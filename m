Return-Path: <netdev+bounces-130567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE3298AD9B
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 21:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00481C211CF
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC931A01C8;
	Mon, 30 Sep 2024 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jzswEsnL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA3E1A00ED
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726193; cv=none; b=k3GTtvzRJ6GSZy2y2Rtx7CbK+rv+vqIcdSgGnNiqnXvoygaFW2x8ROsH2CZpRFFJISNTY9V8LLWDkQsZLFxackNlnaSpCG4fzpdxfJq69jCCNO3kR5qRLxtt3RYevb0ymjTpJekbSV/6br2Lv6Ftxjp7bfrwbfblciPU+pOH024=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726193; c=relaxed/simple;
	bh=VOP2E4EdNOlzmnohLf0Aivfl38U8ErSPEO+iGtQjFcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IakdUk0l7yhGr69Ryew7pyE8ovBFDdqlFMGhAnCjOWrp9OvxP6uKdmjLiZyFNEqGPXU7S3ZYiPfJsTN+Rja6I4QAIh/HcAI0a28WEjrtS3mx4UgIXaeXGTmick8jJntFStN5LxRhTzvnvl3d8O1jqp+t82XwLL4G69pMx0az97A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jzswEsnL; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso3041491a12.1
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 12:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727726189; x=1728330989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YrIxNM9HjJUUgFmx4X8hgJEmT6bLFjQYQ/uTKQH+yI=;
        b=jzswEsnLnwUWLqB+qmvSJBj1v1okWoCrdfkj7HbvDIoxQ3afSf5TdK3sUhORgkkWBs
         ILqMDGRdsKA1bZ/iR48bvUUQKF22D64ZTBgtA/EEssc0EgjBeN9RtR4UudU1HhZL/yT6
         A1nh8C8uuiqnd9C8bT1BIVDdnZlSz8qd+jEhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727726189; x=1728330989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YrIxNM9HjJUUgFmx4X8hgJEmT6bLFjQYQ/uTKQH+yI=;
        b=ePDAoFifKgq6hOsxAVxdTb+hApji1bJCFpek8sxKVbhTtjgAM4jJ1bv+nJHUOJyNLZ
         m82rzvNU9OeYqqTBRd6mCt07vAnSJ5ldYKGW6xI5DvFGdbVImrBp7kkUptSC5BDv56+O
         H6Vi3YmSxuWreLYye9RoROH4NqV5KPh1ipneMyryOSeQ88gpUTq8d/ynDrIxFlkl7sl1
         dhnM2bxdyJjqgfZMuU5hTjAyvFx7XMnNhRejTDDYgOKMKtzPhBbz0Xo0oSU2fYFh0ApG
         jkWoFBgOqkMMNx+tA1PLRwE1Egzr3VF5rESam/ZQrXAE37y4v23SV3fD+IuU10VJQgoQ
         5DOQ==
X-Gm-Message-State: AOJu0YxkUec3KIOupVUrR1tO34SynKbgoo/BazihbL/3qOoGwDq39/mC
	ll87P+JxqSuaF8oAVbEYCcfkN+O8lozBgwSW0MXAGtnMkOEd2r+Nlrww9rakwmOC8fU+lmFYOJ5
	garGUG+CVjG/UAzgSlwMFMG+rzPnsUdIkCHCpV7yKRZQQbpWQGUqjzUqg4WNYTQx8Z0LFT7Ql96
	TBeVXd4hZFLlquaXZB7078rOqw3klOh9wR/8U=
X-Google-Smtp-Source: AGHT+IHgE5GnxDFi+aeV5uEKrnZGDLW/FvYDcTAFwrkxEpkkA9AIh3erQXuaGCJcfY7pKP88QGl+Jg==
X-Received: by 2002:a05:6a21:1693:b0:1d5:1354:5256 with SMTP id adf61e73a8af0-1d5135453a2mr7660563637.39.1727726189164;
        Mon, 30 Sep 2024 12:56:29 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2649a2cesm6604450b3a.43.2024.09.30.12.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 12:56:28 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next 1/2] ena: Link IRQs to NAPI instances
Date: Mon, 30 Sep 2024 19:56:12 +0000
Message-Id: <20240930195617.37369-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930195617.37369-1-jdamato@fastly.com>
References: <20240930195617.37369-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link IRQs to NAPI instances with netif_napi_set_irq. This information
can be queried with the netdev-genl API. Note that the ENA device
appears to allocate an IRQ for management purposes which does not have a
NAPI associated with it; this commit takes this into consideration to
accurately construct a map between IRQs and NAPI instances.

Compare the output of /proc/interrupts for my ena device with the output of
netdev-genl after applying this patch:

$ cat /proc/interrupts | grep enp55s0 | cut -f1 --delimiter=':'
 94
 95
 96
 97
 98
 99
100
101

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
			 --dump napi-get --json='{"ifindex": 2}'

[{'id': 8208, 'ifindex': 2, 'irq': 101},
 {'id': 8207, 'ifindex': 2, 'irq': 100},
 {'id': 8206, 'ifindex': 2, 'irq': 99},
 {'id': 8205, 'ifindex': 2, 'irq': 98},
 {'id': 8204, 'ifindex': 2, 'irq': 97},
 {'id': 8203, 'ifindex': 2, 'irq': 96},
 {'id': 8202, 'ifindex': 2, 'irq': 95},
 {'id': 8201, 'ifindex': 2, 'irq': 94}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index c5b50cfa935a..e88de5e426ef 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1679,7 +1679,7 @@ static int ena_request_io_irq(struct ena_adapter *adapter)
 	u32 io_queue_count = adapter->num_io_queues + adapter->xdp_num_queues;
 	unsigned long flags = 0;
 	struct ena_irq *irq;
-	int rc = 0, i, k;
+	int rc = 0, i, k, irq_idx;
 
 	if (!test_bit(ENA_FLAG_MSIX_ENABLED, &adapter->flags)) {
 		netif_err(adapter, ifup, adapter->netdev,
@@ -1705,6 +1705,16 @@ static int ena_request_io_irq(struct ena_adapter *adapter)
 		irq_set_affinity_hint(irq->vector, &irq->affinity_hint_mask);
 	}
 
+	/* Now that IO IRQs have been successfully allocated map them to the
+	 * corresponding IO NAPI instance. Note that the mgmnt IRQ does not
+	 * have a NAPI, so care must be taken to correctly map IRQs to NAPIs.
+	 */
+	for (i = 0; i < io_queue_count; i++) {
+		irq_idx = ENA_IO_IRQ_IDX(i);
+		irq = &adapter->irq_tbl[irq_idx];
+		netif_napi_set_irq(&adapter->ena_napi[i].napi, irq->vector);
+	}
+
 	return rc;
 
 err:
-- 
2.43.0


