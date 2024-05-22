Return-Path: <netdev+bounces-97483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8568CB965
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 05:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 994D3B21055
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6671E2AE94;
	Wed, 22 May 2024 03:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iPuFRQZQ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411D64C89;
	Wed, 22 May 2024 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716347091; cv=fail; b=hU8PIFDCkYkHtORqgz4gYVl1eU6WJIkbt6+motC/5kfVMU5g2VXYKvJ8jEjpXvyfQ2VljgGmsR3kQPKJUyqyQoIH+gQ9OfCUu9R62wPAuQ6WGrgih14pOK+qNTpsFe+rMp81E4wfmdj9O7rGR2GTM8i1CLuM2C1A/FrITcKzcEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716347091; c=relaxed/simple;
	bh=ffi+TfvNIYqQSVfLC1JYjNML+M++b4J+ttmKF787/gc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NQj+54bukGDjNb5RbwDtu0jKRNrTeOntq84YEUcftUqvzgH4sfpr/KBshJ+KUKEdIYCLTFTRrEh6IFQwPqPwGPk3oL7mjAB1Y6KP0EeSJbrPGJby2uv9CrO6aAEY1Bp3Np2mwKQHp+WZTHX6TaTjCzKXk8ONljjLLr5j8Rs2Eyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iPuFRQZQ; arc=fail smtp.client-ip=40.107.7.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7cUMorv7tjegMUYeaH60STdq3UA9dv0zbH/mLRBHgJh+Bx58OBJtOtifIyrZc1sGzTcRB7/mBB3+qwI5VpcWAHVLhd7OvO112VvZvKAZL1ZNYPejlXi3AXQPvYzFXYeLauRNcndlmQOz07/C8uaUiXTo2iIPRckmy/AUo9lQo6XkTuqMO/yWTuV5cWyq9zobTvfSwZLgPoWVv42Thxy7snbSfIYb/ix1PMu0mp4umqPa1TVwJlzAqboQYMC3A4bwADdlffNxQrQ/qP+X6FPeeDKNl2pzhviTlSKlXK/7lnO++RBJqlhBodLYWcIyLw6UcfsxYUe0LR6XP55mkEWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffi+TfvNIYqQSVfLC1JYjNML+M++b4J+ttmKF787/gc=;
 b=mNUNBfxJycMcu2/AvFXNf8Ui5/kMJX1ZbEhsWAi5G8LjJ3ZHlO8WjYndaMfLBo4hc8sECKljwymowafAbUtufvcpntXlYhzwpMn9nPOSjkgWEMUyPlFkh4GHQTaGnXPZsefXsGboYNvDPpLttlKVGnFYELBGn+lPkyfMJdC1DKfNUR01k33tC8gCmKV7vTybiPCTkdsExyKUTQnqaceOPA9+2k05GChaQSWRSrilhMXG+JI7ToU5pezBU/wPB2I7db7QS/hFauH9UuAgovSwl9kDCXy4jFnHO+CDG+C/FvvtlYyUzAkMwBtsiAwi/31Y7vmbDh8h2LodlcALkXZ2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffi+TfvNIYqQSVfLC1JYjNML+M++b4J+ttmKF787/gc=;
 b=iPuFRQZQbpQv1KjMedBGDd0Z8uIxAPeQDeMX1SXvoVxY9UmNPlNBFF3eTVcCYr1O6Iq15HOYh0G0rHjLXBIXhzM92CoW4ClYsuhZYlg69Y01qcpGWHwI5i7/mXVI29yu/k/Njw2sg7AFxiwEV/I5Mdd19fJBY50QJSlW2bWFEAo=
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DUZPR04MB9784.eurprd04.prod.outlook.com (2603:10a6:10:4e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 03:04:45 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::baed:1f6d:59b4:957]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::baed:1f6d:59b4:957%5]) with mapi id 15.20.7587.028; Wed, 22 May 2024
 03:04:45 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [net PATCH] net: fec: free fec queue when fec_enet_mii_init()
 fails
Thread-Topic: [net PATCH] net: fec: free fec queue when fec_enet_mii_init()
 fails
Thread-Index: AQHaq+22vnaNT3PSDE643JvjIPXkobGiiaOg
Date: Wed, 22 May 2024 03:04:45 +0000
Message-ID:
 <PAXPR04MB8510B1D6C8B77D7E154CC6CF88EB2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240522021317.1113689-1-xiaolei.wang@windriver.com>
