Return-Path: <netdev+bounces-125687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F093C96E3D8
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B38D1F28CBA
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 20:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC25C1BA874;
	Thu,  5 Sep 2024 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LprD1eRV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7331E1B86C7;
	Thu,  5 Sep 2024 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567324; cv=none; b=Lfm4et+2mz0O+h7slYxysn1Lu0bJv4gU/5PjMCvgDGc1/QPFMSdHBFB88cvScqhRpMs6zYdz/RXaU2KBIm3KvhySg36GV6sejoKO1KUKMFtzPN9QLGb+miOx2xKhyeoIz14rc8XH+2cYCP1zJHCHmRL6z11taqd0ZKzM1frH+9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567324; c=relaxed/simple;
	bh=BAta9vyXkz+IOZ8AXfVnWSqgq48uBbXOCNT4m7rPOPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsjeSKLOQICKu54ETSAQoe8EX+J7q4xR7fQbx7gqjhkX3wmrmjF+UgWPo2QQytKfy09fO+H64+omrHgugWqzhcG1uWTxveAC9f0dVMpUWhHUbqtNc/DlvCXkMwm346DGuGYdNt9btb6P33tRlJ3hHI92/6FC7A4ciFZUIUEPcaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LprD1eRV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20551e2f1f8so12891815ad.2;
        Thu, 05 Sep 2024 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725567323; x=1726172123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2n5GCIp2Flr7vEEXoglsKwWcYTQQ4pdePaiSU8geOMM=;
        b=LprD1eRV/PXMw7iSXGvmPSmjAg8UrwctPLXRGCSW2IPdtPCsE9U6Z1sp1DLhl3+3hp
         wTZDJE4bQYjiX0UNR13DBdb297wLNklCuDTnsX3+Naii9dJurZW2awNCs8oDH+YFr9zK
         uI4AsTCxsjNv63ywReBjzzrjoP8GR3tDlATaTQvB+NvNY+hkZcSIt8PCrrTVeDAULVo0
         yf+pXhHWldGh2pcgPG4KZC1dn+rlUfhNomFPua77w0+W1UgiZyNGsKsCf9n1UZpGzTHh
         nYfyuk+fQU3aER2jbqHBlVi1w6XkLWOROZ9y2wGDXDu+e8/g2weUYdYEswNe1omoPS2C
         gRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725567323; x=1726172123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2n5GCIp2Flr7vEEXoglsKwWcYTQQ4pdePaiSU8geOMM=;
        b=BtddSMQHzYal5Y+hG4iAcNcQLPjkS3PloFglePkdGLC+EeRvTPrZAJYdDYX6R/MpoQ
         MXUmI10tTQJvb/yocT2iqZ0decpwKF9q8aCuFyVoqWYHNnoNWkw4COZXvxkaidpILoRm
         qEoqSjionU6hDu6yRGfVvNdWk+mEKtcR6N/7eOWLPnrEv1sZA3lBje8ijLX3def6AuDV
         X68xpatjopkfuCL8juec8LMRs9zaII7GpPeNL7KiLdCxe26VwcggeqEcOdu13o17c/CT
         /82/AiCfQwgncvzfquUUc6e8oMuWIjlRpuYVgGZuY4ERuHTMhH2RoS42fKtVRtMXsMfG
         jSCg==
X-Forwarded-Encrypted: i=1; AJvYcCU9V6MLb0AWNCTwCI7NWC8tvQfKmCVBWBrscj7VBU58TbRvUoCixsDe9YU4aDu3CUC7tCrSYfbLnRlZUU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1qWrqWFXtXGyEupO5XG7Vnjwl4E+DnfYpU52Lz9/67jqED3Q8
	fKRb6rdVhmhPR5NaI6E3iPKiQ/quldtUw+HdqZW8AVy1RfDHjeH4Uz1/qQY7
X-Google-Smtp-Source: AGHT+IFP/+30VZmnVRxs1vj7LcvedJ/2GNqUznoiDPu5hb1TcaumoCPT3NaVCE72C27BaO4OVrdmuA==
X-Received: by 2002:a17:902:f68b:b0:1fb:62e8:ae98 with SMTP id d9443c01a7336-206f04a10dbmr3320345ad.3.1725567322648;
        Thu, 05 Sep 2024 13:15:22 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea68565sm32327075ad.294.2024.09.05.13.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 13:15:22 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv3 net-next 9/9] net: ibm: emac: get rid of wol_irq
Date: Thu,  5 Sep 2024 13:15:06 -0700
Message-ID: <20240905201506.12679-10-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905201506.12679-1-rosenp@gmail.com>
References: <20240905201506.12679-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is completely unused.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index c643e99e77d9..249cb8e78a4b 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3029,9 +3029,8 @@ static int emac_probe(struct platform_device *ofdev)
 	if (err)
 		goto err_gone;
 
-	/* Get interrupts. EMAC irq is mandatory, WOL irq is optional */
+	/* Get interrupts. EMAC irq is mandatory */
 	dev->emac_irq = irq_of_parse_and_map(np, 0);
-	dev->wol_irq = irq_of_parse_and_map(np, 1);
 	if (!dev->emac_irq) {
 		printk(KERN_ERR "%pOF: Can't map main interrupt\n", np);
 		err = -ENODEV;
@@ -3186,9 +3185,6 @@ static int emac_probe(struct platform_device *ofdev)
 	mal_unregister_commac(dev->mal, &dev->commac);
  err_rel_deps:
 	emac_put_deps(dev);
- err_irq_unmap:
-	if (dev->wol_irq)
-		irq_dispose_mapping(dev->wol_irq);
  err_gone:
 	if (blist)
 		*blist = NULL;
@@ -3215,9 +3211,6 @@ static void emac_remove(struct platform_device *ofdev)
 
 	mal_unregister_commac(dev->mal, &dev->commac);
 	emac_put_deps(dev);
-
-	if (dev->wol_irq)
-		irq_dispose_mapping(dev->wol_irq);
 }
 
 /* XXX Features in here should be replaced by properties... */
-- 
2.46.0


