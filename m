Return-Path: <netdev+bounces-70951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234998512EB
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 13:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4729E1C208F4
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 12:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A917639AE3;
	Mon, 12 Feb 2024 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hhq59t7r"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09C139AED
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739067; cv=fail; b=cp8deb2aPqIb6LUOIN1uzMlHOEw3YUY4Pz2WX1wYRADzkPGzi6uPAAVdMzk6aOE6DgWCcWbssU6Ubisel7HnGSwXlf12K+eAXlNyCN5niLzUfTyK9n6qDLVIIWqkrejEn24Srd0I5aTBhyPxm2y0FKHqbaskcbRvBO7VSnJW33M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739067; c=relaxed/simple;
	bh=JjLn4lwG+Y0QtAA7hwkXXNozDWA6OK0Lyt/uqtk1u3Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CwIITcGtmj5qjFtSe0CGnuTsmgoSU5Ofog39k9hXVS1Y3rTH5SiVODYbTiifT9Yvz4MupA8OoirMU57i12i6P3wCAHoESUxExmZyaqrR1ysiyfGXNWB6uv/f00KFsEfek+WeUf9OpGZV22lallkwwiVTwAZjFDwTA/K/sn/pSEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hhq59t7r; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5z4+16uYfjqtFbhONrRY9dmi5bzu1U95XY3wl8BqHrq3aGSuntXOJted/Vtu4xMq5byGy747w6OoB6G5leNn8oky8vsZVcVwn/qAWrdUMlJjHd1U3uloH0r/LAWl2rHUuihRgLL+rZZsQxPaqRv+UqJE9qcPVxbGjRJi84/qNDOF7wIvCi9Trj+KoO9/WSHkgrS8FvmSJL7N5kpWKVVLutEv4Oqg/E5DqaBcVWkS7TGi5SILPp6QQf3osgJSxUYLNnoWei/IZiaoBU36PTNTa3ccosNw1uUzV9G5ihqj5iyuyJ8RuAqsSIMqlRPbCscwL2zN9cpQ7ibP3yv6Tkmcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zK3dnXJseIAf04wbRh9SXB7fIS3DMKLjt6/PgyMKX4=;
 b=oJd/6Ap3DcHmjkRvWoLh4pdaWtWVDBWzOCzOyrEy1z8yB3Snf4KMmxDU9KV7+xjQ82dw4muX9gjjguPy+c8znOWAPo5uE0htbNtI24yMCrFyLcMHT8N+RKXgzzC7H1RLUIb56r/V3LPEedrEj8TkMM5jlTHjF+BDdNoKcs1OVY8ORHyy7ay/FN2rCWz3vjC0vWFPNGuGYOy5hE2ZdhsJMm4zAv6I2GlYXXiv7g7ZqIbu04Zv8lS9wIAw7r/4eEfERlGwSK3m4gRZewZey3WZlCmJcPtwEure9AKRYVUtzPwLdSuMSrvnk0Uj1UJClxfqaFcn7sJz3zjRFAWs+mCPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zK3dnXJseIAf04wbRh9SXB7fIS3DMKLjt6/PgyMKX4=;
 b=hhq59t7rNFDKIIrAfjDBNjaEAtsA7CiQ1OeFSS87Jyu2me0v89aN638bQUEmNGKp3Sab3q7mZEThS3hty8PpNb/np/TnDHQjqSb8vVZXznSWCcgdptAKjl4fxoB+yx+swnXRbd7OblgpNtdPR/p4Dh8bPH5MxivPsMmz7H9Oxs8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by CH2PR12MB4890.namprd12.prod.outlook.com (2603:10b6:610:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Mon, 12 Feb
 2024 11:57:41 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::db96:8634:7b16:b816]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::db96:8634:7b16:b816%4]) with mapi id 15.20.7292.017; Mon, 12 Feb 2024
 11:57:41 +0000
