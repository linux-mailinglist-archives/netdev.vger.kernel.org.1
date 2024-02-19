Return-Path: <netdev+bounces-72803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CBB859AFD
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7D92817E0
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 03:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D584400;
	Mon, 19 Feb 2024 03:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npxZ6He2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60FD538B
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313365; cv=none; b=NHzTHh/mpM09+VeOmazTELvrYGPOPATHj4a1JaHh0uLFhlTL5GO7ez9cyUR1JLpvSuIAQQKn6QHEGtmRFZ0JxucjvdYHsLHq9VdtQj0vUTa2OAJcAna3O6Ab+FdL2jsyiUpelIudU8rJ0plXB3iFwVVbW6xDTmxI8qHfiIKyTYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313365; c=relaxed/simple;
	bh=M5ik+z+WYItjLjr7q6fs9zadDyKS3UFpR51MdbQp0Pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mtnQszqu0X/dyfaV9qZDSjaE7JMA2K3hCC5LKS0xr66fH0lzvvDSODY3WOwSzfUZkES6D9TlDdesQXCgGTYQVgHFmlaCD14AGsxNMbdNksdCZpGeult1usMGY2uy+ndPCHXUy6klM7mBC2C5enX8Yn/xwOqz0LDXIpwLmny9xHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npxZ6He2; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29954681b59so684848a91.2
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 19:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708313363; x=1708918163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhC4suqA+AkuWcTj9371L/OmqaVuRVvfn/7YTCNIeFs=;
        b=npxZ6He2HeORXy0baWNlYIJ5rzXikSVpmhg6cbylk7m1Id2KoiuRe75bNUCEcWKkd8
         3tPWitzkURn1noIkGzIWd+oQ2q4QyEg99W9+4DCjBX6QOfrF3KdMr9JIXy1GVgsIeAFm
         E286TscjDieN3pxT9EuKmAL5LBIqKeStBL9xKVBJvqHx74rE4x8J4pdFQssu/gTwk+ie
         NN3lmdmF36DjKUuKjYXMns55vSc8EurpjZmqMPKS4oNa2r+OxmAnoSe1RfWvOWaUK+CI
         OZJsk3wpGKyNdra6O13aw8TVX8ntjGFte+YfkItK8SIPHzmfdFvver75yunq2ARI96Fx
         fVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708313363; x=1708918163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhC4suqA+AkuWcTj9371L/OmqaVuRVvfn/7YTCNIeFs=;
        b=H8257FUXEc1X+sxedpn+h08soEzlPb84lMYP4Fkvv3veE1clmIQaFwBxsmLfPE3YIR
         aVeGmTt+GIoI4XvqVRcnc4iN0NNQ+Gyn6N75rhOLP4Jc9CBP0ePXxMmdjI3WbDBWVuy5
         Mkmk+PZhLvUmyCU1El4Pj+AMY4zYtMQ5bUJBYy0fMV2klsD4VAZWoWJpYlIYH6oQ6KoK
         dCxZRKL1z6ducuqhKUDUGOJSkqYOvuNTmYkLIT+MBBXLkqvHYfaQP6w7+Vkp7A3o1Fmx
         OxejZ+EcNSsgEuSP38Dmj1V5Hr1shu1xtLqy21li8BMqbR9HZkWX2CI6RaCjURn1BdzY
         voFw==
X-Gm-Message-State: AOJu0YzRNsBdKXjt1SjCjiFQE9uDrE91X6eW2/Ao+UsQ5MZy1BDKD4Hg
	fSYNkAVTkjdEP0HmUQrGTsT5+3JGbCIn6MnH5gR4nJ2S7oDVOjVg
X-Google-Smtp-Source: AGHT+IGQiaph2i+d/W7BpKx4l4mwWjzjz7LLo4BtPDIrSFCk++KAPSQFEa09u6dLlc4Eb+e5q0yZUA==
X-Received: by 2002:a17:90a:17a4:b0:299:b60:ff0e with SMTP id q33-20020a17090a17a400b002990b60ff0emr8083621pja.13.1708313362903;
        Sun, 18 Feb 2024 19:29:22 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm3968921pjb.25.2024.02.18.19.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 19:29:22 -0800 (PST)
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
Subject: [PATCH net-next v6 04/11] tcp: directly drop skb in cookie check for ipv6
Date: Mon, 19 Feb 2024 11:28:31 +0800
Message-Id: <20240219032838.91723-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240219032838.91723-1-kerneljasonxing@gmail.com>
References: <20240219032838.91723-1-kerneljasonxing@gmail.com>
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
v6
Link: https://lore.kernel.org/all/c987d2c79e4a4655166eb8eafef473384edb37fb.camel@redhat.com/
Link: https://lore.kernel.org/all/CAL+tcoAgSjwsmFnDh_Gs9ZgMi-y5awtVx+4VhJPNRADjo7LLSA@mail.gmail.com/
1. take one case into consideration, behave like old days, or else it will trigger errors.

v5
Link: https://lore.kernel.org/netdev/CANn89iKz7=1q7e8KY57Dn3ED7O=RCOfLxoHQKO4eNXnZa1OPWg@mail.gmail.com/
1. avoid duplication of these opt_skb tests/actions (Eric)
---
 net/ipv6/syncookies.c | 4 ++++
 net/ipv6/tcp_ipv6.c   | 7 +++----
 2 files changed, 7 insertions(+), 4 deletions(-)

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
index 57b25b1fc9d9..4cfeedfb871f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1653,12 +1653,11 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (sk->sk_state == TCP_LISTEN) {
 		struct sock *nsk = tcp_v6_cookie_check(sk, skb);
 
-		if (!nsk)
-			goto discard;
-
-		if (nsk != sk) {
+		if (nsk && nsk != sk) {
 			if (tcp_child_process(sk, nsk, skb))
 				goto reset;
+		}
+		if (!nsk || nsk != sk) {
 			if (opt_skb)
 				__kfree_skb(opt_skb);
 			return 0;
-- 
2.37.3


