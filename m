Return-Path: <netdev+bounces-225676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6332CB96BD5
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6797318A5763
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B742D2E3B0D;
	Tue, 23 Sep 2025 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHTTlYNn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EF9255F31
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643605; cv=none; b=KbR0slplMkOCnROIyNXw3KkFoKqHV0M05GtUc6D96Flcvqi+HJpPTYXj3gGhhMAP1C1lgOsj2W88lDUbjpAA+CwGXCgF9cuCBARVGDWODSdWZ6WP1mj6Mx1i8KXqQTXClIm9V49pOBcBcWnaqII56AQcbI//w5z26/tiHNyEzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643605; c=relaxed/simple;
	bh=yRZBREAJTaU8sSOhttVeLwSntMyFmzNWX36Gn0HWzTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UrqriRe03DpWB2yqfpGaL3fXyV3NdPrW+KecpMeJGKIxpFktJNl1jAm/D61CCG14z6Dn6w55IcLWGgQkS28EU+mF6yiNLjdkPHuY2pjMJeP5veJ2Rql5hU7Rnc/VsObk0l5832xY2hMcJFeFw1qflhrz06DZx8bJh6EmDlzQ/oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHTTlYNn; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77f2a62e44dso3755894b3a.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 09:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758643603; x=1759248403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t309JLGTHyrQ93SF2bmZLkppAVP5+5xihRdA8pDsPLU=;
        b=KHTTlYNnAIQNuqe1lUUQzBojbUFsRc47g6kYMQEW+QXL4DC7XEF7C+8Ym9YB+XlhWh
         ELPPA64yorVIMxjb8sKcdolAlOQvbnBfNUaCcS4V8zp/o5z+UxKyTx5q+mlTYHxhjfqG
         0dk1fMG4Jt3wzc0HzOe8flQa8oW6KfRIkHnp884aABSFOOBve3b9S9pFAMxhLZQIrMFx
         g0aVGlkBht2HLaInaFL7FGhClg5sbZSJ0i/HjJqHJyIMERJuUbTryTsXRbwlZ6DjmdWc
         7o8xVenyxUUMjhZaemd30XDUfrmom3Jd27g8Cu7Z8H16rFWHThnBCxWM73UezRsgod4a
         7kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643603; x=1759248403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t309JLGTHyrQ93SF2bmZLkppAVP5+5xihRdA8pDsPLU=;
        b=fl383MkcfH2HntpVpNHYJxYQjuF0KkFnFmWPyIt1MZ78LVy2lD6i+SUc0/jN3lhS6b
         9D28YCz+D+3iFuges809Tsm/oUY7oHHnI+Fl/RudKk24XZvLF42tuTppy6kxRtYw89Lp
         DtCA25/k1smB0MIma4Pvk+3kSa5uA1zZXl6PPjFRNjno+31vI6iv85Kvk1Fmln1e41tI
         j7OyOJ1alj3bYSCNfzokb67G4V0HxSU29VZFxQvBu1Q38THt66Va6dDFLhgJseeE6FHl
         2HJR7OY8xk4Gccws5lc0so1jNNYEdGUKWFYgVWwoYRrUcbhG8RvyveGW+ITkjn8Un/3U
         gOBw==
X-Gm-Message-State: AOJu0YxljV+WB3jiU8jv4QrQjAHvdVw77VZiPkrEW8FdaLSDRcPQsUK7
	YJgWAVQ6ZC2LPVEE7DNOtkrzJIw2PNNDIAvFbmW1j5nE8kM01phuNivz
X-Gm-Gg: ASbGncsfErFPYYZPZpztCABE6J9rwVe5McA9MrGBlat3mpov+t5COFn+fd5oIkiw4AR
	A/ub2Gcag4kfhQmu8tkCb8fjzFp8xATmmxsIxkdpLtH1UE1nppH6fvzwVXwSaLseep5PZeW/kjF
	XDCzQyMlkYA87GI44Y+QXtzKRKEA6rnlJujDyD9jT78coekXfcGpriARRQjcFNl9ViMBiptveRZ
	L5EJ0xjKoA6woV3S+ZqTbsv6QtjLoApTysVacziTLRu+vkzMIr8iADOdbfL70x3g76m6GppszqD
	DwEIRgl0Rj1a3NO0rYS5lU3EELuQu2I9gn2JKg/TMOk1QYpo1qIIueqSJS2THccA8pWXV2qFT0x
	753JTArLNboCeVF4Bjzd3ponAfuL19tqOdp9i3Cpz26bubiRP0s4PYUvQljMQXAKtXpOImPjMlR
	4pS2QjSlALMy8O
X-Google-Smtp-Source: AGHT+IFkkB+3aFbUYjMbYAr5CaGup6768qgAaVamVl9anvKViE9FgNGhY1HvWcu+9yfaeLkmeqZekw==
X-Received: by 2002:a17:903:2b10:b0:271:49f:eaf5 with SMTP id d9443c01a7336-27cc696e9efmr39277455ad.30.1758643603090;
        Tue, 23 Sep 2025 09:06:43 -0700 (PDT)
Received: from debian.domain.name ([223.181.105.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802df8aesm167167395ad.89.2025.09.23.09.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 09:06:42 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	I Viswanath <viswanathiyyappan@gmail.com>,
	syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
Subject: [RFC PATCH net v2] ptp: Add a hard upper bound on max_vclocks
Date: Tue, 23 Sep 2025 21:36:22 +0530
Message-ID: <20250923160622.8096-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported WARNING in max_vclocks_store.

This occurs when the argument max is too large for kcalloc to handle.

Extend the guard to guard against values that are too large for
kcalloc

What would be a reasonable value for PTP_MAX_VCLOCKS_LIMIT?

KMALLOC_MAX_SIZE/(sizeof(int)) is the absolute max value for which the 
memory allocation wouldn't fail

Reported-by: syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=94d20db923b9f51be0df
Tested-by: syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
v1:
Link: https://lore.kernel.org/linux-mm/20250922170357.148588-1-viswanathiyyappan@gmail.com/T/#u

v2:
- Moved the validation to max_vclocks_store

 drivers/ptp/ptp_private.h | 1 +
 drivers/ptp/ptp_sysfs.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index b352df4cd3f9..f329263f33aa 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -22,6 +22,7 @@
 #define PTP_MAX_TIMESTAMPS 128
 #define PTP_BUF_TIMESTAMPS 30
 #define PTP_DEFAULT_MAX_VCLOCKS 20
+#define PTP_MAX_VCLOCKS_LIMIT (KMALLOC_MAX_SIZE/(sizeof(int)))
 #define PTP_MAX_CHANNELS 2048
 
 enum {
diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index 6b1b8f57cd95..200eaf500696 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -284,7 +284,7 @@ static ssize_t max_vclocks_store(struct device *dev,
 	size_t size;
 	u32 max;
 
-	if (kstrtou32(buf, 0, &max) || max == 0)
+	if (kstrtou32(buf, 0, &max) || max == 0 || max > PTP_MAX_VCLOCKS_LIMIT)
 		return -EINVAL;
 
 	if (max == ptp->max_vclocks)
-- 
2.47.3


