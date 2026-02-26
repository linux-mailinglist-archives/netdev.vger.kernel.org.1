Return-Path: <netdev+bounces-261405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBZPGz9qoGk3jgQAu9opvQ
	(envelope-from <netdev+bounces-261405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:43:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F19C1A901C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8961A3072A6E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4589F410D14;
	Thu, 26 Feb 2026 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SZNNLQfv"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA963DA7EC;
	Thu, 26 Feb 2026 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120569; cv=fail; b=NJo0bm1ya4PNqSyhSdwWATKqFU2HMMby/TMOSax1rpXAhwfWpWw3+PlpToDRL/VvxZVe226/0i3H4UuID0IZl23Ar4QcJ1NyMXICcbXVQaO38b1MpBgmxpJ9FKiOe7w3Hv/9iIQJF7knOAGcYbs334kxpVn4EkLgD8cj1lldzn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120569; c=relaxed/simple;
	bh=ZelKrkm9LfDaAoqZlp2LBY8s7FU5QRRi4llcepblqiY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jO3DSsISkS/QQdJxCSwsgZl9PYlNMgHA37WeMvhyYWWiY06MOvxBllkT4H3d9t7+KyOsFLybrWd3LmvgZntuHvRjF4P+/jr/7waJDgzBbBVSFkJ9JUwQbYsz8CwHD1H3SWllBRjlzfYY+8WQQeEWShnZKB/vf82Ob02DEjguC7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SZNNLQfv; arc=fail smtp.client-ip=52.101.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGumWFf+pebTSivW3xEbCPNAYSCmoAzWBeO7t2MKawDjnUHtz97Yz1u9pmEOwFBVXfYizhFxQRbrTGVOfAc7Kv94/EsDBFlCXauhmzDhsNQ6NUKzpJKQvKMW2ggFkqVvrQpVmCBC7Y/1saA6xazx4iqfLkmn1HmQ1d4DJSfIE1Hm7GKqCZZlxR9pRWPUwPZnemJoXdjM6DFUUGpxmZXKGptXDs8PMKVOobaL72yo5wR3/9tM3R75snKcalxb6SS4J8zHiR2eRTgWo6QeZrLyJsTyiNP8mHsT9tTgPuCVHdbYktHWaYPardKyOEJw4m43NKzvRiOtO9uBrIxsJpvIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhhdqvr4/yXn8WjP09iSgrvbn+iFuc2P/Mw8kKTICJI=;
 b=U56sRjHhjFlzNOwDnPbfiSRvRhIx49eJG04tDd+Ni8Kc4wpPs/IZGlkP6TV5Ho9NEc96HWHo1sWHjCtARfCAs1C7BAuB0VZJQKD14ewUcoq4zsCM3xF2oPZLLRX/+V641dj6eiFVXraXYcjSai6z12a0hSaT8txzCLEkco6iT5RUOOxHNrOBmOsJcgyj6YlNGTJbKKWM2Cys+yHWSSnqb5Z38hPzxjLOR4Y27lMKI1k5v1i+Zi4mpcy+uDayN1J2ncl7DoUF+tyFqWmI07E83+esGKngVlP0WSf1rgDkJo4sQx6nO6aZVfcrlkpyYV25oI9uyn0PIGIMiycmKMtQoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhhdqvr4/yXn8WjP09iSgrvbn+iFuc2P/Mw8kKTICJI=;
 b=SZNNLQfvVx37nB5oq9xEHgPM/Fm6DV0T/Ryjhkt5jFb8yOdIoxHfxZnpE4EKWYikj2Tcytlndqk3dR04f+IxIkO7vGpJhQod8n2qa879UMiZimIgVxzfzX19qTqgA3k3htifjUXTqJPaAcANzCVpzyU/LXljXthC8ZqGXpCu4dg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 15:42:44 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::5a2c:3b6:82df:208c]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::5a2c:3b6:82df:208c%6]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 15:42:44 +0000
