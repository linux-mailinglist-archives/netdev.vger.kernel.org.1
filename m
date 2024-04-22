Return-Path: <netdev+bounces-90206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 598E48AD146
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4801C2103C
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77654152176;
	Mon, 22 Apr 2024 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WihMX8as"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5C91514D6
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801134; cv=none; b=ObBmY88WwL0ZkQLqfZsqj5iWyoQAo++8l1kLnlTNWfeuq9yJ3XbDUPjieLnp25EKa0tOrXDJNWLvH93jlNQ3lSQl5eJS4xDudrX+f7tgdTK98n4rUPL7TZpWhTtZYDx9uyH6RQxVYLO5rkQMbrYt3IjSlkE1kNYMz9s5bz3B/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801134; c=relaxed/simple;
	bh=pRAjpFJeMRL0lMUo+IT68aNOmArbXfJ8GhJmwzwffTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s51+EfKhGw/ggTXASqYZB8U89CZzcuhoZ43+KvOdWTYC17YfJQRPnXOta0LismYmxIcCa2GmvnCvidvA9PFSpHE6UeITT6ZwpXtndz0f7okmvGv04dSM2zMWutxfN8QVAW1B9hzHQihiv76O3BpB+UMfAptr2X0QMXjNRNJiho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WihMX8as; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=NzMkIgEF3Ix5ksUbdqaAxLg8OMiBX/uyGVyXPjfjEpo=; b=Wi
	hMX8asiAIDtooInXv5eOyDAhoN/Ayt87Vw6XtpGfX0mXiQZSA4TiKYlawyYDxYKKoNkz00p4sllC+
	+ATIRVWf6HwsVYHPLUOJ2krPmmYQAMZo8i1c6BLHGDrMR23r1oegaY/8a5HwAn6kSIFIHRDB7cAqc
	bR21tWVQhYTaOaM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ryvxg-00DdDR-9Q; Mon, 22 Apr 2024 17:52:08 +0200
Date: Mon, 22 Apr 2024 17:52:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 11/15] eth: fbnic: Enable Ethernet link setup
Message-ID: <bffafcca-3b02-4f76-929b-fc5e30284c2b@lunn.ch>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217495098.1598374.12824051034972793514.stgit@ahduyck-xeon-server.home.arpa>
 <cb2519c4-0514-4237-94f8-6707263806a1@lunn.ch>
 <CAKgT0UdaMtDtHevCX5cM+=4Z1krVCbQg56YJEiNX880H-+cxVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UdaMtDtHevCX5cM+=4Z1krVCbQg56YJEiNX880H-+cxVg@mail.gmail.com>

On Sun, Apr 21, 2024 at 04:21:57PM -0700, Alexander Duyck wrote:
> On Fri, Apr 5, 2024 at 2:51 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > +#define FBNIC_CSR_START_PCS          0x10000 /* CSR section delimiter */
> > > +#define FBNIC_PCS_CONTROL1_0         0x10000         /* 0x40000 */
> > > +#define FBNIC_PCS_CONTROL1_RESET             CSR_BIT(15)
> > > +#define FBNIC_PCS_CONTROL1_LOOPBACK          CSR_BIT(14)
> > > +#define FBNIC_PCS_CONTROL1_SPEED_SELECT_ALWAYS       CSR_BIT(13)
> > > +#define FBNIC_PCS_CONTROL1_SPEED_ALWAYS              CSR_BIT(6)
> >
> > This appears to be PCS control register 1, define in 45.2.3.1. Since
> > this is a standard register, please add it to mdio.h.
> 
> Actually all these bits are essentially there in the forms of:
> MDIO_CTRL1_RESET, MDIO_PCS_CTRL1_LOOPBACK, and MDIO_CTRL1_SPEEDSELEXT.
> I will base the driver on these values.

Great, thanks.

> > > +#define FBNIC_PCS_VENDOR_VL_INTVL_0  0x10202         /* 0x40808 */
> >
> > Could you explain how these registers map to 802.3 clause 45? Would
> > that be 3.1002? That would however put it in the reserved range 3.812
> > through 3.1799. The vendor range is 3.32768 through 3.65535.
> 
> So from what I can tell the vendor specific registers are mapped into
> the middle of the range starting at register 512 instead of starting
> at 32768.

802.3, clause 1.4.512:

  reserved: A key word indicating an object (bit, register, connector
  pin, encoding, interface signal, enumeration, etc.) to be defined
  only by this standard. A reserved object shall not be used for any
  user- defined purpose such as a user- or device-specific function;
  and such use of a reserved object shall render the implementation
  noncompliant with this standard.

It is surprising how many vendors like to make their devices
noncompliant by not following simple things like this. Anyway, nothing
you can do. Please put _VEND_ in the #define names to make it clear
these are vendor registers, even if they are not in the vendor space.

> > > +#define FBNIC_CSR_START_RSFEC                0x10800 /* CSR section delimiter */
> > > +#define FBNIC_RSFEC_CONTROL(n)\
> > > +                             (0x10800 + 8 * (n))     /* 0x42000 + 32*n */
> > > +#define FBNIC_RSFEC_CONTROL_AM16_COPY_DIS    CSR_BIT(3)
> > > +#define FBNIC_RSFEC_CONTROL_KP_ENABLE                CSR_BIT(8)
> > > +#define FBNIC_RSFEC_CONTROL_TC_PAD_ALTER     CSR_BIT(10)
> > > +#define FBNIC_RSFEC_MAX_LANES                        4
> > > +#define FBNIC_RSFEC_CCW_LO(n) \
> > > +                             (0x10802 + 8 * (n))     /* 0x42008 + 32*n */
> > > +#define FBNIC_RSFEC_CCW_HI(n) \
> > > +                             (0x10803 + 8 * (n))     /* 0x4200c + 32*n */
> >
> > Is this Corrected Code Words Lower/Upper? 1.202 and 1.203?
> 
> Yes and no, this is 3.802 and 3.803 which I assume is more or less the
> same thing but the PCS variant.

Have you figure out how to map the 802.3 register number to the value
you need here? 0x42008 + 32*n? Ideally we should list the registers in
the common header file with there 802.3 defined value. Your driver can
them massage the value to what you need for your memory mapped device.

If you really want to go the whole hog, you might be able to extend
mdio-regmap.c to support memory mapped C45 registers, so your driver
can then use mdiodev_c45_read()/mdiodev_c45_write(). We have a few PCS
drivers for licensed IP which appear on both MDIO busses and memory
mapped. mdio-regmap.c hides way the access details.

> I will try to see what I can do. I will try to sort out what is device
> device specific such as our register layout versus what is shared such
> as PCS register layouts and such.

That would be great.

	Andrew

