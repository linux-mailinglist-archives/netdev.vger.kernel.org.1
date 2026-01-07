Return-Path: <netdev+bounces-247637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E73CFCAA8
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 09:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 341D93003491
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 08:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C386A2DE6FC;
	Wed,  7 Jan 2026 08:47:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF6628642D
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767775624; cv=none; b=METGPoUolaz9R5aNvTUjOWg9/46voCFlUklv01IjvGtj6t7ylVEW7XPEtEaXiBByXiBes5eBp5jrfbQ1Q0FPy38yaEixBEN0qfnJzugQl60X/LSup0BaUz53/5+vWsn+dwoDZk013r3uz3y7m8pe6vC9BoOcFsvwv+kvxotMBu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767775624; c=relaxed/simple;
	bh=zcSn67HRG625hD0pU6o4HRa3vtPFK8jR7pyJduTCA94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K52r5+EuCo64SO4sp4sIztUBWpAQYqeSQWJMnHTz58sDrrolAZZ/2f1gRJeiqR4vd4vdmE0gf6pkniC/rZ0tF1UwGGpJhH6xQGyKFGWw33zxSBUVbkhxdLj7vmYXxmNRdVoCts/Sl1StS5jjkQETmFZ1++GGva56RgcYmy5MDFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 887DC602A9; Wed, 07 Jan 2026 09:46:53 +0100 (CET)
Date: Wed, 7 Jan 2026 09:46:53 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com,
	Mazin Al Haddad <mazin@getstate.dev>
Subject: Re: [PATCH v2 net] ip6_gre: use skb_vlan_inet_prepare() instead of
 pskb_inet_may_pull()
Message-ID: <aV4ddkDATvo9lBHi@strlen.de>
References: <20260106144529.1424886-1-edumazet@google.com>
 <20260106095648.07a870f1@kernel.org>
 <CANn89iJnXg892OU13PeJMGvBKw90fJdqDaAmJ867Rptsm0zgNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJnXg892OU13PeJMGvBKw90fJdqDaAmJ867Rptsm0zgNA@mail.gmail.com>

Eric Dumazet <edumazet@google.com> wrote:
> On Tue, Jan 6, 2026 at 6:56 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Tue,  6 Jan 2026 14:45:29 +0000 Eric Dumazet wrote:
> > > v2: invert the conditions (Jakub)
> >
> > Thanks! Much better now, but still failing
> > tools/testing/selftests/net/gre_gso.sh
> >
> > TAP version 13
> > 1..1
> > # timeout set to 3600
> > # selftests: net: gre_gso.sh
> > # 2.16 [+2.16]     TEST: GREv6/v4 - copy file w/ TSO                                   [ OK ]
> > # 3.16 [+1.01] 2026/01/06 10:32:57 socat[20546] W exiting on signal 15
> > # 3.17 [+0.01] 2026/01/06 10:32:57 socat[20546] W exiting on signal 15
> > # 3.17 [+0.00]     TEST: GREv6/v4 - copy file w/ GSO                                   [FAIL]
> > # 3.18 [+0.01] 2026/01/06 10:32:57 socat[20533] W exiting on signal 15
> > # 3.19 [+0.00]     TEST: GREv6/v6 - copy file w/ TSO                                   [ OK ]
> > # 4.19 [+1.00] 2026/01/06 10:32:59 socat[20559] W exiting on signal 15
> > # 4.19 [+0.01]     TEST: GREv6/v6 - copy file w/ GSO                                   [FAIL]
> > # 4.20 [+0.01] 2026/01/06 10:32:59 socat[20549] W exiting on signal 15
> > # 4.22 [+0.02] 2026/01/06 10:32:59 socat[20560] W exiting on signal 15
> > # 4.23 [+0.01]
> > # 4.23 [+0.00] Tests passed:   2
> > # 4.23 [+0.00] Tests failed:   2
> > not ok 1 selftests: net: gre_gso.sh # exit=1
> >
> > https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/461862/65-gre-gso-sh/stdout
> 
> For some reason I am unable to run this test from a virtme-ng instance.
> 
> I guess I wlll not make a new version of this patch, maybe Florian can
> take over.

Its failing because nhoff is moved by 14 bytes, test passes after doing:

-       if (skb_vlan_inet_prepare(skb, false))
+       if (skb_vlan_inet_prepare(skb, true))

