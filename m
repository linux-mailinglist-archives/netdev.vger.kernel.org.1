Return-Path: <netdev+bounces-204186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6528AF96A0
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 17:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A54116A86B
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 15:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3542170826;
	Fri,  4 Jul 2025 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jk5cnw+c"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3670914B08A;
	Fri,  4 Jul 2025 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751642294; cv=fail; b=MqKd1ITKm8y4ak56pvx7ZIU7QTRlCUISVYllz1WtLy8PysCmbiF71gyvm+LN1ptbeBQ4gmzC8zyNjDNXaS1D/4xlMVWdRarmyHw1vXyhgVBvCtBnJPgpxdvF+ycIUmpXG94e8Pvm9CPKqHXaVvJ5fIc+YcIjSgjBbfUsA3BPicE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751642294; c=relaxed/simple;
	bh=cQdYXFZ5VO+EpTo8Vj91CZS94L0bmjV6cEJ7bZq6UKI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XnZjHZOunLNE17nx6CpxjfG4XfA0wou3pTg29m6jRmN11kHw0xqZ4/Pf+ChnW/ahUnKf2v0YCmxT5zl8pKbFfI42RdoZJd7yMfCwVA30+3D4O6Trvmo+pUGPl/RnECwsJyyGLRsxSWi7PQ3mtQnKlMaGWRCiyB9HOIcnLQ9V4UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jk5cnw+c; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8ftyNv4Ta7fz9Sl7lJJwgq7VbzGSB1JYmJ1VnPYwcqdZqIIoVQT89RzHhP5agjw6KXqZlSdEXjnrqCcJJkJqZTFfSzvPX9JGzFpHx3xkwI75WQxHpvJOhOQ/r0dw76xSuxweS+C8dnQgpzgWXMO9O67qxwjgBQQNEMzAU9KTNmzFeqorz7sqEtIuILjYPwooIyps6AtB9YjugZV+yNZmi9xe5IpA/tRZT9U3bWlna48mshq2RXnLYJcf2Nwg3ZPXWW9qYiISKDNZKv2kzKM9jAKhJXyI8jj9KHS173kpAtPF1wrj7YAKKLg447RRwligXWagtC2bigZoVVkn0UuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UfjPMqGNYfzKO4b1PgU3UWjULwRfN/1RubdZPRPSQw=;
 b=Vb/WrbhowjoN4J8i4jQ5phJUUrcodss1RB57Qa/SWjCMjWhQx/wo9btN0chph8vG+u53UmJlxUZAHSGeef9bO6qZcaRbezNN4DHNtU+tb2xm8yV+jJxAPHsDceTSgp61UWUmwABlfjqca5kcbn5AfYeUDkaowVoYh3dsYYJ/AzV7qW+QvC9k/sBzlzk1T/ZD+gFkavAf6aZr7iGMG74CqLBM+/vNMCo/PtOW6CObbAM/gvbOpPmtGQn/0Dd/rdKt4Pgx7eQUtDvdlZm+e5ZrBbz0w/dQpEk7dypt5DOF380dkvdFI/XJcPAMtfB8pP4hStIaGkFcPx2ScTIyH1EAJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UfjPMqGNYfzKO4b1PgU3UWjULwRfN/1RubdZPRPSQw=;
 b=Jk5cnw+crrN4JcS2H3o5xqhShtCl2i//H3uJMls+Z0lEDaQchjBHUzPHSsMoK4HyS1psNTj48EAKZYbRUuFoypzIk1Wqmfn+jMIIY9D4q6U+SDJCEGzD16cw5eZpgrn9e/qIwo5O4IJ7IChZboLBVkXvPRE9HK7HPErg88cOMzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Fri, 4 Jul
 2025 15:18:11 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 15:18:11 +0000
