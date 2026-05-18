Return-Path: <netdev+bounces-288864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M2LDdSyCmpx5wQAu9opvQ
	(envelope-from <netdev+bounces-288864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:33:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E1A566BAB
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 560F8305AEFF
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 06:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E8F3E0C69;
	Mon, 18 May 2026 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uATL+Tud"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62303E0721
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 06:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779085410; cv=fail; b=e8effpil+zjg78w7jbtZyHXPiv4A++ipWt2czxAr9vU3cxHsh6m/DuKne7GTiNKTfNPjJOReb2seXWSiMzkw77MDxCULuZPHLCGkSR4pW+uys7J30pJOrkF42gM7GbQsCfMRJcvmBonBsOB3Y5Uvl+gubAq9F5+mt4sn+UJCIs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779085410; c=relaxed/simple;
	bh=ZJc2NIn76zaCHJsq4YJfDodnJ4jfQUE1NgE0nrVvZgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjFNfXmWpShgiV6nFsjDtuQUmjX9IFcemiAnqyvFObAdImK1846DJhSjrNNW3uOHWlFMygWavyJRMoC5Wck05gTnyvwU/OgnL1JKB7a+lr4Slxu/qld9SFVJAbZDIXTJ7JTmT9wV3Og4zoVPLR11RmIHJ4/3PCVPgvjHuDcdXWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uATL+Tud; arc=fail smtp.client-ip=52.101.61.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoJ7QO4ktTyTSibfVZ4YDyz074fNqzdFSqJqaqjyh3a+AWosUULIr8WqNMhrNBeITCn84AWEyOzmI17j3o4SGRfDVV3cS5znpzFCmPq21Iv/bIZLJjnKD9+qQl3Xjp3CwZQRZ9Kmb9D4F14hk2N63U1e6fIDoi1OZlcjxvdItTQO3dkRaLwziglk6r2OzebXDdS3csEFJOU6GMqVOpfsgYjkdsa2lxqVX2pbRVfMMqFB9C4FtpRotzZcJrXBH+85F6h2d7la5ic9kgRnAWt+vJ6A20zDisfhCyH5SNA9x3pvX4/l5y8dI4I1hHAjHMmB9u+1oXoBmBourLBLR/KSTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucz7DmO42S9qKU1Qd2pojiAixpzi6Gtf/ZvDYAAdt0E=;
 b=aNVKmJFPLGLIrmwqUbqC+aE3z3g7jbGj5QOgFKEZ/1+JVDGfY/AtJ9uLhet3Z5ZugbOxQv8n7wm7FwU44BJ0lSPaSVKIjTk1VUIuoYPhWGDJ4KWk7YLE2rCTOsSE7B3zFAJTOvCnhYbL5otlaM5O+bnlGX52iG1nu9g/AIqmuY0B6G40gupKl7UOePCGXnVf1Efd0iAF8b95fHY+ql3yVGu+2+PjD9nyU4okfIiIIBvvB81sJ/btNqXyKfA4fCvLeNlNa0nWWP/MSz4gCHTGwoyKL8npbOIrK2JdHthxSRy/JjRAz+KFvwK4+zjXDVSTiiVgNzasBGaZTLevs3Ebzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucz7DmO42S9qKU1Qd2pojiAixpzi6Gtf/ZvDYAAdt0E=;
 b=uATL+TudeLtI22bPmLptK3NrzeFLcwWDqtLN8+lbQ3o+vM09km72RPOvzzFwggQsJsrg7XJDaTDrZ3hVMgAI4ERObV85hRi2Q2jc5YrkjTIJseGUAVJgHwlc3ppVAnB7kgARN5/RwgcNxMsiwo0A6iZ7VBWNdC4SmBXdaAosNpVW0yvQoaCZ+XmU1ey1/yjX1EaZQgE+ehANdE8XZEx1/M1N4EqR+QzuMDBZrkrbscpWvwSMjQPpERV2YIkcMfB+UCxU2fF5ALhStdwzX+wsLXJmIc/oLkxB//nQFmGXqjI3eTm7Xfm3OS1nLPD6CyhfHRMWHKb+RIMzhiedg+346w==
Received: from PH7P220CA0064.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::8)
 by PH7PR12MB7115.namprd12.prod.outlook.com (2603:10b6:510:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 06:23:19 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::12) by PH7P220CA0064.outlook.office365.com
 (2603:10b6:510:32c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 06:23:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 06:23:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 23:23:01 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 23:23:01 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 17
 May 2026 23:22:58 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Gal Pressman <gal@nvidia.com>, "Willem de
 Bruijn" <willemb@google.com>, Dragos Tatulea <dtatulea@nvidia.com>, "Alice
 Mikityanska" <alice@isovalent.com>, Matthew Schwartz
	<matthew.schwartz@linux.dev>
Subject: [PATCH net v2 2/2] udp: Fix UDP length on last GSO_PARTIAL segment
Date: Mon, 18 May 2026 09:22:50 +0300
Message-ID: <20260518062250.3019914-3-gal@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260518062250.3019914-1-gal@nvidia.com>
References: <20260518062250.3019914-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|PH7PR12MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 404d94e1-d6af-42c3-bbab-08deb4a5f34c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|11063799003|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LpgC9WdEMxQd/FxrKKeXmYAPHP/HAO/6lrgrhKKZofIKJiWrWRfJknGGBjvDM8MLaCopYTDgQYhEOVMjYKirWshYb0P8ZIbExr0dMswt1snvOPvg58hB+Qq184LPj9/4+XqMFvdYkSgR9MqaZcvaRPiA0Fl5c7wOQU4iohG6w9VAaMQD1oGcjdPtmF+f2/TEZFigVvsDg6phxeoMUS7nYvoefbOWLO2JkmDZUq779WwoUtcq6ot7SaQc4LeOrit2oxV657/6hL5hgd/20xSt3oZssVHOe1cku9cK3+JBFsLguTUou0n2j3K2q5CAS/r6jz+8GoPaP7zbXjQnuINttCAxvoatUndg3YvE6DYieFA9H9USE+ht52G2kLs8sm9TDsVlLAWcFouBCpqCs3pimZSkp73eHCIhV1SEZ9JcgAtADn2xkYKEoZ1jIvPiuue9uCBpg1PBFHMIEJCkRhTDuuOKiy+QnVLz++uNkAD7vPP4vSThidMku3NJhhRwY3yyMFVjUKt//R7dNGyl2hL8aLk/HCp8A4ZJ/MCOfksr7JWmPPXuzYFo59GdkVqvMMHa279KVaZpmehDNurCPo5pWgd8Pma6RjxgY/mhGKQxjG3N3GRg11wSqTf33p/fHFPQfIHMlwY6zb543quMbRgkOG+ofLJgDtfW6UQFmuNcl9yUW8jlTJGnHHW6RkaFvU3kKcCk4Rlap43hRaWe8oqW8TS9naSx0jCbYt13g/qomVU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(11063799003)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	21YshMspRsY2kg105IljBkq67qf0zweoC41nsJt/7hBU9AXVc6VHAtXYZPL2gTO2T+cerDN/BY3Lor80wX4HTR8m0gyOoiQ5ouHTaTlWdv+olPS40uIfYLKDLKYQKDvKYrYxM22h6nZyyBMH0TSaz3q08RE+VPwQA2hyDl/Idol3LpfkPpqDXKp/WeBeI4JrciP1BZbBBtDcwwd4AgGh1cC2PlBrXz+Buz8RPr/Klef8Elmx8ExHsoM0DKew3U7S7Y/s4c9UQIvfwTVp/vzClptL64O0P6kKrEPXjNEJFC2BUIEEGzzS9wLSjt/lWx22Lf/NtEUiEbdStGiEg2vqWzSoeB1V1k+jenycjmhOLItFH3Aw9k1e8xyD2hSlh3qm5KLJuIChLAJrDvb6Umh8R8Y3wu/q7N7lW4ruOCobu1tw+1bYFK3oHw2r4IF7npPy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 06:23:17.6180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 404d94e1-d6af-42c3-bbab-08deb4a5f34c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7115
X-Rspamd-Queue-Id: A5E1A566BAB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288864-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Following the cited commit, __udp_gso_segment() writes single MSS length
in the UDP header.
The cited patch doesn't account for the fact that the last segment could
be a GSO skb by itself. This could happen when the size of the packet is
a multiple of MSS, hence the first segment is also the last one (there
is no need for a remainder skb).

When the post-loop segment is a GSO skb, assign the single MSS length in
the UDP header.

Fixes: b10b446ce7ad ("udp: gso: Use single MSS length in UDP header for GSO_PARTIAL")
Reported-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Closes: https://lore.kernel.org/all/6c3fb15e-711d-4b8d-b152-e03d9b05293f@linux.dev/
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 net/ipv4/udp_offload.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 2578aa7f9ff9..815396fe97ad 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -590,9 +590,12 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		uh = udp_hdr(seg);
 	}
 
-	/* last packet can be partial gso_size, account for that in checksum */
-	newlen = htons(skb_tail_pointer(seg) - skb_transport_header(seg) +
-		       seg->data_len);
+	if (!skb_is_gso(seg))
+		/* last packet can be partial gso_size, account for that in
+		 * checksum.
+		 */
+		newlen = htons(skb_tail_pointer(seg) -
+			       skb_transport_header(seg) + seg->data_len);
 	check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
 
 	uh->len = newlen;
-- 
2.52.0


