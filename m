Return-Path: <netdev+bounces-284678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id adpiHmi4+mmzSAMAu9opvQ
	(envelope-from <netdev+bounces-284678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 05:41:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB584D5F49
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 05:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D42F301BA6E
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 03:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE9D2DCF57;
	Wed,  6 May 2026 03:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TNObTd/G"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011025.outbound.protection.outlook.com [40.93.194.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FF3224B05
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 03:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778038885; cv=fail; b=TvdTfIiR3JOmodlyTVrLYV0EgLYIugjRQA5ykIa2eV0pwUJ8EYGe8A9vAVO4cIOTa5iWhWRsItyEtCthjkmQsc9TeRq0UlAcfyRfr/SS6rp7MEyItPZMvHv/0s95flt+uU2PKwmOWmNZJK37wZNuURg04XLv5bhohrO+x2LF8d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778038885; c=relaxed/simple;
	bh=sOpc14ZKUdConAsIYyM6ndUKQVR28+GYCZibJnoXbRc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EHWZUIcKEyI3r1gGVHqoemdyXwydq5Mqw3dflxjw+5AvgshZiey4pcgBIz7hEeo++442xwrKyJPbTJJsmVtMO2E0PxJP5zBRylNXqUHLQo1w7WVMx3lpBw6VKZN7mh0snoCso7cGIGRH4dASAQ5FIy8meSL6DCNhfnYCQeCNdmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TNObTd/G; arc=fail smtp.client-ip=40.93.194.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBPhq6IUt1UKR33vgADyXoNskcb0kS2xdW+oz8HVCZctCeWoO6nfGlMayD0ATF6K9BHpilpR43dAzZlmKVI2yGqzWWm4CXJovwj7MZqjQQt8t3L78RaQ1ZHdQx1lOgBerCoZhW3OQlqV6wUpYdc6aXieiprWfbQtjANGLGRlIfFWQGaFdmlcUGMfEBRbLeVZVq4UouGISn2Y4HI98BGjaJtgVW7YoaNDyLnhAmB/PdcWiGJj9MoJbBAZ5t8WhsefNWK1AUWBtLQqcE34r7SdKWrc7Z6779Hq9jFxxeRWrzm/xH1wIlE713e4NL6vQnFFH4JiYpsQVAQLyJAgawR4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2XwXOomjJKEC3c1yAMAFLAFjAkO7cDOU6+X6ouRj50=;
 b=deKbuSW8InJGn4ZPR42yIphwaQr2mi6ll88cOT1g0zMLO9unpUDyJVE7NoDdQbT+R+2eE5eOVI59/79CGbH1QCNVyc3y3BBC3DZdg+nExdwui4s3+ZyjvwnnJ49oYCJPsH5+NyR9cazHulerfjpzRN2O2pZN7rT6q/VR47Aeq/5TTTv75fgoeQYAidrhRAiw+sncrl8XUASAWo7Bqx4P/oMYj2N2DHWHjlms99Rv4BexP3gdjHtSlJwCrC8wwAe9yKJaOzi4WxQw0KaOgozDTXhKF3DmgPJUpGgoBW3DAO/KaYiNNl3NeH/+ttHuBUohOLViQVuWC2nullnf8DQvxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2XwXOomjJKEC3c1yAMAFLAFjAkO7cDOU6+X6ouRj50=;
 b=TNObTd/G0rhR/Gmii1zIMqGH0KKd0jLt5sKCI8dd7ep3K9WawWrTQ66B/yMq6dr3XDh/XAMrkNNY+REohwZt2oNUnpe78e1kMc77jDcW3uwJMmwCHp349tpHMzd4W4M8Vxx4MeDY18U0DdxJtglE6+3qJjFlE2B7Rb8ATU9eW7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.15; Wed, 6 May 2026 03:41:19 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 03:41:19 +0000
Message-ID: <4b8bea35-ccb9-44a7-a104-7f69afbd2599@amd.com>
Date: Tue, 5 May 2026 20:41:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] ionic: Report "link_down_events_phy" in
 ethtool statistics
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260501031555.43259-1-eric.joyner@amd.com>
 <20260501031555.43259-3-eric.joyner@amd.com>
 <20260501163951.0e0b7e97@kernel.org>
 <a1a9ebf6-fde7-40bf-ada4-7b032a5fdafb@amd.com>
 <20260505162135.5fa39358@kernel.org>
