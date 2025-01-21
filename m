Return-Path: <netdev+bounces-160093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBCCA181B1
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 17:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B016016870F
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 16:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9151925AF;
	Tue, 21 Jan 2025 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eaton.com header.i=@eaton.com header.b="erJdQvlG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F91C36;
	Tue, 21 Jan 2025 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737475770; cv=fail; b=XQIPooJOLrsD/1Sp4whLZkwOUdLdIj6+ffhuSAUjtAdXRmQBbdyCJHr+rB4r2jY4WsByX3GQ7rm2JlmYkv8leuf2HBFgWkQmybWf7KSbnlH0pwETCmHOc0MEs5SUh7qqjKW+8B2Nk7CBV61RqckRNd5S/6YrX2qUI0daD7yvmHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737475770; c=relaxed/simple;
	bh=h6cBoUjIv74INWbpE0bkWLtJjvdUtcoBHet9+ogk7m4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WyNMhShA6z+Pu8aF657W29c1vX5FZz3Nl/MYtNcKaUxeMx1adLMyCyzW64+2AFscYsM0SyUyLCeePisaxjObyJ8h87CAJkd+v9gg6ij4r1OdDcYTi0gGw5NORfUsirDMj7ON6jvNOqx4wC5P/LfEsItx3Ta4y8wI6pVuPo+NN6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eaton.com; spf=pass smtp.mailfrom=eaton.com; dkim=pass (2048-bit key) header.d=eaton.com header.i=@eaton.com header.b=erJdQvlG; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eaton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eaton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZVobzfgzxLld/Z88r58hNWVEkdkTJREDZpOLH6VadoYOWR04Xa/VfivUGn6wv5xKIX3jAB87WDZiImMkp1ZWusZW2jM0iIrvGR7lnf2T7ketavnNP1jjHOsxtMitplvX0zM9XHKZiNKr9DbySbHeXmp6TVxUsWkERc48QViCpmDlsX/t/ueFClJuKOD/ys+mdnEf5u5QqgR7MexihkbZa/PlJiQnTId8H1D+vU973fsfNO4ihjxor58L5UVSiRvLL7eyKcq6hl3p2n5bWGj4h5e5VpJCDPspYiEH9vyT8+2BzR+QDABEoWnevqTbEyUTRtMCzgVqrCEstgB/xZaVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6cBoUjIv74INWbpE0bkWLtJjvdUtcoBHet9+ogk7m4=;
 b=TWzWwwEveOX0N5XH20kO2sVZLlvw+giIJPG8pZNZ2URXsV7r5UDlo3IFxIy7Kc4+DR6iPlc/FW0kIbFigr18BBxiWyuxhbEdMSbeqCcMU23AGDPXO9kb5AeX5CaawQjyFpaGf9H9MgER7jVLXUIVpehWp5doxryB6NOHuKoCBeK8W3BynpQFWvwVx5EdaSVD1nt/qxDsAvSilGWGQF18cMkZ9C7Homio1O6u40KJG5/LgPJkibCkAOx5Ys3kAUyAXEtR3gpIBO0DmSBjxSywd0GppCf2iocBz19QOyaL14WU24XdhfJ7mTfR7mf+2i/P3I7zppCfqPsMa64LPFZ2Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eaton.com; dmarc=pass action=none header.from=eaton.com;
 dkim=pass header.d=eaton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eaton.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6cBoUjIv74INWbpE0bkWLtJjvdUtcoBHet9+ogk7m4=;
 b=erJdQvlGC4gc3A5dCm/Td61qZt2p6hMkZOfUp7mCx/9Kbzo4Tj58WQd+xTY6j/pBO7nxJtYx3ocpRZaV7hvaitXOm0t+nxsPs1f/jP7t+dvGTBF4QKJ1I25hyCpqeUMSKpB9HD8a0DQaubJMss5Fgm6J3p5/jpcAcPqmHKhPTBUcJxpEQFY7KdAJR0aQkjD5Wmc/9hXfz3oNlWgpuHJWFkdCUehAntcnXMR44HNGJtDA27kUCNh7m35k99RuP4jJLVZebYUdPRFliL0/R1enV9vXdwkM8gd0oPz8GpVb1wQEel7JUPQPdrqlzseJTH864jW8q/F5fTB8qGfqjOlgGA==
