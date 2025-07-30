Return-Path: <netdev+bounces-210938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D73B15B7F
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 11:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E833B6E9C
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 09:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4174B270EB2;
	Wed, 30 Jul 2025 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fs21ByA/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B3526CE18;
	Wed, 30 Jul 2025 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867638; cv=fail; b=MqEBToaPwW1M0H4bi6LjWjHZXBiEv4m7UZHgpORXFwFhSGhi8Uud76WJOEx19TpCVzPeLwEaftJ5jSKVAjLgeVKoxzmvV7tuYsOjl+lMZh7yZSD+D03hzYIpxj4yTejNlFocUIUjnnlLc0xMa/L3W5t+Ki40snsLSqjIxW4a9s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867638; c=relaxed/simple;
	bh=qdDjr3ebUFG3u0dy23qySn4yD9B5/Q7gZKPydMj31CU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SY8TkUhJYuLyvIKvd3rSHrSFGA2rgyDnS/2noAiFSHNWSHev9G2nzxLd4AzgvxEnecQQ0JM+B5Qk0lexDjeQlgOBPq++22I4Y8eqnKvETOKIPVQKdXjaj+4IULVSloOQX4rUJiIbBL1XNuLa6GdFTHyCnwWMSJyP8IV1myr7wVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fs21ByA/; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvXhuKWvsjupkJ3KNL6rWyDZsYmWAUb3X6+YguH0SBDvQoamyhCIA0xv3Y4s/aJvMd65jpNHw4pbnilDpFpnrt8ykwhl9iGvOa7+Iq+N+KWQ0atnU8wmsXOV2H9Yz43+xu+28alAHrnlMdWCqHspuu5Q5CIM9YG7BHJQ1ZHFpbgYOvzlbpNevsVSDYVrZgYUOUv+MERH6bv9S6/Q0DiX1wLsOzHDZ0g+qHVXqYhlQ566scIVo79Y8g0Wq+6B5jufqTz/UWwhZffI6yl4DX+WkcfFx5lJISeNRJdjSqYOFWTXkcfztd9qSc5xm0g71uwDzP/ij4iEQWfTl/jIL31/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjfPLPiDQCLhvHjuNyUYq+LEWbBo6+RInD/DT+xMXEk=;
 b=np+RzhlsdtTEWwBOnYtspT4scKW4YUX5DulgYN0It6nEPYgW7QpZUBPvlQI/OsuyAbUwCnjOqn2A2zfbyDbQK/ChPd2xhCn4q5Osa9/bKQc5V3j1ejqGHEDPYaqs0RQeNm6/sFCFOwuOamBi5v5KGD3Tf1OVJlzmWWttbfKpFe7mk5t3glWfAMNx/xRwDNh95H1orBZgSATb+1wQ6CHROp52ZaraJ9lSQn+hJwMPBtR8qNwi68TzPuKmmTAGbcPz1rkNjY/leUdn5Kd4YtFEUg4JSNmnfORoUhDRVr6CabGxUc+/pGfsYCbcwFsFYUk3cj9I3/JgSRYSF6Jof0QMaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjfPLPiDQCLhvHjuNyUYq+LEWbBo6+RInD/DT+xMXEk=;
 b=Fs21ByA/T3FDGY8R3FRUzQfJIgab6KMG+4hXKi9sUinW7TsEe1/Pzm2/xaTPTpBno0EdUgiQARnQgZLfTZUToj+HcVNM0hkERSPYu0UsWtU3Ad90X1dkrjsjjzOKN6muXASMxfrXu3kZnKV8p2JuHOgJ6feTm8X4jIiC3+tmIbI=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 09:27:11 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%5]) with mapi id 15.20.8964.024; Wed, 30 Jul 2025
 09:27:10 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, "Pandey, Radhey Shyam"
	<radhey.shyam.pandey@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Simek, Michal"
	<michal.simek@amd.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Leon Romanovsky <leon@kernel.org>
Subject: RE: [PATCH net-next v3 1/7] net: axienet: Fix resource release
 ordering
Thread-Topic: [PATCH net-next v3 1/7] net: axienet: Fix resource release
 ordering
