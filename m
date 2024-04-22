Return-Path: <netdev+bounces-89918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275B98AC2E5
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 05:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA17E1F20FA5
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 03:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD044EADB;
	Mon, 22 Apr 2024 03:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsLj1NQk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5CCDF51;
	Mon, 22 Apr 2024 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713754905; cv=none; b=tegvw4l/3+5le2D5oNPbZ7poT4xPgjSdhNDezkOwB0FlJBpC9P0Uw7JoKeUG8exJ85GeB9oca81hBM4EmfKgU9NPk8WoZR2bYNWZVC0btdC9JxOk7pm1R/p8UM46XZlq35wadk+slhUdPS+uIE6dI1QLxpMTC3APLZbHzQTRu2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713754905; c=relaxed/simple;
	bh=RTWw1RJ8Sf7w+SDB/NEHgvuOa2DragyZlMgGDPZ1xOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g/sobe58FFaXP+PmZg71gjcy4hsd82NlDvQ9uAaLyw7y37p4wWFT/Br64WYtVVUgg9tcyjHC1lkXFmef0/4QdFpDuviJeKnLMX2yvt1Go3BUZcPQAAQKFTdYi1YZSNmNm9jPs3T5W5ioSL6LgO999xUL9TY919Sn/a3+zAvMkas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsLj1NQk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e8f68f8e0dso13359715ad.3;
        Sun, 21 Apr 2024 20:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713754904; x=1714359704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4wkux2748y2lve+W5fu/atZMum4Uf95bxiqhm5+aE4=;
        b=QsLj1NQkM4ZIWVFMJN1whoxTi+DfhWIJeqOyJpiagIO0TRaHN7TkBkcVZC6pgqlelP
         /FblaqWp5UF/4jwsTq4C4Whb2k/wsPIC0xaNHW5QXTJmsHkNtsGqJ9r/TWM+9nU8exJv
         P9D2XpLZH0EljMNVpSsiI18YbzqFyFuaYq9gwLPWZiYAh24Yd+6+gBxwUs803Orz6xSD
         Zu17SnnKezhhx19yAINbpq3c3weuVv17JfP72k6UHCBxR8VRQPPYxIdKhiKUHcaIDbGa
         C3ytNtLAacVReNG6QpxnRXHN/pqqUlGQxyzCM6Vv2RENBRQKKE7Wmdrge6rJe/MH9A42
         wt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713754904; x=1714359704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4wkux2748y2lve+W5fu/atZMum4Uf95bxiqhm5+aE4=;
        b=e1kP8ltJsB5kNMG0Oa5r3NVsxxSAMbrin6LZ5N+UkFZMfPw92lbKVO8+3zCJuXSRus
         1feWhrLNZGThlg3BkZXQonzLzCHJhZUeMSBmzcG5BuMsbmcKmz1cbuby+wox2+5OwrUx
         IFwzYnu2m1VGgXXWnOIZA8gh6EaE5DySvOos1FFype9tpHq4y0Oe6Trq7+GHfn+yJ+ki
         Px6Gb7xox7aMHXIxGsNdet+oT6Gv4FX0pT8iiCmWZb2yRm9ZTRsejnGNvvvC6gfOiDGt
         FOfHC7Erq9gdyAMf/QMyNzRXfTcnPmrjrgMK1e8oPjmQO9GCtL7dfgT8183IgSn1Wgf+
         v8cA==
X-Forwarded-Encrypted: i=1; AJvYcCWH6qgfo7IWZqd/o1nPV2Zg3koE0MkNK3/zqJ84Fw28W2dNzdCbrJ5UEgwv6ERuWP/LG6+8KzO1szMsIPdtdAMSEkVogdVppnNY0CcZm1GJNJMCX+4i8F41edkuYW1FGw1yuWrSrl8+xA7B
X-Gm-Message-State: AOJu0YyAwbiUCljYIEVbIUYvrzM9QwdmMOvNbyV45gFxfDzDkbXtOdKT
	U0YRa8I1GnrhQqklFob/PVW/DD+FfzMosjr1p9khVLhyJKqL3JvE
X-Google-Smtp-Source: AGHT+IEtILAJBXJMCNC/pVUC6tjFc4Hym76dZ7HfiyZqXWhrh4H7sB5XUXK/2EZ84XaBHgloMANfUA==
X-Received: by 2002:a17:902:d34d:b0:1e5:3554:d9da with SMTP id l13-20020a170902d34d00b001e53554d9damr8008616plk.34.1713754903814;
        Sun, 21 Apr 2024 20:01:43 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d60500b001e421f98ebdsm6966009plp.280.2024.04.21.20.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 20:01:43 -0700 (PDT)
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
	atenart@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v7 6/7] mptcp: introducing a helper into active reset logic
Date: Mon, 22 Apr 2024 11:01:08 +0800
Message-Id: <20240422030109.12891-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240422030109.12891-1-kerneljasonxing@gmail.com>
References: <20240422030109.12891-1-kerneljasonxing@gmail.com>
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
index fdfa843e2d88..d4f83f1c6880 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -12,6 +12,7 @@
 #include <net/inet_connection_sock.h>
 #include <uapi/linux/mptcp.h>
 #include <net/genetlink.h>
+#include <net/rstreason.h>
 
 #include "mptcp_pm_gen.h"
 
@@ -581,6 +582,16 @@ mptcp_subflow_ctx_reset(struct mptcp_subflow_context *subflow)
 	WRITE_ONCE(subflow->local_id, -1);
 }
 
+static inline void
+mptcp_send_active_reset_reason(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	enum sk_rst_reason reason;
+
+	reason = convert_mptcpreason(subflow->reset_reason);
+	tcp_send_active_reset(sk, GFP_ATOMIC, reason);
+}
+
 static inline u64
 mptcp_subflow_get_map_offset(const struct mptcp_subflow_context *subflow)
 {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 54e4b2515517..423c842086ff 100644
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


