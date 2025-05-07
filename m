Return-Path: <netdev+bounces-188760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFA5AAE829
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 19:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE47A5218F2
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B57828D8FC;
	Wed,  7 May 2025 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ea9sJqjB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E29D28D8EE;
	Wed,  7 May 2025 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746640145; cv=none; b=Ed8zmfVH9wgl5fvPWgRUALppcfsYWnZBTU3bjKQNQiVhZgrrN19FiQUkIzk0jJHU/HSlD+44mWwuw35xI70xvZC+CgZCKf1ZQOm9pF6WC4OimQe5BCuds8YHadNUADvwUbzyOdskX0i7vBksRZkbl0NAFeZ2RZUo3uzuhikbsqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746640145; c=relaxed/simple;
	bh=e8m12oB+PAXHw9PasXT8ldfd3ooHEH1qA/KyTNGeaYo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ju6/GUHFZ+zzzaWL/v3PuNYuhAlmeQ0NiK1qE/FLJAn3BgNxKMzKZJAOJc2Wc4ldy4oG1Y3BtO9H3aSl2gza77EQyaHaclwCOFoXPorpe102uOHbGrGPFullWrw48wZ7Dea9cJxHk7yrfVnKBhRTynktL7vju8c0aaob6EbFs8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ea9sJqjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D88C4CEE2;
	Wed,  7 May 2025 17:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746640144;
	bh=e8m12oB+PAXHw9PasXT8ldfd3ooHEH1qA/KyTNGeaYo=;
	h=From:Subject:Date:To:Cc:From;
	b=ea9sJqjBQWfoh//KVPojoXUqTxI1pc+dRs0r45XMVo07QYuXKL/wd8KupbatWPnGU
	 mV2k45f1QoHZmhEf+9XK7OQJRpzO0KGD8zGYxP7ibBihwzncOMZHWvYe4msCoKoWqP
	 +fmfd2Dku8m2bp5nb7UJfQvntVzGZb1/3B+puppBVhJ6z8hVciTXuJ4eprk/ni1EtK
	 ZMbt5gdhxGeq/geqaYAWokdBCRnPlOYtFCrLhENWFqij5a/Ez3Lo7B7hfoT/yDAbl1
	 wEm6dY1fJZmkQR7nQS1k6HGv4lmXJogOs6ErvHdOygaDgnra1C8cHLKBuRAx5gssNJ
	 iLbPZfTXPZE6g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/2] Add the capability to allocate hw buffers in
 SRAM for EN7581 SoC
Date: Wed, 07 May 2025 19:48:44 +0200
Message-Id: <20250507-airopha-desc-sram-v1-0-d42037431bfa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPycG2gC/x3MPQqAMAxA4atIZgNVqYJXEYe0RpvBHxIQoXh3i
 +M3vJfBWIUNxiqD8i0m51HQ1BXERMfGKEsxtK71zrsBSfS8EuHCFtGUdlyJQ8fUxxA9lO5SXuX
 5n9P8vh/6t3GrYwAAAA==
X-Change-ID: 20250507-airopha-desc-sram-faeb3ea6cbc5
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

In order to improve packet processing and packet forwarding
performances, EN7581 SoC supports allocating buffers for hw forwarding
queues in SRAM instead of DRAM if available on the system.
Rely on SRAM for buffers allocation if available on the system and use
DRAM as fallback.

---
Lorenzo Bianconi (2):
      dt-bindings: net: airoha: Add EN7581 memory-region property
      net: airoha: Add the capability to allocate hw buffers in SRAM

 .../devicetree/bindings/net/airoha,en7581-eth.yaml | 13 ++++++
 drivers/net/ethernet/airoha/airoha_eth.c           | 48 ++++++++++++++++++----
 2 files changed, 52 insertions(+), 9 deletions(-)
---
base-commit: 9daaf197860055aa26c06d273d317c18c6e3621a
change-id: 20250507-airopha-desc-sram-faeb3ea6cbc5

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


