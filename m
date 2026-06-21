Return-Path: <netdev+bounces-300882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jyKtGInuN2oJVwcAu9opvQ
	(envelope-from <netdev+bounces-300882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 16:00:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F196AB056
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 16:00:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=NoKc6DJN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300882-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300882-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BE9F3023F85
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 13:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922AA368D6D;
	Sun, 21 Jun 2026 13:59:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C79B367F4A;
	Sun, 21 Jun 2026 13:59:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782050392; cv=none; b=J7TRBFSOeI+/h9mdaB0NWwRbGQY3yD0QCj3hdRYvQIZ/Vld/SRULgsoCj5DA1PsqtYn8joxX8E735Q+/ess+kC94hvB1S5Kl5iaJIq8U+68lEBfTcqyXVXPTVc3J9gNjcVuBuswQeHVA9jZEE7FEeDC7R4mKZOpkAxr7CGZIdC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782050392; c=relaxed/simple;
	bh=kH/kGCqefwSe47atd5O5sa9mZkV0xFM8OlsdojUVE9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZ7NNC8UhkIosgbn3n8OJPci6O/iPQP8GEhW7zOuCQDeqmvbmAvqKCQoJSYQEsxcu/ELl/TxwjHdNK9svag5YV7/O04n6mB+RfmJ6C7i9vzL9iPUpP0MEeWY2NZEDH5borKMQRub+vj//5wvbIsCTryS7udPG2VjIZtu7I8sSX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NoKc6DJN; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9kh0Ruqth9Ny9QfjccDd8uZuGtEiQrI7payt1+r06vY=; b=NoKc6DJNtSPtbjX+7vWnRdibZr
	hvh1e2TfCkrG/nJGrWIOKfqn4NSWPPfUmqmVRsCm779cGV4/rxU/VEqOksEtsxwxWVFrFdmT6wcNx
	WfBtk+xtKAJFbuO7tf7mS0gLo8/u0wRA6fkOqU31Wn+vPq9ka2HqoAbjb29Cy+XtWbcQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wbIhu-008ifL-J5; Sun, 21 Jun 2026 15:59:30 +0200
Date: Sun, 21 Jun 2026 15:59:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Laight <david.laight.linux@gmail.com>
Cc: Alex Goltsev <sasha.goltsev777@gmail.com>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] net: add sock_open() with flags for socket creation
Message-ID: <b057ea36-9810-40c1-9154-859eb9e0da5e@lunn.ch>
References: <CAEKmD4KSvAGWEod3h8mPKQ-UYhKqakxfakt4gXrsU8sWuAO77g@mail.gmail.com>
 <CAEKmD4K-v_srabQDJCfqaqA6vssk-Hg-mLHEdTsphTBLmQVjnw@mail.gmail.com>
 <20260621135746.067a93be@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621135746.067a93be@pumpkin>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300882-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:sasha.goltsev777@gmail.com,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:davidlaightlinux@gmail.com,m:sashagoltsev777@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,vger.kernel.org,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6F196AB056

On Sun, Jun 21, 2026 at 01:57:46PM +0100, David Laight wrote:
> On Sun, 21 Jun 2026 14:05:40 +0300
> Alex Goltsev <sasha.goltsev777@gmail.com> wrote:
> 
> > From a9316957e594708dfb4258ad968fe88666c9b736 Mon Sep 17 00:00:00 2001
> > From: 0-x-0-0 <sasha.goltsev777@gmail.com>
> > Date: Sun, 21 Jun 2026 13:24:29 +0300
> > Subject: [PATCH v2] net: add sock_open() with flags for socket creation
> 
> A) There is no info here.
> B) You've not said why this is of any use.
> C) It isn't a bug fix so would go into net-next
> D) net-next is closed.

E) The patch has had all its whitespace corrupted.

Please "submit" the patch to yourself and ensure you can cleanly apply
it.

   Andrew

