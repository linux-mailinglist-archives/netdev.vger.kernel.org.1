Return-Path: <netdev+bounces-245272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F33BCCA1C4
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 03:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A70CD3016DD4
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 02:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0BE23D2B4;
	Thu, 18 Dec 2025 02:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RuI0qkfK"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B43C23D7FC
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 02:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766026387; cv=fail; b=kgPhnlrvCrPAEWSN6imavLYsblc3RNzZYxmj7qBkKEARKl1zjortjmlMgAW9qe98OhEe11F+BIm0NL9cndY9jNDkRWL8GhBRvyVX+//K/N+kvVg5gJYfewRi4I+Ec4NcrFk5dt9f5Q9DK2i9Crm4/QsJnAAmYh+KGckB4P1qC4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766026387; c=relaxed/simple;
	bh=fiIfwaJiRk18ahb14r6BbGgt+y+kKLBSFj7e8fTGh9k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gqqrBAZri1KmS+u4hEqQkRAU1+y8ae7+xb60LX7VU+tmzjJaAX12Qm+U0y13GQXbrxvXOZnERV+2NW5ocl/fDDtC9WQLrO4pUlycEP9Nh/OLCzJ9PWhR8GPBmFNoL6qnR5dRlB2q7kNrXUcTJRlnBVHvweneozFYCfcPBk9Vzps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RuI0qkfK; arc=fail smtp.client-ip=40.93.196.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSA0/BdwFE9Yz/tuytwekc4UZ0u67D4BjTpz/GJFDv4clX0ivZUsm7uX8UzRR8U0xK+i7SLJJrr7u+u9Qi3+UiSTTyvtlbvr4b7HoBWbf4EHjsvfK5EzlwiGP4xYsHOnf1guIJoZugEGVYL+d2Kvi7UVd3XIRNJACg+2lYZR6rEx8rZs/FlqJVpjzbO+Nkvcc8/JSI8m5IDeeXiUxvo2iHHw8nxLinhKeCg9FJHusm9LEDgtGxAQFMZc89AouDZMnPa+crdHaVSp46V5/73QkZUfUJoD3dpejfjcQmhq5DD/SGsrD1tL6tKi7L3hz77iV0cmK8HbhIueBTGU5Pkq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrNXaPQIrT/FkiyfnYwfdaNCnBCKYSKGUzDpp9Q6pk8=;
 b=chhqPjG5Wcdko3Ywc4+qWBSpyDaWm2Vb9ZlEymW52md0KPVM6XNGffqqB9pJ4Hoa+MNqRSPN4Y0KqVDkN6sOXgm0vBCspt0cX6ZbLl6Z8m9ja2twuAz4KbZtuZDZl1hoQBhM8n99me7t//tYFasReZTa3xnzIVMCcqJGio4aHafoZMwosaZSmuYW/L9rD3mPIRN6yiF2opn0AMXYsI0dUySfWKZIyjpBzXkRj2oeDq53s58eeVADnnkuIi/Whq6SLydjzR0crD8GA7aiktx4ZqaHXcNBNsOHfMhuP8FWQKhfXTLYzWR9/xZKup4RZESmwGqlQIdnKRXk8JvBEeSBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrNXaPQIrT/FkiyfnYwfdaNCnBCKYSKGUzDpp9Q6pk8=;
 b=RuI0qkfKjm5mkpJqQjMRx58Xsuz9SIkNlQSKBLgAifMzeI/vp80RZYdiX83EPk73SCOOZGxB+E6Ze6cwxEUMy2E9FkooQiG2j43ISERmLc5ULzBv7Jn18usZYl3AabWtGita5VG3iSBIvbV7brdS5a7E7K7JKZg3K/ENht5XPK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 21:16:03 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 21:16:03 +0000
