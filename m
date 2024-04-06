Return-Path: <netdev+bounces-85447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9836089AC88
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 19:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC30D1C20B95
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 17:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFB040857;
	Sat,  6 Apr 2024 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsHlquZq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8614B3FE22
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712425265; cv=none; b=n+VAXWGCt1LhMEqgiYNMIjKCj+1KWVTMhULXk5taqaYeFzJ8nE5nlQ3P7r/vwZPHDbn8BWQusfdS0PahtsmkT1CPF2eE2lxgHY1C1wGFvraH6fG+LPXddJhtmQqVHuYgV+r+q4AN4xNpZpxYEzruRVpsPr2d8WVz+0O3EBxVizE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712425265; c=relaxed/simple;
	bh=3TWOmvaqbhLAlCgsTj3sJK0FMZAn7fGBFp0SUqJHeAw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=u3WpzD6oTTVdH5hj+XIeTbanZ+mBbEzt5r5mYgcNSpKXf9U7IOy7Q5AqeAGrGqGk4O01Psto42qF337hmVn+3yvM6MMOQD6RzzqlfbcHq6W0VZoe7e2EhHrDF5WXDUTwlkwiwJZEKsQkejZzy81jwCKEi+zVhczASa/jITvFTE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsHlquZq; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42f4b66dc9eso14949761cf.2
        for <netdev@vger.kernel.org>; Sat, 06 Apr 2024 10:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712425262; x=1713030062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlGYbAEOuAdXKDQp4uQEalwxZ+yUk3Eg6JJ/6e09WIQ=;
        b=ZsHlquZqvZUMJ6AUUvFKGE5NRfWq7hu+5wQ7IFQQBTU0zDv7iZnA5qh6GYjdeYE3UA
         l85RH+Mk9plJjULBgUuVFlq6p9D1eIw8CsWDV3i6GoCkY+/+ha9UXnJuPevuhdeNWaYO
         3W3w5Kp2ETkisFrU/gwDsqwT5TcKso2GOHN9SipavFWnsWzo+Yt1Rc6SjRG7WUJAnT7J
         lbagTxl0nZUuyT80U/lljOFO4Z/gCGLvy439GwgwqgmfY1GkI1DEXIcCHeCeMPz5av0y
         fsHoolkhQL7VG7ak2Nv2eO4Elzok603IiEJf9yOrhlrul7p+V0HLx7AUTy6Aicu/YdKj
         17sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712425262; x=1713030062;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UlGYbAEOuAdXKDQp4uQEalwxZ+yUk3Eg6JJ/6e09WIQ=;
        b=DcuD3MDlf2BRk1whl5C2tN43zfDgCKYNYcHdXjoUprEE8V+iuUl9mFntZLOWbwuz2b
         EqTCFLcF5RI3oyxVWfkJDrPx5T84mlHumGGNnANYGDz1ID3BeV9y6FhurMfhED4lGXdN
         xogFy/3lK08LgfA90gnz61ADDfzLpX/mxur1ZV0w01chlNdFydhk4MXHaEHVLXkf4ij+
         q7piNyZEepsizHa+F6i0G7XtX0lfpxB+6q36yu4Audu1NR3+6raHztBY8L3TtCb6An2a
         HBPEeQsgrvhA3AA3D0MdcQ4oxC3osS9nyoresTIkQXo0YfeQiIx8LAhikbW5qL/Oe6BC
         /JSA==
X-Gm-Message-State: AOJu0YyX7vQnY2YzgfdlWIpN65vhD58MamB2bYP/B4a8C9mjwMttZg/6
	ETzKCEMkfB/7vn8jF9oYF0tctcbnA3xkNv5M9jRh9pKADrJojvsNS1LUqreV
X-Google-Smtp-Source: AGHT+IHGyAeIayaMDZtIXEk2b58OQunCoSCTcTIuxomXBoSXRbCauoHGDLf/A0jXr4KngiM999VaNA==
X-Received: by 2002:ac8:7c52:0:b0:432:a566:cf71 with SMTP id o18-20020ac87c52000000b00432a566cf71mr5580839qtv.9.1712425262155;
        Sat, 06 Apr 2024 10:41:02 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id z7-20020a05620a08c700b0078a517d9fd2sm1637868qkz.29.2024.04.06.10.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 10:41:01 -0700 (PDT)
