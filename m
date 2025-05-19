Return-Path: <netdev+bounces-191572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AA0ABC2A8
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB054A2B48
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 15:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4538D286404;
	Mon, 19 May 2025 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWcNiw0b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD76A28540A;
	Mon, 19 May 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747669081; cv=none; b=RaPlRvdR2lPVa37ZWx5gvBrsolAtU21W4uH3kUQeY8mvyuL02X+0AmjHTachgK+qcvd2Eii1vpFgDaP4Cys+7XMNNQ1NJxd7Y7/5rDxslvTj3btdyu/zCAcGyboZiTLfbM6QbM/N8p/VH46Nt5NwBA29cPk0xl+jUzUIkmUsHlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747669081; c=relaxed/simple;
	bh=dKurGU96ZzpvsDrFtYxUMpxWBM/A1evO2kIvvih6luU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iLripk3wTSPomlL3dSyBJfZyBtp0ngUDuDWWhcteiJRBeVRIibeYx17MeJPOJKDo5HEb25QjBnDV30ZwyLrGA633CqYoSMSDTPRK9/NL85WSDZhtwOm5kttMdRq7UxmBsgIvazZx7F/+9zJIj9z1JuMSsq7HcrpCB56sTp2OWZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWcNiw0b; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742c9907967so1379313b3a.1;
        Mon, 19 May 2025 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747669079; x=1748273879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jtVYWklYpyxE1OBg2B7twpCzPiSl0RE7UkgacGb++bM=;
        b=aWcNiw0b0YyPHQAZc8hKH6TJ+DSMMwiu+yFwoX3YvjjDZfV2AfxhxSSvE2mxBDEalj
         76hMWI63kR1jqhrdiJ80VHrHRwDJ8n7xhFEwEs7YzOfx76ERH3HDRXpVc81lAsEEafg0
         egDv9WHplZXAYU+Sw9vpC3lg7sTRKRBI6U9jdFHrZRYSCducRYZPbfuPUM/d6rOq/r6d
         Z3wGuU/6uObt/exsFTSaOM3LuqBwz5T6gsqJR7W7tHioQ3nnTedIAawSTVhHyFSMixWF
         1eecdJlZJP9N3zWkeEgjEcrj/CsX0mH4hq7v6xJCTyocBp0r9jERrmCXek78lESajvR3
         HsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747669079; x=1748273879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtVYWklYpyxE1OBg2B7twpCzPiSl0RE7UkgacGb++bM=;
        b=V9hQam97wybklrNFMx39Db2uW8qlHQZu4Ms/pndjGmFkMy8TuBM7y62GeSnurN+aYA
         fDqZuWTrX/SfenQnNqMKZVTgWMJs8sV/gbyDCO4kytl9OmmNTpI0IdTjlMgHePYk6P1a
         JwY+lcqOA47jDtGKy5yeXL2EZqLMebN+yH4cArNi9TENKRHL0w/O+ESsC4cfcqGI5P/o
         DGIKkGbxKy0UYq4H33QGN8fXAMp7hwL9imwQpyRLTffcaucqHPt4EdX6XKSSrFMffxDa
         Yv+igrDyPv05YAzWfPshTCcpttGLxWv0PV4LTT3TZaxWa7DOhZHNdi8L8TURSANjvuWf
         Higg==
X-Forwarded-Encrypted: i=1; AJvYcCV15kBaI0/nLdm2MIwu+SWynXE9SRK9hA5KjcTF1U3UUBhYxym3hEwpSHuWjtnYAc6stMEKi9TT@vger.kernel.org, AJvYcCWSVqqcEcKo10BTcfw38CTuIHTi0aRlumvjoPwEM5tlU7aak0zDeOl6saSSwYRj7t5C+6LnshhYdyYgdFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1HyHfK1OJsIhOqeJvlvNHqSA4TPdFHRe5+hZ9/X8T+rH3euC0
	QsX2cpbcZYKVuSONbKScqyvKk45g2bxusOh+pujsttbyaedgia1aI229