Message-ID: <e39f4e4c-3b60-496f-9142-85b1570de3eb@amd.com>
Date: Wed, 17 Dec 2025 13:16:01 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/6] i40e: validate ring_len parameter against
 hardware-specific values
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org
Cc: Gregory Herrero <gregory.herrero@oracle.com>,
 Rafal Romanowski <rafal.romanowski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20251217194947.2992495-1-anthony.l.nguyen@intel.com>
 <20251217194947.2992495-3-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <20251217194947.2992495-3-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:74::29) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5442d6-1931-4e66-ff4a-08de3db17c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnlzQS9lOUMrRnlwQllzVEVNYktEUkZTUWxFczJlNzdIWFY2K0Q0Y0Q3cW9v?=
 =?utf-8?B?cnhKa3VBWFVkUUhCc1pqK0J4SG9aWFJYdk9ldjYwT1JJRTVFc0F3anFYQUsv?=
 =?utf-8?B?KzYxa3lkeUdFdGY0MWdzOUlKMlFWZHU2NGtiN0RsVzZIaDN1OVBEbTYySTJS?=
 =?utf-8?B?L0NlNStFQVk0U3Bsc1pnemdmUHkvSkFHMnpDL1o1b3dTTVMvRmdjcGpxTVNF?=
 =?utf-8?B?WFZ2OU5RRnVMRytwTS9LMmkrbVJFTG95RWVaaGJkL2YrNXppYW9rTkkzOGhk?=
 =?utf-8?B?UmZselZEMXl5RlZZWjZsY01zclVKMjl3S1J0ZzcxSGw5MTFPWDBOZVpkSW1M?=
 =?utf-8?B?Y0haaWpJZnBTUTByNjhQaHJzTzQrclo4eStDRlhJRVE1amIvZU9xOXJJdVUy?=
 =?utf-8?B?NVUrUlFQaEswWFMrZWNWTGlCT09WaEFCUWxyZG5HbVptL2UzMGNTUklYZlg5?=
 =?utf-8?B?clFiWGZrNStRUjczYmxVb2kvdWhsY1g1TmR4ZnZ0Zm5QeHU0REFGU0lLTlpG?=
 =?utf-8?B?c3NmZUY3WXJLT3drc2dZWGYvT05KWEhVd21CNVo0OFY4dWRUYk5WN2pDN3cv?=
 =?utf-8?B?bzlBend5M0tjTk1SK2lkSWE2b2dQT1NhRnpmRUl1MnF6UmFCRkRrRWlRSmZB?=
 =?utf-8?B?T2dESkF6a25Wam5ybzFJUGQ5Yk95OGRCR1RRb3BTeEZJbVZwc3pYdGhPVUZC?=
 =?utf-8?B?MnVzS1RBV0x4QllaSEg0aVN6dkdkUWl6R1U3eFM5K3E5QmpWRzFsSFhhS3Nj?=
 =?utf-8?B?RHdLdGxqbWtwcjBBbE91YlNHZnJVd21MZHhJVDRmeUxrZmIvRmU3L1JPTElY?=
 =?utf-8?B?ZlZZTEFaRUVjNnVtYVM0OG9IbVZaMmxzSmpEUlJteGxSUkNzcndSRThpeC9q?=
 =?utf-8?B?bE9KSmFRZDU3KzBOSlJUWjJLYUJmQ2F4OUZma3EremlnNHI4UElGdVdvaThy?=
 =?utf-8?B?bmY3NENtZ2EwSHJtUXJwNkRFcnpoRDdYZHN0VUM4cHluYnRWOXloMlllZXdw?=
 =?utf-8?B?bmdXbmRtb3BIRHJtT3VOZ1JYdzljdjJiNWt5Sk84cGIvN0hxY2IrMEU2TzFC?=
 =?utf-8?B?UTBmUHNQR3VlcHRBUXpKbGV4bUFPUTJsRXNrM2Y2ZHNPRmJNZytjdW9tTFU1?=
 =?utf-8?B?U04xZmVZZHpFdS9KWDFCS0JIMllKZ2FwYTVRbUlwV1VKakdiTEdjVHhCbEVH?=
 =?utf-8?B?MWJIRlpEcWRtM3BXYXRTT0tLc2lDMGlaN2ZEMFVqYkZYcHN0KzE4KytPYjJO?=
 =?utf-8?B?eTdJNm1MWUpGTjFQakwrZ3BOYmJ4WHI3SWtPaU56alZNYnFHY0lDbytHTkV1?=
 =?utf-8?B?QzBITGxBZGl3MjM2T2plckRObG9EcWRoLzdzOEFEa05lR2o2bmluOXZCcEdZ?=
 =?utf-8?B?S0trc25kMUpNbzdvdlloS05CbTZWaTJtV2FYV0o5U2JhajhOV0QzSXpEZllG?=
 =?utf-8?B?UE5HSklwYkZhUzZnc1ZFdFFtZVNRcHl0VGtrdVJGNkdObU1vcWJBTkEvSDVT?=
 =?utf-8?B?aEZpWUJhNkt0SSs0ZGF3NUxNbFh5dlVLTEJVK21kZUNrcGlxL0NMQ3QzWkNn?=
 =?utf-8?B?TEtWN1Bpbm5vdlZ2WmJjMGRYRGk2T29XdWlTeE4xdVU3cnUwK2lmV2E4MzZX?=
 =?utf-8?B?L0Ftd1RJaWpid25tOFo5M29LUTNjTEViV2dYMEhYM3FXQW9naW5BKzJpRmVy?=
 =?utf-8?B?REg3dW9JUFFqOGN1WTFWTnhHM0VteVB6dmJLTkp1UWlwU3NaTm82TEZRVVdn?=
 =?utf-8?B?cDBKSmh6MzFNVzN1aTBXdnN4elJta1RROFpoYkVQWmgxaEx0QzJmRWlYTEJu?=
 =?utf-8?B?dUxsckhTOVFsdTBpR3Fjd1ZTWE85d0haV3daZFNWWkFPNnJ0eHBNY3FFQ0NL?=
 =?utf-8?B?REQ4Zk1nZ2lybWpXQWxDL1ZCWFhVd3NOS3JENEV6M2tzNnJmSVh2OW5FclpG?=
 =?utf-8?Q?R2pWKFThHCM0XpyRRBDSoXtqpOAzI5Tj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVorSUEwQ3NnVmRZa0QxcDkycWhkMStoRnZ1T3NEN05jZlBvbjI5dXZiWVRi?=
 =?utf-8?B?UFNreC91QkZ1Z3N5bG1UN3g1RG9aV2g2WG5XTFZ6UVBxbFJUWU1tSGNsYkg0?=
 =?utf-8?B?WFVmVUQ3U1U3VTFxZzRhZUVaVng3N2xTSFBldXNWQUZGckc0VDc1Z0hiNXR3?=
 =?utf-8?B?UjhrWUFuUWlXak5PZDRwYjU5RjhaRlErOWk2Z2F1QlcrT0txS25jSVdQN3pw?=
 =?utf-8?B?R3poUlJGSytaQks2MjJKV2FjdzdoM2NVQzRlUDEvZ3VDUEZrb0F5OGtvQUQ0?=
 =?utf-8?B?clpyOCtsa3ZLeWpYZUxNeXpMalpYUFJlWFN3QVArZTlZS0dqczB3Y3N0T2JS?=
 =?utf-8?B?TW9vSzd4WmdwTDB6T2YxV21vZGlGQXdmSnNIRk1HVlVYZUkwMDRmdnNtalJX?=
 =?utf-8?B?ai9UOFc2N1huNC9TR29CUTJJOHJCWUNBSVRZZ2tOb0l4dEpxWGtNa1NjM3ZI?=
 =?utf-8?B?c01PMUg0bW5NN1hTSk9CZEgycVdHRG1mMVUrTGFjQUxPNTVnS0NCVC9heUEr?=
 =?utf-8?B?QytpTFNpTnoxV1Zod1VRdGtidnpBVmo4Z25NTmxzMUR6Rko1cmpZSVlEb1dD?=
 =?utf-8?B?QmNsODVreW1ZVHBOYnlDQTUwa0hkTWY0NG1QaVZOL3d3N2djM1JXQVcxYnQ2?=
 =?utf-8?B?NEIrUXlhOE14Z2twbS9OQlNOakk3WStwZU9TWC9PUFVTdTk5Q3FFbnEzRFlD?=
 =?utf-8?B?Y1NVa0UxS0l1Q1RrTnp4OFJoZlNqOVNJa2JxNnhzUTdJM0dVQzBTb3FSNWd1?=
 =?utf-8?B?V0pKRm00WTdhckFlb2hKZ0p4T0I3UVRJdURaWUxwbGZWSm1GRmxuZXE2L0Rt?=
 =?utf-8?B?M200TzNtNzVRdVRQQndUSzl6Y3hBUFNwMzZ1THdhQmNjRTd5V1hxblF4bDlZ?=
 =?utf-8?B?L3hpVUxZdE44NDZqV2pHSEZ0RmY5bUUrN1VIdU9qTGQrMEhzYXNCRUJsMS9Q?=
 =?utf-8?B?RzVQZGNrTGVIczVGQVhxRlNoNW1CTlNsa3NzSmNTWFRmeXJNdWhLWGxKUjJE?=
 =?utf-8?B?RlJFcURHQzAxZnBBSXZJMW1tMmVhY2tXNkRnMDlxTXJPSDhjaE0xMjdOUHpR?=
 =?utf-8?B?eUxYOXlqRGwrOW44SVNqbmtBblIwMnoxaEFGakY1K0c1MEVrbFVnR2QyZllG?=
 =?utf-8?B?Yjk5STM0dnYrc2RMWkoyVVgycGxleXh6aVhnLzJFYW1EUzgzdXNIdnRiZzIx?=
 =?utf-8?B?TVZNMjVINi9hSjFrRXlsMytKU1BxLzdDeTBIdzRoRkxsL0FNWGZNZDlJNVV0?=
 =?utf-8?B?Z2JuaVNjeVVJWVJpQlBOMkpFRDhjMm1NWndjUWRyQ3Joc2JZSkpCNDl2NnI4?=
 =?utf-8?B?bDFLd1E0YzFYYk5GSFVWV3ZLRGdMeDBLbzRKZThwSXM4RFlIc0xwSVFvWlR6?=
 =?utf-8?B?d1ppKy9nS1B3SUlNMU96MVprbEVhVjBPUkk0YkkweW5qTGJOaDB5cFVMU3dX?=
 =?utf-8?B?Nmw4cWY4N003WThuN2c3dHRqQWVZZWhyK2dORnBJZzVXWXlqczJUSU9IS3Ft?=
 =?utf-8?B?WXloR3Q2UE5uT2M3a1Q3Ymc5UnBKYnVwN3BoRzJBaDFQV255ekcrWkxkSmdz?=
 =?utf-8?B?NGlkcjV0Z20wRUtHRUJEK2tHNkx6YXdxVVIrRjNRSkZkUUpnWUIyeVZjUzRv?=
 =?utf-8?B?L01YMGFya0k5eHhZTFJGVUMvdk9VMVV3MjBRRnpVTFdkZDQrMzEyZVJ6ZWE3?=
 =?utf-8?B?aExEd3VEMERTWVpJYzBxcllQWjBUUnQ2aGR1NllaZC9uM2tMczdJRm1PQ3dH?=
 =?utf-8?B?aE1oUkp5a1JUU2tNTHNPeUd5dEczKzlIdjVpaHcwc213RytoK09WV2VHTHBG?=
 =?utf-8?B?MVN1TlM2dUVDZlFsZXJGcm55VVVLaFRjbnBhRTBTSlJLOXUwVUtyaGFvK01G?=
 =?utf-8?B?em9GTFVoQ0x0ZTdrVmE3dXB1RkRxaXd2VUZQejNYWGY1d0JaMDdFNmV0ZDZ2?=
 =?utf-8?B?NmlONEFQRnV2M0poUHNzZVU2bHZML2diR3R5TjBaN3hzYUZRMEZ4QlZLZVV2?=
 =?utf-8?B?ZHkrUERlTmxNQU9jSXRXa2tGdS85TGw1NUJIa2V3RkpCTHFlWWxNemZkbXRN?=
 =?utf-8?B?OVM5M0pNY0xiMTdEcTVITFE5VlJXMnNNUzJlTjhVR2pGcHZBTDh6VTFvb1ZC?=
 =?utf-8?Q?XwshZ9t4AVQfZV0Ac4/wIQjtG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5442d6-1931-4e66-ff4a-08de3db17c0d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 21:16:03.4267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsUXcaMr6SQtmK4hodKL/OaltS4kLYF0jltp9Q9/FiTrG2LPav9qzjSqVIy+tkKilq3C8TgXvk/A/NVtCtl8Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683



On 12/17/2025 11:49 AM, Tony Nguyen wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> From: Gregory Herrero <gregory.herrero@oracle.com>
>
> The maximum number of descriptors supported by the hardware is
> hardware-dependent and can be retrieved using
> i40e_get_max_num_descriptors(). Move this function to a shared header
> and use it when checking for valid ring_len parameter rather than using
> hardcoded value.
>
> By fixing an over-acceptance issue, behavior change could be seen where
> ring_len could now be rejected while configuring rx and tx queues if its
> size is larger than the hardware-dependent maximum number of
> descriptors.
>
> Fixes: 55d225670def ("i40e: add validation for ring_len param")
> Signed-off-by: Gregory Herrero <gregory.herrero@oracle.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e.h             | 11 +++++++++++
>   drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 12 ------------
>   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  4 ++--
>   3 files changed, 13 insertions(+), 14 deletions(-)

LGTM.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
<snip>

