Return-Path: <netdev+bounces-88295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 856E08A69CA
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 13:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18921C214B1
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EBB129A93;
	Tue, 16 Apr 2024 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1XsAJc6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7A1129A70
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267636; cv=none; b=cUYsHEq5YDWMHSUGk/PgeUEKLN8YiRU56luKgqdpxW3TQLzlo/XdaN2FFSaQWodkj+ZvO/BYz4Juesu5swB1kk74wD7pCOtSpPdYwcB+54fJgArpKSaiOyumbgW8S91eSZFs1PkyYL5uAwAmtfg4SjP9zcOAUmxN+bIxvxKugTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267636; c=relaxed/simple;
	bh=If0ixVmS4jqLthHAQJrwikLdIGrKYKIcGDEuRLNduYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JSoic1BJyGyetinjtmXxiyt02WxTu2O7vua7AkVH9JswvZdUz7+kTDOMrNS4RaXCb1BFyTKizL89IVlFRw60oRNjuCzZh5kxVAmZtKJLdeSvQQ4id/ia2CKGxTvl8fjuQcVXulmWX/5E2fNLrmpJzebQMe8mQ0z82NhhXRx2QAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1XsAJc6; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso4043684b3a.2
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 04:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713267634; x=1713872434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gI624BRC7VHIXXWrjtPFW+9g8fWkyjzMnN2FP5J+sk4=;
        b=K1XsAJc6t1OMTNS6aeotf8ysbJHVIo93GGZAtitgcvHCrcv9C2iaTFr3CjTF2ITqBD
         xxgFXFjaRYF8r54v5hl0p6j6qWTxV6z4GfS3p/mvw+KTaTjDTar4gTSsYoPfWm9Tieie
         DxCpNkkFkoo54shFKj/l5g10MdH9hcdZIEUOuKzFVkjtWZkgtLs5pl7pfzDLbM7yJGCN
         1CDCEsG6DYW0I2WKcgU4qIYkdtK7uObu54JewAW3Ln3tMT6A1oJ/0EODbR3U6JjgVfaN
         XJcyD/OZscfHPNHVxYH5XInVD6B6UH8CYbHcdSRA0SPZOSve6ttGJSxUDfP9EIKHhX/e
         /ZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267634; x=1713872434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gI624BRC7VHIXXWrjtPFW+9g8fWkyjzMnN2FP5J+sk4=;
        b=QIOf5UmRi+CbEVp6cyMVg4I6nUklSaYeiVdFiW73E586Or4vmgkGuQop4wdSDg9TmF
         lSOwrttpNGUXkg1byJPJIh3devQJWt9NWZ9lY0hfvUGYjwuzhXYv9CU/BRDnhCxqD5Z9
         K59Ys737PR/3Espt0kS0FAvC+PUEjK7wB63aXTMwzeQM/k8NlSQg0E0JJZs38xeffB87
         5scdISwXkMz4AjWKiv4D6cOw7+OFZOz+2lPwXwr4E4Zu8XiZQtjrQYnMO0vbmiQm82hz
         z1OIJWI42PBOvOjHzOmOkvRAeXz28eN41mT1UTAco+FO0wJVVg+bBT8xtHlo9GSUEWk8
         cZHA==
X-Forwarded-Encrypted: i=1; AJvYcCWC4hIuRIuENZwzPSWFWTZzjInrQM0Z7BWqVc5/L1lXcGk+eVO1yRewNH7b5eGzFyriGbeGxZuPSR/KabRuTu5qdpcvIPrQ
X-Gm-Message-State: AOJu0Yw6x/IYnFF0YPvZRX0C9VF3p5lcRPfUZurylQHiiZ4AilhNi9dt
	HVTnMjao7qZxNN8SSAc/4Z5wi7s8JbVoUJ3OONCqhvXZ4RxNaI2M
X-Google-Smtp-Source: AGHT+IE2dwFcOV4zY/B5HFLQFhG6u6XzpPjpMTRt7YIs6qY8/aqhPsmxMGSKrRc9cMCv6yg1WzDMeg==
X-Received: by 2002:a05:6a00:2312:b0:6ea:74d4:a01c with SMTP id h18-20020a056a00231200b006ea74d4a01cmr15362591pfh.14.1713267634216;
        Tue, 16 Apr 2024 04:40:34 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id a21-20020aa78655000000b006e6c16179dbsm8862045pfo.24.2024.04.16.04.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:40:33 -0700 (PDT)
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
Subject: [PATCH net-next v5 4/7] tcp: support rstreason for passive reset
Date: Tue, 16 Apr 2024 19:40:00 +0800
Message-Id: <20240416114003.62110-5-kerneljasonxing@gmail.com>
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

Reuse the dropreason logic to show the exact reason of tcp reset,
so we don't need to implement those duplicated reset reasons.
This patch replaces all the prior NOT_SPECIFIED reasons.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_ipv4.c | 8 ++++----
 net/ipv6/tcp_ipv6.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 418d11902fa7..474f7525189a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1936,7 +1936,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v4_send_reset(rsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v4_send_reset(rsk, skb, reason);
 discard:
 	kfree_skb_reason(skb, reason);
 	/* Be careful here. If this function gets more complicated and
@@ -2278,7 +2278,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v4_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				tcp_v4_send_reset(nsk, skb, drop_reason);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -2357,7 +2357,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
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
index 017f6293b5f4..e0b90049e3c5 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1680,7 +1680,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v6_send_reset(sk, skb, reason);
 discard:
 	if (opt_skb)
 		__kfree_skb(opt_skb);
@@ -1865,7 +1865,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v6_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				tcp_v6_send_reset(nsk, skb, drop_reason);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -1942,7 +1942,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v6_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(NULL, skb, drop_reason);
 	}
 
 discard_it:
@@ -1998,7 +1998,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
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


