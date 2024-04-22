Return-Path: <netdev+bounces-89917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505DC8AC2E4
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 05:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065A41F2102A
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 03:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A806AB8;
	Mon, 22 Apr 2024 03:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ8N7lPK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FBFFBE8;
	Mon, 22 Apr 2024 03:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713754901; cv=none; b=reSY739CV9AafppY+tqnmgH4gQPGIKFF8faCzWgWbSqjI8uOxkFvUMaDqQxkzsL/DbQFCv0YXzmKLf3oMsDgeucb+uMhZ9YkMuRIEiBPg4VOF/C9I2o4QBPKqcW8ZhJ+JKKrtOEd7De3/efWOL9kiBx5W/cE2euCTY7vXsfXLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713754901; c=relaxed/simple;
	bh=WjxyLjN2XXFGhBWrou1hHCduoG9kiV4eYSnQy4H1J6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YXmd/LarDlC5I/8zhvZr9E1dqFSQ1ES58J6bt/B9r8ZsEsxYVK+Ybig6Os5jvDpMxLDxTQDpG/OgOgxiSolzADACO6UMid8CQDzur/cAi0tZGecm//3ffX5iueMZKjS1lozNXrq3QYzRa8INNSf3ls28A/HQdLGPnc1Eepud0fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQ8N7lPK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3ca546d40so31910055ad.3;
        Sun, 21 Apr 2024 20:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713754900; x=1714359700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYeVVW3LSCqlYGBsnga3ls9vjokc9ozCT9CspXhLgec=;
        b=TQ8N7lPKX0hIpgqb4oEqjbLvzuWFz1gab4toh1Jd/ul/mA3fUZbK6BKp0Fsv3BumtK
         6+4k+T8RLGk5IuaEwTKLEmiM2w5EwZBqd92y7vLHzhvL1T4ct7Q0RGGdPXZnBMRqQVqu
         c7zV8DjOeoJ+8MGhrAWb2P9pzXWGF1KCU7E5dN6oRLFiyATYoBbNKvTMGKXdMiqrjL32
         n53GxkcAfXfbvn5v30pNQpj9otHNI0Ndd/DR1kBdENvBI6/qTAWqgDm9rqZracMwIpss
         +X91RXM11F/8cUiVgSmYeU+AKuWq8yVA6wDkX8sPX/KBsyd3nrUPNv0FRsQV6+yLHnZH
         HI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713754900; x=1714359700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYeVVW3LSCqlYGBsnga3ls9vjokc9ozCT9CspXhLgec=;
        b=DoC1qw30Q94xQUovqkhLhjwS7uJWv7DTAjNodCqyb1RPi3UF76Bn/sSpe3yBHZoEVk
         ge/QEW/vsuV5e5yABPFZuBkJU0vWhQG3fP65NQ1t7PdOqi6W9mo1HmWC1QhVL4f8MH3g
         RDOrS3aSOuZ0A244adaYhhg4s7lqJVb/n7SPeOPnJqBJMBNiUIw/cRE5ikoVJQcwKDhW
         FiLZw94yI0jBR8VDSSpoX3tjS9Iv/7Srl0Lq1Hpe2k12J3xiY2MraW/kQhdV5v+yVGHL
         bWk088gOYViXtMzjHWMk9ojyVpUGn7CMcfNHfTkx+4epzQwMvzuqFeY9P2VejteM3pjK
         lK7g==
X-Forwarded-Encrypted: i=1; AJvYcCUI7gLr2nsrqZh1lT457PjpZIqGKRcQE31OJ+MVf273arTMlEayf8WhH/tW+HKNWOfg6Rzi2Djy3OdQykIa9Lz2faOyO2tURiJbWM34eDf4Pt11x94x1vq4YkFIuD0JZKZoST+odmmeH8PH
X-Gm-Message-State: AOJu0YzGFcfB06QoPDtgwCen5PiKGmZqoflJSjAmZ+/UbfZTXb5CFNeE
	OmJszbTZBcTbHCC+S4BOqdTLpKUpwAPfiG3XAQXI1ebUaYB6XeT1
X-Google-Smtp-Source: AGHT+IGV/c0wsMeQPxLO95FLc5z6vYhPP780ckEi3E8GQHDURTGIlWAooKM5o99muZb1LR2YpdZU+Q==
X-Received: by 2002:a17:903:22ca:b0:1e0:b2d5:5f46 with SMTP id y10-20020a17090322ca00b001e0b2d55f46mr10230874plg.46.1713754899605;
        Sun, 21 Apr 2024 20:01:39 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d60500b001e421f98ebdsm6966009plp.280.2024.04.21.20.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 20:01:39 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	atenart@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v7 5/7] mptcp: support rstreason for passive reset
Date: Mon, 22 Apr 2024 11:01:07 +0800
Message-Id: <20240422030109.12891-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240422030109.12891-1-kerneljasonxing@gmail.com>
References: <20240422030109.12891-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

It relys on what reset options in the skb are as rfc8684 says. Reusing
this logic can save us much energy. This patch replaces most of the prior
NOT_SPECIFIED reasons.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/mptcp/subflow.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ac867d277860..54e4b2515517 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -309,8 +309,13 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie)
-		tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	if (!req->syncookie) {
+		struct mptcp_ext *mpext = mptcp_get_ext(skb);
+		enum sk_rst_reason reason;
+
+		reason = convert_mptcpreason(mpext->reset_reason);
+		tcp_request_sock_ops.send_reset(sk, skb, reason);
+	}
 	return NULL;
 }
 
@@ -377,8 +382,13 @@ static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie)
-		tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	if (!req->syncookie) {
+		struct mptcp_ext *mpext = mptcp_get_ext(skb);
+		enum sk_rst_reason reason;
+
+		reason = convert_mptcpreason(mpext->reset_reason);
+		tcp6_request_sock_ops.send_reset(sk, skb, reason);
+	}
 	return NULL;
 }
 #endif
@@ -783,6 +793,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	struct mptcp_subflow_request_sock *subflow_req;
 	struct mptcp_options_received mp_opt;
 	bool fallback, fallback_is_fatal;
+	enum sk_rst_reason reason;
 	struct mptcp_sock *owner;
 	struct sock *child;
 
@@ -913,7 +924,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	tcp_rsk(req)->drop_req = true;
 	inet_csk_prepare_for_destroy_sock(child);
 	tcp_done(child);
-	req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	reason = convert_mptcpreason(mptcp_get_ext(skb)->reset_reason);
+	req->rsk_ops->send_reset(sk, skb, reason);
 
 	/* The last child reference will be released by the caller */
 	return child;
-- 
2.37.3


