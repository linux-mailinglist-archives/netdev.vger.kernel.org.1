Return-Path: <netdev+bounces-73533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B74385CE65
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF3D282422
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020942837A;
	Wed, 21 Feb 2024 02:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fni7v8+/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5D2C1B1
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484282; cv=none; b=p5dnglUD+lom+UgqY4qxgTNKZ8Mz3nvWzop4sSdIfAwuJcakqe0CbnOtrlgAZYzJjtfoBKR0tDA7YOMlHcjQOXuhWtlwJPHQVIjOTjAJEyYcaJJ6gg33KAwRjUNj1MoqTIBKvMD1iTvIoQ7NW+pJXgHCWTKWJPatW1x2n8OiAXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484282; c=relaxed/simple;
	bh=vODjNpSFEwUimK6t0NAJ8JwOi7abz7WuYbHZl6mC+Wc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GF/SCNFGWDAUNx94WkHyyK4VoBlzLu23MWwasr4jZQGVmQT27VGtdZibIKBgpS5IRfnzNy0j3F9RTh7sEf5pnThswDcDj5QDPQNszzCKStr6xRIPhzU3UHZprlfGSyZpsxYlRHv8TPlaLp7T6Z2DGVQkSdOrSaOgv3i7j03YZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fni7v8+/; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso5782035a12.3
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 18:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708484281; x=1709089081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAt2OO7Hem62qMBwPKg5IUfr3hsJsvxEwfizP/2NuGg=;
        b=Fni7v8+/15b2fIwg539MHgxM3swGuQryq7kNbDUQOLRmZn5EdkmnCNuYtpD5UQ54MH
         j3vQT6anDEs3iLTV7Um2L5OJx9eCz1f4eD4aVSqIfpUtvGFRoyAPC246kcivhUNq9PRT
         7i0xKmJNMQBBqOOGmFH9VNga7TiyxUZ//mqSq0Hd5VBmg1J0bZLamUTZqXsvvjPfKCNC
         WgtRDwdicZ58oNDrzCBL1EiAiumKB7TRlV1R5t9qrdqD5TaoZBH81YGv7ZRNxtGZVef5
         fBACK092H/18VdD9Y2j38XKWrAX1sHGUzU7LHNP5zb8mRXs+Q1nbPVHfr01HO6Bijerg
         y/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484281; x=1709089081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAt2OO7Hem62qMBwPKg5IUfr3hsJsvxEwfizP/2NuGg=;
        b=osvASVzPTjgdkGwO+xaop/eZcwmATrQjdupNlrjb5UcEAepztMODNP+I680r8q6nss
         8LQ5ZdEwJ+sjopfZT/iiXh+VekWfBgCe0OwjRFfx8aCQl+J0j0R/JNaJwz0NlqVNt77x
         jP3HnM9xWQUBFm/g4zcUk4bg4U7FT+KQLv8j92E/murBO8DulrXe3/+Scd9BZGG9jodv
         ZYTVx9hLGxUYQ+/7P6eXwixGymzjzuhLq612+c+0pkpqpXLs2oK4sm/8at5BfI51LXNU
         1GzmsjxsOXhZHNXb4cQdSUToIOexozDPVA6yMiJDXDXKhMFwVpZaz9y9dbsdebHOP4ji
         4qJw==
X-Gm-Message-State: AOJu0Yxf3efs89y6IolEAMwlud7aImb2HKQf2ihZ6nJ9RKKeiSw9go7d
	GSonIQcmF/0udzNAUC1kykDpowi7NflOYgHodnK44ArY3XkvCCgf
X-Google-Smtp-Source: AGHT+IGUySYrGarbYDW/8SvedNia3SbMsOp9W7197M9r3LWeS+u5VIrnW7p69rSeK+ADe6mtzmM06g==
X-Received: by 2002:a17:90b:4d86:b0:299:d5fa:3e1c with SMTP id oj6-20020a17090b4d8600b00299d5fa3e1cmr4014415pjb.31.1708484281096;
        Tue, 20 Feb 2024 18:58:01 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id pv14-20020a17090b3c8e00b0029454cca5c3sm426467pjb.39.2024.02.20.18.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 18:58:00 -0800 (PST)
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
Subject: [PATCH net-next v7 04/11] tcp: directly drop skb in cookie check for ipv6
Date: Wed, 21 Feb 2024 10:57:24 +0800
Message-Id: <20240221025732.68157-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240221025732.68157-1-kerneljasonxing@gmail.com>
References: <20240221025732.68157-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Like previous patch does, only moving skb drop logical code to
cookie_v6_check() for later refinement.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
--
v7:
Link: https://lore.kernel.org/all/20240219043815.98410-1-kuniyu@amazon.com/
1. refine the code (by removing redundant check), no functional changes. (Kuniyuki)

v6
Link: https://lore.kernel.org/all/c987d2c79e4a4655166eb8eafef473384edb37fb.camel@redhat.com/
Link: https://lore.kernel.org/all/CAL+tcoAgSjwsmFnDh_Gs9ZgMi-y5awtVx+4VhJPNRADjo7LLSA@mail.gmail.com/
1. take one case into consideration, behave like old days, or else it will trigger errors.

v5
Link: https://lore.kernel.org/netdev/CANn89iKz7=1q7e8KY57Dn3ED7O=RCOfLxoHQKO4eNXnZa1OPWg@mail.gmail.com/
1. avoid duplication of these opt_skb tests/actions (Eric)
---
 net/ipv6/syncookies.c | 4 ++++
 net/ipv6/tcp_ipv6.c   | 5 +----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 6b9c69278819..ea0d9954a29f 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -177,6 +177,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	struct sock *ret = sk;
 	__u8 rcv_wscale;
 	int full_space;
+	SKB_DR(reason);
 
 	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
 	    !th->ack || th->rst)
@@ -256,10 +257,13 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	ireq->ecn_ok &= cookie_ecn_ok(net, dst);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, dst);
+	if (!ret)
+		goto out_drop;
 out:
 	return ret;
 out_free:
 	reqsk_free(req);
 out_drop:
+	kfree_skb_reason(skb, reason);
 	return NULL;
 }
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 57b25b1fc9d9..0c180bb8187f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1653,11 +1653,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (sk->sk_state == TCP_LISTEN) {
 		struct sock *nsk = tcp_v6_cookie_check(sk, skb);
 
-		if (!nsk)
-			goto discard;
-
 		if (nsk != sk) {
-			if (tcp_child_process(sk, nsk, skb))
+			if (nsk && tcp_child_process(sk, nsk, skb))
 				goto reset;
 			if (opt_skb)
 				__kfree_skb(opt_skb);
-- 
2.37.3


