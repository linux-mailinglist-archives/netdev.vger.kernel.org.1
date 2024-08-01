Return-Path: <netdev+bounces-115027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C595944E90
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDB51C2127A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8751A99D4;
	Thu,  1 Aug 2024 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKkOi7oD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3D21A99CA
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524104; cv=none; b=B5ZEaT9J0E5m4GEGXTcDclnqHLsgzhhMnj5vNw11e49Rkpuob98a60pANYRSAGgCET7jaAyDrz4XhbIV+d0pqGCcXFsRceMLylOsCnSqV/pyonl9ricJtx24HnY6IIirxfzdj0IzFCN3UOjWJnR8t1X679wAkajJy+gKzf5oKJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524104; c=relaxed/simple;
	bh=40qsXruOSw79gTHVXcGlmBLPZGor8ZQ+cJwFxP9+6Z4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yb0kUVYfBb+uad110BMiHz9+J1oE99Ob3EO7yg57bUdmGo2mVGpKHJ406KYye4ymxST9gIXb89KMpw9KtNCxUeZuXtR95Y0KK1SzDX64m4c+WIAu+qWS3AWriJ92w3i3A9AU/hps6SZLEzNxvWTC/fYOZXBL+lZWVn6iBrIzkR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKkOi7oD; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d1a74a43bso5212198b3a.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 07:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722524102; x=1723128902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbIhvip/hguhyYk7xdPEmCjiRFpey3/NxNJuPwFxjx8=;
        b=TKkOi7oDGcanhnOYSB18vp2FXZVKMbtDvrg/WmhSOApdxtiIagcgR+WmZVS6Ig909z
         G1zjEe1ENwTRz7zDxC/X8AN8ukQGDM4ckF69oa9smnH4HlybrBxi7XTCr2/WcTp050Rl
         M7jAhUHF0AFCOYQgqiizk78aZAV01WhBIuCs8niyl1yI8l5xzQDrMrbyqvUh9zdj6JxI
         r0Efhy4TbPOeE6THobq1bxyrq0f+Uwo00NT+6jGK3/WzBysFJz+jMb2YQ2kwSGy16WnT
         aPra/Qd2cFV7meNWzV6H/ci9msnOaIwd9SAdzguw8+BiBh89PWdeSiFmWP6w6Fd28s3X
         b6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722524102; x=1723128902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbIhvip/hguhyYk7xdPEmCjiRFpey3/NxNJuPwFxjx8=;
        b=sRZtNCuSCu7wBmCrQ20y89v4/HxDepHGUB0779sNDRwQ3cejY+KbfQq5zBRO5WR/T+
         MNAOSqrE+QpcuwW5KY91oPobW75nfCaN5dkqDS+w3j5Ocf1E0nLBlFJ4J0BzQesTISV0
         nq4rP7QV7rXgW/Mt3uP3qkNj4y7Hq0YaLbGqzpfaC5uBVwGMqkuB8d9uhij3Vx9wfaOh
         sJ9nImQcqNB4QGXaH1KtjY6mXS74MvhXbcx4C3ESLITZkI4xQ4keFsXMFAzG4Qjy/Pae
         65Kld8LCgeqE8aF0ZzhS/Fnh4AQ8Vyc8Dckwi2Xss8VA030HYdDPleb0Ki7iTWubIa91
         cwQg==
X-Gm-Message-State: AOJu0YyoIyTv8Tv86BXgervm+vOjiOJcWyrccFRGQWhumky1c1zvSXZg
	mXpEbpzv15tKjPzIbK+PYxx7H5a0Erie65TUsFc959snisgx0ITpFTmbQ7Fn
X-Google-Smtp-Source: AGHT+IFq/L1buLhI2/mon5LWC3XFVkMYBfgKtMPcxiQwBlnlvLQPNcFp3DRMXYWGm7T0CwzUnP99oQ==
X-Received: by 2002:a05:6a21:78a7:b0:1c0:f5fa:d1e9 with SMTP id adf61e73a8af0-1c69955f4c8mr759738637.15.1722524102020;
        Thu, 01 Aug 2024 07:55:02 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a35c7sm11611739b3a.200.2024.08.01.07.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:55:01 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 4/7] tcp: rstreason: introduce SK_RST_REASON_TCP_STATE for active reset
Date: Thu,  1 Aug 2024 22:54:41 +0800
Message-Id: <20240801145444.22988-5-kerneljasonxing@gmail.com>
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

Introducing a new type TCP_STATE to handle some reset conditions
appearing in RFC 793 due to its socket state. Actually, we can look
into RFC 9293 which has no discrepancy about this part.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
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


