Return-Path: <netdev+bounces-271287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL87OZL1wmkEngQAu9opvQ
	(envelope-from <netdev+bounces-271287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:35:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A99A31C5FF
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6986D3013D73
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91D53537C7;
	Tue, 24 Mar 2026 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="no+5ljhy"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3088E35295C
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384410; cv=fail; b=jIxgOZfOgJf66CRviGa2/EvaqoSCcw9AdHB5mrlsou83u5L812XdsmcEh1HtINRUzXAMeHmgp9wc1K0dKSOsnC1WZMtvZMQL3Pi79h70GZytdOzRFhBI0i/ZvJqf0vFK+CNYtYkrz9HmObBVDsZNzHecSikL/HUqpwOTIfG3xGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384410; c=relaxed/simple;
	bh=WROM26b+1Xs3xSaMp26gZUvjhWtEXFLEeqpzpSyZT3c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bpQc+3jqVGy5Y0syKttBwEgAAYelgpGu/w4nVjEwLQ67d/qzMlyw1E5v8nw8bqfYtDMO6lSnUUgVakQbJ+Teha0kFqsQzv/aeujANtbEAEyOUMP+g27ulkzgxLVwph/sDIKHtc3Mib05PXlQflgaB0LyRrzL5jTYKMTYF5Y3FQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=no+5ljhy; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1TZoqaIo1LeUBqbGX3AXwleJrYmu68lp+cFqYHhba8q8Yj4rmH47UwW4QTnTNVzK88wXmL20qTeVSDv+cYAHXuYw/2AnlrX9VE+Lrq+o7JebFcn+vC1eF/tpo2AO6hSyo45P5uyygo/0PIHTMPT1oaTzRpW8LrqSWlka80SdKSEXcDXIhnC2YiqqT0MmB7AR/+Zm/eEHAIXKQLYHCyJZNWwPW0webI9/hTV1hSXRg+873vK2ihs9tZ52TI6nt92jMKcMt3aNx0y27Cf8/3dfbYrcWCVtVadGl+GIqvalPbGyoeAncr4rCpw3ovIf0iHvTVTUhmKLYfsvNkOiV3Ydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hEG1jcVjLIRfPunVU56zho0DOp+FkSZIgnkxNKvCJY=;
 b=y6icewuQB0HtLvCwpM7nVaWkiS97jIs0OF8vSanpu+89p33cBpOkzrWpoC9z2emeXZZegquLBrNq1BNBesdUd5KzeqU4QSXp4D6jqfK/g9V6aRN09bBRDw2ApelPne9RHO8g/sh745TgDK8HPu6Vp88lOpmZHc6dQ4K1KzM65WSOEnAWkL9XdSejEqg+8lh6usQhbBQgMaUqpafPjAiYEWzl1jTKANI/bHX6I0d9YmLHGjVPgehbEnLqe+JZN1vOtQTJza1hFFvLDXgxV2zUfKnYhl3dQ6hv1Qgc8ZdYs5aHATcXgnpMyEH1Nve2RXHKwL6Bjinu9/RpPpkT4KLHww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hEG1jcVjLIRfPunVU56zho0DOp+FkSZIgnkxNKvCJY=;
 b=no+5ljhyOwpyjINQlPVcwWrg1lJjkT42+60tep2nipMIfiBjb6t4WDeF8yK9lFgCAZXHH1iFONVl6Oty3grsXAxr2Tuhs+6UyXZFBAPzLO8I+ZnVDVE7oFwSCXZ3L8ddGcEBzO5R/V5ZOOYdwnU9ncPXJyopWklt+MiPuWjS1fQeSP8A7owpchVgJAhSsM3IZOZWDjau7bPWuTyj1ZaB9WsYPsn9M4IzBHve6DlMffFli9Q5gAoCq9maFWE9+EFwhQdhrRNdgogwUIKxW72c/Xcz2jyj3B3Q+J7ed6pZyfb5YTlGbcKt4NJe+SNW/qcYxA+d33iCH9qjN5KHHtBZFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DS4PR12MB9745.namprd12.prod.outlook.com (2603:10b6:8:2a9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Tue, 24 Mar 2026 20:33:22 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 20:33:22 +0000
Message-ID: <acac2617-367c-41f8-ac98-16c721ca7112@nvidia.com>
Date: Tue, 24 Mar 2026 22:33:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/6] net/mlx5e: add TLS 1.3 hardware offload support
To: Rishikesh Jethwani <rjethwani@purestorage.com>, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
 sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org
References: <20260320235706.636531-1-rjethwani@purestorage.com>
 <20260320235706.636531-3-rjethwani@purestorage.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260320235706.636531-3-rjethwani@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::10) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DS4PR12MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8e234a-5935-4f7f-ca90-08de89e4976e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JrXEL51KgqEAaDMX42+0JArhjSFaRSszaFOPEv+A4YdWyoY+er1IxzTUNf5dkDszW2y1sfvMrjZFzgFa4bjB0KWlaU2Y9jfF/oxnfYfUEw0AFqtG8vSvzCLpgAaVhuxNjwkbHuXhftaNFqRRJ+zkYIirLGk0lwH3VhTGMjqLJTTT2vABp7KSWtcHfa2CPo6G81k3F1dutrfkRHJMmcjjEcysKujIvWVSTeOlU0HiV3/9XXp4t4NuWCIu2gIHIiKiIVIkh5ueC97ot02SCI5bAVbro4BzY6Ms4DcgPG6WfWBCEklL2fuzctHTyLASkcQekBAHe2SWH1UZwwybyNxHfUGYAnvakfkuarwKjmBxVoNMpU57aqG3semx3jMIuSdCzIS/ihCYViFqnubZFn70j2TBUTg26HJZAbSrf0NtzYQIHL+W7ZsiVDdQD+dTcptU7k7NcDHz1+k+A4cB1hRFpJouxbR02wqVAA4eaUkvFBHhZjkDVLHyIjB/XUiNi96Fi3o618IPkOnE/6mCUpuKeCr1sZ7ZfIREKDgPV9fY2v3trPxjywYN4j9MKiC+o0JEpYJ7tBxuRpdLFzpmNEvAXVna9XahucZIXUnebMfVBZolgSJJNFzLWWfie/wtxUkrrkwOId/tHFD7iHN443ZryFFkp53EJGGO+S0NOcj7/rxXHEILstXNHGf5YyWu5h/d2+ZM51JVVMzWQf9QwbhWAJRCokmNFpExr5o3C3efp/A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVpyUzNiQmE3MzJud3NacUVBOXpVU0loRTk3MFl4NlVEK1pRQ09YbnVYNGNz?=
 =?utf-8?B?NUFBQlR5NGZ6RjlKWkpHdTNjMHZhR0FXRnptSlcweVpNV1BhT2tnc01JeEtZ?=
 =?utf-8?B?Q0MwTkY2bUNSMlAzbmZkQ1JDdkNoeE5UeFBSMGNtSzNJeHlvcFdUMnVtaUtY?=
 =?utf-8?B?US94NVU2NHZMckFjb2J1NHlYWnp6djhZbE5LMDVCdWU5WVlzckZmUVJ5ZU1k?=
 =?utf-8?B?Z25jUU1NZWZwQTk2RXU3blFDSjczSkdSMFpTcUVGM3UzMG5BblhjVVMvVXhC?=
 =?utf-8?B?Z1VVYXYyOUpSNkxmNDdvZnpNa2ZVOERqV3dzYzhkeEJxc21TZUh2blorUStk?=
 =?utf-8?B?V0NtemJNOXY3Si84V0tFN3NwQXRURFk1NUI4OVd2bkRieGZxYTNSdy9sRVpS?=
 =?utf-8?B?TkJFNHNRWndsZ1FkMEJqb1JzNmFHQjdLZFhSYzdjTFNVL0p1L25DRWRFY2hp?=
 =?utf-8?B?ZFk3WllUWkZMSTJEVUhETjdBM0VHS3dVaGtsQjJ0VmJtYmgwVTBzY3B1YVpC?=
 =?utf-8?B?NzBKZ21VMGtnTUtvMFJOV05yS1BQcDRZNUd1VERreFJ3R2xpY045bzBmNmxa?=
 =?utf-8?B?eU5OL3hYaXVzVEQxa1R5STBOK0w4bmpWa0Zod2JKajhTVzgyMjBlb1BKSERH?=
 =?utf-8?B?UzFpK3NWRWJWV2kxUEtLN1Z2VGFWTHh3T3NOZUlxZDFqZWcybnVIbU5qVlRt?=
 =?utf-8?B?aVovNi9GbHFEdDZSTkZQS3luN1NMU3VLa0VLUUNRc2tndWR5dmg4aHVEb0k4?=
 =?utf-8?B?alNXQjllRHlnWWZ5WDhtV3BPN0JXRlNqWEZPaGRwd01wcHNOajE1RzVxOFY4?=
 =?utf-8?B?OXQxbEVJT3I1NmZac1o0TFFPWkdTVllDVjBMQTM1TzFvRWNKMXRlOWg1QmxH?=
 =?utf-8?B?cXV5TFZTNE1hbjdIVnI1R3A3K3N5NzhQYXBRUy9xZUZLV251NDNmeW1OMFZv?=
 =?utf-8?B?RlRqQnpjZjNQNTlNbTZqMDNzZjRGR2VBMHNVc3JHZkRaRkVGWTVHRE5SRlVo?=
 =?utf-8?B?SW5TV0I0cTA2Y0FrU2QyeFFlN0k1OFdXTzNLTlFHcVVwY09IcjNaRnZzNHNj?=
 =?utf-8?B?aTYxT0hLdDRZNUZZdnZuaDBQcTZiTVhXZGJNUjIxWHVteEY5a1NnajM1dmJ2?=
 =?utf-8?B?cFpzWW5Xblc5UkN4OURMeDBYVU5IRXVabXI5UDZoNDVaMExtWlRnTDN4Zjcr?=
 =?utf-8?B?cnFnaUY2U1h5OHBtUlJrdTl1S1F0cEN5emRmMFRZQVk4LzB4eEtDZlByUjhP?=
 =?utf-8?B?cTJDTXVNRXZ6T2I0SFJ3eEhHc05VYUpBc0hFSExOL1hxbXRwUjRFVXBTbUM0?=
 =?utf-8?B?QVhYNW5VZ0JId2ZCd3NBUFVrMmJhTGNYZEZCeTF2eW1aSURwODZCRzVWaExr?=
 =?utf-8?B?a21NM3BJUG1HQThjNVFwMURtMk1uYzhTZzdEajhtN0tYSWZkZ0xUMThITHRv?=
 =?utf-8?B?aFVaYlhrVk1nTXo0OVc0R3QvWGg2SVpLQ1hxVjRmaVU1VU1RNG44QkJneE5S?=
 =?utf-8?B?S2dBOFJBSStMbjBtOWVKZmRiNFBFT1FOZkR1dnZqdGJMUXc0WDN3OWVZUG9T?=
 =?utf-8?B?TUxwVW4vY1ZBWEpSRUFvVDIzV0tTeUVQbThKZlZoMkRlK3NHdWRTMFo3KzVm?=
 =?utf-8?B?MiswQjE5QkN5eHJVRE51OEJLb09obURRZEZxZ1RzVjJjd3J2S1BEZ0NKZlZk?=
 =?utf-8?B?THYxUnZxcHpjUFFxb09rUS9OaVhBbFZBTmJqUUs4OG9wNFBwM1FBTDVWbVYy?=
 =?utf-8?B?akJPcWpMVXRNQ24wdWJOY1ZMUW5Ib3U4b1RVSGt6OVQ4UFp6d1VMUkpXVElt?=
 =?utf-8?B?M2JsMjd1WHlRdVg1anc3Q0F6S0RRaE1DSkVtaTJzZ1psUWthdlZwOE8yaGZx?=
 =?utf-8?B?ZDFpaUZkN0licS85cVV6bXRCVHdzeWxiS0NhNXBja2ZYR2NNc0Q2aW1lL3ZE?=
 =?utf-8?B?REtJcGZwL21weTZJS0RuZXV3d3ZFeEdpZHoxcTJKVUxhQkt5NzB5Z3FPa2F5?=
 =?utf-8?B?UEJjWGpFUFRuNFRwbExiUkhIRFN4b2NsVnBwRkRvbW54YklyZHdGL0l5WDc4?=
 =?utf-8?B?Zi8rOVkraCtramhXUUJFNkdIQkFzRXAwbU5YUzhsT3VmL0s4ZEF6RGk0TERp?=
 =?utf-8?B?WmFWaXI1RG1UYVBESXZDbEVXNEMvSFJ4NnZDd016M2k0UW5VUFRYcnZpcU1I?=
 =?utf-8?B?cmltdXd2aGwrOUFzcldvSnlBWDNLOG42Wnl4ZVlkSTBFbm9HWjBPYTJ1RDBy?=
 =?utf-8?B?OHpKZG1jdndzcWNZaEZxQnkrRmtFeFN0amlkSnIxMmFJT0lGT1R5VWFSbEJ1?=
 =?utf-8?B?VlAvbExFcW9aSjh1Z1ExdUlwbzhjMnZRSDVTaGRpcUFJSkl5Mm9BQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8e234a-5935-4f7f-ca90-08de89e4976e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 20:33:22.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sk4PSd6u4xxnGq6NGkxPUSBvjBCmFtRi1zb05BdCY+UTbn7nwOadZrbqugsGwR7nqeJLria52lNgZcfvZ1qi6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9745
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271287-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4A99A31C5FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 21/03/2026 1:57, Rishikesh Jethwani wrote:
> Enable TLS 1.3 TX/RX hardware offload on ConnectX-6 Dx and newer
> crypto-enabled adapters.
> Key changes:
> - Add TLS 1.3 capability checking and version validation
> - Use MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3 (0x3) for crypto context
> - Handle TLS 1.3 IV format: full 12-byte IV copied to gcm_iv +
>    implicit_iv (vs TLS 1.2's 4-byte salt only)
> 
> Tested with TLS 1.3 AES-GCM-128 and AES-GCM-256 cipher suites.
> 
> Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
> ---
>   .../ethernet/mellanox/mlx5/core/en_accel/ktls.h    |  8 +++++++-
>   .../mellanox/mlx5/core/en_accel/ktls_txrx.c        | 14 +++++++++++---
>   2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
> index 07a04a142a2e..0469ca6a0762 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
> @@ -30,7 +30,9 @@ static inline bool mlx5e_is_ktls_device(struct mlx5_core_dev *mdev)
>   		return false;
>   
>   	return (MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_128) ||
> -		MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_256));
> +		MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_256) ||
> +		MLX5_CAP_TLS(mdev, tls_1_3_aes_gcm_128) ||
> +		MLX5_CAP_TLS(mdev, tls_1_3_aes_gcm_256));
>   }
>   
>   static inline bool mlx5e_ktls_type_check(struct mlx5_core_dev *mdev,
> @@ -40,10 +42,14 @@ static inline bool mlx5e_ktls_type_check(struct mlx5_core_dev *mdev,
>   	case TLS_CIPHER_AES_GCM_128:
>   		if (crypto_info->version == TLS_1_2_VERSION)
>   			return MLX5_CAP_TLS(mdev,  tls_1_2_aes_gcm_128);
> +		else if (crypto_info->version == TLS_1_3_VERSION)
> +			return MLX5_CAP_TLS(mdev,  tls_1_3_aes_gcm_128);
>   		break;
>   	case TLS_CIPHER_AES_GCM_256:
>   		if (crypto_info->version == TLS_1_2_VERSION)
>   			return MLX5_CAP_TLS(mdev,  tls_1_2_aes_gcm_256);
> +		else if (crypto_info->version == TLS_1_3_VERSION)
> +			return MLX5_CAP_TLS(mdev,  tls_1_3_aes_gcm_256);
>   		break;
>   	}
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
> index 570a912dd6fa..f3f90ad6c6cf 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
> @@ -6,6 +6,7 @@
>   
>   enum {
>   	MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2 = 0x2,
> +	MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3 = 0x3,
>   };
>   
>   enum {
> @@ -15,8 +16,10 @@ enum {
>   #define EXTRACT_INFO_FIELDS do { \
>   	salt    = info->salt;    \
>   	rec_seq = info->rec_seq; \
> +	iv      = info->iv;      \
>   	salt_sz    = sizeof(info->salt);    \
>   	rec_seq_sz = sizeof(info->rec_seq); \
> +	iv_sz      = sizeof(info->iv);      \
>   } while (0)
>   
>   static void
> @@ -25,8 +28,8 @@ fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
>   		   u32 key_id, u32 resync_tcp_sn)
>   {
>   	char *initial_rn, *gcm_iv;
> -	u16 salt_sz, rec_seq_sz;
> -	char *salt, *rec_seq;
> +	u16 salt_sz, rec_seq_sz, iv_sz;

[1]

> +	char *salt, *rec_seq, *iv;
>   	u8 tls_version;
>   	u8 *ctx;
>   
> @@ -59,7 +62,12 @@ fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
>   	memcpy(gcm_iv,      salt,    salt_sz);
>   	memcpy(initial_rn,  rec_seq, rec_seq_sz);
>   
> -	tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2;
> +	if (crypto_info->crypto_info.version == TLS_1_3_VERSION) {
> +		memcpy(gcm_iv + salt_sz, iv, iv_sz);
> +		tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3;
> +	} else {
> +		tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2;
> +	}
>   
>   	MLX5_SET(tls_static_params, ctx, tls_version, tls_version);
>   	MLX5_SET(tls_static_params, ctx, const_1, 1);

Thanks for your patch.

Patch LGTM.
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

In case you have V10 for some other reason, please maintain the reversed 
Christmas tree in [1].

