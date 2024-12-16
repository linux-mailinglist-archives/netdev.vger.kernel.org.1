Return-Path: <netdev+bounces-152071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900919F2946
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 05:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB866164D5C
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 04:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB7F15359A;
	Mon, 16 Dec 2024 04:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="BNo3Q0BS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F11CA81
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 04:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734322974; cv=none; b=C/EyvjaNws57c9shgOXqyihIbIOSnWFYwMUMwy+vPss5VtlFqWgxt6G82TA872BF0t7yQ9Pj91vbC+Mvo/PH1PYjvmUDNyh/ehwlRmrzudrQzo7p68IwkV9f5mUSi8fnLGZVX3EI02PQMRBXx6ASryS/+eBS2F/IiQUuvUP4HeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734322974; c=relaxed/simple;
	bh=0G755B+9nbPlNiqISFKJRxs+J5U37t3pY3B8E/6OQK8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cpe2Q6FYO2EhHJ3VTfP3rRUPUcJhadgz4SJHp+9tOiOS4KKdZ/D9hpKmY0l9bhCuZuk+EORdU3R86KIteohZhNuLn/3QraudqQ4hwhqconCp1l7uTn6/rPcHfKx+C1Zs8Drk3ryRzcyywZax1f6siviP8mTkNwXYgr++LK9fkUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=BNo3Q0BS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21654fdd5daso28708335ad.1
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 20:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734322972; x=1734927772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VjSK92MDXF+rKpGlwdB1LcILhlvdYC/fEMykK6hyTB4=;
        b=BNo3Q0BSa/8AXS5HFsDmvvh8I5C2CcZRIFKnJcv6ShvwuYgHQ8D/cj8tOwpLGFzXSy
         +6uZgPKMR7nsa+8s/jxSrW7YySCMyzeqc1QsExR8AWiqiBsdt5411fnfMDCgNaLtzlPm
         /ex6u4Somi3xc+3r9w2jdOR78rZBB/wQKTEEoIzOCSlUHF3WChniVRD5NMnNF51y3hqS
         Sy+q0reVF5ZHr+TyE1Gkjk7pOSGj7D/sTXglJB+3OgG5ZGzwdvUraXUMhq7Y449Ae2rl
         dlcpgKLRm/awT0We/xYPeUXW/NgxLYFGLZLGx2fpstGnZjuc+2eD8yAsTlQvQ2v+NNed
         gZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734322972; x=1734927772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjSK92MDXF+rKpGlwdB1LcILhlvdYC/fEMykK6hyTB4=;
        b=JNNdvbAGHUhbBo1T9eiD6GGoALyQbsvl2qsOvk6t7/mOEnAaNLmuiENF3j9JfrtM5C
         pGGGH9+88vMzqYtIDn2jQ9Xgq8fcwfBSL/trycODa2nzoO9jIyHlOp2zMZ801yJlIgnt
         +hhTZAnS70idTyR+qlNfhduY8U4bXHsTIpP6TZ0mQD3XH1pE+gqwdd5ZW/SiwxvTFFdr
         FWcO58nKXpRZVJpdNakgYBNHraMaQW5MXT9rTLNYAHY6/xPDqcJ7FKMkkmRVOZ4Jh+b6
         ELz9QyZ2PEyywdzt3HWmj40DP36PZbhJoHETvOixz/6eKn7nmv9PnL5BzQ2dEyCQkOM2
         W+gQ==
X-Gm-Message-State: AOJu0YwcI0vDVsnPQCdiCwccJs1aDp0+n2+tJEp6jryIs528NJ0SUykz
	COHnuX7Ab+88OgX4mrHRhxXa+Ku5mjSnHqrnULkUO93oTjn81BADvLoS4krZ6lQ=
X-Gm-Gg: ASbGncu64Frd9nza64P2C0DRu4nx82LwuB9BpPm8MdFPbnuNp5MSHCWb1p4LsN0RIcz
	dJjg275nsG8O25+Y16nkhUWXYRBf+/Ne0ISnn0FPPl2WxoTiYYPj4sd0j9WmJLpljN8EuU9+7WA
	yQUvN1eI5eH5QTryntVLCK3K+DWuxb+zVuPpSh92h2HLVA1TmFxGslJs7gY/a+vJfgGE0HAxqS7
	DIIIlVh1499hR+2RQRFeoI6u/iBPRcBrmWvJGTzDxfnJfiurdkLQEsBd+/UUOqfpUQ8Gnc+zhvk
	3BaT
X-Google-Smtp-Source: AGHT+IFGe2nwWMdmPam/MvFiPdEktshKDUrw4k70L9OBDu3gYx83b7qi/p/OoILFEV1WEoLm7zOq+Q==
X-Received: by 2002:a17:902:db10:b0:216:3436:b85a with SMTP id d9443c01a7336-21892a78ec3mr156229125ad.52.1734322972372;
        Sun, 15 Dec 2024 20:22:52 -0800 (PST)
Received: from localhost.localdomain ([2001:f70:39c0:3a00:11b4:f79d:62a5:8fff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcc47bsm33956985ad.63.2024.12.15.20.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 20:22:51 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: sebastian.hesselbarth@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH v2] net: mv643xx_eth: fix an OF node reference leak
Date: Mon, 16 Dec 2024 13:22:47 +0900
Message-Id: <20241216042247.492287-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation of mv643xx_eth_shared_of_add_port() calls
of_parse_phandle(), but does not release the refcount on error. Call
of_node_put() in the error path and in mv643xx_eth_shared_of_remove().

This bug was found by an experimental static analysis tool that I am
developing.

Fixes: 76723bca2802 ("net: mv643xx_eth: add DT parsing support")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
Changes in v2:
- Insert a null check before accessing the platform data.
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index a06048719e84..917ff7bd43d4 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2705,8 +2705,12 @@ static struct platform_device *port_platdev[3];
 static void mv643xx_eth_shared_of_remove(void)
 {
 	int n;
+	struct mv643xx_eth_platform_data *pd;
 
 	for (n = 0; n < 3; n++) {
+		pd = dev_get_platdata(&port_platdev[n]->dev);
+		if (pd)
+			of_node_put(pd->phy_node);
 		platform_device_del(port_platdev[n]);
 		port_platdev[n] = NULL;
 	}
@@ -2769,8 +2773,10 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 	}
 
 	ppdev = platform_device_alloc(MV643XX_ETH_NAME, dev_num);
-	if (!ppdev)
-		return -ENOMEM;
+	if (!ppdev) {
+		ret = -ENOMEM;
+		goto put_err;
+	}
 	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 	ppdev->dev.of_node = pnp;
 
@@ -2792,6 +2798,8 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 
 port_err:
 	platform_device_put(ppdev);
+put_err:
+	of_node_put(ppd.phy_node);
 	return ret;
 }
 
-- 
2.34.1


