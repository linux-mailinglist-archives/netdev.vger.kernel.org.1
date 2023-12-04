Return-Path: <netdev+bounces-53594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 492CF803D95
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7CFD1F2108C
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 18:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1803F2F85F;
	Mon,  4 Dec 2023 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="B5selm5V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-71.smtpout.orange.fr [80.12.242.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3E6192
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 10:54:28 -0800 (PST)
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id AE5FrwDQ5Moj4AE5Frxl1d; Mon, 04 Dec 2023 19:54:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1701716065;
	bh=bA4kX9rxibdxURNPiiRaVXTSF7jjxSA+0KGcHMkxAZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=B5selm5VlHoKf3GqZnp0ROHcZkYFo/nfYqc6FE3VSbB8dLja2HdePtpnSyUawFxEq
	 N8RlfWQj4TNrL1ob16+vh9b2jFuqOM90ro9Mce7Q5gzzgWZ31T68bzHmZ2iBsHLAFc
	 b5e66ZS5QQML+aMN+ZuHfLd7zdkvYJzeivETaGHhpEe5JANuiqJYM1VmGdL8Aw7DOY
	 qEJGfeeuQQwL6kfhnfwyqdwFTKCT28r0tH9vA7jTbkaw0Rq9su4lg35c3DyLLYnGe6
	 GBOyrCRHfZIbZEHje5zQ7/YbOx/BIvNd/juKvGJhIZgrCf3DSzYYvnkF/ZMOvHXkjH
	 Uk9rae5k0Wmiw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 04 Dec 2023 19:54:25 +0100
X-ME-IP: 92.140.202.140
Message-ID: <8f5f9a4b-f809-44cb-8f26-05e39b29dfb6@wanadoo.fr>
Date: Mon, 4 Dec 2023 19:54:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] net: hns3: reduce stack usage in
 hclge_dbg_dump_tm_pri()
To: Arnd Bergmann <arnd@kernel.org>, Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jijie Shao <shaojijie@huawei.com>,
 Hao Chen <chenhao418@huawei.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231204085735.4112882-1-arnd@kernel.org>
Content-Language: fr
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231204085735.4112882-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/12/2023 à 09:57, Arnd Bergmann a écrit :
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This function exceeds the stack frame warning limit:
> 
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c: In function 'hclge_dbg_dump_tm_pri':
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:1039:1: error: the frame size of 1408 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> Use dynamic allocation for the largest stack object instead. It
> would be nice to rewrite this file to completely avoid the extra
> buffer and just use the one that was already allocated by debugfs,
> but that is a much larger change.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: fix error handling leak
> ---
>   .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 21 ++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
> index ff3f8f424ad9..8f94e13c1edf 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
> @@ -981,7 +981,7 @@ static const struct hclge_dbg_item tm_pri_items[] = {
>   
>   static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
>   {
> -	char data_str[ARRAY_SIZE(tm_pri_items)][HCLGE_DBG_DATA_STR_LEN];
> +	char *data_str;
>   	struct hclge_tm_shaper_para c_shaper_para, p_shaper_para;
>   	char *result[ARRAY_SIZE(tm_pri_items)], *sch_mode_str;
>   	char content[HCLGE_DBG_TM_INFO_LEN];
> @@ -992,8 +992,13 @@ static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
>   	if (ret)
>   		return ret;
>   
> +	data_str = kcalloc(ARRAY_SIZE(tm_pri_items), HCLGE_DBG_DATA_STR_LEN,
> +			   GFP_KERNEL);
> +	if (!data_str)
> +		return -ENOMEM;
> +
>   	for (i = 0; i < ARRAY_SIZE(tm_pri_items); i++)
> -		result[i] = &data_str[i][0];
> +		result[i] = &data_str[i * HCLGE_DBG_DATA_STR_LEN];
>   
>   	hclge_dbg_fill_content(content, sizeof(content), tm_pri_items,
>   			       NULL, ARRAY_SIZE(tm_pri_items));
> @@ -1002,23 +1007,23 @@ static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
>   	for (i = 0; i < pri_num; i++) {
>   		ret = hclge_tm_get_pri_sch_mode(hdev, i, &sch_mode);
>   		if (ret)
> -			return ret;
> +			goto out;
>   
>   		ret = hclge_tm_get_pri_weight(hdev, i, &weight);
>   		if (ret)
> -			return ret;
> +			goto out;
>   
>   		ret = hclge_tm_get_pri_shaper(hdev, i,
>   					      HCLGE_OPC_TM_PRI_C_SHAPPING,
>   					      &c_shaper_para);
>   		if (ret)
> -			return ret;
> +			goto out;
>   
>   		ret = hclge_tm_get_pri_shaper(hdev, i,
>   					      HCLGE_OPC_TM_PRI_P_SHAPPING,
>   					      &p_shaper_para);
>   		if (ret)
> -			return ret;
> +			goto out;
>   
>   		sch_mode_str = sch_mode & HCLGE_TM_TX_SCHD_DWRR_MSK ? "dwrr" :
>   			       "sp";
> @@ -1035,7 +1040,9 @@ static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
>   		pos += scnprintf(buf + pos, len - pos, "%s", content);
>   	}
>   
> -	return 0;
> +out:
> +	kfree(data_str);
> +	return ret;
>   }
>   
>   static const struct hclge_dbg_item tm_qset_items[] = {

Hi,
could :
    pos += scnprintf(buf + pos, len - pos, "%s", <something>);
be more widely used to avoid the alloc()/free() + copy of strings?

CJ


