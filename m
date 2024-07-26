Return-Path: <netdev+bounces-113227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D6493D400
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 15:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B003B2322F
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 13:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4397143889;
	Fri, 26 Jul 2024 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2xuox08"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2133217B4E2
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999845; cv=none; b=sN8WSAz34k2lAjnBJEU0LOnXor+eYjenDRLYK6OIarRt/U9v+VeemPNb3ORfBiM3WXntObjFRrYKFiTGOO7NQmjlJIT5FD+8oJm2cmeFkjC4qDOS6mymyCwcDIhzypspi7gHr0D+/wey0HnqiSjsuFQesQZdz1Dl1g3DxSu2vi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999845; c=relaxed/simple;
	bh=4kVIQCChUbglyV+k+HOn1kW5CkgQE1FBgFEBC/jDQ10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUG+S0ro0lJm5+vSTfbxER3Vl9KTq7Fk98fBjwYQTe94R79VnB1Q9FGENLJVW4mZc/QXOMkV3MP/jT9IuB2P+zpEbRHlgZ1bQTmXoty/qjdqbjO5tnddh2s2VLJdYsog7pv7ImFplUJJWWDJ1XNKayYyIojSI8g/pPN8PNH4bXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2xuox08; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721999842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l+6VpRCa0Q8GNnCtOBFwW2bwj7nkDDhJJ2rPfuFnhh0=;
	b=h2xuox08qgnfQPhLiHyDk6udRehg05q3jwwB9OBc/sr6eifjhHquR/qGC7ktUXZpA3Ybvs
	D0AxeJzauneiKOrCLqBjC4KQlmvJc6VHDbyVw14+sJudLWgDeuuyjzkheplOQnIFIwhF/g
	hLIcJM/wfpmrB+bsZiPlX0Slqa8EOnY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-z6GZV_WfNm2Du-ktAUL4jg-1; Fri, 26 Jul 2024 09:17:20 -0400
X-MC-Unique: z6GZV_WfNm2Du-ktAUL4jg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4280291f739so15867945e9.3
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 06:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721999839; x=1722604639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+6VpRCa0Q8GNnCtOBFwW2bwj7nkDDhJJ2rPfuFnhh0=;
        b=Lxnh7VsPTnu7/kw/LbqvrkZttZspMbY9duedpFjN1tfu0465vftGBCfqx3yVAGHqxC
         9QbLuUQyOsFNpstJdH6GoLldMBJe2Q8vA3d2KeSWuGVPaTSBKyIiV5kik4hf3cA3BfEZ
         99oWf+3TQaW43K1HgR1dojAvuYvhDBzdiHwtY1E+Or10sZLS1wO4lKc6rFyvJasr+bHv
         Peq/OmByeriC3Rp74SY6KHg4qvPWk1lceQT3LGwL5BBthu8SjGvD4D+IV2L9I6IjhKo9
         WiYWbjB3SfYPZHKe+O04o/Vd8aOu+ku4QlHROF555QK8bQ/vILqSk+rFHx6KiOa3Tqnb
         kyJA==
X-Gm-Message-State: AOJu0YwFCZIbU6RonYR+OYyN6768IRMc0hjqWvf3tr9+81nZehe7D5CX
	KMKsLl1AUrzY5EQ40Yi0Fzy7mb3Qj/phlYSgJe96P9rYvRaOD9EV2GBF79t7WQNiEyl61b3ZoKO
	yX1uera7dl3mZPKwk+x60/5ZGFVwEAWPnu6IG93xoudJJelHnaBJ7NA==
X-Received: by 2002:a05:6000:4024:b0:366:e7aa:7fa5 with SMTP id ffacd0b85a97d-36b31ac772dmr5227799f8f.1.1721999839384;
        Fri, 26 Jul 2024 06:17:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjZr996e5XEt9Hw79Pp4nlOQdZe1bT3/CsiJZelgeZSjshKQhuswyopfmY8bYKVmR/lrvYyA==
