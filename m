Return-Path: <netdev+bounces-139380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D93E9B1C86
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 09:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFFD1C20B18
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 08:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E233BBC5;
	Sun, 27 Oct 2024 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qR5YYsNs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52672905
	for <netdev@vger.kernel.org>; Sun, 27 Oct 2024 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730017905; cv=fail; b=T2mY+fsRdWwqzC7ED++Tyi70ZMZiG08s4NC9UZ2QfKXtKIjrETnf9IB+v8WvP3+wyu89jlHAOONkXwPDue1D2hjaJf66E0CNgmcm24Q6q7OMm28XN4lO04S6ShW3HBBWOVA1ZDjsxA5uoNCIz0HWTNllKk9RwD+jnT9tsGOTI+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730017905; c=relaxed/simple;
	bh=t/TuTT5+lIBZPI2xYrohDWR5xBaieV7INP2SNEYFO2U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pyYQZtE37Ld08KAVAMPjnUbNwntjrRsZoneXQndD3aQDcYww36roT7Oczy/yAbpHIRVIO317t8zvMoXcjWcGO+hZO1vH9uTMVP8b9HEwqiWOirrshgw39T2KnHrdiwlKVKXzSMVgJgnqy7zBKQ1x6h6H0ryomXKm2QbQZ+mZBRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qR5YYsNs; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7pZMEF8z5GadqnoqFgzSn7afCCfHJQDFMe9kUhV/feVAN550KwqffaSkavAc+7Bp54uBeauGc1OG5SSpqVd4SL1xSdNXi/u6zaSHwYqEJ7oYxgsO53M/JCS9EZXL8DQpG4I6VD79BZM+Z0qWVFbdgpnoUj2iqv4c2AZl9lpNAh18f3ffQcFtBMxRKbAUHDw+dHqretSGXcQGYTlnOXxDBt5+E/HGnj6mL/G9R/Qs0aGMqb+2vf2ZXy4JsrccUovWkAOkI8JIsv8gXmI4mPOj9lVutQhNMUerpm2wXYFc030oe3IMPOT+EfpLHTQXKwqdLMEi0fYj7kyQRNxRVllKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/TuTT5+lIBZPI2xYrohDWR5xBaieV7INP2SNEYFO2U=;
 b=MmynUobyzBOJ5TAUSB/vqoM+TYd+IEgvQ87HzSq1Y1lhsRrxdPPACBg6gIpaoHVi7pnqRyrQFoxK138Uo2IzG7YxaLz5SakiPdbjffo/fsfCF2Nd3ZTE7b28Uz8hH4Gl+p4PpqZmWw8+VY4P2m9i8z3o3/gy4YuvMKbylkOEENTbNuiCRQuGQoJ6LN+HQqGjRVuDtDMdRVzXl3cmEeA2+p50Jmk2rHIfYY4tMRcRWDwwbiwSUycRUBSMFGj5CcXPd1KlLym5uHkjWOt/X/DZEIACsFuClEmaHA59JB2Erauuz8HRcZa9fNnmQk1WOHh78L+fmnUlBqkH5KpKLvgIRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/TuTT5+lIBZPI2xYrohDWR5xBaieV7INP2SNEYFO2U=;
 b=qR5YYsNs5ZxCKj+ckaMKeE3w5BYJqT9FT2KZQWhfHBh4pQt4ltK8pdvC0C4Vf3pmMPd4LS9BseuW4AaL/qnyEyy2k2CIHPVqqWXxQUbakWTMbKDSYsj/ECqpxTMQDW7aqkvxhafCtKvXslI+1l/eVV9z0ATXzf4L55ULn+AOfi12KGfIjaD+6GPwurQ6rpMFVLe+DYpyuwF+YTlKDiIok9ENzDLWcWaKpDWfLUU4axqYqTwu74Topz8yFGj8M1HAQwLJVx+ZYp25j1kUrK6S5xspGl96n9sG3kFirIk/nKlgVmU04fU7OEdy7rtYQZxr+r+AUu6G2k+AW1GtVSbbaQ==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Sun, 27 Oct
 2024 08:31:40 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%4]) with mapi id 15.20.8093.021; Sun, 27 Oct 2024
 08:31:39 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: RE: [RFC ethtool] ethtool: mock JSON output for --module-info
