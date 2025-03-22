Return-Path: <netdev+bounces-176935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719A8A6CC69
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 21:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF89A1899D63
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 20:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0748323643F;
	Sat, 22 Mar 2025 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Z6Kltw/i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392B5235C1E
	for <netdev@vger.kernel.org>; Sat, 22 Mar 2025 20:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675786; cv=none; b=Vhsu247bSHzuPpmjrZUIWKKbnh0tfYXfp2qUFEbAt6Ex9NZ9oBXmSlhXpM/voCNFLpH+/eSMBwmPvJxVl+TUE7LV5eIT3gXQvlGj6fiDlSlvx9r7G6xSogavKkOk+fLQXzrjMYK30VzQuUPajN8oqnsY73VT4n8jJbhVkpPrnFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675786; c=relaxed/simple;
	bh=qbvFSXXlRxEZRsSQ1rGR/kY5wbhIub0fjCD9kgQy4iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXPMWWZ/JrXkVOEH6QfUz9y6MC14INXLJUEXsXgIaZylrOnLBzOXQ8oHOrsc92spyPuXuHB7Tjz5bREZNw0HbAIuLMrJ4kprIYOWwHFqePHg6kqeiSE/cSu4oG2rSkag6ot9N/L+CgMnRIIIiUzxh7Xzl3fPMX0XRSLAOg8V5PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Z6Kltw/i; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso5213001a91.1
        for <netdev@vger.kernel.org>; Sat, 22 Mar 2025 13:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742675784; x=1743280584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+I4oPHJF+38GJ8m5lCV4gA9QS6Q49rkDipJxmeTXcI0=;
        b=Z6Kltw/i6kaKIXCk8l+lP+ERWp+RLs19yqq5uJcRofu3ZFcKi254gfhq9BSY0lqNLn
         2w+w1sIZTdIDzSYaedhAoYze91xY2lnAAyCfxA2Kco0lYFxr0qzNfLvtuaEOdLxfQIJ+
         P0k7JbkJxKxoGS16hhZjpYGGGTAufdPLqL5q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742675784; x=1743280584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+I4oPHJF+38GJ8m5lCV4gA9QS6Q49rkDipJxmeTXcI0=;
        b=kRfMg9VbgtWPLGPertqhZCSvd6gxclm8G104JX1PgNpy0XBIVElK+ZWZv+drTB/z3t
         7Iuw40oJnsJGCwHpHgocHlzaRFfM0Pwt1Psed7hygujAXRXAmTZcTSuScKhUbEKc3YYW
         PA98X7ZeZlZX05UYS286Vr3Cfq7BQl7y3/Fx9aZwiOFk7BSHsrIUbf2i1fOXqYVEfspg
         ZiYBNkTPEOC1Vh5SY7ZcYzZGFLqtCTi8HUnH3NO6uilHdUm6C8lJ7l6ghZUjGncMhXo4
         9Y/gPKh2emGdVxh21NU9T9P+qhLg2hlfJ0DUEo5XVa8v3F+jPjoHbSCoCyCy4Xlx+h3O
         rEcQ==
X-Gm-Message-State: AOJu0YzG6RhXpjptF6ZluPxZeklWZ5ZzXS8ILl1Fi20yoNL5CVXif6q1
	MLNtjZP1xqOjcqiZKdLHrwKRDCEU/OAM6yQra4v9QYDCVRARO4ebFdCQVDN6Fqs=
X-Gm-Gg: ASbGncudCk9gDYj/f8/bQvtm149kHQccYo7BrMQ6Dqdf/9odBkDJbJvoSG2p+5OPXim
	c4iNiQpKT6SphpjPrMLudplyYU9q20mtGkqc6jnVfuqlhEzbo2PXZJ92EefVUFfUl7YEIFtsLII
	hJ6UMM0LC3VjAXZzy9tCu/D+/FZAEN/N8Hp5gbN2iL6BjCBNC85/MvSHBYRGzJK711yzkDt15rE
	vuRuqfjRoYN6Y31+arDnibl7tgqxh0Ko/Vlw4vhNaaE64YjghlYuZ7acFe0pBxJyzlDIoXLV9zv
	mJ/beA4Loxdh7k/jC/JL2gOZvwdlhdIz4uSL83Td6z+0bih4I80E
X-Google-Smtp-Source: AGHT+IHyoOis/rjHSFfuKccf8c+BZff1uWR7a/+owtf4wmyADvnt9ZNo6zx7hov+57H8z5QaPiwUUQ==
X-Received: by 2002:a17:90a:d008:b0:2ff:693a:7590 with SMTP id 98e67ed59e1d1-3030ff08de9mr15396057a91.33.1742675784460;
        Sat, 22 Mar 2025 13:36:24 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61a579sm8711798a91.32.2025.03.22.13.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 13:36:24 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-fsdevel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	brauner@kernel.org,
	asml.silence@gmail.com,
	hch@infradead.org,
	axboe@kernel.dk,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH vfs/for-next 2/3] splice: Move splice_to_socket to net/socket.c
