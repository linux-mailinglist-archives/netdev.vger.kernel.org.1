Return-Path: <netdev+bounces-73955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B3085F6DE
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D843DB21D35
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0618C41211;
	Thu, 22 Feb 2024 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0c3tyhQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8112B3FE4C
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601420; cv=none; b=rerLZXdLRSZDmLzGc3qjYmeEq/F5aBMbZ0j8kLSuNSVVCav0SxZCVycVJcBNT9tbRDNlf0c7Hb02+lO0XECzSO5fwZrFyzss0hs89Zhp+3kSikXm1GIR2UvCPrcHHKnMmPoJL/PFn0afRAyGu7lTIIEU4oS+RkMzaurCePHQKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601420; c=relaxed/simple;
	bh=sCwDei58mRUsxdScWWgD4+vXCH/Z2/Wla5zgJD9BH6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lxW2UTkjd3DN3f/2ka52zTK28PUwETk6WDz3O//8TPMHEBdVu/nEZzyL4oxMbczw7P7omY9RcRqogiILxS7lGOuBsvi0+/1NxCAs1Q3Xh5haCyp6S58BzYeqEYM5OUvU/3vvcKUUVLdlYG99HnyBgHWa0RPF7P3+egAHOtwEVcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0c3tyhQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc1ff697f9so21805425ad.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 03:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708601419; x=1709206219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtUWWj8Al8TQWnM6twtNIpEn/ED/jKVV1nZhQrKrLbM=;
        b=N0c3tyhQWsyYA7wHZF9AwMnHRsPC/zO3pu9XYsJcLRgvSCQUWI81tyj1VIv5fCOmO6
         kW1+t+ObzbFGVOpfrTItvCMjmMLbl1IDA9DGH5UQFLn/2+kIG7LPwNon/AqmHlNSXx9i
         QYFZjtk2VcLYQ6mjuj2uv3osaU2HMi0Pl5GeBVbon5OtWyNRCdyV27Xvxjq9pXIELew4
         S3nZ5UCkYJATkFEDDTp/95VtsxkMwpAI1ueI/1qWXnae2CQJ+EOmWuJJNRqyLNbAPFCb
         Njt1eYd+27cWRMN1Wvo7TtQq9xWo8VxwOS0SkGZtNsOal3WgIRHfbSx6vXYW93EebUdX
         fQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601419; x=1709206219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtUWWj8Al8TQWnM6twtNIpEn/ED/jKVV1nZhQrKrLbM=;
        b=W8LDZ41o1wEvWltK44m6Y9y9IxnwFztz6IwN6pCdjIQj79LLWHKmDLDp7ckdUUTl+6
         Nof4WizUIlLj492wZsNtvnoWQ0KM2ZzuWxXdTgvkl2jgh+DXSaegw1LZSwfCtrc0Q8T9
         PyFMX75Vxy74qAvI948zrzj5hpc7J0cAW0iRhB8kPlcPpk/l00Hjh+n0sfu9WWh7xYYC
         Rg+X2HQqCRforrfl66lWIh3bX4nbKe3AJKipk0FwdVDtCcmy6QG8rj8pnkFCmbgUWfC8
         FvELnxH86LOj8GZUtO46mwve/RgzezZVmGfeNnYouekmobETPj4nPS9VNUqDNtzorIvG
         OrvQ==
X-Gm-Message-State: AOJu0YzfbNYmoSNhJ1aFiio0d3JEFfki7jC39KIsapRTNfIc1GacxMPE
	+UYHtTI0P56WVpfgXkC779DWKv/YcdWsY7jdDt+Yb8j3leHBZ7M8kqNAIefMs1c=
