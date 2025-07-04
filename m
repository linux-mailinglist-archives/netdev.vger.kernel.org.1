Return-Path: <netdev+bounces-204041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77199AF892D
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FD8E7B9FC6
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 07:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337B7277818;
	Fri,  4 Jul 2025 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UOGSQEIT"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013004.outbound.protection.outlook.com [40.107.162.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828BF2DE711;
	Fri,  4 Jul 2025 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751613825; cv=fail; b=usrjsj+EOZ5EJU5uuWeenbdXO6By1JYT/GtGk6ptryWyBacs0I8ECmS62eck+M+MUVhx+81V6hTtdJpnBNIK29qDpEv35pykz/4EJIlj3iCcK9a5qry1CtOQd8V9zJGc8FunhBNfM3lnvigC9Cg9jMlio/k6WUyzBNBnWvTtMUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751613825; c=relaxed/simple;
	bh=KkKS4nqT4YnjVs3hJ0QGJty9tSxqj5yqGSrsU+V/eBg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IlIUEaWwpDsOVRpfza6PaAorz+zaNovHEtyAiF8RS1rBPRucz/VJ4vSo36Q/BWFSBidcYMRAmoVbpXgq72N7nckak87cQj+Rczgt6JkyNrPj2H7kssIWgYZoAaso2n5/CwBBFu2cgr+bHBPu073oog3wtBZpYBTgP/IAXLmRq3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UOGSQEIT; arc=fail smtp.client-ip=40.107.162.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpmq11W4ychBsgwLTUmGtInZzv7JhHj9Ltm6kK3xJZV0uvjQQKIaqncNuM3Ubf75Xu8K6ArcpBc8dA+/LOceBNS6y/AOPYcOD+DZAS5ojhseFmj1d9CJ5nrq+RHTxTZTP+YXbBSGEmuopy5R3zwF+a3QQFXa1CtxYvRz++Cjs7W1adJ8Zq/XxszAtMDUnX/QQEWVr3Qm3Q+SZ8v9jErHK/WG+TI5QqqHophFgYjohc+hjgTyg5RRkdw70X7LeKjzHM9ERUwAqNio4RiOhwmZTvxiO5cg4BBF1DoNKukET5xA/HXugst5vdaeuVthYt91f/3v/8TfandTFz+MLRhKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkKS4nqT4YnjVs3hJ0QGJty9tSxqj5yqGSrsU+V/eBg=;
 b=EGNgOjtewqu4Ot5lA+a7kZM8ISgZ82L281NUk2plA/tsgPtbbgwPl0eiPcmE4hH1Bt3xekhqWA0DHdQMUtWl2REw7nxphUW5JB3+UzYccYDrC6rT+tXqlyELVAIQ5YXxhuE/HLYZWuir3QMPTrGTg9khkixMhr/Y9hOJxj7wiWUrxOTEQ3PlK5Sx5z5P0eNgj2mLDb6A3MIj7E/6dRwfWzTZQG6MBxRaDv78VjCea/kdhtswweDWvlyAln8L/fzSoi2Jxaga/nHRYIkmLnP1gR3cKZHig0gMq1rI6y9HkjYLPrM3DAvH+IS61uHqcchXj72JMMat6/QWWktD4oh/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkKS4nqT4YnjVs3hJ0QGJty9tSxqj5yqGSrsU+V/eBg=;
 b=UOGSQEITVYOtB32F++54cfQNHwIHnFBVpx4T/SZECIcvxeK6bab15gFjqJyiRtuwiVxZMiUH3Z/EM/YHLzbHUaCZsR4/22Fy/y5VD+aRNlOCJBlLrshehtI2XVIAlMohPLhGT6kd9122hxQNiIr6DpAunViuJ7AAqdV3L5PBfzfwFg6i8hF1XKcnxXOKvz09qjABQaByPHsjg5l6vFjuhFasWZNi0R0kVNt+W/+eXlb29cJ4gASTDAhyvnepOLM/LnSp4+Fm3ZT2lWyM6Q0dxl0CS8xRH9qUOhr4HIXC+fZmhL//Z+915t90mWr99F8+ejIovLmaEBlpjRiY23VpOQ==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DU4PR04MB10816.eurprd04.prod.outlook.com (2603:10a6:10:582::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 07:23:39 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 07:23:39 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>, Sherry
 Sun <sherry.sun@nxp.com>, Manjeet Gupta <manjeet.gupta@nxp.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: coredump: Add hci_devcd_unregister()
 for cleanup
