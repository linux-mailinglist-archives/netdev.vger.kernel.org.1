Return-Path: <netdev+bounces-99692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E69B8D5E0A
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 11:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFBEF285B00
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 09:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610E97A15B;
	Fri, 31 May 2024 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVVqEzzJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F159574267
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147086; cv=none; b=ZM7LtJRMedc7pFtLsYHH8XsqIYwxT7/R7xehXM2XxpSyao0GXEeKBQbc7jQzvc3fSPlyMWQwYPuIQ39bUhWGLynSoFpDGB22XNGqQZbtH07iBXg+opUd6yoN7B8+ffIqk884xNBeZd6zTbasIVlJI7aG+1jdnB9anj/GM/Cm5Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147086; c=relaxed/simple;
	bh=LxPSHGj+YqVPkDKGo+uORRwgqnKKiBsfU35zezrsazo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZzfZtqvjt3jqb7op9IuNJiLPusyyuAJM31DqEsWNb0kYg/PTBFAQWFgmxKaLmOotuHIG53YNp0oQggbriHgJGwX/mKrsQP206XH0/eEF1JhW919WOHcThxA/oTEV6peWQ/3LS8YuyMwbosXAOcV6jvH6KBwYdPjCaIgm5YjlLck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVVqEzzJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f480624d04so15789245ad.2
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 02:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717147084; x=1717751884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyfPe9ztbEYNGGiUHWp+Lku7sfb+L/LbaE9KE47G5ug=;
        b=YVVqEzzJQb2gMwSuVXPXB8RJZf7zdAqL5wkBCcmYlZmlp8PgPd5rURC6KB5QW3NVy2
         sa3TPeGYiblseDxqJXqQebuS40t+Dxo3Ewac8QItflN0/2+xCh1Y5sJAEWKlog9n4V8K
         W0A5pr9yEGP9y7sNcGlf+bKgZk3z1dxy2U49TOabgIGj5bQGLNepgTixuElIRWc6TuTL
         M9C2iqHaaA38O5dp4NaAZCCOypmd6gQBiDCiFpTE+wihR7s25E/bC4+s7PjRHWfXFcFk
         tnxIiEsw85y58w9NCB+CXI+Jzso2wKMlf8x3xU713sa0xMOVjpngLlYqCfPTZ5R4A6EA
         +yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717147084; x=1717751884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyfPe9ztbEYNGGiUHWp+Lku7sfb+L/LbaE9KE47G5ug=;
        b=kvgL84UnKFrVNV7ibcOHXB6o+bEhiovYoWy8JSNDBvEOxkDTBlSBzLHwAIh9RHHMmo
         hUDA0r6pfnVLIhKvfd1SZwCv4J/nSuOk11bjIN/xIQwCi0ANyYqhBUuEC+wzHVNVmVHS
         b5JHkzZC5+OIWyYZqnAG/GFzDlKqUJMCmYdIVuoAfiK7cnVmAyMPciE/QLfPY9o+wVYe
         BpWRryQ5EtB6ghmGG+2M4tzlhjkrs9ZH34zFBoN4C0ulH5UrZcNA6Tt9ts550H8IffnD
         oeKduDmFHgNSITasTQpKMoXxZwuozTFBXtXLSXgCYCR9+d8TYzeH5nmUCRtLecCP/z/s
         2tBw==
X-Gm-Message-State: AOJu0Yx2Y+Qz+tBBAVj4qt/45KT7U2wYiPmEEpFpkJuCTaHTgzLfXi4x
	wmYDAzxcqRCikB3a70fwf46nMo6LmsTrW5cCrKhPBKdGpAaVHsiR
X-Google-Smtp-Source: AGHT+IGDwC34IENpstbCQnwxx9+3Ns1eMnJa0OYx/FleLHZ0BHNJ3Qbo5Mn2nPMgwK/Pr2FQvqJQ2Q==
X-Received: by 2002:a17:903:22cf:b0:1f3:b0:f9ef with SMTP id d9443c01a7336-1f6370a0c4dmr15508015ad.43.1717147084160;
        Fri, 31 May 2024 02:18:04 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632356c84sm11950015ad.76.2024.05.31.02.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 02:18:03 -0700 (PDT)
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
Subject: [PATCH net v4 1/2] tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB
Date: Fri, 31 May 2024 17:17:52 +0800
Message-Id: <20240531091753.75930-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240531091753.75930-1-kerneljasonxing@gmail.com>
References: <20240531091753.75930-1-kerneljasonxing@gmail.com>
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


