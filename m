Return-Path: <netdev+bounces-155897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC8AA043C9
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E01F7A13FA
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6081F192F;
	Tue,  7 Jan 2025 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="od0D/bmT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB6F1F2373
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262633; cv=fail; b=R+Q0rqiJ940+2d+zNmxcwPIZp+Gb7S6MduA07or/zwafwNd5cSs6EehRJaF7sKl1QJYmNc9wq08h68ZFAfNx78Zq0+WgqSwJ7EIowvBx49ECVbcyp1qgT/7aYrhqFTzex5n6GzrGFlgDmMAXQJDIUfHambI6TYwby3niMl1YIQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262633; c=relaxed/simple;
	bh=yF5QVCxry+yeIEr5txcBUwYhbj382ECXw78XCE9C0wg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hitk73FAAQJw6/UryrAqAG9j5ZIcigp2VGGKR+cjcaVnJhLUIU5sQjMUDZusX4mz/9Akh+++s2U+or+uR+ezqBGzuo3UBJqfrsGhDPkOue4GL+SDQWawH8b8UGezq+BVsQ/3L20AI9uXfqf6OPcHvSiMGNG9JDloildLjCzcDKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=od0D/bmT; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrldinL7MpQ3+lCTsoqmy10dPqGqcqoYo5KJGoHrDdxylwKg06RPfZS8W/UE1x0rLQRhUFh5QHzcBET1+ujQUSC9KG22Ey5gXwtMIWXZGWWbVhEWEsMxAbm5Bm9ANI1JxirXN6x0vL60esNiX1dy+TFx44El6GeJYTW/3OXpfzYdTCQtP6r1hJHLzcDBNHZAe5BpcazFEf2gAo+h2DEi2j0R1WysD1TLw/lH+M+VMJaBBAG4AhtY2L/Vor1Jm8MvprcPHKrNa7F0q3qq050gEZzP9HYKYmcvmxEkQY18FNK1jt4HJFGzS1O5bEH0eb5eqo1WDoEV8VQvtIvcF0mQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yF5QVCxry+yeIEr5txcBUwYhbj382ECXw78XCE9C0wg=;
 b=pZdFusU7/FDJrY52TQxS+HT037WYUcJddYRMHNSw/6K1RR8gLm4ejcCuhZQ59PK0VkFzczqiN4wFOhpjdnYHiVx10fmohk3Y0856KHhCBShE0Y4g9Uc+57E/3Hbwh5OA40dlsfwt5Gq/W+x2p41kalGqyTkYgafABbUi+Kpu0Yq47WkFf1w1hBy25xYQcRyYyHUBlOzHwhH5Wf2FY1ET+Fokb0hIHTQ0mXq9VJ46tlAAkNFkskUkhZAKDf5JN1BFijGJm27SSPd55s1hvJWJenFEgBUHAYvnH4cCWkNteeSnT8QT4uzSlPg22m8q0gvynaCaIrZ/ZEEkO9reycb/qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yF5QVCxry+yeIEr5txcBUwYhbj382ECXw78XCE9C0wg=;
 b=od0D/bmT9K9vfkhfcypVDHj1fqLNIcI6Do5VUokGMemLum+TxoT+6dBDzGsBH2Xkq30MuOosGHswRwkuJwrqGWfLElPEDl8RL0oYHOC2JvYrMou3CI3G1QG+N2AxmBcYUVGwu8sZlyqid636HLFMDi/FSj7OV+7ceFM8LGwRd0RjflktwvRT/XevRRDKSpE7xosusxWAyI8iyDL2bNLzO+1FW2BraftKjA0iLJcR98mcGtTF80JGCsUi9I8nE26UMigOmCu1odYSl3xHMqxMiWpl0V4O2+Z1ueogb5zHIKD4P54dEa6zaHPNvyEOeJaCu23jVJs9soi8Y+4meXIoOA==
