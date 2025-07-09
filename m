Return-Path: <netdev+bounces-205577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3567EAFF524
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 01:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B1B37AA58C
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 23:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD1F24888C;
	Wed,  9 Jul 2025 23:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="qVI9hyZN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB99A24728B
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 23:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102225; cv=none; b=GeggtMvcEjBAUXMQi76xwNuIYdA74xkzdWwWJivzCcFOc6L3jqsz9KzckQXxpBV+r08WVFUFcqcvYKRX92E/Egqr3VEMqxX38X+sljQaAgaWa+iWyMR6PGC3FeokDMDhQLD7LUPMQUIBDAsgBxQYt7HejrLZfP1lXyj22hvdpU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102225; c=relaxed/simple;
	bh=a51HgorEIgGCAVUbMsfE6xOpMv7c+DqcFSKtMtvMLIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ou9wEVVjHQpwYw8QnOfvmTmkIjdJHeT3UmoeiZBsSLy4MaL0yO3EaSQzaBN21Yiec5io0T+xpPS/clXD7XVTTrZnDoitqasekUNhFwEIOWC7SlpmhQhMIjxBWMh5nvlMHld/uWUcnN65xp5/DrBu1PIP7HVQALykeVCSRNncT4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=qVI9hyZN; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7481adb0b90so53334b3a.1
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 16:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752102223; x=1752707023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Vze6RhlSTESRUYOf4wcKBQGRaLuvTgL6/CGzGYUzwU=;
        b=qVI9hyZN0i+cDJ2QVO+28a32eRMr82BhFCqIDSC3vilKDcvimmprwidxIilXCsOlW1
         UFQCNgPSsSENXu3fAK9w/BUFW7l76+mksF9dS3v+KYqxyzPZD3Q/AUpPwek8NnkaVnUk
         wCwzMZWwMO8CxQKTRxpoXrU8vQ57OOvcZY3/JBbqtxghqSzleHcoEMDpePeIJoYKMEad
         eeIA/vcpAyD39C79wSnmaj8nvPvr0TwMaj5a5olJoyVNq41dM6WZL61iUdmsgfo4RKit
         XRcfpwVqAz7LNswOkuv/6+NPCO6bJw56sZACtWSbiOn4l7mOvStcPP84cTHwAXq1FoYj
         GNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102223; x=1752707023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Vze6RhlSTESRUYOf4wcKBQGRaLuvTgL6/CGzGYUzwU=;
        b=tnXF2hd9FQZd18CT3SuGeaaTSTVIKNsGE+HjDlzGqb+gyNCf9wWsmhUo1O1qQbOXvr
         UGASpFk7DT1zqyLmzQWojvGUMtPqXlSSGUWMEZy+gWBdksJJuhZ66U4bT9A0EPUb99Lu
         zmYDKlxV8kfb30tDtlKrMdpC2yz0VGO6Y90FWJtnnY1quUYtgiR1ni+4SA9atscvPefT
         M46oMubiBmc30VQe5Y0a13Jf8SMuJEFxw1VaFtNqKRDUU/sDep6aPSk4b9hXRS0CDxnl
         F1ruMEvnqadNcPpdjT1tctz10PLroEBWtxKZxEp0awNlGp1c/7mZlWeu1+25DBCFHgks
         CMnw==
X-Gm-Message-State: AOJu0YyOkaSnd58o2ZbI8+C7FicOhO03mGLCJjjD83q76+l5d89BTC7U
	nKbKodI3qx60hi3FIBOD08Q48qNwCNi3QMRghlvBLZQv5/aGqaauXcU/JlR05M0rfUchJ0N43kc
	uihQS
X-Gm-Gg: ASbGnctc74vF3wnK7YJ4+OL9d7/8I4SnRVKXubfb9PS7Qw3rTPx0z1DvotnG4dnGThw
	d6mMVcyDJ9YowjmDOUYc/Sf905EcDh2hRKTtPN6QlerjKF+SyHTXitC3D8TYdOq6eka3Xr122+T
	MNfLuki0ONUwndEB62j4yi7y+lW4Tj4vogM/YFeZHBkww/s6ENg84vB+pkZbnneIuO9Taut3G7K
	151dVX4MQsN2dIi0aARJBns42WIlH6ZX75OgxeU+9mBCjvW05SK9QyrV8fTq8j8OIODK1Q2Wv1M
	KrzKGH/Yjf9m3TryqGNojiqbF01CwNDUUSvpZ31u09pvIIx2KD4=
