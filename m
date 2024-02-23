Return-Path: <netdev+bounces-74251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1498609A9
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 04:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C61288363
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 03:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E9BDDA6;
	Fri, 23 Feb 2024 03:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="jyT6M+wq"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2115.outbound.protection.outlook.com [40.107.117.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05E9C2E3
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 03:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660457; cv=fail; b=BnXMv+SCdqM2jtlHpAjXJsMe8rXDDETXnZeUt+ZvIHwKS0Fojhh1bawMUPFa0Ho51GA5Q4IHMeid0C7aLYleMHEF5rrn5PeyZL2lvgnD+dKCtP9eMYNoBDQbKMFtQRYcj1GM+5wvmzLUXDCIDJSkN4B4ICmzTVUvGtd0kytNAWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660457; c=relaxed/simple;
	bh=MyOQEeMzBtN0ZT6sIo6ix32vlnrm2WqY/Bk9tbQ3Cgw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t9mSyrGYcgoeX8+PkKnuw/7fek/sW4tZsTDuGpGJ5hYjshU2hVHyT0ieiTnxNCpvA2C8poKn09tDTR6uFHkLkpaKdLR5ktG4HDgjcFrm3kTTRpSTSlXoLSFbESNR5hAytJ+DEj/Fz7yJztAi9E4bynrWUgyYB7xHYhy8sZco5dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=jyT6M+wq; arc=fail smtp.client-ip=40.107.117.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mcwhj9GohsU2hvFBrt9wPG12Ms/KlOKPrrBnpSofWSEZg6ufITLpCE7w9AondmuJ6J8B9PvHbzNYAUfaa5xd+mPHbNSFTqTQ9iX9huUsI/HZczVMY+b6dUHUjKJBbPkKg+weBuZen5h/iUB086sM/A7HFEals+WM32Ni/MLvQJA0mF06xF/r8nDWO1J6j/MNZWr5CrvmziNq/LZn+4TGtw4y62/sGVJiUs3tBGCwOu2WFBOutYplojx1DLGM4g8WJS2rv6GnoqVPt7Ww4h/TrIE88sXMkapLEqz/ijBSgZ/8L58WoyQTz9upg1sjDYCsiuu/lzS3objytl9nW0VKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyOQEeMzBtN0ZT6sIo6ix32vlnrm2WqY/Bk9tbQ3Cgw=;
 b=Mx7ouJdZCdBLwttlGOlW08bj4ixWwYhUKX5FQUR9WMldFTRF9oQ92gP9VpcUL5quZ15PiI9kzt3+4PKeyRiHHProohO6Vy6KLOckPwU66g7O7hkpj2s51T+F5EsgCB1hoWwqBO5O+0lNuQBi81bbShqFIf4Bh0DeH8nRyBoNBYsDtVla2x7h4o7VXpsNfgZafAWtyos4EG37iO6V5PFG7uchxm3HDXpSu5sbAgj4sa/9fJeK6Jim+Ws+hVgWw15aSh4gwIKuusQMzrwVNxQa/8tFwOEZoU7GCXaNiVr4rJ8Jc8Qi/WtLyMw59rg6McAYW1PvJBaywEO1ja8SVl/RuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qnap.com; dmarc=pass action=none header.from=qnap.com;
 dkim=pass header.d=qnap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyOQEeMzBtN0ZT6sIo6ix32vlnrm2WqY/Bk9tbQ3Cgw=;
 b=jyT6M+wqwYxo4SHfHBjmgtq9h3W86LC8k256aYfG96vb4e2mORRnsqjorXYlzW1qcc2XPzrIPv8xacL8WzM+MttmwFfm8tCilvVuIv3TGnnTvobHoJV5zBsKnc/Gb+2AMXBXn8a+im4jCr7TawSlNqrsx22PRomsdOstGWKPo6DM1mfJCLJ7NtmWseAgI5RxuAe3cv6+Qe/Dhr8dHaN2p9xlB4/JU9s0ghLjijzg4ZdLiq2e+odmnx04TpBy8FhFPRR9KMvo9k5s8F/flwq+0YLdarvE5kmhZj55u6yDIqXDBFmmdSMbJ1TmvnnWq3GcYQPLjSpGebZdmHE6XnrA/Q==
Received: from SI2PR04MB5097.apcprd04.prod.outlook.com (2603:1096:4:14d::9) by
 KL1PR04MB7538.apcprd04.prod.outlook.com (2603:1096:820:11e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Fri, 23 Feb
 2024 03:54:11 +0000
Received: from SI2PR04MB5097.apcprd04.prod.outlook.com
 ([fe80::2f40:e11f:9d69:5bf5]) by SI2PR04MB5097.apcprd04.prod.outlook.com
 ([fe80::2f40:e11f:9d69:5bf5%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 03:54:11 +0000
From: =?iso-2022-jp?B?Sm9uZXMgU3l1ZSAbJEJpLVhnPSEbKEI=?= <jonessyue@qnap.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] bonding: 802.3ad replace MAC_ADDRESS_EQUAL with
  __agg_has_partner
Thread-Topic: [PATCH net-next] bonding: 802.3ad replace MAC_ADDRESS_EQUAL with
  __agg_has_partner
Thread-Index: AQHaZWtNDF12TJHYYEeyVWmKAhc8p7EXRboAgAAGu90=
Date: Fri, 23 Feb 2024 03:54:11 +0000
Message-ID:
 <SI2PR04MB509756F6E1DB746FA0283407DC552@SI2PR04MB5097.apcprd04.prod.outlook.com>
References:
 <SI2PR04MB50977DA9BB51D9C8FAF6928ADC562@SI2PR04MB5097.apcprd04.prod.outlook.com>
 <20240222192752.32bb4bf3@kernel.org>
In-Reply-To: <20240222192752.32bb4bf3@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qnap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR04MB5097:EE_|KL1PR04MB7538:EE_
x-ms-office365-filtering-correlation-id: b8d03339-a28c-4726-161c-08dc3423183b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ooLlf30dklqbTP6FgprrlAaTN4odpJjBN29xdr8OvT1yqHXFwuz2m1RN8OUDMuXaCok8XLCGe9Ef5BCWqIDCXMg3o2gQ4BQ+h2R3WkxpFF/F2FnhGdN2RqDwaJf1VK7IdWlQRe1760Ppd0T9rjq31sHf1l2Hnd2eZiAHBat0529tY2rBK2I0iM3t3JKM81AvUZvSvn6FVvzLVI4eCJMR+Z3zY0yegB6RppmdxcYTvUS2WFJy6bOBLIkq6fT7jC/kygEFAvBIz3YUOV5VU5YxIrwaZdwt9k0/5Q0Zf5tFeeItCJo9qoKldKb88fcKeaqPCzIgrDZzMu7uhE/N41TVGis7jwtszopMhMLhF3A9xX+5WMQHCw2vOaf6Wfw/mM09Dpg09GhQskbbh74nM5HUdtmJWNlOJEFwVa6PCYe+G0HyJZ5FcENH6bOUz70j6pHMz11ugYIh0qsdZsQMvyYHKxPeYFapm0egwVCjz9l1XVksTnMVkfPIxQl+QXlGm3K7lnTwwHzMNoteyI/ly5zKNyM4dI7lhfpTCIzMXg5u8uLO3/SApnsIWm8uJolHnZ/sXaCyiCWRwD4vuWNe7oxfGcRbQxQ2fA7OnqyOGweVkdbhFbJgbD/5+2MHRBHm3BoX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5097.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?aHJxN2M0M2pSTE9CQmhPd2NzVTdhK2J5MmFMMEt5VFJQNnZNaGpaejV3?=
 =?iso-2022-jp?B?aGd0dE9yeTNwMWUwdVhHWTVpNE5taENvNlVlK0dTYVE5aVYzcnF0ak93?=
 =?iso-2022-jp?B?dmVMcm9yYnhvWDZaMmNtQUd0dk82OEpCZkVBTk5DM2psTUdwTmI2RUUy?=
 =?iso-2022-jp?B?elppZXBqWEU3RWdJVWVJdGVlMmlRL2Q1alc3bEZXak1vbGh1YVgvV2dE?=
 =?iso-2022-jp?B?TVFILzdoMkVSaDZCejZRWmFHK3UwaWEwbTJuVVZvTEExMEl3a096YWtJ?=
 =?iso-2022-jp?B?emdLRTRDZ1ZSNHVSeHJZMitoSWFha1NRTVRzUE5KaHFmOGJMRVMwVVcr?=
 =?iso-2022-jp?B?WFFkbG5WU1BDUU1EUXRxRDlEaU9ta3dWWGY0b2RjRUJEY0w1aHJWSkoy?=
 =?iso-2022-jp?B?NnlHOWsvMDlBTTBjQXlZSXBvRnlCenhLRmFrdXZqeGh0QUkvNzE5eVV5?=
 =?iso-2022-jp?B?QjRRUTF2NjYwSHQxdEsxR1lwbGNvVVl5STZvb0NVck5NK2h3SlQzcGoy?=
 =?iso-2022-jp?B?MVZlQk5SdFRpd3BpcVlnbEN3R3MwalZ4Ynk2NFM2aDhYKzZ2ZmowME5v?=
 =?iso-2022-jp?B?NktlaGR5QSttVGdDNGFqQ3hxSTduZk03MGw2VHNDN05MK1lqM0thQTQr?=
 =?iso-2022-jp?B?UjZpZFBwUnFoWlVXdnlTN3R4cTVLQTBFMjA4cGJYb0loMk80YzdtUWFo?=
 =?iso-2022-jp?B?U0lqd3NpRUkweTZMK2tQRiswV1ZpYW1jUHEzWDE4MWFnVE1oZWFGcmY0?=
 =?iso-2022-jp?B?RE5tZVhkWTlBVDIxMC9tNjNHUjdUUDBYN1dkVnFXcTZYT2huYnZmbzN3?=
 =?iso-2022-jp?B?U1gwMjBUMmI5d3pGNElnK0RTMkh2ejUwaGxGbkhoaXUweThYUmdOVEpX?=
 =?iso-2022-jp?B?Q1F6TTdzaWpPbllHZHErTG5KdUlUV3RoTWk5OG9mcGJuK1dBazhLS2x4?=
 =?iso-2022-jp?B?SEp3a1NBcWdZd29KQmlPUDVsR2k2SUpucURkRDhQYStZT0FEUjBOSXIw?=
 =?iso-2022-jp?B?ZVhOUngyRm9ud1BQdXBLelNDaFFpUHVjUG5FenBoUGhKOHlkYkl2NkM0?=
 =?iso-2022-jp?B?TmJaYzhCaWhwUXhUZlVsM0FxckF6bkhLSFFKUVZPM01vT1kxZFMrbVBV?=
 =?iso-2022-jp?B?VzltY05JSm8wMk0rbzVWczBNbDU4TzZ4MWlKclZIUEN3ZS9GQ3FaVlNo?=
 =?iso-2022-jp?B?cGRzTnZHK1I2bGVkRFFDaGc2Nk5TQUVtN0h0YXFQYXU1OXJGZ05JUzZu?=
 =?iso-2022-jp?B?TmFNZVoxTXZFcnJrd3JwalJJMDd3M1N5QnJPNFdkVHBpYUw5bC8xZnV4?=
 =?iso-2022-jp?B?L2dkZDJXREovcG92eVNzT3Fvc1p6RzJlbGl1Sk1FcjN2Q2JodjBhNjYv?=
 =?iso-2022-jp?B?U3ExQUZJRk90U0h2T0pSSFZELyticGkveU1Lb2ZWd0N5bCtVYVFXZkZh?=
 =?iso-2022-jp?B?cnQ2MTRsWlNuWUxHaWFzcmxHSDRmZXlsaU5ZL1RmSTRJN2x1NXN2ekQv?=
 =?iso-2022-jp?B?bVlEUGZ2WUxLOFVrblpKa0g1VmJVUUpzcmNrQUJjYUNxMll6bXpONG9Q?=
 =?iso-2022-jp?B?bVFjNGl4Nk1ZcWhVbHdGVzJZQ3YxOFNDdWZaTXNLK09UOUJMSllhcHVC?=
 =?iso-2022-jp?B?NUVqa2FZQUdXeHZWT3AvYU5VRkVra1N6RXZwazkxb29QaDRYZEFzREl5?=
 =?iso-2022-jp?B?bFBDZzRMRzlXN1A1dnBpVU1kVHBaY1FYOFZsRENkb3JvK3dLRUROOUE4?=
 =?iso-2022-jp?B?R0pwSG10WlRkMGdBd1lvNnNnSG96a29ocEdtd01XL1cyeWxiN0x6Y3NZ?=
 =?iso-2022-jp?B?c2xza0p1azRpK1lGa0t5UHc3b29ldHZpNTFkeE1rOFlsVnNvZEY3L21s?=
 =?iso-2022-jp?B?ZFNwV1hrZUhzaCszZWh2YVZpQXFQbzd0SjlzVCswQ2V4d1QveCtmWXY3?=
 =?iso-2022-jp?B?QVZGb240V05jRjYvSnpKSVM4cGRNU25RTGgxR0ZyUUR4QXEzWHV0Tmht?=
 =?iso-2022-jp?B?YUw0empaV3dZbTg0blhwV1JtbG1iT2FyeUhKN2Q0enFOUThuekh5OGlv?=
 =?iso-2022-jp?B?Zy9HOFMvdGlZWWlPeUxSdFltNU5WZ0x2TXdGQ0QwaTRnRVo1bkxBN1VN?=
 =?iso-2022-jp?B?YllnSzBwUk5wM2I2WHE3eUtXSllaYldoMnNNdmF0Tm16dTM2TGIvODZI?=
 =?iso-2022-jp?B?TVVESm9VT0hGaHhTdUszeGU3WVRyaHNES21XMS9DSnhkTWR4YjlIc2xz?=
 =?iso-2022-jp?B?RGd3QmVzU29JMlliSEErcWo1NDNwV04raz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR04MB5097.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d03339-a28c-4726-161c-08dc3423183b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 03:54:11.4588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y327QQAXYAh6ZZJVrMb7jw+QxDuC3s6ZryfvjD4yCDkj+Vm6XG0YMkvN8eRq7vF2S+/J8LjBNkdKP8qVnSFfdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7538

> You need to CC the maintainers. Please use ./script/get_maintainer.pl=0A=
> to identify the right recipients and resend the patch.=0A=
=0A=
Thank you for kindly feedback! Sure will resend with correct CC :)=0A=
=0A=
--=0A=
=0A=
Regards,=0A=
Jones Syue | =1B$Bi-Xg=3D!=1B(B=0A=
QNAP Systems, Inc.=0A=

