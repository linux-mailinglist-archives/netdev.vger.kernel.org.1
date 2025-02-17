Return-Path: <netdev+bounces-166930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9335A37EF4
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 10:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663D1188B253
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91620215F56;
	Mon, 17 Feb 2025 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r02LqE1j"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69912163AD
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739785818; cv=fail; b=MOt1JhM9LlE66cvbrF+rbteJquaXcVwMzbm4sEDg+dMYh1rpMW0R+TWfwg0IGFZ4Jg1kuBxLPTnNMzVKJInsARyKgQKe9uWFuR0xNDVT9caylwQURWyaOCIIRE2ZQbyTlacCrEVEgL5uzbjgMAc5zLeJgck/QNmHwm8T9tNNhI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739785818; c=relaxed/simple;
	bh=WvOVR3pym8bNDnS8pZuVsw4Foc5qVkKNQXCeTSogaBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tbdsfM1DVols9zL0kpdCdS/SutHbhdJNm69GY7T2QvftI0VhAHCGfF4TusTgwdonbBoYZRW/9ophXzH/0iWuMhLpL7czVRPGruE+BgkWMkyEpN463cJ98wXJzbA1o6YYt2VWBKjxkKQ40CSjAPgonlSdUAStxlUGVb8iZ8UI17A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r02LqE1j; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8dPf4P1xmU4i7tKdolG4/ms+aUL6rz3Gw/fZVOUWewdMbqW4tMvZr/ipWB0hij8BpXIvami0HulhTj/46GHuHfIqYFVgNC4U/fnwRSDq7pRvym75X0weRaDr8QGrzviCRTKLTSrQG/2BBP+pFyjB2Vnd4BiXnvYzXcFX6oDAjVBHu0HMYBRbOLJe876TMfrFvbpdafcqm6PA/uhskujkXoGp6c6ZopIxm80DN2r+Ep7/oBQIQtcShr2yakXnM5+VntNOIeJEO1rO/Ef+mbUfTKI43dlRSntFNH5VstPZ3kaHCysBWR1yQGBTomMJpcKiq8eD5S3Exc4SeVQWW07kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptKJjULvUOtqbRwLT8K+KYy6fNGjjyS99tIa3hDvtMs=;
 b=AumvN6k4I8Oh312oTPyjj9xppDR66Pymh9qIhjNPLUdttBky3oOExDxtxXp1cHwcQ+GauLZTcpK2CoiQFsv+s8sOCGn8iBUZ5yzB7UOX0MY9NaOrcORIcrB+30gnM8TJykNU/P/5k2zWH5naG30o8KJRrgh4yebxEwDszb9xE7hvb6KvyQWGW/Msu++nXzv5Fl5gFAf6/DhIJN354LOqaLBIluWLoSeWHzq0JGEKdqDdMd2iGgEWMd+7ljPPWFsTMQT+VvVKRBa6CNvxYsYhvxNInUDbUS8gWywLP6DyG4uBRdyiDHeM5gcAwMvM2tUbHxcOC6JKDRZ43Qzk6s23DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptKJjULvUOtqbRwLT8K+KYy6fNGjjyS99tIa3hDvtMs=;
 b=r02LqE1jgiEzPXayfTGRFvkDo5Jg80DK7h29G5U579voECgvfxjEHfJPkYAidWMDxojXCiD8Z59GXhH3ptVoiMS6/6IbdJm546y2FoohurOO6QNFFXuyqJz2yq4ST2g6gjvtDmrftjsomz878I+k7nDOFiDdnLFG3sSQuu3G6dzxBNL4C059+Hr9Se9XdbDuEkhpxKgC6KoCBjoVM1zJ3CxV3HwWyARpQ8pMN8rQdKw9HVa0WnJjicT/6Tc+2bGr3iR7rK/M1AjVqNYzNXRSGo9Fn3uUorwxfehNxpCTroa9wfnhdX+KofgDWpnYTLfxPNJjhpGYJnZnkGZHOqb+8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by SA1PR12MB7443.namprd12.prod.outlook.com (2603:10b6:806:2b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 09:50:12 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%5]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 09:50:12 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	vadim.fedorenko@linux.dev,
	kuba@kernel.org,
	horms@kernel.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	pabeni@redhat.com,
	tglx@linutronix.de
