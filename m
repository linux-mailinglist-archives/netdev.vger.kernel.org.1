Return-Path: <netdev+bounces-217300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F7EB38411
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C6B7AFC8C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 13:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A950335337D;
	Wed, 27 Aug 2025 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjmvlq7l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BCA2EACEF;
	Wed, 27 Aug 2025 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302639; cv=none; b=qutQnf7NTu9rpsjh7y953hQTdBwM4mH5HBOD6H4N9IPgzlbaUQK0MVaNHqqXoiOzq5qALQC6UNfWwc0obLZornUhWVBKuVrxjB7o0Sh4kLmAx4mYL9oFP1ua2kOAhpOySiIK3FlA0vKot6CsorT4RmdCHksE/r1uraAQcHC+yJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302639; c=relaxed/simple;
	bh=/CxF26f7IY0gzBYXUQvlyigPUysQMgswZzfFi3tBp14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QCoKYOuJ7kZXJn6Xfxl7ZzgLrgObdy/zzKmz5sLEsA3vtrzzpdwHofTNZgGQf7VbEU6/cpOSoKdCoYmAzbjn18id/Bhpda9nJw9Ultm2xk2NdFXo8IEkbahkhhVcpUljg32qhTmoMr017kUE6Hb2dTRkFJqYKmOPONYZ8+hvIpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjmvlq7l; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-324eb9cc40aso782897a91.0;
        Wed, 27 Aug 2025 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756302637; x=1756907437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zHvHAd+WcxCB4dlz78++SYO8j8Zl7cNSriJo6KrI3ho=;
        b=bjmvlq7lbaSl6YGgJ7a+1z7QLPq3SBaXSYW+0dsceaXOsXRmvybapuoOrTZqPwf/an
         d1tlqHvmuma/D7pcvd66VK0nIwLaHrNxzmdr4n1xGVqVfm/B5THatMR79YYdMaIl1pvj
         ydYGs1e+Rt7xjfZfpHHR2sRuw9QkToD4uWhbsg9g+tsJmeYP8GUqL/JW7SC8w/3eXD4M
         DQqTRAwvR96Y6xDShcEyynVzk58/5e0w9Knnwa5ENfQj2wnTPFxq5WMA0g4J2s8aAcLV
         TA8oACjcifJuCyZGVM3uSfRjLtyxlUa/B1yFvNpza49BliaM2WeI4HtMTq6vWUXF4lHm
         5pPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756302637; x=1756907437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHvHAd+WcxCB4dlz78++SYO8j8Zl7cNSriJo6KrI3ho=;
        b=ZANP2dx4ro4vlr1o/rliLYH5eGucDlTopHYUL6d3XGOBz/ysQOhgtKQFCxZnMYFFvy
         GkpGqB0VlqQ+9GHcT9EXCCl9lhupJzLT00dy1F/V45c/IixKArkvSUw7MbwW8UK+tAIJ
         6BMXCtyO9LENZqMfoIrmuT2+CHYzF2xeX7WZB5F4kfxPWq4cved8/0Mte5nYFMHZyeZV
         52bAwgEEBi8QoesaQZa7Ft/K2rzhlm0pyevUdSXq61TlJTj3FCIBB5E2jZhbXu2Rxg3X
         nbs0dWL37LTgXIdD8ScHqrYPi8LBM9eK7klwXbEV+nXU0utS59DVUXe0hMMhWB1dBhHJ
         T7/g==
X-Forwarded-Encrypted: i=1; AJvYcCXJcRMQuHsDfcIcXPPtH6ijo/J+I6uKzdGanCxFJ2GosUbVBiACNcrwjkd0iYEX/BN4UldkkFpS9cw9ko8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4DRm6TEkGGSWV0UJagAvcSiyPrJY9wYO5data5Ch4fLgQpwUp
	p8SaoevOw24LgFK/Gv7pouByxpCl/4dB2S+H+tfvgAKdfSOnJY202Add
X-Gm-Gg: ASbGnctcKf7RW20KhGDI19vPLYJFAmXPpMgafdr1ePq2Req5uobdtQzJ4yqCbvNDBfG
	78StbLj6uCM4XWneH5QO/ZdPn5OydIFIaRv3Q5VT/CyRnCR3x7Av9WMbnaqReb9t0RJEPz4QhBr
	BgSkV0aNr+N32oo73fiknUlpTytHxcXgj7zEbxo7Pi5hQxCU7AhAFf9PZ+yCPh0mghLsPKxsLE1
	4FF5oyzwphvAKr+KKfL2cBXN2GI+pxBnlLqGYBnxs47zcI3n1SjssxEKSdBS79QSb+YSniVIZ4H
	MiLce8qnHr4f7S/850tQfjWcE5svd3HJXh1EyeImWh5+SEZoB2/iXHWCwXe6K5C2MwiRA49ZoJm
	PkkIJC9ABl6Wewbxndp7vLUJ0XXkvPyT3nYgJPU+qWE3EmIO2Qrp40AfH8f3BN+BqQkPYv7NzWy
	0dIFu+YVHdRXQ6
X-Google-Smtp-Source: AGHT+IEKgDN/ZBcwEn87KjLNUNyqjBkpE8EGUUYNqeRgHERjmZuT6UdvYUjXs54tgL3WSG2ZB11oWQ==
X-Received: by 2002:a17:90b:390f:b0:327:8fb4:5140 with SMTP id 98e67ed59e1d1-3278fb452a6mr1209899a91.10.1756302637106;
        Wed, 27 Aug 2025 06:50:37 -0700 (PDT)
Received: from localhost.localdomain ([222.95.34.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772017f538esm3247052b3a.21.2025.08.27.06.50.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Aug 2025 06:50:36 -0700 (PDT)
From: qianjiaru77@gmail.com
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qianjiaru <qianjiaru77@gmail.com>
Subject: [PATCH v2 1/1] RFS Capability Bypass Vulnerability in Linux bnxt_en Driver
Date: Wed, 27 Aug 2025 21:50:21 +0800
Message-ID: <20250827135021.5882-1-qianjiaru77@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: qianjiaru <qianjiaru77@gmail.com>

A logic vulnerability exists in the `bnxt_rfs_capable()` function of the 
Linux kernel's bnxt_en network driver. The vulnerability allows the driver
to incorrectly report RFS (Receive Flow Steering) capability on older 
firmware versions without performing necessary resource validation, 
potentially leading to system crashes when RFS features are enabled.
The vulnerability exists in the RFS capability check logic where older 
firmware versions bypass essential resource validation. 

Signed-off-by: qianjiaru <qianjiaru77@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 207a8bb36..b59ce7f45 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13610,8 +13610,11 @@ bool bnxt_rfs_capable(struct bnxt *bp, bool new_rss_ctx)
 		return false;
 	}
 
-	if (!BNXT_NEW_RM(bp))
-		return true;
+    // FIXED: Apply consistent validation for all firmware versions
+    if (!BNXT_NEW_RM(bp)) {
+        // Basic validation even for old firmware
+        return (hwr.vnic <= max_vnics && hwr.rss_ctx <= max_rss_ctxs);
+    }
 
 	/* Do not reduce VNIC and RSS ctx reservations.  There is a FW
 	 * issue that will mess up the default VNIC if we reduce the
-- 
2.34.1