Message-ID: <9d7ee663-86ea-9fb8-dbf4-31726354a398@amd.com>
Date: Mon, 12 Feb 2024 17:27:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 net-next 2/2] amd-xgbe: add support for Crater ethernet
 device
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Shyam-sundar.S-k@amd.com,
 Sudheesh Mavila <sudheesh.mavila@amd.com>
References: <20240205204900.2442500-1-Raju.Rangoju@amd.com>
 <20240205204900.2442500-3-Raju.Rangoju@amd.com>
 <20240207190946.GM1297511@kernel.org>
Content-Language: en-US
From: Raju Rangoju <Raju.Rangoju@amd.com>
In-Reply-To: <20240207190946.GM1297511@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::28) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|CH2PR12MB4890:EE_
X-MS-Office365-Filtering-Correlation-Id: f45b847d-39dc-4b1e-7329-08dc2bc1d065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M53M3cwePfdx503ZJ2u2a4KBjKGfRGiNd6tIaWFeVO1DzbtqLGvlzh8Fl8vPkbOhl7P3yGKxafB0G16xVNBeISs+XFSneWh1osnIGDM3mGr3QFM2hNpxBtHGzzBSHn6sM/Zlys6cIlWDG614CDmkDbIoES8vus2miJOMMWDWfSjxz4x4uGTSzyAG+2et7ahmsTnYzrDEgl6Kq/sxenisCTTyvtRpWSL/UT5yhLRCTz1jra2I/nh/9us82X4SpzYy1ewk54SdRpXLHCXEnBopWJcBUENEnrF+1Ahnj8WBbOhYeb3cCKRmmu069RB8tRdCQEwnKRT0QsFh+sI47wX1/24CO0Kg7QzYhkw5FD4uW9AHnr8uDSGiRCLzZL7i3jRxLzWS76hYiFwTArW9YLFGOROqh5bRmUyCqSRhEZsYhsphqqGh+Tdym5goJl1rVbNhDBK4+ITT5D2l8jr1OOXc++fKVBdkO7x8KVvnJlk5IKhv3kNKbj5R9iWnsBIYTfLWV9qUoR/0SJutHo/HvPCi+nlWdZZ5/IWnwnMRltGL/cIKjdV3Yrgf412t5TyVXgfv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(366004)(396003)(230922051799003)(230273577357003)(1800799012)(186009)(64100799003)(451199024)(36756003)(2616005)(478600001)(53546011)(83380400001)(26005)(66946007)(66556008)(66476007)(41300700001)(5660300002)(8676002)(4326008)(6916009)(8936002)(6486002)(6506007)(6512007)(6666004)(316002)(86362001)(38100700002)(31696002)(2906002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2pHN2luK3hmLzdyL2RyR3BUNzlRYXBPdityOGN0Z21hd1VzLzZldVNUcHRX?=
 =?utf-8?B?KzY4RTI2VVhCR2JPODRLTVZDTWN1TWtMcmlGRFVjTkFIZXd2SW5EVEhUVVd6?=
 =?utf-8?B?TjFiaDVNakV3a0pGc21yajFlajBxQndxL05BUDIyWFA4aVZlZ3F0VFNXUGRV?=
 =?utf-8?B?dWlneVE5VEl3UEJrWTR3WFJJbWpKaVBvUUQzbU8xOWw4dytqL29XWk5VZzBu?=
 =?utf-8?B?UGVwTDVxS25pV3hlL2srRHQ5Y3ZnNk5QbHpjMVovdjl3S2kram4xb2w1ZEJZ?=
 =?utf-8?B?bU1jcWY0dk56R3J6aE1mVlkvZXo1TUljNzRwWUFVQkxxWkVqUFEzRU5RL0xN?=
 =?utf-8?B?V0FJRENneGF5STBZMFNxN2dtcnVaUHlmTlVyL3hudjMwc29xQzJ0MDAxamh2?=
 =?utf-8?B?WVc0a2ZxL2lIcEx4ZysrdGxyWXR3NmNGamxiTXQ5cWFjN2pQMkVUVXVYb2Zt?=
 =?utf-8?B?K3o3dEQ2SXBJUDdROEtnQWZiUmFIQzZncmZtRzBjblFEa25Hc0VUeUZpbytX?=
 =?utf-8?B?VW16dGJhMG5kU1U0UytvSmYxbCtLVjl4Sm5WYnlQRFdlYnBCMzZOeWlmcVIx?=
 =?utf-8?B?M0RmNkhWMXZNeENueW5pUkxzRFVESWtpTkxaeDVIVDNWTjNxNVpUQlQrbDk2?=
 =?utf-8?B?d2xuSVlnMTJ1V0UwSHhzQmFJSnVCTlZNcEJjakxEdlpha2N4S0sxRXVzUDF2?=
 =?utf-8?B?TzlvSmJkYVIrcmE0WUtsdFRlYm1IaDUxUlNadkl2YkNJTE9TamxtblZpZTIr?=
 =?utf-8?B?c1JrNEZBWjZGOXlKZkRLWDAwdEFLWXg4MHdvNlJCc1VIV3JiTHF6WXp3SGVu?=
 =?utf-8?B?cHhwUzR1VTIvNUZId2pDdTlWWjJYM0NVMWZNb0VvZ0FTUFFLVlB4Tkd5eVRD?=
 =?utf-8?B?WjdiV3RVTXorZ2pjdUw2SUkrUEdBeklhTVRGVG5TNnVGSERXNGNHeVlyUGph?=
 =?utf-8?B?M1pyeUl4Z0I5WU5zZEhXZ1B1OGhtQzhiamlUa3k0a09KM3pMTTlWTkdEVUZV?=
 =?utf-8?B?TUJhLzc4K0haOVRYWUppOS95RFgxd3Z0M1ZYaThkaWlIb0xxc1VWOXF3V2dx?=
 =?utf-8?B?S1VyVVRxcDhROHJmUkFKOU9UaG1TK3JjRFZxMUhnM1k2MXFGbzZzRDFMTms5?=
 =?utf-8?B?ZE1JU01ZZGR5Z2lPazNXRHVmODI4WUpUWGE0L3VHa0YwR1c3OXkxNDBDN0Fo?=
 =?utf-8?B?RUk3emdKcGVjN2hVTEo5YVhaSTRCYU50SUp4anRWU0s4U0NVT3U2bXpxWEt5?=
 =?utf-8?B?RmJVdG9WSVpsTm1LL1NpTEZTMERmTzlaVmpHb1NYZlNoRDRDUzdqb1lhK2N2?=
 =?utf-8?B?YkhDcnhSRk1FbUUrUFNrNGd0RGw0Y2t6VHUzVlBYcmpBZFVVam9GblMwREc2?=
 =?utf-8?B?NDhzUjUyZEE4UVREdTNQNXc3WVBPTnV6clhXcWI2aHJINXVwMlNjR1Rna1gv?=
 =?utf-8?B?aXNwSVg5NEhRZ3g4VUp5V25zRFp1aGpHSlNaZnRQVFh0L2laZzNGMHo3djUy?=
 =?utf-8?B?NzIrRHNUSElUeFl4OWZEZi83UTRiSk5hZ3BiWTNsZkR5emtRVWExUnozTVJk?=
 =?utf-8?B?ZGMzS1FlangxK2hXYWtZZ3dEd1pxZTQ1TDJDdTdZcmo2Y3cyK2RPOThBeEdB?=
 =?utf-8?B?bEZBbllNVWhqMEJkT2ZEd3RZcUs0TEhCWjJmZ2JYYkd3d1pYZkJtbGlBT05R?=
 =?utf-8?B?a25aSHZad0xDclBjcHU1RmU3V2xpbWtiM3dITGpHSncwY3dabHBZWXZmOU54?=
 =?utf-8?B?cG5HakRBWmxyaXF0WklhUE5mWEVSRkhNZ2xhUy9GcHZkc1ZCUHZMRVF6aVlF?=
 =?utf-8?B?YW0rKzEzUzdTUmc0MzJDVHNDdW1jeHlvRUIrK3M5SGRsOE9GakswaFM1dVN0?=
 =?utf-8?B?MDFSeGR2U3cydjBBYjBvYWplekE0Z1VseUtMazdhVk9kUmg1U2R3OGdTR3M0?=
 =?utf-8?B?Y1owRUZRUzd6dnhJWVQ2eVdrekpWSk10L2p4blQ1Y1FHaWYxa3dZTGQ3Mkh1?=
 =?utf-8?B?cXkxV0RYTHdaN2dOSmVZaHViYVE5djlUcHEwMzFJUkhZcDRXdFc3STA2c3dZ?=
 =?utf-8?B?QmhLZndVNlVMWk5WdWlZME1JY2hCUHFKNUxkeGNVQWdlN0JTY0NPdlY1VTRr?=
 =?utf-8?Q?LSEvapb3mxRePZ6QN5h/0slZ+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45b847d-39dc-4b1e-7329-08dc2bc1d065
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 11:57:40.8580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKCOWeadt4t0HQtL4OhsSgT/HOSYHn9CjDqV7bnqJXVqy2S/SbAMrA74lUuVeM04dhOnUv89oM3nkGDdWPfShA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4890



On 2/8/2024 12:39 AM, Simon Horman wrote:
> On Tue, Feb 06, 2024 at 02:19:00AM +0530, Raju Rangoju wrote:
>> Add the necessary support to enable Crater ethernet device. Since the
>> BAR1 address cannot be used to access the XPCS registers on Crater, use
>> the smn functions.
>>
>> Some of the ethernet add-in-cards have dual PHY but share a single MDIO
>> line (between the ports). In such cases, link inconsistencies are
>> noticed during the heavy traffic and during reboot stress tests. Using
>> smn calls helps avoid such race conditions.
>>
>> Suggested-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> ---
>>   drivers/net/ethernet/amd/xgbe/xgbe-common.h |   5 +
>>   drivers/net/ethernet/amd/xgbe/xgbe-dev.c    |  57 ++++++++
>>   drivers/net/ethernet/amd/xgbe/xgbe-pci.c    |  33 ++++-
>>   drivers/net/ethernet/amd/xgbe/xgbe-smn.h    | 139 ++++++++++++++++++++
>>   drivers/net/ethernet/amd/xgbe/xgbe.h        |   7 +
>>   5 files changed, 240 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-smn.h
> 
> Hi Raju,
> 
> This patch seems to be doing a lot.
> 
> * Add support for XGBE_RN_PCI_DEVICE_ID to xgbe_pci_probe()
> * Add fallback implementations of amd_smn_(write|read)()
> * Add XGBE_XPCS_ACCESS_V3 support to xgbe_(read|write)_mmd_regs()
> * Add XGBE_XPCS_ACCESS_V3 support to xgbe_pci_probe()
> * Add support for PCI_VDEVICE(AMD, 0x1641)
> 
> So a similar theme to my comment on patch 1/1,
> I wonder if it could be broken up into separate patches.

Hi Simon,

In my v2[*] series I had initially split pci_id patch to separate patch. 
But, I had received a comment from you about "W=1 allmodconfig builds on 
x86_64 with gcc-13 and clang-16 flag that xgbe_v3 us defined but not 
used." In this series, I had ensured warnings are taken care.

However, based on your new comments I will further try to separate the 
patches taking care of warnings.

[*] "[PATCH v2 net-next 2/4] amd-xgbe: add support for Crater ethernet 
device"

> 
> I will also say that I am surprised to see this driver using
> full licence preambles rather than SPDX headers. I assume that
> is due to direction from legal. And if so, I accept that you may not
> be in a position to change this. But my comment stands.

This is done to ensure xgbe-smn.h license match with license in all the 
other files.

> 
> ...

