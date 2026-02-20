Return-Path: <netdev+bounces-259788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAWOEG70mGkaOgMAu9opvQ
	(envelope-from <netdev+bounces-259788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 00:55:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E71F216B749
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 00:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBF953001584
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 23:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BFE2EA169;
	Fri, 20 Feb 2026 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RP7eOj97"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119CE29D297
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 23:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771631701; cv=none; b=Qufs9qbh/6XH/ap0AQg5s+y6q+Jan1u+ygbosg31uhjV63++vPXeEx3rUt/J2+JvJliyuxfZUYGDC/AhWkX11RLfKSkh490EhPIk5hnySTlQCXtNHj1tAGhD0m+bjX8U5QG3bm91gOZB/FetyA0zTp19kB/EhRKYIyYTsZjpXUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771631701; c=relaxed/simple;
	bh=CdjUUIPs+TJXs9Au9FAXVXksVMVP6VqPCvB2dRW7i0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTye46JoBnMm9XL32asrfyNHy5vO1gWFJjYlRytSkAb2RXb3+MmM+GWy4Qc4k0IF0pSAfcMvkiiyQgYpyCpRyNIBJR1qHiPGZAOzugy40ezEp+YGsKB39I8len0wIwYrP+h2rUVgxuVOtGZ9Sw2iZ+4RceyzujIbXD1y0RXakzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RP7eOj97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713FCC116C6;
	Fri, 20 Feb 2026 23:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771631700;
	bh=CdjUUIPs+TJXs9Au9FAXVXksVMVP6VqPCvB2dRW7i0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RP7eOj97c8J4Q4STN154LhQM/ebnpgiSPfPtCiPsY2qhyFI+TWXrorh/0r7M+LsoV
	 vItBMDo7sJxGFzwa9LMiHISP8qvjl/mQdzAVcsF/X+9lY/rdN1mVtCqbLwzeJBoLMu
	 27I8xnPS3z7hSk8u74xF0TYH+qUg/AGxMl8sGE2wR6yJAyP4g4pxoCdEB8GsOcdXDQ
	 GyRTl+60obL9m8TcoRAwckpd4KSzXoNSGSr63Puic9wUK/ADWQnpW3bPhgU2khF4LB
	 kgSVTmQn3LIH07ftDyy+QKIppbDRcjtSpH4mASHdPmc6cAz+UpZs1g1i7R/LbGgWfV
	 D5aZYvKdowTxQ==
Date: Fri, 20 Feb 2026 15:54:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ingo Rohloff <ingo.rohloff@lauterbach.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 netdev@vger.kernel.org
Subject: Re: [PATCH] net: macb: fix race condition in TX queue
 initialization
Message-ID: <20260220155459.572e04a5@kernel.org>
In-Reply-To: <20260220152723.2d98c022@ingpc2.intern.lauterbach.com>
References: <20260218104325.28381-1-ingo.rohloff@lauterbach.com>
	<20260219144338.50e8bb73@kernel.org>
	<20260220152723.2d98c022@ingpc2.intern.lauterbach.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259788-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E71F216B749
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 15:27:23 +0100 Ingo Rohloff wrote:
> Subject: Re: [PATCH] net: macb: fix race condition in TX queue initialization
> Date: Thu, 19 Feb 2026 14:43:38 -0800
> 
> > > On Wed, 18 Feb 2026 11:43:25 +0100 Ingo Rohloff wrote:
> > > Commit bf9cf80cab81e ("net: macb: Fix tx/rx malfunction after phy link
> > > down and up") initializes queue->tx_head and queue->tx_tail to zero
> > > without holding queue->tx_ptr_lock.  
> 
> > That commit does look quite buggy, but I'm not sure whether the fix is
> > effective.  
> 
> Yes: I myself think that what I posted is definitely not enough.
> 
> I am not sure if I can come up with a real fix though:
> 
> Looking at ethernet drivers which use both:
>    * phylink_mac_ops->mac_link_down()
>    * net_device_ops->ndo_open()
> the most commonly used strategy seems to be:
> * When net_device_ops->ndo_open() is called:
>   - Setup ring buffers
>   - Call netif_tx_start_all_queues()
> * DO NOT call netif_tx_stop_all_queues() or similar when
>   phylink_mac_ops->mac_link_down() is called
> * DO NOT re-initialize ring buffers when
>   phylink_mac_ops->mac_link_up() is called.
> 
> So: Leave the ring buffers alone in
> phylink_mac_ops->mac_link_up() and phylink_mac_ops->mac_link_down().
> 
> The driver in macb_main.c seems to be one of the exceptions
> which calls netif_tx_stop_all_queues() in macb_mac_link_down() and
> netif_tx_wake_all_queues() in macb_mac_link_up().
> 
> My problem is:
> I don't understand why the OTHER drivers don't do it like this.
> What's the expectation of the hardware, if I fill the TX ring buffer
> with TX skb's even if the link is down?
> Is the hardware supposed to throw all these TX entries away
> and still produce completion or error(?) interrupts?
> Or is this handled, because drivers which use "phylink",
> automatically call netif_carrier_on() and netif_carrier_off() via
> "phylink" when the link changes up/down state?
> 
> 
> If you know the expected behavior:
> Could you teach me what's expected ?
> 
> If I understand the expected behavior I might be able to come up
> with an idea what the macb driver is supposed to do :-)

Before I tell you what I think - a disclosure that I have limited
experience with embedded devices, so take what I say with a grain
of salt. I mostly work on integrated NIC designs, day to day.

Normally the MAC has a "flush" bit of some sort which makes it consume
all the packets sent to the device / placed on the xmit queues.
With this mode enabled the device completes the transfers to the host
as if the send was successful, but the packets go nowhere.
This is necessary because we don't want to suddenly send a burst of
potentially extremely old packets when the link finally comes back up.

The driver is not expected to stop the Tx rings when link goes down.

I suppose macb either lacks such flush functionality or it's broken?
That'd explain why it tries to reset the ring manually.

Note that for integrated NICs the link is usually managed by FW running
in the NIC, so you won't see the driver do anything in response to the
link down.

