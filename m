Return-Path: <netdev+bounces-287908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLNkGYukBWppZQIAu9opvQ
	(envelope-from <netdev+bounces-287908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:31:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F1F540623
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEA633019926
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60420357D0E;
	Thu, 14 May 2026 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WMsmFB6o"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD53A221F39
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778754683; cv=none; b=UmOGAwGJ2c2wizTaTVoUTJkfp/eEEz0br+A3jc6G0wDHtPI/8ibnfBqleRSYSH5RzipDN13lIpuMUpLRK80yj8rvAN9ebntKIN2DDVp8QgpbexwZBLrsvILPoUWUXJkB+b68/BxQqcz6gVFji0VaZWXSOVDUR7tg1h6kFqUvZX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778754683; c=relaxed/simple;
	bh=tUQXUqeeODt1JKFOoSl1r5fEIizO+lV/kuaxVYPZk2U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Wkxklx7avPwNfouo+6L031eZ6/t/usE+TpV7BeClaOmJvxgU4NDLvaZzMuxT0jXhjJXosFgyfNJ7H08D3lzZ3zfH/4fcZO5sT+/t6sW2msFjnfRQfq4UGSsHL8Cm80aKCK7hmz+Jn0OFLnzo4UM9ZW9qUmkxr16MewaGnt1X8QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WMsmFB6o; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AC8061A35B5;
	Thu, 14 May 2026 10:31:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 78C2C60495;
	Thu, 14 May 2026 10:31:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 635AB11AFA057;
	Thu, 14 May 2026 12:31:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778754670; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=i+ER/V7BqPBVcuw5u4kn1XH/+1ROjOBqJjLVfUa0dTo=;
	b=WMsmFB6oOYpXVZ7gDNQB/+wS3d5hKqjildZxAPiV2yRwqJnSphqGeu8MEHNVtzhalFE9nJ
	f0drDnkagj5ZSbDHTPzCbvGrjZ1rT1LG1WlrBGz3TAOcQNFtMnPXz3SsufYByUBXKPLQLC
	OzD2XR4Oe1Fc0ubk0PK18oPQLTnWHQxhS87+8JB1IeLZs2btUazhOgZqi25hY/fCVeuDp8
	kqLvWiXanhnnpZykOVioNl5uSSlkLEt2qMwOcBr5bLJD+I3n4kLyJPIWej4Cd38VqZ4cBS
	+iyedRwC6XCBAyCYILzsAwJfpXnbwS47IMVXnzSCj/ZYzhgFajKpNQHky9xECA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 May 2026 12:31:02 +0200
Message-Id: <DIIBWIZCWTLY.P8H6UNUWM22K@bootlin.com>
Subject: Re: [RFC PATCH net-next 0/3] net: macb: candidate fixes for silent
 TX stall on BCM2712/RP1
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rpi-kernel@lists.infradead.org>
To: "Lukasz Raczylo" <lukasz@raczylo.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <cover.1777064117.git.lukasz@raczylo.com>
In-Reply-To: <cover.1777064117.git.lukasz@raczylo.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: C0F1F540623
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287908-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:url,bootlin.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello Lukasz,

On Sat Apr 25, 2026 at 12:38 AM CEST, Lukasz Raczylo wrote:
> This series proposes three candidate fixes for the silent TX stall
> observed on Raspberry Pi 5 (BCM2712 SoC, Cadence GEM via RP1 PCIe
> south bridge).  The bug has been reported, with reproducers, at:

I've taken over the MACB driver maintenance following Clandiu & Nicolas'
work. I have read with curiosity your series and links attached
(though I skimmed over parts because there's been a lot of discussion).

Have you moved forward since your initial post? I've seen your
still-working-on-it message from May 8th on the rpi kernel PR. I have a
few remarks and/or questions:

 - You still think the two fix patches solve it? Any clearer picture of
   which of the two patches inbetween [1/3] or[2/3] fixes it? Does
   [3/3] ever trigger on your targets?

 - Can you clarify the exact symptoms? I've seen a few contradictory
   facts. Two I remember:

    - You say here it is a Tx stall but I've seen messages in the linked
      threads that say explicitely broken Tx & Rx.
      https://github.com/cilium/cilium/issues/43198#issue-3706713821

    - You say here link down/up fixes it, but there is a comment that
      says they unload/reload the module (rtheobald). They don't say
      explicitely that link down/up doesn't work for them though, but
      someone before in the thread recommended link down/up. Another
      one says "Only power cycle recovers the node" (lexfrei).

    - Also, some messages point out disabling TSO / SG / EEE helped it.
      Any comment on that? It would help point fingers.

    - Some comments are about DT props missing. Is that lead dead now?

 - I've seen no mention of the bug having been reproduced on upstream
   kernel (?). What does the rpi kernel bring to the table that makes
   everyone use it?

 - Anything was found to increase the reproducibility of the bug? If it
   was then a bisect could be made possible, as I've seen mentions that
   it didn't appear on some older kernels.

Now about the patches:

> Reading the current driver we identified three plausible races
> between driver and hardware, each of which could independently
> produce the observed behaviour.  We did not determine which is the
> actual root cause -- that likely requires either BCM2712/RP1
> documentation we do not have, or dynamic tracing of the driver
> during an in-situ stall.  The series therefore attempts to close
> all three, with each commit message stating which specific race
> that patch is targeting.
>
>   Patch 1/3 -- flush PCIe posted write after TSTART doorbell.
>   Writes to NCR are posted PCIe writes and may not reach the MAC
>   before the driver returns.  If the TSTART doorbell is lost, no
>   TX starts, no TCOMP arrives, and the ring goes quiescent.  A
>   read-back of NCR after the write is a standard read-after-write
>   PCIe flush.

 - Makes sense, but only on MACB mounted over PCI, which is not the
   majority.
 - IDK if we can do better than a readl(NCR) on all platforms.
 - I am surprised it is the only writel() that needs to be flushed?

>   Patch 2/3 -- re-check ISR after IER re-enable in macb_tx_poll().
>   An existing comment in macb_tx_poll() notes that completions
>   raised while TCOMP is masked do not re-fire when IER is
>   re-enabled, and mitigates the window with macb_tx_complete_pending(),
>   which inspects driver-visible ring state only (after rmb()).  On
>   PCIe-attached parts the descriptor DMA write that sets TX_USED
>   can remain in flight when that check runs; the rmb() orders CPU
>   writes but does not retire peripheral DMA.  Reading ISR directly
>   after IER re-enable addresses this in two ways: (a) the MMIO read
>   is an architected PCIe read barrier for prior DMA writes, so a
>   subsequent macb_tx_complete_pending() sees up-to-date TX_USED
>   state; (b) it directly observes a pending TCOMP bit if the
>   hardware has one set.  Either signal reschedules NAPI.

This will not fly because ISR might be read-to-clear.
See macb_queue_isr_clear() and how it is used. So we cannot re-read ISR
safely on those platforms.

>   Patch 3/3 -- TX stall watchdog.  Defence-in-depth.  If patches
>   1 and 2 close the races we identified, this patch performs a
>   single spin_lock_irqsave/unlock and a branch per queue per
>   second with no other effect.  If a further race remains that we
>   have not identified, it invokes the driver's own existing
>   macb_tx_restart(), which already verifies that TBQP is behind
>   tx_head before re-asserting TSTART.  We include this patch
>   because we have empirically observed multi-minute stalls on this
>   hardware; we are willing to drop it if the preference is for
>   1 and 2 to stand alone.

Good idea, but that is what ndo_tx_timeout() is meant for no? It is a
mechanism that is not specific to our HW so that should be implemented
at the subsystem level, and it looks like it already is. :-)

We are aware of a few software scheduling races that we plan on fixing.
If your above patches ended up not fixing the issue, you could look
into those.
https://lore.kernel.org/netdev/DHIT9TPJQJ46.21A89R5UAFXVH@bootlin.com/

Thanks!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


