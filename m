Return-Path: <netdev+bounces-139721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC5E9B3E7C
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00EF1F23121
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F521FAC27;
	Mon, 28 Oct 2024 23:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="X6Zvx9LO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E734E1F7571;
	Mon, 28 Oct 2024 23:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158298; cv=fail; b=mRlhbRgAfwK9tKiIi0JjaGMR33vuFTYR4C60Tcd0KoDHzZbwea9/0n40su6XHBx9GGUWQAeUOuivDSIbPnuxdniA3V10u2FkzvLiCZZQgAjH6jC9UcKiVqDHNIUNU8Ld+L7yRaPyvgZMB4v9q6XZ3x3n3yxCEtGQHQ18QqT/eZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158298; c=relaxed/simple;
	bh=MMjhDZm93DtrTFDK07Mla+6FVL+7wug2HLD1WRFfzzg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wd/4yb9kZLKzkh3yL4hNZDup37d+dD0wxhKLl4CkE4k+90Y011jirTwIxxDOLNNlbc+xNoiIA3Tku/azYEmLrz39zWtOFtwmZn75WisWB5rMvpFhwELfxU+4ZmIApVA1ZEzbJiu6xzk/PXi0Ru16+7zPUF2uRNW8bWS2XuCYEeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=X6Zvx9LO; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cv/eKiTxou/UJ/loSa4XHV5n1kHRQnW7fAWL367FZTSmbpilJ1j9TYPkWxr6f0IsPd0oHlpU3y9gT8NyIkecg4wDQivEe2N2Jb+q0Rx7xZdW1Iy6EORSQrTl8ZBYtz+OBaqn6FzUlF+hZgPtyh1yXm5djBnyD2zXSY1EGq8r0pN1xKZIK6yy+O59W+FK6nbx78Pn/ap8ZueUHCS8t8y2nmpZtHeVoaWYZTfQ8o3XK+MgTbJIjThtdElqgKSI7q+c7rhI7W0L+NrzaGprXh/98adO12zYZn4tpesqG1SHWRp58UmlZqvCeuZi90UzLF7JXK6C1YwQ3oh2SnSPx94A1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSnBiKdHc2ELfvBifYru0WczxgFmn/k/obDaoxBWIDA=;
 b=J/Top4idY0UFzVEgEs7qiNg+eL7D3J8E1OAbQ+AyVMmbF/L61OqN+wjuttIBpSLcfrBG6DshmijXUW1CFcAaTRON6LE1ZJcwsH2mzJnGysHBvMJHltQcbTWPrt2CGNqukgPoo+4Fi8hFcU9FnUXlJ2+JmiwOiZFR4INv6CJZ7z4AJ9Rgwk45/j6HMsf5viw9XvtZmaSUKuEBZvAaKnNm+RnQNCvdtOaPE1JWzCk7H8CGoN3SMvMyDi3BGBZ29Uczzs9tn6VhqCDopDBF5zQ51pSQtZhQruAmdtz1FwxvgLusyeQC2b+aHR4IrfszR38fEbXbn/m3ZeM3C6c1RGBqNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSnBiKdHc2ELfvBifYru0WczxgFmn/k/obDaoxBWIDA=;
 b=X6Zvx9LOMZGdlg9WMNKgjmLaIX7LmKRIGFRmfdjDfXOZEeRvcysrFDNBg/+TDzN0JmkPyBrh51krtkB2SGEjQF0RT+986tk4W+rXCH/b9B4QCKcAc2v+gn6XVc1JRTs4YCox+EqH4oJFnlY5OafA0eoGYwxRKRo9BplrsYR8zmCvHpql9CH1UvJtFynzAUR0SQI2MjUwSRO09qfnGTB8UwsWgfDtY2m8p+72/lX9a9xZjeL9kGw3QuSDpMXlQaw7owNA2HbFi9R/Ms5MM6GYvd2bhGssfsGG9BuaPIdMrX6uDSuGShsULKbj4llV0s39H+oij/1g/Sk6LqsFzKoOWQ==
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by LV3PR11MB8741.namprd11.prod.outlook.com (2603:10b6:408:21d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Mon, 28 Oct
 2024 23:31:32 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 23:31:32 +0000
From: <Ronnie.Kunin@microchip.com>
To: <andrew@lunn.ch>, <Saladi.Rakeshbabu@microchip.com>
CC: <Fabi.Benschuh@fau.de>, <Woojung.Huh@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: RE: [PATCH] Add LAN78XX OTP_ACCESS flag support
Thread-Topic: [PATCH] Add LAN78XX OTP_ACCESS flag support
Thread-Index: AQHbJzJ+R5s7yeWnsEOPGdRw8jsjK7KcHiGAgAAlo8CAAEpXAIAARIIw
Disposition-Notification-To: <Ronnie.Kunin@microchip.com>
Date: Mon, 28 Oct 2024 23:31:31 +0000
Message-ID:
 <PH8PR11MB7965673387FA5E135F4A3810954A2@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20241025230550.25536-1-Fabi.Benschuh@fau.de>
 <c4503364-78c7-4bd5-9a77-0d98ae1786bf@lunn.ch>
 <PH8PR11MB796575D608575FAA5233DBD4954A2@PH8PR11MB7965.namprd11.prod.outlook.com>
 <a0d6ef0c-5615-40fd-964d-11844389dc29@lunn.ch>
In-Reply-To: <a0d6ef0c-5615-40fd-964d-11844389dc29@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|LV3PR11MB8741:EE_
x-ms-office365-filtering-correlation-id: 923e1d20-2f23-4a58-9533-08dcf7a8a7b7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eZBrGB6J+++aiiWLCNP6JZO6u1BBE3K2y/FGpA4rWtJA38Pieu7z3vfQWKnN?=
 =?us-ascii?Q?ZV+e94O/MIXZm/tVCTgn7+PNUdEE//5K0w+rnoxNUf5AW3yD8LWjXH2YmwP3?=
 =?us-ascii?Q?vBeA7j4fDuCIMFY/E7jXA1X7YzPh4mwofPn+0LpCXxP1aeO5EFzCleY9T8dD?=
 =?us-ascii?Q?BuzC3YMx7VKwn4KaIZGJs30aJsdlu5xxG3oP7z7jM/tdMEVRsNldPmeFYG5A?=
 =?us-ascii?Q?KZ9SlXFhuPPDBn7hBcaSb4Qv1eCR8zm55USFaJbleJohQIEWzCCbgKQ2184i?=
 =?us-ascii?Q?9zVB1Ub1xQFU674fVrMabbui3uhC83FOZTuzykytr2xENKeT4nYqEbablQey?=
 =?us-ascii?Q?oTvxx2UgQlUfT95bCVNM9IoN7lyVTHFvQiIK9vyYwSHRpv+lo2CrK9wjtsLi?=
 =?us-ascii?Q?H7m1S2oXw3onGups5LrDKt2eX8TW79KUqJPLoaRrDjHwadG7TlAo5B4FZhkt?=
 =?us-ascii?Q?VXovYMoXA8/Qb2IqNZtPbahA/MATYUvDfM7dSaJaxuQDKp+ToTQ1qqJ64Ly3?=
 =?us-ascii?Q?c67E2qJjb0UEYJ7MkkH9aoRuP6uD3yJTSk3b3TB4BTYOqYS+RuiOUM68xT2b?=
 =?us-ascii?Q?iLSkq/xEZOQLkX8YKMhWuf8YKW27whtWTpCntkFTXr/jtQEjazT8lnkFwZkG?=
 =?us-ascii?Q?czEjWTJYiQeXCdTy5ohvIWwwKstETi0UsOCkZnUztQXqh+W7bjv9uT+ZXKhs?=
 =?us-ascii?Q?2OmaIouniU3/Q3ZN3gh6P68zL4Oc1YyLfXrfgNGu1Z039j3VwWaTMfIuQo8r?=
 =?us-ascii?Q?Fn7BTqcIBZBTUWpcXHb3J4sM46MXa60E+dQxiGEKiVckdCud+4LxhpLJm2iS?=
 =?us-ascii?Q?Of06Ow/k3kksRCIsaVYeU0//OF81sfQdzwmGW6kjPKOpk8yIHDRUSb1uwaKr?=
 =?us-ascii?Q?WuhadEpfSM0gAIfVCfvKIiX7zJNkoVMrU5UT+qHs723ocmTsBn1uTNS/GqM8?=
 =?us-ascii?Q?5y9aqEn6GNnfTE52ZfpObBn3vDCVx3KHDpwyqpV4R5ZokcFlXqbdAAPhxBqG?=
 =?us-ascii?Q?QScmBumPiBVoJRTAKJdeFda+3qUEgo0b3aeoGZrIVE/kp/LuviBLWucqGYM4?=
 =?us-ascii?Q?eyzFzSONUl/0yJD1fXs6qzlG1hvkn9qELnD9+WDxU5QIXk7A7+JxzNdvsk6j?=
 =?us-ascii?Q?v7BHcRRrFTx/p0JzTmp0TUnZyYfkPUE1WKky4JEfesMIKTj/X/+sY/Z5PIoV?=
 =?us-ascii?Q?qg3LttMFxrS64pBn80e2NzlxuhdgxijyF6cLbMrZZqJ9GqPPXN0dh0w7MlXx?=
 =?us-ascii?Q?cHgLxZ7RNPfHpfDq8r4mZB6SCdBQK+F88MikBofXvAhoJB+BJXyS7mjgC41M?=
 =?us-ascii?Q?RE84s5gDn1cHmsegTPckBEeX9LVCtLcBrw4zm50xpmXyKkc3sja78ODlaECf?=
 =?us-ascii?Q?I5Zp9oA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Xi6OL1V7epULWmNxys/SUIjptnaS7CJ1SVhQGbO7jMX8NqN4HoWDxrKNZBuC?=
 =?us-ascii?Q?FPSGagkHmTObBbig0e7Oigiuz5HOlTcO0+AXxG0QB0cxV+qsnUAiy/wObEFt?=
 =?us-ascii?Q?As5D7gKQaq6TAfU3Sx5tDth/lDcgWB71PYLl3UBI6JE97yeTGobGIQ1BnOnm?=
 =?us-ascii?Q?tu9cnBuORLWsMPIiy5mYPf7WiYElrocTX/e49kskMk5wVMqHnsJ8waLYd85w?=
 =?us-ascii?Q?KaPXgJCCfeX95pxg5Fvv1LXWlxB14iTqonRdAu52PIuiEpWwKpC2OulR2pmi?=
 =?us-ascii?Q?32jYI6kux5qQ385q9xNpgDDxyXYhjb3D4TCR4+4tZNDH01DhIV+WUeehZWD8?=
 =?us-ascii?Q?HJX553t/weG4Zc8C51mo8mhMvvuAjILmk/xMuFLsMKvl54ggls8dtpTQRFNr?=
 =?us-ascii?Q?WX0R812fa7y3rltLew9lt5BO+AMx/1r7KMtgUs/dUHF2JFW8xXUKTDzn3Ism?=
 =?us-ascii?Q?xqVwHLUQnsyb3w1ro45iRRT6JuruL4nP3QOeTxycQEVaZ3QAlWuFnlzN9RaS?=
 =?us-ascii?Q?AAuJA8nRyDLNnEJ9Nn2Dk70U1dcxXtqezCAodwjWovcOqX8Qv+zl6+ilONbp?=
 =?us-ascii?Q?qzdlJ1m6CxTu81qCxBFo9TojswJaOVcXI0wjMrRcXsddtng/7RIDEMflYGUi?=
 =?us-ascii?Q?f7eDgXTa92zq4IzAMiCoUMOwdESul5vgGJfe5e012D7Rgj8qNig0JZvQ80Er?=
 =?us-ascii?Q?sAZeB40U+1VlqsQv2tq4K8joZnprVrBwCRj22OoBRKh4FRaSkexGeJ8CdisO?=
 =?us-ascii?Q?2oxvt1A0+GWoR97JXrcyPeCi/9dRbtYXMxTCnKovapn1BkkhGSKgFea1obb+?=
 =?us-ascii?Q?AGuGDcTQg2YX/26eNVuwv9gOzJESJpuTbXbV7SQH49QQZmrp0McP7bII/aZC?=
 =?us-ascii?Q?8h5hcyX1UDRm2OSwMbRE2cUtqNEgTP+GS4KVTyBnkj2O3PwFiWuJtEwiyWi2?=
 =?us-ascii?Q?nvUh0F9l0fWtQWJxlNWcvNcY3/vsoYKIn7Egh6UDEFqGJUx7t/HwzVHa/jXV?=
 =?us-ascii?Q?/wvwJmt+d2qMlhC5Ta9cXQTWzZtD3LhfO8oHvkBtM1CWIshVgbLGqsUf4apJ?=
 =?us-ascii?Q?fsdkHIUQhvsZlkmWFs9fPdGkWatvAVrXxyscTFcB5EZSlkfVyrLjqLCXhliD?=
 =?us-ascii?Q?XUmemr9I+ejMVHjbyrMdoCjSx/84WSseT/ylzWwIFm+O7I7G0fafuTvOyQGE?=
 =?us-ascii?Q?pjNuW4gHXriik+22r9CIz+NIhXRnsVbxVYlZ+iz0plb+oQN4yn7qkdIq8PJh?=
 =?us-ascii?Q?XEKTFC/ZZ5XHNEjl4FySUjCnbUZIvCuL63fobiU9++AXvj8xiVMYrivd3FXx?=
 =?us-ascii?Q?f3W7TIzmaR8K6ya6V1R6VGe6iynLb7zuvGwHCxUiSpQST6ndRY2uuVPJfs0/?=
 =?us-ascii?Q?ybyPYl9pK9SWPVDc5Zp6yHJr/yQ2aa6F9oR0R/1IhKgvawwWOMaTR9Hg5p1c?=
 =?us-ascii?Q?rGFVxVLJruYCMbQl8yqvJfRmgDaobOHaxUrY/qh1jDWYEsTltcJZCyEZZ5AQ?=
 =?us-ascii?Q?HnKRWQMX5MMYWxnPomCBttXcCxJ//RfvFMs9eWM4GdnTYk70hNpu8m5pek5d?=
 =?us-ascii?Q?ytNlWpKmusSe7u/WlmEU7hRM2CARKBso8+R+6lDQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923e1d20-2f23-4a58-9533-08dcf7a8a7b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 23:31:31.9846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mzv9fP40Kexag1RlD60M9tn10DQGRqKmDkwz/XCgMhi8v99fxlXY2NdqQLCGkt9JZMZSRiKQrhKE8gqYwpGdXJxbpiQ+j0z4yJ/KlVYbVq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8741

Thanks Andrew.

Adding Rakesh who has been working on this patch internally at Microchip (t=
hough for an earlier kernel version) and after completing that was going to=
 be upstreaming it for net-next (Fabian beat him to it).=20

Ronnie

-----Original Message-----
From: Andrew Lunn <andrew@lunn.ch>=20
Sent: Monday, October 28, 2024 3:19 PM
To: Ronnie Kunin - C21729 <Ronnie.Kunin@microchip.com>
Cc: Fabi.Benschuh@fau.de; Woojung Huh - C21699 <Woojung.Huh@microchip.com>;=
 UNGLinuxDriver <UNGLinuxDriver@microchip.com>; andrew+netdev@lunn.ch; dave=
m@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; n=
etdev@vger.kernel.org; linux-usb@vger.kernel.org
Subject: Re: [PATCH] Add LAN78XX OTP_ACCESS flag support

EXTERNAL EMAIL: Do not click links or open attachments unless you know the =
content is safe

On Mon, Oct 28, 2024 at 03:02:44PM +0000, Ronnie.Kunin@microchip.com wrote:
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Monday, October 28, 2024 8:38 AM
> >
> > On Sat, Oct 26, 2024 at 01:05:46AM +0200, Fabian Benschuh wrote:
> > > With this flag we can now use ethtool to access the OTP:
> > > ethtool --set-priv-flags eth0 OTP_ACCESS on ethtool -e eth0  #=20
> > > this will read OTP if OTP_ACCESS is on, else EEPROM
> > >
> > > When writing to OTP we need to set OTP_ACCESS on and write with=20
> > > the correct magic 0x7873 for OTP
> >
> > Please can you tell us more about OTP vs EEPROM? Is the OTP internal wh=
ile the EEPROM is external?
> > What is contained in each? How does the device decide which to use when=
 it finds it has both?
> >
> >         Andrew
>

> This is pretty much the same implementation that is already in place=20
> for the Linux driver of the LAN743x PCIe device.

That is good, it gives some degree of consistency. But i wounder if we shou=
ld go further. I doubt these are the only two devices which support both EE=
PROM and OTP. It would be nicer to extend ethtool:

       ethtool -e|--eeprom-dump devname [raw on|off] [offset N] [length N] =
[otp] [eeprom]

There does not appear to be a netlink implementation of this ethtool call. =
If we add one, we can add an additional optional attribute, indicating OTP =
or EEPROM. We have done similar in the past. It probably means within the k=
ernel you replace struct ethtool_eeprom with struct kernel_ethtool_eeprom w=
hich has the additional parameter. The ioctl interface then never sees the =
new parameter, which keeps with the kAPI. get_eeprom() and set_eeprom() pro=
bably have all they need. get_eeprom_len() is more complex since it current=
ly only takes netdev. I think get_eeprom_len() needs its functionality exte=
nded to indicate if the driver actually looks at the additional parameter. =
We want the kAPI calls for get and set to failed with -EOPNOTSUPP when otp =
or eeprom is not supported, which will initially be 99% of the drivers. And=
 we don't want to have to make proper code changes to every driver. So mayb=
e an additional parameter

        int     (*get_eeprom_len)(struct net_device *,
                                  struct kernel_eeprom_len *eeprom_len);

struct kernel_eeprom_len {
        int otp;
        int eeprom;
}

Have the core zero this. After the call, if they are still zero, they are n=
ot supported.

I know this is a lot more work than your current patch, but it is a better =
solution, should be well documented, easy to find and should work for every=
body, against a device private parameter which is not obvious and unlikely =
to be consistent across drivers.

        Andrew

