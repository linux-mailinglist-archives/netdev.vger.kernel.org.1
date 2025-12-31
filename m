Return-Path: <netdev+bounces-246436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E96CEC207
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 15:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAE6C300ACE7
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 14:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785C0238C08;
	Wed, 31 Dec 2025 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHXWW4mQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA713A1E6E
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767193111; cv=none; b=ZikQUXUpRqrfJhYC7etTkdiTDMHXTCOL3sB3zgv/rt0SlgU5CkMXu3ASn/8I/0rlEE+fiJgDckGgAqg4licJyKc4JmNc/4QvHaaZa3MrIdiLE4eoHIeDR5cggQuKG8E+1mNdrSlc0HNHfj/gUePJfpCuN0Dm1rdsJFKwx9DEqjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767193111; c=relaxed/simple;
	bh=0CbJ03oboIzEc0MERNJl7GWpCb4+/aPuB9OvqKpmxF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDMwyX4HxBKNIrJm5ttj+uc5LaKm+AdA7p0pTQhlvpeI3BiYCQ1TAo/TyhmcYGW/ZoqqNbZtqU2IhFW7ccnSf9KbHHIjS6j/2iJaOA16U5YojkIUYOXjCf5Xgj3PHRhrXAYtZinrNlzUSoX1tQpyv2EHa/OHr+vGh88FNYV7Irw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OHXWW4mQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767193108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEqsqHgzDG5y0v/Du1uKjptW1iu7EY+iymS7hzDHbPc=;
	b=OHXWW4mQi70uY4K9mKSp9n7M0OCFNlb4U8ax3ReoYJ9mj6y7D/3Tpt2Th0fChcWLXCRop/
	6P6d8MeiohcbTMvzrmZqoGZZhopKALIPX9YG86NLydHXnoasNAm7RFGWgucb6ZAx0x/SlI
	Ab3rDIFcBawR/r0aYjAuWk26w/St8PQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-ytwg_eW1NLm-w8RYNfyTVA-1; Wed,
 31 Dec 2025 09:58:25 -0500
X-MC-Unique: ytwg_eW1NLm-w8RYNfyTVA-1
X-Mimecast-MFC-AGG-ID: ytwg_eW1NLm-w8RYNfyTVA_1767193104
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CD971956046;
	Wed, 31 Dec 2025 14:58:24 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.72.112.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E26DA19560A7;
	Wed, 31 Dec 2025 14:58:19 +0000 (UTC)
From: Xiao Liang <xiliang@redhat.com>
To: shayagr@amazon.com,
	akiyano@amazon.com,
	darinzon@amazon.com,
	saeedb@amazon.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Cc: xiliang@redhat.com
Subject: [PATCH v3] net/ena: fix missing lock when update devlink params
Date: Wed, 31 Dec 2025 22:58:08 +0800
Message-ID: <20251231145808.6103-1-xiliang@redhat.com>
In-Reply-To: <20251229145708.16603-1-xiliang@redhat.com>
References: <20251229145708.16603-1-xiliang@redhat.com>
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

Fixes: 816b52624cf6 ("net: ena: Control PHC enable through devlink")
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


