Return-Path: <netdev+bounces-243108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 68164C99969
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 00:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0FD0A34612F
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 23:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E97292B44;
	Mon,  1 Dec 2025 23:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="e5LLNboC"
X-Original-To: netdev@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A7A288C0A
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 23:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764631575; cv=none; b=EYfHUR8ZgU3af3ci8W0gVn5FEYlOD1nVbpWyF2/izUt+ZNgGRRTM6jXev/lIPmMwrm5UYxy9IRDkBrbIPFb47Xa0DJpN1ul+ENNM4Z9+ZJ3acDsbqXd9+9vAjFc1RgGi3uqc3D8NRH+f6WVpUscMo6rzPB4vbrOJQi4opeGXc6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764631575; c=relaxed/simple;
	bh=IhuUFkTAQn3HCdO39MmbD7c+eYJC+M1vZulcshkUlLM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KjCinNmLrVdpkJZFlL7lczBLTiIu5J0BovDLrO2NOpQmcOK789z4/CJgPZMNdzqNeBFnE+nBTTmhdcp6KLheD7gShB7CducdxasrP4c0FN0nUx5WHgFSvjpKw/oLFbE1AtqOEF/jbiXDJDrhob4FZpUz7hlv+SORguROaO+kSag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=e5LLNboC; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To
	:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LPnA3kADe2K1Wgkbb5NFyb/5G1fkzt32O2p1kgxqgyY=; b=e5LLNboCHrpZ9NU76nzX52hPuQ
	B5J9rXUROSPYzC1oYLfhMHnIXYGK0ZZAN333eNNWemtOaXitAkVeExoDST3Z3bj0klQ9rz5pVo5ut
	y7k9QZMyv4ck4J9z5eRf+QQbQxzTKEP41llF9Zz1JmQwxRkdN2pLPqEi/7xB5vFpO/wGE1gZTBSyj
	KfYtnMJ+p0+yIwa0aCcg+JUBNaabrNq+tGe7HOeUxfaBFouJwKccg1Xx5oXbbgOuWrTkrdcRks5Kq
	jar3wWaMpkMyIn0rTDsHoH0XZIJp0ZwtkfqrJP7kBNJgI6vp/McHRCyhFzwa9Uw17D6GVU946/6si
	Y0B+m64Q==;
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] r8169: fix RTL8117 Wake-on-Lan in DASH mode
From: =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
In-Reply-To: <76d62393-0ec5-44c9-9f5c-9ab872053e95@gmail.com>
Date: Tue, 2 Dec 2025 00:26:06 +0100
Cc: netdev@vger.kernel.org,
 nic_swsd@realtek.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9F5C55F0-84EC-48C2-94E2-7729A569C8CA@exactco.de>
References: <20251201.201706.660956838646693149.rene@exactco.de>
 <8bee22b7-ed4c-43d1-9bf2-d8397b5e01e5@gmail.com>
 <B31500F7-12DF-4460-B3D5-063436A215E4@exactco.de>
 <76d62393-0ec5-44c9-9f5c-9ab872053e95@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

Hi,

> On 1. Dec 2025, at 22:12, Heiner Kallweit <hkallweit1@gmail.com> =
wrote:
>=20
> On 12/1/2025 9:31 PM, Ren=C3=A9 Rebe wrote:
>> Hi
>>=20
>>> On 1. Dec 2025, at 21:15, Heiner Kallweit <hkallweit1@gmail.com> =
wrote:
>>>=20
>>> On 12/1/2025 8:17 PM, Ren=C3=A9 Rebe wrote:
>>>> Wake-on-Lan does currently not work in DASH mode, e.g. the ASUS Pro =
WS
>>>> X570-ACE with RTL8168fp/RTL8117.
>>>>=20
>>>> Fix by not returning early in rtl_prepare_power_down when =
dash_enabled.
>>> Good
>>>=20
>>>> While this fixes WOL, it still kills the OOB RTL8117 remote =
management
>>>> BMC connection. Fix by not calling rtl8168_driver_stop if wol is =
enabled.
>>>>=20
>>> You mean remote management whilst system is powered down and waiting
>>> for a WoL packet? Note that link speed is reduced to a minimum then,
>>> and DMA is disabled. Who would drive the MAC?
>>> Realtek doesn't provide any chip documentation, therefore it's hard =
to
>>> say what is expected from the MAC driver in DASH case.
>>=20
>> This RTL8117 has a 250 or 400 MHz MIPS cpu inside that runs
>> a out-of-band linux kernel. Pretty sketchy low-quality setup =
unfortunately:
>>=20
>> https://www.youtube.com/watch?v=3DYqEa8Gd1c2I&t=3D1695s
>>>=20
>>>> While at it, enable wake on magic packet by default, like most =
other
>>>> Linux drivers do.
>>>>=20
>>> It's by intent that WoL is disabled per default. Most users don't =
use WoL
>>> and would suffer from higher power consumption if system is =
suspended
>>> or powered down.
>>=20
>> It was just a suggestion, I can use ethtool, it is the only driver =
that does
>> not have it on by default in all the systems I have.
>>=20
>>> Which benefit would you see if WoL would be enabled by default
>>> (in DASH and non-DASH case)?
>>=20
>> So it just works when pro-sumers want to wake it up, not the most
>> important detail of the patch.
>>=20
>>>> Signed-off-by: Ren=C3=A9 Rebe <rene@exactco.de>
>>>=20
>>> Your patch apparently is meant to be a fix. Therefore please add =
Fixes
>>> tag and address to net tree.
>>> https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.rst
>>> And please add all netdev maintainers when re-submitting.
>>> scripts/get_maintainer.pl provides all needed info.
>>=20
>> Yes, I realized after sending. The only Fixes: would be the original
>> change adding the DASH support I assume?
>>=20
>> Any opinion re not stopping DASH on if down? IMHO taking a
>> link down should not break the remote management connection.
>>=20
> I have no clue how the OOB BMC interacts with MAC/PHY, and I have no
> hw supporting DASH to test. So not really a basis for an opinion.
> However: DASH has been existing on Realtek hw for at least 15 yrs,
> and I'm not aware of any complaint related to what you mention.
> So it doesn't seem to be a common use case.

