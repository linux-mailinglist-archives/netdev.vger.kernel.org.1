Return-Path: <netdev+bounces-175963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA37EA68138
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 01:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3387118946BF
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855F517A2E7;
	Wed, 19 Mar 2025 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LNZH3qR1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A501537A7
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343344; cv=none; b=aCYWPqtx4t3Q1qK1Vt4xN1eyw4YTiIOR9efW3qAneZmmh2aiFBbIkByU/l6E0oHIYMtmybTSJ29AL2ebK42GT3SXePhziDDCw9RitnWUxHNQ6Q+uYF+CjznGYsutSgcqMvaPmptrjSHADWdmPrMC32vhx+MDxOjs7Jrnr6Y8p9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343344; c=relaxed/simple;
	bh=4XmeV+SwsUckbKoljf1imPQeQxED4NvPOSxU0C/rldo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbsf2MDQ9enJlI5fHNRvNDYaCvj6Prv/qXYdANnUiDUVUiAYkIGN+rEJdXqrR0eagvixJxcby77V+0KiRUM16qEsDMVc7KCT1aS50GOQz7vSyKVUbCUG7DoBZeMLFebTMbDhiK7qVkrJRGXZNK00e38/WriuCilxpFhfauc64Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LNZH3qR1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22580c9ee0aso108908575ad.2
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 17:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343341; x=1742948141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=js3UD04AvSWxrN9RHcwFb61ujoiYEshPhpsTiZDgHgM=;
        b=LNZH3qR1uWFDzF9bQC0jRqVCxBj0XhnnQKxLQt53RWWbP9Ddo4X5mxjbDYeRlz2b8g
         x92shF+UhIOeahYVFcSmf9FaeuocEomstZDZHCQEL0sYgMlcbxhXxMb5QxYWnWuET5MM
         xadfXaJoHP5VER3ZT3b4hxYUwe7HeFijMPl14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343341; x=1742948141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=js3UD04AvSWxrN9RHcwFb61ujoiYEshPhpsTiZDgHgM=;
        b=J4geH7Q8F3XN9EPyKRXywncqsoHfrJrhwFSHFgP+GhLttCQ68sYT3pyBI2HF37I9B3
         f0nZP3uOnIKrdL0z2fHoto+YMn+oDunRzwKoiUGvF+81iE76+8Js3IFSGETP67PuF8wJ
         fstsdzNx1eF3vYwSSSHmAFHXDpyNHJsgy+ZZQQvS2WDJcOqLqbXTQaCi7BMrpZve9Q5z
         OjJPikqbrO07XAmsk7+1JipfJccScql/6K3yZz/w94f1+i4QfIQsL3lJwiOwle8iMjuI
         pulAmHXaysY67+QhL1eX29+KiLmK88+aOZQwM/LFSiiQ7yDBgCeJNHlXm/lUrsLVtBwQ
         BxHA==
X-Gm-Message-State: AOJu0YyYyfCvM9gDuq1I+LWH0C7I2206vtLtxdj2pWtENogj1jGoWHBo
	YVjudmzYqBzMSX1wx54rGAdvjWyEyG0hION7M/CyZ/oR9UxRfMDPgFjxs/YtcACulNUCfcFJE6l
	brRtR8y/9mWu31ZmGLBwCYIfVozf2LT0d9yOwtIiTmqemmXk56eOBjh9Lb21CtegfSBuBl+Fs+X
	U8n/Iq4GPmvLgu7w+n4JrpLztOCCi8Jq/xNBI=
X-Gm-Gg: ASbGncstD+J2t1tvlLxKX2ek6n7xh5lqLJw2T0fim9y2QZHrymLo/rw5cSSoTq3W9E7
	2Wj9fnQtoXVenkEhrDsrIeobQ4M9WpLi+2TivfKQ4vDb0JuVLaLOu+DBUUVeB1/VTgteGswWP8f
	srL5U3/FFxwqkbwSukC1bzUrSrBzw6baDNKtUuJvsp2OjWynqBv4APllmIbFjBbKpBRW+vayJYW
	/KgaUI0HazwVHs58dp+Ditcku2kA0ZnhUrvN7YbABoWNqlh9VyHIqCep1VlCof15935IozYmtw0
	d8Pm2zcYDNUCIc7g/HoFoWloeJDzJ853S3LDC/d1hziVsRy2fyQo9u/dLxSmWzw=
X-Google-Smtp-Source: AGHT+IH7oXUPwBlv8OzKX6l4S7tFotTPIWvWoF6rpoUJjb85+9JTpVERsJIAUNLcb6oCGgVeRTkFdg==
X-Received: by 2002:a17:902:ea07:b0:220:fb23:48df with SMTP id d9443c01a7336-22649caa9ebmr8193745ad.36.1742343341302;
        Tue, 18 Mar 2025 17:15:41 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:40 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kuba@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	mingo@redhat.com,
	arnd@arndb.de,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC -next 03/10] splice: Factor splice_socket into a helper
Date: Wed, 19 Mar 2025 00:15:14 +0000
Message-ID: <20250319001521.53249-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319001521.53249-1-jdamato@fastly.com>
References: <20250319001521.53249-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

splice_socket becomes a wrapper around splice_socket_generic which takes
a ubuf pointer to prepare for zerocopy notifications.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/splice.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 9575074a1296..1f27ce6d1c34 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -37,6 +37,8 @@
 #include <linux/socket.h>
 #include <linux/sched/signal.h>
 
+#include <net/sock.h>
+
 #include "internal.h"
 
 /*
@@ -783,21 +785,10 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 EXPORT_SYMBOL(iter_file_splice_write);
 
 #ifdef CONFIG_NET
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
+static ssize_t splice_socket_generic(struct pipe_inode_info *pipe,
+				     struct file *out, loff_t *ppos,
+				     size_t len, unsigned int flags,
+				     struct ubuf_info *ubuf_info)
 {
 	struct socket *sock = sock_from_file(out);
 	struct bio_vec bvec[16];
@@ -920,6 +911,25 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 		wakeup_pipe_writers(pipe);
 	return spliced ?: ret;
 }
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
+ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
+			 loff_t *ppos, size_t len, unsigned int flags)
+{
+	return splice_socket_generic(pipe, out, ppos, len, flags, NULL);
+}
 #endif
 
 static int warn_unsupported(struct file *file, const char *op)
-- 
2.43.0


