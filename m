Return-Path: <netdev+bounces-192186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4A0ABECE4
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882683ACB25
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 07:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694C7233713;
	Wed, 21 May 2025 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f33Bb6Ar"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFF422D783;
	Wed, 21 May 2025 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747811815; cv=none; b=JlTCbRn2yN1Ov6SCDfzjz1M+1xQIJlYfbQ6VNcvb8d5oD/FY3unQhqYyUN7jmbEctTFbp3dduKFTh6ixmYcl60dZG1od+6B8b7MozfCDvLgzNQI17Q/gm55JMeEK1hXxkc91yYwwPKfoVl+X3dtU1v8xG5LKfyAvjcvTquMav30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747811815; c=relaxed/simple;
	bh=3HyaTn4YnLp/bMKXEE5qeF1LeOW6suSY3fTbxGDD9Vw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rfwGNKADFkKrp0o9p1EK1XeCfmrmqFGQt+yFP/lWaTd87E02cnmiCUNvn+iwSfoe9bwutBt5RB0y4NyoDHdiuVHfNdrEmUtQsk/e5cN+v6CvhBdA6kKABwfxcbhul/SzC5Ppay8pyM6LeJhutcnnsYIQJGAt53tPYRsH6f7a6Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f33Bb6Ar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AB0C4CEF3;
	Wed, 21 May 2025 07:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747811815;
	bh=3HyaTn4YnLp/bMKXEE5qeF1LeOW6suSY3fTbxGDD9Vw=;
	h=From:Subject:Date:To:Cc:From;
	b=f33Bb6Ary4twB6XEkk7mxnvbInYROzsV6bpENojZG4tboODFmhhHNfya+4dXtmEmT
	 u3sX5O117acPvattruXan3bNk4xcIOs7swho/CKpWEzGt7ACotkLo97CGR8t2CeOoF
	 O1CcWantWKwmq+wGgC7ejzjP3uBYRwMN2LpXzRgki8mNnFFxe66SujDySlo6WpKnMP
	 i9fadrlegbF+1yIFmftwUozbzUEZF107GCHYUEH/7TGL9kS2Sd/rzcfMzGAFgV4o3k
	 471L66gK+/FQTJIWE3mUxMCWISyOIb2fQG00IBE42OhXYI5hsHWoxmD5QUtjOZFaUA
	 xTBe+OGyaNaPA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v3 0/4] Add the capability to consume SRAM for
 hwfd descriptor queue in airoha_eth driver
Date: Wed, 21 May 2025 09:16:35 +0200
Message-Id: <20250521-airopha-desc-sram-v3-0-a6e9b085b4f0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANN9LWgC/33NywrCMBCF4VcpszaSJr1YV76HuMhl0ga1KRMJS
 um7m3alIC7/A/PNDBHJY4RjMQNh8tGHMYfcFWAGNfbIvM0Ngoua17xlylOYBsUsRsMiqTtzCrV
 E1Rhtash3E6Hzz808X3IPPj4CvbYXqVzXf1oqGWe2Ely2lSy1U6cr0oi3faAeVi6JT6L7RYhMd
 NZIe+BtY53+IpZleQMenWdo9gAAAA==
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
performances, EN7581 SoC supports consuming SRAM instead of DRAM for hw
forwarding descriptors queue. For downlink hw accelerated traffic
request to consume SRAM memory for hw forwarding descriptors queue.
Moreover, in some configurations QDMA blocks require a contiguous block
of system memory for hwfd buffers queue. Introduce the capability to
allocate hw buffers forwarding queue via the reserved-memory DTS
property instead of running dmam_alloc_coherent().

---
Changes in v3:
- Remove hwfd references in airoha_qdma_struct in patch 2/4
- Split patch 2/2 in 3/4 and 4/4
- For downlink hw accelerated traffic request to consume SRAM memory for
  hw forwarding descriptors queue
- Fix comments
- Link to v2: https://lore.kernel.org/r/20250509-airopha-desc-sram-v2-0-9dc3d8076dfb@kernel.org

Changes in v2:
- fix sparse warnings
- Link to v1: https://lore.kernel.org/r/20250507-airopha-desc-sram-v1-0-d42037431bfa@kernel.org

---
Lorenzo Bianconi (4):
      dt-bindings: net: airoha: Add EN7581 memory-region property
      net: airoha: Do not store hfwd references in airoha_qdma struct
      net: airoha: Add the capability to allocate hwfd buffers via reserved-memory
      net: airoha: Add the capability to allocate hfwd descriptors in SRAM

 .../devicetree/bindings/net/airoha,en7581-eth.yaml | 13 ++++++
 drivers/net/ethernet/airoha/airoha_eth.c           | 50 ++++++++++++++--------
 drivers/net/ethernet/airoha/airoha_eth.h           | 15 ++++---
 drivers/net/ethernet/airoha/airoha_ppe.c           |  6 +++
 4 files changed, 60 insertions(+), 24 deletions(-)
---
base-commit: e6b3527c3b0a676c710e91798c2709cc0538d312
change-id: 20250507-airopha-desc-sram-faeb3ea6cbc5

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


