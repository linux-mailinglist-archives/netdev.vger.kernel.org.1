Return-Path: <netdev+bounces-170482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CA8A48DDF
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA7D168535
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AE02B2DA;
	Fri, 28 Feb 2025 01:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4CcCcW8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137AA24B34
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740705938; cv=none; b=UY3dPIWJkO7A84kZV895LEtQx2VhyLZ8TCC6JYWEUF3TbT6fhOfMXK4OE5ap/hawI2gMisWmhHAYhPSw3uSnlntpxxT+2Rr1RiSdkTipBnWKRwDSG/ftzlBtVKyy+sJ3MC9J92tt1rhH84EiYsRHdGSLDDNXpFsQtBAGESH0Rr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740705938; c=relaxed/simple;
	bh=xlfesCAYFJuORciIZ6LM+t4QFT/GvQSC3mgpWimbL/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1ZIlH9kC4u6TWdEWLxD8MPTLLYAesLmJzchdiaeICQx5o6ITklBknZhMpL1zym2jRn2fWdx+3fhrODCSmXYPXPrZ1jRocrZViqTf/Ujqto/4p9dVkAzGdYjdnJgSIrQPFU9KJY5uF/F4M/nP2nNMoi0NWot5IiOsFeWz1Atm1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4CcCcW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E47C4CEE7;
	Fri, 28 Feb 2025 01:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740705937;
	bh=xlfesCAYFJuORciIZ6LM+t4QFT/GvQSC3mgpWimbL/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g4CcCcW8UE0P2zAOR7cXr4GWi3YlQ13gfAIhOhfobKjkRJyCbpdPdUtixLTae9G9u
	 3qzLLxxOQirQLVgMJHJSEPI9/xjM/xAdYUtHIWsrPw1AcQurAXLSd4fz5MEHz2q7Qb
	 Zx7+yRXTsbUrp5FYJ62qsRdonfL2SQ/qK9qUl37ZZN9Rh8KYBl9V4VFYS8p3yLhFy4
	 JCq2xARjnZHsG2AvOjLU+h4m5C46ikyYd1vi2TxlhEPfHhAh2hvDIeijFc2wqe6R8A
	 bBiY/Q8YzzU8v67wTzbwbb6pk5hCcQTHQWnn7Zy5GFI5saiUp2F+oSZPVguqH5tPrD
	 B0KZyeAqF8Lkw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/9] eth: bnxt: use napi_consume_skb()
Date: Thu, 27 Feb 2025 17:25:26 -0800
Message-ID: <20250228012534.3460918-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228012534.3460918-1-kuba@kernel.org>
References: <20250228012534.3460918-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use napi_consume_skb() to improve skb recycling.
__bnxt_tx_int() already has the real NAPI passed in budget.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 15c57a06ecaf..f6a26f6f85bb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -855,7 +855,7 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 next_tx_int:
 		cons = NEXT_TX(cons);
 
-		dev_consume_skb_any(skb);
+		napi_consume_skb(skb, budget);
 	}
 
 	WRITE_ONCE(txr->tx_cons, cons);
-- 
2.48.1


