Return-Path: <netdev+bounces-171300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0780A4C6E5
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBF617193D
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D69222E412;
	Mon,  3 Mar 2025 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kBQy8Ggp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FB422E3E9
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018444; cv=fail; b=O/r15Iy2CyasUuODr/Gm30BTr2feG+EZivoNz7FairUsLxuIXGl15jR3r4WluphAhI6IhURZbv9breAB3Bpfvvrs+bODyMRracfc4hrloyIoiH30S7zDwNCaCDzMs8eZ+aNeLU2VPoRs5/odDnY8/KCknh8Zl+BWNfOE/hGNxgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018444; c=relaxed/simple;
	bh=jI7Z0RPIUDZZQcW+odQqrXsyoPz8dfGXLL7pTAAds5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gxs6jWpFosj9uGh2ySEakkPUd33xL4/708H/HHHKKh8ObHPLtDnllgKm8bE+5C0HyR8gVRSnd1PNVVdrCiEj4ADGIJFdlELZLQ8qPvZz2xrqwe43FpEqcKZXje69MjpenJPhuQBO+5dL8eP+umZMyOwsgtIrhg2zac6MuD5qq7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kBQy8Ggp; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ID+jfqCm/aaa3j8wXeVc++EQAmLtaUcUmzOyvpXRZbDxkHeoRR01BuHA0G0hVUm0/rp3LirtQVaJp1SbLmxdmkeYuRc9Nt1Pt72kyjNy76WlKI/vog0bY7XeVdPrf4D6qADA6Veggk8MZXI2SQyteXBAD81PXT8wF+SiBhfq6cTq9HdyQ6qhxKr8G8suhcE+e5EL1iVCY6nT22qd1a3DMJtBnQbTypJdzkcdG2CyW3Uo4cQtzm5fP1I3fX4jenGDgdxelvArMto63HJdbSZAqhhP4jDmJ8yHjmN/Xs3kA5ou/oPDuzf8K4zG+6kK87s86hhsTgGV6wEJpZe5Ds33fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bGEbL8UsDW/lntfljG1L4K6eomaTCMikWWfqVL6UdE=;
 b=USibllHTvAzplOL1feoKLDr8O5xIVnd1PwAMV3HvZRRRnJBr2nH2GikUcYv7UVYhGDYVqbPOSTaIUEOiALG72G1fNeM6bX5zqcZBeKo5ooH9hVB77pgmitDODEbWdyn7KOTN6WULsmFdkuwj9S02XVHkC/ite4EVRXx3EaBQOmJj3KBrV1n/Fk+d4vOqQ8jAxqHXL79mxYoL8keAZ3obVy4cO3Sg+QamxZgWze+h+Ep+OI8A7MLhMxbnbcVfLhHdINV060PzhZO5m2K0f4fdKc+2oB2L/jwUmRPO+j35BeFPm8OTgRownrzvleYpR/D93yIv6HFgAlxzDoWWFSrJZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bGEbL8UsDW/lntfljG1L4K6eomaTCMikWWfqVL6UdE=;
 b=kBQy8Ggp9aQ8C2s6el594WpMr+oIFiM4BbZBQYaIh0Jo8PQ09HF57rJ9ta0QFqbaycCSmAphB7hkXiLYWIgM/1/ORGS9POxSWbX5CQ6k9NoWeno5AB/8Xllt1p8uUoK+zd2jbDTQ8v+Bn9+tdEcBaIJbmpDToBz77f1XR2ThIgSE6OK+ulkd7HGoyygOvNr16TdOZ/yISNYr+uhLEAFzMx/T3fVcFCY1oFoMpY58HfbKSeDykueBOponzzTUww4NVkQ3+9EgjXO4Nk64FoYuOANVbsaOMEYOoncTqLZCj1SmomY/dAZbWKeA5pDbydg3ReTm5ysEc2eXPDlp9ivKTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by IA0PPF1D04084C7.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 16:14:00 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 16:14:00 +0000
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
Subject: [PATCH net-next v4 3/3] testptp: Add option to open PHC in readonly mode
Date: Mon,  3 Mar 2025 18:13:45 +0200
Message-ID: <20250303161345.3053496-4-wwasko@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250303161345.3053496-1-wwasko@nvidia.com>
References: <20250303161345.3053496-1-wwasko@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0123.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::20) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|IA0PPF1D04084C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a6cf41-0a60-4f94-927f-08dd5a6e683c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTYwSDFUQUFxRGRzcm54Tk1UdXVPelNJLzYxSXlvOVJCQkRubWVIWVRVSVc5?=
 =?utf-8?B?M29LQ25xdzhRU1Q1WlFUeEx1VjlnRGdLTjd4dlpqZjE1c1p2ZkE3NGQxUGJL?=
 =?utf-8?B?SFhvdlY2STk0QWM0QzNRRjcwckxlY0llUmJDclVGZUswRnhCTGdMSUp0TTZr?=
 =?utf-8?B?ZUNrT2ZiZDN1dXFLK25DcDhySThYeGhEc0ptMyt0V2ZYOWNoeWF0bVdMUjJ3?=
 =?utf-8?B?RlFQS3czOGVRaGZ4YmVFTHBCSHVqMm1GQ2I1NTlzS0s5UjJUaHVpTk50VERX?=
 =?utf-8?B?eDR6S3RVTXg0Z3BNeTN5UkpERGI5ZjRwSlZrWWRiZkVaYUtuMlAvVkY4ckVu?=
 =?utf-8?B?TjFyTitJNXBXMzZBSHRSYVZSc2hBUzd6bHpMbzFPUGM3d20rZm9Ja0RNZ0Rr?=
 =?utf-8?B?TTRGeldPMDYrNTZoNlhPSEpNV0dZWXpKMDlIZGVONG9VVEhSWVprVDZlVW9s?=
 =?utf-8?B?aFlMOS95SEhGbnBISnlaM3NuekxYNXlMUUFmWnlPclF4K1oyMXc1OVhJSitG?=
 =?utf-8?B?Y2d3UW8xTmZWRG1xZW92QWlGUXAwOHhoUTNvRWlwS3BaY0ZrbzNPTVlYN0xt?=
 =?utf-8?B?Z1p1ZmFYbDczRGNTcXZla2FQOTlwZkxaUWVqNTJVTVN5RHdkMGEwUjdMU25w?=
 =?utf-8?B?V1Z5ZzRMdzhnS0U3WG83V2J6VlVremJ0RWMxazh2dmJJTk9DOGNXMG5LYktG?=
 =?utf-8?B?cGhSWEpZM2pkekdOL1BSL2JRM2NCQ2hLbHhLVW4xdmVPN2VPVCtUYktLd3Jw?=
 =?utf-8?B?YUt1M1BKQWF3ZkR5YTY0VkZwdStjbVdCYUM2SjVuNWhmelBSY0RtUXVIL29O?=
 =?utf-8?B?N01SYnN6ajRwZkErYlJpNjlMYWI0OWdkcXVjS2tIRTkveCtTTDhGMGVXdjkv?=
 =?utf-8?B?dHlvcG45ZTJ2amVUaGR2T09TUVJ5NWlnbXlReThSMVhHSzU0MG9abTZ4MGJT?=
 =?utf-8?B?S2kvV05qMzFYKzEwUnRQWGlQeko3VjBoOGhEczlZNzJtMFNQZTVEZzNFNXpy?=
 =?utf-8?B?eU1hVkhVSWRQanVRL280OFJXc015MWEva0VqeHFYSGNRczNtejd5cEZOTUZU?=
 =?utf-8?B?blRZcFU1ZnlWeUNnbmoxa2lGNTJEcXpQb250MnRDd3BFSHNXVXVnblg4NWZB?=
 =?utf-8?B?alVtYUNFNHpkUzRURnpNU1V2dUFZamgzczlSc1VNWDBQVXcwcTJKOGRMWFQ3?=
 =?utf-8?B?NHpOVkFEYWtPNXNLenc1TjNOVnlkdDlZTkFIbW02eWxRSjE2dnpvanVzckJ6?=
 =?utf-8?B?MzUwcExPY0pkSVdqTU8zUFRkSjFPMXJKN0RFT3I1clpTOUdsR2VTOUl2WHNX?=
 =?utf-8?B?eU1QZ3JsYittOGVGUGNPbklZUjRVVCswd1NFdWh4NHhENUUyUXJ2S1ByN1Rw?=
 =?utf-8?B?NlFkenpzUHZVdTBuZ1ZLNjIvZTdPbTBwUFFPaXdUTlc2Z2JXOVNFYmNUbnJK?=
 =?utf-8?B?ZUUxYXRFa091ajdmcE1nRjVvdUZMT0pEMktnYldJWDZFRmJwK1pXQU03d0Nn?=
 =?utf-8?B?NUhYazFvaGdoWWJrN3VRbUp6TWo3TFhZTGcvUlArV0k2ZmpXOW9TZkdaTE9w?=
 =?utf-8?B?YjZXNEJjU0t3SVl3UStQbFQ0RW9XNXFmYTZ5bXJ4MzZZMWtYNTVTSDBwNG51?=
 =?utf-8?B?N1hlVFRlbW9CSkpiMTJnM2dkcTBCaTV1cWh5UHFwYlJoY25mSnhQZjRaQzlu?=
 =?utf-8?B?TTdiaVdWb2MzMXFzWHlsSVlGYlZHSnBlaHFRTU54VUVuK3hLNEV1S0E1NmJv?=
 =?utf-8?B?aHZaREZxNHU4Qi8zVUtDbjNRalF2TjdoYzUzYitFWmdLeGs4dThRRWNHSjR4?=
 =?utf-8?B?YXIvUUpOUVZ6YlljWXZjYTAyY1Bod3h0bis5TWhzd0h2eGx5dDJ5NmwvRkpF?=
 =?utf-8?Q?Z699XdDwhmVZY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUYwNXo1ekt3ZzcyVGZPazJjMG5FeDdxY0NKNjNiVUhZUVZVcGhKSU9rR0hO?=
 =?utf-8?B?L0hiL3ZEMDRJQjhUUUE1NFRKcFArNXNMR211cXo1Mnc3R09vNnc5WTBmYVBE?=
 =?utf-8?B?UC8vT3dPY3o0WWUza3RvMzFqRDZ2eUhaMnFRSENaTUhRMERoU1R2VXVxNUh0?=
 =?utf-8?B?QjQ4V2QyTEFTL1lsMi83QllMMlRBZHRVRDlTOGdzTWV0V2d0Ung4Qi9mMWxv?=
 =?utf-8?B?WGpsNDU0Uk9RWlRScTdOc2lqb1pVL1g3d1dpSzNyWC9ocGZEWW1sSExyUy80?=
 =?utf-8?B?ZVQ1RFduUGNjSnBySXFPeEZya201OVptQjBsMnZvSnBlcDVsTStURVpkbnE2?=
 =?utf-8?B?Z0JSVTVwV1VNSDUybllGait6emVFSyttWHBGbFcyejhtd3lDNThUanVsT3Jv?=
 =?utf-8?B?STFkdUVHOUNWWUlHMWI4V2t4QlpiTkhocHhrVEc0N3ljZHpXZGNQNHJSaHFy?=
 =?utf-8?B?ZFFjMW81S2MrNm5VTEZicExYbFZuT0oxV2dCdkl4RzI5aG54aGhIcWMvQk9W?=
 =?utf-8?B?eE9SWlpQcDhUV0I5Q3RucHJqY21TS2xtZnBJTDV0ZStnU0NPQTVzTHZ4c3FY?=
 =?utf-8?B?WE1CTFl0UndUbG9NdUpCOGR5NnRFdDlDUEc0bUJxaFJoM0t4WWdKTWRDWUx1?=
 =?utf-8?B?RzV1WHUvOExBY3dZTm53Y1pYV0tHVjNQdjZ3V2NmVTZSNlZiL0hlZmJKc3l1?=
 =?utf-8?B?MDZFMlIxY2RMbVgwMDEwOG9CemNJWmE0a0VHbW9Ub0ZHK2tKR1RwNHRBUm9G?=
 =?utf-8?B?ZmZ6S3p2eU9uRUcyRC9pZ2JqU3FzZnEwdXBrdmpVWnVlU1d5MnhleGRQb3Ba?=
 =?utf-8?B?QUtMdXI1QzE3dEl1eHJ5d3ladGltT2M2R05SNXMvbFE4WXYrc0hsZEFHT0hy?=
 =?utf-8?B?UVNvWFYwaW9FWjNLRlhNbnBYdUVqalY0dGg4WWlvQjhnTXQ4NEFySWlDYUpP?=
 =?utf-8?B?Zy9Mc1A4c0MvMFpIMEFyaGFXR1VXdXdnZ1pJeCtZRVNhQ2UvNklKVHI1NnBr?=
 =?utf-8?B?M0VVZUZkMWU0bHVLMVZORXVwS2VCOTFXMHIyQytJZ05JVGtNZjNjLzhHZTBk?=
 =?utf-8?B?N1p5ZWRMa0M0NEJmNjBWNU1maUROenB6YjI3Wm1BekppMXE5dTRGYThrcG0w?=
 =?utf-8?B?bzQ5UG5VUlM2MWFYbnFIRGt1YU5WTjJxTHIxRUVKMDkraFJmZXAvSUhFMXVt?=
 =?utf-8?B?eVJEMFJjMW96Rks3WGl0NHRPRUdLSDlCdzJrTTNTNHZsMlgwc2dNblg3bXdt?=
 =?utf-8?B?eVQyVUpQNmVYT29YODdJeWo2WWJleklmRElWNUl2SEUvdFFmWG9idnY1VTRu?=
 =?utf-8?B?Yzc1T0luTjhaVWdpWWtNSzJWc0FYbm95dExpSFYyRTFwRTg5eDB3MDNXT0Zo?=
 =?utf-8?B?SHRxUExIWjJOaXZySWZUNkpnL3ZQZllrK0N5VjZ1OG9ONi9HeEM2VWJ5Q05V?=
 =?utf-8?B?dDVGeHc1a2V2dlloRy91M1pzejBVL0ROTDZPSHlQTkJ4ZnBjRnhNZGoySUxt?=
 =?utf-8?B?K1drL1dyM1Jib1MyaFRkV25JdkUrVE5aeVlmc1F6dVNBbW1LMjhIVVZvS0VY?=
 =?utf-8?B?Ny9QazhrMWlCcTc0R0RhNFlFaytoT2VLT0twc01zVWdsVEFuTitsOGR1ZjRp?=
 =?utf-8?B?M1hFa2ttZ2lZRmNSL0IyVTR0NXd4c0kraHoydElVWkNTK2VOUkdKQWlFeWdl?=
 =?utf-8?B?WXlmTkd2ZzBKZFYycDJiYUxmQ0ZrOGNZWGxHUWR5aGFqZVJVaGVrdVc2dmEx?=
 =?utf-8?B?SmZHWjY5U1ROVFBLY3RtMWFnVHpFVmlzK2dCQkowQ2dteEJiWmx2R0xuZnlI?=
 =?utf-8?B?U1EwdVgrMW1DK0tQc3JYYTVINFVCL0VUOXIvRE83UWFVai9EVXlPYk5waHRW?=
 =?utf-8?B?MFpyTUVudGNSTlI5ejYzTlg3MTFLMlRyT1BxQWgwd0IxRHVtZHVWS2h4MjlY?=
 =?utf-8?B?UFdEMFJlRGpmc3k5SVJEOTdqVUplRTVXbDZQemVXN0hxTkV0SVBFZjNteGVa?=
 =?utf-8?B?SWZzcG8rUGdFbDZ6T3JCb2dLWm5BNzF6Rk10K2gxZ1diRXZnSERRUVpvcUJL?=
 =?utf-8?B?U0xpVytBQ2dXU3J0bXFlcTE0MTNjMFhySWVHTkxCalE4MEJ5cE0wa3lmditI?=
 =?utf-8?Q?Jbc6cpet/j4AutLENXu4GCsVe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a6cf41-0a60-4f94-927f-08dd5a6e683c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 16:14:00.0092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yT3wxUg36zBFRlOriBL0S/mGSwOhzjrfvvSbyJTcWEyZUajiTBV46IsIe150chFYY2KPATijHZpnAnf//739dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF1D04084C7

