Return-Path: <netdev+bounces-257964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IHBK7oOimlrGAAAu9opvQ
	(envelope-from <netdev+bounces-257964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 17:43:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1403E1129E6
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 17:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A427303D320
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 16:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFCA3816F6;
	Mon,  9 Feb 2026 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVVj18rY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11B91F3BA4
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655177; cv=none; b=MxQsYvGxPRlC0OlWlNG51VViGtRWIZwJ1gJVfSAOs71qpHS6ltECpVkbm3ZSRPJpC8S4/Tp3Ilt4C2OCZxc7x+zicDbCDil2IzLWUrIzhFedi2kZdOfKQGVVQoBN2Pd5nYTOFN9mL30LhQsBqHDycn3MXRYRwOc5fTE0VUQdbV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655177; c=relaxed/simple;
	bh=LoBEqPy8I+2czfLoGnPGRGZnQbST8g0CRKGE1oLtWIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W6DBruK32rcSFDR1XDOKM35rGZ9dWAurPu1NTFEw8IAg/4TeSU1V3l8R+Sfi6D5mTGt7nGrxfbVMUW0u4Wy06sxGbhGQXLG+ga8+h/rs0j8NLT1BG7PrupoVPS9o1L88CHYhNH3QNXSM8dOKPdDZbLhlWAEE9+/1GfrDXBFEV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVVj18rY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-81f38d974e0so629647b3a.0
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 08:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770655177; x=1771259977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DjornqGgioX/jnYpst1ow5ojhAPXQxplwWvTiLVkT34=;
        b=BVVj18rYLVg4Kgx0wKCLzI2WyU/f1n3cOvzG1Jgrq9pEZVjXBM7eTI3to1bknsfQWa
         UT3XAE/RWt8yl1kZwXvcdP+MULaH/u0lT0vdeGQLNuTxkGID+WojtNl7Z67kWgCwFYQX
         W2oFmyZk1JKfmQ4ayNakbEgBZ5XRu1DWGOTaVuzGNr0yDIeoJYz1AmnzVt2z7AVhswvW
         2477TtTmL1oGQjNYIjqbd8WnNNFFf8Bh7Com4KVBB4dlbtBhozT+Wnxd9C4CJNKph955
         JGHZwYy0Qhv3SYizI1J8KP91FIro9hMxi8mqb0DTMlP3+IRoLoi7fi1mfVhb4BkR6gVJ
         AP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770655177; x=1771259977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjornqGgioX/jnYpst1ow5ojhAPXQxplwWvTiLVkT34=;
        b=Cd3i+OhDy+OEIeQ8ayePMRoleKIo/eQHGLks3lypwW2n7YlOiXlY7zKP5baKbfVHlg
         v9E3Ivkq6p95/7fDcQMzQWqycV3wkRufbzUZ2G/NLYNh5lwDv1PW64lssq6tmNq0wjcj
         +/DU7huxTluwiJm8ZYDp5yhyNnk/k3uJQzjPwStBdAIK/FDkxqgVXo3lTfr4NMy7d3j+
         xMLu2i1gfKfSRdDV9oLfqlfv6aeKbLzSAGw6L6rg9qui1wviz0lWFg/FX7WmQMkIiydK
         Z3cN98+3ysechs1NDdQdCnuiwTdXuDsfD8iIcZqJRGBX+bKCwPanPyH4L7qw/5l8hEsO
         jGLw==
X-Gm-Message-State: AOJu0YwxZRr+1BMdSxHX3byBd6WiA7U+53wd5/nFixui5t2Jpijm1Xyc
	x5VKjSiq1zMaQRA6iO4esEm2tIe28EbWaDWItYFcldFAvSM8aFRZ32Hc
X-Gm-Gg: AZuq6aK1w/RquoO4Wz+VsEPpn7VFEeniuZqP+Zy3f1QJ3lvCzeEPfUVa3Z0U4thj6py
	CJZ6C0KsZ3bSm/WPG1tl5NEIcmWp+CHzYxnR+cW6BUBVAjtGTmVHHg5N3XoxIZzRoR1i4MUw9J5
	uXEUGSpGvdx78RAgZ8atArbXvVVgb3WHQQP3P69geuV3T3786odHeO4p1WL4/vO7oQ3vf7QTFSG
	zQ6QT0ZegGM/Feyvlw7zsGwev6rJ+Ud6m07XXYBr3lIqspNokrAP6+huQwKtkc4K4A7wKSgYWnc
	VdWUR+XU3PsgcnzqS+kjoSptDxn3GRVRNROhN42ocB6fUqYkwAzDfSaM718N/ZiyZ2ZTlO2Z0pE
	G3goqjae3B3TXtF6R1a/7lWuyNCCImE2IOHxhc5SecrAibWQhyDtLaP9c//eer8dNXcweAhCviA
	LitB05cr75wc/lfikSoNmWlVeGNcXIYU9www3bvcFZZbuYBKRBJ2tXGwwlPfQ=
X-Received: by 2002:a17:90b:564d:b0:340:b8f2:24fa with SMTP id 98e67ed59e1d1-354b3c659c8mr7145374a91.2.1770655176912;
        Mon, 09 Feb 2026 08:39:36 -0800 (PST)
Received: from 3ce1e5d2d1b2.cse.ust.hk (191host009.mobilenet.cse.ust.hk. [143.89.191.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e531desm15794a91.2.2026.02.09.08.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 08:39:36 -0800 (PST)
From: Chengfeng Ye <dg573847474@gmail.com>
To: kernel-team@meta.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jacob.e.keller@intel.com,
	lee@trager.us,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] fbnic: close fw_log race between users and teardown
Date: Mon,  9 Feb 2026 16:38:54 +0000
Message-Id: <20260209163854.521415-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257964-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dg573847474@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1403E1129E6
X-Rspamd-Action: no action

Fixes a theoretical race on fw_log between the teardown path and fw_log
show/write functions.

The fw_log null check was performed outside the lock in both
fbnic_dbg_fw_log_show() and fbnic_fw_log_write() (called from debugfs
paths or mailbox threaded IRQ handler). Concurrent teardown in
fbnic_fw_log_free() could clear and free the log buffer after the check
because there is no proper synchronization, leading to list traversal or
buffer access on freed memory.

fbnic_fw_log_write() can be reached from the mailbox handler
fbnic_fw_msix_intr(), but fbnic_fw_log_free() runs before IRQ/MBX
teardown. fbnic_dbg_fw_log_show() runs via debugfs and seems to be
not synchronized with removal either.

Possible Interleaving scenario:
  CPU0: fbnic_dbg_fw_log_show() or fbnic_fw_log_write()
          if (fbnic_fw_log_ready())   // true
          ... preempt ...
  CPU1: fbnic_fw_log_free()
          vfree(log->data_start);
          log->data_start = NULL;
  CPU0: continues, walks log->entries or writes to log->data_start

Move readiness checks under the fw_log spinlock, and clear the log state
under the same lock in fbnic_fw_log_free() before freeing the buffer.
This makes readers/writers mutually exclusive with teardown.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   |  8 ++++---
 .../net/ethernet/meta/fbnic/fbnic_fw_log.c    | 21 +++++++++++++------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
index b7238dd967fe..4171dde590fc 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
@@ -176,11 +176,13 @@ static int fbnic_dbg_fw_log_show(struct seq_file *s, void *v)
 	struct fbnic_fw_log_entry *entry;
 	unsigned long flags;
 
-	if (!fbnic_fw_log_ready(fbd))
-		return -ENXIO;
-
 	spin_lock_irqsave(&fbd->fw_log.lock, flags);
 
+	if (!fbnic_fw_log_ready(fbd)) {
+		spin_unlock_irqrestore(&fbd->fw_log.lock, flags);
+		return -ENXIO;
+	}
+
 	list_for_each_entry_reverse(entry, &fbd->fw_log.entries, list) {
 		seq_printf(s, FBNIC_FW_LOG_FMT, entry->index,
 			   (entry->timestamp / (MSEC_PER_SEC * 60 * 60 * 24)),
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
index 85a883dba385..d371932435e5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
@@ -59,16 +59,24 @@ int fbnic_fw_log_init(struct fbnic_dev *fbd)
 void fbnic_fw_log_free(struct fbnic_dev *fbd)
 {
 	struct fbnic_fw_log *log = &fbd->fw_log;
-
-	if (!fbnic_fw_log_ready(fbd))
-		return;
+	unsigned long flags;
+	void *data;
 
 	fbnic_fw_log_disable(fbd);
+
+	spin_lock_irqsave(&log->lock, flags);
+	if (!fbnic_fw_log_ready(fbd)) {
+		spin_unlock_irqrestore(&log->lock, flags);
+		return;
+	}
+	data = log->data_start;
 	INIT_LIST_HEAD(&log->entries);
 	log->size = 0;
-	vfree(log->data_start);
 	log->data_start = NULL;
 	log->data_end = NULL;
+	spin_unlock_irqrestore(&log->lock, flags);
+
+	vfree(data);
 }
 
 int fbnic_fw_log_write(struct fbnic_dev *fbd, u64 index, u32 timestamp,
@@ -80,13 +88,14 @@ int fbnic_fw_log_write(struct fbnic_dev *fbd, u64 index, u32 timestamp,
 	unsigned long flags;
 	void *entry_end;
 
+	spin_lock_irqsave(&log->lock, flags);
+
 	if (!fbnic_fw_log_ready(fbd)) {
+		spin_unlock_irqrestore(&log->lock, flags);
 		dev_err(fbd->dev, "Firmware sent log entry without being requested!\n");
 		return -ENOSPC;
 	}
 
-	spin_lock_irqsave(&log->lock, flags);
-
 	if (list_empty(&log->entries)) {
 		entry = log->data_start;
 	} else {
-- 
2.25.1


