Return-Path: <netdev+bounces-186513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F51A9F7DF
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E651A839A9
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9041329614D;
	Mon, 28 Apr 2025 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="B/oGqmLN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201952957DB
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863254; cv=none; b=F0kOIhIWBBM3AVlB18ykAle/Ru1dfhFqmTxy9ukwvH92bp6TXrB9Wed44YxHU3o9QsXspQKkCwEMLXJjEoSyg5juLzrs5lp3qH41DgqAPoaFypjjcZgdAqEp1G8c3mpkFMrn2OGnyqQF0bcr6srkXuT+hvB+koivs8EVLJMC2h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863254; c=relaxed/simple;
	bh=/F3yqqMzCU5bH5/D12wYGRh+yJF+IBqELQlRUllZ0r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIIyy+53P3bKJftnfiWSb/JsegNS6MRbaN4bZ2AYjapL5V2HWa8M5U2OTlKEmBfzP6EQtu0hMYOjJm5gfImYrVNzOl14ylhtM8CkgGPTqBUH1tWmYjF2fS68ZJYksRchliLC1vSqYqCnolmw3x9vh/GtUU7LAdSauGTBZ5brfqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=B/oGqmLN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22c50beb0d5so9323055ad.3
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 11:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745863252; x=1746468052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C95FnMTfV1qMiVrhx1xJqjNUnbfjrYoOP43A6bV/8xA=;
        b=B/oGqmLNBs/V/exbCsmhOCv+HbJ/fD5H1jz92RIHyb22IJ0bhYiA0/2sMfnNr8w55o
         1EStC0DfHdYJrikGYVt4rUpzxq+3xZCmd+8pFo5Ouudhtkz8vB/KCU032jcT3wmAwugJ
         XkV/24Y5J5rLlVMw1J72yat2Clidur2rxdqOtSLBDqtNtMAIIeP0+pAa4VPcP1LcdCd2
         ez5gePvQxuKjEbA+aW+Al5tYCL5Wnp8doglJckxp/C45n37t2E9ev1PW1ecHkg3y0GDt
         mSOLz8STxmEmQ2fypascDoYfwiW4elOcXpVhq3vi7GCjmtCy76J1ZYBZjlJMpxP+US7z
         H4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745863252; x=1746468052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C95FnMTfV1qMiVrhx1xJqjNUnbfjrYoOP43A6bV/8xA=;
        b=USu1+6DdFV6+BwzfC4BrkAQQFvtDqBvhO2naLgfqtMyu1/GyyNNIaIw9vpwN07WjYF
         NLEGg72Ij2XgSSmqZG0cBknZvWWNkZ3C0IdCoYNBfXc8Ok57aHi0EcN9SuQGZTSJGFhb
         v95Gi5N6jY7GJtqbFkNxwSLgKvvdnpnFee/0//odcc67XlZRNKtPqCBvne9+2uz4CE4f
         hYaSlIAFdzVXzNMiyYdZuxuUyFyrs5WGPgs17FbzHdQQ/NS36iejG9rA2uNUv+pbzrnm
         P7/DGBBbicPSkZ4B12qZv/TN3b0OTvmKhSZI6EMws3ClJ0XP4djJUnoDOHwZVa+YsZbA
         4zxQ==
X-Gm-Message-State: AOJu0YxyirDDhHLy8adBVBKA0eplFIsn9e17avK04yfDoMys8qcNKLv7
	HvP2NSqBTi99KvN2M2vdjHkL5UU7z8QGpq30vZo/DGHqjvrATzGK5xUK3vE9MEqvHkBF45+f5f8
	jCww=
X-Gm-Gg: ASbGncvwxOQBzJfwjSktSlz6FsD9LrZNOmqtUrW3HUTj22HFVfw+ezNaM0IuP5a6fKM
	jcUjy9yLNeh6vyHA2Z0a679sTMsN4o0ZIrk+qGwsJZ0qwPT0Nu5lthuqeTpnlp4A+HedV+xzdau
	TE2LqgSvDOCI8nxNPNe2t2iuvuYlmrEnbLgP4M2yoPYT4p5QL7Z6BSAQu3tCVPps26jtxgFXd07
	3mzuqJlWiIXJYow4ltzAZnQD6Dash9NlF/OhujmxZvvyy750hw9cvKXfbiUgckDYPnL6GXnkyNK
	H3acEK40V9Xp+OBINJjVs8+mXg==