PTP Hardware Clocks no longer require WRITE permission to perform
readonly operations, such as listing device capabilities or listening to
EXTTS events once they have been enabled by a process with WRITE
permissions.

Add '-r' option to testptp to open the PHC in readonly mode instead of
the default read-write mode. Skip enabling EXTTS if readonly mode is
requested.

Acked-by: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>
---
 tools/testing/selftests/ptp/testptp.c | 37 +++++++++++++++++----------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index 58064151f2c8..edc08a4433fd 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -140,6 +140,7 @@ static void usage(char *progname)
 		" -H val     set output phase to 'val' nanoseconds (requires -p)\n"
 		" -w val     set output pulse width to 'val' nanoseconds (requires -p)\n"
 		" -P val     enable or disable (val=1|0) the system clock PPS\n"
+		" -r         open the ptp clock in readonly mode\n"
 		" -s         set the ptp clock time from the system time\n"
 		" -S         set the system time from the ptp clock time\n"
 		" -t val     shift the ptp clock time by 'val' seconds\n"
@@ -188,6 +189,7 @@ int main(int argc, char *argv[])
 	int pin_index = -1, pin_func;
 	int pps = -1;
 	int seconds = 0;
+	int readonly = 0;
 	int settime = 0;
 	int channel = -1;
 	clockid_t ext_clockid = CLOCK_REALTIME;
