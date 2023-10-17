Return-Path: <netdev+bounces-41748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C817CBD04
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EB028154E
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81911381DF;
	Tue, 17 Oct 2023 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKwx6j6u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CAC847E
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B7FC433C8;
	Tue, 17 Oct 2023 08:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697529734;
	bh=hBRPEhQBiSI81nd4KdECGTfCnCSML4Jby3geJfist6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKwx6j6u/UIx6P1emJ78Stnx1hzg6hAQBKTU/o0ndP6yoyFeYSjl3lGrC4upjk8gK
	 ng83qjzrrR1yRpmdxJEYbA/bSuxyrV9bSxfMia2GQedncXLVpylwH/Tr21pLL5K8YR
	 taPsPmlkSmXoICL8DdIKS36l/Zpi+NKUhsrRE3u9rCeN2EQXCOlh7NzoX+ry4C59+S
	 LQpqijokc6aOlFUuwWL02pQo6emKmcCxrIu6uhkO/nurt4SuSM802JUgCgMWOc19PL
	 fQ+r17C+T+RtpgAEy1wBy4CH7+z/snf+GepHZTNm+zSrG/dzSyoqbNnxOj0pqh7sm+
	 TbUjAMMyVNVmg==
Date: Tue, 17 Oct 2023 10:02:10 +0200
From: Simon Horman <horms@kernel.org>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net,
	Liam.Howlett@oracle.com, netdev@vger.kernel.org,
	oliver.sang@intel.com, kuba@kernel.org
Subject: Re: [PATCH v1] Fix NULL pointer dereference in cn_filter()
Message-ID: <20231017080210.GG1751252@kernel.org>
References: <20231013225619.987912-1-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013225619.987912-1-anjali.k.kulkarni@oracle.com>

On Fri, Oct 13, 2023 at 03:56:19PM -0700, Anjali Kulkarni wrote:
> Check that sk_user_data is not NULL, else return from cn_filter().

Thanks,

I agree that this change seems likely to address the problem at the link
below. And I also think cn_filter() is a good place to fix this [1].
But I am wondering if you could add some commentary to the patch
description, describing under what circumstances this problem can occur.

[1] https://lore.kernel.org/all/20231013120105.GH29570@kernel.org/

> Fixes: 2aa1f7a1f47c ("connector/cn_proc: Add filtering to fix some bugs")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202309201456.84c19e27-oliver.sang@intel.com/
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> ---
>  drivers/connector/cn_proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
> index 05d562e9c8b1..a8e55569e4f5 100644
> --- a/drivers/connector/cn_proc.c
> +++ b/drivers/connector/cn_proc.c
> @@ -54,7 +54,7 @@ static int cn_filter(struct sock *dsk, struct sk_buff *skb, void *data)
>  	enum proc_cn_mcast_op mc_op;
>  	uintptr_t val;
>  
> -	if (!dsk || !data)
> +	if (!dsk || !data || !dsk->sk_user_data)
>  		return 0;
>  
>  	ptr = (__u32 *)data;
> -- 
> 2.42.0
> 

