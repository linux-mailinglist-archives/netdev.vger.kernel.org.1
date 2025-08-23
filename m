Return-Path: <netdev+bounces-216193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BFFB32780
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 09:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8CD687445
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 07:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720B7223338;
	Sat, 23 Aug 2025 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyQpAI8W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE07150997
	for <netdev@vger.kernel.org>; Sat, 23 Aug 2025 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755935785; cv=none; b=EYP5VI8Ink7zwBkYCd3diWCQCLw4l83bYOrgFVosy/J69LFewhelI8Vj8+Fu2KrwiY5cLIwlginaMoz67yhceMe9hlxOYDbGDL5Zq7YWdAJQJBFaqYSO/djWyJW2U4006Py5F1rL3JgMVjSdKv4EJ76Dd9YLKF5OVYEfZ2bGRX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755935785; c=relaxed/simple;
	bh=jH/zfECS1KSBq9y+UHL0sl+KGHKSrnJ/X+waTIEZKUs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TNrh7hHcj2noRBgajtJR1rprNkLyVgKdu/nFXZWwkQARADvPNOTZrYDcvBWOZEjZ5M2XRCsLFvCBLW7XfrxniLM4saW36bwsKxrAJSZqoynf7tPbT//mz4oJR1LD220tZAyxeLG9eSe6bVHcSle+mTRK3OIc1Yju7uU2cGSD8MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyQpAI8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F99C4CEE7;
	Sat, 23 Aug 2025 07:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755935784;
	bh=jH/zfECS1KSBq9y+UHL0sl+KGHKSrnJ/X+waTIEZKUs=;
	h=From:Subject:Date:To:Cc:From;
	b=WyQpAI8W8xXT2XCFMrkjkY3lqT3p0RkvOk1Ku7XJ/l2f52GHpOzG3g7yAELI9pOZD
	 EWEUzAIoMXh7IMRDUVGkhAvJF6BwMJ6ei8KmZNnY+bKURE6GFx89IH/zPjbPpToE5Y
	 e0y4Oueij+R+/GAIy3lsA8FB/cVHAGBDpsJaOdNI0y8/kdMki+Qa+yWldOesesTNip
	 tG/bDgH6an8Qa9FAMyCodDOhalNmjwj8vvFyxynQ1wEHF7DQzmiz48aP6StHnFOM1x
	 iBd3k60anVS4YJijSNu8hVJT/6E3OujL4n6Gb0UYAgS2e+od5t7IrgQO0qUh5yDGc1
	 JtN4RagS/HsCg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v3 0/3] net: airoha: Add PPE support for RX wlan
 offload
Date: Sat, 23 Aug 2025 09:56:01 +0200
Message-Id: <20250823-airoha-en7581-wlan-rx-offload-v3-0-f78600ec3ed8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABF0qWgC/43NQQ6CMBCF4auYrh3TDkLBlfcwLiYwhUbSmtZUD
 OHuFla60uX/Ft+bReRgOYrTbhaBk43WuxzFfifagVzPYLvcAiWWslYNkA1+IGCny1rBcyQHYQJ
 vzOipA4VsTFW1BoujyMY9sLHT5l+uuQcbHz68truk1vVfOSmQoBXJRrNkJHW+cXA8HnzoxUon/
 OAQf3GYuZp0xaorDLf4xS3L8gbmzAWiGgEAAA==
X-Change-ID: 20250819-airoha-en7581-wlan-rx-offload-12eff66cf234
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce the missing bits to airoha ppe driver to offload traffic received
by the MT76 driver (wireless NIC) and forwarded by the Packet Processor
Engine (PPE) to the ethernet interface.

---
Changes in v3:
- Fix compilation error when CONFIG_NET_AIROHA is not enabled
- Link to v2: https://lore.kernel.org/r/20250822-airoha-en7581-wlan-rx-offload-v2-0-8a76e1d3fec2@kernel.org

Changes in v2:
- Rebase on top of net-next main branch
- Link to v1: https://lore.kernel.org/r/20250819-airoha-en7581-wlan-rx-offload-v1-0-71a097e0e2a1@kernel.org

---
Lorenzo Bianconi (3):
      net: airoha: Rely on airoha_eth struct in airoha_ppe_flow_offload_cmd signature
      net: airoha: Add airoha_ppe_dev struct definition
      net: airoha: Introduce check_skb callback in ppe_dev ops

 drivers/net/ethernet/airoha/airoha_eth.c  |   7 +-
 drivers/net/ethernet/airoha/airoha_eth.h  |  12 ++--
 drivers/net/ethernet/airoha/airoha_npu.c  |   1 -
 drivers/net/ethernet/airoha/airoha_ppe.c  | 112 +++++++++++++++++++++++-------
 include/linux/soc/airoha/airoha_offload.h |  55 +++++++++++++++
 5 files changed, 150 insertions(+), 37 deletions(-)
---
base-commit: b1c92cdf5af3198e8fbc1345a80e2a1dff386c02
change-id: 20250819-airoha-en7581-wlan-rx-offload-12eff66cf234

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


