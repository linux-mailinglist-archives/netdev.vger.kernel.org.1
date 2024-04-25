Return-Path: <netdev+bounces-91181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABF28B194C
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 05:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CEB61C22B32
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9A321101;
	Thu, 25 Apr 2024 03:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDi9/AOZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5541CFAF;
	Thu, 25 Apr 2024 03:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014858; cv=none; b=S/LocYF9IqbcdUNZh3jvAIjzLQeXWOx/SFy8G3qMyGtK0oOkK10vnbYFLM1WX2nWGsvgGWMKohknKktrIpi2FThpTnrxdUi6VYVG8q8LSM7ihxRVX1HeUkxBbmyy2a8+caPIAnqPgIEE3bVxb9Z69k4lVbfv/+cEyreDOILLrkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014858; c=relaxed/simple;
	bh=5Twuf+QmvuNeGozvIoYp0oljoELBzYsZuDa4GXIvUGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ttbgIVDNc8DN04yWZ+hTMOrc1XgSngQYvnANj3VMwW6GBFBct8cECzQQ4ivrNk9cg6/7sEWKwgKoT7YuilQXX6ZPAvPYLMlEUsxQWz0X3/IOjlagB4KVZwsDN3VhsYgZuwpSneniQqF15ocSAUWRozPQVoqKtRPlpXmaNLhjJZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDi9/AOZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f28bb6d747so500370b3a.3;
        Wed, 24 Apr 2024 20:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714014856; x=1714619656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3+Qhzs5AOSyz2ITXuZgC1EVLjEOHqqD2ysMgBwoBAs=;
        b=WDi9/AOZXllHubkCGwMPw+8gDwm1IVM4xYLqoBhSud0DSpQTpgS7AbGXOzUVoc4phj
         RFBUJFEvrow+uKN5Hs+H6af/QYWdoJ0oSQ34col3xEdJ04ORq9XxD3hNtvqu/YSoWs5a
         C5+sj7rcCsLZKIKTYcWcIOvaKWJxVp4uS9BJ/sEIN7Vf+or6X6VroVYUUOCbibCfopF7
         /HzjPdMMM0TTk1LXvRmJMRSUIi+jjKwXNiH80esUI438eZYJRPaZmESetL6l7l/UnkvT
         DAaScLtHjlZM+8sBNa1qcE8YI2GHYgZqzkQirMsV+bf/pTey8fr32+Qt0no66E2y06UF
         Mwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714014856; x=1714619656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3+Qhzs5AOSyz2ITXuZgC1EVLjEOHqqD2ysMgBwoBAs=;
        b=KnTOyklGNznnDZF+YkVX4/BpPB0irTDAeMuU48Dw3wRzTjwBXPm6zoa0MK/lxlkU27
         2jWbFpnbgrzi1hDGT5MsPP58AaEn/n//xh/rCyODjSwYHSB1bJ0YoeibW6OP44N5Heks
         2Z4lRrdHTlZk+xRrjyiJ3h/sKrAwHH5KfsFFob4HmI2BZ+X9jZbtgSWo7+2EVsapFr3r
         OX1znWi5zNr8N9NoFEmq2dB7B7WG0C7YOM9e6VgVi9ZjUn4wDWlwR6nfx2c2Rn2j/c7S
         8ufu1wflbg/hXVtVvCPkrovqEvxsBjU9VPq4CEVGEiIk67BSNe1/KyitjA70aWJoWV9b
         c0tA==
X-Forwarded-Encrypted: i=1; AJvYcCW1AwC9FSyWZTbPqk8YdgJITrmg4XlseGDQVomlRkMDD7Z3mF1rAv2Q6jlR0zu6dv+R/JNVBmWqeaCFmbZGXGCXgNk+67hicPaG5EJ4jBdtHL1+DdBWPYe1vsbVNQTsVPNAwCjyGHDjp2+k
X-Gm-Message-State: AOJu0YxXzDQst1F6vYU9BtLJDYdK70ddkBOSaOg3/bRk03Y/MZMlysA2
	4zAkIE8UI0X39TdNQzUrZUpABFB8TCw3x+8k5AGVVUQSkgt+Toei
