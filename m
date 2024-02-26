Return-Path: <netdev+bounces-74812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6F98668BB
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 04:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044462820EA
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 03:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DCA156C2;
	Mon, 26 Feb 2024 03:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMyvz4Gw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6581BC3C
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 03:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917801; cv=none; b=RbbQUleayuhH2d2jPEUMhu+lnpbfwUZrNxpFC5sdj2U751USrYCMFVUpFB/VXXA8VDAa2sXhvPdPgmSPLblMo1qrruTYFLZMwp3D4dH/7nREmcXWQWIWzFPVmZJutQ1m0qCOsY812naW3wjpjpAU24oLat4sitf4G6t1wXFiZ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917801; c=relaxed/simple;
	bh=lKG7ICoo3tIHtUX9QPr6Kt7PsVA1d+PiVXNcrumGgzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TpMa9yt5KDArE8HoQndaYWVC5KIwierOowcJV6hGtrlv8q/CYI22/qJ4IO8D59p6O7UuAssJ4TchdgumR+iaVHEKUs5rbUpnOOHkb2ryKPKl1xCrRAC3VmhB/wPRoVrPhgmBFH3iIdGJA7ulsdG5LNSHvua5gv3TsFiC5jTPJ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMyvz4Gw; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-299566373d4so1641276a91.1
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 19:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708917799; x=1709522599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6YQoXiiei/X+kWZ9qjQ6CLGNDjh8Uon0AD/cN0fEjU=;
        b=TMyvz4Gwfna7SIeSFU2bV4kwRIxPmxr3PxQsDZ621khHOWUH8ArBQ+bACH69BqB+Vm
         Xig3Mh0/2ZM/eAd0Z9emeBavXmeVTReDHnoz6JmVaFGdJ0yzhp3rMzJHtnZCqI4oaL4T
         SJNTI7cfdM8GMNp6CKkncedrDBtUENyjtieERO4CGj2jgEo3qfu9vcqOSZwCqzWJYPOl
         59NRmfHgVPCZKxRiNv+gYKVLIgKvNSYKm3bfnFuTPqofvutjn6PfFtIMbS+lazWzEo4j
         3yu4ZF3R5sayV3UeFtrPFnXcSj/yi/vTN6PgrEVE1SANRIWQI98+MGneS22LJQA3x13h
         /Mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708917799; x=1709522599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6YQoXiiei/X+kWZ9qjQ6CLGNDjh8Uon0AD/cN0fEjU=;
        b=I38EakNKD4V2icc2eEU5gK4ZEKrFttrbVh3KUJtsprLd+mLQ5Xior/ScGbeZHrfbbG
         D7pvANwf31RsD+culk2rLtJbPZWtwqUm1rDBZr5KnT3Nh9pySuMVWq6Az4l9BR79xWwt
         xsjuCGOGFDvX58sLSRFVjXxHK0SZAyKw04yCjJi2MuSAwFXhKTdFdWKeJMWhJUmg9gtl
         J6/XtyAmucek8BytMkD+wMRO6InomtxSzY+z8KGBEE3cwgz1Zj//9Fkit/7yZM8zUZX8
         0+oU9mgpgt+PHS13Ss+O7/NF1H8cmHvRe/75oP2q4nkEPXtjzOKNTS8ELBvQ8Fdi348D
         H5ug==
X-Gm-Message-State: AOJu0Yxvdvp3c2gPh9LgiDS3cbbWzON/p/t3DzzuE1kTYFjb/j/R95wo
	ym6hoC6U7scZTJ62YSXJZyeGZy5hW4Cllx46THokuyUOJFLwlkyN
