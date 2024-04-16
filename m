Return-Path: <netdev+bounces-88297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0348A69CC
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 13:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060991F21D78
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC260129E89;
	Tue, 16 Apr 2024 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK4vm+Sn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44812129E8A
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267644; cv=none; b=odz2N12nGV4uwn1ZJytNOp+sMWfjz63mieatv/lB1Wd7ElLHsQhNyrzxvP3C7TtUHJYSX/DuXWz1xX1MajY+wNM1+RoUTkGQ5RWAzmm+VvxwZ9OBauYD6FXoomGf3ORAxaRLZS+ugJA0HPSrlFLGzTwXO1HEOcYPRis9hy9bces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267644; c=relaxed/simple;
	bh=9+NXcmGwyt344ac+65+IFERA0aeIWelc23La2k0MJFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U1fZEBxbypRsjytg808UKgWHj2HSWH3KWTyDtp1AAdZLUMG2ZLVRDogBeaneqp3h2stuSDfgjekMFSIRRlqGXeAKTf2r5eIcCxt0ofK70pOyZnpkHkb9zHWG8Rck5W/GzOmVMTriECUiJvhCzTbIWZvmBh4hqPnlb8AB08eoOps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aK4vm+Sn; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so2174535a12.3
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 04:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713267642; x=1713872442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXPsQyON3TFtDQR7bYganuNlYsXI10vIvS6F+4BgaXc=;
        b=aK4vm+Sni7GhyFxa0sot21f+h+sAAl1wLT9XuQ3Q3M4c1fy3d9sJwubga6/tQCLaMM
         /ICCl8lLi6/hdLbUxbu3GAoyCSRItQHAN9t/95OVTiUTrkxN6oRa95x5FDMQZQ+Qp6UY
         0r1/d0nV1PKlt+pyr9LMq1om6kO4lQ3UtMY0CkmCr0S85EEL1PeUb8vtWAf2SQTQs3+X
         gwebzATWuLUz8sz5F2orIHQvJqvp3aUdKEjWlFldVRmnVUhl22oQUas8Ss1fpK7+848N
         3trFTG1GsUaBFVLlIfLi9JI5+O9IV/mRlFO58lmJwEBDgTpcneqWtgcFXMQdurUkvz/s
         RNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267642; x=1713872442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXPsQyON3TFtDQR7bYganuNlYsXI10vIvS6F+4BgaXc=;
        b=Z15p/uhk2s1xVlUAvzbcjwxbHL3wxbnvOzzvmPuKlVivbjTXE10KwoAXdT6570T3f0
         9U3SsSzAdK1fadolgY8Mv1BuBVXcNnxPxibOMUevLYRqHJoFtCAajw6cnjFy1RsAftRU
         ZU227dhVqIFxHFveg8kLoWIaSTVUMQO6uxh5fXk1HdlyWTv/9R3eoN2KOwjvlP0DlQCq
         AE3rlWWE6aV30xa9A+5wSLa7KbkvZH+I2aUHiBP3RnN3GRcO/lQsyIETQFmBSXjazZQw
         OKthFIkgzOrVhZiihaTXUzWsTUSO4yl6R6mzP0RhBbYnpiaEYYX5JGGYbwt24rNTfyad
         nOrw==
X-Forwarded-Encrypted: i=1; AJvYcCWnxMMFIysRfMZLSEcTIeJ78sJAER9xszmUEOnRr++HQJ0ThWnvGXPQRl3eq6R8owQB1u3ehnijqgaKPLUrZs34vLrBWRoY
X-Gm-Message-State: AOJu0Yx+CVUwQ9Dh0LmUMKeGT4fA9xYoiOlulYT449zEEBcSsWqL4Hmj
	VJmO2NCx1Kkw4Drd83FE6GiVt0skId8zQoAUvGZet5vED5Lf56oa
X-Google-Smtp-Source: AGHT+IEm5A6jT+QGQHERvvGqADXMfEefRQUAVhU84i4vmIlcqJfSQBMWf2rQhxtQGSf4Fu0MKDeoIw==
X-Received: by 2002:a05:6a20:3250:b0:1a3:8e1d:16b8 with SMTP id hm16-20020a056a20325000b001a38e1d16b8mr10410698pzc.28.1713267642554;
        Tue, 16 Apr 2024 04:40:42 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id a21-20020aa78655000000b006e6c16179dbsm8862045pfo.24.2024.04.16.04.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:40:42 -0700 (PDT)
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
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v5 6/7] mptcp: introducing a helper into active reset logic
Date: Tue, 16 Apr 2024 19:40:02 +0800
Message-Id: <20240416114003.62110-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240416114003.62110-1-kerneljasonxing@gmail.com>
References: <20240416114003.62110-1-kerneljasonxing@gmail.com>
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


