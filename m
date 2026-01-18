Return-Path: <netdev+bounces-250763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A09D391EA
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 01:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52598300D492
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0390A184524;
	Sun, 18 Jan 2026 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="meojs8WE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367A419CD03;
	Sun, 18 Jan 2026 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768696585; cv=fail; b=HXmBh3TrLY9xOpCuoN3pfcifA0QAXN2AAZHKPvpVyekXO5Y8y86A73IyeqpIAe92+ND9t9Y+rvuaBkZmUkRcvddmKXWmHE2GLqtWQglSay1YTintXNEbDrkHgVMhMUPLa5toiRJ5HR5N1qVjSVizgS8lr2BLhlYnGTAx4XaF7Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768696585; c=relaxed/simple;
	bh=gevdEvEtt6KovDtSbtUqMJeNfyJH9ZzX+gjQu9mjvQM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ip9KzQpB9iNasVfWzeWGOAo87Bp3v9GuN5E5d7ZIG/48b3hlF4ns5DG9ze7tWo7SKk29f7JJwrqwTdB2aUgd0iPd5ycC0/IAZAdX5B2m/M6UuqjL3Wuky+MIHA4Cw4tcqh3hcqcKpFxwe1U8dJ341KoQKmYWllroNbTWv28yy4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=meojs8WE; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60HGdu2K3247088;
	Sat, 17 Jan 2026 16:35:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Jc3zXWMFvpU2bR2eUj4aEeWGmRRIKOn8QfY6TbiZoxU=; b=meojs8WEpuXu
	VyhPlRxn08tGxKpL9QwxgWyd4ndufGi+wnDNwHCy1+WmQhhB11xw2mJ7bb/S0wN1
	T6MXIOaiVaGh0OaJ72k7MEV5MXLd+NbUiY9gBWqVg04VegJKZbIXAAZQ3jOAR/2s
	Xxqnru9+8Z4iuqkfOWGAuFfopB35Co0o4xZDLie/qciyk+xgHgBo7Hpk7jh4D/K7
	6s0GN7sEuVHXa06mogp/z27UlWG0tUWxYcgU9jWmI9VDQwM/oPI2asp6p5otGXPw
	Xqm0AZU2aJjKUuMqyrtca7WuZ0I/anG6H43eLnsHGIpq8n44KFfQO1rfAjpxdYbw
	rWWDX/rrtA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bre519bgq-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 16:35:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rK/VMPRWqVwz6+QxdUh81TQ7H/r+t69YlH8oB4yBRF8lL/iXGXUF6AbptxFk4tx9CtWurEa2midujits3PHeAj47QF2daHMi3E5Z7ZtLaCBXJQ9+ir5GsZ6B/BKlw57vriKtHzvoWbdEpKwOmPVtsoCksNNzbbb0083ClQTVOGjgF8J3IhUql+hFMb6IvJQClWMMJ3XrM6re+D/VfMUYeHvPt0hEtZgrfz1WM4vRsdbQuHYfE9Bo3JDXgfFaFhhHFGcWjGWVVVvOt2DdxiESyw3eHtZkxbnrn0oyViiDvYO0IFd3gLmjBIPQFspbD72jkJx8uY182Gch/ecSkfkMCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jc3zXWMFvpU2bR2eUj4aEeWGmRRIKOn8QfY6TbiZoxU=;
 b=JiooxIbSyZqMy6lCI/PYr4SFcScLY+uAX4I7+EWJEn8S4K+vqgjW49vSdKr/83VLQZypyK/5cYBYdVQlBXMpy/JEd1S3IZiZJjTT849uZYO85DUbY1m2AUPr29zeuW9N3Pn6mgcNtRUjDdEJElEFj3uE/IEpkRn/F5Fn4te6P6DKonxdx9fAjSiSh7q5efeMGoojX2suB/ix5DPC4SeSJ5tigWk0PQA4Hk7/k6ytArZMOqDMVIq6g9RgG7nC5c7bjuViwamW+f7ftjY82QwyXlmcQVrTb6vS90OQx2tvE0T7k5gxFA9qxwXnq6Kd02Nzy1gIQQkt1Q8hqbkDWOiOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by CH4PR15MB6647.namprd15.prod.outlook.com (2603:10b6:610:225::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 00:35:52 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5%4]) with mapi id 15.20.9520.006; Sun, 18 Jan 2026
 00:35:51 +0000
