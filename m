Return-Path: <netdev+bounces-87180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 533638A1FF3
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 22:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B757F1F24951
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B593175A6;
	Thu, 11 Apr 2024 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kc9dlWFy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1950217C67
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712866429; cv=none; b=thWE7WrKyAMmH6LT9RvsGNUWIlHRaHdWU26HQdjdG29VQzLK3PAxCN/Q6cU0LHyPubOsVcCYQvRwB0UppsOB7IWSok8JIzXJFn/mnghmPZNQFtpHTNgI1I6hr15MuO6XlgbNcX7o5D2bnFQA2ltA1sFMqJa4hX3FUuRTcmxmiag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712866429; c=relaxed/simple;
	bh=k92o4ntReoLV1qGFgor70oFn0HujuDu3MkXV5PowWqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBnbsjz33e2EwI95gTX/Mr2uu9pzWg243yXWBq9rWhNJt3aDztTcJetL/6uMgS8Ba1Pu8aPu62RaA4Tm0tOs/d+ZLaTukElk041ohpVKyu267awDvGHQdmzhrwtH9cRFWEgqoBFi75iHneX+/Lj1i6szOXAodvqBddUZFRrCitg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kc9dlWFy; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712866428; x=1744402428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LIYjvKtgpn6BGjObi14Xx2A+c7VJcEhrTohy7nkHEv4=;
  b=kc9dlWFyUmMLiE/SxivkJapglCDJ0bBzaEu9SHzBzpGX0AtMfLTLcI5J
   goBIFUxZ6mwT7O62SjTFPt3nrlqDU/NWKlSWjVj7sk+937Skf8frV+YfG
   lPthLn5QilNGpFbzImNwuc8HD6IHclh8gMeOK0fN/5FpJEeueb+SoePtG
   g=;
X-IronPort-AV: E=Sophos;i="6.07,193,1708387200"; 
   d="scan'208";a="394121594"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 20:13:44 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:30339]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.230:2525] with esmtp (Farcaster)
 id f3689b45-50fa-4717-8614-a52b75d05bb0; Thu, 11 Apr 2024 20:13:44 +0000 (UTC)
X-Farcaster-Flow-ID: f3689b45-50fa-4717-8614-a52b75d05bb0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 11 Apr 2024 20:13:36 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 11 Apr 2024 20:13:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <krisman@suse.de>
CC: <davem@davemloft.net>, <kuniyu@amazon.com>, <lmb@isovalent.com>,
	<martin.lau@kernel.org>, <netdev@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v2] udp: Avoid call to compute_score on multiple sites
