Return-Path: <netdev+bounces-172238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E101A50F1F
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 23:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02083AE465
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 22:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E13D265632;
	Wed,  5 Mar 2025 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsbN9juf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7834D263C97
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215154; cv=none; b=dFyMT2rbDwWoG7xhDseazV2u8aS3/RGbX6TGyKSgpJiHx9raTtBUiXhYPCM6eyCOjtKVcfJsiScwYQVgFe+3cL5GAogSPYRh8gXsQ0z7gmRooH36i/oICiUJhQ4AG5FoPHxUI1FwK39GN+uyuUHnYOj10thzIGS8uafn78mL7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215154; c=relaxed/simple;
	bh=j+HM0zxu1T9sDSYQfj0qD5Ow787jp4ngF/cckbf0Hoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGWTLJyNdsMz5h4EOKDCMcf1jJWog1Q61O2Gsj6Z7eO/NCvG6Iwi/8xg9h/wLdR3wilC91NmlBxBHkf8WAr0l3v3cm/Se9tnEp42FmnAA8FVwOZmeyTq5EmV+bY3vm2KmPBFAx2HwhzMtJF2aZi0VtsLSoA82WhfJpYqWbGFAmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsbN9juf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14720C4CED1;
	Wed,  5 Mar 2025 22:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741215154;
	bh=j+HM0zxu1T9sDSYQfj0qD5Ow787jp4ngF/cckbf0Hoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hsbN9juf/Gtg26oYdsJrx/WfmJFPz7fda5dWD7qyVAI0rzBkiyht+g6xPl0i9PYGy
	 wv6m/vRhJYVEqaR+HIEaOTHu6jN+1it6prmksF4NU4hGgeBtdiBPb6sQbJARAgMgot
	 IJ+BSrkKthrjC6usziabPHDDus+n7qxtP2Pez+1ZiokNPYwvQG+qOUyw+6t5MhWSc+
	 1JHjeWGxI7+c1ix67khMGFIyycejpFfWTqV1nAHpHfQQcbvENu1Tpj4xs8B7ZgvenK
	 jOCzJCRhubiw5HSdpuZX3Vk+JKfBsxT+xKDGMCBw33T4OD8Xp8VMeH05K37YgPFAHE
	 JRnuSB87Leufw==
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
Subject: [PATCH net-next v3 05/10] eth: bnxt: don't use ifdef to check for CONFIG_INET in GRO
Date: Wed,  5 Mar 2025 14:52:10 -0800
Message-ID: <20250305225215.1567043-6-kuba@kernel.org>
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

Use IS_ENABLED(CONFIG_INET) to make the code easier to refactor.
Now all packets which did not go thru GRO will exit in the same
branch.

Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 854e7ec5390b..d8a24a8bcfe8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1740,12 +1740,11 @@ static inline struct sk_buff *bnxt_gro_skb(struct bnxt *bp,
 					   struct rx_tpa_end_cmp_ext *tpa_end1,
 					   struct sk_buff *skb)
 {
-#ifdef CONFIG_INET
 	int payload_off;
 	u16 segs;
 
 	segs = TPA_END_TPA_SEGS(tpa_end);
-	if (segs == 1)
+	if (segs == 1 || !IS_ENABLED(CONFIG_INET))
 		return skb;
 
 	NAPI_GRO_CB(skb)->count = segs;
@@ -1759,7 +1758,6 @@ static inline struct sk_buff *bnxt_gro_skb(struct bnxt *bp,
 	skb = bp->gro_func(tpa_info, payload_off, TPA_END_GRO_TS(tpa_end), skb);
 	if (likely(skb))
 		tcp_gro_complete(skb);
-#endif
 	return skb;
 }
 
-- 
2.48.1


