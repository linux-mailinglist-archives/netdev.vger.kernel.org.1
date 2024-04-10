Return-Path: <netdev+bounces-86771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2193B8A03C4
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 00:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DC51F2AFD1
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 22:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2ED101C5;
	Wed, 10 Apr 2024 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFG5sV8p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58598F9F8
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 22:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789497; cv=none; b=qMfeJYr0zltK7M4HIeMku3WLlOOBCoJQ0+mwAWVH2nsTcQ5w53XcOMRYCGLlKdj6FSlbJjgYY/Jkx7r2twtL7gqGS8xNIf3iA3MYFcWoClw4UQdGqSzCPBA1o/uEuWlwyDpFP+QWZ5G9IdstGiAt9+zcbIAe+C6Iy3pq8TEU4cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789497; c=relaxed/simple;
	bh=UWD7/E47qm1quuArC+Hhyj3R8AbQVcsb+JjQtPFXQqA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qx+Qq1KlF4qWoV4nAlb+ArEqSfWEI99pSLOf0i6bNpJmF+o8wijF6AxqzzBZN3kbnC+7Vf+n74l/2xBIfD/QFp3xjflsU1jFcwBdNzLT8wpVJJ1x5LVckxaM1sYhif4Gki5ksCTpZ7utvSy5rIvnhGxmZG4OYpULbgnqlYGPoj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFG5sV8p; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-229661f57cbso3743376fac.1
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 15:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712789494; x=1713394294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1NBPKrLEDoUclljuPyZ7vSB0UlR2JKhDvrs7iga850=;
        b=BFG5sV8pyydtz7QIZSUEKS7ZIqUSCsPpSiPOL0qvjzM5OgXTjHjPzfRuPaBr0ckE04
         LxZupIXmJT6r+de8Z/3qnq0+z1wKYZwHUiQxXOCxaE1ctoNU2jQzV2wTP8/JXDlM9SDE
         z9goQAAUlmgrVzXnV9VkIFvqDfhuaR0MOPXQNIauXhw+GnSMEkEce+ZWPkorZn9ZNu7G
         l6rznhzJf53iG0vvSOwxa7K02WcHKzOrfRjIwUX6x3VPFqf06lo1UvQYCKU0rRdy4UwP
         REQU+UimvA5jicqCYtd9fmPuik2vH5e8/iKw8TBDrp5YRw0P6uAs0dGNiV/fnz+RsPM9
         JTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712789494; x=1713394294;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z1NBPKrLEDoUclljuPyZ7vSB0UlR2JKhDvrs7iga850=;
        b=hGSm7HYNs0c04GpPqp8AGouQsJXlkVcFHeEaeGySPtwEXrpzBDSa8fGzY7AY+3aHsM
         MopU8eT9hc6FvHKJcZ5U51srVClGtqSb6WO3F520lwIbKEF1JmlNF+wRcxU/2gsxFt9x
         1L6+MFZ0D2mqAI1x1JaD1GipRfOnJBN3x8fTDVch9rz251rBcAjgZ1qFFWYCEZg+Jw1X
         UHWK3HOvRMKpBH3kzjtzmvtRUyEjsMSvODIMBTzMWLyQnyr1ZxgYQrVRh2EeKYbPLfQJ
         PaHKt0qErgusgdOzCZz27uASZUTMrAZikibCh0HmkUscOyhjzN2lpqhkU1LkGj/FOskB
         NS2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBtxUeFh1bW00Izu9SgbFYnLsHNLb9mqvEFrRXTlxcvFX//bdv1MDYNSJCM5aiSeLwJCVuhPK0fMqNyp5n0sq1LHy9tmST
X-Gm-Message-State: AOJu0Yzf4myMwJrDRIiodh5MSchtRzy8dawDbE7Mkla2EJpZsASWfChk
	IEnsWyKPRw1QkVmTzsPk8HFHjVfr9fZEYD0M61qZGXtXKOT1ykg0
X-Google-Smtp-Source: AGHT+IF7OmUpzUALHDkYk8IHYKAUwo81OHDX+HqkabtCjVmD6ncCW5tQ8BkEi4fbUvEBG3KCvYsJxA==
X-Received: by 2002:a05:6870:f14c:b0:220:873d:dbcc with SMTP id l12-20020a056870f14c00b00220873ddbccmr4617795oac.49.1712789494274;
        Wed, 10 Apr 2024 15:51:34 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id m3-20020ae9e003000000b0078d4bca760asm178404qkk.34.2024.04.10.15.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 15:51:34 -0700 (PDT)
Date: Wed, 10 Apr 2024 18:51:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 krisman@suse.de
Cc: davem@davemloft.net, 
 lmb@isovalent.com, 
 martin.lau@kernel.org, 
 netdev@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
Message-ID: <661717f5c2839_2d123b294f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240410221301.44576-1-kuniyu@amazon.com>
References: <20240410215047.21462-1-krisman@suse.de>
 <20240410221301.44576-1-kuniyu@amazon.com>