Thread-Index: AQHcAA2a70rKnYMeAkmDnHlC3LpJqrRKZ6gA
Date: Wed, 30 Jul 2025 09:27:10 +0000
Message-ID:
 <BL3PR12MB65714EDC41F1FB4CB39FE96EC924A@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250728221823.11968-1-sean.anderson@linux.dev>
 <20250728221823.11968-2-sean.anderson@linux.dev>
In-Reply-To: <20250728221823.11968-2-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-30T09:25:42.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|IA0PR12MB7554:EE_
x-ms-office365-filtering-correlation-id: 76abef0d-1771-48e2-c504-08ddcf4b42f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OUJ3CH/s8XhNAsRX/u868ClJQWW5tOUfxdC7uC8eepIvJ6YGciJrZ3N2eI6A?=
 =?us-ascii?Q?sEliF+xa95TW01kQDeuSfvhs4L+Jh0Ym6htl31C1NStgyI6qKI4iAXbUr2lr?=
 =?us-ascii?Q?PY1qepcLvZW7ccIas+lsKJT6xE4yiza3wophqc6xh0q8+SAfk/J2+f1z8DKR?=
 =?us-ascii?Q?L5conJDao6nWExSR+zofnBpKhhm0ThIPsydPUDoDHnaG4VSBbgD1uXWWIMMN?=
 =?us-ascii?Q?KnRikHj8jMlOWVZOHIkFMDZzpCgdCeCTgYrlxi1/ChqfzTR+p9N1KyeRqNzU?=
 =?us-ascii?Q?9Y4LnutCBGj0ibK5vqUpT5VQdj1DLxWMv8sOBHGhI7x/RNbL0MdCEblYhOgv?=
 =?us-ascii?Q?hm3SrjSrxqigoqu1dISxTKt52DyNou/64A8m1ipqI11DnXRj9JN8GXejGaco?=
 =?us-ascii?Q?RCSMKkRwPLTOI/pVuB9Zfr7GX6vsVpqzABz95AWZozqoQ5nY8fyNgyeNcBBb?=
 =?us-ascii?Q?W532xIBa/EejvwAWOtY/czbWUcWTy8dDL8EKrpyjf7KHYXAl1eZGDzf18HXk?=
 =?us-ascii?Q?AVwEbHtX9xlLCdwr5wiR41WntSB+/niVNpyAB8zBXvJqu9bzYJB1EAUBdfOi?=
 =?us-ascii?Q?gmsdyShEYgJqO5dBxXNOhzPq+kqjIPaXma9xecnd9M9E0opMlsU/vmkBs0GL?=
 =?us-ascii?Q?5U6dSEj7MJHdUkJs9h03ffXliERNzAFnWroujWIDW6WaKEx17iwtQJ/lYbuq?=
 =?us-ascii?Q?OrS2fmw4E3x0zqU7XRRqeXMHeFgzRpq+ivTlRTrRLQzLKcmsRc67Vy450jTu?=
 =?us-ascii?Q?h8w3mqVLGtNgneFafzomApb840/r7qObKoic6dDyhEooSDTacmVXMFNjCWn5?=
 =?us-ascii?Q?HrMbKOnZAQsb19KY7x4GltKozmaiCBdd2Z5x3M/aOhTg4xY+X2vyYAzQAcSM?=
 =?us-ascii?Q?bj6mbZj33yi93gduPKzGr8KqrTKmt+JH1lnK+2mTx6Hdvh/1IaYV+on/SdcR?=
 =?us-ascii?Q?zMblFdbEPFxADaV4JyjHcLHO2DRuWYg4M2MHwGnfxD7qT3Ne7bedZARwXMMP?=
 =?us-ascii?Q?8mpeLOkQuNHaAuXMofHRe+j5nEh0G5tQLPYOJP0QR4a10/nSFR6RYwBzKKdX?=
 =?us-ascii?Q?0TWvVqdwkHb3sDyPekBgoeXkYTZPZEyescbFuSbAxuV9Pd2Lujuuh2AXZgpo?=
 =?us-ascii?Q?W8yyb8g3vmdQWzZLZcTjkobix5ovaqXQE7y4PuZrFWBtk17zWoLv96jHQ95S?=
 =?us-ascii?Q?dX769P3GIFp+Mg+jVPxUkpnFYaXw61GJsg5swwmitB6fZLmMBRDnkLeXatdd?=
 =?us-ascii?Q?IApM4AXtq94H0oOkPlq1RlbN0Dl/TQquVhgOxRjBhKkNaEjpCYYQ/Caxb2tT?=
 =?us-ascii?Q?WXdZLhQzz+8FKkoMEWekpbMUQHxacYCIDV0WQ5wiLYwEPMy+GDnot0a2+4Pl?=
 =?us-ascii?Q?X5LjaDN9zEEO4g5z5gcscLH+ma2DKw+K5wDgiJNeTvekBUbChlUQbkY7SNQA?=
 =?us-ascii?Q?zkFqKKlnjS56+IWh/BTc0weO5A2aqJ3i2fbbMB6msVDSgXgjk0YdqDOZGSiZ?=
 =?us-ascii?Q?Xx7AzLAio/Zw8hw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?acTXi5d51nw1TVnw1YOqdMCAuls68TxJ3ueIgQREb/Jrh6XKw9voaa9e10HX?=
 =?us-ascii?Q?g3K81E7u6GP74CWo6OhCyER6nVnO46zHZ9Uc5vIPNKVsl0lIINyzGsl0R37Z?=
 =?us-ascii?Q?72+bqIcLD2V2ipqJwMZnPK9tXqSuddVWWUE396ht1O/JoKS12VlDHMmjzHk1?=
 =?us-ascii?Q?fyEPppfY+tnFFBwVgiE8x56641otRYnt4P9NaD1PhoZgCd2MOsOCMpNkpCmT?=
 =?us-ascii?Q?Ldfip1iLFlUeMzML/hGzoc1tiNj/ov9vm/In0iU8i58k+lmS+2lIwbRJ44jc?=
 =?us-ascii?Q?26kRW1v1tnbbU9E5fwPJbaptuxmgjCrZoxc8IO+34HVmUfXBlP3hr09KsUqt?=
 =?us-ascii?Q?HZBaX+JTXp8QTz37mBrKuHa3WwkonDk/IqbstuDe6+o5KOJjlMjSBhiVVpUx?=
 =?us-ascii?Q?xYN88szVxoDMkuyV5Gkm1AFvSLB4hORZVjxDRpxc2k57nzsKKfJyegBkmHSE?=
 =?us-ascii?Q?jyQkKOkMtpr54ZqPARL5OVpsJJmgaBg9SnblH5p09eh5hRL6OvBlMFNFmhYl?=
 =?us-ascii?Q?8bePeaXr+tmOwNWpnUFAZQccqzUU4iiV6kSbWL+GFlHCTcBcydoARAzJWHkf?=
 =?us-ascii?Q?/PJhcXtz9QnP2TVToLf7xEBVCZVxpJOeL7TEM5P5hf+TBlL7B1pckQjKD/E+?=
 =?us-ascii?Q?vkUtt2jExApgmewLVVEpvQxMnW8sTldWEZzDG+Jj3EuhlcIrpsKR8hP0Z6fn?=
 =?us-ascii?Q?OsvRJkfMuNVgYNXG000qZeHDf2m0RlEP5lqDdA0E+Lt3ZUWfYqbAUub7a08V?=
 =?us-ascii?Q?FnXww66QW1SnYW3UTWN42vM2xcMakZaVgwIJUBusygDIKM6g4Fd4TPUIdJA4?=
 =?us-ascii?Q?4d4StA1wobUFmRcqV8o5fgvSro9KtmPsJ9qfNaIJcNa9brw+jlpDWDLlpQpt?=
 =?us-ascii?Q?+lJGUgrclDCzG5eSoH1ZH99fIaIaB7P65B5XoX/cSMmP2NuLf10EQCG6phO5?=
 =?us-ascii?Q?rmvI68HHT3UEMw568wa1GuO+gXL6Uohj3l8OuZ/RnV2/d6QqhFzx6ltTKvdR?=
 =?us-ascii?Q?rwMB+79sXVip89ZwenvdmRx0FAEgYDoaACdUhyMPA03lHzcae+uZ6vTBkLSy?=
 =?us-ascii?Q?f7ffxO5v3w9b18pz7tVNl1i/PBLgOUeliUbkR32sOziLl32tPFhVUA5Oe/wl?=
 =?us-ascii?Q?sUUdtujmUWtqNaJ6+N1o/YQVYA4IrmR7KqZvRCUrg+v5eW8R3m0s2ASPRvGh?=
 =?us-ascii?Q?yOiDfZC6HDv3TggVGRXtx3AgFAErW31PVl0WKhWbHJL+8MRUBjEJb5aSZbAC?=
 =?us-ascii?Q?+HH91fCn27oKTKPJC0qwWvIHqAvkojRziY6FhveNRAcyapibotuQBgDGdqhh?=
 =?us-ascii?Q?IJtqu5ZfK9bFqklyVE+ujgwgy0cYdrlXs7CXDBjgxQ4115mHGG0JzEOHxNMt?=
 =?us-ascii?Q?tA2XDfeKsMvw21x+sye64PK3XMZ5S2c8d0lwtDRdFA18CxqJ42bXx0SqSIuW?=
 =?us-ascii?Q?1fNQwGhQAhBQmoakiebu6E2lPt1bSbUAV8/TIWtOsO3CLP+6hl813m9IepXC?=
 =?us-ascii?Q?7yeBDOyH+zp+X28/w9eGYge+b6vQzKrRZ4IjoUkIGbu9sBDgHfJTsO3WXpt8?=
 =?us-ascii?Q?9TiP2S1QItMsVCJ6AWs=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76abef0d-1771-48e2-c504-08ddcf4b42f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 09:27:10.9151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0uzE3NfeMfKOqF7JdFFCFmfKE//n2xKJxgYiLlaH1B/uqkhnxWoTdiGtk5beZ5b/9I6m1vC+h7KGOZpZe/KRCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554

