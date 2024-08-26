Return-Path: <netdev+bounces-122007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1574795F8D1
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 20:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922091F237B5
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02BC199E9B;
	Mon, 26 Aug 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KCGCPDw3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DB11991AF
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724695845; cv=none; b=VmHz/ow/T4CnfngWYNfCkGgNobaqDpaTfQjOL8VmoO8cd601/Uid4eiMfiYmPo3nLcExb1ii+GpQ570sfQoxPG6bLhu2QN6igSrenqo91GVXu7ddM19FuHBXWWmFZeuieHdrOewN3P+MsSdYShpcODczXtRqGzzLFNh11HQpCbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724695845; c=relaxed/simple;
	bh=FO1VXGTWQHpXO3EAROfO+xp8yabUrYztbCIjZhc5uis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IcVFV3Z5Axd4XWJ+MP/WR+lzZJzAHJ7nVH1LYMDd3gqCMCYMOGq++V2XIFWHIQVyJPMrych9v/G/utvbZcV48gfkhEnAbeLohiRbCjgYW9uUj7vuVnwmeYVSRIeXACo8pQfA7JSmWj3I3hxG5XodvZXNKm5EKJBw6StC9QYD5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KCGCPDw3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b46d8bc153so87837597b3.2
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724695843; x=1725300643; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LM6a0WurRs0VygQLA1YyzraSEK90YN51nb0L2VXwcYQ=;
        b=KCGCPDw3Ry563vsSoFVmploj8FNfLI0t6HqDkyH7gvPmq2teWYjA0hJ0ZJBE7Pmd8z
         uhBncbXlJAo0fR0J3ui1FeygboW+1JKdfiPTMCMnW8Uy+5KKY/9JpYkyFylJaLGAZKLi
         4t6ItBLpTGYksK2jugdRAAIbTzfxihM4kCatBELqJ1x4uS4LAz+DV8y+P8CNx5AsJboo
         0qZxLynlXp2HRUqKof1CwCRJfUeSj0aq1LKvvVVSGLdITdpKxOlEbzV5lEPuE+BeHufA
         vzyF1z5iT7EzSJSwPZnZxxpCjOpAJd/rR2TtzLoVYyEt+/R18Icda3I9zQAOAt06PoHG
         kGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724695843; x=1725300643;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LM6a0WurRs0VygQLA1YyzraSEK90YN51nb0L2VXwcYQ=;
        b=m1hFM9Nm9/V8ocneyMovvWh/qgko7he0YBacODpW0jYbqr3z4nQG1I+MXvCpDR9xPT
         c4XENBrfNwJvoObao/QlcPkgngxCvIWhWw3DCJeI5G3UhmudMVRE2mwYFL4NhTJoKTgL
         rLF+JoIY5dMokcZZ70YOQgWJBE9ysIE0CGWJn7dJPwPsBoU48Zj2Dxcqav/VW7DvPXEW
         RDBpwK49/ozdW+mPYgKdsaG+7vwyxdr6cq5ZHRxZrxNfXQLtEkbwV/rXWcTiB4tK9X2u
         uByFkN7P63rWfHpQk5M9aMXXBJtDgIXzP2rnoE/IxIVkhoi8Wn4O08YNNPVf/1KxeIOP
         1T0g==
X-Gm-Message-State: AOJu0Yx4e/0II2UAYkF72N2B7g38hQQXcMcIkJTYjjlazdRRNTWp3P+c
	wN653ctaX3zE0WffeRdFaLtdz20Qi/EDFyJOlemVMf9Yv/UeJsJzbzxooKU6CLheZgr4hDeQSOB
	80JDDHvfD7KzaqU5rlw==
X-Google-Smtp-Source: AGHT+IF6Ly19WKd+JcS6CcJwheQlRT65UDI0KdLySp4FklnSjsvLt63ejTCLnUizmDoAvkVv4ljTcp6I2KahJvls
X-Received: from manojvishy.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a5b:24d:0:b0:e0b:f69b:da0a with SMTP id
 3f1490d57ef6-e17a865b595mr19562276.12.1724695842941; Mon, 26 Aug 2024
 11:10:42 -0700 (PDT)
Date: Mon, 26 Aug 2024 18:10:31 +0000
In-Reply-To: <20240826181032.3042222-1-manojvishy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240826181032.3042222-1-manojvishy@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240826181032.3042222-4-manojvishy@google.com>
Subject: [[PATCH v2 iwl-next] v2 3/4] idpf: convert workqueues to unbound
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

This is not just a theoretical problem: in a praticular scenario
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

Fixes: 0fe45467a1041 (idpf: add create vport and netdev configuration)
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
2.46.0.295.g3b9ea8a38a-goog


