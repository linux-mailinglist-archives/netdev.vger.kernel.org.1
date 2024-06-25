Return-Path: <netdev+bounces-106399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B050916162
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCF85B23A33
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 08:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3323C149E0B;
	Tue, 25 Jun 2024 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="J0h5vpYR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF3C148832
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304420; cv=none; b=Nn/LU+l9xnZ3AaqXhp0yK1xCwhyal4KesI39jwM4FnUQy9JekF7EKboyaoQP+cjoeodCVBj7ds72w20EW8rsWcqmdWtuocH583fKSLgoHdVtmqVd2UD+4sxKAfLnxGUTKPzpX6GDnHC/3lyOlc9eJ1a5lyu6z8TL06u7ZkIt+bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304420; c=relaxed/simple;
	bh=6zLeUxGI/6eJmXDQirmzJApQvIPtWQsC1uEMVIgt2tU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ic1spMHILf7wiurJjFBg8r+I+gixoEwvSTHyoKM8qEbVJabXoBp3P7oNPAxpth8UhfZzuPwJe1KxzIn3bKCTHmvww6ysZQYN+8YyDPYvbAcbXLhyG5Y+BDumOHD7AHo5A7QAHE0FLligU1UcMG11r6YSjzbtD/B+shoJyTOR7ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=J0h5vpYR; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7067a2e9607so1877016b3a.3
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1719304418; x=1719909218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mm6ddIKDyA7yDOVacp77GbndxO6yjA2PPWGRWlNTN1Q=;
        b=J0h5vpYRiqosRaYwTeDSWa7DdrN8EDN7B+B+WXEl5ZdQNBBj2dXfguSQ64usrxddoF
         08W+b6rndt8CJIb4vwjNotO9W16+mwHfJkl1lo97bOxzzJ0hM1xdwy1xJHMkyEWEG1NS
         QgU3cwpMweam3XpfM82MDJQUAqrSjQOTKUAglSz7JWG8AgPV6+RukprNwU5/49tFndDr
         guVtEhi20WzM3JirI4GZxb1YHybwf7vCenGSqFZCj0ttpWQwRMXs7fEo6KfhWmukj1a8
         Ibl1oIqwIuXyCjQMwTxWMCx/n7XfoDJYf8Vls/OOlqnPvQX86oIdo0JEiLBsePsoOFuy
         Rhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304418; x=1719909218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mm6ddIKDyA7yDOVacp77GbndxO6yjA2PPWGRWlNTN1Q=;
        b=bL2V8jkaMiDUIzUd36uRbflgAeW1P4f33P1x1M5zmx5Z0c9sKOTjCQCMnFX5XHYRY5
         iqR6SgZzdtZuUiuQqPKAFETzqUG8kprYhv/tfAqF2aVoMvsdlsvmmsC83jLpS11p44c5
         jbhAWyLsUPwOnFRENKENUOEqDlp2MTANH3W7XaFL3VEb3AUAAYpqgQygFHwcKE9G5/dB
         fOUPM2y+UISSAew9EiYl8f9pRpCuWUpeYUDn31CJWqVPmwAIP8g/mAWGUHgp+328P+Fk
         5j2CladpUTgi/FrVEnoyF7FTfp6E2cOg8x+tMf1L6GoPRzHifYrZe6FghTKFcbJvOEqg
         wm5g==
X-Gm-Message-State: AOJu0YyaDnGesyCmHUHIxEIoronVAPY524DTXaN+jbyoXG4EHBh4KgGC
	Y7ykl4v5vRovZAJMRPIlXdQWYKIjRoOPPcYB7+U2IHxbj0t3p19+AeP/q/pAo+0=
X-Google-Smtp-Source: AGHT+IELm3Ttvtx5YR4G1Z8+z+DN1lPcg5UI0/UEjh9cx2tvPjDsjig+TPYlFTxJUKTZbgzOn8F1Kg==
X-Received: by 2002:a05:6a20:6720:b0:1b4:b4af:6045 with SMTP id adf61e73a8af0-1bcf4479e5cmr7378240637.18.1719304417403;
        Tue, 25 Jun 2024 01:33:37 -0700 (PDT)
Received: from echken.smartx.com (vps-bd302c4a.vps.ovh.ca. [15.235.142.94])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70662ee117asm6035587b3a.211.2024.06.25.01.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:33:37 -0700 (PDT)
From: echken <chengcheng.luo@smartx.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	echken <chengcheng.luo@smartx.com>
Subject: [PATCH 2/2] Add UDP fragmentation features to Geneve devices
Date: Tue, 25 Jun 2024 08:33:24 +0000
Message-Id: <20240625083324.776057-1-chengcheng.luo@smartx.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since Geneve devices do not support any offloading features for UDP
fragmentation, large UDP packets sent through Geneve devices to the
kernel protocol stack are preemptively fragmented in the TX direction of
the Geneve device. The more computationally intensive encapsulation and
routing processes occur after fragmentation, which leads to a
significant increase in performance overhead in this scenario. By adding
GSO_UDP and GSO_UDP_L4 to Geneve devices, we can ensure a significant
reduction in the number of packets that undergo the computationally
expensive Geneve encapsulation and routing processes in this scenario,
thereby improving throughput performance.

Signed-off-by: echken <chengcheng.luo@smartx.com>
---
 drivers/net/geneve.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 838e85ddec67..dc0f5846b415 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1198,10 +1198,14 @@ static void geneve_setup(struct net_device *dev)
 	dev->features    |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST;
 	dev->features    |= NETIF_F_RXCSUM;
 	dev->features    |= NETIF_F_GSO_SOFTWARE;
+	dev->features    |= NETIF_F_GSO_UDP;
+	dev->features    |= NETIF_F_GSO_UDP_L4;
 
 	dev->hw_features |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST;
 	dev->hw_features |= NETIF_F_RXCSUM;
 	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
+	dev->features    |= NETIF_F_GSO_UDP;
+	dev->features    |= NETIF_F_GSO_UDP_L4;
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	/* MTU range: 68 - (something less than 65535) */
-- 
2.34.1


