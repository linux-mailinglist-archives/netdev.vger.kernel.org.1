Return-Path: <netdev+bounces-246033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3088CDD426
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 04:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8091630169A0
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 03:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F5C25A359;
	Thu, 25 Dec 2025 03:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZJz9eda"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DD1238C0F
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 03:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766634441; cv=none; b=EycYIlwmWmqr/aF3nq92qcMbfUtmpUN+5Rsl685SXjib7bvEOkQWOR+WUv3eb2uAGDEgfNAPaEKYKOt+V+wNvUB97HiuxNQEWZSe1g/co0PRVhMXvA4FBA31GQGErfh/CWuvu47GsrOEbbm0lBwB9YeaC6yDv6sYNsMxd5+ecnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766634441; c=relaxed/simple;
	bh=zdHcXv7gthuNoETqRDRcPpK1gbnRFnQ98u0O7g8q1PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mU+H0YwR6TcC3bSuIv8Uu+Nyp+mw/d8STtwUD73Ugi8vvSEKIRSIdXUoCzo+xYPVSWDYNyCN5eHJYpgFiBRUNnL7RdxtfmUVHqCKE1FTNyt641uR9VxaRZLc4+CMfM6hE3bUVbmiNMgO63sksYWIGHGx4UYeF5S4VkfQEISXdzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZJz9eda; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42e2d02a3c9so4028272f8f.3
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 19:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766634438; x=1767239238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HQeB5Svb9ckkH6BmtFvtVbZNlGDfQ9LAipz/Mvve9Ng=;
        b=kZJz9edawFkRKwviwG7TfCgS0SFLHXPFPjzRuF6W6thgerxF/2YCU6PxpeMRiv5vPM
         s0YY5QiNQDlLtMSDAvKRNGSFJ+/yKqiS4ahd5GW+TZBwaiC7EDOvIJRPrFzdin25AtQF
         shRNG69hRpZz4D5dxoppiXf5MdXVUb2u/0xJOplKikHdY+8XFDqlkXNgU2DvnUe609D1
         b02C4xKMB5f3hT5JrbQiMf3viWdENyUEFBRlE79MktW1B5NZHmRAKpBiOnukhhg5BgFe
         nz+jmaBFRolpfDI5yAxb5lbWoqcD6OCnVaVYetWy06WaKCmWF3mbss4ZeuuxoxCoXHe/
         koAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766634438; x=1767239238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQeB5Svb9ckkH6BmtFvtVbZNlGDfQ9LAipz/Mvve9Ng=;
        b=OPc5qNkLGujU802wo/OwdPD/LlPkdNC5QFtiJukTJo5GlduJ2ISjC9deWeokhd6+v1
         i5mSsTXu184eUvJW+GFw6sTudM6UQoJhd9ZNYmypU3/zK40KFxMv7OfQ1MaycE3QnSao
         3lrpWahJmGH3FORyh8yiHJyWL6IVuc6DXHRAnPkjyC32lQv6U0agvC/t6nkdgaiyTe3T
         jpp26WE18/079caKMJxpEK1X+mTeR8Qgrf/v1OyWuHUK7kSudVSu+EB6RfKhGmROsWN0
         J5OjYhB0secLXpEampnhtUnDFcmjmF8tNxLzTDAmD9n9tjno6+PlWXb255/UR7IJUHJZ
         0iWw==
X-Gm-Message-State: AOJu0YwnjI0V2/zzhquPI2pzcbed3VSS7ccL93AjM5GGukDNLG+DIxkN
	rsnhkqdD8EErp39jksYfjrP1d9GT0ZZAHgzPEYYgacuWJswBaRU8iAg3QOz6Q2WL
