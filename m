Return-Path: <netdev+bounces-171672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EFDA4E19F
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDC317D521
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E5F25DCE6;
	Tue,  4 Mar 2025 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPipgkLe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6CC279320
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099121; cv=none; b=fNsHm7v+xh6hPiVq4KNrOoeG91csaTaHGTHhXCqiSQWW2AN2B6KFdl3PUy+RS+zyVUEKe/FgNthDbSBeHHWgzwQgDQ3E2X3Q2xSlhkligsVsWX0T7ziYs2cHl+l0/hGKx9860bBmNqiMSweuAcyVYbKlRWzGWHs+mG8ppiwaNuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099121; c=relaxed/simple;
	bh=m0n3yZpfgV1Qn+CDKwbzKRlXeaAVOxF5fSD6p02HaQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iGJtLjQLZy9U3EtgoW8cQaQrwYCFhJXi2TDBqrXYD/zzAyLg1H2UeXPtK8o2mkKY7ryq6Y0AI7xfjH1pYuxUkxDJ5VfiHSeZmzK11ig8PvK5fYgxlve33dYQOuQO70VZwrEJMIrRwNuqXjgIE4ez7sTDw3QFhhjTaaAEE9n7by4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPipgkLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B475C4CEE7;
	Tue,  4 Mar 2025 14:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741099120;
	bh=m0n3yZpfgV1Qn+CDKwbzKRlXeaAVOxF5fSD6p02HaQA=;
	h=From:Date:Subject:To:Cc:From;
	b=rPipgkLeiHOlarXyaSCOlN+pp0Pp1AGr9REOywoytcL1h/BJJKgeeH7CCz/pRPUfK
	 4M5Qa/RXaLohAPA0GGYTGPGE6OhOd3sn/bSp70XErTWoSraNHZKTlvlsvS0OQ+v/D+
	 jmXYGrohZrLT4Jd1yQJfTIErwsnKU6HT5FscfaC7cpawMdnYSagAbfYI/56keFrB2m
	 Nc9HlxFwFfxAuV1v9+tX19G6D//dvj0BXZmJTfWpRrarueUXVZJITGwxTxqxBPPYYc
	 rat0SzhgDWi/9sXg+AX3wPEYCJ+YEVW3mn8d8agIDRWCuVAWr+3ajRPPd3x1f5Cvyt
	 C1PeazMeiZn8w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 04 Mar 2025 15:38:05 +0100
Subject: [PATCH net-next] net: airoha: Fix lan4 support in
 airoha_qdma_get_gdm_port()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-airoha-eth-fix-lan4-v1-1-832417da4bb5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEwQx2cC/x2MQQqAIBAAvxJ7bsFKE/pKdNhqzYWw0IhA+nvSc
 RhmMiSOwgmGKkPkW5IcoUBTV7B4ChujrIWhVa1RndJIEg9PyJdHJw/uFDQaZ2w/25UdE5TyjFz
 cfx2n9/0AdzgGx2UAAAA=
X-Change-ID: 20250304-airoha-eth-fix-lan4-5f576b7defea
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

EN7581 SoC supports lan{1,4} ports on MT7530 DSA switch. Fix lan4
reported value in airoha_qdma_get_gdm_port routine.

Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index ff837168845d6cacf97708b8b9462829162407bd..5355685a9731c01e74c5c11e7173078e08c6b044 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -594,7 +594,7 @@ static int airoha_qdma_get_gdm_port(struct airoha_eth *eth,
 
 	sport = FIELD_GET(QDMA_ETH_RXMSG_SPORT_MASK, msg1);
 	switch (sport) {
-	case 0x10 ... 0x13:
+	case 0x10 ... 0x14:
 		port = 0;
 		break;
 	case 0x2 ... 0x4:

---
base-commit: 188fa9b9e20a2579ed8f4088969158fb55059fa0
change-id: 20250304-airoha-eth-fix-lan4-5f576b7defea

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


