Return-Path: <netdev+bounces-160132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59634A1879E
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 23:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF42D188A8AB
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 22:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3741F8931;
	Tue, 21 Jan 2025 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="emcNefhv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEAB1F8ADD
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737497706; cv=fail; b=DCGPIfZr9wd9A8dEPGp6I1YWlkT/NdU5Q6aaWkQGNSQyWeR4Cprb4OQu54EWuZXUNvmEaj//Bt9ApNHk/0wKwdB5/s/UVl+OT0EkMVk73meLDmahV8BqMiCpQtmqc5RSNQ9UkmFbBI5WPKQN+jpabP4WjXkpNh2XqnsKmuL7svs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737497706; c=relaxed/simple;
	bh=P4w/MEGuqiYAM/v+R1uvzF9XXuOJfUN0sHyCiqs8i9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dH4a3grJ3Hco5rlU4b+SrG9MJ75LzoK2suqcg45D7mQfXjGXL2PI7HpdlnPC7NtX4cs7Y0Bxi/Yw4aGxYw5dDsDiARonhasMA5zIaLsK6xdcQwNULxzcP7YvRg3+/YdGLfX0M35I9TikXKUjkiS//TLW97MQypRybKC54QqsUlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=emcNefhv; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfmWp+J2PyJTtfThBC9XKPyJiXZkBqm3rsGLB3LPERuDXRGMxz1SUVnIcTwCuD3Jdq4jWRPf1PCV4Rn+lxlC0PY/OwNUsaJ5Irm4CWLaoHcn1RkuqutKejk0CIaYgmDTm3DNnmI327ibFIPitEixtZF2DmnDZuP4BC9WT8k71XwcWSv4fgOwG4C+2nNhmpFs8B8biIyk6hVBqu9UVlRre9u4hgSJ3matfME1jBCt6b/54FvQXAnoybVhfPDz94ZQzzyCRAnDraGK4ky+qnUXRV7eAjCDFdyoUAcGH7LMeyewUrum0P7lOHNQa30IqvyG3RCXaccJMGxtTuXQduaSkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTJed2YHJxn17rf08p1TcyiZ/1ZNqEwNKZzZRmZ37Rw=;
 b=T9vRAUwTvRWLxmgCI5rolC0jBznRr0adHjczYAHLuAVLESCddcavL2f6YAiP/jRSJATvhAcYBIzU5qbDNH7zsuo/DV05j/acFEC6eJWlQv2RIVasj0G1dKvUwbmocPUuqQjTBEXIgeisbMqccG9jFemsHLaoAOVoV0YzZVMl4e45gtjIudeZuTeQmJ41UKlVgTqDkM8w5LGaAolOW46K7b9fNfVTT6b9sEGMKFUHmVDDmIcNnp9notIRGF69k86xuvtYZRHmxuyEG26CWJjmhzY3lmIndTmRAvRuIp2b0eeC8T36m52cyZZttBKlQURiwXGD2cPtI4CYWpvSULTj+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTJed2YHJxn17rf08p1TcyiZ/1ZNqEwNKZzZRmZ37Rw=;
 b=emcNefhvSqiXT+Rn6++hmuC2HHfR2CBW4AJ2/P8Zk6Wdu1lbTKIcowHEi9Urvym+CpZOfWmTGHftpErVZzRyW+jeGlhjKtsY+FO0B60PZp3F8Cq28YXmqW6wGvTmW2U0I8ZCKMrc0dFETUrYQ2T+H0f8UP3zdhJB9fd/XJMmE+U=
Received: from BN5PR12MB9486.namprd12.prod.outlook.com (2603:10b6:408:2ac::15)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 22:15:01 +0000
Received: from BN5PR12MB9486.namprd12.prod.outlook.com
 ([fe80::47b7:8302:88e1:da6e]) by BN5PR12MB9486.namprd12.prod.outlook.com
 ([fe80::47b7:8302:88e1:da6e%4]) with mapi id 15.20.8377.009; Tue, 21 Jan 2025
 22:15:01 +0000