X-Gm-Gg: AY/fxX4yvJVmclMZHqCG4vtSKNRz/E7r0p0SInI7F5/9lCqCbHDg5Wyqf3f7EZc7aOF
	Nye8vLOGWCeMeyNMnEALlCbOg1a8jJsfb1/NZx9jD4GaTMp5blLz3FhOjHC+u+LF7ukFPDcyMxp
	cpl6bjNBqPrxZ6veY7Z1P/iav3cIxr8XmRBeofBRg4JhWgo92bRBdba1Pw9B8SsJ61OH0sGIQqZ
	QJFxo969tTgVztFOJFfrfFqENJ5CwUS0+/yGq78JeQXG93TCUgvvrIKsQLMJIH56f5JvRaJBwM9
	/fJeNXOfsynVr/eN3Jc+IaFBsarKJ+lxwVkBRb5SZUaMf58zz8xR0PQ+dWVxWBQectanv/qDrHq
	7TbsUmaAPY0IABw9JigV8fEXUGBvfP7C21gjt+YlFMrsb3HC+SM/Sig1ELgDca6qmUOFZyClGSf
	VoRWO1lT3C5+CFX+ll
X-Google-Smtp-Source: AGHT+IHXxJ3PNrv8tMkh/YpvZIeiLQuPs5WX2+gcKW6UX4KIXgk+ZKzP4CKg9wLB3mGwZ3G4vLN9dQ==
X-Received: by 2002:a05:6000:2889:b0:430:fb00:108f with SMTP id ffacd0b85a97d-4324e4c9eefmr21340980f8f.18.1766634438165;
        Wed, 24 Dec 2025 19:47:18 -0800 (PST)
Received: from Arch-Spectre.home ([92.19.101.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa0908sm37102865f8f.31.2025.12.24.19.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 19:47:17 -0800 (PST)
From: Yicong Hui <yiconghui@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Yicong Hui <yiconghui@gmail.com>
Subject: [PATCH net] net: Fix typo of "software" in driver comments
Date: Thu, 25 Dec 2025 03:43:53 +0000
Message-ID: <20251225034353.140374-1-yiconghui@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix misspelling of "software" as "softare" and "sotware" in code comments

Signed-off-by: Yicong Hui <yiconghui@gmail.com>
---
 drivers/net/ethernet/emulex/benet/be_hw.h | 2 +-
 drivers/net/ethernet/micrel/ks8842.c      | 2 +-
 drivers/net/xen-netback/hash.c            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_hw.h b/drivers/net/ethernet/emulex/benet/be_hw.h
index 3476194f0855..5b953800d94d 100644
--- a/drivers/net/ethernet/emulex/benet/be_hw.h
+++ b/drivers/net/ethernet/emulex/benet/be_hw.h
@@ -16,7 +16,7 @@
  * The software must write this register twice to post any command. First,
  * it writes the register with hi=1 and the upper bits of the physical address
  * for the MAILBOX structure. Software must poll the ready bit until this
- * is acknowledged. Then, sotware writes the register with hi=0 with the lower
+ * is acknowledged. Then, software writes the register with hi=0 with the lower
  * bits in the address. It must poll the ready bit until the command is
  * complete. Upon completion, the MAILBOX will contain a valid completion
  * queue entry.
diff --git a/drivers/net/ethernet/micrel/ks8842.c b/drivers/net/ethernet/micrel/ks8842.c
index 541c41a9077a..936658bc61c5 100644
--- a/drivers/net/ethernet/micrel/ks8842.c
+++ b/drivers/net/ethernet/micrel/ks8842.c
@@ -242,7 +242,7 @@ static void ks8842_reset(struct ks8842_adapter *adapter)
 		msleep(10);
 		iowrite16(0, adapter->hw_addr + REG_GRR);
 	} else {
-		/* The KS8842 goes haywire when doing softare reset
+		/* The KS8842 goes haywire when doing software reset
 		* a work around in the timberdale IP is implemented to
 		* do a hardware reset instead
 		ks8842_write16(adapter, 3, 1, REG_GRR);
diff --git a/drivers/net/xen-netback/hash.c b/drivers/net/xen-netback/hash.c
index 45ddce35f6d2..c6b2eba3511b 100644
--- a/drivers/net/xen-netback/hash.c
+++ b/drivers/net/xen-netback/hash.c
@@ -3,7 +3,7 @@
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License version 2
- * as published by the Free Softare Foundation; or, when distributed
+ * as published by the Free Software Foundation; or, when distributed
  * separately from the Linux kernel or incorporated into other
  * software packages, subject to the following license:
  *
-- 
2.52.0


