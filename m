Return-Path: <netdev+bounces-239219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4E1C65EA2
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 20:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 315F0294E8
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 19:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8B233F8BF;
	Mon, 17 Nov 2025 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBW5IjnH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F035F32AAC3
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406918; cv=none; b=HHuORqv9utvtUaQNSOpxkXDprRS3OkE0PDDFp8RrFO/GY56W4h5pmwdcTm5tYcE6njKDbs6uEAeAoEM9nm3+/SRKLHYReJtTVYkEwn04qRhcSEOg9pi9DluwqvQeX1SZMcVUegRrbBpv0LUHHZ4ybvnQWfjiWccfCcbALcTwjZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406918; c=relaxed/simple;
	bh=8XYMyZUxzf2Gu/EkbhT25ijmIzyv6Q+HEDxpFUrbxvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZOesoDmsIbsu1uiybFQ59OqRFMSht+SsCf8DQR4cyLIDL+vMPyj5be6mU9cUz1WKnpyl7QLVCRoSUwtDQ2RS7dGv+ch6/pjaTFfyuFFBpCiiq+PRdhS3tBaEzemyRG0589cx2iyw4xoGLFAu0m+SxYApQoJ8gMo7Buqh4nlggxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBW5IjnH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so5113865b3a.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 11:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763406916; x=1764011716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FxBy++oAoQMduY8bXug9aUHF7Mi2DRiPPKfNcmF1Q+w=;
        b=UBW5IjnHvP7rgwE7fl33PNvEAlfa6E/3ozwNVrWigUbOhmqrBN7DiVX8wKey/ABjiK
         iI0Zf7Ovz4q76e9oI5nOifPSXf5TTzJied57fWoIvio55/DQtXdarS+shkZXvzafDnuQ
         GasTPj/htUUI3itm76hNpDsiC7MxRHh0tyMrwiV9GhAAk/zk0pCqGplFZx8+9IHqO9GY
         NqEwHlz2R7u8vLrsQID7PNHu53PYHqOXXUd6KRh8rX29Ay7Lbwjo4G5mWPKlzDCQnBqS
         6l4TP63MuSJyQDdTuhFqxCnCcQRJ7hjtnx3KdKrvWFkTYWffu1MXqnvci4o0TCJwlJuY
         hmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763406916; x=1764011716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxBy++oAoQMduY8bXug9aUHF7Mi2DRiPPKfNcmF1Q+w=;
        b=XLFUoa1RoiEujD4BRJ8yBBwyp1m3SR/V7bJRntTju57ePiUj2CAl0bFs0Pz8Gg0nFD
         X+TalzI/TuCDnk0jtNfWZf46pa+pDin5FTtk3xQOD/BtzSuYbKheoEM8DPF27qmb/xMf
         pUTcuCJkMCymSyQxXqzyqK9Yq4DSlAT57nT0zQRSN3l535itPVTMF3LdtRsHryQRvL6W
         NGzuLw99V2ElimKGHRVGdjlBHfVgSrBvjf1gPiI9k+n58Xqr4Fefg8nXHIu5sSfrdVWv
         J6WU0oXFmMNLtKKKVzfQvNQ7qZ3kwEh6MOXoegh1VbIzGJRTfX7ecK8OmXedd+yyUd/C
         jp4w==
X-Gm-Message-State: AOJu0Yw8cEWZjtDYb+W7k0v5//5ByCvwW+lbVBi4KZIygrkLiGgAD5QF
	3RSjlRGqdxHhEcGqqkS2WWzYZEzhPxsN+IsmLhVA7QQs+2PIIppGcpxc