Thread-Topic: [PATCH v1 1/2] Bluetooth: coredump: Add hci_devcd_unregister()
 for cleanup
Thread-Index: AQHb7LSQLA3TVvNOWUyfSGQrRm03Jw==
Date: Fri, 4 Jul 2025 07:23:39 +0000
Message-ID:
 <AS4PR04MB969274E6E1CD42BC80C1BE61E742A@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250703125941.1659700-1-neeraj.sanjaykale@nxp.com>
 <CABBYNZKN+mHcvJkMB=1vvOyExF8_Tg2BnD-CemX3b14PoA1vkg@mail.gmail.com>
In-Reply-To:
 <CABBYNZKN+mHcvJkMB=1vvOyExF8_Tg2BnD-CemX3b14PoA1vkg@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|DU4PR04MB10816:EE_
x-ms-office365-filtering-correlation-id: e32da0fc-3ed1-495a-0ffa-08ddbacbb29f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U0VBaVdQUWszSjBGMWhhQ0p6WG5NZ1FRRmNVdmtpOHVSVURzUmJNdno4Wkpl?=
 =?utf-8?B?MFZ0a01KdFZ3Zzc5eU9aQ09KSFdVZDdoWElaeWFPYTl2cW5VZEtseGl5MVNL?=
 =?utf-8?B?NnBnU0VnbDdZWHp3TEJ2MCswZG1EVXU3RTBMeCtqZDVrWWxpc0ZpTWJmOFND?=
 =?utf-8?B?bS9HZnVMYXNmWHJtaFMza0RzK0F2MTNnOWZTUitaWEtVN3NtUElsUVlxeGxD?=
 =?utf-8?B?SDJPVlhTbGtiS09yZHVCcm5JOUdzNDNDYjFhK24vYTBLN0F6M25mY1lPOFdh?=
 =?utf-8?B?RUFJcFFyV0h0Z0g3SndxRldmcUVLSEZzclRaNFdQaWtpZGMxajVLRy9MRU12?=
 =?utf-8?B?N1BIbWZWd01zSGR0L000TW9xRkNZMDVpWG1kMWt4MjI2eUxVZHk4ZEdoeCs4?=
 =?utf-8?B?cXpudHkvUEdHQThqY2J6bnNaNm11YUYzdjJJY3YyZ3ZoNXdOVStiNGlWQWds?=
 =?utf-8?B?YzI1VCtKWFc5VkFyZWxFcnRaRVJNdWhpRnAwMWJndUVEUmkrdmc3Z3JvR1ZS?=
 =?utf-8?B?cmhRaFNZOExqL0QyY05YYVNLZkhUbDRyb1dPNnVhVlVML0cvUUF0Zmc5N00v?=
 =?utf-8?B?Q3F0VEdsSXo5NFduZUV2R0twNFg0aHFoMDdCTWk2YjB0U3pIOEdOMVE1UGJZ?=
 =?utf-8?B?ZnFZaHYwTEJidWI0ZitzYng1SkZxZFR3YkF2dmtGbkpCbjJCYS9IN0g0TlVO?=
 =?utf-8?B?dEdrTm9XaEtvSTRqRU82NFNvZk9jUDBBMVFqMmpCRVJuR2JaVVFtSEhZSERa?=
 =?utf-8?B?Q3UyaXVlRlFFMzU2MUFTNS9oS29iVXZCL0JPbEpYcXRXS25xNWhVNFpqZlEz?=
 =?utf-8?B?YmRuMVhicFFyTk5GQnJSMVg3aGp5VzZUcDBWVG5IdmNwamVta2NPZjBnbXVu?=
 =?utf-8?B?K09xSWt1dFdWa0lJNnhMNE5uS0w3R3lmd2dlem5TdStsdFpDSnBRMFZMZGVJ?=
 =?utf-8?B?UGE0WENxL243bmlQTm9MVDlBNWRPQlhHanBGUkpiRVFPMkxISG1kU2E4WTdN?=
 =?utf-8?B?R2Z1UE43QUhQbklmZ3g0R3J6S2ptWWduTDIvNURvTHpMb1RnbXJCWFp0bFE1?=
 =?utf-8?B?d2xleTh0QXJpa2YrRFgra1VSWkhvZ01uSHRhdFBVcGgvQVJ2TGFkMWVOMVhB?=
 =?utf-8?B?YUdzZmJDWjRUT24xNW1EZ29ha2FqTnB0OHhZVXdwcXR2TG0yUzJWOEw1c3cy?=
 =?utf-8?B?aGNGYlZDWFdKMlBVUjl5VWVPajlHcTcrSDZlNTFsK01WbUhwVUtoN2VBa0FC?=
 =?utf-8?B?U294blZRdnJPQXhNdDVyK1RZeGVZL1FCZ1hxUEVuUnlIRHFjY0lvRVhnaFV1?=
 =?utf-8?B?Z1F4NkRzaVV1b2N4RG9Ra1VBMTA5aGJmNy9WVUpES2hDdVcyelZZb1ROdnRl?=
 =?utf-8?B?NmhyenduN1NIRWNZSzFoSytkeC9GR3p0SkRsK0l5amxSdHBNTnE2V3VBUkVM?=
 =?utf-8?B?NFQ4dlIzOU1qTzlaZHpEcHRPTE1JYUgrVWN2VysyYkxHTUFKNHN5RFRWT1JD?=
 =?utf-8?B?dkxSZGpwVmdPTEpyUUZKTFVtTEpMempsSkJEZ3dXR212ZU1ENXdxY3U2ZWg3?=
 =?utf-8?B?ZEZoY2dzenhhWDN3UjdMeDA2NGNkQ3p1MngxM2xacHd6bXNOcmpOQ3doSW9M?=
 =?utf-8?B?YTlSMlNJa2twRUI2K2NHcmo3dzZwdU4yU2tkMU9KdzFBQzNXUmtTVk1zcmNV?=
 =?utf-8?B?TUI2bHE3RWMrRmJrcHhRTzVYbDhnRVpsejdWT2hTNTNxdWN4UWcvZ2lIY1BY?=
 =?utf-8?B?QWx2MjgzSWU1aFFpQ2tBaGZRL2xzZzJ6alEyWXphNWtqL3JxS0hNSk0rNzhJ?=
 =?utf-8?B?TWw1aEdoRGp0R0RCMWI0MmJoNVQyb09CNkNvMEdXZUpZMUNuV3kzdE5abERk?=
 =?utf-8?B?UVl1UDZ3ekpucWtuS0QwNDF0V2FEbkVuekxvOVcwYllwWmx2bkVOZEMrbFVI?=
 =?utf-8?B?b0p6MUF4SjlQeEREUHVpU1VlaXlWaG13cmNYL2dNWHpXMnRDeXE4S3oxM0cy?=
 =?utf-8?Q?3qEM5VFkWlsP4JLthHPeGJMWfvdVAw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dTV5QzhVbUpubE5YUnhTY0w2cFJJcUUwa0kzdklZZ21WVCsvWG42WXZvd25Z?=
 =?utf-8?B?NTIrWS9jRTlSb3VOcVZnZGhNeExYVXhIVHRZaFk2TEk2Q2tWSlUreHpSV1My?=
 =?utf-8?B?eGdOYUxXZGVxcG5pdDVVU01HczRtTGoyalcwc25MMzR4U04vdGxvTzBZUWhF?=
 =?utf-8?B?VGFCb3BUSjJrVUk2cXpOeTJSSnFYdUFWcGExbFhzMmd0ckxRN3lydGFPNGgz?=
 =?utf-8?B?M1JiWk1hUVNjaTB4YTJJWlUzSjdDVXJGUDdtSm82eW1JcVk3RXJoc2Q1dG5X?=
 =?utf-8?B?all4U3o1TXJUT2pyeVJKSVRGMCtmaDgxU1p3N0JaUWlhV1hXSFRyb2txbkx5?=
 =?utf-8?B?aEIwYktiemRKZmVqejZTRUFmdkpEeFp5RXJCYkJVeGFoWC9SZkZ5bTQwS2lz?=
 =?utf-8?B?RDRyRHZ5R3kyNllRdVY0REdhOWE0VnFzTmlsZzlLWlR3WFVNV2J4MDhuWXdW?=
 =?utf-8?B?RzMrYTcrMWZDM1VSYTlxWCtOS1MzWWNMR0RLdW85Z0RqRXZ5WkluSzFrWWNy?=
 =?utf-8?B?OUxMcmtJL0J2M3dIOC80ZStlT2pqdHBiSzRSampTRlBhZTdqeWhyUlM5eUpz?=
 =?utf-8?B?ak5oeVBINHpXRlNWMDdwRVJYRXdhNjNzbmNIazkrUkt2MHZCaEk3QXNCaFpP?=
 =?utf-8?B?SnNsR2VYdWgrSnRrK0NjRVFKTUJCbXBBL1hWRUN3NDJSQ3ZEUTB4Ym92NFEw?=
 =?utf-8?B?ZXZCN1lVR2NQODQxN2pWQzZkLzNHTlh2WDNkbFMxQ3dpK2J1WFFWclhxMmhG?=
 =?utf-8?B?elhqSFhtYUlkdndVVWl3bkR2czFFdERiNFJKZnRDcVdkZWdoVTIvTjh6MEFV?=
 =?utf-8?B?MERZUXU2c0MyM0JlOFVZeUdUT1U4TkxrVWVxSnpWVzBNRld4NzExeWpLYlNi?=
 =?utf-8?B?aytWak1BVGUxOFhTcHkxT2J0RkpWTlR0M3RQRldHbWFJZmgvUEpnQThTWld0?=
 =?utf-8?B?VTBPSDJOZVBEK0J1eGlXaXZyaStFTWhhTzZJZTA5MlhtQUZaOUlRZHllMlhk?=
 =?utf-8?B?WExJMVFvcmY0eU1WSlVCTWFCNEdXVlhmOGkwTUVDUm8yOUVucWV6azQyUFBG?=
 =?utf-8?B?Z0toUkQwZXVVY2xYNEFXK3VPeHhJK2xMeE5FNzJGUTU1ZWl0blY0UnlRSEh4?=
 =?utf-8?B?cXNVQTJoWlJqOG5INytwU0c2enhzdVVuOUZoTVg4TVpwcGE1dzdLMmpRYmk1?=
 =?utf-8?B?cGFPSjh2d2xDckNLZXZONnFNM0FSL0RZY2piQ0ppNGZ1ZGFCd3BtR2dOL3BB?=
 =?utf-8?B?ZFJpVkU5TUkweEZUdXVLZXRXMGZMYzVlcVgzeFVTbHhzbVBnOWlYM0VNZ09V?=
 =?utf-8?B?QjVEb04xS3hLZWF4VVFUWTJIZDVWclkxaXg1QnFGZlM5T3poVVN5UTE0bzc1?=
 =?utf-8?B?S3E5elJmL0pVWHNQdjVSakhKV2IvMlhiZHp0VVNUSDF5THp3K3ZzdFlaWHRW?=
 =?utf-8?B?dUcwTWxsd01UaFBPSHVhdmNzbWRDdys4NFBCM1EyU3E3SVdKSW5nQWNHeUEz?=
 =?utf-8?B?TXVTSkJtRGlVaEV5M09xK2lHOE1mU2JaMytIWEhzR250YnVvYW0yMUVFMlg5?=
 =?utf-8?B?T3c1YVJMbHVRS2ZBNXdRM2NBZk9lN3pZTTRFS3cvZVVXaUYydEpmR3BVR25B?=
 =?utf-8?B?ZStMeTBFWEpzcXhOR3U5aUpsTkh1Um5yR2liTnlTakEvemNuaktIdVBGckFz?=
 =?utf-8?B?cmZwcHVDYkJjeVhpckM0NGJqb3pOVFl1UGljSnJzMU5rUHRDcWYyOThodXZq?=
 =?utf-8?B?dlJBTUFSa0dBamdFZXFyK1kzcThMZTRpRXFma00wbHYzVjZPUlkxamk2Nklj?=
 =?utf-8?B?TlJ0TDJyZmdyTytIdjZLamVYSmlrVjhGaGlvSTQ5UVlFRVRhZFVOOTI3YTZw?=
 =?utf-8?B?ZFZXeDZGZHdXYUNYenU3cmplYVJnM3NKY2liUkhtY25vRHB5SzhZUTVYRDh6?=
 =?utf-8?B?cXZ1a2htL3VWRXlFU003ZmJFOENvbURLUDIyVEYyY3I5NUNRdFN2U1YvRFJz?=
 =?utf-8?B?QllJVlhzejVuYlZhOFJ5eTFYanpOSmoyenExbUcyYUVzN1VlNGdod2hlbm9B?=
 =?utf-8?B?SkZTdmxScVRKN2piVmVObjdwdG9PekpHQ2FJQjUxQTZXRjVmLzBiRzZadVBG?=
 =?utf-8?Q?3aYnYhipyQ/3/TGIms6Mytf/4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32da0fc-3ed1-495a-0ffa-08ddbacbb29f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 07:23:39.4029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zRCnok4e2smygFvvSXkc0UWBanov//+KeycPHCpMiS5vRC0g/bHteoZQ5ayVGHDUwYuJfeq9K9zs1ixcHc05y8jSHgEL7kLFPAVlTHL26oI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10816

