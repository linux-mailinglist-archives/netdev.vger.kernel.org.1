Return-Path: <netdev+bounces-205060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 277F6AFD004
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4409A3BFCB6
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA24F2E0B58;
	Tue,  8 Jul 2025 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hOan1Fw+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D4E1E412A
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990617; cv=fail; b=JSXqnnoKYq9Yn8K8XOB6omh8liZ0XpkHNCJzrVyI3EluqnzIKw9WjaA3RVJ/HWNkawuaxjC9iS6EBbuFiyDyafxYs+Yfr3r2TPal7dKY88dE6PRJTyI1tWUiXmhJEJln9gKIIO7HOnvgWjvlwBApGWQs29A1+ov3IdG9gG02vXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990617; c=relaxed/simple;
	bh=NU00GgL3p9QNHrC+32anEP5NC1HR54JbwiBLyiRPt/Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qamxLbDRr5Qh1A3Bw4/jQbuR4Cr2RxClNaFwG78IJwjNY+9q5gpSE9oFXiX/dy8m1eylDzU1l8hpeRN6jTkUsFX7v7zG/AT7w4URaP+VP7RO2zS19i3LtpHEPlySqylykQs+UuF6mDSwlzO0kS0W/P79rIWT/kjiw3O+dQtQe4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hOan1Fw+; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XezRzGlJnrVZO9P0KTxWTeFsEIxK94i9HBALRMlJyXCMiivOG/iS0UVpklDe8gjkMNf5EGyRZZ8ESOch5mCOrtBQ+TIGE74RrJQmAycYspaPmPiNddImxKxCl2v4HkIPFnhJzEwTJKVtxXkggQ7Yo/YVvp77Qkv7FXCXq7c0Dn+HTf6qYOo/Oc/754W3YuUhgbEcLVn3/qnJY46z4y7lQxRsiTgURMINka+PISQI+q5hD49rg932qkfmqD7ZdKr1rHCQFsvLNJ/Nvb4tucKcPm13FTspFOvpvhRHBdwdKieNI7HTn+giHBCTZYhKMC/igADUh48kX3plfZb1eziRCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2z/mHhKGmS4HL3XgMVMluHCXzUSdngmqlIW28TOl+z4=;
 b=Y4BBWvhvuC3eOPeD+3ibWMzoxkxjH4ukbnJ9d+rcB/HTeJOuFK5VtExdbO6sjRUfzKoftRIQBMpBZ4cB9BP9qZ4IQO/F6Z2ZYGuyFgva/+EoCt6evw6AcJSTM9yW1kwguwH6ckyAT2fbK6dqDHr1V4YlnhJzdNC2sbHT6TYGMxK++NcLno13DHN7xYQh0eW4AnOhR+9sbeFlvW/5mzejbiqWUKMfVEmuEMslrXcalHbpYlsD7sma9uO5Py1NtDnzis1cjMN65o9gZpdAOIUMqNgGd0Pu74SWUls49Oy4CyobFEaWriyrkb/sju9O6ox1lMoAX+RmyfKdEc8B3FnRGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2z/mHhKGmS4HL3XgMVMluHCXzUSdngmqlIW28TOl+z4=;
 b=hOan1Fw+J5QCAqTCIMcyyBu25tV3uNZieIJUXixL/AKJTRie7bpSbbpKZzYYRlnj7TGlI5IqPxu4MiHr1nhrfjcbfw6/QQPVZWSvKsV+wKHXeuGazMCD732Mhqf6axAUx8SyLu454xtnxvOYASdKnH/gD1H0EzmYqCt1TkOnw9Uw6aofFH94J7GkpH9h+EfDAw0u/2h7Jc073NZZNSyJS2gV3E4InEcGFb9r5BG7u/yuJtPRIPcWRVnkEsmmOLNdg0zKW8cdFQWk3Pu//Iw41UxFBjPMeKp32FXVU+Z/jnArjGYkAdxXRg2O/uXMB6lpee5Zq7HVcaV+Zf3rUG8Tzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DS0PR12MB8504.namprd12.prod.outlook.com (2603:10b6:8:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Tue, 8 Jul
 2025 16:03:33 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 16:03:32 +0000
Message-ID: <d3029215-1ab9-4503-bddd-6dfce10e8e5d@nvidia.com>
Date: Tue, 8 Jul 2025 19:03:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/5] eth: mlx5: migrate to the *_rxfh_context
 ops
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, tariqt@nvidia.com, mbloch@nvidia.com,
 leon@kernel.org, ecree.xilinx@gmail.com
