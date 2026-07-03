Return-Path: <netdev+bounces-304459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yB4DLSSAR2qgZgAAu9opvQ
	(envelope-from <netdev+bounces-304459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:25:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 584357009D4
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:25:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SJUij5X3;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304459-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304459-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9DA23013A68
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 09:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB543ACEF4;
	Fri,  3 Jul 2026 09:20:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F8F381EBB
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 09:20:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070410; cv=none; b=LuLE7fFlz/7joKhQh5YiGajqYxqhjh+2d1UKw427zFNTiCRGTzLtM2DCpMDV/JgAcC9pjLPTlQIeLKFFKOBcYLbGOF06LYPXSJo0E+hKt6L2ebHHkIRaUyBKLrZaxNaF1AW19VytCArfnBfiddr1Qqz7bKTwhAiwhAMw92FgGSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070410; c=relaxed/simple;
	bh=Xn1HFity6Lg3JoP1pTZN1ZVZKVQmkQ5GJNW8NnAt2sM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AHFZngF/bzd8jo7f9OWAJ3pn5qAWrVKny/tT03d+LXPpRmEmYbWQyBSGWGx7JT4r5EAN0k2oI/CM1HYGCJEa5jJD9HUneJRaP72Y6+E0+LBjaIY/QdA8Mq7IjhJyLKOnDhkRUQvE4WYmlCSIkbMko8cGfsfv2Fr6pYGSZsrp2GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJUij5X3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A265C1F000E9;
	Fri,  3 Jul 2026 09:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783070409;
	bh=8avXWQARkeiSCL69SLt7SOMVDKzGcDbduYcPsftLroI=;
	h=From:Subject:Date:To:Cc;
	b=SJUij5X3FQRUPi5L1yrtICjMKHvaVmCOxHsENFe7wPDzYHYGKRvI4OehI0tjGBEBL
	 BQcGAnPEVGszTJRfnjhm0rZKl2nDmaOEGEtdZQCMp4rl87M1iN3lo5c2hY4dMXSw8A
	 WuYvOTtRDCnl7NqqoF5sPpim/vswLVhEEMWNUEYmtaQlhNu0LZV3y1mYI/MLDKw+O4
	 B5hqa4sxZxOejJMAZaTjo1gqCh5kqoEKy/x2fEOPvwRzCZ0hKnXOQ0ASiYfhJAJplI
	 6S57VSUKqYb0nY1ZelWAQRZIHoynkhGtq/QRU0HzT8O9zg2G0Of6Xuhq6s6LIIeTyp
	 k5EDduz4WgVhQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v8 0/3] airoha: add the capability to configure
 GDM3/GDM4 as WAN/LAN on demand
Date: Fri, 03 Jul 2026 11:19:24 +0200
Message-Id: <20260703-airoha-ethtool-priv_flags-v8-0-015ba5ac89ee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QX2vEIAwA8K9y+DyHUav2nvY9xhj+ia3sqIct5
 cbR7z7pyzoKMgKBEPJLyJPMWBLO5Hp5koJrmlOeamFeLsSPdhqQplBrwhlXrAa1qeTRUlzGJec
 bvZe0fsabHWbqlLWa+ZoMI3X+XjCmx26/kwkXOuFjIR+1M6Z5yeV7X7rC3v+HvwIFKhk47vuIf
 YS3LywT3l5zGXZ25UdKtyheKS2519YCguEnShwp06JEpQQaFMGLqKE7UfJAAWtRkjKqGJreR24
 i2hPVHSloUV2lPEBAZqRR4fwrdaB436JUpYxyXjEWBDh/ovQvpVnzKl0pJ6ETLkgpuflDbdv2A
 +kLOUiPAgAA
X-Change-ID: 20260606-airoha-ethtool-priv_flags-b6aa70caa780
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, Madhur Agrawal <madhur.agrawal@airoha.com>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304459-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lorenzo@kernel.org,m:horms@kernel.org,m:aleksander.lobakin@intel.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 584357009D4

