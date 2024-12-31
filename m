Return-Path: <netdev+bounces-154615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 107959FED0A
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 06:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38AEA3A2ACB
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 05:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371ED1607A4;
	Tue, 31 Dec 2024 05:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB1Lh4T7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9940A14A088
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 05:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735624350; cv=none; b=C22WuXhzjmvhW7BmK4GHI5CzYitIa/RYGoOSceY/2CYUCTyBBG2DkIITeEi6T/lEuOasaPbFEh7snD2tVdYBnwB7kHadJQiC2EdhW8H+oMveotlcF20S9t64CBroQm04kGgpP5qrXfh6oN9HwvyOm9UImK+9Bk1QP89N/sT09Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735624350; c=relaxed/simple;
	bh=vvNleVMhSdxjsgoYbs5epPk1Svx9RdPZpGsfwqdDkbE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dDdrfItCEUcN6+NlqaAUirSOHJTVeCvo6IL0QLG7q/PWd51oPBEYE3ashYDgXEVgdDX15OfF54qY4MjVBVXdBJ444vVwS1WtTApDm4HnpMTtJLzdbZlfJmqJo8vZrV8bHjC8aoBayVQH7bHJ1q4NAWVovTK3o1VKWrhH6yQflL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XB1Lh4T7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21644aca3a0so35419935ad.3
        for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 21:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735624347; x=1736229147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X3BlMCTrPLUswA7xJw49Cs5Xb1aWcbAn5FALsmHN0Ic=;
        b=XB1Lh4T70YEvxbUTORMEWosmEjL8o3/I6Xvuamz3GOI7DOlmuhQ0jxZMVw4Nea0vEm
         y44PwqbDGjfS9Z+6F0kukbQ09iLLG3gP/znu9uim1ysq+/KWN/RlyDVu6QboscfHKjbY
         Y7N8K5ciXPPf0Nan24bcmedFLyzixknwbv+pb5sNzsRIq1TPk9qNcX+dbibPFE3ZRGdU
         YPRtMkv5oCY1xkq2j6r3GFVAiruiCyLYuQ5CR+KNUa5FQEmKJlZLlOClxTUYovUoP2gG
         1mjZewowlDb7DG1K+uL5X7cpSiuq8QoV2hnR44eQI3F/UvRx2kg9IEGhGY56lPrrgCLr
         kEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735624347; x=1736229147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3BlMCTrPLUswA7xJw49Cs5Xb1aWcbAn5FALsmHN0Ic=;
        b=Er1McwlVthUsFYOJRgxeGvfyLOAYhAWeYWKroc2nlWSl16FqijwLZUJX74gCZyyHTP
         zJtEHZiKex93YctIXCyFtLjtrga/wSi1zBpkyaTkr5vS7LrMy5rqRvXl8JpBH/rNttCF
         9ijLTwSqivW8ey+fq0pXMAHIFm3om4d8Zy3ZA/qagb0WF9xYJ2ETNzkcXtiKbDZqoeYi
         CKglg6+uRH7rPuwWRdScLO2latrfUhnUxBKIeG+ucP9WrO2e1byHRlPVD6/YKLLu6Z4p
         Lg1RiIksacvIf5kz480ThX6HQxcag+B3mepfkRhif+iWD7vPiE7XdO3YMawWpYePyco+
         VBgw==
X-Gm-Message-State: AOJu0Yz/d61H+79SF4t+iobxmWSpessf/I0eIMicmgmz4TBpL75QUhYi
	oVuLcGxQa8UYxs6hokfJ4W/geDVrk9qauC/nTl8ZBvOI9iPJO/dc
X-Gm-Gg: ASbGnctHakocgLsuKO4IjtPHEcUk43srWNOpO/aDx8v2/fWBM0ZMwgrotghWh4DJCT6
	TB+bOjn5e6QmnhveO8F0lOws5EhlOpFQU6lOuwq5mKAFaNv3qmJHCyVoBswoadRZDBQdJeGOqDF
	vgPcO6hZHYvSc2T8fI0uBti1sW37p743jnno8aM41q23iFdPsVBlhxUHqTTBTayjuxj/5ZpQKU5
	LTqKocVCsIObvqsfxbMLi4W5aWY2+Otf8XivIXw4W3sBa6ASSjbXzdM+ADPfYkmscKr1K+jomch
	wOJM+oXq/M8f
