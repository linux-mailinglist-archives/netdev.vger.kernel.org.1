Return-Path: <netdev+bounces-118942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB94C953983
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 19:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88761C21979
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4DF48CDD;
	Thu, 15 Aug 2024 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qGu7eOy9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6873EA76
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723744512; cv=fail; b=eraEQWjm8YdI94Ju2zmibvf7wl+0jMdsxbYTbjPOAMP0a6lARbeA8q7lHY8z6+tjf6KOXqk361o2kbDTyNXARxSBRilZfsvC/i4TC6de2SDh91kvkexj6gxjWKxJgSbcLU/4k3QhKy4Hv83G3YbXnSTK+o54gh764ALO9yaHJFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723744512; c=relaxed/simple;
	bh=Yed2dJmkvh/bSegLjVw4ynyFxqobLbUXlK1vP9KdZg0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tizz7U7kieRLpOYsJSdSk4HeMviWyBk+0jVtnyNNFCeLQz2FYFq0smhVy/I4UgTHfvo7BSxiPUriPSJYNS6YPWgvyWkpHwMIr36FeDQIOXFGIHJ93mtZSl9JSAyRn4z6x2Zo7lwKssaZmvQAm0jhaJHcjvbXFkzxCpOsL4Dqq4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qGu7eOy9; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9SRICQFkXlExu8f5tldKTS0bwgR9LzXlDds+mhaN1duYDTdt4PsE7AMUJknBLmOdwDY2s8+WY5qKxy6KmN5Bl+ID5qWms/an3GPB7v07JttrSiRUDmjDTH/rO5Y/bmc7XD8+9Ww13DT/+vGVnVXspEyGYBgJaSbNtfefnzA7y0ti0pNV8RDOI5XMUvJoaDySIx66rp21shEC4G3UkXEjr6fQldOhlHb3NVcQZrD3BGByKKVf9cRkVDmK0qji/KG1En6/2x9HKvna0SHEr/C86T6qSjpnLlt3EEHP1wFBXz4D+tUfLL7Etcnxwa+IAhTu1nCKP7KaSPTjqlLlDa0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGbP/7yPdd0pnYx5VNS4fiG2wGtsB3wLGiV+/EB9i8k=;
 b=x/8hUz5FUoMFgiqzIZyVurD2VlUdtAX+g86s/dSOBe65T4fdbcKdC8hPkQzy/1FrB4b/cXV1BuWcj0Afwum7iMk1hAKjYfKqffE2aibgzIG3/i/x4asiUjdV1abg5MKVVhoh3dG2qgnrvuLr9j2zTpazZbaJtSfd/OYShHKG910ZKd3Q+ntM/C+dBu/W7Un36nmSa/ozLV9alOJbqfqWzQHmZC2iRa2QLk029GA8bOOlZIWYSzduJmyACIyxRG2LZKpezy0yvwrb3o72LM8MhsQhj1S3ciWV+ID6IWFsGAgcalQ6OMqJe8dj8MucrjkjERZPGnPbMDWVTu7XeQ6YZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGbP/7yPdd0pnYx5VNS4fiG2wGtsB3wLGiV+/EB9i8k=;
 b=qGu7eOy99slf0po3rN63DIs/pjMFKza3YLIzNR+/7tbuoxWJcLhH7gK34OaWZd4H/JUNubu3RgcWQW6NvCx9L6Wh9msd5SPEE6P5/B95QV8O1FoblEeOud+S1DCwMNg2NlJFeHVlXXYYBccQEC2cGriorVKg5bhTtUJHhY3m3vA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by SJ1PR12MB6195.namprd12.prod.outlook.com (2603:10b6:a03:457::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Thu, 15 Aug
 2024 17:55:06 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%6]) with mapi id 15.20.7875.018; Thu, 15 Aug 2024
 17:55:06 +0000
