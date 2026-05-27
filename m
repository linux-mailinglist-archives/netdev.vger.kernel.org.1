Return-Path: <netdev+bounces-292203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI8iDqOxFmokogcAu9opvQ
	(envelope-from <netdev+bounces-292203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:56:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6995E1688
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F11D3014B0B
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EAF3E3145;
	Wed, 27 May 2026 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCzE5UrS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E723976AD;
	Wed, 27 May 2026 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872116; cv=none; b=pev75RuMI4HgxWQxmL9tdK1vY95rxKj8eiMaxP9WB5DdVfQm25bENN41YzpRGU5HI1gEb563Q/wl/sNvLtYDiBZQnmuDx8cgRgEh+ut9ZdgvxR69fVpKNBeK0pVSMDlWQsyuoHHTGAypQsLmBmMWWKWF/1+KX2yfi89rbXOmU7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872116; c=relaxed/simple;
	bh=Bsl5GPz6DzzO6L/sTRo6b/OLxF3ebkMqr7ka0i4JyGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbqfWEQrNUE24PjPjx2SGzd87gBzeakYH/puiPYlT7h/sJuPHduYHIJZJ8niR7iQM+wJrVyNOglI2vst+/rtE9JaQYCWWzPq5Sqb9rHq4EC6hZSh3yFFGeCchIu8yGF7Inv6Pu0mMN7OVyqZmmnrGhB4Zwt2bGyKLCa+cdcPY9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCzE5UrS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF941F000E9;
	Wed, 27 May 2026 08:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779872114;
	bh=UEDxqNXJ4UEjblIvQoSSL/wcWvyHJ4OXwS35a/CCfUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QCzE5UrSjFjQTXU+opr+xyd1FelMofgA1s99UVxSVflKaV5OarwTUQGn4GoEFicTo
	 QVFz7DekWrJpnwWg7AWEbjVtv4cElgxkTCT0FnYhE3yWyPYlSScUtNOwnLqzQ0yyJ8
	 ckOlMcf54XZAhpGARxZfEpMG4Iqn+6ObaDezOjhNVFsib6C9FgO57yxdqYl3LW+zZk
	 3hqxpSDBcS1DTv2T0YYYUv3qh/RHIj1KIkG3zMxEJnLIv79Ube4eL9nQ0D8pkOGSkv
	 8qz9uPRepoTBfRLNacOwPZu1w3MgXdYEbNoWp3SrMAvMBooZGpbh1+wzZ9ArUVpDqT
	 SS8eLtfNsuVXQ==
Date: Wed, 27 May 2026 09:55:10 +0100
From: Simon Horman <horms@kernel.org>
To: Qing Ming <a0yami@mailbox.org>
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ovpn: avoid putting unrelated P2P peer on socket release
Message-ID: <20260527085510.GF2256768@horms.kernel.org>
References: <20260523081543.94507-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523081543.94507-1-a0yami@mailbox.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292203-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 3F6995E1688
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 04:15:43PM +0800, Qing Ming wrote:
> ovpn_peer_release_p2p() is called when an OVPN UDP socket is being
> destroyed. It checks the currently published P2P peer and releases it only
> if that peer still uses the socket being destroyed.
> 
> A peer replacement can publish a new peer before the old UDP socket is
> destroyed. When the old socket destruction path runs afterwards,
> ovpn_peer_release_p2p() observes the new peer through ovpn->peer. Since the
> new peer uses a different socket, the function takes the socket mismatch
> branch.
> 
> That branch still calls ovpn_peer_put(peer). At this point, however, peer
> is the currently published replacement peer, not the peer associated with
> the socket being destroyed. Dropping its reference can free it while
> ovpn->peer still points to it, leading to later use-after-free accesses
> from the peer and socket cleanup paths.
> 
> KASAN reports this as a slab-use-after-free on the kmalloc-1k ovpn_peer
> object. In the reproducer, the object is allocated from ovpn_peer_new() via
> ovpn_nl_peer_new_doit(), and freed through ovpn_peer_release_rcu() from RCU
> callback processing. Observed access sites include ovpn_peer_remove(),
> ovpn_socket_release(), ovpn_nl_peer_del_notify(), and unlock_ovpn().
> 
> Fix this by returning from the socket mismatch branch without putting the
> peer.
> 
> Fixes: f6226ae7a0cd ("ovpn: introduce the ovpn_socket object")
> Signed-off-by: Qing Ming <a0yami@mailbox.org>

It is probably not necessary to resubmit because of this,
but for future reference bug fixes for code present in the net tree
should be targeted at that tree like this:

	Subject: [PATCH net] ...

You can see more about the Networking development workflow here:
https://docs.kernel.org/process/maintainer-netdev.html


FTR, there is an AI-generated review of this patchset available on
sashiko.dev. I do not believe it should effect the progress of this patch.
But, rather, be considered in the context of possible follow-up.


Reviewed-by: Simon Horman <horms@kernel.org>

