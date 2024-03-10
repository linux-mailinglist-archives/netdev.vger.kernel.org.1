Return-Path: <netdev+bounces-79023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A968C87768C
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 13:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419951F213E3
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 12:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF00028383;
	Sun, 10 Mar 2024 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsjvSd13"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8390A20335;
	Sun, 10 Mar 2024 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710072866; cv=none; b=EIFXG4AURD9XIkxG3fbWuNX1fKa/0OHPBphceusxeHWnjxoHo4tBLOEqJewuntmAEky/nwMMiw2DlTRKBaieAI6Kg46T7auL2zedIXsZnDN2LCQKNdnB0kORs1gpc3OHB0WgtTb0OJpA2iy3/Z7cr7nTjz8+Mr8n+WKkAfv9sNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710072866; c=relaxed/simple;
	bh=HBFH2KOlP2HSSSU1VXasxhtjODXxUMZmoTi8xeyxyHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n80FonI+E1DrLrzinhZhysKHkdjPTEU1Iz2q9TIEQIJJQ7MSq353Zaz6lwAyFLZ7Mdb5G9Puq1Q9oEVYv1smFyLckT2ZaFvOfzNqCp+cv+1dGKRujSIcv5JjHSUJy6BWTgW0jHVWDROxeuobbJD2q/fAIWAeQq5sSCCVCjcV150=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsjvSd13; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso2928890a12.2;
        Sun, 10 Mar 2024 05:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710072863; x=1710677663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kxa+WSij7JIs5xDL7CTBVLsNlWQfBNLOi+KNiX5iofA=;
        b=IsjvSd13YcKmBjVETrWntfhy9UbZYYMMMLIxvX56HkOjBeotIz7AcQ/QPKuBNmJV5E
         qivpvO1VVBF/NNkfDLcL6lqQtBi+q+GKZHWxT4uBNsRJYi4gj2cDDBzn249d6OPuqCka
         pzJgZ94KK/xEfGtjjX1glRjf8PivB9DtdXvmL6Un4tozCdQRqUBAi8ZMfvvtCa2r/t1e
         cewWj6Qt1kATkq94/doBBrJlXcydhcmizhTuS/1Re7byBeOKHq28ag7wLAldAuwGOEEX
         l+2nfRmaIvH+plX4vBsJTge0UJign61NRLWdOitwX22F4YxhfIL7k6JdsdcFi7rGoUlp
         0cPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710072863; x=1710677663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kxa+WSij7JIs5xDL7CTBVLsNlWQfBNLOi+KNiX5iofA=;
        b=GswnuHd572i30yuFGANGZ7kjDr9yvx783y8Dppb94RryijZWPS3S7hS+DH4TJR/yf8
         QGCqXswC1Ukf9cKSrr53WaE6giW91DAqiJbL+wNpmbJavgZwC4vkYOJRZuX2qQqS/eIc
         U/rMJWB9BGEDTNOhEhbaTiwk6Ft2IO/qvY4NpMjVXUvrSUGtOVKEbtVDFzb1rBRQy8TY
         Fp59drxKyfLkcOFzXNeHredo1H0cOKZ8lmRqqjWdCDRy/j1pULogktO+8olIP9ZKaOfF
         JEAu4XqwOTtCm9hlRXHwN/MePbywFde+zlU3uVCCfbs4ItalCohmf5Jo66ICmErcZbAI
         vweg==
X-Forwarded-Encrypted: i=1; AJvYcCXpEFhVPFXhkfZdu2ruivrXCVSVOSMLCBjnU0C0iZPZdid9OXtSNde7kcQsCotnHxPafv30e7nOB3r6W4fV+Pia9hL2+8LUdnoie5hFZBN+b8sk
X-Gm-Message-State: AOJu0YwL4zhY1CEAXAEenMCFmLS1x9gUe+fzr+SFP93eOxuXRVpiwbmM
	5BAZSwR50944jx+166w7yS0yxQyRaDOiLhwP6TQkl3txY2T+0x5/
X-Google-Smtp-Source: AGHT+IGhuVnLsiaSde8+4+zCnc9ivPFUP0bbOFza29osma/R+lhSX/EGf4YEy2PXyceUXQo8Fpqq1g==
X-Received: by 2002:a05:6a20:2447:b0:1a1:4e02:e54c with SMTP id t7-20020a056a20244700b001a14e02e54cmr2244148pzc.14.1710072863138;
        Sun, 10 Mar 2024 05:14:23 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([114.253.38.90])
        by smtp.gmail.com with ESMTPSA id y30-20020aa793de000000b006e5a99942c6sm2485330pff.88.2024.03.10.05.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 05:14:22 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 3/3] trace: use TP_STORE_ADDRS() macro in inet_sock_set_state()
Date: Sun, 10 Mar 2024 20:14:06 +0800
Message-Id: <20240310121406.17422-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240310121406.17422-1-kerneljasonxing@gmail.com>
References: <20240310121406.17422-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

As the title said, use the macro directly like the patch[1] did
to avoid those duplications. No functional change.

[1]
commit 6a6b0b9914e7 ("tcp: Avoid preprocessor directives in tracepoint macro args")

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/trace/events/sock.h | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/sock.h b/include/trace/events/sock.h
index 4397f7bfa406..0d1c5ce4e6a6 100644
--- a/include/trace/events/sock.h
+++ b/include/trace/events/sock.h
@@ -160,7 +160,6 @@ TRACE_EVENT(inet_sock_set_state,
 
 	TP_fast_assign(
 		const struct inet_sock *inet = inet_sk(sk);
-		struct in6_addr *pin6;
 		__be32 *p32;
 
 		__entry->skaddr = sk;
@@ -178,20 +177,8 @@ TRACE_EVENT(inet_sock_set_state,
 		p32 = (__be32 *) __entry->daddr;
 		*p32 =  inet->inet_daddr;
 
-#if IS_ENABLED(CONFIG_IPV6)
-		if (sk->sk_family == AF_INET6) {
-			pin6 = (struct in6_addr *)__entry->saddr_v6;
-			*pin6 = sk->sk_v6_rcv_saddr;
-			pin6 = (struct in6_addr *)__entry->daddr_v6;
-			*pin6 = sk->sk_v6_daddr;
-		} else
-#endif
-		{
-			pin6 = (struct in6_addr *)__entry->saddr_v6;
-			ipv6_addr_set_v4mapped(inet->inet_saddr, pin6);
-			pin6 = (struct in6_addr *)__entry->daddr_v6;
-			ipv6_addr_set_v4mapped(inet->inet_daddr, pin6);
-		}
+		TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_daddr,
+			       sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
 	),
 
 	TP_printk("family=%s protocol=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c oldstate=%s newstate=%s",
-- 
2.37.3