Date: Sat, 06 Apr 2024 13:41:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Gabriel Krisman Bertazi <krisman@suse.de>, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 martin.lau@kernel.org, 
 Gabriel Krisman Bertazi <krisman@suse.de>, 
 Lorenz Bauer <lmb@isovalent.com>
Message-ID: <6611892d95684_172b6329493@willemb.c.googlers.com.notmuch>
In-Reply-To: <66115fea712ed_16bd4c294c6@willemb.c.googlers.com.notmuch>
References: <20240404211111.30493-1-krisman@suse.de>
 <66115fea712ed_16bd4c294c6@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH] udp: Avoid call to compute_score on multiple sites
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Gabriel Krisman Bertazi wrote:
> > We've observed a 7-12% performance regression in iperf3 UDP ipv4 and
> > ipv6 tests with multiple sockets on Zen3 cpus, which we traced back to
> > commit f0ea27e7bfe1 ("udp: re-score reuseport groups when connected
> > sockets are present").  The failing tests were those that would spawn
> > UDP sockets per-cpu on systems that have a high number of cpus.
> > 
> > Unsurprisingly, it is not caused by the extra re-scoring of the reused
> > socket, but due to the compiler no longer inlining compute_score, once
> > it has the extra call site in upd5_lib_lookup2.  This is augmented by
> 
> udp4_lib_lookup2
> 
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
> > 	iperf3 -c 127.0.0.1 --udp -4 -f K -b $R -l 8920 -t 30 -i 5 -P 64 -O 2 2>&1
> > 
> > where $R is either 1G/10G/0 (max, unlimited).  I ran 5 times each.
> > baseline is 6.9.0-rc1-g962490525cff, just a recent checkout of Linus
> > tree. harmean == harmonic mean; CV == coefficient of variation.
> > 
> > ipv4:
> >                  1G                10G                  MAX
> > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> > baseline 1726716.59(0.0401) 1751758.50(0.0068) 1425388.83(0.1276)
> > patched  1842337.77(0.0711) 1861574.00(0.0774) 1888601.95(0.0580)
> > 
> > ipv6:
> >                  1G                10G                  MAX
> > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> > baseline: 1693636.28(0.0132) 1704418.23(0.0094) 1519681.83(0.1299)
> > patched   1909754.24(0.0307) 1782295.80(0.0539) 1632803.48(0.1185)
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
> > Finally, I can see this restores compute_score inlining in my gcc
> > without extra function attributes. Out of caution, I still added
> > __always_inline in compute_score, to prevent future changes from
> > un-inlining it again.  Since it is only in one site, it should be fine.
> > 
> > Cc: Lorenz Bauer <lmb@isovalent.com>
> > Fixes: f0ea27e7bfe1 ("udp: re-score reuseport groups when connected sockets are present")
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> > 
> > ---
> > Another idea would be shrinking compute_score and then inlining it.  I'm
> > not a network developer, but it seems that we can avoid most of the
> > "same network" checks of calculate_score when passing a socket from the
> > reusegroup.  If that is the case, we can fork out a compute_score_fast
> > that can be safely inlined at the second call site of the existing
> > compute_score.  I didn't pursue this any further.
> > ---
> >  net/ipv4/udp.c | 24 ++++++++++++++++++------
> >  net/ipv6/udp.c | 23 ++++++++++++++++++-----
> >  2 files changed, 36 insertions(+), 11 deletions(-)
> > 
> 
> > diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> > index 7c1e6469d091..883e62228432 100644
> > --- a/net/ipv6/udp.c
> > +++ b/net/ipv6/udp.c
> > @@ -114,7 +114,11 @@ void udp_v6_rehash(struct sock *sk)
> >  	udp_lib_rehash(sk, new_hash);
> >  }
> >  
> > -static int compute_score(struct sock *sk, struct net *net,
> > +/* While large, compute_score is in the UDP hot path and only used once
> > + * in udp4_lib_lookup2. Avoiding the function call by inlining it has
> 
> udp6_lib_lookup2
> 
> > + * yield measurable benefits in iperf3-based benchmarks.
> > + */
> > +static __always_inline int compute_score(struct sock *sk, struct net *net,
> >  			 const struct in6_addr *saddr, __be16 sport,
> >  			 const struct in6_addr *daddr, unsigned short hnum,

Forgot to mention: __always_inline is used very sparingly.

I don't think this qualifies. It did not have that attribute before,
nor needs it.

