Return-Path: <netdev+bounces-265405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOPPFiCBrmlfFQIAu9opvQ
	(envelope-from <netdev+bounces-265405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:13:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D276F23560F
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 048EE300DDF9
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 08:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A273624A4;
	Mon,  9 Mar 2026 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hFaNmHny"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD172CA4E;
	Mon,  9 Mar 2026 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773043980; cv=fail; b=TyTmU3q0nR2uFd7K76D9rVvzgVoyTjAKhVXKP+FfICxHEypjlwq31XnjMbsl/bSiNvPh8JOK5gT5IiCaqA4bFkL2FiPCwHBVuEWZPDSOvWow64/5WwMutZxet8r5wHTtR5nkJ7HZD1kbMj1DHepvfJiUYnqiQRs3MY4Yu49qrGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773043980; c=relaxed/simple;
	bh=+BrprJOIna6fl6Z1pap9MAudnhtXrkwqOpwZuVXUWGo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qd7f2hYKE8oaO8YF36inq7YCVYBkYNA1mrj6jf3ZzRLg3BwJ4PVtw7BHz+lCoNRbvBP0CyLKB8+3OLMyFcEDwDEJaa58fUxbMA+TBDOmQJ/kEkWuONz2tTMb0tLALEvRXsxZj7XsNdm8lHBU7AbxXQSVTEh4eoiX8qugZxdM0rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hFaNmHny; arc=fail smtp.client-ip=52.101.43.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfA+y/IwNVVSPGRUiUkrn9hS5eblOADM2MZ0h4SLUfZ+yk8SbdSIo/URZ3BMK+UqFbNeKTO6+I1iOLziWxcO709MQC4t+eC7VplO82gcZR83tHF0Uk0OZeGxtX5oYVaEFSC7swcTeeC0sc8OhBYwO4GlshCEDXNsjISTvrgXlx64B90Fz6X1dGO8Ax/3Pryk/AFb3G/+PH3+qMG0uWzA484/EWiEiH26OUYBpT8HvYpYBd67rXl9VlN7EQVehFu9RUZIBOwrxbslRv7AHXM7flDIn9qBWS2GwHfG0uQymRJ0f4HarGJjsvo6CjdM2XmTvrXCArQH7vzlNPBFL3W6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzlNO6VR185igww343ZPtr1jLf0Ftpna7k0uNXUlpZg=;
 b=CxGmaFtEGLSkXsvPc9TXofT3caQDZz/aeHOeyBoNzohRWRBNbeOLfL62415nV9oySJTQs4KuXfhlxybxUg1lP25f42GkFdVh+Zt2GTcrwTtKwb75L0L4TF39CLv5NEEccAiNOv3KJBiS254D7Dzv4rDyFOhI+ZTLfbcvQdSsTxwlpgQ3qTsJULobwlHASY0LeE7qFfAzET7Z5m4DUd8j49e8nglBiV6s9pMsV4NyUYiNv1+GWZUDky4lvWW/AxjlXsyh/aAcl5YNoySbXEsxciom9nPK26jcD1DPKozjOznmwTNurw0wyuBpFL1/XsloXr7wlgPyQsUABbKA9zO33A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzlNO6VR185igww343ZPtr1jLf0Ftpna7k0uNXUlpZg=;
 b=hFaNmHnyIzHrEONYXxYpJjeglaTqVLl6LZaHHqAmixloiEXqh38SHzuiZxo/Eiweovz6x+gXm7cxuAGv+88i6AOBgaRdWKrjDUZBr7uyrv6hI9ONAcyvibPuvW2wbpQpyb4WxFHz1Guo9hl6zOg0AznPbOzAbxBAWdpKRVTVuBJjoAKrGO6DuaxTAW9nsB7mI/WMqcvGZyn/JjgGy0fqSsHBtw4KwAKJCa3zVjZiQlS7CKGsgIelPMtq15zRkzh+K+W4+hvwfJJEHktYXpR101rpIQn4/mLu+H+TydKY3LJ7HKwVka2YZ+GHOCO1uAV7ol4gp+2FDMY0rSvFlS9ZeA==
Received: from CH2PR20CA0002.namprd20.prod.outlook.com (2603:10b6:610:58::12)
 by PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Mon, 9 Mar
 2026 08:12:54 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::d8) by CH2PR20CA0002.outlook.office365.com
 (2603:10b6:610:58::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 08:12:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 08:12:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 01:12:38 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 01:12:38 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 9 Mar
 2026 01:12:34 -0700
From: Nimrod Oren <noren@nvidia.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next] net: page_pool: scale alloc cache with PAGE_SIZE
Date: Mon, 9 Mar 2026 10:13:01 +0200
Message-ID: <20260309081301.103152-1-noren@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|PH7PR12MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: 77aadd1a-d8cd-43a2-5978-08de7db3aa0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	lz18Fa974sRPoCyjEqnWiQ/yBz20td5TVnKA/1mRfb2VTREwkoHwkMRpRVr70SHAY7cCVKSdqTDDHjBT1xP3COCZrAG1ZbK2gCecIzAKWmQFH/xVPO66K+0Z4B7TMCQkWjG/dzEA0L1M+xwfNLzoCUOXAGF1z60d9Mkrk/JEhXmrzN/alK3HW0fB6MOZ1aN9oh6zBDO5Cb/RMHD6XjH+3dEeHiyP22i3/wJezrMGgJrQxRoLXQSIEWMsurpQ1NB5fHc2Q1DGXtgwXsi6+bguBRimJlJuNmaMgkFqN4hH2yI3QxvOM/+o2Os8Wqyslmay3hkoeGwiubXS4jNKLRgJMEmQwmxfWvtLPE/Y9Q5M0tOtiuTIsinYtDRPu29FOte7xakU8UmYWyWNeFNnUJafhKVNm796R8qhOo0swEg6EN2IHZfrCq3NpcKeJcJb3/yVcyvTAmwEoljKvV9Lq0soDr5glURfCvRzxa8ruID5tXKq+wC9WhokGKgg+IBhivGx6Msj7FzUsHnnEEc572qKBaQtounfttUx8tH5+vzJ7KWUxuGlm4GESZJFcvrqcs8GeI/FT3pgtYATVUb2b2+Q9cWvLShWy5QRqn3JdwrXzsz8CtFJnSAWawOrJuypYqXm13f464oudfvYFBPnJACNCT9xVeC8hY2SpnPCMh83v0tAANMD0JGhJ/Chsd9PDU5DmOu3f6fDKdMhoBMxuQUib77wqJO+c/LF2Ez63hj8RHJN+aibvBAegX26xMxf0z2jGf5MoD5bCTW5ohqs7SmMRA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BTR5K8AXNJUxq7fP5+l8jndaBfl66iK0LHKgVYaGJYIKVjOP3vslB+CAJuFVF5rM5JxdI/SAHLeKfAh5IMfQOzu0ozMu41aoX28qVgKwy29SH0uyjSItiIkUa22l/HmTgH4GZHwIY7XkrySTl3kEId0Nho5zq/sC1fkvCIn1pk80pAYKv+tqJCCvQs80BxMAqnANSNg+fibq6CHrBoug9lT09A/Cc47top0ze6V/8UTpwUFuIGxRPpYuzj7XEbMQ2viR1IyoyqOAzkrHHasEjR3cu8s2Sg2vjf4xr6VfYWCPMytFNqO3ci2s6d09AYs562jGf7euQjcXim1db709LyHX35+o1QGRFSBJ4V7QgFOMqWWyQOvWuaB9Wf9mVa8X+wOUboi726hc14TF+DIgOdC8gM9Wa/lk17S3lp5PnM/HLXu+ODJ9SRMwd2jtPsrP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 08:12:53.7204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77aadd1a-d8cd-43a2-5978-08de7db3aa0c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6739
X-Rspamd-Queue-Id: D276F23560F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265405-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noren@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

