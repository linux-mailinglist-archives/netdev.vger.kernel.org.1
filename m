Return-Path: <netdev+bounces-67659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C2384476D
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 19:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92DC1C20840
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 18:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4D120DE9;
	Wed, 31 Jan 2024 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D5r8oUo1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC3F210E2
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706726854; cv=fail; b=gEAKH6SgYjcCAcEDF9w68ALaewVkpv+XYrf+6yowJu3+ZsvtLUZeQkVf1EZE5Y9dZ4w5p/eS458gZhNrAlVC6CIXJOjKWViuHaJk+ZwTt3wZZcy+nmf/7MaIj08gXMRSZi66TEN4Jh5OwQAaR9wqU0hWlg97pSdA66Pqkkw8Fyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706726854; c=relaxed/simple;
	bh=lScwX35VI9ip9tOT1EoiBXVOxuXcziTQEum6kU4eejo=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DCXQdVVJ6zvHFycff9mf/rbgMKfDMhClrFKQ+Bl7BQRH7P9OctF+0la0VK/8wsEH0pRttNiwRdv5bSs9Jz6z8TCzi2r8I+OOU2kbjfRRnfBXPIb068GBLNWPE09Jz+NzguMb7HC+04dzHic8WpvMPir3NGS0zJUy6iEo+6r2B5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D5r8oUo1; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F29gylx24kf8v55Y/GqVX9VWVqyUE1rUnxrY3FrwnlE3g9ZAe0/meNI4t631cp4ZixoIWk34wVo64M6Dz+JR5aox2hBZkVYj9OTtscfmqfMR5Cy94r79q0pT6Qhu+BPBRitadg8p9H3Tag+7UrB5tnREKu9WGhRojnOAqp4RrILC6wM9zHl5OnHzJeHlZP7A8A85SKoLGCcH4XRpese4XMM25FbTFk9Xhnwo81Ci9YnoXsE8ZPk2xVhHT1zGOn5QU7RZpB6+koqLcAG1YFHNy5JT2fWPuV0F81LXF7JNmF8KTuBfFZEpAkpZsNa00W5GoIRhwcHLkx5V4h358tl4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=il0OcOLzqOQSUOr17f06XGMyGS3Y2R76gDdbC+dwB4Q=;
 b=klWgEmRVkirgKv/UFo34LAMM6mFkGoBn3pwerNU+d7/azVaoI40IByhVw0P4zSl2Gw/HYiNuOrM8zazo69nhP68UMc5sjtofVaBToUxW/sUcgzfY65mn8aJtxNv9yJcutZmVQChfh2NitF6zu6HAZjYQH3wz1sgSaKvj2I3OHGD9h8bIX2LbazEVBvYbbaQ2PtuBH6/tGR9fP9J4UUgiVhDLYbVwfnFCQh712nkaXuaefByi1MK4jWhLMl3mvK15PLGNc3hr9f6Nf9kHLabLa8vypzCOF7ADEnEf67MNF5y9HLRdwq7HFZnq4zzhWjs8IjIdkE6I9YRTB9zNEifkYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=il0OcOLzqOQSUOr17f06XGMyGS3Y2R76gDdbC+dwB4Q=;
 b=D5r8oUo1cfb6BfoVcAm7WjIlzciJSBG2yI8nY+97pRtWhX2TYMFmlyg7opFOe4bGwAyuWmhEqYeqx7JaZyN17hlnLgAcGfSlDvIRep5eXZk/iqv+rbuCCT5dU/O1jxV59Vw3RZQ9Gjj0kObaWV4mWRLrMesZqlTheUCReXFi8zuTNgVTD0WptZ01OvjophcJ+5QM0913X+nX8mB14hXAd7sVPtRq+fcs5Fl7SG9Uq1rBCJLzqfH+lI+S09X6uvY67mOvWbeqXi5hoEeaGKXPkyfOjPQz+WoW2VWzgioEUDOi/APRRtHJyeiTX7YNl2tOZl/rJ5WCi8Ush/0q45egoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by MW4PR12MB6876.namprd12.prod.outlook.com (2603:10b6:303:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 18:47:30 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::c4cb:7b15:ece2:2a3b]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::c4cb:7b15:ece2:2a3b%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 18:47:30 +0000
Message-ID: <748d403f-f7ca-4477-82fa-3d0addabab7d@nvidia.com>
Date: Wed, 31 Jan 2024 10:47:29 -0800
User-Agent: Mozilla Thunderbird
From: William Tu <witu@nvidia.com>
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
To: Jakub Kicinski <kuba@kernel.org>
Cc: bodong@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org,
 saeedm@nvidia.com
References: <20240125045624.68689-1-witu@nvidia.com>
 <20240125223617.7298-1-witu@nvidia.com> <20240130170702.0d80e432@kernel.org>
