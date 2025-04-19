Return-Path: <netdev+bounces-184289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4775EA9444E
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 17:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C49C3BC13E
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948EA1DF984;
	Sat, 19 Apr 2025 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="mVOMDgQj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9D11DF246
	for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745078293; cv=none; b=dluUx5Xzc8r9lx8+IKI33iLD1K+E2VxWFTJXPECeZGj7kIQH3QsENiiA05NyP3TgVKXJzGFSi6gfw+a02ZaPZUo0VXQe2OJQf1dRBOkSWcbAsl3KM9iy9MRNLzoNSYNUy+QaMt3khfffD59EQAPCdRB72ZmZ8SHw1LjJrA2X9KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745078293; c=relaxed/simple;
	bh=ftgQcqMQpwQf6jHLXFaZm/cI/dHMSA8F/nMjTREAVsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBxqOkwJvESEV4+OeRolzWG/G1hmd6s/5h3IHYU8MUoKBwSuFN2vFjLyAhAj81JxlxmCjau700i7GC9ijfRn0dm9OVPPxg3WI4EqW5yrYJcxcPmVVHgyl1saWvgfrZCu+mNg145M52GtVKXNAB4ZjHF33Q2GS9rbAgfd977GaZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=mVOMDgQj; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-af9a6958a08so263720a12.1
        for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745078291; x=1745683091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJ9tF5XVwy2MCSOmuzi3dTz+kjigAZ4e/XhnhYr6xsg=;
        b=mVOMDgQjnsAvf9DB8EWCxL2fwY84JiEd5xDD6krVMSOpnVKKgwcPfc3C6ah/J39GM4
         hB7FUKCjA46ri5qJqWAlh4uJf259couSUw03xRPWnpggmyeWB4KGvuyRGS/1gazszI8q
         MqM6M7TuLS6lYhTOeFHzaQ4oe7N0o3Mk4t6wE+dZHIc7h4HsRfCUFqgcIIeI07Zq1wKj
         8/GCcxFz6JV2veEtbwSpuaPO+ZQlffWlJpsl8kPEgmKNRFO3gox97wSm7kHBHVBmQSC9
         9dCwI9SYD4vopSY2LGD7WvvTDAArVQVV16lhil2FNrCMpE+3an+ki76FnEiL6aPcCPNL
         5gUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745078291; x=1745683091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJ9tF5XVwy2MCSOmuzi3dTz+kjigAZ4e/XhnhYr6xsg=;
        b=pxrmU36X76X+SiLy49aEx9wxG1a+peyjrSHq87XzaiSLGBEYXZq0DjvBKc4ZB1WCXo
         HCtT5RGOLZZvnYqHRos5JVO539LR7FgyryeUvFgCwixOL5RUA7Qv8WgxLySRNdqKWoS8
         JBIfIfGJpJUCX2O80JjmY5NSpNIyZfdNit/o3mk6+QnsO9TYwB8QPSrJWKUMKN/PPlRJ
         Zy7WXy91dFNvnLHcMrYSWtupDVr/x1bQQXQ6W+1kweMVx+9JT5u9ldufZOA83kZQLowt
         k2Bw2xeSIiNPXCPxd+XY9zEZSll5AVpYYXhyjlxg2n2/mGmJYMPZnTpzT/xqOHXDjGQc
         Uhgg==
X-Gm-Message-State: AOJu0YygijFuPLD+CD6JS0C5hBACeDfBpgxCh5c0nLgXl1/02UVnjTC2
	df7JgTIkbneGg+DXfilYL/T5sat6lQkW3GNjX6V28qf7TUIkCVR/F6u4le81vY3I6hSalinyR/M
	T17g=
X-Gm-Gg: ASbGnctJMgJ91peF+/2TqoQwQrN2ZqQmvdC4Zftru89zQZC7DUU2SF7ASYuPjbsR+9u
	Ox3XNqGRtnfUBT3jB+K58BZIlrNnl+q/2BzfsMxsfYDotySpGtkNN7JLebY1NeFqM5XGksYz9co
	RMPno6tD3zlbKw4ZB22j5YBPD6VI6ECGnmDSFHkSyy7ZImtpMLCn8SC/ism85anlYiejtSFjht7
	je61czet/oUtG/G3M03H4frz29J4Lpm9e619/MzkLwVX2bS1YqfLCRJv2pYetHZmLnnr9b+lYF6
	O1ari9QZWmuV1JvtrFF4a6gnnK4lDA==
X-Google-Smtp-Source: AGHT+IEEEVWf/c9Yuxr07De8kexelueNYcfCBdKeMc0n3ueM9/r0r59EqjCCUxNoBhp8qHnC00UNYw==
X-Received: by 2002:a05:6a00:3a12:b0:730:915c:b70 with SMTP id d2e1a72fcca58-73dc119a591mr3090239b3a.0.1745078290962;
        Sat, 19 Apr 2025 08:58:10 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:1195:fa96:2874:6b2c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8be876sm3464157b3a.36.2025.04.19.08.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 08:58:10 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v4 bpf-next 3/6] bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch items
Date: Sat, 19 Apr 2025 08:58:00 -0700
Message-ID: <20250419155804.2337261-4-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250419155804.2337261-1-jordan@jrife.io>
References: <20250419155804.2337261-1-jordan@jrife.io>
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
 net/ipv4/udp.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index d3128261e4cb..261dd7f508dd 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3385,13 +3385,17 @@ struct bpf_iter__udp {
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
 
@@ -3455,7 +3459,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 				}
 				if (iter->end_sk < iter->max_sk) {
 					sock_hold(sk);
-					iter->batch[iter->end_sk++] = sk;
+					iter->batch[iter->end_sk++].sock = sk;
 				}
 				batch_sks++;
 			}
@@ -3481,7 +3485,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		goto done;
 	}
 
-	sk = iter->batch[0];
+	sk = iter->batch[0].sock;
 
 	if (iter->end_sk == batch_sks) {
 		/* Batching is done for the current bucket; return the first
@@ -3525,7 +3529,7 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	 * done with seq_show(), so unref the iter->cur_sk.
 	 */
 	if (iter->cur_sk < iter->end_sk) {
-		sock_put(iter->batch[iter->cur_sk++]);
+		sock_put(iter->batch[iter->cur_sk++].sock);
 		++iter->offset;
 	}
 
@@ -3533,7 +3537,7 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	 * available in the current bucket batch.
 	 */
 	if (iter->cur_sk < iter->end_sk)
-		sk = iter->batch[iter->cur_sk];
+		sk = iter->batch[iter->cur_sk].sock;
 	else
 		/* Prepare a new batch. */
 		sk = bpf_iter_udp_batch(seq);
@@ -3598,7 +3602,7 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
 static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
 {
 	while (iter->cur_sk < iter->end_sk)
-		sock_put(iter->batch[iter->cur_sk++]);
+		sock_put(iter->batch[iter->cur_sk++].sock);
 }
 
 static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
@@ -3861,7 +3865,7 @@ DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
 				      unsigned int new_batch_sz, int flags)
 {
-	struct sock **new_batch;
+	union bpf_udp_iter_batch_item *new_batch;
 
 	new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
 				   flags | __GFP_NOWARN);
-- 
2.43.0


