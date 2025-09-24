Return-Path: <netdev+bounces-225751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5C0B97F2C
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 02:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B24B37AB8B3
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 00:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1617E1DF273;
	Wed, 24 Sep 2025 00:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKJdzHkZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A331EA7CE
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758675151; cv=none; b=CYYO3AiARo1Xax6vlKUvfmZ4It1vsn1TgRltMUpqWLmtPcb9dlrZDpAvG041pjGen4VOWCz2A38iSPdTbBktODACj7hIwGeITshcUYxqEm1BPdg7qStyc9IO+xZa/q9ikcmUsX01dlQ1A3AFiKlfUTlaKN913bjzTBnt22LOwb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758675151; c=relaxed/simple;
	bh=AEf0I95B1tjH5s61FQZBvW27y0/Hum/gRqAnEH0Yebk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUsiiGZrIHIQGDwWYG15f2ljawTKQLWdw3a9N6/v5KoMXlq0t4fSoPYbJd65d1q+pq38hmBhFbb1XZnHT+GFtoXRmfz6b0tiMg68ihbVAJEr91+ytdEYNvt839r1iC8z+5BZJn5Mj1vE346ITTevXSuTgITgxGs7uBu0Qwk2Fl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKJdzHkZ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77f2c7ba550so3007310b3a.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 17:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758675148; x=1759279948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RAUmB/RuCiCZPtVgZPv0J2E666nuMHsy58KGKXw1oKM=;
        b=RKJdzHkZyjwKgK/kyT3C82zrCXsu0iQ8WR/ki62qb6o9UYv0l7fjpwJpNH3VkTKssI
         y/t7R9zUIgaOtHYpitE4mShndrsibRcqnDUe1eoRuTa9raBxbmftvh+8FmA8B5Na4KKh
         dgtwfSPHZ7VlRGR5gLFrrnh7SWmz0JBqn3jUjwhen/mREzmLrk9w3mNrkOVbQH+fWCem
         i4Q3/jZvwLaTK1F2bi30TKsvcVuDTky4aa4v1J4VZ0oV9ThEvuP2Rkl8uUI4KGKLRW2/
         l8q5CYOU2t9DVOA7d5H9hRn4ZM9EEuuhLTo+7q351xcAQUh0AzBEBsL0cb9V7g7GmJtd
         gWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758675148; x=1759279948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAUmB/RuCiCZPtVgZPv0J2E666nuMHsy58KGKXw1oKM=;
        b=KxW1ULL4iagJO2nijxLV+zQ5x6o+kocF5/rjuZX1pupX5Ms0UKTkvhZc6DhgNIteci
         yEzC3IjCrU2TM1gbCD5QGCw8CP10KHdpjjCSn7P/N9Tw+2uAghT228R5W11Zw3opRdUl
         EO0J1YqIjozMEzO7LFVIyRmzAAb41qZOkKaVigiwBduOwTboKImpS/XbsP3cFZSjYJNi
         jDEQbPSSQuxKkDjYt1DP+7cVycgKkVvQ9vv8gDht450ed8AZ7Jr++uLdp3R3asavW/t/
         hvHD4YRYU7r8sWCuAJJipXrqXqMvlg4ERKRP6jlUuFlITIZJNSFfC17LMiLrgBa5N+y2
         r5KA==
X-Gm-Message-State: AOJu0YydYOiOdTH5hgbqSQ5OCNJmhPiMOvHr3IVbICn3Zz4RfqoSSfCe
	Qfufys6kRhnM9doCJXzaXrttbtI7iAwEHud3dki2wKkkkn9cxa12r8Cz
X-Gm-Gg: ASbGnct1VM4pC6VdcyqkOy8T0caHljABrh6B7tGMSkvYmvowVeQq0VxOGXYksa5H3Zv
	nIGWdksuXCXALxbBj3xo2Ye1QaAW4tzIK2D0jP71JVPIhnLH0WTjxBxUGR2EHMr5vo7J+bavfUU
	GCHmjg+jno8e2Zj3YkIV9kOyFGD0pp8i1laMm/BCTJxn3vUNZdyzJ8Hgk3i8IK81GeUIPiBkeUH
	wemSonE4htUwB/KooMnYEWR9Ed/npmwVlyWg6EvIA0V8AKnJIKPEaq60Muc4X3XUaTS1WjAIXWD
	kPH9CwwuOaIXgAdKMrTR2mk02i3DOZJGZUD4h4dGtAmbwkwXuHRng1CVCch+0a90WelYSKDxk7K
	9wcIQOUAyRyLVTcGNjcXD/cU3ckI=
