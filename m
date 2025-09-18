Return-Path: <netdev+bounces-224452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B1FB8542C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3FF3564D2E
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8621304BCD;
	Thu, 18 Sep 2025 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dFCVsyQ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D4A211499
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205526; cv=none; b=tILk8nymumOQqb5iNvXRrsyTYvz71gifjDUoQ7XmcTuQWvDf+O30H4WPw6VULxhRLWGa+OmAjcYo24Hu8l5WWwj5LnRzSaFT+PRqP26Ii06qe8cE5cGEZuj+5Tl/tgAJ/T63tuf0e0nhQ9Xi5cmVgfMC/AFP75ga0Mgu4EMA8iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205526; c=relaxed/simple;
	bh=ziqgQkaGHrvYtXodyVeshXfzhMM+GYwPqrgAIHX0zLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6ti5nx1UU1xRMwaoA5IIbt4eoCr1u/GLzB9wH3dfjFMaajz3NH/qdO1667QEP1NF74gbWjMqJ1rC33z1w3t+uj+pq3FSsh1qbkCK3LfKAmdod6ywIDrpmUzG7g9o5r3Gb8QPp3Skv44FBVjmRJbzrVS0e7Y1VEEOH4YU8/myt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dFCVsyQ1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45f2f7ae386so7623435e9.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 07:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758205523; x=1758810323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/2z7PKjfIDTx+me72zIUy7nDyqmR9j8zHqJ2HdPGwo=;
        b=dFCVsyQ1Hy6Sa64ayhK/E4by0wPXz1+XwUP6obiKZhChPQz3WFQX21WPHMMxMX/0O6
         XY5NEkn5yijqT/YhI/82j/x7IQyhWVPeXlvAnk+eSWpwAkIKl2kmBgnL0k6dHM5EqqXw
         51BmBU7lnLVyF5uD+9lWyB4DMox8FaYYJGp51KFN65YCW6z1tNt7go4P318F4fguH2qw
         sLbipMhCM43YPMXmDNp58QFAzGF+9h4iAQ0w0agginiX2atbp6zLYBpxLDlSE0uOJ1n5
         +CEQ5MjcrXSV9ovyYphtyBRWgU/8jROAD+dmySe7OqQ/bbxF8KXnEKiZIn2ZTbiTyac7
         ropw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758205523; x=1758810323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/2z7PKjfIDTx+me72zIUy7nDyqmR9j8zHqJ2HdPGwo=;
        b=UYUkLX2sGMwhs113bAm4Mpo9I6n6mkmF3GbFONELEIT3CHam69t6QCXEY9RepFFz2H
         dzaWmgm40dT3CUbv5UdIpK+651O0XGrpHbXN8oSjy3es/hZxuze6W5fKGGxc+Anj85yo
         cCBAYKEsE7BI/KArybNKZdKSx1+S5wewobroO1/RJvIDARy9j1NWSJUDB10PqFZYR8vV
         bHUjkOdRLBSJHJonHYvSiV2biTxkOUIyhPQrVOOgQjFLhDizM1KNP2M4d556+PoxjGwG
         7D0MywAIpeVnbBFNWxdVuEVzJampWjbhg51RGdubUMRNAYVQxWSnJAniiRglrTcLCToC
         SO9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTr/px83GKx1b4vC8SXaqytM/am1+iSUQIav6U65PupiUZsCjw+vZZYaYPWYgY7+hliWOMmWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWxzuSBQVJ0GOL5vGlW0SXijEQXMdiWHdKreMibWFWEBbPiFkp
	UKL4CXJ3/O374cShv/15aLXJnMjKaEbRCxFoEd00MVwq/cjrRlfx748ZysmLAgXPuVw=
X-Gm-Gg: ASbGncu7MXSRDVhJ6KlOC/J58/zg7qTTpdKvoq3I4Stewy8n6W7s6XWABIofJTTF6dt
	Balo/0VT2U2poTayU/OAGg2/NabdYIdjAlbb47CKWOontsvyLstX3CyeL8wF4yJsNu/J46+c5ru
	dfmzp7PHAdb4mQ9EBs3b23xQK1kZkE2yVNkvOxnF0vkPaS0hb/eYW7ANoa6DlUyQd3QNuwykdHC
	d2VA2ohJnxkSThvzv5BKl6G0RDnQNr2fVAwuotXl6ECTV6SW5wYxZiI+VH9+YRUpMzY6WhLXVBd
	EJmyRVHNHglKSCloccy+Zg/XbuKZnXbMHCpNkEG5zn40dwtpHTdPUtj7xAxwtyb2ASG/iZQWNBi
	3goluj7ZKMR089A1TcM83dlk+4Zs3jXxfxz9V7SzP3MJACvPS6tQpoEqmdJOUi79/
