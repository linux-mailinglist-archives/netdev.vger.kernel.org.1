Return-Path: <netdev+bounces-295062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yWkYCQMhIWqv/QAAu9opvQ
	(envelope-from <netdev+bounces-295062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 08:53:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A5563D5EF
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 08:53:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b="2R/8AbAg";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295062-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295062-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9F57302E7DC
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 06:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726253D9699;
	Thu,  4 Jun 2026 06:51:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011067.outbound.protection.outlook.com [52.101.57.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A33CF041
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 06:51:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555879; cv=fail; b=l95PqrCGadYJKv/Ty68k9GuOfHR7WG6xyrxIko+tVd9UMIBY3pO8TRiuqc5W8aWW9D1ztuCIGEG/b/X/968aLdifw1pOqF+Kzk0LEWBwJ/K6wJxWzYrvyCyaVCrwjcraojLO7gMjLSvSa6YhGtlSJHpyrFpScpbuGw1oHwEJAhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555879; c=relaxed/simple;
	bh=IO6zFjQ70VfWCgqHtqWJpqybI35kLMSPnxO5qOBnCZI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uBvaHmBeMPiSw57LXErtD5CMI3YViK3luU8IUBi2P/lU3MB+BKkIBHMZk/T2Sq56qJ84Tt1YUdOo1voRCEP7L5iwyLeqvaW3dR9J6K50EYbAY68DTkcZdvHXs0lMorWlmx9CAhVK4yjU0hhROqQwveYuSP9xITTwqrcdzS7wqP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2R/8AbAg; arc=fail smtp.client-ip=52.101.57.67
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBl+/wPZgIc2s8gtcElrSqFYPOsP9sRrhe9MrnyTyyuo1AGqqEMkDyZNKne8EAT7N7h/31QDKikzyzp6U98MBcn4CdbT/kdKkfma9blewW6h7AKQYHBAefLLuIEa05XMK4Jxm/XAJRDFrjmsqcdJ8b00Ymk1JKlZs4MMtL12gw3XMxj5oVNkPWpY2CIaFRplrTW1oMBV2MER33fryJic+sgLA1PdnpWt8cXnwW0mRzuZMOrDkpdOjerco2SP7S8SqH63KVZRzq89XM3LZqB54Ksoe9nmhVFnPGBvwu/bcet2PXbd5jTQzTcumNGr44IMJC/zYKweWOjN20T3qo9JOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IO6zFjQ70VfWCgqHtqWJpqybI35kLMSPnxO5qOBnCZI=;
 b=AwdGjuVu5I5I0ciwqFi6O53x7ta1OkfqCbo/MLUg5p93AaZ4ypXHgzWnYnak7QASD+bjVKpKLxyPv2d6gUbmkKCYQ7lu61vOt1HlsnCFSwl246/6ZdYYlSAH5nFcB8uPTvUTtMshOC7tKvxGA59Mqlesc6eu4KrdmNFubl4AizW7bS8gaZArr5Mb8dY5UxBmly8wdnvlpQh05JDCre+mEet6YqFfoCScbsBGHQthMreOzGWQk2GrtGyOc1QppKJEKzldJ81QiUitPP0esMmzFuHH5smvV3cpicNBWFaD0edyLxLznXWjZ2qOYnO7jgVFP+5JjySznoNFcO42jmI5iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IO6zFjQ70VfWCgqHtqWJpqybI35kLMSPnxO5qOBnCZI=;
 b=2R/8AbAgb+pnFIE0yMPMeN3yncN3wA4HCfTRhSBCnzZ6y0PwA6YvPe2RDj1KrCpIzo8/xc6NfUouHvLNiLJ8J47ehEbifyx71via1ZnenYH3ZF3xKDlwJEH+g8wOeESfm5IGy8QIaS6xMpGUF1MhZETW/SruZL5jgxvMUbGZsiY=
Received: from MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 06:51:13 +0000
Received: from MN6PR12MB8513.namprd12.prod.outlook.com
 ([fe80::d5a7:a7f1:94c8:1c62]) by MN6PR12MB8513.namprd12.prod.outlook.com
 ([fe80::d5a7:a7f1:94c8:1c62%6]) with mapi id 15.21.0071.011; Thu, 4 Jun 2026
 06:51:13 +0000
From: "K.R, Prashanth Kumar" <PrashanthKumar.K.R@amd.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>, "S-k, Shyam-sundar"
	<Shyam-sundar.S-k@amd.com>, Jakub Kicinski <kuba@kernel.org>, "Banavara,
 Madhu" <Madhu.Banavara@amd.com>
CC: Patrick Oppenlander <patrick.oppenlander@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Linux kernel regressions
 list <regressions@lists.linux.dev>
Subject: RE: CL37 autonegotiation not working on amd-xgbe
Thread-Topic: CL37 autonegotiation not working on amd-xgbe
Thread-Index: AQHc3Qw4caePuwbso0y3KhLOwGoE6rYszQSAgAFTAnA=
Date: Thu, 4 Jun 2026 06:51:13 +0000
Message-ID:
 <MN6PR12MB8513D5386E2A586BE4FC68D7CF102@MN6PR12MB8513.namprd12.prod.outlook.com>
References:
 <CAEg67GmFS0Q4oSZkz8zWdOzckSth9_vBPiOy6a7-d697C2w2Xg@mail.gmail.com>
 <20260427162839.350135c8@kernel.org>
 <fa98f520-7539-42c0-a8f4-1858553946fe@amd.com>
 <59207b24-4fc1-45ec-b34d-359e1d247c54@leemhuis.info>
In-Reply-To: <59207b24-4fc1-45ec-b34d-359e1d247c54@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-04T06:40:40.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR12MB8513:EE_|DS7PR12MB6237:EE_
x-ms-office365-filtering-correlation-id: c65f27af-7450-4734-8116-08dec205ab2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006|5023799004;
x-microsoft-antispam-message-info:
 5N809zjfkOeNoXESooB6u6qT0KXFLiq9nUV+Xzj2pkeJ32dHqrsj978OI3R2d7RZH0+stWlP5yQXvawPuT92JwIjSCV+wSBsvXJP/yaZ5rXgzE+b4mYTiK0PYPP8E4wMRKY7au/qt7ZijuZG2n0u4z/CMKMsBjKoHaaxgnYouQZe2u/n7ooqfZuxJeRe7EJTH+LRk7WI218FDcxQavBWK5SBri2U9FjyoSGvsYm7JjcMwGEU1TsSo9rtBt/d6PpLmOTNybh5fRmfr5IJQS9CngcCKDOEAxYDKBU1+dqZoiUymunFUYaBa//0umOGtehaUONYBScK7mm6ifn5pccYH/xV1knewYCZ+b99DitU1M4hhJI14BoVAPMwQzQBxTc+2El5InBU72guN+J7GaS35b2CnwntxLzggT7kyP7R43RiwxpNdkmjdlOOTNWG/hK/XcDKoHB8cLwr0jdV4sEACtxbKMtlcI/eOkLt6fRs5SFtRHMjzYT1QIJvVe+gDsftREkuEIvmcP0y6yFJEU5TJ3pfa/I0trFonDMrUtyIrXKi3YKmeJJ2CdWAx5wwr9jCyEyfdkb9LoopbPTke60PTXfDX4maV+TJ5ExjfyeKWvatvmBpV1N8+zUmJ5pZ/cJDgr4QnuaZtpQ2Zo4+Iah8ESu1yO/WSQymc/vm4iiwm8JQrXJx3JEFxb1aGl8EbJOE1NimNliet8fAzbpFnO/LpwwTxBHYmSE9/GzUhv/UYRZ4OM++llnrOXoc5id73yRW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR12MB8513.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1dtaHdCSVVWVk5sRnVReWp0N2J2NUU3QnZsZWk0REJvekRPUEJZWCtDTERF?=
 =?utf-8?B?RzhtdzRmZk1hK2RIRmhWSFBsSWFsWTFQU2d0cmVYYlFNc2NLUGVQWllsT1NW?=
 =?utf-8?B?UVdxaXArK3NHRWE4U0lpVjhFdTJ1bWxXSUNRRTZ3UTlUS0xxbzNCMFIyN3ZQ?=
 =?utf-8?B?REhzbWw0Mkg1ekl3NXNGMWYvem5GaDg0YlNjSEkyTmZFd01FTU9RUXNhZ2JI?=
 =?utf-8?B?dnRTaVZUbUJ1blhSUVRvSFdOeHIxU2U3ZFRxL2poc2RtS2NLTFozNFQyVGJE?=
 =?utf-8?B?T29sWlBnYjhJQlA4OTh5Um53dzVRaS9RTGZqTi9kejlGY2RDK1h6WG1WK3Br?=
 =?utf-8?B?Mk1CTnpscGNHU1J0SHdPQUl0ZncvUkhpeDZvLzRhODIyS0pDc1lSWUd1eXpU?=
 =?utf-8?B?Mlg2RHhsM21qWW0yT21PT0QwaHdZVmIveVp5dk5zVndKNVpWMVg4a0FyOUVG?=
 =?utf-8?B?Sng0dUJwZ2tubi9saEo3NUxudUxUTzllazB5aXJIc2M0N3N0VWlvTTFnQnlu?=
 =?utf-8?B?ZnM3TTR4aWYxa29mYmhCc1N3MDJSYXhXVm80WmlLNmN3eHpSV1JIQmdFdW5F?=
 =?utf-8?B?UnVob2srL0hOcC9xdGJGSGZ3WjlvNWxiQ2NJSmFrY0tacmRtbVdUTHNlVFl6?=
 =?utf-8?B?RHhwdXh1VjZYdEpwMEc0SU1rQ3dHeE5lT2Q5cXdjUjdTS1NMVVdZZVYyZVdi?=
 =?utf-8?B?WngwWDV4ZVJmYS9wZ0R1VDQxanJnbVpFbzBvbFFWbW9xMDM1OU1TSVhFRTdn?=
 =?utf-8?B?NWpVa3czb1Q2TjFOQ2hPQmlYQ1A5Q2ZsT3hWUzUxMVRjOGRhOWJVUExNRU1w?=
 =?utf-8?B?ZFU3Sk5mMElESGxUR1RwQjY0Ukp5OVp0VTVHakgwTU5ScHhsZ1Jla1dxYTZ0?=
 =?utf-8?B?ZzVob0NjdnZ3MDlTTzBXTXIvbnh0U0lJNEN3ZElmZHRZNDRUMWVFS09udHAy?=
 =?utf-8?B?ME9pRDZwSGZvYXJlT0lPbnJudWZQNThWVy8vTUlZWHVzWVJ1RU5BRm5ITUpX?=
 =?utf-8?B?bW9Mem12eWxDYi80c1dUd1owRHhVd1JKRk9KakVKcnBTcFh6dlNZckphRVNq?=
 =?utf-8?B?eEFoRDI0V2dkWnRXZmNEOW9VeHUydi9lV3JxR25wYWc1SFRROEtEVUxNUVo2?=
 =?utf-8?B?bDJIUk5YbnE1Q2NPbHNlVXRlbWtEcnM4WnBYSkxHUUg2bmdCT0l4SXcwVit6?=
 =?utf-8?B?aC9TRzZORDZ6NCs3UUF1MzczZXUvWlVRSmZXSlY4ZSswUm9oTVJmTWI1RExM?=
 =?utf-8?B?M2ZCRzRVMlcvVUxIenV1bkNFMU96RXNVbnAyYW5DQ0hVSml5Sm1aL0MyUGZl?=
 =?utf-8?B?dFE0azdCbDR5c09zTmxlemVqVlBiZVM1cWVmM0Vxb0ZZdTNNK0I0SXJCZHoy?=
 =?utf-8?B?RWlURCtPTXFtMTM2MURxcVIxNUVXajJjejhtVjlQRXRSclU0Y3hqY0hRL1NY?=
 =?utf-8?B?UWNacWRSVzQrUWFxODN6TGI1SXR6SVlnNTd2UE9oU1Q0L3FmOFZGZkNPdWVO?=
 =?utf-8?B?MUg2NlhRM09OYVVnSXdqREphQjVWUS9QZTI5UHp4bFZzaG1lUVdlWlIrdEwr?=
 =?utf-8?B?bTR0Z1YxR3N4V0pqYTduZ3Vwc0E1bjRSYmtLeGdtMURBeW9YQjV3QmdpY1Bl?=
 =?utf-8?B?NHYxc1lkdzh0U2hNdk5yL25kcjRVdGVKMUZKR1hrcmJGVzVJUUVSRm80TjIz?=
 =?utf-8?B?Mmd5OXpGNVpmVGxsSVNlOUZucE9MaFo2OE9aMkRKYm84MUo1TXFjUkJaMmhl?=
 =?utf-8?B?aGFrYUx6eE9nWDg3djFFMFViQnEwdjNGMkJBb3pLTnlQdjh5clA4L01vVGlq?=
 =?utf-8?B?VnE3dzMzYXM5N0kybkZuMjhLekdlUVU0UGNTNGhFRjlsM25xSjYrd0JKNFdn?=
 =?utf-8?B?VDU1SW1yQUNtTldWd3lpcVBDS0txbnd4NkZYR1RUbDJodGNsRkVLaHJ1dGF5?=
 =?utf-8?B?cXVpNlhaakZrUkVRendkN2RWTjYrRXpVS29qalVBbnRybC9rT29XUGVDNDFG?=
 =?utf-8?B?Z2NFd0JTTmMwMzBERkJiZWJqV1RGK0VTNDVBSW9OcFplaTFoRTd5UFg2eWtT?=
 =?utf-8?B?YzZXRmgyR3NlcUNWMXByNFNZanRtQmJXUUJwRUVSZTN6Zm13c2huMmZpdEtY?=
 =?utf-8?B?d2YzR3ZDUlhJbHlvVjNBZ29ZMUlYREh5N1NKYmpBOVhaNXdhblR1WWhOdVZy?=
 =?utf-8?B?RzBKOW9iWDJCVDFEOHhUd2IxbitYdU94WDZtU1kvTmVXTUxqWWxRS2E4dUxh?=
 =?utf-8?B?anArdWVnUGJ1b0RUejJkYXNuay9sY1pjYjI5UHZNaGNxdVVQVVlpeEhNaXRH?=
 =?utf-8?Q?Jo/BpxCf5Xgrvw6pcQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR12MB8513.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65f27af-7450-4734-8116-08dec205ab2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 06:51:13.5601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eoAWB0Y5IWkxdux8/zFAv7fKUObr90GclOLiHJkpD0S48rHYe1ahfbJ2kA6Y8FLN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295062-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:regressions@leemhuis.info,m:Shyam-sundar.S-k@amd.com,m:kuba@kernel.org,m:Madhu.Banavara@amd.com,m:patrick.oppenlander@gmail.com,m:netdev@vger.kernel.org,m:regressions@lists.linux.dev,m:patrickoppenlander@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[PrashanthKumar.K.R@amd.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[PrashanthKumar.K.R@amd.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,leemhuis.info:email,linux.dev:email,amd.com:dkim,amd.com:from_mime,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88A5563D5EF

QU1EIEdlbmVyYWwNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFRob3JzdGVu
IExlZW1odWlzIDxyZWdyZXNzaW9uc0BsZWVtaHVpcy5pbmZvPg0KU2VudDogV2VkbmVzZGF5LCBK
dW5lIDMsIDIwMjYgMzo1NyBQTQ0KVG86IFMtaywgU2h5YW0tc3VuZGFyIDxTaHlhbS1zdW5kYXIu
Uy1rQGFtZC5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgSy5SLCBQcmFz
aGFudGggS3VtYXIgPFByYXNoYW50aEt1bWFyLksuUkBhbWQuY29tPjsgQmFuYXZhcmEsIE1hZGh1
IDxNYWRodS5CYW5hdmFyYUBhbWQuY29tPg0KQ2M6IFBhdHJpY2sgT3BwZW5sYW5kZXIgPHBhdHJp
Y2sub3BwZW5sYW5kZXJAZ21haWwuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgTGludXgg
a2VybmVsIHJlZ3Jlc3Npb25zIGxpc3QgPHJlZ3Jlc3Npb25zQGxpc3RzLmxpbnV4LmRldj4NClN1
YmplY3Q6IFJlOiBDTDM3IGF1dG9uZWdvdGlhdGlvbiBub3Qgd29ya2luZyBvbiBhbWQteGdiZQ0K
DQpDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJj
ZS4gVXNlIHByb3BlciBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcg
bGlua3MsIG9yIHJlc3BvbmRpbmcuDQoNCg0KT24gNS82LzI2IDA1OjU1LCBTaHlhbSBTdW5kYXIg
UyBLIHdyb3RlOg0KPiBPbiA0LzI4LzIwMjYgMDQ6NTgsIEpha3ViIEtpY2luc2tpIHdyb3RlOg0K
Pj4gT24gVGh1LCAyMyBBcHIgMjAyNiAxMDoxODo0OSArMTAwMCBQYXRyaWNrIE9wcGVubGFuZGVy
IHdyb3RlOg0KPj4+IEEgcmVjZW50IGNoYW5nZSBbMV0NCg0KRldJVywgdGhhdCB3YXMgNDJmZDQz
MmZlNmQzMjAgKCJhbWQteGdiZTogYWxpZ24gQ0wzNyBBTiBzZXF1ZW5jZSBhcyBwZXINCmRhdGFi
b29rIikgW3Y2LjE2LXJjNV0NCg0KPj4+IHN0b3BwZWQgQ0wzNyBhdXRvbmVnb3RpYXRpb24gZnJv
bSB3b3JraW5nIG9uIGFtZC14Z2JlIGhhcmR3YXJlLg0KPj4NCj4+IEhpIFJhanUhIEFyZSB5b3Ug
bG9va2luZyBpbnRvIHRoaXMgcmVwb3J0Pw0KPg0KPiBEcm9wcGluZyBSYWp1IGFzIGhlIGlzIG5v
IGxvbmdlciB3aXRoIEFNRC4NCj4NCj4gVGhhbmtzIGZvciB0aGUgYnVnIHJlcG9ydC4gUHJhc2hh
bnRoIHdpbGwgbWFpbnRhaW4gdGhpcyBkcml2ZXIgZ29pbmcNCj4gZm9yd2FyZC4NCj4NCj4gUHJh
c2hhbnRoLCBjYW4geW91IGFkZHJlc3MgdGhpcyBidWc/IEFsc28sIHBsZWFzZSB1cGRhdGUgdGhl
DQo+IE1BSU5UQUlORVJTIGxpc3QgYnkgZHJvcHBpbmcgUmFqdSdzIG5hbWUuDQpBbnkgcHJvZ3Jl
c3M/IEl0IGxvb2tzIGxpa2Ugbm90aGluZyBoYXBwZW5lZCB0byBmaXggdGhpcyByZWdyZXNzaW9u
IHNpbmNlIGFib3ZlIG1haWwsIGJ1dCBJJ20gbG9va2luZyBhdCB0aGluZ3MgZnJvbSB0aGUgb3V0
c2lkZSBhbmQgdGhlcmUgaXQncyBlYXN5IHRvIG1pc3Mgc29tZXRoaW5nLCBzbyBwbGVhc2UgdGVs
bCBtZSBpZiB0aGF0J3MgdGhlIGNhc2UuDQoNCkNpYW8sIFRob3JzdGVuDQoNClRoYW5rcyBmb3Ig
dGhlIGZvbGxvdy11cC4NCkEgZml4IGhhcyBiZWVuIGlkZW50aWZpZWQgYW5kIGEgcGF0Y2ggaXMg
cHJlcGFyZWQuIFdlIGFyZSBjdXJyZW50bHkgcnVubmluZyByZWdyZXNzaW9uIHRlc3RpbmcgdG8g
ZW5zdXJlIHRoZSBmaXggZG9lcyBub3QgaW50cm9kdWNlIGFueSB1bmludGVuZGVkIGlzc3Vlcy4g
V2Ugd2lsbCBzaGFyZSB0aGUgcGF0Y2ggb24gdGhlIG1haWxpbmcgbGlzdCBvbmNlIHJlZ3Jlc3Np
b24gdmFsaWRhdGlvbiBpcyBjb21wbGV0ZS4NCg0KVGhhbmtzIGZvciB5b3VyIHBhdGllbmNlLg0K
DQpSZWdhcmRzLA0KUHJhc2hhbnRoDQoNCuKchSBZb3UgY2FuIHVzZSB0aGlzIGRyYWZ0IGRpcmVj
dGx5IGluIE91dGxvb2sgYW5kIHR3ZWFrIHRvbmUgaWYgbmVlZGVkIChlLmcuLCBtb3JlIHRlY2hu
aWNhbCBkZXRhaWwgb3IgYWRkaW5nIGNvbW1pdCByZWZlcmVuY2UpLg0K

