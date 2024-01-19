Return-Path: <netdev+bounces-64376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF60E832C0A
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 16:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1751F21BA3
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 15:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210D252F8B;
	Fri, 19 Jan 2024 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoNk1q6n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438441373
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705676580; cv=none; b=ild+jon6XVcjXYJTbpTevF55tj2A7NeeYHILkKzENbYU4VlbXVSu9IMrjIndzmo2GH8cHB5drnX7yfoTvYPVZ9EMFTndhOgZE3KdXbeG9AgYXOADjSPkA3oRlOU5H9NSC0/MfE7C88Y0W4rpsTYIyQuE2jWSfbpX9gCSWZssCEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705676580; c=relaxed/simple;
	bh=Wvdp8NwroEUnlOcyXYB6fhifFLEf86W+er2ratf6ib4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SkDYPXtZkCgBSA2yXxV+W8TXMvbtfURsSiy+lISZ5G+FhAWkLXupUYiKAFA3lE6rzbyknH2rEdwrjLl9vEcSOqxJNvlvImsxHkDi1Iji2bXOitm4lTXTX/B0IKiZBAbLroHdVZuVTTmJkiexnqRhtfrcfiL5qlehVMe2pBlwpdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devoogdt.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoNk1q6n; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devoogdt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3376555b756so537230f8f.0
        for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 07:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705676576; x=1706281376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CVdx0XTXF9oMlbE/2BBUk3oy7mn9BIkXq8b5DHwfmHo=;
        b=QoNk1q6nhdlk7GJHjN1/q+60U/VAjaseiNhtE9coTp8TswJaCO3FVXj+vGFP3YgmV3
         EO9sJrdJ94F/hFCqKQsBJ0TK4tdWyGOTz9lYBz6Uvsd8d2e+s2MjCzr/Cy32GBVvTOTl
         NgS4RS9AhGNawtwbsC2m25yw/zdvU6iMcwvQVLwNw/Z/iu5Q4igmVy+kIbhDQC6JKOoU
         q23VAlIcj8+YDKoEzKshKDEXOeNHDI5maztAYF5rhZR2hTl/m1HR7tYcvNvNX/cWIEbN
         WcXAayR0d4yZ7aVZja+FP2NtwFBLIqhqOhh/Aox7rMLN5nboce0PjRYf0RYh06mO+U6m
         Psdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705676576; x=1706281376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVdx0XTXF9oMlbE/2BBUk3oy7mn9BIkXq8b5DHwfmHo=;
        b=iSGt02KBbUfh2K4A0qQrCxMGWk5h6NfnLq1aa8ws4C4SGJ3a2z1ZODeVdWKPykKUh0
         U8CiCd5u+WKFT5g40GcLiDsvjs1OQUSPHHL/hWDU9rABWkSrQvoHs4ykJPaD+ONiQnxN
         kQ4Xug16qKMjdlfmlWwajYKx3qpcM8boaPmY9OBOWzY35SHqqzOTpaS+51mx9L3GpIu/
         Y1aHCrq7LahAG5Zm5da33XhFPFy0fU6fcmC8UaJeniCOCPxwq4zFUl6VOr5Cg/nfMI0W
         4td3JYbgpSmGgh3D5WixzyhZRKrlcdtA9rNZ4vOSiOfKm81GVZSpbLtCJmRd44pHMo91
         RHtQ==
X-Gm-Message-State: AOJu0YyKmVwJN5TpvXR+764rTeMxhJw2sH8jNVwoqBeUaM7onQWbw+Fu
	Q5INr6Cu8xw2WqiOQbIyrAJGmIXvo4OkpN1qQN4ZbkbhfzfF6/cUqAjxxchc5k8=
X-Google-Smtp-Source: AGHT+IF/vX4ILC15vEGiQ1r6Q5nIWrSHqfcbd6u2tpOtdeR2TXTCFaPcl1wyvKUoT8i2WX515e22SA==
X-Received: by 2002:adf:f489:0:b0:339:2374:ab55 with SMTP id l9-20020adff489000000b003392374ab55mr8242wro.8.1705676575654;
        Fri, 19 Jan 2024 07:02:55 -0800 (PST)
Received: from thomas-OptiPlex-7090.nmg.localnet (d528f5fc4.static.telenet.be. [82.143.95.196])
        by smtp.gmail.com with ESMTPSA id i4-20020a5d5224000000b003374555d88esm6736748wra.56.2024.01.19.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 07:02:54 -0800 (PST)
Sender: Thomas Devoogdt <thomas.devoogdt@gmail.com>
From: Thomas Devoogdt <thomas@devoogdt.com>
X-Google-Original-From: Thomas Devoogdt <thomas.devoogdt@barco.com>
To: netdev@vger.kernel.org
Cc: Thomas Devoogdt <thomas.devoogdt@barco.com>
Subject: [PATCH] tc: {m_gate,q_etf,q_taprio}.c: fix compilation with older glibc versions
Date: Fri, 19 Jan 2024 16:02:52 +0100
Message-ID: <20240119150252.3062223-1-thomas.devoogdt@barco.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

glibc < 2.14 does not define CLOCK_BOOTTIME
glibc < 2.21 does not define CLOCK_TAI

Signed-off-by: Thomas Devoogdt <thomas.devoogdt@barco.com>
---
 tc/m_gate.c   | 4 ++++
 tc/q_etf.c    | 4 ++++
 tc/q_taprio.c | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/tc/m_gate.c b/tc/m_gate.c
index c091ae19..1dacd4b3 100644
--- a/tc/m_gate.c
+++ b/tc/m_gate.c
@@ -26,8 +26,12 @@ static const struct clockid_table {
 	clockid_t clockid;
 } clockt_map[] = {
 	{ "REALTIME", CLOCK_REALTIME },
+#ifdef CLOCK_TAI
 	{ "TAI", CLOCK_TAI },
+#endif
+#ifdef CLOCK_BOOTTIME
 	{ "BOOTTIME", CLOCK_BOOTTIME },
+#endif
 	{ "MONOTONIC", CLOCK_MONOTONIC },
 	{ NULL }
 };
diff --git a/tc/q_etf.c b/tc/q_etf.c
index 572e2bc8..041d72ce 100644
--- a/tc/q_etf.c
+++ b/tc/q_etf.c
@@ -25,8 +25,12 @@ static const struct static_clockid {
 	clockid_t clockid;
 } clockids_sysv[] = {
 	{ "REALTIME", CLOCK_REALTIME },
+#ifdef CLOCK_TAI
 	{ "TAI", CLOCK_TAI },
+#endif
+#ifdef CLOCK_BOOTTIME
 	{ "BOOTTIME", CLOCK_BOOTTIME },
+#endif
 	{ "MONOTONIC", CLOCK_MONOTONIC },
 	{ NULL }
 };
diff --git a/tc/q_taprio.c b/tc/q_taprio.c
index ef8fc7a0..c82bede1 100644
--- a/tc/q_taprio.c
+++ b/tc/q_taprio.c
@@ -35,8 +35,12 @@ static const struct static_clockid {
 	clockid_t clockid;
 } clockids_sysv[] = {
 	{ "REALTIME", CLOCK_REALTIME },
+#ifdef CLOCK_TAI
 	{ "TAI", CLOCK_TAI },
+#endif
+#ifdef CLOCK_BOOTTIME
 	{ "BOOTTIME", CLOCK_BOOTTIME },
+#endif
 	{ "MONOTONIC", CLOCK_MONOTONIC },
 	{ NULL }
 };
-- 
2.43.0


