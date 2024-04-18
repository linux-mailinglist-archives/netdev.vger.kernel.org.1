Return-Path: <netdev+bounces-89219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 277F08A9B5C
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A901F1F231D7
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F421635D6;
	Thu, 18 Apr 2024 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxSQfSYY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B51635C4;
	Thu, 18 Apr 2024 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447207; cv=none; b=ruBlp0lNaCQE3pMapDCkUSQS+s4gAYBTd+528CZ+57tQ3RwKdRVv5ISJaBHNOkt3moSeP6XOtiDhBSvmLV1QA/t+t23gO3MLS6FWZMeVLPys1yrgVtVSlXS/mtWaFZfk7OdN2qCjpIP1F5mYcGi7heZLWU+bYMrxHjpwd0Tci1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447207; c=relaxed/simple;
	bh=9+NXcmGwyt344ac+65+IFERA0aeIWelc23La2k0MJFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ct/EpFK70s/4vvx3rDehG2llMU6/iu1HEMtCRoJ31xVKo+Q8SxcqKbQVsffNb7PHogP4jo3aH+BYbwVLtpxOSi2fOIrnEyQxNCdhYJ4yPFDS3IV9IgMZI+wlaqQib5P5uj+pvrHJsffjVETYlu29lYw3zI/CITwxKLHEz/JQiGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxSQfSYY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e2178b2cf2so7428745ad.0;
        Thu, 18 Apr 2024 06:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713447206; x=1714052006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXPsQyON3TFtDQR7bYganuNlYsXI10vIvS6F+4BgaXc=;
        b=VxSQfSYYSr7V+zjN5V4madTAzY6GiOi56FnsyeIw7YhUyfLeoytPQMbtLdUrZRe+xF
         k2PbtQXX0xeI2ifCXaDDUX+0lGxBucAn4lA17AF81ebTcaQ+vURgZ9hVsafH2fUGzze3
         AcaK8S5S7h2XYyMHZGpJkStPLx0GK4cuF8uuLdIk3V9L1ko8I5G660rvb+jTAMJv7QqO
         nmXZY02R6bmJqg3p50jXXpMHiAq95Cao3E/tht71/3VdYW9MncChgOURz3Yxnq/3tf83
         7ZEvgvesP3Bz4kZu0ziiT9giBxOuDpamxW1LVks5u5b1kUtfrcaw8ZzBLwCtoeIy60aQ
         nD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447206; x=1714052006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXPsQyON3TFtDQR7bYganuNlYsXI10vIvS6F+4BgaXc=;
        b=vq4jEbhS0pnJKMIo+8gbI0wYRwwLR7MAQKExBm1VCBvyyymW/qQJl43UDe/SAvUtpI
         YSR3UagFGU/DwQzc4cVSGynTt6e+u4Uo/EiNiKiTWQe0DNRAT3r1MhCxSROapOSOlW7Q
         AFh3I2axRnkj6xliQ0+p5uIqY4wrbUPdNMSbTQZ79epb4uTH4EV95YurlF3RD1+5Uqhs
         MevEiosmJeCPhSfQAXMNtQCk1jPgJWFOrtWLCD6Q30VKLV38WXsq8AZvbDxKV3fB0IHZ
         N35A1R54mBjp1mdo5kWhVG2oZVTXzweEDyJmPWM6qAi+yVi58T586Td/oEemCVavRRv9
         nZwg==
X-Forwarded-Encrypted: i=1; AJvYcCVF1kVPvWyG+Qw4Gqs95shKRD6Y4R07GEapo0wChIwkMSN1ybsJQsNAKD/YkScfAjv0eVcfyiW3eyRnKKXNbpkUpi59Mu64u1vmmBrEs6LdREQZqkQq4Hj51TOMML90n5QB0PqMfLs4Ebpa
X-Gm-Message-State: AOJu0YwVSaUboUsUXIGAZSbXecYxM0Kz6e9hzpcPru9FITSjYv9JnaaT
	dbHkBv67S6fTD42ySaNp/3rcAN1eZypisvjwSaTM2lFsa8OqV2JL
X-Google-Smtp-Source: AGHT+IET4uBkWueYvNuE9jr28hGuSH8072k7It7gJTltNpltgeOa5nNSgKoCviy8RWdgleE+lXkN3Q==
X-Received: by 2002:a17:90a:db4e:b0:2ab:ca7d:658b with SMTP id u14-20020a17090adb4e00b002abca7d658bmr1905825pjx.4.1713447205673;
        Thu, 18 Apr 2024 06:33:25 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id bt19-20020a17090af01300b002a2b06cbe46sm1448819pjb.22.2024.04.18.06.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:33:25 -0700 (PDT)
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
Date: Thu, 18 Apr 2024 21:32:47 +0800
Message-Id: <20240418133248.56378-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240418133248.56378-1-kerneljasonxing@gmail.com>
References: <20240418133248.56378-1-kerneljasonxing@gmail.com>
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


