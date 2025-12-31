Return-Path: <netdev+bounces-246394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 750CCCEAFDB
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 02:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98DEA302C22C
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 01:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5D61F1513;
	Wed, 31 Dec 2025 01:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyFAhoo9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9962374C14
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 01:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767144070; cv=none; b=h/l4L9NMJoyK5ZeLFSy019A5VBx5GkmIEUJXXJmbL/FEkUeyAdzlD3prj5XjjiQ9MnAHRkYL3uc0ulwqmPFl7zQXVDGOHoVOkDK0tVP0b00Aq7JymzO8Ao0YfTldegm4MgsFHHzUeN6gn1JIIZvTa9TjwevDsz1FiCILZEKfFDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767144070; c=relaxed/simple;
	bh=filJgWl47X7iQElQfzz4maRRhjiUUJfd+B8gjoh7umY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i94ucdN/L1qZ+zDxbxm/dFpLuZZQ854Pi9y2ycv8cj7PTi8DnOmQFF8PdkxMjG5D/rTtUKUPxnUilNEwoq35904ejFz47EJupUkHBVwzO4xSwFgYchCohvUmQj41UkjYy98293j8povzCKJBtUNel3p5t5LerAT8QBIZnvx94Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyFAhoo9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767144065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgMKBlblGEGUwbZ2glt1AcmEiBNBCwiy72H146MYxIk=;
	b=eyFAhoo9yYdxh20q7Xp/1jaiDYhmcqGlTs8APIx5Ix6UCuwul1jXj/suNs2/aMXOHhcUoZ
	BZFCOVtZf90q95dQlDKhjzhNoEpRL2Tnal0jvuS+TdCWm3lHLaibvrwG6B/n7OsDrldW8f
	KLwaSjqfx0sZlvvDqSgGId6QTZzGOAQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-5fS7eBybMyeFMWdqAGnCrA-1; Tue,
 30 Dec 2025 20:21:01 -0500
X-MC-Unique: 5fS7eBybMyeFMWdqAGnCrA-1
X-Mimecast-MFC-AGG-ID: 5fS7eBybMyeFMWdqAGnCrA_1767144059
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE1531956050;
	Wed, 31 Dec 2025 01:20:59 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.72.112.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FFD430001A2;
	Wed, 31 Dec 2025 01:20:55 +0000 (UTC)
From: Xiao Liang <xiliang@redhat.com>
To: shayagr@amazon.com,
	akiyano@amazon.com,
	darinzon@amazon.com,
	saeedb@amazon.com,
	netdev@vger.kernel.org
Cc: xiliang@redhat.com
Subject: [PATCH v2] net/ena: fix missing lock when update devlink params
Date: Wed, 31 Dec 2025 09:20:30 +0800
Message-ID: <20251231012030.6184-1-xiliang@redhat.com>
In-Reply-To: <20251229145708.16603-1-xiliang@redhat.com>
References: <20251229145708.16603-1-xiliang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
Reviewed-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_devlink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_devlink.c b/drivers/net/ethernet/amazon/ena/ena_devlink.c
index ac81c24016dd..4772185e669d 100644
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
@@ -145,10 +147,12 @@ static int ena_devlink_configure_params(struct devlink *devlink)
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


