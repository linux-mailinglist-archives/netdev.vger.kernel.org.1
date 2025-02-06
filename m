Return-Path: <netdev+bounces-163610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3176FA2AF06
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262DB16B77C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E72E194091;
	Thu,  6 Feb 2025 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TRI6m5Ik"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F9B192D83;
	Thu,  6 Feb 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863466; cv=fail; b=OI3lfmtJAFHzUelOUbF1has7Ok9sbDBk922XhzLACzjPwUgavg6/JSqB1JSA+kDmQ6rCsXL8qWyH5U+3jmPqTCD22G0PHWcxE6fXQE+jSP8MHiVuy9Zm9g7VqN/mvKseyWMOnfQZ02lqtf6UdxpMAxWiJOI0HFGOIOErVcc5Hs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863466; c=relaxed/simple;
	bh=MtBOnLR8qpOcj/w809dj3z23vorsxvPCLuy5xJY5k2Y=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VSOVpn4uQHzAIWhUD06prcncDD8bEZDCzBU4w0j+ibvo3HkxcCix9DbK7BL979d6SrVeWsBA3s+JVh+CaTX8NGElFFUznOZYdenTYb8xUstJMmj1uOWLcLVqEE8ZN1JcBjk1XpNDgPQCy2ASN4CqCOmW9CszY5xNSOMWlmP2WCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TRI6m5Ik; arc=fail smtp.client-ip=40.107.102.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZo+eI25tqJIdK5nWcid1cSAxrY6vHPe3FaKsAH94EGnXVRsHq9E4cROerKNlm9i1hbao+ZOxNOX1x8IObPhvyLEmnJEajOOSmaSsC0SN5qTBBOLRLxZYFWjKG9qYIKQpRMnIkXKGgO6hazC1DuJsOnAoDnl8SQd2bGHhSt+jNED96ol7VRqL7aSuWpfIT9Iwq6eNSH3H8Myw9llASwD5ciWRGu4q+HEOL8/X2G7dagXK7v7v0PNzxVySwbDAkOzlirCwKnbXVi/4nk5C6BcRFG44uW+vauQPMQmBuy2mdpXgWJ++7tQeLjyGfhkz7TxQAazWK2lNIBjGnMGVW0t5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XqJyt7nUhwuj+jXpS+TjcZbwSYBok8gT0CnznnFako=;
 b=hoeZ9zyRQwsJM4Buo3lNVaMUgRGNRB9SFZ+eThdQfaFkGoQ/rC+HOW+c5sZxdgPtbTk5+pEzx0/EullFj/P6PPDXxgvREKWBoRbnE1y1CBH7ke6/V8NEo79TSBxfSmh2vbwheDnOcFkEL4Z9bUOeLsrAlw6Zm4GKve3urt9dhuIZZdMGzWA2vYmuYdCjjgUSpeJ/SPNruK3tldmHdyurGn6eJJK6979JewM0UkuaWW4v7vlNxOly2O4i+1pTgdmQS9iCAOkIcaDqYIYIPakaLmN9KfWAy9efLhTvFNmtrCzTi7iVL743EUQoD6qGuxqIa+J/ZYi31tq2GfINtPc4AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XqJyt7nUhwuj+jXpS+TjcZbwSYBok8gT0CnznnFako=;
 b=TRI6m5IkPsBY+yPinPnW6Rts1JKcEusMe7l1fCbN9H5CxNdTxGn/agWcU0wtGoGtcayPs6JEmgMSRw9Rzqc7ArXmUcQKU4+Sp3j4T96608IxT+ryA97CV61Ib6SkHco9xsETiOI1a1RXkBvn5LRVvXL6QYNLro9O3/ACBkyV38k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 17:37:40 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8422.012; Thu, 6 Feb 2025
 17:37:40 +0000
