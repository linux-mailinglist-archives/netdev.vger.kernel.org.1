Return-Path: <netdev+bounces-288602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IgnHMc6CGpafQMAu9opvQ
	(envelope-from <netdev+bounces-288602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 11:37:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1416455AF47
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 11:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D894130071CA
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 09:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0349380FC5;
	Sat, 16 May 2026 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="y8w+I41u"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0139A045
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778924226; cv=none; b=pBpIJcu/5yqX3Hm5GYkIu/l2h2EnV10LksBbyBx6+BYJ+Jvn2/syNgIE2f/N+M9Tf+z29U7E07OHILX9wGHk60sjNP9T2F6R/1JY+2EgNtkh1gMbKBvQLVlNfgxGlBGVkSM1tIqnqAjXhvgucyhhcD1jgcwcoBWLJ70FhyVuscI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778924226; c=relaxed/simple;
	bh=eKXDr/j4oGqhC5VEAtTBKloNrPmEjECa8i9zLtzm04A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=MdNve4FN4awIupI0I51/g6HOwuD2Dkt+Fgvet4AZG6q0dvF9P/+3uOc4Y9JPCLWzpNoI9WavA/zHrwnCTPQBMkDXA8G9RabbDVO2Eqijk4/PEnh7JKLpPt9fCLUhy57EZq7pzL39O0+X9T1BD0VLAT/Gz6L2EKg8e3onK0e5/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=y8w+I41u; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id ABE61C5E162;
	Sat, 16 May 2026 09:37:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D128C5FF2B;
	Sat, 16 May 2026 09:37:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CE5BC11AF8A00;
	Sat, 16 May 2026 11:36:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778924219; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rpzoZAFKRYAZK0vmypXj69JCTnwzveyOnoaIj0OblW4=;
	b=y8w+I41uLf2848/1cF2YmOC2nvTaeFeozSLUnA1DZsM+70KdBbSIuZdwJQPCAtQGcBUfnn
	B6yfpQy0vmRLXp6lkXCcF48W1c3IIM+o2b7qU5mRkDlLxrDiIcvX4igT+kaXtHo51pXxbK
	5xw7kJy1+QLQN/DS0HgHcQ3n5Z1wbuXCdCkyLEw4sOhj1zItQeiMmc2BE6DuGx7/A1uqkd
	RGQFZP08UTuq61i1JKw5d9R5R8TycnkoYhs1B2+Yuv9bDPY9qgHfhRP2PIYQeH71pT1r32
	1jjQdvwzjXkjO/IPTcvcaqBSyVwDezAlVa6X4BTpcGlEWFvgFtHISi4704yhAQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 16 May 2026 11:36:46 +0200
Message-Id: <DIK002QFFNBY.31C3KUX2SQC6W@bootlin.com>
Subject: Re: [RFC PATCH net-next 0/3] net: macb: candidate fixes for silent
 TX stall on BCM2712/RP1
Cc: "Andrea della Porta" <andrea.porta@suse.com>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rpi-kernel@lists.infradead.org>
To: "Lukasz Raczylo" <lukasz@raczylo.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <cover.1777064117.git.lukasz@raczylo.com>
 <20260514215129.33559-1-lukasz@raczylo.com>
In-Reply-To: <20260514215129.33559-1-lukasz@raczylo.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 1416455AF47
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288602-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello Lukasz,

On Thu May 14, 2026 at 11:51 PM CEST, Lukasz Raczylo wrote:
> Andrea, Th=C3=A9o --
>
> Thanks both.  Replying to multiple points in one mail since they
> intersect.

Hum, you forgot some parts of my email to address. The good thing with
interleaved replies is that you see what you need to reply to.
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#use-=
trimmed-interleaved-replies-in-email-discussions

No big deal.

> First a correction to the v1 cover: the "zero events post-patch"
> claim was true only at the user-space watchdog visibility level.
> With patch 3's warn made unconditional (which is what Andrea's
> review re-tested with on v6.19.10), kernel-level evidence on my
> side now matches what Andrea saw -- patches 1 and 2 are partial,
> patch 3 is empirically the load-bearing fix on this platform.
> The v2 cover acknowledges this and reframes.

[...]

> ## Th=C3=A9o -- the four questions on the cover
>
> Welcome to macb maintenance.  Quick answers; raw 1 Hz traces,
> dmesg dumps, and event logs available on request for any of
> these.

Thanks!

>   1. Tx-only or Tx+Rx broken?
[...]

ACK, makes sense

>   2. Recovery: link down/up vs module reload vs power cycle?
[...]

ACK, makes sense

