Return-Path: <netdev+bounces-192283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D11DBABF39A
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 14:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842794E0717
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC59261388;
	Wed, 21 May 2025 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="pvbObIws"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C1A1C5F1B;
	Wed, 21 May 2025 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747828866; cv=fail; b=pqThhTfGvKeUhyQwJj7m4kjcBn78V7R/kf2GLL84nFEq51yMQYDXeEvMynbJPd9P4lk3sL09ZpyyQ9ilhuF/skReV1qMpR6F5+/VAEPCn0fP1KZwET21NA9JGXp9cVaYCh28qKdgm0d9GKa7IIhW09usIlTW/46XK+9poVD+Evg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747828866; c=relaxed/simple;
	bh=uVoWPsqjC9zfW9M0ISjtWZMFGrcfdfRP4g0fR4pqVAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=unG1L9J3QbbpB8bIECGwu89SfbNhlO7yBH86jgLZguI3Dvp8zYZ/EmFj59rfMKoh48Or+8tsgGGQ7sdrDnBCbOPJ+q1kdDmHRFF7cBWzQpALBv121wqKuRI6PSv74nlIOZLDudgBVSZxdxfQ6b0ldAMwNlW2B0ixAofZRdQTCPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=pvbObIws; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9qnIn012821;
	Wed, 21 May 2025 05:00:35 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46s3kc95as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 05:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpZrW6gEAFW/n50yahKu8JQvym6c25kbiP+wyrht2CJNO+FNdqMMLEZY56yu3l3xjViDXLkKWybRJnU52Bn2L2qo6MVFVya3eEXKjcww/4jFXIQF/OqMwDikw5bn8DmU1Za/OVSmND37s4DnJTzSBbv+ekbhvCmb4Olaru/moK0jXiu4op0sEisdl+bFOp9RYRLh48LaEN3IIJQQPEWpKFGhmWlR9CfrsMF+w4CAvvMmgqjvCrLvmQmds1LhsEJcLkf01I+LASEIQN8WhwCwkSNyrvqJnm/kaEv/ShbXD18ar+K/6B5Xxf6Iq2F/G3CeAHQavI4rR5mwZvSGEOOe5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVoWPsqjC9zfW9M0ISjtWZMFGrcfdfRP4g0fR4pqVAQ=;
 b=mi3wJBdCnvvpfcoJw511yhZaB3b8eJimxlL8BJVjnCxTmomkUfW9auMhhhHLBLW5YgsNWNDrtvI2cOnXyNV+gYj+aT/LCoZGU5+uCCpxaovQbG7FWxpUFBX8QUT3Ohj4aHaSkEYs1CAIdwMQ+T0ucRTmsBndzVmEKDxDne7hSca+o7SHBcSdsX4s7gExY4n8MFuI4eqUFoM/aRf1IX/gt/O/RZ+S9ktDQQzGvQT0SH20WES9z1fD2auJHxneBppFbc4/CYKSQfVKWEeIqTIIkOL7Tg8oMNAJD3gc/4SVsIQ2zeNEQumCjTluNrvNzXHyMkF7TGE5IgOp/Am3xO/NVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVoWPsqjC9zfW9M0ISjtWZMFGrcfdfRP4g0fR4pqVAQ=;
 b=pvbObIwsFBnY6JiPo3mX5ZjrouK/gNcv14N5A1eIYfD39N842wKiYv1SEDn3m3EmYMT+3ltAHhut3tKbHrURwZX7LvFsy1X9RIWkz/9jRdbqJaStXsqCMn7zvY17UyrmW/iRdlA0sXQIuHwLqWzj4jrvRpAQcdumsGXHbnW6t5I=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by PH0PR18MB3879.namprd18.prod.outlook.com (2603:10b6:510:24::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Wed, 21 May
 2025 12:00:00 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%7]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 12:00:00 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>
Subject: Re: [net PATCH 1/2] octeontx2-af: Set LMT_ENA bit for APR table
 entries
Thread-Topic: [net PATCH 1/2] octeontx2-af: Set LMT_ENA bit for APR table
 entries
