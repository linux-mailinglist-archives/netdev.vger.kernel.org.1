Return-Path: <netdev+bounces-101723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0CC8FFE0F
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 10:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2121C20F94
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 08:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C1847A6B;
	Fri,  7 Jun 2024 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="SQZzWcsQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594ED15B0F7
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749180; cv=none; b=d2JaS9D0DFPskOBxzhT0p/7cCEP+6dRR+ZuGOY7St7kTZ6eq+7ThnMI68nAZ190TuGklAyghcEyctnl8n72LLURB78ueoB2b1zLu8+CwKAa8tVkW4SP/c7mk3uBChW/68JStXoBE4Rn6Mg89LC0tGHjLD5m17OIuv6Edb8CENkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749180; c=relaxed/simple;
	bh=n7vjazD7vhR6NqyBsdAjqx6OSxyzSA8TWRoNZRP54yo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nhm95iBoMb75TDNDjGKqYSKCTFRZVMt/QwLJ/RY0D5HoCe9iRmcPIv008XSLBm8Msh9NyNP0BjWNufffcTiXxnbhalnvQGD/yPms9BSmJB+D38/+Q4SVhC8zfOWL/fRecfjhNU2ZNaHs/w0W53pYirfjS9KcMc2XD08yVpfzJQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=SQZzWcsQ; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id EF5DE9C542E;
	Fri,  7 Jun 2024 04:32:55 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id sBTE3zoUxnbU; Fri,  7 Jun 2024 04:32:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4B6929C590A;
	Fri,  7 Jun 2024 04:32:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 4B6929C590A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717749173; bh=X7pODirykHMN8FVXO9sjhcKunWq5M3HlLxyn9uIB+uo=;
	h=Message-ID:Date:MIME-Version:From:To;
	b=SQZzWcsQ0P2lfrp1AstvGTVc9GatcoH1i8esMVsRFZwOdexPCY+nIRpH9JNzG7/Qx
	 NwY6cV+hwpwHLDVZoBDnYDuVCdR1ykbaEBLlSEhF0n556vVO+TgYrEBLncGPIWuDcW
	 Vt7zVvb4urg//+ZCtmxdNzrChsv9z8cD8dVv9P/AjHbM4SIc6NkFyXq1E883fzKtFp
	 CC0DKq+jSPidGib3jhPSOC2KNt2q/Jg6QlSUnn86TPfNtW88hJuhOHGLfDaL+xHJfS
	 IVMpD9tHMbbx7bYabtjvXfpLlojdPWHIRgLk6xqJ031eRgxI3Ks/Rk/j9/RiyzxTiY
	 OfI2MVRrP2Cbw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id esO2RC0bjuBv; Fri,  7 Jun 2024 04:32:53 -0400 (EDT)
Received: from [192.168.216.123] (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 13CA39C542E;
	Fri,  7 Jun 2024 04:32:51 -0400 (EDT)
Message-ID: <4bd9b6ba-2455-4456-bb2d-6f638547156d@savoirfairelinux.com>
Date: Fri, 7 Jun 2024 10:32:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/4] net: phy: micrel: add Microchip KSZ 9897
 Switch PHY support
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: Woojung.Huh@microchip.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 UNGLinuxDriver@microchip.com, horms@kernel.org, Tristram.Ha@microchip.com,
 Arun.Ramadoss@microchip.com, netdev@vger.kernel.org
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240604092304.314636-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <BL0PR11MB2913D8FC28BA3569FDADD4A7E7F82@BL0PR11MB2913.namprd11.prod.outlook.com>
 <19eef958-5222-4663-bd94-5a5fb3d65caf@savoirfairelinux.com>
 <BL0PR11MB29133CF39DA619F1AAF1DE95E7FA2@BL0PR11MB2913.namprd11.prod.outlook.com>
 <2e37f014-d9f5-4a09-93b2-81543399d2c4@savoirfairelinux.com>
