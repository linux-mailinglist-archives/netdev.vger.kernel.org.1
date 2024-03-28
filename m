Return-Path: <netdev+bounces-82731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8478888F779
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 06:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77E11C2552E
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 05:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033E645944;
	Thu, 28 Mar 2024 05:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="CV9TAJ2i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA64D3D55D
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 05:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711605152; cv=none; b=f+HtivhbEBAfWdV30bSWnyzWE5maCYSZaqsnSwZ1Pk6SJKiXAD9rSYNvvw372Uu9NXSSoAmo82bz2VNJTpkPbQlWtF/T/wJdS5RSN/MA66ltTbItUp05k6+Fi/kohInZWjOA8zaImE86CHghWPIAOvndoER6fu7HXmmq9Xdw0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711605152; c=relaxed/simple;
	bh=IM7KzaaRTUbiiz8gas+y3YT7bts1cJvbq3AR9jRHSRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uCHJwU9+qxqsniVX76n9geYQXr9o6JLG1stbY1ItSetLtAep3U4sMg6/O1+bKDvgB08GUwxFLwaXhTvWbcv7t+9lf0nV4TYVcddf7cHIkQeXwEaYCc2CVQngVFOhrjeMn+hBpUvLZuNOPoQjjrWBqIxoqu5Oa/eNiouaK45wr0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=CV9TAJ2i; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C9E113FB76
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 05:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711605141;
	bh=VBxUCjUNVZV+fl5KJlFAhITCM40y00zmGCguCULZrbw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=CV9TAJ2i1kZu2GIErF/LEyyC0DWNdrHDj4VhwBBv0tz3UpY97Z1LYe+wE/nYxv3zF
	 JO7j5fwimyp/F9MobEiJqx4z4sY2CYRG+ix3lgXNA4r95KdnZFhVaV3fwJEQWmja1S
	 pWs3f+aadAUA/MfARnTBv2qc7+s6vVEcTuA0way4lIifnN/Tf3kzIlBGE5IW5DH708
	 WCxA+rj82LdoOp4uttAjfqgBPO/LtBXL0crB5GDsQ8ZUKm0VUC2UaVdUzXCIWKaogu
	 FSkIOquugeHrC0HLLTIdjVr5bO87ikb53RNJ3rrxhyfVrg+l+lzgWlLgrqoqrsOd1i
	 LnYkOKyqyu2Ug==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a031e5bb29so531683a91.3
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 22:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711605140; x=1712209940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBxUCjUNVZV+fl5KJlFAhITCM40y00zmGCguCULZrbw=;
        b=uF1QoOkf58ybBFh6gPdYfABJI7Ek4y39c6Osyw0U8mXwu1As1e0V/2CVUFZ1DwyEVy
         HDOisxdyhexCP7KQm2ib9binjkXy3fY8fd49LqNUCkQnnt4Fh/uHuXwewhxlIJpKRRvt
         93g6jrgGcaYElRrC6xpucpbS4rFfdof7qOzF5ptbcYteZoxMmtYN1ZzkgXNy+M0JhlKP
         kLtZ92EVM2/J9TTxjsS9fVvJ0MQCIA3SnBV8vTgNSKRdDtZYvfBQLi3fj1VNetzI9Cfc
         IG7rn8mtW4wYhT/ZAmamNjlXqWnkNcbXAM4DuDW3S0GyCSRNFu77OU2NhPAmXwf11l5T
         O97A==
X-Gm-Message-State: AOJu0YzxNqLJnY8vxUAuLxTVVPGtzFV1EgIGmM2AjVkUuK1Vc/VaDaxA
	E+kV/F70TZmXMFSKg3fD6icUhO/a7whE6SsQQAItQEHgzntM6FXk2ofJVcoIqHcqkkcSiQLqLxI
	uilFyUUTK9aOy7k7+QaivyZgQ3n4JdzKnnPDwspmP1N1t1wGKxg7eaKyudFY1ZkBJ4WGkeQ==
X-Received: by 2002:a17:90a:fc95:b0:29f:8d52:d5da with SMTP id ci21-20020a17090afc9500b0029f8d52d5damr1666117pjb.22.1711605140197;
        Wed, 27 Mar 2024 22:52:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhdAR5Qr3109Gj+ShgjvrgV5CZXFMSIAQJkuqovm9XMmsuc/x89atGroPnAzWBfcdakLA3FA==
X-Received: by 2002:a17:90a:fc95:b0:29f:8d52:d5da with SMTP id ci21-20020a17090afc9500b0029f8d52d5damr1666107pjb.22.1711605139830;
        Wed, 27 Mar 2024 22:52:19 -0700 (PDT)
