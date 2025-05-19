Return-Path: <netdev+bounces-191664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ABCABCA4A
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDCE83A504D
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D070C221F33;
	Mon, 19 May 2025 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUWITi1p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375F7221F1C;
	Mon, 19 May 2025 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690932; cv=none; b=S2Rgo5Pqzt/z3gBI+ghJACvH2O2XCesOBL45S/SUYu9ZiGSfh9JZxdYCVejJojmIZAmbXzxlyKbMo4XjJHWBvaYfWeQyBX9dLoBnUPPWIlEnXGUE5y3lBy3k9kbZn6B8uuqS6Ztv/3JBd4YVAFV1SyEeMBkEKX8k8RavIBmrJqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690932; c=relaxed/simple;
	bh=JJn1G/j91f61FBbpVWMImfHtWIFluem4iH8Pp25ZfAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gQ0sI7aqgXKzNpAoXcDb56jwynQ1I/JHM5BokIamLvDQfXH5XcHEc0klEJM8j9oUlO6lqHmnipXVjXJ94pOAIwWZCRQq8ivp02q2IgClnJcsecVvbCPBROFqVgFLIk+Kp7BWyBKfz4RvoJYKJeYJ7cKtxH2nVXV3I7KbuHqYAcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUWITi1p; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso6314234b3a.2;
        Mon, 19 May 2025 14:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747690930; x=1748295730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bGI/w48fIiA0eeXLnGtGjWEjUDoal1CE/ntvGdj0dd8=;
        b=lUWITi1p0uefDEy27pM06sQ4GSSxC2YUk4aGjEyRhAYyrw1kZ254u7MjTANxWR4P45
         D5nWHigzd6LeF8WBwd7UQ0Cx+l1fMOURe9RMZuf7bA7VmaRWlP0dM8LcYeByaSBvJA+h
         sLCV18UPeHaSy+5QpIPE8iHufvEZ4xoHrFTh5kFRZHwKz3G4DgCCo0lgP+H17Uzl3Y8A
         9yetX1AMfsGHpROfLKJcFHrB7kuGXaUxYoZo4Pu4wh4nC4w/QiC85pPVKIc9eSq+rcH5
         87J7arTTVALeuClRebdjsAlc/NXlBHtgBkmSl2TYUe+yyFnEKeyIP7HVNlbVXM2JNYw4
         3dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747690930; x=1748295730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGI/w48fIiA0eeXLnGtGjWEjUDoal1CE/ntvGdj0dd8=;
        b=KkNiUvVqjvWWGBWWKRNw3Jc0sIgMjGZ9vAYt2PUluW3hkYqWzyIP/5QkVADw/e/7Yj
         6i4hqn/F6s3rX7CBku1qSkOEYJN7y120OCGaj3dPm979xrWHFpdBjTbP/AOm98hQbRM/
         HXEB04yK3hLTx+eOR1mQ0PpLX0pr2aA1erxEut6dVbJ4OFbny99w2zbeSB3t/MYM/+7V
         hFIqvPCeBBEUK+xvqSGXgITfiDLxsFewMNm4uPc8zFUQMz5OmwK2t7+xBAyoI7X2/K7z
         M/PTVPhmI5nUvHVaNlEPzL88tC9ASsfmi6zjVDHHLyTKbgeUsYKwW8JgcKD71gRIQq5S
         AeuA==
X-Forwarded-Encrypted: i=1; AJvYcCVgBNRlCNYYhf/5SVQBYUdORyfBZvZEXCWsTnudC4cBm2wAFUITH5iJY1pCYLLygpEDtxqxILMW@vger.kernel.org, AJvYcCXILN1FEkm1ZEySbijIh9L+S7EkIB2JOrSH8J/c1Pqf5prZXtx9EbnVrIioJIjfbNJCqmiAhDLi41U1yqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBErsaaTnqopHwLZec1mdCqsWO+WLz7Ntt+GA6RP9GI4Mj9153
	FkKIOmtiDDzFjtDil4THCzuQHXKEBcwXMWF0VZ6QCyCAw0D5cQnIwmqZ