From: "Panicker, Manoj" <Manoj.Panicker2@amd.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Michael Chan
	<michael.chan@broadcom.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "pavan.chebbi@broadcom.com"
	<pavan.chebbi@broadcom.com>, "andrew.gospodarek@broadcom.com"
	<andrew.gospodarek@broadcom.com>, "helgaas@kernel.org" <helgaas@kernel.org>,
	Somnath Kotur <somnath.kotur@broadcom.com>, "Huang2, Wei"
	<Wei.Huang2@amd.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: RE: [PATCH net-next v2 10/10] bnxt_en: Add TPH support in BNXT driver
Thread-Topic: [PATCH net-next v2 10/10] bnxt_en: Add TPH support in BNXT
 driver
Thread-Index: AQHbaExVpONcG9K/okuZeFZM6MJnmLMai3OAgAdFPbA=
Date: Tue, 21 Jan 2025 22:15:01 +0000
Message-ID:
 <BN5PR12MB9486BC66168772767F4D8BAAAFE62@BN5PR12MB9486.namprd12.prod.outlook.com>
References: <20250116192343.34535-1-michael.chan@broadcom.com>
 <20250116192343.34535-11-michael.chan@broadcom.com>
 <Z4oA8U3opS/7Ike0@mev-dev.igk.intel.com>
In-Reply-To: <Z4oA8U3opS/7Ike0@mev-dev.igk.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ActionId=c858e366-b1c9-44de-ad25-82a6fdb5543e;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ContentBits=0;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Enabled=true;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Method=Privileged;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Name=Third
 Party_New;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SetDate=2025-01-21T22:12:01Z;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN5PR12MB9486:EE_|DS0PR12MB8788:EE_
