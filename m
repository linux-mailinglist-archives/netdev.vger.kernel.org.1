Return-Path: <netdev+bounces-175561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98C4A6668D
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 03:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE8F87A854E
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 02:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D3C16EB7C;
	Tue, 18 Mar 2025 02:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uaujf2ZI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A134A1A;
	Tue, 18 Mar 2025 02:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742266308; cv=fail; b=JPW/4rGhcXLsMOUAu4x5MZxQokm1hyfnxBjlGmvtVRbk1VeWihndxGlR0x/ugfjlvBB+SQDQIit5kxLjpGB1Hh8GO+PNGC3Ff7gLrhQdVnzzoiLWv/U/HCxgj9KhF/psVCw5GnmtFZ9eYpGH+Ann2dIf+tkcnHQYwili0IcZ1Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742266308; c=relaxed/simple;
	bh=BHTCwRg7UYozcKYvlsFSMNulLSR150x2RqF0zEZo/KI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DGhYlpZ7PItd4JQlW8YqB0fYs9OBfTkvlpjxbZHywgH8t6CFDkKl8n7FdCox0om6/RpGNfSp0DTAeiScjHFLBKuJnePnr3wg0BCwt1mUVMz1o7Hm6NoRznsWMJpZCStCCmwepMHT3/DFDlzV0UpJI9zYC6ZC+CbBLhtBOBYRlTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uaujf2ZI; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFKeDcyZyPIg+BZQMUZddKTA5SeJmc4U2E6wV8BNvubEhU4eQQb/CUkh6QUOLKXLZXl1rt2ybvrweAkT4rZNGzQovDEfNKNIOcwFEttMBwkxVCPKnacMeQpfjIFA6iQLJIxu2LLn1VZxzGhIrqgUNGezeWUk3vVsTrhWSytmzQAiMBZtfuXMGsffGXvqLOM2lKPFtqefsB8azwyyQXOxqvPnwgeO25AKf3TxNME0aIBERS980yf7CdyPl798fIAl5k/astaIAz4/GbQs92CbGpB0kFCUETj/hJvxKe5RCJCQNz+U6nMef617l8uZli5qlUasuevilBmN1zm/10gDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHTCwRg7UYozcKYvlsFSMNulLSR150x2RqF0zEZo/KI=;
 b=HeL1YubS8Nu2vDcT+HJ8F5z6XUfu38u0L4UVanQkqlsa0vo66r3rtbXnTy6vm9bHkABDw21Qs/HcPJbDKNl01dUzCCDBaIZAL4OUfu1UFQbbBC5u1l26JGq95lvEkToFujw/MYzWgk0gi4rjdK0zbvw2IHKpbIZUu2avE3Y/Ws1tstr1PHL+7V4bD3HazlIIS96+EcP5/KQgjbfoyHDIfSi4oQd2KMs+G3B785YnyjxJjqN+L54eavN+UVm1KAjix/Ec4udYxgcG8ThfqL2HDBtgeMY98V4nH+L5IBuU3kYR/A2+8cg4elFyLSk93zu2L5VPSXc32OTtvOmQwRyB7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHTCwRg7UYozcKYvlsFSMNulLSR150x2RqF0zEZo/KI=;
 b=uaujf2ZID6ZF5MJAk/NeDAWOFvE59UERG5oM/fdfDPDE2RZRRmV1UAS0cLfpPBnhaEdL+hdvq+1hzua/R7rloFE50a09Btcq39NZT8BlGTEJMRHq98ne+UWDwCKyRdeznek3x6o0pAT5Hl54jcl/ARXpCJNsvo6EM3YAAuGid2kdC+uv38FAm971YfBBva65MaPLK/OFQ6y+D2oHT0rEoGM0IqCUcHDAxyvT9kKIwqmr3yk7rehXHyckmmiVL0rC+Uq1xUMIVaft/idRBr0wB5nC/caEE1OMeANapd1gZRWJnG4tx3qVQsfAeDyg4ctozA311AxGwjxM2IBaXB0zFQ==
Received: from DM6PR11MB3209.namprd11.prod.outlook.com (2603:10b6:5:55::29) by
 DM4PR11MB6550.namprd11.prod.outlook.com (2603:10b6:8:b4::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Tue, 18 Mar 2025 02:51:44 +0000
Received: from DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924]) by DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 02:51:44 +0000
From: <Thangaraj.S@microchip.com>
To: <gerhard@engleder-embedded.com>
CC: <andrew+netdev@lunn.ch>, <Bryan.Whitehead@microchip.com>,
	<davem@davemloft.net>, <linux-kernel@vger.kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: ethernet: microchip: lan743x: Fix memory
 allocation failure