Received: from localhost (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with UTF8SMTPSA id ev9-20020a17090aeac900b002a03d13fef5sm2741309pjb.7.2024.03.27.22.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 22:52:19 -0700 (PDT)
From: Atlas Yu <atlas.yu@canonical.com>
To: nic_swsd@realtek.com,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Atlas Yu <atlas.yu@canonical.com>
Subject: [PATCH net v2] r8169: skip DASH fw status checks when DASH is disabled
Date: Thu, 28 Mar 2024 13:51:52 +0800
Message-Id: <20240328055152.18443-1-atlas.yu@canonical.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On devices that support DASH, the current code in the "rtl_loop_wait" function
raises false alarms when DASH is disabled. This occurs because the function
attempts to wait for the DASH firmware to be ready, even though it's not
relevant in this case.

r8169 0000:0c:00.0 eth0: RTL8168ep/8111ep, 38:7c:76:49:08:d9, XID 502, IRQ 86
r8169 0000:0c:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
r8169 0000:0c:00.0 eth0: DASH disabled
...
r8169 0000:0c:00.0 eth0: rtl_ep_ocp_read_cond == 0 (loop: 30, delay: 10000).

This patch modifies the driver start/stop functions to skip checking the DASH
firmware status when DASH is explicitly disabled. This prevents unnecessary
delays and false alarms.

The patch has been tested on several ThinkStation P8/PX workstations.

Fixes: 0ab0c45d8aae ("r8169: add handling DASH when DASH is disabled")
Signed-off-by: Atlas Yu <atlas.yu@canonical.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 31 ++++++++++++++++++++---
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5c879a5c86d7..4ac444eb269f 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1314,17 +1314,40 @@ static void rtl8168ep_stop_cmac(struct rtl8169_private *tp)
 	RTL_W8(tp, IBCR0, RTL_R8(tp, IBCR0) & ~0x01);
 }
 
+static void rtl_dash_loop_wait(struct rtl8169_private *tp,
+			       const struct rtl_cond *c,
+			       unsigned long usecs, int n, bool high)
+{
+	if (!tp->dash_enabled)
+		return;
+	rtl_loop_wait(tp, c, usecs, n, high);
+}
+
+static void rtl_dash_loop_wait_high(struct rtl8169_private *tp,
+				    const struct rtl_cond *c,
+				    unsigned long d, int n)
+{
+	rtl_dash_loop_wait(tp, c, d, n, true);
+}
+
+static void rtl_dash_loop_wait_low(struct rtl8169_private *tp,
+				   const struct rtl_cond *c,
+				   unsigned long d, int n)
+{
+	rtl_dash_loop_wait(tp, c, d, n, false);
+}
+
 static void rtl8168dp_driver_start(struct rtl8169_private *tp)
 {
 	r8168dp_oob_notify(tp, OOB_CMD_DRIVER_START);
-	rtl_loop_wait_high(tp, &rtl_dp_ocp_read_cond, 10000, 10);
+	rtl_dash_loop_wait_high(tp, &rtl_dp_ocp_read_cond, 10000, 10);
 }
 
 static void rtl8168ep_driver_start(struct rtl8169_private *tp)
 {
 	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_START);
 	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
-	rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
+	rtl_dash_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
 }
 
 static void rtl8168_driver_start(struct rtl8169_private *tp)
@@ -1338,7 +1361,7 @@ static void rtl8168_driver_start(struct rtl8169_private *tp)
 static void rtl8168dp_driver_stop(struct rtl8169_private *tp)
 {
 	r8168dp_oob_notify(tp, OOB_CMD_DRIVER_STOP);
-	rtl_loop_wait_low(tp, &rtl_dp_ocp_read_cond, 10000, 10);
+	rtl_dash_loop_wait_low(tp, &rtl_dp_ocp_read_cond, 10000, 10);
 }
 
 static void rtl8168ep_driver_stop(struct rtl8169_private *tp)
@@ -1346,7 +1369,7 @@ static void rtl8168ep_driver_stop(struct rtl8169_private *tp)
 	rtl8168ep_stop_cmac(tp);
 	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_STOP);
 	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
-	rtl_loop_wait_low(tp, &rtl_ep_ocp_read_cond, 10000, 10);
+	rtl_dash_loop_wait_low(tp, &rtl_ep_ocp_read_cond, 10000, 10);
 }
 
 static void rtl8168_driver_stop(struct rtl8169_private *tp)
-- 
2.40.1


