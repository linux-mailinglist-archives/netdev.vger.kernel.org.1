Return-Path: <netdev+bounces-195068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B68CCACDC2A
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 12:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F83C3A5554
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 10:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AC428CF58;
	Wed,  4 Jun 2025 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4ly+D30T"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB81B0F17;
	Wed,  4 Jun 2025 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749034374; cv=fail; b=O1/AYwlvtzlhZvHZ3Qp4GQXOxquTuSvxA4IKyfncLZF9yUsGt6414u9xq1Ehj2U6rx3IgqRATIe44aaprO1sndQQFOGocVDWdyLDN9sI35zdcj17sLYvjKiBA+6f4HrJyHF8hkaKfgaOeBE/meKFBml0reHddbHqgjc5J4zqEmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749034374; c=relaxed/simple;
	bh=wcIsxtEeHE9NUPZAvzluYWu4OzNIThL1mdevFRSrVcY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GkN0i9fi1xcyesvWjvZ7RG+slJGL/VsdfhH5iM5wUoOcuZwvHJRDehaBhCXChxCMvAPbZ06qpRIkMoHdl68SS+VxYKTjK8fnwWVyKb9A0ZfdD1Vj4AD4RIrQvEl4+LGVWgp6HgorWpylIQ38DDegtM92oCq7omZlgbz/ROrzFCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4ly+D30T; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoS1JvS0P8jH6wExeHJHLVdq7cCA4yQsOKbNgPnQ+7zeYBFxI61yHX6SjISBYauUIRZ9wXo/0oDdiqoxd19HQBXCQlEqH6Ex7JBBQs82UeDb+v71h6Tzy+3G9Jfdwrit74b1JYpw2uCzCaYjpk3yEVUUhecFu11S9AeRQeQcpNH5G/760kXt51bvgSbluRlCtm59EzS5bKAZD4uH1Dc9/0S4agYQGIDA4y0daYROVWc6hw4Dh6Wh0rBJCwDosWwWGea8/FKjEyQl+jRuEMenR9WR1lLdf5qZ+oJkD9itBuLAvNKMhfyK33Hosxr6ObW0+IqhP1kmdg8hNi9K5vbbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKZSWj69udCLp9IP2Mr4xKsivl0TM7HGBZGc7SfgpV8=;
 b=aQb5JizY3dNoOZr/1ArjnDuBwqTLUWVuqYoiKHPSxe/Ww0u5gXuiXgacZFuid+LmNWDkye6ZA2BjHLq2zJCShkhut/CrlMHZfJaY613JdGXniA36NwraITnxMw3FPMRub20RcrlieWEFCladfYTwZXCyGDtM5IGQ85+yAVwP8UWKQcyrKfo2X/iS78B2tQt9azujU+koSyN/DHKssMlSnO6K9cUumwl3ta0RHI2DFh5Oo6ZFLQ5v90P+yGsHzGZ72RhfrEsvMzf+U7Dz5+dz0tJeeb3WT33ktP79cxaJOJWWrWWf5OL2vraFsC/8vypFR54aBu96GcEfHLsfMW4dWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKZSWj69udCLp9IP2Mr4xKsivl0TM7HGBZGc7SfgpV8=;
 b=4ly+D30Tl7AyuZ+fxnS/s/ubsdU4o00zDHn5KJUFRaTb969dnj8hbJJZynJl9Uv16ZnmZ8IPiUTY6VMI/8jRZ57iQKARu8NbYSZt6iBdW72RrWG8W0ZcE1EYkXAUnIsF86dmVy9JZg2bNmvx6s5C0oUQsnDWxHZTaeTusj9Geb0=
