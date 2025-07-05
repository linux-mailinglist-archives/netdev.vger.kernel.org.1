Return-Path: <netdev+bounces-204343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4CEAFA1EF
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 23:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD7616B056
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 21:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF90238C1E;
	Sat,  5 Jul 2025 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyIZzY/O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6533136349;
	Sat,  5 Jul 2025 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751749804; cv=none; b=lyTWlC4h68ItehSkhMGMMfxTx3urjsyzI0Z3Ay10nVL51XTWX+Ng6UyzD/opEwe4zmmcqADeeQldtfH9sff8lOCi6lY1rm7BGokqS3HjPGKYII/ZD1u19Oln6EgWxEF37htGKoBTejjhljEgm60Os9z40dPeFILzXDtyXDtRvOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751749804; c=relaxed/simple;
	bh=n3rcFQ+MPVHTDhl/5n07Sg92l9DRbmRw4++LxHuXcDw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JW1M7shmtKjAgiZusUIaKYeK0mapXe7IAGdcrQWAGKHJH2QFCsSLDJT0V432u7lMm6UNEYhpnbeheWF4H9xXclB7pRXZGHlZRBvfvgO0ESmLv5+9jbP0IWALjXsL4Hx+0aV5+AWSb716PRdBKuq7ahAYMCRegRuy9md8Zn9aN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyIZzY/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB2EC4CEE7;
	Sat,  5 Jul 2025 21:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751749804;
	bh=n3rcFQ+MPVHTDhl/5n07Sg92l9DRbmRw4++LxHuXcDw=;
	h=From:Subject:Date:To:Cc:From;
	b=GyIZzY/OcIOU6APTBF/8YB0x1W2aljG+aIEkrb08i4ZqK/KsiUytQWa/2g06PX+Dt
	 PgYBtCWrpDGF02CVtMwBCr/smCQh4999kc+G5a//fTI2ub++T3BVjcXIqG2N1xaLYV
	 hd13YXERrd1S1rOkynbbbYYCCezNKRR34TjgHuzVx456IStS0EGI3LR5iNV1WI0OYP
	 6SCw1yUkgq1qbmzYQEj12etkzR4u/nNSeVWOl0aKLXudTiMwjETHVG+p5M/6dMNsw8
	 jrNFAZG3yJLiexc0gDocvIhTFcjNNzXkFhdrsQNeYHxgXU8mtzS2MAPR3I6FnovarM
	 /4c6H7Hydf9zA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v2 0/7] net: airoha: Introduce NPU callbacks for
 wlan offloading
Date: Sat, 05 Jul 2025 23:09:44 +0200
Message-Id: <20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJiUaWgC/33NQQ7CIBCF4as0rB0zUCvUlfcwXWA7tMQGzGCqp
 uHuYhO3Lv+3+N4qErGnJE7VKpgWn3wMJdSuEv1kw0jgh9JCoWpQowTrOU4WKOjGSHjONkB0brZ
 xgKPu28E6Zw66FgW4Mzn/2vBLV3ry6RH5vX0t8rv+WPWPXSQgGKwRW414rc35Rhxo3kceRZdz/
 gBSL4hPxQAAAA==
X-Change-ID: 20250701-airoha-en7581-wlan-offlaod-67c9daff8473
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2

Similar to wired traffic, EN7581 SoC allows to offload traffic to/from
the MT76 wireless NIC configuring the NPU module via the Netfilter
flowtable. This series introduces the necessary NPU callback used by
the MT76 driver in order to enable the offloading.
Subsequent patches will introduce the required MT76 support.

---
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

 .../devicetree/bindings/net/airoha,en7581-npu.yaml |  20 +-
 drivers/net/ethernet/airoha/airoha_npu.c           | 180 ++++++++++++++-
 drivers/net/ethernet/airoha/airoha_npu.h           |  36 ---
 drivers/net/ethernet/airoha/airoha_ppe.c           |   2 +-
 include/linux/soc/airoha/airoha_offload.h          | 256 +++++++++++++++++++++
 5 files changed, 450 insertions(+), 44 deletions(-)
---
base-commit: 6b9fd8857b9fc4dd62e7cd300327f0e48dd76642
change-id: 20250701-airoha-en7581-wlan-offlaod-67c9daff8473

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


