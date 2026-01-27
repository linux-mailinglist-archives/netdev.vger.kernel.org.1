Return-Path: <netdev+bounces-253732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ACOAyxneGnTpgEAu9opvQ
	(envelope-from <netdev+bounces-253732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:20:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 789C790B38
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D97C43004DEF
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810942D1F7C;
	Tue, 27 Jan 2026 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYUw6I9L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01993269D18
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769498408; cv=none; b=Vxgn0hoQpI+UAZ72WxfwzcPNBw3imC3yLLxsp2oTD31BuRXR7VStw59h1OYNMcTGJAck1vJ6Y3jqoONYrgJZRYLrwCoJMJRqbI96AxwML3s44DDqfpAR76qCLZ+MScclOV/WXIEG7eOv9ByDtEscCTmXWk41+bIcTG6UIDqJgr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769498408; c=relaxed/simple;
	bh=81F3rTIPutz/0pH4tf433mr/DXtLcwyzVIfphouJJyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XFVF/1OLttvsqk4VSBa3t5NC4+TUx3Gf5mWLYThPEVfWlGsZyb0U1nj0LYF5bwSf+ELr7d/PqG7WWZ0K6+huYG4BlMxHNlldjQha9KPku+3bKXy42R+KF+k1NYroGsGF0+AZaTPXdK1M6lFiRAuKjzicYEYkcihEsfuZBBA0UOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYUw6I9L; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c6c922850cso554570485a.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 23:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769498406; x=1770103206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9QEx1C/oYB7PurQl6mZb4VXQ4WDvvLW28qJrv7K/l7M=;
        b=iYUw6I9LyOSS05NWO+oYkRbPJ1ObRAQzujwp3VrnduGsaDLL/gvUX6ogWVmOgayp2M
         TRZpvMUPMpBFQDmVKUolm9b88y/cHV4foDmsO7mQuBkrCD+se/fiiMaun2o+fiQZa66K
         Kr0IuOUWWIuh8VV6qBhqbQESSuBJ+iSCNWxP2xU1/siwswDkRADdbR5al4o6NbIMb/40
         2uf1SGcOpKYgyjs7QsNhDA/hvhl+NzsdMDrV0ChkxF7auAYpAAFwRZPaJRjv+dyA5ZHE
         JDML/8piF0KwqKOIzrSasN/oh54Y3YhJmdcIE22rin9jz76IHPdoGdj63SSUUdRMV8sF
         wj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769498406; x=1770103206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QEx1C/oYB7PurQl6mZb4VXQ4WDvvLW28qJrv7K/l7M=;
        b=cjAyModBYePP6RkGTOIT7kPeTaOjHyb2sNpHwiMvSsxsxQVdn65jMPAQt/PK2ZgOPc
         qastzbjncgmDRLgkDIMisVaPIsE1c9fze8AN4CWIEo29F0Jfd0ZZjWlpTzXNwTG7KJN1
         0Ygv2X6GVUAN7nSZH6fxDxfWFZKhQf91idLCc1epnBz+p2Z0iiKOkvsW7rRj3mLy4cX1
         8pTBYbUhPijRHjNtN2hhVS6FOIxpK3WQT68KNvguqX4KY+UfSph4JG1XYU8Hsckgr4vc
         BJ+WPutWyNEdaB0F7mSIeTxTUwZKErRoSW3WcJ3YWOV5c8qvO6M9bgpDrOeDml/M8e24
         51Bw==
X-Gm-Message-State: AOJu0YzXY6Kf7U1bwwMedq9Juc6I93E07FyYepCj5tHcEXn4OrHH/5Bj
	V69jVpBeWvaRBd08TvRcHAInp+RpvBUIhAFn0SeayGEIDCZvs0Flx2gXFLbtLV42
X-Gm-Gg: AZuq6aKfcTNfGXCUq2opIejM8hMxvU5racJK6SO+LRws1U5SgZw1wZ3rvKey3DwrvCx
	QGjb7hRdRpWLQfzdWMaA6uLI7rPx62566W9zfHg8VYX63KA3D6kCob+4JJRL/67D/3lCk7JPvFP
	AzU734nVGUzEthjb91ACslud8EEr+VapoXOw3KyzUuu9MBSJfiFvLddDOQ6u3YH3Ms7u9U0ou0E
	Ppqui+H6v3J77T7QnhAkSWrLJU2TPgcxUduh2JKWRm3cukaWVgSXYsh/7eTCJ1LiAPjyTIa65su
	2Imdypiqcq0K6hMpOrtq/DxYTM/T2epaTlS+DYjmnD1y68TeRQRJp86qmgItzSYtgS4tbPZLIfS
	Pc+44r+/1tcQDhwcJyF1cIgWrx4WwgPuGlcBaMPd/Y35HadgKX9kDP9/f7/Gp48I4HfN9sDs=
X-Received: by 2002:a05:620a:1788:b0:8c3:7f27:a65d with SMTP id af79cd13be357-8c70b855dbcmr92270485a.28.1769498405679;
        Mon, 26 Jan 2026 23:20:05 -0800 (PST)
Received: from r730.. ([46.110.19.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894ac89dc43sm73935596d6.46.2026.01.26.23.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 23:20:05 -0800 (PST)
From: Henry Zhang <henryzhangjcle@gmail.com>
X-Google-Original-From: Henry Zhang <zeri@umich.edu>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	mingo@kernel.org,
	syzbot+c6e7bcea7ffb7ff46acb@syzkaller.appspotmail.com,
	Henry Zhang <zeri@umich.edu>
Subject: [PATCH net] mISDN: Fix data race in timer handling
Date: Tue, 27 Jan 2026 02:19:27 -0500
Message-Id: <20260127071927.1520272-1-zeri@umich.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-253732-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henryzhangjcle@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,c6e7bcea7ffb7ff46acb];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 789C790B38
X-Rspamd-Action: no action

KCSAN reported a data race where misdn_add_timer() writes dev->work
while mISDN_read() reads it without holding the spinlock:

write to 0xffff88812d848280 of 4 bytes by task 10864 on cpu 1:
 misdn_add_timer drivers/isdn/mISDN/timerdev.c:175 [inline]
...

read to 0xffff88812d848280 of 4 bytes by task 10857 on cpu 0:
 mISDN_read+0x1f2/0x470 drivers/isdn/mISDN/timerdev.c:112
...

dev->work is read locklessly in wait_event_interruptible() and
mISDN_poll(). In mISDN_read(), the result is rechecked under dev->lock.
In mISDN_poll(), a stale value may cause a spurious EPOLLIN or a missed
wake, but wake_up_interruptible() will correct this. In both cases, the
race is benign, so we can annotate these with READ_ONCE/WRITE_ONCE.

Reported-by: syzbot+c6e7bcea7ffb7ff46acb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c6e7bcea7ffb7ff46acb

Signed-off-by: Henry Zhang <zeri@umich.edu>
---
 drivers/isdn/mISDN/timerdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/isdn/mISDN/timerdev.c b/drivers/isdn/mISDN/timerdev.c
index df98144a9539..f98f2e0cfb9f 100644
--- a/drivers/isdn/mISDN/timerdev.c
+++ b/drivers/isdn/mISDN/timerdev.c
@@ -109,7 +109,7 @@ mISDN_read(struct file *filep, char __user *buf, size_t count, loff_t *off)
 		spin_unlock_irq(&dev->lock);
 		if (filep->f_flags & O_NONBLOCK)
 			return -EAGAIN;
-		wait_event_interruptible(dev->wait, (dev->work ||
+		wait_event_interruptible(dev->wait, (READ_ONCE(dev->work) ||
 						     !list_empty(list)));
 		if (signal_pending(current))
 			return -ERESTARTSYS;
@@ -143,11 +143,11 @@ mISDN_poll(struct file *filep, poll_table *wait)
 	if (dev) {
 		poll_wait(filep, &dev->wait, wait);
 		mask = 0;
-		if (dev->work || !list_empty(&dev->expired))
+		if (READ_ONCE(dev->work) || !list_empty(&dev->expired))
 			mask |= (EPOLLIN | EPOLLRDNORM);
 		if (*debug & DEBUG_TIMER)
 			printk(KERN_DEBUG "%s work(%d) empty(%d)\n", __func__,
-			       dev->work, list_empty(&dev->expired));
+			       READ_ONCE(dev->work), list_empty(&dev->expired));
 	}
 	return mask;
 }
@@ -172,7 +172,7 @@ misdn_add_timer(struct mISDNtimerdev *dev, int timeout)
 	struct mISDNtimer	*timer;
 
 	if (!timeout) {
-		dev->work = 1;
+		WRITE_ONCE(dev->work, 1);
 		wake_up_interruptible(&dev->wait);
 		id = 0;
 	} else {
-- 
2.34.1