Add the capability to configure GDM3/GDM4 as WAN/LAN on demand when QoS
offload is created or destroyed.
Make dev->qdma an RCU pointer so the TX path can safely dereference it
without holding RTNL.
Introduce airoha_qdma_start() and airoha_qdma_stop() helpers.

---
Changes in v8:
- Rebase on top of next-next to fix conflicts.
- Link to v7: https://lore.kernel.org/r/20260701-airoha-ethtool-priv_flags-v7-0-b4153bd44428@kernel.org

Changes in v7:
- Fix ETS stats accounting in patch 2/3
- Reset ETS stats accounting in airoha_dev_set_qdma().
- Link to v6: https://lore.kernel.org/r/20260629-airoha-ethtool-priv_flags-v6-0-86bc600d31bc@kernel.org

Changes in v6:
- Rebase on top of next-next
- Add patch 1/3: "rename airoha_priv_flags to airoha_dev_flags"
- Drop patch 2/3: "refactor QDMA start/stop into reusable helpers"
- Link to v5: https://lore.kernel.org/r/20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org

Changes in v5:
- Add patch 1/3: use int instead of atomic_t for qdma users counter
- Protect dev->flags with flow_offload_mutex mutex.
- Introduce AIROHA_PRIV_F_QOS in order to handle better WAN/LAN
  switching.
- Link to v4: https://lore.kernel.org/r/20260610-airoha-ethtool-priv_flags-v4-0-60e89cf28fea@kernel.org

Changes in v4:
- Move back QDMA TX/RX DMA enable to airoha_dev_open()/airoha_dev_stop().
- Configure GDM3/4 as WAN if GDM2 is not available in ndo_init()
  callback.
- Protect qdma pointer in airoha_gdm_dev struct using RCU.
- Rely on rtnl_dereference() to access qdma pointer in the control path.
- Add airoha_qdma_start() and airoha_qdma_stop() utility routines in
  patch 1/2
- Link to v3: https://lore.kernel.org/r/20260608-airoha-ethtool-priv_flags-v3-1-3e8e3dc3f715@kernel.org

Changes in v3:
- Do not introduce ethtool private flags support to configure LAN/WAN
  for GDM3/4 and rely on tc qdisc offload for it instead.
- Set GDM3/4 ports as LAN by default.
- Move QDMA TX/RX DMA enable from airoha_dev_open() to airoha_probe()
  and the corresponding disable from airoha_dev_stop() to airoha_qdma_cleanup().
- Link to v2: https://lore.kernel.org/r/20260607-airoha-ethtool-priv_flags-v2-1-742c7aa1e182@kernel.org

Changes in v2:
- Rework airoha_dev_set_wan_flag routine
- Enable GDM_STRIP_CRC_MASK in airoha_disable_gdm2_loopback()
- Do not always reset REG_SRC_PORT_FC_MAP6 in
  airoha_disable_gdm2_loopback() but use the same condition used in
  airoha_enable_gdm2_loopback().
- Link to v1: https://lore.kernel.org/r/20260606-airoha-ethtool-priv_flags-v1-1-401b2c9fe9f1@kernel.org

---
Lorenzo Bianconi (3):
      net: airoha: rename airoha_priv_flags to airoha_dev_flags
      net: airoha: fix ETS QoS stats counter underflow and cross-channel corruption
      net: airoha: defer GDM3/GDM4 WAN mode and GDM2 loopback to QoS offload

 drivers/net/ethernet/airoha/airoha_eth.c  | 253 ++++++++++++++++++++++++++----
 drivers/net/ethernet/airoha/airoha_eth.h  |  26 ++-
 drivers/net/ethernet/airoha/airoha_ppe.c  |   9 +-
 drivers/net/ethernet/airoha/airoha_regs.h |   1 +
 4 files changed, 246 insertions(+), 43 deletions(-)
---
base-commit: 6fb33632323a396c9dc2bb9bea483e013e547d57
change-id: 20260606-airoha-ethtool-priv_flags-b6aa70caa780

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


