Return-Path: <netdev+bounces-121190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 123FA95C180
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 01:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B527128541B
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 23:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD00D17E46E;
	Thu, 22 Aug 2024 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zqfG02TL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FAB1304B0;
	Thu, 22 Aug 2024 23:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724369469; cv=fail; b=omVHOooo3BcW+E9ZHuq5/d0r4PAk+LPx1BqYnVi3jX5pDXzNTxqwtuIH1/qLSlO4D1Dz+yv1ls5cyZCr1GSJFfkL+q+5BeAghyl5074CN2axEBO0cIfHI6RGIZGtCIaHCSmrxPJOn5btrpoxMEvaN3XlpRxo0FXGmm4HGlSduEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724369469; c=relaxed/simple;
	bh=98DGy9NuzvrNeUcTrvBd3HghXUYRTymahEBhzwQqRpM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A7iKq8t9lM39G+1St8wmnjglce4uGv2kPOaJq5iy52IawXMC7n31W2zw3tnP8lD9xAYMorVT+vDdtpIPnthpHmIpW8g1szuEyQMCVgB1IrAr9fk+Teig57cV+gxYwlHvJcaRJHxIro0f2AVuy2li6SgB2ta5ea1qjH3JTFgxplU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zqfG02TL; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pU09JHvetpSeUWGJITnc1iN8i32W0TzmKiX9ZblcI/UEL9ArSgVz+Ezo90gfL/8VDtL0Rlu3PmiiK12IwEEvNk91Wb2IPYdBFryyTSzNuu/kdN84OGczV3O8aIQksUjDQmkYS4YzUtmKTXzAzdRWKqVYVxwb7AvuM5AHd5s0SAbQzXIXERL4VHokHApezKkjNi5xKCobnUHdEWirtFavdMkcXmz1xb/oY4Rr5ww28rEne0YS4cZIOoYKwF1dZhpRQJs4rczluxNodPI96E+hNTWJyXisOc4hdubgQXykaG9+eA8PEnavwde0jN/hJmIC8MgqYrBkqtjXp+eb9iEL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWtXywrA1O/fffmjo0GYWx2gsuKNRFy/X2gHqKEWRN0=;
 b=IcbfoPQgCAkvtL8CO9PVH8gCM4HRd3cefppXa0TGOgYztJfBFqcJtZKA2cFdOXVKkNTUq2Eey/NocrsAic1rOC46F4qw1r9jy99/jdsdGMfo8A3yJ5H2/na7Z/AANXBujyGiZXB9iqBGFXJZVEEjqFm6qXySWRCtZcs1m7BsGXn2KKyfIE2ICh11OZMZtbpWVIkhtJiK1YmMdFwVEd6NHRp2hP6dgMip2O6EmxcqCGw45x8QJsfLiPJfhump6dJiXCxe/kUQw89DnKPzix6ZOln2fZ03gxD/hEvDjaHRzTc5mqPKisTJJ60uwwXr03Yo2AuYEyC7Oz6CkLUZHYu+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWtXywrA1O/fffmjo0GYWx2gsuKNRFy/X2gHqKEWRN0=;
 b=zqfG02TLd4t2pUjFyiCDCJ68d/oS194y8ACCcnAf8hKIngbDkaCX2hGdZ85+WYYf57sEl2phc1dFYr0LXzJpnUgg7p5+h8BZwHG1zBD093yFnqlrRd06Frl/4JOu7dqYb5qIVcemOx9DcsS/lhoVfEcs+UrUVvXAhEBvPadptow5dBapI5WJ56/EqE+15ASK96xGIRpUjq0qaaQ3Pfnts4BKQWlVsyDh9CCnPu/XGJ23qkbi8COYjLNZQ8XUGtEnG2hz6UlprNrGyf0kbBxvHRZZJ72tpWBkOcSAGHRw/PVLCIaOtfpnluL6dTf6ZvG2pDvuq2TWX0b3JfZNhPstkg==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by PH7PR11MB8124.namprd11.prod.outlook.com (2603:10b6:510:237::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 23:30:59 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%7]) with mapi id 15.20.7875.023; Thu, 22 Aug 2024
 23:30:59 +0000
