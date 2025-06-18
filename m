Return-Path: <netdev+bounces-198910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63338ADE4A8
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10056174B1E
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 07:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B190F1FFC48;
	Wed, 18 Jun 2025 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaDVWtaY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B25B2F533D
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750232273; cv=none; b=YgJLyX6z22BimAJNeFXeFzxvIwtaYaAZp50cs1NMJdic6Oo4xFzTliqpa5Njl0bQhfE8Vao9wfvI7M5EQEN5n2LXLseLKCHjyrTsVFShPNyh38QXG3A0hwmZxKKYC7hWd06Oju4ytHTRc7aVklvG3MsJhrz1CpiDZSbWLzI/zjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750232273; c=relaxed/simple;
	bh=C8cDydoGOBcR8NvM/4b7j8MB33R0OSAtbo+7+9KQiJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JfLepHMxkt/t1EqkN0D4gZB/zezB5lFm3IjhHcLLekRdc9KT88J0XmVt+pt8/9TZik1uNc6VnHqOdiM9RyzINPNbGF/YhxzR4Psvhd6hfRidTektMOGiLYcr19AaAiTWQB+Q9PFnMdR0sts1ZQZwHwoK2exdtEj3oQMa1UB9oiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaDVWtaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B0CC4CEEF;
	Wed, 18 Jun 2025 07:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750232273;
	bh=C8cDydoGOBcR8NvM/4b7j8MB33R0OSAtbo+7+9KQiJQ=;
	h=From:Date:Subject:To:Cc:From;
	b=eaDVWtaYiFzXj5XEQY9BiNKvXNH+YTToyJxw4JhPH63t/GXjhQawT4nv2zRYIaZVF
	 ORNk6KIi6cr4b0i72kd/mUYp/k5jUsO4FkmqyaYUmeZD/VO5s/1XdJAYjkO7O1BWSb
	 WiqxJS3BDxasTTcic8X76KtSjw6/FIejlKIR93QkfyYFaSKO8wy9S4UZ16tIV7Recc
	 +uOjiaW06h+6RcEo1CBx558ebpDarJfh/kVxc9jK5vaYxLhsuRCAmq4rPIcDFZ75XJ
	 7T7Dx92upt+1LiawAY8VUXNPM6HuNTseCAbdtxqPSjxuTfpWcMtc/AzLvFKvQ1fUDb
	 XGM/y9VTyYM2Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 18 Jun 2025 09:37:40 +0200
Subject: [PATCH net v2] net: airoha: Always check return value from
 airoha_ppe_foe_get_entry()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-check-ret-from-airoha_ppe_foe_get_entry-v2-1-068dcea3cc66@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMNsUmgC/x3NQQrCMBBA0auUWTuQVC3Bq4iEkM40g5iESRCl9
 O4Gl2/z/w6NVKjBbdpB6S1NSh6YTxPEFPJGKOswzGa+msU6jIniE5U6spYXBtGSgq+VPBfyG3V
 PuesX2bB1Z7dc7MowalWJ5fM/3R/H8QPUH/tUeQAAAA==
X-Change-ID: 20250618-check-ret-from-airoha_ppe_foe_get_entry-f0f1838641df
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
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Target net tree instead of net-next one.
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 9067d2fc7706ecf489bee9fc9b6425de18acb634..0e217acfc5ef748453b020e5713ace1910abc4a8 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -809,8 +809,10 @@ airoha_ppe_foe_flow_l2_entry_update(struct airoha_ppe *ppe,
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
base-commit: 0aff00432cc755ad7713f8a2f305395d443cdd4c
change-id: 20250618-check-ret-from-airoha_ppe_foe_get_entry-f0f1838641df

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


