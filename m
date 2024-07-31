Return-Path: <netdev+bounces-114551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406CD942DD5
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718B21C231A8
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321CC1AE85B;
	Wed, 31 Jul 2024 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pw51nL7M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EE61AED3B
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427819; cv=none; b=MS3tBhPhYaUj5NHR/vebc4JwkxajY0h12o+NxogD/wmfjGA2cdyNsdFLjO3nBO22U5dmnjigsNaK2okMmhYucypH4hNFL4J9SlXeB/0D4n5s+EfSAvkb1TH2QCQP1eklkUh1dWlA7QxxBPUv6b5OTpHuqwIz7qB26PMvOb1YFdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427819; c=relaxed/simple;
	bh=wKRYlDbDJLM/Gx64el1DdLGR3qFg9OlOfbPy4XoYNfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y2zhveWUmcyb4iwDIh+uTCfnzQ0Ghzx5yrfNGVELr+iOruQgybz+2VOVDGYSmIDjvxzU+xgwRvvZy8eNvjfDWfqWnguAXmg0JjYASqCm/ElTLUJgJwvkbspKGb12YeVrUb67LCvzfbM1SrhsTIGgyGUCpjUiqsR92EEGU7b1AA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pw51nL7M; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70eec5f2401so3067961b3a.3
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722427817; x=1723032617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRADjC01DYCUa6G78E+iirXfPEEhpJpu7Urq/4yWEhM=;
        b=Pw51nL7MV1eptTePpSJIkDI8Z3ujeGC6r6oa9n9ZujeiQ/hqB13/KIiKO5tRD6Mo6W
         tEQT84Qea6LV64QQQ3LhQhb080sPhURzJ9QAk04R1ZQ1NMtd8hISkwM362OHmpYrcmAT
         WJeznx9RqmBGQrVPOv5oe957kHJTY0PwViye3QB4adolM+zUaC5xY35Fsq7cJgjsoURs
         Ht503ugwVUBXfqKN9QM2qdPanq4a4Mrhy7cwbBCrzJgepHMjr2jDDrCxxJ8ZM1W7aAqD
         VlNMe+XRz/2CN/3GLshcOU8UQDXA45200PqNH4SWgKvqHdyRpc1m1HvuFLxj0zW6G+YJ
         mNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722427817; x=1723032617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRADjC01DYCUa6G78E+iirXfPEEhpJpu7Urq/4yWEhM=;
        b=QGCrVn49CGMlHOZORPgjdo5O5t+kzHd7MVVCrmJxvM8hSigkdK5AE4fNRpOq9b4Tn2
         1KLA14vs2p46ET8aQpmGHZEPdK2r0F3hgjrDMZE/B3rJyYoQ7Au1mHtsxP+GRgFjzq5j
         U2OyjoeRT5OoDvzJE9MCB801tFwMsu1Hx44ZmAnBZ9VgIPjjsrMfu+BTNnAgV/CY9ZUE
         1I+NlMpAgnLoo6ZqKM930i5XXVKvdkDxbEA/3IRSPY7qL291Zo/vgIbLFFhtBQAswSbw
         LDnCSIC/aR6DW9XPiEH7RQy/4I2YtRAEVVDX3+pUELOjgAQK/IsXKhDsILTd8wYiaeMz
         QRuA==
X-Gm-Message-State: AOJu0YwGbeRDa8IRWbLoHB2xF1mINeBt1UE655I35+9I2nrbxKS5BGfT
	eQYp5cjdEwzeqnKPukd8C/5bNMAcwJIW6EXzNd2un/ErqYXPQh2k
X-Google-Smtp-Source: AGHT+IHZLMH8fEJeSdaq1IkKIdah8mlFqK0gl/VJ559LDQ7wYA6DHR/+h+F8r6qZUHnwj11/9u8CkQ==
X-Received: by 2002:a05:6a00:91cb:b0:70d:2621:5808 with SMTP id d2e1a72fcca58-70ecea19a17mr15958824b3a.9.1722427816978;
        Wed, 31 Jul 2024 05:10:16 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70eca8af213sm7488545b3a.180.2024.07.31.05.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:10:16 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 4/6] tcp: rstreason: introduce SK_RST_REASON_TCP_STATE for active reset
Date: Wed, 31 Jul 2024 20:09:53 +0800
Message-Id: <20240731120955.23542-5-kerneljasonxing@gmail.com>
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

Introducing a new type TCP_STATE to handle some reset conditions
appearing in RFC 793 due to its socket state. Actually, we can look
into RFC 9293 which has no discrepancy about this part.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
V2
Link: https://lore.kernel.org/all/20240730200633.93761-1-kuniyu@amazon.com/
1. use RFC 9293 instead of RFC 793 which is too old (Kuniyuki)
---
 include/net/rstreason.h | 6 ++++++
 net/ipv4/tcp.c          | 4 ++--
 net/ipv4/tcp_timer.c    | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index eef658da8952..bbf20d0bbde7 100644
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
+	 * Please see RFC 9293 for all possible reset conditions
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


