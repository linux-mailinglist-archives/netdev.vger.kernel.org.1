Return-Path: <netdev+bounces-72804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 506A0859AFE
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AECF281723
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 03:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594DC46B1;
	Mon, 19 Feb 2024 03:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmcMmUBx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DA953B8
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 03:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313368; cv=none; b=hecdVibUqC2HM7jrZbkcBZA5+5ZPykeFlm4nnQtEaMKmitiQrMpGeC+tugCdr+uXsV3VAY7ixGNZPKppptzUGASWIhKW0wqwM2R2YqmkHPHHiSNz+UZCJMTPhtHUMG9RFPRwYgtMiayyLH9NTOYibN0UtxEua7vLgrqoQXbIqyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313368; c=relaxed/simple;
	bh=vrwHOQrkYWZJHHyBK1czZNZtq4kCFj/6UeI03PC/L4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tg5s9xkF2OmEB3Vih7kA0mjLDvH2hU7OnMQdunuswy2UXlBla7Wqg8b+M7xrgGHWC5Y70Ezp2Z9TE4Xt00u3rML/iV1lbrM31yqpc+pby93Aw3ijS8/GtrDAx+xUcHH29BhxGlwVciMOBhiczViyLT64gpG54F+dTPKsInEbDNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmcMmUBx; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-53fa455cd94so2798124a12.2
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 19:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708313366; x=1708918166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8iqFTRpqy3PRXp8DiJCTCYAi+UJa4eByPGTpJmMuc4=;
        b=BmcMmUBxkok1ZFREUWwu1pWX2a9NQiEkdWla0gOflfUdsJsS42qhZAJhA0J05fxmDV
         6pg1hG95t22Fu8sRqDIKFZnCaBK6Ay3sQc8oMXWnArZ5tGz3+gone0682b6mrSoiU0DP
         NyyEAT6aibwTz1tXwxtGmoOt3BD+9LizEryQatRaSOxs6dA8PSEjeRp8wrXYviDl+5Z5
         IOt0eHVSpQVXeHs41IZuOPtbvEbDW8zNFfu3He+qLaEq/GmncwGFkmhJRObUEhhrDpW+
         g7SAvfyVEn3LeplpKMw1Lzke5CnqtGoIgv6577ov4wmiToPrOBycWlbDKwKUjWdnyl4x
         taiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708313366; x=1708918166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8iqFTRpqy3PRXp8DiJCTCYAi+UJa4eByPGTpJmMuc4=;
        b=T+ucUzBplxlxN0E5iFJtIWaKTDXn3KU1Rp4e7kclCkx/3glhB0w+RLbC+R9UHTf2vF
         JkaAMBJ7xwcRi7yT3nitL5W7WIIOSWGM0dI+6ySw+3doGNdWky4nVSxt1poXfDL7Ymsi
         aPVYammw/LefbhyJU7wPr5yqPajJ/saAutZ8TzbK31GcVOrcg+kkv14OISt0vrSnFnHh
         1zRxyKZufNVWvpTIg/GLHy16y/EGeElOMEzV50WFQ0tLS7dK9z5X0UgCmkXSWLXMbzDr
         wV/59ocDarkTxTT08bjVOsIX5aD2neWVUOqrTinddb00ODYBIOwR1ctEdFwA6ScnFgwP
         JAtA==
X-Gm-Message-State: AOJu0YyYf3qLTvSw9W6oSTb+B358PaMbKKr9rptnUZz7Pk9pH29Tfsvn
	HiLW+SRRQY6UkYU0w/R61de7yaZ6NICdTWXZ+9nStiseRD2mc2Pr
X-Google-Smtp-Source: AGHT+IE7PSEyZeINFR6CdsZIBr3SDdrlVHCIhkAYtjp4kdpK1Vo9rLU4JAsOk05/YFGCsB+080lwbw==
X-Received: by 2002:a17:90b:304:b0:299:df2:66b2 with SMTP id ay4-20020a17090b030400b002990df266b2mr8312086pjb.22.1708313365802;
        Sun, 18 Feb 2024 19:29:25 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm3968921pjb.25.2024.02.18.19.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 19:29:25 -0800 (PST)
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
Subject: [PATCH net-next v6 05/11] tcp: use drop reasons in cookie check for ipv6
Date: Mon, 19 Feb 2024 11:28:32 +0800
Message-Id: <20240219032838.91723-6-kerneljasonxing@gmail.com>
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

Like what I did to ipv4 mode, refine this part: adding more drop
reasons for better tracing.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
--
v6:
Link: https://lore.kernel.org/netdev/20240215210922.19969-1-kuniyu@amazon.com/
1. Not use NOMEM because of MPTCP (Kuniyuki). I chose to use NO_SOCKET as
an indicator which can be used as three kinds of cases to tell people that we're
unable to get a valid one. It's a relatively general reason like what we did
to TCP_FLAGS.

v5:
Link: https://lore.kernel.org/netdev/CANn89i+iELpsoea6+C-08m6+=JkneEEM=nAj-28eNtcOCkwQjw@mail.gmail.com/
1. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket allocation (Eric)
2. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
3. Reuse IP_OUTNOROUTES instead of INVALID_DST (Eric)
---
 net/ipv6/syncookies.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index ea0d9954a29f..8bad0a44a0a6 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -190,16 +190,20 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		if (IS_ERR(req))
 			goto out;
 	}
-	if (!req)
+	if (!req) {
+		SKB_DR_SET(reason, NO_SOCKET);
 		goto out_drop;
+	}
 
 	ireq = inet_rsk(req);
 
 	ireq->ir_v6_rmt_addr = ipv6_hdr(skb)->saddr;
 	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
 
-	if (security_inet_conn_request(sk, skb, req))
+	if (security_inet_conn_request(sk, skb, req)) {
+		SKB_DR_SET(reason, SECURITY_HOOK);
 		goto out_free;
+	}
 
 	if (ipv6_opt_accepted(sk, skb, &TCP_SKB_CB(skb)->header.h6) ||
 	    np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo ||
@@ -236,8 +240,10 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		security_req_classify_flow(req, flowi6_to_flowi_common(&fl6));
 
 		dst = ip6_dst_lookup_flow(net, sk, &fl6, final_p);
-		if (IS_ERR(dst))
+		if (IS_ERR(dst)) {
+			SKB_DR_SET(reason, IP_OUTNOROUTES);
 			goto out_free;
+		}
 	}
 
 	req->rsk_window_clamp = tp->window_clamp ? :dst_metric(dst, RTAX_WINDOW);
@@ -257,8 +263,10 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	ireq->ecn_ok &= cookie_ecn_ok(net, dst);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, dst);
-	if (!ret)
+	if (!ret) {
+		SKB_DR_SET(reason, NO_SOCKET);
 		goto out_drop;
+	}
 out:
 	return ret;
 out_free:
-- 
2.37.3