X-Google-Smtp-Source: AGHT+IF+5cs5xruTMc57tUQH+FOmNEUAbOBlTyYLxBZ6GcxYCdZp496Z6fd+L8/0yXpQiT/vlp1XQQ==
X-Received: by 2002:a05:6a00:2e25:b0:77f:1a6a:e728 with SMTP id d2e1a72fcca58-77f53b0e05dmr5495256b3a.17.1758675143531;
        Tue, 23 Sep 2025 17:52:23 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f20b61586sm9946959b3a.83.2025.09.23.17.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 17:52:23 -0700 (PDT)
Date: Wed, 24 Sep 2025 00:52:18 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH RESEND] ip/bond: add broadcast_neighbor support
Message-ID: <aNNAwo6wDpSasVsY@fedora>
References: <20250923083953.16363-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923083953.16363-1-tonghao@bamaicloud.com>

On Tue, Sep 23, 2025 at 04:39:53PM +0800, Tonghao Zhang wrote:
> This option has no effect in modes other than 802.3ad mode.
> When this option enabled, the bond device will broadcast ARP/ND
> packets to all active slaves.
> 
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> ---
> 1. no update uapi header.
> 2. the kernel patch is accpted, https://patchwork.kernel.org/project/netdevbpf/patch/84d0a044514157bb856a10b6d03a1028c4883561.1751031306.git.tonghao@bamaicloud.com/
> ---
>  ip/iplink_bond.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
> index 3ae626a0..714fe7bd 100644
> --- a/ip/iplink_bond.c
> +++ b/ip/iplink_bond.c
> @@ -150,6 +150,7 @@ static void print_explain(FILE *f)
>  		"                [ lacp_rate LACP_RATE ]\n"
>  		"                [ lacp_active LACP_ACTIVE]\n"
>  		"                [ coupled_control COUPLED_CONTROL ]\n"
> +		"                [ broadcast_neighbor BROADCAST_NEIGHBOR ]\n"
>  		"                [ ad_select AD_SELECT ]\n"
>  		"                [ ad_user_port_key PORTKEY ]\n"
>  		"                [ ad_actor_sys_prio SYSPRIO ]\n"
> @@ -166,6 +167,7 @@ static void print_explain(FILE *f)
>  		"LACP_RATE := slow|fast\n"
>  		"AD_SELECT := stable|bandwidth|count\n"
>  		"COUPLED_CONTROL := off|on\n"
> +		"BROADCAST_NEIGHBOR := off|on\n"
>  	);
>  }
>  
> @@ -185,6 +187,7 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
>  	__u32 arp_all_targets, resend_igmp, min_links, lp_interval;
>  	__u32 packets_per_slave;
>  	__u8 missed_max;
> +	__u8 broadcast_neighbor;
>  	unsigned int ifindex;
>  	int ret;
>  
> @@ -377,6 +380,12 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
>  			if (ret)
>  				return ret;
>  			addattr8(n, 1024, IFLA_BOND_COUPLED_CONTROL, coupled_control);
> +		} else if (strcmp(*argv, "broadcast_neighbor") == 0) {
> +			NEXT_ARG();
> +			broadcast_neighbor = parse_on_off("broadcast_neighbor", *argv, &ret);
> +			if (ret)
> +				return ret;
> +			addattr8(n, 1024, IFLA_BOND_BROADCAST_NEIGH, broadcast_neighbor);
>  		} else if (matches(*argv, "ad_select") == 0) {
>  			NEXT_ARG();
>  			if (get_index(ad_select_tbl, *argv) < 0)
> @@ -676,6 +685,13 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  			     rta_getattr_u8(tb[IFLA_BOND_COUPLED_CONTROL]));
>  	}
>  
> +	if (tb[IFLA_BOND_BROADCAST_NEIGH]) {
> +		print_on_off(PRINT_ANY,
> +			     "broadcast_neighbor",
> +			     "broadcast_neighbor %s ",
> +			     rta_getattr_u8(tb[IFLA_BOND_BROADCAST_NEIGH]));
> +	}
> +
>  	if (tb[IFLA_BOND_AD_SELECT]) {
>  		const char *ad_select = get_name(ad_select_tbl,
>  						 rta_getattr_u8(tb[IFLA_BOND_AD_SELECT]));
> -- 
> 2.34.1
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

