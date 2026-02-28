Return-Path: <netdev+bounces-262112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OBgJQ/Romli5wQAu9opvQ
	(envelope-from <netdev+bounces-262112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 12:27:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1503B1C28D4
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 12:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E6C230265BA
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 11:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966EC438FF0;
	Sat, 28 Feb 2026 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="XBQDFS6f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j4WJeWxf"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ACF82899
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772278028; cv=none; b=qF5r/9BFsBrSmjkhMqK/y/e118yIkM+W1eZATscsmsw+VAHyuJsXfYYV3087ataeB7xUrnM0FRGiNjx8AeEWqBWgsF3aP26tBI4dDDExjxzq0UcRDsmxNpRkkJxaPH7oCNGSC7CnJBsNV7Ox91vwLg1N+YsS9RICcysBg1yAB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772278028; c=relaxed/simple;
	bh=VhDChWs/CVn5+ro5e/EzruXXxeOipLnM6ue2nb+WbDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZubjMo+bXyT2MZmtFkwP05dA84fScrwwi95y+jRBaZk2EONcMdpl4wQgckX5dcXdN8LupOp5gtesCrsSk1aL93c+syCgI0+ccrX7W2x8dsQoszEFAhOyzAfu2Tc7LbT2mBde5IBqrGR+T0KCvM52ENM4dwAJmEWudHt18j2/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=XBQDFS6f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j4WJeWxf; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 808F0EC0AD7;
	Sat, 28 Feb 2026 06:27:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 28 Feb 2026 06:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1772278025; x=
	1772364425; bh=XVXNAtlju5Fo8FzXkJGNDkl8zfdijgvpF14GD23Tctk=; b=X
	BQDFS6f3F5IW6j5m+8KPtQY9dQKJrPpLBL0ooaT2QSiqs6lvU6bvgCvea1b9xhpK
	Ghjkj0lzc/p7r/6R1H5XLHO3kdRmyaQ6WL3IdtcyVbJDr+TR3YP2m4hAQUSDRrh1
	rq0kRIt2BMr2qnQgDPBKgKGiB7mATFWurgP5N08rv39C2Xsq05Y++cbM9i/7j7XE
	/v7vTNbQD+CbHuTNzQaIGpAT4rHkg9PCzGyiqYHoZEv0zkBqx4sgw6P9HKD2QOW9
	d7MiVQA4zCDVBVR2PHMY3G3jkfpsucFhs9zOssVZJPRSRC3JJEGkFljyHKjxDRQ/
	mE+LtbtXwp8V/XgwH36vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772278025; x=1772364425; bh=XVXNAtlju5Fo8FzXkJGNDkl8zfdijgvpF14
	GD23Tctk=; b=j4WJeWxfNuqI0fb6EeulufnFEthIVPKkW3ww2sC1xGVD8xyRMB/
	n6Q7DKnRLdnFtJzl5XgAAkkfAcM9VKI5VgP09ewlNfJ0biFDqYfRAgqJPO5VP/jf
	c2F3xiZzANT8Px3+r3sBhkc4gJHV8w+IWmxL4EeCk9ATpBW/dovmm4LzaNDTl3Ae
	LCCqsFLa1I7erKY4pb0P2uX3jfw9Tn1nIwdb/bC8hp8i5mhqXoWTV8p2UyhbQTEX
	gJAUBLWA0/Q1j3TLJihbsmc9kPKOxbUIhEVg6IG2AtBaqsNKbF6VbFmoKNtUy1Pd
	lZP5SyaQPNf8iSYeUikWHWo7C5Z54F4bpug==
X-ME-Sender: <xms:CdGiaUWhp3Pci48yltHD8-1fN1_8Vg1rGh6kRQfAHXRz7L0qSneFwQ>
    <xme:CdGiaXqjSOkNhkQS3efttnh0uNyM3efa92NVubdE_D3qkDMfcHZ3zOTJvyTsoelIl
    sEpXwE58bz5naZIEsd_DsO7UXQlQCkdn63cma2jWHT4Ctqkvmw6DkY>
X-ME-Received: <xmr:CdGiaen00aokpuTG46jPyjr5oY3PXW04YgzVO2PndXyXcuaTm-vsS_IWhB4n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvhedujeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgefhffdtvedugfekffejvdeiieelhfetffeffefghedvvefhjeejvdek
    feelgefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdr
    nhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrhgrthhiuhesnhhvihgu
    ihgrrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphht
    thhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrg
    iivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepughtrghtuhhlvggrsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:CdGiaf26I6e5s-9isx9zfkXZEnDyJMJeRLZbYFeBn-7I3lKkWsSxvA>
    <xmx:CdGiaTR6sDPid0ZedJcBG4Cg--REfpUREBbjQQ70M4PDkuOpibrCWw>
    <xmx:CdGiaQy-ljBb4Fn17-4Ryeg83xZk3v-mXiiCZW7ZlfZn3iHesq1ybA>
    <xmx:CdGiabADwTwXekBYHg5HCTiATZg3fXxv4ZpqR0ru3boG-tPSotIJxA>
    <xmx:CdGiacCxmzPqtZ5X5I5zYn7HJvsSr5uK_HLxGjk9MKoaWcQ8yyDztymz>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Feb 2026 06:27:04 -0500 (EST)
Date: Sat, 28 Feb 2026 12:27:03 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cosmin Ratiu <cratiu@nvidia.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next v2 3/3] macsec: Support VLAN-filtering lower
 devices
