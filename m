Return-Path: <netdev+bounces-174282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB11CA5E21F
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DDE0189DC1B
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 16:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E5024500F;
	Wed, 12 Mar 2025 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l6io7vg1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781DA16BE17;
	Wed, 12 Mar 2025 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798749; cv=fail; b=sDzfdzYjc/kFAhjPBdGhYf8lkJhbLNxxHLcg6UkZtLIiyjD1lNc7QhupHHVF9XASx5Ep5crtVVwpeNuuq42vboqz7p/Du16X6Sc8IMWDEqRIgk+kDMkX56pHaUSACMvSXo/z8H4sMbO+249ol/HFJwJeGIc7FBbnU579suXigZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798749; c=relaxed/simple;
	bh=zcmxxEuhjoECgDmqKFHIeQl6Hjv8jgRG8R8B8HFStQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fJHjDqknK/o++eQlbaZ0EH86a2y94/M3bSPcBidPZeaoF9UKGw1S8pf7bIn7g8Isyihw1vny1In4LJ8CFPKBhdoLUKpWiFAQQE8W9I09KnSLngLUbpPZw1KOHRNCRAMIdknQTcrIi5e0DGdXLzp5wvXOvAzDmlKlfJkam9YVFVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l6io7vg1; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=II0rtl+jitdJ5DBn7BweoJTPeXrmgfESftCKpl5Ye3pmc7Ag/ydZNZ1zGTqYFMfzDtI4Ip1gXBw5bY4oUh9oFixDqGl5T5/8ve8GlvAQKG2cJvBeqOTadfqu3X1BPKB+sLLwsG8QIZ+nLZo0wTpjYLrbM8m+INCKcue7tVrm41l3UKYyrRcUnosXUOMP76CRg5vO7tyWmKwFxQzXOqoxSEt8RfppS/9Luyu6uFCvfbaD7fDoHgPB5FH0pazue9Z9a55mGTpfhiO7SeHs7Tzm9CKjIyLZFQKiZKDgk+PKT9EkREGV+ll1p5eCpuxamiYzayxj548UeTvxkzcZDBzCpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcmxxEuhjoECgDmqKFHIeQl6Hjv8jgRG8R8B8HFStQ0=;
 b=oDukerasUcEcAnqT3x4SHl0gojWekBDiU/dd3BJ1PhYXp/ESXghdycoOErpUNKu1YYQa7kmHYMTR1jv/ILiw1vwGX2MDbV7TuPOKCEDjHhRUqaKbdDig7yn3LYCiSbIX/AqJyNO/5lgrx2KSP65qgpFPhFU4AeliDDRciONVL2bizZzQN45mWcUlQ0PbU3PXZMaBWzRp/LN/glGZrO5TYJm2hj4BEJiNeEzYFuyR4HqehiqPmcFJ3Dgi3+TQIE1+2gmuBkxk4eOXdWVgAw2GnGqGPaD0MvK6WwTmAOLL+frb4IJs3l4GBFEe1OCi3MX/cKWhoysVliKMK9uKFSsAiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcmxxEuhjoECgDmqKFHIeQl6Hjv8jgRG8R8B8HFStQ0=;
 b=l6io7vg1XU6Yg7lHVnAf3++02/W8ebEnfmbUFRsPrR5+Con+Fmgas3uRltwLHjsZrHw8i52MZIQuHZ46MzhR6jy3WpSrhVSziYdcStQb+w2D6HRjQHWrwwmedeodZKjwHX6PJcgYBUJt/5KR1y+p5Gf+XKEA1UVoUcWPzrqtUeo=
Received: from SA1PR12MB8163.namprd12.prod.outlook.com (2603:10b6:806:332::17)
 by DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 16:59:03 +0000
