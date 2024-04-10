Return-Path: <netdev+bounces-86779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB518A03EE
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 01:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04B6286F7D
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 23:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1EE282F0;
	Wed, 10 Apr 2024 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEz8VCyC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B8246B5
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791098; cv=none; b=Bv9GSiibyLDmCi2ZXsfxbelCC/Vd2I/O5ax0q9M8IQSxkIdxPeKprzpfW/jJmybVqyFm6hAVHRR81hr60fB5EAFSfUi75ZFbCDO9Jr52B/AkBaGJGVhMiCShf34k2y7fkD5Uqgu+RYc0kq1EaAbaGiQm8QdpP33zCd5JLEhq0Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791098; c=relaxed/simple;
	bh=wTDepFGbBDyBwHr80RVMYCmu8usQcT6mUQHo1C9zJpc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VExDCXvE+hTiQyJNOy3F1iQr74xCmAQrecD3qJCEnrXmS5rszrnUMg5sa+u7ErHM3NDISgWmqnEnWAZn2T2BgWrricyq9MmJNTUM/5q7DAJ3ANA2CmCEYtwn2CM5J7L+LZ6fvrOAu8NZy21z3atDZ6mMCyvkOUjtT57PH4WUzoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEz8VCyC; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78d68c08df7so224056685a.2
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 16:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712791095; x=1713395895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAY9Y2h2POT5uaOqhVMBuqSmAf6sfxkP1qS8/f4GNsg=;
        b=fEz8VCyCM3esXVWnxPHXDSS7VUDetPnoHgwSaCudow0ulnA/kMyfQxBedTOv0bjA+B
         bGdNLqGs6qcxOcQTFoN+7upzX/S09R1viYgCkgWydB8lftJGSdmC2mA5t+fK5qMp0jug
         YTMExat6wYb0jTjwZ6xqxCREMUOdcYrb9bQT3f5epfRBUvX/i+GlyQsRGLgUPv/2BkRf
         3QJZJleU+pYa5cqyepXyLoQ9aF27oxn6jJGLiY9QN8bhaZ3QFtw90IU5h34fdGv2QFqD
         D0gaZsIbw3ZRS+ZwHeMYEA8ebT44vCLGIQd+b15MLsXxNXPrjt83RvM1rlNC8+ys6GeB
         gUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712791095; x=1713395895;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oAY9Y2h2POT5uaOqhVMBuqSmAf6sfxkP1qS8/f4GNsg=;
        b=cSsuYWUKkRsbN45g/AvIeu88LJxUoR2IPWf+AsRKljA19aXiyUBQLV8uJ37P7hsKCN
         EnH6l81ffvgvwqshP3UTYBriWyFqPx5IDA5yW/Im1zMWxdzVVoAnwvRffloQCcnJO7pv
         MwyJVzmY5dRFLL6CDxukS0dqdgobXXgirGffeEyMXcNGjwtCAnwwwHlwsC3WbQJFxOBb
         su4xhV2UbLuhTXZsLqfWFXz4fWAduz2/gTwLrYGBSR52wumquIqKCaG3PB5FfO7kpw/Q
         duKoi7DuyvvycL1ha7CVKNau1CA8jsuyitQxeZErW5OLYH9r9hGR2EW1TH1ZaUaiGnCE
         J6Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXVOvUUtoWa2oIBTMf9yQIVIm1xnzUFDHM91PcXw6WwQFKGwcRCRnT09dla4ktasrPgHzbd2XISyFbGQReUvaXvdP6IjM4/
X-Gm-Message-State: AOJu0YzpxbIzpzpxDx6ccL4/wRKJ2JU3uU4AJL7X4RZyXy0JdXLLP0Vu
	14fCAsC1qddKQYKm+6QYLZhBrOTbpc/TjSlECqHg8waX/WO8DPdY
X-Google-Smtp-Source: AGHT+IGmZQYpdJuKsg5nMeqb5hsKpqfELEjCcvIuCfWv4n2lxqLAAEm1G+nlv6DsLGsNUzbD2gRJCw==
X-Received: by 2002:a05:620a:134c:b0:78d:7574:89da with SMTP id c12-20020a05620a134c00b0078d757489damr4312260qkl.62.1712791095348;
        Wed, 10 Apr 2024 16:18:15 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id w11-20020a05620a444b00b0078d68e38d72sm193588qkp.121.2024.04.10.16.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 16:18:15 -0700 (PDT)
Date: Wed, 10 Apr 2024 19:18:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 krisman@suse.de, 
 kuniyu@amazon.com, 
 lmb@isovalent.com, 
 martin.lau@kernel.org, 
 netdev@vger.kernel.org
