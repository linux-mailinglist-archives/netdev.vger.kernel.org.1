Return-Path: <netdev+bounces-168701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB77A403C7
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 00:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7EF19C6D6A
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 23:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3410252909;
	Fri, 21 Feb 2025 23:52:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA7B1B0406;
	Fri, 21 Feb 2025 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740181969; cv=none; b=CyeTkKaWqf7J2Cz0CvDrMAKWevoBDXmR9cIP25Kjx732CiESpy9XCF6bx28VCijWZrTHSvZqLq7WwxHzz3UzOO6o1ezlDmA6Q030QNnbAKtz/aIdHaEwE+NEdjo7do4XycbwR8t5dV3VsE1YVpqp4ChSPljSvmqW/9jcBxH9dFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740181969; c=relaxed/simple;
	bh=hgWLz1C6z2dOml4Qn+cGDF7z+dN+RruWoXkAvwyiBKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q5drNpOnmwRWPI8qA4N0GF7sgoCRvodckdXSqdR4R0zuCTgEw9LeeW3t/2KON8PoNwJsK044YddhneJBhy6v/SRDcJe//6aESEUScK5ghzc/iPpiXpvsN0NrOD2VNTYVwVvI3uHm4p1C4ns0xEE+Q0ekwz5zOo55S/oVMCDLEb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c92c857aso48200655ad.0;
        Fri, 21 Feb 2025 15:52:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740181967; x=1740786767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MiXt5L2NZf4QIt8uUxzUrlKvPrnM4G0GDJ3C+qziUeE=;
        b=WMS+kFt9mRJnuk95HZRwqG1yhY7Jb8/tIWkSvBHaYwvXuTBlRQvmHy4diF3YU+QiiY
         /vqCQ51gohtUsLa3GsTzKDviCykEbYOUPXZz2nt0GZJORnTWfMR3Fx4gwGnJNIy7CuhG
         mi7z11SCOZDaKjIhGF7oJw/smkaeIfMWkb8j5CDZBqWMQk2Scegg6zKFNnu6+VOtZyyJ
         Bw6lqDraG9fba+npCgRI6JK3wVxaSlSe3P/rPJyMO4BvCPyhKi9GeYUKZ2c7jtSHp4eI
         LeVLRwyYu86PSFw5HUaR3xOchvftlrh89eKFfOA4fGJSUdP8iPlqf+NNxNSa3Tjn3ilH
         RYoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDsKSHWgVFOPr75RXVPA1G8N+ORqvIZS/9y4IipKoa4U6/iIrctYOqLVKvNHvmnYu4ehRjzDUT4lLdS3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD+qxBeV813IO2F+j4qx6RnnjHhjAOB4TD5HCQfioLdf1d2RRH
	NUc8tngwAq++n1I6LxHLBS54eCEbugis5RHIVJ4nf8FPW+beRIDQ8Z3X
X-Gm-Gg: ASbGnctmmqxSaoc/uZLnlxGYB3RR8yt3QtyP0AooVPnrrJ9XHea9EeWbFpwwN1GNVBk
	wlG1JCZ7FFSJtodoJJab1gp/1hqxjNNoez9vkGDsTpTVfDOQgHWJs3RYnKGuwSXKJGRV9D9+zu1
	qLfHvrC6FWyMCgduLeDYOa879JnIgZP9PX9nVAFoUw1EHuMgc0Y0Apt3S0P2stnaeJhRJ8x7Xl5
	mhzjoZBOgRhJBVTsbQcjqm/hi7/REd6lutiYeC32EU9td6nT18B31vz9PaLH53nfHtDeRr1A3ZL
	IiUm4bwPy994slO2EOmOvgYgPQ==
X-Google-Smtp-Source: AGHT+IHfwFbXKm/hok22HTRFZuTOCJjmCbW6JKhOuBCXbTbkJ8mwJ7m6RoxAaWIQS0i5V2ldIHhK5w==
X-Received: by 2002:a17:902:ea06:b0:220:e98e:4f1b with SMTP id d9443c01a7336-2219fef3602mr102025985ad.0.1740181966577;
        Fri, 21 Feb 2025 15:52:46 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d556d4bcsm140824545ad.178.2025.02.21.15.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 15:52:46 -0800 (PST)
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
	almasrymina@google.com,
	asml.silence@gmail.com
Subject: [PATCH net v3] tcp: devmem: don't write truncated dmabuf CMSGs to userspace
Date: Fri, 21 Feb 2025 15:52:45 -0800
Message-ID: <20250221235245.2440089-1-sdf@fomichev.me>
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
v3: s/put_devmem_cmsg/put_cmsg_notrunc/ and put it into scm.c (Jakub)
---
 include/linux/socket.h |  1 +
 net/core/scm.c         |  9 +++++++++
 net/ipv4/tcp.c         | 26 ++++++++++----------------
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index d18cc47e89bd..2d8939a2dc40 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -392,6 +392,7 @@ struct ucred {
 
 extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr);
 extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
+extern int put_cmsg_notrunc(struct msghdr *msg, int level, int type, int len, void *data);
 
 struct timespec64;
 struct __kernel_timespec;
diff --git a/net/core/scm.c b/net/core/scm.c
index 4f6a14babe5a..9fd986db0cb7 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -282,6 +282,15 @@ int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
 }
 EXPORT_SYMBOL(put_cmsg);
 
+int put_cmsg_notrunc(struct msghdr *msg, int level, int type, int len, void *data)
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