Thread-Index: AQHbykfggITxH+5ybkWlngyihYDRpA==
Date: Wed, 21 May 2025 12:00:00 +0000
Message-ID:
 <CH0PR18MB4339446EDBF8869C2740AEC0CD9EA@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20250521060834.19780-1-gakula@marvell.com>
 <20250521060834.19780-2-gakula@marvell.com>
 <aC2RWIQgAxG03pSC@mev-dev.igk.intel.com>
In-Reply-To: <aC2RWIQgAxG03pSC@mev-dev.igk.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|PH0PR18MB3879:EE_
x-ms-office365-filtering-correlation-id: b3915a7c-a1c8-4c18-8ef5-08dd985f0381
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dnRuMk4zQ2RyK2wxQm0vemlSMzMwdlZQZ2NmVDhTcGU4eWZWbWs0M2NMV3dB?=
 =?utf-8?B?TmJJUmZMam41NkJNSVhVVnFhVlFBQ1JkWHNDQW1IZFB1dGJRYmhRTEYrSkk3?=
 =?utf-8?B?bEF1Ym14M203WHgrRDI3ZU1XRGdDOHppbVZVK096QWpjWk8rSE1GNjNLZ3N0?=
 =?utf-8?B?WEErcXp0Z2NWWHlGOXZDZXBub1Urbnh1N2krTktvR1JMSzRHZ09KLzg1NWVU?=
 =?utf-8?B?LzhvSkxuVUFrR3J3V3JoQnpudHVWZm0rS2NqNG5GYlh2RjJ5REQ0ZWdONjU1?=
 =?utf-8?B?V0gwR1FDZnZnY3VKREVDaG1jb1p1QmtnUWpOaDBsaU9vaElUMTBLVEl3elZY?=
 =?utf-8?B?Q0EvcG9uSUgzWlhwWi9XNUVsdjU5cDhmaUNhWVBXVHRrSHRIUWFwTWhwa3Ji?=
 =?utf-8?B?ZTl6d2kzUzAwYjk5cTI5aS9hNG9lZUVPTXBHWmt0bXE2TFUwbTZhRlQybEJK?=
 =?utf-8?B?UW5kVWN0SkN4cEZTZzZNdVBKTVN6SVRkYmxwdlpJY2E0UXFKejBBSWVsak55?=
 =?utf-8?B?TmF2QjF4V3dwdDh5dEs4Tkx2bVpkd1FsQXVRdlRJSHRNMmJpNFhCU1V1WTAv?=
 =?utf-8?B?Umg4c0xJaG1EY2FJMm9NOW1TUWtIUnhZOGN4cnU3UGNzYzh0cDE5bERLOGZH?=
 =?utf-8?B?WDJ4c09TYjExeTNFWlNqQ3Q2ZDkxSlhmOFQvSzBreGZFZTlxajJIejIxNjhw?=
 =?utf-8?B?dW5uTFpkODhkQ3JaYjkrZjk3VFo0VTEzQW5kRm1oeHZoQldVUDE5NHRmUlBq?=
 =?utf-8?B?NVhuVEwvTFF5cVR3VzNkY1g0RHJuR0krTmQzOVV0K1ovdTRHMzRiZTZBTmpC?=
 =?utf-8?B?a0pSQ0xZTWl6bk0ybHpOTTRBdXdxWDg0MXRHTFFRR1NOM3VGT2hDeHl6ekYy?=
 =?utf-8?B?cFNxLy9zaDJYZEFxVjVsT055QlIxTzR6OHMrUEswNzRFcEpzNituM2thdUxI?=
 =?utf-8?B?UVIyd3I3VnErYWdrUjVtaS91YXZ2Z0xURndFeEZFTDROZGxXZDVJS0VwN0xB?=
 =?utf-8?B?cXBEUWdMdEdEN29xVG1ERHA5MU5ZL0FTWUo0TDVTbTVWNjhZUDAyc3BWeHh5?=
 =?utf-8?B?U0NSNVB2R1I1NDB6NTZJYUVTV0JXS2tzZERlZ1ByU1BjUHIwN1p4aUNQUG1Z?=
 =?utf-8?B?UTRFZ2hKbXhnUmV5NXhSUXAyRmFwck9BQ2dPcXdqNlU2MUo3cTc1M2o2OE8r?=
 =?utf-8?B?OTBrMmhaQm4yOGhXQjZldll5NTQ1MHA0RlAzRDRTZXp6d3NRdHdqaVYreW0x?=
 =?utf-8?B?dGtwVFVNbmRWc1N2aksvNXJtVU1QTzlKQmFGT2EvZ0JyTk54NTR6ZG9TR2VO?=
 =?utf-8?B?VDg3MGtERXd2SEQ3eElXOXdqN3N4QXFRMUMxeXp6dVY2em92ZGd5ZHd1eCtZ?=
 =?utf-8?B?Y1U3a1VqeHVFV0kwYi9Iclg2UFRQNjJMK3N3cDlqNHFwcUlhU3d3UkhDUElq?=
 =?utf-8?B?N2ZEbURsbGVOYmQ5L0o0dWpzdmlYUjVQRzNTQXVFSldydmZ3Tkd4cUFYd1hL?=
 =?utf-8?B?WFR1SHB2dUY5MjRhZHIzNENXSTkvV0daaXZWRFlUZk9UK0hRQVBXWlJYZXNE?=
 =?utf-8?B?blZCQkc5T3FyclpHeXA4dU1QRmlzTjNpVVhYbkRuWWZTQitqL0hLVWVYcVRD?=
 =?utf-8?B?bUpHa1FUNDUwY3p0TkRTWThQczJvam1OS2p2WnFuWDVoUWUxUXBBa2FubE5X?=
 =?utf-8?B?dStIZmR5VE4zcllMdzJEUXpBOE9OcDhxOXU0cFNkazVlQ21ud25xLzhQd3RZ?=
 =?utf-8?B?S0ZQbEJGSFRzNERBV2Y4K2FJeXY4Z2gxeVZ0RmZFbEdlUkZwcm1JZndFUVd2?=
 =?utf-8?B?QnNvRm1wOVUvN3JYcmh6ZzVwNC9odE50VzRPdTVISSsxaGFTbGlpVTFZa1N0?=
 =?utf-8?B?Q2F4QXgvUm1Obi9HMGo4Y1ZKNXVpMGh4YXRBUUx0aUdaK3pjZFc1TW5mdEFO?=
 =?utf-8?B?TlRqdnZKMUtCUzRBUXhRaFV1c3J2MHZOZUUwd2hhajVoOGxFUkZNWTJiZjlN?=
 =?utf-8?B?RDdrU1dYQk5BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0hCd1FZQ1VXQ1lPOGN2blZBZVE2cGtabHFNdTEwOTdqQTBYQ1FGT1FHYWJx?=
 =?utf-8?B?SFFPUlVyNFRQMHl2MlBkWnBISlhIaXBBR215c1ZicDQ1UU5jSzRtN2lqV1Z6?=
 =?utf-8?B?UlVpSWR6QTVpUnVuV055dkNYSEIwcFgxYTJXSVUrRHhvZFlkSDV2TmczR2xC?=
 =?utf-8?B?L1cwYy9pSTVYZWRYU0lERzJDSUJ6SzdNSFF4MkIrRnI5dTkwWDhEVE5nWVMv?=
 =?utf-8?B?LzNMNmphSnRZSWM2dWFRUHhzWkMxaWh4MnM5KzI2blhEUW9BdHc0aG9JczB2?=
 =?utf-8?B?Z2dITkhHbzNhc0FuODdQdGo4bk5ubmt5MTUzYktiOE5QcDFjSDdNcmtmL3NO?=
 =?utf-8?B?ajhGeUhkZUwyQ210VFhVZHBFOUxyL3c0YysyNkRiOWFMSmlmaGo0cVBsVnRG?=
 =?utf-8?B?STdzeFhUMDVJUkNDU3VVaStEOVk3WGJidG9vVzJrdnR0dDZWUVBUR2dTaDcz?=
 =?utf-8?B?RnN1OEVDWEk2M0FhbHdPVWVFYUR5RXdTdVIrcHlEQ3lVU2s1eEZVU0VEV0k0?=
 =?utf-8?B?TWxCRzlXaFI4SE9GdlBkRFJiSzdpaWRvbm1LWVdvR2RUbFRlMHZVK1NEVWJJ?=
 =?utf-8?B?TEhWZVpCZEE3aXIzS2F6OUJSc1RrT0JZL3VFSVZFam05bkxGRU53VlQzZzRp?=
 =?utf-8?B?cDdHdzZLVVR3ZVYrQ2pSbE1iYzBLMWp1OWZacGZ2VEZJMS8yV21wclF2dmIz?=
 =?utf-8?B?R0RMR3FVZG5na09MaVZXV3hBcW1kYnNkMGIybU90TnJKcXRYeDkzdkNnSGsz?=
 =?utf-8?B?dTZmWEhkTXM5UGtTNy9tR0ZhSzFzeTB6cEhYN2tzaHphRFE4aGhVa2VoZ0NU?=
 =?utf-8?B?NVM1U0tqUVY2VHUxcXZmVHlSMlhqUTRaUzVpZEVkUmZESndmeWVyL1lOREgw?=
 =?utf-8?B?TGFiclNvUkJkNFhYd3BIZ2VadU83NjFYSnE5VVRwQlhSMWNKR1llVnJ3MkhB?=
 =?utf-8?B?d1hKdFg1OFliSjBSNUJ3SkZSU2ZXQnpjczVoeVdFeFNyMUhWbnV3blN6eFpH?=
 =?utf-8?B?Ri9ORmZIVFZXaXV4UDRQNlFzaUFSNTd2eUFGWFJYREkwMGdOMFg1ZHhMZ0Iy?=
 =?utf-8?B?Z3NoYkMxS1duUkQzTnhuN2w0NGhabW82WVUwQncxT1ZHZys1OEJuN3RPMWNQ?=
 =?utf-8?B?MXArVjdXZ2hJZ3Q0N0lDTHQ5MUFjeEhPdmI0NlArcWxyYVZMQVdNS1RmZVpN?=
 =?utf-8?B?VzNDaE5PQWJDdWlZenB1bUYzOGp3c0ZocWNBenFoV0VZV3o0RllWS05GSG55?=
 =?utf-8?B?eVpzbC9jTmpENGFYaEdSSDVCUVpjVWsySnZNQmZxZGttdnl0TThlU3cvTzJu?=
 =?utf-8?B?aTgveWZ2bWkwb2d3KzhJa0w1VHVWODRsdVFZSWw1bUZ1a2c3d203UnpPVENj?=
 =?utf-8?B?Ri9MZElpK0g0RStyNHNXQnBRUmFpemlXMUYwcVJWbkRvV2NIU1JIUnRxZk01?=
 =?utf-8?B?ODdaclhOL0dVM1h3RmR3NnVKR1RxcXQxUzB0eTl0L29hdWZXTENCdE5DRFVr?=
 =?utf-8?B?Nlpzb3dFditydXJ4OWE3KzRHNDA3VTFLUGRsM0NuRTVzeFdxdm1HUWV0aTBq?=
 =?utf-8?B?OS9tUG0yRkRkY3JTazRvMUt6SXBqVUF4OEZsVDQ0QzVjeTBEcGhaamtTd0tJ?=
 =?utf-8?B?Zmd4VFBCN1hUaEhJODIrN0VzeDlaWGk3bkY0WXJyS2lObk9IOVZ5aHJWcmFp?=
 =?utf-8?B?K3A3MHFLaUFNVnhXYWdVNXNvM2ZUNkhvRURyeUpBaWo3UndBa2xYUUphckk3?=
 =?utf-8?B?bUh3OGZFbUxnOWJ0cU82a1pCa0RGcWpIMTJ4c3VoUml2QjFJbmdtaGxuZEY2?=
 =?utf-8?B?WkNMQVRCVW5BQkZpUXphdnNmYU9zR1VET01OeUsxVHZZV0NZZjNrZ0Q0eWlk?=
 =?utf-8?B?WHlFbENNbGNpa3paNGU1SjFxUERaTlJRUm1Nbm5UckJGbnhvbFpsOHMzQWNh?=
 =?utf-8?B?ZjhWdTdndmorYXZpemw3UzRBVkZDaFBvTURFWUlpTHNGUzgzWGduN0dna2xT?=
 =?utf-8?B?czczUEJIc1V5Ynd2cEttUTkwbW5hRSs5MWovc2tTTmJNUHR5UmdaejVjbHBI?=
 =?utf-8?B?SFdrYVgydjdMRlBQM2YzS1JBemRlS25KYnRNK3RlWGNFQlk3K2pFakRIYm4r?=
 =?utf-8?Q?cMYg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3915a7c-a1c8-4c18-8ef5-08dd985f0381
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 12:00:00.4345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LyPOa6blKKcQYAKXm291+x45AwY+LL3AsXtkFyQ7LabU+Y4V5C3F9gwS2ZjY9UfombMjWXoz4UnQN55wQOo0Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3879
X-Proofpoint-ORIG-GUID: KSYuktYrtnXBj07WEltd7HKYv_or_Yb6
X-Proofpoint-GUID: KSYuktYrtnXBj07WEltd7HKYv_or_Yb6
X-Authority-Analysis: v=2.4 cv=TcyWtQQh c=1 sm=1 tr=0 ts=682dc063 cx=c_pps a=yF+kfS/uWKtSACHbTM5LMQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=3lLte8MRLwuyka7UL0kA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDExOSBTYWx0ZWRfX9GZUm0p/XuJY P2JxfMlbTkH47ldpRiHe9ZBXtP+xdWK9TFQKYTCZzmKoI8tpnc/Iw11v2TLCAuzNA6Nr9xbZXdj huUrXDYtsuG1VqUak7MPGchLdh2YV+2oHxZBvI1nHu26qmbN1zos3uQQ9NKRn0dVDzqywwUng1O
 P28TMVy5qFet7EPZqA6llVRAXaefMBzm4OHonMwEf5ePGK7XOoPMmE7t0uz3BqgW62eptThMW89 W6w34OxHVfwnVlASiv5spwNYFHJKSJr8btCECeI+Wb+ub3ekouhg1a6LHLZDeKiOHT1+sClKlFm zyOwIs/xOwF3mvlq0l8Fmu6AEHSqtC/ylKGAsYErv8uoSLv0nO8fGALTQ/0FZSAmLdpWPkJqtWS
 38peh36zD0qZjzYvNqKyXNRCpebbHUcGn7KJaVSVWLUilw1ko6GrjVmmfIGLiGHpdc8OFYae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1pY2hhbCBTd2lhdGtvd3Nr
