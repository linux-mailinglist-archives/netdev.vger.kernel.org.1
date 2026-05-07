Return-Path: <netdev+bounces-285110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCEaOkDz+2mMJAAAu9opvQ
	(envelope-from <netdev+bounces-285110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:04:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E25E4E227A
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C0033004DE6
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 02:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E242773EC;
	Thu,  7 May 2026 02:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpIyeNaE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799BF23D283
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 02:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778119484; cv=none; b=s3YRzX2x1bBfcDCpqKgW3PyLk2jFL6RuM5MSTkWan7X8VhkZFzV/7HTIDy0lrZVINM//B1K2kL0H7CBFzk+pmDLZNJjA64AX9fx2EDUbtvZijCFgY39xK1w0qYDExEwDTf/G3oVZZ5chtSUn0LRBnCtzA/vyhcVfvPOTwL6oy3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778119484; c=relaxed/simple;
	bh=8Zg7fCfIcCNsRpTeWFDEb/zP61VgONm4+4hZ41j0PjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=W8icM+BqJUvtFv20gIHzc8EvhJaT9tqpbS68XOVsPQAEfGU1VVl82WelWPxKGeiJGBZpFdhobwPK5NcEP2MXg7NiFL/qI7YWjwba7QQLgJVo2mkRTmHA6jxU53PGuHFQENHBu4BB4Nq14sBf2p16aX4s5m04zLar2LSNZwD/Rw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpIyeNaE; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-356337f058aso168418a91.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 19:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778119483; x=1778724283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=URbYvSwXxosJOxLstKTSXu33kWbi1zwav8hi5KjbgC0=;
        b=DpIyeNaEbGKfpPy8WDuG7LBqEp+QhV8Ygzco570Cg5QI0kfYYZ3xoztpgMhr3Rwh/M
         O9Iwuy3v0+CUtRhkGEeh7++DYw1t63mlV6PYMlvbec2t7WOrCsUYzA6O6hK1tt9pTp+H
         JvszS0bnHnmO3nZaWMrI2/oSzvTmU63Gv99aK99p6Dkdiuy5uy20QkpBzhlKSF+d2ZHA
         RmWigMXysO0gsweQHoZlabW96NNVHpbIuuCRK0H8+lVswqoviCpP4J/0tQE7NsfsLMcf
         XtFQS7yWKXgZgLW9n9Myr2SE5ZSKUUpCFvF1jE3oE4of7GtC0a76cl3NzF+wLwQ9DJse
         J4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778119483; x=1778724283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URbYvSwXxosJOxLstKTSXu33kWbi1zwav8hi5KjbgC0=;
        b=Rj7sKxOvuLMAZu9XAAWY4ySkrBAvEcbtFFuC0ChBU1idA1C0Hi6aVC2dkCkx4h532A
         u6Fj+sTERCobcV6Uhj6FJVMAofXEaTEazzSGnQcmt0BLEzRAhy1uqVFvAGt2s1m2YT+K
         ar1xiAuwVnAs/x2+cIuivp6yc1a78qzSEgQFcTuFjiXvTI47Sx3Iy9Bj+ADOIsLot0oP
         T4v/gelWfgeXdEC/rTuAw32/yu/Epw9rtPTu9TJbcMkoKSwV8bK35FscrrZTSTvSvxCI
         a25xI0HdgTjUYKS+EQrgcwAMZFbNDTIJk7AkBWWVd/4IYSsaeMtXITTPaEd95nZ6fR5v
         /5pw==
X-Gm-Message-State: AOJu0Yx6javA2Igxa5nTGpInfr+KLW91HmxnPhmUhjTdgPmVVsAdd9Dn
	BWviJoC5VVeJGtMrhKgU/ba99p5P8itrxlCAkbR03s4yimLuucylFgu0
X-Gm-Gg: AeBDiesOizMZzR/Xqv5+g84oymRi4Sh4UosopjJ0BCfi5pbyp8wK5ctn1JWcndSM5f1
	qoMLXZK1OBqBKCABn9SqGdPlTgtKLe1QcS14QPvCp1GfYaUdk2G/Mpg1WrI8cPWCHfHbtLY0x2y
	5SgCSeHOgE6oAKjBMkQRdpn0Q8i6PooPPdspOgrLoeSxK65v2Fq+wWba0HWSe2FAFN3qWrG9zD8
	ujoU+1AijpunJJxKA1UvJq/svTAUAjgt2jPdwiydSnuYNDJQkKElnsl819Qycph/UhgRT7sKOG1
	pcjJqU64uvd7SdRoT2biraPjYk6zgpYe50TYrrjtxnfva3E0CdapxEiO3Z1buViGaaDguM4KYb7
	B1dLenh4tSMs/gajo8xjqRNuvIPfW0f/RlEyIazRiR5+gJH1h4aT7qSEXXKmCBgXfLH6y+IU3UP
	X5cIPS626NfcAwO1Nss1+hHPFxrBUeuSpyXTcJ5WvzDKHa8L2G4yLiVmT5qzD6PY5Gh3j2mpE=
X-Received: by 2002:a17:90b:1f89:b0:35f:bcc2:c351 with SMTP id 98e67ed59e1d1-365ab9b8c19mr5682954a91.6.1778119482592;
        Wed, 06 May 2026 19:04:42 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4cba340sm5100204a91.17.2026.05.06.19.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 19:04:41 -0700 (PDT)
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
	kuniyu@google.com,
	shenyangyang4@huawei.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH net v2 0/3] macsec: use rcu_work to fix crypto cleanup in softirq context
Date: Thu,  7 May 2026 10:04:23 +0800
Message-Id: <20260507020426.1126254-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8E25E4E227A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285110-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tencent.com:email,tencent.com:mid]
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

Changes in v2:
- Use rcu_work instead of work_struct to avoid the manual RCU callback
  wrapper (suggested by Kuniyuki Iwashima)
- Introduce a dedicated workqueue and drain it properly in macsec_exit()
  to prevent potential crash on module unload (noted by Sabrina Dubroca)
- Extend the fix to TX SAs, which suffer from the same issue
  (noted by Sabrina Dubroca)
- Add Fixes tag (noted by Sabrina Dubroca)
- Split into three patches

Thanks to Kuniyuki Iwashima and Sabrina Dubroca for the review.

Link: https://lore.kernel.org/netdev/20260506100107.388184-1-alexjlzheng@tencent.com/T/#u

Jinliang Zheng (3):
  macsec: introduce dedicated workqueue for SA crypto cleanup
  macsec: use rcu_work to defer RX SA crypto cleanup out of softirq
  macsec: use rcu_work to defer TX SA crypto cleanup out of softirq

 drivers/net/macsec.c | 27 ++++++++++++++++++++-------
 include/net/macsec.h |  5 +++--
 2 files changed, 23 insertions(+), 9 deletions(-)

-- 
2.39.3


