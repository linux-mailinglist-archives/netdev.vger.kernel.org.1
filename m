Return-Path: <netdev+bounces-207708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D1DB085A6
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 08:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035B4161D2F
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 06:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7038219A8B;
	Thu, 17 Jul 2025 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFtfpfXc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5DA2185AC;
	Thu, 17 Jul 2025 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735491; cv=none; b=BoSpJsK85EH7PJFUDDwWi7Ahl6VuMM1BS87AaqpztbEpCgpBgs1mIyc07CHYOHn8q/PovVQIk4lARvR+NXnyw02LDCccmQF6uUA0npm71ddf81mSDF2bDE/jH1tnOIbr4UiDdkf0KUlZZYM7EVNXTkbmYJ1XXWsU/+HlxJM9g+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735491; c=relaxed/simple;
	bh=DTAc1QH2SG3wBIaDqh/zWN6e5pCpQY2YlQrMVLcHS5I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n6WcHvyRrIhRgXaMUhBXH+BuYPtGQP6QDt/nX/TeqilJNlWp4atWMJQdTLyhacEMA9XMAmlFK1u7te+BZZuPNJvYT0xosyJP43sgcQffSFhOxI9zu+em/8KINFZdZlUsgJcwgMVPoDDYBjqzwz0u7+A25bg/FG84cc1zjwa0oeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFtfpfXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A348AC4CEE3;
	Thu, 17 Jul 2025 06:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752735491;
	bh=DTAc1QH2SG3wBIaDqh/zWN6e5pCpQY2YlQrMVLcHS5I=;
	h=From:Subject:Date:To:Cc:From;
	b=OFtfpfXcIQiBCe61xRDUOlE+OyqUKE3/2zysnAzg4uwVKvXYg9yMZT2Zjc74s1Guh
	 uLB/CQ0TP7E7m7H1ZUUkFelcKsrVRayDJDDnVHvAbv9s/mVcrZUiQnZOH7KvECCJXU
	 e7RNwPgMvZlYzdbQSvkOvPuGyDkzRvHbq2ge1adI/YdhuquPbNl3e3YTKf6F0rjecy
	 Z4NoK8IJmf+54AytWdILySv7EsuFl93VH2j0OCHThnbbz9cxEclPVQFpgY30PXi1zn
	 xFPQX4qM8LSlBMAZllksPfLRp3MGag18cSRe6A17jAAYuQaSMa14n1xwVRLYqv0tna
	 W2mnLSzgleaAA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v4 0/7] net: airoha: Introduce NPU callbacks for
 wlan offloading
Date: Thu, 17 Jul 2025 08:57:41 +0200
Message-Id: <20250717-airoha-en7581-wlan-offlaod-v4-0-6db178391ed2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOWeeGgC/33OQQ6CMBCF4auYrq2ZtkCLK+9hXAwwlUbSmmJQQ
 7i7hcQEY8Lyn8X3ZmQ9RUc9O+5GFmlwvQs+RbbfsbpFfyXumtRMgsxBg+DoYmiRk9e5EfzZoef
 B2g5Dwwtdlw1aazKtWALukax7Lfj5krp1/SPE97I1iPn6ZeUWOwgO3IACKDVApczpRtFTdwjxy
 mZ3kGsr37RkslRtldQmJ2XEn6VWlsg2LbX8hZUtEKmk7MeapukDMEhRYl0BAAA=
X-Change-ID: 20250701-airoha-en7581-wlan-offlaod-67c9daff8473
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Similar to wired traffic, EN7581 SoC allows to offload traffic to/from
the MT76 wireless NIC configuring the NPU module via the Netfilter
flowtable. This series introduces the necessary NPU callback used by
the MT7996 driver in order to enable the offloading.
MT76 support has been posted as RFC in [0] in order to show how the
APIs are consumed.

[0] https://lore.kernel.org/linux-wireless/cover.1752505597.git.lorenzo@kernel.org/T/#t

---
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
base-commit: cd031354087d8ae005404f0c552730f0bd33ac33
change-id: 20250701-airoha-en7581-wlan-offlaod-67c9daff8473

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


