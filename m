Return-Path: <netdev+bounces-169124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCC6A42A2F
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4571636DB
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888B72641D0;
	Mon, 24 Feb 2025 17:44:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9325426280C;
	Mon, 24 Feb 2025 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419045; cv=none; b=mE8c4sZ6T0MM2nkS/YPjyWc+HIeFofoNxIwve9eexy3cqehLsQGmTrEstJ+NF+hLWs7R9eDomdtPj1G+xfHfy9A2qaZfk6E2CNWLP0JGuPuxJ93aOj0GP1Cr0LaKiT3m8o8YyWYQv5EbZMA4rH30OYBzdjN/z3HYjhRH+hIeLh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419045; c=relaxed/simple;
	bh=nWiv1gFNqBVT0jBzZeK1/WSuHaNSOd+ibwvsUUqZowU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X4KxGINcty18m6rdacBCzHHN7FacyyzOaeO9uI8fHvFRZNJ4NbgTG5GSOAj3MGuvTDvGC9Psclr0kTgGDXX0gl36PT9lwIg2cZs/VhD4hrJJO7O9rujvBvRd+27L84bquz5apvliGnQ5HM8ehUHaXnJoid/IA7FEiybajXdyMFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220c8f38febso100071735ad.2;
        Mon, 24 Feb 2025 09:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419042; x=1741023842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aE6DUngSxwY3etZZHx2C7wT0U9bbZo01Xod0OnS+oLI=;
        b=gIcHqQ93lEnqbbrvDI+8+hyqrD0NGmuYXZi0FwuxQS9qOX9HzNBjVcarUPS8oGCOlg
         xh8tU/D6x210MjUVdwtGXs3gIZDJoMz9livM09Lx40CIZwk0Ljrs07wYj1b1+GULGVTs
         TpU3tsBUowBZhr8bEP0FG32enb9fZywB1RMuELLQ2LSutOj//iZXjIf1EkX7/hK5QqVE
         +yb+xJyleYZ0T3YOx+EtQ4QBqcmt/6cTxOP3XAz96F/DfnqY0gy5PbHZDWquybkUrdFw
         gsu9pNEt48DReLFYzvpuqFJOM2eEsZvRN3EgtoCINvukf37mauCFl1O/klFDHE10OWN7
         a7+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/rQXRHrkE5t/cXpxdioDPFPnQLnx33cXMgbcejsCNZKp4NNnSA9akp7jXnffeCMVKMEUXEGyRA15lHzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkYeZqE6cgIuPMnkeISlnflZaFcaqMI7kHuUsXzgH/DMPuVFSs
	IInXU+BXXJJ0vV7HDqjK5RMcSKueZ3YYLae/NEYm2wx+IHFV91xXastrv9E=
X-Gm-Gg: ASbGncsYocTD3v1x9J45OK1QxhFLA7Lsiy8wchCbPnA/Yyl7bGzOlnB81TlpwDEOMB5
	RpOq/lO8bvDFbGkeFLCmLIe+UWiOYUy4ymwVIgOfeO3Hna2YwPkhzGM23ON1sawFC+uh8SOpiL7
	FOr4hPkkqX94/OEZogz178a/z8r7+o7xdLEIH68DFn07uyN48OvDF2BepHNxYLuas0orZV1yKMu
	fq5QGcqmeiQmAOwLmKF+THqwJn2O+X0m9isix3WZq6gJIW47Uy8FhSmwSkwwHnek3wuaW8ApPF1
	Q+qRX275IPg7RYOGpjQgYKQEVw==
X-Google-Smtp-Source: AGHT+IG6C8GKkGjXLzptgw4xMFBRKHxCzZoWFt9D2V7ocYm5Xdh2ewFEuIHX7Zu8Prit0CTGpU/N2w==
X-Received: by 2002:a17:902:e54e:b0:220:d256:d133 with SMTP id d9443c01a7336-2219ff9e7f3mr262239945ad.14.1740419042456;
        Mon, 24 Feb 2025 09:44:02 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5596115sm183685685ad.258.2025.02.24.09.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:44:02 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	kuniyu@amazon.com,
	willemb@google.com,
	horms@kernel.org,
	ncardwell@google.com,
	dsahern@kernel.org,
	kaiyuanz@google.com,
	asml.silence@gmail.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net v4] tcp: devmem: don't write truncated dmabuf CMSGs to userspace