Subject: [PATCH net-next v3 1/3] posix-clock: Store file pointer in struct posix_clock_context
Date: Mon, 17 Feb 2025 11:50:03 +0200
Message-ID: <20250217095005.1453413-2-wwasko@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250217095005.1453413-1-wwasko@nvidia.com>
References: <20250217095005.1453413-1-wwasko@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0452.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::7) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|SA1PR12MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: 110d838c-3249-4806-12da-08dd4f387907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDFDWllLMkpGZDVUcGl4Z2VZTTI0OHN5Z2c1ZGZEQ0xtd01jNHFzZ1ZZcG1L?=
 =?utf-8?B?bEx4MldpSlRRMTRib25SVEtKMDUvUlVUR0ZYT01Oc2RxaXBaa3lCUFExcUkv?=
 =?utf-8?B?UXNDOE5aSkdJK1pNU0phV0FxWENKam1WMStRUTJ6dVNVZ1hXbVRpdzE1ZkxQ?=
 =?utf-8?B?aldvdFo3dXNXM0NTUkthZm9laFVETzFJTUFYRU41QnpGaEozZHdlTi81MTlR?=
 =?utf-8?B?eVR4WlZHQWJnc0xhTXlYL3BrVm8rOFJCWnR0d2JhMHhHWDFTM3B4K2h1K2pm?=
 =?utf-8?B?Z21td3VjV2Znc2FFN1VIYzVXQ3NxdEdudzdnYmxzSm9jb1hyd3ZsOSt1Yk84?=
 =?utf-8?B?ckpOY1JFTGh5V3oxUnZkempvVC9hWlNNM3pSRGIxanBWZ1N1MWVCTkppekJq?=
 =?utf-8?B?VjlNSm5FazRNc2RNenVBanZFQ1JyOEZMOGFKZVBWWmwwZGpzMU45L0tjRkZT?=
 =?utf-8?B?anRLVERVcG9nd3R0NTJ6WUdUNWMvS3VzS2s2R0dKRFhFVUF6SGtnckZMNzZF?=
 =?utf-8?B?ZnZTVGRseExMdlRVR3FteEF1QVROcmJnSUVDY1dxazBtMEJMWVY1WEtXK1Z1?=
 =?utf-8?B?VHdWdUVQQVVLZzJvR0lBUUJPdkVqWnh5SC9TWVNWT2JlMG5VRlNQRGFMZmVR?=
 =?utf-8?B?b2pLU1VINnQxVTdMM2syU1NjUFUwOGdsaHJhYWMwNDlkalI5OXdNRW9ENkJO?=
 =?utf-8?B?UWx4amtWeEx2YlpIWnhjbUNuTWk5WDVkcjZlNUdrSXQxK2hxRm5lQWR1QVRu?=
 =?utf-8?B?TGx2dHZNdWhUQ053Q0gzY3pEbXlVK2VwaDZqdlRkdkJud1p3bCtlbFNvZU9C?=
 =?utf-8?B?elNodXJoREVKcG8xVXlzeVhFOTNwenJ4aFBvdG5seVdValBUOFQySlJKck5G?=
 =?utf-8?B?WTliaUpzanBGQ25lREk5T0xkcXNITWtsem9RUHJKbWJFblJQRkwwcWlBdUhQ?=
 =?utf-8?B?RXlzVXR2YWo5UVVScktkZzRZSFcyUS9zMDlzTWxnYnhTZTRRYXEvYXRIYkx2?=
 =?utf-8?B?OWk3ZlpaK00yZHhoQ3hJbGJFMEJKWlJ5ZGVvN21EbnV0ZHBTYjN3TkM5WWdx?=
 =?utf-8?B?QlpTOXRwdHd3cGdSSE1sZmJIZFpzbUFzNnBFSVFvM1pnNGVaNFlueGdxeUxq?=
 =?utf-8?B?RWthYXlPaEJZZ1FETWpjbmtZa1Q3K0VDRUN0c0hyU2xlUHNtR1VTTEZaQUdp?=
 =?utf-8?B?azBZUk9kQk9QRHJpUmtuSDBHNHQrWEZhRUc2SGFPS2J6M0xZVnU3cWl5cXFr?=
 =?utf-8?B?N3B0dk5vQWxRSjhtNzRQbnhXdU1lOHZRQ09WTDZHcUNUdEdiNUE0bUtrKzAw?=
 =?utf-8?B?MFdvYkQ0OWpUMDdQdlNOU0JheFlrSkZiUG1yMFdsTFl1S2M0cEd4bE9jblN3?=
 =?utf-8?B?TVJER3pwUCt6bzF1aFpOTWNFVzE3Ym9zZlBUUmdJem9WeVExS09JSG5wN1B4?=
 =?utf-8?B?WklmeUpZemNsK08zL3NrUWUvdU8valRrVnhhMlFMTHQ5L3UvVGV6SVlsVVBY?=
 =?utf-8?B?c1dFT1ZaUjJzZEFaMW5WUW90akZzdjZtRVBFTEl0eFgrYkt2ZWxyZythMHZz?=
 =?utf-8?B?Vm0rRWNXR1p6VWZLQUtQNzN1RHNPeHVUemg3ckJwaytJVjVySWlxU2tkSEN5?=
 =?utf-8?B?ZGs3ZkdkSzlaKzhnUVBKWDRIMHRsLzVlT0hNcnVkVXN3NDRwSlZNZ3pLK0hM?=
 =?utf-8?B?Tk5OSnVNRVp1V3o4VDR4dFBnbWYyYnFjalVZQXIrcVBGR0hqYVZiSDlubHBU?=
 =?utf-8?B?eXVWa0M5ZXJCaC9VbC9mZFYrQllwczZYVzRJaTkzaHZhTkJWcUdlUTFkWWNU?=
 =?utf-8?B?TjNTeW9oTmRWZmtaUW5Cc2k5NVdQZGdKSGZSejFMWWEvdjBQY09WTjMvYjRW?=
 =?utf-8?Q?0s32UzP6uIWNV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0F0WVdtdDZzcHc0My91WGNodkt5bVJUZzhFMHYzSmVaTXF5RkVPTmhGbDVG?=
 =?utf-8?B?YWROcml4NWpBMmR0eUQ5SGdoZkZ3ZnpEUGpBK2JESnE3bEhaRnJPcGZiMTIr?=
 =?utf-8?B?eGVvZW44b2N6QndycWVIU0FvSTdLRzg5MnNMbi9ERHJwR3dtaFFEL21WOWxM?=
 =?utf-8?B?RGNaRyt1TzRwTUF4UytCOUhrL2lLU0xkZER4ZVNKN2lRUXRscXozbXRHSWtm?=
 =?utf-8?B?dWJJK2RPZ3BCajhIKzNES1k2S2Nwd3RSMEVVbDRBdnc5SHVSaFVyL2JTcFpm?=
 =?utf-8?B?L1JuUGx2bHFqdGFkMmdrTzZROXpXK3lXMTB1VFVUMjlqTHBrb3d0bUdzZDNP?=
 =?utf-8?B?b3R3dDl2Y05IQS9zQnk2bkxHMTZoaDBBVEZMR3MvanIrSDdPU2t2VDJnaXpX?=
 =?utf-8?B?OUVpaUo4Q3BhR25INlRyV0xQQkRvcjdiY2E2SVNsTHRYRitxNGI0MWpscUJm?=
 =?utf-8?B?dEFPaFNmNEhxam5TZ3BjSHRMMG1GRnNBS2JBZ0lXT3lTK0dSaUFIQzMrUjZW?=
 =?utf-8?B?RlVDOW5mR01rTUcxcC9BQ3lpWTUrUktnWSt0N2VuREFwK0FVSjgxdURES2xt?=
 =?utf-8?B?UmFCNllaOUtoMjRraVdiWUM3T1dNUW91MmF6QWVxdUttcGN2eHk0TnE4UDlH?=
 =?utf-8?B?N0w3YkV5UHp3aE1sbDl0cFViUGhKVVZqYVZPSWZhbk9JUDUraG8wS3dPVkJ2?=
 =?utf-8?B?cDBBMWlGVmloc0k1LzR5dHNzRTAxODVBMVlhRFd0V01QZHBYd3lPaXJSb3RO?=
 =?utf-8?B?Rzl3OU9ETzM2UVdDZll2T3Q2c00xS1dQb1gydjAxY2M5bEFIeGh3aU5VdEV3?=
 =?utf-8?B?NmxtcllMRlZ1b25sdjhOVEE3S3VFRkF5cDF5cVdQZFZWcXJBcnU5OGNxc3N6?=
 =?utf-8?B?NnJJb05CVm0zZ0hoOXhnOUpjeTBUVVFOS3ZaRWhjb28xcW1ZSHZFbVU5bDJi?=
 =?utf-8?B?M1VoTmFVRWJUUUs2VHpLYUJEZm1VdnR5N2t1ZC9TdEYzTkZHOXhWVlRkSERR?=
 =?utf-8?B?TnNPeU1qYW9oV3RVWmRHVjlKYzhqVFRnZlBON0NSNEhnNDBVWWNoWUpYUVhu?=
 =?utf-8?B?akRyV3NSN3lyU2JySG1oUXVJNUdHWDZ0VlNlZ1dCeE8xNk9UQnVKSVZwRkFt?=
 =?utf-8?B?anJEZ1N3bXJMTDBtME9mRzgra1pvS0lvb2w4MXdiZTBPNEFHUmI1R29MeHlB?=
 =?utf-8?B?Z1hkRmYxSENJSGRkMSs4ZnlONVBHSWVSNHAwMG1lTWN5dFFrTk5FcXRCanFC?=
 =?utf-8?B?eVNEQmloVTVwWHdqdVNqM1JPaTRFaVZ1Wnlva2E1dEtGRTcrUktmaUhscG51?=
 =?utf-8?B?QjFIRkR1NTY0ZytyUENLSTlWSVpmVUMrU0lQb3NKbEZxRzJnWm9JWmcxbzBM?=
 =?utf-8?B?ZElIME9DVk9pMnhKbXN6aEo3VkpTR0ZLUk05YWhac2p5cTNOOEJiUmx6ZGxp?=
 =?utf-8?B?cVJ4dll5cHBIYjVIaGtVTndndkZtUjFJRndlRExKQ1J1emtUTktvMUNzTlVw?=
 =?utf-8?B?Uk1oWVRIUmFaNFB0MnAxdi8vYjNPZjB2RjdiQWZYcmcvZjh2Z0JLMnVHT2hM?=
 =?utf-8?B?YzMvWGI1SVhxTFNkTDVXdDFFSVFTSTg3ZzZNV2UzUytYSkNuS2pNNzlQczIx?=
 =?utf-8?B?NzN0M2lCT1d5MXZTMW90QUx1V1NlL0ZBb3NDZmhHbnBJKzBGOHo5L0FrbHc0?=
 =?utf-8?B?USt2OHZTZ2RHM1NoWnlzVVNnMnR6YU4xSmhWOFcxVUE4Tk5mbk50ckFseVlm?=
 =?utf-8?B?b2tFRi9LMEFweWFUVGV5SXJpaU5FczU0azdOT1liNFpxbXRSNDlBd0kwdkh4?=
 =?utf-8?B?YnpGRC9nSHZwR2Flc2pzdE9sWnJ3SGVzZkVzYUI2R0RDTFdQdWJuS2U5VWFu?=
 =?utf-8?B?UFRqS1R3M3RCUGhJVFIxRkIwcUwwM3pQWjNKM0ZGcitLaGhwZWVvUXUzMVow?=
 =?utf-8?B?dHRqVFc1ZEhiVEI3QmZTRHdnYlp3WFYydStxUzJ2NmhieHgrWVdqYmJieGUz?=
 =?utf-8?B?d3BEYjNqelpadDRZMmkxTmdoc3RTaUoycDhkcmx1NllubEZVZURwaGtyOXVn?=
 =?utf-8?B?WHNSVXQvbU5sN0RqQnMrVUkremdRZTREckxXN2VWbWFQOVBNa3ZxZ0k5UzBO?=
 =?utf-8?Q?6kECMjiewNTFFE3oFFU427kMV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110d838c-3249-4806-12da-08dd4f387907
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:50:12.5779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1phzwT112o6KfgzFTlBQJcaOoANJBB23z5LHwdFn4V/i9d6Q1he6pJs/bXrah8DQIcLhyNNdy9KXvXlkfiVcgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7443

