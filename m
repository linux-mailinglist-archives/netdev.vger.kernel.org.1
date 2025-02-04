Return-Path: <netdev+bounces-162406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7F9A26C3B
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 07:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BBC167D2D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 06:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FC2200BB4;
	Tue,  4 Feb 2025 06:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mIEJNaAW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1CE13212A
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738651365; cv=fail; b=GuJwJhV89eSqzw6hwKQv1B83GYGYwzaM3kncD1TlZUEYRAfxhdQd3TFaPjypQW5PVyUoRnDtNX9PrnY5L1BcArWX1TpMhl8392hpSiyK8eDwbe7AsegL5o0YOcrWKp/Wzda0oOUXUqQC/Lv9Ish8y7SOQY+0AZL5ZYruYW9OFb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738651365; c=relaxed/simple;
	bh=uL3qSvFrPHEhkHRR1nNiE89qODbFPDcXxzIVJps4J54=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=svilF3HGrkEMYUhNDXqjzgbd/oAn8sPTtNjPXSvQ79aOfJrMa8N3ijTjrJXwqnNdRI6K2f9UdjggfTejPqhAt6hH1heJ7r+thcpH0feoJFGBoCWQViE31Z+B8M12eU1mQDu3SYwADZloPLzfi1M41DNlwZxzW70ICuUNs57SsyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mIEJNaAW; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrBfSKy54Vx8fP5SPHZcN8DR6Qc5Ny1B/yVmjkhHF9Cex+H1reBetCYd6/HKv0PmIOsaIX5mt+wZ3VCrfDxPVd3Rt/zPUF02Ye1OoaC6lYpIoY/wSvZQhxLtF23MYBKE7HydBonSC85p4cx/Uw8VfyEf8CaGG2vLwsLOmSbk666y+GO5Hqi3OjwHMhwcqtbd6OEcpwk2jZlIcpG/k5+tsE0t/8f7g+JpUb4KCzqDYkhXHtNx5sqbm3WZc3kiCE3w+pgsEjDeEVNw002x8NNNrAJ3zPldCmp0SvcjEKE+vX9aRDqMtsAyN684XSeary0c1y3IIsiRGI18Z1RGUlvpTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2soJMow5n0Hh6NtbDuBOkKSnCyW23svrKs30p7CHGk=;
 b=botSF3NrEzgVieBcMqBJyBhASwOfKp7fHbA2vm50hWWlejTF43Noj2hd9sHz7pqMk2tnXlcThd8q9KG1YARGezt2MLebPbHXeKk/SEf/CFIwYs4hfzohqOb8MmCAEij7U3vKzV5COZpjQYyeqvFHjQLORcUqkw8XiP2csJGH2xP7hqlmOCVFb37zptnaalq7VJrrVzvXJgBwphEvzKQmcK0Z4Dc88RSynJx5hAsoWcdxIc5aaedmR5u1J60ygmt5IB3tI1PfpxKZPHi1fOCs8PEBaiBla47adqF5gq7o7kp3KVDhty20IdW+cjdHrnznK5aopbNv9MxjbaVeBAU7rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2soJMow5n0Hh6NtbDuBOkKSnCyW23svrKs30p7CHGk=;
 b=mIEJNaAW80ysdXHuXTsACZbngGQqolAMPO/v8CtPtmbHXPn+qL3xHaHFd+/AeLPNbnaN8A7znSmGKFIeFKMsmpemHycnlIsF5pEy7AmE6dJDMCH33/A1iewZ3rmwRqmNcOQmBQuIJPX30geKVCfL+n5sin6UnmvJQT3Cekudlgum6WVvPko0DLz+hfuqrvPfAj448s+y0KnZtk0X5flEH0ZRazWFGsWMit/dnXHOq7m6JcECz7HMe2j27xsxfQY2nyD6jZJqdc/dRKzne/cSaDnP0pu71ORUmQLzhdomwOefCmDkGc692JalPlqrklZoHiF0jK+Qm6jC2gOlcsf4vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 06:42:41 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 06:42:41 +0000
