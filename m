Return-Path: <netdev+bounces-100307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 510638D8791
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 19:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5EC28A173
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9446B13213E;
	Mon,  3 Jun 2024 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQK2cqYL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328651304B1
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434159; cv=none; b=jpXLjMc06v8oO7gArvINpewYirx/EqOuo1ZFFPPKHbwJWnbH5ZlPaRqFHJ2xNUNMFFGmcvCvqo3ajy3r8bjfY/RhZdMjI6OjgVeyKrlhknBhsUneedIEQQGFuBhpsYiZccm4uOMRtJJUIRjF6ciVc2xNV3iAP3i5qs0uxVHakgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434159; c=relaxed/simple;
	bh=LxPSHGj+YqVPkDKGo+uORRwgqnKKiBsfU35zezrsazo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SlpZx9tLBBrLl8clyP4Eo9l+Nga66wQZvRyAKTwXAQ6UKPzoIQh4S/1F34hWjWu0wDiSj5li3aBlSAJUUgpsulog5l/7DbOQW1aoszEO2KhFr4VUwZXy6KlgAQ+AguP8zaecoYSSDAnftpQDzYV4swltu2slGdtJJbfZfoaPp44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQK2cqYL; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-702508bf0a9so2242398b3a.0
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 10:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717434157; x=1718038957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyfPe9ztbEYNGGiUHWp+Lku7sfb+L/LbaE9KE47G5ug=;
        b=VQK2cqYLA/tMHz/LcJ/Tk3F9gsxW8TYvTuu/nM0+WP5ErZK+sGQUH2HGw3YwptMXuL
         YtgEquHSIuHEObJwZUwu+xmptewto8lxU5eM/oDZWD1xY1cdqebw5yLl/h0+S8xcagyB
         DBQtOyIvasZ5kZc3D7FGPpszFz1FQAiTZ9k4gdMh7JzsSedBpCrJxYfhaku29FD2z8sX
         B3smS/2M9rMwR4NPkhp/Fz6kzkHl6tmGEou8n8CtvfnxRTVuewGf3IQR85QVFdOgnYkI
         kFl/iPwyySuFqtgHUaSyhvDUpw8U6MnMVUTWz77IQjlyS1SbRsQxOTJp7VmcmOlAeaOI
         s3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717434157; x=1718038957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyfPe9ztbEYNGGiUHWp+Lku7sfb+L/LbaE9KE47G5ug=;
        b=g6Y1hoNfJwStQQkbx8zqtJfQl8a0eT4X2pH0EHtkLB5DceKx4Ixjq25+B1dFUUAbrL
         mMUQoIfBhUV00I6VOsNMnLNDemAp3b2qkJCqa5YJ98ByL6GQuxRa8MYEDTSdukw1Pmye
         B/MICyIVuA+6GB+P7YULyl+9dmY9VO+xc8ebLbEG/ncjpPk0NKDQwSl513aIOZqJC8mx
         fbYavIFI+NTb6X1uEo9LBqRdbgVkFQTVjbwEYnclRp7cIuvgViEtZx7mG1CHFLPjyqub
         4/0YaCFAszDBO8crBnmtJyZupZ4spbY85lSBEd5uGS1f8w0axY3B77dwNxSbSj7wqOfA
         g1Cg==
X-Gm-Message-State: AOJu0Yws/eYzP1vvi7jm5+mVY49lje61yDHfCw7kUGV81+a43AndX7JS
	OlX5XzVwMkmrYqK0Dc5HOCqNKgg1s3hOXKr1vP2MLFhN68KDb4L5
X-Google-Smtp-Source: AGHT+IGpi5Tpv3DJ3j3s3qdDjRqX28Ju2V7VqI8lPxnOSQaD1fyMdZjvXAzIKkzNPgfyWGcBGoToGw==
X-Received: by 2002:a17:90a:4b06:b0:2be:af:3637 with SMTP id 98e67ed59e1d1-2c1dc5c8ffamr8276778a91.37.1717434157359;
        Mon, 03 Jun 2024 10:02:37 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c27e577fsm6460431a91.32.2024.06.03.10.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 10:02:36 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v5 1/2] tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB
Date: Tue,  4 Jun 2024 01:02:16 +0800
Message-Id: <20240603170217.6243-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240603170217.6243-1-kerneljasonxing@gmail.com>
References: <20240603170217.6243-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

According to RFC 1213, we should also take CLOSE-WAIT sockets into
consideration:

  "tcpCurrEstab OBJECT-TYPE
   ...
   The number of TCP connections for which the current state
   is either ESTABLISHED or CLOSE- WAIT."

After this, CurrEstab counter will display the total number of
ESTABLISHED and CLOSE-WAIT sockets.

The logic of counting
When we increment the counter?
a) if we change the state to ESTABLISHED.
b) if we change the state from SYN-RECEIVED to CLOSE-WAIT.

When we decrement the counter?
a) if the socket leaves ESTABLISHED and will never go into CLOSE-WAIT,
say, on the client side, changing from ESTABLISHED to FIN-WAIT-1.
b) if the socket leaves CLOSE-WAIT, say, on the server side, changing
from CLOSE-WAIT to LAST-ACK.

Please note: there are two chances that old state of socket can be changed
to CLOSE-WAIT in tcp_fin(). One is SYN-RECV, the other is ESTABLISHED.
So we have to take care of the former case.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
previous discussion
Link: https://lore.kernel.org/all/20240529033104.33882-1-kerneljasonxing@gmail.com/
1. Chose to fix CurrEstab instead of introduing a new counter (Eric, Neal)
---
 net/ipv4/tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5fa68e7f6ddb..902266146d0e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2646,6 +2646,10 @@ void tcp_set_state(struct sock *sk, int state)
 		if (oldstate != TCP_ESTABLISHED)
 			TCP_INC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
 		break;
+	case TCP_CLOSE_WAIT:
+		if (oldstate == TCP_SYN_RECV)
+			TCP_INC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
+		break;
 
 	case TCP_CLOSE:
 		if (oldstate == TCP_CLOSE_WAIT || oldstate == TCP_ESTABLISHED)
@@ -2657,7 +2661,7 @@ void tcp_set_state(struct sock *sk, int state)
 			inet_put_port(sk);
 		fallthrough;
 	default:
-		if (oldstate == TCP_ESTABLISHED)
+		if (oldstate == TCP_ESTABLISHED || oldstate == TCP_CLOSE_WAIT)
 			TCP_DEC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
 	}
 
-- 
2.37.3