From: <Tristram.Ha@microchip.com>
To: <vtpieter@gmail.com>, <pabeni@redhat.com>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <conor+dt@kernel.org>,
	<davem@davemloft.net>, <devicetree@vger.kernel.org>, <edumazet@google.com>,
	<f.fainelli@gmail.com>, <krzk+dt@kernel.org>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <marex@denx.de>, <netdev@vger.kernel.org>,
	<o.rempel@pengutronix.de>, <olteanv@gmail.com>, <robh@kernel.org>,
	<Woojung.Huh@microchip.com>
Subject: RE: [PATCH net-next v4 2/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
Thread-Topic: [PATCH net-next v4 2/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
Thread-Index: AQHa7rnc/3sa+M6QMUWSGIxDEI+x1rIv9DoAgAACCACAAZ+AAIACYxZg
Date: Thu, 22 Aug 2024 23:30:59 +0000
Message-ID:
 <BYAPR11MB3558BF270DDBDEFE67178206EC8F2@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <584ce622-2acf-4b6f-94e0-17ed38a491b6@redhat.com>
 <20240821110226.1899167-1-vtpieter@gmail.com>
In-Reply-To: <20240821110226.1899167-1-vtpieter@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|PH7PR11MB8124:EE_
x-ms-office365-filtering-correlation-id: 631bdcd9-906e-4652-f816-08dcc3027a70
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?e2kcl00lZrVY9je9fBN8Uy3Yn8u5/Kp+e7DolT9jW9v20LUYDEpatenuqB0s?=
 =?us-ascii?Q?727EbVkg9jKBg96lywXfzmsknfrq97S26EKyT2cjwr4d21t1YkmHofB005F9?=
 =?us-ascii?Q?vglT+yTDnK/Ob5rNJ80o0T0IcLk9wqB3M27Xq76enNnaDWmV8ByOuT6uREQb?=
 =?us-ascii?Q?+a93pRd0hxCrtfZcz9fQZElvmkHnJSPYVm7hESKPDMrMVn2q4i5+dy0v/g7m?=
 =?us-ascii?Q?HC6QMTvhzy4oCD5iFD/VZJwtAy0W+aqOkyGbyEkZu19Ih2gMbrsavFE1vhLQ?=
 =?us-ascii?Q?7ebqB4/nherkbcvT6r5wfhNxCft9hvhR4wsHbt2Lw4cRw+NGoVXnHP+ARm1r?=
 =?us-ascii?Q?VxWXhi9u+eglc/masva26NhdZIQBmd7tvClmdvKN1eAxSqTp9az2apEJbatb?=
 =?us-ascii?Q?SzokM9sZWb7l/J0ly2LbdDvE5GZCEH468Rrc+mPikjSG2eEL4j1rpmgil31D?=
 =?us-ascii?Q?Din0kE+ZDAhNfNGtvufkZdd/4vTMSxwjPxNA3MzcI6Zy74zNXixjOsaKjX6H?=
 =?us-ascii?Q?2MN0Lo0xRebwxp8NiwvwJwPPQcKp5zMlFs4rfiTP/FP2rOIByAZ22H6aRv4j?=
 =?us-ascii?Q?ZsneYn3M9CAjs58shbhAogps44WZOp7+tOFGcJjVlT34dRAXMHQE0SMcJJge?=
 =?us-ascii?Q?89Zk7RGdqQsFPtPwPVuCKkOrd1AHVs3/jQv2xDaJRrZZhXCAimmryq+cOe+C?=
 =?us-ascii?Q?Rnlqaok9De27KWq14It+dq83juA1AlWd8KgRt4f1rNs6TcZbaIuQzzPAP4sK?=
 =?us-ascii?Q?HkMgWhQwShxpRorv0NuywFS/gHQt5dwbbK6lecRZGqStcmVkrbIeeDX6I2hz?=
 =?us-ascii?Q?O/nYgeC5pmvDdopK32u+SDKSUADxLtkxHL28xjpQwp6faC/E/jeZntLWCENJ?=
 =?us-ascii?Q?gCicyePYODJARoJQdKfc8vf1+cgPQzTg+Quhhw75MJvaG/ki/Ymm0p+lnYua?=
 =?us-ascii?Q?AfSAlBaYTtuTsRhRtpCgEdP6VPgIpnjfH8CQTGHYZ00vrKwNDTRbV10g1mfi?=
 =?us-ascii?Q?+hq55qE0OdIfTBpl2eDgW4e/uOdeTS8wDdrtAqBM8bveY12MPi2YfYjtf9jX?=
 =?us-ascii?Q?GlJKmhS7PG3bdpeWB7GahIGQvJ3WMBRu88yMAuGH1zheXRNRauAI8QY5xFTM?=
 =?us-ascii?Q?MK/l3AX7y+UVPvyUQbhpDr1RdT5r9DbbwVzHNnyLB4HDRiBsaCeodwjKes6q?=
 =?us-ascii?Q?jxplblyBCr83usriFAS0FAHCWB+Vsd4cC6lysuNJ3oa+Le+XwI5ROaWgAZK3?=
 =?us-ascii?Q?Cs5XSm9XnKdqyAxcLkqnTiQqKWDMzrRn6HJZ0Eg4gClFgHb8kmwcgoIVf0Ev?=
 =?us-ascii?Q?B+8YRCyBiZUlVogoVlQRCibxrS60V7etg8nQE1w8xh6UNO2Op/hjS7BGXR1W?=
 =?us-ascii?Q?Lm92z4YDR8kPhnlKas8ny6vjQc3GJ0GMlnePAcOhA8KpAVOQSg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OrT/1z8MrtBSciAj4DZdIAHZxbsxCghYVhPU125WUeuZA/V2jDUfLpWXJFGP?=
 =?us-ascii?Q?g8IsIiVNyFqkjxCkTA8bBO1/ssVzugfGbKyiS8EwXQyZr7Kyk2zrbphH8Lb8?=
 =?us-ascii?Q?ozZIDAUKXF3zRJ10Z3C5mxLWdqNyqqR23/Zm6qyL9Ms2dskt7iQjDih/2srz?=
 =?us-ascii?Q?pP769/DjYypvCpiUYFpFy33ZQhkXxVthVKt+fx24hFISas7fEgFl9e8b86US?=
 =?us-ascii?Q?//TkFjbPJssu6KEv5nkGH88KUx0rzXqPYAAW98B4ji3TxfkNya65UBL4DMp1?=
 =?us-ascii?Q?RiAVfaZY07okdOxGZm8AApR49Wln/MHrG/NBs9FoaecyKz6sWV8USkG9Srk9?=
 =?us-ascii?Q?h/XjrYELeynHTwWkGvhVodaSy+WQ12yJRbfanGIWkwls4FWJeUstbC5H/bn+?=
 =?us-ascii?Q?tsqWSB8dQDUxMnxea2sMfWqoJIOklSCAcA6LdPyUnhBG648jyzNj47bbtIFB?=
 =?us-ascii?Q?k/letXJLXB6giEhW+tDO5cFfsaNFUh5IzgzLOCCp4HdvCPurkbcDAg6LGBj5?=
 =?us-ascii?Q?Hp4IyFCdmZfZZeAP6kHJalq9CfDo+6fgP7qOgwNHCe71tkjMA4j0Vhm+hgxr?=
 =?us-ascii?Q?HFlwRU9Ekj+O6eXbJl5mQWhtbDtQ1q8lWO36GOL/lW7EcdThE7Gc3y3fO0rL?=
 =?us-ascii?Q?SWjlzRZrlP7cSMba7JtnU5Ck2l+x9O2OEHvMlLsgmZiPTO8r8DoSZpsodLGE?=
 =?us-ascii?Q?m/YenINxatlukzTWCxnMgh6r7WVaBogkUACHfV02JFQqPMQGBEWvGUl/pl6d?=
 =?us-ascii?Q?sB9Oq95PqTKyC4NuSi6pxsVkrRSZjaM4C8muR3z41auvXbGRW4+dYjMGE6EW?=
 =?us-ascii?Q?7FS7S/qN5+bwzc5BvMTSc0f5S9Qee7JnGHoeq7loikvb7911riIOspmwyxz9?=
 =?us-ascii?Q?WS8UbjinfZXbRRZO3D0GEq5nBtesbREbh0TDD6dzMHB08lNPYU+Ht/34/5/M?=
 =?us-ascii?Q?naUkbbOh6m3GenGaeC3A0/IhM4vokPCCtGqnGgtzA1z84BOgiBmPiD6vrPjo?=
 =?us-ascii?Q?Wlhe17i7tLEYahyCHeh5ovebDHoa+cxJM4p92I7TjF+exzxLFCohDt6ZW0uk?=
 =?us-ascii?Q?hFGvNxx36cSyDqUHuulr/wOrezU8FaWcJr+p7Dx4Bj3GFEc3uac3VKq8dmXR?=
 =?us-ascii?Q?PfvdTmP9i7TgaFXH8Q78nI6bDFpJ/iuv7Vfx8pael3+KdQ0slv5MlLOHy9NK?=
 =?us-ascii?Q?J8DA00/HclyDeZ5k2Skt5FwvOzC7ts4n4fq1Rt4bfctToTjReVMz6JTxmbTl?=
 =?us-ascii?Q?KeuqZ9lbexF8CExymp1ScHis26szeEgrqu3nrXMJAU+r6dOclypF0C/3dOfS?=
 =?us-ascii?Q?AnPy7pwbejqMZ2G+oPCnftV3kQJLkH7bqJObnERaYgdeYJqYqkF1IfsNrZP3?=
 =?us-ascii?Q?CLJBxp0INIP0epmFLpqK2B0fCz75ZFC6NXEyx1OIR0qxADgYAK+Sw+MWiU3f?=
 =?us-ascii?Q?vm8WZe/rrlxUOGf31MQU+0MXYD5De9fZv9DDmZR3l0OOIJb4dCiqx7cGwE1X?=
 =?us-ascii?Q?+tK+u+Pp1yqn1yTVChhS3oF1URg7wt+PfAJ+tK/ybG787c8FdrXMvRWDzVPw?=
 =?us-ascii?Q?BtmO7HrkZ3sEcNotWeXzr5FDvWxg4NdPLdZved61?=
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
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631bdcd9-906e-4652-f816-08dcc3027a70
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 23:30:59.1238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VXuK6tyrvncHZZxFjobSiOSw+L0Q7STBVH3anFXSAbTBeUP7Qr1dlRsnxMQUtFDfUEzbnujIJAa3tzlT5ZzvST4yvxyrl3GRpvlsSy1NbBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8124

> Subject: [PATCH net-next v4 2/2] net: dsa: microchip: Add KSZ8895/KSZ8864=
 switch
> support
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content
> is safe
>=20
> Hi Tristram,
>=20
> > @@ -325,7 +327,7 @@ void ksz8_r_mib_pkt(struct ksz_device *dev, int por=
t, u16
> addr,
> >
> >  void ksz8_freeze_mib(struct ksz_device *dev, int port, bool freeze)
> >  {
> > -     if (ksz_is_ksz88x3(dev))
> > +     if (ksz_is_ksz88x3(dev) || ksz_is_8895_family(dev))
>=20
> Small comment, would it not be more clear and consistent to introduce
> a new ksz_is_ksz88xx function in ksz_common.h, being ksz_is_ksz88x3 ||
> ksz_is_8895_family?
>=20
> That would help with the renamed ksz88x3_dev_ops that you will
> encounter when rebasing. In fact, seeing your additions here, I would
> propose to rename this struct to ksz88xx_dev_ops.

Will update and re-submit patches after testing with new code.


