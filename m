Return-Path: <netdev+bounces-202608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EC4AEE57C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C123BC3FB
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C8B295DAF;
	Mon, 30 Jun 2025 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="vFQimYCk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FA1293C6D
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303853; cv=none; b=gRUkJi6cRQ6OVwW/JJ+Ja2XlfsNaFqoTHT+gutrNvNCjB3Jl34cKkAxXc9bW70/z1GrWqGzIeE3hanNTStJuGq4WTNJ/6HuOnevouBuehucn1oXlDZtp+vD5ijlsw/lNBnILH8nWOmPNNuzoxC+VBRlAK2rlNetMf0t1tTk7F2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303853; c=relaxed/simple;
	bh=e8mBfD/Mf3WsGUcN/cZCls6eAizCzOkMUL7ooN31tjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEJP7vryKEd71CxhRynNkZXbraybGmwLdDFTPOGasReJCTfHXlxENTZPRAy+6rvO7tncTWDyc+YxBeZeHuce/E738lx6qMruTmmUvsyp8vhdg8b6U8Epj8i3BSfWAvTr4TfBOP4HU5BEnEgyNn9jjfze6w6qY9McqJTbw99i/jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=vFQimYCk; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74b013aefbdso237850b3a.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 10:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751303851; x=1751908651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RahNzvE7Os+o3No4Ak4PR/YrMMvz2u9H0FwyM+5TYQY=;
        b=vFQimYCk5dLap2P4wsfAVEL7VZZrSAtdozcBrwf5vV+xoX8RBh8PniMC9DvuDEno0F
         HDrnhs7AuKAB6CEDpRlc8aJOUuHr7V6HMQMqiRA3/tv7hx7Cec7/L2TJ5Ur4k9MqopVH
         +oMmLGmLcXMTLEFZa38jl4ewdF3Mbr9Sj8jiVCFjZ9AXQ7Y7jDy1DUm3mq3UAQfSxNzA
         0zz2P8APmzyvG7OU/tJAHxLy3mRbqrbcm1XnmPW5uDdMEbNiHJOgBfk4dayawqZG7hP8
         lQ5pu6ZBOqoqRTWxgCQ84Cx+/27H3L/OcOFd3br2tiFo6SKvKi7AjBksTTRV7ojIgrjh
         D+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303851; x=1751908651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RahNzvE7Os+o3No4Ak4PR/YrMMvz2u9H0FwyM+5TYQY=;
        b=JnsHTuH7tJb7DQczH0L4WKXMfDaX7EKIL8r5XK+vtkACKzw9pINYucNyXmt1qvnVkJ
         dhCCaIzwdexR9JMKT/pMxAPDlCmKW84LYMykG5hbt3Z/3FzdZimjc8y6GweCWVFs2Y4i
         8/8MshpUHrfwV0gsGLHbpzsRBumEFiMrmtHd6LG6zW2EbPAIFHbGEbWfGU54uAFQ/uz8
         xv4fDw0U6OKGc7Xeb7xgUi8hPWDvm+25g4HiyC1cgmBGE6tqYcVEYSOyQyOUQlWaO184
         nVRaxYSYvF4+RVnSIjfjWLDYYGZM3iZKa3mvMBxqL+ZnflmIc8e8wzi1b9XneXUYKB29
         Esrg==
X-Gm-Message-State: AOJu0Yyeob4luQ4H+q42NWp9WDAL6H/PBYuRv/zNILxAaF469h5T281r
	efkLRwtEN2OhhN9WQz5XPreYn65pjDqdncr0jNtvpUUqnb8NyzgL80kTpXxZ1noFFJFGvS7sw4O
	H93tBaDQ=
X-Gm-Gg: ASbGncvUK45pGps3rolVNaHe5pmIhSnvEPTd11y/TrdHUN9a0LNxE7FQNlt8NqsVbuc
	dcrn2UDQbkS15oQd7aZBHOsmIuvSM4oaTieylC1eulLp33cDJNTkjXbCFfSnX/UwmkuIlOxPQFu
	GyTA5Xcxvs0DTFVqd27nrFylrt8NitcjPbU6ju0I1A7T7O8yIlTs1a9q65Yx/LyubIIxnYqEVSs
	saCT91g3N7vvPozgp2HPHmOQO6yjQ62lYZf8KUmnJWEseZTY1nAyCYfGGk92o7zA6d7i8T8oPmN
	n1PGFRY/Gx/h4Y6ks1VaNAcIabM7UFbUIEcMQNYQTxeB4YSmAw==
X-Google-Smtp-Source: AGHT+IFGNjjJIhVkPG/QQMfVQcXOd/Ojx6HLdpOsBFHvjK1apNAW3lIOzGfCBb8CFbFyZqj2wR3NIQ==
X-Received: by 2002:a05:6a00:340d:b0:732:18b2:948 with SMTP id d2e1a72fcca58-74b0a4ed5f8mr4967622b3a.1.1751303850681;
        Mon, 30 Jun 2025 10:17:30 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:9ab8:319d:a54b:9f64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a846sm9229232b3a.31.2025.06.30.10.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:17:30 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 03/12] bpf: tcp: Get rid of st_bucket_done
Date: Mon, 30 Jun 2025 10:16:56 -0700
Message-ID: <20250630171709.113813-4-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630171709.113813-1-jordan@jrife.io>
References: <20250630171709.113813-1-jordan@jrife.io>
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
index 565afaa1ea2f..8a1fd64d8891 100644
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


