Return-Path: <netdev+bounces-178152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC79FA74FA5
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 18:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C41DF7A6CAA
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 17:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C631DDA34;
	Fri, 28 Mar 2025 17:42:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9744A1DD886;
	Fri, 28 Mar 2025 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743183741; cv=none; b=YOG5plB4ci1W6drIDVChl/ouEdGRuXQDHddLYJR8Lcb5of47LXrWOx7nEeK/MYgo/jV7/xsOY4ShMAs/mVUhWdWB3QhwxxeeLv0NOtWuwp6ilfXSLQLEYm1omUA56hHbf4QvXxelKXz77soK9iSRhAfhf5Azf/FozlRftn0KLIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743183741; c=relaxed/simple;
	bh=wDLl7q8yCK6sZ1U9VZxBoe7R7a8qDbk2d1jkp5HLTNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ue+eNWKMZ8PCbnVzm5x6qCvq0mWJ821uRPMeFSdtAL/K6340fuXxHo9c428rthZ0TEWcuUpFN17sJKEUTAIC7uKZv4bvOFq+c2repDrCOjJxyTQ/BVrQ6UN7dInwMcvEKkLuSjfgEBfmraOhJfS/9jeDg8Xj+RgaUPEdT/FTZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-227c7e57da2so42449365ad.0;
        Fri, 28 Mar 2025 10:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743183738; x=1743788538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKa6jgVmUArcbtiv2yhnL664CVqTmaJqm0HRm05eXh0=;
        b=jTP+UQGtscEPKynUKHb+jL6W7e+B0MwoQszn30bFGx9DocimlsFQKsOOY67JyYcK6r
         kFZnTy4rdz0ySmVNfGupgHukm7fTU9KvIw8TcHmdzGfIv72Jjwfj4f96INocskk0ZA9j
         X/+miP+pqzKAnTuDknf6PSkPRD4To0NJFT+KgjhrCBMQFT8/KfQOgjSM9pqGleJaYbd+
         TglCvA0iar1A8/Vqi7LufnxtHKAjcqK854z0UMtmFo7UGAmQctttDzTHDOE1/6i29N+7
         E5EQiIeN4ohYusmizxn04EMe0heYaYXvG1pLXtNGXdu1e9wfZZ4xAo6S9RQ5wi3Sx8J0
         eaag==
X-Forwarded-Encrypted: i=1; AJvYcCW5NWqocIijMW1sX2Vu47dhqVrFSAvoDxG6S2N/nSGQwu9VYqbAXklbkkangP+W/j1MwwscgmyeAScfk3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWVFGsGHXePvFgCkKKJGnxkqxYZIrsZxIZ1dP9bJNYgMW4DggJ
	472CtuCJK0lkbGVcyIIPdiD/VTwtxQ5FhXT0QNZR/W9nCi78ovuDTb7IEVbGLA==
X-Gm-Gg: ASbGnctBNXm52FOzFtgw+HNNmsCXFW79YOMjuticrmChsBmamykkPhx4eOjg14DARSt
	z70jI/EbtvyHKMCLQniLlF9GFJxETy2YWTle2lFTY0hFI2zM5QmwerlS8thCHxsooy2APX/S7J0
	AH0WvDbvlUVriW83JrrJKyc9epDO9E1/Y+EZaFpf1Ev62XZ4Uj8C4EHfYaGgoMzyg7v2q3YC1h+
	+jZg9ewHKe1xmRc/Bvi3s5nyLFvy2FrLBWsG2p3UsIV1QGf8DXTPe4MMGncuREHe7cwu7SLWS0f
	x2zZlxmSWG8LSskHgkOTsID6UP5JJ9f28Jurv+fj5BcHlDnommF0RZs=
X-Google-Smtp-Source: AGHT+IFx1HPfaS5J878pg8fSK4zOF5eNtRQCHmNDON2zvhMySyohRrCp734Wno7L/9vFEF3SB1lMww==
X-Received: by 2002:a17:903:1107:b0:223:88af:2c30 with SMTP id d9443c01a7336-2292f960b3cmr656895ad.16.1743183737902;
        Fri, 28 Mar 2025 10:42:17 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291f1cec3esm21096625ad.122.2025.03.28.10.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 10:42:17 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	sdf@fomichev.me,
	Taehee Yoo <ap420073@gmail.com>
Subject: [PATCH net] bnxt_en: bring back rtnl lock in bnxt_shutdown
Date: Fri, 28 Mar 2025 10:42:16 -0700
Message-ID: <20250328174216.3513079-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Taehee reports missing rtnl from bnxt_shutdown path:

inetdev_event (./include/linux/inetdevice.h:256 net/ipv4/devinet.c:1585)
notifier_call_chain (kernel/notifier.c:85)
__dev_close_many (net/core/dev.c:1732 (discriminator 3))
kernel/locking/mutex.c:713 kernel/locking/mutex.c:732)
dev_close_many (net/core/dev.c:1786)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)

Bring back the rtnl lock.

Link: https://lore.kernel.org/netdev/CAMArcTV4P8PFsc6O2tSgzRno050DzafgqkLA2b7t=Fv_SY=brw@mail.gmail.com/
Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
Reported-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 934ba9425857..1a70605fad38 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16698,6 +16698,7 @@ static void bnxt_shutdown(struct pci_dev *pdev)
 	if (!dev)
 		return;
 
+	rtnl_lock();
 	netdev_lock(dev);
 	bp = netdev_priv(dev);
 	if (!bp)
@@ -16717,6 +16718,7 @@ static void bnxt_shutdown(struct pci_dev *pdev)
 
 shutdown_exit:
 	netdev_unlock(dev);
+	rtnl_unlock();
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.48.1


