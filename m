Return-Path: <netdev+bounces-88617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6BA8A7EB0
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 10:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9925F1C20D95
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67D012B16E;
	Wed, 17 Apr 2024 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMgiwBg9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E42129E8F;
	Wed, 17 Apr 2024 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343929; cv=none; b=QGWuCF94u562phPpRC3e+sB1q0Tzjuxm/xj8id+etjA341TjmsxqrfdrGWmzTab1oStZ6XjCcHescIQIPL0qYaSGx12cBYW+UGRvI8DRjoCc5Bgn5JvDUm/ENuqkzSvJ7jYRF24NVO380VEAsR5ODI6opDkGa/wkk6Q+RU1H5KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343929; c=relaxed/simple;
	bh=Sg52tjwZu02VauEN2wifSM/4N8k/GSX65W7rSwbBSOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MViBzrKgDe/2IhEDCr7hiFnenqtHD0WT8hQ3g7Fccw/4sQ4TRRRTOr8D9xDc3lM6VJFx5Tu/8ybUsFe16RgTCWC0bRIbruuJPY9hlqZNBcs8HAwTvsoOJ0w7vA8ARa5qh7bQP7oznkYmbrI4e4o7TIjLroZZlbBO4WehkwWxYzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMgiwBg9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e0bec01232so44369325ad.3;
        Wed, 17 Apr 2024 01:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713343928; x=1713948728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZaHHJogYh/uBF5yMrMV9lgM3yab7Wqg84yx5am8bms=;
        b=CMgiwBg9SkxlUiQmXAFBYCc7DRNYuShwTrkEh7X7GbgyKFkZuwyIoanuanc8geEfF5
         14wBifUgNJ5x6kTzrz52DSJf/kwstTpPfDPZY5DRRjMnZYr1OI44RmrFBubNC2a3C2p6
         4HKyB3ZBy3ms2lCb7cBCYgzwaUkXxpniEAKLsmMkkyL9D7RhixbcJEB7TQEBu2/YTxPq
         dmQ2/S8VQuxLhXAEA/FkNb4NgDp5agrKfDz4AVMVpc9G330AEi6uqbzHhr2ZQkQxtnzJ
         vM0iMySSwWeIcnJAjGFs8xdOdaEHCtDKdAoiWXBRDCNyAnf3sAMXT3TRPPhK26cTvQ+5
         uvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713343928; x=1713948728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZaHHJogYh/uBF5yMrMV9lgM3yab7Wqg84yx5am8bms=;
        b=ITa+gOCMvVVVVc6wRThRIjh8pQHHQZDo+OkAROYD/8T5wlD4xAX1K0PEOrbArUzfGx
         3nsW+not9a/XvPLyRil89tzAWJckD1vw6HE5OCTUbHLQgw5klcpQhxnqvnwVl3mNbcIW
         9tKGHbPg/ZSX46JsL8UVqsFB4wkEZIIxfG/DVCC3mD5A5q/hPIDEQt6ViJFso8dxYKRj
         tpBJx7/D3agaBb0nA7wl1nFjwfR/KNbMlnCbORA/2eAKYjR/bwL03YNT60LgOIu4F7/G
         c0hFfreHniewhhBonGhlf0lcxfFNa7/gbzc/1CeZ5pvbAzCzJ04gMV/8QplLzxe1Mo47
         PUtw==
X-Forwarded-Encrypted: i=1; AJvYcCVBpBvw9ND4XkFrVEDbpJwbBk9Tslfo6WDQFxtWTFyCi/N6zSvS6hWNd67V4+TkDybPvnKoe896Lz70fL74fXcO41v7V5F9P6D7b4z5bAyKE2glz2iOxTrh1wugzUWofjQ2tp7nJfyB5OhX
X-Gm-Message-State: AOJu0YxnzwwbWlmUMB95lrLi3p+lwxq9bXmhKenkOrw3WagTi/xO+9gi
	88kaCbeUwZJCbEWWEh6JROsdfvFA7qpFEnVoA1G9zCOFRo29UZMv
X-Google-Smtp-Source: AGHT+IHfbJQQkqEXUGIoWQvJvxqOwXmwLTmClrFzKOUjG7cLUz0s49LjxNYfzdPEy1V1b34gSVrENQ==
X-Received: by 2002:a17:902:f545:b0:1e3:d4a2:387e with SMTP id h5-20020a170902f54500b001e3d4a2387emr15934235plf.1.1713343927736;
        Wed, 17 Apr 2024 01:52:07 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b001e452f47ba1sm11348611pli.173.2024.04.17.01.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 01:52:07 -0700 (PDT)
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
Subject: [PATCH net-next v6 4/7] tcp: support rstreason for passive reset
Date: Wed, 17 Apr 2024 16:51:40 +0800
Message-Id: <20240417085143.69578-5-kerneljasonxing@gmail.com>
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

Reuse the dropreason logic to show the exact reason of tcp reset,
so we don't need to implement those duplicated reset reasons.
This patch replaces all the prior NOT_SPECIFIED reasons.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_ipv4.c | 8 ++++----
 net/ipv6/tcp_ipv6.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 418d11902fa7..d78412cf8566 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1936,7 +1936,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v4_send_reset(rsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v4_send_reset(rsk, skb, (u32)reason);
 discard:
 	kfree_skb_reason(skb, reason);
 	/* Be careful here. If this function gets more complicated and
@@ -2278,7 +2278,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v4_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				tcp_v4_send_reset(nsk, skb, (u32)drop_reason);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -2357,7 +2357,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v4_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(NULL, skb, (u32)drop_reason);
 	}
 
 discard_it:
@@ -2409,7 +2409,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		tcp_v4_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v4_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(sk, skb, (u32)drop_reason);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 017f6293b5f4..c46095fb596c 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1680,7 +1680,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v6_send_reset(sk, skb, (u32)reason);
 discard:
 	if (opt_skb)
 		__kfree_skb(opt_skb);
@@ -1865,7 +1865,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v6_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				tcp_v6_send_reset(nsk, skb, (u32)drop_reason);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -1942,7 +1942,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v6_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(NULL, skb, (u32)drop_reason);
 	}
 
 discard_it:
@@ -1998,7 +1998,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		tcp_v6_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(sk, skb, (u32)drop_reason);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:
-- 
2.37.3


