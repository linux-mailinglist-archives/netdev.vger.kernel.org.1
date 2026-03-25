Return-Path: <netdev+bounces-271504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHZIKojNw2lKuAQAu9opvQ
	(envelope-from <netdev+bounces-271504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:56:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E38C23244C2
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4130131F2301
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0623CF69E;
	Wed, 25 Mar 2026 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uLIQowmx"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012013.outbound.protection.outlook.com [40.93.195.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244F3CFF5C
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439077; cv=fail; b=rU2hqdNtnF7YF5Zo29hTm2UP/GTMamHqin4kzzKDcVjKtfsxiPW98it7GF+vizF7WcRI+ivUDxVuGFyV4IUShJGcdv2L6ieU0/6O3oQytMuVgDXqWiKNqws48AnFaC8FzATkbkmBuxBLas/Hg53u3XOqCoTmfiRqiNdytMg6UX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439077; c=relaxed/simple;
	bh=+96c1v/xWHnCZ/OWWsxcuvZpiKxnezyDbyVEpFFSUvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HY6E74Eih8w6Y6txfshhwc8F1acJGBlw9QgpNuI7Ch0YwDUtagYyTnZHHf9t5vejH+VbbKYfQuMxQS+z5etCyno/Dn4F8+JciwveE0IsaQRXPgxI3s3qKDRdmBFMPj9H0Km7rC5S6XZWAnoryChGBUPZMQSVdInv4b0Nlj5KPnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uLIQowmx; arc=fail smtp.client-ip=40.93.195.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzxiindAXXjygvyOhlKqyl/I/Y8Ug4PwJNUSiIdJ3BWwCXYtKfID1+R1WHBulhbtwoxYscfjRKLvatAR/ht+PY482Z7NkoNkWQzLZgmaiOOAIYXpf6yU8ewyZTunWj0T0d70zTnOguJIh+meSjltXmyw59dQHmSszC+LMJqfXp4QmzQDSByjXzS1Y9vglDjxLYah4SOPs/ZuFBVdSY/PpgwAAl33epPzcOdMgBhV2kuV4CVjvajr8QGYBwnGzEM8H4QtXXT8CoMZE3pQfJOtwcXDfy0PX87FLg/tdoTuL9smDxCdsdqmPpF+OT9+9VlbQ6K6pRWr7QmMff6lEJOHgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yILAndwoC0RrWUEaAcF8B/dinQwCUsoyZKQbHFciWp0=;
 b=BQeJ5oN6ShIvCdqLWxy3NWHYEDLTiQEAmq/kZR+ZzARmpi/Xvv5HII4fDQIeM1atbIKMHsIw33Cw007o8y6oyvaFa3ya0eimdLyeOXqncHndR7GddGUPWkMk0XPNwcNfM+mX073RxYK+AxjSkUfWCK7EsyoI23/PJgbPibLa0hVX4mc40TEtOdQmfzJSRJK+bTOqy9iayABcfg7vkTW+ZwF+nL21NvHaBy7z7mfHI8nmm7gykGjDaUQ8EpZlsydst45v65F9BS75TkZU8edG5KXA9NlW4HDwlXNdQPQXSgh2oWCA2WJSPRUdVcv92vbdo1vLQlSHpG6TXXVd6lcglQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yILAndwoC0RrWUEaAcF8B/dinQwCUsoyZKQbHFciWp0=;
 b=uLIQowmx0ycMXSHBPT3TJPSaJDYy44ENRb0IjUHGrBm43eku5FoGlJyQtsS+Nu8Le47j8GaqdbWb3xfR4tNnqDaGIDdxy+CKbpqQCLQbl+KNCQjKCwDTQgjx70f4F1K4+NqJ/mqmXNmRftu1C9Os+5rX24wXKhqCnJswim9S4/k=
Received: from BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::7)
 by CO1PR10MB4753.namprd10.prod.outlook.com (2603:10b6:303:6f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 11:44:32 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::d4) by BY1P220CA0020.outlook.office365.com
 (2603:10b6:a03:5c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 11:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 11:44:30 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 06:44:29 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 06:44:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Mar 2026 06:44:29 -0500
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62PBiQxs3928918;
	Wed, 25 Mar 2026 06:44:27 -0500
Message-ID: <18662852-e71f-47b9-81bc-76cc31f64a83@ti.com>
Date: Wed, 25 Mar 2026 17:14:25 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ti: icssg-prueth: fix missing data copy and wrong
 recycle in ZC RX dispatch
To: David Carlier <devnexen@gmail.com>, <danishanwar@ti.com>,
	<rogerq@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>
References: <20260324211402.342474-1-devnexen@gmail.com>
 <20260325092857.47962-1-devnexen@gmail.com>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <20260325092857.47962-1-devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|CO1PR10MB4753:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c91c672-c1cc-41b6-e12b-08de8a63e0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	RqK7ZBNWzxML/yVE4tHhj/OafqTMlC0irjzcMch2dk3bIIN4FcwLzVPgdjd14nlb8c1+muJdb5bLLUKh4jXNBJmCmwm3N7mQlhILNYJGgXaWS+E52Xe5+lFunpK8Uxvp08Fn9PXoux84zuEABsf8qi2J6BM+lu2cLB/8dkglzUnuHPGPWPEi3URK4TaEchG6mXZa0mUTjoa02FBGoXKUYDi1HVC6x58w+rDLJRFs973UVEr5Q4Kpiq3szLeYvQ1kZH5u9q1ic0pOFoQFY6hznI79y48cyIJaT+lKMaR15a9txvL0yZ03U8bYqV/niUPd6sO83yDnlqppPGw0EGdjlnuxx2osJTFRitmH/eNot/PGQ+f4vJTyzW+vCN+KI1qIMrFLF+pjxVdvG2wLdxMPewE04DaPGNawSk8WJfWj/K2FyGtdGxbuXQL96OMi7TlfCQ3anS/Ru10hreMtC4S+qNI5wmDUZCihvyId8x4xHaOAMwnWqdekhSL/7ff0y2EjWrygWEVyY72eDGjvrF8Qejy8sV3KNSdGbwDwtFfyGShao+8+T9tfq4Th0LdeIuLjhE0cVyMe/KoEN7uLLIwbLq1N4tQK8+A6rgmc+h4ftRTC84WwW0cN57g14/u+09koAi3LbzPCFS/wIzoa+SVL8EUhTB62xSpTbnWCEenL9rzcQokJtfMqwxqLMlyD9pGDO8j5cJgjL17s44IIm4428QjyB6VGdAymEU5aME2HIP+okDXDtpyMQOL8jIJpL90XTAmNXaiH9wspEIG+qRZ6Ww==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sojx0/eaY2S/y9qH48c3KTXnI+qKJsz1RCciZS+NuaJcnqvTP4Ys32KZCkSJfP7x/S9k7vAKydabf+ZVfvEyz7Pk1z8OFSKPFeFaeHXb3zl/ajfFYfr/flBzUAgWQ2RqxcE7e77AdmeQn8Kk+oeIpqKixVxpi2+3BvHNIxOt3BxcO8cfT8c2HmTPzVhfEZ1YayAtUUVu799JCBEDlFXlVscLKAcQNw0nEzc1T+9osoIDuXy2/guumUfBeIgEoyNCKXMlTixMB5Fwg//pWBnjmp4SayzMn13u9j7dT4XR4Uz4TRBiRGFI14HR7BblrKU6WRknw06Ley/VytkqVew6tjSct479MPNGnuzub2lGdE5qFiyFwx4O24ibx6QXcG55665xopROA8OHV5FcP7rjf6j6WJsVqiPqG+6oTJe54C2kacBb24nHptc9CldW/C0f
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:44:30.8844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c91c672-c1cc-41b6-e12b-08de8a63e0bd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4753
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271504-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:dkim,ti.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com,ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E38C23244C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

I think you might be missing to put some maintainers in cc. Can you 
please check: 
https://patchwork.kernel.org/project/netdevbpf/patch/20260325092857.47962-1-devnexen@gmail.com/

Also check "resending after review" section here: 
https://docs.kernel.org/process/maintainer-netdev.html
Grace period of min 24 hours is needed for re-posting and "The new 
version of patches should be posted as a separate thread, not as a reply 
to the previous posting."

On 3/25/26 14:58, David Carlier wrote:
> emac_dispatch_skb_zc() allocates a new skb via napi_alloc_skb() but
> never copies the packet data from the XDP buffer into it. The skb is
> passed up the stack containing uninitialized heap memory instead of
> the actual received packet, leaking kernel heap contents to userspace.
> 
> Add the missing memcpy from xdp->data into the skb data area.
> 

You did make changes in the code as requested but the commit message is 
stale. Can you post a v2 with updated patch and commit message.

> Additionally, remove the skb_mark_for_recycle() call since the skb is
> backed by the NAPI page frag allocator, not page_pool. Marking a
> non-page_pool skb for recycle causes the free path to return pages to
> a page_pool that does not own them, corrupting page_pool state.
> 
> The non-ZC path (emac_rx_packet) does not have these issues because it
> uses napi_build_skb() to wrap the existing page_pool page directly,
> requiring no copy, and correctly marks for recycle since the page comes
> from page_pool_dev_alloc_pages().
> 
> Fixes: 7a64bb388df3 ("net: ti: icssg-prueth: Add AF_XDP zero copy for RX")
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>   drivers/net/ethernet/ti/icssg/icssg_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index fd4e7622f123..a28a608f9bf4 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -902,6 +902,7 @@ static void emac_dispatch_skb_zc(struct prueth_emac *emac, struct xdp_buff *xdp,
>   
>   	skb_reserve(skb, headroom);
>   	skb_put(skb, pkt_len);
> +	skb_copy_to_linear_data(skb, xdp->data, pkt_len);
>   	skb->dev = ndev;
>   
>   	/* RX HW timestamp */
> @@ -912,7 +913,6 @@ static void emac_dispatch_skb_zc(struct prueth_emac *emac, struct xdp_buff *xdp,
>   		skb->offload_fwd_mark = emac->offload_fwd_mark;
>   	skb->protocol = eth_type_trans(skb, ndev);
>   
> -	skb_mark_for_recycle(skb);
>   	napi_gro_receive(&emac->napi_rx, skb);
>   	ndev->stats.rx_bytes += pkt_len;
>   	ndev->stats.rx_packets++;


