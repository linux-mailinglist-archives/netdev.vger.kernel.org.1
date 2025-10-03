Return-Path: <netdev+bounces-227791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E01BCBB743A
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 17:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 225934ECFA2
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 15:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9C127BF7E;
	Fri,  3 Oct 2025 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sROMF+vV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8167D3594F
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759503683; cv=none; b=nkSezvWjbbbUTJPiDRUYQ/EmrL3HpIKTYT+fwYBCdzH75Tb+cTmECKa9CkVMwHFrZy0wpLzW79AP/EgWW9i2ryFdMMv2oPwxQ+gGKHERcKf2zKO0G7JR2xmiAONrtwZfbR1D0Iy2htfLSB7cK8motKRhrHfHtskHSN0gIf1B07k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759503683; c=relaxed/simple;
	bh=LVDJBgXtoMN71uCAVEeMR+49ypUsWLxZrHU16qX+6gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4jY5rCuZ+khYqHDCCUqATHpOIfWBwgZq9Y8EUCeBsKujGtA7CCQ5hxcLUfV6h0sEN7d/BDp1MalSM/+wlW+Xgikb1d7vjjMTlVkCQ8H9ogXr03y6Fsagse2yZh2RUmKQe/WKxiOgtGKWABNl0AY3T+TRNjFLW75oNxowpGzVdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sROMF+vV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2731ff54949so149695ad.1
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759503681; x=1760108481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zenS1wKelhByRdZ8R4MywqW+WKf5VchsSGKYTzbwgA=;
        b=sROMF+vVL/SgIpcdqVetA3/9EikfehgslvSdWfE7IM5r6nwQdg8S98ptuXnDBtJLUF
         okq+Lt3JiyAdpm9e4vBLWTzQW1Gca73m/XBm/b4oO1cmnGEiPmFV15G62LoNL8iB3/ta
         Lk3PFjkHC3h/rQk+0oJ9IID8t/s10AEdfUa75zIMNJczxUf9No/f9RFHunHUiGuhSeqQ
         Y7gfbYCSdtZt47b298GzuOJ7Xc4RWoPK49ZBOFeuJdw8b5QZydidwHERTwxrpjQLeE/k
         oSUE/vq2G+20Dqvag32yBnC+E3F3WXm7XyL4gbAe78VqQFRTyEp10NodbY3JUeSOez6z
         qgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759503681; x=1760108481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zenS1wKelhByRdZ8R4MywqW+WKf5VchsSGKYTzbwgA=;
        b=SWOG6N2l+CuIr74Gr6HxwmR3yHbsuhgpHtWn+jF+2Da6hgKWCQM3fxDvfO2vudwoSp
         W658G6nOA8cMXIlxOFZ57gxmIGz4mwDDSpXy2dE69NKzzkCJ0Ak1j8jEotEw83KWZqTL
         Wsz5n7nwX05t83LaoUvuPs+13MJllmPoXsRxarnANhZ7+D7toIdrrrVjoUKNSOvi/N07
         9NJ28IB9Tz3sZpBrTaOh5SAXUx97JbOc576rLTdljqmK2jP0M4d7+2qsvBwAOBvaOiB1
         nnBXpSsFK7EfnfuLKgFeO42zq0JmEej9P8diE0b6J7xjXk7QlqTZf2QQ+xPuY3kZl4e0
         +KgA==
X-Forwarded-Encrypted: i=1; AJvYcCXJOuRzJekpmVcX6r62yB3c9yChu5OoENlI7CTKwKiUyY9dPs8WE/DsbBBsuvcbCRRZCarKxnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc0KVcKTyS/t4On0FHR4GiAi8d6BNbeYDMc1c33dAph2I3Ixky
	HqqoDUhvbhoIrzi/lyZUVSuvX74OLgrRyHDab5AYTgxzXzdWZcZFF7fwmqKk8+EsbA==
