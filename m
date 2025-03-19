Return-Path: <netdev+bounces-175964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 593C6A6813A
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 01:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6428C189624B
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3754194A44;
	Wed, 19 Mar 2025 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gIVpTV15"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116561494D9
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343345; cv=none; b=JJYZYHIz0k/Bwu0pnVkGcMzyrJoGWMK9sBOAX7MPNWThYcfeE7z/wr4+EOtRAoBMiy5xpyVfY8L8hfRGiuXI4tbxXmu9fEgJMntO3aMl15Qo/pZteebYPi+fYFec4/ZHIJpjproj+cX/Mba1YCTPjVfqz/8bsaKVhhgNQTBfhtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343345; c=relaxed/simple;
	bh=SowAWf3suxdJmhbIj/+rpT/CNsAYNCCACOuR5s/3LGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgCd0DEr7npH688DR6JwUCmbcxkJmOZPZnWHfpFESIVf0XIuJRczXrHxhf6FOYuT4l3dSnpiLJjltjuOk1IqShrP/Nx96+7JM7U/6vAxvOONShHkqFj8YDZgEO7E89r2HFwflOdEY48gBMhGCiJlYZngzh0hmPGVWn2DjJk6wEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gIVpTV15; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22548a28d0cso18569675ad.3
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 17:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343343; x=1742948143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BqxlSUPLPLK+n0IEZ/na32d+xFXeCa925E/NE7WMKY=;
        b=gIVpTV15hhkkYilj5BypVWGWlzUL3CqQ72S1nz2FWsVuUY16SNpf5KQkU11mnaTAKn
         1WaoeJcNBjDgCS32IwIWKfkUfCs3oFZs0wmmQtBRsXJzqoJr4KgKFKcmXmUWyDSv1UL4
         BoqqJF1llr2ptP6/5CELh0Zkw4SLxiefAIwMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343343; x=1742948143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BqxlSUPLPLK+n0IEZ/na32d+xFXeCa925E/NE7WMKY=;
        b=jTte6LrOgwdB+S77CT/Xlt9P2fAW9YD5Zt22dOAZ//hsXAm8sfeqfjmnAL+pxJDiqO
         bVKMVuaU9rDvsYFYksLyKwjPsTP7vBWmth8c90SPHX3z2mPkBUsNDmSo5PpPaH/S97EV
         12GUB6eNKLHA9fMB53ujGRykn0+hsgt2y+9TIlklwzenZMZsLajqSIhSFiPoAaWS0a5I
         7cIDyVx+Vy8xwqcf9R4vj6hOtVeZ33j3QyTCByc9Puk+Ycxr4z40ZQnilc/YHOeSvyTf
         szUNbQlVgrCOH5QergqAGevsTgZB0E2lyBTL8Lds/svgpGkTaGnwJtxE5Zm1CTV4mm2a
         Y59g==
X-Gm-Message-State: AOJu0YxwL0mX40Ec3kx9bvNKhyP2CrnOh1suM2Exct/g/dgA6oZfYTdP
	kIpAdSYnlq2LEXYYmvWorIHx+zGCTygDjr6qWzd+V/m0pfZTerNafCAElE1FsYjFxo//+I8XuXp
	fWcjD/jElkzRGLCcuh3N6YmotUp5GEaeOjvGimzKD0BxX8rHq5san4I4OIK8kgUNEmXAlsbiAWQ
	cLT8111JXouUdI/tufcHXAExFozqKjgLo4qwM=
X-Gm-Gg: ASbGncv2n50OtWnUt9W6aUM7bPiu4FIsdMrwEWzU0VrnD9E5hZl9rfK8N9gIebA56/S
	wo+xIc3DvPliUX2EINEdCiPojMfzcQWbWZuH6wQ7uElFM7BUHVSq9mFEH9CU3WyQ8SsBrziJy6Z
	KWCURWrcT+jhyhMpEH2s6dPHvDRts+IWiOOWSV9yp8xgM80GAIoAShW1T+1B5eM3SXHmDXZD9YO
	gheIKTrfEAJlwAXEM5H318XW+Q84uufQQcCa7blo+xKizme3ABYzhWY9Wu53RqzhRoUJJGbuoAo
	2UaCRJGn5niGlSMkdUz0gOJj54ty+aOn/900TgXtg89fNwt3PIaa
