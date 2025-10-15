Return-Path: <netdev+bounces-229487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51135BDCDAE
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998FD19A4FC9
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF9B31281E;
	Wed, 15 Oct 2025 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQ3+j/rL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2E32153E7;
	Wed, 15 Oct 2025 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512537; cv=none; b=fdVaE1oNYFbhENCDN777WfS/DXmCma8Zo5l0lQeDANnqhspbFkJraPJ5wjStYUuW2fxw2HBHSGkgCeqGS5fsv1bbXFUop0Z3PZjBV1SiZgpG4fpz1Ii5KamYHu4/WsBJWAyo4wUuyzqIEgzMGpw+Xre1gzMIwlnpEQIoVv4O1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512537; c=relaxed/simple;
	bh=Evnl21vrZtWSZfim1BEaHg8W/MkovgamjiTZHLmL3Ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oiE2CvoJiHdMd0j/Sj38Ht1aRSGLf7l1nZXIzt6I1RjPS+rX1ELRk3HhYNoM39vLlrqKQst4ibcQySV2Nn4YTs8uhJiq61DymbZyWjaoH6boQKl8sSL3AAYLp87frzdgD+QA+o76fmeUzySSwxEZZ06U8pZ1ovSKNOWb8DkQcGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQ3+j/rL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9356C4CEFE;
	Wed, 15 Oct 2025 07:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760512536;
	bh=Evnl21vrZtWSZfim1BEaHg8W/MkovgamjiTZHLmL3Ac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CQ3+j/rLKZX6EdUpqOj0pJ8BZJu0ds7t+t4UYbbfuVYfoCrGpBHFcFP1j0y+RN/xI
	 93GiMblJhmoDqMoo8HuF33pi/hZv0opHnzE2G3EmXcudD+gW/nPtKX8HGajNZY2VB6
	 yd0ad6zK5orMrBRn6paDPl9bquQ3NqBt6e4TRpTXfCMBPl7zrB8S1tFPJ0lYx2LZFa
	 +hupH/gRbNgdU6qlGoGlzrtYgawSoiv8hGYu0Onb2FtdU61Oolz+A7Cuk3/AYpMgCF
	 Y8bF54HUn3AdHrExyHMDko8Zj3BXV6m9wv6zhRYHtnkross5n1CrW6EJMGFlvRSUAJ
	 0OCR+yHVirPTg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Oct 2025 09:15:02 +0200
Subject: [PATCH net-next 02/12] net: airoha: ppe: Dynamically allocate
 foe_check_time array in airoha_ppe struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-an7583-eth-support-v1-2-064855f05923@kernel.org>
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

This is a preliminary patch to properly enable PPE support for AN7583
SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.h | 2 +-
 drivers/net/ethernet/airoha/airoha_ppe.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index cd13c1c1224f64b63d455b24ce722c33c2fa7125..4330b672d99e1e190efa5ad75d13fb35e77d070e 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -554,7 +554,7 @@ struct airoha_ppe {
 	struct rhashtable l2_flows;
 
 	struct hlist_head *foe_flow;
-	u16 foe_check_time[PPE_NUM_ENTRIES];
+	u16 *foe_check_time;
 
 	struct airoha_foe_stats *foe_stats;
 	dma_addr_t foe_stats_dma;
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 691361b254075555549ee80a4ed358c52e8e00b2..8d1dceadce0becb2b1ce656d64ab77bd3c2f914a 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -1440,6 +1440,11 @@ int airoha_ppe_init(struct airoha_eth *eth)
 			return -ENOMEM;
 	}
 
+	ppe->foe_check_time = devm_kzalloc(eth->dev, PPE_NUM_ENTRIES,
+					   GFP_KERNEL);
+	if (!ppe->foe_check_time)
+		return -ENOMEM;
+
 	err = rhashtable_init(&eth->flow_table, &airoha_flow_table_params);
 	if (err)
 		return err;

-- 
2.51.0


