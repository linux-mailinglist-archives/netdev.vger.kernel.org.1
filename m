Return-Path: <netdev+bounces-72807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CEB859B02
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 022BDB21321
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 03:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254B05220;
	Mon, 19 Feb 2024 03:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwMRtUjh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E4524A
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 03:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313379; cv=none; b=Zqz4p+Wogwsitn11oUqvjsM0CUd0N04M4KBQfJEloiLtD2S6M//Cwk525+9wOp7hE168Tac7Edy6SwaVGBXtpCCemqB8ip/ltdKP/bzSf11cR39soj5db6Jqe3ADF2vMhq3zVduL8HGipuWILA7ftp0n9GN2lGO/lzjewstt8+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313379; c=relaxed/simple;
	bh=OU2uwqIjOfTh+AmFOfGudPP/RW1PKWT8VrA1aJ85WeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PIYmXCfmKwNxyYIxgfmLV3jlc/r0W4Jd/EEqJi+u4QMtKQtrusO7VWfIcrHfVRL0q+K0qhPHhg03RJo3JbtOmuRdyUNhgUaqeJZY31f7AN2C+KQQ+sSli9jIQDfirZqaYmhrvWmQGHHKyWkeH4aTVDakCrN2d8j2pZcIGqVNePs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwMRtUjh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2995fa850ddso711018a91.0
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 19:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708313377; x=1708918177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3U8r7pHM6I/hcOWbq8mog8dHQKxp/aJ6JsR5ie6qaU0=;
        b=SwMRtUjhTSYb9aYp8W8o8ysvY14VVx66QFQDNI+dHhLovbGS+dzps3jLDcNgn7jJwW
         lFrldEXHL0HnoRWr6AGoiHrgBOUleTfeuYWe4C1zrO8bfM03J0B4+Oijq5jWJn9xOv3Q
         DKZ+aQFbYnPHpLUj1khL6rQVtGd4/8RCcIq8aqjjEeCcBYPl7ggz4uyLZ6hmPF9gBhYL
         fUOuz6YPmPmkUpYaTurKbZZPGJ5+AXSgIqskHYVMyLXIilR4J3h+0pFuY0VPEaW9LAQ8
         7c9qjEFT+hbTmR3iTMzzBPobQPSHrzqO5lZ5ey+RHLhZSvCcDZ9gXKSFIZzGpDdmxXGo
         I5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708313377; x=1708918177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3U8r7pHM6I/hcOWbq8mog8dHQKxp/aJ6JsR5ie6qaU0=;
        b=aynj+pPil9PJ8TuZ549ZrAf0PQI6dgca9RG9P23d6YFLhjRSgsL1zphTieVe/ZsFYb
         cqsvHgXrXZkywV9z1rz/sq0PxQZE4RpWUSNMQ7Vfk/dgvcEQkuErBTnl7Nu1zMzTWGPf
         qvpWxwXwIbvpHsph7GD6qgSEHPSNVRST8y9SjF2qD9Lflxiq9ArPK1vYKW3nZN/G0DD6
         2zcaY38nADiHHkkHV2EOu3NxlWQEx9PhoJe/+3YV2SfeY9qex+8yjFjQYuWxpQ9W0Y35
         v1JygJLs9w3mi245vZyE7ivIGEm20bMP12mVPEIBYnaln4eDdqGtlK6yZ0zt2XyzpvyR
         aY5w==
X-Gm-Message-State: AOJu0Yxgxzl2MggUVu6Y89WyRzdvwZRoNxJfZuU8C1KCJiUButSny2z0
	ahRsGC5V63URYw1I3JYrMVoYC3f+LqGX0tS1h2uMSnuRN54g/5lt
X-Google-Smtp-Source: AGHT+IFfcDj9wBsDRHfZcaVnJwwjCYeCvis5QbMt008g2yJCaJkCKAvDDnBIPHeuld2c4FAQIwJZNg==
X-Received: by 2002:a17:90b:4388:b0:299:88b6:7d93 with SMTP id in8-20020a17090b438800b0029988b67d93mr3030406pjb.17.1708313371447;
        Sun, 18 Feb 2024 19:29:31 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm3968921pjb.25.2024.02.18.19.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 19:29:31 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v6 07/11] tcp: add more specific possible drop reasons in tcp_rcv_synsent_state_process()
Date: Mon, 19 Feb 2024 11:28:34 +0800
Message-Id: <20240219032838.91723-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240219032838.91723-1-kerneljasonxing@gmail.com>
References: <20240219032838.91723-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This patch does two things:
1) add two more new reasons
2) only change the return value(1) to various drop reason values
for the future use

For now, we still cannot trace those two reasons. We'll implement the full
function in the subsequent patch in this serie.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_input.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 74c03f0a6c0c..83308cca1610 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6361,6 +6361,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 				inet_csk_reset_xmit_timer(sk,
 						ICSK_TIME_RETRANS,
 						TCP_TIMEOUT_MIN, TCP_RTO_MAX);
+			SKB_DR_SET(reason, TCP_INVALID_ACK_SEQUENCE);
 			goto reset_and_undo;
 		}
 
@@ -6369,6 +6370,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 			     tcp_time_stamp_ts(tp))) {
 			NET_INC_STATS(sock_net(sk),
 					LINUX_MIB_PAWSACTIVEREJECTED);
+			SKB_DR_SET(reason, TCP_RFC7323_PAWS);
 			goto reset_and_undo;
 		}
 
@@ -6572,7 +6574,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 reset_and_undo:
 	tcp_clear_options(&tp->rx_opt);
 	tp->rx_opt.mss_clamp = saved_clamp;
-	return 1;
+	/* we can reuse/return @reason to its caller to handle the exception */
+	return reason;
 }
 
 static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
-- 
2.37.3


