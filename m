Return-Path: <netdev+bounces-143945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD32D9C4CE6
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 03:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68DF61F23A57
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD981F8195;
	Tue, 12 Nov 2024 02:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yqaWElVs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EB919CC0E;
	Tue, 12 Nov 2024 02:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731380134; cv=fail; b=TyoTO+Z7taYiZP7kkwEIyHTTu+w8IOfJ25U04LxBnlazsgoSsJzQh+yp4KZvyMDoAT/vX8pY0a//snr7NvBK/Jact7ZG0MmJ5yYY00FPyzznx8r86lIW6UWlIcxPhJldV/YNa3OQLMKKu9c3KBf0zb+pT4iQHJl9eQpjvV3QtzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731380134; c=relaxed/simple;
	bh=QFd7sq0TC14qKA725iVjKutKyioEwEgWLZ0tURAWtWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KACEcsciWjvXTMQz6lXf0i7M2SvxvKcU4uuYNwgj+aMuO4as/rIYbY7Voo39ErSHr6J9kqve+R0iGuUXeNuCLmDZbo3X4CB+N0gtQuzSZkAWl6oT1Bxxikm268LoL0ymbQkxOlwhyr8GQvWgg1vER4dgt2IfWub4/clioZyAm/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yqaWElVs; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxkWn7A3z8YfYyHRYoSLKWk+1CqYjWqY6/RPfjdKCf8yvGH3CxeE0e9/OnFgwyHKWup9c1yYnIO6y9UGcyHTd690eQG8BiZQ7ODkZASTCueR3ovIbB4RN3n7TJVIuz7R2b5qgDMbBSYkrpBu8hSqAOurqe6llqmHD5AVUewWU88q9sgxli8JFB897COgvnj5Vi4T6gyd0XKI3N6CHZqTRxpf6zHqr6k86lz4LN38azzQSLBY+0ndDt40lw/nrZQlB8HtlD9NOxngFWJM1ia4ZarmyuYDMMh9E4M21+tpRbS3yXz+v49aGOI+YDTTDt4RzPt5m4qh5cs8H2DsGaTDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiA1LZKVQ1H1VNhY9cqdVxFr5PioCd/lRkNA+LNvkK8=;
 b=rPFPM06rBBYmzLZatNC/nWVQbT/3Lius6ffE1azluw2Bv3/BZXJkptnaLSiLzm6kcXwU5eUIA2ixI3a4LEKsYaturGc7y3K6ONX3HzHHh4BgLndwczccsb1APSbbiU+agZv26pR4gimxauxPXtngsyFAqk2rWT8JkHQCDcm/PLpWZ7dIBqyhItsEvC4dJg5BaDTzHWR0g1FBp/YloqTxxST6m2KlXXr0rlw6BannLVj1xLfUdW/Pau2evCoATmX9rQC9A+QqqSLzhUMqiw2f9Gf2gCyTP47UUbpz3xaB6wpGHUPqtQJoDVp5taSods7sWcjOkc8ByDRGeL49eOnypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiA1LZKVQ1H1VNhY9cqdVxFr5PioCd/lRkNA+LNvkK8=;
 b=yqaWElVsXw9UnzTOMpmlK/D7uoVlnBqMDM2+CTU5bjzg/9oVdVMhfadqVh48co9anC0RrUhGfzh7pStXYbvy/NhCuZiAbQJW1y5s4D4TcAHtktDPJTzRfh5hp6cKVzLXbiaObP7EW+oA82ZFPyOTIv7A0NIAGKtxOPjXQRSL3xZNmykbjGzERpimiA5Viuf62+0Sum6MyPKjeSFy783oXBTExIR0nN5yJmmEDLNwBwT7s3HvvjboISNs8KbF+724oJlrF0yx3lFE8I0eJQexd6URSMtAD7lePpk/ccayCkcq02df4yk/iL8bjJSaxE5aGaMskVqXVsZ3Zi6r4nX3TA==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 02:55:29 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8114.028; Tue, 12 Nov 2024
 02:55:29 +0000
