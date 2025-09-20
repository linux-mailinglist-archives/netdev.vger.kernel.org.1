Return-Path: <netdev+bounces-224991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FABB8C844
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 14:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A82620B0B
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 12:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3B51A2C11;
	Sat, 20 Sep 2025 12:36:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay-b03.edpnet.be (relay-b03.edpnet.be [212.71.1.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C8F7082F
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 12:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.1.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758371780; cv=none; b=JfPeTWWSyh4Jr470OBy/NY4XflxNDY6bBlmWXvl2P3Y4+NP1ot+fjdEVkWmafw+nFYYwpNlPrJPR2LGdI9fMgUsZQyInKGJZ48Jea5I4jqG4BgWDam9VFEP9dejljbRL5GcW42080CHSxONMOtzmpD5WtuyjZsGKXx1f/co/8NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758371780; c=relaxed/simple;
	bh=YwlRl2/8bKcUxKOf7oMT89bWQLAdrhRivkloI89JbPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdBSR37jrRQNuI5lW/QvFOLZe29o7iQjWXWVem43X8MDEvm0D6CFUfHAy4uXUj6CKmBv/M3LSLsDDZJ7DEZCMwr8iIYKpZioCMneEatUYY5BKZksYN7oVcQ+ZjPU3buos4Gtqe+XXAWUZtOnAVzaxn4aQNhlixnxf1SDhbJNIFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kabelmail.de; spf=fail smtp.mailfrom=kabelmail.de; arc=none smtp.client-ip=212.71.1.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kabelmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kabelmail.de
Received: from [192.168.177.65] (94.105.126.5.dyn.edpnet.net [94.105.126.5]) by relay-b03.edpnet.be with ESMTP id rVBDcIDyGTlRu6lf; Sat, 20 Sep 2025 14:36:12 +0200 (CEST)
X-Barracuda-Envelope-From: janpieter.sollie@kabelmail.de
X-Barracuda-Effective-Source-IP: 94.105.126.5.dyn.edpnet.net[94.105.126.5]
X-Barracuda-Apparent-Source-IP: 94.105.126.5
Message-ID: <1e9c7da5-4ace-476d-8a4b-b05bc44eedf1@kabelmail.de>
Date: Sat, 20 Sep 2025 14:34:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] increase MDIO i2c poll timeout gradually (including patch)
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
X-ASG-Orig-Subj: Re: [RFC] increase MDIO i2c poll timeout gradually (including patch)
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <971aaa4c-ee1d-4ca1-ba38-d65db776d869@kabelmail.de>
 <cbc4a620-36d3-409b-a248-a2b4add0016a@lunn.ch>
 <f86737b0-a0fe-49a6-aeca-9e51fbdf0f0d@kabelmail.de>
 <aM6Ng7tnEYdWmI1F@shell.armlinux.org.uk>
Content-Language: nl
From: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Autocrypt: addr=janpieter.sollie@kabelmail.de; keydata=
 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
In-Reply-To: <aM6Ng7tnEYdWmI1F@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Barracuda-Connect: 94.105.126.5.dyn.edpnet.net[94.105.126.5]
X-Barracuda-Start-Time: 1758371772
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 4737
X-Barracuda-BRTS-Status: 1
Content-Transfer-Encoding: quoted-printable
X-ASG-Debug-ID: 1758371772-24639c1e2f48e430001-BZBGGp
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=10.0 QUARANTINE_LEVEL=10.0 KILL_LEVEL=7.0 test= 
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125474
	Rule breakdown below
	  pts rule name              description
	 ---- ---------------------- --------------------------------------------------
	

Op 20/09/2025 om 13:18 schreef Russell King (Oracle):
> On Sat, Sep 20, 2025 at 12:00:50PM +0200, Janpieter Sollie wrote:
>> Op 19/09/2025 om 19:04 schreef Andrew Lunn:
>>> On Fri, Sep 19, 2025 at 03:52:55PM +0200, Janpieter Sollie wrote:
>>>> Hello everyone,
>>> Please ensure you Cc: the correct Maintainers.
>>>
>>> ./scripts/get_maintainer.pl drivers/net/phy/sfp.c
>>> Russell King <linux@armlinux.org.uk> (maintainer:SFF/SFP/SFP+ MODULE =
SUPPORT)
>>> Andrew Lunn <andrew@lunn.ch> (maintainer:ETHERNET PHY LIBRARY)
>>> Heiner Kallweit <hkallweit1@gmail.com> (maintainer:ETHERNET PHY LIBRA=
RY)
>>> "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVER=
S)
>>> Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
>>> Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
>>> Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
>>> netdev@vger.kernel.org (open list:SFF/SFP/SFP+ MODULE SUPPORT)
>>> linux-kernel@vger.kernel.org (open list)
>> Done, sorry, this is my first post here
>>>> I tested a SFP module where the i2c bus is "unstable" at best.
>>> Please tell us more about the hardware.
>>>
>>> Also, what speed do you have the I2C bus running at? Have you tried
>>> different clock-frequency values to slow down the I2C bus? Have you
>>> checked the pull-up resistors? I2C problems are sometimes due to too
>>> strong pull-ups.
>> The hardware is a bananapi R4 2xSFP using a MT7988a SoC.
>> The SFP+ module is a RJ45 rollball module using a AQR113C phy, but nee=
ds a
>> quirk in sfp.c (added below)
>> I'm not a i2c expert at all,
>> but about the i2c bus speed, the SFP cage seems to be behind a muxer, =
not a i2c root.
>> I could not find anything about i2c bus speed in /proc or /sys, maybe =
it's impossible to tell?
>>
>> The dtsi or dtso files do not mention anything about bus speeds, so I =
honestly do not know.
> As you have not include the author of the SFP support (me) in your
> initial email, and have not provided a repeat of the description,
> I'm afraid I have no idea what the issue is that you're encountering.
>
> Thanks.
>

