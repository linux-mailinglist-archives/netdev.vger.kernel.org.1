Return-Path: <netdev+bounces-235537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1931C323AE
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DAD18C51B3
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3903F33B97C;
	Tue,  4 Nov 2025 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WZwB7Le6"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011005.outbound.protection.outlook.com [40.107.208.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFFE338F5E
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275886; cv=fail; b=aIL+ZKbsMsIi1LupPVaIZMmhLXL9xL9c/1ll/7mSwvKsfD9a8soCs0QeKLmLw6tHLirTk+rKU3D/k64x+MmfjM9J2covt8+WMc9tINSN7L7DxQVMBSGKu9vJ8P6ZTkMtuoMyq8LuQyhkgUzPG5gNEUDEPs4vNQeHE1gxmgEHstc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275886; c=relaxed/simple;
	bh=ENWA0x1yx0+a+bhvTRlBRVE9NpipbT4898z28bmDFlQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p1i79yIugjSc9bUJhSg85DvvCmUcFPqtD74c6BkLoHEnu0GULQLucA0j+Z4iLImV7vqn5vtAaxVp8Zc3GdUQ1Cd4QbyllzPRyKZSbPcFvxodSRmzPHZ+h8Q6lc0jjW7Eivrk5nIjlCHfXmOEJlsZwGTnt/7TVQCr82Emb0Y/HNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WZwB7Le6; arc=fail smtp.client-ip=40.107.208.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQmDFJrD5RpE0kLXj3Ny9GkDrCWIMtnBNTHS2nfjzrbpmuoPw0BEAfW0cVEfa03h9xzt9Orf+Ysow1VHAeoWJbeG8nQkuqVR/yFohcQh3760l93YfdwZ2pkUcXRXag8iAOnQ/qGUoPs2cyVzI+OzMCWk2qAawsK93rQLHJLpeKkeCZX4ue9JEQy52pd4z50oC0ZsWvujsSMUObmxcoCotfdTg+cnetTOxQ1XZksK1vNkl7ZajxKIfCuwmY7p6hcySFUVEyevIfn2lR4nvDPbpti/IkHaUzOaR527hw+TWH8eW5TITgzkZHcB3Pjkhxt/6bbnUhhoPY2mkeB5kVvNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8ubrNzfWm0fK4mB6LcklKGFKSmH9dswN9M3JqnBd6I=;
 b=EGZIpudPGCf1YOnkhrMlsoH38H4LpSjmT+bExGeQG1yukFTXyN6UhYs9R19MiulwdJRyMabvgoVOZRQnd0H7jLy+50e2Bp4tacpyaUh1TkJJMi20a6jTnwNPQNwd7Lnv9ZA9ZDXxwbmt3B6+k2Q20kiJoAoYMsOd1ZXLjMOhDUj/i6U8BxxV9QwAL9a2B0gzMRPjk64qvxwfycK6QQ5XPxgc9Nx9yGXITeFTMncg5bfy4XtycxccO9G2LfzJtY2A7h71kq/VZcft1UEQaFOlIUJiqhx9QgCyxsi1QdkiZC4ChqPPuOoGAQAjsmhKTGZzpw28V0G+t88ZxsEbjjINbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8ubrNzfWm0fK4mB6LcklKGFKSmH9dswN9M3JqnBd6I=;
 b=WZwB7Le6JVnD65DU3wiYgEiTOvyz9P/wVD6mNzHWkg4Io4ycRAoaG8H1aUTezE84gi4XySAKLhLzpqujCZqg8mOs/aS+2CKCk2IeVAUlVjaIvmyW/GV5lhdB5hcsd5I5w4+4nFDPUDpHTmdox3xSTsmZTRiSGXsd1EHW1NyltgKIRkYJJxnmeiwAq2h9GXAjCyCi3gNfsvSfGg+wrbIfcw6OyOcWEyw5w1a0ZrCOnfmTDD3TlHaaVHn9gnpcw+dYR9sjf8yAOb7t0iu9hzWqh6fYKUn0RyczMdfZmdOS6VFkWJmwS2mlQkZ17BIM9xGtDaA3P/rNxoW91tLaZ3S7qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:04:38 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 17:04:38 +0000