Message-ID: <5cd8ee3d-c764-403d-9b9b-bca268b33383@amd.com>
Date: Thu, 6 Feb 2025 17:37:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/27] cxl: add type2 device basic support
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-2-alejandro.lucero-palau@amd.com>
 <677dbbd46e630_2aff42944@dwillia2-xfh.jf.intel.com.notmuch>
 <677dd5ea832e6_f58f29444@dwillia2-xfh.jf.intel.com.notmuch>
 <c3812ef0-dd17-a6f5-432a-93d98aff70b7@amd.com>
 <92e3b256-b660-5074-f3aa-c8ab158fcb8b@amd.com>
 <6786eab3a124c_20f3294f4@dwillia2-xfh.jf.intel.com.notmuch>
 <67a3c49e1a6ef_2d2c29487@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <67a3c49e1a6ef_2d2c29487@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: bd0896d2-32c1-4242-d4c0-08dd46d4f3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkdySHV0ZkQyY3lRL0x2cm5Xd0NtQ3BnQ1RmRVgzWk9nQS9UZ0dQeVpXenRi?=
 =?utf-8?B?ZXVESUQrS2VjM0JxOUEyd1JzcEF0V0E1V001dkMvaFVFRHdUK3k4NWFKclpq?=
 =?utf-8?B?cGM4aVA3SEhCZDlCUjhMSUdFbFFyVDU1blZOejF2TlFiZlR6SzFkOU5tcTcz?=
 =?utf-8?B?ZjhVWWxhT2dqNU5kaDBRWnFLSmRMRzAwNlFBWFJ3dW9yOTNrUzFSVkJGQm1J?=
 =?utf-8?B?cXUwb3pWMmlNaEVrWkIxbXpyT01xWktueWpuWVhNNXlSNGE5elRPUUdodnpP?=
 =?utf-8?B?emFoU2VFOFU3QVVHeDFvZzh4S09CMUdUNzMza1FxZW90VDFpVkFiZWM3MUR0?=
 =?utf-8?B?NHJxK0IvZ0EvYzNnUGZnckhnbEZkaVRFUk90d0lHWXJlelQzcFNRUDkrdnVn?=
 =?utf-8?B?TU9KcW1rdkxKeTkzODVlUnZ4eWJybXV3azFhbFJvM2Z6Y3RCdUhacjY2V0p0?=
 =?utf-8?B?K2JMUWI5Wlc5aGVRTWNwemhMV0w4ZFJONkhFakxJL1lpRjJsSE5sSUhZNDYz?=
 =?utf-8?B?VDBNSERUQkJPS204b0taaUl3NTRTTTdFcDB6MWFUK0tsMW8wMHJWNWtmQTJ5?=
 =?utf-8?B?bXhFbm1vY2hELzliOVNOanNXVDBQMWRsOXhTeSt4TUdBUWdEV2tXRWEvWXgv?=
 =?utf-8?B?eGlob3h3VXY1MEc1OGVWcldiL2dmNzk0REZibEh0a0liQktEQ2NUbFg1bDdj?=
 =?utf-8?B?YWJoY3pLeW1UVWRqM3RsTFBzSyt3NXFUUTd1WGcremxvUER1ZjRENElwRW13?=
 =?utf-8?B?K2tqeG5FbHNPTTVoV0krOHZneFVVTi8vMXVmZ0t5SldBa3JQTnZjeDNVc3ln?=
 =?utf-8?B?WDNKTlZZU09TeERLOWordHhDRm1lUEVkRC9lV0FZVEk1UUExQVBoZ2hiMDND?=
 =?utf-8?B?VFFRdzZOYkdBZ0czUElkTEdkdEVkOTFBb1AwM2FTcjYwblVUc0VlbGZxTlhS?=
 =?utf-8?B?aGF6K2pKK3RndUxWdUsyYnBxdzgzZVRYLzZFdWp6Tnh5MVdxUnExVmhoa1gy?=
 =?utf-8?B?SzhqUEg3Q0xheGVyNzYxKzdEVnp5bW1lbVBYOTdYbW9TMllHd251QnhOWm9Q?=
 =?utf-8?B?MG9rWnBHMm01U1pWeEFkd2hjdGZ3ZUhpNHFnWmNDd0IreHp6YUlTaGQ0RUtQ?=
 =?utf-8?B?dDRpdFBPa1Y5MGp3bUVmUlptS25LT29UK0loOHU0RU1UTGZZSVMxTnRiemRp?=
 =?utf-8?B?Y2JSZGcvMXltNVFzSXlGeDduMlFtZUwyRnUyVjVNZGRjWjJkaW9jVW5GN2NW?=
 =?utf-8?B?MlM3bmwvZGNhbDM3alA3WHlVOUtJR0FyZnlkQUk2V3dZU1RMcUF3K3FYSTRI?=
 =?utf-8?B?Sm94cTlmZUhVK1dmOVYrQnN5L2FrTW9OMkhOb2VKdi9VTklTakJjQlJlVU9O?=
 =?utf-8?B?ejU2TGdBQVkwVXRKRXFKUGFudEYycnRFZ0wydXNmb3hINGl6T0VvYnlxampa?=
 =?utf-8?B?a3d6YVQ1bldRNFJIaWtGT1hua3kzYUJPcFQ0OFlEQ1hoNVZVTGQ5cW4wTmto?=
 =?utf-8?B?Qm5zNEJLdThYeTh4ZDVTanQvZGJHNlI2Q2RlSjlUcGkreENaUVdEK001U05E?=
 =?utf-8?B?cExOWEtBNnpzblAvMEtYUXJoREYzOWNua0kxRThJK3YxQ0gxelRBMXdOYXRS?=
 =?utf-8?B?Uk9vVVMwZlpTbGEzQmEyTktoa2Mvcmc4YnRsRm1PbnJrRXJIUnprRjluMVQ3?=
 =?utf-8?B?ZUFGK2NkTGJjbFVqNE9DZTNiemw4ZG05cGtydWpZSDFjUnRUNXcrbnQ3cTdL?=
 =?utf-8?B?Z29WckFIMHRwRHdhdi92cFltYzUrMHNQWFNtYWN2WFE0WjRnTnVGYmd2T1RF?=
 =?utf-8?B?ckhMczQyWHAvMkV3dHpsKzMzekFvUmc4aDdaT2ROeFZRQVFkQjVPT3ZKeHps?=
 =?utf-8?Q?QMH5yIABCzSGl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjRLVG9TY0RMTEdqdkFrMmQrSzJKbUtJVXZSTFpXeHY1SktFZXppRGUrQ0x0?=
 =?utf-8?B?S1AzY1M2N1NGa3h2YzFEM0c1OW5yL3hMU2FZQU1UaWZoVVByUTJUVW13dGlo?=
 =?utf-8?B?MCs4R0l1c2RuZzlrV1Y2SEJXamJWWFN3aW9HV0NmZUtUSURXVUJocGQwRjUr?=
 =?utf-8?B?VmtBSW9KS095WXdYbk8xU0lBWTQzSFBERDJWVVc5c2hodjVjT0oyZHU3cEZh?=
 =?utf-8?B?RUZKS2JuWXFtN2puYks0OFdkQjdvTjlFM1g0bnJCOTJWSGlpL1hyNiswNitx?=
 =?utf-8?B?TnJyTklua2tBanZNbTZYYUlyUjE3WDFldzJKeG5GUUc3V2dpMkVLT1U2MjNT?=
 =?utf-8?B?aTJrY0UyaGoySXd1c3YxdDgwTHh3RlFPYlp0UGVYdml1ek42YnJ2dWIwYkVh?=
 =?utf-8?B?eFRKdlg5V2orL1Y5QVVSYTUyYjdKMitKNGtoMXI4dnZVMXFiT1JYSEhpSXA2?=
 =?utf-8?B?RG1POUFsRVk4QlUwYnA0NStNbmxWNStGUXZSV0J6TTNOWEZZY2RLT1VoeVNv?=
 =?utf-8?B?VEkvc09rQ1NDSk1mZlZKbWt3bW9TRSs5UGtLSTdUNG42WXJuRXpYVUkzWnNn?=
 =?utf-8?B?akN4cmR1VUNCMXlUb3F5V1FRVEdXVmpVTXQ3UDlaUHgxM0xXNnVvMVFuS2po?=
 =?utf-8?B?bkdLRFgvU2NGbEREZVIwTE9DekVLRGtBNGQvYm9UVXEvRUlEOTgvMGtadnYr?=
 =?utf-8?B?MXhVOUlaQmREVnJmSWpDNGZ1UVQveUViek1jcEVKN1Rra0tzZEE3VkRMc1FM?=
 =?utf-8?B?L25SRXlaY2R3SUlnRnBxUXgzL1FTVUVWd3crNGFGeWx0L0tEZElhK1JxUGFZ?=
 =?utf-8?B?T0tNL0VoZFA0am5Wa0N4T1p1QkpIZ0k3c0RwUlNKa3UxY2MvcytLaXlHV0pn?=
 =?utf-8?B?Z0Y3V01JQlFmR1N0R1E1RTlqaUNxUStia1daL3NXVWlYRC9ETGNIOEFMQmFj?=
 =?utf-8?B?eTRrZlYvS1FZQ09jTE4wWmwybzFUd1A3TjJTRFZ2ODdKOGt2MFJIOHhzWjV5?=
 =?utf-8?B?TjdmeFJNSVJVQkFRRE5iY0EvOU10eWtiU2pPcVZpZ2tIUVpsZmliM003Unk5?=
 =?utf-8?B?bVp0Rzd0MTN2azdFU01CNjFBaUxkRFkwTmRZQzJBa2trbFF0ZEF2OGtncU5B?=
 =?utf-8?B?bDBHMUhMUTJXUy9WeDl6ajBIVnU2aEhRdTZib2I2ZHptMmtZcGZndzBTeHFD?=
 =?utf-8?B?OGtXejN4RVRPNlRPNzNBY2t0VjZmWENrUngrWDFKUXV0NHJ4QnpGZTdudkY3?=
 =?utf-8?B?ZDFiMnpnUDlFRXZlWnZjNWdQeHo0aW5JbDlaT1R1VHpHTmRLNVpudW00c2Nv?=
 =?utf-8?B?SHJCSVVLQTN6VW91K2U3N2FEUTZtTnVEeWgrVFRoSmtHQU1Mb2NydHBXRmlB?=
 =?utf-8?B?YkNxNzJNalhHOUFDc3hlZGFtTlpHQTlEUVBwaTdHNExvN3kvUnlXN2piNlVq?=
 =?utf-8?B?VDc2NjYyd1c5Yks1cENjQ2p0Zk9NWWhpZGpvek0yYUIvQUljd2czRUI2aHVi?=
 =?utf-8?B?NXhzY2N5VS90c2t3YUVDa3lHMjdpSFI0VVVRaDZsZlY0NXpzdUZLSXJET2pn?=
 =?utf-8?B?RlpYQlExaUptNmZwUEl5L3dIQzRnTGRuc2dnSTVwcjdJMmNPSkpuR0cvL29q?=
 =?utf-8?B?K2srK2FPcHFmNzVjeWNqQnhlTW01Qk01b1liM2M3TDJpR1lCQS9ZMGFYNi9F?=
 =?utf-8?B?TVJjSElkQStsWVpjZFl1clpXRXQyR2NINEZ3R1JCTWplTVhsZDVPdDZGbXRE?=
 =?utf-8?B?ZlQrTmlvT0J0aVY5NXRReFJMWk1tczlrS1RoQ1VvSUhzNmRzaFBGTnpaQmkr?=
 =?utf-8?B?clJQU2VXMVlEWmlnM0FXak9VODRPYll1THFoZGZxZjJhZTZucFpTNzlDbkc3?=
 =?utf-8?B?ZUE1Y1AzTG14dXpqa1M0akhpUXA0QkkwTFJlMDNVR0FFS21Gb0ZkcnlBeHc1?=
 =?utf-8?B?c3ViSTB0YmtDUkFJVFQzN3ZXZ1hYQ0FHeUdqTld6T0JFYXd3TThvUmZaNjFl?=
 =?utf-8?B?bjhITk54Q1hPV1Z6YkFXNFVMYklPdkNJY1c2VzJnY2N4dWRadDNsNEhyem1V?=
 =?utf-8?B?YzgvOXFmbEY5Y0kwZ2xoSVJBYVJZQzYvN2RDNEphY3hEVFptZ1ZZZUVMWnhh?=
 =?utf-8?Q?U4QXOM+RzvUe13RKWHiyuGJ21?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0896d2-32c1-4242-d4c0-08dd46d4f3e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 17:37:40.1084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFNS5TZkwG0uvylYMw7cj+Yl4SyKG0vqXdlirR4ieQWceXhyE733VrZcuWFPExfJ7eI1+u30XWc4CWW6Wr2gCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021


