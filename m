Return-Path: <netdev+bounces-152311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6A99F3604
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F66C166473
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D5D20764B;
	Mon, 16 Dec 2024 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F5v3yN+s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC1C205E2E
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366476; cv=none; b=T9JbnSuOAHfT9DTZibDnWobSxBARR5m5F8FiIyYVibo6sJrIj+2zX0AWl1XvmpUqe+e3bDqzXlWCaqgsFIsuaXhqo8FBgVogbrwy/uwPw8U4Vwwx2olPQ9IF9uj0Z7wSwQV47vikf/Mnn+aqceS0b+5tjsYvJ/MD4yau2+DjVcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366476; c=relaxed/simple;
	bh=Duaisv63OuGEXKabu1B70YdNEWCFhEY6uZDg/YUCXJM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ihw4UJ0H8a683PNAXzx/bUpowW3V4nzjAWqzFpVlrTTtKJmf0KtRy4uPSrPpQpOJKkcLVAlv5I8Sak2PwAnz2iM5dm8gzUwhESh5kjJ7N+DCBEzwl5pv/T1vT7UTN4nY44Pr36OKZ6cUo07cMtfqkiXzxmUsp9qYsNKf+w2nEDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F5v3yN+s; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef91d5c863so4047999a91.2
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 08:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734366474; x=1734971274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gW4H2/TOHS2zfDTwC9BxNBGpe/B9ZolBHNbHz0o02es=;
        b=F5v3yN+sru2NV3UUZfKr46JqS40zCuJhX0iO10muI9TX8STMB243Wgm471gmaeRsBq
         ijHFGMUbdiqPUk5yJU0RQNOrr0zePjbmWtmXINyxyZqWmzx/lCK5w61SRK6kXRbS4eOC
         82D/kSInaa6m1413As/aCJkm0FGQVCjHEsm9mGRN1nFUgR+C8ZkebpoWlvfw1EHUOUpI
         QTmc1b7Ydr8Z+fMOGGR568OBn1qaN60aUFlVVjKWHp/mSW9R4UEb/thqS46h5hNXLUX6
         7EQE3WZNIdDE9myqopM6wVkLDQb2qfN5tpakJwqQSVyHzScfnn/oj+A58s2yllxsmDGv
         2uJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734366474; x=1734971274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gW4H2/TOHS2zfDTwC9BxNBGpe/B9ZolBHNbHz0o02es=;
        b=ovVMvt1fE0uuxvOJoZEIGgaCxXFFbutvbCtJJsc32fEpftpgBTeiTa306WBZhb2Bjw
         o94MQtTCAnHZA7pkxem2Nk1FR6GVEc33w1rKdfLRss2i+jUF7+2or37gu4uvC6s2gGfD
         BpVsJkB/MQJFFmu1N+xhTQ97+P0Sabemxzh6xdaLh3bhjBsn2+elYvD7jT11xb4FG9uM
         Nl203mxEQqciASlGNVwNbH9qKgqt1WcPI2j+J+5NEGD8CzoTtSEfxepaEdYv78Zl5oKJ
         F2PBnw4xywymvdUsfVYHUCVoRXa1+MtKr/kSHy6E+hv9FkCUWDjBnv9e0dFFWJZqfIDe
         tT5g==
X-Forwarded-Encrypted: i=1; AJvYcCX+Gnh0nt3jyDE8jXlxg1z0clinQm5Bdiqdu4zCR9nRjKHpc+iTaT6wry06ZwjnHQ05txKMLKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMXuF91TETrQ1wwWGZriT+/E8rLd3dOv77soSnxklGQ+hvV7BX
	bJ/zA9g6FqolQjIa2n58usuYcafpaYcSrrxYpce9vbQddIKZLrLnrKTgB8wyHNdYoIvDeMoz/zT
	mq8xJYw==
X-Google-Smtp-Source: AGHT+IH+NcFqvSJGVZtZhakhKOrf/vnRiODHzmjmJUPUWT5kMvWkePf7WswTE1jLMuI8ih/KoplSGx6a3tO5
X-Received: from pjl4.prod.google.com ([2002:a17:90b:2f84:b0:2ef:71b9:f22f])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5284:b0:2eb:140d:f6df
 with SMTP id 98e67ed59e1d1-2f28fa55c91mr18168313a91.1.1734366473766; Mon, 16
 Dec 2024 08:27:53 -0800 (PST)
Date: Mon, 16 Dec 2024 16:27:34 +0000
In-Reply-To: <20241216162735.2047544-1-brianvv@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216162735.2047544-1-brianvv@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216162735.2047544-3-brianvv@google.com>
Subject: [iwl-next PATCH v4 2/3] idpf: convert workqueues to unbound
From: Brian Vazquez <brianvv@google.com>
To: Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	intel-wired-lan@lists.osuosl.org
Cc: David Decotigny <decot@google.com>, Vivek Kumar <vivekmr@google.com>, 
	Anjali Singhai <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	emil.s.tantilov@intel.com, Marco Leogrande <leogrande@google.com>, 
	Manoj Vishwanathan <manojvishy@google.com>, Brian Vazquez <brianvv@google.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Pavan Kumar Linga <pavan.kumar.linga@intel.com>
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

This is not just a theoretical problem: in a particular scenario
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

Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
Signed-off-by: Marco Leogrande <leogrande@google.com>
Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 305958c4c230..da1e3525719f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -198,7 +198,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, adapter);
 
-	adapter->init_wq = alloc_workqueue("%s-%s-init", 0, 0,
+	adapter->init_wq = alloc_workqueue("%s-%s-init",
+					   WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
 					   dev_driver_string(dev),
 					   dev_name(dev));
 	if (!adapter->init_wq) {
@@ -207,7 +208,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_free;
 	}
 
-	adapter->serv_wq = alloc_workqueue("%s-%s-service", 0, 0,
+	adapter->serv_wq = alloc_workqueue("%s-%s-service",
+					   WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
 					   dev_driver_string(dev),
 					   dev_name(dev));
 	if (!adapter->serv_wq) {
@@ -216,7 +218,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_serv_wq_alloc;
 	}
 
-	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx", 0, 0,
+	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx",
+					  WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
 					  dev_driver_string(dev),
 					  dev_name(dev));
 	if (!adapter->mbx_wq) {
@@ -225,7 +228,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_mbx_wq_alloc;
 	}
 
-	adapter->stats_wq = alloc_workqueue("%s-%s-stats", 0, 0,
+	adapter->stats_wq = alloc_workqueue("%s-%s-stats",
+					    WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
 					    dev_driver_string(dev),
 					    dev_name(dev));
 	if (!adapter->stats_wq) {
@@ -234,7 +238,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_stats_wq_alloc;
 	}
 
-	adapter->vc_event_wq = alloc_workqueue("%s-%s-vc_event", 0, 0,
+	adapter->vc_event_wq = alloc_workqueue("%s-%s-vc_event",
+					       WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
 					       dev_driver_string(dev),
 					       dev_name(dev));
 	if (!adapter->vc_event_wq) {
-- 
2.47.1.613.gc27f4b7a9f-goog