Message-ID: <5fb06bfd-7bc0-4c2f-b1b6-1fd33990dd0d@amd.com>
Date: Thu, 26 Feb 2026 21:12:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] amd-xgbe: add PCI power management for S0i3
 support
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
References: <20260225110001.1000014-1-Raju.Rangoju@amd.com>
 <20260225110001.1000014-3-Raju.Rangoju@amd.com>
 <aaA-xiedBzGqx9HY@horms.kernel.org>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <aaA-xiedBzGqx9HY@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::16) To BY5PR12MB5544.namprd12.prod.outlook.com
 (2603:10b6:a03:1d9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|IA1PR12MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: c6055a6e-f81e-4169-54f9-08de754daf27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	rxiHbE6Qm8QQBcoJz4mQe687dRDEDBNZD8WDkHKAHTVExvscfb85joJnC/fWaBsFmFPwHEqpzovhWZBfzmHZgheXb5zlJeVuri4sKlAeTZ7iBLv7Zsgb3tOFl42CLw7C/tAEeAEQDPRYpYgW6M7Q2liJoYeUz9uX8vAEGn2nZ4y22XdbApjUBk0YHwqBA8wnsyfZ3MZOn2zKe5pmkIYsaCZBSCeNMh/wluL8GdTeLOk1NqOh6B5rRQ4Hyn389gJiwLL6uXnvWB1aq6NZWpFpKwuRTzG23c7lbkG00sSg0ky/P0saQaGQniT9rfZMQDcGTY3gGTtnfcHYLYDTNS4s1HTKfC9kIzS7a5AbTX5bCPsa9dJ80mY6pEjapc8TuKIh+4EgvqJXsh0LKrf4iWW4bESi1juFcPVDL/Sggwn25xTl3mIxfyV0htpGvrGJ/MBogzsS2YxugtDcQ903MoRShHFKGl6PjC+m2WkZ35XQG6y2Ki2tIEoyS/K3vCfSzOHwMEbFe5UY9PAVeKB3zEoPOgQyfruxUSL35LJi9bQkwHSOsGTH8XgzBPYBuib6zbtco3HiorvNLjt8mqnbQ3AyemGq+2XvfStpxgmdme6DDxBSjdwklVX/hN76L9guLG95c94ouzqG5aSYXkqlcNTn7b67SXi2hxR1xy/ljy32za9qSa0rd+AZ6ODxINui9Hr+QQTblyVauX9A26C66wZ86g8rHgMKEb5afxQu9xyq17U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB5544.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmhOZVRsOGNUckN4THVMUmlrdkt4MHhaM0dSMjZVUVUybDFVeWRwRWdOOEt5?=
 =?utf-8?B?VUdOYkdBUmVNN3loL3VWRlVHSzdMVXhKSklSRHhTOGQxeHBuVENsVW44Ym1j?=
 =?utf-8?B?anYrZXFkN0NuaU5YeVJXRW94Sm1qQnp3bFJ1Y3RUTnZpK01mMXViSDRwcDVr?=
 =?utf-8?B?ZisxYjhJZnpIVGJFQU5VQTNkK1hxeTZQK01NZW85eG0zZ0h2TEVkcTUwVlE2?=
 =?utf-8?B?MFlua3A0NllVZkF6Mlp1MFpoS2xYb3J6RFNSY2FYcFlIOWozNE5XYmpvcHBv?=
 =?utf-8?B?SDJUaGRiZVJuRVFVSlF3WGtWeE9aNnVFS2lsZnJzZnBnNUo1cndaV1JzZC9H?=
 =?utf-8?B?THA0am4zZ1U2Wm9DbmRrYUhrV3FKZ2ZqTEc1V2F5cmhKNTJkRmJBekJOSkd2?=
 =?utf-8?B?Rm1oSTBKc0o4U2pMS3lYNmxMcjJaYXlMbkRodjlpQmtKd3BmVDlvQSt1ME4z?=
 =?utf-8?B?QVdISVB2SHMxaXAzYkNJc2tUbWViZlFqNklYZGE3THhqaCtDTnBTQTN5ZW9L?=
 =?utf-8?B?ZFRTc0tZSTZnMzJzbFQxUCt5Qk5UU0x5K2NwSWhEcXIra2hRS1JldHNnWWV2?=
 =?utf-8?B?b0JnbFcwWis1dnVNa3RtaisvVnFYL2pyd0I5MUhURk1wMnV0Myt6cTh5cmww?=
 =?utf-8?B?alBBVmdReWNrYUs1Q2kvbE5aN1FCbFpyeXNVaCtIMmhRNFlRVklKZzFXdjYv?=
 =?utf-8?B?cFRXVUtqdVcwQkZ1MkFLcjU5U0lCdTBkclMyQVVwOUdmUmpQZHhhS2dWZkM2?=
 =?utf-8?B?VVpaU0xwTjQ2T3VsRERDK1lwZDR2angvYTBLakpXWDNZSlVnVnRTQ2JOWXRa?=
 =?utf-8?B?b1oyeDRWaXJqb3IzWlZCaU80YVVwRzE3dXJDOGNFeTZxSnY1UmYzWGY5ZG5q?=
 =?utf-8?B?YmRJRjZUVkI3cERacklxZG5Zd3ZpL0c5WWpyd2dMRTdOZm9hbjZVVkxya3lD?=
 =?utf-8?B?RjE3cUNsVVUxSEpqWXM4d1VhL2pQOGZ5OUlHQUpVcENUZ1B6Q290ZXhYTFhG?=
 =?utf-8?B?NFQrc3V0STlmMUpPYjdWem4vbTh4RmF6R1kwb3ZBTXlnWHhjb0RNVkh1L0JS?=
 =?utf-8?B?NXZ2bUV2V3NyVzNtdGEvbXR6azRIdnpRTnpBS3VBVmI2bndObkVMOXZrRVV2?=
 =?utf-8?B?OGhQdFc4TkFsalZuNEl0R0lxOWpPYW4yN3lBbGhwb0NvNzBUZnA3cWJlNjdK?=
 =?utf-8?B?c2pPODJrdGMyMXVKWlVKSndLYUNhaWhkTExPSEhMY0lPSko3TUpaSnlzRU40?=
 =?utf-8?B?NG5qTkR3YTB0QlAwVGlvYVk1bkhNOTZIUmRsUHdxUnRocUN5K05SSU12T3R5?=
 =?utf-8?B?b1UvQVp5dzBhRVJGTnVKWFZaSGFyMzkwdlU1WWszeUlmVXk3WlE4WHNBMG10?=
 =?utf-8?B?M0JGWE9kSFpKM21TSFZCdjEwQzZqd2QxeXRvb0FFMlNBV3d5R3pUR3BFaEJK?=
 =?utf-8?B?ZTJrMmExL0RRN1lVL3pVRDBCeVBUUjFCOFQrOWoxQWI3OVM1WkVlc2xpZWRq?=
 =?utf-8?B?WnZlaElSODNMbUo1R2tDR0ZYZ0dkd2xtTjJzOS9FMFlSTFRKT1d6UHAzLzR5?=
 =?utf-8?B?L3JPeDVSbFE3bmwvUCtYUnFXaU9HZ0dEbEd1bEljZ2tVQy9BVDI4VElURTc1?=
 =?utf-8?B?K3hZRVVqa3FWRXpON0xCOEQ1dmRSQ2lNY2VLcnJ4V3VtbzZ6eXIwd2I3SlVa?=
 =?utf-8?B?a0wweUhPOVZKTzl2dldseXBTZVhJdzREYmNVRFdLL3Zrb1NjeUJzU2ZnUk5t?=
 =?utf-8?B?dVFjbWd3ZHBsYUVXcTJ0d1RkS29YWmtCWFNXT2xNZnZtVm92RG96YlYwZHBi?=
 =?utf-8?B?WHltY0ZraE5OSXdncUNrYnBZSWRBd0lHRFlPTTNFUUV3UkttOE52OGhCczl4?=
 =?utf-8?B?NnExU1pFQ1ZDU0lwMWpVTEdjY2FzYlBNUk5YaVZQbXFxc0ZmWlB0Ti95NHNo?=
 =?utf-8?B?Q2svNjJHbTN3ZTZyalRxVEx2RWhSeVlKL0tCRSt6VTZ3aGhsVEZhbEQ3eXJa?=
 =?utf-8?B?KzUvSkVrNmQyT01oSjBDZ1YzRTBOODhyOFFMMXlQQWdBb2cyTDlVQjZjMXZ6?=
 =?utf-8?B?MmVucnZONEM2dWc0VUcwRW04Njc2cXhyOWRzckt4VjE5UWpwbjlsNzZWRnhn?=
 =?utf-8?B?bHIxSDRRK0UyR2RWaXdKUTVRcVRuZStYamxpNlRKc3BFWVFOc3I5TElTY0l2?=
 =?utf-8?B?M1NCODNJYUxwQWYyZjMzVW1ZSFhXNmkvck9SRU5hRnhJMnlLOFVON0pWVmlu?=
 =?utf-8?B?aU1uaW9jMjNpRW9SUnpadFpWOFU5aWhrUEd3dzRhbWZPNzBJM0UvbjNwMVlk?=
 =?utf-8?B?K2pVV2ErcHg4bkxXNzRNbCt6STcwL25zalRmMStkOC9WcVNjM2Rmdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6055a6e-f81e-4169-54f9-08de754daf27
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:42:44.6500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMaFyI6WuT8Lw/XcjiZmR9e+XYs8/tltnWnrjLsrl3Ug0KWtd6+RQTaGge0s4tito7d/OdtnK4yw0woTo/Pr4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261405-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raju.rangoju@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F19C1A901C
X-Rspamd-Action: no action



On 2/26/2026 6:08 PM, Simon Horman wrote:

>> ---
>>   drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 39 ++++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
>> index 112d7697174c..8e392cccd065 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
>> @@ -356,15 +356,34 @@ static int xgbe_pci_suspend(struct device *dev)
>>   {
>>        struct xgbe_prv_data *pdata = dev_get_drvdata(dev);
>>        struct net_device *netdev = pdata->netdev;
>> +     struct pci_dev *pdev = to_pci_dev(dev);
>>        int ret = 0;
>>
>> +     if (!netdev)
>> +             return 0;
>> +
> 
> Can netdev be NULL here?
> Same question for the check in xgbe_pci_resume().
> 
Sure Simon, will fix it and submit to net-next as this patch is an 
enhancement.


