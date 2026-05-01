Return-Path: <netdev+bounces-283085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH4XD6ce9Gks+gEAu9opvQ
	(envelope-from <netdev+bounces-283085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 05:31:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6F14A9EED
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 05:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 296FC300A581
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 03:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3358B2DA749;
	Fri,  1 May 2026 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3OAyOEGs"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4979196C7C
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 03:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777606305; cv=fail; b=BLVrqWTTICx6VmWqBnp/qvlCluPANN0KSlHAmSUZmzLo3fEBc/twm4nodE77J6vb0P6DaKKC3VMfZvUJ6m9N+axmqltTTeRoymScTcsrnuqvcjVTSB4cOgRVFPacOhQ8K++SwJA2kLeziZjqnjrVHPnxLpsvU1ncZCUT8GYkcaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777606305; c=relaxed/simple;
	bh=NUipQuyx7U8WoIA5vLM3WNXIgZEjzgzLdRX2Oc9aiK8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BHd6/+SbEEeeyx9i43QpjJ4ZELYuWtb1DdHVbp1MRE4wnMCMFUwWOv7g99A0usG6h/lMT2Gi5WfBAv4lDMi88JTlVz5zb1kiBSb9ZcKy5vVo21kjDTCVN7ydx2/CxrspbOrX+I3Qp08164gaYVpAwgbWH/49CXoIulc9+MWAYSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3OAyOEGs; arc=fail smtp.client-ip=40.107.208.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmz9fvxkD3WNT9mSRJOfdqM4sc2JcweGWeJLWBOhwsLQwKoFEEk12YKvBUtdO+2Xbum1ewguUtzGvEynYW0bNEVpix2FIwuTItsJU5RyHrWP5YOlxVdukQD99IjrRPctyQVzyn2dDoLMnVZ/t9JPehO6crbCNby7DLZQVJKm7Rlb0nSxbLRsHshBudefr13JEt3+H0gpN9Y95JHAbyfvJ74Og9TTaZxx/iY3TjNTva0bipOrmY179Yc9W92HF0RuVmQ8TrjkbJlFtGA4XOr6DvSeSdBV21qwc5MorWuulVP+DHPg8d2Q8ud8FDTrpxtOchBq5vwuT6bOQAPwGNMh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkqjSTZVNH//rscXkRIAZqnwNKW3rCRXshkQM44aPkU=;
 b=dFcB1fAjg0zmIaVZrJ0uScAXrIjOj0HuCyTBC1qtTVXcucfRR08SyCYsWYFMHgASPN7F8QreqG2a1rsQtQKrU0aQ3HK5k2iOzWfTZgqxRBO1c4jYLJthMAT/5S4qOlFcenK9tZD3qGFOXAM7lgRRSoZzHlDjX2bVj2foCRQ/0EKlJozvJTNxP7xZRFSHqB0qWEObm1mtSsnjD+8HZOWMWgLAC0dVDh7epoit92rmXlCeQmPprJ+bz4a3TNk8k6w81I55s1/tbXJ62q5SvtYDDoe4i99zSV6/pHyYP7UFg4u8mO311/cne28CAbuD9j1unKhMH24jBWAkNK2pCsqXKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkqjSTZVNH//rscXkRIAZqnwNKW3rCRXshkQM44aPkU=;
 b=3OAyOEGsfVcdzSEG7L4cJo6V4jxyjGHCs+4tyO9fJ3mO6wBQnFmPxOs7lhmXCBTNukYFdTG4z++6ER//TPAx9TswedOuc3Dqy1qvfVRsd+ufYhme5DJCRr9VeSZX3YZLgMngk0cgyqrmEZ5ccPe2V7fx6b4OOrC/DmzAgreCsbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22; Fri, 1 May 2026 03:31:39 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.20.9870.016; Fri, 1 May 2026
 03:31:39 +0000
Message-ID: <e11587b5-2012-449b-b108-7483f5943327@amd.com>
Date: Thu, 30 Apr 2026 20:31:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/7] ionic: fix adminq use-after-free on command
 timeout
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Creeley, Brett" <Brett.Creeley@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260429210007.40015-1-eric.joyner@amd.com>
 <20260429210007.40015-6-eric.joyner@amd.com>