Message-ID: <aaLRB-KAUYbFVPao@krikkit>
References: <20260227090227.1552512-1-cratiu@nvidia.com>
 <20260227090227.1552512-4-cratiu@nvidia.com>
 <20260227065908.6dda892c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260227065908.6dda892c@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	TAGGED_FROM(0.00)[bounces-262112-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1503B1C28D4
X-Rspamd-Action: no action

2026-02-27, 06:59:08 -0800, Jakub Kicinski wrote:
> On Fri, 27 Feb 2026 11:02:27 +0200 Cosmin Ratiu wrote:
> > VLAN-filtering is done through two netdev features
> > (NETIF_F_HW_VLAN_CTAG_FILTER and NETIF_F_HW_VLAN_STAG_FILTER) and two
> > netdev ops (ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid).
> > 
> > Implement these and advertise the features if the lower device supports
> > them. This allows proper VLAN filtering to work on top of macsec
> > devices, when the lower device is capable of VLAN filtering.
> > As a concrete example, having this chain of interfaces now works:
> > vlan_filtering_capable_dev(1) -> macsec_dev(2) -> macsec_vlan_dev(3)
> > 
> > Before commit [1] this used to accidentally work because the macsec

The first submission was for net-next, then Jakub asked to make this a
fix for net:
https://lore.kernel.org/netdev/20260106171027.57a7757f@kernel.org/
which makes sense.

So "v1"
https://lore.kernel.org/netdev/20260107104723.2750725-1-cratiu@nvidia.com
was for net, and we discussed making it a net-next patch because the
changes were looking invasive. But in the end by using
vlan_{get,drop}_rx_*_filter_info it's a pretty simple patch, so I
think this should still be for net?


[...]
> > @@ -2616,7 +2616,17 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
> >  	if (!ops)
> >  		return -EOPNOTSUPP;
> >
> > +	/* Remove VLAN filters when disabling offload. */
> > +	if (offload == MACSEC_OFFLOAD_OFF) {
> > +		vlan_drop_rx_ctag_filter_info(dev);
> > +		vlan_drop_rx_stag_filter_info(dev);
> > +	}
> >  	macsec->offload = offload;
> > +	/* Add VLAN filters when enabling offload. */
> > +	if (prev_offload == MACSEC_OFFLOAD_OFF) {
> > +		vlan_get_rx_ctag_filter_info(dev);
> > +		vlan_get_rx_stag_filter_info(dev);
> > +	}
> >
> >  	ctx.secy = &macsec->secy;
> >  	ret = offload == MACSEC_OFFLOAD_OFF ? macsec_offload(ops->mdo_del_secy, &ctx)
> > @@ -2633,6 +2643,11 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
> >
> >  	if (ret) {
> >  		macsec->offload = prev_offload;
> > +		if (offload == MACSEC_OFFLOAD_OFF && prev_offload == MACSEC_OFFLOAD_MAC) {
> > +			vlan_get_rx_ctag_filter_info(dev);
> > +			vlan_get_rx_stag_filter_info(dev);
> > +		}
> > +
> >  		return ret;
> >  	}
> 
> Does the error path properly restore VLAN filter state when enabling offload
> fails? When prev_offload is MACSEC_OFFLOAD_OFF and the code calls
> vlan_get_rx_ctag_filter_info(dev) and vlan_get_rx_stag_filter_info(dev) to
> push VLAN filters to the lower device, but then macsec_offload() fails and
> returns an error:
[...]

Looks like it. Since the vlan_*_filter_info ops can't fail, just move
them until after we've called mdo_*_secy, and macsec_update_offload
can't fail anymore?

-- 
Sabrina

