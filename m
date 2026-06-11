Return-Path: <netdev+bounces-298303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WKMhGVsFK2qf1QMAu9opvQ
	(envelope-from <netdev+bounces-298303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:58:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BE2674A07
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:58:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=selector1 header.b=elMIIn4s;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298303-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298303-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4DE9F304CDC3
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8391C4D90B3;
	Thu, 11 Jun 2026 18:58:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BE64BCAD9;
	Thu, 11 Jun 2026 18:58:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204290; cv=fail; b=D4ibDgreyIVssDJYOELGwbseZYl/dLoHViwyOrQmJjBIqJx3jsk6ANGpDhzjJFOmHdUFZKfRBQ6PPaDKirQrHSIT1x0nIKVEMhdlHKiyKEPQ43ApC8ThTaxh0Bb0s8s8C545ZOrb+PZ/JqV6sTbk81KDo/rA/g7M9rqzCHUh1Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204290; c=relaxed/simple;
	bh=Iz0o52+6abTRehp0q7Mxkq7+oO+XGVBRLJMphrPV1Z4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKhCzLTjCNqPu2I788+fGQHQ84xr7zzPiLwI1vHb6/VNfBeFk0yx4/Ds86vjA5i3m6XJ14DYOSJcDH55RepbWo+wTnrZwrsIhk+c0vqSvwpE6GG12LQ/mW1HhJXfdas2JOJtsqXFesU+XtttnXVkMTXUdTnBb9K5Vra/ocd36Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=elMIIn4s; arc=fail smtp.client-ip=52.101.56.61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y41khLSUn7jgK7WOorvLy8VOzGU/7V9ZIH8OIY9Mk/DBFwbi/20D/jQsYzVHEcdg/AxQmZBcoIxXp8VtJUH2k2TQ245u0lJLImagBDFM8V1qn4hIGznHJWwuXQ2XP197VX25t8JvDhEobfnBaNg5Ue2RLwA44MdaEmrC0+sI9ICJ+6KV/ckfcd/X3YgA8eEsR3TOY4BAANWQ/Nb9i4Y4zZe+W+nLpfVJvgP45HtREueH++uWAgGzx1wTpUvSjyPPbC+qnVAOnx4Uc10sJkVa4DjmeoinYcR2OtWfLdn8mbWsuaA6jpnX6t2f1Nr+1stuUcXJKwcd5kukqE3jSCuSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6n3h8aYmpJaqSNDsk6xy76KfnD8qUzKGQ9jTTSvkUA=;
 b=QmEvWrHYC7QO5y17/1DgTy7+wW3TQb+eQXCd3c6st7dUrHjVwbH1WNnFFS7ERr958kHqMQ6kfCmiPrtOaeka1Jg2Mwx4zmOKBwmKu687vNSX5IeQB9XOAaIviiwfO+WPI+EJROPsO5VzOnf8USAxyXOutcw/vBzoGqIV6aR24H3jsprFQ7NAl24x9Jahds3zTx91Dw1zQDa1WjdWhihtdwDW7OK8dk9YfXu8xn4AkRddCPeVAAM5vVd0tN4T3TEr+rgLvYiS83qa30VAtYSwETNQQcqz7Me+T97/ZXouxMZW5D/6oELIXiVWpSQpgj4P6TEBJBjO4CHSSAX4uTfTPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6n3h8aYmpJaqSNDsk6xy76KfnD8qUzKGQ9jTTSvkUA=;
 b=elMIIn4styi48Yslv2m26gt6/u958mR76HZxHX3suH3NJJQb3nvhYE5LszZ63DIcCXSZwa7Qz66XebqTUTrspa+13CyCZr4DLbAbHZzl5g2bT4wveRIwrWb0HQFgxD7AkLN8htfKPSoHcPyrBKQE13C8tO6/v7mMmz7sQAEtavw=
Received: from MW4PR03CA0303.namprd03.prod.outlook.com (2603:10b6:303:dd::8)
 by SA1PR10MB6592.namprd10.prod.outlook.com (2603:10b6:806:2be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 18:58:05 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::ab) by MW4PR03CA0303.outlook.office365.com
 (2603:10b6:303:dd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 18:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 18:58:04 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 13:58:02 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 13:58:02 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 11 Jun 2026 13:58:02 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65BIw2193924044;
	Thu, 11 Jun 2026 13:58:02 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.231.93])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 65BIw0J2028177;
	Thu, 11 Jun 2026 13:58:01 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <diogo.ivo@siemens.com>, <haokexin@gmail.com>,
	<vadim.fedorenko@linux.dev>, <devnexen@gmail.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <m-malladi@ti.com>, <sdf@fomichev.me>,
	<john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
	<ast@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net 4/4] net: ti: icssg: Fix XSK zero copy TX during application wakeup
