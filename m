Return-Path: <netdev+bounces-121460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A93895D44D
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4EFD2860B6
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 17:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45561925A9;
	Fri, 23 Aug 2024 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="fmUkKKLa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29894192590
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434315; cv=none; b=lUeMWDpy3MxGGHT0oEm0CkapHpVSAyGoZFNUkYdHX2K4nXDGQSV4ZIRdMbTyBIiy8QhBsTeeJgseRPfV3Ji/N+cguXx5UGhPV+IfsVZs/hlDNS3mvUwPj0Sss8/ESTZxAsOdcPEodVyEeWMZj8hO7qbwkyozGin6W1uIIiPodCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434315; c=relaxed/simple;
	bh=uX0QibKij4hrx1iInrriZkBV1gHHT5oaikcEGlUnPwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kpwhlHKX1HADOxQtuactYTX9c07WucL+gr5K3EqAryfBSd7B24fHHupfuZ3W8QfVWSfvzk7B29POjKnAHaGF/7JwFEpZZLgfGuzCz0HDJX5h+Y4Wl5E7cAfVVgQ5fMylujrbbmiUue5omK5U6hizJCWLNBOqTL15t+u5xqf+9fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=fmUkKKLa; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7143ae1b560so1227212b3a.1
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 10:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724434313; x=1725039113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJ3Cgz7lMCJbNt90o7mMTqlTtQDLxW3serLqcE11Oz0=;
        b=fmUkKKLa76VtyrMJONnBCmzjy//kBey/QIPGFSQtVVxllYqvb/oHS7YjGFFJ7j42/6
         sF3daiBLlJ45dwelvD7Z1CZ0DUw8W2MsXzA1/DgcmI6rID1rDlHYwQk4aqt1sELaX1pv
         HQctLfsGX9Xak7VN0hbLOwa3jL2lqyfhfahpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724434313; x=1725039113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJ3Cgz7lMCJbNt90o7mMTqlTtQDLxW3serLqcE11Oz0=;
        b=c2LIgVkyBYIgXBR/Gm30RBRQiw4miOBkw+cfHZVtW3ZViKmVVLr+hero/rJi36jlck
         pNY2jE44N5OdONVJ7WWK33ID9N4qyXrYUKNJ3rmxtIFAT9/10sdxS7es41vqfTxD2/mD
         eYDmaTf77z0YOg3xci7plU4CYQQcGZssctnMlllk928jyOwPFmyoXsG5nZybg4vx6N0a
         RsB5Mk1xgU76y0lwZIQVTWJIGxukX6s9sKL3/Te2jV8yZBr6KuhymNJL0uPDvr2LnZ4Y
         Bp0mfb2glxmn2RpB7jtPhrq54vy5xdXCP7nNXhon9WRw4tKFf6MXfGB6tlmAsii4hU53
         nQqQ==
X-Gm-Message-State: AOJu0YxPo1LxZqDJKy+2vnkfAD8qScogEC5ZwAMits4aiSs+pV1eBorv
	APR7QKrNEWKE9l2mp1b5EBn4xyhqYzyvevjcW5GGxj+Q/u36J1EF55dmdgV0nJvkeCQ+C/Aj8/0
	XRh+bg9pmxW1GKUAvUorRkI5amWp4BS49stdpMvALhcpLsh/Cz6OPlQLSEkD9Hidd6t9qXnAN6p
	sWp75MpyU0D50NNLzSy3tAhqp75pMyc7DAyNH07g==
X-Google-Smtp-Source: AGHT+IFlAQEc9KoqTiJ+uenwue8nngt9FosFsk1pBy96LJQu6gg7G2mzoKPb7tyMW3FTcjllOcQq/w==
X-Received: by 2002:a05:6a00:9443:b0:706:6962:4b65 with SMTP id d2e1a72fcca58-714457d3788mr3219030b3a.14.1724434312772;
        Fri, 23 Aug 2024 10:31:52 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430964fsm3279624b3a.150.2024.08.23.10.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 10:31:52 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	peter@typeblog.net,
	m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 3/6] net: Add control functions for irq suspension
Date: Fri, 23 Aug 2024 17:30:54 +0000
Message-Id: <20240823173103.94978-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823173103.94978-1-jdamato@fastly.com>
References: <20240823173103.94978-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

The napi_suspend_irqs routine bootstraps irq suspension by elongating
the defer timeout to irq_suspend_timeout.

The napi_resume_irqs routine effectly cancels irq suspension by forcing
the napi to be scheduled immediately.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 include/net/busy_poll.h |  3 +++
 net/core/dev.c          | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index 9b09acac538e..f095b2bdeee1 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -52,6 +52,9 @@ void napi_busy_loop_rcu(unsigned int napi_id,
 			bool (*loop_end)(void *, unsigned long),
 			void *loop_end_arg, bool prefer_busy_poll, u16 budget);
 
+void napi_suspend_irqs(unsigned int napi_id);
+void napi_resume_irqs(unsigned int napi_id);
+
 #else /* CONFIG_NET_RX_BUSY_POLL */
 static inline unsigned long net_busy_loop_on(void)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index 74060ba866d4..4de0dfc86e21 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6507,6 +6507,39 @@ void napi_busy_loop(unsigned int napi_id,
 }
 EXPORT_SYMBOL(napi_busy_loop);
 
+void napi_suspend_irqs(unsigned int napi_id)
+{
+	struct napi_struct *napi;
+
+	rcu_read_lock();
+	napi = napi_by_id(napi_id);
+	if (napi) {
+		unsigned long timeout = READ_ONCE(napi->dev->irq_suspend_timeout);
+
+		if (timeout)
+			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(napi_suspend_irqs);
+
+void napi_resume_irqs(unsigned int napi_id)
+{
+	struct napi_struct *napi;
+
+	rcu_read_lock();
+	napi = napi_by_id(napi_id);
+	if (napi) {
+		if (READ_ONCE(napi->dev->irq_suspend_timeout)) {
+			local_bh_disable();
+			napi_schedule(napi);
+			local_bh_enable();
+		}
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(napi_resume_irqs);
+
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 static void napi_hash_add(struct napi_struct *napi)
-- 
2.25.1


