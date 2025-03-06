Return-Path: <netdev+bounces-172515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC936A55162
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 17:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C50467A6437
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 16:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDAB211A19;
	Thu,  6 Mar 2025 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZ+89fUp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F537212FB1;
	Thu,  6 Mar 2025 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278695; cv=none; b=H36U9u7yeseCs9S+pU6uBZisDSLZ6zcUnwAE/rcZ2lZiKONeHa3KdCtacIcdkxdifCEAiy/Ba10Imcl1EZcKd+yWm9sfhnoAQQuYDqEjXb1Yju1MUV3dA284CVW7kobnS2C/GPwXDT+0YI/Xd0CRMn5hzj0T5N7JilH8JxsVos0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278695; c=relaxed/simple;
	bh=7r/gG0w6gC88jCss1RAAZtEOdDZ1c0D4zEBTrfEV5tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ch5z9ghw66+pXa2FT97drVTioLe6c3kzFzWnWKXx/5+v/qIZoi6IE+5AST6WpVGYuqrdEGb9KLxoDP0+uNHZE5BUbELgHhBdUJF/FYKESaTiKqdX2UvBY4luJ8RCqVL7MOHUwOAp1VBeBCitt0VgaDy9blmul/oOKfVLTKGZA/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZ+89fUp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2239f8646f6so17114365ad.2;
        Thu, 06 Mar 2025 08:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278692; x=1741883492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JscHytd1XdAuAda6A13Y2muZ+vbs3gk0u1qcG0vie3Y=;
        b=XZ+89fUpZlPF9fn6/72qhYmifD/n2RO9n8ZAe22nZ1UDHVOTybdE5kOJqtsazsczuA
         qkVRfYhsRVO732HHGSmz+N3T5hUKmXP7acIALJDcoeReAIxMTpHz94RvhlS9G4WnyF9F
         goqb10VFQXcvCmnLBlhR/EFA/BeWfXAnxWVGtZzEbEr/e1jI1MgdC9myBviCPjUY/Djf
         f5bN9VwgsPSGP9FKfbAMHbV56ZXgyQqPw+Vwnat2w5TJCGLyz1X/7bTCaBIR8H+pZBXw
         R2DmsTS8CU/f9C4aL+NpB+okqx8iQVeSMHMfKB9ehGlct+J7yErcVLCOkx8TpNY3aTgw
         NONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278692; x=1741883492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JscHytd1XdAuAda6A13Y2muZ+vbs3gk0u1qcG0vie3Y=;
        b=iyKWR9WIRNdnxLfXV7ixVByE9dJqFc5KGAsMhD3k0azhoWLMyi/mhBt3fujyzClF0/
         2ib5N61gsWneHlnyUiafuPtZkCU4ZX8oJ1n9aU62JhirrDSNyXu1Ua5Jd07jwCahYeD2
         8+OdUw7Jp+vFs7CSfwPK5cJlRMUypBXIsOQwY9S67/XSF18kxXoA3ns+75r9lxT5etOg
         vmOsZfJcrgKpbtz3aeRzmVTUDsBvywunv0DjVR2LXLTwoelNIIDgRhqROXg9/8WDdrRT
         8mflvMEmZos1xgsqMf1x8JO3OgjmTBZTDMTHSYQ4YVklgcNwdFseEFWFJVqTx5uJwIG2
         vTAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGfKX+vOGXvmwwwUBWeX8UoejIUoYFrW+V6NScB0AqG9/gEK+poiNsuRr9ANRA0zJ/589k/SRYi3soC3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuyiRmBI/xJP7qyjob0Iu0NHHIoGEvvZvCEBQ/0t/JzM8WbQRx
	SlySTi5gMBzT9GlVxpx+K5sAi07HtLL6Jhk+U2A5vdwNgmAL5u/o
X-Gm-Gg: ASbGnctDWkix4JYZnnRQQDXhdmENZ1AvcLAXADz7fuMzG7raI4BfxaGIPxKFDwxVApP
	FMZvbeLW2RbxtgQPj7wAhGAZg81pFQqD4Kwg3AVdgA6bBPVv8Y3tHfIo+EZg6oGGWW82gqe4+JC
	e39eCJT+Tdg9ingTdbu00lAPrMissHaK1Ov0dKPGEzBc39gG8EHmgUr88gz2fgXlPuO1PrTMeHo
	3G40B0zqLLgKPOnKii8oNzwFMNMyDXsmR8DFB6oBpQycYK2wcnmMKiJBaexvUli71c0OIMo08U3
	cuUMUJ3CDv9EhJX556we75AVThinLxfVwAZsM3z516S7B1SHDw==
