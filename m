Return-Path: <netdev+bounces-286169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGC1Czcx/2lb3QAAu9opvQ
	(envelope-from <netdev+bounces-286169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 15:05:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CE64FFB74
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 15:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8EE530069B7
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 13:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4903624A5;
	Sat,  9 May 2026 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fllg43zz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B1918A92F;
	Sat,  9 May 2026 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778331954; cv=none; b=pIMlY4mhaQW/mGQzMsqqkjP2sp5UEHDSBK+ZBkNh9+VFW52K3mQ6wkTewIcwTUyDUiT+T6g85YmIiuq6LBph0AcZvaR6dG94c/FPtSh0NoFra6YmuXrEF4y/7+oILKthge1+JsvD4NUpKeHkhzJbMqmVGv633T4bVSAnkObuUtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778331954; c=relaxed/simple;
	bh=gb7mGI1ybcfQRhKJ1hSBPApVKm8A4ms+Frof0TyZ92w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IQvdxBPPDLJfEUHhWGQ567pchwAl464X2xw72Nh8uWEEuv49MebkzVgdJ6qmnTSCZkfG6q0giEHRplcRBKX3jKiG5eaR8wVHMcVbEm8YvlEqMjydNharHkch5zqtsbGCUHIbflOHc1T90MiHn9TS5Er3hoqg2zNZQXWJWjJX47Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fllg43zz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFFEC2BCB2;
	Sat,  9 May 2026 13:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778331954;
	bh=gb7mGI1ybcfQRhKJ1hSBPApVKm8A4ms+Frof0TyZ92w=;
	h=From:Subject:Date:To:Cc:From;
	b=fllg43zzCJHEgKEch5dg4knY0W8RVzvBnjM4GCM3VZz0+AbQDdqgwbFrJicN9jvDG
	 dk+5esMVT6MdZfVuY+iDAGSM3EgGDT4eJPQEdgi0Hw4MPrmTNr7LETZfoGJwDaSzRL
	 bxNI9h1mTI9d4srcka0rI2QjQYzOCgmCloKTaC/fYeMm7tF0Kcjq2os/GMM5wNaUAi
	 +VkRW3wDt2ScyMB+4dLRZf2J6//00i6PQsTE580htayBu/DpJBZrHGvvSuFJo2D6wk
	 LE8u6TsWddccpQxt8vMGdf15IsoPJARokO3AOrEvgLyiz77QmYy6bIwT3GFEas0aM/
	 YG6+erAiDYXEg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v5 00/12] net: airoha: Support multiple
 net_devices connected to the same GDM port
Date: Sat, 09 May 2026 15:05:25 +0200
Message-Id: <20260509-airoha-eth-multi-serdes-v5-0-805e38edc2aa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNS2rDMBgE4KsEravy62ncVe9RupDsUSyaykFST
 Urw3auYQlqCl8Mw31xZQY4o7OVwZRlLLHFOLZinAxsml47gcWyZSZKWlNTcxTxPjqNO/PPrVCN
 vwIjCg9feGAt0xrK2PmeEeNnkN5ZQecKlsvfWTLHUOX9vl4vY+l+939UXwYkTBSPHQVka3OsHc
 sLpec7HDV3kHdIk9iHZIDdo2TloD/gHSP2F7D6kbpC3cLofTR/CA6TvkKFuH9I3KFihvBUOJP9
 B67r+AChiZAykAQAA
X-Change-ID: 20260324-airoha-eth-multi-serdes-fb4b556ee756
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>, 
 Madhur Agrawal <madhur.agrawal@airoha.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 26CE64FFB74
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286169-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

EN7581 or AN7583 SoCs support connecting multiple external SerDes (e.g.
Ethernet or USB SerDes) to GDM3 or GDM4 ports via a hw arbiter that
manages the traffic in a TDM manner. As a result multiple net_devices can
connect to the same GDM{3,4} port and there is a theoretical "1:n"
relation between GDM ports and net_devices.

           ┌─────────────────────────────────┐
           │                                 │    ┌──────┐
           │                         P1 GDM1 ├────►MT7530│
           │                                 │    └──────┘
           │                                 │      ETH0 (DSA conduit)
           │                                 │
           │              PSE/FE             │
           │                                 │
           │                                 │
           │                                 │    ┌─────┐
           │                         P0 CDM1 ├────►QDMA0│
           │  P4                     P9 GDM4 │    └─────┘
           └──┬─────────────────────────┬────┘
              │                         │
           ┌──▼──┐                 ┌────▼────┐
           │ PPE │                 │   ARB   │
           └─────┘                 └─┬─────┬─┘
                                     │     │
                                  ┌──▼──┐┌─▼───┐
                                  │ ETH ││ USB │
                                  └─────┘└─────┘
                                   ETH1   ETH2

