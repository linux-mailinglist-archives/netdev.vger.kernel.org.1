Return-Path: <netdev+bounces-34923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0D37A5F07
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 12:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616241C2099A
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 10:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FA92E63C;
	Tue, 19 Sep 2023 10:06:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE287110B
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 10:06:37 +0000 (UTC)
Received: from out-210.mta1.migadu.com (out-210.mta1.migadu.com [IPv6:2001:41d0:203:375::d2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2769E
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 03:06:36 -0700 (PDT)
Message-ID: <8d8f2aee-ce64-166d-b13d-9791e8d47036@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695117994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z13/olEq8GyW2EUlZpY3hnsJroKO32II25IDBVJXOTs=;
	b=ed9hcfrJ7JmwZfShPsWjCFY5zQAzN1IPjlyXGSNFlfp1CQGWD6e780HtKR64q1UBkPHSrE
	GM8q+2axy/e2IFaabfNVTkInuF8evswQ/LfkWwBoWmwPIbwP2n9Pf5cp6b91Tg2B1Zdoln
	V0GcDwmDpEh+2T9NIFLDq1XFRH3nxO4=
Date: Tue, 19 Sep 2023 11:06:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] net: hinic: Fix warning-hinic_set_vlan_fliter() warn:
 variable dereferenced before check 'hwdev'
Content-Language: en-US
To: Cai Huoqing <cai.huoqing@linux.dev>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230919022715.6424-1-cai.huoqing@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230919022715.6424-1-cai.huoqing@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 19/09/2023 03:27, Cai Huoqing wrote:
> 'hwdev' is checked too late and hwdev will not be NULL, so remove the check
> 
> Fixes: 2acf960e3be6 ("net: hinic: Add support for configuration of rx-vlan-filter by ethtool")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202309112354.pikZCmyk-lkp@intel.com/
> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> ---
> v1->v2: Remove 'hwdev' check directly
> v1 link: https://lore.kernel.org/lkml/20230918123401.6951-1-cai.huoqing@linux.dev/
> 
>   drivers/net/ethernet/huawei/hinic/hinic_port.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_port.c b/drivers/net/ethernet/huawei/hinic/hinic_port.c
> index 9406237c461e..f81a43d2cdfc 100644
> --- a/drivers/net/ethernet/huawei/hinic/hinic_port.c
> +++ b/drivers/net/ethernet/huawei/hinic/hinic_port.c
> @@ -456,9 +456,6 @@ int hinic_set_vlan_fliter(struct hinic_dev *nic_dev, u32 en)
>   	u16 out_size = sizeof(vlan_filter);
>   	int err;
>   
> -	if (!hwdev)
> -		return -EINVAL;
> -
>   	vlan_filter.func_idx = HINIC_HWIF_FUNC_IDX(hwif);
>   	vlan_filter.enable = en;
>   

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

