Return-Path: <netdev+bounces-286711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLK4A1v3AWqcmwEAu9opvQ
	(envelope-from <netdev+bounces-286711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:35:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C365114B3
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B6023055058
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB394014B4;
	Mon, 11 May 2026 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljC0gE6U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3AA402420
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513467; cv=none; b=R6NedRKRLzwi5/GVS3saf2ODMmPMLEDgj8hP4epqfvp/mdzu1eyJ/FTmgV6Ri2LDvJXIXq9CWnktrVvC7jx6QHRF221hTys1CtVGs2U9T/wdbPibHe5ELwANMRhOTYS22nPCuv9FshS73JKPp9FwhmYGoJgi92z1GumNTAIr3mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513467; c=relaxed/simple;
	bh=9ybCAM9TUx9CqlJ0crtNBT6p11cePWkj+bG9UJxG9Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WhSEV+mCNIrrCpod+qi0RxRS1usgY708GiMuVWm2Br+gcvRxyooQgdqCsZPfLIp+lkAgbAzR87EWao/nQA8wbqjsOHsxc73U8UC+6hnVFgezko9Myk6WGVpr5guIrfMqkiD7wx2NOjiB6q8qzRDmJV0Y0ho76KhPTqm1bQAiu3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljC0gE6U; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso4308284eec.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778513465; x=1779118265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9e3eV5WUWG1OXri6eiKpNFGmglMZ+qekNtdFHRcBpTU=;
        b=ljC0gE6UtSFBrHMlrxckJU8t0e82ud8kkMmpKHbS/gzl9x0hraUj+ATWbQbpZ1fqMS
         sgqelLsT6eBpamVUTZLAb2I37OY3s7xeFdXy+7gIaAst14AHaxS/ucorra3Dr1QN4vi7
         nLgxMJJ3r6FNZSHQUHcrTei5wob381Wn/q7t0XWUgC/jGAwGz9jiEyH01DxlNR+REQmu
         S/38Xaxv6SRr94JBtDDb3DxNIux+MzsbieSEzWLlQS/wPGb+RnMzbkJDqRdwy/F4hHYM
         6fbLEo7Rh9OsOKIblsTV0vzmFYleQPDVcATFOl5BbyIWAhV5zipqW9vHQVUMyYkg02PA
         KEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778513465; x=1779118265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9e3eV5WUWG1OXri6eiKpNFGmglMZ+qekNtdFHRcBpTU=;
        b=XcqRpCV/FGLLN5FDfUi0JLPZbZq8uIKarUTD3aUEL7LF14hRlcb9HAdFsySQeaco5h
         pgSIVXr4+ZCHRHcubanOv0p8FNktTCziYYrjrf1zmLnqYpYUCRl298miF5MfpH0k8qfE
         qJj4ZMtSogUd5Iaa1GglxYqDW4xcjkI3ZJNRd8oxgO2nc7NQpm3CEMZCYr3x4jZoIz9y
         qDbjCHTV9I/C/ZkUxuP8n9dPEM4N1rdjsfzN0Y14v6GjkZc5g/p3DGryQPJavr9oRA0U
         Fvr/L9oSbpPIa+mPyY/j1IbxklLXnvln3LjEqF++mTLvo6PZGQ804C7L5lXGTQO75h1c
         KC4w==
X-Gm-Message-State: AOJu0YyHy3pZO6H1UQELkgmsNzhT/bPvgcCXc0JSK97b4QHZKjSLKt4F
	Lze8/+DjZaGm5WUoqCOwaFBtxz/2A3cjV+VRLfUie2e7gFa/nLYRe8df
X-Gm-Gg: Acq92OGNttuugfJ4MS4ycSiPVnzjNU95CL+FatOs/jSXLjd03usx70xOVCD5/VLW/Xy
	vp0sal3RIQh4XMogkDLsp+JNTy46+2T23gOFI5y0lrVqqsqqL2IwN/LS4d4Qe0bISLwax1goKq7
	bQbB5ELGy6gQS1Bg5VwaS4sBMll+ahnKBY/zrxpd1DvYjUOfd5NtL07QdnwXo1jXDI78m0LkOc1
	K1qee10pNhBm5GQO9omAe56JeJmSZPSYAf/hiM/2OxApVFbMxR33gFBmvdH5y8dwv7DqK6ZefX7
	1pVViPvZb9JQ/AtDVPLTbU9YfEGRZusZxk41Vq+iHGaehrenkSK6Coj+Oq5mY8HSc9dZWfOq/iq
	YsHTfSFqEhwX1UAx7WGPyZIr9h7GA/OIFEtzFxURAwxy9eAItuZ1mhZ1TijLbTeym597MTOywtA
	wntRGeIFfFG0leOnWLDL2ge4ZX2dD4LT4lpcb+Lj/p8CHMWQ==
X-Received: by 2002:a05:7300:148a:b0:2d9:3616:d897 with SMTP id 5a478bee46e88-2fb4d68f9e6mr5382338eec.22.1778513464854;
        Mon, 11 May 2026 08:31:04 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafcdsm17464080eec.6.2026.05.11.08.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:31:04 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	hannes@stressinduktion.org,
	albinwyang@tencent.com,
	shenyangyang4@huawei.com,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH net v4 0/3] macsec: use rcu_work to fix crypto cleanup in softirq context
