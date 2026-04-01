Return-Path: <netdev+bounces-273910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEOhMHTCzGkWWgYAu9opvQ
	(envelope-from <netdev+bounces-273910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:00:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3619E3757D4
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5AD33014772
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0E53314C2;
	Wed,  1 Apr 2026 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMHR94Dg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9615A2F1FEA;
	Wed,  1 Apr 2026 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775026801; cv=none; b=lynatfq+v2AqqHxuhnJjzPLs7RNgVFxl65FVI9E3ViT+NE2AHDXc6KvLG+l0tDOREMN/c7dS5GqQKIPRasaJ5PGi1t8GBLgp2HAn1i9/N2ZnTqGEeAHOy8Rx/mnn0xeQopAk7WgOsr2mn1MnzRXFCdpC0DV+Gz9WhC3oIunL0kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775026801; c=relaxed/simple;
	bh=4HoH/phdBrc8oyL9BAmfrv1hLzyLn1XUdnpO9xKGt0A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=azphTUUHkDiQSM9J5n9yBad2tMAhVXsMwWdoID9swqUZKXD2A7iLEUhSPw9HZlpTJrjC5RKONqeW0HKE/MCP3JDPGGFLbUarqaqrHJvUou897Gj7BQedGjrphaMsBM8t8RdzBs9DVSCovOkvxb3tpMbGa9W+XylXXpHL88sRmQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMHR94Dg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFC6C4CEF7;
	Wed,  1 Apr 2026 06:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775026801;
	bh=4HoH/phdBrc8oyL9BAmfrv1hLzyLn1XUdnpO9xKGt0A=;
	h=From:Subject:Date:To:Cc:From;
	b=KMHR94DgfRfOsfxuCdVVQP2+x0xQMgUCkKVaQ81WrDYnarnEtMItaUpDVYAYil9tF
	 DXanx74oixguSoHPe8XgMxIpsWv2hz/L2eckJm7zW7r9couPmi8qJL4Uw1zdhDnuM9
	 mdk/l2Lcw9gvPUrS+6JKCltA/PSW+2AERYiHyy87dq0ynJvZ7aLB5JIjJHWpaYYDoB
	 bFHTu4EHd+hnpXEHWdQ2rSdyURSpvJV3l2I4zuMqmysnGKIaBRzrUYO/oqN6bGkXeH
	 W4B3k5YSUEQaFzD1fbzdsVQiYsYETySEdt3NsD4tHAfrFRpXx434u71PxTmv9pc4p9
	 aCrfz3qi1Wh8A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v2 00/11] net: airoha: Support multiple
 net_devices connected to the same GDM port
Date: Wed, 01 Apr 2026 08:59:18 +0200
Message-Id: <20260401-airoha-eth-multi-serdes-v2-0-ac427ae4beeb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0Jm7ZhSaI2uvIdhUWCgE7ElbSUYw
 t1tiFuXLy///Q0iBaYIt2KDQAtH9i6DPBXQWeNGQu4zgxRSi0rWaDh4a5CSxdd7Sow50FPEoa1
 bpTTRRWnI6znQwOtRfoCjhI7WBE02lmPy4XNcLuXhf/Xr3/pSokAhBiX7rtKiM/cnBUfT2YcRm
 n3fv5vISCTJAAAA
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
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273910-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3619E3757D4
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
Changes in v2:
- Rename multiplexer in arbiter in the commit logs.
- Rebase on top of net-next main branch.
- Add missing PPE cpu port configuration for GDM2 when loopback is
  enabled.
- Link to v1: https://lore.kernel.org/r/20260329-airoha-eth-multi-serdes-v1-0-00f52dc360ca@kernel.org

---
Lorenzo Bianconi (11):
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
      net: airoha: Rename get_src_port_id callback in get_sport

 .../devicetree/bindings/net/airoha,en7581-eth.yaml |  44 +-
 drivers/net/ethernet/airoha/airoha_eth.c           | 631 +++++++++++++--------
 drivers/net/ethernet/airoha/airoha_eth.h           |  30 +-
 drivers/net/ethernet/airoha/airoha_ppe.c           |  43 +-
 4 files changed, 502 insertions(+), 246 deletions(-)
---
base-commit: f1359c240191e686614847905fc861cbda480b47
change-id: 20260324-airoha-eth-multi-serdes-fb4b556ee756

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


