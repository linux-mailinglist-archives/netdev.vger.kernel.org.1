Return-Path: <netdev+bounces-275967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJUHDvru1GkjywcAu9opvQ
	(envelope-from <netdev+bounces-275967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:48:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8283ADEBD
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FD373020EA3
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 11:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370C63B0AE7;
	Tue,  7 Apr 2026 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="l9S9XNfJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB76530F94B
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562367; cv=none; b=lMtRjmnNwsrDG/3EjzIovBGyNidVXGP+0Wvaagk7QmEOlGfYv3/QrtC1qYjaZF+2K6g7QGWZkUronM6q2DVkOCTBfFeX95kAlWkKVlTVlPbSZPlHN4x0iJU5NWKKFt4g/D6syiOQbIYy8gbhH11AsBxXW/ZhB7D1cLiwObk8L0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562367; c=relaxed/simple;
	bh=uOvYUiplJ3wBMN5NBAg7FPor8mUaG804VOSKkrURJvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxqVun2CvbwubrYOvU6BJTAiE2355UyC1U6MvViKCGS5TgYFxYFJmHn01FPymZsphEPDYaMuRxZiHaN+2fbUcLlkTcLG/2ZvYWq2fubNaQAfrRIwDavqP9mRg5oEvYBbZJ9hdX6AEGGHHTjyWM+nH8p9boIgbrixPXwoyQCRFG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=l9S9XNfJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xbusdekfIOnLk1V6Cd6say5N7PFhbNT4TXpSd+uqMeo=; b=l9S9XNfJLGQuD/qMSklWu8oQZl
	tMPJufW84OzCxp+zfDDFvutd9TbVtmyHrTmyscvMB6mwky6JPD5orxxphv5GmcMkGfkVZyISSOxRM
	QOWjp95tlGAtEB2/kaaMBdZ/X4WGi3TUlZfe5bn/7ZYMxy6faWtK7MwDf//n6GJArZ/mIAa67igT/
	yK0e9dQpMthLgqBCeZbVENfZqUZpQqWQSJ4Q+qkhqZlNj6KweeGSXRaP04uKE3X+lKS1VqZNbu1J8
	YrqB87cRjq32CaxzJbcqGJlPCaeu7vic34RItKP7RmdQPiAfppho55iP2HaNwI0dUC43jjr/qDyyN
	xbQkdw/Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50046)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wA4sb-000000000rY-1vXF;
	Tue, 07 Apr 2026 12:46:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wA4sZ-000000002Eo-3LLG;
	Tue, 07 Apr 2026 12:45:59 +0100
Date: Tue, 7 Apr 2026 12:45:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org
Subject: Re: stmmac: TX stalls with head OWN=1; requiring manual DMA kick
 (6.12.63)
Message-ID: <adTudy6ehcIgnJeq@shell.armlinux.org.uk>
References: <CAP6Zq1i31Z0kfDST1Xcoftxja-TFaxgSjKH6jX5eY0AGdASpTw@mail.gmail.com>
 <b2868f3d-ef84-4ec0-ac37-e41029a1d385@lunn.ch>
 <abHV7rDryld4A-S_@shell.armlinux.org.uk>
 <CAP6Zq1hKd19aLjWBnx3pkfeGyqrudqSHd0PTxUJhn7r9BG0oSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP6Zq1hKd19aLjWBnx3pkfeGyqrudqSHd0PTxUJhn7r9BG0oSA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275967-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:email,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: AA8283ADEBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 04:02:45PM +0200, Tomer Maimon wrote:
> Hi Andrew and Russell,
> 
> On Wed, 11 Mar 2026 at 22:52, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Mar 11, 2026 at 08:46:04PM +0100, Andrew Lunn wrote:
> > > On Wed, Mar 11, 2026 at 08:34:36PM +0200, Tomer Maimon wrote:
> > > > Hi Giuseppe,
> > > >
> > > > On kernel 6.12.63 (GMAC, normal 16‑byte TX descriptors), we observe
> > > > brief TX stalls when sending small packets.
> > >
> > > You might want to look at Russell Kings patches from this week to
> > > rework the descriptor handling.
>
> Sorry, I mean 6.12 LTS.
> >
> > Yep.
> >
> > Not sure they'll materially affect any problem, because I try to avoid
> > functional changes in stuff like those.
> >
> > What's missing from the original report is a description of the
> > hardware. stmmac drives multiple different versions of the Synopsys
> > IP which have significant changes between them. Which platform glue
> > is being used, which core driver is being used (dwmac1000? dwmac4?
> > etc.)
> stmmac IP version is 3.73a
> The platform is glue is "snps,dwmac" and the core driver is "dwmac1000"

Thanks.

> > Also what isn't mentioned is whether this is a regression, or whether
> > it's something that has never worked. If it's a regression, which
> > kernel version previously worked?
> We ran the test with kernel 5.10 LTS, and it didn't work.

So it isn't a regression, but a persistent issue.

You mentioned in your original email:
> If the head descriptor still has OWN=1, issue a Transmit Poll Demand
> via stmmac_enable_dma_transmission().
> This immediately resumes the DMA and clears the stall.

This will be dwmac_lib.c::dwmac_enable_dma_transmission() which writes
to the transmit poll demand register. This write is prefixed on arm64
by a "dmb oshst" instruction which should ensure that previous writes
to the descriptors are visible to stmmac.

dwmac1000 doesn't have TSO and in any case the packet is too small for
TSO, so we can ignore stmmac_tso_xmit(). I'm also guessing your not
using xdp either, so we can rule out stmmac_xdp_xmit_zc() and
stmmac_xdp_xmit_xdpf().

So, we're looking at the normal path through stmmac_xmit().

The code at this point is:

        /* Set the OWN bit on the first descriptor now that all descriptors
         * for this skb are populated.
         */
        stmmac_set_tx_owner(priv, first_desc);

        netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);

        stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);

stmmac_set_tx_owner() will be calling norm_desc.c::ndesc_set_tx_owner()
which quite simply sets bit 31 in the descriptor via a
read-modify-write:

0000000000000000 <ndesc_set_tx_owner>:
   0:   b9400001        ldr     w1, [x0]
   4:   32010021        orr     w1, w1, #0x80000000
   8:   b9000001        str     w1, [x0]
   c:   d65f03c0        ret

and as I say, dwmac_enable_dma_transmission() includes the necessary
barrier to ensure that _that_ write should be visible to stmmac:

0000000000000120 <dwmac_enable_dma_transmission>:
 120:   52820082        mov     w2, #0x1004                     // #4100
 124:   0b012041        add     w1, w2, w1, lsl #8
 128:   8b214001        add     x1, x0, w1, uxtw
 12c:   d50332bf        dmb     oshst
 130:   52800020        mov     w0, #0x1                        // #1
 134:   b9000020        str     w0, [x1]
 138:   d65f03c0        ret

However, I'm wondering if we have an issue with the descriptor writes
becoming visible in the wrong order. Please can you try adding a
dma_wmb() immediately before stmmac_set_tx_owner() in stmmac_xmit()
to ensure that all previous descriptor settings are fully visible
before we update the OWN bit on the first descriptor and make that
update visible?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

