Return-Path: <netdev+bounces-189292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E713EAB17BE
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4901A172B47
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5F923184D;
	Fri,  9 May 2025 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roz6jdw9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C22230D14;
	Fri,  9 May 2025 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746802311; cv=none; b=qvyzAyO/2lvxq6aY/ue6CCeBtr3bp30+jdLjnJjPcORqiRwJy9nS5MBnJrjnGy9+P5tG0SaLa6/cS4dS0hMbjq72ukzn96ztPzdxi7UGAhRxDP167h5NJNLO9YNb+0AcvxMSD23BhyGKv2FJtQx8IgJjCOTgT6k3dJ/Bzq9QRM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746802311; c=relaxed/simple;
	bh=yow+lntSz2MlCtXy+xkWXR8zt8RwshTgTwE/Pdd8ivk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TFUJ5qUFvE0OSU96PdBTDE24j7FlOnadXPswIYmxRjTbX5Kdi4uERDeFA4U6aSmV1y2gqY5zuyuW5af1iIc5zxlh6B7EuVPsu8T8mRBvkdyh3+Ily+tlsrgRWpx3yd/+w7dGVPYvWXUHjOmlhawsWv1SGDNa/iM3J8dlv0j89og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roz6jdw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B9FC4CEE4;
	Fri,  9 May 2025 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746802310;
	bh=yow+lntSz2MlCtXy+xkWXR8zt8RwshTgTwE/Pdd8ivk=;
	h=From:Subject:Date:To:Cc:From;
	b=roz6jdw9Eo/WA+UOrsBTXcOkhyJ1ts2cW5bv2rzfgwEBWwP/QdZMZv6xuk9depFbj
	 4bEe+0CWE1//8ula1UMj6S6rAhFipyo9mEPVtbkcfgeV/tZLsAvSrs5iM95D1tPkBa
	 4ZAYQQ8gzZ1oXpYPzP6fV6JYgufnPfdh9IK0JsoHGCKfs4x8fPBUNFp113PDC6BQly
	 l56l3E5mE6w0Q/vp2K3tVB+C/iZiX6TkCF0iAT/QHD0IYBdK6ThRC58CT0/HZPQm/O
	 /ySF3MzPIPYLCM0JKM1zieZ0ZeCb7f9a6YRu3K/YOAvOesWeQ6wdKsCK7sgQEX0f1x
	 LLsKMYMSM5TkQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v2 0/2] Add the capability to allocate hw buffers
 in SRAM for EN7581 SoC
Date: Fri, 09 May 2025 16:51:32 +0200
Message-Id: <20250509-airopha-desc-sram-v2-0-9dc3d8076dfb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHQWHmgC/32NQQ6CMBBFr0Jm7ZhSqCSuvAdhMZQBJiolU0M0p
 He3cgCX7yX//R0iq3CEa7GD8iZRwpLBngrwMy0TowyZwRrrjDMNkmhYZ8KBo8eo9MSRuK+YLr7
 3DvJuVR7lfTTbLvMs8RX0c1xs5c/+q20lGhxqa6qmrsp+pNuddeHHOegEXUrpC/sgeyyzAAAA
X-Change-ID: 20250507-airopha-desc-sram-faeb3ea6cbc5
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

In order to improve packet processing and packet forwarding
performances, EN7581 SoC supports allocating buffers for hw forwarding
queues in SRAM instead of DRAM if available on the system.
Rely on SRAM for buffers allocation if available on the system and use
DRAM as fallback.

---
Changes in v2:
- fix sparse warnings
- Link to v1: https://lore.kernel.org/r/20250507-airopha-desc-sram-v1-0-d42037431bfa@kernel.org

---
Lorenzo Bianconi (2):
      dt-bindings: net: airoha: Add EN7581 memory-region property
      net: airoha: Add the capability to allocate hw buffers in SRAM

 .../devicetree/bindings/net/airoha,en7581-eth.yaml | 13 +++++
 drivers/net/ethernet/airoha/airoha_eth.c           | 57 ++++++++++++++++++----
 2 files changed, 61 insertions(+), 9 deletions(-)
---
base-commit: a9ce2ce1800e04267e6d99016ed0fe132d6049a9
change-id: 20250507-airopha-desc-sram-faeb3ea6cbc5

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