@@ -200,7 +202,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xy:z"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xy:z"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -252,6 +254,9 @@ int main(int argc, char *argv[])
 		case 'P':
 			pps = atoi(optarg);
 			break;
+		case 'r':
+			readonly = 1;
+			break;
 		case 's':
 			settime = 1;
 			break;
@@ -308,7 +313,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	fd = open(device, O_RDWR);
+	fd = open(device, readonly ? O_RDONLY : O_RDWR);
 	if (fd < 0) {
 		fprintf(stderr, "opening %s: %s\n", device, strerror(errno));
 		return -1;
@@ -436,14 +441,16 @@ int main(int argc, char *argv[])
 	}
 
 	if (extts) {
-		memset(&extts_request, 0, sizeof(extts_request));
-		extts_request.index = index;
-		extts_request.flags = PTP_ENABLE_FEATURE;
-		if (ioctl(fd, PTP_EXTTS_REQUEST, &extts_request)) {
-			perror("PTP_EXTTS_REQUEST");
-			extts = 0;
-		} else {
-			puts("external time stamp request okay");
+		if (!readonly) {
+			memset(&extts_request, 0, sizeof(extts_request));
+			extts_request.index = index;
+			extts_request.flags = PTP_ENABLE_FEATURE;
+			if (ioctl(fd, PTP_EXTTS_REQUEST, &extts_request)) {
+				perror("PTP_EXTTS_REQUEST");
+				extts = 0;
+			} else {
+				puts("external time stamp request okay");
+			}
 		}
 		for (; extts; extts--) {
 			cnt = read(fd, &event, sizeof(event));
@@ -455,10 +462,12 @@ int main(int argc, char *argv[])
 			       event.t.sec, event.t.nsec);
 			fflush(stdout);
 		}
-		/* Disable the feature again. */
-		extts_request.flags = 0;
-		if (ioctl(fd, PTP_EXTTS_REQUEST, &extts_request)) {
-			perror("PTP_EXTTS_REQUEST");
+		if (!readonly) {
+			/* Disable the feature again. */
+			extts_request.flags = 0;
+			if (ioctl(fd, PTP_EXTTS_REQUEST, &extts_request)) {
+				perror("PTP_EXTTS_REQUEST");
+			}
 		}
 	}
 
-- 
2.43.5