In-Reply-To: <20240522021317.1113689-1-xiaolei.wang@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DUZPR04MB9784:EE_
x-ms-office365-filtering-correlation-id: cf2f91d4-7aa0-48fb-a835-08dc7a0bef50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?gb2312?B?dHdYS2NnbWVUNzJ3aGxVWUpwWDBUZnY5MFduaUxoUFF6eVZ0ZUZjTnRFeXZU?=
 =?gb2312?B?cDVyNEdYUG1tRE5MYms1aVR0cTRCUGpTN1V3VzFkdnhSVUZ6YVp6ZzJCakQ1?=
 =?gb2312?B?VHNRaE01QzFhakthWUNsKzBaNFEzblVva3N6bWZsbk5tUFNobnpOc0FSVU1C?=
 =?gb2312?B?WFV1blc3TURSdjhrdmtpWU5QaDFCcDI3UDl1SjVCMmpVNk5qTHJnNEE4eHQ4?=
 =?gb2312?B?WHdmb250ZStHSWlpTTF2ZTJvNGE4TlB4ejJibzJLWlh2MVJRMWMzdmZDTTJ5?=
 =?gb2312?B?RHU3eVdjYXJVb0NPc1lVbmtqb0cxc2hYMkhNeG9FSnVrc3RnRmtwM1ZYdjU0?=
 =?gb2312?B?QUZkSEczOS9tK0xqYVJ5SzRzNzZlR2oxalhUZHdNaEFvaGcrbUlZSVdzb3ov?=
 =?gb2312?B?K1FhUGZhYXlESjFVVjZwSGMxVndaWUNHQXQrb3B1Zy90U2dkR1lYaEVYWlhG?=
 =?gb2312?B?M3RWaVlpYWxBazdhUjBMc00wVm5jWCs3L2Y1RHNCQ3VZUVRMeVFJK1ZTcEYw?=
 =?gb2312?B?SVZSUmZxY1FtVXB1VzlhakNpVWQ5RElGMnIvQ1hZd1VycFdmQTE4dmNPcmlh?=
 =?gb2312?B?cHFCQ3VWSEtuVHM2QlpBTkkwZmp3SkJUR3d0OHpkVGxycUoyWmdjNlk5RFhS?=
 =?gb2312?B?VUt2RlRDT2drNklwYlFnQUY1dHlGcEJuR2thdWNuSnE2ZkRlUkMrWkxocDFL?=
 =?gb2312?B?VUF3VHJ6WC8vZ24vMjBZUm9WOVd0cjdzQzJJaWljODE4SUt6Skp5bmtuSUxY?=
 =?gb2312?B?dWtFSFJVZVVUdng1V1NiRTE3WWtoMkthb0ZvU0tNbjhWdGo3WEZrbkV6L2ZJ?=
 =?gb2312?B?eXU2M1BwQnB0ODBGbFFPQWZXL1BvUStFMU11WTdDbHRUOFA3bTFJODlIVm5m?=
 =?gb2312?B?dmg1Qy9UUkkvbTVWY0RLaHpJdHVGUThGNDhlOFUzdWdpdWsrRVNEdW02QjU1?=
 =?gb2312?B?Vm5LRFFZa1M0U2NGZnl6UmI1Uzkxak15b1FaakpoUFk3OXcrUGw0b2ZGWTdp?=
 =?gb2312?B?Q1BoRXNuV2FFTFB1SzJjeFkreVZ4OXVIVCtMYUtvdENIUmxnSlhKSE9OcGdZ?=
 =?gb2312?B?SGNvL2h0MWdWbkNaRGJpaEsraVNOZndHcVVoWGpBOTFhSE14dVV3YlBsOXVG?=
 =?gb2312?B?ODhGeFhFM1NBdkJ1Z2dmR1MvTkd5aDJWZ3NodVpmRHBTM1NscDVMbWxneGg3?=
 =?gb2312?B?TFlweEludldtc1ZFSlcrUmUzdkFGbG4yMk91dS9VeHNTSGVyeUxmZ0k4cCtl?=
 =?gb2312?B?bkIwaE1IMGZ2RzZFYlFCcE9VcmlrSU9iZVN0d3VOVHBCQ1B5VnVYcWoxL242?=
 =?gb2312?B?aWUxTjZwbyt5dk15Nzl0THFNRko5cWYxRkF5S05pNmRXNzBZMEdMZnlzQUFF?=
 =?gb2312?B?aVBDL2wyTmlUUUkrcGt0eTJFSzFjTlIwb29ORmNVbDBYN2JkRm1FaXpqSC8v?=
 =?gb2312?B?OXZ6VXBFK0U1UlM1bjhVYXdVWFZkQStPK3NYcXozcGVWK3ZYQm1ZK2NnQlN3?=
 =?gb2312?B?VUtoZkxlNStxYkhqN2lJOTRKWnlKcDlQQkhCU0ljU08xN1daaTQvZ0pkdjht?=
 =?gb2312?B?Lyt3aDlqK2l3dFgvVFc4Ymt4SDVYb3lrcVREbFI0MDE1ZGhURURubGF5MzZX?=
 =?gb2312?B?YVRyQ0U3eDN4TEdyT3B2QUdmS1dPZFpLUGNsUjA0RG1vYXViMXJjMGJ0ZVhJ?=
 =?gb2312?B?azVOOEcreUZhSk9Oem1mQlRXcjR4TFA2Qm5MbmoxUVNKNDhETHdGUGxYUVVm?=
 =?gb2312?B?SGE4YktPUzBiL0cxa1N5WFQwS2J0TzQ3azdSa2djM00xWUtqSUhmMW5yWldU?=
 =?gb2312?B?QWNGMXF2RSs0bnVLWU04dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bTFRUU95cmJvSjhCdTREMVpLYjRRbHJkK2paK1pYbGRMMEVmL2FsYWxQVzg0?=
 =?gb2312?B?b0JlZ3pHai93d2ZhRzdISFdaNkNSazd0d2NNVWtyNHhud2EycXNpb0cyNlp5?=
 =?gb2312?B?T0xZeEI3U1hxVUYwZ1dHUWwwb3RJWVBRQnl2TlhmVlM2UmpQTGFpd1RNcVo3?=
 =?gb2312?B?azlSaWZ3c0NKdFMyLzM3LzBSaHk5V2RUdDNodnc1VGRqeGp3ZjBYVE1lbXFO?=
 =?gb2312?B?MWRvOERuMVFZNmRuQURrUUtIZXYxQjgrVjFSa0xFaGJTU1dTY01xY0g5Q2J0?=
 =?gb2312?B?SWlqQ1Nha2s3Z1N6bEFDbjQvU3pXZ3NVUHNEQmZpblVGR0pPeEZCd1JqUWZ1?=
 =?gb2312?B?VHpMOHN1MC81R3dma0R5SktEdkpscDdQdmNQZjVwQ2pSVmtQUUw4WXVrUFVN?=
 =?gb2312?B?M2l0cVdlT0JFNWtWM213Nk5aZG8vam9YNTRodWt6Z2I4bUczaGM0THFqNXgw?=
 =?gb2312?B?VEZLQjBERW9iOVE1cjRocTFsdDBKVmNZODFYSFd4RDE0eVQ5NitPUGpjSEJ4?=
 =?gb2312?B?U2VVY2dQT1lHWGc0WkllNVJ6SUJCRUdISmJiWHpFNUVscmFRM04rSys4eFpt?=
 =?gb2312?B?dlZ1TzFldHFHWXNQRGZ1R0ZUN2lvcmZueHNaNlpZbDBBVHJWQXlmZ3ZSSm5v?=
 =?gb2312?B?RWg5YUhISlJ3bTBGdzJodnBTQlUxZlpCcUY4MlJJL3NJbkJkYTVmY1dqWElJ?=
 =?gb2312?B?NkVjQi83NmJidlg4TndXTExIWFdTUEU0Nkx3YzdWZGM4THNCRFp4dU1hVHZm?=
 =?gb2312?B?UXpWRFhpOG83TU5FMXRpZm9UL2t3UGtDTklkMVF0V0VyZkRGM0loc0gzNUlS?=
 =?gb2312?B?N0ZrVUFaTnNETGs3ZHAwZGJYYlFqMTVkRkFWdGJVQnpuQzd6QWNDclNkUnF6?=
 =?gb2312?B?OEZrMVR6MVk3eTJLZE5SZERGRlJ2cTU1aXJ4S09sVjhnMjJrKy9HOWx1QUhN?=
 =?gb2312?B?d3NDVkVibHg3NXJHbW1MTE1lK1RXODR0T1VUd2hOaS85SlV1dm4wQVorMllo?=
 =?gb2312?B?Y2traUZtZzIwZjVrVHBsUlVFb0tzMnpsQ1JPY1FwdTlxRWNmVzBmbDMydnBG?=
 =?gb2312?B?RE5aSHpKWldHQ3ZnNUw2S0JHaHBZZ0Jneko5T0hiYXNwR1FxYWNoQUxlMHBy?=
 =?gb2312?B?VGpDT1JYUzlpSkdaMnk3S0JOVGFoUVdXZ2lhVGVvaWtxSkZMN1pNMG92Q2pk?=
 =?gb2312?B?VmQva2dRc1JhVElqcDFBQ2JsOGNXS01wejU2SDZsa0xTdU55Tlc4WkYvaVA0?=
 =?gb2312?B?NVNGbjF4TGNlakRnNURNcHRRMko1ZEVzVjhTYTF1eXNiQnY0ZWZZZ3dzS2VX?=
 =?gb2312?B?TkQ2WklPaEx0M2RMTFZrVTVEOVF5dE1vU2NaV21uUWVXbzVxS1hWckdlZXJR?=
 =?gb2312?B?ZEhRK0NmZkVtSWMvdGZwSHY1VUJzY1lmVVVjZTMzbFZsR29nWEF5OCtGRUNt?=
 =?gb2312?B?UVNGMEdxbzdFWmlUVEdZUk1zU1hSVDUza0FvVEpPbm1OUUJKNEhHZW5JTnJU?=
 =?gb2312?B?eit0Ris5MmxlYy9uSEtYKzlwSkhBaGRtOElkbElnQzFhb1ZnaEEwdUxkeExE?=
 =?gb2312?B?QVowdjBvV2NwR2svb2lFRmpDTU9LN0tLUldXOVkvSWlrVW4wZXFOTVZxb1gw?=
 =?gb2312?B?RUpJVVFDbXk4eUFDdVlYK1daYlg0WXVZYXZWMzM5SmJDcnJmWFFBZGxIOXhT?=
 =?gb2312?B?bTFWdVh4U2dLS0VyWE9qRmVJaFY0bHE3TE9DZ1IrWXpaT0ZaUVRGdmlzNm8w?=
 =?gb2312?B?aWFVQnVIRjVpSHF4dDJ5UTVzL1FZZFErcmcwdkMwVElhQmtobm9sYmZKdDE2?=
 =?gb2312?B?RUhOYm5CQnhkd0tqTHBtRzkvS2E1QWdCUVpGMEF4Y09KNTJSTEJWSjVPRlpN?=
 =?gb2312?B?WFlsOWF6R2VRSFdwSVNtb2lZNEt4VGlCRjZGREI5dDZoN0RIR3ZUVVdsdVdt?=
 =?gb2312?B?NjhPRXhSTzdiNmhrY1JhSFUySUUvRzJ2K0dWQnJUbzZRNi84MGxXTzczVGdq?=
 =?gb2312?B?b3hLbnRwMHpYcmZFa3ovQXF1MElldG5IbVR4UFhFQlFUTTBRQXo4YUlhdDNz?=
 =?gb2312?B?YS82Y21mVWZuR3Uva1RqRFBQKzBQSWZLQTVkTzhYOUhqTEtxZGp5WHR2eU5n?=
 =?gb2312?Q?yi4Q=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2f91d4-7aa0-48fb-a835-08dc7a0bef50
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 03:04:45.7567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPHcXhr2JpPYORKdkhQr2HZzcFpQtMJVq7Wxj1Dsk6C5alsFXKO9eIoTkyIMwYY+9uIVJMBiAUFhNq7JmgNOxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9784

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBYaWFvbGVpIFdhbmcgPHhpYW9s
ZWkud2FuZ0B3aW5kcml2ZXIuY29tPg0KPiBTZW50OiAyMDI0xOo11MIyMsjVIDEwOjEzDQo+IFRv
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT47IFNoZW53ZWkgV2FuZw0KPiA8c2hlbndlaS53
YW5nQG54cC5jb20+OyBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+Ow0KPiBkYXZl
bUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+
IHBhYmVuaUByZWRoYXQuY29tDQo+IENjOiBpbXhAbGlzdHMubGludXguZGV2OyBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFtuZXQgUEFUQ0hdIG5ldDogZmVjOiBmcmVlIGZlYyBxdWV1ZSB3aGVuIGZlY19lbmV0X21paV9p
bml0KCkgZmFpbHMNCj4gDQo+IGNvbW1pdCA2M2UzY2MyYjg3YzIgKCJhcm02NDogZHRzOiBpbXg5
My0xMXgxMS1ldms6IGFkZA0KPiByZXNldCBncGlvcyBmb3IgZXRoZXJuZXQgUEhZcyIpIHRoZSBy
ZXNlLWdwaW9zIGF0dHJpYnV0ZQ0Kbml0OiByZXNldC1ncGlvcw0KDQo+IGlzIGFkZGVkLCBidXQg
dGhpcyBwY2FsNjUyNCBpcyBsb2FkZWQgbGF0ZXIsIHdoaWNoIGNhdXNlcw0KPiBmZWMgZHJpdmVy
IGRlZmVyLCB0aGUgZm9sbG93aW5nIG1lbW9yeSBsZWFrIG9jY3Vycy4NCj4gDQo+IHVucmVmZXJl
bmNlZCBvYmplY3QgMHhmZmZmZmY4MDEwMzUwMDAwIChzaXplIDgxOTIpOg0KPiAgIGNvbW0gImt3
b3JrZXIvdTg6MyIsIHBpZCAzOSwgamlmZmllcyA0Mjk0ODkzNTYyDQo+ICAgaGV4IGR1bXAgKGZp
cnN0IDMyIGJ5dGVzKToNCj4gICAgIDAyIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDUwIDA2IDhh
IGMwIGZmIGZmIGZmICAuLi4uLi4uLi5QLi4uLi4uDQo+ICAgICBlMCA2ZiAwNiA4YSBjMCBmZiBm
ZiBmZiAwMCA1MCAwNiA4YSBjMCBmZiBmZiBmZiAgLm8uLi4uLi4uUC4uLi4uLg0KPiAgIGJhY2t0
cmFjZSAoY3JjIGYxYjhiNzlmKToNCj4gICAgIFs8MDAwMDAwMDA1N2QyYzZhZT5dIGttZW1sZWFr
X2FsbG9jKzB4MzQvMHg0MA0KPiAgICAgWzwwMDAwMDAwMDNjNDEzZTYwPl0ga21hbGxvY190cmFj
ZSsweDJmOC8weDQ2MA0KPiAgICAgWzwwMDAwMDAwMDY2M2Y2NGU2Pl0gZmVjX3Byb2JlKzB4MTM2
NC8weDNhMDQNCj4gICAgIFs8MDAwMDAwMDAyNGQ3ZTQyNz5dIHBsYXRmb3JtX3Byb2JlKzB4YzQv
MHgxOTgNCj4gICAgIFs8MDAwMDAwMDAyOTNhYTEyND5dIHJlYWxseV9wcm9iZSsweDE3Yy8weDRm
MA0KPiAgICAgWzwwMDAwMDAwMGRmZDFlMGYzPl0gX19kcml2ZXJfcHJvYmVfZGV2aWNlKzB4MTU4
LzB4MmM0DQo+ICAgICBbPDAwMDAwMDAwNGFlMDAzNGE+XSBkcml2ZXJfcHJvYmVfZGV2aWNlKzB4
NjAvMHgxOGMNCj4gICAgIFs8MDAwMDAwMDBmYTNhZDBlMT5dIF9fZGV2aWNlX2F0dGFjaF9kcml2
ZXIrMHgxNjgvMHgyMDgNCj4gICAgIFs8MDAwMDAwMDAzOTRhMzhkMz5dIGJ1c19mb3JfZWFjaF9k
cnYrMHgxMDQvMHgxOTANCj4gICAgIFs8MDAwMDAwMDBjNDRlM2RlYT5dIF9fZGV2aWNlX2F0dGFj
aCsweDFmOC8weDMzYw0KPiAgICAgWzwwMDAwMDAwMDRkYjY5YzE0Pl0gZGV2aWNlX2luaXRpYWxf
cHJvYmUrMHgxNC8weDIwDQo+ICAgICBbPDAwMDAwMDAwZjQ3MDUzMDk+XSBidXNfcHJvYmVfZGV2
aWNlKzB4MTI4LzB4MTU4DQo+ICAgICBbPDAwMDAwMDAwZjcxMTU5MTk+XSBkZWZlcnJlZF9wcm9i
ZV93b3JrX2Z1bmMrMHgxMmMvMHgxZDgNCj4gICAgIFs8MDAwMDAwMDAxMjMxNWIzYj5dIHByb2Nl
c3Nfc2NoZWR1bGVkX3dvcmtzKzB4NmMwLzB4MTY0Yw0KPiAgICAgWzwwMDAwMDAwMDg5YjJiNmUx
Pl0gd29ya2VyX3RocmVhZCsweDM3MC8weDk1Yw0KPiAgICAgWzwwMDAwMDAwMDRkYmUzZDFhPl0g
a3RocmVhZCsweDM2MC8weDQyMA0KPiANCj4gRml4ZXM6IDYzZTNjYzJiODdjMiAoImFybTY0OiBk
dHM6IGlteDkzLTExeDExLWV2azogYWRkIHJlc2V0IGdwaW9zIGZvcg0KPiBldGhlcm5ldCBQSFlz
IikNCg0KSSBkb24ndCB0aGluayB0aGlzIGNvbW1pdCBzaG91bGQgYmUgYmxhbWVkLCBiZWNhdXNl
IHRoaXMgaXNzdWUgc2hvdWxkDQpoYXZlIGV4aXN0ZWQgZWFybGllciwgaXQgaXMganVzdCBwY2Fs
NjUyNCBkcml2ZXIgaXMgbG9hZGVkIGxhdGVyIHRoYW4gdGhlDQpmZWMgZHJpdmVyLCB3aGljaCB0
cmlnZ2VycyB0aGlzIGlzc3VlLg0KDQpUaGUgY29tbWl0IDU5ZDBmNzQ2NTY0NCAoIm5ldDogZmVj
OiBpbml0IG11bHRpIHF1ZXVlIGRhdGUgc3RydWN0dXJlIikNCndhcyB0aGUgZmlyc3QgdG8gaW50
cm9kdWNlIHRoaXMgaXNzdWUsIGNvbW1pdCA2MTlmZWU5ZWIxM2INCigibmV0OiBmZWM6IGZpeCB0
aGUgcG90ZW50aWFsIG1lbW9yeSBsZWFrIGluIGZlY19lbmV0X2luaXQoKSAiKQ0KZml4ZWQgdGhp
cywgYnV0IGl0IGRvZXMgbm90IHNlZW0gdG8gYmUgY29tcGxldGVseSBmaXhlZC4NCg0KV2Ugc2hv
dWxkIGZpbmQgdGhlIGNvcnJlY3QgYmxhbWVkIGNvbW1pdCBzbyB0aGF0IHN0YWJsZSBtYWludGFp
bmVycw0KY2FuIGJhY2twb3J0IHRvIHRoZSBjb3JyZWN0IGtlcm5lbCB2ZXJzaW9uLg0KDQo+IFNp
Z25lZC1vZmYtYnk6IFhpYW9sZWkgV2FuZyA8eGlhb2xlaS53YW5nQHdpbmRyaXZlci5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMgfCAxICsN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gaW5kZXggYTcyZDhhMmViMGIzLi4yYjM1
MzRkNDM0ZDggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9m
ZWNfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFp
bi5jDQo+IEBAIC00NTI0LDYgKzQ1MjQsNyBAQCBmZWNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gIAlmZWNfZW5ldF9taWlfcmVtb3ZlKGZlcCk7DQo+ICBmYWlsZWRfbWlp
X2luaXQ6DQo+ICBmYWlsZWRfaXJxOg0KPiArCWZlY19lbmV0X2ZyZWVfcXVldWUobmRldik7DQo+
ICBmYWlsZWRfaW5pdDoNCj4gIAlmZWNfcHRwX3N0b3AocGRldik7DQo+ICBmYWlsZWRfcmVzZXQ6
DQo+IC0tDQo+IDIuMjUuMQ0KDQo=