X-Google-Smtp-Source: AGHT+IH2Jg7mFJdFg7MhA6U4p0FvYQM4qd+4LKaSyvfh0mv4jTcwbNPicnPeSvpgHTRxWY0RfOqe0Q==
X-Received: by 2002:a05:6a20:7347:b0:1e3:da8c:1e07 with SMTP id adf61e73a8af0-1e5e0458ea2mr63030356637.7.1735624346772;
        Mon, 30 Dec 2024 21:52:26 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbc01sm20779426b3a.125.2024.12.30.21.52.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 30 Dec 2024 21:52:26 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next] net: tcp: Define tcp_listendrop() as noinline
Date: Tue, 31 Dec 2024 13:52:07 +0800
Message-Id: <20241231055207.9208-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LINUX_MIB_LISTENDROPS counter can be incremented for several reasons,
such as:
- A full SYN backlog queue
- SYN flood attacks
- Memory exhaustion
- Other resource constraints

Recently, one of our services experienced frequent ListenDrops. While
attempting to trace the root cause, we discovered that tracing the function
tcp_listendrop() was not straightforward because it is currently inlined.
To overcome this, we had to create a livepatch that defined a non-inlined
version of the function, which we then traced using BPF programs.

  $ grep tcp_listendrop /proc/kallsyms
  ffffffffc093fba0 t tcp_listendrop_x     [livepatch_tmp]

Through this process, we eventually determined that the ListenDrops were
caused by SYN attacks.

Since tcp_listendrop() is not part of the critical path, defining it as
noinline would make it significantly easier to trace and diagnose issues
without requiring workarounds such as livepatching. This function can be
used by kernel modules like smc, so export it with EXPORT_SYMBOL_GPL().

After that change, the result is as follows,

  $ grep tcp_listendrop /proc/kallsyms
  ffffffffb718eaa0 T __pfx_tcp_listendrop
  ffffffffb718eab0 T tcp_listendrop
  ffffffffb7e636b8 r __ksymtab_tcp_listendrop

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/net/tcp.h    | 13 +------------
 net/ipv4/tcp_input.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index e9b37b76e894..65e6357e893b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2537,18 +2537,7 @@ static inline void tcp_segs_in(struct tcp_sock *tp, const struct sk_buff *skb)
 		WRITE_ONCE(tp->data_segs_in, tp->data_segs_in + segs_in);
 }
 
-/*
- * TCP listen path runs lockless.
- * We forced "struct sock" to be const qualified to make sure
- * we don't modify one of its field by mistake.
- * Here, we increment sk_drops which is an atomic_t, so we can safely
- * make sock writable again.
- */
-static inline void tcp_listendrop(const struct sock *sk)
-{
-	atomic_inc(&((struct sock *)sk)->sk_drops);
-	__NET_INC_STATS(sock_net(sk), LINUX_MIB_LISTENDROPS);
-}
+void tcp_listendrop(const struct sock *sk);
 
 enum hrtimer_restart tcp_pace_kick(struct hrtimer *timer);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5bdf13ac26ef..0fcea815860b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7174,6 +7174,20 @@ u16 tcp_get_syncookie_mss(struct request_sock_ops *rsk_ops,
 }
 EXPORT_SYMBOL_GPL(tcp_get_syncookie_mss);
 
+/*
+ * TCP listen path runs lockless.
+ * We forced "struct sock" to be const qualified to make sure
+ * we don't modify one of its field by mistake.
+ * Here, we increment sk_drops which is an atomic_t, so we can safely
+ * make sock writable again.
+ */
+void tcp_listendrop(const struct sock *sk)
+{
+	atomic_inc(&((struct sock *)sk)->sk_drops);
+	__NET_INC_STATS(sock_net(sk), LINUX_MIB_LISTENDROPS);
+}
+EXPORT_SYMBOL_GPL(tcp_listendrop);
+
 int tcp_conn_request(struct request_sock_ops *rsk_ops,
 		     const struct tcp_request_sock_ops *af_ops,
 		     struct sock *sk, struct sk_buff *skb)
-- 
2.43.5


