Return-Path: <netdev+bounces-224971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB62EB8C528
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 12:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAE767AC039
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 10:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3062283128;
	Sat, 20 Sep 2025 10:02:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay-b03.edpnet.be (relay-b03.edpnet.be [212.71.1.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAF725B31B
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.1.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758362553; cv=none; b=fTWwvuBntIrBf6mhJXIx8xHpMQ8xJouIUAEgL4q0+wGRyoqaJFmoNZLXAHZ4c6sbonB0oAawOHtUjBikJdJEeVVcU/igzDqBgsM2IZZ3h/lum9kONYA4Bvc4FOuQnqBzU/mwC84MRf/kvihk1CSHgqtqMfgiZIbqLQkii+ggk6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758362553; c=relaxed/simple;
	bh=ev/X71/AklW07SMWJLD/MgDaleekMUw8iyOOUIxX/1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Seus2D6LlqmOM6JNFI0kAuk8/HRrCkk5IcrAVfYntEqJRdtAVty/r9C/71AlJg6YeC81PKjCT+0ZpjNn0fijr69uPvmHc1j/a004iIzj6cJtpGFf/FEIC0s2wTxco3rqBfuF6uhqL+wQjYaa2srw51eV1oSBn+1UzkqSKi27v0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kabelmail.de; spf=fail smtp.mailfrom=kabelmail.de; arc=none smtp.client-ip=212.71.1.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kabelmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kabelmail.de
Received: from [192.168.177.65] (94.105.126.5.dyn.edpnet.net [94.105.126.5]) by relay-b03.edpnet.be with ESMTP id s11EBV1lw98x4ZhP; Sat, 20 Sep 2025 12:02:22 +0200 (CEST)
X-Barracuda-Envelope-From: janpieter.sollie@kabelmail.de
X-Barracuda-Effective-Source-IP: 94.105.126.5.dyn.edpnet.net[94.105.126.5]
X-Barracuda-Apparent-Source-IP: 94.105.126.5
Message-ID: <f86737b0-a0fe-49a6-aeca-9e51fbdf0f0d@kabelmail.de>
Date: Sat, 20 Sep 2025 12:00:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] increase MDIO i2c poll timeout gradually (including patch)
To: Andrew Lunn <andrew@lunn.ch>
X-ASG-Orig-Subj: Re: [RFC] increase MDIO i2c poll timeout gradually (including patch)
Cc: netdev@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <971aaa4c-ee1d-4ca1-ba38-d65db776d869@kabelmail.de>
 <cbc4a620-36d3-409b-a248-a2b4add0016a@lunn.ch>
Content-Language: en-US
From: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Autocrypt: addr=janpieter.sollie@kabelmail.de; keydata=
 xsBNBFhRXM0BCADnifwYnfbhQtJso1eeT+fjEDJh8OY5rwfvAbOhHyy003MJ82svXPmM/hUS
 C6hZjkE4kR7k2O2r+Ev6abRSlM6s6rJ/ZftmwOA7E8vdSkrFDNqRYL7P18+Iq/jM/t/6lsZv
 O+YcjF/gGmzfOCZ5AByQyLGmh5ZI3vpqJarXskrfi1QiZFeCG4H5WpMInml6NzeTpwFMdJaM
 JCr3BwnCyR+zeev7ROEWyVRcsj8ufW8ZLOrML9Q5QVjH7tkwzoedOc5UMv80uTaA5YaC1GcZ
 57dAna6S1KWy5zx8VaHwXBwbXhDHWvZP318um2BxeTZbl21yXJrUMbYpaoLJzA5ZaoCFABEB
 AAHNMEphbnBpZXRlciBTb2xsaWUgPGphbnBpZXRlci5zb2xsaWVAa2FiZWxtYWlsLmRlPsLA
 jgQTAQgAOAIbIwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBGBBYpsrUd7LDG6rUrFUjEUP
 H5JbBQJoLGc9AAoJELFUjEUPH5Jb9qoIAKzdJWg5FNhGTDNevUvVEgfJLEbcL7tM97FL9qNK
 WV6fwyoXUM4eTabSqcq2JVbqR4pNur2i7OSPvF3a/VRhl2I0qMcFz8/08hVgFG55iBI9Rdwl
 sn3b37KzwdGR7RX5cRt83ST76riKVdEsB/EKeU88/i9utWmT7M8HaqvKw16qhcs2i2hAuM9T
 wNmLt+l65sFMZcgY2+3pne8X1DRj6c9aQ3IBUcKMsB977P2aiss0xQrJ4CqSG3Tgjtzw0c7F
 BuamFq8FIzAtTwRnjxHtqYVUnFLLMu7INfdcQuW2Q2eZHO6+X80QlL+uMDirXB+EbHKZcrU4
 EN13bLOk6OG5ODLOwU0EaCxqtwEQAOfQzQMy61HqB1NL4rWCCI3fG131Da4iyMceOuMntmZx
 9EomthdZRiunLffjMcN7aBcgr4wCh2tNar0hpUkkPpnM/Lat+avTZBkaSmuSF52ukmkVZLEE
 +jPy33hTWkc+k2pJ91XvLVU9axtd33XDBL6bP2oNmG+QF8hfN7QzukWzI52EdzF+DYgt08te
 875abopdtZa/csYO51uqGg5zBjixylZ48pB9o5lWM6h1HSlBoHGBHh3u2ptxyxqTGQYOX+MR
 QEJElLV7ydJSWmm+3cSza3z2BtwyfjKUPzgHXQEBhPQdTalH4cZeJQGi3Zxhy4iQBGpvg1nW
 msd2//x0FRSHkZtzTVaTCTuf0kHhqiQ8a50B6YDJiTC5koH0hp72Fz2SQoFBcDpUFkNzBWng
 Ju9o1LBGd69c7AvOgMYZxDWwvDyb2sUfPJX0V4f+jJUjffO1K+PTrtnq2gpHKjBZHgGUvG4w
 36Juy5BFr7TDDRt5rZGN26Tcs4Nq4EZTjyE6QuJOtA5iyJQo3ZwqQ5d9apyStPBJC1CnBZCo
 kCbRrIbLgqe+mCgXhQngj3QZUZn8qmDB2VHEDmSdkJ4A9qKyiof9uRhmAH287uQ/i342xuUM
 8raS/RGFQaNCV2bBGKqflpS9l1BKGyevk2MUw/IGKJOYfXYc6L5RoPLSlkseBdSpABEBAAHC
 wHwEGAEIACYWIQRgQWKbK1Heywxuq1KxVIxFDx+SWwUCaCxqtwIbDAUJCWYBgAAKCRCxVIxF
 Dx+SW62eB/0SdagAw65x1IEwtEbdo4qxTL/a2iShsMvFOZYt/UE8fDTMkyTJFlDnxHDJqiHR
 0yHpt41+CGxt5z8xhd+4HE+NdQJD2rjvvk5A2C8baOQYv8Mb5I4iDjSuYJWjrAwjCo25oHo7
 CtoMd2jhn3+L1BO8/VY+AjdVXpGqPzor6Q/c5XAfUsgA2/2VEUpXLp8xKr7v/Gn08zUqaT+W
 90QjvK1gwYv7sQ4X0w7kzf3sgQvN64cjo0jVsC3EG1AfdLtc+213+3dzDLqomtWtqoxmnrqx
 oMdve2PL2byHDAtzeWGGM38JB4H6A0VlvUyGqgAnRS/UyOLPpqNYbi1lPemVHZsk
In-Reply-To: <cbc4a620-36d3-409b-a248-a2b4add0016a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Barracuda-Connect: 94.105.126.5.dyn.edpnet.net[94.105.126.5]
X-Barracuda-Start-Time: 1758362542
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 4232
X-Barracuda-BRTS-Status: 1
Content-Transfer-Encoding: quoted-printable
X-ASG-Debug-ID: 1758362542-24639c1e2d466b50001-BZBGGp
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=10.0 QUARANTINE_LEVEL=10.0 KILL_LEVEL=7.0 test= 
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125474
	Rule breakdown below
	  pts rule name              description
	 ---- ---------------------- --------------------------------------------------
	

Op 19/09/2025 om 19:04 schreef Andrew Lunn:
> On Fri, Sep 19, 2025 at 03:52:55PM +0200, Janpieter Sollie wrote:
>> Hello everyone,
> Please ensure you Cc: the correct Maintainers.
>
> ./scripts/get_maintainer.pl drivers/net/phy/sfp.c
> Russell King <linux@armlinux.org.uk> (maintainer:SFF/SFP/SFP+ MODULE SU=
PPORT)
> Andrew Lunn <andrew@lunn.ch> (maintainer:ETHERNET PHY LIBRARY)
> Heiner Kallweit <hkallweit1@gmail.com> (maintainer:ETHERNET PHY LIBRARY=
)
> "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
> Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
> Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
> Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
> netdev@vger.kernel.org (open list:SFF/SFP/SFP+ MODULE SUPPORT)
> linux-kernel@vger.kernel.org (open list)
Done, sorry, this is my first post here
>
>> I tested a SFP module where the i2c bus is "unstable" at best.
> Please tell us more about the hardware.
>
> Also, what speed do you have the I2C bus running at? Have you tried
> different clock-frequency values to slow down the I2C bus? Have you
> checked the pull-up resistors? I2C problems are sometimes due to too
> strong pull-ups.
The hardware is a bananapi R4 2xSFP using a MT7988a SoC.
The SFP+ module is a RJ45 rollball module using a AQR113C phy, but needs =
a quirk in sfp.c (added=20
below)
I'm not a i2c expert at all,
but about the i2c bus speed, the SFP cage seems to be behind a muxer, not=
 a i2c root.
I could not find anything about i2c bus speed in /proc or /sys, maybe it'=
s impossible to tell?

The dtsi or dtso files do not mention anything about bus speeds, so I hon=
estly do not know.

>
>> A good question may be: is this approach sufficient to close the gap b=
etween
>> "high performance" equipment having a stable i2c bus and they do not w=
ant to wait,
>> and embedded equipment (the device I tested on was a BPI-R4) where eve=
ry milliwatt counts?
> Does your board actually confirm to the standards? I2C busses should
> be able to run at 100KHz, as defined by the standard. Also, the SFP
> standards define modules should work at 100KHz. And counting every
> milliwatt makes no sense when you are supposed to be able to deliver
> 3.3V at 300mA, i.e. 1 Watt, to the module.
Sorry, I thought the issue here might be the SFP cage limited to 3W.
While it should be enough to feed the RJ45 short range module, maybe it n=
eeds more during=20
initalization.
Is there a way to tell?
>
>> Should this be fixed at another point in the initialization process (e=
g: not
>> probing ridiculously all phy ids)?
> Unfortunately, MDIO over I2C is not standardised. So we have no idea
> what address the PHY will be using, so we need to look at them all. If
> you have an SFF, not an SFP, it might be possible to do some
> optimisation.
>
> 	Andrew
>
Well, that's a bummer.

is it possible to perform stress testing on the bus by randomly reading t=
hose phy registers and=20
check
whether=C2=A0 the muxer is the cause of the instability, or the target de=
vice itself?

Janpieter Sollie


--- a/drivers/net/phy/sfp.c=C2=A0 =C2=A0 =C2=A02025-06-21 15:06:02.086163=
322 +0200
+++ b/drivers/net/phy/sfp.c=C2=A0 =C2=A0 =C2=A02025-06-21 15:59:41.836883=
438 +0200
@@ -422,6 +422,13 @@
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sfp->id.base.extended_cc =3D SFF8024_ECC_10G=
BASE_T_SFI;
 =C2=A0}

+static void sfp_fixup_oem_10gt(struct sfp *sfp)
+{
+=C2=A0 =C2=A0 =C2=A0 =C2=A0sfp_fixup_10gbaset_30m(sfp);
+=C2=A0 =C2=A0 =C2=A0 =C2=A0sfp_fixup_rollball_wait4s(sfp);
+=C2=A0 =C2=A0 =C2=A0 =C2=A0//sfp->module_t_wait =3D msecs_to_jiffies(100=
00);
+}
+
 =C2=A0static void sfp_quirk_2500basex(const struct sfp_eeprom_id *id,
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long *modes,
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long *interfaces)
@@ -516,6 +523,7 @@
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SFP_QUIRK_F("OEM", "SFP-GE-T", sfp_fixup_ign=
ore_tx_fault),

 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_ro=
llball_cc),
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SFP_QUIRK_F("OEM", "ZK-10G-TX", sfp_fixup_oem=
_10gt),
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_o=
em_2_5g),
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SFP_QUIRK_M("OEM", "SFP-2.5G", sfp_quirk_oem=
_2_5g),
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-D", sfp_qu=
irk_2500basex),

