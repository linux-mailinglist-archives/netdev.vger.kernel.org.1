Return-Path: <netdev+bounces-86060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCAE89D65C
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 12:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D55D1C21D15
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 10:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49F48173B;
	Tue,  9 Apr 2024 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQfZHH7V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FDA81723;
	Tue,  9 Apr 2024 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657439; cv=none; b=TxxJH2RTO+7L5q/mzq8doNvi+qHWPhQmOrxKee3TRMzqyTuexHgIrgwbhAip3gCrsa9HfoJLJNEZF0ZHjayoHuMXlu5QJhahIG7K56QPRukPZbXlTi6WF7yZORXQENhH335mLpmB+MfxTQS4JTMhbVIRMGCACfJOrSqnVfwZ4MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657439; c=relaxed/simple;
	bh=vR6kbHqFQ3srkxogKcDP7Nt5k/mLa5xmK4UC1zZj96o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hlIwbT46r+i6eZ2MCuPTJcwR3j8PxGXbeWpfGU0MSX6IoxJEyxFRhUQL//o074N1Vk8Uu7GQWBASVT3TzC6vd67O4jkB4yOc6avijA8YCsms1QhYfz/BgdduinToqwxG2U5q27ogu1e3UAREJQx+jHplGcU96G5Hp1Y+0U1IVHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQfZHH7V; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed32341906so1530611b3a.1;
        Tue, 09 Apr 2024 03:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712657437; x=1713262237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9njs262BXZ+KTO0nKZYKjQcAI0Rd6Xl4cj8uA5zuCE=;
        b=DQfZHH7VdBmXZXIjSXm38eTBc/PCvzjJq4ybC8aBff3urIUt0dz5T0empSHCRStzGN
         33SnA6/7AhLPiPqC1mh49OaMbE1NNhOuYHmcytMmt2Bc2JEWDvUEhpYrEeTyBH+O3Nu2
         NO6adVh0ZOCpl6ExsiVNW0K9ZQDz7b7cVR63GxRyso8/FX4eBUexfWcyyojKy8HAga/M
         d6iPg6mulDY929Y7pkEhuO0dkyPiPvTsnA0RTU2QjEGdY4vrk0xNcJRjHDmN9+W62BR1
         pfYVbV8L9ld3tSYglqiM2rh7/Cl+qGArTs73xSRoZy8DlN1q9TvZjILAXirbHVZidHei
         WiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657437; x=1713262237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9njs262BXZ+KTO0nKZYKjQcAI0Rd6Xl4cj8uA5zuCE=;
        b=OSEN7Fp4+XtUSiHIuYAlNYbJOjx1rmlh9mvrgC1ruXH46HDLRbkHg5qcu7NP7ljaTh
         5JZizqOkcZlqL8i6/Wkju/QSDVTmv7POhZ2+gCNPLoldnVr7dSpHCH/3ArHY7ZmlSSf8
         jtyL1vdbFnL87oJkDl0SLCEcoBxr9lJ+RaFsGu0YivxXrXfB6JJO0hXrDQdSb4I7Daop
         h4G22UC8x2iOFqruhQvXf9AiFDn7rlAyMttJ6iMzscnI1+6G9r/JrUpuxkKehIHxczls
         9eG6fjO3/Snmq3dS9fYq233fdncvlQ6Kea0kNFcyCxsEV/B0IgVFruSfjiEUU0LFT6Gy
         XJtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1Vuwqa3jp6p5gEBP8M1g2BgqLtxHbQutz+6rUNotOl14edg4Bkjm23MUqet6m2HdJCJRc0XG5gkXfF1S6849Y/AKea68Lkfks8yhRKVEd+/RHr2pYcz6QFZtJkuomQKK+PbKnuQ8FujWd
X-Gm-Message-State: AOJu0YxiQwP8L2mHrFLbYi5BKnLRtKMWU4FYOQ411RgY/H5I944f8LQV
	nPtoxZ6LTeWGznH3MXw3CqzNamiFn+POltYfrlTc7urYjiD6Z26H
X-Google-Smtp-Source: AGHT+IGbDsK36pQYj/QkFCTE5pr2kBpve2qdJTIHdWw40y+MVtCjE2g6UTnZJRWLuyK348NB8A+fsQ==
X-Received: by 2002:a05:6a00:4fca:b0:6ed:4288:68bc with SMTP id le10-20020a056a004fca00b006ed428868bcmr4068922pfb.19.1712657437479;
        Tue, 09 Apr 2024 03:10:37 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.26.66])
        by smtp.gmail.com with ESMTPSA id fn12-20020a056a002fcc00b006e5597994c8sm7959130pfb.5.2024.04.09.03.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:10:37 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 5/6] mptcp: support rstreason for passive reset
Date: Tue,  9 Apr 2024 18:09:33 +0800
Message-Id: <20240409100934.37725-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240409100934.37725-1-kerneljasonxing@gmail.com>
References: <20240409100934.37725-1-kerneljasonxing@gmail.com>
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
 net/mptcp/subflow.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ba0a252c113f..4f2be72d5b02 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -308,8 +308,11 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie)
-		tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	if (!req->syncookie) {
+		struct mptcp_ext *mpext = mptcp_get_ext(skb);
+
+		tcp_request_sock_ops.send_reset(sk, skb, mpext->reset_reason);
+	}
 	return NULL;
 }
 
@@ -375,8 +378,11 @@ static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie)
-		tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	if (!req->syncookie) {
+		struct mptcp_ext *mpext = mptcp_get_ext(skb);
+
+		tcp6_request_sock_ops.send_reset(sk, skb, mpext->reset_reason);
+	}
 	return NULL;
 }
 #endif
@@ -783,6 +789,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	bool fallback, fallback_is_fatal;
 	struct mptcp_sock *owner;
 	struct sock *child;
+	int reason;
 
 	pr_debug("listener=%p, req=%p, conn=%p", listener, req, listener->conn);
 
@@ -911,7 +918,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	tcp_rsk(req)->drop_req = true;
 	inet_csk_prepare_for_destroy_sock(child);
 	tcp_done(child);
-	req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	reason = mptcp_get_ext(skb)->reset_reason;
+	req->rsk_ops->send_reset(sk, skb, convert_mptcp_reason(reason));
 
 	/* The last child reference will be released by the caller */
 	return child;
-- 
2.37.3


