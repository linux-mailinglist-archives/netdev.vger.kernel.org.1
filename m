Return-Path: <netdev+bounces-229982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 640FFBE2CA2
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4EF519C863F
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFC3311592;
	Thu, 16 Oct 2025 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="is4hDyEi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8A52E0925;
	Thu, 16 Oct 2025 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610543; cv=none; b=X0yjbraaZdw7ZhynGTNBKeC/7PtLRxlPKiZ0VBMNReW2uHVKp3cw1Yvo4hQf7fpquc6KXBOasXHciBaHuhRwBqYP8Qf/a0H6JeDhrcx2hGYjqEzVOJCoplByH8haXzB8QXRqul5jjBbc3P2LOezViHsBG4FqYek1UfUaa1aPv00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610543; c=relaxed/simple;
	bh=2hNyNS6XgkjccYANXlv5LduUzRd2LBIUmU8MlMuX+94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ETdany0egXdJJPXwNzX+bVSGALYok+awliD+EKElhsmBAjC7b7nHO/6evjUZ0usILb/jW8n1th1982BD6V7MCYZTpQAHqycBXf7dTpN9in6hhOabxzi5NEn78NEYxYspnSxAR9f9kb5Kb46keT7ASB4zxrsr11I/iE7kJCYmR94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=is4hDyEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1597CC4CEF9;
	Thu, 16 Oct 2025 10:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760610542;
	bh=2hNyNS6XgkjccYANXlv5LduUzRd2LBIUmU8MlMuX+94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=is4hDyEifiBZhX1q9qu4NFgRnxQuuQiFogwQq0UM9woOUxn9dlLzvPXpR1KrVhzT4
	 QwIdYdZykCDTyYJOKcEVYoL/GXpSEoaWOon2dWexXGSfNhzLfXDT1wKaTzfGkqeSb9
	 eYGL9TYzBe1kr6WdJ5wzV88Lx+r2SZolG5N8t6pexNx2r5lh1mv7pmby/gcgUDjKaJ
	 qwPkO/cA8g/6hFekFbK2xex/2kLEURJinjQ/TCaVwuUAWBbTzipWoMEsj5YoGQ21t5
	 fN2J6kFNDff4O21OQjI+Kh/lu0G/758Hu4bxTK+ueeoi6Wjd3ho2bzD/Wn3gHeAqSE
	 2F9Bp7Ou9r3AQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 16 Oct 2025 12:28:23 +0200
Subject: [PATCH net-next v2 09/13] net: airoha: ppe: Flush PPE SRAM table
 during PPE setup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-an7583-eth-support-v2-9-ea6e7e9acbdb@kernel.org>
References: <20251016-an7583-eth-support-v2-0-ea6e7e9acbdb@kernel.org>
In-Reply-To: <20251016-an7583-eth-support-v2-0-ea6e7e9acbdb@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2

Rely on airoha_ppe_foe_commit_sram_entry routine to flush SRAM PPE table
entries. This patch allow moving PPE SRAM flush during PPE setup and
avoid dumping uninitialized values via the debugfs if no entries are
offloaded yet.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 46755bc60a8e822b296e188c061c45eae0b88cb5..4b038673cefe20b47c42dd1419c05b57d4d6c64d 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -1291,18 +1291,22 @@ static int airoha_ppe_flow_offload_cmd(struct airoha_eth *eth,
 	return -EOPNOTSUPP;
 }
 
-static int airoha_ppe_flush_sram_entries(struct airoha_ppe *ppe,
-					 struct airoha_npu *npu)
+static int airoha_ppe_flush_sram_entries(struct airoha_ppe *ppe)
 {
 	u32 sram_num_entries = airoha_ppe_get_total_sram_num_entries(ppe);
 	struct airoha_foe_entry *hwe = ppe->foe;
-	int i;
+	int i, err = 0;
+
+	for (i = 0; i < sram_num_entries; i++) {
+		int err;
 
-	for (i = 0; i < PPE_SRAM_NUM_ENTRIES; i++)
 		memset(&hwe[i], 0, sizeof(*hwe));
+		err = airoha_ppe_foe_commit_sram_entry(ppe, i);
+		if (err)
+			break;
+	}
 
-	return npu->ops.ppe_flush_sram_entries(npu, ppe->foe_dma,
-					       sram_num_entries);
+	return err;
 }
 
 static struct airoha_npu *airoha_ppe_npu_get(struct airoha_eth *eth)
@@ -1339,10 +1343,6 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
 	}
 
 	airoha_ppe_hw_init(ppe);
-	err = airoha_ppe_flush_sram_entries(ppe, npu);
-	if (err)
-		goto error_npu_put;
-
 	airoha_ppe_foe_flow_stats_reset(ppe, npu);
 
 	rcu_assign_pointer(eth->npu, npu);
@@ -1513,6 +1513,10 @@ int airoha_ppe_init(struct airoha_eth *eth)
 	if (!ppe->foe_check_time)
 		return -ENOMEM;
 
+	err = airoha_ppe_flush_sram_entries(ppe);
+	if (err)
+		return err;
+
 	err = rhashtable_init(&eth->flow_table, &airoha_flow_table_params);
 	if (err)
 		return err;

-- 
2.51.0


