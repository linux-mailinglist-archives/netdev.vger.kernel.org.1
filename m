Return-Path: <netdev+bounces-284139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIj+IGFA+Wkr7QIAu9opvQ
	(envelope-from <netdev+bounces-284139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:57:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9F84C5965
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D8C730185AD
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 00:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D716830BB91;
	Tue,  5 May 2026 00:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DccwTTyX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F9630146C
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 00:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777942621; cv=none; b=c58b/91/K6bMbKa986D08tRl9489amXr8aHMkOsY2aIGCMkpT569ddbdkWIfT0GrwD5SKyVogw9q9Y6ivol+wDNt1C8a8Dd6BL+GcZD5UNPiX3GcYj1IugjCmRHn3VN/MowIGByWJNhQkQtiev8N389hEkrWW3nSe7WKLpRq7cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777942621; c=relaxed/simple;
	bh=GunvcoKK1vnxkYVSR1GjMiJ6TZyG85mcvfb8XiJ1xvA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZ0HtCfO0pz4tzFjZFyc2ttQEVTDG/pmPGogkp28B9tDXsLIRLHDUldNUX4/Y9x+WI/VQPJ/ZO75RrfCIVzcUphP6dxiZ1HFHDhHzJGVT2k/Sm9h2+0MWxa7t5sUrCrgcVth4dLLkGs8RQ/LDiLz4gysOcj7J67jMTtYC0pYHnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DccwTTyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198B4C2BCB8;
	Tue,  5 May 2026 00:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777942621;
	bh=GunvcoKK1vnxkYVSR1GjMiJ6TZyG85mcvfb8XiJ1xvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DccwTTyX4pkOSufPSjf1PeSfyVY7HISulvN/lebzjX2SMNbVm0d33RIh6AFjKMu3G
	 wBNuS436gmTOWV/lMvsMQp8WsSk4Cm765ZsIbpb6ttadQOQdSRtC4IC9nm0l+UtTwq
	 Hsm/me/iOP7dwhkiObjvcBrTn1ELRZa7SUpRu4Wb7+eRSZ9V7WzaMAFhrK+4DPEErx
	 J36avYsAAMlQyZtrIOxLOgKMieoS8mfQn3Q4zYyscW+GcQ/jh/t3rI67OGTjTn/mwt
	 a5Ubn86EmQPbflvJesPPkMY69xTE9gfloZFGSovtraVH6uIjz4zuJsJUxU9W04P3lE
	 1cXu74fes7ryQ==
Date: Mon, 4 May 2026 17:57:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 petrm@nvidia.com
Subject: Re: [PATCH net-next 2/3] macvlan: Do not transfer operational state
 when protodown is enabled
Message-ID: <20260504175700.44619b2f@kernel.org>
In-Reply-To: <20260503181934.GB269092@shredder>
References: <20260429124624.835335-1-idosch@nvidia.com>
	<20260429124624.835335-3-idosch@nvidia.com>
	<20260501180948.1f68c43f@kernel.org>
	<20260503181934.GB269092@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2C9F84C5965
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284139-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Sun, 3 May 2026 21:19:34 +0300 Ido Schimmel wrote:
> On Fri, May 01, 2026 at 06:09:48PM -0700, Jakub Kicinski wrote:
> > On Wed, 29 Apr 2026 15:46:23 +0300 Ido Schimmel wrote: =20
> > > -		list_for_each_entry(vlan, &port->vlans, list)
> > > +		list_for_each_entry(vlan, &port->vlans, list) {
> > > +			if (vlan->dev->proto_down)
> > > +				continue;
> > >  			netif_stacked_transfer_operstate(vlan->lowerdev,
> > >  							 vlan->dev); =20
> >=20
> > Doesn't feel particularly macvlan-specific?
> > Other simple upper devs don't support protodown
> > but when they do presumably they'll have to add
> > this exact condition, too, so why not add it in
> > netif_stacked_transfer_operstate()? =20
>=20
> It seemed more consistent with patch #1 that invokes
> netif_stacked_transfer_operstate() from the driver. I can move it to the
> core in v2 [1] assuming we go for a solution that doesn't involve the
> driver at all.
>=20
> [1] https://github.com/idosch/linux/commit/1d86acbf0affc9004fad79820bbb21=
72aeb305a4.patch

=F0=9F=91=8D