References: <20250707184115.2285277-1-kuba@kernel.org>
 <20250707184115.2285277-4-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250707184115.2285277-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0020.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::9)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DS0PR12MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5e4261-950e-40be-07da-08ddbe38fcae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGZmdDNRQUlFcDF3eWZmSzlDV3hoRytVNHJBajQ1bGNoN2FTaFRld01jNWhX?=
 =?utf-8?B?TTZ2Sys1QzMxUEgxQWhoQ0FscGw4K28yVGMvVnBaV2xBdHcwN0JGRWNSUnVE?=
 =?utf-8?B?S2RXU2EwQkRWdWZwK0l6MWtZOFRVQmxxRTd4b0JHRHZQeFFnZ1Y4SSt6RE9Z?=
 =?utf-8?B?ZXV4TEtCQ1BYbzRJUlZDczBwQW45S2tHb3drdyswU0NEK1lWcE85Uzg5cGI1?=
 =?utf-8?B?Vmw0UlQ3K3lNU0M0NWFIRER2MWtCMjBGM0hqTWthZ0NvS3RJVEhPZmJKakFO?=
 =?utf-8?B?K1FjanN5dldvUVNHNytHWmtiY0dYWG5HNkE0NzZTb3FpNWF2dVZFTW1MTTkw?=
 =?utf-8?B?T1h5ZlJzZzRxVWZzQXBiU3Y5WjU3OG5aTUhjcHZPcHNtRk9YblZVbE14NVZF?=
 =?utf-8?B?UEU2aUJLK2c1MnlJcmZ0d0J0cFBJK3kzaXJtQ3NlcTR6U0RkZWZrR3NLNGdi?=
 =?utf-8?B?TCtxOXV5WGY1OFNiaWFaZHRHNkNURkxvOE5IbUJQN21xL3NzaGg5NGMrczdU?=
 =?utf-8?B?TXFLUVhER1ArSmE1TGdkeXN3NTNucDVUUEhpbXc4QkYrc2F2OEdvbGdTUjh2?=
 =?utf-8?B?SkNhTi9mMXlMUnJqY3RtK1JxcGdYRjRDejFYTU0reENjV3JDdElMSi9xOStV?=
 =?utf-8?B?ekFmQjltY2I1ejZCbkdIeWh4dkp0OG5wMlZvNGNBalZHT2EyVzhETjBua2Vt?=
 =?utf-8?B?WkQrYlUzVkw1aGV2YlJKajhoK25hMWZRVnlxU3hxamV5UjRUVkFYSGZ2bzdw?=
 =?utf-8?B?VVU5RzI2WTMxeHhpWUZub2FXR1NoOG1vZ2dtUUN1VTJ2OFN6aHdQblhoUjAz?=
 =?utf-8?B?MzRMdjZtejM0Z2IxT1lqbGhsdDlIOENOeUpaTlBTWlZ2enJvNUt1amkxNzFV?=
 =?utf-8?B?OStlZENRb1BsUlhncEZPdlFsWDlUYVVpR0ZYVWNJLy9oU2RrdDFuZmZISVJI?=
 =?utf-8?B?eGhldDZadTNYL1g1cXhPR2FOOWI2cCtrY1VlMjUwNGJvWHFUMWREUGZwbnBY?=
 =?utf-8?B?eHhOc1VKdTVBMjhyckJ6MHlCcVBCci9VQytORXdlMXZOdU5zZ3JBZzhjQWdV?=
 =?utf-8?B?a0V4WGhLYjFSK2NaVXNEOHdWNHBrR0YraSs3NTJHUWtYdGtMc01BeE8vakhI?=
 =?utf-8?B?R1FOVWZ2VzNJczk4RDRvTk1zSEtINnZITXJsaWthOHhwRHkwSWxYU0Nvdk93?=
 =?utf-8?B?UGZYdXhyeEovKzhodHFpQlAzVFJpWVJCSit4OFZBY212TXBYNEEyYnJmSk1E?=
 =?utf-8?B?Tjc1OEFodE56Q2Vobnd5Zkp1RnB5bHhPNkZTQUgyOUpTay92ZTN1TW5wYjBD?=
 =?utf-8?B?Mktyem9rSU0vWHpBUk50dWk1K3FMcEh3WVgyM3dmNDBPTnNONzhneFZNRWcr?=
 =?utf-8?B?SkE1czJrWG9wL3cvNThDTUoxRUlORUx3QVN2ZE9XZXFCQnh4clVBdUJPQkRX?=
 =?utf-8?B?VU5aSkNDcFZqT0lBYkoxQnNlakc2c0gvU3VlNGE3WW8zVlVOandMRnJwcjBt?=
 =?utf-8?B?cXpPdit0eXgxNTVaeERpaEhTMEtwQ3hQMUt1a3d4SHdEVkE5bUVCRmJvNEZI?=
 =?utf-8?B?eWpBcW4rU0l5Q1hJSEU4OG1lQmt1RmFSNHNOQ3lPQ3MxRFpmeUNSWFUyTFpq?=
 =?utf-8?B?YnNiYjRLOWV5cnBRUWFWVnNnTFkwcEZOS1VseEkvNVpLV3ZIcDBrTVZjTldS?=
 =?utf-8?B?MTVDL3BQNVBnVXdIajBpU1lLUTRnUkdVQ2FSWWFPRWxXTlhma1I1Zzloa0JW?=
 =?utf-8?B?UVU4UExDNUJucDV5bEw4VUIyNlFHbXdzSG5Ycnc2Yyt6NnhNTStvSWtha1U4?=
 =?utf-8?B?SjNmQngvYkk5T3lXVDIwd1pCMHViOEFSM3FORlNoL0c5a09KVjdOeWJXQjZ1?=
 =?utf-8?B?T1V2MUJVWTN3bmRkMzB2UTJhRHhIaGE5ZU1ReHVmaEVISnlZWXptS2tOYVE5?=
 =?utf-8?Q?azeduF4d7DI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTE5UXNpdk9kTkZha1RoOEFhVVVBcmZrTkRVRC9pUG9DdUFnZDQ1L0REblkx?=
 =?utf-8?B?QWhnV1FJbGhUTUhxTy9Ra3FLOWVVNTRXZHRaWHJyUGJ5ZWlCa3FjOHhOUjQ1?=
 =?utf-8?B?RWhYRkVxMHI2Vkh4aWpXM0Q2NDIwNU1YaUgwZkUwNWJiNXJZZytyc1Fjbm1o?=
 =?utf-8?B?eXFlVXJ0cllObWZCeFBSQXlKU2pkdHJNeWFkaERTVCt2MS9xdXQ2bEpaRzlO?=
 =?utf-8?B?UjJYN21LZDlaRkNUb1gzZmwxSVNFVFJ0WVpCZWt3R1UzNC8vc2RMSHBzUGRP?=
 =?utf-8?B?cjlxZjRFdzc1N2hxU0VkVzFRc01Kd3RUVXZVY2xyVC9aWHo0WEtFOUVidEFZ?=
 =?utf-8?B?M24rbGt3b24xU2NSTzFoMkhYblNVY3B6dDJUTzNDVngvazBSeWozaHp0bTcv?=
 =?utf-8?B?dFZROGs2N21DMTU3bmtydmlzK1lkamU0QThGYXZMRHJSMjlmV29CMlI2bTht?=
 =?utf-8?B?OXR2RXFacjVycUFkOGMxaGR3Z254MDhuZDJ1YUJiUFNuS2xWby9kUm5CYysw?=
 =?utf-8?B?UU1OTElDMnFZYmk0NUc4bFFHcXB4TWkyZGZERS9tSFZXSGRINkZIMkNkYnNF?=
 =?utf-8?B?dFNOTXd1S2dkWE9VTjR2YTF5d0dEVFFpS0VNWTNreE4vZ1VDNThMbmRDcGxF?=
 =?utf-8?B?d0tRVFk4VmVTWjluQ0JZVEZUeU1jN2RJcHN4eE1Ib2ZQVTVUdS9rZVMxenJZ?=
 =?utf-8?B?VTYrMnVTZFhsbnBtZW5zS1RMbmJ1ajc0NzR3aVd5T1I3cnR0Q2lBc0VYRFR4?=
 =?utf-8?B?TDV1a1dEcGdVTDlJQzFuRm94dGl5Vjc0a2g3aklNcU9HOU5lNk4vdnVlQldI?=
 =?utf-8?B?SnRITmFTRlczWUg0UXRjREFEWkxwOVVlK1RzdkRlTW56emNURlA4TzZNeHI2?=
 =?utf-8?B?YTZWSnFxQ3RMWVJkbktVbUprKzdlamZUUHBuaFRNYUZSNm0zMGFUMW1Vb243?=
 =?utf-8?B?NkJEdm1SUWpRNU5VaWZQOHdYeHlVdEpsdDZ0dWt2amgybWhRMFl3WEtaTHFQ?=
 =?utf-8?B?TU10N3Z2TWZrZytrV3FNVldmUGxMYitGTndGYlBrcG5CUlZ1Q1R4MEZRdmQr?=
 =?utf-8?B?SFFFMnV5ZlZybnpMTi9kMFB2a2wzOFdsMngxcXJudmZNeXJmcHJUZDdnSFNj?=
 =?utf-8?B?QXVkS3lDdGp3ajJ0YlJ4aFR1ekk4RmVORkk4bGQ0UHVMRVNTNXZXS0gzK1ly?=
 =?utf-8?B?a2J3TGl6TGFYd3VSL3haWXhqNHVxVjNISnZtQkMwcEdGMHpyVXZTTDRodUZD?=
 =?utf-8?B?MmNvUFpMazZDKzJOKy9oSXpDVlZVYUdVQ1REUHAzUmRxbXZpeGRUc3NqbHdM?=
 =?utf-8?B?QTIzSDVvSFh0cklLeG1NRE1oRjVBRHAyT1dkaUhDeUFNYTY3Y2hRbWdLRUFK?=
 =?utf-8?B?RGZPaWlSQzlQaGVPTTFMalJWaG9EZitjenVjbzlVT1FwWDRMVnZUMzRwMmdm?=
 =?utf-8?B?akJqbGJjSEJRd0thN0tDa1dHVkRRMWJCRmlzQmhjNmg5bVBYT3RxMmErMDdr?=
 =?utf-8?B?K01oY3JrckFOOEZINldleDlXZWlyR25hbnozRG00c0NxK0kxMFdRQmwwZmVy?=
 =?utf-8?B?N24zYU5UUzJJZ25pY1A2ZThGY21hNkl6azFUeGhaWXYreTYvSkp4ODA3QTU1?=
 =?utf-8?B?U2JObldoYk91L0JtNUg4T1cvZHJWWXJ6OUZ2eWQ2T2hKRGlPeGc1M3VVK0RX?=
 =?utf-8?B?Y1hLM3dTWEFPN1JXcW5qYmE3YUZaZGNubk4wRHowYi8rRjBZZGJpZERBZS84?=
 =?utf-8?B?WUVUTy91dEJsSHVKeEpJK1N3bm5JQnRnQzY4cG8vY0Q5aWJ5MGJJRUhwVnln?=
 =?utf-8?B?RWp0MHRCM1B3QW1rV0YxZmkzWFRrMEdPN3MrVnFQa0h5d1FNNkVHMyt0djJD?=
 =?utf-8?B?Z2x0aW51eVBPVi9IUkZiKzZndTRQbFpCY0xyWUtQd0g3R3MyTHNuQXlyQytu?=
 =?utf-8?B?MENhbEd1UDFvelQ3eUczeTJTNmNNR3dFN1BjL3dIcVNacW5wajcwSE5IcW93?=
 =?utf-8?B?OTk2dGlJZTRSYjdYQkhPalFPNDcyanVoNDRVNUJkeUNITktDUktVV29DR3ZM?=
 =?utf-8?B?dUd5ZVp4OHEzUFVvak9UTzE4SmxSaXlhUkw3MDA4RTJLL0xPaE9NRmdZYnBY?=
 =?utf-8?Q?raiA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5e4261-950e-40be-07da-08ddbe38fcae
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 16:03:32.7817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CC5W9gvvnDXPOYfIAufW1FJ8sbjuBE7hdUkPU1fsHM0tYcwd4v9JYcz1Sds9gQI1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8504

On 07/07/2025 21:41, Jakub Kicinski wrote:
> Convert mlx5 to dedicated RXFH ops. This is a fairly shallow
> conversion, TBH, most of the driver code stays as is, but we
> let the core allocate the context ID for the driver.
> 
> mlx5e_rx_res_rss_get_rxfh() and friends are made void, since
> core only calls the driver for context 0. The second call
> is right after context creation so it must exist (tm).
> 
> Tested with drivers/net/hw/rss_ctx.py on MCX6.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Thanks!

Reviewed-by: Gal Pressman <gal@nvidia.com>

