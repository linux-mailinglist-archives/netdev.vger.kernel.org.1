Return-Path: <netdev+bounces-86788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC0E8A046A
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 02:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3271F2466A
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 00:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EF514F61;
	Thu, 11 Apr 2024 00:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VtcYsZ0F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FCB134A0
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794103; cv=none; b=nTvMevDmQ2hskDk0tXfXUXMlNz/ygvhcrNk9CqxDGZ3nrlpQrbVbFXIttmGaM1Y5Koo+1agU/RUEGQS0HDvl0S6vNCq6BFsQ2G0amy218AQ4q/hP6kY/MuuGFo0q88JZ3ZCjNriYxY9QocEip7lzXP5a7yCTv34u0y8VHmgYQpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794103; c=relaxed/simple;
	bh=Jtf/SRwRgZHJEsWDGItVreVBVHeZvSgBW1nzd9NGSeA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/l7Q+3fkPzafp3lXh2wdb00ndxA05Da2FbJgwMHIM1U7pjz+bRMfcRBIlFmCSXanoBbzjIKOqC9jNqz4ME4sUaeM7d2vyN3YEgNt+P4YorlzuUH1xv4Ob7MWNUk3h4/YghfEtbiiXWSqf7YL9uxM571JqkXIue9mf7cf7HZoUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VtcYsZ0F; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712794101; x=1744330101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=il6MW0T5O18TQB4pM0G5LS+r84S3zHH03G4QSkKbLIQ=;
  b=VtcYsZ0F+VAALn5x2I6UoVYaKqe4eUkOSQC1MUqlupPrlXhfDPI8Ckwo
   NWpo5Xa4W65pAv8PA5g6R6O6kkauo+I5T2pFog7mPcI/nwCe47CHOEps6
   U3/snV+PArVmNSucH0SoMQjDnx9Kant+GsgwPapRYECnucbpTAYDh1AVQ
   A=;
X-IronPort-AV: E=Sophos;i="6.07,191,1708387200"; 
   d="scan'208";a="625734198"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 00:08:18 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:48752]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.49:2525] with esmtp (Farcaster)
 id 8f080273-2903-45b7-9879-a3b2ee8a5e04; Thu, 11 Apr 2024 00:08:17 +0000 (UTC)
X-Farcaster-Flow-ID: 8f080273-2903-45b7-9879-a3b2ee8a5e04
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 11 Apr 2024 00:08:17 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 11 Apr 2024 00:08:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <davem@davemloft.net>, <krisman@suse.de>, <kuniyu@amazon.com>,
	<lmb@isovalent.com>, <martin.lau@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2] udp: Avoid call to compute_score on multiple sites
