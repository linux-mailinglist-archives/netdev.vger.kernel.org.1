Return-Path: <netdev+bounces-282037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDMOItrz8GnUbQEAu9opvQ
	(envelope-from <netdev+bounces-282037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:52:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2750448A37A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52ADA300E299
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5240A4508FD;
	Tue, 28 Apr 2026 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uq8/QsMw"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBED31E844;
	Tue, 28 Apr 2026 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398741; cv=fail; b=lX1Yd/0bM6b54+o6Kwg8tnFhAAYLSpWkhYeCmQrO2ZeCiNvp8LnbUMLc9XCQyR9++kSBfQT2utaUeseR1Y+1KhexH10/C6gNzpkO4gP1KatG8QGhlzJqyIxUvkdcAe3WcE4AEyjbdoUo9jIJ2Yw1ft9Cwy+cEpvMB5S16DbRKL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398741; c=relaxed/simple;
	bh=0AlI8Z5MLvZa4sSm6uFf+Hu4+25i477IWsrqnOm76Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qsx6wKVY/On8F+uQnUe0HZZzvWcqqZ/pzy7gnKQy30ouXJr/Cokt3b5YUE3jMLG3KwnT1Y6x2/AulfbsbkYdhWr+OKUNqIgDYpAeW8fkhjiTXGXu0PsUjm1OGbnCA/qD97fSdpMtLNN5IkOBo4aiIkZzvUW6UUtlV7LSk5FYqvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uq8/QsMw; arc=fail smtp.client-ip=52.101.52.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5yfNz3ussncuMnAOttM/RLScLGqsXHS+89E0rs4YdekTkikP75Vna7fLNAHBKmKZe5iNWOZiikTs6/wjGGdVvyj7EEzOwhPqgw0XKxAZlPv/MJrh2i8gon3U+zHZBRmC9ZpplhBNKuK7MYlFnkiVo390n+kPxVNmfxt2jFDIybfy1F6c12wf8g7KwpOE35C3RAyb8I9euqugjJOo3gKNKmKGhWggm2iE1iFY2L8+PitiIJVd91hb/+qV7Lp2dKgQPvsoY1J/5W/1noAZcGguAg2W9YP8Yi299d4+HHAXtu9ox0r4ZsaTMot1o3MW1k1KkJsnHC4luBZeMTkbxyNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uICRXWi66sOxOu5gErFx/xqr1T3zwgBeiUbIbGRYDsc=;
 b=llz+lYQfU36KKxFPva5IJOPokPMpbi8iaOx9FgvS8AXCmekkmGyOcbVgtYPtGqk0Aq8jXlmFuBvjVu9uohwwWaflgUranMAIbctttlVY2pXrqEZZLkb9/xch1YeArBdEP6R8oMm3+7HEswBzKUFqhxfGPL+m/aDObeNb9KNO1IMhzdDgHmM36jB6eSPMo+st9kTAoGnxTKDFOEYbDAMGBapmbUhu7koXZC75kqkmIntl/dvX+f0WQhei0031TEClmKWkvaR5P+MvSbO+252QfkGExm/K8/n//NqMwK56wUJtrffWqj9tKUuNht6y3cDvSvxxKPXf6M33Zn2LbgbOgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uICRXWi66sOxOu5gErFx/xqr1T3zwgBeiUbIbGRYDsc=;
 b=uq8/QsMwdYaIVafnPD5fVA2GX4rS3t9zZfnnWfcUxO2E4ACAtinpyBbtv8uTB0FRGTwC6pUy6RYtKA6wKCcIBcxFlNuYGjNPNUq/h+X+/H3AWT1EKjNdTnn/AZjbhCGK4dwuwhi3ThLPyKMcDOIt+yBdcMOuXdCKjVmRBEvbfkk+osRxIkwNAysm0AHhc4A0/LDU2TyIlbDU1qS1/Yy02Zdurn/m+fXtg66auVrndFao8whLqr5T4RbhezBxviX24oktET1nXEvzRcEQnohf+s5t2Yv1zTQlTW9uioZXUdh37grFvhkpNI/M2uYgEPRgpazVbOjJlfygfyVsalTx2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by PHXPR12MB999232.namprd12.prod.outlook.com (2603:10b6:510:3cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 17:52:17 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 17:52:16 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>,
	dtatulea@nvidia.com,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Joe Damato <joe@dama.to>,
	Frederik Deweerdt <fdeweerdt@fastly.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 2/2] net: napi: Skip poll when arming GRO timer in busy poll
Date: Tue, 28 Apr 2026 17:51:31 +0000
Message-ID: <20260428175134.1197036-4-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428175134.1197036-2-dtatulea@nvidia.com>
References: <20260428175134.1197036-2-dtatulea@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::12) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|PHXPR12MB999232:EE_
X-MS-Office365-Filtering-Correlation-Id: 72df3bbe-6b26-407d-c3c1-08dea54ee2f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZBm8XG3xvVL7bvJh2pHQlZB2174oCQp6EruvoJEfkCLwsBhvGbZiahHuu34wh5f29rhj6ok4+VR7hnms13R4y7N+YAhnL82nxpg0nMmaDFmQcXXaEuV+pj2I5aBIEZ0S5eZLqUXSVRTb0qrXbRDiF6pKzW9HCiXO/u7/BAhP/jiaNBnx8rdzNwQZdjbluykek2BopR+J6YSDKVXtTJHYwI0Dd0oD/1TkCiQOuPplsJAOZ/9RZFpj7x3KVKeZmnNPMLkbPcVGpdtL6b6En7URFRKzGOS0KSX3ipS/4jbVgsXkrtzScnW7DDjaiKZr8xTbPlte8yqE9Fdl55uyWlO3XgmlZIHA8Xa3lb4/Z/05y7oyW80atEP40H+TfG/xJ+bRiToVfBKfMs454veGq8J5TErv+8ONhSBBWacnTfttcroc80lTFWDxSXfBA8mThLMAoqujDbUxK3HcN5RN1wrEPy0mnYawKQKWUpTd3G0dtGfYCqcEgwB6Otu+dRsiJtwbJ+4VnUCA4thWmRMLa3VLw7CY9F9deDjxZSZfCwHg6OxE7/4KMkolKpnmw7OhFy6T0y8A+HSgi6ylSghhTOsv0RlDHNkXEnEXy42xOd0vSsJgDwsiGJ2joypSWAlqq1sY6T+qKRwVmuEJvOpzbMcPiJy4DqkPOMug0BXzNRwC/ylqtOs0OTkbUfMd9Pl5EOrBzhmczCGBfYxXQo2iJcjPRrDLe42cH7LqvbbetF+S9io=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VQWUI4qRbK1JxoM0vA/dRAAma8LAK0fYy/wiS88V6UskTHqxCfX/7RN+ZBCs?=
 =?us-ascii?Q?3rYfXyu/8Vrr0HomaKIvwVOGlgmEEYO4ilyc9wh6kELDqnUFOoWNreAt+ayW?=
 =?us-ascii?Q?qMs4g7wltwE2CZAatKih9t2bqPAyMGGWmiw8R+9mNJ+aBlGVqT9V3NRnI3zI?=
 =?us-ascii?Q?D/sYuLnV0kIz0M/A7bJodaRT1M0cGD7c0Gx9/dV2Z8wKPl7/RCilpkBlZd1g?=
 =?us-ascii?Q?IlBXiE9iFs63YoN6fW9KISjrtXjxne3NV9B3mkrtTG4aoFJhpqbC6NbPQEQq?=
 =?us-ascii?Q?LoHVtWZw88hLeSPfq0/bRpNdkE3vIFWrPpMbe1nupKgR4HNqd6AzmvKNQICn?=
 =?us-ascii?Q?2MDSQla0FQ2/iovj7C0CUItpn2c7qaXO5Jj6qB3KwY91oXSE+XWZfAkxbx77?=
 =?us-ascii?Q?3mMnXIuhp1hWe+PVB4Q96tBsujxEPvitkwJ13hlUF/W2Dd8oJ3Z+Fhmndppb?=
 =?us-ascii?Q?D1BMdiCbGz8jVho/omNl21zuPyikgJ3OLMqqMZj/EsLy/jxEbVF9QtsUFpwE?=
 =?us-ascii?Q?d9QelHXLWxlO3d3XXjn80YaM6yHZq6rMj8tf1b6Pin2tVUGAiBECdMZhyFLA?=
 =?us-ascii?Q?ZxtfxOgwslsF3jr6e2I2oHGfmrRVCwX2G4JnLORI3gP3yshQu5SHTg/SKZse?=
 =?us-ascii?Q?U2eXNbKrfAsATdh/lMIaFoo+gCF0fWC7OUiP8jkykoibwSwZsrMl/BPDyNX+?=
 =?us-ascii?Q?nZ/6+zH6A6JzevWi30j0gem8JfHXpA6sD20kol2kNdNAylJpmTHuaWFRkzbJ?=
 =?us-ascii?Q?zONaxm9CCqtY3QbtaNfM94t/A8FjXhTF6/tb/MeFhd7T7xlIzj+k6KWdYZEN?=
 =?us-ascii?Q?iosTd4+j1RaMcpgqOTf1vfakf0GUj933OBc8i77KjdS8tdprkbWUPyQ2ZUHm?=
 =?us-ascii?Q?TGx3kOrsyDsCWLaZkVLBQc+SatanhG7kyiQoWJ2MEk2gQfdjAlnCWjNwYpyJ?=
 =?us-ascii?Q?oUS3c3U8Sg68fkEXwJUmxhcwjh1cArfsbOMdg9ompDHA0vhNv4mGBCzb4xXg?=
 =?us-ascii?Q?a4Pn9eavxxVvWIVq9/RyUPEtIWb/YK80ghq+ed35st96zcnfMtNmfwZdSqq5?=
 =?us-ascii?Q?4k2r1J17qBP8f5tw7pg7Ul0vylSTlmyMykgqExnQ9GUHP0vP5NHgxY5SeZW2?=
 =?us-ascii?Q?j/ABoLLsdQWOi1NoA0nhr/aeh68HPAA679/odYZjzizfibGJKvdH8sCC7KZ8?=
 =?us-ascii?Q?gKctk/UhQRUkEWiu4aa0JMMMrfS5d+snbV10DDfHQx5QWBI2Oo4cF5FSHWFr?=
 =?us-ascii?Q?oOSVtfo7vn0pqnoxmmDNwIgO1msu6Ez0bjUr9MHNiy+SEX0ruQjLQc11BqbF?=
 =?us-ascii?Q?CmqPTyoVBfxvSTePrNOq/o6t520E57vKpJjqXQjyoROSyngIapl+JgXzdDIO?=
 =?us-ascii?Q?yPwa0jUCZZFvt3mFaVSRiiAg3LKv/FXL9xGUjechPRNhh73iYYnJkMf3Tk5x?=
 =?us-ascii?Q?htMNKFS+/cnmXxAnGnsVwrxF1tL/vmNVjb8P3BnCdyg2DraByV0ZQoq7sE2d?=
 =?us-ascii?Q?72BABohRKfUfNhSP6EdZQq20Bn6rGZzkY2UzKztn1mB9nDDkEBKPlaMLTnUl?=
 =?us-ascii?Q?7lnlrlamaHvAU70RWnh2D6rcuBNXvou576MkX88E0COeFjd/zXnvqIuTFzIk?=
 =?us-ascii?Q?tuqdBt31DGnvm2oVpTpoOyPX+VaotWP/8BQEiBQkTiMVa5uDsCJWr+o54WTS?=
 =?us-ascii?Q?QzKa7tcqDURYZVLLWWYsV/0AMxFO8W03evSPq75LyhOAUMHKxGGNiJqRM3IA?=
 =?us-ascii?Q?U1YAH7MDnA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72df3bbe-6b26-407d-c3c1-08dea54ee2f6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 17:52:16.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JhszTx4+oakgB+JirW/OmPzMfM/xAf4jokGAnxjGTnUHGsTKN/mDzZ3t98XA65ugEV9LmW6QybEXFZd97MnNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR12MB999232