X-Gm-Gg: ASbGncs5I2h1KpRzPClMwxhJut8Myc5vXSbLFXFUZQeQNQ9eqD1S6aNSxDjbQUGVYBB
	Mo/zwRUbAWjZvMFLrwOp1qukCqtVoxGCUh5QAhgknS8FQ2lojr+eqW0x6Fw6yFo4ENJEXNT/Ofq
	nwozQjRYVF/33tjsLo5q+6aZDYTdZi5jRAMY902xgC5pjsF7yglA8zjzb6XkEDqFjBGm1jlj/6e
	P7k33AzZUm+8eAd5vSndLznGc9IpH1BNc7kaA0HZHSWRm7I8ipk1crl7zmoovhkT1osH/43Tusq
	AJXn6yCmvlIYgDyo7XjQxJo8DBOsrGcLR8Lzd+byAezX/ows7iUclrOqdhjFpJ26IvgGZ5aupEC
	uOrgVAqaEqcHQvyMZyaB2n1ID/TV47Z17SbPzy62wI6mor8Gz+JCguYjhkJYOWYdRENvKNCvHk2
	Bto1r58wBKW5o4pw==
X-Google-Smtp-Source: AGHT+IHQSlB6y0yoS/2SJRGI6OmxNreWIDSNmKLWw1s8pQn38QPypGMNjNRREJMfXdM8WQ5+i1jsOQ==
X-Received: by 2002:a17:903:2447:b0:275:8110:7a4d with SMTP id d9443c01a7336-28e9a1d169fmr4442805ad.0.1759503680938;
        Fri, 03 Oct 2025 08:01:20 -0700 (PDT)
Received: from google.com (133.101.105.34.bc.googleusercontent.com. [34.105.101.133])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f73537sm4826900a12.43.2025.10.03.08.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:01:20 -0700 (PDT)
Date: Fri, 3 Oct 2025 15:01:16 +0000
From: Jordan Rife <jrife@google.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>, Julian Wiedmann <jwi@isovalent.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH bpf] bpf: Fix metadata_dst leak
 __bpf_redirect_neigh_v{4,6}
Message-ID: <76nzfqbnb7dfbzrezpaeudtdzub7l26v6fdubbif6quu3hyvcv@gfhmjdh64r2c>
References: <20251003073418.291171-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003073418.291171-1-daniel@iogearbox.net>

On Fri, Oct 03, 2025 at 09:34:18AM +0200, Daniel Borkmann wrote:
> Cilium has a BPF egress gateway feature which forces outgoing K8s Pod
> traffic to pass through dedicated egress gateways which then SNAT the
> traffic in order to interact with stable IPs outside the cluster.
> 
> The traffic is directed to the gateway via vxlan tunnel in collect md
> mode. A recent BPF change utilized the bpf_redirect_neigh() helper to
> forward packets after the arrival and decap on vxlan, which turned out
> over time that the kmalloc-256 slab usage in kernel was ever-increasing.
> 
> The issue was that vxlan allocates the metadata_dst object and attaches
> it through a fake dst entry to the skb. The latter was never released
> though given bpf_redirect_neigh() was merely setting the new dst entry
> via skb_dst_set() without dropping an existing one first.
> 
> Fixes: b4ab31414970 ("bpf: Add redirect_neigh helper as redirect drop-in")
> Reported-by: Yusuke Suzuki <yusuke.suzuki@isovalent.com>
> Reported-by: Julian Wiedmann <jwi@isovalent.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jordan Rife <jrife@google.com>
> ---
>  net/core/filter.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index b005363f482c..c3c0b5a37504 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2281,6 +2281,7 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
>  		if (IS_ERR(dst))
>  			goto out_drop;
>  
> +		skb_dst_drop(skb);
>  		skb_dst_set(skb, dst);
>  	} else if (nh->nh_family != AF_INET6) {
>  		goto out_drop;
> @@ -2389,6 +2390,7 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
>  			goto out_drop;
>  		}
>  
> +		skb_dst_drop(skb);
>  		skb_dst_set(skb, &rt->dst);
>  	}
>  
> -- 
> 2.43.0
>

Nice catch!

Reviewed-by: Jordan Rife <jrife@google.com>

