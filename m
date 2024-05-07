Return-Path: <netdev+bounces-94005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514248BDE73
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A4F1F25C7B
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 09:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FC214F9D6;
	Tue,  7 May 2024 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qn9V5A0j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DE114E2F1;
	Tue,  7 May 2024 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074539; cv=none; b=iAUEYkj4r9Wdg/6whBMmefgoSDVttfoA5gfB/K/qH9mbxC76dVOWggg0cySJKR/GhBXDEiws/zYef37nujA/szWRSMilG3M/kaGRtj1ZiaXBboUnonT9Oq5a2jAgepIJdFdH+X27Hzi2Df1QCOZZG7uHK2/lyg8NxFPYdgixykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074539; c=relaxed/simple;
	bh=+/Wzimi9IDd0AOad7JCOBMX+aJPeFaceFPRoaZUd6JQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZCWochjwwZwz9NztqWraIvMIuGg4l6idzMjg55a2fduCr/Z8Z1pg++R8NiPu+kSDJP5FZDpSJrB9qmijuq2h8K2u707NSmfl5RhXPjjFqoXgaz5XGzkaHAkgenyI97Jr3z8KKyk/vRrxCVFEA2qPRwpf5XnuCayIEZb7TqZ04Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qn9V5A0j; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2db101c11beso36565341fa.0;
        Tue, 07 May 2024 02:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074536; x=1715679336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHQ3wThlCa+tmPm7RaR+qFcrkGfD7gzEvoOA5PrmsZ8=;
        b=Qn9V5A0jesQZGCTXuVJHyqNGw/91oEXDjIgBz/SvXiZ9YgEOFnZ3GLIgWUxQi7Mkgi
         IdLpfkgpBsad/tqUYMYMscuLuqDTdvb7fdrjzWPazXJRw8/8nPYNrvq4GJKoHRzihu3p
         6GT23cNQY1Qloec5lS22UXhNQmVsQK9OIAeaz63upP/VZZg4tDalQ7glnDbRvqTCRE19
         LgNTPKaFuKycCmarguyQmGTyPMveC/07wz3cnsSV9wQ6qoxqgmO+I95gpdG+pnS3H/Ta
         1UvVfnvx7a7iGATudsuL3BwehWn+Z5ZSKMm+3ERzR1rZkLWoYTeWfRr2mUGwCRRXTBv9
         e4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074536; x=1715679336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHQ3wThlCa+tmPm7RaR+qFcrkGfD7gzEvoOA5PrmsZ8=;
        b=CXjPGBIQoCbgcXn7xVJu/XpAvOaif58H4PK87Gi+TlMk+289DJ2m2H2T8PfzgQX/jf
         MWoVyZVAozg4fQz4xO+HUf25/DnXY0nKqbu2SMCs3ehSnax+BU4kkiVeQZ9qe+lPo+8j
         ZON+W9eNMSIf4lo2ZzU1fEMfc4j5sS0KT9pEnQOy9mGkFV3KzBvDi+7G4Cyjd8m/FV2M
         QD7dE5nwM4AGlDdlX2KwSmkgtWFYM0HjqbqN+2jjGvFTI3hppykGFKjUZDNIcKpwyvii
         +heNTR9DFhrOCb8KsZ+mnxAo8GemcAJc+LN0vbWlajIZKC1jKaOLxM2X9MPmWSZ2Tetd
         njvg==
X-Forwarded-Encrypted: i=1; AJvYcCX1J+RbDqD9+y0rw6COw06z8VEGi5ub7/EWn1T2VMLrTIvxOZNv7rUOmg4wRnynzazsr0KYF1gpcp6nrOKVq0xCtSNO6pHdnhH/QlECOwA57LgK/crFnk7OpFUgi49tTmGg+Dzp
X-Gm-Message-State: AOJu0Yzth5zG1sWevcu579UGoEjy0q0draT/MwMZmMTrZRUU3gB6xS3W
	GJIEflqCsXSViVMphY3hFMPV769ryHnG5LsqkegdcXH/mXFd3OFz
X-Google-Smtp-Source: AGHT+IH3kyXVRJ4PLiuJO5l/3kxoCLnD2cm+0pheedS9Aj4zvXVnedQGHMETTqwaLGYpsfRGaYHCpA==
X-Received: by 2002:a2e:9585:0:b0:2df:b800:5bff with SMTP id w5-20020a2e9585000000b002dfb8005bffmr8142337ljh.7.1715074536291;
        Tue, 07 May 2024 02:35:36 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:35 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Yan Zhai <yan@cloudflare.com>,
	netdev@vger.kernel.org
Subject: [PATCH 03/48] rcu: Add lockdep checks and kernel-doc header to rcu_softirq_qs()
Date: Tue,  7 May 2024 11:34:45 +0200
Message-Id: <20240507093530.3043-4-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507093530.3043-1-urezki@gmail.com>
References: <20240507093530.3043-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

There is some indications that rcu_softirq_qs() might be more generally
used than anticipated.  This commit therefore adds some lockdep assertions
and some cautionary tales in a new kernel-doc header.

Link: https://lore.kernel.org/all/Zd4DXTyCf17lcTfq@debian.debian/

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Yan Zhai <yan@cloudflare.com>
Cc: <netdev@vger.kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d9642dd06c25..2795a1457acf 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -240,8 +240,36 @@ static long rcu_get_n_cbs_cpu(int cpu)
 	return 0;
 }
 
+/**
+ * rcu_softirq_qs - Provide a set of RCU quiescent states in softirq processing
+ *
+ * Mark a quiescent state for RCU, Tasks RCU, and Tasks Trace RCU.
+ * This is a special-purpose function to be used in the softirq
+ * infrastructure and perhaps the occasional long-running softirq
+ * handler.
+ *
+ * Note that from RCU's viewpoint, a call to rcu_softirq_qs() is
+ * equivalent to momentarily completely enabling preemption.  For
+ * example, given this code::
+ *
+ *	local_bh_disable();
+ *	do_something();
+ *	rcu_softirq_qs();  // A
+ *	do_something_else();
+ *	local_bh_enable();  // B
+ *
+ * A call to synchronize_rcu() that began concurrently with the
+ * call to do_something() would be guaranteed to wait only until
+ * execution reached statement A.  Without that rcu_softirq_qs(),
+ * that same synchronize_rcu() would instead be guaranteed to wait
+ * until execution reached statement B.
+ */
 void rcu_softirq_qs(void)
 {
+	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
+			 lock_is_held(&rcu_lock_map) ||
+			 lock_is_held(&rcu_sched_lock_map),
+			 "Illegal rcu_softirq_qs() in RCU read-side critical section");
 	rcu_qs();
 	rcu_preempt_deferred_qs(current);
 	rcu_tasks_qs(current, false);
-- 
2.39.2