Message-ID: <913c68d5-8695-4dc9-84bf-d2ffe9f8b15a@nvidia.com>
Date: Tue, 4 Feb 2025 08:42:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/4] ethtool: ntuple: fix rss + ring_cookie check
To: Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com
References: <20250201013040.725123-1-kuba@kernel.org>
 <20250201013040.725123-3-kuba@kernel.org> <Z6EyPtp4rrCYSCTb@LQ3V64L9R2>
 <20250203132519.67f97123@kernel.org> <Z6E1afDYGcU2NM7V@LQ3V64L9R2>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z6E1afDYGcU2NM7V@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::10) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 488d1b8e-7511-4b6d-d200-08dd44e71f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3lHK0dTUU0yeWcvNE5EeXlUenZ1SkZndTY3d1NCU0gvRzhvMEMwUVIzbGF0?=
 =?utf-8?B?V1RoQ2hMWGtqL0I5MTZWVmp1YUt6M3dXTmIwQzhNeVNMY29MWTJQSEVIR0pH?=
 =?utf-8?B?T3RGZndNeGN1MUdNTERwekNkNHJTMjBiRWRQYWdLNVpwQTdWaXlmWXZGN1kx?=
 =?utf-8?B?SnQyRGRDR2k5N2FBUHVlam8xQ2pVZ29MNzJ2OCs4VWR4bUVWUWJhbjkxOHd4?=
 =?utf-8?B?Z1pLd3VKS2RqTnRsWnlHSXhGb0h2VVFGNTU2MGs4cnZmSkdzMjk3OVFIV2FM?=
 =?utf-8?B?d3puS080RUlaeXpnbm5aQ3g3ZXdhNVd3NXhPaDdvTzFDa09IUGRNOWFUR3NH?=
 =?utf-8?B?SzhydlNnQlZwVDVwV0VLQ05OR2xnZVdLSU5VQ0hBemRTZU4rRW5BWDcvV3hL?=
 =?utf-8?B?OFRUUUNvb1YxUjFESzN4Q2tad0E2MEFaWTBobDB5bjFtM1hRdjdZaWRrSFR6?=
 =?utf-8?B?OUNUOVdqbjhZd2VZaVY3TUQyb2RFRjJHYW40cytYdXRSQXM4KzgzMEJES2U2?=
 =?utf-8?B?NVozdmgzUTZNVGdWNHJMcUpvRzYxdXpMb0NFdXZ6c2FkWlpiR0dwK0FQV0ZK?=
 =?utf-8?B?YkpyQkNhTzZXSDNPcmdtK2IzQ2NCamptTXdwQ3hHZHNJMC9pR0xNalcybVpz?=
 =?utf-8?B?YnF2dDFpUjRYZjYrd20ycEFaV3ZvckJVb09VRC9uSzUrR3AvNElhM2c4Z0Ru?=
 =?utf-8?B?YUNVczY0NXBNcHFEMVVvR3IvVUF4ZkJuUUdTTkRKZCtpa1VYTllDcXhCQ2Jv?=
 =?utf-8?B?TkFZK2RjeElaZkJMOTc3Yy9hMUNGWENyRWRERElNWG5hZFprZVJzYkFRMVJj?=
 =?utf-8?B?Mk81dG1tOEJRYVdWMHZ6Zm8yT1RGWU9sc3NDMjRLZmEyek05OVRtYXRkSEcz?=
 =?utf-8?B?dDViV2ZrUU5uSkdwNUdPYWtOMWJCNWw2MnZuVGV0Vy90b1JxZ1Y3WS81V05k?=
 =?utf-8?B?bUszY05pK1FaZzNGTW9EejVuZEVnelhrT1ZqWFF1R2p5ZEJSMXROcm1NeGY1?=
 =?utf-8?B?bGpiNkErd0lIRC9xTTVuWDBxSUlZWEJpQUE0Ky8rSDkxK0taY2hYR0k5UFRz?=
 =?utf-8?B?OWt0NXBLLytoekxKUzM5OWt6QnZVRnVhVzljQWI3UjZnb01VUytTWG93OGFH?=
 =?utf-8?B?WHBpTlBXeEhmZGs0SUdTWUxFZzhzclV4bmhveWtnejhZNXVBeGo3VElmVHRu?=
 =?utf-8?B?TDV2cEc4LzBSaDBnajZUVkJFNzZQYXBmTFVuTHJab21HbE9rcEJMeDdNdlZE?=
 =?utf-8?B?OVk4cEticFRpQlFhRnRFRzFnSVgwMXd0NVdaOUlKWEc5TkZEVE94ZXB3TUxZ?=
 =?utf-8?B?ZkMxalh4NmllV3JHdjZoK2ZNZmRHQnJUbFJxS1hQNjJGeDRqYjhxeUdiQUcz?=
 =?utf-8?B?QzJETzNDZGdkMENIQzV4TDlQaHU3ZnQzMEY2OGUxWEtZUG83QU51a0UxcjZW?=
 =?utf-8?B?aFRkVDBEak9Kei9ITmtucW5YQnNjdmFibVU2aDY4b1prcU90akhuTVlRMTJ6?=
 =?utf-8?B?b2xGaVJweUR0YlJ2dzZrazlHLzI1c1VtSDVVQ0FOb0RwSzBVUzZkd1JJOG1Q?=
 =?utf-8?B?ZnRsM09XbXA1ZzdmWDFHeVE1dVRxNUtFemkxTTdOOHIzeE1pOTd0TnVzMUxW?=
 =?utf-8?B?Y0NWTHVtUFp4OTZCTFpVdEtaZExhUnVCUmJDeTVYaGF1bjlCOTh5SkJqTFpP?=
 =?utf-8?B?VnAvU3RzcFFYYUcyQ0tIZWJSMnpicFdnWFpJTjF6LzR0bVpxYTlOQ0J3MnFw?=
 =?utf-8?B?Z3ErdVFKVkNiY210ek5ub1Q5ZXlPcjB2cXc2VlQzb3daajV3enJHaitVRk9z?=
 =?utf-8?B?T1k2NzUvL0trUVUxNzN5eDM0eDZRSUVNTXZSUUREQkw0YUZNMkJjQjNKVjMr?=
 =?utf-8?B?V1RlVDh6Q2VaNWlURVY1RnV5VC9HNVNaZTBmZEd5OVpIWVAvWlZSY05oQUJj?=
 =?utf-8?Q?1rJ3KwrBrf4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnVESHVmWkZzelJIWnVtVlQwS1hwWGhicEM5STZEaC9sLzhLZmpGcGI0bUkx?=
 =?utf-8?B?TWkrWHE1NVBtTHc0YUh3YkFWWXBwL0ZaU2p1cmtsaXcvV1F0eUNnV0V3V1B4?=
 =?utf-8?B?L3ZwakhoSDc5ZUlVcGdJYzFIRmcxNzdFS1k4Z2E0dWE4K1pYeUhSNnN2Y2tu?=
 =?utf-8?B?VG5lUktQdHlVTjk3R0FrcDhCZVpDMVFFdnFJd2ExanNZUmRFQ3lGQXRpd05O?=
 =?utf-8?B?NWk1R2MrMVk0S2s1UUNtWU1JODNOUnNSeGJ3dVNvMjY1UWlFUjhpL1NLcnJu?=
 =?utf-8?B?dkkvdUIyQmRBRG5yY1ZLOGwrMWlvdDRJL2pMdDU0N1I0ejUwSWR2Ui9rU0JN?=
 =?utf-8?B?SUErVVhFTGpKd1ljZWk3N3U1K0hYT0UxOEw3SUdWRnFrV3pmTkhCa1U0a2xy?=
 =?utf-8?B?cjJzMExSTTlkeGZkZm1CTjA0Mlpqd3ZkbG84OXpWRDVRaG53ZHVYeXd1WEhq?=
 =?utf-8?B?NmhrVGVqaG9ZenYwdnllWm0vRERkUFA5VFUrM3lBWVlZOGJ2a0grNTg5T1p0?=
 =?utf-8?B?b3NsQ1ZYV0hmbEVZRDdBM29XTXVBWk5JK2JXYk9pellhTldLbzAya2xYYXN1?=
 =?utf-8?B?RDVua2gvYjdpTng1MnU5WkttQlYzUGFIRW5SZG4yRGREczNjS0ZtZFdjSmsw?=
 =?utf-8?B?dEl6eTJFb0V3WEFFUjU0SFJ1ME9Xc3V0bkkyR1NBYWRQNVVGOGIvQ2tYZ1gr?=
 =?utf-8?B?VmlSV1JNN1M5bnp6a0N4Y2QvTXFqU3FyYWlLT3BjeVcvZ2IzVVpONEw4VGZu?=
 =?utf-8?B?ZG5Idm9jVTd5K2xNQm0rbURQSmE2ZzRFSXZoWlg3ektqTjcwVFpGU1l6ZUx4?=
 =?utf-8?B?ZFpzK1VrZUZhQm9HVTRsYmVJVUxJc3dmQWVjL1VmYTZibjBOZE9DV2VFSnN4?=
 =?utf-8?B?K1I1M3FMOS91OEVPQm56RXA2aVBXR0xPcmY4dEh6VFpwOG56RFVJbkh6OWlC?=
 =?utf-8?B?QXhJL3ErS0paZ3lNdFF4enBqRldYbnJpdTl5MDRKMDRLdzczZXFudkcwc0Jh?=
 =?utf-8?B?Y2QwVFpLV29zUmJ1UnFicCtmSVlrM1kyZWVhTExBVGU2QW84S1h5RlRBQkEy?=
 =?utf-8?B?WXBrem1wL2NzR0JvYWt0OHBXVTB6alpIT0RaeEc2empZaDV3cnpsOEFaSzJk?=
 =?utf-8?B?Q3k0VmZFc2VwY2xDWGdXdGtUTk9VSzdYY3prYXFOSkZtUzZldjdSUlQybXNk?=
 =?utf-8?B?NjhjYVI0RGhHRTE1cUJsRTUrOVN1M1dCa280SEdINk9JM2c5cmpEWWdQVFY3?=
 =?utf-8?B?ejVBdEhNWTljSkdYTjgwQnhMTGNxMWZKd1hMMmtUT2N6ZmZtaE9TSFlpWWV1?=
 =?utf-8?B?akQ2bXZNU0hMUkZhc3VzdDZnMEVrS2grR3B4ZzVBL2NsWmJJUSszYStTVHZZ?=
 =?utf-8?B?S3RTUGdvcCt1ZkIrbFVsT3NZSjhjVEc0Ukg0endjKzV3blFiVkpkOW03VVdk?=
 =?utf-8?B?SGE0ajlEUjhXTHBqTmVxOVdSWmQrYzdwYjlsQTI4QUNDYmxaU2MzWVBEbHRL?=
 =?utf-8?B?bkNhZGxhOWRtK2JVbkhOYkJHNjhwL0lCWFYybWtuRDdKZlBQdElCQ3hLaDBa?=
 =?utf-8?B?U1I2NE0xT1ZzL0htRUlFR2llTzFIR3RpZVpEbHhiQzRBSHROZzZCS25kWlpH?=
 =?utf-8?B?Uzh0R3V4cW9BcDZTZ2FncDd6cFJNRnpSSzJ6WEx4Y3dZUVlzb085THFzYVNn?=
 =?utf-8?B?RXJDUXMzd1BoUXNCZzhPczdKQlZUTDI5QTZHS1h5czZxd0dVT3Nabk9CMGFX?=
 =?utf-8?B?Ui9hOFA2SFQ3T0xodmtzTWxTbzNwempFR1RPT28xd0Vtb2FJYUxsbmhoQUFt?=
 =?utf-8?B?R2o3YVhnMlMwb0tGU01kc1pPNE9pZkhIby9BMSsyUjN5ZURFSXAzdE94anpW?=
 =?utf-8?B?VDRhRVB1MUlDNmR1ZTh4TzBndHJ1QzNTQktXUjdkYWRVN0FDK3BZUGVSa2lq?=
 =?utf-8?B?a28zOGlSZ1BqbzhlY3lvMXQyMnpQc1FxREZ4TWtSdVJwYUpPWFVuSUNSYmQr?=
 =?utf-8?B?N3U0RHhSMk1CdGNZY01NS2VXNkZPbml3YXRjUDNTWnVtUlFLSWhHaUZHay92?=
 =?utf-8?B?SUpSQkprVE5GOGtqb29nemlKTkhYc1JlbDRROS9nZVNYVHZleitWM0szb1JV?=
 =?utf-8?Q?wqmatNcY9MAf+xoWRNYu0IDgm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488d1b8e-7511-4b6d-d200-08dd44e71f06
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 06:42:40.9736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMKIx748qEHELlZ1cP5N7qYmdnuUqFWSip5OW1+u8WChSnfTEirIc/BE2Dhit39D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971