Message-ID: <00624fd6-8b30-4f86-99b7-f7df2cedf401@amd.com>
Date: Fri, 4 Jul 2025 16:18:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 13/22] cxl: Define a driver interface for DPA
 allocation
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Ben Cheatham <benjamin.cheatham@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-14-alejandro.lucero-palau@amd.com>
 <20250627100638.0000456f@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250627100638.0000456f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: df606995-11fa-4aab-3f96-08ddbb0dfcd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clcvbEN6NDQzVDFtb1cwNkFpbmh3eEEvRUZFVkM3WEVNcmYwQlR3djRsUVRs?=
 =?utf-8?B?eDl2K3dleW5vZU5HK2R1cFhHZUNvNXo2T1ZLa3lqT0lFeFVHZXFSVmx6TEJG?=
 =?utf-8?B?RDl2L2JYLzFyQmh0QW5HTDd1WUhZWVQ2Q2VJRDBNMU8xdkpJZmM4L3J1MFB1?=
 =?utf-8?B?Mld3MDFjR3RlL3ZjWHJqQVUzNlM0dnlkVUIvam1zSWNXS0FHQzVMZUlYTk9N?=
 =?utf-8?B?RmxiRmxYMVZMNElaS29GUnc3T0paNEMzVDg1ZE54Qi9Qa21jYXFFMEV3K2VX?=
 =?utf-8?B?OFRFZmxhNkNhYXhmRmFIUTlPQXZqdTJkTXg2NHNlMWdzeTZseElMSElZT3BQ?=
 =?utf-8?B?SFZTWTkxdnFWR1c2RGhRYVYrL09rb3hVc0lqOU81ZTk1ZnB1akQwb3VQN0d0?=
 =?utf-8?B?OXJyOTYxWHRGMllveEl3cU5nOVdEK1BUeUhGMkc3ZDk0M0VJZnNzNWdaamRv?=
 =?utf-8?B?YnpaQ016NWRNcGhTMVVtQ3R2aFJmWkhObUxrRWtTZ0ozOU94bUFqc1gzMUU5?=
 =?utf-8?B?NUs1TE9BTWpubUZJSjJuTlNYSURpcXJPU2hwU3JWMXprY0U4alJiWTlaR1Z3?=
 =?utf-8?B?L2FRNTBFM2Jsc2RJSnU2MUlhTU9DdXY0aHpDbUZ6RjlOWGQ1OXBSTUxhUG5I?=
 =?utf-8?B?WDllcTVPQkEvRlRMOTVYV2tWTTZ6MWR6YzRoUnlNWCs0OGQydWl5M1lSMkcz?=
 =?utf-8?B?WVF1QUdCZFJVTDdjMHl6bTlPMTF6UEJiall4c29qall4eEJPV0ZHWEZpazhm?=
 =?utf-8?B?YUtwUVZXdFBlZVJhZTA5cnNRUS9VWFY5UTAxU0hWZEhGcEM5NVNxWnYyemk5?=
 =?utf-8?B?WGpZcEd3bC9lR3JTY1NtSVNMUEgzMXNybmRyV0dEOCs1eUpMVkNhbDMwNzBh?=
 =?utf-8?B?akdpaTFZcERVa0hkdGdrMzdJVXZUaFo4Qkx0V2N5dVFDeWN1VlVGQkNBK0x3?=
 =?utf-8?B?eGNzVnM0bU5WT0xmSU5qV0FlMWtjaTZ3cTM3c2NtZ3RjYW1uQW9NVUwwSHN6?=
 =?utf-8?B?MUtPNW04dkFPeGNDN1p5WXpaU0ZyZVZzM0JyTGhQL2tBSGVJUCt6ZHdnb1JH?=
 =?utf-8?B?b1R3cW1aQ2ZMdSsvVDlZR0R5RUxpdW9zNXVPZHFDYVVYcDk5L05MS2M0STlQ?=
 =?utf-8?B?VlRDdG5tZ0hUY3NUQmNUZDJOT3VuNEdBblZQU2pFUm1KMlkwdEFhN25STklt?=
 =?utf-8?B?RzBNQlJaMllRQWlmT0toUmdFQzRwaDMrbnFiQmtzTk40NWFyaVlrS1VQZzhU?=
 =?utf-8?B?NERjN2VNR1pSR0xHZU90ZjlXZmloeXVlaDRWbXRSY05TUTUvSzJRSUdpZXp5?=
 =?utf-8?B?QW5QeGxsOGhrL2hBZ04yWmZmZU9GWGlsYlI4eWFpUFBGVGg3bmljOFl4U1NQ?=
 =?utf-8?B?aXlvcGFTcVhUcGd6Vll0bmFmU0phUlJ4Y0srZWd0QVNlWGNhU2NGYjh4SVU1?=
 =?utf-8?B?VEsyd3VuaEJhTmtaZ3dUeUwrRVB2RXllZSt3NmNpTVowbk1vOFAzLzc4MnR0?=
 =?utf-8?B?NmNESnhrMy9MM05Mc1AxUHNyYjRiZDNoY2RWRUYxWEdKR3ltZmJUa0RxT1lU?=
 =?utf-8?B?R0d3Si8wWmU1VGY3WW9ueUM1UXkyYjVsU2dLcEVFVm1FNEx4aHJZdnhnWmVM?=
 =?utf-8?B?bW5STWpPdWdTSkNjUjNjZi9uZytnaGliZ3NmZ0R2SFoxZW5vNVduL3hLak1Q?=
 =?utf-8?B?VUtqWFNhWHRFNFc3Uk9ZcjAwVHhuSFh2QmVoWCt5TFVDNDI3VzNkUVF1OWs5?=
 =?utf-8?B?eTBuWVBmSXVWa0d5NUxycGRUaG1CNGl4ZTJuUzRTdGZwMFphOS84ODhacmVq?=
 =?utf-8?B?K0EwQWpablh1WWRzMFpEcWRqRzkveElHVDQ0TzlKRHY1dm1HMkNBTmF4SG1V?=
 =?utf-8?B?Zis3RjF2aFY0b0FuWG9QR2lLVGFoQjhrQ0M5TmgvanVHbmludytwTVNIU0Fv?=
 =?utf-8?Q?snRB5oDJqTM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnBMN1lHemtvZ1d3NC9pcnVNVXFhYTZiMmxKQXhWUzJGdTk2M3l6N2dZQ0tD?=
 =?utf-8?B?UmtDcVdmZ1k3SXcxRjErZE5PU3c3T3VlVWdMQWxyZm9kbVB4WlZBYTJyODFB?=
 =?utf-8?B?T0lQeFhsWUtMWUl5djBReXBnek9yL3V1ekRHc0lLcGtnVzNRRG00YXVLdnZr?=
 =?utf-8?B?NFZsWG8rRUp6a2RmR1ByTFFxV01MdmMwZ1JiWkN2QlRLelJxQ201ME5vMkVZ?=
 =?utf-8?B?UExqZHR0bU5qaStYSmd4NVN0cThtL21nckNRVi9RUEtJeHZNUW5hcW1jY1NT?=
 =?utf-8?B?UjIvb1BCdXZmZEFVeFVqZ3BRMG9rVGxmWkhpSktpUDVUUEJxTUNiM240UGRB?=
 =?utf-8?B?RXY4d3FYbnROVEN0TEVvbFkrUjlYLzFFTDVxQmJBaU00R0FjTER0VWg2OW1l?=
 =?utf-8?B?dFdmcEdIbGNROUlmZ09DNW40cVRLVEU0bVJvREFMaFR3d1JsaUYwdFdQTmhL?=
 =?utf-8?B?Mk1DTkxmcndhR3pDWGFQaDBvSUNlSWpMakNFUC9kb0UrTEtXWlhVSllZTytl?=
 =?utf-8?B?S2haWU9DbmRISGtsYi9qSkpUYWNKTFU3NTVWVVZyaHpjYlRIOUNKMFo4VUNT?=
 =?utf-8?B?b21YNC9IcUFBRFBpejh6VUVLdEswaWdEdHpGNytJMkM1QVV4M2NlSUQ4WlhD?=
 =?utf-8?B?MWF3ckNCTGRMbDlPaVlZc294QWJMVDdiWW9zK0ZCTDN2MjBmeStIQ3ZqS01S?=
 =?utf-8?B?cjFhZ1czZ2FldjVlVEJETlBIaVd1c1k4L0l1UWU0Z3p2ZlpFWW02eTYwNHFQ?=
 =?utf-8?B?SWFnRkZUNUlxSFhwUW5kM1BDQjh5ck9KYjM3N1BzYmZPeDRyVFZXZktVWlZJ?=
 =?utf-8?B?Q1QyUVhRVlRueXhHR0dpVWhITW5NMkZUR3pBdWFoY3FBSy9RUnI3UjdaR1Br?=
 =?utf-8?B?UTB0U0FORXdpZDJiWUtsUmxUeU9DMHFQT0tFV2xZSzJyRmJ6b2JaeFpSTnhN?=
 =?utf-8?B?ZFBvaVBLUmxEVG9paTZOV3Z3RzZqcjBOVnA4VGd3amN5dXJ6TEJhL1ZneDI5?=
 =?utf-8?B?ejJoU1dVRGR5bVFSMVh3dGV4NjkxV2Y4ZjhOQ2hRcjFsd3N0UjNmS2RlOE85?=
 =?utf-8?B?bFJFcWpRM2dUWlk2SDZoZHFURDRqMWRJWG5rN09WME1sMUpCRVFaWVBRVTIr?=
 =?utf-8?B?UjFMbmtxNGZSaThvNzBRWEova3dzS0Rpc3hRWXlHNnBlWFNjbGZ1bDM1R1ky?=
 =?utf-8?B?UDJxM0E4R0RHb3BxcnRsaGJQRkZKZXo3ZXFMeHlXTjFJZjdsMThocUtlSWJk?=
 =?utf-8?B?SkFnUWhSNHF0RFNSbXJEcjdTL1RLWFZxRmRVUlRzWlJvRzNPcjR2VXloNURT?=
 =?utf-8?B?QjlFaUZsRjFqSUZEM1dFSVpHMG9QK2Q1ZzdLVndJL04weUVRbllCVzF4NjFs?=
 =?utf-8?B?NDlWRDFMSENEdE5EWk5UYXE1N3dJek84NjVyeVJhWVZhL3VrTFNEMy9XWmFO?=
 =?utf-8?B?U0Vyd1Jubk92czFGWFhEbDEzUVhWeTJMOWduby80Tko2WnB6bEFmS1ZjWTlo?=
 =?utf-8?B?b3Z4NlNzV1FBZUhDN3Y4Vk5WYWpnZTFEelNqRXdPeUxQQXB3SGJVaEYrc21o?=
 =?utf-8?B?RHNlM09YSXFhbTlrWFd0S3l5TXpqbStxZjhUWFdUZXJNV1YvOWdqN1l3bGVW?=
 =?utf-8?B?TTRUVnNoV04rMjdNbzdjdmZOSWhvQ2g4ZXo1WG5TZUsrWUpMRU85L0xSR2o5?=
 =?utf-8?B?SEdOdGJPQUtDb1UveW1YNHVHZCtFSFhMTkFJb3hvQ3QweEdLU1BES01LOEhk?=
 =?utf-8?B?ZHlORkN6QmJJQjlHWmNrNWY0eWFvdHVpSERXOUYzdDlLZTEwUzZMaG80MkZx?=
 =?utf-8?B?TzEvaEJzQy8zWjJPMXNESGdMS3poSExxUHorQmk5WUlOTU0xSGhMcko3OVFC?=
 =?utf-8?B?UmlQQW5JS3hyM1Uxb1JZeHhsWkk4dUNzbVhXcU0vNnpuaUFUK09Ld200S0px?=
 =?utf-8?B?cGJ0NU9NV0t2OERDK1YwQjZSazI4Mmg4cWZlMFluNExpVUZNVnQyMHZhV0Rs?=
 =?utf-8?B?TWNqVDFoWnM0OUxSd0FDQ29VM1psL1I2RGdKbkoyUkhnOGV4TmFvMFpJZ2t4?=
 =?utf-8?B?ZzR6SzJ3R3pNcDZWbjhoWGx1REhxK1QxS3lLemZObkFwaTZtWDV5UWlMWkFq?=
 =?utf-8?Q?zji2QalxLx7QpGb3tdLsHBtoD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df606995-11fa-4aab-3f96-08ddbb0dfcd3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 15:18:10.9428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4OE5G2uRrytnjQgW5iJVJDPRJcpyxDnqUgiaJ9k0qYrRJ6U8Nph7mm+jGivI5qAmFN9jWxHRnt8kL969BJ5Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434