Thread-Topic: [PATCH net] net: ethernet: microchip: lan743x: Fix memory
 allocation failure
Thread-Index: AQHblK98BjdQkP81m0OBUoCronD9I7NzGFCAgAUerQA=
Date: Tue, 18 Mar 2025 02:51:44 +0000
Message-ID: <34d674a3cef104b3b3417645f8b52f0c8972ac08.camel@microchip.com>
References: <20250314070227.24423-1-thangaraj.s@microchip.com>
	 <806eed8e-0695-450f-a16b-66b602db01dd@engleder-embedded.com>
In-Reply-To: <806eed8e-0695-450f-a16b-66b602db01dd@engleder-embedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3209:EE_|DM4PR11MB6550:EE_
x-ms-office365-filtering-correlation-id: fd8ce156-96d3-4972-442e-08dd65c7d166
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bXBLZmNKeTNRMnFhMVhoalRnK3E3d3ZTNXNISTA4ckMvSk9hMFN0bjRWcjZq?=
 =?utf-8?B?MTJoYmdiZU5OR1FVSE9vQUFMajhpUm1sRlBUMkpJOG9qVTNmWlQra1BmY3l3?=
 =?utf-8?B?UDVsVlVxWXBUWTE3ZEZaSldoN3VZdGJaaTBCczRtbytCQjNzQzZvTlBwYlND?=
 =?utf-8?B?NzZCOC8vRHV2czRHTWdMbDdjZVdSeUsvRHZPa2FIcWpuWnVOVHA1b2pNV1lX?=
 =?utf-8?B?OXZiMk40cFFaVUxyWjlob1lCbnVtNmhjVDFvSzJFd3l6MTlGc0R5aVpZNGgw?=
 =?utf-8?B?RXVyZS9saGJna0dxREgzMlJKbldSNWhYVWQyaFhvWjNzcDl3ZHBmSElQaGhL?=
 =?utf-8?B?YTBpbjJTOVpFZDJNSi8rODVxK1JtZ0tlNVhIYzRyUGIvT3VVNEttN09SZms5?=
 =?utf-8?B?R1BFa3dheC9YbmpKM1BpMnU0ZWRsNzI1emtCZHNqMWE4Y2F3MWhzM0p1YzRD?=
 =?utf-8?B?anFkUk9OK0VmWFQwM2g2emJlUVVVbExidmFyN2x0R2t2aDZKd1Q1dWJ4VUdl?=
 =?utf-8?B?cFA3QU9NYmg0SnV1V3V5eUNCWnArMG41V2xzMGloRkczMUN5LzRhNFkvcmhW?=
 =?utf-8?B?alpUUVV6Y2tDSTlpNWdMZXQ5ZnNuTkVWOTZyYzloVUUyWVFWbXRvK3VKLzRQ?=
 =?utf-8?B?aVRxejFjOGc3VkthelROZUFsWTVxZ0R3K3cxMytGNm5KNU1SdmlrOWpCdEU5?=
 =?utf-8?B?ajdORjlKeW5ZNTNTSnhUc3ZjdkduNFB0WExKNUJtSTV1NjkrZ1Arcm1GSnhD?=
 =?utf-8?B?Q01kT0c0c2lhK1crcmJSRmpFV2k2YWZURUV2d1JJREplZzkrV05RSXJoNVBR?=
 =?utf-8?B?TnovZVFycU9xNVVsWHlYLzNIN3FnNXI0THl2dGxVb2FOMnpqc0ZLSDlBMUhh?=
 =?utf-8?B?dWxWRDlsYzNPTDB2YUxjcEx2azZja3JRVkJJSFByWFhzSGc5VWhJRHI4eTdx?=
 =?utf-8?B?b05CM1UrTXQxcTRqVm9MMkNlYnRMeWljbU1MUTlMampsZElRWGJObFoveHlT?=
 =?utf-8?B?T1pBZ1pTS1NiQmdra2dINUVuMGs5akMzeUR6L0hLWDlqK3p6dUQvcDN3dGdM?=
 =?utf-8?B?bkhkaldGV21PMjZJRFlheW1CUXp1eGlkNmtqeDdTTGVnQ093VHZua3NCNGZv?=
 =?utf-8?B?M0pNVktzdmJPczFhQzJaUWNrVFdidFN5SnRsWnJOYkhvOXo0M3lia0lVVmYy?=
 =?utf-8?B?OGdGb3RMMGYrQU9lOGhvNmdBZ2tVanZlSGVxZVE0ZFJJREhUQzlUYkFreFdt?=
 =?utf-8?B?dmxYY1F6ZmF4Y090MDlJK3J6ck42ai9xbitTY3g2RUNWWTd2eXBMRHlscEs5?=
 =?utf-8?B?RUZBcVNySmlhVWQ4VXhzY1ZIR1JRNFRFbkdpcEI4RWpxTUdtWXpCZnV4V29E?=
 =?utf-8?B?ZG5nb29RWTh1MWNlZitQNjlDa0prUm1Xd3RiTDRmWG4yMk8xaDh6dVNjSjFY?=
 =?utf-8?B?UktVd2Uyb3ROTDc3aU5SbWYydzRHK1h1STY3bmpYMGNaUUd5UHpTbklHaVEw?=
 =?utf-8?B?cWtHWHZmMlZ2SnRFdDFuUEtobzVzdktmbEVJaUZadGVMVXFSSVJlZ3ZPb2Jk?=
 =?utf-8?B?OStqY1NxWFp5c1NzR05ZNzJXOGYwdTVZcjYzd1dSLzFmaGdoMzhWT2tnTkx5?=
 =?utf-8?B?eEFoM1ZBaHVPU3V0cnJHYVM0ZHd3SzVyY1JjMDV5cWo2YXJxR3lBeVVtL1dO?=
 =?utf-8?B?WWJWSDFGWEZIQU1FYzYvd1U3U0pWNW1XbmtTUXVza0xoKzNDeGpLNVJVVDlK?=
 =?utf-8?B?YWZKM2pmN3N3MGIvZXRrNkgrQjlEMS8xNWZZK0MrWWQ4Ti8xZytYZzRLZGdz?=
 =?utf-8?B?SFpvYXh1SzJRejIwZURJMmdrK2V4aVc2d0FuSHJDSEhZQzF0c3NLZE9ZS255?=
 =?utf-8?B?QUM3MWNVdmt4MjR1c21STUdvMXFrTTR5endwR1NxSGZPdFk1TVZMMHdaN3lo?=
 =?utf-8?Q?0/LgJBDifkAyyjraptljt3MEykW8ooi9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3209.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjFOcXQwTXFCcUV3VDJHKzdCNWxxSGpPUThVK2srZEhnMEZNd0JMZk1GdXN0?=
 =?utf-8?B?anFiWmpIR3cwVGdJNGI4eU9RRm1EeCtndTBGNnp0YTZpN0JaZ0ZoajhJYXNV?=
 =?utf-8?B?bGFDb3RXQ3RUMVZRY2E0VmdJUEdLTUpzSTRKRDBPcWkvMjlTNHdJS2V6MlNj?=
 =?utf-8?B?UHFzd0tiaXRsL2toUjFKOHoxRmVKblVaU3llcHpiaXFWSEphYWFJbm5rK3VX?=
 =?utf-8?B?YlNFczk2ZWg4K2orZFFScTZrU3ZIaXZhQnI4N2VkZGdqZXVtZ01UUDBiaEpx?=
 =?utf-8?B?MnlaZE5uT3NoV2FQdVhYV1k2SkZnVE5aS3VQclFhZy9yQnJ1YlM5eEp1TUNz?=
 =?utf-8?B?Q1NvNU5zcjFlaXNBbTNQamR6bE9EaWFPU0hJY0hxL2pueERhc2JzQm9jNngw?=
 =?utf-8?B?U1FoTGFHQUhvREZlaW1Td0s4a3dmS0hzTkNkVkJaM0V4eExCMndHY2dieXc0?=
 =?utf-8?B?dndZZnJYTmUrZEQyL0FzcmZ5U0RsSmRNNjhDd0ppazI0RnBuOVBQV2xCUFVK?=
 =?utf-8?B?UzVickwwS0dMci9vazJTTVcwMmJRVThGU3ZKd1V3cnFhZE9ER2dhb2NidGJQ?=
 =?utf-8?B?YXR6RlZMbzd6bkJTUDNodlNMQXorNEtLSFdPL0ExWktCK0VySk90azhROGp5?=
 =?utf-8?B?MlFpTnlyN0xlVVg5ZEpERXArN01OdGVFb2YwRWRQbHhsTGZwOHhtTkZVcnRh?=
 =?utf-8?B?UUMrYzVpU0VWOWFtSHJ0SElJWWdvV0VKYWM1S1R0OGtCZTVvNHZkYzhaYVJ3?=
 =?utf-8?B?bUJtVE1HUDlpVDdQNXp6bm10dDgwTTdIS2hvQ0NFNGpkRlZqWHkwQWpTVklq?=
 =?utf-8?B?MVB6OE0zSXhIaWFNNTBTakNEdHd6bDRmc2g0QTBEUHF1cEtPMWVUQUpkT3Bm?=
 =?utf-8?B?Y01WNVVWcVlTRGNzQkhMUW9mUEUzYVkvUzFaWW9ma1I0RVVud0RKdkU2SnVM?=
 =?utf-8?B?K294LzFrSzRIeEdtZHhhZUtwUjJMRDYzWCtpYUFEa2UyOXNWYThWMTBCR2o1?=
 =?utf-8?B?K1Eya3NGbEtHMUc3alhObVdwOFRKZWNTZHdBcmZNZ1BQRitrbys0UjRIN0xU?=
 =?utf-8?B?MmdOb095L3BLNHZPTUczdmZKdDlBRU05SDg5dE9WSXYrdEhyQmdMSkIrOXpT?=
 =?utf-8?B?QWZRd2VvVDl6c21sVWttVmp3TkthcXZpa1h4YTFnVUZqT1hNSGpQdTBnRmlW?=
 =?utf-8?B?emlMVjFUNFIxU3dhNEhUcmRqYUkvdGttNkdrbU0rRldsSkJOUzZubE9rUENP?=
 =?utf-8?B?M2p5UnV4MnFzSFFUWk8vbndRVmFMOXlCWC9rYm10aUk1TTJ6d3c0N2NNOVVI?=
 =?utf-8?B?TW8zTEE2alBzaUh3aUZ3MmZxV3pNdWpWME5PQmNSTkYzUW9DTUVuNHZVQ2Vq?=
 =?utf-8?B?dHcxQkRkbzZoSkxrQjhkd3M1NzhkODlyYzVsS1FhRHd0L0ViQjg0MEhQalBP?=
 =?utf-8?B?ME5TRk9SK3plUjVXYk04Q1EwcThMTE1OL2ttTFhDemwrUzZNTmRqRnBQV0Nt?=
 =?utf-8?B?ckVFcjc0Tjl5eTVqQ0Y1RVRTdm51Q1RtcWF3NjNON0UwbEN3RGR5OUdmZjVF?=
 =?utf-8?B?ckxlS0VpM0NpeXhqWmIwd0M4NGUzNVNSQS9zQk5jQnQ5ODNieS9uVEdNcUJ6?=
 =?utf-8?B?U3N5OTArenlUUys1dXlKa2poMm8wVEkyZ3ZtdUlSV3c4VXMxbnh0TDQ0aWZ5?=
 =?utf-8?B?TWQ4TDEwcXY3UWZQQXlZUzdzL0RSOG02OXFpOTE4VVlNdkpvWWF6MVhnU0Zl?=
 =?utf-8?B?Vzd5OSs2NFFqTjg3Ukw3UzZwWmVGZllGaW5aSmpGS2lxaU9ObUROQmJ1dkxq?=
 =?utf-8?B?U0N6bkgrM1RkMlFRbzdldE1BRVlzamd5Nk1YSTZoR3pKbGZodGg1bTk5RGRE?=
 =?utf-8?B?TW9NbW01SUFRVmNJaTlHTjhORnV1cUlycEdGeUlsaU1UT3l0VllKUjBuRGNr?=
 =?utf-8?B?eElpd3o1RVJXZjB0bGNmbjJuUnZtYVl0cUFTUGRWVTZYV2FmSTRXUGFUaURs?=
 =?utf-8?B?aXBabDFOYk4wU3FHN3JuSGoyTzlUMUFpZnJNR3JWRXE2aVZtUFBDTW1kbFRr?=
 =?utf-8?B?U1BHRkk0cEF6ekNTcHZjMk1XZTNaVUNIMlo4aTduUDhka0w5K3JRS25qNDBJ?=
 =?utf-8?B?R0kyY3RDNXc5OXFkWlpGamRQM2RKSWRtMEp4ZTIvVmtpcW91WkMyQjBIUGpx?=
 =?utf-8?B?T0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8FC5C053C14C344B417813FA5E30778@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3209.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8ce156-96d3-4972-442e-08dd65c7d166
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 02:51:44.2319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r5WHe1Nk4xDu6Xuwmt0N/0oEcmHe3sfojJx8OQRK2+cjVfsAjAWV6pGSKmNQtdlcBJZTndqpSrUxboSukszWeytrmTmz89bZoxWgnkIfqtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6550

