Return-Path: <netdev+bounces-198020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F214ADAD57
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1C8188B44C
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 10:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D05295DAA;
	Mon, 16 Jun 2025 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAAd/DRo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45D427AC30
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750069638; cv=none; b=ts3SXNUR9ti6LWm1aLrqciNKq8Eh90tRt88yijHPBAQIsSclvnuILgXvyItWWEIDK/DVZCIrTtWp57Ork7njwp6V2qGwYxkhASigGkExK7EeIf9gWCtarjtu9KkMZtoVPPZYTGfC/Svct6Hl6/n1kgaP4p2nwvp+bdzy3wGA5/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750069638; c=relaxed/simple;
	bh=Rse1XPrFQM8gbRQ9n75PNuNKPkjS6jSQ0wCaAW+iRNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LOBSiR4M9APVjKGc1Yj+D6GiB7jPTTIMJey/61ld+cLbQjx1vKwzYVaqneVGTCnVu/xJI5wrbLkgvz8+OtoWOHStTlmp+bJEsjJitu+6pzXXLxLnnF3PZVU3Yl9GGIny802vF8AdYPK4J+B2WCIpsRw9FJCDZU9fPqC+NM5gpQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAAd/DRo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1806CC4CEEA;
	Mon, 16 Jun 2025 10:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750069637;
	bh=Rse1XPrFQM8gbRQ9n75PNuNKPkjS6jSQ0wCaAW+iRNM=;
	h=From:Date:Subject:To:Cc:From;
	b=KAAd/DRo0OmWZZI5v2URno/X6HitKTcgiKTw4c/LOp3EkMgvk+imqnxTszK/uIS2v
	 6u2e/aCFu+4SALH3jXGh96ihmbWGJuKUTfxTadTd0jeuedL8DaMYWMgQKag34Chypl
	 f6uMO5wGfatE8IW/x3LgSdih76upC3A4eN9VP/PGB2iFLqtdV4pFBLuYG+7vKFSsf6
	 betuBIdV8wEzsQjJ0WqxRDcF7X5Sl1XLGX9AOAiCVmGKDZ/RY1v6P6xiEkCzpo+UWC
	 ONbVcLh0djWkY66657y5F99ygHecPphlLyfLNayPJAE+I+UrAxXigSiiiuQW83n50h
	 WuXg3WNnSuTmQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 16 Jun 2025 12:27:06 +0200
Subject: [PATCH net-next] net: airoha: Always check return value from
 airoha_ppe_foe_get_entry()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-check-ret-from-airoha_ppe_foe_get_entry-v1-1-1acae5d677f7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHnxT2gC/x3NQQrDIBBA0auEWXdAhZjQq5QiYsY4lKqMUlpC7
 l7J8m3+P6CRMDW4TwcIfbhxyQP6NkFIPu+EvA2DUWZWVlsMicILhTpGKW/0LCV5Vyu5WMjt1B3
 lLj8062yXRSuzRQ+jVoUif6/T43mef+f0SjR5AAAA
X-Change-ID: 20250616-check-ret-from-airoha_ppe_foe_get_entry-285677102dfa
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

airoha_ppe_foe_get_entry routine can return NULL, so check the returned
pointer is not NULL in airoha_ppe_foe_flow_l2_entry_update()

Fixes: b81e0f2b58be3 ("net: airoha: Add FLOW_CLS_STATS callback support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 50d816344b1f8c1ed639de357f62e761ede92f05..c354d536bc66e97ab853792e4ab4273283d2fb91 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -819,8 +819,10 @@ airoha_ppe_foe_flow_l2_entry_update(struct airoha_ppe *ppe,
 		int idle;
 
 		hwe = airoha_ppe_foe_get_entry(ppe, iter->hash);
-		ib1 = READ_ONCE(hwe->ib1);
+		if (!hwe)
+			continue;
 
+		ib1 = READ_ONCE(hwe->ib1);
 		state = FIELD_GET(AIROHA_FOE_IB1_BIND_STATE, ib1);
 		if (state != AIROHA_FOE_STATE_BIND) {
 			iter->hash = 0xffff;

---
base-commit: 8909f5f4ecd551c2299b28e05254b77424c8c7dc
change-id: 20250616-check-ret-from-airoha_ppe_foe_get_entry-285677102dfa

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


