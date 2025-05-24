Return-Path: <netdev+bounces-193197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9D8AC2E28
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 09:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C80F1BC40B0
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 07:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9731D7E54;
	Sat, 24 May 2025 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="M2xlF3Eb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-78.smtpout.orange.fr [80.12.242.78])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8E1B6D01;
	Sat, 24 May 2025 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748072337; cv=none; b=SEYd+lj9FM02uDtL+yUfQKGZ6fn0jSC27S9RJj0GuAXx4XTQqlFlGpPunT2OFVzxdwt8r+NzyhMwl6tuazFPBdkctRlSjWZSjwi8O/pOSooEGEk7sp5Bp0gQGXpvqhkqe2JG6MBq+F4Ru+jgD30tvMMLmv9I/CJaVI1YVVhCzAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748072337; c=relaxed/simple;
	bh=dwddXXfTZ6aOFpQVEBms0LZLfj8vls/D4GgVFgaJB18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I9vb3uW7HR12kgzJvFeoNpA6tUv8RfTm919Yn1ahhkDYnvsXFVfOuF3jB+JFpFd5WRIHrlW8az6s/7NKvBm/EqjEBWJU1f+1f0i1dJbI8rwZaVs5eGsCVIIbWoLE0BbMSEnK1EC2JX6L0Yr3O6kv+O1GFQHdCpve7mVNVU6t2Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=M2xlF3Eb; arc=none smtp.client-ip=80.12.242.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id IjJtuiv3wVLIhIjJtu03o1; Sat, 24 May 2025 09:29:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1748071767;
	bh=Zu3Rr90y+tiM/8UlA4hAOXkaFy8wswdz0HsN6oicuAI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=M2xlF3EbgDjP+m9zcGtmTntP7L6mbLUqQBpHne6e435s2uUnBR3w6T2k2JWT344oO
	 3UTgq9e0u/oJUn8f66BhmWNQNlgxRR3dWpd60Wc4CdnMPn0QaWLJqUpfVXZxGY7xMR
	 1WJLsXo/t/EqcQCRgibLgjg2uBiBZT0QTPtGC9CTZdkyaCY7dmvSCEzH+2/Ih1lgLk
	 OvMv4awXIjtr2HV3iVfPQzCNoDSG/U6AZYIgxHx6Vhf1LNMw3ErvJO4eVDCL2AJjfS
	 N6A6K73uC2JJBQrC8B4QHNiE0Ihb+qWtyONpWDMmAz8aGkvy9UhY4JXTrXT1TncirF
	 PPvdEzTZAekVw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 24 May 2025 09:29:27 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 net] net: airoha: Fix an error handling path in airoha_alloc_gdm_port()
Date: Sat, 24 May 2025 09:29:11 +0200
Message-ID: <1b94b91345017429ed653e2f05d25620dc2823f9.1746715755.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If register_netdev() fails, the error handling path of the probe will not
free the memory allocated by the previous airoha_metadata_dst_alloc() call
because port->dev->reg_state will not be NETREG_REGISTERED.

So, an explicit airoha_metadata_dst_free() call is needed in this case to
avoid a memory leak.

Fixes: af3cf757d5c9 ("net: airoha: Move DSA tag in DMA descriptor")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changes in v4:
  - Add A-b and R-b tags
  - Rebase against latest -next (because v3 now gets "Hunk #1 succeeded
    at 2869 (offset -4 lines)")

Changes in v3:
  - None
v3: https://lore.kernel.org/all/5c94b9b345017f29ed653e2f05d25620d128c3f0.1746715755.git.christophe.jaillet@wanadoo.fr/

Changes in v2:
  - New patch
v2: https://lore.kernel.org/all/5c94b9b3850f7f29ed653e2205325620df28c3ff.1746715755.git.christophe.jaillet@wanadoo.fr/

Compile tested only.

In the previous iteration, this patch was part of a serie. But it
should be related to 'net', while the rest of the serie was for
'net-next'. So it is resent as a stand-alone patch, as a v4.

---
 drivers/net/ethernet/airoha/airoha_eth.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 16c7896f931f..af8c4015938c 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2869,7 +2869,15 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 	if (err)
 		return err;
 
-	return register_netdev(dev);
+	err = register_netdev(dev);
+	if (err)
+		goto free_metadata_dst;
+
+	return 0;
+
+free_metadata_dst:
+	airoha_metadata_dst_free(port);
+	return err;
 }
 
 static int airoha_probe(struct platform_device *pdev)
-- 
2.49.0


