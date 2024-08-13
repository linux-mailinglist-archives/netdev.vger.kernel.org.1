Return-Path: <netdev+bounces-118151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7445E950C3D
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 20:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033F81F225F9
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 18:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9301A4F2A;
	Tue, 13 Aug 2024 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nwazf42l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EC21A4F1F
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573687; cv=none; b=Qk8HZuuGK20pEOB7geMCyEKjGEy9ErK1+jwW/p2Bq3iV7XKUbSoENhEwsWXzxs+s7MvveMS7ZsrxzBIKAFalSZi+FGPAwWrcTd2Ook6Eby92L3W/2hy+wZtZyBBEEtOw4VAfp1GqUed/wjwGTprm8PEX0yvSoiruigqs4t+QPVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573687; c=relaxed/simple;
	bh=j69ckPh7E3QD6AiHqrqUQtHhaCzw1plGFQ8OeVu17UQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qFufTm1JhGNDK2WlNKi3GDZOKppDAN++MUp1zUpWd4VyVfkykwZARyfxtfG+QjGXV+xXUKJf/ag44rwCg/c6k0aPplw5m0uZV3JJzyHZpxBknm8aai0dihGzB56HOioMEi8vtN1cN83sfD+X4HSpyv9lfy4d61ukcuMRI6Lk1AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nwazf42l; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-66890dbb7b8so131011437b3.0
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 11:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723573685; x=1724178485; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TP961J72JDd3W/A5AwIhTA95rpBeW3mVlPbF5keUAfI=;
        b=nwazf42lrD42GpXfM+jnF7888q8ncFWYTMYMigAohgEzXGv4S9yAa0SXQ0eOm3P4bR
         BzO5S2StBzMBoQ+hjldsU3GyApif5J8S1m9mayupmZZEWq70wwPjlzbiQdWeO8UZhiak
         2EL9qtMAftz5I6UMFGiY4lA3ZBAl6ZzrsW7XI6AQqND8DEhuctR72AFniEq3oncViDuq
         0q/I+1LC1ijdleIBL+0c9vY9VKuFOo2lnf/JjbiEcMhoK6Zx+tPVPqO4UG/NSNzuXPvq
         XqfFcud5tH/eyIl6Hpoe7W5sY8SwIugdkoRCrDXjecapJefBwqGKa5NyDbPeuNE0D+D9
         z3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723573685; x=1724178485;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TP961J72JDd3W/A5AwIhTA95rpBeW3mVlPbF5keUAfI=;
        b=dcgNoC1fJqBcabxsZrX34RO3fwu3Kb8cQX38ulxdMCfPuJAlTlA5jqfkN3HAizsldD
         oNS928vlaPHkeaKHlzoQVeI6Iov9n6BDHPrzlqXIFuj5peTE9rfv7+8ovuh2n1UexFuA
         JNeAjrXuQnzaAsWCkSyXqPYC6WyawIt7ETEiUK5slCn4zjJjcKJrEItsYR708oQa1p4M
         jYExcrIJ6wcLq/jtIZtiAg0GHh1H9bdYcvXTCE3BCDK4IYVokab+UcoMfqPrNIXnXAkr
         3iikHDCTzxKTce0o+sLwYJQuNOqusAc/w5rcFrsykoWOqiFpPwgyfdvP4GS2gpM9M2D0
         /j8w==
X-Gm-Message-State: AOJu0YwLcSv0PFgAV+pJXdr2owAbslcW2/o7IUA9uTJzLNNuBGf5XoV9
	XuAJ973T1SMkxvMK96Ug3h4WWKw2MIAtTeqfdvR9cTjm3Z9ianh8l/y6wLpA4pa6gq0AgVZlWdq
	gH/NBFbV+DcdApOxA9w==
X-Google-Smtp-Source: AGHT+IEcUJ4nno820COmCVkqEY2grkP8CkJXPuWKQlxjBtfvY5Cd6Kury80B6+oOUU3OFR28ZBOqgQRdHfLwWACY
X-Received: from manojvishy.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a25:c5c3:0:b0:e0b:f69b:da30 with SMTP
 id 3f1490d57ef6-e1155b7c6cbmr11272276.9.1723573685319; Tue, 13 Aug 2024
 11:28:05 -0700 (PDT)
