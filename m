Return-Path: <netdev+bounces-224779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DFFB89BD5
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 15:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E645A2FA2
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 13:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E812219A7D;
	Fri, 19 Sep 2025 13:54:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay-b01.edpnet.be (relay-b01.edpnet.be [212.71.1.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496831A9F91
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.1.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758290080; cv=none; b=DE4IpiPWNm/1YVPGFvj3uc698ASzQWzUtjJm60H8NmJRXOPFbKLuKnQBY9mhBQVOzz0N5+EV6HXIkhwTyezz9b7Afwduj5hf1Jp4cdn6YQUwwG3U3Ysm7JAvwXeNg0p49+Hlihb+28Vkvu5dn4EA8aC0OsagjuXw96lSIIc+F3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758290080; c=relaxed/simple;
	bh=ErxY+JOK/byq/YbDMDvIEWk7wW5VgEpH0fRFhIlpj7Y=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=j1RYFjRdGfLUyfYfKaDhhqD7LQEFU6VfKnuvdiw5pCzmzvLyw0nwkq0huI/NJBBOqbSWAp+ELyNVfbsZroqk0Z0KyKPas/BDmMIHwwQe6RVvMUQ8B5FqhJ5p8LXbyFgE95z864QMNuIjM+QPD+Kz8xuCZ5vXz07963Y59iuHem8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kabelmail.de; spf=fail smtp.mailfrom=kabelmail.de; arc=none smtp.client-ip=212.71.1.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kabelmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kabelmail.de
Received: from [192.168.177.65] (94.105.126.5.dyn.edpnet.net [94.105.126.5]) by relay-b01.edpnet.be with ESMTP id xHOQLIwjECVmSY9L for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 15:54:27 +0200 (CEST)
X-Barracuda-Envelope-From: janpieter.sollie@kabelmail.de
X-Barracuda-Effective-Source-IP: 94.105.126.5.dyn.edpnet.net[94.105.126.5]
X-Barracuda-Apparent-Source-IP: 94.105.126.5
Message-ID: <971aaa4c-ee1d-4ca1-ba38-d65db776d869@kabelmail.de>
Date: Fri, 19 Sep 2025 15:52:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
From: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Subject: [RFC] increase MDIO i2c poll timeout gradually (including patch)
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
X-ASG-Orig-Subj: [RFC] increase MDIO i2c poll timeout gradually (including patch)
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Barracuda-Connect: 94.105.126.5.dyn.edpnet.net[94.105.126.5]
X-Barracuda-Start-Time: 1758290067
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2514
X-Barracuda-BRTS-Status: 1
Content-Transfer-Encoding: quoted-printable
X-ASG-Debug-ID: 1758290067-2392341bde312330001-BZBGGp
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=10.0 QUARANTINE_LEVEL=10.0 KILL_LEVEL=7.0 test= 
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125474
	Rule breakdown below
	  pts rule name              description
	 ---- ---------------------- --------------------------------------------------
	

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