Message-ID: <8959bbcd-8845-439b-b986-e1d7007e3adf@nvidia.com>
Date: Tue, 4 Nov 2025 11:04:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 09/12] virtio_net: Implement IPv4 ethtool flow
 rules
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, alex.williamson@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca,
 kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251103225514.2185-1-danielj@nvidia.com>
 <20251103225514.2185-10-danielj@nvidia.com>
 <CACGkMEvNPzVkD8RQ84bU0yTSJeVNiq63jYbxCKhLQLpMPd0tZA@mail.gmail.com>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <CACGkMEvNPzVkD8RQ84bU0yTSJeVNiq63jYbxCKhLQLpMPd0tZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:806:6f::35) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 927be3e8-3377-4a7e-4914-08de1bc43caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alR2bmU0NXZhREt4ZEw2Y0wrM1hSTU5INnIxbHBoeGFHVGkyZkZUV3dZZEZX?=
 =?utf-8?B?RVUwdnJjSUdlQThuQVAzdzhjZVdtdUxWTzNjNlBKNGk2dkhsNXMzWlBzcFBj?=
 =?utf-8?B?a3BlMXRyMnN4b1NFQWxyS0MxNThSdE1vUGE0V1dyZHR2WHZtVDRjdE9CSElv?=
 =?utf-8?B?L2xYVWt0M3FPRWFMa1NyZW9rWk9McFN4Ny9ZS0NjbXV2MUFSRGFNWm9DM2Zq?=
 =?utf-8?B?VTBIcTFnRnhWdFo2cTVtazFFNGZmVFF0MWdpYTlrYTg4MkFvOXZXbVZ6WTkz?=
 =?utf-8?B?Wk8zaTNuangxN0lnVVVOL3hpY3NpMi91djViNll3TU5LVCt3TTQvdldDdTEv?=
 =?utf-8?B?WFgxNkhOQUpsbTdvR3kxQThQckdkcXZ6ajdVMytaeWJha3JWb21QeGRPSUxI?=
 =?utf-8?B?VVNVYm1BYVpQeU9nV2ZEd3o2eVdqVU9iaXNtQThneGk0NFVteEJuak9rZjlw?=
 =?utf-8?B?R3RrUHBFbzV1aGUyWWdoSkVJYjBqV0hzNWNzTk5WS3dland5bFZXbU5pUzVP?=
 =?utf-8?B?dUVJN0xLK1lwaTZLOWRkanYyL2xsTFQxeEdLbEN5ejJTSlBsWVBJMGM4MnhR?=
 =?utf-8?B?T0hJdXVSQVFTWGJ0V0N5cWZReHJ1MFZ4RHBFeEtTQUZWdXEzUVVBMFFoeUZq?=
 =?utf-8?B?S1E5UVAwWHUrTE56MmJFMGZaZFRaaXhjQXQ1cCs5QnY4TG5IM0V6OFZEaFZF?=
 =?utf-8?B?QjNTcEYxdkxjQzhsSGRCTHl1VDN5eDNubTFzMzA0c0lNQzhMbU9RWk1FZi9j?=
 =?utf-8?B?T1ZNRFFydDRsdks2R1dIVjA0aXdsT3REVjFYVnhleFkrem1xU3cvOE1jUmF0?=
 =?utf-8?B?T054VGx1cFVvUUlPLzVBYmxHZ2xzRUpOQkpqd3F3eFozb0c5eWFUYzd1aUJP?=
 =?utf-8?B?M0tTWDFaMHh0Z25idDdOd3g0QlE2WnExSklvaDJKMFEzU0Fqd2FOZ2dVaXVP?=
 =?utf-8?B?QytVQ2JrekVDM2o2UjlyeWU3RTZrRjMreFR3dkJIQWd1RjRhd3M5OUhabTZZ?=
 =?utf-8?B?b0d1bGJUdXZlVkNjM0EyWDZEcVNwWlFWNXRIQktLWWl2N1lOblN0WWpMcGE1?=
 =?utf-8?B?N1hEM3pZUXZuUm5WMXNhR2ltTCtBRGdKWXNBU2k5OWR4Sjl4eURWdkNpZnl2?=
 =?utf-8?B?YnpGSVNhbmY1Q1FVV0VoWThIcEpuK3hmM1FnMlVvNncxbVRGN2luak1xVjJt?=
 =?utf-8?B?dW1sRzB4UmZMd1pHMXZLKzl4UVpvcnNCMU5NWWpFS1hGK1UzODhSVjYyY2Rt?=
 =?utf-8?B?bzd2eGdLM0NadHEyeUkralZ4R0VjSkRxMUtMcklnTDI3VVJmYzRMNUUwSENJ?=
 =?utf-8?B?clAwdkFzWXFHRVlFZU9RcHhsMXlicFllZGJBb3o5LzkzVWVBL3pzYUZyOFpL?=
 =?utf-8?B?c3FOa2QvNDlPZVB6UHB6WWI0QUJkV3BHNkw5dG9OM1d5M1EwN2JheDBpWTlU?=
 =?utf-8?B?L0tQLzJyemJrY1c1c2t4TlFhTjBzTklzajdoZmV0cGw5YzF0dnlBMW5FU3NO?=
 =?utf-8?B?OGdSUzg2NGxKa2lSZDVzTjlmTXJQcCtGYXU1dTg5a3dLa3dlaGNlSzhUUGk1?=
 =?utf-8?B?OW9ra1ZZZVNnZ20rNyt1NjJLTFUvbHBiRVhlYkQxN3k1NTJrSW9QbUhpZnh1?=
 =?utf-8?B?bGhETVIxbjU1cFJVREdYZWFMeWw1SG1KWFdiODJ5M2hFQmljcVJnc1hhZERq?=
 =?utf-8?B?WkVEWXRLSjVhUE5PSGwvZ2tMTHFIZ1hSb3FrT2JieGlubDQ2dmJHQXBJOUp0?=
 =?utf-8?B?K0NUZzMzbzRUSW83SU91VG1USkd4VDJseTZseGUvKzVJSjN5c05KSnVLeTE5?=
 =?utf-8?B?cTNOaVhKNUFNSGlydHM4bVRTOXArdEh1a2RMOFJoeVlTWkw3cmc3N0FTWC9y?=
 =?utf-8?B?SmZ4ZTVLTXBRNnBmbjh6MUk4ZGRucS94ai9NZCs2NXR2a1NoK2pEVVhLcy9K?=
 =?utf-8?Q?/iCO9zNHGQEJLY2S4aWJ2agFZv26S8li?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGREd1FwM0p4OHlZdElNdEpmNUVPWHFOT1F4NlVMYUFTRDZaY0ZoUS8vaVgr?=
 =?utf-8?B?dndldDlwaHNFUUhBdm5MS20zaFAwdXpqdGI5d3lkT3ZBbWpFUVlTTGV2eER1?=
 =?utf-8?B?VFpSYm1jOVpCclhtR0JzM21UajJGNk5mcHoyNlBRNG0zMlVmMkp3WXZ0RndY?=
 =?utf-8?B?ZkFBSGhWUnBXRXR4UmpEaWtGRkhuS3ZrbDQ0K1I0WWxKRHdqRjU1dUJoWVBB?=
 =?utf-8?B?Z0tlSEIxY1BpSGpLZ0UzQnZockY0KzU2SVM0Z20vRHJNaXppaWdVY1NNY2hD?=
 =?utf-8?B?WHI4am1CUlZWb25zOVlXNzBYOEVYWFdwS1VJYWlsR3J6bFpUMFU3Qkw2U3hX?=
 =?utf-8?B?Q05xUmdFcFBRSjVUcnFDenROalJOTVgvWmZOV1VYaXZLbnMwWjVQaUNBREZ4?=
 =?utf-8?B?YkgxejNhdFI3WE92dVc3cWd0L2krSm9qNnlrMGhGSmtzMWFVblVsSjJiaHBW?=
 =?utf-8?B?Qk9VMkpwWHdpc3JSVDdYeXVoUkxOWEczbGM1L0M2dnJBZHh4RWdSYnNiY2o1?=
 =?utf-8?B?MFhOWmhWL1UreWhTb3hpUHJzK1FuZTllQ1lsM1VpOFJabVFKS2lYdHVVUGpT?=
 =?utf-8?B?Z3hCUUJEVXpGV2ZkSVgzOThic01PSWJoVkcwZ3JkOVJ1dncrNGNzbTZJaUg3?=
 =?utf-8?B?K0J6c2ZCZERSbTdkWGxjUXd4d2g2bTFDRG1MN053ckk5OWRsbEUvcTEwaCto?=
 =?utf-8?B?aU1veGMrdnRJL3lqZXF5a1VXanRLUURMSnZmWlh3SFdHVTVOK2owcnFiTmlS?=
 =?utf-8?B?bGczOFREc0hjeUk1ZFEvNmVlNUN1SHkzL3k3V2kwMFF6MVBYY0xYMlk0QVRy?=
 =?utf-8?B?UWhyN2ZUWm80TUN5Z2Y3eWYvRjJseXo0dEw3YXVtSlhac04vdjRIOTJsK21B?=
 =?utf-8?B?c3ZyeWlnMWZUR0hObWNTSk44MVpYeFlvQ1ExNjlxYnZHZXc0Si83T2pGQ3Rq?=
 =?utf-8?B?U2xtQlRwRG1uTFkvL056TEMyeWQ5RVJwb1A2QTUzT2JxM2lZQWJxbTYyVVBq?=
 =?utf-8?B?YzRUUCtHWjdhWlhma000THovV2h3RmFHQytqYzdmdG5LRTVNc2JaNC9CUkdD?=
 =?utf-8?B?SE04QytMSSsvdjVjMmdLUnNSV1FWa1ZpTERkZ2wxbWRGcGhpR1k2VEhoc3RL?=
 =?utf-8?B?K3QvMllQTjZ6Ti9RcTNsL2toUGZmR09CbDNoNjR5aG1lQlhoSG1jZmtmK1pR?=
 =?utf-8?B?RWhhZzhHQUtKdjRsOFlWZndOcWQ3WGozTFk1STBjbXZRSG1UM2R6d3RBbkw0?=
 =?utf-8?B?MGs0OHZWOHBaYWhmUlR6MWRtcjRXbVpxdjZhU0hCN3YrT3AzbmREWUVmRXdp?=
 =?utf-8?B?MmsvYTlaejlmY3NaWlpwZFNpY0x4bW9SQm9wbUx5VFVqRjU2ZHpOcGR6aC91?=
 =?utf-8?B?RklhUkRQVHZibWxkWjlWU2dtTGtmbjBMVGQ2Q2Y5RktvdmUvQlBhZFl3WVFG?=
 =?utf-8?B?b3NKa2IwVUc3NmxueGVjMlVCWG5LRURTYTYwdDJ1MmZiRzJMb1hBaTcyZXFH?=
 =?utf-8?B?RGxGWHdlZTVEL1Z0aW9VazJNeHE1eDdpWExsQURCUFhnNXhGRVZVOWMvUGZt?=
 =?utf-8?B?aWpvcGhudU1GcFZyMDN0U1hhV2lTS2dJSzFaZ3RURnhVRnBWODZNalVKaVBw?=
 =?utf-8?B?bXU1YlQwbWVGT0gzR3hvT2Y0UG5Nak5MUHA2dVI0U0UxbHQveEhpM0Y3d0Jr?=
 =?utf-8?B?RDYrc2d2amc0N1lJdE9xemlmNlI0eWxKMkdMTXJJT1BMZ1BzZjYwQTNZa3NT?=
 =?utf-8?B?Wk40cm1vNkFGL1dRWCt6UkZNOHlZVlRLeVY4aDQrSWNoNzJvcjExWExUZUlF?=
 =?utf-8?B?alJ2Q1RSTVVVU0c5YXpkeG50YUJZRFRxNjVBYld1YXFJUXlXRWxkcHVKdnIr?=
 =?utf-8?B?cmlnOWJ4VzFRdDhMWnlIdDBuZEhEWnpYOVBtTE1iM3RBQUcyejJBckUxaXFi?=
 =?utf-8?B?OGlNREU3emM5UHE5WTVjQ2JDWmtlWjNyYkhlckdWaElTUVlaclZ2cy9sSTJQ?=
 =?utf-8?B?UnVHZ202di85VjZFb01xN1dLSlJRVUJNRFQ2VDB1eHVaeGJJZUx0QVhyRW0w?=
 =?utf-8?B?cW93UUk2ZzBXdXJkTVJXTWdoM3pxV2tVWXVjcUdnRm9GMmk3WUh6ZlRsYkw1?=
 =?utf-8?Q?3x44z8XrsdJcH3LMqUfPZRr+2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927be3e8-3377-4a7e-4914-08de1bc43caf
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:04:38.0967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26x7RUI1Rhd6FOdAKPiwYxCRxt184TdS3s3QXwmxi+m/JMYPsREEHacLvrhgRgdwUMEgI4723V0j5z/H4IwU7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997

On 11/3/25 10:35 PM, Jason Wang wrote:
> On Tue, Nov 4, 2025 at 6:56 AM Daniel Jurgens <danielj@nvidia.com> wrote:
>>
>> Add support for IP_USER type rules from ethtool.
>>
>> Example:
>> $ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
>> Added rule with ID 1
>>
>> The example rule will drop packets with the source IP specified.
>>
>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> ---

>>
>> -       memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
>> -       memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
>> +       if (num_hdrs > 1) {
>> +               eth_m->h_proto = cpu_to_be16(0xffff);
>> +               eth_k->h_proto = cpu_to_be16(ETH_P_IP);
> 
> Do we need to check IPV6 here?

That comes in a subsequent patch. None of this is actually reachable
until we set the get operations in the last patch. So I think it's fine.

> 
> Thanks
> 


