Return-Path: <netdev+bounces-216000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39769B31526
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 12:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02D0A02FA8
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 10:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633692D7DE3;
	Fri, 22 Aug 2025 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="x39ILH+Z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B972D7DD9
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857877; cv=fail; b=pkkBhsex0mvMdRJgpbrVqXy24AtWujnfhPvaZFx9CjWpCnIiDUzxOPksTRfk+04JW/MUEKsS4Lk4pAsca0La2k1+F7sh9rUR41bgrwBY3R4wD7VRSgWf9izn5mrAgvPQGjY+VV+17NLUjC6ASOSW4dhnxFPJEA92VbmVISWcz9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857877; c=relaxed/simple;
	bh=ULZCUUYEDTYwVDHgUwXRy10bTfduW2HmUMHjH4EQq7c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YVlDgj0Zt31mAwyh2Mdu5AQbJdPje+X7yKAyWMu9ViGasz5SQcG305tmW6Nvs2SPn0hGJabHce1b1bnRBsQ1gZqp96XS3NJAQzHkG0rMFd0fPkJqONv3aqnI45tQ/7ZGtyKv5xaGHgRSHTdtvqO2jbt2R/bMyGL0o5LzQjyYQQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=x39ILH+Z; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkN8aLMJYndZzsYaKSqzmEWyyb+2R+NmUTaylv4sBoi3OohgLOBwwrF3msSxVFMgCmBsVlCPWT+5XkGUKqIL3Uiku1edh9wsVqUhfSa2YNP6ZVI8z3fYH8aQLnsmOT7CcqidW1SX7q+p1yaLfadnMWPVOZOCbumTH3DY5Kpf/8tsdbuNCVwUVcLOUbcfwkCfETu+mJN8Fl01o3wQxVl1xH1NgAItE0hV7ATntY4ujkJcrwZQ62/+K+xNfylcpZgUSlCJtZhYxTajkwi7oYcQfvPy52fc2ixUK71I7xaslOf5nAsyFBCUA69fbjdw4Kc810j7SFzBwFVHv+LZSMuVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULZCUUYEDTYwVDHgUwXRy10bTfduW2HmUMHjH4EQq7c=;
 b=JHZImBJgZJEyZTidYlPDDoBY2HVvNR8h7A/67zFp6W17m91QBex8kKLLmO1nVSsBH8v+4UgUqUR3JIyYGSs0b04ZtpNI69tjYMHZK/7yBEKdDVftbDlsfW9e/7pf6y7XV8WzHNI2VsejCqoI6g2Dc6FdCDtGwV0ELwN3yKXaAKY2c9vjYhKXPR2vtyrjHU/US0ewfh8NNcCzsChY6dEE65HyRFgyzfNZXLHRxDRw28f2mBXnVf8tJd/mHkSIMV6ejQfZaxJvlcBEWdjSOZfhdvy047m0oZj/otcSAO52ru/mwh06SA7IB4GIihkKu3UOQWIqT7i2R/HJoRwxvlknbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULZCUUYEDTYwVDHgUwXRy10bTfduW2HmUMHjH4EQq7c=;
 b=x39ILH+Z9id020vQbTuAgZP2Spaf17+JKCUUJSzCMHGTRmTw9Mf+ZOFDXCvpB+dNASTlV7LPC2GuBj8r2uOF2b63St3t0Nvtheo89Ub4Z9oo+jT6Y8okG/i+p1QNoO3n2bH2ZFPfZESUu2aMTue54/0MzyEBjr+Fl4rTNWy6GKS/pUaOBHvckKmBnUDWQp2Juq/ltTrsvNPjPOFKUqbQM/1JP6/jw4lFimI18802N+VCDlI9EQyggEHAhSxt+Qz0nqlsNy0roqdkuxXDAJhzXUcst+X4ipbYT3ExC41ps2FvvwmVy4MEeB5HZ+Tz5ur+6iob7fjCDTzUTWL/pKSmpg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by BL1PR11MB5953.namprd11.prod.outlook.com (2603:10b6:208:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Fri, 22 Aug
 2025 10:17:52 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%7]) with mapi id 15.20.8989.011; Fri, 22 Aug 2025
 10:17:51 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Horatiu.Vultur@microchip.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: phy: micrel: Add PTP support for
 lan8842