File descriptor based pc_clock_*() operations of dynamic posix clocks
have access to the file pointer and implement permission checks in the
generic code before invoking the relevant dynamic clock callback.

Character device operations (open, read, poll, ioctl) do not implement a
generic permission control and the dynamic clock callbacks have no
access to the file pointer to implement them.

Extend struct posix_clock_context with a struct file pointer and
initialize it in posix_clock_open(), so that all dynamic clock callbacks
can access it.

Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>
---
 include/linux/posix-clock.h | 6 +++++-
 kernel/time/posix-clock.c   | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/posix-clock.h b/include/linux/posix-clock.h
index ef8619f48920..40fa204baafc 100644
--- a/include/linux/posix-clock.h
+++ b/include/linux/posix-clock.h
@@ -95,10 +95,13 @@ struct posix_clock {
  * struct posix_clock_context - represents clock file operations context
  *
  * @clk:              Pointer to the clock
+ * @fp:               Pointer to the file used to open the clock
  * @private_clkdata:  Pointer to user data
  *
  * Drivers should use struct posix_clock_context during specific character
- * device file operation methods to access the posix clock.
+ * device file operation methods to access the posix clock. In particular,
+ * the file pointer can be used to verify correct access mode for ioctl()
+ * calls.
  *
  * Drivers can store a private data structure during the open operation
  * if they have specific information that is required in other file
@@ -106,6 +109,7 @@ struct posix_clock {
  */
 struct posix_clock_context {
 	struct posix_clock *clk;
+	struct file *fp;
 	void *private_clkdata;
 };
 
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 1af0bb2cc45c..4e114e34a6e0 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -129,6 +129,7 @@ static int posix_clock_open(struct inode *inode, struct file *fp)
 		goto out;
 	}
 	pccontext->clk = clk;
+	pccontext->fp = fp;
 	if (clk->ops.open) {
 		err = clk->ops.open(pccontext, fp->f_mode);
 		if (err) {
-- 
2.39.3


