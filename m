Return-Path: <netdev+bounces-115025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D13944E8E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71674B25ADD
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24B91A99C4;
	Thu,  1 Aug 2024 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9NCXcwX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DA41A721D
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524098; cv=none; b=EfA2ELlH8Phwi+OkMMFStuD3kscQ1xes64OoQOhClxbv8iT6/F0KnzEJhHu/+qTEy7ThdNKR5j2vVTAkO8JLcMPeh9wabKeByScejy5thVAaBAk9zZcYb8L4axKkr1BDiVJsmNg/GJfDHhnTc+uSmXn5+xz2oev1igH9Giq2j+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524098; c=relaxed/simple;
	bh=bB5quX6hf5roJw3OqlmFW9vud3KXLMbEWmO1V3KzOcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=auKXvALvoYMYYj+MKdxigDO6JKKt9MZcS3Y1F+wGF0WKOZ0iaVH8EaPCt0rldVUXufGfz1H+JDB8FQnmEHk1NZNEeZsdHtpMvTpOzJIGjORT+HaRqt2+shw1Kg+8PhFGfIw2kz0S9dc+IS4oiVnsHINMNOcMe4iM04OPb7cv+LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9NCXcwX; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7104f93a20eso1708869b3a.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 07:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722524096; x=1723128896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zgif6oVSTEITP/o4l4CprEQozCE/rlgITlHxlm8H5hI=;
        b=a9NCXcwXfPeZnxYPvEFhuMiaH+vUv/RbvTk5DgjwK5v6NcDt5Mmc+Fi9Of8yd2d9Yy
         nq/gQcKdgvbYy+7Wez2EZnxYVTGM2lZ8O1fJVUgWs01BOY9gre203KR/Y7jEFd5OUaWB
         Xvu2t5U2HVs78mkgfm6XY9wbM0EuYkvgJqlh5sRjn9pN4P6sIMnPRa+nfNkt5OkwC/4q
         pItTO60gpn2yh60NywM5og+f9esqz2+7h1kV6mtGrDgK07M8ebuoept9dGu516VgU2EJ
         jkCwLe64OUaJHhyKbCdnIAyBi+0mYICLcjjl1pvmiNl4dcjIuXrMtpjbta25tSBVoQCD
         kkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722524096; x=1723128896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zgif6oVSTEITP/o4l4CprEQozCE/rlgITlHxlm8H5hI=;
        b=to/9C2U8LQzwzPhgXNpnDNe4aTI3bv628iZLqzSccM1uAq+JiibUWEirN6X9FpRuQV
         cXRHGQoYCFZ8Ti5ZiNUXyKQSNpZUpjgmYHcxxcLhCdRuT7oN9dVQgS7AnxW0TcSt9Mz9
         GwUtdmBUaS/xa5C90U84sG3UlwEEExSpSM44TjCRX0szVaKd5/fis57TvZhnsIu6DUxO
         wTIIlhphh6V8tMakQDH77g6HwYRbeuCFaOhWNvQFOlbQZSoDR7G/AmVHlVcapajQAmoA
         JY9S4cZBjVzM72iEjyXT57hbLFCZOiBlCp+Gdpx/4/SthPNc0NRloDz9DSq+gI85d3eU
         kTtg==
X-Gm-Message-State: AOJu0Yy429aMftMNxnq5COn8rjWgjzavc/pXQ4oEQQX3BvKxlmvamgUq
	9NFIUOa2bTX0hsQb4ufsAFjOM9WFvI5r+a5doU+JM+RhLA/hFF72
X-Google-Smtp-Source: AGHT+IFA/tVLS0S7f5lqvQ3rAPMEjGQbDz39hpmfeWpo/ug1qIbm9Ag1TN1g4zyJlID7I6ktGAaMMQ==
X-Received: by 2002:a05:6a20:2d26:b0:1c4:c4cc:fa67 with SMTP id adf61e73a8af0-1c699624ee6mr554581637.39.1722524096042;
        Thu, 01 Aug 2024 07:54:56 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a35c7sm11611739b3a.200.2024.08.01.07.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:54:55 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 2/7] tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_LINGER for active reset
Date: Thu,  1 Aug 2024 22:54:39 +0800
Message-Id: <20240801145444.22988-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240801145444.22988-1-kerneljasonxing@gmail.com>
References: <20240801145444.22988-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Introducing a new type TCP_ABORT_ON_LINGER for tcp reset reason to handle
negative linger value case.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/rstreason.h | 6 ++++++
 net/ipv4/tcp.c          | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index fa6bfd0d7d69..fbbaeb969e6a 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -18,6 +18,7 @@
 	FN(TCP_TIMEWAIT_SOCKET)		\
 	FN(INVALID_SYN)			\
 	FN(TCP_ABORT_ON_CLOSE)		\
+	FN(TCP_ABORT_ON_LINGER)		\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -90,6 +91,11 @@ enum sk_rst_reason {
 	 * corresponding to LINUX_MIB_TCPABORTONCLOSE
 	 */
 	SK_RST_REASON_TCP_ABORT_ON_CLOSE,
+	/**
+	 * @SK_RST_REASON_TCP_ABORT_ON_LINGER: abort on linger
+	 * corresponding to LINUX_MIB_TCPABORTONLINGER
+	 */
+	SK_RST_REASON_TCP_ABORT_ON_LINGER,
 
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 2e010add0317..5b0f1d1fc697 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2908,7 +2908,7 @@ void __tcp_close(struct sock *sk, long timeout)
 		if (READ_ONCE(tp->linger2) < 0) {
 			tcp_set_state(sk, TCP_CLOSE);
 			tcp_send_active_reset(sk, GFP_ATOMIC,
-					      SK_RST_REASON_NOT_SPECIFIED);
+					      SK_RST_REASON_TCP_ABORT_ON_LINGER);
 			__NET_INC_STATS(sock_net(sk),
 					LINUX_MIB_TCPABORTONLINGER);
 		} else {
-- 
2.37.3