[Public]

> -----Original Message-----
> From: Sean Anderson <sean.anderson@linux.dev>
> Sent: Tuesday, July 29, 2025 3:48 AM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric Dum=
azet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Simek, Michal <michal.simek@amd.com>; linux=
-arm-
> kernel@lists.infradead.org; Leon Romanovsky <leon@kernel.org>; Sean Ander=
son
> <sean.anderson@linux.dev>
> Subject: [PATCH net-next v3 1/7] net: axienet: Fix resource release order=
ing
>
> Caution: This message originated from an External Source. Use proper caut=
ion when
> opening attachments, clicking links, or responding.
>
>
> Device-managed resources are released after manually-managed resources.
> Therefore, once any manually-managed resource is acquired, all further re=
sources
> must be manually-managed too.
>
> Convert all resources before the MDIO bus is created into device-managed =
resources.
> In all cases but one there are already devm variants available.
>
> Fixes: 46aa27df8853 ("net: axienet: Use devm_* calls")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>


Looks fine to me.
Reviewed-by: Suraj Gupta <suraj.gupta2@amd.com>

> ---
>
> (no changes since v1)
>
>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 89 ++++++++-----------
>  1 file changed, 37 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 6011d7eae0c7..1f277e5e4a62 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -2744,6 +2744,11 @@ static void axienet_dma_err_handler(struct work_st=
ruct
> *work)
>         axienet_setoptions(ndev, lp->options);  }
>
> +static void axienet_disable_misc(void *clocks) {
> +       clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, clocks); }
> +
>  /**
>   * axienet_probe - Axi Ethernet probe function.
>   * @pdev:      Pointer to platform device structure.
> @@ -2767,7 +2772,7 @@ static int axienet_probe(struct platform_device *pd=
ev)
>         int addr_width =3D 32;
>         u32 value;
>
> -       ndev =3D alloc_etherdev(sizeof(*lp));
> +       ndev =3D devm_alloc_etherdev(&pdev->dev, sizeof(*lp));
>         if (!ndev)
>                 return -ENOMEM;
>
> @@ -2795,22 +2800,17 @@ static int axienet_probe(struct platform_device *=
pdev)
>         seqcount_mutex_init(&lp->hw_stats_seqcount, &lp->stats_lock);
>         INIT_DEFERRABLE_WORK(&lp->stats_work, axienet_refresh_stats);
>
> -       lp->axi_clk =3D devm_clk_get_optional(&pdev->dev, "s_axi_lite_clk=
");
> +       lp->axi_clk =3D devm_clk_get_optional_enabled(&pdev->dev,
> +                                                   "s_axi_lite_clk");
>         if (!lp->axi_clk) {
>                 /* For backward compatibility, if named AXI clock is not =
present,
>                  * treat the first clock specified as the AXI clock.
>                  */
> -               lp->axi_clk =3D devm_clk_get_optional(&pdev->dev, NULL);
> -       }
> -       if (IS_ERR(lp->axi_clk)) {
> -               ret =3D PTR_ERR(lp->axi_clk);
> -               goto free_netdev;
> -       }
> -       ret =3D clk_prepare_enable(lp->axi_clk);
> -       if (ret) {
> -               dev_err(&pdev->dev, "Unable to enable AXI clock: %d\n", r=
et);
> -               goto free_netdev;
> +               lp->axi_clk =3D devm_clk_get_optional_enabled(&pdev->dev,
> + NULL);
>         }
> +       if (IS_ERR(lp->axi_clk))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(lp->axi_clk),
> +                                    "could not get AXI clock\n");
>
>         lp->misc_clks[0].id =3D "axis_clk";
>         lp->misc_clks[1].id =3D "ref_clk"; @@ -2818,18 +2818,23 @@ static=
 int