Message-ID: <94604894-16b9-44dc-a2a5-bf2106b027ab@meta.com>
Date: Sat, 17 Jan 2026 19:35:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [v2,2/5] net: phy: realtek: simplify C22 reg access via
 MDIO_MMD_VEND2
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, michael@fossekall.de,
        linux@armlinux.org.uk, edumazet@google.com, andrew@lunn.ch,
        olek2@wp.pl, davem@davemloft.net, vladimir.oltean@nxp.com,
        netdev@vger.kernel.org, pabeni@redhat.com
References: <fd49d86bd0445b76269fd3ea456c709c2066683f.1768275364.git.daniel@makrotopia.org>
 <20260117232006.1000673-1-kuba@kernel.org> <aWwd9LoVI6j8JBTc@makrotopia.org>
 <20260117155515.5e8a5dba@kernel.org>
 <2279fd03-6261-44fb-b4c5-df2786a17aa0@meta.com>
 <20260117161708.049eec6e@kernel.org>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <20260117161708.049eec6e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::18) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|CH4PR15MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 46390a41-b202-4d20-0f9a-08de56298883
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NFV5azlSNUhHa0xTdFYxcE04M0NjY2F5WURnMlBHbDdEK0owVG93Y2g4S3Rz?=
 =?utf-8?B?UkhYdCtQekpDUi8xZFNpYmJaSHpMSDZ0TTU3VGNmOFdmQUhEdGtSVU9iN1VP?=
 =?utf-8?B?TmFlYzJmVm85TFFrUFVNWldoRzBNUWJVZmx5aVlCMENJa0gzQ3ZsUzJZdTJq?=
 =?utf-8?B?K1pwNlMrN0JMYXF6WWkzbFpoUzZiM1Y5czRxVStnQko0dU5RZldVYy9ybzdl?=
 =?utf-8?B?c0p4M1MzWWhMV2diR2V4c3ZidjRXMmdWQnFQVUl5V3k5LzMzWHR2ektCU1dh?=
 =?utf-8?B?Q0tqdTRNNW0xWHMzcjlxQml4WEJscWxPczFhU0FScVc2MnY1QU1DTzNQZk5S?=
 =?utf-8?B?dXFWQnVDN1BLd0daZEZZVlVkaVRBQTZ1V0NTSmFrdHE5SkxvbUVrQVREeENQ?=
 =?utf-8?B?SHI2cXcxdTlWKzUvSFNRNzBWK3J3NGZYY21YQW1wRmgwT0NCbnA1SDRHbytY?=
 =?utf-8?B?eGd6RHB6ckYrZEZ0SEhqM3BuZlQ3OFlhcW9nYzVkc0hKMkZuZUJDTzkxN1I0?=
 =?utf-8?B?Qm02L2RYVFpxdXRBUWlUczZ4clhUT0cwMEVnVVQ4Y1FQRW5vNzI1YjQxNHJu?=
 =?utf-8?B?bWVncSthVFFicnZyTmVoWVRIT1UvWEIvMU5JbTNtZ2ZZREtsbGx3dmZUU2Vh?=
 =?utf-8?B?eXVnai8vNURxYjZ4QnVyMU1HekVlR2RUNkNRYUdPajFJV3MvUTRVV0ttYUwr?=
 =?utf-8?B?N3RtUzBqRFBDZlJlNDRBK3g0Y3oyZm9hWXVnMEZJVmRQNXJkQ1pIRTVJN1g5?=
 =?utf-8?B?TmY2Y2FsRm1iOEMyWjB2cnNtcUR1bG9pYkdIdDR1ejNEdm84cWdwTUpZRG1G?=
 =?utf-8?B?UnZISjVwUENoOE1vVW16aGliWGhjZExKbnRJUmdqWDEzYi9lZTJsS0NXQ1RE?=
 =?utf-8?B?ZDVMbE45ZjNrVEYyUytmTXNObHVBcC93UkNTRnJuYUpSS2tGUm9SbVBiM2l2?=
 =?utf-8?B?WDh4UmxjZTVuNWM4NGp4c3dHZzBnNkV3VjNhdTBmUlNiS3B0K09iM01JSi9J?=
 =?utf-8?B?akoxWG8yaUdSYU9RMFUxeDZuQStzYTRMOWlzTmNmM0tjanU5aExORGd4Qyts?=
 =?utf-8?B?bU5ZUzlvQUExdTUzeTZVNnc3dkJTVHIrNjNGQTVML0wxUVNoRWpZTU5FSWtP?=
 =?utf-8?B?MU1jYWhnTEh3MFlleVJGRUVsN1lBaXhZOStEWCt1VjNXOExNSElJNFNQeHN1?=
 =?utf-8?B?WDNSNnV4djhNS0NZZzIzNEozelVQZVNVNmJESkZIN202WmpLcng1akRoLytR?=
 =?utf-8?B?ZGxWTll1YkhLQ0dFS1FONTJvK3FsUVVhMWRqcm93ZWc2MFBHd1dubU95a1N1?=
 =?utf-8?B?Sno3aWdJejAzVUVhSHdiTWtIYjlRUXFmTjVvd3prbDlsMWVxOUNhYjI0SHM1?=
 =?utf-8?B?RThZNTYxZUJ6RFJDdTZ6SDJCbTZRc1lLWWo4L1RsMDRaZzBVZ2xPeTBZQ2Vm?=
 =?utf-8?B?SllWMG9PNlVUa1psMnVzc0IrYVJaYW93N1dsdUZVd0hmR3ZZWkdyb2NuclJK?=
 =?utf-8?B?bDBhVmJjeFVJKzNXV2UxV3FrOEN1SHRhWFJJUnBjbzZNZ3ZpNHFmOUdmN2hH?=
 =?utf-8?B?dVBTaVZQTHBRMEJIS1NxaTdUZHc4YTNzcFBIM2I4OS95WXk0YUxJOTcrYU9F?=
 =?utf-8?B?T1FnZEFSd2M2ZWtJL0FBMEp1OWFVaktNUUpyT1BsaFVMd1lYeUQvbExGazkw?=
 =?utf-8?B?UktrS2pJUFpLRE9hOHhIemFsa0w3ajJ5aEprRmNvdDRmeHFZYzRIa1dsZ1Mr?=
 =?utf-8?B?RnJnZkkwNWY3M0hVcjlFUE9NcksyQ2FIdnlabXl3NG02ajhXR201SExMUlZZ?=
 =?utf-8?B?akJTblVNbGszQUtiR2ZJOS9QdGoyYWtNS3pYN1NnOTdldElaZHB3Wmw4cjUy?=
 =?utf-8?B?QUhWT20rcHlEbG5xRWZ6dGtyN0hSREdxcFF6SDBKazFWWXpEVDdoVWlGQ056?=
 =?utf-8?B?Z2hCMTM3RjRDSk5kaUkzQVV4NUlieWhQS1NOWXllOHpXdU1LV2lqd09FR0JE?=
 =?utf-8?B?UmlVSVZZNHB0b05MbG52SjYxMGU4Q1NWU01iUHZhMFZyQm9CVk1XMG9wdEQ0?=
 =?utf-8?B?RWl1eGhsQkFUOEVhL3MyOHFadVpLbGliNStIREowUFlPZW0wWDRJV01VbThD?=
 =?utf-8?Q?0L3o=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MmJLK0Nka3hITUdVb2dDcitKbnQwTVpqSENKdkcycllNWU1aSkNGc2hzZk1Y?=
 =?utf-8?B?a0kzUGxiMmNrcWNPem0vZHVVSHhRTDFFaWpUenF6M1NrbjBmTkxXbjZlWllX?=
 =?utf-8?B?QzNuR3VubVVDbEF5QXBMWmxiNUxKMVp1bjIyeHFqcURRV1A2TG9zYjRqVGF6?=
 =?utf-8?B?bGlibFhVTlJiaFd5R3FPWVRvUURLVGNEcXhadU1qUnZKa0k1a25NZzhGcitj?=
 =?utf-8?B?UjdrS3lSRCtrTDFua1RIa25CdHVPYzFUdFZBZFlnL1VUbC8xRVNmZnB6cGQw?=
 =?utf-8?B?VDVGRi95dWZNakIrQ2x4aEVITVJEUFRPV3UranI4RXBtbmcvWnZFQ1p0RWZn?=
 =?utf-8?B?d21UcnU2NXBHNnQ2NXphNWU1bmQvRVlBVFRQM0hXaHJuS2lZM2ZyWlFHU2gy?=
 =?utf-8?B?dFd0WmZ4K05kUDF5ZUpUU0FNUUhTbjlWMWtrcCtlUnVUM1N6V0U4REE1cFdX?=
 =?utf-8?B?TTJzZ1BiRmpESC9uSnQrVi9WS0ZXRFo0Y0loMjNva2JzZ3hkWEpVVWF0dDVY?=
 =?utf-8?B?ZUx3WnF0KzBvSnJmaGpYN25rcDVGNkdrQWZ1dHN5M0p4MGJnUEhZN295WnE3?=
 =?utf-8?B?anNMK2VtZmJQQWVNWnRPSzRtWUNRcThPUEFDd3hNdDdLTTJHd0syODVkeU1Z?=
 =?utf-8?B?VjVoTkVvWXlDcTM4Yzladm4rWXlmV0toUGMrelo3UHEvNi9qbTlkUHZOVERQ?=
 =?utf-8?B?WGgwa0dobFY4TzJ5OG1HV00zU3BhRlYrcERIUlFkQTRqV0JYT2YveWNsbVYr?=
 =?utf-8?B?S2NnVks0K0szV0JqVE9QZXZqZHJQU3cxN2xEVmhCK0tndVBqUnhST3MzOExq?=
 =?utf-8?B?Q3ZVMVd5MFVRTE9abnBSWlVSUjkxMEx2eGRTVi9Zb212RUJZR3pKa2lYdFpl?=
 =?utf-8?B?VW5hV1AvMXFTdmlIMEdtalVlSEV3WnhUMkFMOVJtdG1GWjM3UzBEWlg5YWY0?=
 =?utf-8?B?bXFCbSsvNFpIbG9Kb2I0VEMzTjgrNnY2NHdadTBORTlNRjJuN3NTRXR4d3Nv?=
 =?utf-8?B?NVFsVERwaktvWWJxOWNzV1ZDeTYrVWxvTlZ2MGg2SUNScGFhRVlkUzhmZldV?=
 =?utf-8?B?WkxoamZsVUx3NmdxbTA5aTBxSmRwYlJNOTMweDBzbHYzOVRYZ1lLNWRPUWpH?=
 =?utf-8?B?SVVCU1hzRGxDYVI0N1liRVlqSk84QUpDWDAvM3lNM1BlcE1KN3JjZWRTRmcy?=
 =?utf-8?B?dlZjdmhtZnpIZ09QMzJ6Zkt4OWg0T0E0ZThMRjQ3YjRlWFdWUkJ4YStERmIz?=
 =?utf-8?B?OWdUK0ZqdEZ3UlhpaW9DYUhld2pHbEFoMUpNZkdobUpWUUQ4ZS9PdmE4Q0NV?=
 =?utf-8?B?ZEhUeWwwMVBtcGFZNmpRVm5kMVp4bnVSWnRpbkhRZjIyaUJzMWFwcVNQVDYr?=
 =?utf-8?B?VFB1dWllOGZuemZoUm1KOEhsaWl3T1d3YTBYbm1KdVlDZDZxZ1cwMnpnamRw?=
 =?utf-8?B?MzJWNlNURE1zMVhXNzF4RUgxZzFIek9zNk9zcTZhSWFFSGRLeTMzOXVsdUZ5?=
 =?utf-8?B?MG9DeWowV2tneURUVUVGSDhaVWk5RC9Bai9ySUZwQW96c0N4ZmNDVXhpUTBN?=
 =?utf-8?B?MXJiSGppRXpXR2IydUZkcE5sWlM3UFVtUDRGTUdpQjNNWHNOSUxTVjRqLzBX?=
 =?utf-8?B?c3h6UVg0RTF3dk9aRXNGd2U2bitnWmJZS3FrRUlCQ01XSWdMeTh0bFVwa25j?=
 =?utf-8?B?NUlOSUxuMm5TejdKL25OWlA0V1A2NGRlV2JIZlRzemx3STBDamZ2SnFXc0tp?=
 =?utf-8?B?SVNKeEFPQlRTUWJtMGcvbkowZTgzamRkdGVWWlJFaXErb1RIZzRoVGJ6OTcw?=
 =?utf-8?B?SXBqY3BvNjhPTHRHQ285NDJYdTgzZ0lDU2EyUDhQMmQxdFdmK3JEN3JBbFJP?=
 =?utf-8?B?R1pITktZVTcxL2JteFROR3p3TFdNZ3l4UlNyelBWTUJ3VXdJelRjMytRbTJX?=
 =?utf-8?B?V001RXdUeWd2MmtrdFVLbVFSQWlPY0hqVDFYVVZaMVJNb1IydEhraVF1UTdQ?=
 =?utf-8?B?UTl4VVhHZ3JwTzBkZDI1aCt4TVJCRFpWZWlDd0xMUHNZcFp3bmRtdDlVVHVE?=
 =?utf-8?B?Sy9wR21vaEJNOG13eE9pYWMvU3V4M0VBS3ZYOThCUjVFYUlxU21Pd2NtS215?=
 =?utf-8?B?UWp5VWFpMVphSUdlcUFsMEFOSjd2ZkV4VkNDWDE5QnZMVmVOUVN2NU10a1Zv?=
 =?utf-8?B?WkFic2VHNUZOcmtnTE8zMmJIMUtLeDFUMGxQN2JGd0xaUHVkV1NLdnhVeEJl?=
 =?utf-8?B?ZWg4NStMTCtQL09IQ2RJUVo4UXBVczNKbklRNWlMNDhmQ1NhVDYwTm9JM2tV?=
 =?utf-8?Q?Veo5b+Tggmxktwt5dj?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46390a41-b202-4d20-0f9a-08de56298883
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 00:35:51.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ChBjI9tIH7lRfFNFwlXJc0Gau7TrW+VvuqSRpd6FGvOquEt1Mg4T1ClL1Xxg5aB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR15MB6647
X-Proofpoint-ORIG-GUID: ys_QLOJpjpPAGjYEg-NQhHKC3DY50vbZ
X-Proofpoint-GUID: ys_QLOJpjpPAGjYEg-NQhHKC3DY50vbZ
X-Authority-Analysis: v=2.4 cv=ZeQQ98VA c=1 sm=1 tr=0 ts=696c2aeb cx=c_pps
 a=miuBlqXM8bFb40OTON37XA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=WCFBw7OsLRUffPuzCy8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDAwMyBTYWx0ZWRfX4PouR0j5/QZL
 auIXMdn1EeRTW8GQWDxQEFF4zKh35tnM7Yaf7Ih0ilddkLCN6YxQSLNWYfMuQYIh8QcKwMWo3AY
 4Q+bb7G1F9YBNBOCYTnSYHTqrNc6DIJtTJwXA9zdZAqVZXhi5TtOXWKrcvuDbEf0oc5DHvsWCgK
 U3Z2qmT3YUpCvRRqYk/Ks1TillwAioA2vslhsBOeVuMd0gunHoJeilpPbyv2t6emJUCCEHuTFUG
 Ot56GpJBo4p1c7/mMXpH8Uh+a4Acwg25xBkIX6+8n5AnG3fS4Hw8s58rdgKkxCGJsCpKoXqbf/N
 jy3rX3U2YbSzpXZzKmmU+FaUml7K6lZlNEXlhFUxvpgxZRBZU/wdy5+N2il/8MkNFDu2CZ6K7Op
 thChHljfWWGAvtCLufKoOcUEbY18mVCuwPmA1qH8euy1ErLg0TQLJzUYWCOuYxtqm3HJXhwi0vq
 ENMGatdSR2nGLM+sqzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01