Message-ID: <deafd990-8186-4fc3-8ec5-46a1e9ad7501@amd.com>
Date: Thu, 15 Aug 2024 10:55:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bnx2x: Set ivi->vlan field as an integer
To: Simon Horman <horms@kernel.org>, Sudarsana Kalluru
 <skalluru@marvell.com>, Manish Chopra <manishc@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20240815-bnx2x-int-vlan-v1-1-5940b76e37ad@kernel.org>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240815-bnx2x-int-vlan-v1-1-5940b76e37ad@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::24) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|SJ1PR12MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 3272b023-2662-409d-f54a-08dcbd536578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azFjWGQ3UG1ZLzNBOVU2YjRwb3JubUMvMytyTi9uN2JpWENCU1MwaENOREtz?=
 =?utf-8?B?bWdzUHFlamwvS2lIelYzK0pUM3Q3dExvQi9MZTJSUnh2a3VZbUdxWTRVc1ZX?=
 =?utf-8?B?NG5RaFgzNTBCK0o5QytyVkU0OHFFdnYvNTFkNTlmd2N0S2svdEw2OWRQcmpW?=
 =?utf-8?B?N29ETGhBOFpEOXg3cmhrV29CSTZDN01sNk1BT1N0U0d2bGNHZ3JWcS80c2Qx?=
 =?utf-8?B?UGpSVVZrcEQvT2tiQjJaYmN3Z0JzemxaL09GY2p0NzJUMEliTHpFbkoxRU9x?=
 =?utf-8?B?MzR0TW5kbytiRjJrQkhOVlV0bWJNTWhhRHRzam9LQm5YL0hmenJuVkRSK29i?=
 =?utf-8?B?eEU2bStyRko2Z3Q3Nm83OGNEdFNxMExwbVFQK2M5Q1ZxTkxUNmR1NWp3MWtK?=
 =?utf-8?B?WGNyQkYraHNDbkNSdVJYMmFCQmROSUt6YVZORjVpNE4xdzZ5bU5iR05zOG9S?=
 =?utf-8?B?WWxKZklhckdLQStROGxIbWxKQ2dFWmlWTFhYTmhUTVpBTG9zbllCVGRiTFA0?=
 =?utf-8?B?UGh6bHh0U1Znd0Y1R1hRZlplMWNxb1l3Vm9CNWVOeFFkd3RSV3FkWmhkTXdE?=
 =?utf-8?B?dUVMQmdtckRJZXEzSitGVStqbVBidS8xYzRmUXhLUzZWaWJPRzNScGtwdjBw?=
 =?utf-8?B?TFpXWVNEYjBKWU0ydXZiVVdkMDBCVWFxQzBCam5tdm1SdkVOakNzNUxrMktq?=
 =?utf-8?B?UkM0Sm1ncllHZEQwT21ZUkJ1R3VkSUJNZmlEK3V6ZE5GY3dvMTVpeGlGdTNT?=
 =?utf-8?B?N2JQemFteXVydi81c2VGVDJEWEs2dGp4SGZ0L0E4SWNvZ0VFdi9sRDRyL3dK?=
 =?utf-8?B?UU4yTU1tZkFVRGJZckxZZnIyQ1BlSVVKK0dSU3hnT1YzSlRaWWprdzhPOVd0?=
 =?utf-8?B?ZWpzbGNkMzlBMG5LbEJ4a3hsYnlhMm1rcU8wc0xwbmpSTGpqUUdOK1VqR1dX?=
 =?utf-8?B?WnNWY1lBWmhjMGdpS0lON3U5L1dnM2FKTDdoM20wVm83UlFWKzZObVNGTGRs?=
 =?utf-8?B?cE1hckd6MkJ0TkRWby84emE0UTFJa0NrTkZ5anRZeEgyOGFabHY2V09LbzZ0?=
 =?utf-8?B?bUdKQS9iYnFLbEpwdVppK1l2NHFKSkhFQlJvWS9mcmNyWjF2QzB4NWhBQ2dh?=
 =?utf-8?B?VWEwY3l6V1k0SytBQzZwQU1MWWUzdjF2c3AwWHJGQ3M1TGNCSnR3OGpBbGxX?=
 =?utf-8?B?cXg0RGliYit3UGxOL2ErSzFmUFJuN2poVWErSStOc1N1YVQweWM0ZGl6Mnht?=
 =?utf-8?B?UVJhRGF1L0lwcHBJSEZhNVpQT2V2eUpuckNDSVBmeDJzb2RhbXRaZlJXbGJH?=
 =?utf-8?B?NkZWblA0b2x1a1hUaDdRZ29XUFlPNUE1eWdRbUpsNEtNVENMc0NENGpDTXFw?=
 =?utf-8?B?QmhuUGNlUDdiWTRLQlNsWjRUSVJQdXBzNThMZGRBcTJxQ2Zsc3NKaVlGamN1?=
 =?utf-8?B?WUVjOUFhVTlqMDY3RzVWb2N2cE9ESDVwTmhmNHVJdUpZSVVtdENlN3dCN0x2?=
 =?utf-8?B?eVZLcGZmSHMyR0JqVkdSbERmcGlsMmdOK2RXRkYyU1NCYmZpd01IK0hKaHUz?=
 =?utf-8?B?WnpnOWZCUkRDVGYxMWd5N1JRbkR3U05SMER2T1pFelJrZ2xPR1hESGFqakxm?=
 =?utf-8?B?SHo0bW4vSGxoRHZPNWMrSjRWWjlENlJtdHpSeDBQVW1GYkkwOHowMFo0M1RF?=
 =?utf-8?B?YkhkWGRMcHhXejRBS0hWM3FLTXR4OUg0T1d1NU1jejVSVWFHZkQ4Q29UTFJp?=
 =?utf-8?B?QitHT2o3YTVTM05lK2ZyMnFKVWEzMTU2Zi9MN3dqRk0yUjBZRTVzbU9mMk1w?=
 =?utf-8?B?K3NOYXRCK2lHbHMwMjQ1QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWxoVGZjaURMTzd6aVNhUExwVW5VUkdXT3liYmo4VkJTZWJJMGRqcDBvWTE3?=
 =?utf-8?B?dzhkZm9DSlp6Tm9UMGRzbEhFaWdiditxaFRYOTFkS0lDL1ZkZ3BhT0RLMm9j?=
 =?utf-8?B?dG5IZkd3NUtrT1JwamZmZmhMajJQT1RLSVByN21FbUxiUVVobmp1VHpzb2Q4?=
 =?utf-8?B?bE1GSDROR1Bla3o2MEFwbkNTTGx6NVZSL2FQTzZQbjRKMytqejZUeG13KzRv?=
 =?utf-8?B?MW5MdjQ2cEhGeFl1TkJXZ2Y2SjkrT29saUNLM0NjdlNjOXU0RXYwalFKZDFJ?=
 =?utf-8?B?T3hrZVZGa2svaWJ2OG5ocmdZaTNwcEU1UWFxbThpa0VmNXg0Nlg3YmhhaHVW?=
 =?utf-8?B?UWlVOHlFKzRSQnhGdXQrazlYaEc5RWkxanllWXAvQll1c09NZlllcC9NdVZJ?=
 =?utf-8?B?L2ttT0Mwb1lWSUdTRnBnL0lzTGswYTkyNHQ4bFJWQjJHaFp5NmhGMGdwM1RP?=
 =?utf-8?B?US9id2UzQUtnREt4MzRibEhnVmxxUUQvMEhqMHF1dDhlR2JrVFl4Nk1qVU1w?=
 =?utf-8?B?ZGxRVWpmSys2MjBoMlhFc0ZRT0Z6cHJtd3R6alQ2RDE0UGE5Z01xTnNLK0Np?=
 =?utf-8?B?d1RVbU9JMTJBc0VZT3BZRDBlVjVUT0ZtMW5tZ0YxdGx4VVkwa3l4ZkZqY2VB?=
 =?utf-8?B?K1lkcHExOUZiL0txdVBwZDRLa1hzbnFsQmEzVlJpUnllbTNNYVlhNUxVdmtI?=
 =?utf-8?B?WndQMGNYSzFTNG4wUG5JYkZ6aTd2aEN6b2tmRXNkQ3A3dVg5L2lSVi9JTXdZ?=
 =?utf-8?B?UTljVU5XNHBtUkRSY0t2WjgzMEx4ZDk2R1dSMWZWcFFkNEVjdm4xNXJNUW1D?=
 =?utf-8?B?UWFxZUZJYTJDWXhsSnJZTHQ2N1lqMk5MVHhDeDdGOGoxeWdEK0kyNmZQR2Zo?=
 =?utf-8?B?Ly9zUXkzajVlMFRFdXFPYk9WSk1uZklGV1dUc1paMmllMjR0aTNiZFB4RXJD?=
 =?utf-8?B?a3pIekp4allUQ0xod29kVkdHaEErVFh5Ym1HRE9GYlhPT1lHMTl2b3lZK0hS?=
 =?utf-8?B?MlYrNGpVbm9mczg5Tmhsb1EvNWtGR0U4SUNlT3VGUGdwMFg0dEpucTFGU25R?=
 =?utf-8?B?MTcrU3BkMHZ1MDc4cGp2Ny9wNUpJdlBqbTBTbU1YY0FOaS9GSVJJaUZVN091?=
 =?utf-8?B?UlFYTlJoL0VMTnZaeElRZ3VIMmlLMlB6NkNIQ0hyYjhuQVNOc2kwbmVZRGxZ?=
 =?utf-8?B?ZlBFZzdENGdrT2R5SEFnRVdQT3l6cXZUVmtlZEZ4bXlETE1PRVJWbGxuWG9O?=
 =?utf-8?B?bmNnOVVYZmlVUVphemEza3lWRVNTWklTc3FwUnB0OFd0dUZqY0N0UW54UTA4?=
 =?utf-8?B?dGt5YkRXT1dzbFVPUWhwekFCT0ZEbWQrbC9jYWJ2dTRFcFM0K2Y1RlpXMmlV?=
 =?utf-8?B?YjUrcjRXREk3UzhrMVFkNmdDQ25RNGhxaTFuVVdBSXZiSDFaOWt0a2JnZEhi?=
 =?utf-8?B?R09sL29vLzk1ZFBZb1NyVUgrWE9SQWcrRGIxU3lPUjhWaEFKM212dlRWNThs?=
 =?utf-8?B?TDR5OWtkREgrNG5ySVBDK0x1TVZ3WlJGVlFnRlp0VklEOHcvajJOUkZLb0lL?=
 =?utf-8?B?NW0zUzBoc0ExaU9qcDN3ZGVxUUJuY25jYUJKTERpYlZIOGg2Z2ZObVlsWGs4?=
 =?utf-8?B?bmF0RFhLV05IL3oyeFZFOEU1WnE3Z05oQlEzQ1VqVm90WTRrQUk5bmlFdmFw?=
 =?utf-8?B?TEd6b3JxbjVRYjJsWjg5ZGJuR2UzdTZnejJPQmVYK2dzOTQrZGdwZnF0d094?=
 =?utf-8?B?cmVFeXYvVFRDRWtVYjNITldqOWVsRVhmYk0zWHlVQmlLWkF1MWdHT0w0LzMv?=
 =?utf-8?B?dVZQZmFSczRxUC85b2FDZUVxMWtKZGdoTnJpNDBiUndtUlpjc1JrME1vMm1W?=
 =?utf-8?B?TkwwWU1EQkVQVEJFRElENDF0c00ySjZibi95TzFJaklLM1paeklzUW5pR0Yz?=
 =?utf-8?B?bzFhNWlyOENJR0VIMXc4aUIxSkUxNjZJVHo0T3FsSDdJNEJyZDZlN2dRdzlj?=
 =?utf-8?B?UGNsUURjcTBpeGI1akFkTk1OZHFIV2NyNk5ZMDdaRUlZTFhRSnR1NHJGOEhG?=
 =?utf-8?B?c21rVE9VR1RJYlFmTjAxUGR1b2Q1MlU2TGhnWVBHNHNyeDJ1T0JzVEJmQkRH?=
 =?utf-8?Q?7XjTead3pKFHPoTYSlAgY7y2G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3272b023-2662-409d-f54a-08dcbd536578
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 17:55:06.3559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARBd2u4XscuvHdozfW5IuJ4i+elsAemsIER98XlZ+Fp8xEI/gzLif7gwLo106UyuaBxOFWLAH9OalTpg67gvJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195