Content-Language: en-US
In-Reply-To: <20240130170702.0d80e432@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0150.namprd04.prod.outlook.com
 (2603:10b6:303:84::35) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|MW4PR12MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: dbfa53f4-f82f-4c18-cf5a-08dc228d13dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ED6DL8NM3GcHKT0c4aoZ2uGsprEnvUr3IkBpJJJR41FpE+FNFzBfNvfgRwDer3Boxaz4Dnl2QvWwBxTuVI7atNkus/uFecj1+FsGxnftVngWUjeGOMigjoCqF+SL1rWKX54es7Q3siNmHH6ZZWsvgQBFSYlUp4Aral+WoBM3aEKGIQufgxVbQ66uKG5sBP1voOG0dnQ1L9mmECz8QuU4cLtJeI+uqpb1rIteRbnaxfaYVr0xW9l02FlqMnC6ZPLtcg7uI0Fz4yQFOnfPa/T/gaap/PO9moKKlQRoUvDVG9jSli8K4RBY41fDP4orqTx1F3+hbxTap2EYHWXLnIShw22qI3p0kZYrNH4e6y3SsR30kRHiRjod7OZbS37JLwJ5dUyTnYGBlqV1DD/R1u/aEUIIbRU/j48K/AMuxh81HdpjNVwjTWMdCmRnkZWDfyYHHVZ7auKre/Jl4+v6l3E/y8KFuo6Ifb8k0YHG+ZBG5UM0BM9PAEe1vKH2MS2ZqCkHPGA16yHvxutCWKLhTmxTry2vuCgl5QlAi/9FemuDwcK0WVjWqXyDW5sQo7dgf+VlFTvjN+gccJh011lFgH3URcqF2vM8E8VM3eEvJTREBUtF36yYBz91DccKvdOTlGqBGHZTOrpoMx3uDGuUgAikDmlFusPwMvRNSM3TmlvA1qb6CfAnM6a2JaewYKt0cnph
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(230173577357003)(230273577357003)(1800799012)(64100799003)(186009)(451199024)(26005)(53546011)(6512007)(6506007)(31686004)(2616005)(38100700002)(107886003)(31696002)(478600001)(6916009)(66476007)(316002)(8676002)(4326008)(8936002)(66556008)(66946007)(2906002)(5660300002)(6486002)(36756003)(41300700001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkpUa0h4TmJnSllLNEV4aGYvbG8zMUNiQVRFV3U4M1g2MU80dkVQY0YrUVc1?=
 =?utf-8?B?dStwdE12dU51ZDliY2RnVXVscEFZV0owU0ZxdzVidGhpeXlCSGt3aDBWSE5w?=
 =?utf-8?B?Y0N2cHhOK3lCc1dtYW1OV0VHaVhSVXJoRks3ZXM1QklEM3kzN2RGakZOSFBv?=
 =?utf-8?B?QjA5Z0tjcVZnWEpxNUxwb1dNdXdCaCt5ZWJoWExlZWUyazkyWWY1bXgwU0JP?=
 =?utf-8?B?cjhMUXNkWVl0MmEvTGVvVEdjWXVBd1ZLdmliVEJJampYd3pNd04zcEh2cDN1?=
 =?utf-8?B?Y0Jmb2kweTdqSkhkNlU4azdaZVRKRVdMOGxFQWlieGJwaHJaVFM5dzVFR3Bw?=
 =?utf-8?B?MDgrc1BQYWl2Q09nZHVrVTBnT0t2RFpIM0VmdXV3SjJMZWtZVlM3TVhjSzdq?=
 =?utf-8?B?NGpReUFhSW5XZHJERDlQek9QblVKRHYyMTlYWVplTGZodHQ1TTNnOEQrYmhx?=
 =?utf-8?B?b2llTnN0dHE2K0ErZUs1YjlGN3RyRE5aeEQ3VWZzVXpUdmN3Q080SGNwNGNo?=
 =?utf-8?B?VFFvMUdkTVladGRUSzhwb3V1Z2w4b2ovVGxyN2dvRkppSlBwOTN2WFpoaHRq?=
 =?utf-8?B?WndSYlNYTUxTRTAxd2lOdEl3Z1ZTOGQrblBIL2lhS1VDbE01WVo1L1dSVGhZ?=
 =?utf-8?B?ejFCbXR0b291UHRnYzF2RW1lL0gvdFVBQnhKUFRkbUNCakw0Zm84Y04xaGRN?=
 =?utf-8?B?VHJ5cXpBTWQyMnFOVVlRaTZUNXN6R0lnby8ydEdpQWtDWXk0aVFZRU9LQzNu?=
 =?utf-8?B?eXFGMG5FQ2dIK2Fydkl6OVV6S2M1SVd4NEdYbTJldzc4dVVibzRqSmc0RVlm?=
 =?utf-8?B?bUQvYXpaWHlVNUxXWmVGcmtRaGUyMG1Wa0VJdjF1YWxGUEFEeThmK05hVk5u?=
 =?utf-8?B?SDFCWkhxRmVjWHdrNGIyY3BiZ2ZwNHFtaEhoN0NWQlI5WDNNM200aEg5Wkcv?=
 =?utf-8?B?R2RVQzhuNnUyK2xtRWtER2RqK08xR2lMaGVEQzJpdHpST09zdTFTeGhQSktj?=
 =?utf-8?B?ZWJRMk9IdWFmWVdUeldOdGpxM2dEVXRPZ3N3Z1c0R1Z6ZmwrZGx4bXl0QmtH?=
 =?utf-8?B?SlU0SHFPRFE1WlhuQzZMeGx3NWJad2Y1aitZUzZSSXlWaTZvbEJNcmsxRHJT?=
 =?utf-8?B?WGFuTFl6UmdHWHRwZTdiRVMrV3FMNGViZUliRVhRODRmMnI4blp3ZmFYSWZ4?=
 =?utf-8?B?OUl6c0hUNDBXaGExanFiY1hranNKZ2hJWFlVRDJEYm55VzRoV0VFdUFhcEYz?=
 =?utf-8?B?MkxId3EzM3ZVdURremxKTElNNzB2S3lQdHRuTmEyVWY5SnZwWGpLcDBaNldQ?=
 =?utf-8?B?cDRNZThVaTBkNDZZNTlQNHE0NCswcm4vTG52T2FkeU9NUExtU2hIV2hnclMx?=
 =?utf-8?B?cC9wL2kxQXIvQWlURWZJUU1ybGpjRy9aYW5jeVNsREpDSDAva3ZuVWYvT1ZR?=
 =?utf-8?B?ZWxWVVBPOCt2L204V1ptZStuUnlLUnI5TTBSV0tzcGc5blpvL05hYjBYb2hk?=
 =?utf-8?B?TzRVRUFmS2twRjhtNXYvOWVhRjFZYmZOOVFoMDhjTGxIeUFIV3pZL29mNnc0?=
 =?utf-8?B?Rzk0Q2JZSkgvTGpWMVIrTENpWGxaUkNaMzBZbENHVEVKU1VqbFUxYkxxSDl5?=
 =?utf-8?B?cWFDQnhrd2ZWMHJ5d09KWlgxeTRxUDB3NHJvam4yamlGZDREZitEdUJHL0pY?=
 =?utf-8?B?Q3Jhb3hQMG15NEo3S2FsRWJMQjh4ZWJmSWVlM2cxVW9NM2ttcFYyRDAxWnZT?=
 =?utf-8?B?ZkZNd3loM1RwQlhmazlDYktVaFdWZ2RMUWgwVTArR2xhR3drYnZob1I4a29t?=
 =?utf-8?B?d1IvRjdGRjR0MUR4STFiNHkzc0dDcCs4ZW9wS013SThjbG1JUUdZVDhzaXpJ?=
 =?utf-8?B?UStWVlFmU3VzbVBrRTB6b3pTMytNbWplS0lJZTJZUTNGV0dBdnVxQnhVK01C?=
 =?utf-8?B?Qkw4bTZqRWo2RW5PUW1FMDI0eHVXeUQwdE9RZWZqamFPNkFkVHFGSndKcU03?=
 =?utf-8?B?SWhBc3I2cXJLRTZjYyswclJmcFZFVlY0QVBsYWZOWEwybEZ3U0lVMHIyMkYv?=
 =?utf-8?B?aHZyMlZFTDl2SzNUWUdsQzYrZEVtL09aMnZ1RjIwdHcxOHd1eFJ2VWRneUhQ?=
 =?utf-8?Q?495XUUWY7Qyf9NAuSH9cNq7eR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfa53f4-f82f-4c18-cf5a-08dc228d13dc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 18:47:30.0102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axnszwgkC9hhqo2O+9dnU4ORS5pfd4nV9jkpdpPw1lBeM4ApzclJaKV6JYk8yV7E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6876


On 1/30/24 5:07 PM, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, 25 Jan 2024 14:36:17 -0800 William Tu wrote:
>> Add devlink-sd, shared descriptor, documentation. The devlink-sd
>> mechanism is targeted for configuration of the shared rx descriptors
>> that server as a descriptor pool for ethernet reprsentors (reps)
>> to better utilize memory.
> Do you only need this API to configure representors?
Hi Jakub,

Thanks for taking a look. Yes, for our use case we only need this API.

And there is one additional add to devlink eswitch, mentioned in the RFC

+ * devlink dev eswitch set DEV mode switchdev - enable or disable default
+   port-pool mapping scheme
+
+    - DEV: the devlink device that supports shared descriptor pool.
+    - shared-descs { enable | disable }: enable/disable default port-pool
+      mapping scheme. See details below.

use case

+    # Enable switchdev mode with additional*shared-descs*  option
+    * devlink dev eswitch set pci/0000:08:00.0 mode switchdev \
+      shared-descs enable

William


