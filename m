Return-Path: <netdev+bounces-114154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E9C941340
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 959DEB23775
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB021A01D3;
	Tue, 30 Jul 2024 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAuHPpKD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5D81A00F4
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346539; cv=none; b=rUwttZqYfr9uwSUL5YFiWASuHBvv52nMqwY9rilaZaBQRH8FH5UkwE4gozFpv35+uZWq0AP2ibSHggMAS3V80ueiDYeKCCeT3V/FDV1X8RPAH0bST0/WGKqgmC898t68WiqDNlcKMaSA5jcvBTfD/794KtmcEE15tXJH13fv4wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346539; c=relaxed/simple;
	bh=gNRYtyPxTW5j0lVp3MPsk/y0Ru1C6PQUvY0RuwJleqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LW2vGnZvnLq50utcovMHE/b5bsE77V5NzVXFR7nd3/LQL21tRfJzZ+D+XCT0dS6J0ZcD4JVnqzHFyauJnnDcgHsYvt96msruq3esNzyzVR8U+rLb0ZpjB25jFluyAfvY7ACRc6EWfc7hezeo/e+lLDufYRT+on5+ZJxy+V+qQcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAuHPpKD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc658b6b2eso33492835ad.0
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 06:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722346537; x=1722951337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrQYXJBKKEioBOqfWbTtlBWFqhm2B7GtE3jbVtpk0tU=;
        b=fAuHPpKDtLQTFohHGozxdbu4/Hgu6s5tTzWX0avgZ5RN9ukQkcdacsRndDPsqTitNH
         GpA9EeF3/T0WWoVZ0hG6LAbTfc58+n0Z7VVl7JaNqHUiWzfA9BfcoMArDnvfgFVLD0oa
         51y2wwGWE13a4vJIBSvHNXAjVvFxc9y2b0Ik3f2u7sv6faKD/5XF762lcGCz/Rg+xlt5
         uDsCHErNfKPq+YdVsEjtxPWiRwHWbledYa0SbLiP48oTaZGCO3F8Ltz5nZLaY3vX4zuv
         P1fuPrPfaWKKNpbV7i95zOT0wGd6VHir1dYz2DpRKsDE1YTd7UNXRMdaJ9WySYZfF6Aq
         s2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722346537; x=1722951337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrQYXJBKKEioBOqfWbTtlBWFqhm2B7GtE3jbVtpk0tU=;
        b=udh2LAp/pRtRvWRksKTL7H5vddjZwBA76c44P1YqLHIuS6tbVCrEwzYYo6zKJrCXVA
         WXoAsZk/XNUVRD7HuDAs1rYnXaUNX2leObo91jNKzSdUuVJzeoNcbnzqu3EU8g5enXSC
         IxqaVN09hxvolfVbhbe/eYDsDXPcySNPb+HLtPQ1q8ZsTop0sU5R/1sjIwA0E8jY7eSW
         qv4fGykhgKkq08nR2RF36b7lgOZfobdYnqtvMv+s3AYQhQw5miBa7stonVtq4r9CgCiB
         1YS4fFxHlCWZ7EnEi8JV1oYRtIu2YCyZuJOOH4CXd2MacPuljy21BzlNz3DlTH1+/HzI
         NXlw==
X-Gm-Message-State: AOJu0Yxu2CWPOgtev4InFcZiytQHRB7cYrjZodA1KzjIepEQ/JBXrEMo
	WAGhPfcg29YrHqI174lmYrSoEIQ64X8eSMni884vf8Sn1ISqdmeQ
X-Google-Smtp-Source: AGHT+IHkHILUM3Y06/JXPevGkqHgyam6P6Ei0HXJzlWST4G0NLgof3/PIrm3lmoW5z21YI6lqDpSOQ==
X-Received: by 2002:a17:902:f683:b0:1fc:3daa:3a3 with SMTP id d9443c01a7336-1ff04854dd9mr129624895ad.39.1722346537548;
        Tue, 30 Jul 2024 06:35:37 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f9f279sm101562515ad.256.2024.07.30.06.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 06:35:36 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 4/6] tcp: rstreason: introduce SK_RST_REASON_TCP_STATE for active reset
Date: Tue, 30 Jul 2024 21:35:11 +0800
Message-Id: <20240730133513.99986-5-kerneljasonxing@gmail.com>
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

Introducing a new type TCP_STATE to handle some reset conditions
appearing in RFC 793 due to its socket state.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/rstreason.h | 6 ++++++
 net/ipv4/tcp.c          | 4 ++--
 net/ipv4/tcp_timer.c    | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index eef658da8952..fecaa57f1634 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -20,6 +20,7 @@
 	FN(TCP_ABORT_ON_CLOSE)		\
 	FN(TCP_ABORT_ON_LINGER)		\
 	FN(TCP_ABORT_ON_MEMORY)		\
+	FN(TCP_STATE)			\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -102,6 +103,11 @@ enum sk_rst_reason {
 	 * corresponding to LINUX_MIB_TCPABORTONMEMORY
 	 */
 	SK_RST_REASON_TCP_ABORT_ON_MEMORY,
+	/**
+	 * @SK_RST_REASON_TCP_STATE: abort on tcp state
+	 * Please see RFC 793 for all possible reset conditions
+	 */
+	SK_RST_REASON_TCP_STATE,
 
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index fd928c447ce8..64a49cb714e1 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3031,7 +3031,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 		/* The last check adjusts for discrepancy of Linux wrt. RFC
 		 * states
 		 */
-		tcp_send_active_reset(sk, gfp_any(), SK_RST_REASON_NOT_SPECIFIED);
+		tcp_send_active_reset(sk, gfp_any(), SK_RST_REASON_TCP_STATE);
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
 	} else if (old_state == TCP_SYN_SENT)
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
@@ -4649,7 +4649,7 @@ int tcp_abort(struct sock *sk, int err)
 	if (!sock_flag(sk, SOCK_DEAD)) {
 		if (tcp_need_reset(sk->sk_state))
 			tcp_send_active_reset(sk, GFP_ATOMIC,
-					      SK_RST_REASON_NOT_SPECIFIED);
+					      SK_RST_REASON_TCP_STATE);
 		tcp_done_with_error(sk, err);
 	}
 
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 0fba4a4fb988..3910f6d8614e 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -779,7 +779,7 @@ static void tcp_keepalive_timer (struct timer_list *t)
 				goto out;
 			}
 		}
-		tcp_send_active_reset(sk, GFP_ATOMIC, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_send_active_reset(sk, GFP_ATOMIC, SK_RST_REASON_TCP_STATE);
 		goto death;
 	}
 
-- 
2.37.3