Content-Language: en-US
In-Reply-To: <2e37f014-d9f5-4a09-93b2-81543399d2c4@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 07/06/2024 10:11, Enguerrand de Ribaucourt wrote:
>=20
> Hello,
>=20
> The exact hardware is a Phycore-i.MX6ULL. ENET2 is directly the=20
> i.MX6ULL's FEC that connects to port 6 of the KSZ9897R (GMAC6) in RMII:
>=20
>  =C2=A0- X_ENET2_TX_CLK -- TX_CLK6
>  =C2=A0- X_ENET2_TX_EN=C2=A0 -- TX_CTL6
>  =C2=A0- X_ENET2_TX_D1=C2=A0 -- TXD6_1
>  =C2=A0- X_ENET2_TX_D0=C2=A0 -- TXD6_0
>  =C2=A0- X_ENET2_RX_EN=C2=A0 -- RX_CTL6
>  =C2=A0- X_ENET2_RX_ER=C2=A0 -- RX_ER6
>  =C2=A0- X_ENET2_RX_D1=C2=A0 -- RXD6_1
>  =C2=A0- X_ENET2_RX_D0=C2=A0 -- RXD6_0
>=20
> The DSA control is using SPI, but not involved in reading the phy_id in=
=20
> my case.
>=20
> This is materialized in my device tree:
>=20
> ```c
> ethernet@20b4000 {
>  =C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "fsl,imx6ul-fec\0fsl,imx6q-fec"=
;
>  =C2=A0=C2=A0=C2=A0=C2=A0...
>  =C2=A0=C2=A0=C2=A0=C2=A0phy-mode =3D "rmii";
>  =C2=A0=C2=A0=C2=A0=C2=A0phy-handle =3D <0x15>;
>  =C2=A0=C2=A0=C2=A0=C2=A0fixed-link {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 speed =3D <0x64>;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 full-duplex;
>  =C2=A0=C2=A0=C2=A0=C2=A0};
> };
>=20
> // MDIO bus is only defined on eth1 but shared with eth2
> ethernet@2188000 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>  =C2=A0=C2=A0=C2=A0=C2=A0mdio {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ...
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ksz9897port5@1 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 com=
patible =3D "ethernet-phy-ieee802.3-c22";
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clo=
ck-names =3D "rmii-ref";
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pha=
ndle =3D <0x15>;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> };
>=20
> spi@2010000 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>  =C2=A0=C2=A0=C2=A0=C2=A0ksz9897@0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "microchip,k=
sz9897";
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ports {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // =
GMAC6
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 por=
t@5 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 reg =3D <0x05>;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 label =3D "cpu";
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ethernet =3D <0x0c>;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 phy-mode =3D "rmii";
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rx-internal-delay-ps =3D <0x5dc>;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fixed-link {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 speed =3D <0x64>;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 full-duplex;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 };
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>  =C2=A0=C2=A0=C2=A0=C2=A0};
> };
> ```
>=20

I also checked using `phy-mode =3D "internal";` on both ends, but ended u=
p=20
with error "Unable to connect to phy".