Content-Language: en-US
From: Eric Joyner <eric.joyner@amd.com>
In-Reply-To: <20260505162135.5fa39358@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::14) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e7c7a0-5327-4823-5fb8-08deab21558b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VnIO5mXKkjdhGKHX/27cvf8sMeEQvKERy6+QNjWRjCKWDaBtzJU2M8WIoC8GmhnrHWJeHRf9eTGmMIlSYQy0M6ypfLyDHaUOU4+8HaYGMdC+qrjetI6ND60DUHblS9olqktKfhA0jZGlQoePqfRHD494HjLzWFrMX+H36pLg/yzHRZKvUypS/7M1pf+NXgb3w9nf02TPuSqxIw/NDYKnsh0+Jfmo8paMOyb2nr2E+0phNOd+HUj5PsmLIl1rlBGymYkfaEGQXUeI4ArG/SZv6wwEMzEEOlZJVVOeZ5tvRJPWzbj4bABYOVC8YSpClN4dXsxauDj12AAxAiCKsnFo3I/rlZheIbLcTPMiJtDXQTWTdA0Z5T5Y61kCdmAGPBUewXw3kHcO+hBT0+EQtNMJGscx7IQSl6pbMtUb+OUA3xK18QuzrCjkguVZEzuTMDrTzXCQqQjFUgccvsODV4L8IXAmPtxW6HDYojyHeg/MO3fWbmzC8SdjPP6ij0yQ3crB/j9Mt94ARWZwJBaI4c/1BrZNfcNVsqn/3QAyYwxIiDUAhhE6VLYUGuDiE7Rcyyw+qSEKkXzVFF9PfzriQ/ND2TDmCQqq7wKQNZ26Ia2P7MI872gKZGdIClbxuRMn7/+jdkqnsXmfW/ZfrgFbN0JJS21Suog0y5SaD3MMaxn2mCZ2lElLRpnuBsVsdCUZ4R6R
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjlkRWZ5SUxYNzMxNkNJV1ViTmxueXkxRFdMeWUwTmlOcG41a25UZFpja2NS?=
 =?utf-8?B?d2FRUEZ0ZjNDZG5Eeno5ZDlSdFMya2hOc0NjSnFaQU00UGJOVDBGeEFsSktK?=
 =?utf-8?B?YkdTTHRKOWJ0OEF0Tm9BazBMRGRuVUZqWHQrOHp4emJTR04wdDN3b2VEQ201?=
 =?utf-8?B?SUZvdzA0TFZ0T3NaM3BLUXMxU0FpSkl3eVlNRzZXcE96WUxkK0pPTDlRQ3ZK?=
 =?utf-8?B?QkVVZGR2Q1cwSC9GbmlWUU9EUWpLNGRtMXNRejJxV3NkcW04QmlqenVadUc0?=
 =?utf-8?B?Y1A1bHlHazIyRVB1amh6VXFGaTNIanE3d2dNMWFMTmpmQXhrL1kwdVdyRXVE?=
 =?utf-8?B?eExvZTRnNVVlME84MmRtbXpDRkczUkdRdmZFcklkZm5zeTBlUTg2bjlpMTh5?=
 =?utf-8?B?YTN5Q2EvSlMyNUxHL0hGY0NaQUl2M3BTQWFYTkludGxRYkZnaWJoNDVGV2JO?=
 =?utf-8?B?UEt4OXJZaENwM0xNQTluMVhzYkJ1ZFZMdWdwNHRZRElXR0grZDZOdGVwWEdi?=
 =?utf-8?B?NjZKNGR4ZDkyT1UyNlhqTldZZFJrblFsbkVMREZqS09SYzAyNWRhRlJPTitj?=
 =?utf-8?B?d0ZRL2VqT1VqeTJpN3hMaUV2QkFyMXdGeCtHUGFkcGZsYTkyN1licFFSZmtk?=
 =?utf-8?B?MjZSZ1JLMisvUGxDUjROZ0xBSG5NK0JvbjdkWjd5elJNNy9VV2d6Q0pTa005?=
 =?utf-8?B?ajBza0lrcTVYZjhoZGhUTDFHOTJWbUphTHIyN1FleEFBQXhNcjhMTHpGTGJK?=
 =?utf-8?B?M1ZoekZtbFhpMTd0MjY4Z2UrV0ZKM2lLQ2hrdUkyczZVRkdNNldTa3hEQ0ZT?=
 =?utf-8?B?RUZCazV2OTlOZzZLcmRIK01XS3hra25IZm43SC9iRmVsSmVRcUZpT2lWODQy?=
 =?utf-8?B?NTM4R3Nqb1Vyb0pZcUF1Z2pOL0F6MFUvUlRDditxM3lmRGp4dU4wbDYzaGNQ?=
 =?utf-8?B?R1BqWTVhQlh3dDJpT2N3ZDR5SVF3dmE1bWhzaUxiRXNhdUU0T3hCUVA4c1V1?=
 =?utf-8?B?SUg1Tnh4Z3VjT0phT056aEpLY2NRTmVtVzUzWE5TWFNEQnpodWtLQVBZRkNq?=
 =?utf-8?B?QnNTVnl3WVpxNW5zUitrajdzVUFYVWdjWXF3d0x2UGV3SWFBVSs3THo2VGxQ?=
 =?utf-8?B?ZVVOOGpuUlZzN2t4S3kzMm9CMklqVldUZzN4NGRXWXVaN1NnN04vRGFMSkwz?=
 =?utf-8?B?Rm9YT2g0S3pQVDRuZDlVaHFiU25qTHVxRkRzZE4wK05kcGZXUXc5Rjc2cFRN?=
 =?utf-8?B?K3d6azQzZjUrU3pvZ2FhMzRRQmtGMzZic2YxMmZlSkVOTS9SQUhvQTJIbWdw?=
 =?utf-8?B?WUNKTUNJZmdBR3dkcmNzdU9QYUNnZVg3SE50VGJ6ZEJpcyt2dHIxQThsRzNw?=
 =?utf-8?B?NUhCUWRXY1lMMldaQjVsZnZjNFY4WExrdlpidWRXYnM2S3MwS1laY3MxMUhr?=
 =?utf-8?B?SkNEOG5TOWl2aUtCWVgwR05lMU9GOGpjSkN2bWtNVkprRHdKZVhleHN4M25x?=
 =?utf-8?B?ZG5ER1hOMlFxUWczSUJVZzJuVzBGZGlLNnk2Z1pMbkVFYnZwZ3RsZE5LM0Ns?=
 =?utf-8?B?OFZNMHRNV3ErUDR5LytCdFBYQlRyQ21TZ1ozZjNXeU9oL2t4NE1tVFFRQVM0?=
 =?utf-8?B?YlhpdXorMVFXbHRiM0NpdmVwb0NyTXhCK3dqK29yR2xMVE12dDdFOFpYVXIw?=
 =?utf-8?B?dEhPM21hbG51NkF3R1pOSnE0eXhaMXRlSFJKR1RDN0ZhakpwanR6a1dsYWxv?=
 =?utf-8?B?QWFsUis1WVlGa1dydVRlazloYXBsa3NIdnJvRVUwb3V6YWpFUFV3UHViam82?=
 =?utf-8?B?c3NLR2FBczZkNmVaSFJkRUJaNlZDd05JNngxT2ZKS3NBcXJCSW1XdTBBUkdJ?=
 =?utf-8?B?cFZ6UXFNQ1FOUEgzazl1R0t3Y0x6VWFwQytpOUFkdWg0dlhFNVUvRFlZcnBp?=
 =?utf-8?B?RWdoaFp5VlVUb1Y2VmN4S3JrYW1pTjhLY2gyd1p6RnB1eTE2OHY4eWlpQkEx?=
 =?utf-8?B?WlJtV1UxVXBaMjg1UExkSENpTlV1Rm5OTVB3dEpGejBmVVE3ekVMVzdCZ2Ru?=
 =?utf-8?B?cDcxRmVGUVNTS2Rid1g0QmRKZDlFL1RRd0dHVzQweE5zWm55ZkdubTZ4R2lI?=
 =?utf-8?B?T1BFd0tEVVNYWDVnRVo0ZCt1RHpRY000Zk9nZmhzeU40L3hvZ3RxTVJ5a0xo?=
 =?utf-8?B?S1BnUEFjS3BiUE13cUN4VVBIR1JyWG9mR0I4aHEzSi9rM0wrWmVISGJ3TWp2?=
 =?utf-8?B?UTYyVlIweG94WFFvTWxoOGE4MFFsSHVMSC9LTUEybWlBREdhVm1KTlNwV21o?=
 =?utf-8?Q?gGkR3LS5mLXzfzkFH/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e7c7a0-5327-4823-5fb8-08deab21558b
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 03:41:19.1887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8J+4MDVQAM3eSFSBRH9phehzpB6iVeMT1Po/NFMIvmMA8XWiYNAcdwRbXEw5TRZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
X-Rspamd-Queue-Id: CFB584D5F49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284678-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 5/5/2026 4:21 PM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Tue, 5 May 2026 12:53:26 -0700 Eric Joyner wrote:
>>> We have a standard stat for this:
>>>
>>> struct ethtool_link_ext_stats {
>>>         /* Custom Linux statistic for PHY level link down events.
>>>          * In a simpler world it should be equal to netdev->carrier_down_count
>>>          * unfortunately netdev also counts local reconfigurations which don't
>>>          * actually take the physical link down, not to mention NC-SI which,
>>>          * if present, keeps the link up regardless of host state.
>>>          * This statistic counts when PHY _actually_ went down, or lost link.
>>>          *
>>>          * Note that we need u64 for ethtool_stats_init() and comparisons
>>>          * to ETHTOOL_STAT_NOT_SET, but only u32 is exposed to the user.
>>>          */
>>>         u64 link_down_events;
>>> };
>>>
>>>
>>> IOW the definition of this stat is - ignoring asymetric link faults
>>> this counter should match between link partners.
>>
>> So, this is a little awkward to talk about -- we are already filling out that
>> field with a stat that's calculated by the driver; there's a task that monitors
>> link transitions and increments it.
>>
>> But, I'm not sure if that method exists because of older firmwares or cards not
>> tracking the link_down_event count for us. So, I didn't want to just overwrite
>> this stat with the value from firmware because then we'd lose the count on cards
>> running firmware that doesn't do that counting for us.
>>
>> So that's one reason why I put the stat in the generic ethtool stats output, and
>> gave it the slightly different name "link_down_events_phy" to distinguish it
>> (this also matches Mellanox's name for consistency) from this stat in the struct
>> you posted. Though reading the doc comment you posted, this new stat really does
>> belong there.
> 
> If the stat is currently filled in with something that does not work as
> documented it should be fine to drop it. The counter is optional and
> relatively recent. I think it's unlikely that any monitoring will have
> a hard dependency on it.

We did some testing internally, and it's safe to replace the link_down_events
stat with the FW generated stat instead of the one the driver calculates. It
gets populated and updated properly by the firmware on all of the hardware we
test on; I'll have that replaced in the v2.

- Eric