X-Gm-Gg: ASbGnctI+Woj49SEE5QAJDFr73SaK6HK92eXF3MjDHjcPzwgHBKP0b8RQ0UQYPGREyQ
	jNZ3HqJCon7I/kujDUAbg0kqvsIlcfKVhKJ5QFOYbEe+PfFWx6Ry66AWy7aGGrnjCrUglVzULdu
	rZesHniSB76BGVioDvR/9ekYwBkBJWwFXX+SxwdrLwssXAbGutMTzugLs89bKufqQytniXIjwl/
	gNHkOzzjAXOUVukHX3q3+3DSAZSR4kOwRg0g9DQ4C6EYgGTOEpy6M81uZmBC5Tl/+XX0hm034fB
	TFaQYNGIugoMcGLuo/5QG3cO62hDuge2zosj6Mzwe8IDb5Gb0slP9KA131ZrbyguiRJYiqhftSh
	n7Gzw/Fu94Pbb9V4=
X-Google-Smtp-Source: AGHT+IEUxKV8nLC5lnK8nYHQXm9WZkHCSFe1sGSjebI/QVF6TFfUnBgfLJqH1cBVHM8S7NujHb80vQ==
X-Received: by 2002:a05:6a21:329b:b0:1f5:8f7f:8f19 with SMTP id adf61e73a8af0-216218b8d82mr14117627637.10.1747669078724;
        Mon, 19 May 2025 08:37:58 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a45ccsm6328516a12.76.2025.05.19.08.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 08:37:58 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: richardcochran@gmail.com,
	andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	yangbo.lu@nxp.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] ptp: remove ptp->n_vclocks check logic in ptp_vclock_in_use()
Date: Tue, 20 May 2025 00:37:35 +0900
Message-ID: <20250519153735.66940-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no disagreement that we should check both ptp->is_virtual_clock
and ptp->n_vclocks to check if the ptp virtual clock is in use.

However, when we acquire ptp->n_vclocks_mux to read ptp->n_vclocks in
ptp_vclock_in_use(), we observe a recursive lock in the call trace
starting from n_vclocks_store().

============================================
WARNING: possible recursive locking detected
6.15.0-rc6 #1 Not tainted
--------------------------------------------
syz.0.1540/13807 is trying to acquire lock:
ffff888035a24868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at:
 ptp_vclock_in_use drivers/ptp/ptp_private.h:103 [inline]
ffff888035a24868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at:
 ptp_clock_unregister+0x21/0x250 drivers/ptp/ptp_clock.c:415

but task is already holding lock:
ffff888030704868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at:
 n_vclocks_store+0xf1/0x6d0 drivers/ptp/ptp_sysfs.c:215

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&ptp->n_vclocks_mux);
  lock(&ptp->n_vclocks_mux);

 *** DEADLOCK ***
....
============================================

The best way to solve this is to remove the logic that checks
ptp->n_vclocks in ptp_vclock_in_use().

The reason why this is appropriate is that any path that uses
ptp->n_vclocks must unconditionally check if ptp->n_vclocks is greater
than 0 before unregistering vclocks, and all functions are already
written this way. And in the function that uses ptp->n_vclocks, we
already get ptp->n_vclocks_mux before unregistering vclocks.

Therefore, we need to remove the redundant check for ptp->n_vclocks in
ptp_vclock_in_use() to prevent recursive locking.

Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/ptp/ptp_clock.c   |  3 +--
 drivers/ptp/ptp_private.h | 12 +-----------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 35a5994bf64f..0ae9f074fc52 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -412,9 +412,8 @@ static int unregister_vclock(struct device *dev, void *data)
 
 int ptp_clock_unregister(struct ptp_clock *ptp)
 {
-	if (ptp_vclock_in_use(ptp)) {
+	if (ptp_vclock_in_use(ptp))
 		device_for_each_child(&ptp->dev, NULL, unregister_vclock);
-	}
 
 	ptp->defunct = 1;
 	wake_up_interruptible(&ptp->tsev_wq);
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 18934e28469e..528d86a33f37 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -98,17 +98,7 @@ static inline int queue_cnt(const struct timestamp_event_queue *q)
 /* Check if ptp virtual clock is in use */
 static inline bool ptp_vclock_in_use(struct ptp_clock *ptp)
 {
-	bool in_use = false;
-
-	if (mutex_lock_interruptible(&ptp->n_vclocks_mux))
-		return true;
-
-	if (!ptp->is_virtual_clock && ptp->n_vclocks)
-		in_use = true;
-
-	mutex_unlock(&ptp->n_vclocks_mux);
-
-	return in_use;
+	return !ptp->is_virtual_clock;
 }
 
 /* Check if ptp clock shall be free running */
--