> axienet_probe(struct platform_device *pdev)
>
>         ret =3D devm_clk_bulk_get_optional(&pdev->dev, XAE_NUM_MISC_CLOCK=
S, lp-
> >misc_clks);
>         if (ret)
> -               goto cleanup_clk;
> +               return dev_err_probe(&pdev->dev, ret,
> +                                    "could not get misc. clocks\n");
>
>         ret =3D clk_bulk_prepare_enable(XAE_NUM_MISC_CLOCKS, lp->misc_clk=
s);
>         if (ret)
> -               goto cleanup_clk;
> +               return dev_err_probe(&pdev->dev, ret,
> +                                    "could not enable misc. clocks\n");
> +
> +       ret =3D devm_add_action_or_reset(&pdev->dev, axienet_disable_misc=
,
> +                                      lp->misc_clks);
> +       if (ret)
> +               return ret;
>
>         /* Map device registers */
>         lp->regs =3D devm_platform_get_and_ioremap_resource(pdev, 0, &eth=
res);
> -       if (IS_ERR(lp->regs)) {
> -               ret =3D PTR_ERR(lp->regs);
> -               goto cleanup_clk;
> -       }
> +       if (IS_ERR(lp->regs))
> +               return PTR_ERR(lp->regs);
>         lp->regs_start =3D ethres->start;
>
>         /* Setup checksum offload, but default to off if not specified */=
 @@ -2898,19
