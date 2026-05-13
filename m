Return-Path: <netdev+bounces-287457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCWmENorBGoSFAIAu9opvQ
	(envelope-from <netdev+bounces-287457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:44:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC0A52EDAA
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B701E300E722
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 07:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A603D649C;
	Wed, 13 May 2026 07:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jTtDJfLb"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E240F25B09C
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 07:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658263; cv=fail; b=e9Qe8ND7DAWY/dW77H+S4IQ6QoKEWBHdi05aa6HNgtjLBBnvyHoO56lOoHpFBWnoeLfVLCfirlMdlcZyseG9AQ1Yj+oJq/R93CprVVmkz9A9h9JpCJdyyH9feYBWyWlDypfBNdlL40Z36ZLlhPls1vrWw91vmIBNW9zGjifkaMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658263; c=relaxed/simple;
	bh=V5wFxU7gI/elhjKkDD3akBEQa9DsPGxVBOafaBXB5Ig=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gH61Regk6ZL+jAmZoVppvgrareWjJoD7fypzd/nIt+GUETsplqLXf+osPmGtbPSylEAKIe8msglMH1kKTEBUUOa7w1PeO8sIqRP405qlFhIGb069YLwmzrTqz4u214brQ3Gmn9GcdSb6zKQsr65KTHvzMvN7hu2wRdDGdHCjCG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jTtDJfLb; arc=fail smtp.client-ip=40.107.209.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U64LbfYdTyssEMfFis+EFxJ86tzTUThZOg2/Xrvrlt0aGQUTAJpsTXUYCYBOdViY5PKdeRGBhofbMociCVIS4qfrB88Jbd1agB8M7tXFRFLTOz2M4plOKEEqtPngoMpzVocy8MgexKcOX/iRfY4/C8MSRDDJ1Ef38GEJdlAzdUb3rBVQOfeTfjCN51PQodAMLyOeXWJmXLd+GkYQgJrWkjEsxqaBidQGVELt05OsdHnxMeQc9/zSskR4/1I4t5k6u0RwO+o4xK4wcgofHaFM9e3zdQnk2OPnE6OHZ+fr+4UZRB7Cyc9Y6reOG+HsPnxMCpUd789SPq2FtaAPMm8djQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAcRunDjZjSkQcPhZQXYhUWRjxadocBQl7qRiYqXSy0=;
 b=zRNMKwcwt9ubU94lR+YY8V3LkB2hnH+TXb1YHzYi/qN6XMpR0L6skoNvdyrNEfvZzm0iK1jOau4j2BQ/1xMlN///QrlgkrGoIvNd7C2k+QvA2f6U2Y4ubG8tXyUtGFTpxc7PjlIdllQk2utdb758fpBTNJ8Hp2YSqZCU7pRkmmJVXKwA3014kfTYpiPMhG5wjazdRlhZTzmbh+IFO6y+3n7udhqZb77Xr4gLPjJ2Z5613c25ipBNJREKn+wKR+bmgj2B43Pguka/812C8hzH25veD5CL+/PRPA1lNr1UCONHJNk3vMLhfufbsdWCL98ql80PLNqX2qSgASRYh884hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAcRunDjZjSkQcPhZQXYhUWRjxadocBQl7qRiYqXSy0=;
 b=jTtDJfLbj1fyR8oqvBZyxxleVVWkSA/zq69lCAfvTJu0rg9NH7W9ubk9+SBrkRtYi6IUHS6e/yHzqNoPyJHl+J+NhB+eBdiq0zZm5NR93N9j4eaT5g/LM8qSfROfV3d6OMFDxvCmARSWGHou8GH5NmQwShwtAXLom1aqAnziPmTBjk4plSnWz99pKsAT1U3UomfmepwS6T5cKVkm98JBqQCyxo8LW6TGkhdze5dYSpJMpS2D/hxWCH+HGKltv6/7J5temQT4q97K4hHHi+BDg6ufcB0Zqv5fvUkYr13gc/zYb705rXzQ4Of17CPnHCdsTH3EMBE1R9TghFp+jaTYpw==
Received: from MW4PR04CA0217.namprd04.prod.outlook.com (2603:10b6:303:87::12)
 by MW6PR12MB8664.namprd12.prod.outlook.com (2603:10b6:303:23c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 07:44:16 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:303:87:cafe::7) by MW4PR04CA0217.outlook.office365.com
 (2603:10b6:303:87::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Wed,
 13 May 2026 07:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 07:44:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 13 May
 2026 00:43:52 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 13 May
 2026 00:43:52 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 13
 May 2026 00:43:49 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
	Willem de Bruijn <willemb@google.com>, Gal Pressman <gal@nvidia.com>,
	"Matthew Schwartz" <matthew.schwartz@linux.dev>
Subject: [PATCH net] udp: Fix UDP length on last GSO_PARTIAL segment
Date: Wed, 13 May 2026 10:43:49 +0300
Message-ID: <20260513074349.2152146-1-gal@nvidia.com>
X-Mailer: git-send-email 2.52.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|MW6PR12MB8664:EE_
X-MS-Office365-Filtering-Correlation-Id: e425d3a1-efa0-4f0a-4c54-08deb0c36e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|13003099007|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	sp2PDkEgdoAkq6QMtbfHQtMqCQK1cLzgpAvNdOpKfBjUxlkoPNrY7YDpyCdWdKUrsXC/C2CU/KNysGfSLjjZzB3oAqom0RPKzRJq/qriUK7T6woTq1o3nM9J6S7sHdZcajh3MJW2/kJhpDTNsxuIDJzy2kGQZKIjKSIC54sWvTGWaBBmECE8l8AzlamUa1cq40lUaoUuZEXMcVNJEyhyr2Ii9UecKhoXqseEMOK9pXi2Jet07km5a88hy80YXCL+mH0tci5qeqMfLgdZStIOR/vs7VJuruEkKjpwQJe4P/v6lR+mrEjvc3L6rE9y7tGZQekwOaQXM8ajJCqIKY723Ipvj1lxRNVdiVCI+eQMdU4QwuWaWU2PDWM+K1CgwQLUuiBZAs1Q4HTMi7C/1B0iQbzxwqEf3cVCMFhB22MTZ3WaNeD/+nIL1z60no0Ldh8BrPFZLfLrzjs6QQJk9r+aeFdLHpVx3H0pNrgmaNs0y39dUNwAU2I296lejQIam6nqENbISDld2pQYoecSrSjn42C+bJ0CwaazwfqA8fHIFdF8lajFvLMRachEbym8Bizyy+j3VCcscHMRKpq6sXDCOl+z3SrvU+0OAch1wqDGyY3HwLOv5eb5mF0ebHKn0ieGAa20flCDDllU1QwkxLgLClXnV62H2OpZAvunCApKvcgBOLf3Zl+i0V4eb+TdcdM4oISeJvS7E7WQ8jEheGgpORpHIuBJhxBytLS5yKD1ULT3dwVTRb2/lm0+XxHo5vRv
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(13003099007)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qgiLbpL/BTxNs8tDHe26aZoGu8m2t/ulmEBVinDkOHF8IyFnP4ElpY062T3zNaISteInaC2XhMChjZ32ccXRzS1Fto/ikIC3yHM5FBgWkQQXX9Dkf5v0tywszKsEA3QCB4Ye7VrgvzHFKmd3xZOBc1xE/xHcudBluAyyGorILGz6B7spkWBnyAHq7XGgX4lyiXQS7QWDOSf82TVbsBrDUMjC7c8LZBtJOLgRp2XN1W+N0RugFvPhT1C1RotjMqqqcF3C0VGUmyfFUaI19mbycfDsUqky7/pYqFEjq+21S2/vqIhG+SRmHUeYAzVANilpnHumQRy9IURLtOJWuLhl7etPMF6hL2oJsjJPSWjxlv9C7DoY/YIqFvglUL1n2MZNsUk9yZxFNnoFMvqb5L/FGp4Jae7libWqV1NVvGh3vWE0IoQ1/zHWycIrxY6MXxeK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 07:44:14.8575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e425d3a1-efa0-4f0a-4c54-08deb0c36e5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8664
X-Rspamd-Queue-Id: 8CC0A52EDAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287457-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,linux.dev:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
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
 net/ipv4/udp_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index a0813d425b71..71df45f9488a 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -604,7 +604,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		       seg->data_len);
 	check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
 
-	uh->len = newlen;
+	uh->len = skb_is_gso(seg) ? msslen : newlen;
 	uh->check = check;
 
 	if (seg->ip_summed == CHECKSUM_PARTIAL)
-- 
2.52.0


