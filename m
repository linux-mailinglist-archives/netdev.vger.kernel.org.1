Return-Path: <netdev+bounces-188894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B82AAF383
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 08:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C791BC710E
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 06:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD90210F59;
	Thu,  8 May 2025 06:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6VI+Gcy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A48815B102;
	Thu,  8 May 2025 06:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746684891; cv=none; b=dLYmGuGEifwtx3N7ZDQvYaj2YTrj718Ge+KycLBg8FaNkPvJCAdVgIDZKHManv52symZYktM6u5zvm3FwxLjdUXfEmjNGxC56TKEC7f5kYdiL2nQnYscPuSSUIAyi9QX1bIYJWo9ORbbM2f6X/wxXJj+2nvMXc4JwVJUUWZ0NiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746684891; c=relaxed/simple;
	bh=MFvOzXbBqb2FrF9xJ99n1Vvnhtq7kc+wQtyVehe0cZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dDxmTlW4xXOCppeRXdEzqE8Lq1lmJIQkYfQiYeczqTWsUYXx6cyHMJAuRCkIaziozdTwwBYn83aNdE8zLCu18vH43+VR+t1QUrwX4FinVJEHwLGNHl1aYpZWrRHQnrS6DwC7oJIsuBthjIfbtYaLxY/NjGZfg4KD7i6bN2HgGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6VI+Gcy; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-740b3a18e26so155247b3a.2;
        Wed, 07 May 2025 23:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746684889; x=1747289689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VotcU77DWw4Y1PxH+nM5ixe9fRq+X5xufuqprZuD5/w=;
        b=J6VI+GcyCRg8gFK6XVov7p9bACq97KB8ldIqAh+T3n/HvZMiYKEDCyCQS9BlVnHLvt
         Nwt4hSV1D8HC6vZDBgInglmQSlSNDSe2kpNdz4tn+j6sNAsabWGHDSqTmvIj39uQ2YCc
         uZIuubBWvkobsTlPldXFvkl5aqNPUaOxeDi9ogL49WH9USzqURMyX37v9mxfEB7HACHJ
         e/wcVfutjUdD1NjoXr1Q9Wh+fiNxCBkNi+qRdpybEAun7XzVSHT9s4msV6W8mBI9Baij
         He0M3YXwk7isUBUUtCshDacyLaPj6eyg2tMv+eY9YQfaS5p0bFre8PVqvJfaC/Jb1wGF
         nXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746684889; x=1747289689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VotcU77DWw4Y1PxH+nM5ixe9fRq+X5xufuqprZuD5/w=;
        b=Hhg37VD47R50lNCiFjxN5PZMi1knH9R3hDA41ZkiAD5ooYxmIiK3TUpyDOlIDGVEqM
         GzPqWpDZ3LiSzFmXsmyswiLnuhu4MrDhBhITVwXfmgzg+JI9aAs41pTfA5RhqpNgl/yU
         ARUPK3J+bd9yLcWZH26F8cPGxTS3rVdhcC2Jd41rOFc4tbuFN5r5nNJ+XJi2aq20h+hb
         TeJ4G3GcXToOYJhZe3kRK8vupmJn2V5TcKJ+brkyFs27yXztT0BHzzB03ERqKz/8CQzY
         i6/tK2n+K9eo4sb5LJF6qkfGx61t5rKGD8djIH7e8AyqoEx67pVBU8K6G2t/0R0Cogu+
         XfrA==
X-Forwarded-Encrypted: i=1; AJvYcCWpxxiGjECDWlTibFEIc3uca3RqYBtWpW1PymAzKtO+PfBePDNWqofwH7ljW2eQVu+2kzCQdBBfjByYTj0=@vger.kernel.org, AJvYcCXDXMSK8U2DaihQzc9RY3BkTiPY+H8eacUL591xUM/FkaHYab8GdJtMbXGNZ+92MZZNlnwqIs/l@vger.kernel.org
X-Gm-Message-State: AOJu0YwYp8VUGaoG/kDAQqmYYKVM5epzcNuZ2t3RiqjFG/4SdIrFbnyn
	i8FxbPC15HRoMK3KzR6tPbSqG69DRB/kJ4yJM8O3dIyAFHK5Qee5