X-Gm-Gg: ASbGncvKt1FgwUjnmeNw8oQobvZ4LFelHw7vcu+UJDlpLYJJWEU//xviamjI/rtinvN
	Ag0iolxhCq+nTwKgBFB1ppNNg2eZ6FU7lHBKyNAy8Qx3S56QvAQRxWTzDeBgg7GDukHLQLPlXFk
	pTeifruJ0gO+Ls3nXyvSoDM7Baj6sBUjUZHeuVZ54VTZW1TUwkx0MVX7lD8IgKqXF9VydcU+mBy
	P0Q4HQuApL56pR6rGdrh/9KC1WWR3Q1sA3bGalndlx514HVGwBCz6ZqVODVGUMbiL6/SFP7w76N
	YhLZY8hSyeqrfppzqgEtxtn52uIH1dh8M1az/MV7TNxG35ToTF0iNMcct7HRj3XH1XPFirIMzLQ
	CjjhTXtWvf1E/eL3IsZsB2e/PMCoKn9t7HY3VU3/ChAEsTUnGnD9PQmyAZuafOw/V/UCHGzCoZg
	pSv2wiPRdzV+7YfQ==
X-Google-Smtp-Source: AGHT+IFg9m2V8IGb7kvHuVx3MlddcQxQnC06pKFHTVSj+DnxLfz6b9fR/ZfBVQmI4UhIgu60FR0jIw==
X-Received: by 2002:a05:6a00:174c:b0:7ad:df61:e686 with SMTP id d2e1a72fcca58-7ba3bb96782mr14320319b3a.16.1763406915969;
        Mon, 17 Nov 2025 11:15:15 -0800 (PST)
Received: from localhost ([2a03:2880:ff:10::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924aea0f8sm14155354b3a.5.2025.11.17.11.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 11:15:15 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/1] bpf: Annotate rqspinlock lock acquiring functions with __must_check
Date: Mon, 17 Nov 2025 11:15:15 -0800
Message-ID: <20251117191515.2934026-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Locking a resilient queued spinlock can fail when deadlock or timeout
happen. Mark the lock acquring functions with __must_check to make sure
callers always handle the returned error.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/asm-generic/rqspinlock.h | 47 +++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 6d4244d643df..855c09435506 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -171,7 +171,7 @@ static __always_inline void release_held_lock_entry(void)
  * * -EDEADLK	- Lock acquisition failed because of AA/ABBA deadlock.
  * * -ETIMEDOUT - Lock acquisition failed because of timeout.
  */
-static __always_inline int res_spin_lock(rqspinlock_t *lock)
+static __always_inline __must_check int res_spin_lock(rqspinlock_t *lock)
 {
 	int val = 0;
 
@@ -223,27 +223,36 @@ static __always_inline void res_spin_unlock(rqspinlock_t *lock)
 #define raw_res_spin_lock_init(lock) ({ *(lock) = (rqspinlock_t){0}; })
 #endif
 
-#define raw_res_spin_lock(lock)                    \
-	({                                         \
-		int __ret;                         \
-		preempt_disable();                 \
-		__ret = res_spin_lock(lock);	   \
-		if (__ret)                         \
-			preempt_enable();          \
-		__ret;                             \
-	})
+static __always_inline __must_check int raw_res_spin_lock(rqspinlock_t *lock)
+{
+	int ret;
+
+	preempt_disable();
+	ret = res_spin_lock(lock);
+	if (ret)
+		preempt_enable();
+
+	return ret;
+}
 
 #define raw_res_spin_unlock(lock) ({ res_spin_unlock(lock); preempt_enable(); })
 
-#define raw_res_spin_lock_irqsave(lock, flags)    \
-	({                                        \
-		int __ret;                        \
-		local_irq_save(flags);            \
-		__ret = raw_res_spin_lock(lock);  \
-		if (__ret)                        \
-			local_irq_restore(flags); \
-		__ret;                            \
-	})
+static __always_inline __must_check int
+__raw_res_spin_lock_irqsave(rqspinlock_t *lock, unsigned long *flags)
+{
+	unsigned long __flags;
+	int ret;
+
+	local_irq_save(__flags);
+	ret = raw_res_spin_lock(lock);
+	if (ret)
+		local_irq_restore(__flags);
+
+	*flags = __flags;
+	return ret;
+}
+
+#define raw_res_spin_lock_irqsave(lock, flags) __raw_res_spin_lock_irqsave(lock, &flags)
 
 #define raw_res_spin_unlock_irqrestore(lock, flags) ({ raw_res_spin_unlock(lock); local_irq_restore(flags); })
 
-- 
2.47.3