Date: Mon, 24 Feb 2025 09:44:01 -0800
Message-ID: <20250224174401.3582695-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we report -ETOOSMALL (err) only on the first iteration
(!sent). When we get put_cmsg error after a bunch of successful
put_cmsg calls, we don't signal the error at all. This might be
confusing on the userspace side which will see truncated CMSGs
but no MSG_CTRUNC signal.

Consider the following case:
- sizeof(struct cmsghdr) = 16
- sizeof(struct dmabuf_cmsg) = 24
- total cmsg size (CMSG_LEN) = 40 (16+24)

When calling recvmsg with msg_controllen=60, the userspace
will receive two(!) dmabuf_cmsg(s), the first one will
be a valid one and the second one will be silently truncated. There is no
easy way to discover the truncation besides doing something like
"cm->cmsg_len != CMSG_LEN(sizeof(dmabuf_cmsg))".

Introduce new put_devmem_cmsg wrapper that reports an error instead
of doing the truncation. Mina suggests that it's the intended way
this API should work.

Note that we might now report MSG_CTRUNC when the users (incorrectly)
call us with msg_control == NULL.

Fixes: 8f0b3cc9a4c1 ("tcp: RX path for devmem TCP")
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
v4: respect 80 character line length
v3: s/put_devmem_cmsg/put_cmsg_notrunc/ and put it into scm.c (Jakub)
---
 include/linux/socket.h |  2 ++
 net/core/scm.c         | 10 ++++++++++
 net/ipv4/tcp.c         | 26 ++++++++++----------------
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index d18cc47e89bd..c3322eb3d686 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -392,6 +392,8 @@ struct ucred {
 
 extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr);
 extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
+extern int put_cmsg_notrunc(struct msghdr *msg, int level, int type, int len,
+			    void *data);
 
 struct timespec64;
 struct __kernel_timespec;
diff --git a/net/core/scm.c b/net/core/scm.c
index 4f6a14babe5a..733c0cbd393d 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -282,6 +282,16 @@ int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
 }
 EXPORT_SYMBOL(put_cmsg);
 
+int put_cmsg_notrunc(struct msghdr *msg, int level, int type, int len,
+		     void *data)
+{
+	/* Don't produce truncated CMSGs */
+	if (!msg->msg_control || msg->msg_controllen < CMSG_LEN(len))
+		return -ETOOSMALL;
+
+	return put_cmsg(msg, level, type, len, data);
+}
+
 void put_cmsg_scm_timestamping64(struct msghdr *msg, struct scm_timestamping_internal *tss_internal)
 {
 	struct scm_timestamping64 tss;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..d74281eca14f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2438,14 +2438,12 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 			 */
 			memset(&dmabuf_cmsg, 0, sizeof(dmabuf_cmsg));
 			dmabuf_cmsg.frag_size = copy;
-			err = put_cmsg(msg, SOL_SOCKET, SO_DEVMEM_LINEAR,
-				       sizeof(dmabuf_cmsg), &dmabuf_cmsg);
-			if (err || msg->msg_flags & MSG_CTRUNC) {
-				msg->msg_flags &= ~MSG_CTRUNC;
-				if (!err)
-					err = -ETOOSMALL;
+			err = put_cmsg_notrunc(msg, SOL_SOCKET,
+					       SO_DEVMEM_LINEAR,
+					       sizeof(dmabuf_cmsg),
+					       &dmabuf_cmsg);
+			if (err)
 				goto out;
-			}
 
 			sent += copy;
 
@@ -2499,16 +2497,12 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 				offset += copy;
 				remaining_len -= copy;
 
-				err = put_cmsg(msg, SOL_SOCKET,
-					       SO_DEVMEM_DMABUF,
-					       sizeof(dmabuf_cmsg),
-					       &dmabuf_cmsg);
-				if (err || msg->msg_flags & MSG_CTRUNC) {
-					msg->msg_flags &= ~MSG_CTRUNC;
-					if (!err)
-						err = -ETOOSMALL;
+				err = put_cmsg_notrunc(msg, SOL_SOCKET,
+						       SO_DEVMEM_DMABUF,
+						       sizeof(dmabuf_cmsg),
+						       &dmabuf_cmsg);
+				if (err)
 					goto out;
-				}
 
 				atomic_long_inc(&niov->pp_ref_count);
 				tcp_xa_pool.netmems[tcp_xa_pool.idx++] = skb_frag_netmem(frag);
-- 
2.48.1


