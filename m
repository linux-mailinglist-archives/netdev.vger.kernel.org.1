Return-Path: <netdev+bounces-208327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE36B0AFF0
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 14:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26F41AA0BE5
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 12:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4654F222566;
	Sat, 19 Jul 2025 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxCigReU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B132179CD;
	Sat, 19 Jul 2025 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752928848; cv=none; b=oWa/63gNYBvBFeU1F8HdB98jvrAJMqfhokmeiZUHsJjcEA0jM9VVVhI/2IDOOTy8TDk0xsEACfN0purlN82LziDlpw3XvIrEpNiAY09aDbdk6z2WetngoQ8sODPUra2jh330ejzmUC0WGXRxJlPZ3ZZB3kld9w/9TunNsADGLZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752928848; c=relaxed/simple;
	bh=POOKiELi+GdlAqJjsQHw6ZyuOJyr7R8My1xl6e7qJ0g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lk7Gsk27BsbodnHil4U6C17XDJned4YmGOC8p/sdK8+EV5ARv2EaP0b2u/SI5hvkNqU/eLUImYRFcrSjTXYs/4EVPWVlA96Flwu+2ItCmPlCQar37lkG9NlJ+syih3oP9At1+TiaK7NcQKHxu4RE+vNtTFJsX3YtLa+w6GuCeSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxCigReU; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b271f3ae786so2184101a12.3;
        Sat, 19 Jul 2025 05:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752928846; x=1753533646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BQfdgdkRBWe5TVjNpBGDG5q7sQM2q/hqv2mJrxoFnZQ=;
        b=BxCigReUdN7dIgRQJVxIvS20L1G2XAnlpkCpFOv32hIV0hKqttOYdZAafsjuEAhoGo
         lOmmsmT8V7iSt/VBrX5vAJYClS5NTlvsbJMmEiLK0atWHMZJ6H5OmUJ+tmLZyUuPgXuR
         mnxrJoSmNw2ajVC1sVwxUmOWbEs4Gk7THt6L/0AdoDOmSyUM/qhB6lwiTkXJTDt5LdgE
         MSpDOLw7MsdlUwLtWBNyKpX7Z666Apuno+J43GnSYinNczOCak1DX5T3gEsjxyE+U2ri
         64q7AZwmccke8G1DfF4+0YinFbk1hUA4JIrYVcit34HYYO/nHNvNsBvo23qy1N3gjnau
         WxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752928846; x=1753533646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQfdgdkRBWe5TVjNpBGDG5q7sQM2q/hqv2mJrxoFnZQ=;
        b=HsiH5spRHQrVRSYwss55q411W7jGAyZ9Ai7YzoS+Gx0xY56BMYwsC5NxDwM0ua8dRi
         h6maybw4UWO3YmcHH7qrkPKi1Nr+qqPmrfaNPRRGwc/Fk47pVzjcvJH0hsuiIz6Bkf0z
         8swyI4NYJyCONaqybnXPLAt2+bM0fqtfdDRH6vbsoIAaed5kJJd4PHvDJA8b1J3v4qmL
         uF7uWBrMypNFVouYRP9JSOLvuX7mwGNAKz8W+6yylw6UewPkP9wPDhBZIkp4QcjsJjbV
         0oxRMgwwApVAu8WSRsdsRg/GMReAwVnAELzIydF6Gf2t3Ycgpn9TPa9SbzUW30OEtHLh
         hBVw==
X-Forwarded-Encrypted: i=1; AJvYcCVd0qciO5fg1sqRO3uHCTz+nd/fMZy67kACzVGSnJUdSMXQu791RdbN29PPjVVsZX6jOzCAc1LotVxxmTM=@vger.kernel.org, AJvYcCWZmfSMyJ/trXG+eT2YQ3KlDxndHuVDBUHrOY2H1m7aYNYRjKkCOTDYandTzMwHnEsLyhR4FEwn@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzq6dIqT3Y7RMSl+1B7Y7XNv1OyLAB6Csx7GDz7NCaufO+sRVU
	BkurK/XzYFFVAsOig8zCB4fYJyVNeRrldDTzatHfW4uiSIonpZOGg5Jg
X-Gm-Gg: ASbGnctw0gHmgdFpR2A2hG98o7yN3P7RGWau9WwIcGRsFJGOBje9r2ffGD+fOp5XxLm
	Mc0Mrspd+o5+B4JwUbG5CLvBykpReq2qUzkB0P9/xpwcVOSnxn3y7fSuIwD6r+6nF56/dgVut2y
	QSTtIwMcpOtnR89A+9c99ahy8NicES/jmdDqOQQI/o9AZRki6kYHHdwZcY0BcdvwBuTyNLZoUQH
	zdCNjRB+L+TL0mdQyvHHGlkW9du+ogGY6pJu9RqpC4bUuWCSGZCK1NmsS+oMYbXT6dRNfRU7Xo8
	oX058Zcz6qBnhrXDQsL4IdwvH82jVH1p0XbHpwJvvVIj1b1OONIm9p3WqGNOaIemNJM+Ly7ODft
	ULlBgbUWW1D45nGbt0cNAtGSm00guA3Y+emhFCbJslOfh7GzcIQ==
