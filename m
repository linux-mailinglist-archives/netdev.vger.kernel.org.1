Return-Path: <netdev+bounces-118995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B14A953CD4
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324431F241B4
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1C814EC6E;
	Thu, 15 Aug 2024 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR1ZhJ4r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547671514C8
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758106; cv=none; b=kqF/z+b21PT/L75z1+VgK/f1nfGr4OMpzI62PUvkbocTV2X0OBdPuv/mYoPzeNzWYc3r3WQScsK7F/MoCmZtq6WAKlCzGsV8GWolOeTd9AhfAqLM+HwioX0RVGRt7DOrdkgHma3OIk78naxbPcSIRnH7gMiHIgTUY7aUBNEVt2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758106; c=relaxed/simple;
	bh=GGMtPrAVGvi2K/4qPq/ljnpN+pRfL5lsV5NlF6JMVMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7Gsaz44IaQRTNVa3vs2LbcTQiil6lqLKAMyX5n8QFMVezSLpkQu+osBVWUL0ckE9pIfBlUvUC1OopzQZjX5+FGbivMr4qp3kQ6xZivfBoa/vDniE7hhCzZj2Yl9QWmGZHZNIzx0S/GfHzkcBs5IbtaKWv2vIwc3k29uPVwXNpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cR1ZhJ4r; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39b06af1974so5468475ab.2
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723758104; x=1724362904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvPly2LZhVx2LvQ1pKkjUeoR0Rz5L5mNxo86sOIiCzU=;
        b=cR1ZhJ4rsgqiMg6BD8ZBdJigasJ3O6/YaOq72ajeiEb44obAUYa5Py0aB0sSLqx0O/
         owAZq2lzAGGdqY+QLDPNqsnSSBGFLbkgy9tp9v2tZB5ssyRVFSAdB1+s5RVmuaZI1S19
         giuRDo6bUSD8ZOiwWH4G6iWSjfhWl3wzPB5qv5Swmi8EBDeLWxwGtxLUsNMSdD8zmdtJ
         ybT1AEcS1PG99DdfMEYUHURpa/Fra4Cz8R9C0Q9q7WS6G3vhIEJ5ibWYDtcS5bXWU3nS
         7ktz6RwOSH/Y2NrBAaMDsTa1Hjow2Cb7WohuJVfCDyT2FIvgckvwha5K7R3RbTEFHS+A
         UxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758104; x=1724362904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvPly2LZhVx2LvQ1pKkjUeoR0Rz5L5mNxo86sOIiCzU=;
        b=XSXCZM9xHflgmq3aYJZG7+RqqveN7pPqBcGdK5fjiUNnnmWJKd+WLJBL3Gxl28M0wT
         iJkbaLKOM1qeoaBanlX+Q5HL8SCVfMZhBdEh40f6DmHW/vgqHjt3dVM+987vTw4Blqlo
         artmh/PXtaAfjyuEhPtoM9sqZrHNsodvqFlPSuJhi+9RR9887U9TTC0NsJVe4NzgUgtN
         8/4LYViTOEsrjWuGIQEnyLDSUiH0roKeXx1pSTVRdKCmluAM8zLD1c7yBwTi0KGVruPs
         qOyWzlgcbAs3u2HecvNxg0peYJkDKDOZJSHFFHnarEJd4pKsTW+jDKNZJgYPtOXiVyFC
         HmVw==
X-Forwarded-Encrypted: i=1; AJvYcCVpS15gtoQmc1cf6cP0qXukdCiMIoS/JWSheksu9AYnUF7XIR6TtAAyQ+/TM/Znffmzjoeuh4w4EXLnyJtjCTNWA4Dmvphq
X-Gm-Message-State: AOJu0YxU33Qkhheg+FLU09VlEMARYYGLuLjOW0bapaQGvlyojhimliqq
	gX7A3icUvyZV/J7guKfZ/RQmbPKC/Ln29sxMv5ddpGU28ocx4Tovuh2op3tN
X-Google-Smtp-Source: AGHT+IFkxUoMomrjCcrlyw2Ma1YZM1Ps9QdhhBBISPDvxIUztiFgFZzxSNqBXt9ZgsqkrjuYkbXV/w==
X-Received: by 2002:a05:6e02:1a21:b0:39a:13e3:9176 with SMTP id e9e14a558f8ab-39d26d02582mr10702805ab.15.1723758104399;
        Thu, 15 Aug 2024 14:41:44 -0700 (PDT)
Received: from jshao-Precision-Tower-3620.tail18e7e.ts.net ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d28e13cd8sm642125ab.22.2024.08.15.14.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:41:44 -0700 (PDT)
From: Mingrui Zhang <mrzhang97@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	ncardwell@google.com,
	netdev@vger.kernel.org
Cc: Mingrui Zhang <mrzhang97@gmail.com>,
	Lisong Xu <xu@unl.edu>
Subject: [PATCH net v3 2/3] tcp_cubic: fix to match Reno additive increment
Date: Thu, 15 Aug 2024 16:40:34 -0500
Message-Id: <20240815214035.1145228-3-mrzhang97@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815214035.1145228-1-mrzhang97@gmail.com>
References: <20240815214035.1145228-1-mrzhang97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The original code follows RFC 8312 (obsoleted CUBIC RFC).

The patched code follows RFC 9438 (new CUBIC RFC):
"Once _W_est_ has grown to reach the _cwnd_ at the time of most
recently setting _ssthresh_ -- that is, _W_est_ >= _cwnd_prior_ --
the sender SHOULD set α__cubic_ to 1 to ensure that it can achieve
the same congestion window increment rate as Reno, which uses AIMD
(1,0.5)."

Add new field 'cwnd_prior' in bictcp to hold cwnd before a loss event

Fixes: 89b3d9aaf467 ("[TCP] cubic: precompute constants")
Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
Signed-off-by: Lisong Xu <xu@unl.edu>
---
v2->v3: Corrent the "Fixes:" footer content
v1->v2: Add new field 'cwnd_prior' in bictcp to hold cwnd before a loss event
v1->v2: Separate patches

 net/ipv4/tcp_cubic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 11bad5317a8f..7bc6db82de66 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -102,6 +102,7 @@ struct bictcp {
 	u32	end_seq;	/* end_seq of the round */
 	u32	last_ack;	/* last time when the ACK spacing is close */
 	u32	curr_rtt;	/* the minimum rtt of current round */
+	u32	cwnd_prior;	/* cwnd before a loss event */
 };
 
 static inline void bictcp_reset(struct bictcp *ca)
@@ -305,7 +306,10 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
 	if (tcp_friendliness) {
 		u32 scale = beta_scale;
 
-		delta = (cwnd * scale) >> 3;
+		if (cwnd < ca->cwnd_prior)
+			delta = (cwnd * scale) >> 3;	/* CUBIC additive increment */
+		else
+			delta = cwnd;			/* Reno additive increment */
 		while (ca->ack_cnt > delta) {		/* update tcp cwnd */
 			ca->ack_cnt -= delta;
 			ca->tcp_cwnd++;
@@ -355,6 +359,7 @@ __bpf_kfunc static u32 cubictcp_recalc_ssthresh(struct sock *sk)
 			/ (2 * BICTCP_BETA_SCALE);
 	else
 		ca->last_max_cwnd = tcp_snd_cwnd(tp);
+	ca->cwnd_prior = tcp_snd_cwnd(tp);
 
 	return max((tcp_snd_cwnd(tp) * beta) / BICTCP_BETA_SCALE, 2U);
 }
-- 
2.34.1