Date: Wed, 10 Apr 2024 17:08:07 -0700
Message-ID: <20240411000807.55368-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <66171e3698462_2d249d29412@willemb.c.googlers.com.notmuch>
References: <66171e3698462_2d249d29412@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 10 Apr 2024 19:18:14 -0400
> Kuniyuki Iwashima wrote:
> > From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Date: Wed, 10 Apr 2024 18:51:33 -0400
> > > Kuniyuki Iwashima wrote:
> > > > From: Gabriel Krisman Bertazi <krisman@suse.de>
> > > > Date: Wed, 10 Apr 2024 17:50:47 -0400
> > > > > We've observed a 7-12% performance regression in iperf3 UDP ipv4 and
> > > > > ipv6 tests with multiple sockets on Zen3 cpus, which we traced back to
> > > > > commit f0ea27e7bfe1 ("udp: re-score reuseport groups when connected
> > > > > sockets are present").  The failing tests were those that would spawn
> > > > > UDP sockets per-cpu on systems that have a high number of cpus.
> > > > > 
> > > > > Unsurprisingly, it is not caused by the extra re-scoring of the reused
> > > > > socket, but due to the compiler no longer inlining compute_score, once
> > > > > it has the extra call site in udp4_lib_lookup2.  This is augmented by
> > > > > the "Safe RET" mitigation for SRSO, needed in our Zen3 cpus.
> > > > > 
> > > > > We could just explicitly inline it, but compute_score() is quite a large
> > > > > function, around 300b.  Inlining in two sites would almost double
> > > > > udp4_lib_lookup2, which is a silly thing to do just to workaround a
> > > > > mitigation.  Instead, this patch shuffles the code a bit to avoid the
> > > > > multiple calls to compute_score.  Since it is a static function used in
> > > > > one spot, the compiler can safely fold it in, as it did before, without
> > > > > increasing the text size.
> > > > > 
> > > > > With this patch applied I ran my original iperf3 testcases.  The failing
> > > > > cases all looked like this (ipv4):
> > > > > 	iperf3 -c 127.0.0.1 --udp -4 -f K -b $R -l 8920 -t 30 -i 5 -P 64 -O 2
> > > > > 
> > > > > where $R is either 1G/10G/0 (max, unlimited).  I ran 3 times each.
> > > > > baseline is 6.9.0-rc1-g962490525cff, just a recent checkout of Linus
> > > > > tree. harmean == harmonic mean; CV == coefficient of variation.
> > > > > 
> > > > > ipv4:
> > > > >                  1G                10G                  MAX
> > > > > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> > > > > baseline 1730488.20(0.0050) 1639269.91(0.0795) 1436340.05(0.0954)
> > > > > patched  1980936.14(0.0020) 1933614.06(0.0866) 1784184.51(0.0961)
> > > > > 
> > > > > ipv6:
> > > > >                  1G                10G                  MAX
> > > > > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> > > > > baseline  1679016.07(0.0053) 1697504.56(0.0064) 1481432.74(0.0840)
> > > > > patched   1924003.38(0.0153) 1852277.31(0.0457) 1690991.46(0.1848)
> > > > > 
> > > > > This restores the performance we had before the change above with this
> > > > > benchmark.  We obviously don't expect any real impact when mitigations
> > > > > are disabled, but just to be sure it also doesn't regresses:
> > > > > 
> > > > > mitigations=off ipv4:
> > > > >                  1G                10G                  MAX
> > > > > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> > > > > baseline 3230279.97(0.0066) 3229320.91(0.0060) 2605693.19(0.0697)
> > > > > patched  3242802.36(0.0073) 3239310.71(0.0035) 2502427.19(0.0882)
> > > > > 
> > > > > Cc: Lorenz Bauer <lmb@isovalent.com>
> > > > > Fixes: f0ea27e7bfe1 ("udp: re-score reuseport groups when connected sockets are present")
> > > > > Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> > > > > 
> > > > > ---
> > > > > Changes since v1:
> > > > > (me)
> > > > >   - recollected performance data after changes below only for the
> > > > >   mitigations enabled case.
> > > > > (suggested by Willem de Bruijn)
> > > > >   - Drop __always_inline in compute_score
> > > > >   - Simplify logic by replacing third struct sock pointer with bool
> > > > >   - Fix typo in commit message
> > > > >   - Don't explicitly break out of loop after rescore
> > > > > ---
> > > > >  net/ipv4/udp.c | 18 +++++++++++++-----
> > > > >  net/ipv6/udp.c | 17 +++++++++++++----
> > > > >  2 files changed, 26 insertions(+), 9 deletions(-)
> > > > > 
> > > > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > > > index 661d0e0d273f..a13ef8e06093 100644
> > > > > --- a/net/ipv4/udp.c
> > > > > +++ b/net/ipv4/udp.c
> > > > > @@ -427,12 +427,15 @@ static struct sock *udp4_lib_lookup2(struct net *net,
> > > > >  {
> > > > >  	struct sock *sk, *result;
> > > > >  	int score, badness;
> > > > > +	bool rescore = false;
> > > > 
> > > > nit: Keep reverse xmax tree order.
> > > > https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs
> > > > 
> > > > >  
> > > > >  	result = NULL;
> > > > >  	badness = 0;
> > > > >  	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> > > > > -		score = compute_score(sk, net, saddr, sport,
> > > > > -				      daddr, hnum, dif, sdif);
> > > > > +rescore:
> > > > > +		score = compute_score((rescore ? result : sk), net, saddr,
> > > > 
> > > > I guess () is not needed around rescore ?
> > > > 
> > > > Both same for IPv6.
> > > > 
> > > > Otherwise, looks good to me.
> > > > 
> > > > Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > 
> > > Can we avoid using the same name for the label and boolean?
> > > 
> > > And since if looping result will have state TCP_ESTABLISHED, can it
> > > just be
> > > 
> > >     sk = result;
> > >     goto rescore;
> > 
> > TCP_ESTABLISHED never reaches the rescore jump as it's checked

Sorry I forgot about BPF.  I think BPF can select established one,
so this part is not true.


> > before calling inet_lookup_reuseport() and inet_lookup_reuseport()
> > also does not select TCP_ESTABLISHED.
> 
> I was thinking of the second part, inet_lookup_reuseport returning
> a connection from the group. I suppose this is assured not to be
> the case due to
> 
>            /* Falleback to scoring if grnult;p has connections */
>            if (!reuseport_has_conns(sk))
>                    return result;
> 
> 
> Is that what you mean?

reuseport_has_conns() is for reuseport group mixed with TCP_CLOSE and
TCP_ESTABLISHED, and here sk is usually (I mean without BPF) TCP_CLOSE
so that we don't decide too early and can check TCP_ESTABLISHED socket
placed later in the same hash chain.

Also, reuseport_select_sock_by_hash() returns NULL If the reuseport group
has only TCP_ESTABLISHED sockets when selecting, and then we continue with
result = sk;


> 
> There are a lot of hidden assumptions then to make sure this
> control flow is correct.
> 
> Should we instead just have
> 
>             badness = score;
> 
> +            if (rescore)
> +                    continue;

The 2nd compute_score() is added recently for a situation where
inet_lookup_reuseport() returns sk with higher score to avoid
calling inet_lookup_reuseport() again for the result.

  f0ea27e7bfe1 ("udp: re-score reuseport groups when connected sockets are present")


> 
> Also, can the rescore = false in the datapath be avoided. The purpose
> is to only jump once. It would be good if it is obvious that a
> repeated (or infinite) loop is not possible, regardless of what
> the callees return.
> 