X-Google-Smtp-Source: AGHT+IFSypysstaWxmv0T0klNclVTjsYJUKz+bG3Pjcu5N9+tgi/x8M9eygkzrh/QftQYpz8JCMiiw==
X-Received: by 2002:a17:903:2ec7:b0:220:cddb:5918 with SMTP id d9443c01a7336-22dbf63db59mr67529095ad.9.1745863252272;
        Mon, 28 Apr 2025 11:00:52 -0700 (PDT)
Received: from t14.. ([104.133.9.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52214ebsm86204235ad.246.2025.04.28.11.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 11:00:51 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v6 bpf-next 4/7] bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch items
Date: Mon, 28 Apr 2025 11:00:28 -0700
Message-ID: <20250428180036.369192-5-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428180036.369192-1-jordan@jrife.io>
References: <20250428180036.369192-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the next patch that tracks cookies between iterations by
converting struct sock **batch to union bpf_udp_iter_batch_item *batch
inside struct bpf_udp_iter_state.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/udp.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 57ac84a77e3d..866ad29e15bb 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3390,13 +3390,17 @@ struct bpf_iter__udp {
 	int bucket __aligned(8);
 };
 
+union bpf_udp_iter_batch_item {
+	struct sock *sock;
+};
+
 struct bpf_udp_iter_state {
 	struct udp_iter_state state;
 	unsigned int cur_sk;
 	unsigned int end_sk;
 	unsigned int max_sk;
 	int offset;
-	struct sock **batch;
+	union bpf_udp_iter_batch_item *batch;
 };
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
@@ -3457,7 +3461,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 				}
 				if (iter->end_sk < iter->max_sk) {
 					sock_hold(sk);
-					iter->batch[iter->end_sk++] = sk;
+					iter->batch[iter->end_sk++].sock = sk;
 				}
 				batch_sks++;
 			}
@@ -3493,7 +3497,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 			}
 
 			/* Pick up where we left off. */
-			sk = iter->batch[iter->end_sk - 1];
+			sk = iter->batch[iter->end_sk - 1].sock;
 			sk = hlist_entry_safe(sk->__sk_common.skc_portaddr_node.next,
 					      struct sock,
 					      __sk_common.skc_portaddr_node);
@@ -3510,7 +3514,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	}
 
 	WARN_ON_ONCE(iter->end_sk != batch_sks);
-	return iter->end_sk ? iter->batch[0] : NULL;
+	return iter->end_sk ? iter->batch[0].sock : NULL;
 }
 
 static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -3522,7 +3526,7 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	 * done with seq_show(), so unref the iter->cur_sk.
 	 */
 	if (iter->cur_sk < iter->end_sk) {
-		sock_put(iter->batch[iter->cur_sk++]);
+		sock_put(iter->batch[iter->cur_sk++].sock);
 		++iter->offset;
 	}
 
@@ -3530,7 +3534,7 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	 * available in the current bucket batch.
 	 */
 	if (iter->cur_sk < iter->end_sk)
-		sk = iter->batch[iter->cur_sk];
+		sk = iter->batch[iter->cur_sk].sock;
 	else
 		/* Prepare a new batch. */
 		sk = bpf_iter_udp_batch(seq);
@@ -3596,8 +3600,8 @@ static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
 {
 	unsigned int cur_sk = iter->cur_sk;
 
-	while (cur_sk < iter->end_sk)
-		sock_put(iter->batch[cur_sk++]);
+	while (iter->cur_sk < iter->end_sk)
+		sock_put(iter->batch[cur_sk++].sock);
 }
 
 static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
@@ -3858,7 +3862,7 @@ DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
 				      unsigned int new_batch_sz, int flags)
 {
-	struct sock **new_batch;
+	union bpf_udp_iter_batch_item *new_batch;
 
 	new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
 				   flags | __GFP_NOWARN);
-- 
2.43.0


