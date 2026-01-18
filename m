Return-Path: <netdev+bounces-250844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6221D39542
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 14:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70E093010AB4
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 13:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFC832B984;
	Sun, 18 Jan 2026 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rxauhs0M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8102DAFA1
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768742731; cv=none; b=pb7DOspbUL411qAxOyD9bOTeEIxaij8qdHP27r5Wiuog0CjAQqUCVUWJoDOFx3Ot3QRqk11HgcRQfVg+HAhu1+jR08BQNl8XUdpV7vbU460BdojccBKJ0KX8KT+H46Y4tX/yWOgQwipMGmJTinRmaPJtg+uuyFgE7KXpt4jBUZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768742731; c=relaxed/simple;
	bh=qebTn4ntNYLaoPbeiu5ofXuz0ebIHmgwKL5uV5X/8jY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JBzR9UiUM3SeC8j/v5/0Fy/DHRbeM2raRQlQbJWJQEiVf79i4tYjotETg2oMkZjNCA13c4jAMwNzb4jbX5UVTJLsXmX+Smhdqk/ler/9Gx8W8Y5HUCC7oSuZ/9FMIIAjjR2XFO8JkUk+IyoHOb02+KrSnOLOi/nY+Hmbisn2/d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rxauhs0M; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c538971a16so795302585a.1
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 05:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768742729; x=1769347529; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=52tYt1tQnBF8l5fx5EYUwkTRCxpz++yOhNubcV8bUHs=;
        b=Rxauhs0M2Merf9j37kxApk9ADXF2GaM2ZdSPmVfP36SfWiFziXtOhDXT6AKvLRC/UI
         87LS7rffqXAx2KoyiWlwLglOfuXUZFFH6jmKb9tjzfNb/Dk6RpAAGULTd3yLGl4l2cwH
         BXObWnAJAY0k5DlBaHZIZNR0f2lGDC/izeet+ZrIAwyw9rwp/e8EXoE/to1VJWmAER80
         361KiA6ljQjpOuiCsO2pQPRZmHS+c+QOCa94oGX6Wu+fRGKFotZgztPngqzP4lUUAYAR
         JOCizN/nSfiz0kkaweM73uK89BRDT0NKZzK9+0GrN1FVJsmXqwoucBDDJlm6YR9v3nPZ
         8sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768742729; x=1769347529;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52tYt1tQnBF8l5fx5EYUwkTRCxpz++yOhNubcV8bUHs=;
        b=UXEhKOXASe+YWAnwYfucuidH6pY/7Ocsr/ejxYVr+gYIMXP/dvnW7TZDnUN+sQ7TKP
         1CP3jN1n5PNvmEzhsnxN37+fpvSgSJCs6zqY3+QJ5ZJZclXYp7wh9dUgnw664NjTqZwI
         cIuIx2Iaz1u9qDd7+4bXHhbOIJmCIy1UGcoN8m2UyERt0K9XS+uHVJjORxBSILyws10n
         exs1TD0nJmg0vd5bemijZ/Ri4rh0rL+RnIVpUbBID0dw1fbiXNr/I9lqzsWOQuZ+3EYr
         AqJMBxTxVb+EMBz4parFjF1GJaeMQKLSn0tK5sC6jPTcmmhCPuGK1FMwOb0t0mGRV+dq
         wDgw==
X-Forwarded-Encrypted: i=1; AJvYcCVBAlSXKEzdItLcid7UusbPIA3ABohqrXmUjQFgVQ9V2w8vwnjhbsja/GnDTHv4VOjSKX/V3Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp0gjUabLPUwtY7oreIY+xWS54QN54zaglaYpbByszqtbY+Ba9
	WwIdAx0IEtnj7FID0tNHmTO8Ei3+JBiMVpES0oKgqk+eoPv2yoh10tio7EZjGxeg7krCesHhXVc
	+Wi4kaF/G2nEumg==
X-Received: from qknrl9.prod.google.com ([2002:a05:620a:9049:b0:8b2:72f9:9905])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3199:b0:8b1:5f62:a5d5 with SMTP id af79cd13be357-8c6a6789902mr1239404785a.62.1768742729157;
 Sun, 18 Jan 2026 05:25:29 -0800 (PST)
Date: Sun, 18 Jan 2026 13:25:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260118132528.2349573-1-edumazet@google.com>
Subject: [PATCH net] mISDN: annotate data-race around dev->work
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