X-Google-Smtp-Source: AGHT+IEVyaBVbg7X10VONFZTYPRIjJzAAo9wwEje7Wl7FqZnPPGDmRVxEf4TuHcUaYnsF3Odv+RIcw==
X-Received: by 2002:a17:90a:f3c3:b0:299:365a:3db0 with SMTP id ha3-20020a17090af3c300b00299365a3db0mr3392629pjb.5.1708917799505;
        Sun, 25 Feb 2024 19:23:19 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id fr12-20020a17090ae2cc00b0029a78f22bd2sm3262521pjb.33.2024.02.25.19.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:23:18 -0800 (PST)
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
Subject: [PATCH net-next v10 10/10] tcp: make dropreason in tcp_child_process() work
Date: Mon, 26 Feb 2024 11:22:27 +0800
Message-Id: <20240226032227.15255-11-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240226032227.15255-1-kerneljasonxing@gmail.com>
References: <20240226032227.15255-1-kerneljasonxing@gmail.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
--
v9
Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
Link: https://lore.kernel.org/netdev/CANn89iKE2vYz_6sYd=u3HbqdgiU0BWhdMY9-ivs0Rcht+X+Rfg@mail.gmail.com/
1. add reviewed-by tag (David)
2. add reviewed-by tag (Eric)

v8
Link: https://lore.kernel.org/netdev/CANn89i+huvL_Zidru_sNHbjwgM7==-q49+mgJq7vZPRgH6DgKg@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CANn89iKmaZZSnk5+CCtSH43jeUgRWNQPV4cjc0vpWNT7nHnQQg@mail.gmail.com/
1. squash v7 patch [11/11] into the current patch.
2. refine the rcv codes. (Eric)

v7
Link: https://lore.kernel.org/all/20240219043815.98410-1-kuniyu@amazon.com/
1. adjust the related part of code only since patch [04/11] is changed.
---
 net/ipv4/tcp_ipv4.c | 12 +++++++-----
 net/ipv6/tcp_ipv6.c | 16 ++++++++++------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c79e25549972..a22ee5838751 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1907,7 +1907,6 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		return 0;
 	}
 
-	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (tcp_checksum_complete(skb))
 		goto csum_err;
 
@@ -1917,7 +1916,8 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		if (!nsk)
 			return 0;
 		if (nsk != sk) {
-			if (tcp_child_process(sk, nsk, skb)) {
+			reason = tcp_child_process(sk, nsk, skb);
+			if (reason) {
 				rsk = nsk;
 				goto reset;
 			}
@@ -2276,10 +2276,12 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v4_restore_cb(skb);
-		} else if (tcp_child_process(sk, nsk, skb)) {
-			tcp_v4_send_reset(nsk, skb);
-			goto discard_and_relse;
 		} else {
+			drop_reason = tcp_child_process(sk, nsk, skb);
+			if (drop_reason) {
+				tcp_v4_send_reset(nsk, skb);
+				goto discard_and_relse;
+			}
 			sock_put(sk);
 			return 0;
 		}
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 4f8464e04b7f..f677f0fa5196 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1623,7 +1623,6 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (np->rxopt.all)
 		opt_skb = skb_clone_and_charge_r(skb, sk);
 
-	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
 		struct dst_entry *dst;
 
@@ -1654,8 +1653,11 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 		struct sock *nsk = tcp_v6_cookie_check(sk, skb);
 
 		if (nsk != sk) {
-			if (nsk && tcp_child_process(sk, nsk, skb))
-				goto reset;
+			if (nsk) {
+				reason = tcp_child_process(sk, nsk, skb);
+				if (reason)
+					goto reset;
+			}
 			if (opt_skb)
 				__kfree_skb(opt_skb);
 			return 0;
@@ -1854,10 +1856,12 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v6_restore_cb(skb);
-		} else if (tcp_child_process(sk, nsk, skb)) {
-			tcp_v6_send_reset(nsk, skb);
-			goto discard_and_relse;
 		} else {
+			drop_reason = tcp_child_process(sk, nsk, skb);
+			if (drop_reason) {
+				tcp_v6_send_reset(nsk, skb);
+				goto discard_and_relse;
+			}
 			sock_put(sk);
 			return 0;
 		}
-- 
2.37.3


