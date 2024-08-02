Return-Path: <netdev+bounces-115292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BECF7945BE5
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 12:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7F91F22B8A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD72E1DC46C;
	Fri,  2 Aug 2024 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsG95LsJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFB63FE4A
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594094; cv=none; b=TmBIezrQL2yJqF0n1p25LIpCXGYFCv8lsy+87hxI61csc1yNXnYB3HKs2C//uCgTM55wl57Wjn9+LpUTNF6fOeMc98TzgPJNCqSE0/X0iA0U6yHsBWj7VaJMsPkf5iqwFI9E1VRylRq/amUfP/7AKCtHDX4aJ6Y99cZK5Q9kBGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594094; c=relaxed/simple;
	bh=vUy6ppz3XH81EZK2zrGj89sqmf15Y97Pw0B1juU9Dvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OZ1mHHkWhPBk7kol+hFL91zDQJwrYHOZHmBEqLX9Ktqt5enZrw29azTVJAFOM+DT6wXsKBXUWHJr9yKT/EDl/6uMOTe6MryFd798jnbhOd+hdLyDuwhW2kFsYUOlo2QZS93VC689nhCS1mbEp2pcaCRrEADrOiPPWNiWysqWFko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsG95LsJ; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2610623f445so5251283fac.1
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 03:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722594091; x=1723198891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yh/nFJhVgDc7iu6LZb/1AqpfqlML4cdyZgKqK3RH2OI=;
        b=gsG95LsJcR8OvWOgwF71RBIR88jZ07A2lzkuY3ZsK7cxWt5QBuHFcaKXgNb6432YOZ
         I7/PmU6rqgrjL3JGmsq9oyYd+0cXwMS4tn1SsARCNbGzH61EfXYHSBFKWwZOoBITQPFE
         uCeJM8TQimttafrFTg7UTiIyADz/jBUHJ8f7xJOa7I1kf0ZWcPTogeWq1JjLtVPxdlBQ
         lAmUqBTeiXUcv0p75mA4A3oljjKe5vgNJHUutisxeFZRnEVj+EaWzA/C/4qtkXY7wB4K
         rFI7c3FHVK3cHChvlDt9wvTlwIjc2WCLmzM89yNHRERs93d2ifXD60aBmJQDVbNiy1df
         FYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722594091; x=1723198891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yh/nFJhVgDc7iu6LZb/1AqpfqlML4cdyZgKqK3RH2OI=;
        b=N39M6FaxRYYDXliedUq+oKRKYz8uo5IQGqCNOeZmgS6yvJnWml4APEZD0DbhViWTmk
         4aWP8W1DAecVSTpszihfuLtlt0RojqzyyqlKtU0bNu0hbpU0SWI74+xppsg+TnUmVGnP
         dM1I64kQiTG+8weIXf0O8MyZHaWDTaBFLw0GajwQOaZ75q6fIoUEhLygd0Zp9gYJ3bM8
         O5JqQeyqfQGg42Yg+nlOZ1/8YOG/qVG4JJn1g94SjeyEdru0xkm+DKYY/2fAFUCh/Bck
         5ohXNdM+LKL0aaMXyhC9kQWW4pcY7aKOI+N92R7nXmVUUVGMVDhMlqy+guFBiFzCgcrh
         QRLA==
X-Gm-Message-State: AOJu0YxvazqsFR2amuhwBohQR8ffIkj9aJtZBCkAFsP7gKDAS36ZHJA0
	mfyHIu/V4yANhOjsKxdLtG51/V+IMwBSXiI+B2PPo15Aufie0HwU
X-Google-Smtp-Source: AGHT+IGNTVYYsVdhj11YxxEWpprJ8U4bnxjDp8amL2LTvKdoTjG/8DwPOci+G41rYmjXgZvZa7eWmw==
X-Received: by 2002:a05:6870:968c:b0:261:2c4:f7a0 with SMTP id 586e51a60fabf-26891f41374mr3098353fac.51.1722594091114;
        Fri, 02 Aug 2024 03:21:31 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b763469e79sm1109050a12.26.2024.08.02.03.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:21:30 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 4/7] tcp: rstreason: introduce SK_RST_REASON_TCP_STATE for active reset
Date: Fri,  2 Aug 2024 18:21:09 +0800
Message-Id: <20240802102112.9199-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240802102112.9199-1-kerneljasonxing@gmail.com>
References: <20240802102112.9199-1-kerneljasonxing@gmail.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
v3
Link: https://lore.kernel.org/all/20240731120955.23542-5-kerneljasonxing@gmail.com/
1. remove one case from tcp_disconnect, which will be separately
categorized as another reason in the later patch (Eric)

V2
Link: https://lore.kernel.org/all/20240730200633.93761-1-kuniyu@amazon.com/
1. use RFC 9293 instead of RFC 793 which is too old (Kuniyuki)
---
 include/net/rstreason.h |  6 ++++++
 net/ipv4/tcp.c          | 10 ++++++----
 net/ipv4/tcp_timer.c    |  2 +-
 3 files changed, 13 insertions(+), 5 deletions(-)

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
index fd928c447ce8..24777e48bcc8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3025,9 +3025,11 @@ int tcp_disconnect(struct sock *sk, int flags)
 		inet_csk_listen_stop(sk);
 	} else if (unlikely(tp->repair)) {
 		WRITE_ONCE(sk->sk_err, ECONNABORTED);
-	} else if (tcp_need_reset(old_state) ||
-		   (tp->snd_nxt != tp->write_seq &&
-		    (1 << old_state) & (TCPF_CLOSING | TCPF_LAST_ACK))) {
+	} else if (tcp_need_reset(old_state)) {
+		tcp_send_active_reset(sk, gfp_any(), SK_RST_REASON_TCP_STATE);
+		WRITE_ONCE(sk->sk_err, ECONNRESET);
+	} else if (tp->snd_nxt != tp->write_seq &&
+		   (1 << old_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) {
 		/* The last check adjusts for discrepancy of Linux wrt. RFC
 		 * states
 		 */
@@ -4649,7 +4651,7 @@ int tcp_abort(struct sock *sk, int err)
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