X-Google-Smtp-Source: AGHT+IGJLabOuao1TExGeMbmwrpLcuQArmlji57Wwb1no1QTxnH0aii27+o4KkJ3Xa0K2e34n4iFGw==
X-Received: by 2002:a17:90b:5289:b0:315:af43:12ee with SMTP id 98e67ed59e1d1-31c9e761501mr23718931a91.16.1752928845850;
        Sat, 19 Jul 2025 05:40:45 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3f44970sm2985883a91.39.2025.07.19.05.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 05:40:44 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: richardcochran@gmail.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yangbo.lu@nxp.com,
	vladimir.oltean@nxp.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net v3] ptp: prevent possible ABBA deadlock in ptp_clock_freerun()
Date: Sat, 19 Jul 2025 21:40:22 +0900
Message-Id: <20250719124022.1536524-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported the following ABBA deadlock:

       CPU0                           CPU1
       ----                           ----
  n_vclocks_store()
    lock(&ptp->n_vclocks_mux) [1]
        (physical clock)
                                     pc_clock_adjtime()
                                       lock(&clk->rwsem) [2]
                                        (physical clock)
                                       ...
                                       ptp_clock_freerun()
                                         ptp_vclock_in_use()
                                           lock(&ptp->n_vclocks_mux) [3]
                                              (physical clock)
    ptp_clock_unregister()
      posix_clock_unregister()
        lock(&clk->rwsem) [4]
          (virtual clock)

Functions like clock_adjtime() can only be called with physical clocks.
Therefore, all structures used in this function are physical clocks.

However, when unregistering vclocks in n_vclocks_store(),
ptp->n_vclocks_mux is a physical clock lock, but clk->rwsem of
ptp_clock_unregister() called through device_for_each_child_reverse()
is a virtual clock lock.

Therefore, clk->rwsem used in CPU0 and clk->rwsem used in CPU1 are
different locks, but in lockdep, a false positive occurs because the
possibility of deadlock is determined through lock-class.

Therefore, to prevent such false positive in lockdep, a subclass
annotation must be added to the lock used in the virtual clock structure.

Reported-by: syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7cfb66a237c4a5fb22ad
Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
v3: Annotate lock subclass to prevent false positives of lockdep
- Link to v2: https://lore.kernel.org/all/20250718114958.1473199-1-aha310510@gmail.com/
v2: Add CC Vladimir
- Link to v1: https://lore.kernel.org/all/20250705145031.140571-1-aha310510@gmail.com/
---
 drivers/ptp/ptp_private.h |  5 +++++
 drivers/ptp/ptp_vclock.c  | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index a6aad743c282..b352df4cd3f9 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -24,6 +24,11 @@
 #define PTP_DEFAULT_MAX_VCLOCKS 20
 #define PTP_MAX_CHANNELS 2048
 
+enum {
+	PTP_LOCK_PHYSICAL = 0,
+	PTP_LOCK_VIRTUAL,
+};
+
 struct timestamp_event_queue {
 	struct ptp_extts_event buf[PTP_MAX_TIMESTAMPS];
 	int head;
diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
index 7febfdcbde8b..b16c66c254ae 100644
--- a/drivers/ptp/ptp_vclock.c
+++ b/drivers/ptp/ptp_vclock.c
@@ -154,6 +154,20 @@ static long ptp_vclock_refresh(struct ptp_clock_info *ptp)
 	return PTP_VCLOCK_REFRESH_INTERVAL;
 }
 
+#ifdef CONFIG_LOCKDEP
+static void ptp_vclock_set_subclass(struct ptp_clock *ptp)
+{
+	lockdep_set_subclass(&ptp->n_vclocks_mux, PTP_LOCK_VIRTUAL);
+	lockdep_set_subclass(&ptp->clock.rwsem, PTP_LOCK_VIRTUAL);
+	lockdep_set_subclass(&ptp->tsevqs_lock, PTP_LOCK_VIRTUAL);
+	lockdep_set_subclass(&ptp->pincfg_mux, PTP_LOCK_VIRTUAL);
+}
+#else
+static void ptp_vclock_set_subclass(struct ptp_clock *ptp)
+{
+}
+#endif
+
 static const struct ptp_clock_info ptp_vclock_info = {
 	.owner		= THIS_MODULE,
 	.name		= "ptp virtual clock",
@@ -213,6 +227,8 @@ struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock)
 		return NULL;
 	}
 
+	ptp_vclock_set_subclass(vclock->clock);
+
 	timecounter_init(&vclock->tc, &vclock->cc, 0);
 	ptp_schedule_worker(vclock->clock, PTP_VCLOCK_REFRESH_INTERVAL);
 
--

