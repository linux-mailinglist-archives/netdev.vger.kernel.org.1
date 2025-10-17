Return-Path: <netdev+bounces-230385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02834BE76B5
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 11:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D12E506646
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A511D30CD91;
	Fri, 17 Oct 2025 09:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzaJkJEU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8C830B50B;
	Fri, 17 Oct 2025 09:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691991; cv=none; b=FUCjZGydUc4bYwN18DMV69o2OcX74i95yqTRhwlOEjmtUcPBMzfqxIupNl9gzTLZfNI6UX6JYMUCLMECzTA2WlAE9ODQ0qvSwoKwnw5Gi/aCSWwqmBfMwr8bO2dsWNj6iopT/znwI0YEaQZgwLLCkVE/Lt0cpjtozldGvH+SNSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691991; c=relaxed/simple;
	bh=KV5DmgyqFakOTVbuIKJ6b4T9d5atMUomV8W9aWsMh6I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nVGBNlztbIXUN0owzphoQxTz5IQVPAU8TEbvq6RLc5/HR/fVfHxbXdkTfn/5aRIQnfpHw7dQF0kC19axxBT83PtG31KYEkikInpJ8rLmGXkBkkNsHSx8YMu/lkFWllhR4NEWK398z+vHgSkr2877+8cMgGorum1G0e7xY9fmLpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzaJkJEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648AFC4CEE7;
	Fri, 17 Oct 2025 09:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760691991;
	bh=KV5DmgyqFakOTVbuIKJ6b4T9d5atMUomV8W9aWsMh6I=;
	h=From:Subject:Date:To:Cc:From;
	b=tzaJkJEUBeZ1QXa46ol3Fc5KIZ53kYMEbiqp7CsIkmHTh1knTvpHCfguF0LRol+oN
	 cJfqoMdTPD+0j8EzEJ+8NxsiU3Q3JkOXwP43jOik4Yi77nKhC1F6C0JTH7ZvR0ASlx
	 vE3DuBMGwWVlUrmvhF4okObfg6lAtXdt7NstYEZuwiPgHFR7o0NAk1WTKI+UGQbnoi
	 0WymbAoKhwOORJK39Poq2L1mfi/++vza+7hGUYVwA+3BTMHbq92dRvSPT6yhAWZ2hx
	 Q4U47fexN0UcoeaSuLJ0FImSXamb2O8Ewss5cZP5HbQaHv0ExqPOKn7Qfzc3a0/jhx
	 m33xvLf8bDYEg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v3 00/13] net: airoha: Add AN7583 ethernet
 controller support
Date: Fri, 17 Oct 2025 11:06:09 +0200
Message-Id: <20251017-an7583-eth-support-v3-0-f28319666667@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAEH8mgC/23NywqDMBCF4VeRrDslFxMvq75H6SLqqKElkcSGF
 vHdG6WLFlz+B+abhQT0BgOps4V4jCYYZ1OIU0baUdsBwXSpCadcMkpz0LaQpQCcRwjPaXJ+BqZ
 5zzuVV6KkJB1OHnvz2tHrLfVowuz8e/8R2bZ+OSaPuMiAAlV5KWVPZcXF5Y7e4uPs/EA2L/JfQ
 x0aPBmoFRZY6bbpmj9jXdcPdq/39fkAAAA=
X-Change-ID: 20251004-an7583-eth-support-1a2f2d649380
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Simon Horman <horms@kernel.org>, 
 Christian Marangi <ansuelsmth@gmail.com>
X-Mailer: b4 0.14.2

Introduce support for AN7583 ethernet controller to airoha-eth dirver.
The main differences between EN7581 and AN7583 is the latter runs a
single PPE module while EN7581 runs two of them. Moreover PPE SRAM in
AN7583 SoC is reduced to 8K (while SRAM is 16K on EN7581).

---
Changes in v3:
- improve device-tree binding
- rebase on top of net-next main branch
- Link to v2: https://lore.kernel.org/r/20251016-an7583-eth-support-v2-0-ea6e7e9acbdb@kernel.org

Changes in v2:
- rely on IS_ENABLED(CONFIG_NET_AIROHA_FLOW_STATS) instead of ifedef
  CONFIG_NET_AIROHA_FLOW_STATS in airoha_ppe_get_num_stats_entries
  routine
- return number of stats_entries from airoha_ppe_get_num_stats_entries()
  and airoha_ppe_get_total_num_stats_entries()
- remove magic number in airoha_ppe_foe_commit_sram_entry routine
- improve code readability in airhoha_set_gdm2_loopback routine adding
  some macros
- improve commit logs
- remove magic numbers in airoha_ppe_foe_get_entry_locked()
- Link to v1: https://lore.kernel.org/r/20251015-an7583-eth-support-v1-0-064855f05923@kernel.org

---
Lorenzo Bianconi (13):
      dt-bindings: net: airoha: Add AN7583 support
      net: airoha: ppe: Dynamically allocate foe_check_time array in airoha_ppe struct
      net: airoha: Add airoha_ppe_get_num_stats_entries() and airoha_ppe_get_num_total_stats_entries()
      net: airoha: Add airoha_eth_soc_data struct
      net: airoha: Generalize airoha_ppe2_is_enabled routine
      net: airoha: ppe: Move PPE memory info in airoha_eth_soc_data struct
      net: airoha: ppe: Remove airoha_ppe_is_enabled() where not necessary
      net: airoha: ppe: Configure SRAM PPE entries via the cpu
      net: airoha: ppe: Flush PPE SRAM table during PPE setup
      net: airoha: Select default ppe cpu port in airoha_dev_init()
      net: airoha: Refactor src port configuration in airhoha_set_gdm2_loopback
      net: airoha: ppe: Do not use magic numbers in airoha_ppe_foe_get_entry_locked()
      net: airoha: Add AN7583 SoC support

 .../devicetree/bindings/net/airoha,en7581-eth.yaml |  35 ++-
 drivers/net/ethernet/airoha/airoha_eth.c           | 254 ++++++++++++++------
 drivers/net/ethernet/airoha/airoha_eth.h           |  65 ++++--
 drivers/net/ethernet/airoha/airoha_ppe.c           | 259 ++++++++++++++-------
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c   |   3 +-
 drivers/net/ethernet/airoha/airoha_regs.h          |   6 +-
 6 files changed, 439 insertions(+), 183 deletions(-)
---
base-commit: 7e0d4c111369ed385ec4aaa6c9c78c46efda54d0
change-id: 20251004-an7583-eth-support-1a2f2d649380

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


