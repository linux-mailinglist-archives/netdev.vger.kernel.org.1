Return-Path: <netdev+bounces-243058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D068C9908A
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 21:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFED3A4828
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 20:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833B62147F9;
	Mon,  1 Dec 2025 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="fFVxY83o"
X-Original-To: netdev@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B624936D50A
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764621091; cv=none; b=LlqWeAeFqkfOjwLyob+uZVD8pvVgXQnjBC2hY1NeC39rtotBjH8BhH0cRT3ss5eQiwE1LeX+C8qZeLNWluGyfBHt++LEwq3cvatvEuaKCSEsUh+JG97Gn8PXU47H2eBy2N8e8qbjTzqiu0XUXaxtPNIOmTbAgeJlukXCuytMOa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764621091; c=relaxed/simple;
	bh=wEkDzz1PQQoPW4MgYe4N3DYGfQjREa3Vhc0lwTxZcfk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mVivTcbmmxo1+7cMXuNV9+DvJ/4JSOJg7PgeBcWdMWuuDuONEF2vgNdbgD8FdIOAzJRgB6D3mXTw7YGCPGuJy+DXmOEnbPmrv5RDl2fxY4vlVqIvdDNnCO6ec4P4z6fhKOYaq62OpqwXgZF4vco29yZPD875lCph1kYTNlu7EOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=fFVxY83o; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To
	:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NtGO6Mp5+QGlrhGCOvLeF8L2wQBIpY/4os0UbyIOh0Q=; b=fFVxY83o/2NYcq0Ty/+4Vl4IOl
	elC4GOgTQq/sOdtU0JFnjitwwmCh/NmbQlMmyzfLoCdG7xN4iSpCLAgD7IoP5Lq2LyuqpODMxdZv3
	y5ElOWb9shyY9fYG6HZLQv1g4ZsXqTuI88pmpCeQtqxE1wwnvLhXJuXsV9fe08xne4liVP8ONTzs0
	Si7op2Von+RaMZGBolXXNwi7rfBkLly2LlT8Qw0tMZtnPjK1E3q2ZQmhdSLWv/K9o8XTZla5Y82NP
	7EpyimBg3+s1x+WY4q7GhVdk93nN/RN0WCc8N4roWtphuQW0ZbNLnCHmYX3bYS7tjxwYa+31EEtwV
	30k2AJkA==;
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
In-Reply-To: <8bee22b7-ed4c-43d1-9bf2-d8397b5e01e5@gmail.com>
Date: Mon, 1 Dec 2025 21:31:23 +0100
Cc: netdev@vger.kernel.org,
 nic_swsd@realtek.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B31500F7-12DF-4460-B3D5-063436A215E4@exactco.de>
References: <20251201.201706.660956838646693149.rene@exactco.de>
 <8bee22b7-ed4c-43d1-9bf2-d8397b5e01e5@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

Hi

> On 1. Dec 2025, at 21:15, Heiner Kallweit <hkallweit1@gmail.com> =
wrote:
>=20
> On 12/1/2025 8:17 PM, Ren=C3=A9 Rebe wrote:
>> Wake-on-Lan does currently not work in DASH mode, e.g. the ASUS Pro =
WS
>> X570-ACE with RTL8168fp/RTL8117.
>>=20
>> Fix by not returning early in rtl_prepare_power_down when =
dash_enabled.
> Good
>=20
>> While this fixes WOL, it still kills the OOB RTL8117 remote =
management
>> BMC connection. Fix by not calling rtl8168_driver_stop if wol is =
enabled.
>>=20
> You mean remote management whilst system is powered down and waiting
> for a WoL packet? Note that link speed is reduced to a minimum then,
> and DMA is disabled. Who would drive the MAC?
> Realtek doesn't provide any chip documentation, therefore it's hard to
> say what is expected from the MAC driver in DASH case.

This RTL8117 has a 250 or 400 MHz MIPS cpu inside that runs
a out-of-band linux kernel. Pretty sketchy low-quality setup =
unfortunately:

	https://www.youtube.com/watch?v=3DYqEa8Gd1c2I&t=3D1695s