Date: Mon, 11 May 2026 23:30:57 +0800
Message-ID: <20260511153102.2640368-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D0C365114B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286711-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[alexjlzheng@gmail.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tencent.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Jinliang Zheng <alexjlzheng@tencent.com>

crypto_free_aead() can internally call vunmap() (e.g. via dma_free_attrs()
in hardware crypto drivers like hisi_sec2), which must not be invoked from
softirq context. Both free_rxsa() and free_txsa() are RCU callbacks that
run in softirq, causing a kernel crash on affected hardware.

This series fixes the issue by deferring the actual cleanup to a workqueue
using rcu_work, which combines the RCU grace period and workqueue dispatch
into a single primitive.

Two design decisions worth noting:

1. rcu_work instead of schedule_work() + synchronize_rcu()

   An alternative would be to call schedule_work() directly from
   macsec_rxsa_put()/macsec_txsa_put(), then call synchronize_rcu() at
   the start of the work handler to replace the grace period previously
   provided by call_rcu(). However, synchronize_rcu() blocks the worker
   thread for the duration of a full RCU grace period. Under high SA
   churn (e.g. tearing down an interface with many SAs), each SA would
   occupy a worker thread while waiting, and multiple concurrent calls
   cannot share the same grace period — leading to unnecessary latency
   and resource waste.

   rcu_work uses call_rcu_hurry() internally, which is fully asynchronous:
   the worker thread is only dispatched after the grace period has elapsed,
   and multiple concurrent queue_rcu_work() calls naturally batch under the
   same grace period via the RCU subsystem's existing coalescing mechanism.

2. Dedicated workqueue instead of system_wq

   Using a dedicated workqueue (macsec_wq) allows macsec_exit() to drain
   exactly the work items belonging to this module — by calling
   destroy_workqueue() after rcu_barrier(). If system_wq were used,
   flush_scheduled_work() would drain all pending work items across the
   entire system, creating unnecessary coupling with unrelated subsystems
   and potentially causing unexpected delays. The dedicated workqueue
   provides a clean, contained teardown path.

Changes in v4:
- Switch from alloc_ordered_workqueue() to alloc_workqueue() with
  WQ_UNBOUND since there is no ordering dependency between SA cleanups
  (suggested by Sabrina Dubroca)

Changes in v3:
- Add rcu_barrier() before destroy_workqueue() in the error path of
  macsec_init() as a precaution, mirroring macsec_exit() to stay safe
  if work ever becomes queueable earlier (suggested by Jakub Kicinski)
- Rename error labels in macsec_init() from resource-named style
  (rtnl:, notifier:, wq:) to err_xxx: style (suggested by Jakub Kicinski)
- Add kdoc for the new destroy_work field in struct macsec_rx_sa and
  struct macsec_tx_sa (suggested by Jakub Kicinski)

Changes in v2:
- Use rcu_work instead of work_struct to avoid the manual RCU callback
  wrapper (suggested by Kuniyuki Iwashima)
- Introduce a dedicated workqueue and drain it properly in macsec_exit()
  to prevent potential crash on module unload (noted by Sabrina Dubroca)
- Extend the fix to TX SAs, which suffer from the same issue
  (noted by Sabrina Dubroca)
- Add Fixes tag (noted by Sabrina Dubroca)
- Split into three patches

Thanks to Jakub Kicinski, Kuniyuki Iwashima, and Sabrina Dubroca for
the review.

Link: https://lore.kernel.org/netdev/20260506100107.388184-1-alexjlzheng@tencent.com/T/#u
Link: https://lore.kernel.org/netdev/20260509020054.1792674-1-alexjlzheng@tencent.com/T/#u
Link: https://lore.kernel.org/netdev/20260509033353.1814289-1-alexjlzheng@tencent.com/

Jinliang Zheng (3):
  macsec: introduce dedicated workqueue for SA crypto cleanup
  macsec: use rcu_work to defer RX SA crypto cleanup out of softirq
  macsec: use rcu_work to defer TX SA crypto cleanup out of softirq

 drivers/net/macsec.c | 39 ++++++++++++++++++++++++++++-----------
 include/net/macsec.h |  7 +++++--
 2 files changed, 33 insertions(+), 13 deletions(-)

-- 
2.39.3


