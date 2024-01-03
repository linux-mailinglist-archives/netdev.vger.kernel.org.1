Return-Path: <netdev+bounces-61108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4C382279B
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 04:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4169DB21D5F
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 03:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C054A33;
	Wed,  3 Jan 2024 03:40:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6A3171C8
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 03:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4T4b7M2RJxz29jXC;
	Wed,  3 Jan 2024 11:39:27 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (unknown [7.185.36.178])
	by mail.maildlp.com (Postfix) with ESMTPS id E2EB11400D6;
	Wed,  3 Jan 2024 11:40:52 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 11:40:52 +0800
Received: from [10.67.121.229] (10.67.121.229) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 11:40:52 +0800
Subject: Re: [RFC iproute2 6/8] rdma: do not mix newline and json object
To: Stephen Hemminger <stephen@networkplumber.org>, <leon@kernel.org>
References: <20240103003558.20615-1-stephen@networkplumber.org>
 <20240103003558.20615-7-stephen@networkplumber.org>
CC: <netdev@vger.kernel.org>
From: Chengchang Tang <tangchengchang@huawei.com>
Message-ID: <99fbc115-c865-c4f8-31d6-9cd157646481@huawei.com>
Date: Wed, 3 Jan 2024 11:40:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240103003558.20615-7-stephen@networkplumber.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)



On 2024/1/3 8:34, Stephen Hemminger wrote:
> Mixing the semantics of ending lines with the json object
> leads to several bugs where json object is closed twice, etc.
> Replace by breaking the meaning of newline() function into
> two parts.

These codes fix the issue mentioned in:
https://lore.kernel.org/netdev/20231229065241.554726-1-huangjunxian6@hisilicon.com/T/#m5476970400a2d6f2b9b8f3f369d8a26b9663d4b9

Might it need a fixes ?

Fixes: 331152752a97 ("rdma: print driver resource attributes")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   rdma/dev.c      |  3 ++-
>   rdma/link.c     |  4 +++-
>   rdma/rdma.h     |  5 +++--
>   rdma/res-cmid.c |  3 ++-
>   rdma/res-cq.c   |  7 +++++--
>   rdma/res-ctx.c  |  3 ++-
>   rdma/res-mr.c   |  6 ++++--
>   rdma/res-pd.c   |  4 ++--
>   rdma/res-qp.c   |  6 ++++--
>   rdma/res-srq.c  |  6 ++++--
>   rdma/res.c      |  4 +++-
>   rdma/stat-mr.c  |  3 ++-
>   rdma/stat.c     | 17 ++++++++++-------
>   rdma/utils.c    | 16 +++++-----------
>   14 files changed, 51 insertions(+), 36 deletions(-)
>
> diff --git a/rdma/dev.c b/rdma/dev.c
> index 31868c6fe43e..c8cb6d675c3b 100644
>
< ... >
> index aeb627be7715..64f598c5aa8f 100644
> --- a/rdma/utils.c
> +++ b/rdma/utils.c
> @@ -771,16 +771,10 @@ struct dev_map *dev_map_lookup(struct rd *rd, bool allow_port_index)
>   
>   #define nla_type(attr) ((attr)->nla_type & NLA_TYPE_MASK)
>   
> -void newline(struct rd *rd)
> +void print_nl_indent(void)
>   {
> -	close_json_object();
> -	print_nl();
> -}
> -
> -void newline_indent(struct rd *rd)
> -{
> -	newline(rd);
> -	print_string(PRINT_FP, NULL, "    ", NULL);
> +	if (!is_json_context())
> +		printf("%s    ", _SL_);
>   }
>   
>   static int print_driver_string(struct rd *rd, const char *key_str,
> @@ -920,7 +914,7 @@ void print_driver_table(struct rd *rd, struct nlattr *tb)
>   	if (!rd->show_driver_details || !tb)
>   		return;
>   
> -	newline_indent(rd);
> +	print_nl_indent();
>   
>   	/*
>   	 * Driver attrs are tuples of {key, [print-type], value}.
> @@ -932,7 +926,7 @@ void print_driver_table(struct rd *rd, struct nlattr *tb)
>   	mnl_attr_for_each_nested(tb_entry, tb) {
>   
>   		if (cc > MAX_LINE_LENGTH) {
> -			newline_indent(rd);
> +			print_nl_indent();
>   			cc = 0;
>   		}
>   		if (rd_attr_check(tb_entry, &type) != MNL_CB_OK)