Content-Language: en-US
From: Eric Joyner <eric.joyner@amd.com>
In-Reply-To: <20260429210007.40015-6-eric.joyner@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::18) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b3132e-774b-4a7f-b1da-08dea732279e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	CbL/K9tIDhjJeFJtT0C/xsrvPQ1jEUw5//FxXyLgtcUiB692fnh8yJQZDHNzX6K024tV4b+bjtxsk0vNkVkRTokVbKdHPUso8Iz2pqxFH4Bv8VzX6sQhYFLD/BuDO98IG31qMaHdCHywvT1n/QL1UY1LYK+VJsofqJLv7UyftV3ENPyXvvVuWSGg36RLC9qP36KiOHzkXKC38LlZifXrRukzBxnWh1kqiOi4pruOyBRM7dvxt+v9U/cgc6k/nPdl+56LGftktJwW4eLfLXaN+2hFW4tHF1tCKVO9BYdpSsj8MZgghCAGt9Mu9daaHhNQHeA381tgKgXoUEKgUOAVcYdFEIyBtMRB9t8g9+s6wFmZQPMj0G+sY7+VCr6TWd5tj5U4PkgyeOoys2SPeKjwW4XgRdU++LNAE56hV5S+p3VWGtD8atHOmwWpytbBQQ5d2AhP82n4P8IUDHVUolSi2k69qxv17icLHkUQ+anrNwfPqCAHeA7ZsktpXKUbLBlmJ6IQ1TrEOGiDuY4pvCAUizKER39GwoAimTNuicqPVlUCdnhL7UrRa4kxUDO4Xno3cnu0Xzm53LxiMuoSvOTXD0gOflTUz2pAPUzJqSjpnXsUoZZLf/FLejgjJea0QNiGG1e5LViT73/IwIptKpcGRg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHZ3THh6NnpxVWJIRVF6QXYrVnZ5eUhoSjBMZVI5WFV2OW5OZm9UUDZJU0Yz?=
 =?utf-8?B?bTJNNW4rdWttcG9NWmswVnVHRWJ5Rll3VDU3V2lmbGhNTnBhenYwSGFDRnV3?=
 =?utf-8?B?b24rVXFESzVtQmxZQkpObThHM2lLWHM3ZCt4NEN3WVpaVVZTZ0pPdUxYZ2k3?=
 =?utf-8?B?U0ZLYXhyeElNRDZMYXBGVFBUN1d2SVh4NklGMEhPUFNsVG4rZndLYWtlQ2Fj?=
 =?utf-8?B?aEFCRldkbVRwT3NYNVM2WmYrcWducWJvMUprMnV0TlNzSWYyN3dKR25DU2J3?=
 =?utf-8?B?dWhYOWhMMklTNFUwdHltRjh1dXZYYTMwb2xGby85NEtXYmdKNHZGeUhOZDRH?=
 =?utf-8?B?c2tldCtMWTU5ZkJ1YlgyY0JkZERtNklwenljOWxudDlZN1FuMzJ4ZTEwSW54?=
 =?utf-8?B?MlVPY0FoVFNxWmM0Rmp1SGNKc0hObFJCQ3MzY0lpR0d1MHBXTS82WDFxUVBj?=
 =?utf-8?B?V1E2eno3MTJpQ1RpYjB5UkdaV21tWVpvTmdWRWxoRUsxV0ZXUnQ4RytweEtO?=
 =?utf-8?B?VEIwa0h0WHJISXVTVkpQNitOeXhvaVNyeXJpU1dqeHhCNHdLNm9oQ2RJemtJ?=
 =?utf-8?B?eXU4b0hyY0t4NC9ucWxBT0s0aHZQWVFZcDVZSFJvOUdLMG10bVNCUktGaXk4?=
 =?utf-8?B?MlM5Zm1pdE9SWW93RkFCOUZSb0VFZEU4VUhDUlJ6L1h3aGhDelpzS1BUTUZx?=
 =?utf-8?B?TzVNclMzbWVvcTgvT0swWFZOa2JtN3c1Y200L2dpSnJ2ZDFhb3lNTXFXbEpF?=
 =?utf-8?B?dVEraUR6S21GQkVEeXNjNDVGdVJyWmJTbVNZSHBteFVJbzk2dWQ4WG1DdTM0?=
 =?utf-8?B?cHp0aHQ1M1c2b2RaRldRcDJGTW8rTUl5eXk2TW1uWENIeFFrdzJjZFZuMmVU?=
 =?utf-8?B?bHdzQmlFMFdqa29IOUZKVkhuaHhWdDFheUpsUlo0V0lUNUlrazBCRkt2Q3Z1?=
 =?utf-8?B?ZTRwV3RFOTFwWFVTWWwvTGppRC9DRmhvQzNLRklUR2V6dXhoY3I4Tm91STFN?=
 =?utf-8?B?UHF5MWEvaGErbXJXU2NoVFpFY2ZZUWdhYlEvcS9ZTlJjMHNYMUlnVW54OTJJ?=
 =?utf-8?B?QkgrNjVRNWpzb3p2TlRjT21wakg0SEhVK0lwOGlwSXpTV2x6YVJxVGpyM05C?=
 =?utf-8?B?MHlicDlSY0VMMkF3dmF4MWM3UmFJemdQL3JWL01BNllJYXVUNXJIeWRwcDRD?=
 =?utf-8?B?eUdBN1NHdGQxd3duTVlEREtqeSs4TnZ2cEtMYUxlelZ0dkMweVVHYktRSkZJ?=
 =?utf-8?B?Y2psMitRUTlJVEQyaVh5Q1lwRjdPdGJnMXkzYlFJWHRFbjllRnRoV3VDbUkx?=
 =?utf-8?B?NXhWamhMWDRITTB0RjlyeXV2VVpnanhQM3lQSmc4NUtHUk1mcXgrbmhVb2JS?=
 =?utf-8?B?alJhOUJJdTdQb0oyVkpiYkJGa0QxRTBERnBPZ3ZaMlVVZWVDam5lYU4yYmtV?=
 =?utf-8?B?djl0NFk1Mys2SVQvQjNSWmtxcEJSRWoveTdXVTk1eG5SZ2E5ZFpNSmpTejdE?=
 =?utf-8?B?WjNhNU93T2RjZTJuSXY0a0ZvZXdxNWlacHorelFZUzlKZS92RmttNElSTXdV?=
 =?utf-8?B?bTlJeFJFc3Q4dm5nN2dEYkE5dzZtL0FIQ0h5ZEl6QVQ5TUlDOEFJTXFkNDIz?=
 =?utf-8?B?OFZjbWVKSnR0ZUYwbEpRMy9RN3Z0Z0lObkJOOTBUck1FMHREckhScllPNmxZ?=
 =?utf-8?B?VmkwY0toYndyK0VjekZvNkZRTEdsMkpFOGozQWJ0T3d3K1JOSVl2eXhucXZB?=
 =?utf-8?B?OHAzcHREbDFsbDZuMFNySEZNY0g4VU9rL1dteHlEMmRweEYzaDNvZko0VUMy?=
 =?utf-8?B?ZGp4S1RtaGZkRGd0YjZTK0M5a0dGUUNQY0MyN2Q4YitYOExSN21PZnV6YkNu?=
 =?utf-8?B?c0VpVmhiaHhSdmlhR1Q4Tm9XN3VSaTFKTE5pSGRjSFd2SXJHRWdWQ2hsR2Iv?=
 =?utf-8?B?cUx0SkMzQXB4aU5tSHJUaG8vL0pnSWZvNGxmWGRuR0pnVGR6VmplZ2dkY0dP?=
 =?utf-8?B?MXRwRGJ1OXVPSnZnZU56QzZEeGE5TEcyb3pnY1JMM0gwemppdVJxQlo5RnAw?=
 =?utf-8?B?Y0R6NVhGbHhBNHV2R1FwRFF4V1A3c05pY1ByVHBlaEdKUnVDWCttcklpYnpB?=
 =?utf-8?B?bHcvUEtadmt1TmhQZzU0SVpTQ2w3VG9hbFZSRk5xUlFWRFVGRUtBWHFUY2RI?=
 =?utf-8?B?ZC9oNlVxeE5YRkVZZE1XeGt1cDhxVXNPNzJULzhpRzYvVko1U2h6dFdlMWh2?=
 =?utf-8?B?TmRnU1RtQ0tydkZRRFZ6ZngwWWF0ZFRMd0FJQmkrL1dpVlRLbUp1bkRUNXBD?=
 =?utf-8?B?VmRmb25pb1F6cFhCOGRiZ012cWhEcGExLzFkVG1pVTV6Z3lMS0kwUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b3132e-774b-4a7f-b1da-08dea732279e
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 03:31:39.0456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEXJYRWMwYrnKiqYF4ahVxtnargzOPuO3SXY3xDfOjM0Q6yizAv6E5CQONOHmrU9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508
X-Rspamd-Queue-Id: 2B6F14A9EED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283085-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sashiko.dev:url]