On 03/02/2025 23:30, Joe Damato wrote:
> On Mon, Feb 03, 2025 at 01:25:19PM -0800, Jakub Kicinski wrote:
>> On Mon, 3 Feb 2025 13:16:46 -0800 Joe Damato wrote:
>>> On Fri, Jan 31, 2025 at 05:30:38PM -0800, Jakub Kicinski wrote:
>>>> The info.flow_type is for RXFH commands, ntuple flow_type is inside
>>>> the flow spec. The check currently does nothing, as info.flow_type
>>>> is 0 for ETHTOOL_SRXCLSRLINS.  
>>>
>>> Agree with Gal; I think ethtool's stack allocated ethtool_rxnfc
>>> could result in some garbage value being passed in for
>>> info.flow_type.
>>
>> I admit I haven't dug into the user space side, but in the kernel
>> my reading is that the entire struct ethtool_rxnfc, which includes
>> _both_ flow_type fields gets copied in. IOW struct ethtool_rxnfc
>> has two flow_type fields, one directly in the struct and one inside 
>> the fs member.
> 
> Agree with you there; there are two fields and I think your change
> is correct. I think the nit is just the wording of the commit
> message as ethtool's user space stack might have some junk where
> info.flow_type is (instead of 0).

Exactly, zero vs. garbage will determine whether the check does nothing
(as written in the commit message), or have an undefined behavior.