The current page_pool alloc-cache size and refill values were chosen to
match the NAPI budget and to leave headroom for XDP_DROP recycling.
These fixed values do not scale well with large pages,
as they significantly increase a given page_pool's memory footprint.

Scale these values to better balance memory footprint across page sizes,
while keeping behavior on 4KB-page systems unchanged.

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Nimrod Oren <noren@nvidia.com>
---

Changes since RFC [1]:
- Converted from RFC to PATCH
- Scale defines instead of dynamically capping values

[1] RFC: https://lore.kernel.org/20260223092410.2149014-1-noren@nvidia.com/

---
 include/net/page_pool/types.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 0d453484a585..08ffa766c26d 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -44,6 +44,8 @@
  * use-case.  The NAPI budget is 64 packets.  After a NAPI poll the RX
  * ring is usually refilled and the max consumed elements will be 64,
  * thus a natural max size of objects needed in the cache.
+ * The refill watermark is set to 64 for 4KB pages,
+ * and scales to balance its size in bytes across page sizes.
  *
  * Keeping room for more objects, is due to XDP_DROP use-case.  As
  * XDP_DROP allows the opportunity to recycle objects directly into
@@ -51,8 +53,15 @@
  * cache is already full (or partly full) then the XDP_DROP recycles
  * would have to take a slower code path.
  */
-#define PP_ALLOC_CACHE_SIZE	128
+#if PAGE_SIZE >= SZ_64K
+#define PP_ALLOC_CACHE_REFILL	4
+#elif PAGE_SIZE >= SZ_16K
+#define PP_ALLOC_CACHE_REFILL	16
+#else
 #define PP_ALLOC_CACHE_REFILL	64
+#endif
+
+#define PP_ALLOC_CACHE_SIZE	(PP_ALLOC_CACHE_REFILL * 2)
 struct pp_alloc_cache {
 	u32 count;
 	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
-- 
2.45.0