X-Gm-Gg: ASbGncszCJojMFVeSTnuizJdU/QqZnQmTDFxUAOOWKf3HmjFsHsU489TJFZcyMBUsD7
	SOPDGIZTnPfqE7q93iNWvA/93wyEEr10vWX/793NBFpb/uBIbjXpTr4HQQsPNkmn8EY5a77N36Y
	8ivrSClIGhdcMa6O+xz8IU0iTUy2Ayu9PDbY9FYQwgbu4vRzffu7lG1JZ9U0iPwCfxjgYu+DwPV
	MWmvOcs2S8N19l+ajthcsDz+kT1ma0ukxSIu6CUT7A3RvdD4Kfm26z+P/G9shs5V1vNavrdnYVX
	yxg6rzKLE//bzOjGRz4akLEQxnObkSR9G5jcl5XEVX0mUD+rGH9pnntmmw==
X-Google-Smtp-Source: AGHT+IGcccthny4wgO9JLnTYbSSOdkpYbJbM2k0A2F+LqBuKt3G8cPMktOYUDmjfyDgWjOu6qpKiCA==
X-Received: by 2002:a05:6a20:7d9d:b0:1f5:81bc:c72e with SMTP id adf61e73a8af0-2159b04f390mr2858643637.33.1746684889489;
        Wed, 07 May 2025 23:14:49 -0700 (PDT)
Received: from ubuntu.. ([103.149.59.114])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740590a489asm12771438b3a.170.2025.05.07.23.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 23:14:48 -0700 (PDT)
From: Jagadeesh Yalapalli <jagadeesharm14@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jagadeesh <jagadeesh.yalapalli@einfochips.com>
Subject: [PATCH v1] e1000e: Replace schedule_work with delayed workqueue for watchdog.
Date: Thu,  8 May 2025 06:14:25 +0000
Message-ID: <20250508061439.8900-1-jagadeesharm14@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jagadeesh <jagadeesh.yalapalli@einfochips.com>

    Replace direct schedule_work() usage with queue_delayed_work() to allow
    better timing control for the watchdog task. This resolves potential
    race conditions during interface reset operations.

    - Added watchdog_wq workqueue_struct and watchdog_dq delayed_work
    - Updated e1000_watchdog() to use queue_delayed_work()
    - Removed obsolete TODO comment about delayed workqueue

    Tested in Qemu :
    / # for i in {1..1000}; do
    >     echo 1 > /sys/class/net/eth0/device/reset
    >     sleep 0.1
    > done
    [  726.357499] e1000e 0000:00:02.0: resetting
    [  726.390737] e1000e 0000:00:02.0: reset done

Signed-off-by: Jagadeesh <jagadeesh.yalapalli@einfochips.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h  | 2 ++
 drivers/net/ethernet/intel/e1000e/netdev.c | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index ba9c19e6994c..1e7b365c4f31 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -194,6 +194,8 @@ struct e1000_adapter {
 	struct timer_list blink_timer;
 
 	struct work_struct reset_task;
+	struct workqueue_struct *watchdog_wq;
+	struct delayed_work watchdog_dq;
 	struct work_struct watchdog_task;
 
 	const struct e1000_info *ei;
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 8ebcb6a7d608..87a915d09f4e 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5178,9 +5178,8 @@ static void e1000_watchdog(struct timer_list *t)
 	struct e1000_adapter *adapter = from_timer(adapter, t, watchdog_timer);
 
 	/* Do the rest outside of interrupt context */
-	schedule_work(&adapter->watchdog_task);
+	queue_delayed_work(adapter->watchdog_wq, &adapter->watchdog_dq, 0);
 
-	/* TODO: make this use queue_delayed_work() */
 }
 
 static void e1000_watchdog_task(struct work_struct *work)
-- 
2.43.0