X-Rspamd-Queue-Id: 2750448A37A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282037-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Martin Karsten <mkarsten@uwaterloo.ca>

As referenced in the previous patch, having the GRO timer scheduled
while poll is running can lead to issues.

Skip the extra call to napi->poll() when the GRO timer is armed. This
removes the need for having a separate __busy_poll_stop routine and its
code is moved directly into the relevant places in busy_poll_stop.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 net/core/dev.c | 61 +++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1487d4946dcf..d4829c2484f5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6869,26 +6869,6 @@ static void skb_defer_free_flush(void)
 
 #if defined(CONFIG_NET_RX_BUSY_POLL)
 
-static void __busy_poll_stop(struct napi_struct *napi, unsigned long timeout)
-{
-	unsigned long flags;
-
-	if (!timeout) {
-		gro_normal_list(&napi->gro);
-		__napi_schedule(napi);
-		return;
-	}
-
-	/* Flush too old packets. If HZ < 1000, flush all packets */
-	gro_flush_normal(&napi->gro, HZ >= 1000);
-
-	local_irq_save(flags);
-	hrtimer_start(&napi->timer, ns_to_ktime(timeout),
-		      HRTIMER_MODE_REL_PINNED);
-	clear_bit(NAPI_STATE_SCHED, &napi->state);
-	local_irq_restore(flags);
-}
-
 enum {
 	NAPI_F_PREFER_BUSY_POLL	= 1,
 	NAPI_F_END_ON_RESCHED	= 2,
@@ -6898,14 +6878,14 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 			   unsigned flags, u16 budget)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
-	unsigned long timeout = 0;
+	unsigned long timeout;
 	int rc;
 
 	/* Busy polling means there is a high chance device driver hard irq
 	 * could not grab NAPI_STATE_SCHED, and that NAPI_STATE_MISSED was
 	 * set in napi_schedule_prep().
-	 * Since we are about to call napi->poll() once more, we can safely
-	 * clear NAPI_STATE_MISSED.
+	 * Since we either call napi->poll() once more or start the timer,
+	 * we can safely clear NAPI_STATE_MISSED.
 	 *
 	 * Note: x86 could use a single "lock and ..." instruction
 	 * to perform these two clear_bit()
@@ -6918,13 +6898,28 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
 		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
-		if (napi->defer_hard_irqs_count) {
-			/* Timer will be scheduled after napi poll to avoid
-			 * firing during a slow poll which could cause the
-			 * queue to get stuck with interrupts disabled and no
-			 * scheduled timer.
+		timeout = napi_get_gro_flush_timeout(napi);
+		if (napi->defer_hard_irqs_count && timeout) {
+			unsigned long flags;
+
+			/* Drop prefer-busy state as in napi_complete_done(). */
+			clear_bit(NAPI_STATE_PREFER_BUSY_POLL, &napi->state);
+			netpoll_poll_unlock(have_poll_lock);
+
+			/* Flush too old packets. If HZ < 1000, flush all
+			 * packets.
+			 */
+			gro_flush_normal(&napi->gro, HZ >= 1000);
+			local_irq_save(flags);
+			hrtimer_start(&napi->timer, ns_to_ktime(timeout),
+				      HRTIMER_MODE_REL_PINNED);
+			clear_bit(NAPI_STATE_SCHED, &napi->state);
+			local_irq_restore(flags);
+
+			/* Timer started, so need for another call to
+			 * napi->poll().
 			 */
-			timeout = napi_get_gro_flush_timeout(napi);
+			goto out;
 		}
 	}
 
@@ -6938,8 +6933,12 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	 */
 	trace_napi_poll(napi, rc, budget);
 	netpoll_poll_unlock(have_poll_lock);
-	if (rc == budget)
-		__busy_poll_stop(napi, timeout);
+	if (rc == budget) {
+		gro_normal_list(&napi->gro);
+		__napi_schedule(napi);
+	}
+
+out:
 	bpf_net_ctx_clear(bpf_net_ctx);
 	local_bh_enable();
 }
-- 
2.43.0


