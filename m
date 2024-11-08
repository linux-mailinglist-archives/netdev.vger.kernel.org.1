Return-Path: <netdev+bounces-143186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 642DA9C15AF
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9BFC1F21964
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A551D0B9C;
	Fri,  8 Nov 2024 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CFRVWC93"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF2A1D0174
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041677; cv=none; b=SJhldp1Hd/0SzW6IKm0Z9yC5/zpsWQXMSiHIxnalk0SnoZCCNixOcJiGTYyxXjAEjyzehtA562HlQ2pa3W4WyuAEQXObMQVhnKfd+Yq82M0OsQXzbGpfRWlGzWL/vHg/WwmgOChaGVWYpf/IBH+7GufshDAP2DX1tVBdUHXz2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041677; c=relaxed/simple;
	bh=7YkKWB/VoyUXO1lGGm/ESxIvFChf/k/+Rh3/h3kzr9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H4lucStCppzFW3A2fqMpctCs24UwMkGXCe1H+8eupXWl6BRCE9NrKUBvPQaryNfYcDzcr7ptJZxwMWwR6y7cxRDT+BvR6NTxkAPGBDzceKsmTzh3P3tPL4XDyGnZPNT7LYuYreRslKQUAiGRNSu8XoBD3qVVSNvCRzgBtjP4KV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CFRVWC93; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso1354193b3a.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 20:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731041675; x=1731646475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HzDb2SxhUo/TAU2Mmq5phfYmvXMmtRzJHslebclKIo=;
        b=CFRVWC93eAI6lwZ7Abyz6Ra+KVw8dGYnifJG+rP87fbmTejuYlAICsMb7ePkBYuh/4
         MBvmFh8Mj39/8+Mf7zsHj3hzSsV4aj++bPtZYNQMetZIV1u8CF7iqspW96tnoOaGv/wt
         1vUzID7kVaeBg9/R6Q98vEK9/jqqAsCNsPlbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731041675; x=1731646475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HzDb2SxhUo/TAU2Mmq5phfYmvXMmtRzJHslebclKIo=;
        b=jn/d4L9TEn+4oJr9EWZWRMp6yif0Dlrrac/6jvFJYpQVKQ5lhnrcWGw+flZElnn/z9
         VqlOOdjiQ+G84lORlCS200Ks1vkJFcTX1aXXUKaF87gqNiEFxo6+WZF8P0Rl3Ftg3Z/D
         kPkDZFVHXm23UOwwdEhO0qvvUky2Gldr7e2ryU8QDmwXZequYU/woqcRD4F7ecTUsV51
         lTAeEyMcDU/KMSE/+gZPtFqadWpZrkykzCDQmCSZb22Xc6iA99DPkPRwBvt+suC/nkpL
         9kzzJV40QUkJZraDABAp/3eY6QrhSaLJnFHQDJAmlnKD2/GN8pj+7Z7slMxqVJ79MO+z
         2E0Q==
X-Gm-Message-State: AOJu0YxatYU1HkVLGih/cuaQjSK5tmak7cNx4i1Za1HjZgtlUfcDU7Tw
	/lWOqBf6fkzRMiku4IMvPNT86z5xS1TqNM/nsrnxgagN6ViRKmEq7P8Oteskcsu+vciX0jxcfnP
	FqnlaKOeRV8Qb/p+uvfHtbtiRZ5bfgLJGB91htHwOXS0UiFt10ju4FBxKYjapmN9PkujUNK4w9T
	xFmO/DhWZn+j3ZZHtbNDD/RTXd/irfunclzpA=
X-Google-Smtp-Source: AGHT+IEYoTYWD1MwcFzklk4B52PngXJWpvZ1zPtgDvh5khNNQq/roN1uxX9wyCPMvqH5KMcRkeoAFA==
X-Received: by 2002:a05:6a20:1591:b0:1db:e464:7b69 with SMTP id adf61e73a8af0-1dc229a402bmr2124072637.20.1731041674610;
        Thu, 07 Nov 2024 20:54:34 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7c76sm2697476b3a.48.2024.11.07.20.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 20:54:34 -0800 (PST)
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
Subject: [PATCH net-next v8 2/6] net: Add control functions for irq suspension
Date: Fri,  8 Nov 2024 04:53:24 +0000
Message-Id: <20241108045337.292905-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241108045337.292905-1-jdamato@fastly.com>
References: <20241108045337.292905-1-jdamato@fastly.com>
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
 v8:
  - Drop unneeded exports as pointed out by Jakub.

 v7:
  - This is now patch 2 instead of patch 3; patch 2 from v6 was dropped.

 v1 -> v2:
   - Added a comment to napi_resume_irqs.

 include/net/busy_poll.h |  3 +++
 net/core/dev.c          | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

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
index 4d910872963f..13d00fc10f55 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6507,6 +6507,43 @@ void napi_busy_loop(unsigned int napi_id,
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
+
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 static void __napi_hash_add_with_id(struct napi_struct *napi,
-- 
2.25.1


