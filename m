Return-Path: <netdev+bounces-88619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379968A7EB4
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 10:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB61285F2A
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8882D12C48E;
	Wed, 17 Apr 2024 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch8CGTMQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312CF12C470;
	Wed, 17 Apr 2024 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343938; cv=none; b=ScS9jXBv5xe391EOKSS6gYDErh4fXV9jYCWNIVl18m/CJs+26k2+MwlCBbnJtc+8JHzbWnU8qE4OIztCxRB/KCSPLrjEJEV4Dmb2Ix5PDRab9pf5+zG0m1tzekj9kqF7unlMz0A3Feuck8Ex2I832iMIC8N5syKeb0Nmeq1eDKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343938; c=relaxed/simple;
	bh=9+NXcmGwyt344ac+65+IFERA0aeIWelc23La2k0MJFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CkTEGSrMJQoH5W5mG5QgLkSkiKoO0Y4kqvKV62xzEBIDRG7VVYr+npAWuvZ5hGRQCuKB3M+9JdRo9g4ppGv+887xG1Kt91xgRjh5MqD7arOo/qKwlI2Gmp0dN0SXRds1qBkk5d9EOs2xeO5z6FS59KtuLWFh9UJfRepgeLis9pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ch8CGTMQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e424bd30fbso41409445ad.0;
        Wed, 17 Apr 2024 01:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713343936; x=1713948736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXPsQyON3TFtDQR7bYganuNlYsXI10vIvS6F+4BgaXc=;
        b=ch8CGTMQOrnN1hF1SLpOqDKv1J9LbSOUsXDsvmDzO383imDpNIm7HY/btAfCkOq6wD
         uDHN5DTMIeHzXi4jyobulhgmiDXZY6FMOF7/yrWQmDmWHQZhCvm94nzlh8pDmu8cKVhl
         iPnG7uUxCIsU1fJjBz/4VENW3ZMSu/9yjtTCeRfF1xt8yarB6u85xnEumqsU40i7VvW8
         JzDyjsadDasqFVO8hy40OpO7+/LnoURx38lhgcRX7XwZkMX/KqKOO8Y1tNonM0cdhmH0
         qPZ8mi931zwFkv7HXejbjsAZ3DHWES9yn5wKB+bP07aUERS+713Ww3jRpxeC9h3/MqHP
         M2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713343936; x=1713948736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXPsQyON3TFtDQR7bYganuNlYsXI10vIvS6F+4BgaXc=;
        b=MQMmTfJ51c5jKW82KepP0tuRaMIowk4fleF3ULUdq8YZ0soCFI3BMxoZJ6tTQvjkF2
         ste0W48F+UnICr3lXLaAenonmVWPYTiWXrO8NjIeF22Q2ThC6anZnVzrVtBX2dMknC8H
         7Qex0ZNaCH3vhhrf9B5DsLv0jBZglvydjpSHmCx8J4xUhf3tV8geFDZL1jOvzGXVqlw/
         UXV+V6C+3TYROOa+GSz8ncBlvukqN4rGdG7oko8v5lX/pce9wSyjEoeLJaHKsSmsYuQe
         Sx32QCvanC1wAl/PczQu/VckBFnndczerjr61ohCsYIr4k0pscLFyV7+JfjoHYjb48VM
         tU6w==
X-Forwarded-Encrypted: i=1; AJvYcCUvgho8pCL64tMOo4wBT81pL12RABERrF0+8PRbgvfv/9wuj13wRpq99hTzkrTZQkNSnLoPZkznrfXcM7P4cYWyw7MJ1agJf4oVqVySjTIytpjcc0lJLpjQGY7LVslrNsL3ydzZfHokMftZ
X-Gm-Message-State: AOJu0Yz/B2Hs4ZXdopUpIf+11SIxJ6z5nVszG/Ey86qfwaIOhau5KTn2
	sLqXZdPzG/PZHWqWPbbcEP0QyPdkxuD7F8fokIzYCFalbeDQHzI/
X-Google-Smtp-Source: AGHT+IGpyr2TT4oCCA250B5rHj8g9n6uOg+JRF31TmN7I0IAFPbNd+V2kkEZb14DBv3LVjmfH0GqdA==
X-Received: by 2002:a17:902:d4ce:b0:1e5:5cab:92ee with SMTP id o14-20020a170902d4ce00b001e55cab92eemr19923004plg.33.1713343936501;
        Wed, 17 Apr 2024 01:52:16 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b001e452f47ba1sm11348611pli.173.2024.04.17.01.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 01:52:16 -0700 (PDT)
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
Subject: [PATCH net-next v6 6/7] mptcp: introducing a helper into active reset logic
Date: Wed, 17 Apr 2024 16:51:42 +0800
Message-Id: <20240417085143.69578-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240417085143.69578-1-kerneljasonxing@gmail.com>
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since we have mapped every mptcp reset reason definition
in enum sk_rst_reason, introducing a new helper can cover
some missing places where we have already set the
subflow->reset_reason.

Note: using SK_RST_REASON_NOT_SPECIFIED is the same as
SK_RST_REASON_MPTCP_RST_EUNSPEC. They are both unknown.
So we can convert it directly.

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
index fdfa843e2d88..82ef2f42a1bc 100644
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
+	reason = convert_mptcp_reason(subflow->reset_reason);
+	tcp_send_active_reset(sk, GFP_ATOMIC, reason);
+}
+
 static inline u64
 mptcp_subflow_get_map_offset(const struct mptcp_subflow_context *subflow)
 {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bde4a7fdee82..4783d558863c 100644
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


