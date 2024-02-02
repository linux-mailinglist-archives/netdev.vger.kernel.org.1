Return-Path: <netdev+bounces-68478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E994E846FF5
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F3C1F235A3
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4621813F00F;
	Fri,  2 Feb 2024 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/NyzW0B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3C813F009
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876173; cv=none; b=dZ2KiETf1jKXuHIsQcoyUtNozcbjMRLPzDEOwtWohaopPIMQ+ahsANvo678gns7RnEznQWtwq47IEA/L3DlWODHOP+EnKrSO589iiKcGnIPnKkgPjR8ri4OhhR9zY4UEVBYVMoKOk0bJnKfOiAKiwoxLDBvDz3w+HS0XUK6Dr4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876173; c=relaxed/simple;
	bh=m0t2JOTQpS6s3qWWoW7EaGf06h5dEQdHGojTb04lHOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biAbbHynflQXxz1jRLvInyVxkNf7jM+h9gnGqkJvy6v7x9J4Y9HKq34w8QYujTFWwvhV6pNj4kjWkGBoAgzU+AI/Sb3V/KlzhaaZdyJVgSZmwGojDUsBZQiz5vzF7ulnOXdyY0bnRvLQ74huhslIWRKddgP2NvTWVwLZUBLc3IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/NyzW0B; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2954b34ddd0so1654395a91.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 04:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706876171; x=1707480971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xF2Oigyhs39tH8cTZgrGi5TN82rSOFExpUx88Lm1VbM=;
        b=I/NyzW0BNdTehLV04L8jDrrmff6txpiQ7rX5brNyWwAukaFYFi2ISc3Lr6TEq1yJ42
         wLsWMxhzM8OgFBC42rciCQU1bvnm3AEgRwGVWDa1YK9vvbjlgAYqIKttev53ZIdWww7x
         IMsfcLDbG92qLJzfT0sulSU3vMW7OPGDKAqitfrv/H+f8t/sGCkx8q1LT4T0UZtcuRY1
         Io0SnvNCKnj+wiwUPfsHE3x9Bq473qxVAycgO98y1rHKF4Y3UnZRo9qXiokp4ydmgYcr
         caL8O/+f5k206o4CC3H1n8cKA1nAFEejEM/JIG/KjnvHKP4nx9o82gVf+LioGrPNEsjR
         mnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876171; x=1707480971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xF2Oigyhs39tH8cTZgrGi5TN82rSOFExpUx88Lm1VbM=;
        b=phURjtieD0w5QrtE4QR2rIBbFhrRzAXVtK5OohLQYQRirv/WJcNsW7Yjx/wKG3Cg6w
         IMAxQGvrJYeWBTX0iPnBGyxV5KZ6KuNq9ppR1Fbzs9DSZSBqqLp9OnJWcjY4FwdCrm7M
         KAqIcZ0I9qm5Au0l9+RMnmch1QNd6lj32nsFcx5dHwQ55pnxux0L664hjeWSSuFRZ7Db
         Rje7XHiRLGmFZLvBzpT10slHZA9R6Cv3u4bnvYOY3AsFJ6q7v4RaAidO+hSk5O5ReuRG
         HqAyTffz6mnL6U+sbe2GZYaEGcgpEc92bNsBkswR0Kak4lub9HL2qVq6wbiisnQaxLCc
         /1pg==
X-Gm-Message-State: AOJu0YxvR++niQbVifH2SWDC5Nw0kHiikbDPEdI8IDplAlSSdJcAiIpN
	i/GzFHVS12QJ2iVTdZ7Pgn5Lr0dyFLk5MjMM9AqBDOlrq7B1hMXP
X-Google-Smtp-Source: AGHT+IGQsrbWdxFd1Jbl9FIN/e4WQOaZioGXDeUDhd8LGKTIKJTBcFvUfrEaLbnIq30+yUwOPe1e+Q==
X-Received: by 2002:a17:90b:613:b0:28f:22fc:e84f with SMTP id gb19-20020a17090b061300b0028f22fce84fmr4863083pjb.10.1706876171018;
        Fri, 02 Feb 2024 04:16:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXetIc7y0X3njXnJKuvJ1POH4m/GFl3ffgYL+zWqG27uof9AUZSqWlCGW2T2eWXNnf4Tw4Nf6AkVDqVWc7FxM7ewFr29/MpoCPZU4oYbihAkPIvJdi3t4sen99TvExotzali0hyuhFF6xomalSJKKEm0E16Ry+QoYMGtdkhOeU7gziuEtJaicRIzjTJ1DxAgE/lIWQffLfGf9z7M+VmSq70N5m7GmOOJOu6UuXLq0XBpcwZtQOjWq8T1vR7sRP02BrDSjZBpGK0EbUcgxbqMO8VuegBWRizOtrVoM4yibe/ZgTCUkF45EXkVVrVXJUFiAWeG5w=
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id nw8-20020a17090b254800b0029464b5fcdbsm70962pjb.42.2024.02.02.04.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:16:10 -0800 (PST)
Date: Fri, 2 Feb 2024 20:16:05 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: thinker.li@gmail.com
Cc: netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
	kernel-team@meta.com, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	sinquersw@gmail.com, kuifeng@meta.com
Subject: Re: [PATCH net-next v3 4/5] net/ipv6: set expires in
 modify_prefix_route() if RTF_EXPIRES is set.
Message-ID: <ZbzdBRd4teS_4Eey@Laptop-X1>
References: <20240202082200.227031-1-thinker.li@gmail.com>
 <20240202082200.227031-5-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202082200.227031-5-thinker.li@gmail.com>

On Fri, Feb 02, 2024 at 12:21:59AM -0800, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Make the decision to set or clean the expires of a route based on the
> RTF_EXPIRES flag, rather than the value of the "expires" argument.
> 
> The function inet6_addr_modify() is the only caller of
> modify_prefix_route(), and it passes the RTF_EXPIRES flag and an expiration
> value. The RTF_EXPIRES flag is turned on or off based on the value of
> valid_lft. The RTF_EXPIRES flag is turned on if valid_lft is a finite value
> (not infinite, not 0xffffffff). Even if valid_lft is 0, the RTF_EXPIRES
> flag remains on. The expiration value being passed is equal to the
> valid_lft value if the flag is on. However, if the valid_lft value is
> infinite, the expiration value becomes 0 and the RTF_EXPIRES flag is turned
> off. Despite this, modify_prefix_route() decides to set the expiration
> value if the received expiration value is not zero. This mixing of infinite
> and zero cases creates an inconsistency.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  net/ipv6/addrconf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 36bfa987c314..2f6cf6314646 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -4788,7 +4788,7 @@ static int modify_prefix_route(struct inet6_ifaddr *ifp,
>  	} else {
>  		table = f6i->fib6_table;
>  		spin_lock_bh(&table->tb6_lock);
> -		if (!expires) {
> +		if (!(flags & RTF_EXPIRES)) {

Hi Kui-Feng,

I may missed something. But I still could not get why we shouldn't use
expires for checking? If expires == 0, but RTF_EXPIRES is on,
shouldn't we call fib6_clean_expires()?

Thanks
Hangbin
>  			fib6_clean_expires(f6i);
>  			fib6_remove_gc_list(f6i);
>  		} else {
> -- 
> 2.34.1
> 

