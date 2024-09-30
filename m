Return-Path: <netdev+bounces-130575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF9D98ADD6
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D3B0B23A5F
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6701A0BFE;
	Mon, 30 Sep 2024 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBR9XpCj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0466B1A0BDE
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727220; cv=none; b=AwehiPqFzR0w8dhSLSvkiIcTPXbHhw7kpfyQXA/LR+HeTA5JQ0VMNHBpCNIDu5A2BAnzmcYm9vg6WZ3D2SHlv4UU0fJ/wgW+p754vdG3S0nkyVVGRragPFbfITLPc40MboMo38zWi6drGKnyxqd7eKP/Pp4yIUxeFAIgAiT464Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727220; c=relaxed/simple;
	bh=qRH5YwDbM1DAHggYroIrUSh7Z56KGEOACzrObi2p8iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzrcbyfAXSud2YSmLjOIa57qurDfhUVudn7y4ZOWtJ9O3GuOLrhud/P8piqmvktMfqk1EvXAZ2rBjzPsx0XjmQ1rzbm4HTfjWKnLWogs+B10rSexzE02ld5yHc454sTH/yzpSxZvS1/NcUVVCXhph2GBS8AkGb5mJzovhw9pkDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBR9XpCj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727727218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRgJGBAJFn3EFrLh4/BAMAfyDsSerAQKWxwR8Z7g+7c=;
	b=cBR9XpCjtWocJSvS42qINSY7uXrg/pu+J3I7oDBcJJ/KhY85ZKbMkbUSWuCErO8srI+uXm
	lT1xVb4vANial3L0ArLnNZRhHURAPw/CF2o1xDZuzuxlCiY0K7pCI6+HQhfbk+8KANGY/Q
	veM4XhyAfCxTg2c2BkSUtYfY07kDtQE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-YfAdo8n-PhSvBZT5WFCWNg-1; Mon,
 30 Sep 2024 16:13:36 -0400
X-MC-Unique: YfAdo8n-PhSvBZT5WFCWNg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5761A1944DD9;
	Mon, 30 Sep 2024 20:13:35 +0000 (UTC)
Received: from rhel-developer-toolbox-latest.redhat.com (unknown [10.45.224.53])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4ED5E19560AA;
	Mon, 30 Sep 2024 20:13:32 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Manish Chopra <manishc@marvell.com>,
	netdev@vger.kernel.org
Cc: Caleb Sander <csander@purestorage.com>,
	Alok Prasad <palok@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/4] qed: put cond_resched() in qed_grc_dump_ctx_data()
Date: Mon, 30 Sep 2024 22:13:05 +0200
Message-ID: <20240930201307.330692-3-mschmidt@redhat.com>
In-Reply-To: <20240930201307.330692-1-mschmidt@redhat.com>
References: <20240930201307.330692-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On a kernel with preemption none or voluntary, 'ethtool -d'
on a qede network device can cause a big latency spike.
The biggest part of it is the loop in qed_grc_dump_ctx_data.

The function is called only from the .get_size and .perform_dump
callbacks for the "grc" feature defined in qed_features_lookup[].
As far as I can see, they are used in:
 - qed's devlink healh reporter .dump op
 - qede's ethtool get_regs/get_regs_len/get_dump_data ops
 - qedf's qedf_get_grc_dump, called from:
   - qedf_sysfs_write_grcdump - "grcdump" sysfs attribute write
   - qedf_wq_grcdump - a workqueue

It is safe to sleep in all of them.
Let's insert a cond_resched() in the outer loop to let other tasks run.

Measured using this script:

  #!/bin/bash
  DEV=ens3f1
  echo wakeup_rt > /sys/kernel/tracing/current_tracer
  echo 0 > /sys/kernel/tracing/tracing_max_latency
  echo 1 > /sys/kernel/tracing/tracing_on
  echo "Setting the task CPU affinity"
  taskset -p 1 $$ > /dev/null
  echo "Starting the real-time task"
  chrt -f 50 bash -c 'while sleep 0.01; do :; done' &
  sleep 1
  echo "Running: ethtool -d $DEV"
  time ethtool -d $DEV > /dev/null
  kill %1
  echo 0 > /sys/kernel/tracing/tracing_on
  echo "Measured latency: $(</sys/kernel/tracing/tracing_max_latency) us"
  echo "To see the latency trace: less /sys/kernel/tracing/trace"

The patch lowers the latency from 180 ms to 53 ms on my test system with
voluntary preemption.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/qlogic/qed/qed_debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_debug.c b/drivers/net/ethernet/qlogic/qed/qed_debug.c
index f67be4b8ad43..464a72afb758 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
@@ -2873,6 +2873,7 @@ static u32 qed_grc_dump_ctx_data(struct qed_hwfn *p_hwfn,
 							  false,
 							  SPLIT_TYPE_NONE, 0);
 		}
+		cond_resched();
 	}
 
 	return offset;
-- 
2.46.2