Received: from SA1PR12MB8163.namprd12.prod.outlook.com
 ([fe80::e117:c594:de73:377e]) by SA1PR12MB8163.namprd12.prod.outlook.com
 ([fe80::e117:c594:de73:377e%7]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 16:59:03 +0000
From: "Radharapu, Rakesh" <Rakesh.Radharapu@amd.com>
To: Paolo Abeni <pabeni@redhat.com>, "git (AMD-Xilinx)" <git@amd.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "kuniyu@amazon.com"
	<kuniyu@amazon.com>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Katakam,
 Harini" <harini.katakam@amd.com>, "Pandey, Radhey Shyam"
	<radhey.shyam.pandey@amd.com>, "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [RFC PATCH net-next] net: Modify CSUM capability check for USO
Thread-Topic: [RFC PATCH net-next] net: Modify CSUM capability check for USO
Thread-Index: AQHbk0V8Nixv4inzgEOOfy/Iu46E3bNvrRWAgAAKm6A=
Date: Wed, 12 Mar 2025 16:59:03 +0000
Message-ID:
 <SA1PR12MB81631C34BCAAA27CB25E271E9DD02@SA1PR12MB8163.namprd12.prod.outlook.com>
References: <20250312115400.773516-1-rakesh.radharapu@amd.com>
 <0b1cdac7-662a-4e27-b8b0-836cdba1d460@redhat.com>
In-Reply-To: <0b1cdac7-662a-4e27-b8b0-836cdba1d460@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4d098b4f-7c89-4c35-b8ee-07f003b800b8;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-12T16:52:19Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8163:EE_|DS0PR12MB6654:EE_
x-ms-office365-filtering-correlation-id: d16dd58f-bef6-4b74-3624-08dd61873176
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGFHRkxRcXNraFEydmFqYU5zN1BvdlBtakl3VVhMYUNQZDBQUG9RN0tMMXdv?=
 =?utf-8?B?TEdjMG1sQmZpYUtnRm44ak1HaHVIemF0am91UmdVck43cGp5R0NweTRCUUFq?=
 =?utf-8?B?UlFWVGpNTnp5ZGFvcDRoRXNHRm4rSjE4eVpMU0dCTTRzZDJXOFBDNjJGL2Iv?=
 =?utf-8?B?aUE4bXBmTEFOWHNvWXN4MEQxMmUyWkRMY25XL21wM2VqNFdUTCszZndXZmlz?=
 =?utf-8?B?b1RkV2RVQUZZcUtaMkxmcTFFMndRMXlLdngyTm9TeFluZk9Nb3lPcXVPcEky?=
 =?utf-8?B?UVF2R01WalFsQm41SEFPSkQ1eU96NXJadFZTQ3hldERWaE9QTnVFa2F1WG9P?=
 =?utf-8?B?NVN3RThtRllJNEozN0tnUnBldjNUcVlDdjJVTERQbHJia1BQcjZ3OExBMndB?=
 =?utf-8?B?cHlxWFdqdXVTNnNKQmx2NXNYOWJEQjFwTVBmMW1sN3diWHdOVkxhS0JPUjRZ?=
 =?utf-8?B?dWRFWk1sdzhvekR1YUsxOTZPalI5dkpaK3BhS0M3SzNxbXA4WFE5cFRzNDRq?=
 =?utf-8?B?ZlNpNm1oOWRqdFlHOEQ3V2krWXhZVXNsM0REMGM4WUcrclFBK3dBNGdoZjhF?=
 =?utf-8?B?MHAxV2ltVVh0cThEQXpydnhSa0dVMkJzbXdJdmNOZlZQSWxMK1JpTysrL0ll?=
 =?utf-8?B?NmYrRXRJclFMamIvdktmNjZFajA3THNHYTdVZ0FqNVdNYTd6TDA2SmpxQ2Qw?=
 =?utf-8?B?QXdia0QwUVdidGl3S0QySmllcHFIODJmcjM5OE1WV1haRXFxRXNhMG1yeWJI?=
 =?utf-8?B?ZVZNTkI0ODBNZ2JpclJHTXJ3SStMWE5Vd3dIRTk2MFRzdHIyR2Z6ZWlVSDkv?=
 =?utf-8?B?eGxtUmc4cTJvKzJIRlNKOWNnaVUyZnpTZG5yaWxQWEEvekUybjhoTEdsK3FH?=
 =?utf-8?B?QkQvQVBBVkZRaE0rZy9zdHVQL29XNDdLRm03WENwOGNYSHBuSmk5em1XWVUx?=
 =?utf-8?B?RFlqMmFCa0RUZ1l0Uk5GTTNhL0JZM1IwMkdKWGVGTHN5ZzRvdzNndzBaUEMx?=
 =?utf-8?B?REJFTGZ4MFBCYnorZjA4ZExJc2Jha0QxY1BuMDJuODJ0WFdUeVZnT2tnZ3VI?=
 =?utf-8?B?RUc5bUlTK1VGQ1pxbnNRWVNhTlNZQlgvcjFrMWozeWZFZmNQNDI2ZmI1YkJp?=
 =?utf-8?B?R0ZURFRMOGM5MzNXV0FaaXloazJJbmNqcDdpQk84aUl3OFhYaDZ1eUJoSHRn?=
 =?utf-8?B?R1BPMkp6OUNFN09GcC83MDVURUhDMER3a29sVENDV05kbGNZZWlXTjF2NHNM?=
 =?utf-8?B?Q3NKSG1ZTDFIQnhkSkJjdS8vM0dZWTBNQzIraWNSUEowOTBydzU3dXRpbVBJ?=
 =?utf-8?B?U0ZnVkpQZFlLalhLc2RybDczS2QyU2phRDczcEVXaDNYUVFBS0o4MDAycU9o?=
 =?utf-8?B?UEhZS0N4aHdmc0pLNmt2REVEWDZRYlowN2hmYkpKeXV0RGNrRW9jUmc5RS82?=
 =?utf-8?B?TDZES1pqVms1WnNnOHc0ZFVpd1M5NVZtc2ltanVEcHRpejFQMm5sbFpZS0xn?=
 =?utf-8?B?QXBIcGJjWjZwTEsrdlVFaFFNZ0pHVjFSczBHajVjNlZ4ZmpZMXdIblVaQnhT?=
 =?utf-8?B?WnRIVVMybjlDVXROejBmTWNnenNPRW4vYjE4dXp0ZjJoVGQzNDB5Vzk5WkQ4?=
 =?utf-8?B?M3FCcVdnTTJ6SFUxOWNHcTk5UHhSVFl5enBBQnR5SEJsOVhXSzh5VTZmVk1q?=
 =?utf-8?B?T1oxWjgwOEl6S0x6QWZBcVB6cW0zLzNCb21IWXRxL095MkY3UkhBWnhmLzhY?=
 =?utf-8?B?WjdhSEhqZ29PVWZqTENFREdvMHRPTENjajdpellYdzJLZCtTZnd2cEM0bCtz?=
 =?utf-8?B?V2pwWDlCQ1IrUkNGa243QXhoZEJ2TDJkdE5sRFVwSzlERUI1ZUs2bDFnVlR2?=
 =?utf-8?B?UTI4dlQyNXMzN1ZycnNhOGRxOXJ1M1FlN0FZQWVkK2RjR2wxWXd5cmxDbm9Z?=
 =?utf-8?Q?3XuVsGDWr15SwHi0j3IUkbSriQ9cRz2J?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akExTGNQakZGSVloSklNaEtpUTFGRXBjdWc5anA0T2lzbFQzQk96blhoNjVF?=
 =?utf-8?B?WnVJZGlJWFVwTXBtYXp6QWZNbHNaWlJyNzBENS9XVlVvbml6Mmpab0hYN1pp?=
 =?utf-8?B?RlVrNUtOdHZ0c0VMd256NTBiQkUvdUNPMjBOMlYwT2krdFQ0S2ZLbDg3M21k?=
 =?utf-8?B?Mm9CNGJMWDVDaG9JNzRRNmVNSmNSQ0E4S1BYQ3V6ME9SeVRtd1JUN01Pb3hq?=
 =?utf-8?B?S3JkOW13RWw5NGxzcWMxTnhBNjlyZ2lnUU9EMjVNcXczVVhkRWt1OEJrTG5k?=
 =?utf-8?B?TWlyTGg2RGJtTjdjMVovNXd0R3RBdDFmV1M3RktLV283S1NmamFMaE1Yc2x3?=
 =?utf-8?B?OEtzVFNYa2RxQnpmMGVwb2Y0TkVXNG50K01iYVNkcThZKzViNVZPbEcxemJa?=
 =?utf-8?B?MWdqamc4dHQxdHBaV1FUa0JwN2RmZVdxMmxQYTJHRnd6K0RoKzEwNU8wQ24y?=
 =?utf-8?B?eGgwUWJhZ0d3UW4wT2IrNVNPRkVxaHRFRXUwZFFkZ0k4cDdXU2hpVWxwd3lO?=
 =?utf-8?B?NlJTdXJIUURINDFnMFk1OXVCZnBGY014WE1KMWJFWDlIaHF4Zk0zamFPQkZS?=
 =?utf-8?B?UDN2M3lqeDJKV3FWakc1eEkvSENIT2t1SVBuL2p1Wk5MeWxJNkwwV1VxSGpC?=
 =?utf-8?B?VEo2eC9YOUJzZElnKytLVjNudHV6cE9UcEdQNUNZKzIwSWRZZ1VDOEVBcTlu?=
 =?utf-8?B?L24zSFZPc1NMTjBXYTlQbTIvbk9iZnhQRGhyZnBhWExybnM3THBZNmwra1RJ?=
 =?utf-8?B?ZFhaRVE4L2E1Yll1Q2VNQkp2WWJ1T282Z3NVWXl1R0NyU1Q3dGR1a3IrTEkw?=
 =?utf-8?B?SmlBRGJSdkZkbGlVdldwZlZ1TDZXNVMvT3dGblMxQmRoaFdzdmkyNXRVVHFT?=
 =?utf-8?B?VjJ2SitiQVZSOGhISjMyY0RnanRpNU9VU2JkaWh4UDFKblMvL0ltd0VtS2FE?=
 =?utf-8?B?WFJZOGQvQWJpYkFZTG5iTVhMaGtBU2dYajJXLzBJMzZ6RWcvanpWWXkwalZi?=
 =?utf-8?B?c0YvaFgrbkI5dGYzbEdOWnlHYkJ4dU82QmNzQ3B1MXY4VThnMFNUdnZKUmpo?=
 =?utf-8?B?S0t6dmZraDhHdEIvTDdJK3djYm5hcDRnWTJtZGlvck5QcXEzMUVRc0pCZk55?=
 =?utf-8?B?SFJWTjk3UE8zYW9xWjdLVjFTQUhXMlVja2hXK3FRSUNFd1ZqREc4Z1ZjUWw2?=
 =?utf-8?B?ZzJKWHFPYVlPK1d2ZjVWUlJCV0ZZbi9yV0F4M1JMRldUb0VDeVEyVGtZNC9V?=
 =?utf-8?B?bFBtcHZmeXZZeGc2d0pIMjJHWEJFMTc0NGZyZHlFc3dGYmp2VktDZk4yZldE?=
 =?utf-8?B?RnZmRkk4YmZQQXpRZHFRY2RvaERWNXJnakYyYU00RkVIbVl5anE1ZTNxbVBv?=
 =?utf-8?B?eDUxWXNTWEo3TjBsT2tKektJTEdnVFdkQU5NT1RKWGVOalNPd0Q0RWxndUZD?=
 =?utf-8?B?VXlGZ0xvSGQ3d2RsMmQzRU1UYStLY3BOYk1Dejl4QlhObXRrcW9pWGVrNkNp?=
 =?utf-8?B?bWlDMnNhM2RrR1NSLzg2dDdveHN5dWloejljc0V1TjdnSENxTG9UU0IrNUlq?=
 =?utf-8?B?RVg4UDhWblZqek9FTVpHVDFIYVV2U2NwaWtSN2ZVamdUMFFQMVk3YWZ6QzlZ?=
 =?utf-8?B?b3dKNkNxcHRicjNKRm9ENlZycVBxRVBkRml6c1J5QWRWWGJVNUtjL00yNkpD?=
 =?utf-8?B?WnJtblIyamoyRGxlS1FVRG0yL24zQ2ExNDFRNDJvOHdGNndFRnI1UFZtTlk0?=
 =?utf-8?B?MEZ2ODhWeXh6cWNBNTZKWmdNZWpBNTVBaWNzZTVpZndUa0JQV2VRVCtJRXNQ?=
 =?utf-8?B?SXgzTmprY0t4emxSekVDSVVueTVkTDdEaDhCbUg2d1ByMlJWVlVEQ1JFK1hr?=
 =?utf-8?B?NkFwZXpESmczd3YyVzVTWmVtUHR0QngrS3luejN1VVVCQ2lOVzRJaTFNTlZX?=
 =?utf-8?B?SSs5ZTBTM0ZhUWxvU3pFVWQrY3FQSlRuU3hEZWFzSTRzaXgrWUtoNEdKQndT?=
 =?utf-8?B?eW0zRnhsdU5PUjFGMUhTdlc1UFJ6M09zM1hHUzYvOURlSkNobkQ1VGtmZ092?=
 =?utf-8?B?SEVrUG1ya3FKWTRsTFRRUExQSmRFWFFFV0YvYWpMN2h4ZE1yUVp5aXk0b1Z2?=
 =?utf-8?Q?TrOM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16dd58f-bef6-4b74-3624-08dd61873176
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 16:59:03.4435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hk4r8bDTdsf3V5+XngJlQTI0YNj/StqfaHxHzr6Yrfd9qBRuVXBLwJ+NakwbeLi9dvTisZQiGm5k182c80FQLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFi
ZW5pQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMTIsIDIwMjUgOTo0NCBQ
TQ0KPiBUbzogUmFkaGFyYXB1LCBSYWtlc2ggPFJha2VzaC5SYWRoYXJhcHVAYW1kLmNvbT47IGdp
dCAoQU1ELVhpbGlueCkNCj4gPGdpdEBhbWQuY29tPjsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1
bWF6ZXRAZ29vZ2xlLmNvbTsNCj4ga3ViYUBrZXJuZWwub3JnOyBob3Jtc0BrZXJuZWwub3JnOyBr
dW5peXVAYW1hem9uLmNvbTsNCj4gYmlnZWFzeUBsaW51dHJvbml4LmRlDQo+IENjOiBuZXRkZXZA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBLYXRha2FtLCBI
YXJpbmkNCj4gPGhhcmluaS5rYXRha2FtQGFtZC5jb20+OyBQYW5kZXksIFJhZGhleSBTaHlhbQ0K
PiA8cmFkaGV5LnNoeWFtLnBhbmRleUBhbWQuY29tPjsgU2ltZWssIE1pY2hhbA0KPiA8bWljaGFs
LnNpbWVrQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIG5ldC1uZXh0XSBuZXQ6
IE1vZGlmeSBDU1VNIGNhcGFiaWxpdHkgY2hlY2sgZm9yIFVTTw0KPg0KPiBDYXV0aW9uOiBUaGlz
IG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3Blcg0K
PiBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJl
c3BvbmRpbmcuDQo+DQo+DQo+IE9uIDMvMTIvMjUgMTI6NTQgUE0sIFJhZGhhcmFwdSBSYWtlc2gg
d3JvdGU6DQo+ID4gIG5ldC9jb3JlL2Rldi5jIHwgOCArKysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL25ldC9jb3JlL2Rldi5jIGIvbmV0L2NvcmUvZGV2LmMgaW5kZXgNCj4gPiAxY2IxMzRmZjcz
MjcuLmEyMmY4ZjZlMmVkMSAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvY29yZS9kZXYuYw0KPiA+ICsr
KyBiL25ldC9jb3JlL2Rldi5jDQo+ID4gQEAgLTEwNDY1LDExICsxMDQ2NSwxMyBAQCBzdGF0aWMg
dm9pZA0KPiA+IG5ldGRldl9zeW5jX2xvd2VyX2ZlYXR1cmVzKHN0cnVjdCBuZXRfZGV2aWNlICp1
cHBlciwNCj4gPg0KPiA+ICBzdGF0aWMgYm9vbCBuZXRkZXZfaGFzX2lwX29yX2h3X2NzdW0obmV0
ZGV2X2ZlYXR1cmVzX3QgZmVhdHVyZXMpICB7DQo+ID4gLSAgICAgbmV0ZGV2X2ZlYXR1cmVzX3Qg
aXBfY3N1bV9tYXNrID0gTkVUSUZfRl9JUF9DU1VNIHwNCj4gTkVUSUZfRl9JUFY2X0NTVU07DQo+
ID4gLSAgICAgYm9vbCBpcF9jc3VtID0gKGZlYXR1cmVzICYgaXBfY3N1bV9tYXNrKSA9PSBpcF9j
c3VtX21hc2s7DQo+ID4gKyAgICAgbmV0ZGV2X2ZlYXR1cmVzX3QgaXB2NF9jc3VtX21hc2sgPSBO
RVRJRl9GX0lQX0NTVU07DQo+ID4gKyAgICAgbmV0ZGV2X2ZlYXR1cmVzX3QgaXB2Nl9jc3VtX21h
c2sgPSBORVRJRl9GX0lQVjZfQ1NVTTsNCj4gPiArICAgICBib29sIGlwdjRfY3N1bSA9IChmZWF0
dXJlcyAmIGlwdjRfY3N1bV9tYXNrKSA9PSBpcHY0X2NzdW1fbWFzazsNCj4gPiArICAgICBib29s
IGlwdjZfY3N1bSA9IChmZWF0dXJlcyAmIGlwdjZfY3N1bV9tYXNrKSA9PSBpcHY2X2NzdW1fbWFz
azsNCj4gPiAgICAgICBib29sIGh3X2NzdW0gPSBmZWF0dXJlcyAmIE5FVElGX0ZfSFdfQ1NVTTsN
Cj4gPg0KPiA+IC0gICAgIHJldHVybiBpcF9jc3VtIHx8IGh3X2NzdW07DQo+ID4gKyAgICAgcmV0
dXJuIGlwdjRfY3N1bSB8fCBpcHY2X2NzdW0gfHwgaHdfY3N1bTsNCj4gPiAgfQ0KPg0KPiBUaGUg
YWJvdmUgd2lsbCBhZGRpdGlvbmFsbHkgYWZmZWN0IFRMUyBvZmZsb2FkLCBhbmQgd2lsbCBsaWtl
bHkgYnJlYWsgaS5lLiBVU08NCj4gb3ZlciBJUHY2IHRyYWZmaWMgbGFuZGluZyBvbiBkZXZpY2Vz
IHN1cHBvcnRpbmcgb25seSBVU08gb3ZlciBJUHY0LCB1bmxlc3MNCj4gc3VjaCBkZXZpY2VzIGFk
ZGl0aW9uYWxseSBpbXBsZW1lbnQgYSBzdWl0YWJsZSBuZG9fZmVhdHVyZXNfY2hlY2soKS4NCj4N
Cj4gU3VjaCBzaXR1YXRpb24gd2lsbCBiZSBxdWl0ZSBidWcgcHJvbmUsIEknbSB1bnN1cmUgd2Ug
d2FudCB0aGlzIGtpbmQgb2YgY2hhbmdlDQo+IC0gZXZlbiB3aXRob3V0IGxvb2tpbmcgYXQgdGhl
IFRMUyBzaWRlIG9mIGl0Lg0KPg0KPiAvUA0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4gSSB1bmRl
cnN0YW5kIHRoYXQgdGhpcyB3aWxsIGxlYWQgdG8gYW4gaXNzdWUuDQpXZSBoYXZlIGEgZGV2aWNl
IHRoYXQgc3VwcG9ydHMgb25seSBJUHY0IENTVU0gYW5kIGFyZSB1bmFibGUgdG8gZW5hYmxlIHRo
ZQ0KVVNPIGZlYXR1cmUgYmVjYXVzZSBvZiB0aGlzIGNoZWNrLiBDYW4geW91IHBsZWFzZSBsZXQg
bWUga25vdyBpZiBzcGxpdHRpbmcNCkdTTyBmZWF0dXJlIGZvciBJUHY0IGFuZCBJUHY2IHdvdWxk
IGJlIGhlbHBmdWw/IFRoYXQgd2F5IGNvcnJlc3BvbmRpbmcNCkNTVU0gb2ZmbG9hZHMgY2FuIGJl
IGNoZWNrZWQuIEJ1dCB0aGlzIHdvdWxkIGJlIGEgbWFqb3IgY2hhbmdlLg0KV2lsbCBhcHByZWNp
YXRlIGFueSBvdGhlciBzdWdnZXN0aW9ucy4NCg0KUmVnYXJkcywNClJha2VzaA0KDQo=