Thread-Topic: [PATCH net-next 2/2] net: phy: micrel: Add PTP support for
 lan8842
Thread-Index: AQHcE0krdOv+uKVIP0OcXezJndoperRudXQA
Date: Fri, 22 Aug 2025 10:17:51 +0000
Message-ID: <0072c273-ed0b-4008-846a-2de23f7e7bfd@microchip.com>
References: <20250822092714.2554262-1-horatiu.vultur@microchip.com>
 <20250822092714.2554262-3-horatiu.vultur@microchip.com>
In-Reply-To: <20250822092714.2554262-3-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|BL1PR11MB5953:EE_
x-ms-office365-filtering-correlation-id: b0b36019-dbfd-4894-387e-08dde165268f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y1ladXNTTFltTzZROTU2TUVOb3psT2RkTUpxQ0s5S2xDaitBSHpsR1ZET3Ns?=
 =?utf-8?B?OXN0ZkRrTm1aS2JtNmlLT2l0MzgxTEdvYjc0NzljNWZPcGE1clovOFoxNERF?=
 =?utf-8?B?d2thbS80YkF6MzEyRVZjQ3VyeGovZTFSUzR1MWNRQXhTTjRWT1hTd3paRGFo?=
 =?utf-8?B?NFRkL1pmV2g4bk9renRMcDZUNmFVd0lKT1N6dGh1TUplbmxnTXg4T051MnBn?=
 =?utf-8?B?ZUpBblV0Y3BqN1czMVZTRERMTFlWeTd4VXVZU3o4MjJVeDZQckFhRDlSVWZ6?=
 =?utf-8?B?Tmo2bjE0YlYwVFBLR2sxdVpYNlV0MHh3SHljTnVNTXk4dXVFZnBnVnNFVWUw?=
 =?utf-8?B?UUI1SWlRTElkdUJMSnF5UXhPaitxemgyODE2bzk1MnJrRHBtU0ZhRXN3eFM4?=
 =?utf-8?B?dTlHbDlMOGJwZ3RHTFp6bG1JeHBURUxKWmVndmdGY0tuMWVzSFNBelpqNnlu?=
 =?utf-8?B?dU03U0huWVlrUm91MlBja3BYSHB0MHJoaHFEdDd1aXEyczJlN201QmlBVEFP?=
 =?utf-8?B?TmFsU2V4OUNuMUxQeHhZejlBUkQ1TzRkdmlsQmgzSEFZaXlkS3JMSkpYS1g0?=
 =?utf-8?B?bjZDQytyOFBYa0FLLytMTEd6UGE2V2RSelQ4YUNPUUxrN3RUNkttbHk4cFhh?=
 =?utf-8?B?Zmk5OENQSDJQYkdNMFR2eFgyblJWVjdQSHRwdmJ2OWh4U1VIc0RJcndLM09G?=
 =?utf-8?B?Ny9pb2tHdXpVRVBVMTVNQnlIR3I1ckNRbHhyTWlJSkRRSWoxbFVHTFJDNHZn?=
 =?utf-8?B?YW9RNHpzUE94cllVYnpOVHFlNTJCODgzd29ZWmoxZllhQ1JMVy9FZTlIcFA5?=
 =?utf-8?B?NlNtbXdJelJnYVdJSk1hZkJ4UzlFRVJTRXRzeXF5RHhmUlk4MlJCeUxONXpu?=
 =?utf-8?B?WXljTGI1NDVwZkc1WVBHc0ZRMkNHWkJaTmtKVTdOMzdIdlNEZHc0WEl0RkRT?=
 =?utf-8?B?VUF1anY3TVBkWjVBUkw0OUQxeDdYT1JlSDhpbDJ1MlhyMElSaGlQbzNxQTl4?=
 =?utf-8?B?K1VVcnFjRUpLR0R6eC9JSFRDb1FNaHFKMmZBd3ZVNmNycnFuYlVKWU4xNElm?=
 =?utf-8?B?Z0NPRlVJT0o3VVhkY1ZUOFpxWG5hS0c4OUZWWHBGOU5vQXgvV3lhVS9KczV5?=
 =?utf-8?B?RGcyMk53UE9Eb1RVNUNLd1NCOHU4RnBnbzZGbENVdWxwNmUweDlOb0FSbHNv?=
 =?utf-8?B?N3Z5bUM1aG40WWMzTzA1WHJ0V0tQWmlSOUN6OFcvODFKSTZndi9POTVqMXpL?=
 =?utf-8?B?NExTSXc3bkNJNXpUVnBQMzlkN3FUNTI0c2ZFQ25EZ2VNS29OQWViMERBYVlB?=
 =?utf-8?B?TExQNjY2ekZoYW03Rk9CL3JobUxucmppM2Q3SG9uRU03SUMvNGdrQlZyWkFW?=
 =?utf-8?B?V2RtZUx1Uzd2R2RERHA3NjlDc2wvTzRCaXFrdnVoTGlPV1BjbXRab1B0Q0Y4?=
 =?utf-8?B?cHduTDBCVGllOE5QTGV1TEYvbkdwd0k4STJlZzlQbHRpc2VtZzA2MmsxanlU?=
 =?utf-8?B?SVlORUdRM3pBUTFjT0xoeUFEVUlYdkwyblMycGVpZzlDMGJhbU11NG5pUERj?=
 =?utf-8?B?c0RFNHcxU2RKdktRWEJnOGphd2pYdDhlTDhnNkRidzhBSGlKcFdDYmtFSjVP?=
 =?utf-8?B?SW5yRzZtRm9OQWhoTFZQcjBhVmRBMnpSRDZuTmQzblFnRmJUejhFM3BYN0J4?=
 =?utf-8?B?MkJwc2ZXUHJjQTJSSWg5aUlQNVFYWkdXejZ4Y0FlT1NIc1E2TGczL0hKbG5V?=
 =?utf-8?B?bE1SdTRQU3hXK3AzL244bFZBQjlqOUg0TTRZS0xiWFRNcFdVd3NUMDc3NW1u?=
 =?utf-8?B?Ly9scVBQZS8xNHM4V0ZranlEZ1ZaZWlXZTNqMzR4WU9WemJWV2ZkYlZQK010?=
 =?utf-8?B?aExTNDVzTDBjUVNlcFZESy9tZkF6MGwvRmRaZmZ3TUp5eG5EMC8rQW44elRH?=
 =?utf-8?B?cUdVRkN6YVBsU1ZqdmwvQTlqejZwVE1iVFNmRkR0Wkd2V1o2NW9ObUFpS3Ix?=
 =?utf-8?Q?Pml45w6kfmyEPpgDV+FhulsQWIwcQE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzUxSWg4NEk0Um9URlMxdXRicXhqTHkvdWx6NEJvY3hxUE5JTURmUk4wWHVz?=
 =?utf-8?B?cjZ3cXdWN3RhK204MkVVdlcyMUtkajVZREdMTCtnaXV4RitVbTFTQjRsK3Bp?=
 =?utf-8?B?VC9RakIveFNUQUg5T3QzbU16d3JXQ2NBMnNTY2tBemo3V0NCOUxHelNyN1lY?=
 =?utf-8?B?bDM5dmV2dzRaKzU5MmViemxrSlRqYXVZQ0pRZW9zaWk2djU5dzlORVJoMnZx?=
 =?utf-8?B?YmxML3V1eUEvZWlWZ0lMaGdZVXJKa0gyWWVKU1A3OFYramdJSTFSSDdHRisw?=
 =?utf-8?B?SVN0MkQzd3k3bTcwRjIxQkxzT2o1WmxNa1p0WmFkbUd1M0tvSHVKSDhIT1lI?=
 =?utf-8?B?MXNJVU53elZYZGFWTHR0ZXVOUmxKVVA4VG5PMXFwYndwZTRoY1oxQ0kyOUtV?=
 =?utf-8?B?aU1wYUNZOFBaUlVnM0ZBTEVuamFtOGdSVGc2RWxxb3NuQW9NV1ljd0tod21H?=
 =?utf-8?B?U09iekJoQkdkdVFWRkpFNnlwbFNmWWxoNTFPVVpuam8xTXlnaEM4U3luTTFr?=
 =?utf-8?B?SDdkazVkWWF2TGlYekNhbk1jK0dpcS93RGtEaGRWZEZsb1JWMU5zV3R6QWxZ?=
 =?utf-8?B?ZFpmNEhtVmVaVzY4RDd0amNoNkdWWHlyUGdqWnlHSGpLd0xIblpCRzRRdVdJ?=
 =?utf-8?B?VEpFeFJDb0ladVBjRmMyZnYybzB5UzNXb0tJUEN5bTdWY2w0UE8wcmxPYU9z?=
 =?utf-8?B?aWY4cUhPb2FlNHlUMmc4QktyZ1Nacm45R0dHaExWWkdVaEl0cmdmV3hmbXE3?=
 =?utf-8?B?WnRlM0t4SGJ5RnVhdWs1RG93bHMreVByRHlsOExkU09CSlA3eHIzSGduU256?=
 =?utf-8?B?UjNRdkJYTEZmSVFqbFJJWEhsRWw4YjlSbWhCY1J2N2tzWmZhZkEyMG9JVGhC?=
 =?utf-8?B?YXBtZjYrMkNmTFRwTmdDOHBDcUJIcUEramphS1NUUjlCYkgvN1RESWpaT2lH?=
 =?utf-8?B?bGh2NnFzMXlGejVXTWx3Q29RZUVCQU1raHFnUXR3TFBwTlV2ZUxHYkxnZ3VI?=
 =?utf-8?B?Wkg0QkpwRlREeDRqS1RjdXpoZ2dvVi9qQ1dTMWpKb3dZUDUvK2x3andBNW95?=
 =?utf-8?B?Zy9Jd09CRm1QaTRjRHNaN085N0M4SVNIUUowNktPZC9JWE1RZTl2TllmUzkr?=
 =?utf-8?B?eEU1c2kwZlQxUkx6VFRncWd2eU9qY25YVlVLOHNvRTZHUjNUSmdFTGVGOElV?=
 =?utf-8?B?anZ5L2MvcWpUK1VOUE5Yd2Q2WWw5K04zTjVjOFNrRjhFMVc0Q0lkSjlkMnVx?=
 =?utf-8?B?WGxjTE9SZEY2NmJuRVpzelRWWDRPUDZBQlQ1M2ppbVB3dGt3OVloQnVKNVpH?=
 =?utf-8?B?TU5tdkVyU21qeE5jN01jTXJ0WGVXSHlrdVpBRmZGYWc5Q3BTWjRWL0VCTmxE?=
 =?utf-8?B?ZlBMcjVkeEh4Y3NZY3RZc3RVTlVQUXBiZ1JoSlBrcHlHODhWZFh5cWdRTzRZ?=
 =?utf-8?B?UElWeWlKNFQ5Qjh5am1mYWw4YXZhNFVYcFBHS2pyb3NWNWxHRytrWWNIOThN?=
 =?utf-8?B?OG1aQklOeGcxNERYL3RTeVlsU3BOK3NZWnZmOXN4UlRiVnowVDJkT0VScWl5?=
 =?utf-8?B?Yjc5Z05jSTB0eUtpT25xamNzSWdQSlNKb0NFbjlBUWI2d3ZrM1VFR1lCVVcv?=
 =?utf-8?B?dFNRa1ZkQmVBOGF3OVYyL01zMzFva3dGWlVsSzVnRUMrcGJtbkpMY2FIcGl6?=
 =?utf-8?B?Ty9YcUR3VzNSV0NYVGdoVCtROXZXY1NMNUVwWTZPais2bUpEVDhORjJMS0kw?=
 =?utf-8?B?TEhJT3VBOUluVnkyWkIxK1M0M2dlNW84LzR2cUhYdWlLcW9uQXVIc01NdVht?=
 =?utf-8?B?UTRrWjkyZUFuOXNxQUNJV09vN3NSSGd1RjFRcEdUN2wwZkE1UFp5WEsvTmtF?=
 =?utf-8?B?NE4vWDZpeXBaZGZxZXRSeWNRcEpUMXJyR3VxUUllK1Q1MFZicTg2RlJTZCtB?=
 =?utf-8?B?UWxsOHY3ZVE0QTlDRWVJaVB3QVBCWWJaUVYyWjZKTE0wdytXZ1dldVlUV3Zp?=
 =?utf-8?B?dTBpOUduSk1SRW45OG5XRDFpU01mOXQ0MlZjZC9EeXMwTy9yQnZBV0hieGNJ?=
 =?utf-8?B?N25haUZNUUx6cWw2d2Y5UnQrRzg3TGlhcEVlZWJXQTgzZ2RvbW01KzJPMStx?=
 =?utf-8?B?MC8zQ2tXUHZqa0FjSDkvZTlZVzYvaEJOdW5FR0RkeHBnYmxidXBNeW5OL0NJ?=
 =?utf-8?Q?ODLE+giI5GDxFG+brTX6NPI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDE7E8844242BE44A595F8B8A289BF3E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b36019-dbfd-4894-387e-08dde165268f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 10:17:51.1249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5YC1Gi8ArXp0ICjbcMG09ELv7V4TF9YLCoDbhIznBWRe5WUShb0U84Q5F0KNM75bQQCp3ou+VKAyHUD9swqurSr9NVY+fS0BZH/a3ZRSCULgcgKe7r4Jgf5HoQKrFb+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5953

