Return-Path: <netdev+bounces-165426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C74A31F7A
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 07:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322521887E8F
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 06:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DE81FCF43;
	Wed, 12 Feb 2025 06:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6zZRBlf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0361F2367
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 06:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739343131; cv=none; b=MjjVij5kBOw7EUQ1XfrL8wOJa3o2xHcb1p025DqWmFILt9qXlWpLTyU0FYpmxAFiCCr4Z7stmwkgOkEgFdq/pnCHtYALPir9Zld2CYmQQx2cgCFYMuDi8meGUM6scgmJb+XqWnpt4vC74pKzQ5uY22IZ7mbVgOnyJLzFLN7mBvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739343131; c=relaxed/simple;
	bh=4WreFNYgftWVc1aDlkY0DugTCMVqujOyi80mA6w1cA8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L1puIr9966I39nzgOX0rrnuEANUdOKFfDJaI+486hbjDYvh2zKtqM/swvSc5PxIcgT4b/O6NXXmyt53YjyydCYU0KOy3E6dmrSqFDgrE3kyQ5pywIw18yqS1Pw23hejt0jtIloGaXpWRMiDq3z4ZoOhl0lQsJNLJnAIOrRzdkT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6zZRBlf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C2CC4CEDF;
	Wed, 12 Feb 2025 06:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739343131;
	bh=4WreFNYgftWVc1aDlkY0DugTCMVqujOyi80mA6w1cA8=;
	h=From:Subject:Date:To:Cc:From;
	b=H6zZRBlfnfL04nfDSsaK3d5deuRCNlXLxeQliGnDqH6igA9LJ5CqALnC35/5l5xYD
	 YfXvZF0VBFuKqFWlY3yoXeHNnE9ozgj5L8vcssKV/XUjjtzJxVfn9q5AO0RKapvZ4M
	 WSvUrw+s8eu6FFn/Xkjbus88VMOlqB9M+WrjzWWOyWtQOSTp9QK7WIZbBLWv9Ex2GJ
	 pD2HB+ri35bbTLkEDIrigjKOu5uA58siULA2uwtBaXHJsTHHO4+1IqJuyOp0y0sGm8
	 Ya20aUeNAeTaSuGfSF6tn3dq0hT15IYJdnIOxtd2cHQHpqV3HDM7Oc9zErZ7DlJwVS
	 bvueldK5b0aUQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/2] Enable TSO for DSA ports on Airoha EN7581 SoC
Date: Wed, 12 Feb 2025 07:51:46 +0100
Message-Id: <20250212-airoha-fix-tso-v1-0-1652558a79b4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAJFrGcC/x2MQQqAIBAAvyJ7bkHFgvpKdDBbcy8aGhGIf086D
 sNMhUKZqcAiKmR6uHCKHdQgwAUbT0I+OoOWepRaKbScU7Do+cW7JDTGTn52uzJOQo+uTF39w3V
 r7QNW5sjHYAAAAA==
X-Change-ID: 20250211-airoha-fix-tso-44a6f9cb14c0
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Add missing vlan_features configuration to enable TSO/Scatter Gather for
airoha_eth lan ports.
Fix checksum configuration for TSO packets with cloned headers.

---
Lorenzo Bianconi (2):
      net: airoha: Fix TSO support for header cloned skbs
      net: airoha: Enable TSO/Scatter Gather for LAN port

 drivers/net/ethernet/mediatek/airoha_eth.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)
---
base-commit: 4e41231249f4083a095085ff86e317e29313c2c3
change-id: 20250211-airoha-fix-tso-44a6f9cb14c0

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


