Return-Path: <netdev+bounces-165015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAA3A30148
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 03:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A5797A2E44
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 02:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362281B6CE9;
	Tue, 11 Feb 2025 02:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="Edf9dKnB"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039626BDB5;
	Tue, 11 Feb 2025 02:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739239333; cv=none; b=J108fu1rbIG8ufy1uIkwjLgS3ZXfB/0Rq+bQT5saEfs7a3Yp0V1iqa0lY1Xlbiujr0DbsG+I9P0gxEetuYt99YgpHreJUn3HYflXW4EJZnIbbWRYyyCGFNCKw0KkyKORhyAxqfbD+E8dmThlGQsiVxtJMaUFghdD4/4hJve0AHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739239333; c=relaxed/simple;
	bh=D3OGM4UhBN/WzDEUIA+L0a9jqUc5uoHq56NnZLNLkXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tTVPuMa3kpqKSoPHXY/sMUgr/OWbc5i467ZSDU6IHN8Fd6rcZSy/wwu8/7CixavpeV/7K3IT/vSGkqwbfDsG8bPASRIw2hD4dilExsbm8chFupta5iv5EQRGDwdQmyq8gGAwZCsIUlXkGK+ooV2Vj7XeBcyJDU2HkOfxFY10KVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=Edf9dKnB; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YsPp52LyNz9sWw;
	Tue, 11 Feb 2025 03:02:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1739239325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eF2KGHCmSxMH1iF70b3XEqji+dT9Ps/Q4stmh8K5rBY=;
	b=Edf9dKnB0qyuXYETn7uiD/W8cSjPVwAd4UCMIv5ilvQVztGrHgsvKJdk0Szf+e1e3JgufX
	9VvWwo+6qXh+wa0eIkV25rZ8P2UflB1jB8GuCRLmHyBKNTAcprS5YtR6oxUKpMQ6pPtEY2
	Hco13ZcuvdQGcsiuTto7C1vgm3S+Eex3y6Maf3o8ZLGyVHv3jWQxBddSRcsdScgaeLypuk
	KDnlzzic1DA4+1erDM7TKHJqa9a5PCnS7pkUWhbx0JqA7bpynOp2P3PUmYiRUlNxsj+8jB
	V1JSPq7NgcIUiO8xXEDl7pE0aSYeb1a8WyNO1MNf8fwgIFuawyWED1gItrppWg==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Mon, 10 Feb 2025 21:01:52 -0500
Subject: [PATCH] octeontx2-af: Fix uninitialized scalar variable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-otx2_common-v1-1-954570a3666d@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAI+vqmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0MD3fySCqP45Pzc3Pw8XRNTY0Njo8REg0QjEyWgjoKi1LTMCrBp0bG
 1tQA0wu2uXQAAAA==
X-Change-ID: 20250210-otx2_common-453132aa0a24
To: hariprasad <hkelam@marvell.com>
Cc: Sunil Goutham <sgoutham@marvell.com>, 
 Geetha sowjanya <gakula@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1666;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=D3OGM4UhBN/WzDEUIA+L0a9jqUc5uoHq56NnZLNLkXg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgprQTBEQUFvVzJEM0ZOM09UeCtZQnl5WmlBR
 2VxcjVpZ05MSnVib0J0dzdzM05WODEyMklBYkZxeDNEc205OGlyCjlvek5MVksvYkloMUJBQVdD
 Z0FkRmlFRS8yd2padUVwbUNDNS9VU0MyRDNGTjNPVHgrWUZBbWVxcjVnQUNna1EKMkQzRk4zT1R
 4K2FoekFEL1Y1aVg1VDJ6aTZVc2Q2ZkFPSWhSNWRwck0vTGQxSmpjcE9XdEdEUUpFQU1BL1J6TA
 owbEN5RVN3My9XM2xTbGIrV2J4N0Q0S211VlgxNHplTXY4ZTBKdjBQCj05NnZZCi0tLS0tRU5EI
 FBHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

The variable *max_mtu* is uninitialized in the function
otx2_get_max_mtu. It is only assigned in the if-statement, leaving the
possibility of returning an uninitialized value.

1500 is the industry standard networking mtu and therefore should be the
default. If the function detects that the hardware custom sets the mtu,
then it will use it instead.

Addresses-Coverity-ID: 1636407 ("Uninitialized scalar variable")
Fixes: ab58a416c93f ("octeontx2-pf: cn10k: Get max mtu supported from admin function")
Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 2b49bfec78692cf1f63c793ec49511607cda7c3e..6c1b03690a9c24c5232ff9f07befb1cc553490f7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1909,7 +1909,7 @@ u16 otx2_get_max_mtu(struct otx2_nic *pfvf)
 {
 	struct nix_hw_info *rsp;
 	struct msg_req *req;
-	u16 max_mtu;
+	u16 max_mtu = 1500;
 	int rc;
 
 	mutex_lock(&pfvf->mbox.lock);
@@ -1948,7 +1948,6 @@ u16 otx2_get_max_mtu(struct otx2_nic *pfvf)
 	if (rc) {
 		dev_warn(pfvf->dev,
 			 "Failed to get MTU from hardware setting default value(1500)\n");
-		max_mtu = 1500;
 	}
 	return max_mtu;
 }

---
base-commit: febbc555cf0fff895546ddb8ba2c9a523692fb55
change-id: 20250210-otx2_common-453132aa0a24

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


