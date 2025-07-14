Return-Path: <netdev+bounces-206732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AD3B043EE
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5EFF3A2350
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B163267B98;
	Mon, 14 Jul 2025 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/Vs8vV3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232401FF1BF;
	Mon, 14 Jul 2025 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506736; cv=none; b=ZjZp4tJrIwYou9Z/7f3ticI4IpKswLoSC+a+KbwYEu9VcXlkoLAaX3W80DK14c19Fi/ODM62rK7Z+9hNqhq/dwjSDtfALFYoB7sXVbH6AzsFwdMgD4xi8pf4UpV2ZD1LYpfZ8DLrBiN/QQZqjKAjN7QbUNlAC7gKsA99nwwHFes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506736; c=relaxed/simple;
	bh=YCh066qOSOnzw5puiQyznGUyX8fu8FqZ4e6PkpV2Kvk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hoAQaMz/lMNW5STk0FIo83ke7CftGdCpcvD88pzHEuc/1+Bm70cVqY292vSoPVwKE/mrCh7eKxaXyFhRUHcC1tkSc3RmlTs468Z+I3jZilmY78NMSLJNc9zMPNd67s4MqBBHUCkNKpP9HweaParNFwnLy4AaudKBENGG84SZ0N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/Vs8vV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F0DC4CEED;
	Mon, 14 Jul 2025 15:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506736;
	bh=YCh066qOSOnzw5puiQyznGUyX8fu8FqZ4e6PkpV2Kvk=;
	h=From:Subject:Date:To:Cc:From;
	b=M/Vs8vV3c8NeRZ67XB+uG0nSpxRlEHQfX4YR95ljNzpd98VVc1hdcwTEFkzibBiZH
	 d59N03CoCbfZ2tHF16BdbTnXuTxEepVfKIhAuZhI51j/vUVVKDTkVouTvdWSP5sTMT
	 H48OdW/Dei/VEdXCWqAzQUTYD6cRCFP5ztMCEXecsyTmWeAtpybNmCywNd7jtODCfM
	 6TSraMYrdEF8swJXNglhpinsZeOl+04haOubgEXcG49rvN4wR+te0druzpJemzIFUP
	 kYLXMzrhDHSXEdXq6WWBJ0FZbeSTJFXvvEvDETpfbfgF6D3a50Kbe01uCUkKpoUhrN
	 /w6anQs06MGuw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v3 0/7] net: airoha: Introduce NPU callbacks for
 wlan offloading
Date: Mon, 14 Jul 2025 17:25:13 +0200
Message-Id: <20250714-airoha-en7581-wlan-offlaod-v3-0-80abf6aae9e4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFkhdWgC/33NQQ7CIBCF4asY1o4ZQIS68h7GBbZDS2zAgKmap
 neXNjHRTZf/W3xvZJmSp8yOm5ElGnz2MZSQ2w2rOxtaAt+UZgKFQo0crE+xs0BBK8Ph2dsA0bn
 exgYOuq4a65zZa8kKcE/k/GvBz5fSnc+PmN7L18Dn9cuKNXbggGBQIlYa8SrN6UYpUL+LqWWzO
 4hfS61aoliydlJoo0ga/mdN0/QB1iVdPxEBAAA=
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
base-commit: b06c4311711c57c5e558bd29824b08f0a6e2a155
change-id: 20250701-airoha-en7581-wlan-offlaod-67c9daff8473

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


