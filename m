Return-Path: <netdev+bounces-245338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44498CCBC18
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 13:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7943C3011ED0
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 12:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE34D2882A1;
	Thu, 18 Dec 2025 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Klv2Qn3H"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011048.outbound.protection.outlook.com [40.93.194.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2284230C37A;
	Thu, 18 Dec 2025 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060051; cv=fail; b=El4cKsQSZwgwunZbtCZ4A+0IQZk5sB3ViekOYaUkuKC/E46rlJ8Ce3GHq+9l/cJglJQCqqFa7oDM4vu/RNVY8TAHIrSnVz4IHscgswwtN0X1qHgiso9ika4emGRteI47JE97YuYAJSkRrdebuLWXBNr/wmjLdRCGgY+DhQLUVHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060051; c=relaxed/simple;
	bh=TGAiBSf0PzMK4eQ5HqjvYGh+44fM0OZ3vZLObk/Z/mM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fXpMA+gWCuUN+ddAKqwyjIJyZav9uT+Kk90BHPbzVfAMvfcf2+O5+YAd/Qf6/n3bzl4qSorMW2ShPhHFtfxElSsPA36v8FD5ZipBpR3VN7MeHUs1G6D5HpTcCRkNvqdlpSZCGiCbyiBXhxyNTT6Quw0nPi4UK4KTuNi7oZMb+7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Klv2Qn3H; arc=fail smtp.client-ip=40.93.194.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnfvOdbVGYbJhR670ODjWUA2mOUUI1s2ca+V8L6/JZX90FBfXry7Sz5LSYZLHGRdw+7GAHurAgUu8uogk3/EUpaO4L6WtzTF+iU1j2cne73UqUHKppTXUFXK8hAq2j4dbxXWd9Rzu6gQ29OcxScZiCnMmlZQWSOTp5lnNibBn7aQ/iNcdVN2un6C5LRHphR5jsGzfSylJYbkCVzNKmAOv5BCeAjVV+Yjkg2p2s7LLarmaEiqiu6RK2LbURNnEBoC6EBVvzkOM1sYjzTPYZivsrEo6fZ8wYnBe4kiMHAznk/w2UDouj/LFlUcLXhZp+Ylm+/Wj6rfALfDSC4GC+8F1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqhhtnYx+p+RatqDP+evQdSkLTc5I4doIVpRuV7QfmQ=;
 b=g92eHJwYRqKiko6pWh5MOWn5LI+MShDtejZOQsmYT2VBN1yzUYKIgUYwpoZb26rCWPWJmCH2tupzXk0r3W7z2z5dUlUNNPTJmvi3eVy7XBQItJJ57cmQkh0RNGXVa/kgqB4oBVFpS+aIVF3Psdt4ZfunR1CPenRdv7o39oEsj2XObpWPrmzkxXYw7tfcP8hy8dwe0BhhH8o53HAu0olzogLospFgAVSoAFwIeymku074B0gGRv3OamKeGB/PnuZuTqZmyzKZb4a2FGLzk/wlZVzYWY/BolO70puVKSvlVpkkUg6kB5hNCrhMrxdVLfH242wp5pqbjAdr7X+cPOP7Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqhhtnYx+p+RatqDP+evQdSkLTc5I4doIVpRuV7QfmQ=;
 b=Klv2Qn3H2q68RinxW2AsOJ8xeJvMS/aTVCgo6gJLe3f23ff+rTgCfmMTudIVcVkfbHtHCvUVEe9JgFjW920YnU2Wknbe3cWg379y6laGav6hTUk4cL9Ewx5LfGbD9qj+71rgVaKcJeAjdj7YWMefmkc20KfahdolWri8g3ElloU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 18 Dec
 2025 12:14:05 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 12:14:05 +0000
