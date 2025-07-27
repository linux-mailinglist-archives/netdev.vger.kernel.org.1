Return-Path: <netdev+bounces-210379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA6FB12FDF
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 16:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A13189647D
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281B221517C;
	Sun, 27 Jul 2025 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPSItQW4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F301ED528;
	Sun, 27 Jul 2025 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753627270; cv=none; b=Wh93HQOd7nbwMj52zJLLHM5LPoGv7na+/3HF4dMPdxtJaZAh7k09fj++C0NMtjkZPjqj/O2a6XKIkSjt+0kl3pE2SaN/Y2+HZ9n8puW5Bfc5uxJHC3VDXFm0EAJrzmJyrktmZqfYIkV/LLfjTk0hu5UNgPSHJbmWJBJKWmYAcdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753627270; c=relaxed/simple;
	bh=xZXb06iCAT/cXJb6tmwqAU2EoCgLyhI7y6UPbxYlDE0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jfoYtw9Ly0Ups6iMeCbWN/cfwxGEqS9aLUp3QvrXpHCK1KDHkqtckjvLGPmqsZeQRY8cE45oLpTU9sBw8oymJi0mCZtYbn1EhLgmTyL5GXGdhRKz0PetyVlEa10NgUfWcmrS0dCWOTB+heD/XkRHw2jPCOEymBpT6IS9PPry848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPSItQW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8F3C4CEEB;
	Sun, 27 Jul 2025 14:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753627269;
	bh=xZXb06iCAT/cXJb6tmwqAU2EoCgLyhI7y6UPbxYlDE0=;
	h=From:Subject:Date:To:Cc:From;
	b=dPSItQW4PIMrn94105dnrfhwyE1WX1U+xzRjzuC2ntAppoJIR8jhxiLYa+UtDD+L6
	 aNPj1Au2HvcO3AN/2tDwexvYh7wIrEl/PGszCoigLMzaCQ3fv1ArZYoAMJucjUST5b
	 GYWgqUY2QT73bURNi1YQ79tJbkFvDC/QVKV+fhucOQPe409PcyuWbZKX6vYN6crnS6
	 T3DLPHOhYcoM/bjJXg/77ZxOItCuFlvP/EWit9ub7A8VA5vtthIZoI1zEx0ReQLl6Q
	 W4IBXT8t//htIeWjTLM71tmMbTcmrKyGHtGqRz37Ox4Zr9b2jk4YbWpYtR+2qnxZhR
	 P+yWXQLptDFlQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v6 0/7] net: airoha: Introduce NPU callbacks for
 wlan offloading
Date: Sun, 27 Jul 2025 16:40:45 +0200
Message-Id: <20250727-airoha-en7581-wlan-offlaod-v6-0-6afad96ac176@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG06hmgC/33OwWrEIBDG8VdZPNeijkbtqe9RepjEcSMNcTElb
 Vny7nUDhZSAx/8cft/c2UIl0cJeLndWaE1LynON7unChhHnK/EUajMllBFWSI6p5BE5zdY4yb8
 mnHmOccIceGcHHzBGpy2wCtwKxfS942/vtce0fObys2+t8nH9Y1WLXSUX3AkQwlshenCvH1Rmm
 p5zubKHu6qjZZqWqhYMEZR1hsDJkwUHS+qmBftf2McOkTzpk6WPlm1aulpd6KV14CUFdbLMwVL
 QtEy1AnpFIrpBe/vP2rbtF0p8hWX1AQAA
X-Change-ID: 20250701-airoha-en7581-wlan-offlaod-67c9daff8473
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Similar to wired traffic, EN7581 SoC allows to offload traffic to/from
the MT76 wireless NIC configuring the NPU module via the Netfilter
flowtable. This series introduces the necessary NPU callback used by
the MT7996 driver in order to enable the offloading.
MT76 support has been posted as RFC in [0] in order to show how the
APIs are consumed.

[0] https://lore.kernel.org/linux-wireless/cover.1753173330.git.lorenzo@kernel.org/

---
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
 drivers/net/ethernet/airoha/airoha_npu.c           | 170 +++++++++++++-
 drivers/net/ethernet/airoha/airoha_npu.h           |  36 ---
 drivers/net/ethernet/airoha/airoha_ppe.c           |   2 +-
 include/linux/soc/airoha/airoha_offload.h          | 260 +++++++++++++++++++++
 5 files changed, 446 insertions(+), 44 deletions(-)
---
base-commit: fa582ca7e187a15e772e6a72fe035f649b387a60
change-id: 20250701-airoha-en7581-wlan-offlaod-67c9daff8473

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


