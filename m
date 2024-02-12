Return-Path: <netdev+bounces-70902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06A9850FC3
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 10:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCD9283D57
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 09:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B52EF51F;
	Mon, 12 Feb 2024 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiWB5YLV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E4617557
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707730195; cv=none; b=G0NPQj3ycr/qh870OPM/J3VKy3HBRKAuRg+r600sU6XDVkieF6zm1gBulF/my3aYk8aRvg0QVqO58M0IJf/EGq6/xJK4goH+BLfpgxeJoz8XCmBxiXvNXGwjj/SCKfhKa5Ayigq5DYz5ZP3d+zd1UfXYYm2mpUUETTsM+4JZeDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707730195; c=relaxed/simple;
	bh=2M7USFiX5nLXq140cq9+M5nfmHpQqyKhgE7+WdLYYrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s/FCVZxG6nWUqBFyXQ9z5NdlouattJum3XE+8DvzAC+YjIGVkcMk3a0jPEmAlXViwOtcAVTEbUuYam1Ezv01yylFEbHP1NwUQRvzRrObN29j8rWp+p0FIp5D8wtWzuZ0zCJlGiTTIHN4lerUT08bDzC2ama2+LCZKiYIfUe4yCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiWB5YLV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e09aada5fdso770883b3a.2
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 01:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707730193; x=1708334993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5VCz9rjMN59Icaq+ueDHdsVRQa+elI2g77RIpJ6uB0=;
        b=WiWB5YLVRDwKvmyrP8rs+BuErWtnfxV+TKjPHrsXDxrKHmLEYnWp46U3XVRf1iBcLD
         IZ51ZCYTA/+Vo7HbWga3Rf5xm39n+KUBobaH1NQlE2nxhuhxP7itsNo8CAOAj00wH9wb
         4KQLBV4yhRqeigVC8VRq8owUhlv63NUxTD/LsRl0OqbC7TW7vHuys+4zhW/1Y/gK+2eQ
         YvGmu7fivKjZUprOQWlhGw+DjUwB8HI36sDEjhW2UzpbxUfksZ/cVITdgZB+yAAQ3DFH
         KFr6pUzctCv6OFS0JET62q8UyAuvQACs7t9b14wxjLyq9+quUa2he4XHl9YWBSwDqWbK
         u5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707730193; x=1708334993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5VCz9rjMN59Icaq+ueDHdsVRQa+elI2g77RIpJ6uB0=;
        b=HOjJndntMMoDfR0kFRVzKBbE6egg+pTuE8D3PSTmHtbRVm2ehMgX6E/ZQw2yd+F03k
         c/P7+N/mEuXhR5F3iQPyZ0E6kS/aEfkSkaH37NJGqtD8GO3NzxlQnOu9lhHs/x4uUJ5I
         uakfBi5l07XL/04jbp7bfDYO6Nj2LuBdIPvK8THEI/OAJpUVSVAhIWW6YxmeMAaGb9+b
         TUNhd7VubAw/3Vqzk+XGX+lNG23UZ028+uLSBjr/K9/2ln/mR53PL22CW6Dca/QjpDIc
         WKVZbGDUqqpHnaNo3Ax2GbKg0z1AvtgGQbHt3072MlCcfiKpkfttretBsFX7/I5fbNhP
         vphQ==
X-Gm-Message-State: AOJu0YwSICyxM63R0E42kL7Q3B6mteKh6StjYY8gdom3BrPAbEaXQ3oy
	Ao8tXJrAlo09KwmiMGsB2WAQcaqovbsoFoqi3lRzIvE7Z3Tgx2lG
X-Google-Smtp-Source: AGHT+IEF7TT6ZIgtSaE2JtBV9Mx9e6WQBAJQ/rVBGWlLdybBHdqQzQR4yM1uoQVkjjQXE/9eENaLiw==
X-Received: by 2002:a17:902:d4c9:b0:1da:2390:c6c8 with SMTP id o9-20020a170902d4c900b001da2390c6c8mr4238563plg.57.1707730193225;
        Mon, 12 Feb 2024 01:29:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDQ3/NFbyFggEP27K5Ap2PZVqys/ua0KwAGp7CXgLzooMsApucuxdjr+rCCNI6sLngYkvoiIdfl5basIkcOiGWdNeh1c1wfgow8xMqDexgKQBcrcvY1TOTCCcQxjHWO7mmyCm1NChChl91dWtY/L+sVK7cwT2RwgTC+2OA45U6sHtxqVkEjLE3RRqxqXQKF+WtxEJ+dyT1mnVi43WT3K++/m/Q6zpLzW0HSdaWRd4=
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id mg12-20020a170903348c00b001da18699120sm4220211plb.43.2024.02.12.01.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 01:29:52 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 5/6] tcp: make dropreason in tcp_child_process() work
Date: Mon, 12 Feb 2024 17:28:26 +0800
Message-Id: <20240212092827.75378-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240212092827.75378-1-kerneljasonxing@gmail.com>
References: <20240212092827.75378-1-kerneljasonxing@gmail.com>
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