X-Google-Smtp-Source: AGHT+IHxf4oLIO0+ttlvW8KJw4gaG4ax4Ylps8Tu49UNEkuqCbvZOs2i/uy+yjH/Qee81AlITLoLww==
X-Received: by 2002:a17:903:1a67:b0:235:225d:308f with SMTP id d9443c01a7336-23ddb1a1392mr26675445ad.4.1752102222791;
        Wed, 09 Jul 2025 16:03:42 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d121:1d56:91c1:bbff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad212sm2679015ad.80.2025.07.09.16.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 16:03:42 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 04/12] bpf: tcp: Use bpf_tcp_iter_batch_item for bpf_tcp_iter_state batch items
Date: Wed,  9 Jul 2025 16:03:24 -0700
Message-ID: <20250709230333.926222-5-jordan@jrife.io>
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

Prepare for the next patch that tracks cookies between iterations by
converting struct sock **batch to union bpf_tcp_iter_batch_item *batch
inside struct bpf_tcp_iter_state.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_ipv4.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 50ef605dfa01..d2128a2b33bc 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3014,12 +3014,16 @@ static int tcp4_seq_show(struct seq_file *seq, void *v)
 }
 
 #ifdef CONFIG_BPF_SYSCALL
+union bpf_tcp_iter_batch_item {
+	struct sock *sk;
+};
+
 struct bpf_tcp_iter_state {
 	struct tcp_iter_state state;
 	unsigned int cur_sk;
 	unsigned int end_sk;
 	unsigned int max_sk;
-	struct sock **batch;
+	union bpf_tcp_iter_batch_item *batch;
 };
 
 struct bpf_iter__tcp {
@@ -3045,13 +3049,13 @@ static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
 	unsigned int cur_sk = iter->cur_sk;
 
 	while (cur_sk < iter->end_sk)
-		sock_gen_put(iter->batch[cur_sk++]);
+		sock_gen_put(iter->batch[cur_sk++].sk);
 }
 
 static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
 				      unsigned int new_batch_sz, gfp_t flags)
 {
-	struct sock **new_batch;
+	union bpf_tcp_iter_batch_item *new_batch;
 
 	new_batch = kvmalloc(sizeof(*new_batch) * new_batch_sz,
 			     flags | __GFP_NOWARN);
@@ -3075,7 +3079,7 @@ static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
 	struct sock *sk;
 
 	sock_hold(*start_sk);
-	iter->batch[iter->end_sk++] = *start_sk;
+	iter->batch[iter->end_sk++].sk = *start_sk;
 
 	sk = sk_nulls_next(*start_sk);
 	*start_sk = NULL;
@@ -3083,7 +3087,7 @@ static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
 		if (seq_sk_match(seq, sk)) {
 			if (iter->end_sk < iter->max_sk) {
 				sock_hold(sk);
-				iter->batch[iter->end_sk++] = sk;
+				iter->batch[iter->end_sk++].sk = sk;
 			} else if (!*start_sk) {
 				/* Remember where we left off. */
 				*start_sk = sk;
@@ -3104,7 +3108,7 @@ static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
 	struct sock *sk;
 
 	sock_hold(*start_sk);
-	iter->batch[iter->end_sk++] = *start_sk;
+	iter->batch[iter->end_sk++].sk = *start_sk;
 
 	sk = sk_nulls_next(*start_sk);
 	*start_sk = NULL;
@@ -3112,7 +3116,7 @@ static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
 		if (seq_sk_match(seq, sk)) {
 			if (iter->end_sk < iter->max_sk) {
 				sock_hold(sk);
-				iter->batch[iter->end_sk++] = sk;
+				iter->batch[iter->end_sk++].sk = sk;
 			} else if (!*start_sk) {
 				/* Remember where we left off. */
 				*start_sk = sk;
@@ -3216,7 +3220,7 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	WARN_ON_ONCE(iter->end_sk != expected);
 done:
 	bpf_iter_tcp_unlock_bucket(seq);
-	return iter->batch[0];
+	return iter->batch[0].sk;
 }
 
 static void *bpf_iter_tcp_seq_start(struct seq_file *seq, loff_t *pos)
@@ -3251,11 +3255,11 @@ static void *bpf_iter_tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		 * st->bucket.  See tcp_seek_last_pos().
 		 */
 		st->offset++;
-		sock_gen_put(iter->batch[iter->cur_sk++]);
+		sock_gen_put(iter->batch[iter->cur_sk++].sk);
 	}
 
 	if (iter->cur_sk < iter->end_sk)
-		sk = iter->batch[iter->cur_sk];
+		sk = iter->batch[iter->cur_sk].sk;
 	else
 		sk = bpf_iter_tcp_batch(seq);
 
-- 
2.43.0


