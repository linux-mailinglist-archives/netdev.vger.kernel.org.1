Return-Path: <netdev+bounces-73532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA8B85CE64
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1281F22EF8
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FDF28389;
	Wed, 21 Feb 2024 02:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCo87NKn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0BD2837F
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484280; cv=none; b=bVgoZMSq4ncJPdTfRoX5+NJ80uBFqOTSdsC+tdytDhh/X2gWGiwvxAAZkZ2p2zcVQVsyxpPre7qaIeuFYPgKejr8ngeIieDfmnfrLFA11l5qPyJf4NM95jpkrjCGPaQP5lcDnMeqZxm0caBpvun2uL1Vbj7leK71CIp+r/N1LZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484280; c=relaxed/simple;
	bh=UAJZML+TMbRy7UfxH2m8GRgEJTovA5EGLgeRqhfJeE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FQOR/i1C70E6aPfHWxYdq/EFOa4cMw60y0kWrbGzBpGmgj/q7VILoe++mao46+2tF/Tr1WkFnMB7L2k5EJiIihyp5+6CP13LiI55M8qBDgfHVipGtj4d5RT0DhkQaWSKGZ3D472ZYrkF8jlhPu4YogM+IsYNFydUt6PvF1H4l/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCo87NKn; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4317261a12.3
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 18:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708484278; x=1709089078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiOncSV9yT9HZiAjkpLU1vUm69RWMLdc98c4JFmhts4=;
        b=HCo87NKn+o3WNR5LjY5yu7Drl6ds44XiV9IlfftwJymNbG2x8ow/cl4jmY9YQGTf+o
         x/r/q6GQKvaIAdCYIA6zQ7WakNVTUCvV0IZi/qr/gZ4m+RX2yjvpklOWHA7Z+GLKZwMa
         U5Rv3nhEoyHYnBOB2MgOTUa/vBBs+EM2DiFjeZYwVCXTNDsKgzaIwuCXZuiEN1rYQq2H
         CbFsUi+TTViDAjsq59F0wrwtjgt/UwPSiobMDIPx62HND6UKHqX5fkY9Ey/Xhp/k8cQU
         Awh4xecg/BVrUcZHY+ODbw8/DbUenX9C7JNDtdqShTB3ZtE355oiCa88zWZcfQ9CfESM
         pPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484278; x=1709089078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiOncSV9yT9HZiAjkpLU1vUm69RWMLdc98c4JFmhts4=;
        b=rYaYSilUEwMP/DTROC7dQ8mgnnxRDgFqRpdfsbJAgqhFLzKnUBDDdmyeBxOo8hmsYm
         HHR304UMFE65S+t3xm2phW9eH8HWy7IhSj3byxFFxKuykBTM5ejWjG3DdN1QEnfFvOl8
         h+135W5ZdM1l0Yn6fiJWN8wIelRoZK/VwQi58udtUfRmmDi5gkNChDMhP3OFANbWMXHt
         Gp5+PfD+oXQac1vEyM+41MKJrxThrQEt17aFYQhV8Oh9ONXaihwqU0Z31Rkn4rlvtN3y
         dwWAxZk1iUQIwRtW3pY7o3/lY6jSdi1A2zBt77hnI1J14l0gcpitZrFB7UAa6N3eknex
         6VwA==
X-Gm-Message-State: AOJu0YxHKDn8+7KqJ3yq9QeFmvRm1LNAYUT0d/bxAqyM1rovxq/xnlkV
	XbcQUtCDhwd1GSupNvH6SDM314sMtrxwykOLBElUJ0rAXP0y1V60
X-Google-Smtp-Source: AGHT+IGJk8G0pMliNiJ4/YQGHx/s5daaImkUI0jtyjvTI/TfNTiHd/PmaCDrKuOUjNueDBMsuLLMQw==
X-Received: by 2002:a17:90a:d243:b0:299:9ba4:abe6 with SMTP id o3-20020a17090ad24300b002999ba4abe6mr5905687pjw.46.1708484278178;
        Tue, 20 Feb 2024 18:57:58 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id pv14-20020a17090b3c8e00b0029454cca5c3sm426467pjb.39.2024.02.20.18.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 18:57:57 -0800 (PST)
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
Subject: [PATCH net-next v7 03/11] tcp: use drop reasons in cookie check for ipv4
Date: Wed, 21 Feb 2024 10:57:23 +0800
Message-Id: <20240221025732.68157-4-kerneljasonxing@gmail.com>
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