SGkgR2VyaGFyZCwNClRoYW5rcyBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaC4gUGxlYXNlIGZpbmQg
bXkgcmVzcG9uc2UgaW5saW5lLg0KDQpPbiBGcmksIDIwMjUtMDMtMTQgYXQgMjE6MzcgKzAxMDAs
IEdlcmhhcmQgRW5nbGVkZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQg
aXMgc2FmZQ0KPiANCj4gT24gMTQuMDMuMjUgMDg6MDIsIFRoYW5nYXJhaiBTYW15bmF0aGFuIHdy
b3RlOg0KPiA+IFRoZSBkcml2ZXIgYWxsb2NhdGVzIHJpbmcgZWxlbWVudHMgdXNpbmcgR0ZQX0FU
T01JQyBhbmQgR0ZQX0RNQQ0KPiA+IGZsYWdzLiBUaGUgYWxsb2NhdGlvbiBpcyBub3QgZG9uZSBp
biBhdG9taWMgY29udGV4dCBhbmQgdGhlcmUgaXMNCj4gPiBubyBkZXBlbmRlbmN5IGZyb20gTEFO
NzQzeCBoYXJkd2FyZSBvbiBtZW1vcnkgYWxsb2NhdGlvbiBzaG91bGQgYmUNCj4gPiBpbiBETUFf
Wk9ORS4gSGVuY2UgbW9kaWZ5aW5nIHRoZSBmbGFncyB0byB1c2Ugb25seSBHRlBfS0VSTkVMLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFRoYW5nYXJhaiBTYW15bmF0aGFuIDx0aGFuZ2FyYWou
c0BtaWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWlj
cm9jaGlwL2xhbjc0M3hfbWFpbi5jIHwgMyArLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjc0M3hfbWFpbi5jDQo+ID4gYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuNzQzeF9tYWluLmMNCj4gPiBpbmRleCAyMzc2MGI2MTNk
M2UuLmMxMGIwMTMxZDVmYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9t
aWNyb2NoaXAvbGFuNzQzeF9tYWluLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9t
aWNyb2NoaXAvbGFuNzQzeF9tYWluLmMNCj4gPiBAQCAtMjQ5NSw4ICsyNDk1LDcgQEAgc3RhdGlj
IGludCBsYW43NDN4X3J4X3Byb2Nlc3NfYnVmZmVyKHN0cnVjdA0KPiA+IGxhbjc0M3hfcnggKnJ4
KQ0KPiA+IA0KPiA+ICAgICAgIC8qIHNhdmUgZXhpc3Rpbmcgc2tiLCBhbGxvY2F0ZSBuZXcgc2ti
IGFuZCBtYXAgdG8gZG1hICovDQo+ID4gICAgICAgc2tiID0gYnVmZmVyX2luZm8tPnNrYjsNCj4g
PiAtICAgICBpZiAobGFuNzQzeF9yeF9pbml0X3JpbmdfZWxlbWVudChyeCwgcngtPmxhc3RfaGVh
ZCwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBHRlBfQVRPTUlD
IHwgR0ZQX0RNQSkpIHsNCj4gPiArICAgICBpZiAobGFuNzQzeF9yeF9pbml0X3JpbmdfZWxlbWVu
dChyeCwgcngtPmxhc3RfaGVhZCwNCj4gPiBHRlBfS0VSTkVMKSkgew0KPiANCj4gSSBhZ3JlZSB3
aXRoIHJlbW92aW5nIEdGUF9ETUEuIElmIGl0IHdvdWxkIGJlIG5lZWRlZCwgdGhlbiBldmVyeXdo
ZXJlDQo+IGFuZCBub3Qgb25seSBoZXJlIGluIE5BUEkgY29udGV4dCBhcyBpdCBpcyBpbnRlbmRl
ZCBmb3IgaGFyZHdhcmUNCj4gbGltaXRhdGlvbnMuDQo+IA0KPiBJJ20gbm90IHN1cmUgaWYgR0ZQ
X0FUT01JQyBjYW4gYmUgcmVtb3ZlZC4gSXNuJ3QgTkFQSSBhbiBhdG9taWMNCj4gY29udGV4dD8N
Cj4gRm9yIGV4YW1wbGUgbmFwaV9hbGxvY19za2IoKSBhbmQgcGFnZV9wb29sX2Rldl9hbGxvY19w
YWdlcygpIHVzZQ0KPiBHRlBfQVRPTUlDLg0KPiANCg0KWWVzLCB5b3UgYXJlIHJpZ2h0LiBHRlAg
QVRPTUlDIGNhbm5vdCBiZSByZW1vdmVkLiBXaWxsIGFkZHJlc3MgdGhpcyBpbg0KdGhlIG5leHQg
cmV2aXNpb24gb2YgdGhlIHBhdGNoDQoNCj4gR2VyaGFyZA0KPiANCg0K

