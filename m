Return-Path: <netdev+bounces-281695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLn9EjJn8GkITAEAu9opvQ
	(envelope-from <netdev+bounces-281695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:52:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CABEC47F4D5
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B56EF32855BA
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA8A3D47C2;
	Tue, 28 Apr 2026 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZgUC3+46"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DECB30DD11;
	Tue, 28 Apr 2026 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777361610; cv=none; b=uToGoN4e1UMwCoDM81QKvtm1i8abAoUHYVO41VBQwLpZ5UY6dr0aWxm+oXXUgVf6H4UasOq5D4srdvyatrW/VY7SkbSm4VkNp+eeh/GqJorpJsqecQpQlGvoj4wLw3abtb4bizjYf752d69xJY2rYHu8/T8K9osmLYbNEuStkrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777361610; c=relaxed/simple;
	bh=x1HK04n83Ri/VIOK/knZMOm7u2xbxr5aRjP8h9e6Moc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrgS5f0PMQ/qKcGuV3oDm+vRbc8g6YQYlwYJqFTXfTCF/iHjFAVnzC1NpfVU7f6RkY5hVUBBTUAVwwP/rCid9l5Wmjiw7dCzF8QXwLHIbic98eMh2aFx9D0jThotfGHqFzN1tDkj73wrr55kHYUanmPdHgBOy6YF0qLtBWlQ4vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZgUC3+46; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777361610; x=1808897610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x1HK04n83Ri/VIOK/knZMOm7u2xbxr5aRjP8h9e6Moc=;
  b=ZgUC3+46JbAnQ27EufyD8rIGIfmean4ztzPORFBVSfavqpDBbU0bB3Y7
   bl1cPQY9llGnHjEh07vniUlkLxFOxUU1o9FuhfDRPyS/EB2SrVz2+ugyq
   0wuche58xJ4hHaVKi91joojnlhLhkmjpcXPEBbNCDcoR2jo9eDKLu9Put
   DhciCXDrNLVAmRy0uN3eVQZjKTjVAH5/AqBwl1wCJu1mU8F6G5Z7O4uFE
   ku4O/aK4A7Gb3qKyE7VTXlZtVqrKxzBE6yGLuaSVe839UTUVPxZ3DjrZM
   My41z/Pr5mX4Qo0lS/de9/42l6w8PEVCK9sqKi2B65CI38wSlMXDjcTDJ
   Q==;
X-CSE-ConnectionGUID: ZkKvm+/ZR8Crl/AdbyW+8Q==
X-CSE-MsgGUID: pKCnbk74Q9esWV/qUIaVnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78453741"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78453741"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:33:29 -0700
X-CSE-ConnectionGUID: U58WZYodRz2zAQsWlC8R0g==
X-CSE-MsgGUID: ha4MF1xxQ3eMn79BPVKDUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="229311531"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 28 Apr 2026 00:33:26 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 1380195; Tue, 28 Apr 2026 09:33:25 +0200 (CEST)
Date: Tue, 28 Apr 2026 09:33:25 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Benjamin Berman <benjamin.s.berman@gmail.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] thunderbolt: drop start_poll guard in
 tb_ring_poll_complete()
Message-ID: <20260428073325.GO557136@black.igk.intel.com>
References: <20260428015521.3454006-1-benjamin.s.berman@gmail.com>
 <20260428015521.3454006-2-benjamin.s.berman@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428015521.3454006-2-benjamin.s.berman@gmail.com>
X-Rspamd-Queue-Id: CABEC47F4D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281695-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,anthropic.com:email,black.igk.intel.com:mid,intel.com:dkim]

Hi,

On Mon, Apr 27, 2026 at 06:55:20PM -0700, Benjamin Berman wrote:
> Under concurrent load on a single NHI with several rings simultaneously
> in NAPI poll (e.g. a Maple Ridge TB4 transit forwarding tbnet traffic
> between two peers), one ring's interrupt enable bit in
> REG_RING_INTERRUPT_BASE can stay cleared.  MSI-X stops for that ring,
> NAPI is never rescheduled, but carrier is reported up and no driver
> event fires.  The ring stays masked until thunderbolt_net is reloaded.
> 
> tb_ring_poll_complete() gated the unmask on @start_poll:
> 
> 	if (ring->start_poll)
> 		__ring_interrupt_mask(ring, false);
> 
> while the ISR path masks unconditionally via __ring_interrupt().  In a
> window where @start_poll is observed as NULL by the unmask path while
> the paired mask persists, the ring is left permanently masked.
> 
> Gate on @running instead and add an ioread32() barrier so the posted
> enable reaches the device before the spinlock is dropped.
> 
> On NHIs without QUIRK_AUTO_CLEAR_INT a second issue compounds the
> first: stale pending status in REG_RING_NOTIFY_BASE can prevent the
> hardware from re-arming its MSI-X generator when the ring is
> re-enabled.  Clear the ring's bit in REG_RING_INT_CLEAR before setting
> the enable bit, mirroring what ring_msix() already does at ISR entry.
> 
> Verified on a Maple Ridge 4C transit and two TB3 Titan Ridge endpoints
> running NCCL all-reduce over tb-lo: pre-patch the chain wedges in
> under 1 GB; post-patch a 192 GB run (3000 iterations of a 64 MiB
> all-reduce) completes with mask/unmask counters balanced.

I think this makes sense.

I do have few comments about the code itself. See below.

> Generated-by: Claude Opus 4.7 <claude-opus-4-7@anthropic.com>
> Tested-by: Benjamin Berman <benjamin.s.berman@gmail.com>
> Signed-off-by: Benjamin Berman <benjamin.s.berman@gmail.com>
> ---
>  drivers/thunderbolt/nhi.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index 2bb2e79ca..bba45ec36 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -389,10 +389,24 @@ static void __ring_interrupt_mask(struct tb_ring *ring, bool mask)
>  	u32 val;
>  
>  	val = ioread32(ring->nhi->iobase + reg);
> -	if (mask)
> +	if (mask) {
>  		val &= ~BIT(bit);
> -	else
> +	} else {
> +		if (!(ring->nhi->quirks & QUIRK_AUTO_CLEAR_INT)) {
> +			int cbit = ring_interrupt_index(ring) & 31;
> +
> +			if (ring->is_tx)
> +				iowrite32(BIT(cbit),
> +					  ring->nhi->iobase +
> +					  REG_RING_INT_CLEAR);
> +			else
> +				iowrite32(BIT(cbit),
> +					  ring->nhi->iobase +
> +					  REG_RING_INT_CLEAR +
> +					  4 * (ring->nhi->hop_count / 32));
> +		}

This should be a separate helper function.

ring_interrupt_clear() or so. We actually have function with that name but
it clears with bit too big hammer for this. So I suggest to rework it with
the above code and user here and also in nhi_disable_interrupts().

>  		val |= BIT(bit);
> +	}
>  	iowrite32(val, ring->nhi->iobase + reg);
>  }
>  
> @@ -423,8 +437,10 @@ void tb_ring_poll_complete(struct tb_ring *ring)
>  
>  	spin_lock_irqsave(&ring->nhi->lock, flags);
>  	spin_lock(&ring->lock);
> -	if (ring->start_poll)
> +	if (ring->running) {
>  		__ring_interrupt_mask(ring, false);
> +		(void)ioread32(ring->nhi->iobase + REG_RING_INTERRUPT_BASE);

Drop the (void) cast but add a comment that this is for posted write.

> +	}
>  	spin_unlock(&ring->lock);
>  	spin_unlock_irqrestore(&ring->nhi->lock, flags);
>  }
> -- 
> 2.43.0

