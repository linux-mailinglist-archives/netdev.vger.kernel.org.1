Return-Path: <netdev+bounces-286687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFMYKSTqAWpHmQEAu9opvQ
	(envelope-from <netdev+bounces-286687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:39:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E600510550
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0131730817C3
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6048E3FE65F;
	Mon, 11 May 2026 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgyXpWtA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3633FE35E
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510071; cv=none; b=pqq6DApfswW3Y9PToXXhDYRKsim5Zse2EMIcd3IQltZncsmdLKJxkyej+MiDnUuptSLt5gbAt4cu/cssUK25Yc0Q3fQOIhVnJq5fR8b3yD9dTSokc/C0lyRJFMCQmvU9HQoVk18ZYFN4j7lTE1WkvSK4kvPmA+Jrex97XtjoUj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510071; c=relaxed/simple;
	bh=YfQBPQevPYy6KNEQoGGylmuoML0doP9gf/WL6NN7rD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gG3s/VDyafrOBoXEJwe68dKj5zw/LXAG+QjizkQrcFSUqM2kZySzwR5cEy67IGeAi2Ew6X7ngksM/4hXOTsf2bL95OF6uU/A3Gs+lKGK8AaQJpmeonwR0iR+sMeVcXUCc3yiBEAgenUv934DD0gvHOuOyL27nzPXEKwo4Rg2GzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgyXpWtA; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-512f750d4b2so34797641cf.1
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778510067; x=1779114867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9wLQan2nN7eJ+L05d+IVGFJIfDrs/6xj1WgA6VgIXY=;
        b=mgyXpWtAZItRMUrplVrjLGFLAbdt1IiVgETfNpAp5ZYavJAZfJD4rlQhtgAT/7fU6w
         LgENAPsX1AEXjTGRN+jG5D/nbxPIjQZhgyy+KnakR98ik5JUziBhLllmvaZXEqc7D/bq
         e8lGfsP632l3lNguCtwroEqWkCeEp58xNWzYZ+ADAbI9A1yuCmsBe74JiR5NNoH9PByk
         OuhGZNQNpqiuK308yDBNUNYWcNhC6Kl1QZo7+unHQw+h0AxaNx+EOB+58MfoeplWdZM8
         cswM4kCaQsigdj56XE4eYFPeM6SbhzfEh7WxY1usNUEJI2Z+G3GhJeqsrmquuEW+oPaQ
         N1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510067; x=1779114867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H9wLQan2nN7eJ+L05d+IVGFJIfDrs/6xj1WgA6VgIXY=;
        b=nS2NeH4HNptbQ5C282D2SCNjaVDjP6zBqHuo9BL/zJ72VYz3cQzIF2A4JW/osFFFvl
         3FLCfm76iwhR3GPdNEmWq/CogQBxvrpwTL1ZqsAPXhe5LUPbSKVi5gmrjJkCmCpm7NQ3
         LlRgFlMpC4ZMuiAzdNPoWDBHAPZMJx7qx1tj5FBDq26WGyrmuvaxcnnhiLFL6dainRGz
         0NeZLI4sBzwve7uO9+I8lXhJTOTYRsqdtTPbdQLYTNW+/Gsu/Z1wwnifefpTjrioqpWY
         uMkGcvHIS1lGkiEhSd4jl0rWrPoKVHoVQRvVtaLnlBbFO6Wqj4we71A5ce6vqweCe/67
         wbwA==
X-Forwarded-Encrypted: i=1; AFNElJ+HKXhdYY41FwGZH80DioUgEtzTq9FDCKmx9x4tsN8BO5PWLzDRm70pv81/2RH6A60LGOpObYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy20/f36a1Kfdg1z22Vjq3bHdZWdosO3g4tlP4hM6EmEh30Aka2
	ILpzzpVjYqkQe+/qlPwBNLZpoqSrBVZmP7f+TRaVdvOjBAheXQ/apxn/
X-Gm-Gg: Acq92OHHVkRVcJzlgZBXM0bLQVJrr0ZpF0A5yo8Ie+iLrak+m1P9PHPeETamKdYuaiV
	AOq+LEVjAjLXaRhUNikNlqNjdk5oE5h19Oec1T1z0lscdUzTmaJox09nKheSRaHhpTaWG2XiEcD
	1RYyrXBJP6fTgUvZpQRtnqEE+VPqt8ySg6VfLks2lGEDgqG1UX/25G4K1JrBgGlTTcDoDE3Gc03
	uNOROdINH5jQyL2l2nHkLRWBgK9aLA1eG0P8Wj5qA80Nvsj6/j+CIkO6XToW+eNyJkBTBBaIDgP
	+ovtEyN3jjLjObhaFM36Ha6maQYpbgjta3JWOClsLsCQt6xp1FT1Vg62apv6bUU40XKk95wNlEt
	4pDbXgvzthq54ypUBcb1s2sfgDi/X1Kqp+YjXR6VmpeWlpYl/+/uLRQ5Uggij8E+7a0s8kQotXL
	+opjvTk9sW4Bp3AwGZeBpieft7PcMIRPPfVoxFU/5d+dNJETNbGeg4H5AoNeSuo+lROfY8BMJQy
	AWgpIIN8OKf1qY0x+EQJCXes6tRv1dfQMInEURdqwOVorl1PbQ70w==
X-Received: by 2002:a05:622a:48:b0:50e:a1aa:2cd9 with SMTP id d75a77b69052e-51461c04ebbmr342766301cf.15.1778510066287;
        Mon, 11 May 2026 07:34:26 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e83aa2bsm90605371cf.28.2026.05.11.07.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:34:25 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mat Martineau <martineau@kernel.org>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Pauli Virtanen <pav@iki.fi>,
	Aaron Esau <git@aaronesau.com>,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH 1/4] Bluetooth: hci_sync: pin conn across hci_le_create_conn_sync
