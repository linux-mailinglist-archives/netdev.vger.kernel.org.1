Return-Path: <netdev+bounces-194434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C714DAC970F
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 23:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825654A7517
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 21:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3134E283149;
	Fri, 30 May 2025 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="JyJtlqk+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB31021A451
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640690; cv=none; b=ska5CVFn+FASI5mFmbZaqVC3OhQvFf3QYxHNl3ZFltTioIuY5psldvLzVuHPO2TtbuUwSOZjqQQ1iyaY1+usN9/yTU8WlnfskhNXKq0nzTD4oEyYYYRIp+8BRRRT1gllV/Z7OlNnAIzwchG96U5VKJ7VEX67JmLQPYS2QUdbp/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640690; c=relaxed/simple;
	bh=9DDxlxWCKSSenOqhiGVM2x6aQ69gEERQnVNmIkzJj0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifizh+s99JlZoDuFqHKS15TrFLmU9EMW3chOmvVFSA5Gv1WKHNSXlGSNucCt0DY3jLpKKly/VuAXQGbkKKd9bDLjhsT4Cv+Nwej6uXDZ9j7K7PPFM76ijm7Ng1CvI7zCNNJV9ZIbXJKTL2fAQM8m6WKwEkB3zAf6MGQivqSSDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=JyJtlqk+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3032a9c7cfeso358147a91.1
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 14:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748640687; x=1749245487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZD2VNu6uejAEqZZTUts1NgZ1BwG6tL+V2jQ1JGQmlsk=;
        b=JyJtlqk+NtOIgf2g8vtIed2AaMMNJaDL+mBSr/TH7+nAwzwwoBkzF14AWlhqCthbGr
         Xii3fhg5+fwilBW3PI075GgPnf56O4/QuHl8tar5+Dh2ed0u6pcTckFYzn0W9m1Bn3kx
         xIIFCyk9S2TlrBm3HVtRGplQNOehn0XtwMm084T9kBkEpXQFuhMe6dE0443l/iI6tk17
         SRHaXmPNojnvKtJVldt1l4L0KXG1SvNWAz2+TSqTHYLlkScVQROwyLA1l31fiuw4WmfE
         jxf5+UQTJSM9ECuYKWv2j/gM8zGRmJHkqy4OPOZQyDMsqIRqiOVRWzC1RZHJM+fqeIyz
         50dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748640687; x=1749245487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZD2VNu6uejAEqZZTUts1NgZ1BwG6tL+V2jQ1JGQmlsk=;
        b=KN2fpHQxnwDCjY8g70+gjwT5MGS85Ag19TV+UyTehBrgY5OXhuMb1rI7Z4KFVchktL
         Z6s3fm/R+SUEkLOAbKSNZlnDue75C5mhP7kYS4EzN4qg8KizA9ux5s1fw2i7qgQAaLhW
         6W2t9fi5jaSVXnDfKS66VA2PjH8vcjq1NL9lDftwq9iMEAM3lOuMv93TFsCQJnlkQhIf
         aIdl2L1ELuc/qg6ZsmF3MN5JBIeqyX193KF6sT03UEd/K2UA3QKjsE3Zd2F9wcKjqzZ9
         ZjMsaCnFJqyYlzR5V0zLnFOynd5BpCY0+h4awtScJmURKf12GsEhlOBuB7cjt/dY3gS8
         +fpw==
X-Gm-Message-State: AOJu0Yyu7kqFw/ES7hpDNcwnUNGqWNsoBhEf9eMjtmR+E/ZMgnvRscQP
	osp1MtPmrHU5ubyDaMeYyWDXKt67n3jMrKOSswTcQ4Xi5kCjTqFOonunbI+qamGJ3krz349jd3Z
	KlKh5oHw=
X-Gm-Gg: ASbGncsXlaG1srFB0lComcD+pPS4+jDpX+1hCU7aGFDCGftQsPY3MKTtzg8W77atn3Q
	7hIQNPuvjWjlCQ4o5LKfReuJAEuTCeEAycIFw4V1zLnYiJxijb4S6rjQOuf5x7xKUMQtVHUC1gC
	hCI20vfUiKBgEMJZoxv4o0l6up66Azivz8OIA9M6bPGzcH12jgU/A4gFz7eo2zTqoFtryykWFLP
	lZMSRB4IBViDp/A+LoD0miBCkRX4Yj+5NdGwiyo4xjG9OBQMy238n18+RABTWc5pMcr9BeVAm7b
	Frsjt0j4G9fYL+2f/zZraM9e5wLLJtwsY0diWkNR
X-Google-Smtp-Source: AGHT+IHmWawHFF3mTsBHJhgKMNxJFagQgPvKjbNMLIiIY0QYn0Fzh6aIojepFd2gyy6eYDzSIAmoNQ==
X-Received: by 2002:a05:6a00:3d4f:b0:736:fefa:b579 with SMTP id d2e1a72fcca58-747bda6d963mr2732772b3a.7.1748640687636;
        Fri, 30 May 2025 14:31:27 -0700 (PDT)
Received: from t14.. ([2607:fb91:20c7:44b2:2a24:2057:271e:f269])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed4399sm3496763b3a.77.2025.05.30.14.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 14:31:27 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v2 bpf-next 03/12] bpf: tcp: Get rid of st_bucket_done
Date: Fri, 30 May 2025 14:30:45 -0700
Message-ID: <20250530213059.3156216-4-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530213059.3156216-1-jordan@jrife.io>
References: <20250530213059.3156216-1-jordan@jrife.io>
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
index 69c976a07434..ac00015d5e7a 100644
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
@@ -3154,7 +3155,7 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	 * one by one in the current bucket and eventually find out
 	 * it has to advance to the next bucket.
 	 */
-	if (iter->st_bucket_done) {
+	if (iter->end_sk && iter->cur_sk == iter->end_sk) {
 		st->offset = 0;
 		st->bucket++;
 		if (st->state == TCP_SEQ_STATE_LISTENING &&
@@ -3168,7 +3169,6 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	/* Get a new batch */
 	iter->cur_sk = 0;
 	iter->end_sk = 0;
-	iter->st_bucket_done = true;
 
 	prev_bucket = st->bucket;
 	prev_state = st->state;
@@ -3316,10 +3316,8 @@ static void bpf_iter_tcp_seq_stop(struct seq_file *seq, void *v)
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


