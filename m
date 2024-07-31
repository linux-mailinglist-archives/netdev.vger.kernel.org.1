Return-Path: <netdev+bounces-114550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CE6942DD4
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD481C22F01
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9511AE868;
	Wed, 31 Jul 2024 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxovRMsm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0AC1AB516
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427816; cv=none; b=Znph59gcGm53u0P92I5zn3NOi543Ury4OtN9oXUsfC6PwCKvwPeLbUFvLudB9BD33vYoXTUssoVfWUiWgYP2rtqdHk53K6E3ARMocaZklS0V1Q+G0yBf2yUiMk5UULbe3fCD4nTxmrPW7HKS3YQ+nDYwoYkfZX0hzAqyTx9SyAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427816; c=relaxed/simple;
	bh=wVa1ccJeseNY3fiGdLHG7LQGRcIJthDze9EEAOwxBQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J3PK4HXzV2NQqHx8Z3fbOiLO5BA0iKheYI3tSm9Ulm7UqODKBOyQLbU2k3qvPn8QZz9W/P7AHt4X6HfETHLTYXQ0OBDOyr9L1wLUlgBtAwnUG0mjW4eYCfUH5RxekiFE7cZ9QI0f9MosTL7Ko8v2MDiTQDrTqzSBCR7lry3kppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxovRMsm; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-25dfb580d1fso2463645fac.2
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 05:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722427814; x=1723032614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nd8SawcL1fjjON1L9lvfL4eTUDsCc9Q6YNNuKjobjrA=;
        b=TxovRMsmWb2E5HZjq1UQPO25nhUy3CUGFbOxVIK389t344lCfkO62dLiOC/KtLnwFv
         s48VGiSd8JSXNhjW2tnvXT6dWtkAAhK8v8IwwVu+P8pVnAsJksr8fCFhGDd3rSxDKuh7
         AKhVq2PciiqkorZaZvbYhLgbp6nZgZq4IsfCjeJb3CuviFTETD9iRxvLspuhr/792Y7J
         7m6K4YYCCPvQZosD5/kew/t0tdI1qJ1kfu5WtyLYuMW3K9ZiVk++DV4z3XMpE1OtX89m
         gy6sUsctrsJzfWEEItb1q8oKMA9Xnknis1ZQgf26TTq1nYz6GDEdhgq9WEXAlAOiMNPZ
         N5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722427814; x=1723032614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nd8SawcL1fjjON1L9lvfL4eTUDsCc9Q6YNNuKjobjrA=;
        b=K/g4L+JzNhqxaD5z43+rdeWkOXEaH4LONFfqv0uyQO8j/Ir6AM0UgmfrfPAm+HIrrK
         YcDUVeY2uILqbDGkpP0HV+opJBZw1g5OE+KsB4WOHRvFOL/rzpLL5fWiorIb3jcHtrkv
         cuOlcM6ZQvCcfp9Kh1GCNKUt/QLP5MZ5DjQ+lSWDF6UlzuODua3rZDFz5CiduJYeYIVP
         S6bjYO8bQdV35lzo1VIKarXHgO7h3Klz+LwNbYqztfU3/WlFWmf0lfiLwhdFKHm5lxux
         sdSUWCQoMmp+4zXVuAnAvTLXAoGsimPmthHNHVzPrZz5oCmbpVJW37Twit9KLFf3uGvt
         q0Wg==
X-Gm-Message-State: AOJu0Yy9iiA/EvoYOOR+8acfSvrVNeQfzf5dhTRtCAboGMjLIgyXpkUS
	vr6/4gVfLnUk4rm4UMrg+Dn2Cr7CLh69yPhEr4jMvR6OWYkPOv6R
X-Google-Smtp-Source: AGHT+IG9j0YKGb1bV3qzdefdtJIGefTTLi0AKKBC9zC9Qotn9yY8DVtm0rBOFwY1ond+0CACRr7Cug==
X-Received: by 2002:a05:6870:1690:b0:25d:f0ba:eab7 with SMTP id 586e51a60fabf-267d4d59a30mr17192345fac.18.1722427814018;
        Wed, 31 Jul 2024 05:10:14 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70eca8af213sm7488545b3a.180.2024.07.31.05.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:10:13 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 3/6] tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_MEMORY for active reset
Date: Wed, 31 Jul 2024 20:09:52 +0800
Message-Id: <20240731120955.23542-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240731120955.23542-1-kerneljasonxing@gmail.com>
References: <20240731120955.23542-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Introducing a new type TCP_ABORT_ON_MEMORY for tcp reset reason to handle
out of memory case.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/rstreason.h | 6 ++++++
 net/ipv4/tcp.c          | 2 +-
 net/ipv4/tcp_timer.c    | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index fbbaeb969e6a..eef658da8952 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -19,6 +19,7 @@
 	FN(INVALID_SYN)			\
 	FN(TCP_ABORT_ON_CLOSE)		\
 	FN(TCP_ABORT_ON_LINGER)		\
+	FN(TCP_ABORT_ON_MEMORY)		\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -96,6 +97,11 @@ enum sk_rst_reason {
 	 * corresponding to LINUX_MIB_TCPABORTONLINGER
 	 */
 	SK_RST_REASON_TCP_ABORT_ON_LINGER,
+	/**
+	 * @SK_RST_REASON_TCP_ABORT_ON_MEMORY: abort on memory
+	 * corresponding to LINUX_MIB_TCPABORTONMEMORY
+	 */
+	SK_RST_REASON_TCP_ABORT_ON_MEMORY,
 
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5b0f1d1fc697..fd928c447ce8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2927,7 +2927,7 @@ void __tcp_close(struct sock *sk, long timeout)
 		if (tcp_check_oom(sk, 0)) {
 			tcp_set_state(sk, TCP_CLOSE);
 			tcp_send_active_reset(sk, GFP_ATOMIC,
-					      SK_RST_REASON_NOT_SPECIFIED);
+					      SK_RST_REASON_TCP_ABORT_ON_MEMORY);
 			__NET_INC_STATS(sock_net(sk),
 					LINUX_MIB_TCPABORTONMEMORY);
 		} else if (!check_net(sock_net(sk))) {
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 4d40615dc8fc..0fba4a4fb988 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -125,7 +125,7 @@ static int tcp_out_of_resources(struct sock *sk, bool do_reset)
 			do_reset = true;
 		if (do_reset)
 			tcp_send_active_reset(sk, GFP_ATOMIC,
-					      SK_RST_REASON_NOT_SPECIFIED);
+					      SK_RST_REASON_TCP_ABORT_ON_MEMORY);
 		tcp_done(sk);
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONMEMORY);
 		return 1;
-- 
2.37.3


