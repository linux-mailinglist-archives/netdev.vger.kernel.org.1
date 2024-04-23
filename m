Return-Path: <netdev+bounces-90679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36158AF7C7
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 22:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA87C28374B
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 20:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFB61422BB;
	Tue, 23 Apr 2024 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFRm/ZY6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45EB13D522
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902843; cv=none; b=HQmP7/3cUlhNQLiscXwLmnD+lFW+RYtUT5IYzxHxl8xfqCWubC12rs0j3J+5tmcGWe2OQurndvNHJR+0yry2dcglj2gyadyNwn28KIV9exICjfkF36iS5oQO6yqj66ZDp1iqq4KhK9FpHuQfBOOFdbDOcMxqT4bjuk/fnxcfky4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902843; c=relaxed/simple;
	bh=rM3r23sFx76LFwkv6P5HL+g20HgwGn8+PIZfHmQFZEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elw3Ei+sedYlMdfoxy4QgWcCrCaGtI12ctwjncafFbtbjEbBjAQbhtWsgatxbjhM0d7NwYEzg5oF338hknkIUZu2QG6GV1DUsfji9wos5EATMAL465j33gFYo7nqZGUiErz6gHBXxQ9T63lKBFNOaP4ZrS1lsmq9qOQox/S6ONg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LFRm/ZY6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713902840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MOU4NuezKXMd7tnThZfTHC5dATyrO/O3TXjxET/i2Xg=;
	b=LFRm/ZY6ht2jklFuZ6ZR1Dx7O6ePjP9BDnWpLadmudYEnn6yQQwgIL93C5m7Surj0CFZCy
	kPj/ejZhVcVJIyFdGShY0/6jVXfRL5grDxAw1Z6JZI4nxl/UxPLVfVrpIC3+7hxZHpWNNN
	+sL2pGCZpyUVo/32ibr62jxCP1LMwbg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-JLMP44z0O524RkG41e1spw-1; Tue, 23 Apr 2024 16:07:19 -0400
X-MC-Unique: JLMP44z0O524RkG41e1spw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3c5ed72fe10so7550587b6e.3
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 13:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713902838; x=1714507638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOU4NuezKXMd7tnThZfTHC5dATyrO/O3TXjxET/i2Xg=;
        b=BQFKRjl2eD/ic+y+zGVorvIEs/kjr1HDnKdnvyCT0jNySFsEH438EWJO2gsUt/wOlx
         xy+IJuOkiV4fLjzRym18oHUc7SbaRPOOCeUHhJSQxP1E0NKNxgwv1ktArk2b1UHcUOOF
         XnJhg2siYx1A8JGI9SiD5abitYGPkW+PfYKaYrAuufFBWkTMvDTBZAHakLeSO4B3zKiP
         rZQlRiuWwCD+NCQQdXZndRWjSgYjpBApHWRA2RyOFDm+SdHunV0itf7hC+MmA8ihY8nm
         UbVmySZDJlUUnImj66Fe29Ds3bpnDxIaL5JAk5pb1opSo/oajjS+iw/7ouCQs2OEcalJ
         RfqA==
X-Forwarded-Encrypted: i=1; AJvYcCVYx3WKWjNkitjFlvfCoTIgP6GpheLnvxYlUJKHP5TN/jKZfVdiHcDTFpzn7VaAnjPpJCz20DOCzts/mp2XI+4V0bsrsdP9
X-Gm-Message-State: AOJu0YwxlRUYTXgYpzKZR00AME5Q2Xilrj95XXkQGvwZBFT2Q+5WSVaF
	jLCPHFf0OaX2DCo/tixuQyibVa1dBv34rhBb4QnqzSFFRyYgKDp3QVY7qHHoXzw1cm4H7ICkDaD
	ftzMKBxiAwK9z04hznauL2JpEuyinkxBFcRK4UuyBgNVwyAYwqOBl8gtZUJjf+A==
X-Received: by 2002:aca:f17:0:b0:3c5:edb2:ec91 with SMTP id 23-20020aca0f17000000b003c5edb2ec91mr367910oip.43.1713902838270;
        Tue, 23 Apr 2024 13:07:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC4AEKBSMGtR0FddUM3bPFWjkymjPUFx5EDjF8EkRKARZEfOamjxgpsKoBZ2H2HJHORiyBWA==
X-Received: by 2002:aca:f17:0:b0:3c5:edb2:ec91 with SMTP id 23-20020aca0f17000000b003c5edb2ec91mr367890oip.43.1713902837849;
        Tue, 23 Apr 2024 13:07:17 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id r13-20020ac8794d000000b0043a0088c785sm544222qtt.20.2024.04.23.13.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 13:07:17 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:07:15 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Colin Foster <colin.foster@in-advantage.com>, netdev@vger.kernel.org
Subject: Re: Beaglebone Ethernet Probe Failure In 6.8+
Message-ID: <3kpvqcg3twpifzkxkrvhqew3cjuq2imgo4d4b775oypguik55g@npe75wf7rpdr>
References: <Zh/tyozk1n0cFv+l@euler>
 <53a70554-61e5-414a-96a0-e6edd3b6c077@lunn.ch>
 <Zicyc0pj3g7/MemK@euler>
 <c11817a2-d743-4c27-a129-dd644c23110f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c11817a2-d743-4c27-a129-dd644c23110f@lunn.ch>