Date: Tue, 13 Aug 2024 18:27:45 +0000
In-Reply-To: <20240813182747.1770032-1-manojvishy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813182747.1770032-1-manojvishy@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813182747.1770032-4-manojvishy@google.com>
Subject: [PATCH v1 3/5] idpf: convert workqueues to unbound
From: Manoj Vishwanathan <manojvishy@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	google-lan-reviews@googlegroups.com, Marco Leogrande <leogrande@google.com>, 
	Manoj Vishwanathan <manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Marco Leogrande <leogrande@google.com>

When a workqueue is created with `WQ_UNBOUND`, its work items are
served by special worker-pools, whose host workers are not bound to
any specific CPU. In the default configuration (i.e. when
`queue_delayed_work` and friends do not specify which CPU to run the
work item on), `WQ_UNBOUND` allows the work item to be executed on any
CPU in the same node of the CPU it was enqueued on. While this
solution potentially sacrifices locality, it avoids contention with
other processes that might dominate the CPU time of the processor the
work item was scheduled on.

This is not just a theoretical problem: in b/317234476, a
misconfigured process was hogging most of the time from CPU0, leaving
less than 0.5% of its CPU time to the kworker. The IDPF workqueues
that were using the kworker on CPU0 suffered large completion delays
as a result, causing performance degradation, timeouts and eventual
system crash.

Tested:

* I have also run a manual test to gauge the performance
  improvement. The test consists of an antagonist process
  (`./stress --cpu 2`) consuming as much of CPU 0 as possible. This
  process is run under `taskset 01` to bind it to CPU0, and its
  priority is changed with `chrt -pQ 9900 10000 ${pid}` and
  `renice -n -20 ${pid}` after start.

  Then, the IDPF driver is forced to prefer CPU0 by editing all calls
  to `queue_delayed_work`, `mod_delayed_work`, etc... to use CPU 0.

  Finally, `ktraces` for the workqueue events are collected.

  Without the current patch, the antagonist process can force
  arbitrary delays between `workqueue_queue_work` and
  `workqueue_execute_start`, that in my tests were as high as
  `30ms`. With the current patch applied, the workqueue can be
  migrated to another unloaded CPU in the same node, and, keeping
  everything else equal, the maximum delay I could see was `6us`.

Signed-off-by: Marco Leogrande <leogrande@google.com>
Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index db476b3314c8..dfd56fc5ff65 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -174,7 +174,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, adapter);
 
-	adapter->init_wq = alloc_workqueue("%s-%s-init", 0, 0,
+	adapter->init_wq = alloc_workqueue("%s-%s-init",
+					   WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
 					   dev_driver_string(dev),
 					   dev_name(dev));
 	if (!adapter->init_wq) {
@@ -183,7 +184,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_free;
 	}
 
-	adapter->serv_wq = alloc_workqueue("%s-%s-service", 0, 0,
+	adapter->serv_wq = alloc_workqueue("%s-%s-service",
+					   WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
 					   dev_driver_string(dev),
 					   dev_name(dev));
 	if (!adapter->serv_wq) {
@@ -192,7 +194,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_serv_wq_alloc;
 	}
 
-	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx", 0, 0,
+	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx",
+					  WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
 					  dev_driver_string(dev),
 					  dev_name(dev));
 	if (!adapter->mbx_wq) {
@@ -201,7 +204,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_mbx_wq_alloc;
 	}
 
-	adapter->stats_wq = alloc_workqueue("%s-%s-stats", 0, 0,
+	adapter->stats_wq = alloc_workqueue("%s-%s-stats",
+					    WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
 					    dev_driver_string(dev),
 					    dev_name(dev));
 	if (!adapter->stats_wq) {
@@ -210,7 +214,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_stats_wq_alloc;
 	}
 
-	adapter->vc_event_wq = alloc_workqueue("%s-%s-vc_event", 0, 0,
+	adapter->vc_event_wq = alloc_workqueue("%s-%s-vc_event",
+					       WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
 					       dev_driver_string(dev),
 					       dev_name(dev));
 	if (!adapter->vc_event_wq) {
-- 
2.46.0.76.ge559c4bf1a-goog