x-ms-office365-filtering-correlation-id: dd741cbb-728a-41f4-529e-08dd3a690c69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6rrTPq1UtMUcYWCb9Kd5WNMR/DOH4cISebfIGCtMbNk0cOnMHI5O/R95IowX?=
 =?us-ascii?Q?iY3fi5YdYUh/6I66IJVwUn/SNfsDjTbJQo0yB0FMFNaaqw3oZkkXjo2ioVu/?=
 =?us-ascii?Q?NV5EwTWqLSlL43CvmINUoFdppDLz4CVB7o9XymOUuremmtzzCTZK/ONjf1eu?=
 =?us-ascii?Q?n9xFkRtz/KqCnK+cidARiAevWpaCKSomoXsrnVeoquJjRQByivmV8CsfUGhR?=
 =?us-ascii?Q?WrmRiBAvkRPJVxas2+ZnD2B6p0aNiRm73NmMVAhQozXqUU4wD1GMOGtgJUTN?=
 =?us-ascii?Q?DXjpt+m+o2vNB/o4JJ+vB16OogUccl6OOthYmFGyw8IlCgTzKxrsacPLV5qn?=
 =?us-ascii?Q?yHLuevhTqGkb4L/sSS8zgmd1ENSoxWiSDHfxqI29cmzhLDYVmYXub8GXi/rm?=
 =?us-ascii?Q?kH96RK37/RBAbymnD6NjcPFHducfjAcVoujrhNyM4gYrF3IWmaWj2K80oKj3?=
 =?us-ascii?Q?1qhyBIGsLFlIIjvbHCHuCjCVHY7Czj5HLgdT1pVJ/229wi32NHbxnGdFRgcT?=
 =?us-ascii?Q?5T8he9qz2URl2CqbSZ57kRtxsixgjphOqxye6rKYfXDOOKVogmHGZi5bKWvS?=
 =?us-ascii?Q?LsxFDXcy6VnRHtKpi+/9bopePrVv+/244HcmGun1/mMdxw09EnBAOrJ++EHP?=
 =?us-ascii?Q?t93DroC4+1rgHvH/2uZypNLn5a1mVyNQ/dR8NkpYFlNk5ZnGllAAA+X6ZSpd?=
 =?us-ascii?Q?fR32qglk4bFgayf836YfzPPDjQbR7bdxSAjCAVy9wJkP7XeSiHDe18wnLkEg?=
 =?us-ascii?Q?WSDu4GB4YYRpgMjGmCewCWG8l8p/czM+Psrnb6m/JwMBRgQHa8zmNsJjXCb6?=
 =?us-ascii?Q?asKFimg2AgANjqlFmBkH6ZDi5hTO+0Ui9Tl6B3LhU3SIDnVpkCbFtg1TzSU9?=
 =?us-ascii?Q?Yf/MFjPxw3b7PNU0cL8GECgRcMKZ9K93X2Y1758unFA9V9kr9livOsLn+OuG?=
 =?us-ascii?Q?Aby2IikEl/8qzFAM6P+6Ip4CM85PBapsFTdJp8t7Gls/HvG3zxGl9MLHtHTg?=
 =?us-ascii?Q?cB0Y7mm/A/pTmO6sHNLJSwHzGmkV2cPV6tqFrFPiULdYFn6DbPGQfFSqSx47?=
 =?us-ascii?Q?aorHB2OR0Wd+PfQLw5XnXipOxSSZz+CwyKXDw/iIpFoheyTe9ikBy8D5qpLQ?=
 =?us-ascii?Q?KGPyUoZ2FZBgtnLh50x2cnXThlGpKOr3MnqZNRZjBsv/S19GlGbeM+ty1jYa?=
 =?us-ascii?Q?HY1ncUsutNcIcKC0wQ7xLcUqmgzajOEOE+6HhlKuOitPJAZSTdS3+luqhA0O?=
 =?us-ascii?Q?V2HU8VWpuWNuSm5n+hoRViviWyoGWnW+b0XgfVbpWdcsmI9YT1u3TGgN2oA8?=
 =?us-ascii?Q?OcCG0IYok9BnrgL/O41a3Ab4IlUAUN0evasVJi34jVrUqjfYuE5vbbdcznEJ?=
 =?us-ascii?Q?rH38yovyIMV94etE18dWLcC6odMw6ksB1lfE0zSViJBwEK8/6A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0DLwUiBD8kA2oYF4VHq5ZdrkeI1cXeXblHuXUxwX3ICfNQzrCujwyEbohKaN?=
 =?us-ascii?Q?xeQcbmTLxbzQylC8bTjfS6xaLfc5z6ZQMSAhFkHJUHate5XibfxTQz9tiR+w?=
 =?us-ascii?Q?2vhF6HGK/J0H4JV4Ud3lQqI6DU8L/3eK/xg4qCfjHKuqtD0PsxzBQVle54zB?=
 =?us-ascii?Q?8l4sDfJiicBrJi+G1rQl/l44rFXs1mktxev28OLxoqnu1f3Wov8EETpqRCEy?=
 =?us-ascii?Q?kjL9f/b9nw76Qqd69aBItLUIsF/IwE1QFsae59R1dDTFd/5nyLD1fYs/HKPD?=
 =?us-ascii?Q?aKF/k8VVCtG7jtGWqt5RSGK2/3RoStul9LDzU+TsZ7IJT1Zpdjts1yfGaeK9?=
 =?us-ascii?Q?BfI6T4cPSEZRzX1xyGg9zRuqRkngaMZd2Yi8oHON/kN8jDm3sOrTW1bizvjw?=
 =?us-ascii?Q?S67/Gkja7xSFcKBQT0HGH8OaWm22kNO1DGVM0t6dcOhSdWKD7SWw7uqsSP6x?=
 =?us-ascii?Q?2oJbprj+jnO7s8+aoor3Ek3+nTOiyrHigQWaN8zrZqdpM0HAWQg4baR2H4pN?=
 =?us-ascii?Q?5ubfBBCUDNXb9saibQ8RydNfbS6hL0zNiQRgRdx0ym6yU8ea/4jI7i6lDH1o?=
 =?us-ascii?Q?BMfys6/2IzJ3mZM35FXaI6+kv5yZNyld2l9kY8rL6WOMbW6I+Es5x22x/idC?=
 =?us-ascii?Q?7JPJJtoZh4mNQtfTTXmYTR26tm7jDn0gEnoUQn3BBHEwFumKiune8UqKNde0?=
 =?us-ascii?Q?vzORONPYHF8CF+/5yya9JFM0QkIiY0LyWVuqjnReJXzBNXwoCnST+nRSqz4B?=
 =?us-ascii?Q?3WJgyj4oMNfsKeGKtsYK1jGIlYVqvyJdRpjoP2A/Xr5UiBInIhSInnzto0ZM?=
 =?us-ascii?Q?jNnIvANX8DmBqr/7q6pEIPePEI7LACNEYv6q+RhvCCF8sk6Gm1TQ7kdbL1ao?=
 =?us-ascii?Q?jjgAD4GZMm9rtN8gfiRzzQ32v2DofQQrsLmpKC3Msn/S6ZnAKAaPwx2runQA?=
 =?us-ascii?Q?VhbcSaxVEaaOY4lT2fRyY3MxXbw2lf15P5Bwx0u+dUzz1A4BsdaXxqSNX3he?=
 =?us-ascii?Q?3aL0q5hDCSqGYc3DtFUnNWgpKTNljJBqAsal0TC/11zTk+DzOKYg8FojDfZX?=
 =?us-ascii?Q?9/dxXkpshe7KhHUlgeP/MwEA6HLVaEgmMQecBVi08CnYuB+O+r/h3H4VVRCZ?=
 =?us-ascii?Q?LNEumLs1vLB5TuP2M9MT1C2xB6NxJUdTSrUZAwslUXJoO2TgH5rlKFATVE+t?=
 =?us-ascii?Q?qx7qgHqEMP2sEUmdJm4et3DKlz3qpHJ6wKpiafMczkdWDBJHmgxzmMxHc6l3?=
 =?us-ascii?Q?+Q/1V8kNCbr6Yn6g/vlDSHoOB5Jd/iulqKSNT+DMKCqJIP07CTTi5lgnRyYU?=
 =?us-ascii?Q?uTss/2GYA/idlYSasE/HbsFAlbU0XF5oHA3faeblr/6XlMP2hphj4znxaIjG?=
 =?us-ascii?Q?C2BkVBV6VlHGYegDhyKZsXmVGBC6mH/IvBqCSB/BbrfS/jys9gmBcW8fMDTT?=
 =?us-ascii?Q?Bo/Gup1s5W31HUQ73p3XXLn/omJHbfG+rShK3U/xX0W9VwYcRSDx7vCOSf8+?=
 =?us-ascii?Q?wjqdCV6I6xuXdzGB/z+1o3tOtBVkxWiibAa7ONU3ul8cuJQ3w0zaf1jX0+/G?=
 =?us-ascii?Q?CeNRnOqn5D9YFBvAqOQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd741cbb-728a-41f4-529e-08dd3a690c69
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 22:15:01.0556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AG0VPFxY34NtBNoywzED0+YiVDdPITH0SIqadmsh59kxvM0uzxSVs/eer1/hp4CEksC7BEvAZXDQMFsdYw3ncg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788

