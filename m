Return-Path: <netdev+bounces-258345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id i+jnF3vQjGk1tgAAu9opvQ
	(envelope-from <netdev+bounces-258345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:54:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E9096126F6C
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 213F330058C5
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6995A352F9A;
	Wed, 11 Feb 2026 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIn44EGP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BAC352C5F;
	Wed, 11 Feb 2026 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770836086; cv=none; b=R2DGRganWbFEAqn8E6PpJMs/4otiVZbzHBkzWrdg68g9o7LrotFe2xsz3ZSQVtE122ThPzqsA5MXAM7iMQ/HfvOhW3/Wy0JX36KxeaQzLrCvCOyvNSBbvKGyGovT4i2VL15TD4K3S0diR1lVS8gHUGgDPtsXzNC4xwHszwPBz5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770836086; c=relaxed/simple;
	bh=bwCaj3+4l+nv+6bgxf4XJU2CWB0++YRNTmcoh/FySrs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4rWDEQpUBI3ncRNYHEdhybaauMSjF9IqhjmXBK+2pvNFFG6T32jcPcXW8P0MG8lmyVJnkS/24k2G0VHKGEao3K7mCNf3ySvk0hFqcVz9C5ljYxJnt8n5Oy7xCHCjpYfVZn8bV71MeVfnsz/TXGKDjdXP2BSwGHk6qdJhwpym8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIn44EGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DC4C4CEF7;
	Wed, 11 Feb 2026 18:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770836085;
	bh=bwCaj3+4l+nv+6bgxf4XJU2CWB0++YRNTmcoh/FySrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UIn44EGPl5OkdSl5yJAa36h95nEdNJ9pFUNFqV7XgaMk1bozEbHB0Vm45KmR9mDah
	 mRFxB4QnhcHQNDhxGzDQkgkDSmzSeWAI4qVYv+HseRO4YUfbr6nYboHJPx8/9PpgJK
	 HDp9bXCBkPs7ilXbgQon3x/FhE/GdAV181ueeJpcnhQVdRRWpYc2ut20jykDIjNp3n
	 yLkPdGKKdL+ZFCRWhB29POHVEd/KbUYxV/TCzg3or+D7ngPZvR8+yR5MSs5Vus8rc3
	 6ys9zdJJB2w0tvC9ZiDbQUJrlrtHBPQX4Kq2yoS8afA5aQBRMqR33Jbp2vPo4Wsaiw
	 XLtYNdEWKFWtA==
Date: Wed, 11 Feb 2026 10:54:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Willem de Bruijn <willemb@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx
 timestamp directly from interrupt for i210
Message-ID: <20260211105444.1e370abd@kernel.org>
In-Reply-To: <87qzqr5vos.fsf@jax.kurt.home>
References: <20260205164341.pJvni8kA@linutronix.de>
	<76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
	<willemdebruijn.kernel.459b2672b1e7@gmail.com>
	<601f0c4b-52d8-4b60-96bf-f2d65f8073d8@linux.dev>
	<willemdebruijn.kernel.bbdefedfb87e@gmail.com>
	<20260209090621.GiZqTiMJ@linutronix.de>
	<8e762437-69f9-40d7-bb75-3a45bef1d5d6@linux.dev>
	<20260209114836.GPU-vnnh@linutronix.de>
	<78e2af2c-40e6-43f1-9471-42f350e69389@linux.dev>
	<willemdebruijn.kernel.2e6213a98660b@gmail.com>
	<20260210121207.9kLHroS0@linutronix.de>
	<willemdebruijn.kernel.cceee43f5b9b@gmail.com>
	<87qzqr5vos.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258345-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linutronix.de,linux.dev,google.com,redhat.com,davemloft.net,intel.com,molgen.mpg.de,vger.kernel.org,lunn.ch,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9096126F6C
X-Rspamd-Action: no action

On Wed, 11 Feb 2026 13:08:51 +0100 Kurt Kanzenbach wrote:
> On Tue Feb 10 2026, Willem de Bruijn wrote:
> > The core issue seems to be that the ptp_tx_work is not scheduled
> > quickly enough. I wonder if that is the issue to be fixed. When/why
> > is this too slow?  
> 
> The igb driver uses schedule_work() for the Tx timestamp retrieval. That
> means the ptp_tx_work item is queued to the kernel-global workqueue. In
> case there is load on the system, the kworker which handles ptp_tx_work
> might be delayed too much, which results in ptp4l timeouts.
> 
> Easy solution would be to tune the priority/affinity of the
> kworker. However, we have to figure which kworker it is. Furthermore,
> this kworker might handle other things as well, which are not related to
> igb timestamping at all. Therefore, tuning the priority of the kworker
> is not practical.
> 
> Moving the timestamping in IRQ looked like a good solution, because the
> device already signals that the Tx timestamp is available now. No need
> to schedule any worker/work at all. So, it'd be very nice if
> skb_tstamp_tx() could be called from IRQ context. BTW other drivers like
> igc call this function in IRQ context as well.
> 
> Alternative solution for igb is to move from schedule_work() to PTP AUX
> worker. That is a dedicated PTP worker thread called ptpX, which could
> handle the timestamping. This can be easily tuned with taskset and
> chrt. However, there's one difference to the kworker approach: The
> kworker always runs on the same CPU, where the IRQ triggered, the AUX
> worker not necessarily. This means, Miroslav needs to be aware of this
> and tune the AUX worker for his NTP use cases.
> 
> I hope, that makes the motivation for this patch and discussion clear.

Are you concerned about the latency of delivering the TS to the user
space app / socket? Or purely reading the TS out of the HW fifo to make
space for another packet to be timestamped?

