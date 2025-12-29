Return-Path: <netdev+bounces-246236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF815CE724F
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 15:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D16E7300A6D4
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 14:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4CB316193;
	Mon, 29 Dec 2025 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbu6PfkP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CC631353C
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767020302; cv=none; b=FSjwV4md+JEaoFJIuT7lEvfPfeaoGo5M+ZCUKHHPGKQC+VCWwDr9EzneuxZVtFaZj9w+xcp9s/gtOhh8YAZNNXuE2IRprjArdBln2cbIF19Gv7dE13kudXJoBX0fncFjxJiyOyR0V2J9HkdNk4HM5V2Y+A6GcU0mykYn63RNZgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767020302; c=relaxed/simple;
	bh=+rKUTHE1C5tMd4wO+uOJxCIcCFL6pdF1qrOtPb4XEzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aPJdOXUumaREZULxYr8DpoqEMj4uXeuuWkv+rZ0SFchCn40VNgYyxls9T+HAhArT2ugtRHiuSnl6HYYcTmFPhPxd1xpMT3XqJUMM18wKpTSTrvQHqeujFmTzWuZDF1TWNVHtJroP9xoMVgjSu6tXfpF73pCKKuweWEgBHxYh2s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbu6PfkP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767020300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9d0Dg/LIBtWTzr9qM/QWRGOSrtOr1mmiEet2atE3UG4=;
	b=bbu6PfkPBCSapdQxEqa0UY+lCXuJ5WdnJvR7ux5XK0xeHh7pvFJsuyeiozv6KXiZahLva+
	P1KskRnrd73S7n+MRVjvBUlFz1AnzIUMdN+/W2QAb0M9X+GSCRbT0+a3DYNl2EhIa64Rfk
	bUhnv3weytnhIDJ6rLzId9GW50OZWPY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-vfhV7sM9Pqiqvj2-wog-DA-1; Mon,
 29 Dec 2025 09:58:16 -0500
X-MC-Unique: vfhV7sM9Pqiqvj2-wog-DA-1
X-Mimecast-MFC-AGG-ID: vfhV7sM9Pqiqvj2-wog-DA_1767020295
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AFC1180035A;
	Mon, 29 Dec 2025 14:58:15 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.72.112.136])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 271D919560A7;
	Mon, 29 Dec 2025 14:58:11 +0000 (UTC)
From: Xiao Liang <xiliang@redhat.com>
To: shayagr@amazon.com,
	akiyano@amazon.com,
	darinzon@amazon.com,
	saeedb@amazon.com,
	netdev@vger.kernel.org
Cc: xiliang@redhat.com
Subject: [PATCH] net/ena: fix missing lock when update devlink params
Date: Mon, 29 Dec 2025 22:57:08 +0800
Message-ID: <20251229145708.16603-1-xiliang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Frank Liang <xiliang@redhat.com>

Fix assert lock warning while calling devl_param_driverinit_value_set()
in ena.

WARNING: net/devlink/core.c:261 at devl_assert_locked+0x62/0x90, CPU#0: kworker/0:0/9
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.19.0-rc2+ #1 PREEMPT(lazy)
Hardware name: Amazon EC2 m8i-flex.4xlarge/, BIOS 1.0 10/16/2017
Workqueue: events work_for_cpu_fn
RIP: 0010:devl_assert_locked+0x62/0x90

Call Trace:
 <TASK>
 devl_param_driverinit_value_set+0x15/0x1c0
 ena_devlink_alloc+0x18c/0x220 [ena]
 ? __pfx_ena_devlink_alloc+0x10/0x10 [ena]
 ? trace_hardirqs_on+0x18/0x140
 ? lockdep_hardirqs_on+0x8c/0x130
 ? __raw_spin_unlock_irqrestore+0x5d/0x80
 ? __raw_spin_unlock_irqrestore+0x46/0x80
 ? devm_ioremap_wc+0x9a/0xd0
 ena_probe+0x4d2/0x1b20 [ena]
 ? __lock_acquire+0x56a/0xbd0
 ? __pfx_ena_probe+0x10/0x10 [ena]
 ? local_clock+0x15/0x30
 ? __lock_release.isra.0+0x1c9/0x340
 ? mark_held_locks+0x40/0x70
 ? lockdep_hardirqs_on_prepare.part.0+0x92/0x170
 ? trace_hardirqs_on+0x18/0x140
 ? lockdep_hardirqs_on+0x8c/0x130
 ? __raw_spin_unlock_irqrestore+0x5d/0x80
 ? __raw_spin_unlock_irqrestore+0x46/0x80
 ? __pfx_ena_probe+0x10/0x10 [ena]
 ......
 </TASK>

Signed-off-by: Frank Liang <xiliang@redhat.com>
---
 drivers/net/ethernet/amazon/ena/ena_devlink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_devlink.c b/drivers/net/ethernet/amazon/ena/ena_devlink.c
index ac81c24016dd..b1eed4b3b39e 100644
--- a/drivers/net/ethernet/amazon/ena/ena_devlink.c
+++ b/drivers/net/ethernet/amazon/ena/ena_devlink.c
@@ -53,10 +53,12 @@ void ena_devlink_disable_phc_param(struct devlink *devlink)
 {
 	union devlink_param_value value;
 
+	devl_lock(devlink);
 	value.vbool = false;
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_ENABLE_PHC,
 					value);
+	devl_unlock(devlink);
 }
 
 static void ena_devlink_port_register(struct devlink *devlink)
@@ -144,11 +146,13 @@ static int ena_devlink_configure_params(struct devlink *devlink)
 		netdev_err(adapter->netdev, "Failed to register devlink params\n");
 		return rc;
 	}
+	devl_lock(devlink);
 
 	value.vbool = ena_phc_is_enabled(adapter);
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_ENABLE_PHC,
 					value);
+	devl_unlock(devlink);
 
 	return 0;
 }
-- 
2.52.0