Date: Mon, 11 May 2026 10:34:01 -0400
Message-ID: <490e228dd02983fb1530fb114d4174148f810261.1778506829.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778506829.git.michael.bommarito@gmail.com>
References: <cover.1778506829.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0E600510550
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286687-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iki.fi,aaronesau.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.923];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

hci_le_create_conn_sync() runs from the cmd_sync workqueue with a
struct hci_conn pointer it interprets out of the work item's void
*data argument. The hci_conn_valid() check at function entry is a
TOCTOU: nothing prevents hci_disconn_complete_evt() (executing on
hdev->workqueue rx_work) from running between the
hci_conn_hash_lookup walk in hci_conn_valid() and the body's first
deref. hci_disconn_complete_evt() -> hci_conn_del() -> hci_conn_cleanup()
unregisters the device and drops the final kref, which kfrees the
hci_conn slot. The cmd_sync callback then writes through the freed
pointer (clear_bit on conn->flags, conn->state, the four
le_conn_*_interval fields).

A KASAN slab-use-after-free splat in cache kmalloc-8k confirms the
bug on linux-next tip commit bee6ea30c487 ("Add linux-next specific
files for 20260421") under UML+KASAN, matching the slab geometry of
the syzbot trace fixed in commit 035c25007c9e ("Bluetooth: hci_sync:
Fix UAF in le_read_features_complete").

Follow the reference-pinning pattern from commit 035c25007c9e
("Bluetooth: hci_sync: Fix UAF in le_read_features_complete") and
commit 0beddb0c380b ("Bluetooth: hci_conn: fix potential UAF in
create_big_sync"): the queue site takes a reference via
hci_conn_get() so the slot is not freed between
hci_disconn_complete_evt() retiring the conn and the cmd_sync
callback / completion handler returning. The completion handler
drops the reference on every exit path, including the -ECANCELED
short-circuit.

Introduce a static helper hci_cmd_sync_queue_conn_once() so the
get/put pair is not open-coded at every queue site. See the
helper's kerneldoc for the -EEXIST contract.

The hci_conn_valid() check in the callback body is retained: a
logically-deleted-but-still-referenced conn has stale
hdev->conn_hash.list state, and continuing to drive a connection
attempt on it would be a logic bug even though the memory is safe.

Pauli Virtanen posted a series-wide variant of this fix as
https://lore.kernel.org/linux-bluetooth/e18591f264c50e15917cb8b9e5f9798d9880979d.1762100290.git.pav@iki.fi/
(PATCH v2 8/8, 2025-11-02). KASAN reproducer captured under
UML+KASAN (linux-next tip bee6ea30c487).

Fixes: 881559af5f5c ("Bluetooth: hci_sync: Attempt to dequeue connection attempt")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/bluetooth/hci_sync.c | 41 ++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fd3aacdea512..b20e07474257 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -786,6 +786,31 @@ int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 }
 EXPORT_SYMBOL(hci_cmd_sync_queue_once);
 
+/* Queue an HCI command entry once, pinning a hci_conn for the duration.
+ *
+ * On success, the cmd_sync queue owns one hci_conn_get() reference;
+ * the supplied destroy callback must hci_conn_put() to balance.
+ *
+ * On any failure return (including -EEXIST, where
+ * hci_cmd_sync_queue_once() neither invokes destroy nor consumes the
+ * data pointer because an existing entry already owns the slot), the
+ * helper releases the reference before returning, so callers do not
+ * need to discriminate failure codes to keep the refcount balanced.
+ */
+static int hci_cmd_sync_queue_conn_once(struct hci_dev *hdev,
+					hci_cmd_sync_work_func_t func,
+					struct hci_conn *conn,
+					hci_cmd_sync_work_destroy_t destroy)
+{
+	int err;
+
+	err = hci_cmd_sync_queue_once(hdev, func, hci_conn_get(conn), destroy);
+	if (err)
+		hci_conn_put(conn);
+
+	return err;
+}
+
 /* Run HCI command:
  *
  * - hdev must be running
@@ -6982,36 +7007,38 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 	bt_dev_dbg(hdev, "err %d", err);
 
 	if (err == -ECANCELED)
-		return;
+		goto done;
 
 	hci_dev_lock(hdev);
 
 	if (!hci_conn_valid(hdev, conn))
-		goto done;
+		goto unlock;
 
 	if (!err) {
 		hci_connect_le_scan_cleanup(conn, 0x00);
-		goto done;
+		goto unlock;
 	}
 
 	/* Check if connection is still pending */
 	if (conn != hci_lookup_le_connect(hdev))
-		goto done;
+		goto unlock;
 
 	/* Flush to make sure we send create conn cancel command if needed */
 	flush_delayed_work(&conn->le_conn_timeout);
 	hci_conn_failed(conn, bt_status(err));
 
-done:
+unlock:
 	hci_dev_unlock(hdev);
+done:
+	hci_conn_put(conn);
 }
 
 int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_le_create_conn_sync, conn,
-				      create_le_conn_complete);
+	err = hci_cmd_sync_queue_conn_once(hdev, hci_le_create_conn_sync, conn,
+					   create_le_conn_complete);
 	return (err == -EEXIST) ? 0 : err;
 }
 
-- 
2.53.0