aSA8bWljaGFsLnN3aWF0a293c2tpQGxpbnV4LmludGVsLmNvbT4NCj5TZW50OiBXZWRuZXNkYXks
IE1heSAyMSwgMjAyNSAyOjEwIFBNDQo+VG86IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFA
bWFydmVsbC5jb20+DQo+Q2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGt1YmFAa2VybmVsLm9yZzsNCj5kYXZlbUBkYXZlbWxvZnQubmV0OyBw
YWJlbmlAcmVkaGF0LmNvbTsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsNCj5hbmRyZXcrbmV0ZGV2QGx1
bm4uY2g7IFN1bmlsIEtvdnZ1cmkgR291dGhhbSA8c2dvdXRoYW1AbWFydmVsbC5jb20+Ow0KPlN1
YmJhcmF5YSBTdW5kZWVwIEJoYXR0YSA8c2JoYXR0YUBtYXJ2ZWxsLmNvbT47IEhhcmlwcmFzYWQg
S2VsYW0NCj48aGtlbGFtQG1hcnZlbGwuY29tPg0KPlN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtu
ZXQgUEFUQ0ggMS8yXSBvY3Rlb250eDItYWY6IFNldCBMTVRfRU5BIGJpdCBmb3IgQVBSDQo+dGFi
bGUgZW50cmllcw0KPg0KPk9uIFdlZCwgTWF5IDIxLCAyMDI1IGF0IDExOjM4OjMzQU0gKzA1MzAs
IEdlZXRoYSBzb3dqYW55YSB3cm90ZToNCj4+IEZyb206IFN1YmJhcmF5YSBTdW5kZWVwIDxzYmhh
dHRhQG1hcnZlbGwuY29tPg0KPj4NCj4+IFRoaXMgcGF0Y2ggZW5hYmxlcyB0aGUgTE1UIGxpbmUg
Zm9yIGEgUEYvVkYgYnkgc2V0dGluZyB0aGUgTE1UX0VOQSBiaXQNCj4+IGluIHRoZSBBUFJfTE1U
X01BUF9FTlRSWV9TIHN0cnVjdHVyZS4NCj4+DQo+PiBBZGRpdGlvbmFsbHksIGl0IHNpbXBsaWZp
ZXMgdGhlIGxvZ2ljIGZvciBjYWxjdWxhdGluZyB0aGUgTE1UU1QgdGFibGUNCj4+IGluZGV4IGJ5
IGNvbnNpc3RlbnRseSB1c2luZyB0aGUgbWF4aW11bSBudW1iZXIgb2YgaHcgc3VwcG9ydGVkIFZG
cw0KPj4gKGkuZS4sIDI1NikuDQo+Pg0KPj4gRml4ZXM6IDg3M2ExZTNkMjA3YSAoIm9jdGVvbnR4
Mi1hZjogY24xMGs6IFNldHRpbmcgdXAgbG10c3QgbWFwIHRhYmxlIikuDQo+PiBTaWduZWQtb2Zm
LWJ5OiBTdWJiYXJheWEgU3VuZGVlcCA8c2JoYXR0YUBtYXJ2ZWxsLmNvbT4NCj4+IFNpZ25lZC1v
ZmYtYnk6IEdlZXRoYSBzb3dqYW55YSA8Z2FrdWxhQG1hcnZlbGwuY29tPg0KPj4gLS0tDQo+PiAg
Li4uL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfY24xMGsuYyB8IDE1DQo+
PiArKysrKysrKysrKysrLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
bWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1X2NuMTBrLmMNCj4+IGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1X2NuMTBrLmMNCj4+IGluZGV4IDdmYTk4YWViMzY2
My4uMzgzOGMwNGI3OGMyIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFy
dmVsbC9vY3Rlb250eDIvYWYvcnZ1X2NuMTBrLmMNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9jbjEway5jDQo+PiBAQCAtMTUsMTMgKzE1LDE3
IEBADQo+PiAgI2RlZmluZSBMTVRfVEJMX09QX1dSSVRFCTENCj4+ICAjZGVmaW5lIExNVF9NQVBf
VEFCTEVfU0laRQkoMTI4ICogMTAyNCkNCj4+ICAjZGVmaW5lIExNVF9NQVBUQkxfRU5UUllfU0la
RQkxNg0KPj4gKyNkZWZpbmUgTE1UX01BWF9WRlMJCTI1Ng0KPj4gKw0KPj4gKyNkZWZpbmUgTE1U
X01BUF9FTlRSWV9FTkEgICAgICBCSVRfVUxMKDIwKQ0KPj4gKyNkZWZpbmUgTE1UX01BUF9FTlRS
WV9MSU5FUyAgICBHRU5NQVNLX1VMTCgxOCwgMTYpDQo+Pg0KPj4gIC8qIEZ1bmN0aW9uIHRvIHBl
cmZvcm0gb3BlcmF0aW9ucyAocmVhZC93cml0ZSkgb24gbG10c3QgbWFwIHRhYmxlICovDQo+PiBz
dGF0aWMgaW50IGxtdHN0X21hcF90YWJsZV9vcHMoc3RydWN0IHJ2dSAqcnZ1LCB1MzIgaW5kZXgs
IHU2NCAqdmFsLA0KPj4gIAkJCSAgICAgICBpbnQgbG10X3RibF9vcCkNCj4+ICB7DQo+PiAgCXZv
aWQgX19pb21lbSAqbG10X21hcF9iYXNlOw0KPj4gLQl1NjQgdGJsX2Jhc2U7DQo+PiArCXU2NCB0
YmxfYmFzZSwgY2ZnOw0KPj4NCj4+ICAJdGJsX2Jhc2UgPSBydnVfcmVhZDY0KHJ2dSwgQkxLQURE
Ul9BUFIsIEFQUl9BRl9MTVRfTUFQX0JBU0UpOw0KPj4NCj4+IEBAIC0zNSw2ICszOSwxMyBAQCBz
dGF0aWMgaW50IGxtdHN0X21hcF90YWJsZV9vcHMoc3RydWN0IHJ2dSAqcnZ1LCB1MzINCj5pbmRl
eCwgdTY0ICp2YWwsDQo+PiAgCQkqdmFsID0gcmVhZHEobG10X21hcF9iYXNlICsgaW5kZXgpOw0K
Pj4gIAl9IGVsc2Ugew0KPj4gIAkJd3JpdGVxKCgqdmFsKSwgKGxtdF9tYXBfYmFzZSArIGluZGV4
KSk7DQo+PiArDQo+PiArCQljZmcgPSBGSUVMRF9QUkVQKExNVF9NQVBfRU5UUllfRU5BLCAweDEp
Ow0KPj4gKwkJLyogMjA0OCBMTVRMSU5FUyAqLw0KPj4gKwkJY2ZnIHw9IEZJRUxEX1BSRVAoTE1U
X01BUF9FTlRSWV9MSU5FUywgMHg2KTsNCj4+ICsNCj4+ICsJCXdyaXRlcShjZmcsIChsbXRfbWFw
X2Jhc2UgKyAoaW5kZXggKyA4KSkpOw0KPklzIHRoaXMgOCBMTVRfTUFQX1RCTF9XMV9PRkY/IEl0
IGlzbid0IG9idmlvdXMgZm9yIG1lIHdoeSArOCwgYnV0IEkgZG9uJ3QNCj5rbm93IHRoZSBkcml2
ZXIsIHNvIG1heWJlIGl0IHNob3VsZC4NClRoZSBBUFIgdGFibGUgZW50cnkgaXMgMTZCIHdpZGUu
IFRoZSAgRU5UUllfRU5BIGFuZCBFTlRSWV9MSU5FUyBmaWVsZHMgZmFsbHMgaW4gdXBwZXIgOEIu
DQpIZW5jZSBkb2luZyArOC4NCg0KVGhhbmtzLA0KR2VldGhhLg0KPg0KPj4gKw0KPj4gIAkJLyog
Rmx1c2hpbmcgdGhlIEFQIGludGVyY2VwdG9yIGNhY2hlIHRvIG1ha2UNCj5BUFJfTE1UX01BUF9F
TlRSWV9TDQo+PiAgCQkgKiBjaGFuZ2VzIGVmZmVjdGl2ZS4gV3JpdGUgMSBmb3IgZmx1c2ggYW5k
IHJlYWQgaXMgYmVpbmcgdXNlZCBhcw0KPmENCj4+ICAJCSAqIGJhcnJpZXIgYW5kIHNldHMgdXAg
YSBkYXRhIGRlcGVuZGVuY3kuIFdyaXRlIHRvIDAgYWZ0ZXIgYQ0KPndyaXRlDQo+PiBAQCAtNTIs
NyArNjMsNyBAQCBzdGF0aWMgaW50IGxtdHN0X21hcF90YWJsZV9vcHMoc3RydWN0IHJ2dSAqcnZ1
LCB1MzINCj4+IGluZGV4LCB1NjQgKnZhbCwgICNkZWZpbmUgTE1UX01BUF9UQkxfVzFfT0ZGICA4
ICBzdGF0aWMgdTMyDQo+PiBydnVfZ2V0X2xtdHN0X3RibF9pbmRleChzdHJ1Y3QgcnZ1ICpydnUs
IHUxNiBwY2lmdW5jKSAgew0KPj4gLQlyZXR1cm4gKChydnVfZ2V0X3BmKHBjaWZ1bmMpICogcnZ1
LT5ody0+dG90YWxfdmZzKSArDQo+PiArCXJldHVybiAoKHJ2dV9nZXRfcGYocGNpZnVuYykgKiBM
TVRfTUFYX1ZGUykgKw0KPj4gIAkJKHBjaWZ1bmMgJiBSVlVfUEZWRl9GVU5DX01BU0spKSAqDQo+
TE1UX01BUFRCTF9FTlRSWV9TSVpFOw0KPg0KPkp1c3Qgbml0L3F1ZXN0aW9uLCBwYXRjaCBsb29r
cyBmaW5lDQo+UmV2aWV3ZWQtYnk6IE1pY2hhbCBTd2lhdGtvd3NraSA8bWljaGFsLnN3aWF0a293
c2tpQGxpbnV4LmludGVsLmNvbT4NCj4NCj4+ICB9DQo+Pg0KPj4gLS0NCj4+IDIuMjUuMQ0K