Received: from SN6PR11MB2926.namprd11.prod.outlook.com (2603:10b6:805:ce::19)
 by SJ2PR11MB8538.namprd11.prod.outlook.com (2603:10b6:a03:578::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 15:10:21 +0000
Received: from SN6PR11MB2926.namprd11.prod.outlook.com
 ([fe80::8fe6:84f3:2dcc:80b7]) by SN6PR11MB2926.namprd11.prod.outlook.com
 ([fe80::8fe6:84f3:2dcc:80b7%6]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 15:10:21 +0000
From: <Woojung.Huh@microchip.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <Thangaraj.S@microchip.com>,
	<Rengarajan.S@microchip.com>
Subject: RE: [PATCH net 2/8] MAINTAINERS: mark Microchip LAN78xx as Orphan
Thread-Topic: [PATCH net 2/8] MAINTAINERS: mark Microchip LAN78xx as Orphan
Thread-Index: AQHbYFuyrVcAlX+vYkCLN6Uqrkp8arMLWwrwgAAQIgCAAABOIA==
Date: Tue, 7 Jan 2025 15:10:21 +0000
Message-ID:
 <SN6PR11MB29266D59098EEEB22ED3BE86E7112@SN6PR11MB2926.namprd11.prod.outlook.com>
References: <20250106165404.1832481-1-kuba@kernel.org>
	<20250106165404.1832481-3-kuba@kernel.org>
	<BL0PR11MB29136D1F91BBC69E985BFBD6E7112@BL0PR11MB2913.namprd11.prod.outlook.com>
 <20250107070802.1326e74a@kernel.org>
In-Reply-To: <20250107070802.1326e74a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB2926:EE_|SJ2PR11MB8538:EE_
x-ms-office365-filtering-correlation-id: b68b2ca0-42ad-494f-24d9-08dd2f2d67cb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2926.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1F2+IcAvSea5LkmwfwLoy27tEKHHUOhxvO1gK0+YM5eCskyDOv3WtmC07+HC?=
 =?us-ascii?Q?eyaYPtPEtb7A70glRgNloJCnY0tzJ1qhaH/Yl4TuvYE9V4RYvdOq5j3RFp1e?=
 =?us-ascii?Q?KqTc/2msXlP0eQNLqunVUARBnyuz8hbV2p6Tp7KZzhRW6kNIZ4cUR/kqgP/X?=
 =?us-ascii?Q?wzVc7UlKF4JVEXM3zbNwAm+AONNBo/8tfmoN/dNPWL3RD0PzDB2M//5f1GRu?=
 =?us-ascii?Q?rCrxJ2Mb8ym4GAWQsy0Nb8eCPwvWDGAJmP0t27bCLp0hnV4g8msGtt+vF5KT?=
 =?us-ascii?Q?3LRHoHPO94jrS92528cD6cZrkGHqFA3SAZlKY9+KgD7btu5bhzpsSMcWM5DB?=
 =?us-ascii?Q?6JuBL6wcnKGgs1p0z5cP+T6yrdV3G/XJImi9PrEMhYK9s+erOJTHZLGh436Q?=
 =?us-ascii?Q?famOGXkDIzau6UxMhcpLnFnsoD9sF5Mi9BBuShXSsbyGQ6SJ+5LDw55MXDab?=
 =?us-ascii?Q?eSSqXcR3Iw1bdkmDWtv4ZYWbv1XlsbuG8j3yBmjaZgsYE1WXRAksXcm1RaEb?=
 =?us-ascii?Q?o8d2xsET9F08Bsh7zhNWzbNfqDFKPuG5Rm/jYD45uKtzmfq68ERJ1e9KdkOa?=
 =?us-ascii?Q?2yNQq+Hx4cGBi7oIAlLVqsRixNwm+3JyyZVIqCQFmee6f3NhrzZMtTFbOH0/?=
 =?us-ascii?Q?Ki5HXa+TALpk225BwMkUMHO6p3Oe8u8pyowEZ0e6ytLIL0PjjgzRwbWgkrK6?=
 =?us-ascii?Q?+u8d79ACr8CPM5wigaWPyjtG7tzaN5WkSk/UaVqbdoAfRg8x2cNPxAKpzpsE?=
 =?us-ascii?Q?AbpN0Z7iETB3qoLncIEhZF8D4vPpVC27apVXC6/umoJAE55ft+wK4xM34pQl?=
 =?us-ascii?Q?w6GCIVwGEN2Oqikl537oufiLo8gbZQATGJo+bKO15X56cCjP2uTzvMBZKVOy?=
 =?us-ascii?Q?Ch8LNGCL0pjVZTu/AHKqL7Ci0a3fCORUyegJX5YaLAv0ZCW7kE5vTxdgBFi3?=
 =?us-ascii?Q?FuIUNLoNAnFVGPeD6kY700No7koEv3+VdyDCIXvVV+LHU+ubpLrhZzzKCUaH?=
 =?us-ascii?Q?KR8HNBqsBxXbaNNLoM1F79VtLSXQwcy8cI0vMiBE1wM3hwSF30CFuOUwbsyF?=
 =?us-ascii?Q?EIMnxC5GJT8wyb51ezznxAPL5DwEQwu3VGyv6py8qGSOd4e84pubNV3aP/Ny?=
 =?us-ascii?Q?777tx/3toRxog5X7nc01874pyOiXBOqdUaUtx65PM97YKqXEhgtOI6XN55Qt?=
 =?us-ascii?Q?cFq+Px+J6OQe0u52xuKXRNngXM/SDWkPOqkdYSNQaWhgdlegLXKf4Dseugw3?=
 =?us-ascii?Q?3FNCoWgw6eE4DXchZsAlqxmWsld305lULU7aATtOfjX/pij0sof3AjTxwCrL?=
 =?us-ascii?Q?vGIGiXp57t4Z6VbLNpT7xPU+5OrbbvncZNntOLbVQ1Yj9ceRIuvxTU1iUb7J?=
 =?us-ascii?Q?r9So4j7DSJoyUuC1a0pAd4swuC+0ylLiwbgwn3588pvASBAsm0SC/1tVyZx5?=
 =?us-ascii?Q?3OByoS/OS5Q/fe44arz4O5Ihzd4yCAV/?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WpnG8SNFFtX9SDk/1QQJHGx9kqvOc2GXZgjjSfNu4T2baw0Cma3pGCpDj1Qj?=
 =?us-ascii?Q?OFXhI9Tg0NqnUjp9/HoJDEcmIXRSNlILFoSCr4Wr6LVzivBm8O+puANa6bYG?=
 =?us-ascii?Q?OgnclZmJaZe4wntT5QLPWS6pGGA0IGuF/judlY3RcuuNLexPUddFCMEGcYlN?=
 =?us-ascii?Q?0Mwo0NhuGp4LZ6Rx8ovMvXHuZMkMAhdIFeb4gWqjI6x9fIg1rM9KDORIOErL?=
 =?us-ascii?Q?q0T72hus6lGxLWKt26v/mqM8NkgSJlPaEuoSDpJMBQYJ3NXhYvSc59J7dvmC?=
 =?us-ascii?Q?emMDdzQLVX0NARBkAtZ4q07Mt8EMIIfHZxZDVL6dHnmtedUXLOTs39s9+n6n?=
 =?us-ascii?Q?J2Z3FrV7XkuZZqTodeGjYdxh6Hemwz9XE0aRcfF73csNAA7vgl6UbehHlB1W?=
 =?us-ascii?Q?FVUJtDXcQ0eGJXj4LhZFzd7zSm+3pHgD0VDQKFExYxS15VC4TY4SbV+pCz+d?=
 =?us-ascii?Q?GkzmCMQHK9QMcrJS9Q+uhmuDvtUzZQxiQLWDksUZtf8iMwerKr1bXf/zvWZu?=
 =?us-ascii?Q?vRrJQnutlwJWAWbp6k8jdEaIlmqLT8STvP/pyKXJ64I4sG4sJHvpoHQVYavl?=
 =?us-ascii?Q?TFpbta9WPU1RoBHqPpbl+JzkcO8hKFxy8Vi2f9iO4ce4UYsJPcW06DI7r2lX?=
 =?us-ascii?Q?0BcxaH5uMOcocBe1glcgLrM6Hp0tW6Yh/D9LewiS2UqMYwLOpuYhUoBIov3U?=
 =?us-ascii?Q?fc9YbOZY19O6u2zxaqQv/o1qWffU/GqVuswWbSx+eQkSau5SCVnyy/BEC5ao?=
 =?us-ascii?Q?d6qRW7SY7hQYNLCd57ScAKZ7GWbkR9ZwfhT/SM6H+Cy83dKwScjod2gNC6LF?=
 =?us-ascii?Q?S26YRJAWVCXLf0Vsm7lph/s3InZix3dozju9pWn7Z/5VJ5chM1t5ML0xDQlA?=
 =?us-ascii?Q?p6zXyEZ7FtmAwumvgoy8N+tB4kgctoZrKK/IhOF0xuyAWPJo4p8+ULUd98Mj?=
 =?us-ascii?Q?VuK/qJVpDng8phMwhauKD+LpXkR+bWxYuJar8IFZanvMCTn4mxCOMpbXYdK9?=
 =?us-ascii?Q?MC9QvXJQh68fyFPvefAafkx+KZBdtsAlI9BCeZG+/xx7+tUq4MyY/cZcbDNr?=
 =?us-ascii?Q?WUqJe2qzlxlz1zWNIes24SmuR3VOZcqHOUndCp+4Iv1s5u6knvRzHFCO4N7N?=
 =?us-ascii?Q?mxxkCkT1SV2AbSKYAshvTGzXIab6sudxlr8zQR5EDbJYrK6UztlH363Tn7Kz?=
 =?us-ascii?Q?EIwhUphqgTVKnn9Tvu/XOwujx/5NaFaDUAMEokIgqVI3iETuit1+UwD2vDr8?=
 =?us-ascii?Q?YmalwrUk8+R72oTYFt4lHpHeJLm8mx8VGaQAfSR60ii4Wcfs+9oSvmDQYMrS?=
 =?us-ascii?Q?2geAIav/ZcMgsw7pKR5TO1u59mKeCYVPFqa6wvFS1NUryRVW+cAC40jzeo8l?=
 =?us-ascii?Q?StPOxuaFmFkDNikujTeG5IsgC2Z/Mvq6y3vVoIVrs7XnCUw1tMjFhOiFieRi?=
 =?us-ascii?Q?VfL/2cLvhncP5B/7WaT7yeg+obXbZlt/t1LWKiosVP5OYV4qRE7nQvBssxpM?=
 =?us-ascii?Q?pcL6PR5i57nBHtdpDv/xwkBfpFT9gwERURl09CnPOLPC9rg/IyONE6urKku7?=
 =?us-ascii?Q?JqqF8IrwwwDPTgeZApF43cZ8TOM1dJKVDtOO5E5S?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2926.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68b2ca0-42ad-494f-24d9-08dd2f2d67cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 15:10:21.7707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+dHOxWZ7vJdzkpSNFpFCZ08n4u9+kTdOhdnXwWP1kZoVYumCFbmmdW8A3ooryPFUvi42zWuMCWkWzCFWq4654ujTMCj8JEDEbG4vd7vybk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8538

Hi Jakub,

> On Tue, 7 Jan 2025 14:14:56 +0000 Woojung.Huh@microchip.com wrote:
> > Surely, they should involve more on patches and earn credits, but
> > Thangaraj Samynathan <Thangaraj.S@microchip.com> and
> > Rengarajan S <Rengarajan.S@microchip.com> are going to take care LAN78x=
x
> > from Microchip.
>=20
> I can add them, I need to respin the series, anyway.

That's great! Thanks!

Woojung