On Tue, Apr 23, 2024 at 03:52:35PM +0200, Andrew Lunn wrote:
> On Mon, Apr 22, 2024 at 11:00:51PM -0500, Colin Foster wrote:
> > Hi Andrew L,
> > 
> > (I CC'd Andrew Hanley, original author, for visibility)
> > 
> > On Wed, Apr 17, 2024 at 09:30:58PM +0200, Andrew Lunn wrote:
> > > On Wed, Apr 17, 2024 at 10:42:02AM -0500, Colin Foster wrote:
> > > > Hello,
> > > > 
> > > > I'm chasing down an issue in recent kernels. My setup is slightly
> > > > unconventional: a BBB with ETH0 as a CPU port to a DSA switch that is
> > > > controlled by SPI. I'll have hardware next week, but think it is worth
> > > > getting a discussion going.
> > > > 
> > > > The commit in question is commit df16c1c51d81 ("net: phy: mdio_device:
> > > > Reset device only when necessary"). This seems to cause a probe error of
> > > > the MDIO device. A dump_stack was added where the reset is skipped.
> > > > 
> > > > SMSC LAN8710/LAN8720: probe of 4a101000.mdio:00 failed with error -5
> > > 
> > > Can you confirm this EIO is this one:
> > > 
> > > https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/ti/davinci_mdio.c#L440
> > 
> > Yes, I can confirm this is the EIO.
> > 
> > > 
> > > It would be good to check the value of USERACCESS_ACK, and what the
> > > datasheet says about it.
> > 
> > The register value is 0x0020ffff
> 
> The 0xffff is the value read from the bus. That probably means the PHY
> did not answer, although it could legitimately return 0xffff to a
> read. More important is bit 29: "Acknowledge. This bit is set if the
> PHY acknowledged the read transaction." It is 0, so it thinks the PHY
> did not respond.
> 
> > The patch I threw in:
> > 
> > --- a/drivers/net/ethernet/ti/davinci_mdio.c
> > +++ b/drivers/net/ethernet/ti/davinci_mdio.c
> > @@ -437,7 +437,10 @@ static int davinci_mdio_read(struct mii_bus *bus, int phy_id, int phy_reg)
> >                         break;
> > 
> >                 reg = readl(&data->regs->user[0].access);
> > +               printk("davinci mdio reg is 0x%08x\n", reg);
> >                 ret = (reg & USERACCESS_ACK) ? (reg & USERACCESS_DATA) : -EIO;
> > +               if (ret == -EIO)
> > +                   printk("ret is this EIO\n");
> >                 break;
> >         }
> > 
> > 
> > The print:
> > 
> > [    1.537767] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6, bus freq 1000000
> > [    1.538111] davinci mdio reg is 0x20400007
> 
> This is a read of register 2, and the register has value 0x0007
> 
> > [    1.538372] davinci mdio reg is 0x2060c0f1
> 
> This is a read of register 3, and the register has value 0xc0f1.
> 
> These are the ID registers, and match SMSC LAN8710/LAN8720.
> 
> > [    1.549523] davinci mdio reg is 0x03a0ffff
> 
> Register 0x1d. Not one of the standard registers. I don't know what is
> happening here.
> 
> > [    1.549551] ret is this EIO
> > [    1.549806] davinci mdio reg is 0x0020ffff
> 
> Register 1, basic mode status register.
> 
> > [    1.549821] ret is this EIO
> 
> In these two last transactions, the ACK bit is not set.
> 
> > [    1.550471] SMSC LAN8710/LAN8720: probe of 4a101000.mdio:00 failed with error -5
> > [    1.550592] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver SMSC LAN8710/LAN8720
> > 
> > Without the mdiodev->reset_state patch, I see the following:
> > 
> > [    1.537817] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6, bus freq 1000000
> > [    1.538165] davinci mdio reg is 0x20400007
> > [    1.538426] davinci mdio reg is 0x2060c0f1
> 
> Same as above.
> 
> > [    1.558442] davinci mdio reg is 0x23a00090
> > [    1.558717] davinci mdio reg is 0x20207809
> > [    1.559681] davinci mdio reg is 0x21c0ffff
> 
> In all these cases, we see the ACK bit set. 
> 
> So the PHY is responding to registers 2 and 3, the ID registers. But
> it seems to be failing to respond to other registers. At a guess, i
> would say it is still coming out of reset. Does the datasheet for the
> LAN8710/LAN8720 say anything about how long a reset takes? Can you get
> a logic analyser onto the reset line and MDIO bus and see how
> different the timing is? It might be you need to add some delay values
> to the reset in DT.

For what its worth, I think that this theory makes sense if reverting the patch
highlighted above makes this go away. Before that patch, you'd see a
flow like this:

    net: phy: mdio_device: Reset device only when necessary

    Currently the phy reset sequence is as shown below for a
    devicetree described mdio phy on boot:

    1. Assert the phy_device's reset as part of registering
    2. Deassert the phy_device's reset as part of registering
    3. Deassert the phy_device's reset as part of phy_probe
    4. Deassert the phy_device's reset as part of phy_hw_init

Which means whatever the deassert time was tripled in
practice before you got around to phy_hw_init() (which if I understand
is when things start reporting no ACK above).

I am not sure what devicetree upstream would be the one to look at for
your beaglebone, but microchip's datasheet for the LAN8720A has
"TABLE 5-8: POWER-ON NRST & ..." section detailing some reset requirements:

    https://ww1.microchip.com/downloads/en/devicedoc/00002165b.pdf

If I read it right, assert time needs to be >= 100 us, and
deassert... is not so clear to me unfortunately. Maybe for starters
triple your value and see if things work ok (just based on the 3
repeated deasserts going down to 1 with the patch applied)? Hopefully
longer term the actual deassert timing can be confirmed.

Thanks,
Andrew


