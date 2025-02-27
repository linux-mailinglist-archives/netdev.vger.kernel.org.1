Return-Path: <netdev+bounces-170347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749DFA48491
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF9B3B96D6
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBB51C3F1C;
	Thu, 27 Feb 2025 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fZ0Z6IUw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2A01B424E;
	Thu, 27 Feb 2025 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672485; cv=none; b=cL7JzZetCKwNUmf9yvBcYQfFpyp2F0Y7kaytSP2nfDgQ3ZoOKMYd+qrtIsB0sBM0gWrVauoXpMwQSgcmvXlB4ghzTZQeXAyihPrJwcYTOoojdVeDQhbQaHKJ0BVKnL0CDqAWeIDXXobAkBMhZ7JCcEA2VAcHpOfSBLmuuMuBSGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672485; c=relaxed/simple;
	bh=CgaSpzeKgn2SkFZRdWkritV3DHz34KyQBsN6j8KTXmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOkI5+0uLGIhJoFIJy5VKj1hCWoYaI/bEfXm75Efo5+mP1+kjlQ7NYTGRdcTdA+X1XoAygdIiF/Wu90Iu5WTN98i7KbBdzG6IareWjRr0ig09Usz7iHEDc7BY/2VZEc9x0TbyScLoVJPkMy8LHECia6T5rdAc+SI7dqn8Yu15BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fZ0Z6IUw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CND/AWjqWtefCR2+bz8yg6Rc6Qum2wM65PkiDHxFQKA=; b=fZ0Z6IUwpZBeYWfehdeZd8LTTq
	fWrQj/7RaPs53mZOEgMIB+pGKvLf8bb6zvQgPHHJ45OOSIGB0Gze9Nws3AX7jY94oQPYdg1qQ0uQs
	T1009zcHl7phWIDtAD7WrLJEiSbTGf1n5C8nWsteHhn4GohocKhajcus+RHV5/8iDH4E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tngQT-000e7u-Fr; Thu, 27 Feb 2025 17:07:53 +0100
Date: Thu, 27 Feb 2025 17:07:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000e: Link flap workaround option for false IRP events
Message-ID: <1a4ed373-9d27-4f4b-9e75-9434b4f5cad9@lunn.ch>
References: <mpearson-lenovo@squebb.ca>
 <20250226194422.1030419-1-mpearson-lenovo@squebb.ca>
 <36ae9886-8696-4f8a-a1e4-b93a9bd47b2f@lunn.ch>
 <50d86329-98b1-4579-9cf1-d974cf7a748d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50d86329-98b1-4579-9cf1-d974cf7a748d@app.fastmail.com>

> >> +			e1e_rphy(hw, PHY_REG(772, 26), &phy_data);
> >
> > Please add some #define for these magic numbers, so we have some idea
> > what PHY register you are actually reading. That in itself might help
> > explain how the workaround actually works.
> >
> 
> I don't know what this register does I'm afraid - that's Intel knowledge and has not been shared.

What PHY is it? Often it is just a COTS PHY, and the datasheet might
be available.

Given your setup description, pause seems like the obvious thing to
check. When trying to debug this, did you look at pause settings?
Knowing what this register is might also point towards pause, or
something totally different.

	Andrew