Message-ID: <66171e3698462_2d249d29412@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240410230718.49778-1-kuniyu@amazon.com>
References: <661717f5c2839_2d123b294f@willemb.c.googlers.com.notmuch>
 <20240410230718.49778-1-kuniyu@amazon.com>
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
> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Wed, 10 Apr 2024 18:51:33 -0400
> > Kuniyuki Iwashima wrote:
> > > From: Gabriel Krisman Bertazi <krisman@suse.de>
> > > Date: Wed, 10 Apr 2024 17:50:47 -0400
> > > > We've observed a 7-12% performance regression in iperf3 UDP ipv4 and
> > > > ipv6 tests with multiple sockets on Zen3 cpus, which we traced back to
> > > > commit f0ea27e7bfe1 ("udp: re-score reuseport groups when connected
> > > > sockets are present").  The failing tests were those that would spawn
> > > > UDP sockets per-cpu on systems that have a high number of cpus.
> > > > 
> > > > Unsurprisingly, it is not caused by the extra re-scoring of the reused
> > > > socket, but due to the compiler no longer inlining compute_score, once
> > > > it has the extra call site in udp4_lib_lookup2.  This is augmented by
> > > > the "Safe RET" mitigation for SRSO, needed in our Zen3 cpus.
> > > > 
> > > > We could just explicitly inline it, but compute_score() is quite a large
> > > > function, around 300b.  Inlining in two sites would almost double
> > > > udp4_lib_lookup2, which is a silly thing to do just to workaround a
> > > > mitigation.  Instead, this patch shuffles the code a bit to avoid the
> > > > multiple calls to compute_score.  Since it is a static function used in
> > > > one spot, the compiler can safely fold it in, as it did before, without
> > > > increasing the text size.
> > > > 
> > > > With this patch applied I ran my original iperf3 testcases.  The failing
> > > > cases all looked like this (ipv4):
> > > > 	iperf3 -c 127.0.0.1 --udp -4 -f K -b $R -l 8920 -t 30 -i 5 -P 64 -O 2
> > > > 
> > > > where $R is either 1G/10G/0 (max, unlimited).  I ran 3 times each.
> > > > baseline is 6.9.0-rc1-g962490525cff, just a recent checkout of Linus
> > > > tree. harmean == harmonic mean; CV == coefficient of variation.
> > > > 
> > > > ipv4:
> > > >                  1G                10G                  MAX
> > > > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> > > > baseline 1730488.20(0.0050) 1639269.91(0.0795) 1436340.05(0.0954)
> > > > patched  1980936.14(0.0020) 1933614.06(0.0866) 1784184.51(0.0961)
> > > > 
> > > > ipv6:
> > > >                  1G                10G                  MAX
> > > > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> > > > baseline  1679016.07(0.0053) 1697504.56(0.0064) 1481432.74(0.0840)
> > > > patched   1924003.38(0.0153) 1852277.31(0.0457) 1690991.46(0.1848)
> > > > 
> > > > This restores the performance we had before the change above with this
> > > > benchmark.  We obviously don't expect any real impact when mitigations
> > > > are disabled, but just to be sure it also doesn't regresses:
> > > > 
> > > > mitigations=off ipv4:
> > > >                  1G                10G                  MAX
> > > > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> > > > baseline 3230279.97(0.0066) 3229320.91(0.0060) 2605693.19(0.0697)
> > > > patched  3242802.36(0.0073) 3239310.71(0.0035) 2502427.19(0.0882)
> > > > 
> > > > Cc: Lorenz Bauer <lmb@isovalent.com>
> > > > Fixes: f0ea27e7bfe1 ("udp: re-score reuseport groups when connected sockets are present")
> > > > Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> > > > 
> > > > ---
> > > > Changes since v1:
> > > > (me)
> > > >   - recollected performance data after changes below only for the
> > > >   mitigations enabled case.
> > > > (suggested by Willem de Bruijn)
> > > >   - Drop __always_inline in compute_score
> > > >   - Simplify logic by replacing third struct sock pointer with bool
> > > >   - Fix typo in commit message
> > > >   - Don't explicitly break out of loop after rescore
> > > > ---
> > > >  net/ipv4/udp.c | 18 +++++++++++++-----
> > > >  net/ipv6/udp.c | 17 +++++++++++++----
> > > >  2 files changed, 26 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > > index 661d0e0d273f..a13ef8e06093 100644
> > > > --- a/net/ipv4/udp.c
> > > > +++ b/net/ipv4/udp.c
> > > > @@ -427,12 +427,15 @@ static struct sock *udp4_lib_lookup2(struct net *net,
> > > >  {
> > > >  	struct sock *sk, *result;
> > > >  	int score, badness;
> > > > +	bool rescore = false;
> > > 
> > > nit: Keep reverse xmax tree order.
> > > https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs
> > > 
> > > >  
> > > >  	result = NULL;
> > > >  	badness = 0;
> > > >  	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> > > > -		score = compute_score(sk, net, saddr, sport,
> > > > -				      daddr, hnum, dif, sdif);
> > > > +rescore:
> > > > +		score = compute_score((rescore ? result : sk), net, saddr,
> > > 
> > > I guess () is not needed around rescore ?
> > > 
> > > Both same for IPv6.
> > > 
> > > Otherwise, looks good to me.
> > > 
> > > Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > 
> > Can we avoid using the same name for the label and boolean?
> > 
> > And since if looping result will have state TCP_ESTABLISHED, can it
> > just be
> > 
> >     sk = result;
> >     goto rescore;
> 
> TCP_ESTABLISHED never reaches the rescore jump as it's checked
> before calling inet_lookup_reuseport() and inet_lookup_reuseport()
> also does not select TCP_ESTABLISHED.

I was thinking of the second part, inet_lookup_reuseport returning
a connection from the group. I suppose this is assured not to be
the case due to

           /* Falleback to scoring if grnult;p has connections */
           if (!reuseport_has_conns(sk))
                   return result;


Is that what you mean?

There are a lot of hidden assumptions then to make sure this
control flow is correct.

Should we instead just have

            badness = score;

+            if (rescore)
+                    continue;

Also, can the rescore = false in the datapath be avoided. The purpose
is to only jump once. It would be good if it is obvious that a
repeated (or infinite) loop is not possible, regardless of what
the callees return.

