Return-Path: <netdev+bounces-225250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746D6B91245
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 14:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378191660C8
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 12:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1895D28D83D;
	Mon, 22 Sep 2025 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="c6+IwH97"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC58305E3B
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544692; cv=none; b=YSEVQmmMSFsNAL1WMXBPlef0qZAmz0vx3LLHp1vwTYEwIxsdQEl3kLO7FMn4+CK4FqeYdVGNsCqzTYJk/Xt7XXuOTEGkIYfhXeoWw4HenKSGv1AuGb/yu07tFA2zIvWT7d18IBW6Zq8HiEVTbYCuTc6eXyUYSwxcjVTThD8Drwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544692; c=relaxed/simple;
	bh=XGhoOgJmqDt8u+WPyGufWLd32mB43qLxiWnV4nGqL5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTnSSkXN6K3JBDdM+unTA7BdNyCkDRWx/StvqMk7TZxJnI9orL0s6Up42f6W25GNVNCEUt6scGFAxXid8fI30mWrKfjeFQpXC4eIFi4BC7JCwoqrZBEj/yE+FXt2wDdn6SDCCIsCV9xKEjuAOjhOxCvodptzybIWCeJCFmb2rUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=c6+IwH97; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Cptg2XPcazefnww5fnawVEk1Q8wBmu4jZtFflDymxJc=; b=c6+IwH97Mk52JPQMgCrX1FuGOk
	VNOEwOkqs3kH8y4Xgkli6LkqRcZJ7Z/DhbzDUxqzKKGAHcoKojdOFYtguwGYYMTf+89etzMA7eke5
	C0lKvkTu+yxsp5td6Npge7+OQLjCRn4TClBXsQFZADFF6yaA0hAgGwU3pVEpLYJ5a5mpiAPtvnYV5
	QR+sZH9Zgt9aoka0MUlX/BTILvTA/hIm6P00dsoAlxMzKcLQb+QSD1razh6BGY77bPtgld5pB2oLv
	ev3R4WtfIG2IL5LPPKeIHq/qhC++DzBOXdtPUzkyFsLwmJuVuh8L0plAwLXvj2ueGH0C38pQLW1RD
	NOUtf6ow==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51032)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v0fnw-000000004lg-2yKL;
	Mon, 22 Sep 2025 13:38:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v0fnt-0000000056f-35aw;
	Mon, 22 Sep 2025 13:38:01 +0100
Date: Mon, 22 Sep 2025 13:38:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC] increase MDIO i2c poll timeout gradually (including patch)
Message-ID: <aNFDKaIh6RNqLcBM@shell.armlinux.org.uk>
References: <971aaa4c-ee1d-4ca1-ba38-d65db776d869@kabelmail.de>
 <cbc4a620-36d3-409b-a248-a2b4add0016a@lunn.ch>
 <f86737b0-a0fe-49a6-aeca-9e51fbdf0f0d@kabelmail.de>
 <aM6Ng7tnEYdWmI1F@shell.armlinux.org.uk>
 <6d444507-1c97-4904-8edb-e8cc1aa4399e@kabelmail.de>
 <aM6xwq6Ns_LGxl4o@shell.armlinux.org.uk>
 <4683e9ea-f795-4dab-8a0a-bd0b0f4fbd99@kabelmail.de>
 <3fab95da-95c8-4cf5-af16-4b576095a1d9@kabelmail.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fab95da-95c8-4cf5-af16-4b576095a1d9@kabelmail.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Sep 22, 2025 at 12:54:20PM +0200, Janpieter Sollie wrote:
> this is a diff of 10usecs (i=10), 40usecs (i=4) and 30usecs (i=3) my device
> is running the i2c_transfer_rollball().
> seems a lot to me when an i2c call takes 11-12 usecs avg per call
> are you sure these numbers point to a stable i2c bus?

I guess you've never dealt with I2C buses before. As has already been
stated, the clock rate for I2C used with SFP modules (which is, if you
like, I2C v1) is 100kHz. that's 10us per bit.

An I2C transaction consists of one start bit, 8 bits for the address
and r/w bit, one bit for the ack, 8 bits for the each byte of data
and their individual ACK bits, and finally a stop bit. If a restart
condition is used, the stop and start between the messages can be
combined into a restart condition, saving one bit.

That works out at 1 + 8 + 1 + N*(8 + 1) + 1 bits, or 11 + 9 * N bits
or clocks.

The polling consists of two transactions on the bus:

- a write of one byte - giving 20 clock cycles.
- a read of six bytes - giving 65 clock cycles.

So that's 85 clock cycles, or 84 if using restart. At 10us per cycle,
that's 840us _minimum_.

If i2c_transfer() for that write and read are taking on the order of
12us, that suggest the bus is being clocked at around 7MHz, which is
certainly way too fast, a bug in the I2C driver, an issue with the
I2C hardware, or maybe an error in calculating how long a call takes.

And... it's your interpretation of your results.

Remember, these are nanoseconds (ns), nanoseconds are 1000 microseconds
(us) and there are 1000000 nanoseconds in a millisecond (ms). Sorry
to teach you to suck eggs, but based on your reply it seems necessary
to point this out.

You quoted an average of 99901858ns - 99.9ms for the i=3 case.
You quoted an average of 86375811ns - 86.4ms for the i=4 case.

Given that the difference in msleep() delay is 5ms, and we're
talking about 50 or 55ms here, for the i=3 case that's 45ms
for i2c_transfer(). For the i=4 case, that's 36.4ms.

However, msleep() is not accurate - and may even be bucket-based so I
wouldn't rely on the requested msleep() interval being what you end
up with - which seems to be suggested by the difference of almost 10ms
in the apparent time that i2c_transfer() takes. 10ms, not 10us. So,
unless you actually obtain timestamps before and after the
i2c_transfer() call and calculate their difference, I would not read
too much into that.

In any case, figures in the realms of milliseconds are certainly in the
realm of possibility for a 100kHz bus - as I say, one instance of a
transaction _should_ be no less than 840 microseconds, so if your
calculations come out less than that, you should not be claiming
"bad bus" or something like that, but at first revalidating your
analysis or interpretation of the figures.

Also, because of scheduling delays, and some I2C drivers will sleep
waiting for the transaction to finish, even that measurement I
suggest can not be said to relate to the actual time it takes for
the transactions on the bus, unless you're running a hard-realtime OS.

However, it seems you're very keen to blame the I2C bus hardware...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

