Return-Path: <netdev+bounces-258813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGe6BGRXkmmjtAEAu9opvQ
	(envelope-from <netdev+bounces-258813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 00:31:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8189D140163
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 00:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5653930097C2
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 23:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A8C221DB1;
	Sun, 15 Feb 2026 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxgcbX2w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3126A1D8E01
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 23:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198291; cv=none; b=P2MixjlsXkFMe44mfOZmaQ1s8ASvoSsHcdfK10zAb1WdKgwYhOYc4wTpkLu+BaEyxjStzXe+DV8whubokmoIqFjkAdVBxWIuIX1ZKmzZwu5DrEIX6PfTK2uWSYuEAmcvTDCEc+CuOlZHORjHOkEMcgDKEZV92YiRYNSNhgJqEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198291; c=relaxed/simple;
	bh=/UTZ3+eESrAxvzZCIeUe9RqgzV+4GH08uO+QHKmgYvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YX7H3nebUgptyz/vN0LvJeouTlv9bNl+tyOoxuoZLJGIYcft4rhZqfy+uUhGCtb4L5kAF65AzU9eV0Rt/cgvcy3EAq5yb/UMGoGGxm/DNg9S90iSVTlNrnj+m38RWgDtU7LKz3/cJVLTwshPv0LoIvn/RQ2TDpWTPsLP9vHh2qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxgcbX2w; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so25732355e9.2
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 15:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771198288; x=1771803088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=StVXhxzh9g9psFpbjyJgn5evB1o+q9oCzqQx6kpImaM=;
        b=LxgcbX2wis8B9KUKx89WHjhR7rDv4RLlywBc79iI2Ef033eYbgO8b1B/mwBpC4UNPZ
         tTeNliqHe0hb9K8TpqflQ/T7C8pETy/5X+VmEJq6nb/uOmahFOJtYHWOdYdDVqPaS4iG
         9WJBYvW/T67Eq/L26wsQjAnuCXr0yVWjVtwNb6NYtw3bfA5C6WY5xspsvCI7XDE1D5hR
         VVuEQMf1jqMdXLcL7Ibd2x38+SQG4SE4ZU5IHn0AupZ+zRWc6U7fEF5F5z4zdZaWL+rA
         2qWJRyF6a4fLbYzn/K7UDsreWtDuyqzLX0aLGiyIjp2i5mmykdXp3baojL7djx5au/3T
         swxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771198288; x=1771803088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StVXhxzh9g9psFpbjyJgn5evB1o+q9oCzqQx6kpImaM=;
        b=feZGnl+9BGsjFxUlVgGy3PeEmXABrIRcZ72P3tALWEuv7XXxQ+qE6HidZ0HWO7Nue9
         krw7LZiPJU3JTaV4DFgUsgamhA0JVAJrrF7/2cBu3KDnNdwMN6HClwJUI93M2Z4ZuK0+
         RIzE7HSpYlEqOuh0F+NwjSHVlyDJRBUs4TC7vpuzMmfqNGwej6QZWw6lQvA97BgOKF+Y
         Efd1036TXADHT93DUbFGsxIz3o7l+iVLVBTa43J+xL7SgGcReU9BWf64wkJmegBO2VOG
         kv+A+jepRTC/XptjZHLYCafVYVTlBILvliaenOjbIBktgGcvw86SImL+isWgMDwJVgtg
         POww==
X-Forwarded-Encrypted: i=1; AJvYcCXlx0aYBvL9sz/0H9wwUQo99JMy5viCJCS5m4CSgJIG7wo+ic7Xymv2sTedZIYvqt6FRArN3mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQfREb7wAcPTl7jatSYcngn+iH0UQBJv8ob2NaDr5kpipAxzTh
	l/fulk8wABzELtrs8UKUM0lP4RGTVVBWc23dzxWyQOHVxhW1nziRnpyl
X-Gm-Gg: AZuq6aKuA2K+YyHLlPqrqgTF4yCslTKcvMnnY/SnD4N1/QQGrW2QNtOB0r7vbj+CTH8
	c45LEPHvQKIkEGXkN/JX8o4PrtVsKQLcvq10UIHUCF1nqt2fJsaS6m6HTnSotCgJEyxdfgOrApb
	ST1fMQrcN2J/3I7bTJMZpE3LWbiDKL2EXOl78uCHd4vtsWC/1tTG5hTQnnLqrueWlY9jm/TtacP
	r8rZBwkNPlCl9Xu8bSjckOOICVPsrxplYQoNLOUqn2fTL2zs+j33t1s9d7Nqe3lihojno31qYlc
	SowPTVV1cu0TUbKV3HLamzdl7+Zbwr0uqaFFAMezTBgL97C97ChwHigfC+9PQxm9IZ/qU3WssMT
	F8uHZU76cF7BugFODpCYbGHoeKVFJTSbH57g7+S1Xv+IEtYUsvtLN2T710nisnTfDIxGm+34a4r
	5JK/XRgbYXnlvjs2e8/uwQFOHmeZ0/b/e6/8zhyf1fa4p8txhczwGXXmkB0B8rXrSeGXtdXuxN/
	VkQ4RWP9P5WrqVV8mNGRXXoEun58Q==
X-Received: by 2002:a05:600c:524d:b0:483:4807:210c with SMTP id 5b1f17b1804b1-48373a5d7a0mr179075505e9.24.1771198288454;
        Sun, 15 Feb 2026 15:31:28 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ad112bsm22924803f8f.36.2026.02.15.15.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 15:31:27 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] io_uring/zcrx: move zcrx uapi into separate header