> +2903,17 @@ static int axienet_probe(struct platform_device *pdev)
>                         lp->phy_mode =3D PHY_INTERFACE_MODE_1000BASEX;
>                         break;
>                 default:
> -                       ret =3D -EINVAL;
> -                       goto cleanup_clk;
> +                       return -EINVAL;
>                 }
>         } else {
>                 ret =3D of_get_phy_mode(pdev->dev.of_node, &lp->phy_mode)=
;
>                 if (ret)
> -                       goto cleanup_clk;
> +                       return ret;
>         }
>         if (lp->switch_x_sgmii && lp->phy_mode !=3D PHY_INTERFACE_MODE_SG=
MII
> &&
>             lp->phy_mode !=3D PHY_INTERFACE_MODE_1000BASEX) {
>                 dev_err(&pdev->dev, "xlnx,switch-x-sgmii only supported w=
ith SGMII or
> 1000BaseX\n");
> -               ret =3D -EINVAL;
> -               goto cleanup_clk;
> +               return -EINVAL;
>         }
>
>         if (!of_property_present(pdev->dev.of_node, "dmas")) { @@ -2925,7=
 +2928,7
> @@ static int axienet_probe(struct platform_device *pdev)
>                                 dev_err(&pdev->dev,
>                                         "unable to get DMA resource\n");
>                                 of_node_put(np);
> -                               goto cleanup_clk;
> +                               return ret;
>                         }
>                         lp->dma_regs =3D devm_ioremap_resource(&pdev->dev=
,
>                                                              &dmares); @@=
 -2942,19 +2945,17 @@ static
> int axienet_probe(struct platform_device *pdev)
>                 }
>                 if (IS_ERR(lp->dma_regs)) {
>                         dev_err(&pdev->dev, "could not map DMA regs\n");
> -                       ret =3D PTR_ERR(lp->dma_regs);
> -                       goto cleanup_clk;
> +                       return PTR_ERR(lp->dma_regs);
>                 }
>                 if (lp->rx_irq <=3D 0 || lp->tx_irq <=3D 0) {
>                         dev_err(&pdev->dev, "could not determine irqs\n")=
;
> -                       ret =3D -ENOMEM;
> -                       goto cleanup_clk;
> +                       return -ENOMEM;
>                 }
>
>                 /* Reset core now that clocks are enabled, prior to acces=
sing MDIO */
>                 ret =3D __axienet_device_reset(lp);
>                 if (ret)
> -                       goto cleanup_clk;
> +                       return ret;
>
>                 /* Autodetect the need for 64-bit DMA pointers.
>                  * When the IP is configured for a bus width bigger than =
32 bits, @@ -
> 2981,14 +2982,13 @@ static int axienet_probe(struct platform_device *pdev=
)
>                 }
>                 if (!IS_ENABLED(CONFIG_64BIT) && lp->features &
> XAE_FEATURE_DMA_64BIT) {
>                         dev_err(&pdev->dev, "64-bit addressable DMA is no=
t compatible with
> 32-bit architecture\n");
> -                       ret =3D -EINVAL;
> -                       goto cleanup_clk;
> +                       return -EINVAL;
>                 }
>
>                 ret =3D dma_set_mask_and_coherent(&pdev->dev,
> DMA_BIT_MASK(addr_width));
>                 if (ret) {
>                         dev_err(&pdev->dev, "No suitable DMA available\n"=
);
> -                       goto cleanup_clk;
> +                       return ret;
>                 }
>                 netif_napi_add(ndev, &lp->napi_rx, axienet_rx_poll);
>                 netif_napi_add(ndev, &lp->napi_tx, axienet_tx_poll); @@ -=
2998,15 +2998,12
> @@ static int axienet_probe(struct platform_device *pdev)
>
>                 lp->eth_irq =3D platform_get_irq_optional(pdev, 0);
>                 if (lp->eth_irq < 0 && lp->eth_irq !=3D -ENXIO) {
> -                       ret =3D lp->eth_irq;
> -                       goto cleanup_clk;
> +                       return lp->eth_irq;
>                 }
>                 tx_chan =3D dma_request_chan(lp->dev, "tx_chan0");
> -               if (IS_ERR(tx_chan)) {
> -                       ret =3D PTR_ERR(tx_chan);
> -                       dev_err_probe(lp->dev, ret, "No Ethernet DMA (TX)=
 channel found\n");
> -                       goto cleanup_clk;
> -               }
> +               if (IS_ERR(tx_chan))
> +                       return dev_err_probe(lp->dev, PTR_ERR(tx_chan),
> +                                            "No Ethernet DMA (TX)
> + channel found\n");
>
>                 cfg.reset =3D 1;
>                 /* As name says VDMA but it has support for DMA channel r=
eset */ @@ -
> 3014,7 +3011,7 @@ static int axienet_probe(struct platform_device *pdev)
>                 if (ret < 0) {
>                         dev_err(&pdev->dev, "Reset channel failed\n");
>                         dma_release_channel(tx_chan);
> -                       goto cleanup_clk;
> +                       return ret;
>                 }
>
>                 dma_release_channel(tx_chan); @@ -3119,13 +3116,6 @@ stat=
ic int
> axienet_probe(struct platform_device *pdev)
>                 put_device(&lp->pcs_phy->dev);
>         if (lp->mii_bus)
>                 axienet_mdio_teardown(lp);
> -cleanup_clk:
> -       clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, lp->misc_clks);
> -       clk_disable_unprepare(lp->axi_clk);
> -
> -free_netdev:
> -       free_netdev(ndev);
> -
>         return ret;
>  }
>
> @@ -3143,11 +3133,6 @@ static void axienet_remove(struct platform_device =
*pdev)
>                 put_device(&lp->pcs_phy->dev);
>
>         axienet_mdio_teardown(lp);
> -
> -       clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, lp->misc_clks);
> -       clk_disable_unprepare(lp->axi_clk);
> -
> -       free_netdev(ndev);
>  }
>
>  static void axienet_shutdown(struct platform_device *pdev)
> --
> 2.35.1.1320.gc452695387.dirty
>


