Return-Path: <netdev+bounces-180907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08205A82E84
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 20:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3564442790
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0473327701B;
	Wed,  9 Apr 2025 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="OFdQJYCS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557B9270EC0
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744222965; cv=none; b=SDu4154zoy5uDiO0cIAHBfcmJkvyDFXsxp5uljfE+BZknFGmRiUySAh1gXwvGOboxIXhGXEz19cShCUiOeDfhigQa1bPbinTk+yleGXBNFIDP90j1XFrYcD6piAOb1cl4j5FiNTXLGUmju18xLPT95xyjLprUZUW7hHCx4f7COY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744222965; c=relaxed/simple;
	bh=wEHFPVdrORgpLcGZ+GvRrXkyZBaib+TRXKwG8iJEyPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrOvaOLHIgWnmxsJxV76HsyDGzndMNwlfq7J8kymDNkfD+7FXIWE18dPBZDXeU9wjSKDRpjPzNnaNJ4cE6/YaVjZ6oNI9f+/hySjUKzkOy+yDKIH4BU6NHW9CKnSKAWBlQllnOxJ8sODfzotefpaJMdwxgvsryUjPAG8BOfmkNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=OFdQJYCS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2240ff0bd6eso7391955ad.0
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744222963; x=1744827763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DntxylgD/bFAuSnepybtNVZWTfXmXLq0Ys2Pz9lSxJ8=;
        b=OFdQJYCStxyB1Sykn2pOT0CnwPOy+Fa303JVx2mmyeqqvw6+0h3AL7LrzEvGj3LLP9
         AUfoqm8lOx8NMEadjPfmGwjZ8tVAM5LcIGT9kZwgbBe6qqk+fFmg60/401oXqkUnc8K2
         3DbaFbZbhnQOlY7yoyXCcoptvgN7hRHoxtVQcM8B/RCJEN4ebP4uGAQE2uLFUUZU1G0T
         xVn+QJgkjqkWCX9UMr9ih0x+ZwJXfHhYl6E+CIqcAvXUbmesfgr7FOkcNqOehG3f/9DN
         B3jMI2J5jhs0yI+QB9Aa2n/yTm/Yrrkcaw63wIxvpoIPId6SzR4vFbvRCbHi9R0MPQlz
         KfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744222963; x=1744827763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DntxylgD/bFAuSnepybtNVZWTfXmXLq0Ys2Pz9lSxJ8=;
        b=jgRfUoTQWp+hyvaUQnwhLPZLoWapheS+h1sw5FhxTfvt87Z0aCMrRTZf9iV/k6RnKT
         fWSX4mXJovJgzeNeHTgyOU4q0CgCoy6Fw7mGFUYvnNNyRLC+nKxlvTPoQnQ9tWt7ict3
         UOjJ2bWSLjvovwv8DHk52dyEgzUiw2NyYb+cBSA5WIlJUIOn2jPqP+ly4Aw/ivh17XUS
         Nbcez1QhNRq6DnLUIGH8vQ+/fxd6DP/ONO54c+PiosfB9pJJMcn0Fy9S9uR29F0sNU48
         ukQ4F0J6tRL6mxA2yksz2779FTLxQ1Jwh26h333PEFloLqPYtjRqwC9kwV/n2lhugWcs
         KsdA==
X-Gm-Message-State: AOJu0YyxwNk+jWUo/zg901KPb0Zr7LVdG6BXeFaYtXUnwjI/eyx3Phmo
	m9aiAf1Ogj1Z+9aAZxAKf4xaStKvSiLL7gS2EolkWTCP2LII/LMDwxn0u7jfoqk2vxclEpUuD1u
	GRG8=
X-Gm-Gg: ASbGncuCin7H86UtL8DMrZN2N+E73u64uOMRharBzyzqA3GrRYpj4tVOYqMWKKThYOi
	9TGnPC9UtbgdvrYdkyxyiggn3CBh04x7psi5GV5JEfTV8IHt6v+V/JG1ZTi8fTWaAph/pKE4CZi
	9RtO0+OwqdYq3yVBJfwHkr+XYgZCL4o/BuRAnY7pjRgqt622wVWtTXLMsVKwNrbaD0yj3tx7aIM
	XB+9B3whDHSzEicOprIOeYjvSsDxW6Z+eDU88KVc4WbqZiMMpR9Rm362btejUQ5o/x/7NVGifCJ
	y67AxZhc/BNqxvu/+F/ccDB48ejPyUHCID6vy+1y
X-Google-Smtp-Source: AGHT+IHRVgJw3NYOgckrFBmUcQqoYpSp6TZXaA/bl5F+NRrvKmI0aks6nLltvSzd1NloBpdjcmwp+A==
X-Received: by 2002:a17:902:f60f:b0:223:5696:44d6 with SMTP id d9443c01a7336-22ac2c2f69amr23547465ad.12.1744222963301;
        Wed, 09 Apr 2025 11:22:43 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:2f6b:1a9a:d8b7:a414])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d2ae5fsm1673021b3a.20.2025.04.09.11.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:22:43 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v1 bpf-next 1/5] bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch items
Date: Wed,  9 Apr 2025 11:22:30 -0700
Message-ID: <20250409182237.441532-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409182237.441532-1-jordan@jrife.io>
References: <20250409182237.441532-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the next commit that tracks cookies between iterations by
converting struct sock **batch to union bpf_udp_iter_batch_item *batch
inside struct bpf_udp_iter_state.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/ipv4/udp.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index d0bffcfa56d8..59c3281962b9 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3384,13 +3384,17 @@ struct bpf_iter__udp {
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
 	bool st_bucket_done;
 };
 
@@ -3449,7 +3453,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 				}
 				if (iter->end_sk < iter->max_sk) {
 					sock_hold(sk);
-					iter->batch[iter->end_sk++] = sk;
+					iter->batch[iter->end_sk++].sock = sk;
 				}
 				batch_sks++;
 			}
@@ -3479,7 +3483,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		goto again;
 	}
 done:
-	return iter->batch[0];
+	return iter->batch[0].sock;
 }
 
 static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -3491,7 +3495,7 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	 * done with seq_show(), so unref the iter->cur_sk.
 	 */
 	if (iter->cur_sk < iter->end_sk) {
-		sock_put(iter->batch[iter->cur_sk++]);
+		sock_put(iter->batch[iter->cur_sk++].sock);
 		++iter->offset;
 	}
 
@@ -3499,7 +3503,7 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	 * available in the current bucket batch.
 	 */
 	if (iter->cur_sk < iter->end_sk)
-		sk = iter->batch[iter->cur_sk];
+		sk = iter->batch[iter->cur_sk].sock;
 	else
 		/* Prepare a new batch. */
 		sk = bpf_iter_udp_batch(seq);
@@ -3564,7 +3568,7 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
 static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
 {
 	while (iter->cur_sk < iter->end_sk)
-		sock_put(iter->batch[iter->cur_sk++]);
+		sock_put(iter->batch[iter->cur_sk++].sock);
 }
 
 static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
@@ -3827,7 +3831,7 @@ DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
 				      unsigned int new_batch_sz)
 {
-	struct sock **new_batch;
+	union bpf_udp_iter_batch_item *new_batch;
 
 	new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
 				   GFP_USER | __GFP_NOWARN);
-- 
2.43.0


