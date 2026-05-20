Return-Path: <netdev+bounces-289867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OjqLj6HDWp4ygUAu9opvQ
	(envelope-from <netdev+bounces-289867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:04:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 417A158B4FB
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CEAD304C7DF
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3B03D3002;
	Wed, 20 May 2026 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d/2xfP+q"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013003.outbound.protection.outlook.com [40.93.196.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8DB39C64E;
	Wed, 20 May 2026 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271243; cv=fail; b=RfXHZEMp293N80d88xe8j4Y0q04bAoGWeOtgNtnQoLiaCmptutupyyud9Je7vQSjCQmSnTni9YL7HMisoTYxxUYSqjlW/1k0FsFctnOr3R1xVNVT4hkIny36n3ArEEUvUEelDutSU+I7Xi2TxKTOIViVapoK/j5OCQCYxxNIrsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271243; c=relaxed/simple;
	bh=PxOkhTG1J1ApiZrhHAebiJ8Y2SDGfc90iVVPzgIRUFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b8pzjGtOQxo1ASbMrM97UlN5bUmQKKVk/GN1TpYnKioqdXRVWoOgU+/2059tJ4YPxq7g2+ZMT4gh19czMEHCiMwecf059u4BiGcXWjr0epqHMRTUHSc9rVmpy1RO7HLQ2JcpOyJDZtPJ7ryE8KROd/SdCDFZ7UyCuegKTYMjtdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=d/2xfP+q; arc=fail smtp.client-ip=40.93.196.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myVI+uE70Zp1+gvrpZCc/ztCbTAT6XlcIcP/2Sca2Ugbf3hfQDRviE0zjek1rXEUOAFvZJLs6qIaE3TSl3bwzMdYxhl4l2jks8W1qkfRyfQBXMQSq0hyjpr+DL91ZBRWfG9c7q1Vw3K/pVMuBaqRqObHGxwSZD1FUEYf/C8vtrRwXPWxR3R5eE1YYDbC+VDCv1h0bPOC/XQA2oNDJFj/IgChNwFQYCb5BNBTyyA8FLM80swMxGCVBNYPrIfMzwzGV89sUWrPRHN+V8dmuzZsTTVcOVPTliqJQziY+NaiWBojhiZrVfu1V9cbKsL+K5K6aK3ZhlK77m1e58uRSJOSrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1e86+fEtFVZcjjxXF54aGBnFRIBUMnWEl24WNIiN7A=;
 b=oZGDLM86hNO/9LzoiQIWCMNIrzebu15lOLvZBnLV6ZdTPeEyGKJyQbvwG3E+VgY7xBrDIU40uxrQ4uUJeSQ5bIIUGVafbIlyH9i8uFHOgiamhyqtvdxDmUJQY6cnjYinCQUJrFnwS1anw6rYvhRYFrMy6NxFIitciIHMfpqB1EHtfUfphibiOeEWhN8gun592E9u4aju7WfFaxGHoooLtWx3Xo4SwEyLQG3FQTk0f3sEC8V2FwgyQ/QccgiJ1xMRDyzIlzI0ZCKh6kAO2VEsFou6G6yShAVgrDkf6lLOQQ3RT8RFT2zmtapkBs2MrPchvyS/OVO6lpetwPXUh4Qk6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1e86+fEtFVZcjjxXF54aGBnFRIBUMnWEl24WNIiN7A=;
 b=d/2xfP+q11d/bdAbNHLRv1ChAP6hkPZGn/aVj4G/8dDXzi6bGWJifCPHHpKQLkUb5SW2gSpL5CZ7CcUUeqQ8erIW2RAQa2OPS/DmZnBPUKDbjOv3Emy/wQ8ppFxGC2b46s/tAO/0uHdLOLqWYHAiN2y88SFMyAnGZ1f2DZUxx+M=
Received: from DS1P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:453::19) by
 IA0PR10MB7621.namprd10.prod.outlook.com (2603:10b6:208:484::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.13; Wed, 20 May
 2026 10:00:37 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:8:453:cafe::ae) by DS1P223CA0011.outlook.office365.com
 (2603:10b6:8:453::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 10:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 10:00:35 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 05:00:32 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 05:00:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 20 May 2026 05:00:31 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64KA0PMN1739976;
	Wed, 20 May 2026 05:00:25 -0500
Message-ID: <1d8ab51a-6943-4978-88cf-adda8cc57f7e@ti.com>
Date: Wed, 20 May 2026 15:30:24 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: ti: icssg: Add HSR and LRE PA
 statistics
To: Jakub Kicinski <kuba@kernel.org>, Luka Gejak <luka.gejak@linux.dev>
CC: Felix Maurer <fmaurer@redhat.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Roger Quadros
	<rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Meghana Malladi
	<m-malladi@ti.com>, Jacob Keller <jacob.e.keller@intel.com>, David Carlier
	<devnexen@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Kevin Hao
	<haokexin@gmail.com>, <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20260514075605.850674-1-danishanwar@ti.com>
 <20260514075605.850674-3-danishanwar@ti.com>
 <20260518184506.694c584e@kernel.org>
 <E30AAC96-01D2-4A23-B562-126087DEB7FA@linux.dev>
 <20260519165646.09b0783f@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20260519165646.09b0783f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|IA0PR10MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d2f068-5638-4494-cfb2-08deb656a38c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|3023799007|18002099003|56012099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	s24esD5NOSlhNilhwB+mD0fTBS72A9/4NAkXKlAwIW2VagLMstv+pyefbD0SydmIQNwL2LymAoXPTHZ//iX75LqX7i1NgAiIIl9AtVJKAGq3AIxdF2tK1hDmPUatn4CWxlur/5JBB702ITpO7E0OZCVhRVdbLErVH9ULgl6KGMsDXc15oefZjvaDJc4t20Ehxi4smHaL3+OlI3toSZa89yFeggosZxLGAChvGkR4gRfEkuL8qk2SdY1pxKDaOFI7lQj1NWgaZlZI6cKxyIsB+PrQ0+BgQoZ64MihfH53rj5MNpDcA+zubMhr47YJXF3k92AtmOYTP+XBAWxKsfWF9oKrorwORW0dh7gnDyWQO5e/K1boetDTiUbAzvUeTTw4xmanLrVfHGP3ffgZySnoHQjnwj+J3zseJZQIIPVqbNbuHo6M+ylFqxqjN/WZlgIpwSbNr70YMkRIiPelLA6t8Epk7Utw8xEGOy5ICsd8cUZWqovVf5sZW/BDUjHGPTRic85q3Ydh0p3tcenk7mVTSG2nbAye1piitJhWOLhMoXj23eFQqF1bUScrou1pZWTe3I1rnzPte1XD7p/GqIrVKSd3YFnHb5vaY/qu30lCmPjEe46jfcXDeaITJRW8OmngtNVWLq0OUQtBi3AaYSNOmAvk/wuEJz5ax7v3px+WPLfe+fd+0dUZTUrq0CR3QtK0n1QMa37PdldAu0anSKLtEptTueRu8wODcErabvgly18=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(3023799007)(18002099003)(56012099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gf/f1jVHXrM2p/GLRIJTnKepPJNSe1O0wSIt+F0zs4t299EGcGm35e5vruOVULySMQhw5u//j0/ARRS9VB7w2AN9j1JwC029fSdK5yVQHVSr3Jrn7zv0/DsTANcsFr9YROx+K4FOiMiIAW/QkkYYe73pU3zQ4NjLbciSRimiGtpAEwwVq1gA1DKdGCb6ZZnkN/NEdNUB77jC05IcNpqnIUOsshYaR/0sgBrwAoUjC3SwVfdpzwftr5b16SRHQpcm5n6ziubgVrW1BETBrq5dJcbS5sO3Nuz7K5pQVALeJ0wsEIqSrtzGdWesAAkhyx3xmrifhdU3coCZJvQqWqlTBY2rn7r+o3i6/ABP4Me/x7OfpKj2H8v9a4S7DPOkhqhoFo3gF0XBD8qCagIroDumUc9gfTBPnQMCI1ii09cb5vUC1W/vSoOaqUxW23lZnfyG
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 10:00:35.9603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d2f068-5638-4494-cfb2-08deb656a38c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7621
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289867-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,lwn.net,linuxfoundation.org,lunn.ch,ti.com,intel.com,gmail.com,linux.dev,vger.kernel.org,lists.infradead.org,nxp.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:mid,ti.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 417A158B4FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

On 20/05/26 5:26 am, Jakub Kicinski wrote:
> On Tue, 19 May 2026 07:55:55 +0200 Luka Gejak wrote:
>> On May 19, 2026 3:45:06 AM GMT+02:00, Jakub Kicinski <kuba@kernel.org> wrote:
>>> On Thu, 14 May 2026 13:26:05 +0530 MD Danish Anwar wrote:  
>>>> Add new firmware PA statistics counters for HSR and LRE to the ethtool
>>>> statistics exposed by the ICSSG driver.
>>>>
>>>> New statistics added:
>>>>  - FW_HSR_FWD_CHECK_FAIL_DROP: Packets dropped on the HSR forwarding path
>>>>  - FW_HSR_HE_CHECK_FAIL_DROP: Packets dropped on the HSR host egress path
>>>>  - FW_HSR_SKIP_HOST_DUP_DISCARD_FRAMES: Frames with duplicate discard
>>>>    skipped
>>>>  - FW_LRE_CNT_UNIQUE/DUPLICATE/MULTIPLE_RX: LRE duplicate detection
>>>>    counters
>>>>  - FW_LRE_CNT_RX/TX: LRE per-port frame counters
>>>>  - FW_LRE_CNT_OWN_RX: Own HSR tagged frames received
>>>>  - FW_LRE_CNT_ERRWRONGLAN: Frames with wrong LAN identifier (PRP)
>>>>
>>>> Document the new HSR/LRE statistics in icssg_prueth.rst.  
>>>
>>> To an untrained eye these stats look like stuff that could 
>>> be standardized across drivers. 
>>>
>>> Luka, Felix, others on CC, do you think we should expose these
>> >from HSR over netlink as "standard" offload stats different drivers 
>>> can plug into or not worth it?  
>>
>> I think there is a case for standardizing part of this, but I would 
>> not standardize the whole set as-is.
>>
>> The LRE counters look generic enough to me, especially:
>>  - unique rx
>>  - duplicate rx
>>  - multiple rx
>>  - rx / tx
>>  - own rx
>>  - wrong LAN, PRP only
>>
>> Those are protocol/LRE concepts rather than TI firmware details, so
>> exposing them from the HSR/PRP layer sounds useful. I would expect 
>> both the software implementation and offloaded implementations to be 
>> able to provide at least some of them, with unsupported counters 
>> omitted or reported as not available.
>> I would not put the firmware check/drop counters in the same standard
>> bucket, though:
>>  - FW_HSR_FWD_CHECK_FAIL_DROP
>>  - FW_HSR_HE_CHECK_FAIL_DROP
>>  - FW_HSR_SKIP_HOST_DUP_DISCARD_FRAMES
> 
> Thanks for the breakdown!
> 
>> Those sound more like implementation/debug counters for the ICSSG
>> firmware pipeline. They are still useful in ethtool driver stats, but 
>> I would be hesitant to bake their exact semantics into HSR UAPI.
>> So my preference would be:
>>  1. Keep driver-private ethtool stats for the full firmware counter set.
>>  2. Add a small HSR/PRP standard stats set separately, limited to
>>     well-defined LRE counters.
>>  3. Make the HSR layer expose them, with offload drivers plugging in via
>>     an optional callback or offload stats op.
>>  4. Define the counters carefully, including whether they are per-HSR
>>     device or per-port A/B, and what PRP-only counters mean for HSR.
>>
>> I do not think this patch should blindly become the UAPI definition, 
> 
> Not at all, the unique / multiple stats gave me pause. We should
> only put in the standard API what can be easily and unambiguously
> defined given the protocol spec.
> 
>> but I do think it points at a useful follow-up. If we want to avoid 
>> adding driver-private names first and then standardizing different 
>> names later, then it may be worth asking Danish to split the 
>> protocol-level LRE counters out and route those through a common HSR 
>> stats interface.
> 
> As a general policy we ask for standard stats to be added first and
> ethtool to only contain what didn't fit in the standard ones.
> There are some technical reasons but it's mostly a mindset thing.

What should be the next steps here? Is there any existing defined set of
stats where I could populate stats from ICSSG firmware for HSR (similar
to ndo_get_stats64 callback). Or de we need to implement a new callback
that will do this for HSR.

I agree with Luka on the categorization,

Below stats can be generic,
 - unique rx
 - duplicate rx
 - multiple rx
 - rx / tx
 - own rx
 - wrong LAN, PRP only

Below stats can be driver specific and can be pulled using `ethtool -S`
on child interfaces of HSR

 - FW_HSR_FWD_CHECK_FAIL_DROP
 - FW_HSR_HE_CHECK_FAIL_DROP
 - FW_HSR_SKIP_HOST_DUP_DISCARD_FRAMES

Let me know if I should go ahead and implement this.

-- 
Thanks and Regards,
Danish


