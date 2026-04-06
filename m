Return-Path: <netdev+bounces-275555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDz/IE6M02nFiwcAu9opvQ
	(envelope-from <netdev+bounces-275555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 12:34:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F803A2D47
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 12:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B2A63012C5F
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 10:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88C63242D8;
	Mon,  6 Apr 2026 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxDMv5uo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22DB40DFAD;
	Mon,  6 Apr 2026 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775471691; cv=none; b=FJ9vPUQgxSo8pX++Cs0aGOYlc7Cs77bz7gKQhMIHubEWlMV4i52/dTP3GbVW5fvCQ8u0tXLBX6oV1AoAdzLtNnFmwGaPicZe+12RoIP9ICOCrzmWlOq/wG9lY2/xB3Re1cV+Yuq2v/UbryIOrS8azB6X+jrEOvdtxKnq1prpusc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775471691; c=relaxed/simple;
	bh=k7JJlwi84yGGOLofZzS7mPP1hD0WkiobHK3wyYJGTnc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=txsJOHxHB/ovW3vW24wU45saFcEwUr2YkQz5hA9sLcvEglp8oFV/Aqw8M5DWfe2vESixvZwG6P0R7amTP46l8/22oJfRPztqi87Wg0a976Qja1MBJVfKyCAXpaDF0mSFzHxKbjFU6nZa6QC57U/g1gB99E+DB7OY8kQxOzmiphg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxDMv5uo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2A5C4CEF7;
	Mon,  6 Apr 2026 10:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775471691;
	bh=k7JJlwi84yGGOLofZzS7mPP1hD0WkiobHK3wyYJGTnc=;
	h=From:Subject:Date:To:Cc:From;
	b=LxDMv5uoiDF75CnKZwgbub7t23mOm4GYDxsxuY7wEaJJv1/eFCq10Stqvm3nHQZMN
	 HRwXMycW4z0aeKno8BH0SjSP23fHYmAYv5cZYi/9+jGjBIAcKW1UoXNN7BbglQ+xTs
	 mAew6Ar3rRjqaRXc58RW1MgIO9Q4ucREXgj2w32bo/bEY9BH6X5u1/Qh6X749cN94M
	 g3AKBb5eL28nI74G10pE6U4Ro8ZnqVn9QrrHkWPYNOLirxIIGtwBo4gCtj5pTtDFhp
	 P4yRU2lSlw7BQFx4Ce5pPwBImTkI7DnDP6iDR32Bp3MtBwUAf8rQ/bKkQkqe4EdV4b
	 bMDjh4JZCafAg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v3 00/12] net: airoha: Support multiple
 net_devices connected to the same GDM port
Date: Mon, 06 Apr 2026 12:34:05 +0200
Message-Id: <20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQQ6CMBQE0KuQrv2mlBaiK+9hXJTyoT9ia9pKM
 IS72xAT44LlZDJvFhYxEEZ2LhYWcKJI3uVQHQpmrHYDAnU5M8FFzSshQVPwVgMmC4/XmAgy0GG
 EvpWtUjVio2qW18+APc2bfGUOEzicE7vlxlJMPry3y6nc+q9+2tWnEjhw3ivRmarmRl/uGByOR
 x+GDZ3ED5K83IdEhrSRotEoW8T2D1rX9QOihXylEgEAAA==
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
 Xuegang Lu <xuegang.lu@airoha.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275555-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0F803A2D47
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
Lorenzo Bianconi (12):
      dt-bindings: net: airoha: Add EN7581 ethernet-ports properties
      net: airoha: Set PPE cpu port for GDM2 if loopback is enabled
      net: airoha: Rely on net_device pointer in airoha_dev_setup_tc_block signature
      net: airoha: Rely on net_device pointer in HTB callbacks
      net: airoha: Rely on net_device pointer in ETS callbacks
      net: airoha: Introduce airoha_gdm_dev struct
      net: airoha: Move airoha_qdma pointer in airoha_gdm_dev struct
      net: airoha: Rely on airoha_gdm_dev pointer in airhoa_is_lan_gdm_port()
      net: airoha: Support multiple net_devices for a single FE GDM port
      net: airoha: Do not stop GDM port if it is shared
      net: airoha: Introduce WAN device flag
      net: airoha: Rename get_src_port_id callback in get_sport

 .../devicetree/bindings/net/airoha,en7581-eth.yaml |  44 +-
 drivers/net/ethernet/airoha/airoha_eth.c           | 725 ++++++++++++++-------
 drivers/net/ethernet/airoha/airoha_eth.h           |  39 +-
 drivers/net/ethernet/airoha/airoha_ppe.c           |  45 +-
 4 files changed, 585 insertions(+), 268 deletions(-)
---
base-commit: 3741f8fa004bf598cd5032b0ff240984332d6f05
change-id: 20260324-airoha-eth-multi-serdes-fb4b556ee756

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