Date: Sun, 15 Feb 2026 23:31:20 +0000
Message-ID: <14826e580830261478a74ed89941694538209bab.1771198073.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258813-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8189D140163
X-Rspamd-Action: no action

Split out zcrx uapi into a separate file. It'll be easier to manage it
this way, and that reduces the size of a not so small io_uring.h. Since
there are users that expect that zcrx definitions come with io_uring.h,
it includes the new file.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

Depends on the patch that added querying zcrx features


 include/uapi/linux/io_uring.h      |  96 +------------------------
 include/uapi/linux/io_uring/zcrx.h | 108 +++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 94 deletions(-)
 create mode 100644 include/uapi/linux/io_uring/zcrx.h

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 6750c383a2ab..7a70ec70ff04 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -10,6 +10,8 @@
 
 #include <linux/fs.h>
 #include <linux/types.h>
+#include <linux/io_uring/zcrx.h>
+
 /*
  * this file is shared with liburing and that has to autodetect
  * if linux/time_types.h is available or not, it can
@@ -1049,100 +1051,6 @@ struct io_timespec {
 	__u64		tv_nsec;
 };
 
-/* Zero copy receive refill queue entry */
-struct io_uring_zcrx_rqe {
-	__u64	off;
-	__u32	len;
-	__u32	__pad;
-};
-
-struct io_uring_zcrx_cqe {
-	__u64	off;
-	__u64	__pad;
-};
-
-/* The bit from which area id is encoded into offsets */
-#define IORING_ZCRX_AREA_SHIFT	48
-#define IORING_ZCRX_AREA_MASK	(~(((__u64)1 << IORING_ZCRX_AREA_SHIFT) - 1))
-
-struct io_uring_zcrx_offsets {
-	__u32	head;
-	__u32	tail;
-	__u32	rqes;
-	__u32	__resv2;
-	__u64	__resv[2];
-};
-
-enum io_uring_zcrx_area_flags {
-	IORING_ZCRX_AREA_DMABUF		= 1,
-};
-
-struct io_uring_zcrx_area_reg {
-	__u64	addr;
-	__u64	len;
-	__u64	rq_area_token;
-	__u32	flags;
-	__u32	dmabuf_fd;
-	__u64	__resv2[2];
-};
-
-enum zcrx_reg_flags {
-	ZCRX_REG_IMPORT	= 1,
-};
-
-enum zcrx_features {
-	/*
-	 * The user can ask for the desired rx page size by passing the
-	 * value in struct io_uring_zcrx_ifq_reg::rx_buf_len.
-	 */
-	ZCRX_FEATURE_RX_PAGE_SIZE	= 1 << 0,
-};
-
-/*
- * Argument for IORING_REGISTER_ZCRX_IFQ
- */
-struct io_uring_zcrx_ifq_reg {
-	__u32	if_idx;
-	__u32	if_rxq;
-	__u32	rq_entries;
-	__u32	flags;
-
-	__u64	area_ptr; /* pointer to struct io_uring_zcrx_area_reg */
-	__u64	region_ptr; /* struct io_uring_region_desc * */
-
-	struct io_uring_zcrx_offsets offsets;
-	__u32	zcrx_id;
-	__u32	rx_buf_len;
-	__u64	__resv[3];
-};
-
-enum zcrx_ctrl_op {
-	ZCRX_CTRL_FLUSH_RQ,
-	ZCRX_CTRL_EXPORT,
-
-	__ZCRX_CTRL_LAST,
-};
-
-struct zcrx_ctrl_flush_rq {
-	__u64		__resv[6];
-};
-
-struct zcrx_ctrl_export {
-	__u32		zcrx_fd;
-	__u32 		__resv1[11];
-};
-
-struct zcrx_ctrl {
-	__u32	zcrx_id;
-	__u32	op; /* see enum zcrx_ctrl_op */
-	__u64	__resv[2];
-
-	union {
-		struct zcrx_ctrl_export		zc_export;
-		struct zcrx_ctrl_flush_rq	zc_flush;
-	};
-};
-
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/uapi/linux/io_uring/zcrx.h b/include/uapi/linux/io_uring/zcrx.h
new file mode 100644
index 000000000000..3163a4b8aeb0
--- /dev/null
+++ b/include/uapi/linux/io_uring/zcrx.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT */
+/*
+ * Header file for the io_uring zerocopy receive (zcrx) interface.
+ *
+ * Copyright (C) 2026 Pavel Begunkov
+ * Copyright (C) 2026 David Wei
+ * Copyright (C) Meta Platforms, Inc.
+ */
+#ifndef LINUX_IO_ZCRX_H
+#define LINUX_IO_ZCRX_H
+
+#include <linux/types.h>
+
+/* Zero copy receive refill queue entry */
+struct io_uring_zcrx_rqe {
+	__u64	off;
+	__u32	len;
+	__u32	__pad;
+};
+
+struct io_uring_zcrx_cqe {
+	__u64	off;
+	__u64	__pad;
+};
+
+/* The bit from which area id is encoded into offsets */
+#define IORING_ZCRX_AREA_SHIFT	48
+#define IORING_ZCRX_AREA_MASK	(~(((__u64)1 << IORING_ZCRX_AREA_SHIFT) - 1))
+
+struct io_uring_zcrx_offsets {
+	__u32	head;
+	__u32	tail;
+	__u32	rqes;
+	__u32	__resv2;
+	__u64	__resv[2];
+};
+
+enum io_uring_zcrx_area_flags {
+	IORING_ZCRX_AREA_DMABUF		= 1,
+};
+
+struct io_uring_zcrx_area_reg {
+	__u64	addr;
+	__u64	len;
+	__u64	rq_area_token;
+	__u32	flags;
+	__u32	dmabuf_fd;
+	__u64	__resv2[2];
+};
+
+enum zcrx_reg_flags {
+	ZCRX_REG_IMPORT	= 1,
+};
+
+enum zcrx_features {
+	/*
+	 * The user can ask for the desired rx page size by passing the
+	 * value in struct io_uring_zcrx_ifq_reg::rx_buf_len.
+	 */
+	ZCRX_FEATURE_RX_PAGE_SIZE	= 1 << 0,
+};
+
+/*
+ * Argument for IORING_REGISTER_ZCRX_IFQ
+ */
+struct io_uring_zcrx_ifq_reg {
+	__u32	if_idx;
+	__u32	if_rxq;
+	__u32	rq_entries;
+	__u32	flags;
+
+	__u64	area_ptr; /* pointer to struct io_uring_zcrx_area_reg */
+	__u64	region_ptr; /* struct io_uring_region_desc * */
+
+	struct io_uring_zcrx_offsets offsets;
+	__u32	zcrx_id;
+	__u32	rx_buf_len;
+	__u64	__resv[3];
+};
+
+enum zcrx_ctrl_op {
+	ZCRX_CTRL_FLUSH_RQ,
+	ZCRX_CTRL_EXPORT,
+
+	__ZCRX_CTRL_LAST,
+};
+
+struct zcrx_ctrl_flush_rq {
+	__u64		__resv[6];
+};
+
+struct zcrx_ctrl_export {
+	__u32		zcrx_fd;
+	__u32 		__resv1[11];
+};
+
+struct zcrx_ctrl {
+	__u32	zcrx_id;
+	__u32	op; /* see enum zcrx_ctrl_op */
+	__u64	__resv[2];
+
+	union {
+		struct zcrx_ctrl_export		zc_export;
+		struct zcrx_ctrl_flush_rq	zc_flush;
+	};
+};
+
+#endif /* LINUX_IO_ZCRX_H */
-- 
2.52.0


