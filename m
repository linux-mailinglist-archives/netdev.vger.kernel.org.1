Return-Path: <netdev+bounces-114151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF8394133D
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A032867F0
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A884F1A00EE;
	Tue, 30 Jul 2024 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/IDlFAe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F901A00F1
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346528; cv=none; b=TEYGXNzKytlHhBK3lwu6OfMH6RuBhKUFaRHxgsOhjFfdsoY4Te0rMIXiwHQuI77Pv+s6teeN78fImqbE5qO3P+DBDa1Rhm6cX1M8SRgm87+r1kcSNO0M2e1hclnFD6lQHUCqlmz2H/Rq5Vh6GUjnKQzB5ZlQHzgPwEjzNleqi5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346528; c=relaxed/simple;
	bh=kfcSXfC5JcvC+7C0W1YUJMsNNRJUrr80jzzuWO2BF3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cLL8wo5/y+kvSBcHapuDB5YnrTcpHnFIKHuT/q4IyZsxJ5jyAJNV5BKEBZtB/PYIH7U94WlTY3jhdhVFLGXxBSNzLPs3x25OPXzFKZ/8EvULpezg5YTIZ2FABUKkDU+teaOwgJXRfJN6cUU/il3jD5k+r/ZoyPDJya/yhnROXLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/IDlFAe; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ff3d5c6e9eso2560935ad.1
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 06:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722346525; x=1722951325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2W23wy756KJnEnaODYZZ3ycAfBd3JNd7g+sLxPmGmsM=;
        b=L/IDlFAeukJ6Uvym5ROFNrpBdJcgMaw+Hcdne8xKjTovKlJ7wasZYvRe1Zy9VqnqI+
         fBfu4MhnfpNIgHGG0CSv5kA/qWTi0IZ79CrzX4FjvzEf2XAz1werdElPGUsWA7LxGMuf
         8gJptttbifYoMLfsZtAF2Jq++cB7IOJwlOMu7btuGCRFupnmOfGRVrkl8zTGDTRiGHsD
         /7xLb6u1yyDWSbGX2uoThf1A/r05NYsDfhbT3Zx1q46BxhuTjFTswzFRwpP96Qi9PqOX
         gsJsNBqnyteQB+yloBILMkUjUAFlq95A+XXvWWv1zYc6IgfwFp0mV5QT6MuYhrZK8tBt
         dSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722346525; x=1722951325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2W23wy756KJnEnaODYZZ3ycAfBd3JNd7g+sLxPmGmsM=;
        b=MhKge6qBG5tIGgyQbTrd0NtrHtwemviWc6ezlpthwcU7AXXvnxa4Erb8eG8OYppqQ6
         7OQZyA/ScpVUajRyZu7+NhQRu8wZxyHKYt1eMJbsbcWLt+L6ERUoV+a3cxsvpalHNggL
         BSPmdLBq38O0Ysy/BnoibXD9u8hwgJh6WgDJnLbZnj4ZP7LD2Up3u3Atx8vNRanhmYkY
         oUGYw3dfXk/64TdTWbV25DuB43Gq4ndb2ebrtvSzsd5Vyv5xASBuMc7gS0qSg2wu+/rk
         fkbK/bplFE/DSvjFWKDsIBop2Acju7f44gm0J6t4VtKuNz0O5AwQBl2HGVIDPXod9Fxy
         X6EQ==
X-Gm-Message-State: AOJu0Yxk+ZGYC40yI7IQgmUyvo6s2QuBQYZ2DfHiFYkO5n3z7nuawxF/
	IiBZ1PYQ+rmjpv7TeGQLIW5M3DCPe+Pj8inaywArya1bU2gR67ih
X-Google-Smtp-Source: AGHT+IFRahXyV6JgGqW6WzrbHsB+RMigZXaf34XD5RwC2N5bN8BI1jzD1SioBvkJzJ0hjtxBWAQYlQ==
X-Received: by 2002:a17:903:1cc:b0:1fb:6b94:66ee with SMTP id d9443c01a7336-1ff048421ccmr98217945ad.26.1722346525308;
        Tue, 30 Jul 2024 06:35:25 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f9f279sm101562515ad.256.2024.07.30.06.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 06:35:24 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 1/6] tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_CLOSE for active reset
Date: Tue, 30 Jul 2024 21:35:08 +0800
Message-Id: <20240730133513.99986-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240730133513.99986-1-kerneljasonxing@gmail.com>
References: <20240730133513.99986-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Introducing a new type TCP_ABORT_ON_CLOSE for tcp reset reason to handle
the case where more data is unread in closing phase.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/rstreason.h | 6 ++++++
 net/ipv4/tcp.c          | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index 2575c85d7f7a..fa6bfd0d7d69 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -17,6 +17,7 @@
 	FN(TCP_ABORT_ON_DATA)		\
 	FN(TCP_TIMEWAIT_SOCKET)		\
 	FN(INVALID_SYN)			\
+	FN(TCP_ABORT_ON_CLOSE)		\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -84,6 +85,11 @@ enum sk_rst_reason {
 	 * an error, send a reset"
 	 */
 	SK_RST_REASON_INVALID_SYN,
+	/**
+	 * @SK_RST_REASON_TCP_ABORT_ON_CLOSE: abort on close
+	 * corresponding to LINUX_MIB_TCPABORTONCLOSE
+	 */
+	SK_RST_REASON_TCP_ABORT_ON_CLOSE,
 
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e03a342c9162..2e010add0317 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2833,7 +2833,7 @@ void __tcp_close(struct sock *sk, long timeout)
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONCLOSE);
 		tcp_set_state(sk, TCP_CLOSE);
 		tcp_send_active_reset(sk, sk->sk_allocation,
-				      SK_RST_REASON_NOT_SPECIFIED);
+				      SK_RST_REASON_TCP_ABORT_ON_CLOSE);
 	} else if (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime) {
 		/* Check zero linger _after_ checking for unread data. */
 		sk->sk_prot->disconnect(sk, 0);
-- 
2.37.3


