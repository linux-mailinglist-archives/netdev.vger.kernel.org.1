Return-Path: <netdev+bounces-152780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BC79F5C3F
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2441670B9
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 01:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897CF21364;
	Wed, 18 Dec 2024 01:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="f+Bslqfi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E9A17C91
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 01:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734485382; cv=none; b=kjbgQicu4z/ZU/s6GZfm/H4roCbtm03Zak+x5ep3apOvtHBi/tKsz/Rof3tlm/9ZzfMipGU7AKJzgIeOewpCisHefpETXXICIGVjpxTCUNWiNPwWFQ/2/AOG5PiZuha8cuxDuMM4ieu7hFt7mTCKHBFeqa6/US41KuZT0pNJVeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734485382; c=relaxed/simple;
	bh=huqvRfaKw6Ye1fwVpCcpxP0HZC6NizyCxIFYHAQBs7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aSseH/cic72RHeeiGX+eKmGL2XXMChoKLAD5EnniSYwv6zPKAeBXx8XfTYQS8XHrqbIbJb33Y51GotUtR2JCasGbP3RgexFfqsrj0uZ4i2dFNgaLu/k6qEIKuyUc2oEmLJE3u+JvJ6yrbKYxrYmUA4WBe8+V6mM/KvRyoHYpq8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=f+Bslqfi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-728d1a2f180so216649b3a.1
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 17:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734485380; x=1735090180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xCXENo2mxX7usyviwpaX1iTNG667dFcbBRqFTo8Ff6o=;
        b=f+Bslqfil3VXAwqm/omaSjCkmWOEkOhsbAPNrEmcmFdbmUlsrCNL9HtHlV8gXtAx2h
         2OUEdG/TwFhfR/GjTwAZefR3n7GEWUYoew89/WlH3BdsYtFX93Dqxri9YRDT0eyTEGEM
         7U26DkzjCIAd0iExOV7zd34glN042PwWyG9rfEsusa/p7RFs7nP/vW816RYmPMpcntxD
         boRpX73KsJFb66YwSkU55UOVQ2RFQsF1GJ2VQclkHrwdZHC4EZ1moDmqhac2vxSd141b
         mOO9yU0MB25vlKrgucphJTSdzTnadTFaVyfQyawCgU60vKpXPBVLGtMP3wCqpWd5WrvM
         KlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734485380; x=1735090180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCXENo2mxX7usyviwpaX1iTNG667dFcbBRqFTo8Ff6o=;
        b=ayZE2tPbs5IoN54WPE1SuhYmnOaq0yjUJLv4LvaLKDJ0F2skeetMX6HHTXqQoele4b
         ihIYpGG7D8mW3+ux/+NNxe8G+QxW25dosmnvB34TfNg32UH2Bs/7dILvWR5zxZWCLJud
         HlHjw6SE170TTcFOZgrtMLqtG6xIakoCyW5dg320uFZWk444oNxE1piiG0E4LakhS+qu
         z0i8ih4JqkqlqKk7HctllUJbFkP4v1QNKsvZxYDIs6L4H9pidQ+E4KItO3yN55bX+uam
         YTD+Gn7EBPBl8gK6plZoKmjKwRYaZIgdSO2mspbPVaGOY2Na+U+m2x8d2YcL/hTsQLbs
         2PqA==
X-Gm-Message-State: AOJu0YxOSehxUETY3rwksZj42DQDaxbWwdCKfuDAaa7/VNH2WNnNOkus
	OzjQMNYgwvC47Fu09IiwCgneGBqwrElrytpQZXufU7/kDWXVYAc3qWSym5fQUzk=
X-Gm-Gg: ASbGnctQ6EuINYQB2PlGiTbEyraq3YZ8jGgCuBM4eQci4p4Tp3Id6KcPNaRh1xb6A7p
	IJbhdA7otT1M6NVAYjmA3dghxDApPQUkDFUlJSDmfXXofUxJfRkzNm2UQnwnV/JGILgIC2z1HEv
	W2RkIyfls6Vh3xBwaYLtx8uvyoyOMlQg1EllzWDua5OXFfmrfhlrxV6uP4bZYTTEFYqCKpDfGji
	Oe4tPZKqjd/xbj5uZi3329MocgnA2q7Sq6Zrvu+EpiTg2fPcNQXt6cU+/wa/CK9PnfcU/Fpf4YU
	pAHOao8Dkon2JRM5Oz8+8GkkqKFTvotuPhKbDKpIvZc=
X-Google-Smtp-Source: AGHT+IGtySnGKC7akPY4F7FxzSmGqcA5r1mZo7n0F8n0SuIsKHGlm5n9Rmq6txUmzJ6zK/hhUl6u1A==
X-Received: by 2002:a05:6a00:6990:b0:725:ebc2:c321 with SMTP id d2e1a72fcca58-72a78729ef4mr8143289b3a.4.1734485379658;
        Tue, 17 Dec 2024 17:29:39 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad5eaasm7288551b3a.51.2024.12.17.17.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 17:29:39 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: sebastian.hesselbarth@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dan.carpenter@linaro.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH v2] net: mv643xx_eth: fix an OF node reference leak
Date: Wed, 18 Dec 2024 10:28:49 +0900
Message-Id: <20241218012849.3214468-1-joe@pf.is.s.u-tokyo.ac.jp>
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

This bug was found by an experimental verification tool that I am
developing.

Fixes: 76723bca2802 ("net: mv643xx_eth: add DT parsing support")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
Changes in v3:
- Insert a NULL check for port_platdev[n].
Changes in v2:
- Insert a NULL check before accessing the platform data.
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index a06048719e84..0e2ebfcaad1c 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2705,8 +2705,14 @@ static struct platform_device *port_platdev[3];
 static void mv643xx_eth_shared_of_remove(void)
 {
 	int n;
+	struct mv643xx_eth_platform_data *pd;
 
 	for (n = 0; n < 3; n++) {
+		if (!port_platdev[n])
+			continue;
+		pd = dev_get_platdata(&port_platdev[n]->dev);
+		if (pd)
+			of_node_put(pd->phy_node);
 		platform_device_del(port_platdev[n]);
 		port_platdev[n] = NULL;
 	}
@@ -2769,8 +2775,10 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
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
 
@@ -2792,6 +2800,8 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 
 port_err:
 	platform_device_put(ppdev);
+put_err:
+	of_node_put(ppd.phy_node);
 	return ret;
 }
 
-- 
2.34.1


