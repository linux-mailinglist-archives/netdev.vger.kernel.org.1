Return-Path: <netdev+bounces-70861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A18850D61
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 06:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ABFA1C2199C
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 05:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD3515AB;
	Mon, 12 Feb 2024 05:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tak9pXDo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2D86FCC
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 05:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707715553; cv=none; b=O9vMcbCRxIcZbqQVJtl9EWzt+OAbQG06qZofHd8slDRBu3kXuB5Ce34hf1zpS+dCyGyReInhke6PDZ///FSyWZKTmPE5vHqNvXMnyPhcFA7ONLkrE0GH2B6ti7M6pVwDUVoOfyMr+8E8HzawbRgGZXROaol0tsCafUbQLzulIrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707715553; c=relaxed/simple;
	bh=yw9I8eGn8fij3hXGVhqq+QyJ/i6Xtww0dNZKPdMaFzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I64ntUBbnB8bX7jw9kGhWl7WFDe+bq5eavP1o+7xO/iCUFjO5VgnTMZiWjYwXzqVcwqUBCN9ryGwIcFsx5m2/t6ZR5MU13PP1sHHDc4V7uBj5Jxf0skxjvHlqOiCkArsfMSgOs6SWfbM+om2xfxLZhi6KPP6IDbaUyNDti4+yFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tak9pXDo; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e0a4823881so569061b3a.0
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 21:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707715551; x=1708320351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCokI4QitffRE95xC4BZDly8mc3aT2cSBYL5RktaTi8=;
        b=Tak9pXDoQNFc2u5ZgVzcxzIBlis+OnTMHT7HgVzfTN4U99CtUkzAbpoYUyyW2G8ee/
         mfmL07hTj+zmRmCtPG4Sq2AME5UgG0QVZ4qG8ZUbI1WCVUAAGNk9Pifm1xuHRiidf7Q5
         UW9YGU39vInbz1jcP2JMwTkMN1rlcG6UvvErLUqmhCNmPio1RVujo3zingapoqp/3UaR
         1ogmOUTYlEK7xmU64KHmEMQp6NDljIpcHdH1QEVJeCS47X32QfFxwz/tTDSNh1aKAMuE
         UHRSIqd1C+S5ndjJQwWO4Gti8PrSF98ff3/UEVxVdItryz4ZQZfVIID3XI2SRgMgz2CK
         KHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707715551; x=1708320351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCokI4QitffRE95xC4BZDly8mc3aT2cSBYL5RktaTi8=;
        b=LzGmM4kkEAeoktotMcib1n1166c6cmVPIoRS1KpwcxFRSqt9+3Ndf9IHxzLdDJF68n
         NIzzS16MXJfobdHpTwEzJX2nzKzNofSRaOO/eJEtfbsICk45DKpc6Bu1Yyc10Ki86Zpk
         oVFdY5EE6PNB5OIhQEcMKB8vb7YMdNtIEAVgeoU7Myg7iCMteJNogeqZfETFhLbRuBsE
         v+2TAmxkV8ow6kqBRNpg3AgwGLFPReZsC30cxrEVS83/U4IaQnOwMZMPjlSSjbAPSGZb
         FmyHOLlOPYx9gIcwS4U3oIE4BNHE4jH/G9FI8ZOf6OKkitqUCXHWByXnqMLAOtptmn/D
         ce6w==
X-Gm-Message-State: AOJu0YxvS7djnpnOTFEKMrDZTe/F03CEcdkzJ5K/1p0sWkAgwoGSfT+J
	pVy6yPAf3HpY1+um40onsjjJ30bM6ld9qoF+E27EbOkm1U083qCJ
X-Google-Smtp-Source: AGHT+IHXQZodQpi446ybjhDdvaqQX5tOIYwBDAkL+MLXGW6W3zEAUT5wB25k9ZjPENBxdBmwAjKjSw==
X-Received: by 2002:a05:6a00:9384:b0:6e0:9da7:8cfd with SMTP id ka4-20020a056a00938400b006e09da78cfdmr6255176pfb.5.1707715551146;
        Sun, 11 Feb 2024 21:25:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0IBdMComcxENuIg95YkFSH3GDFR/PiQg1au1W/v3g2Sn2S5dlIDFDUUkPkOhjU3WkDO2iQfTpERScwSzLusMN2SvXymLuR9pWZbwdKVboEvv8+bjARUkWzNmmc20iXTtb3ZDQCJd1U123UvHBdwGcPfSWrnvjYnGZadpfasA03IDR1xq0YFKxaODwt+sxKzQ8yknxZt/W/kHhR3zUKw5i0qNusNXZjww07dAd8ws=
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id f10-20020a056a001aca00b006da2aad58adsm4725291pfv.176.2024.02.11.21.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 21:25:50 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 3/5] tcp: use drop reasons in cookie check for ipv4
Date: Mon, 12 Feb 2024 13:25:11 +0800
Message-Id: <20240212052513.37914-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240212052513.37914-1-kerneljasonxing@gmail.com>
References: <20240212052513.37914-1-kerneljasonxing@gmail.com>
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
---
 net/ipv4/syncookies.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 38f331da6677..07e201cc3d6a 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -421,8 +421,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 		if (IS_ERR(req))
 			goto out;
 	}
-	if (!req)
+	if (!req) {
+		SKB_DR_SET(reason, NO_REQSK_ALLOC);
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
+		SKB_DR_SET(reason, IP_ROUTEOUTPUTKEY);
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
+		SKB_DR_SET(reason, COOKIE_NOCHILD);
 		goto out_drop;
+	}
 out:
 	return ret;
 out_free:
-- 
2.37.3