dev->work can re read locklessly in mISDN_read()
and mISDN_poll(). Add READ_ONCE()/WRITE_ONCE() annotations.

BUG: KCSAN: data-race in mISDN_ioctl / mISDN_read

write to 0xffff88812d848280 of 4 bytes by task 10864 on cpu 1:
  misdn_add_timer drivers/isdn/mISDN/timerdev.c:175 [inline]
  mISDN_ioctl+0x2fb/0x550 drivers/isdn/mISDN/timerdev.c:233
  vfs_ioctl fs/ioctl.c:51 [inline]
  __do_sys_ioctl fs/ioctl.c:597 [inline]
  __se_sys_ioctl+0xce/0x140 fs/ioctl.c:583
  __x64_sys_ioctl+0x43/0x50 fs/ioctl.c:583
  x64_sys_call+0x14b0/0x3000 arch/x86/include/generated/asm/syscalls_64.h:17
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xd8/0x2c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88812d848280 of 4 bytes by task 10857 on cpu 0:
  mISDN_read+0x1f2/0x470 drivers/isdn/mISDN/timerdev.c:112
  do_loop_readv_writev fs/read_write.c:847 [inline]
  vfs_readv+0x3fb/0x690 fs/read_write.c:1020
  do_readv+0xe7/0x210 fs/read_write.c:1080
  __do_sys_readv fs/read_write.c:1165 [inline]
  __se_sys_readv fs/read_write.c:1162 [inline]
  __x64_sys_readv+0x45/0x50 fs/read_write.c:1162
  x64_sys_call+0x2831/0x3000 arch/x86/include/generated/asm/syscalls_64.h:20
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xd8/0x2c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000000 -> 0x00000001

Fixes: 1b2b03f8e514 ("Add mISDN core files")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/isdn/mISDN/timerdev.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/isdn/mISDN/timerdev.c b/drivers/isdn/mISDN/timerdev.c
index df98144a953946df0fc8669ae3e446d043b98155..33521c328a827311f0bf02b82e99bfd635ee4ec6 100644
--- a/drivers/isdn/mISDN/timerdev.c
+++ b/drivers/isdn/mISDN/timerdev.c
@@ -109,14 +109,14 @@ mISDN_read(struct file *filep, char __user *buf, size_t count, loff_t *off)
 		spin_unlock_irq(&dev->lock);
 		if (filep->f_flags & O_NONBLOCK)
 			return -EAGAIN;
-		wait_event_interruptible(dev->wait, (dev->work ||
+		wait_event_interruptible(dev->wait, (READ_ONCE(dev->work) ||
 						     !list_empty(list)));
 		if (signal_pending(current))
 			return -ERESTARTSYS;
 		spin_lock_irq(&dev->lock);
 	}
 	if (dev->work)
-		dev->work = 0;
+		WRITE_ONCE(dev->work, 0);
 	if (!list_empty(list)) {
 		timer = list_first_entry(list, struct mISDNtimer, list);
 		list_del(&timer->list);
@@ -141,13 +141,16 @@ mISDN_poll(struct file *filep, poll_table *wait)
 	if (*debug & DEBUG_TIMER)
 		printk(KERN_DEBUG "%s(%p, %p)\n", __func__, filep, wait);
 	if (dev) {
+		u32 work;
+
 		poll_wait(filep, &dev->wait, wait);
 		mask = 0;
-		if (dev->work || !list_empty(&dev->expired))
+		work = READ_ONCE(dev->work);
+		if (work || !list_empty(&dev->expired))
 			mask |= (EPOLLIN | EPOLLRDNORM);
 		if (*debug & DEBUG_TIMER)
 			printk(KERN_DEBUG "%s work(%d) empty(%d)\n", __func__,
-			       dev->work, list_empty(&dev->expired));
+			       work, list_empty(&dev->expired));
 	}
 	return mask;
 }
@@ -172,7 +175,7 @@ misdn_add_timer(struct mISDNtimerdev *dev, int timeout)
 	struct mISDNtimer	*timer;
 
 	if (!timeout) {
-		dev->work = 1;
+		WRITE_ONCE(dev->work, 1);
 		wake_up_interruptible(&dev->wait);
 		id = 0;
 	} else {
-- 
2.52.0.457.g6b5491de43-goog