On 4/29/2026 2:00 PM, Joyner, Eric wrote:
> From: Brett Creeley <brett.creeley@amd.com>
> 
> When ionic_adminq_wait() times out or detects FW reset, it
> returns an error to the caller, whose ionic_admin_ctx is typically
> on the stack. However, desc_info->ctx in the adminq still points
> to that ctx. If ionic_adminq_service() later runs in NAPI context,
> it dereferences the stale pointer to copy the completion and call
> complete_all(), causing a use-after-free.
> 
> The timeout path partially addressed this via ionic_adminq_flush()
> in ionic_adminq_check_err(), which NULLs all pending desc_info->ctx
> entries. But there is a race window between the timeout detection
> and the flush where NAPI could fire and access the stale ctx. The
> FW reset path had no protection at all and returned directly
> without clearing desc_info->ctx.
> 
> Add ionic_adminq_cancel() which takes adminq_lock and NULLs
> desc_info->ctx for the specific context being cancelled. This
> coordinates with ionic_adminq_service() which also runs under the
> same lock. Call it from both error paths in ionic_adminq_wait()
> before returning.
> 
> Fixes: 938962d55229 ("ionic: Add adminq action")
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Eric Joyner <eric.joyner@amd.com>
> ---
>  .../net/ethernet/pensando/ionic/ionic_main.c  | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
> index 810cef0fec93..0971ca4d6650 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
> @@ -190,6 +190,32 @@ static const char *ionic_opcode_to_str(enum ionic_cmd_opcode opcode)
>  	}
>  }
>  
> +static void ionic_adminq_cancel(struct ionic_lif *lif,
> +				struct ionic_admin_ctx *ctx)
> +{
> +	struct ionic_admin_desc_info *desc_info;
> +	unsigned long irqflags;
> +	struct ionic_queue *q;
> +	int i;
> +
> +	spin_lock_irqsave(&lif->adminq_lock, irqflags);
> +	if (!lif->adminqcq) {
> +		spin_unlock_irqrestore(&lif->adminq_lock, irqflags);
> +		return;
> +	}
> +
> +	q = &lif->adminqcq->q;
> +
> +	for (i = 0; i < q->num_descs; i++) {
> +		desc_info = &q->admin_info[i];
> +		if (desc_info->ctx == ctx) {
> +			desc_info->ctx = NULL;
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&lif->adminq_lock, irqflags);
> +}
> +
>  static void ionic_adminq_flush(struct ionic_lif *lif)
>  {
>  	struct ionic_admin_desc_info *desc_info;
> @@ -448,6 +474,7 @@ int ionic_adminq_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx,
>  			if (do_msg)
>  				netdev_warn(netdev, "%s (%d) interrupted, FW in reset\n",
>  					    name, ctx->cmd.cmd.opcode);
> +			ionic_adminq_cancel(lif, ctx);
>  			ctx->comp.comp.status = IONIC_RC_ERROR;
>  			return -ENXIO;
>  		}
> @@ -458,6 +485,9 @@ int ionic_adminq_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx,
>  	dev_dbg(lif->ionic->dev, "%s: elapsed %d msecs\n",
>  		__func__, jiffies_to_msecs(time_done - time_start));
>  
> +	if (time_after_eq(time_done, time_limit))
> +		ionic_adminq_cancel(lif, ctx);
> +
>  	return ionic_adminq_check_err(lif, ctx,
>  				      time_after_eq(time_done, time_limit),
>  				      do_msg);

I took a look at the Sashiko output for patches 5 and 6, and it echoed concerns that we found
internally around ionic_adminq_cancel() and ionic_adminq_flush(). We might need to rework at
least those two.

https://sashiko.dev/#/message/20260429210007.40015-7-eric.joyner%40amd.com

- Eric


