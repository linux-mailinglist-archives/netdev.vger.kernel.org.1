Return-Path: <netdev+bounces-215935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E65B31010
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5EAA18945A9
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 07:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AC62E7646;
	Fri, 22 Aug 2025 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oa/ZsUGG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECE92E62BF
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 07:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755846910; cv=none; b=g0liFTql65vNYaV7TRKPrjT0OIyDPtgWgIdFvvIikSvKL6VaPJ20AoNVgfMz/GdtFL8aU+Cp9KfdiG9muR1lyyIT6zffmb664+c+HoCyQ4/Sonp6QwHSzBHxTkNTrTs2+mzVi1RPxq03XBnx0uAZfoCekYtqHfHwdyV58zcSb1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755846910; c=relaxed/simple;
	bh=CVihnyQ1lbG3xmCXsosuDlSrApxiofSs6sf1IgE+ifA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HN2ReUEQcO7SGjrOkKvGJiqa3nxdgNRD9OsFfnp0gNusm44tVJRFaQNnGAsbo8agduiEBsQBDRwS6W3AybDuP2+vLRS6p6iRYubCsiLyyfBIJHtz0jcf0DRc7LkgPcp71/WTiTaQPeV7wmQShTsrmuhyzAcvxqpyz8rSD88wBWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oa/ZsUGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB10C4CEF1;
	Fri, 22 Aug 2025 07:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755846909;
	bh=CVihnyQ1lbG3xmCXsosuDlSrApxiofSs6sf1IgE+ifA=;
	h=From:Subject:Date:To:Cc:From;
	b=oa/ZsUGG7trUDAixHJsonNxYZNWCwSb8P+uTbXcAE8amhNjWbpWjMJg9ji3Txg6hd
	 HmN3DxcKfqw5wcddTVeNZprn+1oDMWwIpNYHblE+Ioq6KUCeiH5i2CKLXYCNt6U/od
	 +/yIcZpgGt/aKwXWfLtTgxGAoyZ3IZ/R3IQC6Sx6v8LpUW8UuUCQQCnvL46K/5hQ++
	 v0NnVYhOhoZ2ZSjB5rpA9LuyxaqxdgfR71O2hgDKc3CwUtht2Jb4nQCaMLEzROYUWa
	 aV2cQSbciDRugLbe5uLsz9jSapNHDygScekpo/7RLxAPNd+Igb1wkctIAk0GyPhCyl
	 sfl7oSsqQzm5w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v2 0/3] net: airoha: Add PPE support for RX wlan
 offload
Date: Fri, 22 Aug 2025 09:14:47 +0200
Message-Id: <20250822-airoha-en7581-wlan-rx-offload-v2-0-8a76e1d3fec2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOcYqGgC/43NTQ6CMBCG4auYWTumU+XPlfcwLCYwhUbSmqlBD
 OHuVk7g8vkW77dCEvWS4HpYQWX2yceQYY8H6EYOg6Dvs8EaW5iaGmSvcWSUUBU14XvigLpgdG6
 K3CNZca4sO2fPF8iNp4rzy96/t9mjT6+on/1upt/6b3kmNFgRm6YSI5bp9hANMp2iDtBu2/YFA
 OL89MsAAAA=
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
 drivers/net/ethernet/airoha/airoha_ppe.c  | 113 +++++++++++++++++++++++-------
 include/linux/soc/airoha/airoha_offload.h |  55 +++++++++++++++
 5 files changed, 151 insertions(+), 37 deletions(-)
---
base-commit: a7bd72158063740212344fad5d99dcef45bc70d6
change-id: 20250819-airoha-en7581-wlan-rx-offload-12eff66cf234

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