Hello Michal,

The driver changes currently attempt to enable TPH only for the Interrupt V=
ector Mode operation when interrupts are being enabled. The check you point=
ed out should fall through to the rest of the notifier code since the notif=
ier is registered only when the tph_mode is set currently. I believe the ch=
eck was added in anticipation of further changes in TPH support like NoST m=
ode, for example, but that is not part of this submission.

Thanks
Manoj


-----Original Message-----
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>=20
Sent: Thursday, January 16, 2025 11:04 PM
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net; netdev@vger.kernel.org; edumazet@google.com; kuba@=
kernel.org; pabeni@redhat.com; andrew+netdev@lunn.ch; pavan.chebbi@broadcom=
.com; andrew.gospodarek@broadcom.com; helgaas@kernel.org; Panicker, Manoj <=
Manoj.Panicker2@amd.com>; Somnath Kotur <somnath.kotur@broadcom.com>; Huang=
2, Wei <Wei.Huang2@amd.com>; Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next v2 10/10] bnxt_en: Add TPH support in BNXT dri=
ver

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


On Thu, Jan 16, 2025 at 11:23:43AM -0800, Michael Chan wrote:
> From: Manoj Panicker <manoj.panicker2@amd.com>
>
> Add TPH support to the Broadcom BNXT device driver. This allows the=20
> driver to utilize TPH functions for retrieving and configuring=20
> Steering Tags when changing interrupt affinity. With compatible NIC=20
> firmware, network traffic will be tagged correctly with Steering Tags,=20
> resulting in significant memory bandwidth savings and other advantages=20
> as demonstrated by real network benchmarks on TPH-capable platforms.
>
> Co-developed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Manoj Panicker <manoj.panicker2@amd.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
> Cc: Bjorn Helgaas <helgaas@kernel.org>
>
> Previous driver series fixing rtnl_lock and empty release function:
>
> https://lore.kernel.org/netdev/20241115200412.1340286-1-wei.huang2@amd
> .com/
>
> v5 of the PCI series using netdev_rx_queue_restart():
>
> https://lore.kernel.org/netdev/20240916205103.3882081-5-wei.huang2@amd
> .com/
>
> v1 of the PCI series using open/close:
>
> https://lore.kernel.org/netdev/20240509162741.1937586-9-wei.huang2@amd
> .com/
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 105 ++++++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h |   7 ++
>  2 files changed, 112 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c=20
> b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 0a10a4cffcc8..8c24642b8812 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -55,6 +55,8 @@
>  #include <net/page_pool/helpers.h>
>  #include <linux/align.h>
>  #include <net/netdev_queues.h>
> +#include <net/netdev_rx_queue.h>
> +#include <linux/pci-tph.h>
>
>  #include "bnxt_hsi.h"
>  #include "bnxt.h"
> @@ -11330,6 +11332,83 @@ static int bnxt_tx_queue_start(struct bnxt *bp, =
int idx)
>       return 0;
>  }
>
> +static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
> +                                  const cpumask_t *mask) {
> +     struct bnxt_irq *irq;
> +     u16 tag;
> +     int err;
> +
> +     irq =3D container_of(notify, struct bnxt_irq, affinity_notify);
> +
> +     if (!irq->bp->tph_mode)
> +             return;
> +
Can it not be set? The notifier is registered only if it is set, can mode c=
hange while irq notifier is registered? Maybe I am missing sth, but it look=
s like it can't.

> +     cpumask_copy(irq->cpu_mask, mask);
> +
> +     if (irq->ring_nr >=3D irq->bp->rx_nr_rings)
> +             return;
> +
> +     if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
> +                             cpumask_first(irq->cpu_mask), &tag))
> +             return;
> +
> +     if (pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag))
> +             return;
> +
> +     rtnl_lock();
> +     if (netif_running(irq->bp->dev)) {
> +             err =3D netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr)=
;
> +             if (err)
> +                     netdev_err(irq->bp->dev,
> +                                "RX queue restart failed: err=3D%d\n", e=
rr);
> +     }
> +     rtnl_unlock();
> +}
> +
> +static void bnxt_irq_affinity_release(struct kref *ref) {
> +     struct irq_affinity_notify *notify =3D
> +             container_of(ref, struct irq_affinity_notify, kref);
> +     struct bnxt_irq *irq;
> +
> +     irq =3D container_of(notify, struct bnxt_irq, affinity_notify);
> +
> +     if (!irq->bp->tph_mode)
The same here.

> +             return;
> +
> +     if (pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, 0)) {
> +             netdev_err(irq->bp->dev,
> +                        "Setting ST=3D0 for MSIX entry %d failed\n",
> +                        irq->msix_nr);
> +             return;
> +     }
> +}
> +
> +static void bnxt_release_irq_notifier(struct bnxt_irq *irq) {
> +     irq_set_affinity_notifier(irq->vector, NULL); }
> +
> +static void bnxt_register_irq_notifier(struct bnxt *bp, struct=20
> +bnxt_irq *irq) {
> +     struct irq_affinity_notify *notify;
> +
> +     irq->bp =3D bp;
> +
> +     /* Nothing to do if TPH is not enabled */
> +     if (!bp->tph_mode)
> +             return;
> +
> +     /* Register IRQ affinity notifier */
> +     notify =3D &irq->affinity_notify;
> +     notify->irq =3D irq->vector;
> +     notify->notify =3D bnxt_irq_affinity_notify;
> +     notify->release =3D bnxt_irq_affinity_release;
> +
> +     irq_set_affinity_notifier(irq->vector, notify); }
> +
>  static void bnxt_free_irq(struct bnxt *bp)  {
>       struct bnxt_irq *irq;
> @@ -11352,11 +11431,18 @@ static void bnxt_free_irq(struct bnxt *bp)
>                               free_cpumask_var(irq->cpu_mask);
>                               irq->have_cpumask =3D 0;
>                       }
> +
> +                     bnxt_release_irq_notifier(irq);
> +
>                       free_irq(irq->vector, bp->bnapi[i]);
>               }
>
>               irq->requested =3D 0;
>       }
> +
> +     /* Disable TPH support */
> +     pcie_disable_tph(bp->pdev);
> +     bp->tph_mode =3D 0;
>  }
>
>  static int bnxt_request_irq(struct bnxt *bp) @@ -11376,6 +11462,12 @@=20
> static int bnxt_request_irq(struct bnxt *bp)  #ifdef CONFIG_RFS_ACCEL
>       rmap =3D bp->dev->rx_cpu_rmap;
>  #endif
> +
> +     /* Enable TPH support as part of IRQ request */
> +     rc =3D pcie_enable_tph(bp->pdev, PCI_TPH_ST_IV_MODE);
> +     if (!rc)
> +             bp->tph_mode =3D PCI_TPH_ST_IV_MODE;
> +
>       for (i =3D 0, j =3D 0; i < bp->cp_nr_rings; i++) {
>               int map_idx =3D bnxt_cp_num_to_irq_num(bp, i);
>               struct bnxt_irq *irq =3D &bp->irq_tbl[map_idx]; @@=20
> -11399,8 +11491,11 @@ static int bnxt_request_irq(struct bnxt *bp)
>
>               if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
>                       int numa_node =3D dev_to_node(&bp->pdev->dev);
> +                     u16 tag;
>
>                       irq->have_cpumask =3D 1;
> +                     irq->msix_nr =3D map_idx;
> +                     irq->ring_nr =3D i;
>                       cpumask_set_cpu(cpumask_local_spread(i, numa_node),
>                                       irq->cpu_mask);
>                       rc =3D irq_update_affinity_hint(irq->vector,=20
> irq->cpu_mask); @@ -11410,6 +11505,16 @@ static int bnxt_request_irq(stru=
ct bnxt *bp)
>                                           irq->vector);
>                               break;
>                       }
> +
> +                     bnxt_register_irq_notifier(bp, irq);
> +
> +                     /* Init ST table entry */
> +                     if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE=
_VM,
> +                                             cpumask_first(irq->cpu_mask=
),
> +                                             &tag))
> +                             continue;
> +
> +                     pcie_tph_set_st_entry(irq->bp->pdev,=20
> + irq->msix_nr, tag);
>               }
>       }
>       return rc;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h=20
> b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 826ae030fc09..02dc2ed9c75d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -1234,6 +1234,11 @@ struct bnxt_irq {
>       u8              have_cpumask:1;
>       char            name[IFNAMSIZ + BNXT_IRQ_NAME_EXTRA];
>       cpumask_var_t   cpu_mask;
> +
> +     struct bnxt     *bp;
> +     int             msix_nr;
> +     int             ring_nr;
> +     struct irq_affinity_notify affinity_notify;
>  };
>
>  #define HWRM_RING_ALLOC_TX   0x1
> @@ -2229,6 +2234,8 @@ struct bnxt {
>       struct net_device       *dev;
>       struct pci_dev          *pdev;
>
> +     u8                      tph_mode;
> +
>       atomic_t                intr_sem;
>
>       u32                     flags;
> --
> 2.30.1
>

