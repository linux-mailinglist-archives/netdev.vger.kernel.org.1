Return-Path: <netdev+bounces-282160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIHUD9pT8WkugAEAu9opvQ
	(envelope-from <netdev+bounces-282160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:42:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C77BA48DCE8
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87E343017DAD
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C141A2253EE;
	Wed, 29 Apr 2026 00:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wJBWiAC/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D605F1E9B3D;
	Wed, 29 Apr 2026 00:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777423308; cv=none; b=MdxVlPo7SUYddN3Fgq9d76tY0Ekm0euZCKbe42dQdNKdUU630+kl7axXyFv1s2vuHdZixZ2R+Y6QOeZ8xpFIXFuoaJJgif0ntjylwWlKqdJlN3BtCI+Z51fQlMhXr7ZdJQ6SbA/Eqd7b9XHAy6zrntwqVwpD9p7Pm0nBwTNVYYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777423308; c=relaxed/simple;
	bh=opxmfDF+udSAEMe4/IDI57EpPA4dk1b/02U/LFOaDGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qm/IgHrn+Bi+ZHioRMmjz35VyWOAl+GMxDGhlrusCD3Zkqf80cS0UwctLz2/8oOVUn62xcvx/iAYpmnWSNq9WY4XQz/B1+qQ3TFLO/KrsJaMNzkgsnmgqo2ZFWf+OY3e6eoSu6vYWYmHGae3kSL6VtF/t+wddEgGzOsBlt4UO9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wJBWiAC/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9tzlH+R3ceoqsxLAPfYo6mlrEiIBkmpgylYT9oNp31Q=; b=wJBWiAC/NUqlB+uY0EulZ3nuk9
	8cr7gSPWSJpSGLEoTke9LFStohgDtlLmaKjjBQ8U/NpluLiSGDtgzKHhMSecKsTxOX06giLyXlLOg
	EgL7FdFmV7HoRs6tfGCojTbVVvcCEeIeSMq6hqaTzdfcQqutAZ1L7aoRqxJyT45mJOjY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHszg-000REE-DO; Wed, 29 Apr 2026 02:41:36 +0200
Date: Wed, 29 Apr 2026 02:41:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: gianfar: use alloc_ethdev_mqs
Message-ID: <d807e204-0052-4a33-b711-e372c7695023@lunn.ch>
References: <20260428223058.113013-1-rosenp@gmail.com>
 <0f704ce2-e936-4bc1-8ab2-144de9e74af8@lunn.ch>
 <CAKxU2N8yb9-M9zELSxdEjLz02GKFZ2mOmgHhc7NbW+oJsvtGXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKxU2N8yb9-M9zELSxdEjLz02GKFZ2mOmgHhc7NbW+oJsvtGXg@mail.gmail.com>
X-Rspamd-Queue-Id: C77BA48DCE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282160-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]

> > > +     *pdev = alloc_etherdev_mqs(sizeof(*priv), num_tx_qs, num_rx_qs);
> > >       dev = *pdev;
> > >       if (NULL == dev)
> > >               return -ENOMEM;
> > > @@ -679,10 +679,6 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
> > >
> > >       priv->mode = mode;
> > >
> > > -     priv->num_tx_queues = num_tx_qs;
> > > -     netif_set_real_num_rx_queues(dev, num_rx_qs);
> > > -     priv->num_rx_queues = num_rx_qs;
> >
> > Please add to the commit message an explanation of why these two
> > assignments can be removed, because it is not obvious.
> I didn't explain that _mqs sets them?

How can alloc_etherdev_mqs() set them? priv is opaque to the core. All
the core knows is the size of struct gfar_private, but nothing about
its layout, where num_tx_queues and num_rx_queues are within priv.

	Andrew