On 1/17/26 7:17 PM, Jakub Kicinski wrote:
> On Sat, 17 Jan 2026 19:10:15 -0500 Chris Mason wrote:
>>>> Yeah. Just that this is not part of the series submitted.
>>>> It's rather a (halucinated) partial revert of
>>>> [v2,4/5] net: phy: realtek: demystify PHYSR register location  
>>>
>>> Oh wow, that's a first. No idea how this happened. Is the chunk if
>>> hallucinated from another WIP patch set?
>>>
>>> Chris, FWIW this is before we added lore indexing so I don't think 
>>> it got it from the list. Is it possible that semcode index is polluted
>>> by previous submissions? Still, even if, it's weird that it'd
>>> hallucinate a chunk of a patch.  
>>
>> We've definitely had it mix up hunks from other commits, but not since 
>> I changed the prompts to make it re-read the files before writing
>> review-inline.txt.
> 
> To be clear as Daniel mentioned the chunk in patch 4 is the other way,
> so it "reverted" the direction too. At least we have a chance to use
> the "mark as false positive" in the system :)
> 
> Daniel, series applied, thanks! The pw-bot is down, I think K is
> repacking repos so expect a delay in the official "applied" msg.

Yeah, it looked forward in the series and noticed the later patch
reverting those hunks.  If you read the logs, it goes back and forth
trying to decide if an issue it found was worth reporting given that it
was changed in the later commit.

And then, I think it just forgot which hunks were which.  I'll try to
beef up the section double checking diff contents.

-chris