Well the Asus Control Center Express is so bad and barely working
it does not surprise me nobody is using it. We reversed the protocol
and wrote some script and hacked VNC client to make it useful for us.

The Asus GPL compliance code dump for the MIPS Linux BMC system
has some rtl8168_oob or so BMC side driver for it to learn more details.

Maybe I should backup a fork of it on my GitHub to archive it.

Given the BMC should be reachable, would be acceptable if I work
out a patch to not take the phy down and always keep it up even
for if down and module unload when in =E2=80=9Cdash=E2=80=9D mode?

> There are different generations of DASH in RTL8168DP, RTL8168EP,
> RTL8117, variants of RTL8125, RTL8127 etc. Having said that,
> there's a certain chance of a regression, even if the patch works
> correctly on your system. Therefore I'd prefer to handle any =
additional
> changes in separate patches, to facilitate bisecting in case of a
> regression.

Of course, will sent separate patches for each topic.

What about defaulting to wol by magic like most other linux
drivers? IMHO the drivers should all be have similar and not
all have some other defaults. In theory it could be made
a tree-wide kconfig if users and distros care enough what the
global default should be.

	Ren=C3=A9

>> I probably would need to single step thru the driver init to find out
>> what reset stops the out of band traffic there, too.
>>=20
>> Ren=C3=A9
>>=20
>>>> ---
>>>>=20
>>>> There is still another issue that should be fixed: the dirver init
>>>> kills the OOB BMC connection until if up, too. We also should =
probaly
>>>> not even conditionalize rtl8168_driver_stop on wol_enabled as the =
BMC
>>>> should always be accessible. IMHO even on module unload.
>>>>=20
>>>> ---
>>>> drivers/net/ethernet/realtek/r8169_main.c | 9 +++++----
>>>> 1 file changed, 5 insertions(+), 4 deletions(-)
>>>>=20
>>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c =
b/drivers/net/ethernet/realtek/r8169_main.c
>>>> index 853aabedb128..e2f9b9027fe2 100644
>>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>>> @@ -2669,9 +2669,6 @@ static void rtl_wol_enable_rx(struct =
rtl8169_private *tp)
>>>>=20
>>>> static void rtl_prepare_power_down(struct rtl8169_private *tp)
>>>> {
>>>> - if (tp->dash_enabled)
>>>> - return;
>>>> -
>>>> if (tp->mac_version =3D=3D RTL_GIGA_MAC_VER_32 ||
>>>>   tp->mac_version =3D=3D RTL_GIGA_MAC_VER_33)
>>>> rtl_ephy_write(tp, 0x19, 0xff64);
>>>> @@ -4807,7 +4804,7 @@ static void rtl8169_down(struct =
rtl8169_private *tp)
>>>> rtl_disable_exit_l1(tp);
>>>> rtl_prepare_power_down(tp);
>>>>=20
>>>> - if (tp->dash_type !=3D RTL_DASH_NONE)
>>>> + if (tp->dash_type !=3D RTL_DASH_NONE && !tp->saved_wolopts)
>>>> rtl8168_driver_stop(tp);
>>>> }
>>>>=20
>>>> @@ -5406,6 +5403,7 @@ static int rtl_init_one(struct pci_dev *pdev, =
const struct pci_device_id *ent)
>>>> tp->pci_dev =3D pdev;
>>>> tp->supports_gmii =3D ent->driver_data =3D=3D RTL_CFG_NO_GBIT ? 0 : =
1;
>>>> tp->ocp_base =3D OCP_STD_PHY_BASE;
>>>> + tp->saved_wolopts =3D WAKE_MAGIC;
>>>>=20
>>>> raw_spin_lock_init(&tp->mac_ocp_lock);
>>>> mutex_init(&tp->led_lock);
>>>> @@ -5565,6 +5563,9 @@ static int rtl_init_one(struct pci_dev *pdev, =
const struct pci_device_id *ent)
>>>> if (rc)
>>>> return rc;
>>>>=20
>>>> + if (tp->saved_wolopts)
>>>> + __rtl8169_set_wol(tp, tp->saved_wolopts);
>>>> +
>>>> rc =3D register_netdev(dev);
>>>> if (rc)
>>>> return rc;
>>>=20
>>=20
>=20

--=20
https://exactco.de =E2=80=A2 https://t2linux.com =E2=80=A2 =
https://patreon.com/renerebe