Thread-Topic: [RFC ethtool] ethtool: mock JSON output for --module-info
Thread-Index: AQHbHz7DQv+I+3IfGkOF2TEcLZxABLKPd+pQgAHPmYCACQ73QA==
Date: Sun, 27 Oct 2024 08:31:39 +0000
Message-ID:
 <DM6PR12MB4516A5E32EB6C663F907C24BD8492@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <7d3b3d56-b3cf-49aa-9690-60d230903474@gmail.com>
 <DM6PR12MB451628E919440310BC5726E5D8422@DM6PR12MB4516.namprd12.prod.outlook.com>
 <f0d2811d-e69f-4ef4-bf0f-21ab9c5a8b36@gmail.com>
In-Reply-To: <f0d2811d-e69f-4ef4-bf0f-21ab9c5a8b36@gmail.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|SJ2PR12MB7845:EE_
x-ms-office365-filtering-correlation-id: a2950119-9769-4ca9-33b1-08dcf661c776
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDhhSHdCOU5IZHJidDhLb3Nod0hZSGN4c2g1ZFZWZitQNjR5Ui9SRFVZMlQ0?=
 =?utf-8?B?OTdkcTkrTnV5M1NNeTlxNDNGa0laN2lpQktJQWdxQkd3TEIreFd4RjdDcGU3?=
 =?utf-8?B?MVFEeEt1Z3BtMExmVjNKdnlmampuR3A1RndiL3F0NDJGU3NIZkVnenlnSWFD?=
 =?utf-8?B?SFpWa1pmQkVXYSt2VDl4dEhIYUhRQVhLZGRLRHlZbVRIR2ZjcUFRYncrTDZO?=
 =?utf-8?B?Q1BXcDgrSFNGRTF0NnN1V3VYNGZoRVF5K3hBYS9KNk1hSGRRYmVCeWVqTExw?=
 =?utf-8?B?ZlByNkdidHhHS0c2RTRqb2M2WWwraEtQa1VEeGs0UFBHTnBuMC9RTU85bVpB?=
 =?utf-8?B?czNTbHIvRWFiRjJGSUc1WnEzcTJBNTRsUHVOTHc5Z0E1TGQvNWQ1ZTByaFVv?=
 =?utf-8?B?MGdQQ1RmYUxoL3M5SS9tZ3R4eFI4eldva2Q1YUhsdFlJRkwweDhkNDBnVTR0?=
 =?utf-8?B?U01YYTJuaGoxcmhwVW5HNEN6VnN0SlRidExjOWxNZVl4aHNwbyt3VmZCVjI4?=
 =?utf-8?B?WDhIaHZKZnArMkcxcDcwZEQ2bGR2VXBuamhpdjlTY2ZEVElPU1orSzBGMDI5?=
 =?utf-8?B?NHVKOU9XTmVhUko3SGF6SU9pcFNLL3lrNWVYSDFvL3lpNllLT0E0Zyt4WFp1?=
 =?utf-8?B?LzAxTm1IdnBrcHg5MGlTU0hWcE8wdFFLN01VdUdUNEltU0hLalA3N3o5SHN6?=
 =?utf-8?B?dUV5Z1hzZ3JzbzN0MjBrWnV0OGxIWDNGYUtDUVVHMDNkV0dYaGtNOGlBaHRo?=
 =?utf-8?B?SGgyOFFHd2owSlFmU0xmdWhHNjFxU25YV25FQW92UXRyNlhJOG9tMkQxUlJZ?=
 =?utf-8?B?dXB5aXBBNHlHM3NYTlQ1MTB5bm1VaHZrdXN3ZERwbS9jcTNUMUxJSTBTOHRF?=
 =?utf-8?B?VUtscTVqWXNVYzZjWFh3VUEvVUVKOEowUVlDbkw4YXFvY0xEVFV3UE15R3Jt?=
 =?utf-8?B?Wjg3MnRIUlF0R0JwSWtHNTlNSE4xaWllTVhsbmZKY3lsY1VReG16YWNiZkk2?=
 =?utf-8?B?d2NsQTM0MGNOd2ZOd1VDVHFjWEFzMkl5S3lVcTlORENPTmsrSkQ1NlZTNVAw?=
 =?utf-8?B?THVkcVJMRGh1U1RVRlZWeGhDaTEwMkRBQnJxSVdsYkhkL2ErVlBiN3FFcGly?=
 =?utf-8?B?VU5QRmRDUU5OdGtpclliR2dDR1o3blg2em8yb09haUNscHRDbzJEMjl6UDFn?=
 =?utf-8?B?dE56N1ptd1dLa2FwbnpOUWtRLytsdXB0UXlCd2lqcnJhbHo4UHB1MTJTTnk0?=
 =?utf-8?B?Qlp3dEhVYk9FQjAyNW1lUGlteXczVnh0eG5MTGJDMW9sZjl0aThJQzlqeThD?=
 =?utf-8?B?RG9UeUZyNzl0eGJseDkrSjAzeGJPTVc1V05tTzNCbVlyaUxkYlpiSkUzME9z?=
 =?utf-8?B?RWUxTVdmSUJhREVKOFk4QnZMM3ZkQS9oMk1xKzAzZE1oSDhlZFhDVWp3ZWpO?=
 =?utf-8?B?akZIVkM4WGxyR1NBKzkvYndzdGtLRlp0T244T01qTXlVWVFqZXdwNThsTDN6?=
 =?utf-8?B?Mi9saFluWjAzYmVkMWJJYVNsUWRuK2ZsRnAwNG5ObkgxbmhLQ0taT3FTb1BS?=
 =?utf-8?B?UDU3R2w1ZmFMWEoyUG5MZDJFVStkVEg4VEM3SVQyVllqMUpRcm8vdUVIZ21k?=
 =?utf-8?B?d2t5YzJIUmJlZzFXYmMzV2FxNjk0S1RuRVZGZXVXMU43OThnbTlkZkorMkZC?=
 =?utf-8?B?d3dFZ05oemFsNUpQR1dVa1pCVGJPc1lPSkluTlQ3RVBRUit3bDVpMXQwNzRB?=
 =?utf-8?B?RVhKcEZzMnUxUmtGVm1zL3VldmNBUFVBa0pYS2lZcUluSWthNm5JWm5TSmo2?=
 =?utf-8?Q?tYiGLvvrCFzGKt12CsrM/16zlP7sRhbjznyWA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ekJHdlBoZ3lrMWNqR1JSNkJHRkc4b2d0eTFZMEt0bzQ2eXJFcnhlOGtLNFpJ?=
 =?utf-8?B?N2l0WTI4RWQrdkpSM2xObVduOE1KbElocE9aczBmYnJ1MThhdUNZTEdjY0sy?=
 =?utf-8?B?UnRZMkk2L1J0Z2g1bWZ1bkNxSzFkNStUZWFPQm5qYm1mL3lYQkdINWg3MDBa?=
 =?utf-8?B?S2diWXdFNjVPN3g4allleEVnNFFOanpLTXRoS0NiTTJ2QWh4bnNJK28yU0d2?=
 =?utf-8?B?MG9KdTVzdGNJRFQxYlJyNkJUMzI3c0xwOW85WlQ2TzlSRXg0YVp4c0NSRUdC?=
 =?utf-8?B?OHBWTnVSbGVUQUtvRnhCMjFEOGZNQUN2akNQUHNNbm5HWkJxRG96aFNsNE9D?=
 =?utf-8?B?UFZpYjA1MGpwaDczTks2SEhmWmh4ejU1a3BvK0FaMUF1QTFqNjhDeWFvVlJM?=
 =?utf-8?B?SDg0ZnZpMUpKTDJIT240UnJVU3kvYnNyU2hvanM5V1ZUU3JNd0pCVFZBdDNT?=
 =?utf-8?B?MndEbjJCem9PaU1yNjhZanlweE1rZ0lwUnVEbVVmVGFDazVUWHRQazhOZThq?=
 =?utf-8?B?QTZBZ003ckRjS28xZURYcnFLQ291WVdRRWVvRzZVQjZHamdWZHVyazE1QmNr?=
 =?utf-8?B?R3UrVzlQam1YOXZWeUxtMFBLVEtDQUEyNFZYcytUa2NCRkhCV0JSNVA5SlZM?=
 =?utf-8?B?OER5YXdJMzdNQVJDRTVXZkJhY2RZOGw2TEh3WG5QNndxd2ovWkFoQ0w5QjVy?=
 =?utf-8?B?MHRET2s1S2tSMXlyYXowTGNaSGFoR21HUGlnMTdDNDJwNXI2S0dHVEVQWmY5?=
 =?utf-8?B?QU1jUjZncVZPMFFnMVRPQ0Zhem54Tzg1TEYwV0g1U1JtcHVsYnRhRGkycXBH?=
 =?utf-8?B?NHd0c3orUVovQnFpRFI4R0l2SnJ6QlYybEN0S0puWDhZQzFRUGhxTWNyZUZk?=
 =?utf-8?B?WGc1MlJoQUlacWVjTmpDMVR2MjlFTkNIT285ZEp1VFNWZ1A4ejcvai9hbU80?=
 =?utf-8?B?Um1kQTZTYUVOdzVQZVdSS1U5N2RPTDIwUGpFMW85S3BBRytsRlVkUW5vNVlX?=
 =?utf-8?B?Qm5TYmR2QTJGeXFjRjVmWDZBejFCVnZCVUpLajJEald4ZDVTRGYwYk1lRm1T?=
 =?utf-8?B?QmFmaXgwaUFtY1c1V2N6ZDM2My9ySm5pa3ZIenBjZHJCY3c4SjRBenhadTNL?=
 =?utf-8?B?ejJ5K2RlVGhrUVlPL3RlNWJGdnhPS1N4VlhjclRmaldNUWRvaXdSd2hibHZr?=
 =?utf-8?B?UHBlOEMyeUcwMmduN2oyRW5xNldvZ3hQc1FUdE9iUGZPMFpBNEVkbTJONjJv?=
 =?utf-8?B?dDlJdGZpQjRwNGlnWGxLaEZHMjg4ZGEzZ2JIMkJMWW5DSFRDRnlWWDU1M1Vm?=
 =?utf-8?B?d2laLzgvbGVHS1ZlYXMxVStqMXgyTlRkMWdNT1lJKzkwQTU2RE5xdzJ2eFJp?=
 =?utf-8?B?eDY0VXRBYUFWb2NwWnBOVVdKMTVTbDVQdWs3d1FQOTVRRm8yRXl3c015T3hm?=
 =?utf-8?B?MTRadW5VaFF5Qm10T0FKSUxBWnk2SGd4T2pWOXFQVDZDcGZXMmo1U2t1bi80?=
 =?utf-8?B?b2lOVENuaStkNzU4ejc5L25oeHhCMnZpam5NZUZsNjVvdGhGSjVFckRBWDBX?=
 =?utf-8?B?M0x6SkFLd3BDUnFUYjhxclVMQXNWSVhBWHArTGVIZ1lCdm1FVXNIOElFUmNB?=
 =?utf-8?B?QlRUeFA0YWtUa2grU3U3aDdzWktTdk16MVMzUW5Jd0VMbG9qQWJOUm90UWN4?=
 =?utf-8?B?YWY3WTRQYzM3YUkvWVRZWEd4cHBKeFdqNEtITzBEY21OZzhReEY1MlQ1OW83?=
 =?utf-8?B?bGRwbko4L2ZLUCs3OGxMRFJnNWlzWGZKdzlWV3A2N0RIZXFaNkI0d0lPbDEz?=
 =?utf-8?B?ZmN4QWlsU0tObGFhVThOYVF3cXRUMlVtRHc1QW8wY0FUMHJXZE1LeHVseWJU?=
 =?utf-8?B?a2Q5djgrb0RaaDVOcU02clFGTVdsVnZxN3JQYnRhcDJCaE9sWEFlYjU1ZEJq?=
 =?utf-8?B?dGw3Y3JuUnluU2wxd1pwZ1lPc0I1dmpoQXFEK2tTbnM2c3VidzQxZ1ZBRGhV?=
 =?utf-8?B?eVpLRDNLR1VJWkxTQ2tKbVZnbS84WWgwbTEzNE1KUzloR1pDbjBISXM0ekMx?=
 =?utf-8?B?VWF3S3ZDZVVuQ3h4bFlieXBaSjFtNGxEU3ZHOGdjS2NLWnVHSlc2Z3d4cTNY?=
 =?utf-8?Q?m6Fva0nSSgEYtDUdDi2cXWeWN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2950119-9769-4ca9-33b1-08dcf661c776
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2024 08:31:39.7859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /JtCH00pKAPzu3Wyv4CYGkB7eWLGlXB/LTcrnA8sRspuagF2a9/dzLLwR2v4KQYpyiPtbjF30Xf1n3PhEdnsWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845

