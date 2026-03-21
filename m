Return-Path: <netdev+bounces-270165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLplHJgWvmnoGAMAu9opvQ
	(envelope-from <netdev+bounces-270165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 04:55:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0981B2E32A8
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 04:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FBE0301F33F
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E3933E367;
	Sat, 21 Mar 2026 03:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzp8YSAx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DA233D6E6
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 03:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774065294; cv=none; b=ZE7FqePpuffnoC4738NQFSGcnAPetzNsHyhe0oYZpiECn5F8iAAS8/fyvKgxAPG9DXPdCkRn/7wBY1LkMgYLYdflQ/P/STN04xdodTf3R2i7n3GfryrIKLYK/I/ka+ZlW9CdWPYkNcD5TlIgYDOYEoRim8JZuWTJm2yDu67AqqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774065294; c=relaxed/simple;
	bh=rUoQuWIfaJgdbpwwynVupr5Nrul9i/+vWIwXroY4tpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Osr5NsR9hfDxlKy7GlLsX3yF3z1wgxouWEJVPI6ew80/pEcvpKRgVyEpFf6zBbwrHKQpP5+QHKt/vnnt3U03S5DFosgGln4DrGE/oozCOOm7QnRwZqqbRKxMfIOVwYGCZVVPFLlrlpOyMNOy8284LsORi7b3JUw3JGSuttLOPEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jzp8YSAx; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899a5db525cso22775106d6.3
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 20:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774065292; x=1774670092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Mkiqb+Vj/SHwdR4VTTJ+J9wlyftU60EVDvQB+SCNHc=;
        b=Jzp8YSAxq/6cTtk+YgXxZ+iuhrYE1iZF09eipsvfOmnhujofC9bUJyjPQnqyRz/2aq
         me57jF2+V/u875DmxZ1AnoSYzSmsZY1rQp4LG/A7x8Xgs/JiBFYru1J63I3ymCsnwI7B
         /3s4ZCY/b13TCWE8RAtqmq5RnKa+LgAny7x5PEN97OgLKFBq7kFVVGHW5HIgImwnXr2C
         oE13YmVntkLHKqs/T0giCClNwru5M8gC1uvYuCivMmPCzleOLt9C0dGMTUaByeiB9LIb
         hBR8pnmZb7j4sVaYWOBHgz7kyzGWyXdMAIDXAjRGMhaYMW7fEHePb/H8xHkQDp1Km+qI
         ub7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774065292; x=1774670092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Mkiqb+Vj/SHwdR4VTTJ+J9wlyftU60EVDvQB+SCNHc=;
        b=cayoZGX4MZG47prQ1bTnDvA8MSKWXvazyBvHpZp6z/QgUKD2coCkuTANTMl7MsP7JC
         /TYx/3oIb2XDYNlUdZ5T9tpr9OvSpaSgH1JnekJ9T/UI2TYRWVjxs2LWmr+PnuMJXcCC
         3nIOdHlQbQ19Rai9MhODRYD2wb3vQBZ+w3AhDTMctis1hPvJ5nk8UEekntNFDu8dgvUg
         PbVpelcwqXJ/ZMsCNRkznNUVnuHg/I/CFgAietchSvuREG4Yp09qD3qCboMnhrs4Qtx6
         uZpOA+HaK55iW2FW4V2j94qsAeuGEqho5RNDzo0dd0l8Te4B9U2AH52MYx+VU316HJAK
         AedA==
X-Gm-Message-State: AOJu0YxZL/AMD1goRR7lcT1Xv+p98JCv3NdqIQsYwBOXznQNjmGJxiFx
	U2RmfgVNcm39/AgzjqlnWoH8QJacHmOr6u+sPNJRFpJvbJrbhbcN3NvpQHOjttoE
X-Gm-Gg: ATEYQzwkAuI3qUE5HVG4yPFNMyw2hhEMiGfjaZmxhoDHC/tN8TTJ8ZfVoRFZijmf8Wq
	z2aFt5pL/72oJ3Ms2zR4ASps5oEmQvId9FDJYZRCKSN9YIx+ve22F9dMzACoOH+R3N+9fI2K3L4
	oBBoutbQvrVck9aP6fmEdU0yBhjGY7GkIms/0XzNbBs/3IHKcLLACTOIedCYnjzJC2rSGPzwAqr
	s4oL90MPrbK1I+EhpMlWDU5P6TG212YH3pa5p7649BmGwxiz4jXwp4lK4r1WtwF7p9Um5UWMoCp
	pxWMGEqhdF+rmAS0/2TQ0b49JrymwPqVOz92Cs8kFUmqh5JgbFE26RfATOIrQOktY3XO+q7mLQ4
	eNvef7GBeD1Eq0X3PnxAnqYUTggRRnCYxlTlBm6USQCFvQs4PSDORWXGSqtrhty7t47t6+wASZr
	kLHsj9K+QQn5Uj5r0MZVfqJHo/mYBJzpak6LmM2hJlEb53hqfIdJ6Ihn4GPdyfNGcvRu/qIKQU6
	VHV
X-Received: by 2002:a05:6214:f28:b0:899:f4bd:66e9 with SMTP id 6a1803df08f44-89c85b0e49bmr86905896d6.63.1774065291566;
        Fri, 20 Mar 2026 20:54:51 -0700 (PDT)
Received: from CS-396-Lab-Machine.. (c-24-12-10-127.hsd1.il.comcast.net. [24.12.10.127])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c96cb614dsm2999406d6.22.2026.03.20.20.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 20:54:51 -0700 (PDT)
From: Tyllis Xu <livelycarpet87@gmail.com>
X-Google-Original-From: Tyllis Xu <LivelyCarpet87@gmail.com>
To: netdev@vger.kernel.org
Cc: haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	nnac123@linux.ibm.com,
	sukadev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	danisjiang@gmail.com,
	ychen@northwestern.edu,
	Tyllis Xu <LivelyCarpet87@gmail.com>
Subject: [PATCH] ibmvnic: fix OOB array access in ibmvnic_xmit on queue count reduction
Date: Fri, 20 Mar 2026 22:54:39 -0500
Message-ID: <20260321035439.900644-1-LivelyCarpet87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,vger.kernel.org,gmail.com,northwestern.edu];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-270165-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[livelycarpet87@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0981B2E32A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the number of TX queues is reduced (e.g., via ethtool -L), the
Qdisc layer retains previously enqueued skbs with queue mappings from
before the reduction. After the reset completes and tx_queues_active is
set to true, netif_tx_start_all_queues() drains these stale skbs through
ibmvnic_xmit(). The queue index from skb_get_queue_mapping() may exceed
the newly allocated array bounds, causing out-of-bounds reads on
tx_scrq[] and tx_pool[]/tso_pool[], and out-of-bounds writes on
tx_stats_buffers[] in the function's exit path.

The existing tx_queues_active guard does not help here: it is set to
true by __ibmvnic_open() before netif_tx_start_all_queues() restarts
queue draining, so stale skbs pass the check with an invalid queue index.

Add a bounds check against num_active_tx_scrqs immediately after the
tx_queues_active guard. Use a dedicated out_unlock label to skip the
per-queue stats updates (which also index tx_stats_buffers[queue_num])
when the queue index is invalid.

Fixes: 4219196d1f66 ("ibmvnic: fix race between xmit and reset")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5a510eed335e..c939391474cb 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2453,6 +2453,11 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		goto out;
 	}
 
+	if (unlikely(queue_num >= adapter->num_active_tx_scrqs)) {
+		dev_kfree_skb_any(skb);
+		goto out_unlock;
+	}
+
 	tx_scrq = adapter->tx_scrq[queue_num];
 	txq = netdev_get_tx_queue(netdev, queue_num);
 	ind_bufp = &tx_scrq->ind_buf;
@@ -2672,6 +2677,9 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	adapter->tx_stats_buffers[queue_num].bytes += tx_bytes;
 	adapter->tx_stats_buffers[queue_num].dropped_packets += tx_dropped;
 
+	return ret;
+out_unlock:
+	rcu_read_unlock();
 	return ret;
 }
 
-- 
2.43.0