X-Google-Smtp-Source: AGHT+IG/0qfk0yHKEY6BSVW7k7f4Bq4WBIetBHDu1DlEHvvjZ4PaMbKW0xUz50mWUUMt3We/tKQA3w==
X-Received: by 2002:a05:6a00:a456:b0:736:9f20:a176 with SMTP id d2e1a72fcca58-7369f20a4c8mr2092565b3a.8.1741278692398;
        Thu, 06 Mar 2025 08:31:32 -0800 (PST)
Received: from eleanor-wkdl.. ([140.116.96.205])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af2812887b3sm1261808a12.71.2025.03.06.08.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:31:31 -0800 (PST)
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: shshaikh@marvell.com,
	manishc@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [PATCH net-next] qlcnic: Optimize performance by replacing rw_lock with spinlock
Date: Fri,  7 Mar 2025 00:31:24 +0800
Message-ID: <20250306163124.127473-1-eleanor15x@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'crb_lock', an rwlock, is only used by writers, making it functionally
equivalent to a spinlock.

According to Documentation/locking/spinlocks.rst:

"Reader-writer locks require more atomic memory operations than simple
spinlocks. Unless the reader critical section is long, you are better
off just using spinlocks."

Since read_lock() is never called, switching to a spinlock reduces
overhead and improves efficiency.

Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h      | 2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c   | 8 ++++----
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h b/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h
index 3d0b5cd978cb..b8c8bc572042 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h
@@ -470,7 +470,7 @@ struct qlcnic_hardware_context {
 
 	unsigned long pci_len0;
 
-	rwlock_t crb_lock;
+	spinlock_t crb_lock;
 	struct mutex mem_lock;
 
 	u8 revision_id;
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
index ae4ee0326ee1..7b9bd0938229 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
@@ -1185,13 +1185,13 @@ int qlcnic_82xx_hw_write_wx_2M(struct qlcnic_adapter *adapter, ulong off,
 
 	if (rv > 0) {
 		/* indirect access */
-		write_lock_irqsave(&adapter->ahw->crb_lock, flags);
+		spin_lock_irqsave(&adapter->ahw->crb_lock, flags);
 		crb_win_lock(adapter);
 		rv = qlcnic_pci_set_crbwindow_2M(adapter, off);
 		if (!rv)
 			writel(data, addr);
 		crb_win_unlock(adapter);
-		write_unlock_irqrestore(&adapter->ahw->crb_lock, flags);
+		spin_unlock_irqrestore(&adapter->ahw->crb_lock, flags);
 		return rv;
 	}
 
@@ -1216,12 +1216,12 @@ int qlcnic_82xx_hw_read_wx_2M(struct qlcnic_adapter *adapter, ulong off,
 
 	if (rv > 0) {
 		/* indirect access */
-		write_lock_irqsave(&adapter->ahw->crb_lock, flags);
+		spin_lock_irqsave(&adapter->ahw->crb_lock, flags);
 		crb_win_lock(adapter);
 		if (!qlcnic_pci_set_crbwindow_2M(adapter, off))
 			data = readl(addr);
 		crb_win_unlock(adapter);
-		write_unlock_irqrestore(&adapter->ahw->crb_lock, flags);
+		spin_unlock_irqrestore(&adapter->ahw->crb_lock, flags);
 		return data;
 	}
 
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index eb69121df726..5389e441fdae 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -2508,7 +2508,7 @@ qlcnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	else if (qlcnic_mac_learn == DRV_MAC_LEARN)
 		adapter->drv_mac_learn = true;
 
-	rwlock_init(&adapter->ahw->crb_lock);
+	spin_lock_init(&adapter->ahw->crb_lock);
 	mutex_init(&adapter->ahw->mem_lock);
 
 	INIT_LIST_HEAD(&adapter->mac_list);
-- 
2.43.0


