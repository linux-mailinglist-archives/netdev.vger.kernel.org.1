Return-Path: <netdev+bounces-143146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161C99C1434
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 03:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA769284D7D
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 02:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D25175D5E;
	Fri,  8 Nov 2024 02:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="HLproQll"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3F012C544
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 02:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731033580; cv=none; b=sGVtSWJzgsXckdqJ+VoVbUnkUj8ZKSfndDTIzLZPrTVWVzsk9pZ+0etn0VDB8xgAAPS9fNTaJwo8VSim0bZRLUZsGU1u07ku1/8flofVodviScNEd9e9eMBjmzsq4macuL7AWsCdpCINR+e9hCPqOF1XpdgjzUUt290sq5M5pa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731033580; c=relaxed/simple;
	bh=qdi7EZQuEEMN3wiZppPLQdX1SCk2Zw8iZ75pu39cHVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dWkDbLAN7AHxR6sxYut8gP9wUrwvkYrcV7N79+l1I6gddQFOC/tgSM6xMBYEsjKxH5I3sDZvqDZtFWONunnMR/vxsoKhwJnKiDo9bDt4gF610ir9Pid0LXG3ZSiluVcuUFCkttyeN5eANefn0vbx2YwPnB7vkAb4/1PwG76i7h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=HLproQll; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-720d5ada03cso1590495b3a.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 18:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731033578; x=1731638378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caqFJ5c+kF6pXY5SxWq1Dvuvko4/3vnOEXbPCOsfprg=;
        b=HLproQllcGl8hh5zN9vO0gcwcTweUKga9ddc5Qx1JqJn1mO0FPeIffK8Qa4szdOlKe
         vLH6iNb7Jjj7tgi8aWC2zAih2Gt8Eq2Pa6RjbWa63S+gcyNCTbnUXKvyjXB+mCXQtbUA
         7wC9Cq6hJV527pZuMD0cX1WgA+YSIdF3XzUYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731033578; x=1731638378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caqFJ5c+kF6pXY5SxWq1Dvuvko4/3vnOEXbPCOsfprg=;
        b=cZ9V14qXiVzabuvZjF4cUkUK2YfqutU3k2CDhjehDDLLHWm1/rw4hCn38BFZdxwM4O
         Odk7dvRsNR+MDYctszBhiipUA1qHWqkES/TNsuRrddf8iyJsawp/WIGPThFgRVzdHLdj
         I2WuUoX6uRue8qL6+B9iLUgWFneRqCz1jknDSyubN8bNoqChkxm016BrRY4vmy0Y7ffG
         Z5aQK2vR8Rq2mSpNvWUT9j6eC1EP5Ef5+WPKSaYXCFwr7K2LdiNJJIdhGfSXt3V27Ktr
         oK0pk4eMY7iM6XJnr86ZAH3ivQI1rA/evwld9Ca0yC77BwucguFc8e4J0JJeGQ8dUOW8
         Zbnw==
X-Gm-Message-State: AOJu0YzseEJAlAYi+yDTmnsAXh3lZP3Qq6Yh2tGJUat2WUFyot80FUrz
	DQuGeVXAB17Sb44tVQNsozJAaXxvDPLwHvmdBM01/8aHfQlFdfj63Tqyy41qMhQpWXpW67gepmg
	aZzzjloj9KDjqg8+IdP3AbPvJXPr7hXlw9qABa+ZxfnOannqBvcum28C8NGXM28U9jHfjle6RLB
	mX7ub9OkRpynKk4yP+7tt6Hbu12I1XlEAabY8=
X-Google-Smtp-Source: AGHT+IHlFfbm0Pmfbo0flkKxCD1GouwjzrjeY1kIQiwWltEO4U94IT6WQ5s5XJWqpCXOwa6ta+3bbA==
X-Received: by 2002:a05:6a00:2a0e:b0:71e:8023:c718 with SMTP id d2e1a72fcca58-7241328f296mr1946828b3a.8.1731033577717;
        Thu, 07 Nov 2024 18:39:37 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a403fsm2561208b3a.105.2024.11.07.18.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 18:39:37 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: corbet@lwn.net,
	hdanton@sina.com,
	bagasdotme@gmail.com,
	pabeni@redhat.com,
	namangulati@google.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
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
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v7 2/6] net: Add control functions for irq suspension
Date: Fri,  8 Nov 2024 02:38:58 +0000
Message-Id: <20241108023912.98416-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241108023912.98416-1-jdamato@fastly.com>
References: <20241108023912.98416-1-jdamato@fastly.com>
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

The napi_resume_irqs routine effectively cancels irq suspension by
forcing the napi to be scheduled immediately.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 v7:
  - This is now patch 2 instead of patch 3; patch 2 from v6 was dropped.

 v1 -> v2:
   - Added a comment to napi_resume_irqs.

 include/net/busy_poll.h |  3 +++
 net/core/dev.c          | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index f03040baaefd..c858270141bc 100644
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
index 4d910872963f..81f5e4175a6a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6507,6 +6507,45 @@ void napi_busy_loop(unsigned int napi_id,
 }
 EXPORT_SYMBOL(napi_busy_loop);
 
+void napi_suspend_irqs(unsigned int napi_id)
+{
+	struct napi_struct *napi;
+
+	rcu_read_lock();
+	napi = napi_by_id(napi_id);
+	if (napi) {
+		unsigned long timeout = napi_get_irq_suspend_timeout(napi);
+
+		if (timeout)
+			hrtimer_start(&napi->timer, ns_to_ktime(timeout),
+				      HRTIMER_MODE_REL_PINNED);
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
+		/* If irq_suspend_timeout is set to 0 between the call to
+		 * napi_suspend_irqs and now, the original value still
+		 * determines the safety timeout as intended and napi_watchdog
+		 * will resume irq processing.
+		 */
+		if (napi_get_irq_suspend_timeout(napi)) {
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
 
 static void __napi_hash_add_with_id(struct napi_struct *napi,
-- 
2.25.1


