Return-Path: <netdev+bounces-90367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3580C8ADE27
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 09:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58FF01C203F7
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 07:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F50D51016;
	Tue, 23 Apr 2024 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gba088EL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641A45BE1;
	Tue, 23 Apr 2024 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856925; cv=none; b=CxR8iw1tb5qLkNGXwyufhS+7KmAe7sKbCbLQs1BzeaDIqO/lxU9R/a0i6eFZEdoOu8f09ka89dSIBwP/HQ54bF+Ka3sQ3SWvvDjdsqYz0Zzs0VyoMUxKDf4ipauSA//FDSj8uO21aM+fmI9Y/YKXOCpqmm53AoEN980SkMmry18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856925; c=relaxed/simple;
	bh=v7U6oW3gDsie/i0ijCRs85/Eal6SYC2LrAnRuKhJdAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g0GFjKWouB3JTl2r3PVBbk4CCYGz7Y2GlajEPOLYu0IU/fLWKj8XB6e4uVqxfgDhij18m+/KVW9m9fG9uTfMFY/ojECiyt8fzhtQOY5h//swnD2mF+sXCEXzl4a5uI0Kgq9rjk01AiNf2U2cN0Ytd96V3sl+q+0bdcKwlE8y3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gba088EL; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ed627829e6so6010265b3a.1;
        Tue, 23 Apr 2024 00:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713856923; x=1714461723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6IM3xStLyH2OezX5Q6f1JfXVKMrEKiHR6KKT+cuT2w=;
        b=Gba088ELBUHKtqCB3Rhs641j8gSrZgfW78nSGe/1Q/kd/gWzHPZvEzTjkRytxDRaDg
         FPe4p3ZdHXNTlMGd9fYLP6Z73oH3NuB/JdoSawTJc73MqgrRY/kr6zelg/krc8BJi/bn
         dgz5P4XH60/YpgT6ugVWbjYwwRTdVL2opZ9YVcygEHtkh227O68HYrWLGolrBrdWEbe+
         huzd5HDUa2SQXAeTpm/bNKMgXnfloE1wS7a8bUhmmVyXgd+EZ2DnXrw9RVcZ8yzXqtz8
         +FYfbgv6feSAYdTmygdZpRVZbr4Ba3RiAphF4HCp8eD8c4d9B2JP8kxdJB7NUzZE/BJM
         YfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713856923; x=1714461723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6IM3xStLyH2OezX5Q6f1JfXVKMrEKiHR6KKT+cuT2w=;
        b=vy3S21/ARC9SUQeDIHRqMkX0MbU7HgNQ7bAaps5nLgMViLi3NJQ0hKQ9JyihVxXwyp
         61dcKd6xeMagkdM3zFfS1NmmvsvTX0e9XDeuc6a5iuC2/hgZW693qkE+Ixz0he1pvCKZ
         oTNpqUJ7YjqkIrTzhI1Brm0QfNauH6HpaaZG5fOKomoA+tcTESte2qQqTa3aTpupupGv
         vOem5IAb/+e68si35M5r6QKT1kZc1pDXDNyCN2dmOwCKdgf92kM6btC7u05nW+MXjTWK
         Jp+i3KmBNaEsYXHEDnTsB4f93Aqdj8J4UTJ7s+qEZ+2YrwXRD+tyDFcx+/3dGt5TlgDy
         sf9w==
X-Forwarded-Encrypted: i=1; AJvYcCUF3KY7VXEBZ1G3xn6F9uDWqY3OyNK3LHX6G5awZdfxH4ZT3z03ImxRAlJO4I7Eu1RpHT3DOMEFEMGjlJDGeIkgXKKX7qjm07zNykEt3kzrc6NpXAOGlG0kvU57ivTOYU7++lyYoRXNarjY
X-Gm-Message-State: AOJu0Yw1I+DZaZF/UHHxFg8lfjTWf70tn2cb0dgWpFvEBq0CSAkAldHv
	ssPINcHjYLPthoKcHmrLYZImEnkY1+/nZxk+8/11PXCUj6wmSoAK
