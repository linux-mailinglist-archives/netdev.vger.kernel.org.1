Return-Path: <netdev+bounces-155626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28633A03335
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 00:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2F03A2639
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 23:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3281E25EA;
	Mon,  6 Jan 2025 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zfFlDYDn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4483E1E25ED
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 23:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736205384; cv=none; b=Wz8gA2Xiv41WNUJpDu2SCSh4OH3J6iO3M7BVfOvF/u4UtRkeu42oBBLxZsTMCIBMFBGtU0Xm5i08PX6JKyoPqUYQUhlb4dBKBptEFDzj6Qe+BzU/0tWFpRHLNEEebwxEqxhcK073ZBkRwlhgp/Pa7x7wkRyCLi6OjP6Fcn34GJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736205384; c=relaxed/simple;
	bh=ikXOsBTsyyZLGhydYKZQTsM9nZ2c2nfjxIqWgNIipzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8ouptnBUyfASRTr2EBWObUVUAYcgjmbsUXU45+PLMEeDT0Ov/Etrl2byAraa/wQqfQQiYMLNTq+OKISpUy7iXDD4OaIty59jI974aKKDo7AyZlsr66mrwSguDwiUQTSyI8g2jHO8FLdBQEIcbYw6f3CiNJN0YO0d41aB18E8Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zfFlDYDn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pf/q68SIBAZxycFcmKBNphvvzKmualAn7mggT43qOts=; b=zfFlDYDnhleWRS+HbXoFmGOB93
	DJC/j7mMIbs6Sfck60Uord33bbrP+KOzu33d6Y51ZEzPFkX93FfsyIw/HTYkBD2LN7xIK5YCE/QYa
	wHIKZQEhfEthH7akg/oXpUSNcBsh0UEQzligv/g3NwdQB6lcGSCec7ej2sjoLPZEMWx0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUwKN-0021MC-M0; Tue, 07 Jan 2025 00:16:07 +0100
Date: Tue, 7 Jan 2025 00:16:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] r8169: add support for reading over-temp
 threshold
Message-ID: <b040f19f-2c26-412e-b074-238e284573aa@lunn.ch>
References: <97bc1a93-d5d5-4444-86f2-a0b9cc89b0c8@gmail.com>
 <f3e07026-8219-4b36-b230-7f7ddd71c7ab@gmail.com>
 <4535017c-10a8-47e8-8a8e-67c5db62bb16@lunn.ch>
 <088501b8-1c55-4d20-95b3-ed635865b470@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <088501b8-1c55-4d20-95b3-ed635865b470@gmail.com>

> > Does it reduce the speed in the same way as downshift? Can the user
> > tell it has happened, other than networking is slower?
> > 
> It internally disables 2.5G/5G advertisement and triggers an autoneg.
> So you get the usual message on console/dmesg indicating the new speed.
> This internal action sets a register bit, and it can also trigger an interrupt.
> So it should be possible to check in the link_change_notify() callback
> whether an over-temp event occurred. The silent change of the advertisement
> may also result in the phylib-cached advertisement being out-of-sync.
> So we would have to re-sync it. But I didn't fully test this yet.
> 
> This patch only allows to read the over-temp threshold set as power-on default
> or by the boot loader. It doesn't change the existing behavior.

Thanks for the details. So it does seem to be different to downshift,
where generally advertised link modes in the registers is not changed,
and the speed indicated in BMSR generally does not indicate the
downshifted speed, you need vendor registers to get the actual
speed. But downshift happens at link up, not latter when the device
starts to overheat.

Does it restore advertisement to 2.5G/5G when it cools down? There is
an interesting policy decision here. Do you want 1s downtime very so
often as it speeds up and slows down, or should it keep at the slower
speed until the user kicks it back up to the higher speed?

	Andrew


