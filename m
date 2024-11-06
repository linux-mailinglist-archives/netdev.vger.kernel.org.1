Return-Path: <netdev+bounces-142338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F579BE55A
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 12:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 794B6B2483E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E9E1DED40;
	Wed,  6 Nov 2024 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsLWH5KI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5F018C00E
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730891699; cv=none; b=HVqwC1OHnZajVSLwYQGi51Wo2EFs3BBCMmxE0XYNXa6G7e0dFwl+Y/ngNZhRjxW5VSSpiSgVe0k978x7HMAciU2A5Spv2momsCNs+cQr4FizcqjZEkbqDVUzvqzRRRX87Q6l4p1//yGk28QBNY3erTsSVuE/2b0MFIpGAuFCXZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730891699; c=relaxed/simple;
	bh=w0uIJNp7DkoJvCA6I6hYVWnWQRy0FN8z4oGmjvTP7UA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WnUMnp5FBLsm134YSRUE4bBat9oBiz4UIaWCOdxNlIVXjpOlqKy1/UI/wAWeFavbfiTeUmNfnXVjwOJdbMqNOsyKzTnChMuBA3MrKGRoywZouQ3pTxWyFAoUJ+lg1RcytqbwSgkx8Q0kncuomznlHjiAxZ0CQMGHeaeGRuPKKz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QsLWH5KI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730891697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q/pUhWBxmCDgwQYzUjg0jWk3qPOCCQzEzMOB8Ax5AVQ=;
	b=QsLWH5KIyrtU8qJ61PLGFYaX9m5oWE8bfhtRSnS7PtpCCVcn3fCgaunoMNVC7vhjubLo0l
	IugeU/fwxul2trwWNYJRZAJG2q2ntWbBgniNtmF9hoCVo63p0gC1CZc6KuBJKfidJhyUke
	1x+WZSm7XP/wVdtud16/FABL3tiYNSQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-6LJtl8SbP8eoyf92emu2Kw-1; Wed,
 06 Nov 2024 06:14:52 -0500
X-MC-Unique: 6LJtl8SbP8eoyf92emu2Kw-1
X-Mimecast-MFC-AGG-ID: 6LJtl8SbP8eoyf92emu2Kw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51797196CE34;
	Wed,  6 Nov 2024 11:14:42 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C23FB1955F41;
	Wed,  6 Nov 2024 11:14:33 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Simon Horman <horms@kernel.org>,
	Wander Lairson Costa <wander@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT)
Cc: tglx@linutronix.de
Subject: [PATCH v2 1/4] Revert "igb: Disable threaded IRQ for igb_msix_other"
Date: Wed,  6 Nov 2024 08:14:26 -0300
Message-ID: <20241106111427.7272-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This reverts commit 338c4d3902feb5be49bfda530a72c7ab860e2c9f.

Sebastian noticed the ISR indirectly acquires spin_locks, which are
sleeping locks under PREEMPT_RT, which leads to kernel splats.

Fixes: 338c4d3902feb ("igb: Disable threaded IRQ for igb_msix_other")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Wander Lairson Costa <wander@redhat.com>

---

Changelog:

v2: Add the Fixes tag
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index b83df5f94b1f5..f1d0881687233 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -907,7 +907,7 @@ static int igb_request_msix(struct igb_adapter *adapter)
 	int i, err = 0, vector = 0, free_vector = 0;
 
 	err = request_irq(adapter->msix_entries[vector].vector,
-			  igb_msix_other, IRQF_NO_THREAD, netdev->name, adapter);
+			  igb_msix_other, 0, netdev->name, adapter);
 	if (err)
 		goto err_out;
 
-- 
2.47.0