>=20
>> While at it, enable wake on magic packet by default, like most other
>> Linux drivers do.
>>=20
> It's by intent that WoL is disabled per default. Most users don't use =
WoL
> and would suffer from higher power consumption if system is suspended
> or powered down.

It was just a suggestion, I can use ethtool, it is the only driver that =
does
not have it on by default in all the systems I have.

> Which benefit would you see if WoL would be enabled by default
> (in DASH and non-DASH case)?

So it just works when pro-sumers want to wake it up, not the most
important detail of the patch.

>> Signed-off-by: Ren=C3=A9 Rebe <rene@exactco.de>
>=20
> Your patch apparently is meant to be a fix. Therefore please add Fixes
> tag and address to net tree.
> https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.rst
> And please add all netdev maintainers when re-submitting.
> scripts/get_maintainer.pl provides all needed info.

Yes, I realized after sending. The only Fixes: would be the original
change adding the DASH support I assume?

Any opinion re not stopping DASH on if down? IMHO taking a
link down should not break the remote management connection.

I probably would need to single step thru the driver init to find out
what reset stops the out of band traffic there, too.

	Ren=C3=A9

>> ---
>>=20
>> There is still another issue that should be fixed: the dirver init
>> kills the OOB BMC connection until if up, too. We also should probaly
>> not even conditionalize rtl8168_driver_stop on wol_enabled as the BMC
>> should always be accessible. IMHO even on module unload.
>>=20
>> ---
>> drivers/net/ethernet/realtek/r8169_main.c | 9 +++++----
>> 1 file changed, 5 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c =
b/drivers/net/ethernet/realtek/r8169_main.c
>> index 853aabedb128..e2f9b9027fe2 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -2669,9 +2669,6 @@ static void rtl_wol_enable_rx(struct =
rtl8169_private *tp)
>>=20
>> static void rtl_prepare_power_down(struct rtl8169_private *tp)
>> {
>> - if (tp->dash_enabled)
>> - return;
>> -
>> if (tp->mac_version =3D=3D RTL_GIGA_MAC_VER_32 ||
>>    tp->mac_version =3D=3D RTL_GIGA_MAC_VER_33)
>> rtl_ephy_write(tp, 0x19, 0xff64);
>> @@ -4807,7 +4804,7 @@ static void rtl8169_down(struct rtl8169_private =
*tp)
>> rtl_disable_exit_l1(tp);
>> rtl_prepare_power_down(tp);
>>=20
>> - if (tp->dash_type !=3D RTL_DASH_NONE)
>> + if (tp->dash_type !=3D RTL_DASH_NONE && !tp->saved_wolopts)
>> rtl8168_driver_stop(tp);
>> }
>>=20
>> @@ -5406,6 +5403,7 @@ static int rtl_init_one(struct pci_dev *pdev, =
const struct pci_device_id *ent)
>> tp->pci_dev =3D pdev;
>> tp->supports_gmii =3D ent->driver_data =3D=3D RTL_CFG_NO_GBIT ? 0 : =
1;
>> tp->ocp_base =3D OCP_STD_PHY_BASE;
>> + tp->saved_wolopts =3D WAKE_MAGIC;
>>=20
>> raw_spin_lock_init(&tp->mac_ocp_lock);
>> mutex_init(&tp->led_lock);
>> @@ -5565,6 +5563,9 @@ static int rtl_init_one(struct pci_dev *pdev, =
const struct pci_device_id *ent)
>> if (rc)
>> return rc;
>>=20
>> + if (tp->saved_wolopts)
>> + __rtl8169_set_wol(tp, tp->saved_wolopts);
>> +
>> rc =3D register_netdev(dev);
>> if (rc)
>> return rc;
>=20

--=20
https://exactco.de =E2=80=A2 https://t2linux.com =E2=80=A2 =
https://patreon.com/renerebe


