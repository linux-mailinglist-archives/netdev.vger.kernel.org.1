Return-Path: <netdev+bounces-212488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1954DB21094
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C53A3E79D2
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 15:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE591A9FA5;
	Mon, 11 Aug 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aABcN5Qm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AF91A9F91;
	Mon, 11 Aug 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926324; cv=none; b=s1Lx0iSdH7/XRMqqhH+sj5eIDE7RQdveH3LnN2Pc6bBEZ5EK7iFpgiGcBgOL+9XuX6p7JJzaRsGISAy4NdrvUSbY8T9Mc315NzoiUfWMOX2qfhkEsK0Vw5MX/bxA9biSe5ZNn8jMG5ERcngQnNeDddTn2S8XFjgWV7L/hELg6XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926324; c=relaxed/simple;
	bh=6q79iZqgmRYKyPHnlMqwPzEGP8FF+iIXD11AwfalVcU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BOMVNeF1Y9kTxC39g8ubqz+vhugTRBgtIWj1cVvYD7aptcl3D/yHWPWecNFbBhhcF0bPgupusjCTQQatfvT8vgGfCyla8ajal5juPITKLx182V1+k0gzBAZQe+6ENeGbpQ8QBq3aqyRgiaSnwaxmsdopr0D5ldI70FEUKOSqNUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aABcN5Qm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDD1C4CEED;
	Mon, 11 Aug 2025 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754926323;
	bh=6q79iZqgmRYKyPHnlMqwPzEGP8FF+iIXD11AwfalVcU=;
	h=From:Subject:Date:To:Cc:From;
	b=aABcN5QmeJa0Pmwl9RL6gqihtSfKmm+rxMX8XRsLUt9rXTP55OGJKwPyHWndGnyEc
	 DCx7XTUyKQFeZ3G9tyuEWX0qBwpmDwPKnvJnVPPS/X/oJc/DSakUN3SnYB7r9fd+PQ
	 ut85ODRKfp0xlJHm9QYgAkOOFk4TC9n7ged34geRH51FAIK1TpRCWHIvwGYgEMTla3
	 gblEoctGffVSVWPvMtU4gw8OVhrlfxm/jepuUKFeMPIrUuawCbCxbkXvLt7h9AohW0
	 OAUFbao4LnXkU2AvSaY0z82+tOIO03JN7UxSxlyT9ijjs5BwxcjEXTsaRO1moBVA9Y
	 6cfWjSAeVaL1A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v7 0/7] net: airoha: Introduce NPU callbacks for
 wlan offloading
Date: Mon, 11 Aug 2025 17:31:35 +0200
Message-Id: <20250811-airoha-en7581-wlan-offlaod-v7-0-58823603bb4e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANcMmmgC/33Oy2rDMBCF4VcJWldF90tXfY/SxdgaxaLGCnJxU
 oLfvbKh4GLQ8szim/9JZiwJZ/J2eZKCS5pTnuqwLxfSDzBdkaZQNxFMaGYZp5BKHoDiZLXj9D7
 CRHOMI+RAje19gBidspJU4FYwpseOf3zWPaT5O5ef/dfCt+sfK1rswimjjknGvGWsk+79C8uE4
 2suV7K5izhaummJask+SmGdRun4yZIHi6umJfcu6KIBQI/qZKmjZZuWqpYJHbdOeo5BnCx9sIR
 sWrpaAbxAFl2vvD1Z5mi1u8zWBRGCN9Bza/5Z67r+Ahk49ehBAgAA
X-Change-ID: 20250701-airoha-en7581-wlan-offlaod-67c9daff8473
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2

Similar to wired traffic, EN7581 SoC allows to offload traffic to/from
the MT76 wireless NIC configuring the NPU module via the Netfilter
flowtable. This series introduces the necessary NPU callback used by
the MT7996 driver in order to enable the offloading.
MT76 support has been posted as RFC in [0] in order to show how the
APIs are consumed.

[0] https://lore.kernel.org/linux-wireless/cover.1753173330.git.lorenzo@kernel.org/

---
Changes in v7:
- Rebase on top of net-next main branch
- Link to v6: https://lore.kernel.org/r/20250727-airoha-en7581-wlan-offlaod-v6-0-6afad96ac176@kernel.org

Changes in v6:
- Fix wlan_mbox_data message size
- Make NPU memory regions optional in NPU dts
- Link to v5: https://lore.kernel.org/r/20250723-airoha-en7581-wlan-offlaod-v5-0-da92e0f8c497@kernel.org

Changes in v5:
- Rebase on top of net-next main branch
- Link to v4: https://lore.kernel.org/r/20250717-airoha-en7581-wlan-offlaod-v4-0-6db178391ed2@kernel.org

Changes in v4:
- Improve commit messages
- Link to v3: https://lore.kernel.org/r/20250714-airoha-en7581-wlan-offlaod-v3-0-80abf6aae9e4@kernel.org

Changes in v3:
- Rename 'binary' memory region in 'firmware'
- Do not make memory-region-names property required
- Link to v2: https://lore.kernel.org/r/20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org

Changes in v2:
- Introduce binding for memory regions used for wlan offload
- Rely on of_reserved_mem_region_to_resource_byname
- Export just wlan_{send,get}_msg NPU callback for MT76
- Improve commit messages
- Link to v1: https://lore.kernel.org/r/20250702-airoha-en7581-wlan-offlaod-v1-0-803009700b38@kernel.org

---
Lorenzo Bianconi (7):
      dt-bindings: net: airoha: npu: Add memory regions used for wlan offload
      net: airoha: npu: Add NPU wlan memory initialization commands
      net: airoha: npu: Add wlan_{send,get}_msg NPU callbacks
      net: airoha: npu: Add wlan irq management callbacks
      net: airoha: npu: Read NPU wlan interrupt lines from the DTS
      net: airoha: npu: Enable core 3 for WiFi offloading
      net: airoha: Add airoha_offload.h header

 .../devicetree/bindings/net/airoha,en7581-npu.yaml |  22 +-
 drivers/net/ethernet/airoha/airoha_npu.c           | 175 +++++++++++++-
 drivers/net/ethernet/airoha/airoha_npu.h           |  36 ---
 drivers/net/ethernet/airoha/airoha_ppe.c           |   2 +-
 include/linux/soc/airoha/airoha_offload.h          | 260 +++++++++++++++++++++
 5 files changed, 451 insertions(+), 44 deletions(-)
---
base-commit: 37816488247ddddbc3de113c78c83572274b1e2e
change-id: 20250701-airoha-en7581-wlan-offlaod-67c9daff8473

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


