Return-Path: <netdev+bounces-61545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF92824372
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AFC2878DC
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D687A225D2;
	Thu,  4 Jan 2024 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b="KKMnI48J"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB5D224E3
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pmachata.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pmachata.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4T5TF30cKxz9sm9;
	Thu,  4 Jan 2024 15:17:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1704377847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dmg9dI56GQYCLPGXZw+eZHGH4v5EBDUVbZ8c7bwKZyM=;
	b=KKMnI48JG8pAh4rUQ+yVpoB9vEB+JIkE1epZuwJzl3Zp738YcgBBdYFcfZzb1zwTC/t0xP
	9CtF8oevuWK2IsMDyNbi9fitpz/CNM+Y1shPBql77ilYoxAaIQ2sHXntVXppxPvKcqw4vp
	sRAKHoAN1zwImwt1sPs+8XHkl3WH6EDvTR6xqk8sJRZj8HqR2IKV8cMycCv0x4Ia7GYkEn
	o/9uLAvZDThUXLz1wUgqhE86M8pWg8DqEJCgHSL7Z0S+YuGBGKIAzxcsRhv9n3H3fSGyaW
	vDPPPn2HnZ0Y9xY2v+P6Ly0SiwqnPd6H6FCC3opvQuMAKQnxbgr4OAehK/Uc5g==
References: <20240104011422.26736-1-stephen@networkplumber.org>
 <20240104011422.26736-3-stephen@networkplumber.org>
From: Petr Machata <me@pmachata.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: leon@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 iproute2 2/6] rdma: use standard flag for json
Date: Thu, 04 Jan 2024 13:07:38 +0100
In-reply-to: <20240104011422.26736-3-stephen@networkplumber.org>
Message-ID: <874jft6v4b.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Stephen Hemminger <stephen@networkplumber.org> writes:

> The other iproute2 utils use variable json as flag.

Some do, some don't. dcb, devlink, rdma do not, the rest do.

Personally I'm not a fan of global state, and consider this patch to be
a step back in terms of best practices. I do realize this is how it's
done in iproute2. To the point that utils.h actually carries external
declarations for these variables. But to me those are inevitable warts,
not something to embrace and extend.

Objectively... whatever. There's only one instance of the context
structure anyway. It's just the overtones of a quick hack that irk me.

Anyway, the mechanical parts of the conversion look OK. But:

> diff --git a/rdma/stat.c b/rdma/stat.c
> index 28b1ad857219..6a3f8ca44892 100644
> --- a/rdma/stat.c
> +++ b/rdma/stat.c
> @@ -208,7 +208,7 @@ int res_get_hwcounters(struct rd *rd, struct nlattr *hwc_table, bool print)
>  
>  		nm = mnl_attr_get_str(hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME]);
>  		v = mnl_attr_get_u64(hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_VALUE]);
> -		if (rd->pretty_output && !rd->json_output)
> +		if (rd->pretty_output)
>  			newline_indent(rd);

newline_indent() issues close_json_object(). Previously it wouldn't be
invoked in JSON mode, now it will be. Doesn't this break JSON output?
Same question for the hunk below.

>  		res_print_u64(rd, nm, v, hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME]);
>  	}
> @@ -802,7 +802,7 @@ static int do_stat_mode_parse_cb(const struct nlmsghdr *nlh, void *data,
>  			} else {
>  				print_string(PRINT_FP, NULL, ",", NULL);
>  			}
> -			if (rd->pretty_output && !rd->json_output)
> +			if (rd->pretty_output)
>  				newline_indent(rd);
>  
>  			print_string(PRINT_ANY, NULL, "%s", name);

