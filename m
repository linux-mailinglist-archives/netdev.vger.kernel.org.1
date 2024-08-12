Return-Path: <netdev+bounces-117740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF4394F0EF
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE9E282063
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B3C18455D;
	Mon, 12 Aug 2024 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="I5kQnO0q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974A118454A
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474629; cv=none; b=YYAymTV0LovHKeAph2RiaZTJIuOorlxNFFfTm2jLLTf8M7dXEivwUROGHs4zzNExNMhg9p/ZUOGT9F5Aah8jLjBmkBl64mcQGHWLy7hJNI2SVLlfxVYO3Q1XrZN8KfeF/n/rSi3arz9ThHjQucr+97YEz+jQIuatk1mUDBFa6Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474629; c=relaxed/simple;
	bh=OtbThwHzrLrDJ6N9iYZP2xMzyRCuIQDSqBSKqkos4uU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=StGVDrqCk5/FkuRHOvf1tnhcNlydsROqLVhmLXBK6Wi2XJnyT/PVecVz3EPlYzUbCOSOfU9rFb1p/TY8Zmo6LGeEDlnE8dx9yjzUKr1wTYBi2lhRNOZjj5MPMMiFdDQNUH6FgoCigV562EPWaggcSkeMxFIk+nsCgJVRx0i/2Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=I5kQnO0q; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7a0b2924e52so2129039a12.2
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 07:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723474626; x=1724079426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2QGcPk3A8tZFSKtHIPQmg9Fxaym0vKQef3yjN2SS5E=;
        b=I5kQnO0q9t1WdsqNw/jMjMOnGt+ttsRx1yfVW7JzuJo11gtOrC2c3cOIHotcaGff3g
         b/8oTXvXWdn/lpaJPZlsOTU5x6vR0mUbyrjoxfFCCxgTt6ZZt1bSihBZ+htbwPLdFjzD
         eX5GZ8m1i8dkaixV+gK998sudjnB58IFdP73w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723474626; x=1724079426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2QGcPk3A8tZFSKtHIPQmg9Fxaym0vKQef3yjN2SS5E=;
        b=AXOP7fSa3TanciCkw+buRWRBDnebQecFerrxnD4hmA+vdGStLO83mg6/sdda42MULn
         dbaJ1AFYxpBP494muwyGbmnzyFRK+vZlY9hRhDy8Cr0zIstMy85dPrJVDEvuLtG6VxXB
         mF04PFCPbNz0Xb4yMurlNmr4KvcMUgmDd1FOGLHoY5TQQP6+eFNYnkUKreWPsFB1vD0D
         nd8cSc1A58jqmlrIrC/kN20e9F+/+a5guzMLQrOUJ4SWlZ257dmWuMhl2t7umyw4KnQV
         K20mOe18n7BxXmImtv+/0Zg2Kb5F/Rpot6xFWDtm1SQ0YGUVmgY7yHVy8r0ihwYClSxW
         I73w==
X-Gm-Message-State: AOJu0YwnBlEoD6dZG3ptBKaTeqm2ABhdWzl3jNijbQqUFnqXN42vaSGK
	gRM6Ix/Lk5+q3ZTVTcTqMJsq86kq6XBVt7clzB5RYJGG9Uej6szZ0uijJvpMJLtPlU+zZRwaVx6
	aKonTY0LEKRmS4HcEVw7gZnsjXWvBolL4oFN+Cjibm+8A9OQaE5b4HgQG2INYhJZb5WtwLpIoiA
	os3yCNtyE90m2BM/4cFQweEzZrvL5e6RFkMnwqRw==
X-Google-Smtp-Source: AGHT+IH/Va6oFceymPtFVikZ4XT7EW9N4zXQhzcHxdCn7/yQShCgpfo1zip9Na9QsbzCb+pTwYHNwg==
X-Received: by 2002:a17:902:ec91:b0:1fd:9c2d:2f1b with SMTP id d9443c01a7336-201ca1cb0d8mr5835315ad.52.1723474626441;
        Mon, 12 Aug 2024 07:57:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb8fd835sm39006955ad.89.2024.08.12.07.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 07:57:06 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 1/6] netdevice: Add napi_affinity_no_change
Date: Mon, 12 Aug 2024 14:56:22 +0000
Message-Id: <20240812145633.52911-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240812145633.52911-1-jdamato@fastly.com>
References: <20240812145633.52911-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several drivers have their own, very similar, implementations of
determining if IRQ affinity has changed. Create napi_affinity_no_change
to centralize this logic in the core.

This will be used in following commits for various drivers to eliminate
duplicated code.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 include/linux/netdevice.h |  8 ++++++++
 net/core/dev.c            | 14 ++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0ef3eaa23f4b..dc714a04b90a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -464,6 +464,14 @@ enum rx_handler_result {
 typedef enum rx_handler_result rx_handler_result_t;
 typedef rx_handler_result_t rx_handler_func_t(struct sk_buff **pskb);
 
+/**
+ * napi_affinity_no_change - determine if CPU affinity changed
+ * @irq: the IRQ whose affinity may have changed
+ *
+ * Return true if the CPU affinity has NOT changed, false otherwise.
+ */
+bool napi_affinity_no_change(unsigned int irq);
+
 void __napi_schedule(struct napi_struct *n);
 void __napi_schedule_irqoff(struct napi_struct *n);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 751d9b70e6ad..9c56ad49490c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -89,6 +89,7 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/if_ether.h>
+#include <linux/irq.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
@@ -6210,6 +6211,19 @@ void __napi_schedule_irqoff(struct napi_struct *n)
 }
 EXPORT_SYMBOL(__napi_schedule_irqoff);
 
+bool napi_affinity_no_change(unsigned int irq)
+{
+	int cpu_curr = smp_processor_id();
+	const struct cpumask *aff_mask;
+
+	aff_mask = irq_get_effective_affinity_mask(irq);
+	if (unlikely(!aff_mask))
+		return true;
+
+	return cpumask_test_cpu(cpu_curr, aff_mask);
+}
+EXPORT_SYMBOL(napi_affinity_no_change);
+
 bool napi_complete_done(struct napi_struct *n, int work_done)
 {
 	unsigned long flags, val, new, timeout = 0;
-- 
2.25.1


