Return-Path: <netdev+bounces-183191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D37A8B533
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384701791E4
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C646523496B;
	Wed, 16 Apr 2025 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="J5rqLzdX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1023F236456
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795379; cv=none; b=UhVDJCI03yfGh3EJynoSqjTB/wZ13EuejhVcpTAHKPE75D8L3BJPoL4W+IUoqdliCSlZvjwxl85UHhB06yWIDM4HWCWkUWJEoi2yxjmbBn7Iuo5ybVYoKlZSeOxvuoytQBR1cxEYz9UDG5jA4UZkk/6B/TjFma/A8H16FMBz6U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795379; c=relaxed/simple;
	bh=9AaagRoUGMmuG3v/XLXqgtNoP+syY3mCOivkxE8R+NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rd0LuXbeBTGXtlL7iSSRBD/TqTu9Q1qM5ZwpBClnsVYbEIjek7KA5r94YIqK8lhDTvrJJkMq0NvRMl5GnEOGl+BmDT9US0hxeJ5vD3uJarnwqKIAUCa5iigEzq8LIWyLozfe3GVbt6+0BObCH4yW8Zpb5WAqzx9zFhGaAEGhXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=J5rqLzdX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+WPslgCeRTES35qN9Ie4Wit2sF445ZU+qKH4X7tw5Ac=; b=J5rqLzdX8fMcZrYm9uLB0w84WM
	8MIgz/Z3U8BVkLn6KD1A2ghhR/nQesnbQ6/5n9J5Hk0Sut+QFvJa8bcHSAiDhJKMlayD4xN8SIq5D
	n6i1Aq01mM0K2D4giwpoVDEPGcuMKOWHsLeKNbHnGyn0sLagHShG/Xd9/VCmOG1q6568X7Peo0pLd
	LBWjLXWP38b8a1krNaY8RRxBq50vS9fKfNHbZKuS95eJ6+OIlRVtiwCfsjyG/tWqrTBYrV7GkDRqD
	oofFfBUZC0ZAeG4NORCaSvPw0DaJwtjjfNrzga90FRUEZOuX48P8moV+Up8UPO7qJPuZ4tcLJpz2K
	i01gWQ2Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36116)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u4yyo-0000xj-2B;
	Wed, 16 Apr 2025 10:22:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u4yym-0001HR-02;
	Wed, 16 Apr 2025 10:22:48 +0100
Date: Wed, 16 Apr 2025 10:22:47 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH RFC net-next 2/5] ptp: marvell: add core support for
 Marvell PTP v2.1
Message-ID: <Z_9252w9vWiGysiF@shell.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
 <E1u3LtV-000CP1-2C@rmk-PC.armlinux.org.uk>
 <20250416104849.43374926@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416104849.43374926@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 16, 2025 at 10:48:49AM +0200, Kory Maincent wrote:
> On Fri, 11 Apr 2025 22:26:37 +0100
> Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > Provide core support for the Marvell PTP v2.1 implementations, which
> > consist of a TAI (time application interface) and timestamping blocks.
> > This hardware can be found in Marvell 88E151x PHYs, Armada 38x and
> > Armada 37xx (mvneta), as well as Marvell DSA devices.
> > 
> > Support for both arrival timestamps is supported, we use arrival 1 for
> > PTP peer delay messages, and arrival 0 for all other messages.
> > 
> > External event capture is also supported.
> > 
> > PPS output and trigger generation is not supported.
> > 
> > This core takes inspiration from the existing Marvell 88E6xxx DSA PTP
> > code and DP83640 drivers. Like the original 88E6xxx DSA code, we
> > use a delayed work to keep the cycle counter updated, and a separate
> > delayed work for event capture.
> > 
> > We expose the ptp clock aux work to allow users to support single and
> > multi-port designs - where there is one Marvell TAI instance and a
> > number of Marvell TS instances.
> 
> ...
> 
> > +#define MV_PTP_MSGTYPE_DELAY_RESP	9
> > +
> > +/* This defines which incoming or outgoing PTP frames are timestampped */
> > +#define MV_PTP_MSD_ID_TS_EN	(BIT(PTP_MSGTYPE_SYNC) | \
> > +				 BIT(PTP_MSGTYPE_DELAY_REQ) | \
> > +				 BIT(MV_PTP_MSGTYPE_DELAY_RESP))
> > +/* Direct Sync messages to Arr0 and delay messages to Arr1 */
> > +#define MV_PTP_TS_ARR_PTR	(BIT(PTP_MSGTYPE_DELAY_REQ) | \
> > +				 BIT(MV_PTP_MSGTYPE_DELAY_RESP))
> 
> Why did you have chosen to use two queues with two separate behavior?
> I have tried using only one queue and the PTP as master behaves correctly
> without all these overrun. It is way better with one queue.
> Maybe it was not the best approach if you want to use the two queues.  

First, both queues have the same behaviour.

Second, because they *aren't* queues as they can only stamp one message.
The sync messages come from the master on a regular basis. The delay
response messages come from the master in response to a delay request
message, the timing of which is determined by the local slave.

If the local end sends a delay request just at the point that the master
sends a sync message causing the master to immediately follow the sync
message with the delay response message, then we could get an overrun
on a single queue - because we'll stamp the sync message and if we don't
read the timestamp quickly enough, the stamp registers will be busy
preventing the timestamp of the delay response being captured.

With the overruns that I've seen, they've always been on the second
"queue" and have always been for a sequence number several in the past
beyond the point that the overrun has been reported. However, the
packet which the sequence number matches had already been received -
and several others have also been received. I've been wondering if it's
a hardware bug, or maybe it's something other bits of the kernel is
doing wrong.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