This series introduces support for multiple net_devices connected to the
same Frame Engine (FE) GDM port (GDM3 or GDM4) via an external hw
arbiter. Please note GDM1 or GDM2 does not support the connection with
the external arbiter.

---
Changes in v5:
- Move qos_sq_bmap bitmap in airoha_gdm_dev struct.
- Unregister netdevice before running of_node_put().
- Move stat MIB counters in airoha_gdm_dev struct.
- Fix airoha_ppe_init_upd_mem() mac address configuration.
- Do not return -EBUSY if we try to decrease configured MTU of a shared
  GDM port, just skip hw configuration.
- use int instead of atomic_t for GDM port users.
- Add patch "net: airoha: Reserve RX headroom to avoid skb reallocation"
- Fix typos.
- Link to v4: https://lore.kernel.org/r/20260507-airoha-eth-multi-serdes-v4-0-af613b61ae02@kernel.org

Changes in v4:
- Make ethernet-port property available just for GDM3 and GDM4 in DTS
  specification
- Move cpu_tx_packets, fwd_tx_packets qos_sq_bmap fields in airoha_qdma
  struct
- Fix of_node leak removing the net_device in airoha_remove() or
  airoha_probe() error path
- Fix nbq backward compatibility
- Link to v3: https://lore.kernel.org/r/20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org

Changes in v3:
- Fix MTU and VIP configuration when the GDM port is shared between
  multiple net_devices.
- Add sanity check for nbq parameter.
- Add missing of_node_get() for net_device np node.
- Check if GDM port is shared before decresing device MTU.
- Move port forward configuration in airoha_dev_stop() before
  configuring DMA tx/rx engine.
- Introduce PRIV_FLAG_WAN parameter.
- Link to v2: https://lore.kernel.org/r/20260401-airoha-eth-multi-serdes-v2-0-ac427ae4beeb@kernel.org

Changes in v2:
- Rename multiplexer in arbiter in the commit logs.
- Rebase on top of net-next main branch.
- Add missing PPE cpu port configuration for GDM2 when loopback is
  enabled.
- Link to v1: https://lore.kernel.org/r/20260329-airoha-eth-multi-serdes-v1-0-00f52dc360ca@kernel.org

---
Christian Marangi (1):
      net: airoha: Better handle MIB for GDM with multiple port attached

Lorenzo Bianconi (11):
      dt-bindings: net: airoha: Add EN7581 ethernet-ports properties
      net: airoha: Reserve RX headroom to avoid skb reallocation
      net: airoha: Introduce airoha_gdm_dev struct
      net: airoha: Move airoha_qdma pointer in airoha_gdm_dev struct
      net: airoha: Rely on airoha_gdm_dev pointer in airhoa_is_lan_gdm_port()
      net: airoha: Move qos_sq_bmap in airoha_gdm_dev struct
      net: airoha: Move {cpu,fwd}_tx_packets in airoha_gdm_dev struct
      net: airoha: Support multiple net_devices for a single FE GDM port
      net: airoha: Do not stop GDM port if it is shared
      net: airoha: Introduce WAN device flag
      net: airoha: Support multiple LAN/WAN interfaces for hw MAC address configuration

 .../devicetree/bindings/net/airoha,en7581-eth.yaml |  52 +-
 drivers/net/ethernet/airoha/airoha_eth.c           | 997 ++++++++++++++-------
 drivers/net/ethernet/airoha/airoha_eth.h           |  48 +-
 drivers/net/ethernet/airoha/airoha_ppe.c           |  43 +-
 4 files changed, 785 insertions(+), 355 deletions(-)
---
base-commit: 8b2feced65cd3aa0597d596ed5733a1abd4c4d78
change-id: 20260324-airoha-eth-multi-serdes-fb4b556ee756

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