Message-ID: <7b570825-1441-408c-9d42-98d1cee11cdc@amd.com>
Date: Thu, 18 Dec 2025 12:14:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 14/25] sfc: obtain decoder and region if committed by
 firmware
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
 <20251205115248.772945-15-alejandro.lucero-palau@amd.com>
 <20251215135715.00001ee7@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251215135715.00001ee7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0633.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 792f3701-a3c1-480e-7574-08de3e2eefeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTRsb1o3UzZLdi9scHJMUHVZRk9EUnBKekszZnlYRVM0aVhtV1FzUTdGQjh2?=
 =?utf-8?B?UkxGQnFuTGczTkxRV0tZUXluT2p2UlE0VEJzSDM1OHJ2dUtUQlhUdVcvKzhI?=
 =?utf-8?B?bHZjRmM4SlAxSTJjTGJrM2RPUGpGKzVZYmgvSldTcEpHY0tBeUJ5a1FOQy94?=
 =?utf-8?B?Q3dvM1RZOWJzNEFLMitxMzlqaW5XSFd5SWRGaTNiZlRXMTI0SCsrYWMyQ0s4?=
 =?utf-8?B?QnlUU0hsU0ZCc09WakxQdytzNW5pTUtBSkNPVnBrbnovZVp4dC9WdjNzMGFa?=
 =?utf-8?B?VkZFRHE4eHdYdFZRNjliM3V0TmFuR3RDMFd2VitSUEJUb1JwZElkMlp2UlF1?=
 =?utf-8?B?MXdSVFR4dTM3c0VJVWtTZ2daeW5LWFBUY0wyUzV1Mkg5ZXZRb09qdHliWG1a?=
 =?utf-8?B?N1V3amNTa09uQTVTZHpjcUxxRSt4bWFZVy9Ra2tNNi9USCtwWENhSStaT2hz?=
 =?utf-8?B?cndNd1lsY01uYXBHd1QwbHk3NDF3ZzRvWkg3QU1TNE55YUhkYXJvRGdIcWtQ?=
 =?utf-8?B?d0R2Yms4RDZNOGwvRm9JcHFpOFdMTFFHdjNDNklVRnVhaDhrbHllZVB6cThK?=
 =?utf-8?B?UU1GVVlxYjE1NnNpMWVabnJ1Ui9uMC9QdUUwaXg4TTdLbUs4eUtGekZ5dUdQ?=
 =?utf-8?B?UmhmWXJVWWJsOFdETjdpVVVrS2RvNjZzeW81OVRhSDIyOVBzMmRNN1BKcitW?=
 =?utf-8?B?L2Y0RTFJK2h1ZVY0L3lHYlFqVlA1YnhiYlhudXJpUThZWjd2WnU5V0xjMGdF?=
 =?utf-8?B?MzR4TzRqbnJ4TUw0SnVReUdlT3RPbWNwUjNmU1JoWkJFOWJGY3cwSkQxcDhB?=
 =?utf-8?B?ZEI1bXlic0pyWWNLbTZiRGpSdkNWUVdRb09tOHJuU2NVWmorYXRxQlVUYjB6?=
 =?utf-8?B?M1FpUWlCeVhnUFhZNElEZmp0SWFONndmbEtwY3cvQklzQ2lObUJCWlBnbDlH?=
 =?utf-8?B?SHFQQUlWVGFiWVFKUWFKRWhUNlFzWHNWb2tKWlBKdzB3UXFMeWU0Vk9yQ1c0?=
 =?utf-8?B?ejFTTTI1anVMcUtoeXpSc0J0Zzl2dTN3L21IQzNJMTY1NEQyV1o2UElmUFRH?=
 =?utf-8?B?TVNxZEdQU1pXbS9WVzBSSWhycGlrRkJNYzE3aXBnSzdiRWI4MzB6R3lPUWJV?=
 =?utf-8?B?ZHVkZ2Q2R1RGbldsNi90T3FxZmZkaCszSk9FZXNPa0I5ZlFDNWd5Q3lUcTYx?=
 =?utf-8?B?eUk0UlM3MjdMbEc5WEJvc0dQNDgrWkhRWFg5RGxwR24xVElKOE1FK05RcmQz?=
 =?utf-8?B?clpUaGlBdVhVSk5KYUR5OCtsSHQyM0s0cWFWYndOS0s3ZXp1UmRzY0lOQXV0?=
 =?utf-8?B?UGxUSHJZVUd0R25mZHhMNjIvbG9sNXNMNndmbDdXdy9mK0xSRFRyVXV2eUlK?=
 =?utf-8?B?M1ptYmtoZC8raS9NRkpoWXluSkoyR09UeDNxQUwrUXlGOWl5dVVuc0VEVWJu?=
 =?utf-8?B?UHUxNlBjTi9vS2tJYzN5QTY5Qms5WVRJYS8yUzg0bGx0ZHN2N0IyWTNWOGVR?=
 =?utf-8?B?b0RtdEo5YnZTQmtENnRNUnlrb1BCUExDT0Q3dU9vdk1uTkNSV3htMnZaNW5Z?=
 =?utf-8?B?SDk0bForTVFERm9obzZqVUZtRmxXdXVSZXhrMHFiTzdEMDhCMldtQ3AxMWd1?=
 =?utf-8?B?TFlwTFFRTTUyTjNSMzRSclhVRFBnc1czTVNTS3kxU1p4VnJFWW9LNXpyeUZ6?=
 =?utf-8?B?R2dBSGtoTWpVNWh6V1hjOTNiVExWNUsrYmxtU1dza3VucGFYazhLZlBmNk5u?=
 =?utf-8?B?OEFDcHptT1l4dHYxT2VaYXozeG9WNldSaUYwd3ZFSE1HVnJwd3lJM2YrZ1FC?=
 =?utf-8?B?Q1N3aVdHZE81QkNYZVJUTlhvZ0QvTmZkM3FmSkFFd2lIVVpnemJqbFBlQnpk?=
 =?utf-8?B?dlBocTZDZVR0WjdCeHpHOE9Nc0xiQXpycXlPYWNMaWtBVWZSeHd2bFJsYzVj?=
 =?utf-8?Q?AfciTphW4fn8+QIfjvoqHQWJTHp//ph8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFJIWUpBTzd6ei85M1YraEprQkVsUlIyNHlZN3pEeEhhdTMrb0RiVzZvZ0Vw?=
 =?utf-8?B?YmV1bGluUU8yL2tLTmNiMXFKTlZ4bnY2SGpZMDJDdnFhZnc4MENWWnhRL0RT?=
 =?utf-8?B?L0ZlTnZtODdpWlREM3R0QnZzVldGOFVnMDY2alFHZ2s4VUZuT0pNZTVBOFQy?=
 =?utf-8?B?Vk9Ma2ltcExWWHBkd1hlODFiM0taK0FXeWJYQkRMNU5VbWVsVEROYmFaa0l1?=
 =?utf-8?B?dWpjMXVhU0JFbXNjaTVSVEZoNGdCb3ZNZlJoNzZNQ2djUlFYdVZEcVRZMHE3?=
 =?utf-8?B?TytxcXR6MjhUancwOGN2OUZXL2FvM21scFNER3NCMFVPamtpcEozbm1WTVNa?=
 =?utf-8?B?TTdENFpDWVZyWUlocG1Lb0RlK0R4QkZFdnZoaUY3Z0Rsa2pLalhBeGlXMHo5?=
 =?utf-8?B?RDRncTlINE5Tdnp6b3pIZFZERFhlT0MvWExNeXQvWW9JU0RsYmJUNmx4Zk9X?=
 =?utf-8?B?ZUxaMy9nWWdqUzVWb3BHMkVBckk1aHo0ZHZmeGFsSjZXeTIyQWcwbXNoZXhr?=
 =?utf-8?B?ZWNORFBmOHp1WmFHR0tXOUtsYWxDekEwVGlOWGxqMFlyQ00zUzNoRHRMalJm?=
 =?utf-8?B?YlBNK3RDaGFXaTkvU3NWMGlUcEJUN3o1SVhOc25KQytCNGRLRitka2gwUWJP?=
 =?utf-8?B?dzFJQUVLbzhKWWIyYXBvVEVXVEVKMXphcy93L0lVdU9nRm45ZFpTcXZFUXV6?=
 =?utf-8?B?RmVyS2Q3VWh1TWNOQWNCcnZ1T0pmS3dGSzljM3RZa0FWeWlMQVRQc3VRRjdn?=
 =?utf-8?B?bHpXSWdUOGhyRFFGSXVGaE5zVjd0dUpscitSRStkTmtNdEwwMXJDUXUvRWNZ?=
 =?utf-8?B?UWprejBCbUJDd3QvQzhjb09EdWk4cjh4cy9YNks0OTkzYWpzTGZWVTlSWUFO?=
 =?utf-8?B?WUZ0TlYxR2tuKzRGRHJXSjY2ek54bHhiWlBGeFR6cmsvL0hCRTY1SDJYWVVS?=
 =?utf-8?B?R0JjcXVNK25GU0RMYkRXZ0t2UXhmTG5Kbkt0aXVUclVUZ1p1WFZEZUFycXUy?=
 =?utf-8?B?NWJ3Y3h3cWZrVHNzRURKOVhxSStseVovSmVPM2pXeVI3eEZwVFlrTGh3Z0hs?=
 =?utf-8?B?UTdVN0g1bTVObFgzVWFCcnVlM1VCMTdRek5ONDdjaVFXNUVFdHduWE5ocy9W?=
 =?utf-8?B?cjduT3NyS1NhVlh4ZTZIeXpudERkVGdGK0hlNG5RNGNSd0pyb3FpRWJEaU1D?=
 =?utf-8?B?bzhMdkFHbFZQdFJQQmxiY0hTTlNLVUk3eXdnN0Q0eHlUR0FjWFZlSnBHcnh6?=
 =?utf-8?B?djRMVkdNcUJpTnhBNHRZN1V0UTN2c216V1ltb3U2bUtmdVlpZEdwT0pxWitD?=
 =?utf-8?B?V245NWZsb2FiQXpGd2R6WTJUVUtVTVBiU1EzVzhYNTM3MUhPZ2J0aHRDdm9w?=
 =?utf-8?B?VlBpV1dkaWo3SmZ4OTVYcUhUUVdBZUVUdnVmY1ozSVI5NkNZZ1U1ekdzN2Ir?=
 =?utf-8?B?c3AwOTZpWHplUmFNNDVqUXFLZThaU1llWlcvV2JsMTZORVpSTUZqTElFV083?=
 =?utf-8?B?eGNXWmNqUnpnRmdXUXg5TE1mb05ZMUlMWXhtK3A4ZGYzYUdWZU5GRUJ3dzZr?=
 =?utf-8?B?dnZ4QUNpVE1RaURKVDJZcFAyL3c5eFFlbHVDNkpJVStFcE12b1M1UTFhdkw1?=
 =?utf-8?B?bCt2QUt6OFJ5bnZlRFN0a05PeGZYM3RvYVovVTQzQzRhWk9tdm4xS3ZXc1R4?=
 =?utf-8?B?dXdmVkd3U3h2azdDYlFxMnZsbDhlUFFHTURoaWRQN3I1VnZycXpSSHQ0MHhq?=
 =?utf-8?B?SUVCbXpkQWhudXJGV3ZKdUNRSXF1TURZM3FlamE5b0gvSWdleUFuUEExckNp?=
 =?utf-8?B?TU9qQ2MwaUNOWXdweTAyUHh5WlRydzcxY1l2OXZVT25BNjE2QUN1em9rT3RW?=
 =?utf-8?B?NnNpakxaRGdGWlBmZ2pqSVVsaEhERURJZ1FEdlV5Z2lQSVVNS281YVB0WlRh?=
 =?utf-8?B?djBMVVFLNEg5bmE0UlJYVGNqYkhGVEhhSy9Ta3RoSjB2YmhyMDl4akRORWlu?=
 =?utf-8?B?WEhleGRhWnhXS0ttNUJDMzlsL2dvMVQ0QUwyVWh1UmpMcVNMeWV3YWloQ1BC?=
 =?utf-8?B?akJhT25iMlI5Ry9hRWFCZWpqTHZXZzB5Q0ZQRGxSQzVnMjcrVVFzMGl3WUUz?=
 =?utf-8?Q?nIuoWErqNo+xCIZ5ahOwlHB5U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792f3701-a3c1-480e-7574-08de3e2eefeb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 12:14:05.0557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzbwkbyhZYcPzdu6gR4G71lCu+gN+k3X7U0fT36ZobNHxz0rPpEUY7iabd1Z11IJxT3obggdiieokI2bYmXwtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971


