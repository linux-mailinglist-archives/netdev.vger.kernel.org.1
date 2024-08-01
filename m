Return-Path: <netdev+bounces-115024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54601944E8D
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5B91F22C53
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F991A99CA;
	Thu,  1 Aug 2024 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGpjRZYj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1027C1A721D
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524095; cv=none; b=m2V4Mb5DwmF+KjxGDfP4wdaGas7MzonAnRhHyVdJsvP5WDJ4hIp6G1uho1l+W+XnF83BKiHD9ff8CbBD4nh/uPDe7s0b6A7dmvbhUttPvtjTEyPzUX79yYOHOrxVqWlAaI9fwFUZYtg16yt63OioU98gvxpD8QNzC8JXDE+tJck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524095; c=relaxed/simple;
	bh=xmrNaBt5a2CwB7pE8jwMkJ9DwMXjVuJmHd6iM+Z0v4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cb0hWrbzBJaYkY4Txly/sUVnzcl1pDd2/Te4L/TdxZ6gF/MhectNIh6vzwLM0LjykY/4lhJXoDMIpLLLMD0jLCAHoAPDl1/2a7DBkMZwFVw+NKDVq9/74L7ZPA4RBd6BPG6BOnxMjVsV/g3erHS23m1lw01oxJzv/mINzLlr9SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGpjRZYj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d1cbbeeaeso5178046b3a.0
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 07:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722524093; x=1723128893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65OKnjJuPQeRm+91VoYodiWcGDqklxrBSmzt5OD+SFE=;
        b=IGpjRZYjrWSgN10wW+C38sLVwbJ/Yp3hOL4mAIy+VIsQ+SmBDHbto7rFYsaVsi5ho8
         BecyyBbJwdpm6E/i8Buk8vex7flfbwc1ip+kV6DcITgMBTpo1huAbe8pADR2P12h/BA2
         WkCjBzoE76Zn43tdepWcjnSc40Z7xz7dQmgYpsnzBNr/jRvZDKf1rrZW6KOVcD/mf/oO
         utWHSfxqtE/HuebXlIMeJHA48ty6XfLsIpj6to6rqGzCENzAGJ+IfXH77RV+XHCsujgP
         K7XfmaJz7u4f7n+on025DG8vkK/bjikIOSxVI7cJVqUez49afFsWjST4kXm+l2i+1y9n
         tIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722524093; x=1723128893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65OKnjJuPQeRm+91VoYodiWcGDqklxrBSmzt5OD+SFE=;
        b=mDFBIgOh8RYB6a7lE1dLojx/5ABWj4T/V7vIcSzpi12LGaUUctZ8WhAf2/Uac4pl+B
         MkP+I0sm2jIIvz8jU1eDD+2Mn3M1biRPWYUkN+L0c7gY8zWTCG+weOEx3WNVFgKqy+e4
         y3XTZd2pkuOKt5uEdj2HIjkHQb+rqbqomctcwSj6d3bVE8n4mTxTS8u8SitqsgwRLJWZ
         /8xti2bcxoAHOqGhzGlU5R4i3XyUVHpSwp8f/Gb2PeyIy1m1ScCUjZLVIWiEcQNX2CDZ
         stqWOJUh5AaZgGYCv8D61v9uuD8onSbnlcR2KmkMUpfBsuSLuD2QNXuzBUKjDQbrtx7D
         wLtg==
X-Gm-Message-State: AOJu0YxZ3MiSf7nWI0lve83e6tyWIdVwzqUrfvvHjTSRUp9Rfr3F/Fox
	uxvub4h/DDBT/ZvGitBVp6Hpqao0o6lZrCIL7QUX2eUUssS/CHZi
X-Google-Smtp-Source: AGHT+IGssBqver1tybT/h8eyfbIFdrbQ17zTZkT3e2d3ufWoFW0Dsx87sXC8VSfru1rHaN7E6m85MQ==
X-Received: by 2002:a05:6a20:9191:b0:1c4:8293:76d0 with SMTP id adf61e73a8af0-1c69953c7camr828950637.4.1722524093146;
        Thu, 01 Aug 2024 07:54:53 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a35c7sm11611739b3a.200.2024.08.01.07.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:54:52 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 1/7] tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_CLOSE for active reset
Date: Thu,  1 Aug 2024 22:54:38 +0800
Message-Id: <20240801145444.22988-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240801145444.22988-1-kerneljasonxing@gmail.com>
References: <20240801145444.22988-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Introducing a new type TCP_ABORT_ON_CLOSE for tcp reset reason to handle
the case where more data is unread in closing phase.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/rstreason.h | 6 ++++++
 net/ipv4/tcp.c          | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index 2575c85d7f7a..fa6bfd0d7d69 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -17,6 +17,7 @@
 	FN(TCP_ABORT_ON_DATA)		\
 	FN(TCP_TIMEWAIT_SOCKET)		\
 	FN(INVALID_SYN)			\
+	FN(TCP_ABORT_ON_CLOSE)		\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -84,6 +85,11 @@ enum sk_rst_reason {
 	 * an error, send a reset"
 	 */
 	SK_RST_REASON_INVALID_SYN,
+	/**
+	 * @SK_RST_REASON_TCP_ABORT_ON_CLOSE: abort on close
+	 * corresponding to LINUX_MIB_TCPABORTONCLOSE
+	 */
+	SK_RST_REASON_TCP_ABORT_ON_CLOSE,
 
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e03a342c9162..2e010add0317 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2833,7 +2833,7 @@ void __tcp_close(struct sock *sk, long timeout)
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONCLOSE);
 		tcp_set_state(sk, TCP_CLOSE);
 		tcp_send_active_reset(sk, sk->sk_allocation,
-				      SK_RST_REASON_NOT_SPECIFIED);
+				      SK_RST_REASON_TCP_ABORT_ON_CLOSE);
 	} else if (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime) {
 		/* Check zero linger _after_ checking for unread data. */
 		sk->sk_prot->disconnect(sk, 0);
-- 
2.37.3