Subject: Re: [PATCH v2] udp: Avoid call to compute_score on multiple sites
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> From: Gabriel Krisman Bertazi <krisman@suse.de>
> Date: Wed, 10 Apr 2024 17:50:47 -0400
> > We've observed a 7-12% performance regression in iperf3 UDP ipv4 and
> > ipv6 tests with multiple sockets on Zen3 cpus, which we traced back to
> > commit f0ea27e7bfe1 ("udp: re-score reuseport groups when connected
> > sockets are present").  The failing tests were those that would spawn
> > UDP sockets per-cpu on systems that have a high number of cpus.
> > 
> > Unsurprisingly, it is not caused by the extra re-scoring of the reused
> > socket, but due to the compiler no longer inlining compute_score, once
> > it has the extra call site in udp4_lib_lookup2.  This is augmented by
> > the "Safe RET" mitigation for SRSO, needed in our Zen3 cpus.
> > 
> > We could just explicitly inline it, but compute_score() is quite a large
> > function, around 300b.  Inlining in two sites would almost double
> > udp4_lib_lookup2, which is a silly thing to do just to workaround a
> > mitigation.  Instead, this patch shuffles the code a bit to avoid the
> > multiple calls to compute_score.  Since it is a static function used in
> > one spot, the compiler can safely fold it in, as it did before, without
> > increasing the text size.
> > 
> > With this patch applied I ran my original iperf3 testcases.  The failing
> > cases all looked like this (ipv4):
> > 	iperf3 -c 127.0.0.1 --udp -4 -f K -b $R -l 8920 -t 30 -i 5 -P 64 -O 2
> > 
> > where $R is either 1G/10G/0 (max, unlimited).  I ran 3 times each.
> > baseline is 6.9.0-rc1-g962490525cff, just a recent checkout of Linus
> > tree. harmean == harmonic mean; CV == coefficient of variation.
> > 
> > ipv4:
> >                  1G                10G                  MAX
> > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> > baseline 1730488.20(0.0050) 1639269.91(0.0795) 1436340.05(0.0954)
> > patched  1980936.14(0.0020) 1933614.06(0.0866) 1784184.51(0.0961)
> > 
> > ipv6:
> >                  1G                10G                  MAX
> > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> > baseline  1679016.07(0.0053) 1697504.56(0.0064) 1481432.74(0.0840)
> > patched   1924003.38(0.0153) 1852277.31(0.0457) 1690991.46(0.1848)
> > 
> > This restores the performance we had before the change above with this
> > benchmark.  We obviously don't expect any real impact when mitigations
> > are disabled, but just to be sure it also doesn't regresses:
> > 
> > mitigations=off ipv4:
> >                  1G                10G                  MAX
> > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> > baseline 3230279.97(0.0066) 3229320.91(0.0060) 2605693.19(0.0697)
> > patched  3242802.36(0.0073) 3239310.71(0.0035) 2502427.19(0.0882)
> > 
> > Cc: Lorenz Bauer <lmb@isovalent.com>
> > Fixes: f0ea27e7bfe1 ("udp: re-score reuseport groups when connected sockets are present")
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> > 
> > ---
> > Changes since v1:
> > (me)
> >   - recollected performance data after changes below only for the
> >   mitigations enabled case.
> > (suggested by Willem de Bruijn)
> >   - Drop __always_inline in compute_score
> >   - Simplify logic by replacing third struct sock pointer with bool
> >   - Fix typo in commit message
> >   - Don't explicitly break out of loop after rescore
> > ---
> >  net/ipv4/udp.c | 18 +++++++++++++-----
> >  net/ipv6/udp.c | 17 +++++++++++++----
> >  2 files changed, 26 insertions(+), 9 deletions(-)
> > 
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index 661d0e0d273f..a13ef8e06093 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -427,12 +427,15 @@ static struct sock *udp4_lib_lookup2(struct net *net,
> >  {
> >  	struct sock *sk, *result;
> >  	int score, badness;
> > +	bool rescore = false;
> 
> nit: Keep reverse xmax tree order.
> https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs
> 
> >  
> >  	result = NULL;
> >  	badness = 0;
> >  	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> > -		score = compute_score(sk, net, saddr, sport,
> > -				      daddr, hnum, dif, sdif);
> > +rescore:
> > +		score = compute_score((rescore ? result : sk), net, saddr,
> 
> I guess () is not needed around rescore ?
> 
> Both same for IPv6.
> 
> Otherwise, looks good to me.
> 
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Can we avoid using the same name for the label and boolean?

And since if looping result will have state TCP_ESTABLISHED, can it
just be

    sk = result;
    goto rescore;


> 
> > +				      sport, daddr, hnum, dif, sdif);
> > +		rescore = false;
> >  		if (score > badness) {
> >  			badness = score;
> >  
> > @@ -456,9 +459,14 @@ static struct sock *udp4_lib_lookup2(struct net *net,
> >  			if (IS_ERR(result))
> >  				continue;
> >  
> > -			badness = compute_score(result, net, saddr, sport,
> > -						daddr, hnum, dif, sdif);
> > -
> > +			/* compute_score is too long of a function to be
> > +			 * inlined, and calling it again here yields
> > +			 * measureable overhead for some
> > +			 * workloads. Work around it by jumping
> > +			 * backwards to rescore 'result'.
> > +			 */
> > +			rescore = true;
> > +			goto rescore;
> >  		}
> >  	}

