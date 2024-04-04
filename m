Return-Path: <netdev+bounces-84715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E15689821C
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 09:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9EB1C23F29
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 07:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0591858139;
	Thu,  4 Apr 2024 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rs7d8n9s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADF95675F;
	Thu,  4 Apr 2024 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215290; cv=none; b=pBPgKWTrbB0dp9DrHrNLy1bZab4vXjI8G/3likHogrQ1v06atlYOXmXMPZBwJ2cggAkE4L6fnzPbWS9++7WLbgE5wrbwwcoKe3nl0t4JEvr2QDy87QG2NQDW2xPweAx/4N7AmY55m2HIDKsFb0a8a0ZDrI5X6z+FZhbzMjXF0vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215290; c=relaxed/simple;
	bh=XwQdJ1YaaAMtdXN9npqhQhlx7+lFvpeEOH+8E1BGeKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jF4e6b/xwxRfoXCdX6cEb/ooSvulY3A22ofwg2azfXOVDcJRDlTCM1woap7i08tF7KfUkd35EYUA8Lr3salTk1/jEXBguTX8HP+WunfAcILxwBdT3f6Kowo/mvn7Apk6/XhuUFcnOccSFuFc6CpGUtHnFP0x78efS1uh7Lw5W2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rs7d8n9s; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso264764b3a.2;
        Thu, 04 Apr 2024 00:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712215288; x=1712820088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bItfs35jBJwYsVcRlz2Ak3QufL1GUraVsJFxf8+lDvM=;
        b=Rs7d8n9syjErn46pOTGBT0tIfOpVB+yRfGmwhBI/Kaq75is0kXZiLTlG8nID+RPWHB
         UqWHqoQzCXgOHwvUO66IOJ83ZlJwrVJgfW99btHFQAtEu68JvJJU3EYuA+TLPbnAqnzO
         aKhSKTFiik3RrrKz2/U/uPSHEHh1c3u9mh/aR724sMImKDVUwArJnSIBd26QXAb7hEBJ
         oOLWWibziDSlBF9MLu3fCU10mK9MnG/xXETektIV301s5IOhZBW/1BGcRU+vCzPcKRY6
         y0Ay1UNpNY2wvBpzp6X/V9C7er6w0xedR+31q2znYRo6K8NQpON0rAdLr+1FxTNWkAAG
         sTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712215288; x=1712820088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bItfs35jBJwYsVcRlz2Ak3QufL1GUraVsJFxf8+lDvM=;
        b=QvnisIY3jqhy54g74N/gHXYfUeE8NdAud5vSBaHB6tB63EKm6nwyFoAG3U6KNxE8wc
         VcEsKgYN+g/KOHk1xgKEX6vjL7gUI8PukDGHbQBaivs33a3HTwHOzMJmDkJEz75YlivO
         /zbN9KfgR+ff29PcT0MiHItgs9SIcF8WSkJk5in6xZLeJ4XXqXx/yITBPDd1LoyrFFV9
         vWqaXZUQwc5899hNOo32QjPy4vibcwHOyTcbuHcNdL155p1Ee6L07KGQdy84J3D2Yh92
         XSaGZO3G/d6ggd7N2IDtQxOP44alJGTkxi9CQT9XcO+QsBqQWkmcchloLzrs3CX+Wzcb
         Gjqg==
X-Forwarded-Encrypted: i=1; AJvYcCUZxBPPT1NAWhYDwlZzXGM/ZnkpUiETjhF2fbVsFevBv4FEQq+qnnGiZ3U2rqFVJGPFroF4yYYlU3g6mrRtROSyEoSu+/RfydcuWFKywqQSF7+ecHTrH6MBdUwTpG0Qcfv1WtGIT2up4VZE
X-Gm-Message-State: AOJu0YwbNTaphwTVXK0rdqIvS5SZ4lpvEIXouKKEf9c8rif75WQUc06Z
	vCqOi+G+lqxnOX9KyDoqSQMD2r3rYLn58mkINRFLvOzTn2o5P+9j
X-Google-Smtp-Source: AGHT+IE21WwNiERpBlyk4bHmJSIsioNkuIjxFf5RmkSh4ep+Z1Hr7F/8youhW3d0v7pmPe+U1uTOIw==
X-Received: by 2002:a05:6a20:c70e:b0:1a3:6474:3953 with SMTP id hi14-20020a056a20c70e00b001a364743953mr1961611pzb.35.1712215288667;
        Thu, 04 Apr 2024 00:21:28 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.7])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709029a8200b001db5b39635dsm14606399plp.277.2024.04.04.00.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:21:28 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 4/6] tcp: support rstreason for passive reset
Date: Thu,  4 Apr 2024 15:20:45 +0800
Message-Id: <20240404072047.11490-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240404072047.11490-1-kerneljasonxing@gmail.com>
References: <20240404072047.11490-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Reuse the dropreason logic to show the exact reason of tcp reset,
so we don't need to implement those duplicated reset reasons.
This patch replaces all the prior NOT_SPECIFIED reasons.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_ipv4.c | 8 ++++----
 net/ipv6/tcp_ipv6.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d8d98db8f58e..1ae2716f0c34 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1935,7 +1935,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v4_send_reset(rsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v4_send_reset(rsk, skb, reason);
 discard:
 	kfree_skb_reason(skb, reason);
 	/* Be careful here. If this function gets more complicated and
@@ -2280,7 +2280,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v4_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				tcp_v4_send_reset(nsk, skb, drop_reason);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -2358,7 +2358,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v4_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(NULL, skb, drop_reason);
 	}
 
 discard_it:
@@ -2409,7 +2409,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		tcp_v4_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v4_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(sk, skb, drop_reason);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 7e591521b193..6889ea70c760 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1678,7 +1678,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v6_send_reset(sk, skb, reason);
 discard:
 	if (opt_skb)
 		__kfree_skb(opt_skb);
@@ -1864,7 +1864,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v6_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				tcp_v6_send_reset(nsk, skb, drop_reason);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -1940,7 +1940,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v6_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(NULL, skb, drop_reason);
 	}
 
 discard_it:
@@ -1995,7 +1995,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		tcp_v6_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(sk, skb, drop_reason);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:
-- 
2.37.3


