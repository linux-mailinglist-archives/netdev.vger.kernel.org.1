Return-Path: <netdev+bounces-230397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F02CBE775F
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 11:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3791118992F5
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072BB3128C7;
	Fri, 17 Oct 2025 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMpZnIh6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29612D5957;
	Fri, 17 Oct 2025 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692022; cv=none; b=qSqkWbiTXore48ECM7tuMi9uOKoqYcrQ9QfDWwdbzz9P/F/IK5nZcoGCDBhkjWZ3tGfaeDMz2RaPR9OTA68v1sa8PSVHt94mCn9PFIMUiw5G58lrQ7uWreWH1CzqBlNAqwqFTXqmsBBK9cXwZe053mCqoUqCUr3j3y8AvxW0oS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692022; c=relaxed/simple;
	bh=ZTKgysNNfScjYNlHG2PtLbUTn95/y+2fnSbvS4Vbw0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KMPk6A5n428M4USturVGQ6FJkowlqT5+06a4Xor/WELUsJyF0qQIem7idSTUKkSK0sh5Aig9j963RVY7ChgC6nnPgRowJeK/imFSts4op4SnkfXzirU650lMnvBrvEu8RDYKSkw4lar5Z7EQ7q+BvEFhIiRDM9z5rRDtHYT5FrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMpZnIh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBCCC4CEE7;
	Fri, 17 Oct 2025 09:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760692022;
	bh=ZTKgysNNfScjYNlHG2PtLbUTn95/y+2fnSbvS4Vbw0U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IMpZnIh6Fl3S1fF14hVVKkclmY4figgjW5dWv8yzfQHUmYllVL+zv1TzD2G6X3Kuq
	 P+Q8EHM3R3BPlf5VD0s/9BHK2lYKRqPJ3N0taJYw7NruQfcuAI9tXvxw6l7JCShVIH
	 appo4+HPBUc6ITUcgxKT4/RjaxUPhT2qOHDPbBBl+NXRQar4gw3bRu0wH4xdDkoSXv
	 gEiXhVQWrFnl8Y9UxPCVKsXPZcEA0Z7f/dYU+8DHZwVmFjDMY50rqbOo+J2Kbios6a
	 ATMKiVeHdZWMV5DF2ML79/t6J6zc3ndxAZZnM+u02mXwnDqDDBfs4oBgnp6qBsgYn4
	 uJPtDTNkH79Dg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 17 Oct 2025 11:06:21 +0200
Subject: [PATCH net-next v3 12/13] net: airoha: ppe: Do not use magic
 numbers in airoha_ppe_foe_get_entry_locked()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-an7583-eth-support-v3-12-f28319666667@kernel.org>
References: <20251017-an7583-eth-support-v3-0-f28319666667@kernel.org>
In-Reply-To: <20251017-an7583-eth-support-v3-0-f28319666667@kernel.org>
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

Explicit the size of entries pointed by hwe pointer in
airoha_ppe_foe_get_entry_locked routine

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 4b038673cefe20b47c42dd1419c05b57d4d6c64d..eda95107cd1daf6ff00a85abc72313a509ed67e9 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -619,7 +619,8 @@ airoha_ppe_foe_get_entry_locked(struct airoha_ppe *ppe, u32 hash)
 					     REG_PPE_RAM_CTRL(ppe2)))
 			return NULL;
 
-		for (i = 0; i < sizeof(struct airoha_foe_entry) / 4; i++)
+		for (i = 0; i < sizeof(struct airoha_foe_entry) / sizeof(*hwe);
+		     i++)
 			hwe[i] = airoha_fe_rr(eth,
 					      REG_PPE_RAM_ENTRY(ppe2, i));
 	}

-- 
2.51.0


