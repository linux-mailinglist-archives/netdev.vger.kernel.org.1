Return-Path: <netdev+bounces-214020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BC5B27D5F
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 11:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C3462330C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 09:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252362FAC01;
	Fri, 15 Aug 2025 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EqoY+K4y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567292FA0DC;
	Fri, 15 Aug 2025 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250711; cv=fail; b=UIp5HrxOPJphj2KDGallO75WRAla1yMowJs1+Dp9EkBtnk9CkKLYxyDdUfgj1ioKkLErEPI9kTN+sefR78afQ065ICwEfd/Z/YrYhY2psO77O/OLUvFYMt83YAu+oTRetf5uqE/7lBoVN1oj7cWv1+vmEEuHmS6MqhNGHFNVH60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250711; c=relaxed/simple;
	bh=yk9rdKaYnyngNUxjDxox+FXxmtO7H5Mdg8TlhFwWOYE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A3XXWkX+x8COTqM71I1NzA7rLB7hdYamt5GutRuhLRkCbeWReDSgbYYBvdVmNEbHehkTk7Ctk2SjcSF7fXhQLNo9D75neS6JRl9S2UTOra/0WGEn/5YHZr7uwT22/6aedtKL91keTCjyIo4hXK3rqFdWqLwRf+ggYMQFdXGPuvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EqoY+K4y; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdLvc12bpCBBPkfCNFwSX27HFjONMWdKfYyFnjS+9WcTsD8NQKYtZVAt3ZjiGeL57KPJA3YVLUzbiXxGd//95LnTsYgVwe5kpGkmu53Xg+tMw1FSwePC4b2VH2FDf3ehjIcYtyz/2SYJ6x0uSKossuxmlOakQqJn77wE06rBI3fqkW5J/B/euNHTBl2ewUlKCEeVy+WeU979n46W8wzkVkpMvqQuoll8BJ9lfVoMXviTtUiafVFZPLXGS0psYt845dUl+mGllv0JJg7abOErhQA+zMNz6FcisXqISU0td3Egzqm0dsZLTZ7gMHausPUPJ2JMrmv1aSPmxk/pYtVC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeXghW7N6MNcAadLUwULsCxyK6DOHjf8SfNv4HOVHhg=;
 b=wvEBGTHA2fOD94UR5KNlrJ3sL5LF7uMp33CNEdDVWfjEsCuuOOnUmgI3aEPZ61pIuXYG2WQEZxxIfqRYIVrW6JwlGya34eddtvAeb/d743YSEswyGXXzB6l3kwaIgcBSYeGEFg83pu3JpdNGqdkQxBKFMtihwYxX3kB5ORGhbiuMsbrIa/nBuflh+0VkOiqfcnBeUuLVRPSo3s92nmyp7H84a1okUP8F5ng7es2YZYYr1b6GuXJ0eru6iyJ+cNVswD4/QWFvlTqNIxI9kt7kBfFANB84HUi3haf8AWrUPVM76I+0mqsQH9+20IJXBIOhZtvqBDGanuSwMg14oPQioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeXghW7N6MNcAadLUwULsCxyK6DOHjf8SfNv4HOVHhg=;
 b=EqoY+K4yCtaCeH/Hkx0Cxm77pepPRptfPJPL5pRuSZlaEAYgezTYCHH8cJ7Ko9VzBY1oy1DOafKxZT6CCqq3s8RKkB0WNE9beA1Yygr4im3bKQzMH7bRua9oH/vzusRCHzgQ+ydE5Ofs19wGORrWhWbqLaxKJytAFsAaH78vKhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13)
 by BN5PR12MB9461.namprd12.prod.outlook.com (2603:10b6:408:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 09:38:26 +0000
Received: from CH3PR12MB7523.namprd12.prod.outlook.com
 ([fe80::f722:9f71:3c1a:f216]) by CH3PR12MB7523.namprd12.prod.outlook.com
 ([fe80::f722:9f71:3c1a:f216%6]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:38:26 +0000
Message-ID: <595d754a-c8c2-4ef0-bdbd-3ff25330224a@amd.com>
Date: Fri, 15 Aug 2025 15:08:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] amd-xgbe: Configure and retrieve 'tx-usecs'
 for Tx coalescing
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shyam-sundar.S-k@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250812045035.3376179-1-Vishal.Badole@amd.com>
 <20250813170012.7436b6e6@kernel.org>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <20250813170012.7436b6e6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::15) To CH3PR12MB7523.namprd12.prod.outlook.com
 (2603:10b6:610:148::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7523:EE_|BN5PR12MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: e45a0d59-e17e-43bf-e40a-08dddbdf7be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3BnSEozYUJiK2lQT3NvQUsrZWRuZkFoL0RlNndURnowSEtKSXlKTDZxa0Z5?=
 =?utf-8?B?S29SSldCRzNSeXBlM1lYb3h5cVE2SW9OR2JPNmh3MW1zeGRUR25KVWN2Ykpa?=
 =?utf-8?B?QXR0eXg3YndJK2VnaXI3S1VTUzc5TU01WXdpaGl4T2lXaGhFRU5HaSt2YmY4?=
 =?utf-8?B?M2VBa1AyUytHSXdSODcrNUNMdDR3RVliYjlHOHFYRWtIR3dlMHRxSE5mMThm?=
 =?utf-8?B?TXdyaG9oYmhjMi84ZlkzTW9VYXNYZ09RbEh1elhMZ2VkSXRBaVF1YWl3NHJV?=
 =?utf-8?B?SmxUdTIxamhPYU1zbjZuM1VEWTRBV0RrLy81K005Nm12QkZianJudlRWMjB0?=
 =?utf-8?B?d3ZJRFNKelk0enIxcG1pT00wRTBFbDZFVmM4MUJZc0lGZUJNU1VMY0R3Nk9k?=
 =?utf-8?B?WmpaVWVlKytmYVNxQS9BaExNMEJxM3h6VDFQYmZOQ05KQWRoNGVnOC84Yllp?=
 =?utf-8?B?ZXE5T0JFWEI0U3dPV1VreWVSVFhXOXM5RElEeXo0M2c4eVg5QlplejZtdFhK?=
 =?utf-8?B?NUVhMG95OWxDbi81eHBvM01BaWZBTW9BSTE3WmdEU1hQWnJmRytPdkJXbnJ5?=
 =?utf-8?B?SG8raWd1c2xrQVF6U2Z6Rnh4YjhBaEV3S2JZV0wwOFkybDJBTGdEejhOOXBY?=
 =?utf-8?B?VUZ0cW9WNWEwWk1ma2FLbUEwNGYzT3o4bUdiUVJ0bW91aTJuNUpCdlkxdzBU?=
 =?utf-8?B?TExzdFM3N2RiOGJyK2R1Q2VvUW9pbTl3Q2tHRjB6Vm1Id3F5cW4xR2daQWhy?=
 =?utf-8?B?WmNYbHdubWZQdFc3MklhYVZvYWNyTExuUkdsV084ak5QNWZhZk92QlJXL21m?=
 =?utf-8?B?Qktra2VRcFlVSG5hcUFMRjBDR2JRNTdIdVRzcjdXUnQvWUMvOVdVM0pWYzdQ?=
 =?utf-8?B?Wjh0TWx1Y0g1OCtjVmh0ODU3d3NGVU9WRzNYZ0VCc3Z3RG5kekhDWHRpdDBs?=
 =?utf-8?B?aWIzS1hXTDVnMXcvRFBhb3pTSUNjWmZHbTZOSDJRdFdlS2pPQlpsL2Vta09E?=
 =?utf-8?B?a1puc1NmcGcrN0JRUGJOdmR5WWdTYk9pWmppNmkyNk1oZ1dpcnVwUnpITjJv?=
 =?utf-8?B?aEtOWWpSQzgxYnZ4S2x1c1RQZmVTVkhNSjdoWHQ5K2x0TTkvcDcxMjl6SW9s?=
 =?utf-8?B?OUM3dWpUR1hIK0NRYW1BcHdOUHdMdTZleDZOVUsrYUpTUDlDcWluT3ZyVGFW?=
 =?utf-8?B?LzhUT3p4VXFJV3VuTHB1c21rUTJnQWc2Zm9UWk1OOHU0NVRDbmhDV1RydjRp?=
 =?utf-8?B?VnBTekhLbjlHa0kyeGJIVEpPMHdqTFZDVjBXbmZyazRiMVdMUy9TN3YrdEMy?=
 =?utf-8?B?TDlicW9kNlBiSzdONXE5NUR5UmhYTWNXQXNzUGoySGlJQThlWlowNTZtZHo3?=
 =?utf-8?B?dVV4anRqK2ZuOEVSK3Y4NkVoRzNPdlJBRjBpN1RxcURrRkRrRExaYUFwZnhu?=
 =?utf-8?B?YTRjZ3ZBK0NzcVd0WGF0Wm4xd2VidmRUNTFleDAzL0R0VjZNTmt1YnRDZXRF?=
 =?utf-8?B?eGtUODF6YjF0VFppMkZNZXJ3UHVsb3FSV3NOMFJZRXpnWTVVSTlrTmR0aGpz?=
 =?utf-8?B?aDdaU2JCQ282bGJjdldqSlZJT2hRdmovZXVmdXljam9DcmhUVUZZcjI0RTRX?=
 =?utf-8?B?QmNkVnJ1OVB4REtwQ0ErdUJrSWxxeHNHL0xOTk9hNmF6RWdKM3JGeHlONVZN?=
 =?utf-8?B?MmYxNXVqUXdmSkR3UnVlaUNQVFBtT1FoVUtVYlgyNVZZTWdaTTBKczYwVVNi?=
 =?utf-8?B?Mm92Z2tCdmF4NHpaSXMzdGpvVVdEUFlabmhBclEzU3FvSU5iMVRvSjZuMFhC?=
 =?utf-8?B?a2hDWjlVdWsrOWFzV3JqY1JOOFBLSjJ2T2RCUVNxYzdJWC9CZ2JOUWdYMVFY?=
 =?utf-8?B?d0FLS0I3ekdhcUhIMjVNazc0c3lXZHE0Uk5teExqWnhhRGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7523.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEVsQVhJVWJYcXhUUVI2c3V4cU9aLzRrZitNUEkrL0JTdTBXS1JVTmg3RVRh?=
 =?utf-8?B?OXYrWGx4Nms0UDMxK3B6dS9SeDlRSU40c2FvSEJ6bVBIeldERzdsQ0xLdlFB?=
 =?utf-8?B?MTNpcVdCcjJ5cnNzR2Z2ZFpHQ2J5cS9jWm0zc1g4V2JLM3F5N3M2NkZhNUxH?=
 =?utf-8?B?cUNIa1VSdk0xQVdSSTVmb1NCU0RpL3pJR3VrYTc1TlNEQVU0a1Nnc1p0Mmds?=
 =?utf-8?B?VGxUejBCSDlrRkEwVFRPcmhJYnNCQVBUaFBBL3BWK2dhVmNURWJ2dkRNQ3Er?=
 =?utf-8?B?SUNFRXZTUW5pQmhEZ1hrdWRyTnZPbkE5aGVNVkJSZFNoUEh5YVRiVHlybG9h?=
 =?utf-8?B?RWNzMENueXlBeFZBbHljUnFlek8wMEx6cHFCdzNBZG90RmQ4Wmx6c3R2Rk96?=
 =?utf-8?B?dGRQK2dOOXNZbUxTeHFEQUlIYmpqMjNad2JjZ3NraGZDYVYvdm5YVzdMSStu?=
 =?utf-8?B?U2ozSGpiNVR0V0Z0c2R6MDM5S1BLdVgxVGZCVXFsRUIrbkYyU2xqUWlTbE1W?=
 =?utf-8?B?WGlrSXNGQU5FMXlRY1A4VEtFWXRuaHkrcGVxV3pKaHlVcm1UcjBnNW04OEJZ?=
 =?utf-8?B?cWxYUU5PSkp2Sno5VkVwK0VBNm93bzdMQmVuUEFPWFFHNjVtbGZJdHZOcHhO?=
 =?utf-8?B?TGN6M1g3RkJnOXZLQUtwQUw4WFJRSnpqbG9NOWxKVWFUNWhWU09IVnB5aFVz?=
 =?utf-8?B?NDRnbTJjMGt3RVNaNnpUSjRFQndBTTJWa090RDNaV1pTUmxoNWtJWG5XNm1w?=
 =?utf-8?B?ZHRlMlJNVy9rMWFhMHpPWW0wdlJhaVV6QzlsczFXWER0NWFlSnVWZjl3aVVz?=
 =?utf-8?B?WVFEa1VzakRTdjNTazFyZGtxdVNqQ25aQkN2alNWbGZTMnIvVlhjSFk0R3lq?=
 =?utf-8?B?WkNmd2lOSTlPMTRVcjhsQW1pMjBPMlliZTlTZ1AyQm5MWTA4UURkRks5THFX?=
 =?utf-8?B?VXV6VXByeXFhY0FzRU9WTU1DZXM1NnVKU1Blb2hxek91THVnZHh6YWlGbDdU?=
 =?utf-8?B?V0x2S3djRHJOdE5ic3NZVEcrWVRWencxYWJhdGhlQlUyNEM0b0FSa0lMTTAy?=
 =?utf-8?B?TmNYeGxKQzhZTGhJeUFZSzVhLzN6NWIvMWx4ZVVQNnVTM1VpbktqUnNxTDZy?=
 =?utf-8?B?cWNZR0liQ1dwb1N1TWg1bDZsempneXF1MUJJekhwQVlBL0FYeWN4RE5KRnZm?=
 =?utf-8?B?ckh0SURHN2U1bnlRd0ZvTG1uNk14UDRxZWE4R3M5VTI2dDJGRjQvZkxoZ2xD?=
 =?utf-8?B?bUdWbHZ1dDk3V1pZdlJZVUhQdWY4MDhESkl5RFg0TTU4NnBEZUs5Uit0K3ZW?=
 =?utf-8?B?UnYzMm5CbnRPakpMaVlVdUdFWi9iME9MUjROTXE4bkV2bE1aV1VPbXdXdWJs?=
 =?utf-8?B?dTEwZll4b0REL05STm5LYzZIUzRkbWJyeVIxTldEUjVqbklaOTJnVWZuMzNC?=
 =?utf-8?B?MEx2WGE1SnBLcVhIejlraG5EQUd6U2NibUVyRlhmL2dqMFB5RnV6VW5XM2hj?=
 =?utf-8?B?NUdkSVNicnBqMytHR1F1MzZGMmYvbHlaREZ5OWpBYzNaZWpLQlRHekFhaWRJ?=
 =?utf-8?B?bTE2THVUMERRWWl4OXpkZk1TdklONGFSZStZUTdFZ1ZtaFU3QWtXWlNuZ01O?=
 =?utf-8?B?MHNiVVNReTRTS1RXbEZibXBRazVERFUyMmdTdkxyZWRtai9UYXVTQ2dqSEt1?=
 =?utf-8?B?RGZxUWRtdW9jcGVCS0J3TkdBVUx4USthRVgraDFCVUpWb29VY3I4Qk94YVZV?=
 =?utf-8?B?WTF6a29JRmhoenFvellYWUpPRDBnbk9kZVZBRmduZjRJZitkZmNVa2dtb1o1?=
 =?utf-8?B?VG9EQ1diaU1OMitHaGFJN003dTMxR2lxbE1aOTFxVjlER0VXMXFFQk1QMUVQ?=
 =?utf-8?B?bnlsOCtrSGY1cHZ6RnpSd01OdG9jZ1JiTW9FRTFzRk1vY3VSbEY5VnBLaW5K?=
 =?utf-8?B?UUJodFRGdUR0TGJmL01QKzdvYUVtdU5pSE1QTnRrNTZWeEVVVDJJZTJmTUZ4?=
 =?utf-8?B?bDhpT2tvbmRsNmUxcjVZTmJicWx5Nm5vWVp5M3VyL2puaVh5dmNlenM1U3Ju?=
 =?utf-8?B?eUlYd2RObUtQRGUyNThCOUd5ckRSMWJVcGR4LzFVZmNHSkRHMG5uYXdzK1pr?=
 =?utf-8?Q?EWdcmySkHcAvlbUmzCh4UOlwc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45a0d59-e17e-43bf-e40a-08dddbdf7be6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7523.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 09:38:26.3199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Elfz1ZNH86jIGz67cSqMYsm+B4giRG2WnfrFd4kgExd2xk0XjmC+0d0MDbjMzLmjvyYiH0N6wW2enw+4e/MacA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9461



On 8/14/2025 5:30 AM, Jakub Kicinski wrote:
> On Tue, 12 Aug 2025 10:20:35 +0530 Vishal Badole wrote:
>> Ethtool has advanced with additional configurable options, but the
>> current driver does not support tx-usecs configuration.
> 
> Not sure what you mean by this, perhaps:
> 
>    current driver does not even support tx-usecs configuration.
> 
> ? tx-usecs is a very old tunable.
> 
>> Add support to configure and retrieve 'tx-usecs' using ethtool, which
>> specifies the wait time before servicing an interrupt for Tx coalescing.
>>
Thanks for pointing that out. My intent was to highlight that while 
ethtool has gained more advanced and configurable options over time, the 
driver in its current form does not have support for tx-usecs 
configuration using Ethool.
I’ll reword the sentence to make this clearer in next patch version.>
>> +	/* Check if both tx_usecs and tx_frames are set to 0 simultaneously */
>> +	if (!tx_usecs && !tx_frames) {
>> +		NL_SET_ERR_MSG_FMT_MOD(extack,
>> +				       "tx_usecs and tx_frames must not be 0 together");
>> +		return -EINVAL;
>> +	}
>> +
>>   	/* Check the bounds of values for Tx */
>> +	if (tx_usecs > XGMAC_MAX_COAL_TX_TICK) {
>> +		NL_SET_ERR_MSG_FMT_MOD(extack, "tx-usecs is limited to %d usec",
>> +				       XGMAC_MAX_COAL_TX_TICK);
>> +		return -EINVAL;
>> +	}
> 
> Normal configuration granularity for this parameter is in 10s of usecs.
> You seem to be using a timer, so I think you should either round the
> value up / down to what the jiffy resolution will give you or
> reject configuration that's not expressible in jiffies (not a multiple
> of jiffies_to_usecs(1)). Otherwise users may waste time turning this
> knob by 100usec which will have zero effect.

Good point — the hardware uses a timer, so sub-jiffy resolution won’t 
have any real effect. I’ll update the code in next patch version to 
round the tx-usecs value to the nearest multiple.

