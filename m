Return-Path: <netdev+bounces-289336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBZ7HTIqDGq0XwUAu9opvQ
	(envelope-from <netdev+bounces-289336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:15:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9D757B0BA
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AD4230E5C4B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C213F58CE;
	Tue, 19 May 2026 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWScUoue"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897EB3F58C5;
	Tue, 19 May 2026 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181099; cv=none; b=tMnav9EQtnjq6cCsyJ/JityeRdh6IEVNWJAZB9hDpXm8ekaxyHkdwouHdV8hbJECW6mGGL9nBGDGgIsxbjaYAFS3M4fjOj8yWXVSCzIwEkP1Wmymt4b14EcwV/ycLXDY8fgLfidRa7r4hFILlkCZnuyKMvin7PLZpJ+amBQAInw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181099; c=relaxed/simple;
	bh=Klu9x/Jv2kB18rShot8JT/954KOo6KDVE2s8WukpTUU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XAVcgwDpM0TE7jvK58V+dMHRYDDK6hlOyyf+YwuYN35cRHKNHwODXBLHm7/kjyargmotpC7wi6SDdxIb1W5ip1JjKY/nUmGdIjmI/LXUjIgQRPDGNPhXa3zjvcduwPPGVWAIFUrjJrh3C/rtv4kLiXJEuut+iXj3jaJR3DADR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWScUoue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006ADC2BCC6;
	Tue, 19 May 2026 08:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779181099;
	bh=Klu9x/Jv2kB18rShot8JT/954KOo6KDVE2s8WukpTUU=;
	h=From:Subject:Date:To:Cc:From;
	b=VWScUoueqTDmD1dqBWCwMZt7XMyrIS/Ki2YYM9IhtmDOdF2Y1jmeLyT/lONzRLdAn
	 C77NB3CEdYbp8FcJ/ao7x7NiDI4xr3vRDNTf9cz5ayS04+BlOd60QerobORLZgXLRm
	 S5ElckmTYoODsIXkcy8loxbUaBnBE0DHzHo3u0O1eG2ZP/T3XGlF1k2TE3sunxc6ZE
	 pFwnIpoWX4gcTG4WLPbVQjr7mCHLW4IrmMVTz6T/5h0nW88qSoGEzrvx7ejaiEIpEG
	 eD6Ly+M5veW76u8E5epO1TUYn8Zhp+2tFrTJIQzQ13beZrssUZexCcM4QpnqP1O0Dh
	 lEtSr2VaCURoA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v8 00/10] net: airoha: Support multiple
 net_devices connected to the same GDM port
Date: Tue, 19 May 2026 10:57:43 +0200
Message-Id: <20260519-airoha-eth-multi-serdes-v8-0-6bd70e329df6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33QTWrDMBAF4KsErasy+re66j1KF5I8ikVTuciuS
 Qm+exVTiIuxl8NjvmHejQxYEg7k5XQjBac0pD7XoXk6kdC5fEaa2joTDlyD4JK6VPrOURw7+vl
 9GROtQIsDjV56pTSiUZrU7a+CMV0X+Y1kHGnG60jea9KlYezLz3JyYkv+p9tdfWIUKEBUvA1CQ
 3CvH1gyXp77cl7QiT8gCWwf4hVyQXLjUHpEv4HEGtL7kLhDXqOTtlU2xg0kH5ACsw/JOxQ1E14
 zh8A3kFpDBx2pCjWgUDTYBu62HekVxA460hUKjbVS8yCjURvIrKGDjkyFrEUAKwQI/P/aPM+/J
 7B45n8CAAA=
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289336-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6F9D757B0BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Changes in v8:
- Fix dts schema issues reported by sashiko.
- Fix possible NULL-pointer dereference in patch 2/10.
- Fix max mtu computation in airoha_dev_change_mtu().
- Link to v7: https://lore.kernel.org/r/20260516-airoha-eth-multi-serdes-v7-0-99e0093303e2@kernel.org

Changes in v7:
- Fix dma_sync_single_for_cpu() size in airoha_qdma_rx_process().
- Fix hw stats reset.
- Fix typos.
- Add fix for airoha_tc_remove_htb_queue queue index.
- Fix dts schema issues.
- Remove hw stats patch from the series.
- Link to v6: https://lore.kernel.org/r/20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org

Changes in v6:
- Reconfigure REG_GDM_LEN_CFG() whit max 'running' MTU in
  airoha_dev_stop().
- Fix port staring MIB counters in airoha_update_hw_stats().
- Fix regression in TC_HTB_NODE_MODIFY command.
- Fix length check in airoha_qdma_rx_process().
- Fix dts schema.
- Link to v5: https://lore.kernel.org/r/20260509-airoha-eth-multi-serdes-v5-0-805e38edc2aa@kernel.org

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
Lorenzo Bianconi (10):
      dt-bindings: net: airoha: Add GDM port ethernet child node
      net: airoha: Introduce airoha_gdm_dev struct
      net: airoha: Move airoha_qdma pointer in airoha_gdm_dev struct
      net: airoha: Rely on airoha_gdm_dev pointer in airoha_is_lan_gdm_port()
      net: airoha: Move qos_sq_bmap in airoha_gdm_dev struct
      net: airoha: Move {cpu,fwd}_tx_packets in airoha_gdm_dev struct
      net: airoha: Support multiple net_devices for a single FE GDM port
      net: airoha: Do not stop GDM port if it is shared
      net: airoha: Introduce WAN device flag
      net: airoha: Support multiple LAN/WAN interfaces for hw MAC address configuration

 .../devicetree/bindings/net/airoha,en7581-eth.yaml |  56 +-
 drivers/net/ethernet/airoha/airoha_eth.c           | 833 +++++++++++++++------
 drivers/net/ethernet/airoha/airoha_eth.h           |  47 +-
 drivers/net/ethernet/airoha/airoha_ppe.c           |  43 +-
 4 files changed, 702 insertions(+), 277 deletions(-)
---
base-commit: 7a348a95f696d20f15c776de4df8b4415bcf3d77
change-id: 20260324-airoha-eth-multi-serdes-fb4b556ee756

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


