Return-Path: <netdev+bounces-281689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDfbMBNl8GmWSwEAu9opvQ
	(envelope-from <netdev+bounces-281689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:43:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8655847F1BD
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AD49303EE89
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730AD423A7F;
	Tue, 28 Apr 2026 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHJrJoYI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6873DBD79;
	Tue, 28 Apr 2026 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360940; cv=none; b=HTkVDI98YkSHwFp9FzufAZWefFuKGrhtVyWK6K26aJac+v9JsJTivEb2cv+zdoo3ZWipO5z9u4hb8jI/aHCiCWjaGw5PchOFUTjuC/UjIW2bbSFLUr2kVfFn71G9HP2TOk1VNoMjeqDQLAsfLshffdfZDoSCmkJ0S91MJgMajZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360940; c=relaxed/simple;
	bh=X96G24pY5hCErV8JAZCiu1U+z1SXayz6lAeLWA14lRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMXDKG+QYihXLVKhHnel9IVe4OVVva7Nls8ubW0zQQRFyYzLx6sbqLnmKg5cqyPiEGKgoV+ZtrrDrWlNxMLlUqMKUZgrONrJEnZQUZrtaj1JI/UJ0DoInBpJpgicKKp1VTXvY2/aZPo78ow4N4itQxy1wfRFIgoeOSfHCqknusg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHJrJoYI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777360939; x=1808896939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X96G24pY5hCErV8JAZCiu1U+z1SXayz6lAeLWA14lRE=;
  b=oHJrJoYImRGI8gtZ9X615r1Xr5pI0t/fj7gvDFu4NT3uuaCY92r8Qbo+
   UzQdKAewEr+1nOUJDhcr/bwFU6ZLJUk2vAnFyrjyfA3OOTqGHrYETrHhc
   qWXZuije5l+It3PFfABmFtMS0tsWb4lLZDeGyYpkKzpYU9ydWOy4U4nbm
   7t7/Da7xqq+jQ9iMHlkW9idFi2bxEwRdNW0wP25cMczRZ/1nd/gkAaBq2
   7RMesZFcQAf/w6ZinZdvLNBNlMi1vFVGeA290hFXAhme+Vm8YTHgqhj2a
   IWKiCuzDAiQn9rlSLX+ZPCPTm9j8vX6do2okv67qJI2MrPjgfOgZAF+XX
   w==;
X-CSE-ConnectionGUID: zMjuyrzRSFqKCUlnL3TGbQ==
X-CSE-MsgGUID: fxz8ogS+ToWOmFiRfnOfwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82126053"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="82126053"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:22:17 -0700
X-CSE-ConnectionGUID: VTRUBTAwQSywUTnodpytrQ==
X-CSE-MsgGUID: blzNkteRSiGVyfh8NfYumQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="229308650"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 28 Apr 2026 00:22:14 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 1351EA2; Tue, 28 Apr 2026 09:22:10 +0200 (CEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-usb@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 7/9] thunderbolt: Add tb_ring_flush()
Date: Tue, 28 Apr 2026 09:22:07 +0200
Message-ID: <20260428072209.3084930-8-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
References: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8655847F1BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,wunner.de,linux.intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281689-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid]

This allows the caller to wait for the ring to be empty. We are going to
need this in the upcoming userspace tunneling support.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/nhi.c   | 28 ++++++++++++++++++++++++++++
 include/linux/thunderbolt.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 13009246e617..a0a789bfb680 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -325,6 +325,8 @@ static void ring_work(struct work_struct *work)
 		if (frame->callback)
 			frame->callback(ring, frame, canceled);
 	}
+
+	wake_up(&ring->wait);
 }
 
 int __tb_ring_enqueue(struct tb_ring *ring, struct ring_frame *frame)
@@ -601,6 +603,7 @@ static struct tb_ring *tb_ring_alloc(struct tb_nhi *nhi, u32 hop, int size,
 	INIT_LIST_HEAD(&ring->queue);
 	INIT_LIST_HEAD(&ring->in_flight);
 	INIT_WORK(&ring->work, ring_work);
+	init_waitqueue_head(&ring->wait);
 
 	ring->nhi = nhi;
 	ring->hop = hop;
@@ -760,6 +763,31 @@ void tb_ring_start(struct tb_ring *ring)
 }
 EXPORT_SYMBOL_GPL(tb_ring_start);
 
+static bool tb_ring_empty(struct tb_ring *ring)
+{
+	guard(spinlock_irqsave)(&ring->lock);
+	return list_empty(&ring->in_flight);
+}
+
+/**
+ * tb_ring_flush() - Waits for a ring to be empty
+ * @ring: Ring to wait
+ * @timeout_msec: Timeout in ms how long to wait.
+ *
+ * This can be called before stopping a ring to make sure all the frames
+ * submitted prior have been completed.
+ *
+ * Return: %true if the ring is empty now, %false otherwise.
+ */
+bool tb_ring_flush(struct tb_ring *ring, unsigned int timeout_msec)
+{
+	if (!wait_event_timeout(ring->wait, tb_ring_empty(ring),
+				msecs_to_jiffies(timeout_msec)))
+		return false;
+	return tb_ring_empty(ring);
+}
+EXPORT_SYMBOL_GPL(tb_ring_flush);
+
 /**
  * tb_ring_stop() - shutdown a ring
  * @ring: Ring to stop
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index 9df8a356396f..9c5cb5e4f23d 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -556,6 +556,7 @@ struct tb_nhi {
  * @poll_data: Data passed to @start_poll
  * @interval_nsec: Interval counter if interrupt throttling is to be
  *		   used with this ring (in ns)
+ * @wait: Used to signal that the ring may be empty now
  */
 struct tb_ring {
 	spinlock_t lock;
@@ -580,6 +581,7 @@ struct tb_ring {
 	void (*start_poll)(void *data);
 	void *poll_data;
 	unsigned int interval_nsec;
+	wait_queue_head_t wait;
 };
 
 /* Leave ring interrupt enabled on suspend */
@@ -653,6 +655,7 @@ struct tb_ring *tb_ring_alloc_rx(struct tb_nhi *nhi, int hop, int size,
 				 u16 sof_mask, u16 eof_mask,
 				 void (*start_poll)(void *), void *poll_data);
 void tb_ring_start(struct tb_ring *ring);
+bool tb_ring_flush(struct tb_ring *ring, unsigned int timeout_msec);
 void tb_ring_stop(struct tb_ring *ring);
 void tb_ring_free(struct tb_ring *ring);
 
-- 
2.50.1