Received: from DM4PR17MB5969.namprd17.prod.outlook.com (2603:10b6:8:50::17) by
 LV3PR17MB7343.namprd17.prod.outlook.com (2603:10b6:408:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 16:09:24 +0000
Received: from DM4PR17MB5969.namprd17.prod.outlook.com
 ([fe80::f770:8bd1:1aab:b84f]) by DM4PR17MB5969.namprd17.prod.outlook.com
 ([fe80::f770:8bd1:1aab:b84f%4]) with mapi id 15.20.8356.017; Tue, 21 Jan 2025
 16:09:24 +0000
From: "Badel, Laurent" <LaurentBadel@eaton.com>
To: =?utf-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>, Jakub Kicinski
	<kuba@kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: RE: [EXTERNAL] [PATCH] net: fec: Refactor MAC reset to function
Thread-Topic: [EXTERNAL] [PATCH] net: fec: Refactor MAC reset to function
Thread-Index: AQHba/DafTAj29fCA0SAXRpQB0Dq3bMhZPsA
Date: Tue, 21 Jan 2025 16:09:23 +0000
Message-ID:
 <DM4PR17MB5969CC2A8D074890B695AF2ADFE62@DM4PR17MB5969.namprd17.prod.outlook.com>
References: <20250121103857.12007-3-csokas.bence@prolan.hu>
In-Reply-To: <20250121103857.12007-3-csokas.bence@prolan.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_ActionId=6e15eea4-184d-4ba7-b5f1-c9b29eea1eb6;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_ContentBits=0;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Enabled=true;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Method=Standard;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Name=Eaton
 Internal Only
 (IP2);MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_SetDate=2025-01-21T16:06:29Z;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_SiteId=d6525c95-b906-431a-b926-e9b51ba43cc4;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eaton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR17MB5969:EE_|LV3PR17MB7343:EE_
x-ms-office365-filtering-correlation-id: 47a95604-2f02-41ff-7727-08dd3a35f8e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SzNjRzhXZG13YS9YSElkOHFTTGRUbmpjbWplUHF3NTNPWWlyZmpBeDBPMVhJ?=
 =?utf-8?B?UCtUVXU4OTRORkVVdSszWVRoUnVpZUNnK1p6cCtzQjR0dExIL2EycERSYW1F?=
 =?utf-8?B?emtYamlHeVVEd3hJVER1SjVXdDBaSXpacVJtMUtaQTFoNzVzdDFkS3U5c2JM?=
 =?utf-8?B?bE9ZNDljcVdqZ25VUDJGRyt5akxSUGNQL2Nxa29JanlhMlViL05qMHNzL3RZ?=
 =?utf-8?B?aUljOEpFVHgra1piNkd5SHExUG9HOHpmdFQ1RXhwSkR3Q0hHUml2ZC90WHlv?=
 =?utf-8?B?QUNrS1ZwOGpLSURpd0NoNUpjVEc2cjZnaTZoQkdMcnRCOUZMbnFzUDZReUZx?=
 =?utf-8?B?RlRub25UVjNlamE0a0haL0VWc3U0QVBoTHlCVFo3cTFuaGNDSmVVWUYvcHZa?=
 =?utf-8?B?Y2VZWVNNQmlYS0hkOTJzeWZDZDhjQkJEWm1JdmpWUUgxbnhHRTBqSWtyaGE4?=
 =?utf-8?B?UEVBWnhCK0JUVWVUMjJCeGxyMEZQN0NZSi80djV3ckFpTnZabzk3bE5mZGk4?=
 =?utf-8?B?Q1F1MGN3eVg3ZC9aa29semIzczdlbDkzZmZENkZFK0lxS2pUT3JBMW9UTHdK?=
 =?utf-8?B?bncyeHg4QnhnMVdHWEtNSFRLTzFZTFYzQTdRT3hSZFlBbnZhQm5jTWNmVzI3?=
 =?utf-8?B?SDh4am5WWUx4amY4ZXdtLzhtK1VVZkV3Znl5WWJkWFU2UEUwZ3psWDJMVVds?=
 =?utf-8?B?N2FvSDdLbFhvejgyUHhaUzJ5RHVVT0Y2MGcrMVNhTzErTk9CcnFCUjBLTWRz?=
 =?utf-8?B?QmRBUzJ5Wm9oWTdIajJzRnZvaHplNC8yRnlXQTdRVTQxcXcyUlFOOElabFcx?=
 =?utf-8?B?R2pvN0xXSGh2TzhkSDFKZEhucHV1ZDBPN1FnMmVnNXdzdThNZ01oU1NhS243?=
 =?utf-8?B?RGpLYWVUM1hrSldrcFVFNEVGNVVNTC9xMHpUdzgzS0gyeExNaUw5MWRsL2Uw?=
 =?utf-8?B?bzRxM3A1OHVKZVI4UGpFZVVwVUFoTm1iVk9LYjVXU1B3bjl4ZGRUeXNzOTBx?=
 =?utf-8?B?bWlLWlA4YnQxNjlxUnluM054U0NJYVYvZ1AxUXpDM1lqODZZRS8ybTFYTW9B?=
 =?utf-8?B?Q0dDWllUMDdtK3hMbkFwU1NUcll0cFpleDJabnlMWVRCN1dGQ1hvQndaREpj?=
 =?utf-8?B?N2FMYXI5NTJUZVF5SVFZTTF0SmtkMEVUZFBnc3A0bSthZFFkZ0d4N01LNkpx?=
 =?utf-8?B?eUtmVFo2V2FHUmZiZDJKTFdIWENyYko3ZGdIZnpQQmFENDNPSWZsMzZIMFpP?=
 =?utf-8?B?d1FMd0NZNC9SYm8zWjVCTllUdDBVcXFYSTJRNWNzenhJRW82L0VsbnFDRHRn?=
 =?utf-8?B?ZmVTT3pjdFhKSUU0L1QwL3ZBY1Ixa0VGV0FJRmlRWDhYNFNteld4SEtsOVhF?=
 =?utf-8?B?Qmk0QTlwZWdDbmpCVEFOZm56RElsdnV0d01IUmdsYmJCT2x2SFMreXFVRWc0?=
 =?utf-8?B?Qnp4SDIzSytIeWdqTnBqaytiRmw1eFVuZklYOGJVN2N0MGsrQ1BkUHB4TjNP?=
 =?utf-8?B?ejM1VyszVy82Y05FUldROHpXNmZBREZ0emZscVBiQjFCcnpuMzMvMUk0Y3pG?=
 =?utf-8?B?K2hRblpUUnIxbmtLck1BVFVmcVZwcVBBRElGWW9lUGpYK1I0Y1d6UmtFcXVI?=
 =?utf-8?B?MHRkR2RNaTZMdmxrNTVqdW95TjltN0UvUDJnSXZjMnRSUisyVXhtVUNjUDFn?=
 =?utf-8?B?dkFzam91RFVMMEtjNWllNkZvR3pZWlBxcEZZdXdZSjhPNE91aGRpbjM2VGgz?=
 =?utf-8?B?eFFFQmRzZ29rNFppbGh6Q1BjNGJPalJMck84UmQ4cEZRYWtUbmlSSGwvOGFR?=
 =?utf-8?B?dk1VQTl1akVFSHphLzdTcndNdlZUbTB0Qm5hZDBVdWFWRTFoK0Jvbk8yNDB6?=
 =?utf-8?B?dVVTV3VtL1VhcnZDUmlUZ1QxQ3NyeitOcVVCMHNrRnpRV1RFd3pTRzVZSWVG?=
 =?utf-8?Q?jucIczXZw1ii4lzAicfKmaudLhbzLLei?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR17MB5969.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cW1MVlk0VnNFWjMzcnVCRE13Q2hzWDVZbWg4V1hXZXV4aHB6Qll2L2N4MVdr?=
 =?utf-8?B?bFdScml5Y201U0xCcXlRcndaajNhMUoyR3JOTHBodEM5d0ZKK1JQeVdJc1RN?=
 =?utf-8?B?TUswUEVhbGRxOW1Dc1oxTDcrZGJzTWdJZ2FzejZYeHI1OUNpVTV5K1R2VGNj?=
 =?utf-8?B?R0JpTFFQV3NvaGdqc3MzUDkvZVMzQWRsZEdlbENTWlpoSG11U3JQdXV1cEVB?=
 =?utf-8?B?YTBTNnhOTmJ0MmpsMytBREljK2VhRjVKSUY0OXVEWkxzR1h5bHlXL3FMYk9y?=
 =?utf-8?B?ekIzd3RZYjNsb0FrbVhHb20xMzdEWlVxQm8wUlVIZkdLOGFZY0VHRU52OVRN?=
 =?utf-8?B?WUFyTmR0SWZtMmtuQU42ZWNCZno1eTQvMXBWS0NCTE1TSUM2VVRDZ1ZUNmpZ?=
 =?utf-8?B?UmJkeVF2eUM4YmJ0SUZ1SndpTDFkNWpjS3JtTFlRVDBVSVF5YXJYVURQcEIv?=
 =?utf-8?B?OW0vekNPV2R2MVJIVUxGRW5sRVAvSjBIb0Y3L1FxWS9GMWpCQ2N5cWRVMkZC?=
 =?utf-8?B?dkdNa3gzcitPRWVDQmc5RlQxMXVOQ1d2T0k4VnhZM2k3M0xEejJhWlRkL1hC?=
 =?utf-8?B?d2YrUFdEb1hlai9xODR0V3RFWlI2QVdoWVRTRi9td0t2TnM2S2l5MHlNRldK?=
 =?utf-8?B?YVFoWDMxdk12T2h4eWJGdzVqSzFLU0hWc1MzMWVaYis4OG5qeE1hQVN4alNF?=
 =?utf-8?B?NjFQVkJWQ0ZtWGI2ZUhwWUo0VmhvV0NTRzNPSHN1MiswbFIzaW9YQnJCWWNw?=
 =?utf-8?B?LzByRU5BQ2dMdzU1cFgrajd4M0NKK3NVaHYwRnhXR3hMeHdTcWZJZWd4WHR6?=
 =?utf-8?B?YWxZcEZRcmRGRFo3QnhzNEVtNkg2aVB1M0IwcTVEZDZLUUNtTkh4VXZTcFl0?=
 =?utf-8?B?U0p4YVhMMER3RWhBT2w3aHNxRnRudVJxdXo2aXZQSUd0WkhzbmNleU5nTnQ3?=
 =?utf-8?B?YXBsRGIvSTdLenRsTDd0Y21zQjFrS1RRcDhJUFkwazhoUDh2U0tFUHZpR1FH?=
 =?utf-8?B?MWpUeHBzTllVcThMT01aQXY2YTdpTVNNQzRyZm43bHl5eXpoY1ZjM3QrRnNj?=
 =?utf-8?B?QXI3YTdBSm42Z0ViVFVRaVBCeUxvdSthTUFyb0YwdkhRZjVCNXdkbU90TkJO?=
 =?utf-8?B?MDBIU1BFMUFtZklkY0k1L2hpU214cEN3empJbHA0ejFOZ09WWWd2OWhlOGx5?=
 =?utf-8?B?SDFSWkdLMlF4TXJjNkF3NG5YWWdYMlZ5anlNdit1czVySWxFMDJ6b0x4WlQy?=
 =?utf-8?B?RWFFWTdEWGhPOTFDQ3RVdHlhNklFWHl4Y3FLbUFmZXBwZ0xBaWQ2ck9NZEdJ?=
 =?utf-8?B?ZFVPNGpzTHFuUC80YWZpZWZLN0FwRXVLc2ZCRzhVQ1JsdVluTG8rV1RjRE5h?=
 =?utf-8?B?NnlmL2R3dkQwZThGRVl3UUNJSDVhWk9SY3FkczRXM3k2ajJyQk9ueUlZRGZ0?=
 =?utf-8?B?RmswdHdzSE5CWjNtMEQ1dEc5b1dtSDRyU3hGSXR4UkFZTWtkNk16VFdqZkI3?=
 =?utf-8?B?S2t1Y014MHQ4SXBZTldTM05KQ0ZlMFhWbXNXdnAva1pzZ04vTEtvdk82dGY0?=
 =?utf-8?B?V0FYYWdBcmdYYVVYNVM1WEYxbGZVRjZWaHRFd2krRjI5NmkwajlCR2tTcGJS?=
 =?utf-8?B?aW9GSFBBMmphbkpkb3dSYVJubWQwNG1yREpQeWFrSFNibFlldC9YN3FXelB3?=
 =?utf-8?B?NFNjcHRkamk2dlFQK2szNHhCVE5OY3JreUEyNUhZam5BNlNLbmpyQlFlcnc4?=
 =?utf-8?B?ejVtTW92OGltaUlUTnBWa01GSHFtaElnZkNiaE5VZ1A1Z3E0bVpza2FsUVg3?=
 =?utf-8?B?dHFRK1ZmZWxERFNibWpiREZOSmRRWXRRS3FyY1FVVGU0NTFjOUZVWDJFbzJB?=
 =?utf-8?B?YlZiaTd6UFpZOTY2aitCT0NXNmJ4TzFUbk9Qei9ZOUpVM1I2V2Y2b25pNlpq?=
 =?utf-8?B?akxBc1VGOWdZanFtenJnaTBzWG9zL2ROalorQzFrcWg3UUZaVDFDcHZxUXVZ?=
 =?utf-8?B?aUhqbGhNSEx4WTIzaW5rdjhTWDk4NnA3YkY5SUQzblhRWGhudXBXaWs5NVQr?=
 =?utf-8?B?ZTZkZ3VEYk1IMC96SW9FVGg1N1QwcUhqaWlpRTNXVStPbndTSWlITndJQjYz?=
 =?utf-8?Q?qIUyyt0HFlj/Y8sGTzdjr6214?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: eaton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR17MB5969.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a95604-2f02-41ff-7727-08dd3a35f8e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 16:09:23.9289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6525c95-b906-431a-b926-e9b51ba43cc4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aGZ9iyEHv64gCgQ/QvUV09PJScRdvmwP9IgbbjIG4zaNP+4dxHcowxmqU9xiRvz+dwgQlrpUn2Cx/+vH0RcEgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR17MB7343

SGkgQmVuY2UgYW5kIHRoYW5rcyBmb3IgdGhlIHBhdGNoLg0KDQpMZWF2aW5nIG91dCB0aGUgY2hl
Y2sgZm9yIEZFQ19RVUlSS19OT19IQVJEX1JFU0VUIGluIGZlY19zdG9wKCkgd2FzLCBpbiBmYWN0
LA0Kbm90IHVuaW50ZW50aW9uYWwuIEFsdGhvdWdoIGEgaGFyZCByZXNldCBpbiBmZWNfcmVzdGFy
dCgpIGNhdXNlZCBsaW5rIGlzc3Vlcw0Kd2l0aCB0aGUgaU1YMjgsIEkgaGFkIG5vIHBhcnRpY3Vs
YXIgcmVhc29uIHRvIGJlbGlldmUgdGhhdCBpdCB3b3VsZCBhbHNvIGNhdXNlDQppc3N1ZXMgaW4g
ZmVjX3N0b3AoKSwgc2luY2UgYXQgdGhpcyBwb2ludCB5b3UncmUgdHVybmluZyBvZmYgdGhlIGlu
dGVyZmFjZSwgYW5kDQpJIGRpZCBub3Qgb2JzZXJ2ZSBhbnkgcGFydGljdWxhciBwcm9ibGVtcyBl
aXRoZXIsIHNvIEkgZGlkIG5vdCB0aGluayB0aGUgc2FtZQ0KbW9kaWZpY2F0aW9uIHdhcyB3YXJy
YW50ZWQgdGhlcmUuDQoNCklmIHlvdSBoYXZlIHJlYXNvbiB0byBiZWxpZXZlIHRoYXQgdGhpcyBp
cyBhIGJ1ZywgdGhlbiBpdCBzaG91bGQgYmUgZml4ZWQsIGJ1dA0KY3VycmVudGx5IEkgZG9uJ3Qg
c2VlIHdoeSB0aGlzIGlzIHRoZSBjYXNlIGhlcmUuIEkgdGhpbmsgYSByZWZhY3RvcmluZyANCmR1
cGxpY2F0ZWQgY29kZSBpcyBhIGdvb2QgaWRlYSwgYnV0IHNpbmNlIGl0IGFsc28gaW5jbHVkZXMg
YSBtb2RpZmljYXRpb24gb2YgDQp0aGUgYmVoYXZpb3IgKHNwZWNpZmljYWxseSwgdGhlcmUgaXMg
YSBwb3NzaWJsZSBwYXRoIHdoZXJlIA0KRkVDX1FVSVJLX05PX0hBUkRfUkVTRVQgaXMgc2V0IGFu
ZCB0aGUgbGluayBpcyB1cCwgd2hlcmUgZmVjX3N0b3AoKSB3aWxsIGlzc3VlDQphIHNvZnQgcmVz
ZXQgaW5zdGVhZCBvZiBhIGhhcmQgcmVzZXQpLCBJIHdvdWxkIHByZWZlciB0byBrbm93IHRoYXQg
dGhpcyBjaGFuZ2UNCmlzIGluZGVlZCBuZWNlc3NhcnkuIA0KDQpJZiBvdGhlcnMgZGlzYWdyZWUg
YW5kIHRoZXJlJ3MgYSBjb25zZW5zdXMgdGhhdCB0aGlzIGNoYW5nZSBpcyBvaywgSSdtIGhhcHB5
IA0KZm9yIHRoZSBwYXRjaCB0byBnZXQgdGhyb3VnaCwgYnV0IEkgdGVuZCB0byBlcnIgb24gdGhl
IHNpZGUgb2YgY2F1dGlvbiBpbiBzdWNoDQpjYXNlcy4NCg0KQW4gYWRkaXRpb25hbCBjb21tZW50
IC0gdGhpcyBpcyBqdXN0IG15IHBlcnNvbmFsIG9waW5pb24gLSBidXQgaW4NCmZlY19jdHJsX3Jl
c2V0KCksIGl0IHNlZW1zIHRvIG1lIHRoYXQgdGhlIGZ1bmN0aW9uIG9mIHRoZSB3b2wgYXJndW1l
bnQgcmVhbGx5DQppcyB0byBkaXN0aW5ndWlzaCBpZiB3ZSdyZSB1c2luZyB0aGUgZmVjX3Jlc3Rh
cnQoKSBvciB0aGUgZmVjX3N0b3AoKQ0KaW1wbGVtZW50YXRpb24sIHNvIEkgdGhpbmsgdGhlIG5h
bWluZyBtYXkgYmUgYSBiaXQgbWlzbGVhZGluZyBpbiB0aGlzIGNhc2UuDQoNCkJlc3QgcmVnYXJk
cywNCg0KTGF1cmVudA0KDQpPbiBUdWUsIEphbiAyMSwgMjAyNSBhdCAxMTozODo1OEFNICswMTAw
LCBDc8Oza8OhcywgQmVuY2Ugd3JvdGU6DQo+IFRoZSBjb3JlIGlzIHJlc2V0IGJvdGggaW4gYGZl
Y19yZXN0YXJ0KClgIChjYWxsZWQgb24gbGluay11cCkgYW5kIA0KPiBgZmVjX3N0b3AoKWAgKGdv
aW5nIHRvIHNsZWVwLCBkcml2ZXIgcmVtb3ZlIGV0Yy4pLg0KPiBUaGVzZSB0d28gZnVuY3Rpb25z
IGhhZCB0aGVpciBzZXBhcmF0ZSBpbXBsZW1lbnRhdGlvbnMsIHdoaWNoIHdhcyBhdCANCj4gZmly
c3Qgb25seSBhIHJlZ2lzdGVyIHdyaXRlIGFuZCBhIGB1ZGVsYXkoKWAgKGFuZCB0aGUgYWNjb21w
YW55aW5nIA0KPiBibG9jayBjb21tZW50KS4NCj4gSG93ZXZlciwgc2luY2UgdGhlbiB3ZSBnb3Qg
c29mdC1yZXNldA0KPiAoTUFDIGRpc2FibGUpIGFuZCBXYWtlLW9uLUxBTiBzdXBwb3J0LCB3aGlj
aCBtZWFudCB0aGF0IHRoZXNlIA0KPiBpbXBsZW1lbnRhdGlvbnMgZGl2ZXJnZWQsIG9mdGVuIGNh
dXNpbmcgYnVncy4gRm9yIGluc3RhbmNlLCBhcyBvZiBub3csIA0KPiBgZmVjX3N0b3AoKWAgZG9l
cyBub3QgY2hlY2sgZm9yIGBGRUNfUVVJUktfTk9fSEFSRF9SRVNFVGAuIFRvIA0KPiBlbGltaW5h
dGUgdGhpcyBidWctc291cmNlLCByZWZhY3RvciBpbXBsZW1lbnRhdGlvbiB0byBhIGNvbW1vbiAN
Cj4gZnVuY3Rpb24uDQo+DQo+IEZpeGVzOiBjNzMwYWI0MjNiZmEgKCJuZXQ6IGZlYzogRml4IHRl
bXBvcmFyeSBSTUlJIGNsb2NrIHJlc2V0IG9uIGxpbmsgDQo+IHVwIikNCj4gU2lnbmVkLW9mZi1i
eTogQ3PDs2vDoXMsIEJlbmNlIDxjc29rYXMuYmVuY2VAcHJvbGFuLmh1Pg0KPiAtLS0NCj4NCj4g
Tm90ZXM6DQo+ICAgICBSZWNvbW1lbmRlZCBvcHRpb25zIGZvciB0aGlzIHBhdGNoOg0KPiAgICAg
YC0tY29sb3ItbW92ZWQgLS1jb2xvci1tb3ZlZC13cz1hbGxvdy1pbmRlbnRhdGlvbi1jaGFuZ2Vg
DQo+DQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYyB8IDUwIA0K
PiArKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlv
bnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMgDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJl
ZXNjYWxlL2ZlY19tYWluLmMNCj4gaW5kZXggNjg3MjU1MDZhMDk1Li44NTBlZjNkZTc0ZWMgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+
ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IEBAIC0x
MDY0LDYgKzEwNjQsMjcgQEAgc3RhdGljIHZvaWQgZmVjX2VuZXRfZW5hYmxlX3Jpbmcoc3RydWN0
IG5ldF9kZXZpY2UgKm5kZXYpDQo+ICAgICAgIH0NCj4gIH0NCj4NCj4gKy8qIFdoYWNrIGEgcmVz
ZXQuICBXZSBzaG91bGQgd2FpdCBmb3IgdGhpcy4NCj4gKyAqIEZvciBpLk1YNlNYIFNPQywgZW5l
dCB1c2UgQVhJIGJ1cywgd2UgdXNlIGRpc2FibGUgTUFDDQo+ICsgKiBpbnN0ZWFkIG9mIHJlc2V0
IE1BQyBpdHNlbGYuDQo+ICsgKi8NCj4gK3N0YXRpYyB2b2lkIGZlY19jdHJsX3Jlc2V0KHN0cnVj
dCBmZWNfZW5ldF9wcml2YXRlICpmZXAsIGJvb2wgd29sKSB7DQo+ICsgICAgIGlmICghd29sIHx8
ICEoZmVwLT53b2xfZmxhZyAmIEZFQ19XT0xfRkxBR19TTEVFUF9PTikpIHsNCj4gKyAgICAgICAg
ICAgICBpZiAoZmVwLT5xdWlya3MgJiBGRUNfUVVJUktfSEFTX01VTFRJX1FVRVVFUyB8fA0KPiAr
ICAgICAgICAgICAgICAgICAoKGZlcC0+cXVpcmtzICYgRkVDX1FVSVJLX05PX0hBUkRfUkVTRVQp
ICYmIGZlcC0+bGluaykpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgIHdyaXRlbCgwLCBmZXAt
Pmh3cCArIEZFQ19FQ05UUkwpOw0KPiArICAgICAgICAgICAgIH0gZWxzZSB7DQo+ICsgICAgICAg
ICAgICAgICAgICAgICB3cml0ZWwoRkVDX0VDUl9SRVNFVCwgZmVwLT5od3AgKyBGRUNfRUNOVFJM
KTsNCj4gKyAgICAgICAgICAgICAgICAgICAgIHVkZWxheSgxMCk7DQo+ICsgICAgICAgICAgICAg
fQ0KPiArICAgICB9IGVsc2Ugew0KPiArICAgICAgICAgICAgIHZhbCA9IHJlYWRsKGZlcC0+aHdw
ICsgRkVDX0VDTlRSTCk7DQo+ICsgICAgICAgICAgICAgdmFsIHw9IChGRUNfRUNSX01BR0lDRU4g
fCBGRUNfRUNSX1NMRUVQKTsNCj4gKyAgICAgICAgICAgICB3cml0ZWwodmFsLCBmZXAtPmh3cCAr
IEZFQ19FQ05UUkwpOw0KPiArICAgICB9DQo+ICt9DQo+ICsNCj4gIC8qDQo+ICAgKiBUaGlzIGZ1
bmN0aW9uIGlzIGNhbGxlZCB0byBzdGFydCBvciByZXN0YXJ0IHRoZSBGRUMgZHVyaW5nIGEgbGlu
aw0KPiAgICogY2hhbmdlLCB0cmFuc21pdCB0aW1lb3V0LCBvciB0byByZWNvbmZpZ3VyZSB0aGUg
RkVDLiAgVGhlIG5ldHdvcmsgDQo+IEBAIC0xMDgwLDE3ICsxMTAxLDcgQEAgZmVjX3Jlc3RhcnQo
c3RydWN0IG5ldF9kZXZpY2UgKm5kZXYpDQo+ICAgICAgIGlmIChmZXAtPmJ1ZmRlc2NfZXgpDQo+
ICAgICAgICAgICAgICAgZmVjX3B0cF9zYXZlX3N0YXRlKGZlcCk7DQo+DQo+IC0gICAgIC8qIFdo
YWNrIGEgcmVzZXQuICBXZSBzaG91bGQgd2FpdCBmb3IgdGhpcy4NCj4gLSAgICAgICogRm9yIGku
TVg2U1ggU09DLCBlbmV0IHVzZSBBWEkgYnVzLCB3ZSB1c2UgZGlzYWJsZSBNQUMNCj4gLSAgICAg
ICogaW5zdGVhZCBvZiByZXNldCBNQUMgaXRzZWxmLg0KPiAtICAgICAgKi8NCj4gLSAgICAgaWYg
KGZlcC0+cXVpcmtzICYgRkVDX1FVSVJLX0hBU19NVUxUSV9RVUVVRVMgfHwNCj4gLSAgICAgICAg
ICgoZmVwLT5xdWlya3MgJiBGRUNfUVVJUktfTk9fSEFSRF9SRVNFVCkgJiYgZmVwLT5saW5rKSkg
ew0KPiAtICAgICAgICAgICAgIHdyaXRlbCgwLCBmZXAtPmh3cCArIEZFQ19FQ05UUkwpOw0KPiAt
ICAgICB9IGVsc2Ugew0KPiAtICAgICAgICAgICAgIHdyaXRlbCgxLCBmZXAtPmh3cCArIEZFQ19F
Q05UUkwpOw0KTml0LCBpbiBjYXNlIG9mIGEgbmVlZCBmb3IgdjIgeW91IGNhbiBtYXJrIGluIGNv
bW1pdCBtZXNzYWdlIHRoYXQgRkVDX0VDUl9SRVNFVCA9PSAxLCBzbyBkZWZpbmUgY2FuIGJlIHVz
ZSBpbnN0ZWFkIG9mIDEuDQoNCj4gLSAgICAgICAgICAgICB1ZGVsYXkoMTApOw0KPiAtICAgICB9
DQo+ICsgICAgIGZlY19jdHJsX3Jlc2V0KGZlcCwgZmFsc2UpOw0KPg0KPiAgICAgICAvKg0KPiAg
ICAgICAgKiBlbmV0LW1hYyByZXNldCB3aWxsIHJlc2V0IG1hYyBhZGRyZXNzIHJlZ2lzdGVycyB0
b28sIEBAIA0KPiAtMTM0NCwyMiArMTM1NSw3IEBAIGZlY19zdG9wKHN0cnVjdCBuZXRfZGV2aWNl
ICpuZGV2KQ0KPiAgICAgICBpZiAoZmVwLT5idWZkZXNjX2V4KQ0KPiAgICAgICAgICAgICAgIGZl
Y19wdHBfc2F2ZV9zdGF0ZShmZXApOw0KPg0KPiAtICAgICAvKiBXaGFjayBhIHJlc2V0LiAgV2Ug
c2hvdWxkIHdhaXQgZm9yIHRoaXMuDQo+IC0gICAgICAqIEZvciBpLk1YNlNYIFNPQywgZW5ldCB1
c2UgQVhJIGJ1cywgd2UgdXNlIGRpc2FibGUgTUFDDQo+IC0gICAgICAqIGluc3RlYWQgb2YgcmVz
ZXQgTUFDIGl0c2VsZi4NCj4gLSAgICAgICovDQo+IC0gICAgIGlmICghKGZlcC0+d29sX2ZsYWcg
JiBGRUNfV09MX0ZMQUdfU0xFRVBfT04pKSB7DQo+IC0gICAgICAgICAgICAgaWYgKGZlcC0+cXVp
cmtzICYgRkVDX1FVSVJLX0hBU19NVUxUSV9RVUVVRVMpIHsNCj4gLSAgICAgICAgICAgICAgICAg
ICAgIHdyaXRlbCgwLCBmZXAtPmh3cCArIEZFQ19FQ05UUkwpOw0KPiAtICAgICAgICAgICAgIH0g
ZWxzZSB7DQo+IC0gICAgICAgICAgICAgICAgICAgICB3cml0ZWwoRkVDX0VDUl9SRVNFVCwgZmVw
LT5od3AgKyBGRUNfRUNOVFJMKTsNCj4gLSAgICAgICAgICAgICAgICAgICAgIHVkZWxheSgxMCk7
DQo+IC0gICAgICAgICAgICAgfQ0KPiAtICAgICB9IGVsc2Ugew0KPiAtICAgICAgICAgICAgIHZh
bCA9IHJlYWRsKGZlcC0+aHdwICsgRkVDX0VDTlRSTCk7DQo+IC0gICAgICAgICAgICAgdmFsIHw9
IChGRUNfRUNSX01BR0lDRU4gfCBGRUNfRUNSX1NMRUVQKTsNCj4gLSAgICAgICAgICAgICB3cml0
ZWwodmFsLCBmZXAtPmh3cCArIEZFQ19FQ05UUkwpOw0KPiAtICAgICB9DQo+ICsgICAgIGZlY19j
dHJsX3Jlc2V0KGZlcCwgdHJ1ZSk7DQo+ICAgICAgIHdyaXRlbChmZXAtPnBoeV9zcGVlZCwgZmVw
LT5od3AgKyBGRUNfTUlJX1NQRUVEKTsNCj4gICAgICAgd3JpdGVsKEZFQ19ERUZBVUxUX0lNQVNL
LCBmZXAtPmh3cCArIEZFQ19JTUFTSyk7DQo+DQo+IC0tDQo+IDIuNDguMQ0KDQoNCg==

