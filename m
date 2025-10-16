Return-Path: <netdev+bounces-229985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8DCBE2D3E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F3F48597A
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40816328607;
	Thu, 16 Oct 2025 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFiYwv7i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172D02BDC34;
	Thu, 16 Oct 2025 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610550; cv=none; b=eFw0+3Q4lYEHNdx52+3CvA4P3yQJE7UsAUHn+feA1ku7P+sBM99Zz2U5/OkFAWPGNwurS8sKbx3kg/9y1d57jxq+hd2vztlCNFgrvG1pWDYaeFCzTMSrpd/99p9xCMTV0UHWWhHCvZs+GEH6wyLLvR87u/91bZP3qFYmiM4rqN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610550; c=relaxed/simple;
	bh=y7mp34c4cvhNC7n/Cqbxu2EAzAT00JK69b6Y7WsgNfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LgXOhChxHF0o8ofmrAk+zlf/a4COP7DLOGvO9HWqT2tuNuWlNMIWSHc7yWkv206SxjtfD31uz3d3Jgsg6VYoUm+80BAuiiQxzcRPKeOsrjZCkU3syLO9qBQ2aas2M0A1k+nS4bojiOlvf/AcSagqH39n3OV5G3/obOw4HglAJn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFiYwv7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9014FC116B1;
	Thu, 16 Oct 2025 10:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760610549;
	bh=y7mp34c4cvhNC7n/Cqbxu2EAzAT00JK69b6Y7WsgNfk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EFiYwv7iOZAE3GZri8hIBXNMnJ3pGK1U9PABapZmIadfG0jA4E2y4ziQ8kiygrKVV
	 IwV2ib27UnEIXbrFLL/p/CE5RWJNakOqp4hsQSteZNFu0CYTt74/FZFSxRm09TTNy1
	 o1WOO9tpKOANTA2B8+pmOwjUT2hWru410zTlNX0SZbOMBiYr9NSUNm/HWfjUpZM2CP
	 QQqxpVsilFSMNW3cqkEwmrAa52ZSVMUk75LdNtaX6pRIzZvzftCxKUOEkZDmy3CYS/
	 RgzN39xqJsnPGBNnz7qrKraXUJpsDBLy22qC5QI5TrpzbrZxH0+sjJDbB6Rq0Dj3JT
	 xTVckbXxrlHdw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 16 Oct 2025 12:28:26 +0200
Subject: [PATCH net-next v2 12/13] net: airoha: ppe: Do not use magic
 numbers in airoha_ppe_foe_get_entry_locked()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-an7583-eth-support-v2-12-ea6e7e9acbdb@kernel.org>
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
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Explicit the size of entries pointed by hwe pointer in
airoha_ppe_foe_get_entry_locked routine

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


