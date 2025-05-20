Return-Path: <netdev+bounces-191915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EFCABDE19
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 17:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844A74E3786
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26F7250BE4;
	Tue, 20 May 2025 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="WIBEWeGX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E5D24FBFF
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752684; cv=none; b=jy2QQrFSDScq8ugHtJvqfXW0ZBROZXijRtbfWk0l2JSRKlWD65bGdF/7BpjtWCV8JewrKY44qGJzki3vngLFPX4JUnJ6X1FuVJ7mKaLQhpt2uW+PEhLDWrc6t0KQvxtCkUbLlFUFTP7VMSPsZvAg9Lo3C7vfc1/J7qK2VgJPADo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752684; c=relaxed/simple;
	bh=ynwETJpAQXdvHO4YIxALq2Qy8Io8I2yE+v757vC54JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzg6WdE3YsaErdz9bvhx+Zi7Ow0EDN8UZcookP+HwsdH75zuFZq5Ecgo7Tfv/62Wvmy1CbRBWyyqQu9Q+hv/b76FoInUZG49q5SFEOrExpmznGNvKtaWwCbGbMBasvbsAAvdV3x10yjkpqDaMW8Jq/dRAQ+nws5GYcnDG7hEToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=WIBEWeGX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742766ebaa7so630823b3a.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 07:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747752681; x=1748357481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vqk5rW2rBw4c0vS6MV0Sw5MeQBuB3Pl99Ow2SgXtEs=;
        b=WIBEWeGX+mWiSycbnCd04Ub/hQJpwF1r8NmvMiuoVKPwdeFwBaDRmg7WwMObmeDxPV
         LbtJ6E7yIiQMhfF59Mqwr+ZtI+iHCPAfUfUDiVx/IP9pGjymqKO73Uto8YWm75otMNHg
         WVtilO1Ca9M1L9wHWNkHJ0015nprOCIy0bNps8dDOVvazvj9PPSrbs3607YZfv6Hz7Pr
         7ogP1U1rZrOycnEdVRvgwA24FF1glk1AhPbRWU27MzEe2FWp1EP52NQt4r4BNsDqk4qy
         C/foqOeeJzsdoXyqarrccIpUVvwL4It9p+3xe5hNaz7G27Q1iQyN/39jVpdB4NNiFYaY
         snxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747752681; x=1748357481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vqk5rW2rBw4c0vS6MV0Sw5MeQBuB3Pl99Ow2SgXtEs=;
        b=Y/WbtxL5JBjqwkXz+TZBjDYM+XT2D/UUc1hCaA8wIIjY2JKgOSPlXQf6oVLadeqwmM
         WLeME0eJNmtCf2V/ReyLYrI8aNXcEar6Dt0WZ8mQk1RluVyEeeE4JijbrlmxuKNcJVPr
         e5Dn2tksabZbye9nnA0bVLp1c3mPjM4lolcpuR9AbgrKS+uNW67o34z5FoZK/aGNl1Bm
         FuY+d8VSk+ZBAFkFoUmYfT+TxEKQ96hTc7D3vKe+tvRTYc6FO1KIcatf0fxleFwZkmcb
         +UURzUOx2b0fT1qavemWqtIFJHmlSL9R1tSF2ImldV9UpWdSBs+SX2SNvKCo74XzBZYv
         POAQ==
X-Gm-Message-State: AOJu0Yxsgee3j+jIXzS6kqVHuzHpoXWFgwe10Ll2LgG/k6OK5gwcWV8H
	2Fi7a92wQvSSMuUt8D8ITYm+MwVwjjIzG57eJDkEO9K3xHw8TlK5i8Xo8cnppaZYNwl9ec1rtaw
	63XQPf0w=
X-Gm-Gg: ASbGncsKs2lqpgPE63ff1p38hu3snPBWLTCY5a3kSbWcFafbOW7/LddybGjiP7DG/bM
	rgmoywP07F6Ae/4UA2h5DGOSnfVpYRp0f7zS6cj5AWgcSBgri8URyHuUxBDzlVjBo7uouHttGVP
	XiKX1MMaL6jzzPGLz9ZapSwWiRtlo/Nn+2CLCRIYkCdKvoBD+vwE6iJY46UnsoEAQUuvIWpGp3L
	lVsVfdplNWSpucbnH+PdFBs59njd+PbxhMHIJfzCZWWcnf303x1jdlOduojzfsAn41Zt7W/1Sx9
	a+C6SkWvprwtNCf9Nl4gsEWUbKbHuFfKeWsvRYK6
X-Google-Smtp-Source: AGHT+IGP+iFZP2CLdnN2q9QLH4oib9KY44ikNhgPm6ahIcsfTt1IKVVI+TMIWB2LAJQ126k2qM/30Q==
X-Received: by 2002:a05:6a00:1ca7:b0:730:9a85:c931 with SMTP id d2e1a72fcca58-742a993297amr9873455b3a.7.1747752681582;
        Tue, 20 May 2025 07:51:21 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:276d:b09e:9f33:af8d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829bb3sm8242993b3a.100.2025.05.20.07.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:51:21 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v1 bpf-next 04/10] bpf: tcp: Use bpf_tcp_iter_batch_item for bpf_tcp_iter_state batch items
Date: Tue, 20 May 2025 07:50:51 -0700
Message-ID: <20250520145059.1773738-5-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520145059.1773738-1-jordan@jrife.io>
References: <20250520145059.1773738-1-jordan@jrife.io>
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
---
 net/ipv4/tcp_ipv4.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 20730723a02c..65569d67d8bf 100644
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
@@ -3078,7 +3082,7 @@ static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
 	struct sock *sk;
 
 	sock_hold(*start_sk);
-	iter->batch[iter->end_sk++] = *start_sk;
+	iter->batch[iter->end_sk++].sk = *start_sk;
 
 	sk = sk_nulls_next(*start_sk);
 	*start_sk = NULL;
@@ -3086,7 +3090,7 @@ static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
 		if (seq_sk_match(seq, sk)) {
 			if (iter->end_sk < iter->max_sk) {
 				sock_hold(sk);
-				iter->batch[iter->end_sk++] = sk;
+				iter->batch[iter->end_sk++].sk = sk;
 			} else if (!*start_sk) {
 				/* Remember where we left off. */
 				*start_sk = sk;
@@ -3107,7 +3111,7 @@ static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
 	struct sock *sk;
 
 	sock_hold(*start_sk);
-	iter->batch[iter->end_sk++] = *start_sk;
+	iter->batch[iter->end_sk++].sk = *start_sk;
 
 	sk = sk_nulls_next(*start_sk);
 	*start_sk = NULL;
@@ -3115,7 +3119,7 @@ static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
 		if (seq_sk_match(seq, sk)) {
 			if (iter->end_sk < iter->max_sk) {
 				sock_hold(sk);
-				iter->batch[iter->end_sk++] = sk;
+				iter->batch[iter->end_sk++].sk = sk;
 			} else if (!*start_sk) {
 				/* Remember where we left off. */
 				*start_sk = sk;
@@ -3211,7 +3215,7 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	bpf_iter_tcp_unlock_bucket(seq);
 
 	WARN_ON_ONCE(iter->end_sk != expected);
-	return iter->batch[0];
+	return iter->batch[0].sk;
 }
 
 static void *bpf_iter_tcp_seq_start(struct seq_file *seq, loff_t *pos)
@@ -3246,11 +3250,11 @@ static void *bpf_iter_tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
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


