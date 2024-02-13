Return-Path: <netdev+bounces-71400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 264CB8532A0
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277B51C23176
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038D55786C;
	Tue, 13 Feb 2024 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvTIB256"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECA856B6A
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833185; cv=none; b=qUgDq+nUhTfKBK2PrNHiHVPRef2rGZzmbb4YY5NKkXHBQW69odrWRShaf3m8EpsxgR9nJnHf+t/T25vKrk601mMlNPgDVCzW7wc0UJhTAI7KNHPORtJdONDUGfzs431AXrwJvo63yNGtUdXpjMXKRT5FQBeQ9g0IjYN+9u0qhUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833185; c=relaxed/simple;
	bh=2M7USFiX5nLXq140cq9+M5nfmHpQqyKhgE7+WdLYYrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nSzSptAE4Qh7S0b4nhqcCzFr9Knn8BuSRgP/3WCwpf2wrU1DtREVoLDTYZIJ208G8HEYRF96CFHpUmXti8AGyWk1oDQ2+aSCzsAODuHeQMAAu7IR3vnf1BjjJHowTvcoBQRudboRLd1ljHQj4Iotc4abuUT9x+DaT2DnIJ8CgSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvTIB256; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-363ce3a220aso16953585ab.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707833183; x=1708437983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5VCz9rjMN59Icaq+ueDHdsVRQa+elI2g77RIpJ6uB0=;
        b=LvTIB256QdsSNn7Sl/0FRigaKThX4VQLNMTK50dTImMKDPogrKk6IWlwWrPjwZpdCm
         eIE+Hi41edpSvOaWBxPuo0iQJ9jcDKJ5MP8m+SVTKyFBi+u5wZpgPCv3V5aCoyjzM3Zg
         mCYLwMCRMv6pbTYJK/4tCR2L1SjYlI3+VWtkiQo3aqcvxeGDFNFi90LuM/YqyXd/Nm5q
         bmSTQmZgkvz60Lbqk9rhxkbZeSreqk9E2OFF90tIpWMAa0CueILdzWvqYP9yyqQfyAnP
         xASzJsJgcljDgyrRLMKtJx8+zaN4YstLRtxDdyXZ2eTyQJAxhQr88MA9k1fiU7oYfYJ5
         Crnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707833183; x=1708437983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5VCz9rjMN59Icaq+ueDHdsVRQa+elI2g77RIpJ6uB0=;
        b=vbuAnuKEn+JON85uxlRJCa4Ic63KAvEPqgl37rPWYc7OXTwPUc6EL+kAP0Hc7XPpzw
         IVJHmfuKjDrgDLBdeoOqclTKn241V0jc//tDO8LtHW/VSRNcF2PBtFj7cg4TMcQeRDau
         yA8BA+lD866pgLmAwXXLnLoHw4bwLK2B5vjKD46YcyW350WbIeEdFPGssSVjnFVaM4PX
         4b4KZa2C8uent6muVuVJpjIteC75E1OlxtMVcVteRm0E0PRYGlWwEEjCMkTkNuz0ElCW
         gqJD8FCKMPJm1TXvIDpI6VObuVvDSZlaANcVYprO2m5y1W9+6gHywVKFM20GZ6vSTjmS
         FNSw==
X-Gm-Message-State: AOJu0YyiIfLMXd4IVjZYdDK63dAxDXGSRcqINWu8Q6DQyNd9OEsNeeMj
	Tjo5gV5NJ/sNHcoV/pgzo+xkRKvAxlf5+JvDVrNpDD8qZV74iB7D
X-Google-Smtp-Source: AGHT+IHdUC968Ksny9xZmUMW4iWuz4/zD5hpIhzSMrtiFpyPnFbFUS6VeNzoMgm4++HFNGvQLgsQ4w==
X-Received: by 2002:a92:d941:0:b0:363:7985:eee3 with SMTP id l1-20020a92d941000000b003637985eee3mr11860457ilq.24.1707833183678;
        Tue, 13 Feb 2024 06:06:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIAE8oB4eESE3e5fVpX9NztB57+ntp8ZFLsTs+22rt+PCudVKNEeBH1XYP1RYtksD/7LCSS9N0mZomy8qk/h2Ee0ofoXRtGy0x7gED46ZBbgIgBc3bB/KrlzBFktD8Eu45k9AGOSgQQrXiLkq9uVBWSzdksoUbA1Ba4Zl/IO5UXRtSjs34FFRc92+PAvgWmX9utQlaxg7uyNGohdTB7vUjIBbWEgRsNZ6OYyx/Ab6zd4WVqG90ZC3bopUuiiP2V453
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id q19-20020a632a13000000b005dc8702f0a9sm1306247pgq.1.2024.02.13.06.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:06:23 -0800 (PST)
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
Subject: [PATCH net-next v4 5/6] tcp: make dropreason in tcp_child_process() work
Date: Tue, 13 Feb 2024 22:05:07 +0800
Message-Id: <20240213140508.10878-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240213140508.10878-1-kerneljasonxing@gmail.com>
References: <20240213140508.10878-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

It's time to let it work right now. We've already prepared for this:)

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_ipv4.c | 16 ++++++++++------
 net/ipv6/tcp_ipv6.c | 16 ++++++++++------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c79e25549972..c886c671fae9 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1917,7 +1917,8 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		if (!nsk)
 			return 0;
 		if (nsk != sk) {
-			if (tcp_child_process(sk, nsk, skb)) {
+			reason = tcp_child_process(sk, nsk, skb);
+			if (reason) {
 				rsk = nsk;
 				goto reset;
 			}
@@ -2276,12 +2277,15 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v4_restore_cb(skb);
-		} else if (tcp_child_process(sk, nsk, skb)) {
-			tcp_v4_send_reset(nsk, skb);
-			goto discard_and_relse;
 		} else {
-			sock_put(sk);
-			return 0;
+			drop_reason = tcp_child_process(sk, nsk, skb);
+			if (drop_reason) {
+				tcp_v4_send_reset(nsk, skb);
+				goto discard_and_relse;
+			} else {
+				sock_put(sk);
+				return 0;
+			}
 		}
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 4924d41fb2b1..73fef436dbf6 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1660,7 +1660,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 		}
 
 		if (nsk != sk) {
-			if (tcp_child_process(sk, nsk, skb))
+			reason = tcp_child_process(sk, nsk, skb);
+			if (reason)
 				goto reset;
 			if (opt_skb)
 				__kfree_skb(opt_skb);
@@ -1860,12 +1861,15 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v6_restore_cb(skb);
-		} else if (tcp_child_process(sk, nsk, skb)) {
-			tcp_v6_send_reset(nsk, skb);
-			goto discard_and_relse;
 		} else {
-			sock_put(sk);
-			return 0;
+			drop_reason = tcp_child_process(sk, nsk, skb);
+			if (drop_reason) {
+				tcp_v6_send_reset(nsk, skb);
+				goto discard_and_relse;
+			} else {
+				sock_put(sk);
+				return 0;
+			}
 		}
 	}
 
-- 
2.37.3