X-Gm-Gg: ASbGncszMWAJ/d7a1vJ2RGef0z/rHnCjXzrqwLNYUxM6qRXLfjV8fcpeY+5CSRzWrC0
	W0/EltXHiWbDLd1CmVOSFbjiC6TQcCCmJkYDnxtwPnafgD+jNlsf8GACWR3quTi8XWYfbPLGKhC
	vvbCBn6226HyYnaJbEnFaiQ0+8Ab4lMxbvYXAuw8N5Bl+Ru3qU5FOZjLhxfpOO7N0Tfgb+OPQ1y
	ziCBGECwvxhonDT0DJpkaNtce9dxsCSDWSjjyKJBZt/7fNvLPdNDL/mwYRzbQWf/IO9jDjb3iI7
	2Z5fuxqkEpIcM+YP6zUucE0GxnWrJgUDN9otO170amRoCPjuAHic6A==
X-Google-Smtp-Source: AGHT+IFBKOgUUFYbx5HEkm5y610RN4G6qp5hlW9ZWIayFQyg20n9R7JbChB2PEzDQ1MkbCRG1BJj9A==
X-Received: by 2002:a05:6a21:3a89:b0:1f5:8a1d:3904 with SMTP id adf61e73a8af0-216fbfe1f94mr20912540637.7.1747690930196;
        Mon, 19 May 2025 14:42:10 -0700 (PDT)
Received: from mythos-cloud.. ([125.138.201.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a0ca7sm6664909b3a.158.2025.05.19.14.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 14:42:09 -0700 (PDT)
From: Moon Yeounsu <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Moon Yeounsu <yyyynoom@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dlink: add Kconfig option for RMON registers
Date: Tue, 20 May 2025 06:40:45 +0900
Message-ID: <20250519214046.47856-2-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a Kconfig option to enable MMIO for RMON registers.

To read RMON registers, the code `dw32(RmonStatMask, 0x0007ffff);`
must also be skipped, so this patch adds a preprocessor directive to
that line as well.

On the `D-Link DGE-550T Rev-A3`, RMON statistics registers can be read
correctly and statistic data can be collected. However, the behavior on
other hardware is uncertain, and there may be undiscovered issues even
on this device. Thus, the default setting is `no`, allowing users to
enable it manually if necessary.

Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
---
 drivers/net/ethernet/dlink/Kconfig | 18 ++++++++++++++++++
 drivers/net/ethernet/dlink/dl2k.c  |  2 ++
 drivers/net/ethernet/dlink/dl2k.h  |  4 ++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/dlink/Kconfig b/drivers/net/ethernet/dlink/Kconfig
index e9e13654812c..40c8c861c5a9 100644
--- a/drivers/net/ethernet/dlink/Kconfig
+++ b/drivers/net/ethernet/dlink/Kconfig
@@ -32,4 +32,22 @@ config DL2K
 	  To compile this driver as a module, choose M here: the
 	  module will be called dl2k.
 
+if DL2K
+
+config DL2K_MMIO
+	bool "RMON MMIO"
+	depends on DL2K
+	default n
+	help
+	  Enable memory-mapped I/O for RMON registers.
+
+	  Since this feature may have potential issues,
+	  it should default to 'no'.
+
+	  If unsure, say N.
+
+endif # DL2K
+
 endif # NET_VENDOR_DLINK
+
+
diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 232e839a9d07..197142aa63ff 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -576,7 +576,9 @@ static void rio_hw_init(struct net_device *dev)
 	dw8(TxDMAPollPeriod, 0xff);
 	dw8(RxDMABurstThresh, 0x30);
 	dw8(RxDMAUrgentThresh, 0x30);
+#ifndef MEM_MAPPING
 	dw32(RmonStatMask, 0x0007ffff);
+#endif
 	/* clear statistics */
 	clear_stats (dev);
 
diff --git a/drivers/net/ethernet/dlink/dl2k.h b/drivers/net/ethernet/dlink/dl2k.h
index 0e33e2eaae96..3a13068d89a2 100644
--- a/drivers/net/ethernet/dlink/dl2k.h
+++ b/drivers/net/ethernet/dlink/dl2k.h
@@ -38,6 +38,10 @@
 #define TX_TOTAL_SIZE	TX_RING_SIZE*sizeof(struct netdev_desc)
 #define RX_TOTAL_SIZE	RX_RING_SIZE*sizeof(struct netdev_desc)
 
+#ifdef CONFIG_DL2K_MMIO
+#define MEM_MAPPING
+#endif
+
 /* Offsets to the device registers.
    Unlike software-only systems, device drivers interact with complex hardware.
    It's not useful to define symbolic names for every register bit in the
-- 
2.49.0