X-Google-Smtp-Source: AGHT+IF11NWgK+bU5kkKnfuWKOBA8yZY0mylAaKvPf3NKeiEy0YZ2BfAo8p55FwqS9DWeacMeQkMgg==
X-Received: by 2002:a17:902:7ed0:b0:1dc:4d63:7a0d with SMTP id p16-20020a1709027ed000b001dc4d637a0dmr816000plb.41.1708601418615;
        Thu, 22 Feb 2024 03:30:18 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902a9c300b001dc0955c635sm5978637plr.244.2024.02.22.03.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:30:18 -0800 (PST)
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
Subject: [PATCH net-next v8 03/10] tcp: use drop reasons in cookie check for ipv4
Date: Thu, 22 Feb 2024 19:29:56 +0800
Message-Id: <20240222113003.67558-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240222113003.67558-1-kerneljasonxing@gmail.com>
References: <20240222113003.67558-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Now it's time to use the prepared definitions to refine this part.
Four reasons used might enough for now, I think.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
--
v8
Link: https://lore.kernel.org/netdev/CANn89iL-FH6jzoxhyKSMioj-zdBsHqNpR7YTGz8ytM=FZSGrug@mail.gmail.com/
1. refine the codes (Eric)

v6:
Link: https://lore.kernel.org/netdev/20240215210922.19969-1-kuniyu@amazon.com/
1. Not use NOMEM because of MPTCP (Kuniyuki). I chose to use NO_SOCKET as
an indicator which can be used as three kinds of cases to tell people that we're
unable to get a valid one. It's a relatively general reason like what we did
to TCP_FLAGS.
Any better ideas/suggestions are welcome :)

v5:
Link: https://lore.kernel.org/netdev/CANn89i+iELpsoea6+C-08m6+=JkneEEM=nAj-28eNtcOCkwQjw@mail.gmail.com/
Link: https://lore.kernel.org/netdev/632c6fd4-e060-4b8e-a80e-5d545a6c6b6c@kernel.org/
1. Use SKB_DROP_REASON_IP_OUTNOROUTES instead of introducing a new one (Eric, David)
2. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket allocation (Eric)
3. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
---
 net/ipv4/syncookies.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 38f331da6677..7972ad3d7c73 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -421,8 +421,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 		if (IS_ERR(req))
 			goto out;
 	}
-	if (!req)
+	if (!req) {
+		SKB_DR_SET(reason, NO_SOCKET);
 		goto out_drop;
+	}
 
 	ireq = inet_rsk(req);
 
@@ -434,8 +436,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	 */
 	RCU_INIT_POINTER(ireq->ireq_opt, tcp_v4_save_options(net, skb));
 
-	if (security_inet_conn_request(sk, skb, req))
+	if (security_inet_conn_request(sk, skb, req)) {
+		SKB_DR_SET(reason, SECURITY_HOOK);
 		goto out_free;
+	}
 
 	tcp_ao_syncookie(sk, skb, req, AF_INET);
 
@@ -452,8 +456,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 			   ireq->ir_loc_addr, th->source, th->dest, sk->sk_uid);
 	security_req_classify_flow(req, flowi4_to_flowi_common(&fl4));
 	rt = ip_route_output_key(net, &fl4);
-	if (IS_ERR(rt))
+	if (IS_ERR(rt)) {
+		SKB_DR_SET(reason, IP_OUTNOROUTES);
 		goto out_free;
+	}
 
 	/* Try to redo what tcp_v4_send_synack did. */
 	req->rsk_window_clamp = tp->window_clamp ? :dst_metric(&rt->dst, RTAX_WINDOW);
@@ -476,10 +482,11 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	/* ip_queue_xmit() depends on our flow being setup
 	 * Normal sockets get it right from inet_csk_route_child_sock()
 	 */
-	if (ret)
-		inet_sk(ret)->cork.fl.u.ip4 = fl4;
-	else
+	if (!ret) {
+		SKB_DR_SET(reason, NO_SOCKET);
 		goto out_drop;
+	}
+	inet_sk(ret)->cork.fl.u.ip4 = fl4;
 out:
 	return ret;
 out_free:
-- 
2.37.3