Date: Thu, 11 Apr 2024 13:13:25 -0700
Message-ID: <20240411201325.85638-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <871q7b8ymc.fsf@mailhost.krisman.be>
References: <871q7b8ymc.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gabriel Krisman Bertazi <krisman@suse.de>
Date: Thu, 11 Apr 2024 15:53:31 -0400
> Kuniyuki Iwashima <kuniyu@amazon.com> writes:
> 
> > From: Gabriel Krisman Bertazi <krisman@suse.de>
> > Date: Wed, 10 Apr 2024 21:54:30 -0400
> >> Willem de Bruijn <willemdebruijn.kernel@gmail.com> writes:
> >> 
> >> > Kuniyuki Iwashima wrote:
> >> >> From: Gabriel Krisman Bertazi <krisman@suse.de>
> >> >> Date: Wed, 10 Apr 2024 17:50:47 -0400
> >> >> > We've observed a 7-12% performance regression in iperf3 UDP ipv4 and
> >> >> > ipv6 tests with multiple sockets on Zen3 cpus, which we traced back to
> >> >> > commit f0ea27e7bfe1 ("udp: re-score reuseport groups when connected
> >> >> > sockets are present").  The failing tests were those that would spawn
> >> >> > UDP sockets per-cpu on systems that have a high number of cpus.
> >> >> > 
> >> >> > Unsurprisingly, it is not caused by the extra re-scoring of the reused
> >> >> > socket, but due to the compiler no longer inlining compute_score, once
> >> >> > it has the extra call site in udp4_lib_lookup2.  This is augmented by
> >> >> > the "Safe RET" mitigation for SRSO, needed in our Zen3 cpus.
> >> >> > 
> >> >> > We could just explicitly inline it, but compute_score() is quite a large
> >> >> > function, around 300b.  Inlining in two sites would almost double
> >> >> > udp4_lib_lookup2, which is a silly thing to do just to workaround a
> >> >> > mitigation.  Instead, this patch shuffles the code a bit to avoid the
> >> >> > multiple calls to compute_score.  Since it is a static function used in
> >> >> > one spot, the compiler can safely fold it in, as it did before, without
> >> >> > increasing the text size.
> >> >> > 
> >> >> > With this patch applied I ran my original iperf3 testcases.  The failing
> >> >> > cases all looked like this (ipv4):
> >> >> > 	iperf3 -c 127.0.0.1 --udp -4 -f K -b $R -l 8920 -t 30 -i 5 -P 64 -O 2
> >> >> > 
> >> >> > where $R is either 1G/10G/0 (max, unlimited).  I ran 3 times each.
> >> >> > baseline is 6.9.0-rc1-g962490525cff, just a recent checkout of Linus
> >> >> > tree. harmean == harmonic mean; CV == coefficient of variation.
> >> >> > 
> >> >> > ipv4:
> >> >> >                  1G                10G                  MAX
> >> >> > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> >> >> > baseline 1730488.20(0.0050) 1639269.91(0.0795) 1436340.05(0.0954)
> >> >> > patched  1980936.14(0.0020) 1933614.06(0.0866) 1784184.51(0.0961)
> >> >> > 
> >> >> > ipv6:
> >> >> >                  1G                10G                  MAX
> >> >> > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> >> >> > baseline  1679016.07(0.0053) 1697504.56(0.0064) 1481432.74(0.0840)
> >> >> > patched   1924003.38(0.0153) 1852277.31(0.0457) 1690991.46(0.1848)
> >> >> > 
> >> >> > This restores the performance we had before the change above with this
> >> >> > benchmark.  We obviously don't expect any real impact when mitigations
> >> >> > are disabled, but just to be sure it also doesn't regresses:
> >> >> > 
> >> >> > mitigations=off ipv4:
> >> >> >                  1G                10G                  MAX
> >> >> > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> >> >> > baseline 3230279.97(0.0066) 3229320.91(0.0060) 2605693.19(0.0697)
> >> >> > patched  3242802.36(0.0073) 3239310.71(0.0035) 2502427.19(0.0882)
> >> >> > 
> >> >> > Cc: Lorenz Bauer <lmb@isovalent.com>
> >> >> > Fixes: f0ea27e7bfe1 ("udp: re-score reuseport groups when connected sockets are present")
> >> >> > Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> >> >> > 
> >> >> > ---
> >> >> > Changes since v1:
> >> >> > (me)
> >> >> >   - recollected performance data after changes below only for the
> >> >> >   mitigations enabled case.
> >> >> > (suggested by Willem de Bruijn)
> >> >> >   - Drop __always_inline in compute_score
> >> >> >   - Simplify logic by replacing third struct sock pointer with bool
> >> >> >   - Fix typo in commit message
> >> >> >   - Don't explicitly break out of loop after rescore
> >> >> > ---
> >> >> >  net/ipv4/udp.c | 18 +++++++++++++-----
> >> >> >  net/ipv6/udp.c | 17 +++++++++++++----
> >> >> >  2 files changed, 26 insertions(+), 9 deletions(-)
> >> >> > 
> >> >> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> >> >> > index 661d0e0d273f..a13ef8e06093 100644
> >> >> > --- a/net/ipv4/udp.c
> >> >> > +++ b/net/ipv4/udp.c
> >> >> > @@ -427,12 +427,15 @@ static struct sock *udp4_lib_lookup2(struct net *net,
> >> >> >  {
> >> >> >  	struct sock *sk, *result;
> >> >> >  	int score, badness;
> >> >> > +	bool rescore = false;
> >> >> 
> >> >> nit: Keep reverse xmax tree order.
> >> >> https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs
> >> >> 
> >> >> >  
> >> >> >  	result = NULL;
> >> >> >  	badness = 0;
> >> >> >  	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> >> >> > -		score = compute_score(sk, net, saddr, sport,
> >> >> > -				      daddr, hnum, dif, sdif);
> >> >> > +rescore:
> >> >> > +		score = compute_score((rescore ? result : sk), net, saddr,
> >> >> 
> >> >> I guess () is not needed around rescore ?
> >> >> 
> >> >> Both same for IPv6.
> >> >> 
> >> >> Otherwise, looks good to me.
> >> >> 
> >> >> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> >> >
> >> > Can we avoid using the same name for the label and boolean?
> >> >
> >> > And since if looping result will have state TCP_ESTABLISHED, can it
> >> > just be
> >> >
> >> >     sk = result;
> >> >     goto rescore;
> >> 
> >> This would be much simpler, sure.  I actually didn't want to do it
> >> because sk is the iteration cursor, and I couldn't prove to myself it is
> >> safe to skip through part of the list (assuming result isn't the
> >> immediate next socket in the list).
> >
> > Good point, this is not safe actually.
> >
> > Let's say sockets on the same port are placed in these order in the list:
> >
> >   1. TCP_CLOSE sk w/ SO_INCOMING_CPU _not_ matching the current CPU
> >   2. TCP_ESTABLISHED sk matching 4-tuple
> >   3. TCP_CLOSE sk w/ SO_INCOMING_CPU matching the current CPU
> >
> > When we check the first socket, we'll get the 3rd socket as it matches
> > the current CPU ID and TCP_ESTABLISHED cannot be selected without BPF,
> > and `sk = result;` skips the 2nd socket, which should have been
> > selected.
> 
> k. Considering this, what I get from the discussion is:
> 
> since we need to preserve the sk pointer, we are keeping the
> condition (rescore ?  result:sk) in the compute_score call and
> maintaining the reset of rescore in the hotpath to prevent scoring the
> wrong thing on further loops. It is ugly, but it is a single instruction
> over a in-register value, so it hardly matters.
> 
> If so, I'll do the style changes (parenthesis, sort of stack variables)
> and add the early continue to resume the loop right after the rescore,
> similar to what I had in V1, that Willem suggested:
> 
>             badness = score;
> 
> +            if (rescore)
> +                    continue;

I'm wondering if rescore happens only once, but at least here we
need to update result.  Otherwise, in the example above, the 3rd
socket is returned as result.


> 
> Please, let me know if I misunderstood, so I don't send a bogus v3.  I
> will take some hours to run the tests, so I should send a v3 by
> tomorrow.