X-Google-Smtp-Source: AGHT+IFxyw3nvWmVaD9tl0lJBbbnI8q3NC7K/P2umCsKr9U07OgWwl21w/NuymcNKusQI296uT0O6g==
X-Received: by 2002:a17:903:1cb:b0:224:76f:9e45 with SMTP id d9443c01a7336-22649a3476fmr9616615ad.21.1742343343024;
        Tue, 18 Mar 2025 17:15:43 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:42 -0700 (PDT)
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
Subject: [RFC -next 04/10] splice: Add SPLICE_F_ZC and attach ubuf
Date: Wed, 19 Mar 2025 00:15:15 +0000
Message-ID: <20250319001521.53249-5-jdamato@fastly.com>
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

Add the SPLICE_F_ZC flag and when it is set, allocate a ubuf and attach
it to generate zerocopy notifications.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/splice.c            | 20 ++++++++++++++++++++
 include/linux/splice.h |  3 ++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 1f27ce6d1c34..6dc60f47f84e 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -875,6 +875,11 @@ static ssize_t splice_socket_generic(struct pipe_inode_info *pipe,
 		if (out->f_flags & O_NONBLOCK)
 			msg.msg_flags |= MSG_DONTWAIT;
 
+		if (unlikely(flags & SPLICE_F_ZC) && ubuf_info) {
+			msg.msg_flags = MSG_ZEROCOPY;
+			msg.msg_ubuf = ubuf_info;
+		}
+
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, bvec, bc,
 			      len - remain);
 		ret = sock_sendmsg(sock, &msg);
@@ -1223,12 +1228,27 @@ static ssize_t do_splice_direct_actor(struct file *in, loff_t *ppos,
 	if (unlikely(out->f_flags & O_APPEND))
 		return -EINVAL;
 
+	if (unlikely(flags & SPLICE_F_ZC)) {
+		struct socket *sock = sock_from_file(out);
+		struct sock *sk = sock->sk;
+		struct ubuf_info *ubuf_info;
+
+		ubuf_info = msg_zerocopy_realloc(sk, len, NULL);
+		if (!ubuf_info)
+			return -ENOMEM;
+		sd.ubuf_info = ubuf_info;
+	}
+
 	ret = splice_direct_to_actor(in, &sd, actor);
 	if (ret > 0)
 		*ppos = sd.pos;
 
+	if (unlikely(flags & SPLICE_F_ZC))
+		refcount_dec(&sd.ubuf_info->refcnt);
+
 	return ret;
 }
+
 /**
  * do_splice_direct - splices data directly between two files
  * @in:		file to splice from
diff --git a/include/linux/splice.h b/include/linux/splice.h
index 7477df3916e2..a88588cf2754 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -21,8 +21,9 @@
 				 /* from/to, of course */
 #define SPLICE_F_MORE	(0x04)	/* expect more data */
 #define SPLICE_F_GIFT	(0x08)	/* pages passed in are a gift */
+#define SPLICE_F_ZC	(0x10)  /* generate zero copy notifications */
 
-#define SPLICE_F_ALL (SPLICE_F_MOVE|SPLICE_F_NONBLOCK|SPLICE_F_MORE|SPLICE_F_GIFT)
+#define SPLICE_F_ALL (SPLICE_F_MOVE|SPLICE_F_NONBLOCK|SPLICE_F_MORE|SPLICE_F_GIFT|SPLICE_F_ZC)
 
 /*
  * Passed to the actors
-- 
2.43.0