X-Google-Smtp-Source: AGHT+IGXT08WAfSY9N6LNnChQMP0idSLLdNjAxVSI6PyQz7x57xvQbff1xV0tuZvTAVStGSawFSC/Q==
X-Received: by 2002:a05:6a00:2388:b0:6ed:2fb8:467b with SMTP id f8-20020a056a00238800b006ed2fb8467bmr5357021pfc.26.1714014856426;
        Wed, 24 Apr 2024 20:14:16 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id gm8-20020a056a00640800b006e740d23674sm12588884pfb.140.2024.04.24.20.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 20:14:15 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	atenart@kernel.org,
	horms@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v9 6/7] mptcp: introducing a helper into active reset logic
Date: Thu, 25 Apr 2024 11:13:39 +0800
Message-Id: <20240425031340.46946-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240425031340.46946-1-kerneljasonxing@gmail.com>
References: <20240425031340.46946-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since we have mapped every mptcp reset reason definition in enum
sk_rst_reason, introducing a new helper can cover some missing places
where we have already set the subflow->reset_reason.

Note: using SK_RST_REASON_NOT_SPECIFIED is the same as
SK_RST_REASON_MPTCP_RST_EUNSPEC. They are both unknown. So we can convert
it directly.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Link: https://lore.kernel.org/all/2d3ea199eef53cf6a0c48e21abdee0eefbdee927.camel@redhat.com/
---
 net/mptcp/protocol.c |  4 +---
 net/mptcp/protocol.h | 11 +++++++++++
 net/mptcp/subflow.c  |  6 ++----
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 065967086492..4b13ca362efa 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -21,7 +21,6 @@
 #endif
 #include <net/mptcp.h>
 #include <net/xfrm.h>
-#include <net/rstreason.h>
 #include <asm/ioctls.h>
 #include "protocol.h"
 #include "mib.h"
@@ -2570,8 +2569,7 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 
 		slow = lock_sock_fast(tcp_sk);
 		if (tcp_sk->sk_state != TCP_CLOSE) {
-			tcp_send_active_reset(tcp_sk, GFP_ATOMIC,
-					      SK_RST_REASON_NOT_SPECIFIED);
+			mptcp_send_active_reset_reason(tcp_sk);
 			tcp_set_state(tcp_sk, TCP_CLOSE);
 		}
 		unlock_sock_fast(tcp_sk, slow);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 252618859ee8..cfc5f9c3f113 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -12,6 +12,7 @@
 #include <net/inet_connection_sock.h>
 #include <uapi/linux/mptcp.h>
 #include <net/genetlink.h>
+#include <net/rstreason.h>
 
 #include "mptcp_pm_gen.h"
 
@@ -608,6 +609,16 @@ sk_rst_convert_mptcp_reason(u32 reason)
 	}
 }
 
+static inline void
+mptcp_send_active_reset_reason(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	enum sk_rst_reason reason;
+
+	reason = sk_rst_convert_mptcp_reason(subflow->reset_reason);
+	tcp_send_active_reset(sk, GFP_ATOMIC, reason);
+}
+
 static inline u64
 mptcp_subflow_get_map_offset(const struct mptcp_subflow_context *subflow)
 {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fb7abf2d01ca..97ec44d1df30 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -20,7 +20,6 @@
 #include <net/transp_v6.h>
 #endif
 #include <net/mptcp.h>
-#include <net/rstreason.h>
 
 #include "protocol.h"
 #include "mib.h"
@@ -424,7 +423,7 @@ void mptcp_subflow_reset(struct sock *ssk)
 	/* must hold: tcp_done() could drop last reference on parent */
 	sock_hold(sk);
 
-	tcp_send_active_reset(ssk, GFP_ATOMIC, SK_RST_REASON_NOT_SPECIFIED);
+	mptcp_send_active_reset_reason(ssk);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
 		mptcp_schedule_work(sk);
@@ -1362,8 +1361,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			tcp_set_state(ssk, TCP_CLOSE);
 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
 				sk_eat_skb(ssk, skb);
-			tcp_send_active_reset(ssk, GFP_ATOMIC,
-					      SK_RST_REASON_NOT_SPECIFIED);
+			mptcp_send_active_reset_reason(ssk);
 			WRITE_ONCE(subflow->data_avail, false);
 			return false;
 		}
-- 
2.37.3