Date: Fri, 12 Jun 2026 00:27:44 +0530
Message-ID: <20260611185744.2498070-5-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611185744.2498070-1-m-malladi@ti.com>
References: <20260611185744.2498070-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|SA1PR10MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec39f30-5fb9-48e5-2200-08dec7eb5e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|23010399003|921020|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ESAiXLd/GxkSbF45N95NuRs0rEbgJknp535tB2xqgNQgrsmCSqQG+HZhKeflKxeKFMBoN6wub8ZAh0wCPUc9wSspx+3ufi+YrxOX83rUlnMf3GK8KjRTCKNR2cUd2zCxuUuBK8xkUItII9H9M3JyaQNhuz0LxYuQcJbvDhEQCB6O0klXK5Ai6Q3v+Fkv0fnaPdpKBUFIhJg619Q0nz3YFfQyM1+FWzns5m9dCf1fsRmGp0E+3GSeUDV/87FG6zNsRmVSOpfsxO32Xdi4vuJaWsP5Vlo6NNklLVQMsuKbu/8fj6e5Q5gM408OsFI6Emw6WeMh+K3QfKgHAPXra8/nghZmppFbCRyJ/A46z2V4dzGy2bb01UFrMTHFHH1kSvVx5Qw+NDxqw1XUsFjKZtWIVmJwLw6+xWttuy15mpTrIdr/ba8nrE5tmGmRSj7G2EncOoaRpKsE366V9bSNx8F5/MC2shrAAQ7swmx48Qj+LQlSbXMGNYtS4KAC20SvViJNeTLcpV2yst96wnJ6dLOil2hyoYgf2G83r+lVFvI7ovlpvil2wH17vSx9SJhqDi0CwWTbieF0cEs0cxIrzAJtI75E5fvf0X6WyvXnuvKXVi+DwcT1PGcilajsnKrD46+B/PjZ6Yc96K4edqDcWvY7h7SHYrGp+4QP0FJNg1Pe6Zgeihh3VbJvxodYg+aN7KMA+r95RVCVq07HpL4XD4U6a/s6qNT9xBaoUxAihRM7MgFm06om1sRuSu0/G4wBFku5NHb9h78G4Q05oLxt/pFygQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(23010399003)(921020)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	alzZf9f6XZGPSEYnjBdqbJs2dO1n1lLD6ISyQmilobD8VwlixU2EmMwKR7MzRYxZGRc7xstIxxBRb7e4vbY5jIr2ulOlFta5X6Mpl1YTKv4vAC57eIvtLbB/foBXs1BdnSucIHQOSz4v0Gnytn/1bwx18NbOIsWnbfRq/o2+2S+7gNczlXflkC+MMhVdbifA69cTcptoAXqiTQJOsY7NrLigFeLNiKHhBRAZdepXDl0JqmbBVJtbJEsij0ZQMpjB+t+LfV5eNKQ6SA6LrIoX6njEjP4ps0VHN1UprP76zWwfX4N43LOSkqwchVkkytwVrcNF1nNoAASiHHwI3yqabwsWEBlYZls1s5cy7JAGgjfAM1Rxki/xVXA2qGLzRIblo7HIYNduU7kXAE8M5uAdfXi4Rqv3zKhWnnaXTi+NfUxDabux9jqEcy72ANM/pkcz
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 18:58:04.0949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec39f30-5fb9-48e5-2200-08dec7eb5e0b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6592
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:diogo.ivo@siemens.com,m:haokexin@gmail.com,m:vadim.fedorenko@linux.dev,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:m-malladi@ti.com,m:sdf@fomichev.me,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:daniel@iogearbox.net,m:ast@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:srk@ti.com,m:vigneshr@ti.com,m:rogerq@kernel.org,m:danishanwar@ti.com,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[siemens.com,gmail.com,linux.dev,kernel.org,intel.com,ti.com,fomichev.me,iogearbox.net,redhat.com,google.com,davemloft.net,lunn.ch];
	FORGED_SENDER(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ti.com:dkim,ti.com:email,ti.com:mid,ti.com:from_mime];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298303-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07BE2674A07

emac_xsk_xmit_zc() handles tx xmit for zero copy and gets called
inside napi context. User application wakes up the kernel while
initiating the transmit which triggers napi to start processing
the tx packets. The num_tx check inside emac_tx_complete_packets()
returns early if no packet transfer happen hindering the call
to emac_xsk_xmit_zc(). Remove this check to let application
wakeup initiate zero copy xmit traffic.

Add __netif_tx_lock() to ensure that the TX queue is protected
from concurrent access during the transmission of XDP frames.
This fixes netdev watchdog timeout for long runs.

Fixes: e2dc7bfd677f ("net: ti: icssg-prueth: Move common functions into a separate file")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 82ddef9c17d5..c3f3cacdb28e 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -93,8 +93,8 @@ void prueth_ndev_del_tx_napi(struct prueth_emac *emac, int num)
 }
 EXPORT_SYMBOL_GPL(prueth_ndev_del_tx_napi);
 
-static int emac_xsk_xmit_zc(struct prueth_emac *emac,
-			    unsigned int q_idx)
+static void emac_xsk_xmit_zc(struct prueth_emac *emac,
+			     unsigned int q_idx)
 {
 	struct prueth_tx_chn *tx_chn = &emac->tx_chns[q_idx];
 	struct xsk_buff_pool *pool = tx_chn->xsk_pool;
@@ -115,7 +115,7 @@ static int emac_xsk_xmit_zc(struct prueth_emac *emac,
 	 * necessary
 	 */
 	if (descs_avail <= MAX_SKB_FRAGS)
-		return 0;
+		return;
 
 	descs_avail -= MAX_SKB_FRAGS;
 
@@ -169,9 +169,6 @@ static int emac_xsk_xmit_zc(struct prueth_emac *emac,
 
 		num_tx++;
 	}
-
-	xsk_tx_release(tx_chn->xsk_pool);
-	return num_tx;
 }
 
 void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
@@ -279,9 +276,6 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 		num_tx++;
 	}
 
-	if (!num_tx)
-		return 0;
-
 	netif_txq = netdev_get_tx_queue(ndev, chn);
 	netdev_tx_completed_queue(netif_txq, num_tx, total_bytes);
 
@@ -306,7 +300,9 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 
 		netif_txq = netdev_get_tx_queue(ndev, chn);
 		txq_trans_cond_update(netif_txq);
+		__netif_tx_lock(netif_txq, smp_processor_id());
 		emac_xsk_xmit_zc(emac, chn);
+		__netif_tx_unlock(netif_txq);
 	}
 
 	return num_tx;
-- 
2.43.0