On 12/15/25 13:57, Jonathan Cameron wrote:
> On Fri, 5 Dec 2025 11:52:37 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Check if device HDM is already committed during firmware/BIOS
>> initialization.
>>
>> A CXL region should exist if so after memdev allocation/initialization.
>> Get HPA from region and map it.
> I'm confused.  If this only occurs if there is a committed decoder,
> why is the exist cleanup unconditional?


Not sure I follow, but the cleanup is unconditional because it is based 
on sfc cxl initialization being successful. If not probe_data->cxl 
nothing to do.



> Looks like you add logic around this in patch 16. I think that should be
> back here for ease of reading even if for some reason this isn't broken.


I do not think so. The unwinding is different if the HDM were committed 
than if the driver did commit them (indirectly through the type2 API). 
This patch only covers the first case. The other patch adds the second 
case and the a conditional cleanup type. And in any case the cleanup 
depends on the probe_data->cxl state.


> Jonathan
>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index f6eda93e67e2..ad1f49e76179 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -19,6 +19,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	struct efx_nic *efx = &probe_data->efx;
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>>   	struct efx_cxl *cxl;
>> +	struct range range;
>>   	u16 dvsec;
>>   	int rc;
>>   
>> @@ -90,6 +91,26 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		return PTR_ERR(cxl->cxlmd);
>>   	}
>>   
>> +	cxl->cxled = cxl_get_committed_decoder(cxl->cxlmd, &cxl->efx_region);
>> +	if (cxl->cxled) {
>> +		if (!cxl->efx_region) {
>> +			pci_err(pci_dev, "CXL found committed decoder without a region");
>> +			return -ENODEV;
>> +		}
>> +		rc = cxl_get_region_range(cxl->efx_region, &range);
>> +		if (rc) {
>> +			pci_err(pci_dev,
>> +				"CXL getting regions params from a committed decoder failed");
>> +			return rc;
>> +		}
>> +
>> +		cxl->ctpio_cxl = ioremap(range.start, range.end - range.start + 1);
>> +		if (!cxl->ctpio_cxl) {
>> +			pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
>> +			return -ENOMEM;
>> +		}
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>> @@ -97,6 +118,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>> +	if (!probe_data->cxl)
>> +		return;
>> +
>> +	iounmap(probe_data->cxl->ctpio_cxl);
>> +	cxl_decoder_detach(NULL, probe_data->cxl->cxled, 0, DETACH_INVALIDATE);
>> +	unregister_region(probe_data->cxl->efx_region);
>>   }
>>   
>>   MODULE_IMPORT_NS("CXL");