X-Google-Smtp-Source: AGHT+IHoNxkdFLrxPGCKW/STKVaUNQvSi1kKswyzGQR0MI/GSOTUPLcJoxVbDzYnNQIyEloeXjVMRA==
X-Received: by 2002:a17:902:da84:b0:1e3:e1ff:2e79 with SMTP id j4-20020a170902da8400b001e3e1ff2e79mr16792847plx.45.1713856923506;
        Tue, 23 Apr 2024 00:22:03 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902c79300b001e0c956f0dcsm9330114pla.213.2024.04.23.00.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 00:22:02 -0700 (PDT)
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
	atenart@kernel.org,
	horms@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v8 4/7] tcp: support rstreason for passive reset
Date: Tue, 23 Apr 2024 15:21:34 +0800
Message-Id: <20240423072137.65168-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240423072137.65168-1-kerneljasonxing@gmail.com>
References: <20240423072137.65168-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Reuse the dropreason logic to show the exact reason of tcp reset,
so we can finally display the corresponding item in enum sk_reset_reason
instead of reinventing new reset reasons. This patch replaces all
the prior NOT_SPECIFIED reasons.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/rstreason.h | 15 +++++++++++++++
 net/ipv4/tcp_ipv4.c     | 11 +++++++----
 net/ipv6/tcp_ipv6.c     | 11 +++++++----
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index bc53b5a24505..df3b6ac0c9b3 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -103,4 +103,19 @@ enum sk_rst_reason {
 	 */
 	SK_RST_REASON_MAX,
 };
+
+/* Convert skb drop reasons to enum sk_rst_reason type */
+static inline enum sk_rst_reason
+sk_rst_convert_drop_reason(enum skb_drop_reason reason)
+{
+	switch (reason) {
+	case SKB_DROP_REASON_NOT_SPECIFIED:
+		return SK_RST_REASON_NOT_SPECIFIED;
+	case SKB_DROP_REASON_NO_SOCKET:
+		return SK_RST_REASON_NO_SOCKET;
+	default:
+		/* If we don't have our own corresponding reason */
+		return SK_RST_REASON_NOT_SPECIFIED;
+	}
+}
 #endif
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 418d11902fa7..6bd3a0fb9439 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1936,7 +1936,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v4_send_reset(rsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v4_send_reset(rsk, skb, sk_rst_convert_drop_reason(reason));
 discard:
 	kfree_skb_reason(skb, reason);
 	/* Be careful here. If this function gets more complicated and
@@ -2278,7 +2278,10 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v4_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				enum sk_rst_reason rst_reason;
+
+				rst_reason = sk_rst_convert_drop_reason(drop_reason);
+				tcp_v4_send_reset(nsk, skb, rst_reason);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -2357,7 +2360,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v4_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(NULL, skb, sk_rst_convert_drop_reason(drop_reason));
 	}
 
 discard_it:
@@ -2409,7 +2412,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		tcp_v4_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v4_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(sk, skb, sk_rst_convert_drop_reason(drop_reason));
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 017f6293b5f4..317d7a6e6b01 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1680,7 +1680,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v6_send_reset(sk, skb, sk_rst_convert_drop_reason(reason));
 discard:
 	if (opt_skb)
 		__kfree_skb(opt_skb);
@@ -1865,7 +1865,10 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v6_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				enum sk_rst_reason rst_reason;
+
+				rst_reason = sk_rst_convert_drop_reason(drop_reason);
+				tcp_v6_send_reset(nsk, skb, rst_reason);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -1942,7 +1945,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v6_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(NULL, skb, sk_rst_convert_drop_reason(drop_reason));
 	}
 
 discard_it:
@@ -1998,7 +2001,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		tcp_v6_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(sk, skb, sk_rst_convert_drop_reason(drop_reason));
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:
-- 
2.37.3