SGkgSG9yYXRpdSwNCg0KT24gMjIvMDgvMjUgMjo1NyBwbSwgSG9yYXRpdSBWdWx0dXIgd3JvdGU6
DQo+IEl0IGhhcyB0aGUgc2FtZSBQVFAgSVAgYmxvY2sgYXMgbGFuODgxNCwgb25seSB0aGUgbnVt
YmVyIG9mIEdQSU9zIGlzDQo+IGRpZmZlcmVudCwgYWxsIHRoZSBvdGhlciBmdW5jdGlvbmFsaXR5
IGlzIHRoZSBzYW1lLiBTbyByZXVzZSB0aGUgc2FtZQ0KPiBmdW5jdGlvbnMgYXMgbGFuODgxNCBm
b3IgbGFuODg0Mi4NCj4gVGhlcmUgaXMgYSByZXZpc2lvbiBvZiBsYW44ODQyIGNhbGxlZCBsYW44
ODMyIHdoaWNoIGRvZXNuJ3QgaGF2ZSB0aGUgUFRQDQo+IElQIGJsb2NrLiBTbyBtYWtlIHN1cmUg
aW4gdGhhdCBjYXNlIHRoZSBQVFAgaXMgbm90IGluaXRpYWxpemVkLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogSG9yYXRpdSBWdWx0dXIgPGhvcmF0aXUudnVsdHVyQG1pY3JvY2hpcC5jb20+DQo+IC0t
LQ0KPiAgIGRyaXZlcnMvbmV0L3BoeS9taWNyZWwuYyB8IDkwICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgOTAgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3BoeS9taWNyZWwuYyBiL2RyaXZlcnMv
bmV0L3BoeS9taWNyZWwuYw0KPiBpbmRleCA0MmFmMDc1ODk0YmVjLi44N2VkOGNmMDlmOGQyIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9waHkvbWljcmVsLmMNCj4gKysrIGIvZHJpdmVycy9u
ZXQvcGh5L21pY3JlbC5jDQo+IEBAIC00NTcsNiArNDU3LDkgQEAgc3RydWN0IGxhbjg4NDJfcGh5
X3N0YXRzIHsNCj4gICANCj4gICBzdHJ1Y3QgbGFuODg0Ml9wcml2IHsNCj4gICAJc3RydWN0IGxh
bjg4NDJfcGh5X3N0YXRzIHBoeV9zdGF0czsNCj4gKwlpbnQgcmV2Ow0KPiArCXN0cnVjdCBwaHlf
ZGV2aWNlICpwaHlkZXY7DQo+ICsJc3RydWN0IGtzenBoeV9wdHBfcHJpdiBwdHBfcHJpdjsNCj4g
ICB9Ow0KPiAgIA0KPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3Qga3N6cGh5X3R5cGUgbGFuODgxNF90
eXBlID0gew0KPiBAQCAtNTc4Niw2ICs1Nzg5LDE3IEBAIHN0YXRpYyBpbnQga3N6OTEzMV9yZXN1
bWUoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikNCj4gICAJcmV0dXJuIGtzenBoeV9yZXN1bWUo
cGh5ZGV2KTsNCj4gICB9DQo+ICAgDQo+ICsjZGVmaW5lIExBTjg4NDJfUFRQX0dQSU9fTlVNIDE2
DQo+ICsNCj4gK3N0YXRpYyBpbnQgbGFuODg0Ml9wdHBfcHJvYmVfb25jZShzdHJ1Y3QgcGh5X2Rl
dmljZSAqcGh5ZGV2KQ0KPiArew0KPiArCXJldHVybiBfX2xhbjg4MTRfcHRwX3Byb2JlX29uY2Uo
cGh5ZGV2LCAibGFuODg0Ml9wdHBfcGluIiwNCj4gKwkJCQkJTEFOODg0Ml9QVFBfR1BJT19OVU0p
Ow0KPiArfQ0KPiArDQo+ICsjZGVmaW5lIExBTjg4NDJfU1RSQVBfUkVHCQkJMCAvKiAweDAgKi8N
Cj4gKyNkZWZpbmUgTEFOODg0Ml9TVFJBUF9SRUdfUEhZQUREUl9NQVNLCQlHRU5NQVNLKDQsIDAp
DQo+ICsjZGVmaW5lIExBTjg4NDJfU0tVX1JFRwkJCQkxMSAvKiAweDBiICovDQo+ICAgI2RlZmlu
ZSBMQU44ODQyX1NFTEZfVEVTVAkJCTE0IC8qIDB4MGUgKi8NCj4gICAjZGVmaW5lIExBTjg4NDJf
U0VMRl9URVNUX1JYX0NOVF9FTkEJCUJJVCg4KQ0KPiAgICNkZWZpbmUgTEFOODg0Ml9TRUxGX1RF
U1RfVFhfQ05UX0VOQQkJQklUKDQpDQo+IEBAIC01NzkzLDYgKzU4MDcsNyBAQCBzdGF0aWMgaW50
IGtzejkxMzFfcmVzdW1lKHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYpDQo+ICAgc3RhdGljIGlu
dCBsYW44ODQyX3Byb2JlKHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYpDQo+ICAgew0KPiAgIAlz
dHJ1Y3QgbGFuODg0Ml9wcml2ICpwcml2Ow0KPiArCWludCBhZGRyOw0KPiAgIAlpbnQgcmV0Ow0K
PiAgIA0KPiAgIAlwcml2ID0gZGV2bV9remFsbG9jKCZwaHlkZXYtPm1kaW8uZGV2LCBzaXplb2Yo
KnByaXYpLCBHRlBfS0VSTkVMKTsNCj4gQEAgLTU4MDAsNiArNTgxNSw3IEBAIHN0YXRpYyBpbnQg
bGFuODg0Ml9wcm9iZShzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0KPiAgIAkJcmV0dXJuIC1F
Tk9NRU07DQo+ICAgDQo+ICAgCXBoeWRldi0+cHJpdiA9IHByaXY7DQo+ICsJcHJpdi0+cGh5ZGV2
ID0gcGh5ZGV2Ow0KPiAgIA0KPiAgIAkvKiBTaW1pbGFyIHRvIGxhbjg4MTQgdGhpcyBQSFkgaGFz
IGEgcGluIHdoaWNoIG5lZWRzIHRvIGJlIHB1bGxlZCBkb3duDQo+ICAgCSAqIHRvIGVuYWJsZSB0
byBwYXNzIGFueSB0cmFmZmljIHRocm91Z2ggaXQuIFRoZXJlZm9yZSB1c2UgdGhlIHNhbWUNCj4g
QEAgLTU4MTcsNiArNTgzMywzOCBAQCBzdGF0aWMgaW50IGxhbjg4NDJfcHJvYmUoc3RydWN0IHBo
eV9kZXZpY2UgKnBoeWRldikNCj4gICAJaWYgKHJldCA8IDApDQo+ICAgCQlyZXR1cm4gcmV0Ow0K
PiAgIA0KPiArCS8qIFJldmlzaW9uIGxhbjg4MzIgZG9lc24ndCBoYXZlIHN1cHBvcnQgZm9yIFBU
UCwgdGhlcmVmb3JlIGRvbid0IGFkZA0KPiArCSAqIGFueSBQVFAgY2xvY2tzDQo+ICsJICovDQo+
ICsJcHJpdi0+cmV2ID0gbGFucGh5X3JlYWRfcGFnZV9yZWcocGh5ZGV2LCBMQU44ODE0X1BBR0Vf
Q09NTU9OX1JFR1MsDQo+ICsJCQkJCSBMQU44ODQyX1NLVV9SRUcpOw0KPiArCWlmIChwcml2LT5y
ZXYgPCAwKQ0KPiArCQlyZXR1cm4gcHJpdi0+cmV2Ow0KPiArCWlmIChwcml2LT5yZXYgPT0gMHg4
ODMyKQ0KPiArCQlyZXR1cm4gMDsNCj4gKw0KPiArCS8qIEFzIHRoZSBsYW44ODE0IGFuZCBsYW44
ODQyIGhhcyB0aGUgc2FtZSBJUCBmb3IgdGhlIFBUUCBibG9jaywgdGhlDQo+ICsJICogb25seSBk
aWZmZXJlbmNlIGlzIHRoZSBudW1iZXIgb2YgdGhlIEdQSU9zLCB0aGVuIG1ha2Ugc3VyZSB0aGF0
IHRoZQ0KPiArCSAqIGxhbjg4NDIgaW5pdGlhbGl6ZWQgYWxzbyB0aGUgc2hhcmVkIGRhdGEgcG9p
bnRlciBhcyB0aGlzIGlzIHVzZWQgaW4NCj4gKwkgKiBhbGwgdGhlIFBUUCBmdW5jdGlvbnMgZm9y
IGxhbjg4MTQuIFRoZSBsYW44ODQyIGRvZXNuJ3QgaGF2ZSBtdWx0aXBsZQ0KPiArCSAqIFBIWXMg
aW4gdGhlIHNhbWUgcGFja2FnZS4NCj4gKwkgKi8NCj4gKwlhZGRyID0gbGFucGh5X3JlYWRfcGFn
ZV9yZWcocGh5ZGV2LCBMQU44ODE0X1BBR0VfQ09NTU9OX1JFR1MsDQo+ICsJCQkJICAgIExBTjg4
NDJfU1RSQVBfUkVHKTsNCj4gKwlhZGRyICY9IExBTjg4NDJfU1RSQVBfUkVHX1BIWUFERFJfTUFT
SzsNCj4gKwlpZiAoYWRkciA8IDApDQo+ICsJCXJldHVybiBhZGRyOw0KPiArDQo+ICsJZGV2bV9w
aHlfcGFja2FnZV9qb2luKCZwaHlkZXYtPm1kaW8uZGV2LCBwaHlkZXYsIGFkZHIsDQo+ICsJCQkg
ICAgICBzaXplb2Yoc3RydWN0IGxhbjg4MTRfc2hhcmVkX3ByaXYpKTsNCj4gKwlpZiAocGh5X3Bh
Y2thZ2VfaW5pdF9vbmNlKHBoeWRldikpIHsNCj4gKwkJcmV0ID0gbGFuODg0Ml9wdHBfcHJvYmVf
b25jZShwaHlkZXYpOw0KPiArCQlpZiAocmV0KQ0KPiArCQkJcmV0dXJuIHJldDsNCj4gKwl9DQo+
ICsNCj4gKwlsYW44ODE0X3B0cF9pbml0KHBoeWRldik7DQo+ICsNCj4gICAJcmV0dXJuIDA7DQo+
ICAgfQ0KPiAgIA0KPiBAQCAtNTg5Niw4ICs1OTQ0LDMxIEBAIHN0YXRpYyBpbnQgbGFuODg0Ml9j
b25maWdfaW5iYW5kKHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYsIHVuc2lnbmVkIGludCBtb2Rl
cykNCj4gICAJCQkJICAgICAgZW5hYmxlID8gTEFOODgxNF9RU0dNSUlfUENTMUdfQU5FR19DT05G
SUdfQU5FR19FTkEgOiAwKTsNCj4gICB9DQo+ICAgDQo+ICtzdGF0aWMgdm9pZCBsYW44ODQyX2hh
bmRsZV9wdHBfaW50ZXJydXB0KHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYsIHUxNiBzdGF0dXMp
DQo+ICt7DQo+ICsJc3RydWN0IGxhbjg4NDJfcHJpdiAqcHJpdiA9IHBoeWRldi0+cHJpdjsNCj4g
KwlzdHJ1Y3Qga3N6cGh5X3B0cF9wcml2ICpwdHBfcHJpdiA9ICZwcml2LT5wdHBfcHJpdjsNClBs
ZWFzZSBmb2xsb3cgcmV2ZXJzZSBDaHJpc3RtYXMgdHJlZSBzdHlsZS4NCg0KQmVzdCByZWdhcmRz
LA0KUGFydGhpYmFuIFYNCj4gKw0KPiArCWlmIChzdGF0dXMgJiBQVFBfVFNVX0lOVF9TVFNfUFRQ
X1RYX1RTX0VOXykNCj4gKwkJbGFuODgxNF9nZXRfdHhfdHMocHRwX3ByaXYpOw0KPiArDQo+ICsJ
aWYgKHN0YXR1cyAmIFBUUF9UU1VfSU5UX1NUU19QVFBfUlhfVFNfRU5fKQ0KPiArCQlsYW44ODE0
X2dldF9yeF90cyhwdHBfcHJpdik7DQo+ICsNCj4gKwlpZiAoc3RhdHVzICYgUFRQX1RTVV9JTlRf
U1RTX1BUUF9UWF9UU19PVlJGTF9JTlRfKSB7DQo+ICsJCWxhbjg4MTRfZmx1c2hfZmlmbyhwaHlk
ZXYsIHRydWUpOw0KPiArCQlza2JfcXVldWVfcHVyZ2UoJnB0cF9wcml2LT50eF9xdWV1ZSk7DQo+
ICsJfQ0KPiArDQo+ICsJaWYgKHN0YXR1cyAmIFBUUF9UU1VfSU5UX1NUU19QVFBfUlhfVFNfT1ZS
RkxfSU5UXykgew0KPiArCQlsYW44ODE0X2ZsdXNoX2ZpZm8ocGh5ZGV2LCBmYWxzZSk7DQo+ICsJ
CXNrYl9xdWV1ZV9wdXJnZSgmcHRwX3ByaXYtPnJ4X3F1ZXVlKTsNCj4gKwl9DQo+ICt9DQo+ICsN
Cj4gICBzdGF0aWMgaXJxcmV0dXJuX3QgbGFuODg0Ml9oYW5kbGVfaW50ZXJydXB0KHN0cnVjdCBw
aHlfZGV2aWNlICpwaHlkZXYpDQo+ICAgew0KPiArCXN0cnVjdCBsYW44ODQyX3ByaXYgKnByaXYg
PSBwaHlkZXYtPnByaXY7DQo+ICAgCWludCByZXQgPSBJUlFfTk9ORTsNCj4gICAJaW50IGlycV9z
dGF0dXM7DQo+ICAgDQo+IEBAIC01OTEyLDYgKzU5ODMsMjUgQEAgc3RhdGljIGlycXJldHVybl90
IGxhbjg4NDJfaGFuZGxlX2ludGVycnVwdChzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0KPiAg
IAkJcmV0ID0gSVJRX0hBTkRMRUQ7DQo+ICAgCX0NCj4gICANCj4gKwkvKiBQaHkgcmV2aXNpb24g
bGFuODgzMiBkb2Vzbid0IGhhdmUgc3VwcG9ydCBmb3IgUFRQIHRocmVyZWZvcmUgdGhlcmUgaXMN
Cj4gKwkgKiBub3QgbmVlZCB0byBjaGVjayB0aGUgUFRQIGFuZCBHUElPIGludGVycnVwdHMNCj4g
KwkgKi8NCj4gKwlpZiAocHJpdi0+cmV2ID09IDB4ODgzMikNCj4gKwkJZ290byBvdXQ7DQo+ICsN
Cj4gKwl3aGlsZSAodHJ1ZSkgew0KPiArCQlpcnFfc3RhdHVzID0gbGFucGh5X3JlYWRfcGFnZV9y
ZWcocGh5ZGV2LCA1LCBQVFBfVFNVX0lOVF9TVFMpOw0KPiArCQlpZiAoIWlycV9zdGF0dXMpDQo+
ICsJCQlicmVhazsNCj4gKw0KPiArCQlsYW44ODQyX2hhbmRsZV9wdHBfaW50ZXJydXB0KHBoeWRl
diwgaXJxX3N0YXR1cyk7DQo+ICsJCXJldCA9IElSUV9IQU5ETEVEOw0KPiArCX0NCj4gKw0KPiAr
CWlmICghbGFuODgxNF9oYW5kbGVfZ3Bpb19pbnRlcnJ1cHQocGh5ZGV2LCBpcnFfc3RhdHVzKSkN
Cj4gKwkJcmV0ID0gSVJRX0hBTkRMRUQ7DQo+ICsNCj4gK291dDoNCj4gICAJcmV0dXJuIHJldDsN
Cj4gICB9DQo+ICAgDQoNCg==