On 2/5/25 20:05, Dan Williams wrote:
> Dan Williams wrote:
> [..]
>> I think there is a benefit from a driver being able to do someting like:
>>
>> struct my_cxl_accelerator_context {
>>      ...
>>      struct cxl_dev_state cxlds;
>>      ...
>> };
>>
>> Even if the rule is that direct consumption of 'struct cxl_dev_state'
>> outside of the cxl core is unwanted.
>>
>> C does not make this easy, so it is either make the definition of
>> 'struct cxl_dev_state' public to CXL accelerator drivers so that they
>> know the size, or add an allocation API that takes in the extra size
>> that accelerator needs to allocate the core CXL context.
> Jason has a novel approach to this problem of defining an allocation
> interface that lets the caller register a caller provided data structure
> that wraps a core internal object. Have a look at fwctl_alloc_device()
> for inspiration:
>
> http://lore.kernel.org/1-v3-960f17f90f17+516-fwctl_jgg@nvidia.com


I'm not sure what you mean here, and I just gave a quick look to that 
reference, but in my opinion, it is quite different userspace triggering 
some sort of allocation based on some sysfs files giving the relevant 
information than a kernel driver using an internal kernel API.


Anyway, if you have look at v10, I have modified the accel driver 
allocation for state using the memdev state instead which makes more 
sense to me. I did use that from your original patch, but it makes 
things complicated and a Type2 is a memdev after all. The code is 
cleaner and simpler now.


