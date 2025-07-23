Return-Path: <netdev+bounces-209419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCD8B0F8D7
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC7C566D1C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DC51FE44A;
	Wed, 23 Jul 2025 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6IixJ8I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5784019C54E;
	Wed, 23 Jul 2025 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291205; cv=none; b=jnGIFjK0Jq51ABZE8xOXFzeuspsj8qPfT75kmIJx7X69jDZgmkbr/LwEsxtBglCLCBjPP0Eo1Ku1RBfGQtAU7Nqfs0+x1OAdozt2hctMH9LNTnVIAyChPp/NPbYVqFWzH+Hvqoyn79PSB7/He9/TB/x6EDj7UA04gUKPq9Pnn60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291205; c=relaxed/simple;
	bh=zp+jX/kXfpkO7Tu8Jj84eW8FHZ9VneOw13Yz+OEtiW8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uF3ufP2AjV/VH4CblEPvadDzE8szv3AJmnDnFpIZEcD+bi1j4vb5yOBbjd3hcxDOOrxoENVxLqEa+t+CGIogtpKD0rsMW+WAvge3YYtTlTTqqslIOVRpYuFlXWkdtUbFK3QmxtzWwJlNjaZsoEZxxCpCU2AYV8EhlciNeo8oWpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6IixJ8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E0AC4CEE7;
	Wed, 23 Jul 2025 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753291204;
	bh=zp+jX/kXfpkO7Tu8Jj84eW8FHZ9VneOw13Yz+OEtiW8=;
	h=From:Subject:Date:To:Cc:From;
	b=m6IixJ8I44Vn0PM8TJaI1DRBt9HlAW+TtStOnYhvTFtnhT6eLX2Z9CNXrzXLQFHvp
	 HsmBn4TiFUVaSNXURh8Gg7dA9z6kjNRFWIGcSWL1E8rWzNGcZ4A4unK5jhIK9Rh+RM
	 rFH7ldtrYelnpaHAzZ9DtK1iA9H6/cmdRU5iJoTMpR6fvvFMfmsxjy4TMl2QPqTRpY
	 mtS2ZelfScivkcZS095Xwr+CK6MpLal3ny+ceNw9t0YKsZ3W0jfbqM5cQSb4aIfPHW
	 wDKKpBzIIGfqjnj324O9sueI1hT1qL0WVS1rSQzcGWviQbblFjz7k45ZHv0qXMZw4f
	 5YSFUnJoPEBZw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v5 0/7] net: airoha: Introduce NPU callbacks for
 wlan offloading
Date: Wed, 23 Jul 2025 19:19:49 +0200
Message-Id: <20250723-airoha-en7581-wlan-offlaod-v5-0-da92e0f8c497@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALYZgWgC/33OwYrDIBDG8Vcpnteijkazp32PZQ+TODayQYtZ0
 i4l714bKKQUcvzP4ffNjU1UIk3s83BjheY4xZxqmI8D6wdMJ+LR12ZKKCOskBxjyQNyStY4yS8
 jJp5DGDF73ti+9RiC0xZYBc6FQryu+PdP7SFOf7n8r1uzfFyfrNpjZ8kFdwKEaK0QHbivXyqJx
 mMuJ/ZwZ7W1zK6lqgV9AGWdIXDyzYKNJfWuBetf2IUGkVrSb5beWnbX0tVqfCetg1aSVy/Wsix
 32QBQPKkBAAA=
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

 .../devicetree/bindings/net/airoha,en7581-npu.yaml |  19 +-
 drivers/net/ethernet/airoha/airoha_npu.c           | 180 +++++++++++++-
 drivers/net/ethernet/airoha/airoha_npu.h           |  36 ---
 drivers/net/ethernet/airoha/airoha_ppe.c           |   2 +-
 include/linux/soc/airoha/airoha_offload.h          | 259 +++++++++++++++++++++
 5 files changed, 452 insertions(+), 44 deletions(-)
---
base-commit: 56613001dfc9b2e35e2d6ba857cbc2eb0bac4272
change-id: 20250701-airoha-en7581-wlan-offlaod-67c9daff8473

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


