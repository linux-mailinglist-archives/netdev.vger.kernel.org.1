Return-Path: <netdev+bounces-226445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567FABA0835
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 17:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188453B25D4
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02DB304BA9;
	Thu, 25 Sep 2025 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoYNbEM5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE93019C1
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815966; cv=none; b=fQlPKUnaCn7ObqBBa8X/cRZm4b2ByEVvhbQo6p3UdJNxoOc20b8YIqck6fnmozfJEVFtUBqAIjYWXa7YghRldWRVmphgSJWwPwtxyQ7WqwBdF5LXI8jvpnsq4kQHKNLYi85leZqMOWtCLHpSfiZETlP7DWnEDINMkdBPbQnT5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815966; c=relaxed/simple;
	bh=2eZlHWvOxIgL3EbW7gHH6le+1fHOsCXZEgZKoMQwuOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LW/xd44iQZqdihWsBLfzHr9yDLTnPUEWUBTbzYpgTDr8+Es29Hz4vx+OXHA+I4y3nPNfDm3wZHRQ8cSZjQ/ULMPgp+PnGx1Zh0htOORZvUZXdjjTcKSV99dzBUddGrYRgRleTbalS4vmv4xyfpGPr8qPyisZ7dCSEJgqVwUC6Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoYNbEM5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77f198bd8eeso920450b3a.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 08:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758815964; x=1759420764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0haNpnskPhHv+Hqq/prkArlkxvbNwI7IdrC7Jtj5DeM=;
        b=DoYNbEM5TpV3Z17OMjOy0uqsyvDFPyTPoxJtD1dejAxtus7VVtREu/92QrEICzDkak
         XXHXWYZEGsj8SojYj8cs+ADE0O0xLL8+UmwqzvENiIpKQDxYGu6SomHWrffZEBP4dcek
         reXpACfda0+NllIHbcuELyWIu6iUwFchCkquLQ2Y7JaAc9WgqDkUcsA6cESIu2CMp69d
         kArKgaYRi8NKfSg/UidWeR4WC8difCzB2ERHOvDaASUPTfT6eUsNQuj3J9JI8pXI9p/x
         MvVf/xn0SE64gdKi/I/WJohf0+W2Nxz7III1vOIcijBlUX7agCOSgaLQepFc7z2b9GfD
         YCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758815964; x=1759420764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0haNpnskPhHv+Hqq/prkArlkxvbNwI7IdrC7Jtj5DeM=;
        b=n3Ad2S6f70wiUDQFgC/nW/QuCBLHf7mXXnDjpZNUutUPgJR4SlDasN5rnSiYBZ/DGt
         VOq8NPfIzGUFFpaI2GmOBwOD7lUAZX9h9xp4OrLhn2k1TNb/R3o9UA4TNfnz3pkWy980
         UUqEb2kcDvaEDCp5YJR+HtqVKv7PbmSG4r+w4JRCInV589tytQU3O0n7uDNlVLv1Vk5m
         8D+fpBEbD+VjQaU5pwXaDouuqlQZ+IS6lrXz+4iiVHcIaCW0c+6Pv0+GRNtfbye2JeDt
         HZjw2BU4wl6WueNYHmxUeXTsDlHh1Y9nMk+8lvhORF2oBWr32jdVzevfrji92qnJWnZg
         k5rQ==
X-Gm-Message-State: AOJu0Yzv8OYHfGB+X4DqC2UE24n0Vzht8k/B6kqxCsLBGn9obSuHWQcP
	4WAMiqX4w79jyspzayRFJ5RCLUOrLwD/5LALRCSq2iG2wd0hERo/DMGX
X-Gm-Gg: ASbGncv7REcpX1xGyO54r+OHtYD6jWVdlMxxXv/lfwotiJsR81LPu66YkIdwH5SUIpD
	M7lxJVvO89EP7ShKRQRZbiqNd5HAzPGaqSr3pTmJT0t+ok0e8bVDtdnRNQ4G9UMh8Iq+2DRw3Ob
	qvo8BeVTqtcKcP9il0wCP6utPN1cmb+a55JWBM9jyzRjB0gZZB0p1TifzSa+QGEZjhKMkIx5xzz
	WTwLkwaQUsVxo5Kh3DZbavv7fYRWAQMrQs59KadFKW+UP5P8O6UfVq1pzp4Fr7J14FLOZha9mvz
	B30Bv5CXbG7O5yuN5RD78Q+LJA6/9yq8JReI1uAj+NgDRbxQ9e54d9H+rDYWmegT4/vja2/L/N4
	RTcjQOrVySV4dlNpwj/rrWv+2AvWLYrYlv0XMsdH41WxUcgzN5D9TG0H0B+33ixuoP9wXF9Aq0S
	wVHPv6AUeWnR64
X-Google-Smtp-Source: AGHT+IEhAQcRgo74RGno0MIUNQs86Uz784EwSabYzAQVGz1THpiA0aDqQT0LiijW0GN3h3wpllQpcA==
X-Received: by 2002:a05:6a21:207:b0:2ed:997b:44b5 with SMTP id adf61e73a8af0-2ed997b52c3mr1885758637.37.1758815964344;
        Thu, 25 Sep 2025 08:59:24 -0700 (PDT)
Received: from debian.domain.name ([223.181.105.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238cafasm2320354b3a.4.2025.09.25.08.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:59:23 -0700 (PDT)
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
Subject: [PATCH net v3] ptp: Add a upper bound on max_vclocks
Date: Thu, 25 Sep 2025 21:29:08 +0530
Message-ID: <20250925155908.5034-1-viswanathiyyappan@gmail.com>
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

Reported-by: syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=94d20db923b9f51be0df
Tested-by: syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
This can be reproduced by executing: 

echo x > /sys/devices/virtual/ptp/ptp0/max_vclocks

where x > KMALLOC_MAX_SIZE/(sizeof(int)) which computes to 1048576 on
my system

What would be a reasonable value for PTP_MAX_VCLOCKS_LIMIT?

KMALLOC_MAX_SIZE/(sizeof(int)) is the absolute max value for which the 
memory allocation won't fail

v1:
Link: https://lore.kernel.org/linux-mm/20250922170357.148588-1-viswanathiyyappan@gmail.com/

v2:
- Moved the validation to max_vclocks_store
Link: https://lore.kernel.org/netdev/20250923160622.8096-1-viswanathiyyappan@gmail.com/

v3:
- Removed RFC tag from the patch

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