Date: Sat, 22 Mar 2025 20:35:45 +0000
Message-ID: <20250322203558.206411-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250322203558.206411-1-jdamato@fastly.com>
References: <20250322203558.206411-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eliminate the #ifdef CONFIG_NET from fs/splice.c and move the
splice_to_socket helper to net/socket.c, where the other splice socket
helpers live (like sock_splice_read and sock_splice_eof).

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/splice.c            | 140 -----------------------------------------
 include/linux/splice.h |   3 -
 net/socket.c           | 140 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 143 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index dcd594a8fc06..40b96387a515 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -766,146 +766,6 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 EXPORT_SYMBOL(iter_file_splice_write);
 
-#ifdef CONFIG_NET
-/**
- * splice_to_socket - splice data from a pipe to a socket
- * @pipe:	pipe to splice from
- * @out:	socket to write to
- * @ppos:	position in @out
- * @len:	number of bytes to splice
- * @flags:	splice modifier flags
- *
- * Description:
- *    Will send @len bytes from the pipe to a network socket. No data copying
- *    is involved.
- *
- */
-ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
-			 loff_t *ppos, size_t len, unsigned int flags)
-{
-	struct socket *sock = sock_from_file(out);
-	struct bio_vec bvec[16];
-	struct msghdr msg = {};
-	ssize_t ret = 0;
-	size_t spliced = 0;
-	bool need_wakeup = false;
-
-	pipe_lock(pipe);
-
-	while (len > 0) {
-		unsigned int head, tail, mask, bc = 0;
-		size_t remain = len;
-
-		/*
-		 * Check for signal early to make process killable when there
-		 * are always buffers available
-		 */
-		ret = -ERESTARTSYS;
-		if (signal_pending(current))
-			break;
-
-		while (pipe_empty(pipe->head, pipe->tail)) {
-			ret = 0;
-			if (!pipe->writers)
-				goto out;
-
-			if (spliced)
-				goto out;
-
-			ret = -EAGAIN;
-			if (flags & SPLICE_F_NONBLOCK)
-				goto out;
-
-			ret = -ERESTARTSYS;
-			if (signal_pending(current))
-				goto out;
-
-			if (need_wakeup) {
-				pipe_wakeup_writers(pipe);
-				need_wakeup = false;
-			}
-
-			pipe_wait_readable(pipe);
-		}
-
-		head = pipe->head;
-		tail = pipe->tail;
-		mask = pipe->ring_size - 1;
-
-		while (!pipe_empty(head, tail)) {
-			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
-			size_t seg;
-
-			if (!buf->len) {
-				tail++;
-				continue;
-			}
-
-			seg = min_t(size_t, remain, buf->len);
-
-			ret = pipe_buf_confirm(pipe, buf);
-			if (unlikely(ret)) {
-				if (ret == -ENODATA)
-					ret = 0;
-				break;
-			}
-
-			bvec_set_page(&bvec[bc++], buf->page, seg, buf->offset);
-			remain -= seg;
-			if (remain == 0 || bc >= ARRAY_SIZE(bvec))
-				break;
-			tail++;
-		}
-
-		if (!bc)
-			break;
-
-		msg.msg_flags = MSG_SPLICE_PAGES;
-		if (flags & SPLICE_F_MORE)
-			msg.msg_flags |= MSG_MORE;
-		if (remain && pipe_occupancy(pipe->head, tail) > 0)
-			msg.msg_flags |= MSG_MORE;
-		if (out->f_flags & O_NONBLOCK)
-			msg.msg_flags |= MSG_DONTWAIT;
-
-		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, bvec, bc,
-			      len - remain);
-		ret = sock_sendmsg(sock, &msg);
-		if (ret <= 0)
-			break;
-
-		spliced += ret;
-		len -= ret;
-		tail = pipe->tail;
-		while (ret > 0) {
-			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
-			size_t seg = min_t(size_t, ret, buf->len);
-
-			buf->offset += seg;
-			buf->len -= seg;
-			ret -= seg;
-
-			if (!buf->len) {
-				pipe_buf_release(pipe, buf);
-				tail++;
-			}
-		}
-
-		if (tail != pipe->tail) {
-			pipe->tail = tail;
-			if (pipe->files)
-				need_wakeup = true;
-		}
-	}
-
-out:
-	pipe_unlock(pipe);
-	if (need_wakeup)
-		pipe_wakeup_writers(pipe);
-	return spliced ?: ret;
-}
-#endif
-
 static int warn_unsupported(struct file *file, const char *op)
 {
 	pr_debug_ratelimited(
diff --git a/include/linux/splice.h b/include/linux/splice.h
index 9dec4861d09f..54c47776469d 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -97,9 +97,6 @@ static inline long splice_copy_file_range(struct file *in, loff_t pos_in,
 
 ssize_t do_tee(struct file *in, struct file *out, size_t len,
 	       unsigned int flags);
-ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
-			 loff_t *ppos, size_t len, unsigned int flags);
-
 /*
  * for dynamic pipe sizing
  */
diff --git a/net/socket.c b/net/socket.c
index 9a117248f18f..2640b42cf320 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -132,6 +132,8 @@ static ssize_t sock_splice_read(struct file *file, loff_t *ppos,
 				struct pipe_inode_info *pipe, size_t len,
 				unsigned int flags);
 static void sock_splice_eof(struct file *file);
+static ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
+				loff_t *ppos, size_t len, unsigned int flags);
 
 #ifdef CONFIG_PROC_FS
 static void sock_show_fdinfo(struct seq_file *m, struct file *f)
@@ -3719,3 +3721,141 @@ u32 kernel_sock_ip_overhead(struct sock *sk)
 	}
 }
 EXPORT_SYMBOL(kernel_sock_ip_overhead);
