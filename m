Return-Path: <netdev+bounces-89217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F306E8A9B5A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C67286561
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C6E161933;
	Thu, 18 Apr 2024 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgxqYS0s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7525D161331;
	Thu, 18 Apr 2024 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447198; cv=none; b=eMR+roXoujTVqDqvXsM5s/PhN74vw6bhOEzxxplF99GkRrxjIKL0xPtbOJd/E5D6bf/iQ9p3AxZT7LB7SGl6sotuQRZtfJ7NrsCuQatR+RJ4PphLI9TCKDgLcSiIRVVB2KOFLhbnxqbVSn0fVyokv4RWNjPnpjA0W1u9ldFuLik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447198; c=relaxed/simple;
	bh=Sg52tjwZu02VauEN2wifSM/4N8k/GSX65W7rSwbBSOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ARSXUiv920u8IeL9B1Wxj0pCHVfzzqIjSEifNvIAMxKSDpQhwFRsRQ+u2xSfRtxvq+oOdM03OgF2J/qLTKNzyIpeCY4tB2Dth9lUD6KujiZ9d3ox8HWWlVC0i/LVSjM8uCmgf0qzkwgyWoKTVMgaSs57be6yxgK+sEBhSB0bvp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgxqYS0s; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a2da57ab3aso663752a91.3;
        Thu, 18 Apr 2024 06:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713447197; x=1714051997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZaHHJogYh/uBF5yMrMV9lgM3yab7Wqg84yx5am8bms=;
        b=ZgxqYS0smRy/16uPx4xR9jfjgRNO7zW69aoACSjkYmRgHQKcnM1JpOWquU9NznZ7mF
         qbB5Cyqv6vQTQblX9t0RDvQ9X7Ntx8plNO9J+XC+hGOSstbsMfuI7vflxwfx2mvROdHa
         GyrQq84bw3J6YK+Isrbo5vDNjX2StOxrTtW4KIHQFj7c87V1NkiJyE/mQImymvi/l7M8
         n31GN9o9zmmx5fEJT5LPOYlOBAdLyd0xV3jyb2N4XvWAkylUVUy2vyttOgeKiWZcMZje
         ALcEKBvsQd+qDsFAVLrdtu3wC/IvwDnQzdKWksu3kNz/pu6UDNAZxM55QDmQVJc9TJZ3
         M6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447197; x=1714051997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZaHHJogYh/uBF5yMrMV9lgM3yab7Wqg84yx5am8bms=;
        b=PLnNmCWdSoYjzW8BRqsDo2WleJ158A88kC5Pf8DSQl2n+Q4UDrSDRI3BHHNCqfNn9T
         2dQ7SSDvlHGzEiwKv8ItcxHLoWjky1w+NnrVL2kaOIvoHH1EVCZnXjGKHemNb71jzB+R
         ay2bu+DDFlikPl1whg05Z+jx81g96feVtZXzDstm+dSEpFlYLjo4KJ3Dfzb6DVCv1SO/
         iQCZ1d6Iiapcm14/nO9BGHYqc+e7kqE7yVGsRCD4z0B6oa3XjxZIs2cPa/5QC3xRrFmK
         V8p0Es7LmYbywVPH4QRdS0MM/zfGmvqM6GsxosnsqoS/omKzLDCPSwJqg8ACnIXwOqQr
         VvdA==
X-Forwarded-Encrypted: i=1; AJvYcCWdP5f0vA9lDwsYHaMia2a/u62nu147hLKi1K/X5VicSZUpiuyO8hyGaw9JMQNSEEHEjxsmlRB0bsLW9XUu/RXM+jf/MywctkAbBWHIyrhpPbY5AIKKfSZZgCE9fzbARMQfb12l12M31LrV
X-Gm-Message-State: AOJu0YxXE1ODMMH/KxbyGjeh4HwCD7I9Vc39L1kuFvzWWfOplB9IC+wH
	lZQMYipPc4roEj9KTGF0B0qBXHS4ej14xXNg5qvX/C6d4ZrIwrCW
X-Google-Smtp-Source: AGHT+IEuAZnH0smVDKADqkJRuOhN3hMKR9yVhk1bcN0plKrjvE77z3Xj1xbtCdt6bOC3JKiVm+QhWg==
X-Received: by 2002:a17:90b:1889:b0:2a2:4192:dfc1 with SMTP id mn9-20020a17090b188900b002a24192dfc1mr2685882pjb.14.1713447196760;
        Thu, 18 Apr 2024 06:33:16 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id bt19-20020a17090af01300b002a2b06cbe46sm1448819pjb.22.2024.04.18.06.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:33:16 -0700 (PDT)
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
Date: Thu, 18 Apr 2024 21:32:45 +0800
Message-Id: <20240418133248.56378-5-kerneljasonxing@gmail.com>
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


