Return-Path: <netdev+bounces-137559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3119F9A6EC5
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA811C22B59
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4F01CBEB0;
	Mon, 21 Oct 2024 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9LJfArB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7EE1CBEA9
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525977; cv=none; b=daa6TOHwOyFMWjNXQ6u64z41XqSA8OspZOMEYS1eV6ma8gLmgZRdSdA0lWCyKl8vvbqcwOhBH5ez23Q2R+76EeUEWc5i1Q5GWvjSfZQOTomtN6xw+gzXCUAuxoI+m+eXQc/NL0OZbc28FxipG6UyHfLvecNbdJ2y1MIuUCq0/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525977; c=relaxed/simple;
	bh=7hW8zlXRrgjz8zQMM2wdq9MkX0sB68Nl9iA3lKI73TY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y6d8zQS5f1p7DcmMVym+jFqmkPXJKKkY/RAF7Dm67sVgUgchuMv+z8uv/dSwzkROv0dIr5OmX9m7HmwC5Ff4TlR/JDnbvWqdD/kz3gZCt8/+eScYJRLfxSyWGjLAqUOLzLr0U75+CGFxhgKC/rLln3G6+vT0PeCiik+hbcuDIkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9LJfArB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e52582d0bso3563918b3a.3
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 08:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729525975; x=1730130775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C97fuJGFQAA5cSpkgiBt91tbbJ3Xn/YFzYUuyrGu94Q=;
        b=e9LJfArB9O4VbZXUgqUNOtSoryZa6ef8La4IrnadIbIPs+MxDOyRL+t1js+yd1e+xM
         yr02HzRjxiM5iVvQ1x+X8ghxzYeTv0f9tladQSH6oEFKw4ecEN/lxmVOi7MArPOSlrFq
         xaPVZb42Dpa8+o9hYglgSwPc2eIfNRVQ1MHPyLw4s9F2BMBuOtQxX1RhxP1wb3NTFYp+
         VHrXj7zMFNO5LDHE3cL5y6XFFa7nBtEkfMUhn3yufzJCQocoK727T5U8B2Avx6weEw3i
         xRET91X+8CLJ2ikfzSMwQsJ2w5/rLtiPS/wCvOfGYEQtBFVE4ohE+LUM+Mn55wjoVf4T
         8N5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729525975; x=1730130775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C97fuJGFQAA5cSpkgiBt91tbbJ3Xn/YFzYUuyrGu94Q=;
        b=iqZ8GRR9X8L9wQf4FJBUhaRqCIJK97ospyLQOaFLAUEii+5J30n3b8cYQ/mpenwind
         FTOlrz3K8s340uLCTLrn+LjbkOE+cc31Bi034EWlrHB6XYvn3oCBF+ji3WOVwvrWmCb0
         ADSxXhGFX0kJsd9w4/806QB4ZarBEsGZ6VyeMIjAjCLSEmWW3Hf71nxyx3fsYEeIs/n2
         7P5b9x6WtXEvf5Qo6gIKdEdbWOdI6ZsbvYdzvxs1lIWKu2dwIyn7zTDaE/gbHCXexrDa
         38qndQOHtjIVHulGthKw1dzaq8hUKSafFl7gcXV48b2m+SYS2kiv5nLgZ9wpLpaZIUb3
         40gw==
X-Gm-Message-State: AOJu0Yyl/R1mxXt+bYS8dQ9F6f2RZyUOdLXuj5yJI4r/TiSlghLeFWQy
	kMR7ch6X+atq27o3+snfW+pmHhNfZ8jTz4+pkZOS8bUE1IpiaOt22oEruhSk
X-Google-Smtp-Source: AGHT+IGlOAWfmt8cowSlfnQoqifwNtGCYXEzCqLR5aWOjdeu2jYFZThcynB9zY8jQ4L9UL629getzQ==
X-Received: by 2002:a05:6a00:2e99:b0:71e:6b8:2f4a with SMTP id d2e1a72fcca58-71ea31e49f7mr17759740b3a.12.1729525974626;
        Mon, 21 Oct 2024 08:52:54 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.33.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13ea0ddsm3154697b3a.143.2024.10.21.08.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 08:52:54 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ncardwell@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 1/2] tcp: add a common helper to debug the underlying issue
Date: Mon, 21 Oct 2024 23:52:44 +0800
Message-Id: <20241021155245.83122-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241021155245.83122-1-kerneljasonxing@gmail.com>
References: <20241021155245.83122-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Following the commit c8770db2d544 ("tcp: check skb is non-NULL
in tcp_rto_delta_us()"), we decided to add a helper so that it's
easier to get verbose warning on either cases.

Link: https://lore.kernel.org/all/5632e043-bdba-4d75-bc7e-bf58014492fd@redhat.com/
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Cc: Neal Cardwell <ncardwell@google.com>
---
v2
Link: https://lore.kernel.org/all/38811a75-ae98-48e7-96c0-bb1a39a0d722@kernel.org/
1. fix "break quoted strings at a space character" warning (David Ahern)
---
 include/net/tcp.h | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 739a9fb83d0c..8b8d94bb1746 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2430,6 +2430,19 @@ void tcp_plb_update_state(const struct sock *sk, struct tcp_plb_state *plb,
 void tcp_plb_check_rehash(struct sock *sk, struct tcp_plb_state *plb);
 void tcp_plb_update_state_upon_rto(struct sock *sk, struct tcp_plb_state *plb);
 
+static inline void tcp_warn_once(const struct sock *sk, bool cond, const char *str)
+{
+	WARN_ONCE(cond,
+		  "%sout:%u sacked:%u lost:%u retrans:%u tlp_high_seq:%u sk_state:%u ca_state:%u advmss:%u mss_cache:%u pmtu:%u\n",
+		  str,
+		  tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
+		  tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
+		  tcp_sk(sk)->tlp_high_seq, sk->sk_state,
+		  inet_csk(sk)->icsk_ca_state,
+		  tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
+		  inet_csk(sk)->icsk_pmtu_cookie);
+}
+
 /* At how many usecs into the future should the RTO fire? */
 static inline s64 tcp_rto_delta_us(const struct sock *sk)
 {
@@ -2441,17 +2454,7 @@ static inline s64 tcp_rto_delta_us(const struct sock *sk)
 
 		return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
 	} else {
-		WARN_ONCE(1,
-			"rtx queue empty: "
-			"out:%u sacked:%u lost:%u retrans:%u "
-			"tlp_high_seq:%u sk_state:%u ca_state:%u "
-			"advmss:%u mss_cache:%u pmtu:%u\n",
-			tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
-			tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
-			tcp_sk(sk)->tlp_high_seq, sk->sk_state,
-			inet_csk(sk)->icsk_ca_state,
-			tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
-			inet_csk(sk)->icsk_pmtu_cookie);
+		tcp_warn_once(sk, 1, "rtx queue empty: ");
 		return jiffies_to_usecs(rto);
 	}
 
-- 
2.37.3