+
+/**
+ * splice_to_socket - splice data from a pipe to a socket
+ * @pipe:	pipe to splice from
+ * @out:	socket to write to
+ * @ppos:	position in @out
+ * @len:	number of bytes to splice
+ * @flags:	splice modifier flags
+ *
+ * Description:
+ *    Will send @len bytes from the pipe to a network socket. No data copying
+ *    is involved.
+ *
+ */
+static ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
+				loff_t *ppos, size_t len, unsigned int flags)
+{
+	struct socket *sock = sock_from_file(out);
+	struct bio_vec bvec[16];
+	struct msghdr msg = {};
+	ssize_t ret = 0;
+	size_t spliced = 0;
+	bool need_wakeup = false;
+
+	pipe_lock(pipe);
+
+	while (len > 0) {
+		unsigned int head, tail, mask, bc = 0;
+		size_t remain = len;
+
+		/*
+		 * Check for signal early to make process killable when there
+		 * are always buffers available
+		 */
+		ret = -ERESTARTSYS;
+		if (signal_pending(current))
+			break;
+
+		while (pipe_empty(pipe->head, pipe->tail)) {
+			ret = 0;
+			if (!pipe->writers)
+				goto out;
+
+			if (spliced)
+				goto out;
+
+			ret = -EAGAIN;
+			if (flags & SPLICE_F_NONBLOCK)
+				goto out;
+
+			ret = -ERESTARTSYS;
+			if (signal_pending(current))
+				goto out;
+
+			if (need_wakeup) {
+				pipe_wakeup_writers(pipe);
+				need_wakeup = false;
+			}
+
+			pipe_wait_readable(pipe);
+		}
+
+		head = pipe->head;
+		tail = pipe->tail;
+		mask = pipe->ring_size - 1;
+
+		while (!pipe_empty(head, tail)) {
+			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
+			size_t seg;
+
+			if (!buf->len) {
+				tail++;
+				continue;
+			}
+
+			seg = min_t(size_t, remain, buf->len);
+
+			ret = pipe_buf_confirm(pipe, buf);
+			if (unlikely(ret)) {
+				if (ret == -ENODATA)
+					ret = 0;
+				break;
+			}
+
+			bvec_set_page(&bvec[bc++], buf->page, seg, buf->offset);
+			remain -= seg;
+			if (remain == 0 || bc >= ARRAY_SIZE(bvec))
+				break;
+			tail++;
+		}
+
+		if (!bc)
+			break;
+
+		msg.msg_flags = MSG_SPLICE_PAGES;
+		if (flags & SPLICE_F_MORE)
+			msg.msg_flags |= MSG_MORE;
+		if (remain && pipe_occupancy(pipe->head, tail) > 0)
+			msg.msg_flags |= MSG_MORE;
+		if (out->f_flags & O_NONBLOCK)
+			msg.msg_flags |= MSG_DONTWAIT;
+
+		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, bvec, bc,
+			      len - remain);
+		ret = sock_sendmsg(sock, &msg);
+		if (ret <= 0)
+			break;
+
+		spliced += ret;
+		len -= ret;
+		tail = pipe->tail;
+		while (ret > 0) {
+			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
+			size_t seg = min_t(size_t, ret, buf->len);
+
+			buf->offset += seg;
+			buf->len -= seg;
+			ret -= seg;
+
+			if (!buf->len) {
+				pipe_buf_release(pipe, buf);
+				tail++;
+			}
+		}
+
+		if (tail != pipe->tail) {
+			pipe->tail = tail;
+			if (pipe->files)
+				need_wakeup = true;
+		}
+	}
+
+out:
+	pipe_unlock(pipe);
+	if (need_wakeup)
+		pipe_wakeup_writers(pipe);
+	return spliced ?: ret;
+}
-- 
2.43.0