On 6/27/25 10:06, Jonathan Cameron wrote:
> On Tue, 24 Jun 2025 15:13:46 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation involves finding available DPA (device-physical-address)
>> capacity to map into HPA (host-physical-address) space.
>>
>> In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
>> that tries to allocate the DPA memory the driver requires to operate.The
>> memory requested should not be bigger than the max available HPA obtained
>> previously with cxl_get_hpa_freespace.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Hmm. I wouldn't trust this last guy not to have missed a few things.
> See below.
>

My mistake. The patch changed after applying Dan's suggestions, so I 
should have removed the tags.


>> +static struct cxl_endpoint_decoder *
>> +cxl_find_free_decoder(struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct device *dev;
>> +
>> +	scoped_guard(rwsem_read, &cxl_dpa_rwsem) {
>> +		dev = device_find_child(&endpoint->dev, NULL,
>> +					find_free_decoder);
>> +	}
>> +	if (dev)
>> +		return to_cxl_endpoint_decoder(dev);
>> +
>> +	return NULL;
> If this code isn't going to get modified later, could be simpler as
>
> 	guard(rwsem_read)(&cxl_dpa_rwsem) {
> 	dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
> 	if (!dev)
> 		return NULL
>
> 	return to_cxl_endpoint_decoder(dev);
> 		


Yes, it makes sense.


>> +}
>> +
>> +/**
>> + * cxl_request_dpa - search and reserve DPA given input constraints
>> + * @cxlmd: memdev with an endpoint port with available decoders
>> + * @mode: DPA operation mode (ram vs pmem)
>> + * @alloc: dpa size required
>> + *
>> + * Returns a pointer to a cxl_endpoint_decoder struct or an error
>> + *
>> + * Given that a region needs to allocate from limited HPA capacity it
>> + * may be the case that a device has more mappable DPA capacity than
>> + * available HPA. The expectation is that @alloc is a driver known
>> + * value based on the device capacity but it could not be available
>> + * due to HPA constraints.
>> + *
>> + * Returns a pinned cxl_decoder with at least @alloc bytes of capacity
>> + * reserved, or an error pointer. The caller is also expected to own the
>> + * lifetime of the memdev registration associated with the endpoint to
>> + * pin the decoder registered as well.
>> + */
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>> +					     enum cxl_partition_mode mode,
>> +					     resource_size_t alloc)
>> +{
>> +	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
>> +				cxl_find_free_decoder(cxlmd);
>> +	struct device *cxled_dev;
>> +	int rc;
>> +
>> +	if (!IS_ALIGNED(alloc, SZ_256M))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (!cxled) {
>> +		rc = -ENODEV;
>> +		goto err;
>> +	}
>> +
>> +	rc = cxl_dpa_set_part(cxled, mode);
>> +	if (rc)
>> +		goto err;
>> +
>> +	rc = cxl_dpa_alloc(cxled, alloc);
>> +	if (rc)
>> +		goto err;
>> +
>> +	return cxled;
> I was kind of expecting us to disable the put above wuth a return_ptr()
> here.  If there is a reason why not, add a comment as it is not obvious
> to me anyway!


It seems I did a mess applying Dan's suggestions. You are right here and 
the put not invoked.


>
>> +err:
>> +	put_device(cxled_dev);
> It's not been assigned.  I'm surprised if none of the standard tooling
> (sparse, smatch etc screamed about this one).
> For complex series like this it's worth running them on each patch just to
> avoid possible bot warnings later!


This is bad, of course. I did not see it, and I realize now Dan's 
changes make this harder to handle.

I'll fix it.

Thanks!



>
>> +	return ERR_PTR(rc);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
> __CXL_CXL_H__ */
>