X-Google-Smtp-Source: AGHT+IEhSJK1jNYM7u0KL/Bo1ob56/ST7gf2eVu/IeqxJeH2mFdEEQ0gi779HKEHzZ+W7finsuU0ow==
X-Received: by 2002:a05:600c:3ba2:b0:45f:bef7:670b with SMTP id 5b1f17b1804b1-4658cdf6168mr26662875e9.3.1758205522890;
        Thu, 18 Sep 2025 07:25:22 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32085823sm63270675e9.0.2025.09.18.07.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:25:22 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 1/3] net: replace use of system_unbound_wq with system_dfl_wq
Date: Thu, 18 Sep 2025 16:24:25 +0200
Message-ID: <20250918142427.309519-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918142427.309519-1-marco.crivellari@suse.com>
References: <20250918142427.309519-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/macvlan.c       | 2 +-
 drivers/net/netdevsim/dev.c | 6 +++---
 net/core/link_watch.c       | 4 ++--
 net/unix/garbage.c          | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 4df991e494bd..7966545512cf 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -369,7 +369,7 @@ static void macvlan_broadcast_enqueue(struct macvlan_port *port,
 	}
 	spin_unlock(&port->bc_queue.lock);
 
-	queue_work(system_unbound_wq, &port->bc_work);
+	queue_work(system_dfl_wq, &port->bc_work);
 
 	if (err)
 		goto free_nskb;
diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 2672d071b325..95f66c1f59db 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -851,7 +851,7 @@ static void nsim_dev_trap_report_work(struct work_struct *work)
 	nsim_dev = nsim_trap_data->nsim_dev;
 
 	if (!devl_trylock(priv_to_devlink(nsim_dev))) {
-		queue_delayed_work(system_unbound_wq,
+		queue_delayed_work(system_dfl_wq,
 				   &nsim_dev->trap_data->trap_report_dw, 1);
 		return;
 	}
@@ -867,7 +867,7 @@ static void nsim_dev_trap_report_work(struct work_struct *work)
 		cond_resched();
 	}
 	devl_unlock(priv_to_devlink(nsim_dev));
-	queue_delayed_work(system_unbound_wq,
+	queue_delayed_work(system_dfl_wq,
 			   &nsim_dev->trap_data->trap_report_dw,
 			   msecs_to_jiffies(NSIM_TRAP_REPORT_INTERVAL_MS));
 }
@@ -924,7 +924,7 @@ static int nsim_dev_traps_init(struct devlink *devlink)
 
 	INIT_DELAYED_WORK(&nsim_dev->trap_data->trap_report_dw,
 			  nsim_dev_trap_report_work);
-	queue_delayed_work(system_unbound_wq,
+	queue_delayed_work(system_dfl_wq,
 			   &nsim_dev->trap_data->trap_report_dw,
 			   msecs_to_jiffies(NSIM_TRAP_REPORT_INTERVAL_MS));
 
diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index 864f3bbc3a4c..212cde35affa 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -157,9 +157,9 @@ static void linkwatch_schedule_work(int urgent)
 	 * override the existing timer.
 	 */
 	if (test_bit(LW_URGENT, &linkwatch_flags))
-		mod_delayed_work(system_unbound_wq, &linkwatch_work, 0);
+		mod_delayed_work(system_dfl_wq, &linkwatch_work, 0);
 	else
-		queue_delayed_work(system_unbound_wq, &linkwatch_work, delay);
+		queue_delayed_work(system_dfl_wq, &linkwatch_work, delay);
 }
 
 
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 01e2b9452c75..684ab03137b6 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -592,7 +592,7 @@ static DECLARE_WORK(unix_gc_work, __unix_gc);
 void unix_gc(void)
 {
 	WRITE_ONCE(gc_in_progress, true);
-	queue_work(system_unbound_wq, &unix_gc_work);
+	queue_work(system_dfl_wq, &unix_gc_work);
 }
 
 #define UNIX_INFLIGHT_TRIGGER_GC 16000
-- 
2.51.0