>   3. TSO / SG / EEE disabling helped some reporters?
>
>      Mixed picture, with one gap in my matrix.
>
>      Tested fleet-wide since 2026-04-24 as baseline before this
>      series:
>        * EEE off (--set-eee end0 eee off + advertise 0x0)
>        * TSO off (-K tso off)
>        * GSO off (-K gso off)
>        * RX/TX rings 4096/2048 (default 512)
>        * IRQ affinity moved off CPU0 to CPU3
>        * CPU governor schedutil (default) -- earlier tested
>          performance, no change
>        * qdisc fq -> pfifo_fast
>
>      With all of those, the stall still fires.  Pre-patch
>      fleet rate was multiple per hour with these knobs already
>      applied.
>
>      Untested by me: TSO + SG (scatter-gather, NETIF_F_SG) off
>      *together*.  That is the specific combination rtheobald
>      (cilium#43198 comment 4188846955) and the launchpad
>      commenter (#34) report as masking the stall -- "must be
>      both, not just one".  I tested TSO + GSO, not TSO + SG.
>
>      Both patch 1 (PCIe-fabric race on TSTART) and patch 2
>      (peripheral DMA retirement race on TX_USED) are
>      consistent with descriptor-fragment-path interactions
>      that SG-off would mask, so the workaround being real
>      isn't surprising.  Closing the race rather than masking
>      it should still be the right thing for mainline.  Happy
>      to canary-test TSO+SG-off on one node if you want the
>      data point before v2 review.

Honestly I was surprised by that comment and doubted it. I don't see how
those could be related. Don't bother testing the full matrix too much.

>   4. cdns,*-max-pipe DT props -- lead dead?
[...]

ACK makes sense

> ## My own audit -- two issues v2 fixes
>
> Worth disclosing before someone else catches them.
>
>   * Patch 2 (v1) reads ISR in macb_tx_poll(), masks off
>     everything except TCOMP, and discards the rest.
>     raspberrypi_rp1_config does not set
>     MACB_CAPS_ISR_CLEAR_ON_WRITE -- the driver assumes
>     read-clear ISR semantics on RP1, and macb_interrupt()
>     relies on processing every bit it reads in one pass for
>     that case to be correct.  My v1 patch breaks that contract:
>     any RCOMP / ROVR / TXUBR / etc. set in ISR at the moment of
>     my read is silently consumed and never processed.  RCOMP
>     being lost is the worst case (RX completion never scheduled
>     until something else asserts the line).  Race window is
>     ~200-500 ns per macb_tx_poll completion; significant at
>     moderate-to-heavy RX load on a level-triggered IRQ where
>     the consumed bit drops the line before GIC delivery.

Careful, you mention your raspberrypi_rp1_config doesn't set
MACB_CAPS_ISR_CLEAR_ON_WRITE but there is a catch: we expect that cap
to come from runtime discovery, see macb_configure_caps() and
register DCFG1/0x0280.

My understanding is that read-to-clear is only for old variants and all
modern MACB/GEM instances use write-to-clear.

I don't expect your RP1 HW uses R2C; my past comment was about making
sure you support both W2C and R2C to avoid breaking the driver for
some.

We have `dev_dbg(..., "Cadence caps 0x%08x\n", bp->caps)` to dump caps,
including the runtime detected ones.

>     v2 patch 2 drops the ISR read entirely and substitutes
>     (void)queue_readl(queue, IMR).  IMR is the read-only mask
>     mirror, no side effects, still flushes prior peripheral
>     DMA writes via PCIe ordering.  Loses the "directly sample
>     latched TCOMP" half of v1's claim; keeps the PCIe-barrier
>     half (which is the half that actually addresses the
>     documented race in the existing macb_tx_complete_pending()
>     rmb() comment).
>
>   * Patch 3 (v1) boot-time false positive described above to
>     Andrea.  v2 fixes:
>
>       - netif_carrier_ok() gate -- no carrier, no completion is
>         possible, don't fire.
>
>       - tracks tail movement via a bool tx_stall_tail_moved set
>         by macb_tx_complete() under tx_ptr_lock when tail
>         advances, cleared by the watchdog tick on the same
>         lock.  Form suggested by pelwell when he reviewed the
>         same series anchored against rpi-6.18.y at
>         raspberrypi/linux#7340 (merged 2026-05-08); 13 days of
>         fleet runtime in this form since 2026-05-02 across 24
>         nodes.  Folded into mainline v2 patch 3 directly rather
>         than carried as a fix-up.
>
>       - netdev_warn_once -> netdev_warn_ratelimited per
>         Andrea's ask -- operator visibility doesn't disappear
>         after the first fire.
>
>
> ## v2 follows
>
> Sending [PATCH net-next v2 0/3] threaded under the v1 cover
> shortly.  Plan to drop "RFC" from the subject prefix (~3 weeks
> production runtime + the rpi in-tree merge tip the balance
> toward a regular PATCH); happy to revert to RFC if you'd
> prefer the iterative-review cadence.
[...]

So you skimmed over two parts of my initial comment:

 - Upstream kernel? From your messages it seems you only build test.
   My question is two-fold:

    - (1) Can we confirm the bug reproduces on upstream?

    - (2) For my personal knowledge, can you tell me why everyone uses
      the Raspberry Pi vendor kernel? I see an upstream DT for rpi5.
      I'll boot one on my desk next week (hopefully).

 - .ndo_tx_timeout() is probably the right approach for [3/3].

---

My recommandation would be this:

Let's get a .ndo_tx_timeout() implementation merged that will mitigate
the issue. If you can prove [1/3] and/or [2/3] are useful, then we can
get those in as well. Otherwise we drop them and keep digging to find
the Tx stall reason(s).

Those are bug-fixes, HW is broken-ish for a good chunk of users, so they
should target net and not net-next. You need a `Fixes:` trailer, it
will probably date back a long way.

Thanks Lukasz!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