Yes indeed, I see it too.

Hereby the original post:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Hello everyone,

I tested a SFP module where the i2c bus is "unstable" at best.
different i2c timeouts occured, resulting in a "phy not detected" error m=
essage.
A simple (but not revealing a lot) stack dump during probe::

 > mdio_i2c_alloc (drivers/net/mdio/mdio-i2c.c:268) mdio_i2c
 > mdio_i2c_alloc (drivers/net/mdio/mdio-i2c.c:316) mdio_i2c
 > __mdiobus_c45_read (drivers/net/phy/mdio_bus.c:992)
 > mdiobus_c45_read (drivers/net/phy/mdio_bus.c:1133)
 > get_phy_c45_ids (drivers/net/phy/phy_device.c:947)
 > get_phy_device (drivers/net/phy/phy_device.c:1054)
 > init_module (drivers/net/phy/sfp.c:1820) sfp
 > cleanup_module (drivers/net/phy/sfp.c:1956 drivers/net/phy/sfp.c:2667=20
drivers/net/phy/sfp.c:2748) sfp
 > cleanup_module (drivers/net/phy/sfp.c:2760 drivers/net/phy/sfp.c:2892)=
 sfp
 > process_one_work (./arch/arm64/include/asm/jump_label.h:32 ./include/l=
inux/jump_label.h:207)
 > worker_thread (kernel/workqueue.c:3304 (discriminator 2) kernel/workqu=
eue.c:3391=20
(discriminator 2))
 > kthread (kernel/kthread.c:389)
 > ret_from_fork (arch/arm64/kernel/entry.S:863)

I noticed a few hard-coded numbers in i2c_rollball_mii_pol(), which is al=
ways suspicious.
In order to lower the stress on the i2c bus, I made the following patch.
is it the best way to "not-stress-sensitive-devices"?
Will it cause a performance regression on some other SFP cages?

Eric Woudstra told me another option was to add a few tries, increasing i=
 =3D 10,
If the issue isn't the device itself, but the stress on the i2c bus is to=
o high, it may not be a=20
real solution.

A good question may be: is this approach sufficient to close the gap betw=
een
"high performance" equipment having a stable i2c bus and they do not want=
 to wait,
and embedded equipment (the device I tested on was a BPI-R4) where every =
milliwatt counts?
Should this be fixed at another point in the initialization process (eg: =
not probing=20
ridiculously all phy ids)?

Thanks,

Janpieter Sollie

--- a/drivers/net/mdio/mdio-i2c.c=C2=A0 =C2=A0 =C2=A0 =C2=A02025-09-19 14=
:08:41.285357818 +0200
+++ b/drivers/net/mdio/mdio-i2c.c=C2=A0 =C2=A0 =C2=A0 =C2=A02025-09-19 14=
:10:24.962796149 +0200
@@ -253,7 +253,7 @@ static int i2c_rollball_mii_poll(struct mii_bus *bus,=
 int bus_addr, u8 *buf,
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D 10;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do {
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msleep(20);
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msleep(20+(10*(10=
-i)));

 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_tran=
sfer_rollball(i2c, msgs, ARRAY_SIZE(msgs));
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)

