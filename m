Return-Path: <netdev+bounces-72802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78393859AFC
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2961C21355
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 03:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CE72114;
	Mon, 19 Feb 2024 03:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+vCdNxu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34D55238
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 03:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313362; cv=none; b=QiKVqUO+KhOHhzMrmQSvNv5/TDS500VSQPF/cFOHKlNRcHCKoPR3g9pMOuficVONm8zjhIVHCRLW70HCto5V/4ypjfOFjLaoklScwP6rlEgbc7eX/m7e8yVsgCtaszQ+3rjMIkUc0J2pruWS0bUCO4MBo5fC1fL/eMRv3jJ6mwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313362; c=relaxed/simple;
	bh=UAJZML+TMbRy7UfxH2m8GRgEJTovA5EGLgeRqhfJeE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T/aZdUJxtq1e4aSTnW/2dxTkYBDtSuKrnwxABVxSV3s+vR5R7UKy9VqiNRplajJGvxoe2Pl9z5Ow0obv9/lauftM08DbatQ6ZORTHzrpu63dCOoCGSmYrGrPXIMQoWYs7+e9WbnyPrgx/EzqAvJGncocHcc6urzeW04a+Req3Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+vCdNxu; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so1970175a12.0
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 19:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708313360; x=1708918160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiOncSV9yT9HZiAjkpLU1vUm69RWMLdc98c4JFmhts4=;
        b=C+vCdNxuu4LQWQ7hI6noWwbCNQ6jnyzxXwEZ6FBrOTHkSyACR6oriVoJQxnUu7oeSk
         0dM7h6NzBCi05N2eB0me/vRMRGzPYa3fWt21Vk66ipxkyKHY1XATYrC13ecEZwXdSrnr
         Y7Ag+tno9WrIUSRVozFOp2ddsa+D5bPlEsJc+NE3z8RmQGfQ6Iw/bcwFcSqONwbiiC9t
         nrzl/Vsc0MZrTUDYVIqFMVqf7MW1zc7kuxSriCMJnt4o5KdWsL7C4ttosGNgjepiRW5b
         rgv+V/inhoyTdJcjwMkBAW37tyBohKO5uWInLXLQFS2kptpc+3GhBPjz61femBKXFjA3
         iNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708313360; x=1708918160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiOncSV9yT9HZiAjkpLU1vUm69RWMLdc98c4JFmhts4=;
        b=p8HvPM2ZvFu+7j7GNsi1xb9ChpkJPl8bdjkxWBVKis4C9DdvN56xqkE6v8IYbn820x
         Yk18uNRseNep0Ijw4aB5ZqhsZKv09x9g7C9JhAUpgK8lQuYGWQEalYCkhzAoNaDhxnUz
         fgq52IcPqDk6svVN/rhiMOF0zFPb+3s2lrokmRePf41/PV9HjbIGrbu5cW9YcaDEcnFm
         ustkYIyCTJEgJTbJ3yg3CAUz/R6Umqki4msXspBZjGAwu5dKe5Dxdnpm4AIrXtMbPPjN
         741Z3IknF3gj7ZxYaBCbBEjjnAsiMxuOK4eCHqdF6aO/uSuF7MoBds+ucsNICDgO/+eC
         Ry5w==
X-Gm-Message-State: AOJu0Yx8fZQrg1SJu7l/YAzmPdMXWoEMhisQTreYtwOUNGPHevQw5Z3T
	iUiCNvl1ll/q3Ujk8jZrbaPvhWOsxgQSiyoHv6AMsPkruszQVxBu51inmilcEYo=
X-Google-Smtp-Source: AGHT+IF1S4nK2oFUQyxYGpRbQ+BWSc/4M9KsgPY7f+w1ElrGUv20ooH0GvGM5N8nGvZdlVSxm5e/Bg==
X-Received: by 2002:a17:90a:8546:b0:298:c104:1eb8 with SMTP id a6-20020a17090a854600b00298c1041eb8mr15611695pjw.19.1708313360056;
        Sun, 18 Feb 2024 19:29:20 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm3968921pjb.25.2024.02.18.19.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 19:29:19 -0800 (PST)
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
Subject: [PATCH net-next v6 03/11] tcp: use drop reasons in cookie check for ipv4
Date: Mon, 19 Feb 2024 11:28:30 +0800
Message-Id: <20240219032838.91723-4-kerneljasonxing@gmail.com>
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

Now it's time to use the prepared definitions to refine this part.
Four reasons used might enough for now, I think.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
--
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
 net/ipv4/syncookies.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 38f331da6677..1028429c78a5 100644
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
@@ -476,10 +482,12 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	/* ip_queue_xmit() depends on our flow being setup
 	 * Normal sockets get it right from inet_csk_route_child_sock()
 	 */
-	if (ret)
+	if (ret) {
 		inet_sk(ret)->cork.fl.u.ip4 = fl4;
-	else
+	} else {
+		SKB_DR_SET(reason, NO_SOCKET);
 		goto out_drop;
+	}
 out:
 	return ret;
 out_free:
-- 
2.37.3