From: <Tristram.Ha@microchip.com>
To: <andrew@lunn.ch>
CC: <Woojung.Huh@microchip.com>, <olteanv@gmail.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marex@denx.de>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 2/2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Topic: [PATCH net-next 2/2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Index: AQHbMkqiYUyxAMrEtEGHh8l2mClPuLKvD0EAgAPmaUA=
Date: Tue, 12 Nov 2024 02:55:29 +0000
Message-ID:
 <DM3PR11MB87360F9E39097E535416838EEC592@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20241109015633.82638-1-Tristram.Ha@microchip.com>
 <20241109015633.82638-3-Tristram.Ha@microchip.com>
 <784a33e2-c877-4d0e-b3a5-7fe1a04c9217@lunn.ch>
In-Reply-To: <784a33e2-c877-4d0e-b3a5-7fe1a04c9217@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|LV2PR11MB6024:EE_
x-ms-office365-filtering-correlation-id: ce548adf-485b-44eb-b7d9-08dd02c57779
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yNkbBMN1Rm46UON1BuJ6MghifqYalSneYAr5iLoUhNU4A2m6MK/I9zq8J/yM?=
 =?us-ascii?Q?OnaW6u3feiFgFpqlAysen9s7TVZEBNSoSKqMXjo16FHKOLtTz+izG5kR0F1Q?=
 =?us-ascii?Q?maGFIVn6ybmejKJutIht2gq5Ex8l9kdMp6ScHqv6p14RNraJxNSQrIF4O5K3?=
 =?us-ascii?Q?jQPOcW3eQDn+VAqLOx5Yh62HlGhPVMMixFGT0lt5fzWApXKDlMOrVpQaCrcT?=
 =?us-ascii?Q?N2RqWXpAO6dMwXzgLnS0RuM6PLAHH0IPX6F4chkqIHLLeJaZ6pnsrPC7XO6e?=
 =?us-ascii?Q?0yCkvmC5uPf7VbF84SYZZ71MYvFz2A5wUzd8Nlxf2hcW9NjBh60u+QHtsiJ9?=
 =?us-ascii?Q?kuPBPn7bsx4xKCcgxUxCxfKK+kw7cZw5bV9eylUBykSxCKkqlRmi8UDjgzpA?=
 =?us-ascii?Q?wVfFBGUaBSKPn04Vh1XJ+CKcgqJJatkE9l1RQUBrHYf/fzqa+iDGIIOyE/Nf?=
 =?us-ascii?Q?odUN69PCg0U8Bd03OMRJD4wkPAREy6Diu5ahPcOYGvuIOD+LLblrdRHslyK5?=
 =?us-ascii?Q?8xEHuw47FAmvTBRIqRILL8lEHoCE0yxrqhecT7eDgRTPscqnQNZSjoI5qzxP?=
 =?us-ascii?Q?+OuWJTZToki97R+1MDqi/vCxLqTpeFzWrtxJNG/Na4MKHbXHc4WVKES5krTG?=
 =?us-ascii?Q?D1vzYwFSVA+XnOCK/Ta888Wzpx29W9J3su8C7wQeWeqohcz2NIQCdZbL0AQp?=
 =?us-ascii?Q?gQYyenLIp9kLaZPSdr/qnTASYZqrWTaEorYf2PwvVHpmpe19nh84vlBvUL+u?=
 =?us-ascii?Q?Oy4moqpxJqI+LrqLkYNMdItVpLnXgUWbdVpfqzgBYtvgPz6Pesoe8xwHjyO5?=
 =?us-ascii?Q?WxRcuBeGZpJWrTw8QLj63McTEtaS+VtjsW484nbQWU8nR+dLIHqjbSdmsksC?=
 =?us-ascii?Q?s0FoXRq9QJxhqMNdLEemUTIafD3mTwo0BS7Jre3WHOWuTvl/2zB/hR6niIAW?=
 =?us-ascii?Q?4Wf9hDivnx+UNupBe/jmtOdzXi4vwPHSKSqnpVymosDZM6C898+qgDO6oNuS?=
 =?us-ascii?Q?ZyzMJHXJyOG0f+znAkb2ouQAHI2v3yxt72jclgOA6K+XOxFlWPg4Fa21vVhk?=
 =?us-ascii?Q?JHtKr0PWP4OIplr+b2nAJj39zvnHPqKuVAe+9FHefOitZFh79RiON1m/S8Qn?=
 =?us-ascii?Q?c7EGJ0XpsawREZ9nyiIqbcdbL/n/yBRD+0XYmdHDyRT+NDmISOHlr6NeEzUZ?=
 =?us-ascii?Q?J8A8S+xn6ns4WTIgiQOaAwontoCFAevBMCY0Sw9Tz7pN1zj/G39mjSA/jut/?=
 =?us-ascii?Q?6VKzFW3RzDzop3omDZ+/nTmHhOQFFZyCYCxnyCl8Igwuyuet2W+UdGJZ8dpy?=
 =?us-ascii?Q?IEIVNjOGn1KiJ/Es2mACGqO9tzKP55blKpaakYEdV67NM0WlOkeuAgmfg8iu?=
 =?us-ascii?Q?X8WEq4o=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qCAxRms4mm7bl2JOB8EoBY80s/l4O4dG0s/oOEN5WPd/8HE2e3ox1zeL9EYD?=
 =?us-ascii?Q?Ji1SkiE/as5USWQ/5JnwmurAh1j7sUnD0dYE2pu++BwVuClRuD3HEA6gnqyo?=
 =?us-ascii?Q?1Kzen1YZfok2umKTJbS3/Nd0aNuNkMOFN0HeU2N/jJ04Lbc5ILR0lMf+WqJA?=
 =?us-ascii?Q?xWVNOCk0l5yhir6lg3caZjmfcTcuNMMfyMMbhPdcopCEAv5Fj4C6M2TanmVr?=
 =?us-ascii?Q?GH7eVRJWw+Qbw0b8euoglDskxIpO2FDdmmwcr6mcD7YOwhmtBlF+TnnsAZPj?=
 =?us-ascii?Q?NDSfljeeDg/rpeLOAUj8g4rv/x6j92DoPgJSRG/r3JRmO6c04lWs/Y30ucR1?=
 =?us-ascii?Q?g+DyEhNTMWrM8DdONi7sVPbDUwxVgDPpdRFk1i73nCOUHKQ63Vn50frTFr2I?=
 =?us-ascii?Q?iE0AjqZVysazBkfjEIaPNcAvBmhD6/K7JKVz7NlPZkJWcJzSVGqtQPR8klW/?=
 =?us-ascii?Q?f+EN13zQa41tkLCzAKwAk7AU+QyDy72eXME18zqLGTacHi4y2bT4qAL8asir?=
 =?us-ascii?Q?UF+udg+CDAqKOw3BtPcnC9Rrn5YG8Xr3emWH5aXkpwsGx/PpUHDa6rD076J9?=
 =?us-ascii?Q?5Z/2wvMPczwyG/qTwVGK3xVRJULcx/Zna9DP6PrFPKeJpaqnba96ccwBH7JP?=
 =?us-ascii?Q?2apnQycXcYxDSnQzTnFWnyVX3i6pmSQq4BW3egHxolmYDv+Iw3mFNCk+Do9m?=
 =?us-ascii?Q?v1h7Tf3aRN9awfy20OA1wlM6zkH19qeCmDWNGuCqATYmMqRiNYlqDkSkzTKb?=
 =?us-ascii?Q?6WKkuDYpJgUk1ATOE5sMiOTX0j7fNfMdDP2lwGd3XvRRyri9L/cD8EDU8Z6c?=
 =?us-ascii?Q?w2/XOdXdx58KRomg73ebjfGSXBGkfAZENHIkj8ALRtc6b+w6V+d6MIutiHJf?=
 =?us-ascii?Q?pQs9pJEOTbIrQFyH3mtqu9gCGiXba8ktvxJuGkhE/nfS5oJ+V5CKcLvI1R7W?=
 =?us-ascii?Q?4YuiAT6PM8LJAa7Y93xqZFVvZ2aLBPxiR3mv7xEIkEj2HaViiz/Ra6rtCjmA?=
 =?us-ascii?Q?xU/kkmWy/03A+2L+cejEtSJXVrweGfiZ2u+qPLsUqVzSPLZJMpLgVzkOpJnC?=
 =?us-ascii?Q?yJn3tAn2VYdQEN/91w6MapzTTSiuTsTueIiyJku77LRtGkBlYH1W1x/piB/8?=
 =?us-ascii?Q?aoAMSb/leVpRhtfDj169uivAutM/AgGugjmaNpKcocBHeETX2WSV8kfCb6F5?=
 =?us-ascii?Q?qI9vmyFC8mhwWemLK9gz5rSluIzVyw/ESURHy+jmDiuH3APJ6MZRAJewz1eZ?=
 =?us-ascii?Q?7g2CEQ0jvge8FIiBmkNI3e4exs6XJr9PEdaAyVFY4zxywfPRflwXTpPry2iy?=
 =?us-ascii?Q?wawRqrWFs8WjbzXFHBALAp6+NqtObMRXoU8ffF5FphQuV8xE1JYuMsJjagc5?=
 =?us-ascii?Q?+YNjoSgV6mdzfaDd0NTCnzhD+Hl37E3nXhc9aU3usbSeoCU9BV9l3NCi5o4n?=
 =?us-ascii?Q?B+8qpWP5mPnALUAEOHtlBzN+ra39uUUaN7qdOC27w1HjB72CJfg83LrcMvtM?=
 =?us-ascii?Q?RRH3iX/46JAveHo2AbNTOhYEfz0RU1W9fj/muBdUB3LkirD1jQgscxyx/qfV?=
 =?us-ascii?Q?hfGh+zUA9oyKZ/ru0JUWfFRNRKyiTYfCM4CIUzu1?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce548adf-485b-44eb-b7d9-08dd02c57779
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 02:55:29.2472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IFwm9bY53K+ehQ0hvawVWSfhT+GH9DGOVUdOhzXIQXM5uSLZ77oO9CeoivwYV2ROhYQpjXJXmfr9+lxXNOxHt+xPC4P36B+nQitjbE9hY6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6024

> On Fri, Nov 08, 2024 at 05:56:33PM -0800, Tristram.Ha@microchip.com wrote=
:
> > From: Tristram Ha <tristram.ha@microchip.com>
> >
> > The SGMII module of KSZ9477 switch can be setup in 3 ways: 0 for direct
> > connect, 1 for 1000BaseT/1000BaseX SFP, and 2 for 10/100/1000BaseT SFP.
>=20
> This naming is rather odd. First off, i would drop 'SFP'. It does not
> have to be an SFP on the other end, it could be another switch for
> example. 1 is PHY_INTERFACE_MODE_1000BASEX and 2 is
> PHY_INTERFACE_MODE_SGMII.
>=20
> > SFP is typically used so the default is 1.  The driver can detect
> > 10/100/1000BaseT SFP and change the mode to 2.
>=20
> phylink will tell you want mode to use. I would ignore what the
> hardware detects, so this driver is just the same as every other
> driver, making it easier to maintain.

There are some issues I found that will need your advises.

The phylink SFP code categorizes SFP using fiber cable as
PHY_INTERFACE_MODE_1000BASEX and SFP using a regular RJ45 connector as=20
PHY_INTERFACE_MODE_SGMII, which has a PHY that can be accessed through
I2C connection with a PHY driver.  Now when SGMII SFP is used the phylink
cannot be created because it fails the validation in
phylink_sfp_config_phy().  The reason is the phydev has empty supported
and advertising data fields as it is just created.  Even if the provided
PCS driver can change the supported field to pass the initial validation
it cannot change the advertising field as it is readonly to the driver,
and this fails the second validation with phylink_sfp_select_interface().
This problem is so obvious I thought I must be doing something wrong.
This problem occurs in Linux 6.1 so it is not a new problem and nobody
encountered it?

This problem does not happen with SFP using fiber cable as a different
function is used to initialize the phylink.  As the SFP code already
retrieves the basic support information from the SFP EEPROM and stores
it in sfp_support it can be copied to supported and advertising to pass
the validation.

I mentioned the SGMII module operates differently for two types of SFP:
SGMII and 1000BASEX.  The 1000Base-T SFP operates the same as 1000Base-SX
fiber SFP, and the driver would like it to be assigned
PHY_INTERFACE_MODE_1000BASEX, but it is always assigned
PHY_INTERFACE_MODE_SGMII in sfp_select_interface because 1000baseT_Full
is compared before 1000baseX_Full.

Now I am not sure if those SFPs I tested have correct EEPROM.  Some
no-brand ones return 0xff value when the PHY driver reads the link status
from them and so that driver cannot tell when the link is down.  Other
than that those SFPs operate correctly in forwarding traffic.

It seems there is no way to assign an interupt to that PHY and so polling
is always used.

The SFP using fiber cable does not have the above issues but has its own
issue.  The SFP cage can detect the cable is being plugged in as the
light is detected.  The PCS driver is then consulted to confirm the link.
However as the cable is not completely plugged in the driver can report
the link is not up.  After two calls are done the port can be left into
unconnected state forever even after the cable is plugged in.  The driver
can detect there is something different about the link value and can try
to read it later to get a firm reading.  This just means the driver needs
to poll anyway.  But if interrupt is used and the driver uses it to
report link this issue is moot.

I just feel the SFP code offered in the phylink model does not help to
operate SFP well in the KSZ9477 switch, and it does not need that code to
provide basic SGMII port connection.