SGkgTHVpeiwNCg0KVGhhbmsgeW91IGZvciByZXZpZXdpbmcgdGhpcyBwYXRjaC4NCg0KPiBPbiBU
aHUsIEp1bCAzLCAyMDI1IGF0IDk6MTfigK9BTSBOZWVyYWogU2FuamF5IEthbGUNCj4gPG5lZXJh
ai5zYW5qYXlrYWxlQG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBhZGRzIGhjaV9kZXZj
ZF91bnJlZ2lzdGVyKCkgd2hpY2ggY2FuIGJlIGNhbGxlZCB3aGVuIGRyaXZlciBpcw0KPiA+IHJl
bW92ZWQsIHdoaWNoIHdpbGwgY2xlYW51cCB0aGUgZGV2Y29yZWR1bXAgZGF0YSBhbmQgY2FuY2Vs
IGRlbGF5ZWQNCj4gPiBkdW1wX3RpbWVvdXQgd29yay4NCj4gPg0KPiA+IFdpdGggQlROWFBVQVJU
IGRyaXZlciwgaXQgaXMgb2JzZXJ2ZWQgdGhhdCBhZnRlciBGVyBkdW1wLCBpZiBkcml2ZXIgaXMN
Cj4gPiByZW1vdmVkIGFuZCByZS1sb2FkZWQsIGl0IGNyZWF0ZXMgaGNpMSBpbnRlcmZhY2UgaW5z
dGVhZCBvZiBoY2kwDQo+ID4gaW50ZXJmYWNlLg0KPiA+DQo+ID4gQnV0IGFmdGVyIERFVkNEX1RJ
TUVPVVQgKDUgbWludXRlcykgaWYgZHJpdmVyIGlzIHJlLWxvYWRlZCwgaGNpMCBpcw0KPiA+IGNy
ZWF0ZWQuIFRoaXMgaXMgYmVjYXVzZSBhZnRlciBGVyBkdW1wLCBoY2kwIGlzIG5vdCB1bnJlZ2lz
dGVyZWQNCj4gPiBwcm9wZXJseSBmb3IgREVWQ0RfVElNRU9VVC4NCj4gPg0KPiA+IFdpdGggdGhp
cyBwYXRjaCwgQlROWFBVQVJUIGlzIGFibGUgdG8gY3JlYXRlIGhjaTAgYWZ0ZXIgZXZlcnkgRlcg
ZHVtcA0KPiA+IGFuZCBkcml2ZXIgcmVsb2FkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmVl
cmFqIFNhbmpheSBLYWxlIDxuZWVyYWouc2FuamF5a2FsZUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+
ICBpbmNsdWRlL25ldC9ibHVldG9vdGgvY29yZWR1bXAuaCB8IDMgKysrDQo+ID4gIG5ldC9ibHVl
dG9vdGgvY29yZWR1bXAuYyAgICAgICAgIHwgOCArKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5n
ZWQsIDExIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC9i
bHVldG9vdGgvY29yZWR1bXAuaA0KPiA+IGIvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2NvcmVkdW1w
LmgNCj4gPiBpbmRleCA3MmY1MWI1ODdhMDQuLmJjODg1NmU0YmZlNyAxMDA2NDQNCj4gPiAtLS0g
YS9pbmNsdWRlL25ldC9ibHVldG9vdGgvY29yZWR1bXAuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbmV0
L2JsdWV0b290aC9jb3JlZHVtcC5oDQo+ID4gQEAgLTY2LDYgKzY2LDcgQEAgdm9pZCBoY2lfZGV2
Y2RfdGltZW91dChzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspOw0KPiA+DQo+ID4gIGludCBoY2lf
ZGV2Y2RfcmVnaXN0ZXIoc3RydWN0IGhjaV9kZXYgKmhkZXYsIGNvcmVkdW1wX3QgY29yZWR1bXAs
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICBkbXBfaGRyX3QgZG1wX2hkciwgbm90aWZ5X2No
YW5nZV90DQo+ID4gbm90aWZ5X2NoYW5nZSk7DQo+ID4gK3ZvaWQgaGNpX2RldmNkX3VucmVnaXN0
ZXIoc3RydWN0IGhjaV9kZXYgKmhkZXYpOw0KPiA+ICBpbnQgaGNpX2RldmNkX2luaXQoc3RydWN0
IGhjaV9kZXYgKmhkZXYsIHUzMiBkdW1wX3NpemUpOyAgaW50DQo+ID4gaGNpX2RldmNkX2FwcGVu
ZChzdHJ1Y3QgaGNpX2RldiAqaGRldiwgc3RydWN0IHNrX2J1ZmYgKnNrYik7ICBpbnQNCj4gPiBo
Y2lfZGV2Y2RfYXBwZW5kX3BhdHRlcm4oc3RydWN0IGhjaV9kZXYgKmhkZXYsIHU4IHBhdHRlcm4s
IHUzMiBsZW4pOw0KPiA+IEBAIC04NSw2ICs4Niw4IEBAIHN0YXRpYyBpbmxpbmUgaW50IGhjaV9k
ZXZjZF9yZWdpc3RlcihzdHJ1Y3QgaGNpX2Rldg0KPiAqaGRldiwgY29yZWR1bXBfdCBjb3JlZHVt
cCwNCj4gPiAgICAgICAgIHJldHVybiAtRU9QTk9UU1VQUDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0
YXRpYyBpbmxpbmUgdm9pZCBoY2lfZGV2Y2RfdW5yZWdpc3RlcihzdHJ1Y3QgaGNpX2RldiAqaGRl
dikge30NCj4gPiArDQo+ID4gIHN0YXRpYyBpbmxpbmUgaW50IGhjaV9kZXZjZF9pbml0KHN0cnVj
dCBoY2lfZGV2ICpoZGV2LCB1MzIgZHVtcF9zaXplKQ0KPiA+IHsNCj4gPiAgICAgICAgIHJldHVy
biAtRU9QTk9UU1VQUDsNCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9jb3JlZHVtcC5j
IGIvbmV0L2JsdWV0b290aC9jb3JlZHVtcC5jIGluZGV4DQo+ID4gODE5ZWFjYjM4NzYyLi5kZDdi
ZDQwZTNlYmEgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L2JsdWV0b290aC9jb3JlZHVtcC5jDQo+ID4g
KysrIGIvbmV0L2JsdWV0b290aC9jb3JlZHVtcC5jDQo+ID4gQEAgLTQ0Miw2ICs0NDIsMTQgQEAg
aW50IGhjaV9kZXZjZF9yZWdpc3RlcihzdHJ1Y3QgaGNpX2RldiAqaGRldiwNCj4gPiBjb3JlZHVt
cF90IGNvcmVkdW1wLCAgfSAgRVhQT1JUX1NZTUJPTChoY2lfZGV2Y2RfcmVnaXN0ZXIpOw0KPiA+
DQo+ID4gK3ZvaWQgaGNpX2RldmNkX3VucmVnaXN0ZXIoc3RydWN0IGhjaV9kZXYgKmhkZXYpIHsN
Cj4gPiArICAgICAgIGNhbmNlbF9kZWxheWVkX3dvcmsoJmhkZXYtPmR1bXAuZHVtcF90aW1lb3V0
KTsNCj4gPiArICAgICAgIHNrYl9xdWV1ZV9wdXJnZSgmaGRldi0+ZHVtcC5kdW1wX3EpOw0KPiA+
ICsgICAgICAgZGV2X2NvcmVkdW1wX3B1dCgmaGRldi0+ZGV2KTsNCj4gPiArfQ0KPiA+ICtFWFBP
UlRfU1lNQk9MX0dQTChoY2lfZGV2Y2RfdW5yZWdpc3Rlcik7DQo+IA0KPiBUaGUgZmFjdCB0aGF0
IHRoZSBkdW1wIGxpdmVzIGluc2lkZSBoZGV2IGlzIHNvcnQgb2YgdGhlIHNvdXJjZSBvZiB0aGVz
ZQ0KPiBwcm9ibGVtcywgc3BlY2lhbGx5IGlmIHRoZSBkdW1wcyBhcmUgbm90IEhDSSB0cmFmZmlj
IGl0IG1pZ2h0IGJlIGJldHRlciBvZmYNCj4gaGF2aW5nIHRoZSBkcml2ZXIgY29udHJvbCBpdHMg
bGlmZXRpbWUgYW5kIG5vdCB1c2UNCj4gaGRldi0+d29ya3F1ZXVlIHRvIHNjaGVkdWxlIGl0Lg0K
QXJlIHlvdSBhcmUgdGFsa2luZyBhYm91dCAiaGRldi0+ZHVtcC5kdW1wX3RpbWVvdXQiPyBpdCBk
b2VzIG5vdCBjb250cm9sIHRoZSBkdW1wIGxpZmV0aW1lLg0KSXQgc2ltcGx5IG1ha2VzIHN1cmUg
dGhhdCBvbmNlIEZXIGR1bXAgaXMgc3RhcnRlZCwgaXQgc2hvdWxkIGJlIGNvbXBsZXRlIHdpdGhp
biAiZHVtcF90aW1lb3V0IiBzZWNvbmRzLg0KDQpUaGUgYWN0dWFsIGNsZWFuaW5nIHVwIG9mIGR1
bXAgZGF0YSBpcyBkb25lIGJ5IHRoZSAiIGRldmNkLT5kZWxfd2siIHdoaWNoIGlzIGRlbGF5LXNj
aGVkdWxlZCBieSA1IG1pbnV0ZXMgaW4gZGV2X2NvcmVkdW1wbV90aW1lb3V0KCksIHdoaWNoIGlz
IHBhcnQgb2YgdGhlIGRldmNvcmVkdW1wIGJhc2UuDQoNClN1cmUsIHdpdGggc29tZSBtb2RpZmlj
YXRpb24sIHRoZSBkcml2ZXIgY2FuIGNvbnRyb2wgdGhlIGR1bXAgbGlmZXRpbWUgaW5zdGVhZCBv
ZiBoYXJkY29kZSBERVZDRF9USU1FT1VULCBidXQgZHVyaW5nIGRyaXZlciBleGl0LCB0aGVyZSBp
cyBhIG5lZWQgZm9yICJkZXZfY29yZWR1bXBfcHV0KCkiIEFQSSB0byBiZSBjYWxsZWQgYW55d2F5
Lg0KDQpQbGVhc2UgbGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cyBvbiB0aGlzLg0KDQo+IA0KPiA+
ICBzdGF0aWMgaW5saW5lIGJvb2wgaGNpX2RldmNkX2VuYWJsZWQoc3RydWN0IGhjaV9kZXYgKmhk
ZXYpICB7DQo+ID4gICAgICAgICByZXR1cm4gaGRldi0+ZHVtcC5zdXBwb3J0ZWQ7DQo+ID4gLS0N
Cg0KVGhhbmtzLA0KTmVlcmFqDQo=

