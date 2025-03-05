Return-Path: <netdev+bounces-172235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B663A50F1A
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 23:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909D53AE4DA
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 22:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA812080FB;
	Wed,  5 Mar 2025 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnMhcNN6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1811220767B
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215153; cv=none; b=Zt/vbb6bPWIllP245XbHHCRH0lc74agSKaUB8Z0JiVIBs/HJ09AR7b/DujVJqRQN2j0vSlazY1BEFcsxYf/LhM8D053wCneh2CyGs3eynIpFIgUxeETy9aD3AJM7ifQ//aohg4gZhCDsogp8ZGNCUACXSvMqX5AYRU/RjnX3+7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215153; c=relaxed/simple;
	bh=xlfesCAYFJuORciIZ6LM+t4QFT/GvQSC3mgpWimbL/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHxNa6/gHFIRExOzdiGOMLP68EutsRasulZxsP+o4RRLsqa4m1s1y6wPlO/WVaY8q3RMvh/mtNFXp4u3e1+B1CqJy2sDDgpvswWxPW6Nw2242z40eePYASeYZNlWSNzkuKEQ/tJO7y0NQ7BN3oI0aXhp/a3MAqqZEvjAwsn1s6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnMhcNN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED01C4CEE0;
	Wed,  5 Mar 2025 22:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741215152;
	bh=xlfesCAYFJuORciIZ6LM+t4QFT/GvQSC3mgpWimbL/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XnMhcNN6FmYw2BD57DmHgdTmTxAUKsYhz7p4ysndf5MAf0oosCG8sZS5gfM2e0zpj
	 xGR6UdNaWj2AM13fGIDuxt4dURnkYpGN3vtDWqGa3PcWPGjmVOjmK3tsPaj3Xq6Y2b
	 EJ7rC99vU3Y16gfq/iC+eoMVDGsXPVYYKdQO2RBpgO6z1AaeNJ8pJMgGJyweLACPPt
	 EkqoyLdk5GfwUOybQEphf/rfLdJGcTYh/+E6ALBACrL+bSumPeiFVsp4rymCBNC2/Y
	 95SBn1X3NUfSwlEwXg5gwv0chO6/H4YA31bWFjeKD6yYOGwa9EIINutNBTbITENK8p
	 MCXmicoIbu2dA==
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
Subject: [PATCH net-next v3 01/10] eth: bnxt: use napi_consume_skb()
Date: Wed,  5 Mar 2025 14:52:06 -0800
Message-ID: <20250305225215.1567043-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305225215.1567043-1-kuba@kernel.org>
References: <20250305225215.1567043-1-kuba@kernel.org>
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


