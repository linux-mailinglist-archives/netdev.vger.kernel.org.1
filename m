Return-Path: <netdev+bounces-229493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305B1BDCDF4
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA6D3C40BC
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEBC3148CE;
	Wed, 15 Oct 2025 07:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nK9B6WEI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5A43126BE;
	Wed, 15 Oct 2025 07:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512551; cv=none; b=qRkkvOPdf7qdHcbYHKGpfROTj2duUkyMiu8sLblyXWFNalXhAYbSywrpzI+1+KJwvAymaUqgKPH4IIdQPXO9bFqOgdzxOF45wsF42iDWiTlItrWMgZKI2xZLF2wJFzLiLW2oZYENT58WWfrHI03ykqMAaLb0bhWeW0rxfwoaGUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512551; c=relaxed/simple;
	bh=7Xfx4Gtt1A7e+sygtsql3O/QaS8Irt67/L0QwGoKAEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k5Zip0pdpfCODa+oD2s6U8ykbj+t9vw7PZq7H43S0rlt57T2i2ZsYMczVQfSQ6kI7r0IK5IMuSO53KTxmZObLFr664O8ezd1stOFVFUiZoZgV2e8pWjaFL0NfuyZmNW9TFwZvwB4V6bPUXmfdEiUe0A1SzmjJ72QMKC9amSN7sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nK9B6WEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA3EC4CEF8;
	Wed, 15 Oct 2025 07:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760512551;
	bh=7Xfx4Gtt1A7e+sygtsql3O/QaS8Irt67/L0QwGoKAEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nK9B6WEINI42DCw3YaYez/obN3YwzzHIQjhB8GDDsA+wW/90JxgJAjLEJneKg6dc6
	 TJHMjHi/ep0Kln0JAkLRB3h85TP7Ezv1YGineXiRrjP2R3ZmY0eLX6bje9hdvpcqNv
	 4E3tujP5j3INUo4V1vVqIc/u7f7qc6w7uxqVlNgnB/yu/I07qMIk5IZhPxW1g/8z8G
	 zZX843xDQ0D4LUytcLtTgdpSX24KuJVpv0zmxyrGZ01AjdBiYTY+bmr+s1W6buNsGi
	 qdIGkgOHJGofho1YYSJh8oXpfIYnY1aad+JYi7wzYuTSvSIpkyv2rY7uIDGx15qtnF
	 vQA2W/U/r50Jw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Oct 2025 09:15:08 +0200
Subject: [PATCH net-next 08/12] net: airoha: ppe: Configure SRAM PPE
 entries via the cpu
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-an7583-eth-support-v1-8-064855f05923@kernel.org>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
In-Reply-To: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce airoha_ppe_foe_commit_sram_entry routine in order to configure
the SRAM PPE entries directly via the CPU instead of using the NPU APIs.
This is a preliminary patch to enable netfilter flowtable hw offload for
AN7583 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index fcfd2d8826a9c2f8f94f1962c2b2a69f67f7f598..0ee2e41489aaa9de9c1e99d242ee0bec11549750 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -662,6 +662,27 @@ static bool airoha_ppe_foe_compare_entry(struct airoha_flow_table_entry *e,
 	return !memcmp(&e->data.d, &hwe->d, len - sizeof(hwe->ib1));
 }
 
+static int airoha_ppe_foe_commit_sram_entry(struct airoha_ppe *ppe, u32 hash)
+{
+	struct airoha_foe_entry *hwe = ppe->foe + hash * sizeof(*hwe);
+	bool ppe2 = hash >= PPE_SRAM_NUM_ENTRIES;
+	u32 *ptr = (u32 *)hwe, val;
+	int i;
+
+	for (i = 0; i < sizeof(*hwe) / 4; i++)
+		airoha_fe_wr(ppe->eth, REG_PPE_RAM_ENTRY(ppe2, i), ptr[i]);
+
+	wmb();
+	airoha_fe_wr(ppe->eth, REG_PPE_RAM_CTRL(ppe2),
+		     FIELD_PREP(PPE_SRAM_CTRL_ENTRY_MASK, hash) |
+		     PPE_SRAM_CTRL_WR_MASK | PPE_SRAM_CTRL_REQ_MASK);
+
+	return read_poll_timeout_atomic(airoha_fe_rr, val,
+					val & PPE_SRAM_CTRL_ACK_MASK,
+					10, 100, false, ppe->eth,
+					REG_PPE_RAM_CTRL(ppe2));
+}
+
 static int airoha_ppe_foe_commit_entry(struct airoha_ppe *ppe,
 				       struct airoha_foe_entry *e,
 				       u32 hash, bool rx_wlan)
@@ -691,13 +712,8 @@ static int airoha_ppe_foe_commit_entry(struct airoha_ppe *ppe,
 	if (!rx_wlan)
 		airoha_ppe_foe_flow_stats_update(ppe, npu, hwe, hash);
 
-	if (hash < sram_num_entries) {
-		dma_addr_t addr = ppe->foe_dma + hash * sizeof(*hwe);
-		bool ppe2 = hash >= PPE_SRAM_NUM_ENTRIES;
-
-		err = npu->ops.ppe_foe_commit_entry(npu, addr, sizeof(*hwe),
-						    hash, ppe2);
-	}
+	if (hash < sram_num_entries)
+		err = airoha_ppe_foe_commit_sram_entry(ppe, hash);
 unlock:
 	rcu_read_unlock();
 

-- 
2.51.0


