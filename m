Return-Path: <netdev+bounces-205576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE701AFF523
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 01:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411464E59B4
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 23:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDD424729F;
	Wed,  9 Jul 2025 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="exFOUH79"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC115246772
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 23:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102224; cv=none; b=AptVnFwskkcklOO5/MPXBadxXSWhpwz7D8q2LqBBzSkt7gnft7WIlsx4Q1aaNJMbaLrdnDaYdUwAYzS2JuzBmkW+RFyJOZuwhk4PefQU/YyoSQdlt983IUQzERP6cUUcyCV3hpAe8zQYDQQZ5j3VY24xTy2VMoBXAicu0xse5AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102224; c=relaxed/simple;
	bh=+RKf0LxsahCX0ru/helpwnqrzojewAmbV20fE5ht/Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9HSLB4WAdApqoO8XA7bwYcz98YqOR5gBQLDC71M9Dp1EEhL+mmfglXtUcPi1kZXhqcpTsQxKtC/654gVyLtjZ4VlE0FzPYFyaxKU/kdiVw1WVLedG2bDLjrENk89Y9rCPcjdVpFA1RbIHqrCbdB43vSOnhhKV14lE/tOA+BX1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=exFOUH79; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b34b770868dso70349a12.2
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 16:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752102222; x=1752707022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAN5AN0xB7TXy/kniPi44+90iocjGvN8izS4op7BZfg=;
        b=exFOUH79PgryF662b4qpEdWmg+J66q3686VukBs99XE//51g2QQYyB2Qksz6FDeLze
         x2YPvrSpCN3Sm17DbJ08cqGN048Wvw5F+EGyki/DzsarrgHJmRai8k3sSkes3gotmAz0
         J9MGP6Nk9jVa3jCJYB5hkwqB9ujJP6F591MhrpaEdeJxO77clA1HUokh/a75qCPloceE
         yu5MBAuIcONTFW7wlZd/nj9d8j3uyW/KJ0H3/x4J5JjT8S0GsZTzd5JOS2v5/9h3qeWe
         qoBRj4POYi+6KV/Y0Im3kI4TXPT56B/MY+dVkleHeKLGkAtOoSxfEZwpvAmx7H8o8J8i
         7L2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102222; x=1752707022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAN5AN0xB7TXy/kniPi44+90iocjGvN8izS4op7BZfg=;
        b=Ma0GYIjuYFXkxXsBadLs4TrouKbylj+iuDR6KL574ie457ViAC8pvPC/YgfCyFFgjT
         1XILXGE2a40ehYSf0y6GaqKAapwNcQOJ7GoygbaW1T8vcecBN/9ZIqSlKa/TfBRah7VY
         DBTMS5Q+Mi2BVFBchMlJJQsmz+as3NN/jDBkzS3iHY7SoMCqjwh+xoBCUUWYhW93i4Uz
         xjaDlt7AWqNDseiIYCsunq8sGqEKqd/mjZz2uJv3DFQ3RIba7i3f6payFo+/SLGdsN7a
         wtEefUagf6ygUts/U8nMi5h608MXHwjI8wo6BTL9mOEnV9Cs6B0XXu3YPMgvCm719JsG
         BFGg==
X-Gm-Message-State: AOJu0YzpfBmqWOp+y69i8odr+wbBj+JYbQCUS6IKvgFpj6pemTbE2WVw
	Vw9mKIAtClx2YsuBmjw0xusE6QpD8tT3BPvsxbjnpRytvYMOGLuoJ1p8kLp5yjE14Qa8OBaspo+
	Hwr9S
X-Gm-Gg: ASbGncsoN4YUgmXQqJn+f6lV6Bjx5vqwG/yI7av9Fv448qJ2hlE20pw4jkDpB2ZCrSJ
	P77u29gLp1JjssojaRPJzOSn2d2JTZlpudKL+XHC5/jq7oLftawrk3f5jOa1QX1arl+iDP4Opry
	lw9O1AarGb2wQpM9Gt6XHTLMS8z3832P8BUjMlGDXr6kO/qLKQJU2w2OLhdROCSUws1XY5mRslM
	K+3PXF5ZZTsB3Ti808shmMObGOp1A5IFWv1912V/Hi9L+6ztgBBGD2xIGmUzB3w4ytcaJsk7DwI
	+XnO/UesBKs9Y3P4Uy+h2vpbkiMeIV+9l0V2p3mZIpjL6Eec6Ww=
X-Google-Smtp-Source: AGHT+IHSoJwzENzTIfZhllIBHiecT93lNyBcFcvHruQHLyq7n/zbrP8I5l/7X8R5Y/tmlUtHXMQgCw==
X-Received: by 2002:a17:902:f543:b0:23c:8f17:5e2f with SMTP id d9443c01a7336-23ddb1a6058mr26803935ad.4.1752102221585;
        Wed, 09 Jul 2025 16:03:41 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d121:1d56:91c1:bbff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad212sm2679015ad.80.2025.07.09.16.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 16:03:41 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v5 bpf-next 03/12] bpf: tcp: Get rid of st_bucket_done
Date: Wed,  9 Jul 2025 16:03:23 -0700
Message-ID: <20250709230333.926222-4-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709230333.926222-1-jordan@jrife.io>
References: <20250709230333.926222-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get rid of the st_bucket_done field to simplify TCP iterator state and
logic. Before, st_bucket_done could be false if bpf_iter_tcp_batch
returned a partial batch; however, with the last patch ("bpf: tcp: Make
sure iter->batch always contains a full bucket snapshot"),
st_bucket_done == true is equivalent to iter->cur_sk == iter->end_sk.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_ipv4.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 8dfb87be422e..50ef605dfa01 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3020,7 +3020,6 @@ struct bpf_tcp_iter_state {
 	unsigned int end_sk;
 	unsigned int max_sk;
 	struct sock **batch;
-	bool st_bucket_done;
 };
 
 struct bpf_iter__tcp {
@@ -3043,8 +3042,10 @@ static int tcp_prog_seq_show(struct bpf_prog *prog, struct bpf_iter_meta *meta,
 
 static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
 {
-	while (iter->cur_sk < iter->end_sk)
-		sock_gen_put(iter->batch[iter->cur_sk++]);
+	unsigned int cur_sk = iter->cur_sk;
+
+	while (cur_sk < iter->end_sk)
+		sock_gen_put(iter->batch[cur_sk++]);
 }
 
 static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
@@ -3161,7 +3162,7 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	 * one by one in the current bucket and eventually find out
 	 * it has to advance to the next bucket.
 	 */
-	if (iter->st_bucket_done) {
+	if (iter->end_sk && iter->cur_sk == iter->end_sk) {
 		st->offset = 0;
 		st->bucket++;
 		if (st->state == TCP_SEQ_STATE_LISTENING &&
@@ -3173,7 +3174,6 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 
 	iter->cur_sk = 0;
 	iter->end_sk = 0;
-	iter->st_bucket_done = true;
 
 	sk = tcp_seek_last_pos(seq);
 	if (!sk)
@@ -3321,10 +3321,8 @@ static void bpf_iter_tcp_seq_stop(struct seq_file *seq, void *v)
 			(void)tcp_prog_seq_show(prog, &meta, v, 0);
 	}
 
-	if (iter->cur_sk < iter->end_sk) {
+	if (iter->cur_sk < iter->end_sk)
 		bpf_iter_tcp_put_batch(iter);
-		iter->st_bucket_done = false;
-	}
 }
 
 static const struct seq_operations bpf_iter_tcp_seq_ops = {
-- 
2.43.0