PiBGcm9tOiBEYW5pZWwgWmFoa2EgPGRhbmllbC56YWhrYUBnbWFpbC5jb20+DQo+IFNlbnQ6IE1v
bmRheSwgMjEgT2N0b2JlciAyMDI0IDE3OjExDQo+IFRvOiBEYW5pZWxsZSBSYXRzb24gPGRhbmll
bGxlckBudmlkaWEuY29tPjsgbWt1YmVjZWtAc3VzZS5jeg0KPiBDYzogbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IElkbyBTY2hpbW1lbA0K
PiA8aWRvc2NoQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIGV0aHRvb2xdIGV0aHRv
b2w6IG1vY2sgSlNPTiBvdXRwdXQgZm9yIC0tbW9kdWxlLWluZm8NCj4gDQo+IA0KPiBPbiAxMC8y
MC8yNCA2OjQyIEFNLCBEYW5pZWxsZSBSYXRzb24gd3JvdGU6DQo+ID4gSGkgRGFuaWVsLA0KPiA+
DQo+ID4gSSBzdGFydGVkIHRvIHdvcmsgb24gdGhpcyBmZWF0dXJlIG15c2VsZiBsYXRlbHksIGhv
dyBmYXIgYWxvbmcgZGlkIHlvdSBhZHZhbmNlDQo+IHdpdGggdGhlIGNvZGluZz8NCj4gPiBJZiB5
b3UgYXJlIGluIGFkdmFuY2VkIHN0YWdlcywgSSBndWVzcyB5b3UnbGwgcHJlZmVyIHRvIGZpbmlz
aCwgYnV0IGlmIG5vdCBtYXliZQ0KPiBJIGNhbiBkbyBpdCwgYWNjb3JkaW5nIHRvIHRoZSBiZWxv
dyBSRkMgYW5kIG15IGNvbW1lbnRzLCBwbGVhc2Ugc2VlIHRoZW0NCj4gYmVsb3cuDQo+IA0KPiBJ
IGhhdmUgbm90IHN0YXJ0ZWQgY29kaW5nLiBUaGF0IHdvdWxkIGJlIGF3ZXNvbWUgaWYgeW91IGNh
biBwb3N0IGNvZGUhDQo+IFRoZSBjaGFuZ2VzIHByb3Bvc2VkIGluIHlvdXIgY29tbWVudHMgTEdU
TS4NCg0KDQpHcmVhdCwgc28gd2hlbiBJIHdpbGwgc2VuZCB0aGUgY29kZSAoaXQgaXMgaW4gZWFy
bHkgc3RhZ2VzKSBpdCB3b3VsZCBiZSBncmVhdCBpZiB5b3UgY291bGQgbG9vayBhdCBpdC4NClRo
YW5rcyENCg==