X-Received: by 2002:a05:6000:4024:b0:366:e7aa:7fa5 with SMTP id ffacd0b85a97d-36b31ac772dmr5227747f8f.1.1721999838623;
        Fri, 26 Jul 2024 06:17:18 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42807246ca4sm71526235e9.11.2024.07.26.06.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 06:17:18 -0700 (PDT)
Date: Fri, 26 Jul 2024 15:17:15 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, dsahern@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, fw@strlen.de
Subject: Re: [RFC PATCH net-next 3/3] ipv4: Centralize TOS matching
Message-ID: <ZqOh24k4UQUqYLoN@debian>
References: <20240725131729.1729103-1-idosch@nvidia.com>
 <20240725131729.1729103-4-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725131729.1729103-4-idosch@nvidia.com>

On Thu, Jul 25, 2024 at 04:17:29PM +0300, Ido Schimmel wrote:
> The TOS field in the IPv4 flow information structure ('flowi4_tos') is
> matched by the kernel against the TOS selector in IPv4 rules and routes.
> The field is initialized differently by different call sites. Some treat
> it as DSCP (RFC 2474) and initialize all six DSCP bits, some treat it as
> RFC 1349 TOS and initialize it using RT_TOS() and some treat it as RFC
> 791 TOS and initialize it using IPTOS_RT_MASK.
> 
> What is common to all these call sites is that they all initialize the
> lower three DSCP bits, which fits the TOS definition in the initial IPv4
> specification (RFC 791).
> 
> Therefore, the kernel only allows configuring IPv4 FIB rules that match
> on the lower three DSCP bits which are always guaranteed to be
> initialized by all call sites:
> 
>  # ip -4 rule add tos 0x1c table 100
>  # ip -4 rule add tos 0x3c table 100
>  Error: Invalid tos.
> 
> While this works, it is unlikely to be very useful. RFC 791 that
> initially defined the TOS and IP precedence fields was updated by RFC
> 2474 over twenty five years ago where these fields were replaced by a
> single six bits DSCP field.
> 
> Extending FIB rules to match on DSCP can be done by adding a new DSCP
> selector while maintaining the existing semantics of the TOS selector
> for applications that rely on that.
> 
> A prerequisite for allowing FIB rules to match on DSCP is to adjust all
> the call sites to initialize the high order DSCP bits and remove their
> masking along the path to the core where the field is matched on.
> 
> However, making this change alone will result in a behavior change. For
> example, a forwarded IPv4 packet with a DS field of 0xfc will no longer
> match a FIB rule that was configured with 'tos 0x1c'.
> 
> This behavior change can be avoided by masking the upper three DSCP bits
> in 'flowi4_tos' before comparing it against the TOS selectors in FIB
> rules and routes.
> 
> Implement the above by adding a new function that checks whether a given
> DSCP value matches the one specified in the IPv4 flow information
> structure and invoke it from the three places that currently match on
> 'flowi4_tos'.
> 
> Use RT_TOS() for the masking of 'flowi4_tos' instead of IPTOS_RT_MASK
> since the latter is not uAPI and we should be able to remove it at some
> point.
> 
> No regressions in FIB tests:
> 
>  # ./fib_tests.sh
>  [...]
>  Tests passed: 218
>  Tests failed:   0
> 
> And FIB rule tests:
> 
>  # ./fib_rule_tests.sh
>  [...]
>  Tests passed: 116
>  Tests failed:   0
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  include/net/ip_fib.h     | 7 +++++++
>  net/ipv4/fib_rules.c     | 2 +-
>  net/ipv4/fib_semantics.c | 3 +--
>  net/ipv4/fib_trie.c      | 3 +--
>  4 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
> index 72af2f223e59..967e4dc555fa 100644
> --- a/include/net/ip_fib.h
> +++ b/include/net/ip_fib.h
> @@ -22,6 +22,8 @@
>  #include <linux/percpu.h>
>  #include <linux/notifier.h>
>  #include <linux/refcount.h>
> +#include <linux/ip.h>

Why including linux/ip.h? That doesn't seem necessary for this change.

Appart from that,

Reviewed-by: Guillaume Nault <gnault@redhat.com>

Thanks a lot!


