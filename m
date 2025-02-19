Return-Path: <netdev+bounces-167878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B82A3C9DF
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 21:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC3A17A9F4
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 20:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8755923BF9B;
	Wed, 19 Feb 2025 20:31:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F154D1B393D;
	Wed, 19 Feb 2025 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997066; cv=none; b=ifOK7KmGpQpQwy0yFJ8MuWvuBWn3E7ls+szqHnuoRm8gcE3NTpv/J9wrAIUQ8sXzC2u/jAbOrqAjbw24Ys9uP30gFocBhwLicYqpscGFv5FPmsF90gVNIPYkijMRkgb7NyZIQ39pQkvO8N0bitT5jjsw/nH0cF8YIvqzseWsjF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997066; c=relaxed/simple;
	bh=0bePGmfHtl35NTbAMyaoUBDGce9xhv6pmYnUXL5lbhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ttOCthpflrTwB/G0indTRC5MLk6fpOy1fQSWQJ6cj+kTQM7plojN0MVIlub23EoSHaf3Au3m7QUWF/dbHHsh5/buhubTL7MPwh/pjq4ssWQudC57gQ+uG2fUsAIgRWI5AXKOTr2tTWeeEHEu6qZTBnmUARrovtb1+4FqUnG3I+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22100006bc8so2943545ad.0;
        Wed, 19 Feb 2025 12:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997064; x=1740601864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRK2JfG2AGCjzGSvpwHXZ3foDZgl6m2wW0qbGdXRWqE=;
        b=kSs3VvCK83MMo9i8V74pNYu77l4Wt6HnReAz07jue9F5QHguDhkvo3yomEUbzjix/c
         Blg3jYvv1Uv6BBr8EmRmJywfDUsTgUCPbR9NNwFt5+lYCDs1iFzh1iUMEr23nV+UA9wf
         rmHg/ET+Lz/VKid8sb3mQTM27aMYlw6fAnNYRFhHs+4QtF4kxMYYi3+LaNKaxZ2Wd5PB
         mC2lJvwZ33y1qUzjEXEy1mXGzAxUYbzc+cXcUmYfxbjzHImyKk+wD9eVeoIZjOsMfRrk
         bW+kTM0XqHmb+9zPbQ0mbXcg0QetYF9o0KV7br/fgm73rloTOUZMIxTIxJlsZqxc7Pfa
         yaDA==
X-Forwarded-Encrypted: i=1; AJvYcCUkhDu4Z+3hUvh76SAdG0fwhHF+b/qdNmdhXyYK+9V+NLMfJ9WyXLZHyW+pxLFPMSVcXjM8sbF0yjet4/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYqit+1bPWGGZ9zcfcvS0O6MnfYF645z0WeljMpxUT67K+NcBz
	1dmrbwPF0vDD4EYUMKo4gB5RVdsNqiO/Lh7G+hXb2+fDox7z90PEFTkY
X-Gm-Gg: ASbGncuSLcCV9IrmvMx2e6oeyOrnoZ8aFm721V5lff22jLVEwxstLQ2d1ie8nMwk3Ws
	4/xZMd9JR5kBJCHgUjpSLlLbYGd368n00uuieT9S/CteHSOdgG5NsHdZ7ze06c7HLTsFpLnwD9t
	lxSnM9ssdAt5k3mcn5/UrowejmQzDPdmIn56mNVb491JXUsUFBaRFdf4x888HtcARLsmmXZOEz5
	KWeccJK2KGJ4hMnlmGrUTN8TRDeDNwUk0TN9BdcNL5nEudY/4oCIL6LestLs4MwblpA1TNZvlzI
	+je23ZGq/6u8dXE=
X-Google-Smtp-Source: AGHT+IFT2XOWIrW/21fFy5EjwW01Qin5ADO++YJueG5kbDKcvcpEo3SznaoYKf8r8cA7PpXXITlWJA==
X-Received: by 2002:a17:903:2351:b0:216:7ee9:220b with SMTP id d9443c01a7336-2210404e4e0mr367274285ad.22.1739997063934;
        Wed, 19 Feb 2025 12:31:03 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fcbab49a05sm805884a91.1.2025.02.19.12.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:31:03 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	ncardwell@google.com,
	kuniyu@amazon.com,
	dsahern@kernel.org,
	horms@kernel.org,
	almasrymina@google.com,
	kaiyuanz@google.com,
	asml.silence@gmail.com
Subject: [PATCH net v2] tcp: devmem: don't write truncated dmabuf CMSGs to userspace
Date: Wed, 19 Feb 2025 12:31:02 -0800
Message-ID: <20250219203102.1053122-1-sdf@fomichev.me>
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
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/ipv4/tcp.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..ba77beba60c4 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2394,6 +2394,16 @@ static int tcp_xa_pool_refill(struct sock *sk, struct tcp_xa_pool *p,
 	return k ? 0 : err;
 }
 
+static int put_devmem_cmsg(struct msghdr *msg, int level, int type, int len,
+			   void *data)
+{
+	/* Don't produce truncated CMSGs */
+	if (msg->msg_controllen < CMSG_LEN(len))
+		return -ETOOSMALL;
+
+	return put_cmsg(msg, level, type, len, data);
+}
+
 /* On error, returns the -errno. On success, returns number of bytes sent to the
  * user. May not consume all of @remaining_len.
  */
@@ -2438,10 +2448,10 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 			 */
 			memset(&dmabuf_cmsg, 0, sizeof(dmabuf_cmsg));
 			dmabuf_cmsg.frag_size = copy;
-			err = put_cmsg(msg, SOL_SOCKET, SO_DEVMEM_LINEAR,
-				       sizeof(dmabuf_cmsg), &dmabuf_cmsg);
+			err = put_devmem_cmsg(msg, SOL_SOCKET, SO_DEVMEM_LINEAR,
+					      sizeof(dmabuf_cmsg),
+					      &dmabuf_cmsg);
 			if (err || msg->msg_flags & MSG_CTRUNC) {
-				msg->msg_flags &= ~MSG_CTRUNC;
 				if (!err)
 					err = -ETOOSMALL;
 				goto out;
@@ -2499,12 +2509,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 				offset += copy;
 				remaining_len -= copy;
 
-				err = put_cmsg(msg, SOL_SOCKET,
-					       SO_DEVMEM_DMABUF,
-					       sizeof(dmabuf_cmsg),
-					       &dmabuf_cmsg);
+				err = put_devmem_cmsg(msg, SOL_SOCKET,
+						      SO_DEVMEM_DMABUF,
+						      sizeof(dmabuf_cmsg),
+						      &dmabuf_cmsg);
 				if (err || msg->msg_flags & MSG_CTRUNC) {
-					msg->msg_flags &= ~MSG_CTRUNC;
 					if (!err)
 						err = -ETOOSMALL;
 					goto out;
-- 
2.48.1