On 8/15/2024 8:27 AM, Simon Horman wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> In bnx2x_get_vf_config():
> * The vlan field of ivi is a 32-bit integer, it is used to store a vlan ID.
> * The vlan field of bulletin is a 16-bit integer, it is also used to store
>    a vlan ID.
> 
> In the current code, ivi->vlan is set using memset. But in the case of
> setting it to the value of bulletin->vlan, this involves reading
> 32 bits from a 16bit source. This is likely safe, as the following
> 6 bytes are padding in the same structure, but none the less, it seems
> undesirable.
> 
> However, it is entirely unclear to me how this scheme works on
> big-endian systems.
> 
> Resolve this by simply assigning integer values to ivi->vlan.
> 
> Flagged by W=1 builds.
> f.e. gcc-14 reports:
> 
> In function 'fortify_memcpy_chk',
>      inlined from 'bnx2x_get_vf_config' at .../bnx2x_sriov.c:2655:4:
> .../fortify-string.h:580:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
>    580 |                         __read_overflow2_field(q_size_field, size);
>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>   drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
> index 77d4cb4ad782..12198fc3ab22 100644
> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
> @@ -2652,10 +2652,10 @@ int bnx2x_get_vf_config(struct net_device *dev, int vfidx,
>                  /* vlan */
>                  if (bulletin->valid_bitmap & (1 << VLAN_VALID))
>                          /* vlan configured by ndo so its in bulletin board */
> -                       memcpy(&ivi->vlan, &bulletin->vlan, VLAN_HLEN);
> +                       ivi->vlan = bulletin->vlan;
>                  else
>                          /* function has not been loaded yet. Show vlans as 0s */
> -                       memset(&ivi->vlan, 0, VLAN_HLEN);
> +                       ivi->vlan = 0;

Makes sense to me.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>

> 
>                  mutex_unlock(&bp->vfdb->bulletin_mutex);
>          }
> 
> 