Received: from CH3PR12MB9171.namprd12.prod.outlook.com (2603:10b6:610:1a2::5)
 by PH7PR12MB9073.namprd12.prod.outlook.com (2603:10b6:510:2eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 10:52:48 +0000
Received: from CH3PR12MB9171.namprd12.prod.outlook.com
 ([fe80::4c1:7aaa:e0b2:ebd0]) by CH3PR12MB9171.namprd12.prod.outlook.com
 ([fe80::4c1:7aaa:e0b2:ebd0%4]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 10:52:47 +0000
From: "Joseph, Abin" <Abin.Joseph@amd.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
	"claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"git (AMD-Xilinx)" <git@amd.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: macb: Add shutdown operation support
Thread-Topic: [PATCH net-next] net: macb: Add shutdown operation support
Thread-Index: AQHb1JwRPoJ9JHDVV0yZ8utTANT4R7PxlxIAgAE7qaA=
Date: Wed, 4 Jun 2025 10:52:47 +0000
Message-ID:
 <CH3PR12MB9171B307A46A01455DBBA241FC6CA@CH3PR12MB9171.namprd12.prod.outlook.com>
References: <20250603152724.3004759-1-abin.joseph@amd.com>
 <3f3a9687-1dea-41fb-8567-1186d4fa2df2@lunn.ch>
In-Reply-To: <3f3a9687-1dea-41fb-8567-1186d4fa2df2@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=18e6ddb4-1fe7-4b3d-97b4-4e863d4ea4b0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-04T10:46:49Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB9171:EE_|PH7PR12MB9073:EE_
x-ms-office365-filtering-correlation-id: bdf238bd-aee8-4794-03eb-08dda355f1a9
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JakUonl5DGYB0/TzUkvdspNMIzWkVcPjSPVAx1zkvW3FfqC4ljmep6iC/YUw?=
 =?us-ascii?Q?pLUD2ChoVSNKCXKIrqfnnVehW2GNBnq+uxZFCBcCa5wZdcwT2OsPCbUkEKGe?=
 =?us-ascii?Q?ss3bcc9+zUbaCCfDHaF3ehI+8FNo7LsSeHNx95ZuqAXxPsmbzeBBGniRsZgV?=
 =?us-ascii?Q?WjpPX5J88LPkJt8CAQsFvSNk2oL5c6czgJ3Zby1J6iPyaFxct3NgkwZDImMP?=
 =?us-ascii?Q?VkzgK/Ipu6QOthhzhp3tBs39lzXVnnZipaudXH3aFFBS4I9GuffRIowuEHhR?=
 =?us-ascii?Q?3+5yzapvKCPqNA+h47SqqVqYVi1iKjtfoA+/kwKtTGdX64IWjsVg5d1SenY0?=
 =?us-ascii?Q?LWEhIvXayka1/Fvi1MUmF5EpxVBEa9FxG/aGagQ/gSMVzFc0OtBjJLm0kzdx?=
 =?us-ascii?Q?leJnFy+UbG/QHI5VonYDAimDHJ43DDY+qkpXmIEaRSvBGNLzoYqtmFbSGEWY?=
 =?us-ascii?Q?Js0tq/71AhYR8vDM1/iHUhz7Wu7+3II+WUkvLQ0XWdt8ZEjWwmomk9asYHpS?=
 =?us-ascii?Q?bHON2hzWYTFfrIskibfNTUCA6gjJQMlOoi3sfyWf2Bl9ThvUe2O6PWafRAi4?=
 =?us-ascii?Q?+i7ihyDbUSdBhcTQOWw3LFp3KLTYRjsrfHOtmViQgptIVfWHeSC/27KVcTs1?=
 =?us-ascii?Q?FNmcHPUvn56vI1mh+TEvtqAyPAHG1fwAg55KZRLUnw42kg0cCOFQo3He9nyr?=
 =?us-ascii?Q?XnU9XBAOtNx4ejtwV35zvwZg3UH/I5sqiGVT9e1hAD/PK2XDCN9XVl71YyN+?=
 =?us-ascii?Q?4CWYPnpR31dTqPllEnHKX6T/SxmKxpUHqOg51LSWKvnOJYJYY/ZW0kU5M64t?=
 =?us-ascii?Q?mh45t4Fgp9mQzB2a15u8p6RXSke+ab4n5rEK0mI7kKxAEn9lrlX8a6OmaXgH?=
 =?us-ascii?Q?NGbC6KiGsU6bRK9i6lpJJpWSoAgaqDYrzSUw+ZVP2UcqOFvM4J6MNklbtLwj?=
 =?us-ascii?Q?V5kwF9O3KzSLux9xYJel3LQNKBzJtkcOFYbxyqVcFqsCApFqJWgh3C6fxGdB?=
 =?us-ascii?Q?MrParFaTJj9KfZDOlyEIIeLgQ/lgDo35ZNwVvo4rKZoauB9y15l/D4hCgF3r?=
 =?us-ascii?Q?4pVCZuOc9NV6kq1iXvI4hNCIPlvLzt5+rkQQGqJx17DzK4R0s2obZVbVBhwT?=
 =?us-ascii?Q?HYIxTCrzaT+wv9DOQtFEnEg1w/caBwYngOPKgP19z6rFiIhT0QblZx+PrRj6?=
 =?us-ascii?Q?V1PaKL4SamzZHRd+0gWJ8NZgYATD8QOO/4n2gxpchmlwvUzsDdDyHlViFnZX?=
 =?us-ascii?Q?+/9qMTl7CBQtyNRHSceuZvntnuJAm4ayyMf3cExaP/RA/4BEoRAQ2lMZjEOn?=
 =?us-ascii?Q?uBte38mfWZjw9x2XxkN+PhNp3D4dIvxhXETf/Q9kELPCEKGB3g5B0yECqkim?=
 =?us-ascii?Q?3lVujAhThWeZ3kv771LvJTf0ozhvo7kx8EOEDYSOMKDpdKLPnuZK7l6p8NrG?=
 =?us-ascii?Q?LgfyjRoTq1BZwZm10VRX9OLjEOfXFf2XkCFyf8VusWkvKDaOptWlM4ysANFc?=
 =?us-ascii?Q?IpLMa9rA858o7Dg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Rt4Ix0SkBmPiXuxWXeoWglAPKaaZnkk1bbGW9alp8aVDuPV46I8TXarpVD2o?=
 =?us-ascii?Q?sfwcNQM6e7+iN6BUmhY0HlJZh42UrQ+AlyOP9mCrS8L6trA7Bijk+WFTVVtA?=
 =?us-ascii?Q?MKpr4WJQmXzq2//0+AezSWVw98sS/R9zb4DAX71x8YP9dVa8gphtrCM6TmLL?=
 =?us-ascii?Q?G6bkHBkQnbnEshH3UH/Ast6wDRWhh/WmRt0FcaiB8zLJ8/2NPSLtlMqsW/1w?=
 =?us-ascii?Q?KlHy7Y5qP9ZhgsMU1nrtZv4EVKkHD9Ig1elTqXq5yqL3EXGm/1io0qvTnYRv?=
 =?us-ascii?Q?GCD5GZKwKMqASWQn/gpcmicd/MRY/N+yr3ZBVUm7MBLfXWRbyjtQrWBKgkoe?=
 =?us-ascii?Q?0ErX6TZoJqO3ZzRTJSn5ucocd6V5yKiITzZn4j5wo85ecVTNK4f/QUDBwX0N?=
 =?us-ascii?Q?OD1DCMQiKOXkTM1b1uKdBpGVHBVsxR7LXsZ/l78Z4WA1Otg6dkY2jpAtHmr8?=
 =?us-ascii?Q?dWKrfvJ8o93dFZTXDmue8htCo6x+JiqM9kfpCltKtne3ELMV3pTyLm1eRIvs?=
 =?us-ascii?Q?KwqG7lLgQLw3dyZOYz+KtWeja+5zYEx6DAZccdpUCBMy/xbT12/QkHdiGfQ4?=
 =?us-ascii?Q?iq5TBG0R+dJRiXB0GB6W31ajtzcilE5QOC9yJxz5yWMuSwrm41TjUUMtaZlx?=
 =?us-ascii?Q?HjFfSFPmkXtZWXNYwdj8OSijN5z/Suwi609/vaeWZ6MyRRBXvrjTK4UIQAtk?=
 =?us-ascii?Q?yVebe1/fYxkQihK9IqGbvN3ieJt92loIE5cDFEoAK4R9P229/Zl7FTn035vv?=
 =?us-ascii?Q?vSeX1/NFl9wCgpTqA9BtRqRlwd+EtumutUNGlKLoLKGe3cVuYy3grEaD6zQZ?=
 =?us-ascii?Q?PtMfYI4i+1Xi+5PIgdswPKzkVu2A6yaws8QirqvYW4YI1fa6lTcKuDUc9gRj?=
 =?us-ascii?Q?BxLDl01CT1sH4RZisJs9bYI9l/6FP4ZqlIa2gOd1TdO/uHxUJ/lAUeA6dxQV?=
 =?us-ascii?Q?Oeq8RVy0xRyqVe0vWrpZu6+488x4aLfzblLlS8xR8VZe2wCW31SUeSra8oSt?=
 =?us-ascii?Q?hTtJbmQ1p1wnO/96nQJADIEeCB43U9XROY0x5Xnf4BcARgy0M1xbbwu7pPkX?=
 =?us-ascii?Q?KYniQBEnv0CzwcTLbsuKvKVfCk8pw5XeY0HpxbVRn/t6yHmCz2ap511rff1H?=
 =?us-ascii?Q?sDlZtSAvbE5w1aJd+fzh8NupR8lr2Y1pE9rKrySLwUh7SvcRWsmnYtYt191j?=
 =?us-ascii?Q?pC1KnDSIn8NiHmINb9wDYjzhBOHWg5BafZ/zlWeqaMHGmfUK0ylvdepnwxbA?=
 =?us-ascii?Q?FiCWSVGbqhBXXvpeY6EJgEJJEriz+a0D6rMClA0BBoKRfewhXKWPNu/psM39?=
 =?us-ascii?Q?RIwnAdKKryObFk+eLdWi/HcqRsSTGYrKWAXdOPV6v0gQ+pm1Zo9ICgUh0UKH?=
 =?us-ascii?Q?Hb2MZKBiFJnHxKzlPv/JR2JaeOxwTVegCj2n4T0Tm0SKDlIieS/I3gaDxR72?=
 =?us-ascii?Q?b6QXt5BtJhb66IwpEuW4JLG2mOR6XgtQdIT55M8tdp65qTpLK0sfFuL27ls2?=
 =?us-ascii?Q?UaU4S4ZppIT5gqtCJ4KXi/PxTU1Qqx8tkFFS/DlUJjrJTgYrtzxdvWjKSCsg?=
 =?us-ascii?Q?zfNVgl+gU9YPJglq2mw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf238bd-aee8-4794-03eb-08dda355f1a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 10:52:47.8249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZidJSJG0tXO4tMNGBvO/BFPAGDtLZqNuHf0zQFc31SsX9aQ7SlzR6fX57IKEXZX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9073

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Andrew,

>-----Original Message-----
>From: Andrew Lunn <andrew@lunn.ch>
>Sent: Tuesday, June 3, 2025 9:27 PM
>To: Joseph, Abin <Abin.Joseph@amd.com>
>Cc: nicolas.ferre@microchip.com; claudiu.beznea@tuxon.dev;
>andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
>kuba@kernel.org; pabeni@redhat.com; git (AMD-Xilinx) <git@amd.com>;
>netdev@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH net-next] net: macb: Add shutdown operation support
>
>Caution: This message originated from an External Source. Use proper cauti=
on when
>opening attachments, clicking links, or responding.
>
>
>> +static void macb_shutdown(struct platform_device *pdev) {
>> +     struct net_device *netdev =3D dev_get_drvdata(&pdev->dev);
>> +
>> +     netif_device_detach(netdev);
>> +     dev_close(netdev);
>> +}
>
>Have you tried this on a device which was admin down? It seems like you ge=
t
>unbalanced open()/close() calls.
>

Yes, I tested this on a device which was admin down using "ifconfig eth0 do=
wn". I observed that macb_close() is invoked only once,
specifically when the interface is bought down. During the kexec call the s=
hutdown hook is triggered, but the close() won't be called
In this scenario.

Regards,
Abin Joseph

>    Andrew