> Before I implemented the pseudo phy_id, it was read in the generic IEEE=
=20
> clause 22 PHY registers, through the compatible=20
> "ethernet-phy-ieee802.3-c22". That would be implemented in=20
> get_phy_c22_id() in MII_PHYSID1/2 registers at 0x2 of the MDIO device.
>=20
> It is not read through SPI registers 0x6104-0x6105 which are not define=
d=20
> in the datasheet for port 6/7 (section 5.2.2.3):
>  =C2=A0=C2=A0=C2=A0=C2=A0Address: 0xN104, Size: 16 bits, Port N: 1-5
>=20
> Do you have other suggestions to read the phy_id?
>=20
> Thanks for your support,
> Enguerrand de Ribaucourt
>=20
>=20
> On 07/06/2024 00:57, Woojung.Huh@microchip.com wrote:
>> Hi Enguerrand,
>>
>> We still can't reproduce what you observed with KSZ9897.
>>
>> Just to be sure, you accessed PHY register of Port 6 which is GMAC6.
>> It is directly connected to MAC of i.MX6ULL over RMII.
>> I guess the PHY ID access is register 0x6104-0x6105 of KSZ9897.
>> And, return value of PHY ID is 0x0022-0x1561.
>>
>> Correct understanding?
>> > Thanks.
>> Woojung
>>
>>> -----Original Message-----
>>> From: Enguerrand de Ribaucourt <enguerrand.de-
>>> ribaucourt@savoirfairelinux.com>
>>> Sent: Wednesday, June 5, 2024 4:34 AM
>>> To: Woojung Huh - C21699 <Woojung.Huh@microchip.com>
>>> Cc: andrew@lunn.ch; hkallweit1@gmail.com; linux@armlinux.org.uk;
>>> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; horms@kernel.org;=20
>>> Tristram Ha
>>> - C24268 <Tristram.Ha@microchip.com>; Arun Ramadoss - I17769
>>> <Arun.Ramadoss@microchip.com>; netdev@vger.kernel.org
>>> Subject: Re: [PATCH net v5 1/4] net: phy: micrel: add Microchip KSZ 9=
897
>>> Switch PHY support
>>>
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you=20
>>> know the
>>> content is safe
>>>
>>> Hello,
>>>
>>> On 04/06/2024 22:49, Woojung.Huh@microchip.com wrote:
>>>> Hi Enguerrand,
>>>>
>>>> Can you help me to understand your setup? I could see you are using
>>>> =C2=A0=C2=A0 - Host CPU : i.MX6ULL
>>>> =C2=A0=C2=A0 - DSA Switch : KSZ9897R=20
>>>> (https://www.microchip.com/en-us/product/ksz9897)
>>>> =C2=A0=C2=A0 - Host-to-KSZ interface : RGMII for data path & SPI for=
 control
>>>> Based on this, CPU port is either GMAC6 or GMAC7 (Figure 2-1 of [1])
>>>>
>>>> I have two questions for you.
>>>> 1. PHY on CPU port
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Which GMAC (or port number) is connected be=
tween Host CPU and=20
>>>> KSZ9897R?
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 If CPU port is either GMAC6 or GMAC7, it is=
 just a MAC-to-MAC
>>> connection over RGMII.
>>>
>>> I'm using port number 6 as the CPU port for KSZ9897R. GMAC6 is direct=
ly
>>> connected to the MAC of i.MX6ULL (driver is i.MX fec). I'm using RMII
>>> since gigabit is not supported by the i.MX6ULL.
>>>
>>>> 2. PHY ID
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Its PHY ID is different when checking datas=
heet of KSZ9897 and=20
>>>> KSZ8081.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 PHY ID of Port 1-5 of KSZ9897 is 0x0022-0x1=
631 per [1]
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 PHY ID of KSZ8081 is 0x0022-0x0156x per [2]
>>> That's true for port 1-5, however, I found out that the phy_id emitte=
d
>>> by GMAC6 is 0x00221561. It is the same as KSZ8081-revA3 according to =
the
>>> datasheet. I also studied all registers at runtime for a reliable
>>> difference to implement something like ksz8051_ksz8795_match_phy_devi=
ce
>>> between GMAC6 and KSZ8081, but none appeared to me. Following
>>> suggestions by Andrew Lunn, I added this virtual phy_id (0x002217ff) =
to
>>> hardcode in the devicetree. I'm happy with this solution.
>>>>
>>>> Beside patch, you can create a ticket to Microchip site
>>> (https://microchipsupport.force.com/s/supportservice)
>>>> if you think it is easier to solve your problem.
>>> I created a joined ticket for tracking (Case number 01457279).
>>>>
>>>
>>> Thank you very much for your time,
>>>
>>> Enguerrand de Ribaucourt
>>>
>>>> Best regards,
>>>> Woojung
>>>>
>>>> [1]
>>> https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/Produc=
tDocume
>>> nts/DataSheets/KSZ9897R-Data-Sheet-DS00002330D.pdf
>>>> [2] https://www.microchip.com/en-us/product/ksz8081#document-table
>>>>
>>>>> -----Original Message-----
>>>>> From: Enguerrand de Ribaucourt <enguerrand.de-
>>>>> ribaucourt@savoirfairelinux.com>
>>>>> Sent: Tuesday, June 4, 2024 5:23 AM
>>>>> To: netdev@vger.kernel.org
>>>>> Cc: andrew@lunn.ch; hkallweit1@gmail.com; linux@armlinux.org.uk;=20
>>>>> Woojung
>>> Huh
>>>>> - C21699 <Woojung.Huh@microchip.com>; UNGLinuxDriver
>>>>> <UNGLinuxDriver@microchip.com>; horms@kernel.org; Tristram Ha - C24=
268
>>>>> <Tristram.Ha@microchip.com>; Arun Ramadoss - I17769
>>>>> <Arun.Ramadoss@microchip.com>; Enguerrand de Ribaucourt=20
>>>>> <enguerrand.de-
>>>>> ribaucourt@savoirfairelinux.com>
>>>>> Subject: [PATCH net v5 1/4] net: phy: micrel: add Microchip KSZ 989=
7
>>> Switch
>>>>> PHY support
>>>>>
>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you k=
now
>>> the
>>>>> content is safe
>>>>>
>>>>> There is a DSA driver for microchip,ksz9897 which can be controlled
>>>>> through SPI or I2C. This patch adds support for it's CPU ports PHYs=
 to
>>>>> also allow network access to the switch's CPU port.
>>>>>
>>>>> The CPU ports PHYs of the KSZ9897 are not documented in the datashe=
et.
>>>>> They weirdly use the same PHY ID as the KSZ8081, which is a differe=
nt
>>>>> PHY and that driver isn't compatible with KSZ9897. Before this patc=
h,
>>>>> the KSZ8081 driver was used for the CPU ports of the KSZ9897 but th=
e
>>>>> link would never come up.
>>>>>
>>>>> A new driver for the KSZ9897 is added, based on the compatible=20
>>>>> KSZ87XX.
>>>>> I could not test if Gigabit Ethernet works, but the link comes up a=
nd
>>>>> can successfully allow packets to be sent and received with DSA tag=
s.
>>>>>
>>>>> To resolve the KSZ8081/KSZ9897 phy_id conflicts, I could not find a=
ny
>>>>> stable register to distinguish them. Instead of a match_phy_device(=
) ,
>>>>> I've declared a virtual phy_id with the highest value in=20
>>>>> Microchip's OUI
>>>>> range.
>>>>>
>>>>> Example usage in the device tree:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D=
 "ethernet-phy-id0022.17ff";
>>>>>
>>>>> A discussion to find better alternatives had been opened with the
>>>>> Microchip team, with no response yet.
>>>>>
>>>>> See https://lore.kernel.org/all/20220207174532.362781-1-enguerrand.=
de-
>>>>> ribaucourt@savoirfairelinux.com/
>>>>>
>>>>> Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip=20
>>>>> KSZ9477")
>>>>> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-
>>>>> ribaucourt@savoirfairelinux.com>
>>>>> ---
>>>>> v5:
>>>>> =C2=A0=C2=A0 - rewrap comments
>>>>> =C2=A0=C2=A0 - restore suspend/resume for KSZ9897
>>>>> v4: https://lore.kernel.org/all/20240531142430.678198-2-enguerrand.=
de-
>>>>> ribaucourt@savoirfairelinux.com/
>>>>> =C2=A0=C2=A0 - rebase on net/main
>>>>> =C2=A0=C2=A0 - add Fixes tag
>>>>> =C2=A0=C2=A0 - use pseudo phy_id instead of of_tree search
>>>>> v3: https://lore.kernel.org/all/20240530102436.226189-2-enguerrand.=
de-
>>>>> ribaucourt@savoirfairelinux.com/
>>>>> ---
>>>>> =C2=A0=C2=A0 drivers/net/phy/micrel.c=C2=A0=C2=A0 | 13 ++++++++++++=
-
>>>>> =C2=A0=C2=A0 include/linux/micrel_phy.h |=C2=A0 4 ++++
>>>>> =C2=A0=C2=A0 2 files changed, 16 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
>>>>> index 8c20cf937530..11e58fc628df 100644
>>>>> --- a/drivers/net/phy/micrel.c
>>>>> +++ b/drivers/net/phy/micrel.c
>>>>> @@ -16,7 +16,7 @@
>>>>> =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ksz8081, ksz8091,
>>>>> =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ksz8061,
>>>>> =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Switch : ksz8873, ksz886x
>>>>> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ksz9477, lan=
8804
>>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ksz9477, ksz=
9897, lan8804
>>>>> =C2=A0=C2=A0=C2=A0 */
>>>>>
>>>>> =C2=A0=C2=A0 #include <linux/bitfield.h>
>>>>> @@ -5545,6 +5545,16 @@ static struct phy_driver ksphy_driver[] =3D =
{
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .suspend=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D genphy_suspend,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .resume=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D ksz9477_resume,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .get_feature=
s=C2=A0=C2=A0 =3D ksz9477_get_features,
>>>>> +}, {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .phy_id=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D PHY_ID_KSZ9897,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .phy_id_mask=C2=A0=C2=A0=C2=A0=
 =3D MICREL_PHY_ID_MASK,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "Microchip KSZ9897 Switch",
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* PHY_BASIC_FEATURES */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .config_init=C2=A0=C2=A0=C2=A0=
 =3D kszphy_config_init,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .config_aneg=C2=A0=C2=A0=C2=A0=
 =3D ksz8873mll_config_aneg,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .read_status=C2=A0=C2=A0=C2=A0=
 =3D ksz8873mll_read_status,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .suspend=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D genphy_suspend,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .resume=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D genphy_resume,
>>>>> =C2=A0=C2=A0 } };
>>>>>
>>>>> =C2=A0=C2=A0 module_phy_driver(ksphy_driver);
>>>>> @@ -5570,6 +5580,7 @@ static struct mdio_device_id __maybe_unused
>>>>> micrel_tbl[] =3D {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { PHY_ID_LAN=
8814, MICREL_PHY_ID_MASK },
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { PHY_ID_LAN=
8804, MICREL_PHY_ID_MASK },
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { PHY_ID_LAN=
8841, MICREL_PHY_ID_MASK },
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { PHY_ID_KSZ9897, MICREL_PHY_=
ID_MASK },
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { }
>>>>> =C2=A0=C2=A0 };
>>>>>
>>>>> diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.=
h
>>>>> index 591bf5b5e8dc..81cc16dc2ddf 100644
>>>>> --- a/include/linux/micrel_phy.h
>>>>> +++ b/include/linux/micrel_phy.h
>>>>> @@ -39,6 +39,10 @@
>>>>> =C2=A0=C2=A0 #define PHY_ID_KSZ87XX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x00221550
>>>>>
>>>>> =C2=A0=C2=A0 #define=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PHY_=
ID_KSZ9477=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x002216=
31
>>>>> +/* Pseudo ID to specify in compatible field of device tree.
>>>>> + * Otherwise the device reports the same ID as KSZ8081 on CPU port=
s.
>>>>> + */
>>>>> +#define=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PHY_ID_KSZ9897=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x002217ff
>>>>>
>>>>> =C2=A0=C2=A0 /* struct phy_device dev_flags definitions */
>>>>> =C2=A0=C2=A0 #define MICREL_PHY_50MHZ_CLK=C2=A0=C2=A0 BIT(0)
>>>>> --=20
>>>>> 2.34.1
>>>>
>=20

--=20
Savoir-faire Linux
Enguerrand de Ribaucourt
Consultant en logiciel libre / Ing=C3=A9nieur syst=C3=A8mes embarqu=C3=A9=
s | Rennes, Fr
Site web <https://www.savoirfairelinux.com/>=C2=A0|=C2=A0Blog
<https://blog.savoirfairelinux.com/fr-ca/>=C2=A0|=C2=A0Jami <https://jami=
.net/>

Messages de confidentialit=C3=A9 :=C2=A0Ce courriel (de m=C3=AAme que les=
 fichiers
joints) est strictement r=C3=A9serv=C3=A9 =C3=A0 l'usage de la personne o=
u de l'entit=C3=A9
=C3=A0 qui il est adress=C3=A9 et peut contenir de l'information privil=C3=
=A9gi=C3=A9e et
confidentielle. Toute divulgation, distribution ou copie de ce courriel
est strictement prohib=C3=A9e. Si vous avez re=C3=A7u ce courriel par err=
eur,
veuillez nous en aviser sur-le-champ, d=C3=A9truire toutes les copies et =
le
supprimer de votre syst=C3=A8me informatique.


