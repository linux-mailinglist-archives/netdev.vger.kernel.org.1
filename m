Return-Path: <netdev+bounces-180668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB16A82146
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 11:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073D1188C4F2
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A9B2512D6;
	Wed,  9 Apr 2025 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbUfYfs5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E570322DFA2
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744192058; cv=none; b=kfr3rVm+ZWcg7WiOuKRF9bp4jxtpMjvQK/6sFAAkbce0Wb4w/f4qzX9o51gdEQd66ZVp+CP4WFLQS6LiH0usvK6QWF5g+5jox+O56CMlZOzYTw84Hxlxhgzn84z1OlO4aM7kFqavRabVjhl+78Q9mJ5dyllDx7MlQKg5drC/rlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744192058; c=relaxed/simple;
	bh=+m0+N46haligEw11nrASxYuR/7DydAeoOe7+i2M73fo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FhvVPvsSxhM4gjl/W5hPJiZG/Dk/IISIaOVkc25UTMaVSVsjywM2BqLdrPn0xtUtWk0T5FC1pa3GyUryBS6HZOtbR8ubi+9NMrCSTB7HC4aktqv7N34ClwkyCuADRJd9o/hZUx6eguifGD92rLhOKnf9q/iFYg8Ohg1ak60dhSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbUfYfs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18ADBC4CEE3;
	Wed,  9 Apr 2025 09:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744192057;
	bh=+m0+N46haligEw11nrASxYuR/7DydAeoOe7+i2M73fo=;
	h=From:Subject:Date:To:Cc:From;
	b=rbUfYfs5XOo5tkvyZq39tMu8b4hVDMHci6cq/9DXOBwaKcXCKkRskse6SYupSxtEQ
	 75FRODDHVTWK1FHXjUg1asgP7As971PPBF6wObzRNrQ5BF2Kw846N8HtKpvL3UmWil
	 zbgYe6lPLEWyNRhuz2PVaWXJlFjSZzn9MFYnJPZM+Dhe3dq5E/+Cvo0feP5Ind+ski
	 PrqqBftR8k8UJ2GJAyI4nnQls9+jxDIVwNziaT0MKOiwcuaSmt24xE9M5/EmAKlDjQ
	 d+90Ct/JS+RIUL179++0TBJYmhTRdH8t+KmaMxLw5UfZXIXW8ObK4dgMC1oSh/sMEY
	 X6L7Kym3CSMvA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v2 0/2] Add L2 hw acceleration for airoha_eth
 driver
Date: Wed, 09 Apr 2025 11:47:13 +0200
Message-Id: <20250409-airoha-flowtable-l2b-v2-0-4a1e3935ea92@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACFC9mcC/22NwQ6CMBBEf4Xs2TVtoUI8+R+GQ5EFNjaUbAlqC
 P9uwatze5PMmxUiCVOEa7aC0MKRw5jAnDJ4DG7sCblNDEYZq3Kdo2MJg8POh9fsGk/oTYOkGqv
 awuVGW0jTSajj96G914kHjnOQz/Gy6L39CQtV/hcuGhXqqtxTkb1UtyfJSP4cpId627YvMfYLL
 rkAAAA=
X-Change-ID: 20250313-airoha-flowtable-l2b-e0b50d4a3215
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Michal Kubiak <michal.kubiak@intel.com>
X-Mailer: b4 0.14.2

Introduce the capability to offload L2 traffic defining flower rules in
the PSE/PPE engine available on EN7581 SoC.
Since the hw always reports L2/L3/L4 flower rules, link all L2 rules
sharing the same L2 info (with different L3/L4 info) in the L2 subflows
list of a given L2 PPE entry.

---
Changes in v2:
- squash patch 1/3 and 2/3
- explicitly initialize airoha_flow_table_entry type for
  FLOW_TYPE_L4 entry
- get rid of airoha_ppe_foe_flow_remove_entry_locked() and just rely on
  airoha_ppe_foe_flow_remove_entry()
- Link to v1: https://lore.kernel.org/r/20250407-airoha-flowtable-l2b-v1-0-18777778e568@kernel.org

---
Lorenzo Bianconi (2):
      net: airoha: Add l2_flows rhashtable
      net: airoha: Add L2 hw acceleration support

 drivers/net/ethernet/airoha/airoha_eth.c |   2 +-
 drivers/net/ethernet/airoha/airoha_eth.h |  22 ++-
 drivers/net/ethernet/airoha/airoha_ppe.c | 224 ++++++++++++++++++++++++++-----
 3 files changed, 212 insertions(+), 36 deletions(-)
---
base-commit: 61f96e684edd28ca40555ec49ea1555df31ba619
change-id: 20250313-airoha-flowtable-l2b-e0b50d4a3215

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


