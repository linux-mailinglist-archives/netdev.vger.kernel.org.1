Return-Path: <netdev+bounces-223595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD31DB59A9F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2931E167242
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0D7313E39;
	Tue, 16 Sep 2025 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="P4X5dLLl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A313081AE;
	Tue, 16 Sep 2025 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033502; cv=none; b=NNzx5wFYSceZ6uvjjUbMWUtPubogqTgIxcuHIdp2c078gNybAcF/JwM3X8SFFe3zQIYvSuC9sNm/lpgjT2IG0UneP2wbjKq74okjZezmIi2NGZIgEwFVpCDpbb+BDTogmnPPGgsZjlX9s8GshCI+jOVK+SZRWLSrLG+WIf1avLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033502; c=relaxed/simple;
	bh=MjN8NM+9Mz20xb1nIlZpOEr/3Qh3fNWBkaaj1YjyEdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdfmPN2yUhvvtc6ENFkdQsCZKsOgmjohV9EEblIfXiWEUK71vufxwNhtQ+cESFZzhAaXU2OgvKTYeRNnD4pfRtGQ4zW+GcHxLu8FOLa8j80OiKwkoa+Z+SjDtHD9yb75Kp6gTW1ELGz7HfPx0ZkLi18QBrW804vD8EkOx+64HsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=P4X5dLLl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=M6rgThuM1WGuVWDhs++mootFR4ZaiAUjcCQGb6p8Tss=; b=P4X5dLLlT8VyoF4RIlX15OQY1w
	NSvr5fdoleoIJbcE58nozjiIy5z0pribctXcYMd9koR2tvsswbhZE6PoV1ZjimQkogS6SYgmXg6H4
	/+RgV2Ix4nHkXjOpLmfwenkHqoVlDPLQhA1NdH8C3IwB2raG7FxB29aoR1t0lBRCf34s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uyWos-008Zkp-6q; Tue, 16 Sep 2025 16:38:10 +0200
Date: Tue, 16 Sep 2025 16:38:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Wei Fang <wei.fang@nxp.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Richard Cochran <richardcochran@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Dumazet <edumazet@google.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Nick Shi <nick.shi@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"Y.B. Lu" <yangbo.lu@nxp.com>
Subject: Re: [PATCH net-next 2/2] ptp: rework ptp_clock_unregister() to
 disable events
Message-ID: <ac7c6c84-02e6-4e3d-8c38-abd5339a021d@lunn.ch>
References: <aMglp11mUGk9PAvu@shell.armlinux.org.uk>
 <E1uyAP7-00000005lGq-3FqI@rmk-PC.armlinux.org.uk>
 <PAXPR04MB851098C0A69B74DD232071B68814A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <aMloTwObRUIRAzPF@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMloTwObRUIRAzPF@shell.armlinux.org.uk>

On Tue, Sep 16, 2025 at 02:38:23PM +0100, Russell King (Oracle) wrote:
> On Tue, Sep 16, 2025 at 09:03:17AM +0000, Wei Fang wrote:
> > > the ordering of ptp_clock_unregister() is not ideal, as the chardev
> >  ^
> > Nit: Uppercase, 't' -> 'T'
> > 
> > > +void ptp_disable_all_pins(struct ptp_clock *ptp)
> > > +{
> > > +	struct ptp_clock_info *info = ptp->info;
> > > +	unsigned int i;
> > > +
> > > +	mutex_lock(&ptp->pincfg_mux);
> > 
> > Currently ptp_chardev.c has been converted to use the auto-cleanup
> > API (scoped_cond_guard()), so scoped_guard() can be used here.
> 
> ... which are very non-C like, non-obvious, and I currently have no
> idea at the moment how to use it. In my opinion, it makes code more
> difficult to understand.

+1

Plain scoped_guard() is not too magical and reasonably
understandable. But ptp_chardev.c is using scoped_conf_guard() which
is much more magical and i have no idea what it does.

> Maybe someone else can convert this for me to this non-C like
> structure?

Yes, if you want to write plain simple code, I submit it so. Somebody
else can follow up with an obfuscation patch.

     Andrew

