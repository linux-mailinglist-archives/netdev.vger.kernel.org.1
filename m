Return-Path: <netdev+bounces-182592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBDCA8941C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 08:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81ABC7A2C05
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 06:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FF2155382;
	Tue, 15 Apr 2025 06:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjhhvYEa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693EEF4ED;
	Tue, 15 Apr 2025 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744699606; cv=none; b=T8O43xzO6WngKSk4w5vdgloVgc3FCr6LHWZUTv+xV3IkbSakdVTbwSxoHqywOeXFw0iMluusEE076uDpwmFzjzyG0KeDOM5b4rLmGF7q6VCb4oTeAh6aN85/TgQm2fGKqKRU4WdXJglHEbb9gE92zpsAuuUNRt1sXx+Sltq7/FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744699606; c=relaxed/simple;
	bh=X+fjcr3QhbZUWxscEWsqQ35xAvKhTO6uBrb8u2MD/Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M1SrFDCro+CYcYQzZ+I3RM8mjfIyF0kQTDCfwZkjOHlwfTc1Y6zmuFHAHexLa7AESQ5xrAxYHogTfeUv1MD8mDcgujHim/62OP8g9zMHuASa0R6tG7mvR55RQrcqOIf0kp6QpCB8CgwxHA/eiQvwVQmLUZSjW3wsnMyTvkuwB6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjhhvYEa; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso56422075e9.3;
        Mon, 14 Apr 2025 23:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744699602; x=1745304402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tf0XHOV7BL5G8XCTnMqntqoer1LQ9IvxtUGe4LQu1Mo=;
        b=MjhhvYEaFVHqmlbwCSjWG66Z7Q94FWs0x3uoaX30feT3+PRI7OBs+vZTZUWCLurvDw
         XZziLTkSJgtW+oW8QYVGTDGB732MS7P6p7VUCieBtMXJxzU2mUSEIBzIiTWl97Kft6aZ
         +Y0JaZd8tggWAwJMTif9R63azefmKVMGprq99isA1H2vi+nKBZQSPRgql7tQxMt2UAxt
         lco14WtP5cGY3edMnttyEh4ihjC2HEPTWt9KzJ9OJUC3NnMkkACmZwrSM7LFmSk4MNA0
         Td+/8jMJ+6ixQ21SyshcOGgwZzd6MQR/zWgjpcwqf8dUwYkuiIfySpjrRA3us43BahtQ
         JBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744699602; x=1745304402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tf0XHOV7BL5G8XCTnMqntqoer1LQ9IvxtUGe4LQu1Mo=;
        b=RFtCg/v6M5fbNX70NdyGcggS+luh0UhEhhVR7trdOn7J91lm9A7STY+K2zWI982VE7
         +WxOinuGf9sqm/eazuu+yiUU6Hk7nDva3di2wPu/05xudruR/YBH5E4Rnz4lPTgUihbH
         Q2Y44WdhsRb6ODvJtQCjsN13iEuxbfpi7ouPsLfUnU8zaZ29Wn5/MMYMUhFDc3237yuR
         rxgvGvnPnIuoyD1D8TESlOhBAZCB40BtMBquPRg6O1W3pNuomVYUuBZ4wGchxM/2/O7e
         lVjfGLGSm7+xmvMbaoBaBRaCc0DIa+UtGBXUjSguN4+WFfWPpVkyL9VruhLUaHHI0aMw
         dIeA==
X-Forwarded-Encrypted: i=1; AJvYcCX5h/+UufzM0XtdBxbW+wG1aDy3b7tHJBT6oORd3/Te5N37lhw8CmpHoOIiqXzmvcDhj+GrVGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxotGiM6SNmqdLEfq9uRXflq2hl0os6rMar/L/nNE7Zy77h2r5i
	TH5u+9q63uGtVZWL5//0tQ8ulzaw2wmHuDlGg1XKUjmzJetuoN/A
X-Gm-Gg: ASbGncvLF8G6Hh4z/Miyrp40mJjFeFlEdc0Q2an2oWhOIMKYq5Tc1DFyyHt0RoJr6l9
	hCA8dnyRrKaeSVm3aEGjztPKEBCElRL62ovAp+QaKf2A7dqWVUgMoOAl+xeNhxRwkOVA1t4T+Nr
	G6yiN6Uh3JqMpb9Oz8IjjTcicamYOJwsp2CbQLLx/Lwk0pfUTpRtJ2A1So2HcMPj9z0ZPXcJPjJ
	99FjFL14TtS1G/JX2phbIvAL9YJQLZlsS7h9KvX0LRQBjcxODkFWGmTaLDMpO+nliw0NHympCnv
	0siCOK4RiCjqy3zquXF4RcbMgCewj9B8P4ESk6ZNx1K9sSlpLqUyliuyvedVwE5B6JFKs3RFXxX
	ASw==
X-Google-Smtp-Source: AGHT+IHisxwT86R0m506gtB4OyZvGE9/Dpo7sMqSR/LKHnRC7jBHFDbHx2PM+1aawYyZ6izqHkIuDA==
X-Received: by 2002:a05:600c:8489:b0:43d:40b0:5b with SMTP id 5b1f17b1804b1-43f3a9a68admr102272625e9.25.1744699602432;
        Mon, 14 Apr 2025 23:46:42 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f23572ce4sm198385685e9.30.2025.04.14.23.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 23:46:42 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH v2] ptp: ocp: fix NULL deref in __handle_s for irig/dcf
Date: Tue, 15 Apr 2025 09:46:38 +0300
Message-ID: <20250415064638.130453-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SMA store/get operations via sysfs can call __handle_signal_outputs
or __handle_signal_inputs while irig and dcf pointers remain
uninitialized. This leads to a NULL pointer dereference in
__handle_s. Add NULL checks for irig and dcf to prevent crashes.

Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
Addressed comments from Paolo Abeni:
 - https://www.spinics.net/lists/netdev/msg1082406.html
Changes since v1:
 - Expanded commit message to clarify the NULL dereference scenario.
---
 drivers/ptp/ptp_ocp.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 7945c6be1f7c..4e4a6f465b01 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2434,15 +2434,19 @@ ptp_ocp_dcf_in(struct ptp_ocp *bp, bool enable)
 static void
 __handle_signal_outputs(struct ptp_ocp *bp, u32 val)
 {
-	ptp_ocp_irig_out(bp, val & 0x00100010);
-	ptp_ocp_dcf_out(bp, val & 0x00200020);
+	if (bp->irig_out)
+		ptp_ocp_irig_out(bp, val & 0x00100010);
+	if (bp->dcf_out)
+		ptp_ocp_dcf_out(bp, val & 0x00200020);
 }
 
 static void
 __handle_signal_inputs(struct ptp_ocp *bp, u32 val)
 {
-	ptp_ocp_irig_in(bp, val & 0x00100010);
-	ptp_ocp_dcf_in(bp, val & 0x00200020);
+	if (bp->irig_out)
+		ptp_ocp_irig_in(bp, val & 0x00100010);
+	if (bp->dcf_out)
+		ptp_ocp_dcf_in(bp, val & 0x00200020);
 }
 
 static u32
-- 
2.47.0


