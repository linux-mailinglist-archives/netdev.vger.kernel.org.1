Return-Path: <netdev+bounces-194435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FF7AC9712
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 23:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C794A7947
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 21:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388C8283CA7;
	Fri, 30 May 2025 21:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="H1ekHiW/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B554422AE5D
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640695; cv=none; b=laadTeqTtvexZZZsTFsZCTtfj4kIj0UdprKGtoIooavq6JwSsXo47rw3clFsySGClPyoLk4eAAHAdwOc88+EBiG6dJs+TvST0mAPmEkVY8XnVDrKx9gPRr11uDzl+skLuSG+HQLMbTpf8wp5PfmnMgd7zQJahj8cOpsfDEIUCw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640695; c=relaxed/simple;
	bh=J9WHRyvRODERSUE/XtH3ualLiF0NfpgkyfMoaf1Ef5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rm93Rq6rz81l54C+VNl0UlIXoIVBKiVDQhiOrYsiQaEC6KL9Qpy5xQZXo7bbvsVU3uGZs9aAUfHi/WUUmgcI0CdtxVe521S8pt9aQD3KoU8pLLkYffXAB+29AlgRKeohHEIrhpMmSRV14kIjDnOEviIMjpzYGbDvxsFLRt+kmsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=H1ekHiW/; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-311f6be42f1so417973a91.0
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 14:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748640693; x=1749245493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrPFMR4OHikyTVTJ8EtBy3d62qMwlWrkmeEZ+t0fDVs=;
        b=H1ekHiW/D6rmw+E5kMQMKtGPOTCLQUxK8DQHOViCRsB5q6kKEofVvm3+PTeNCW4gJt
         HFHCCSmEZ4sYmHgeckr1er6bw3vX876KavDNUe+Iy9GQP/opLvUX2ZO4MxsdUpddEJp9
         BQUhYwjCKNR0XOKIiaB9X/bMwjChxDOgQleEvuICCw5r3Ab93mVKFEYCWeAJTahAkzyr
         9U07Oprf+povqvtEp9znIKXAG1I0wWnGuu3py9FaYoIApg7PpxuikVpU2N23GnTqD9u4
         h2uyKzRZ3DVRvvIdLOH2boJPnoQYwsdaOm5rvrUl2fMc2o1EoWCdaMudedKMGP5+tX7i
         p73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748640693; x=1749245493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrPFMR4OHikyTVTJ8EtBy3d62qMwlWrkmeEZ+t0fDVs=;
        b=iiSSD3dvm8+KRbcV1a3pXXfZPnRQXzYmTABFt2DJSVbsRuhjGjYINC69d7n1tpc5sV
         4WaDx75fmd906aSv4+1HRI6+sKXGpGDB5F5uyfUMx6smqSbN3gsFi/QAku0NuXBvLImF
         dVt4+AxnmrBhZaX0ZgcH/g4eMxeHLrbJ4UXl79u9pi1uPZBSkTBjkU9HVNuN7BfPTChv
         Skvg/SlUpXYLW+cl4HYE2jbV4LWSaAlNqZ/sTqFaACDFALEicsxkOMD3NeEkKOW4PLf6
         TMaTBAr77GBlHmngLkQ13Q7ZHqWiJ5MwiW9V10RExv021wEbzKSLw6ISbjmIraVngvpM
         3AtQ==
X-Gm-Message-State: AOJu0YxZAB/Ss35xHSY6K4PrHzpn/ZDyYA/oBPVKVatEerLTomuiAUCp
	cRrzrjSr/bwz/MFx2ECULOjY+PJER8yXox5HpmqFvSFaboBYY4oEkgM3c1dXuDY4cm81Gqmgdvg
	7HltmITQ=
X-Gm-Gg: ASbGncvGUvX6YfkKW4mTXRNQfjO50cJWYgMvtl9yIuAwLtkGtMNkQanyZKMzV6FGBPT
	F8pBP1EUcLkM3KWjGu/eyi+79yFw/5aeQbp64Rpa+hlm/fkkB/O7r61UbB+y6cNmyUmsvb9UMRy
	xX6ALEzybEU0+avsCA82o1BrEBb3qM/SaWoZf/9ZpBtCI3Rr1ONKvMMhX0pQSwZRf6L8+qDn9sw
	eAjF0gKAaRBxFeWAwHNHCT/sr9yn08n1hduKNs/XgtomdH8dLK1VlUelFnt9nwMH1Gj+uQOcnlM
	ol7wVAuovrodBSYzhkpE0EsNFmORs3z+pndgWQZ3v9hnA2fa8bc=
X-Google-Smtp-Source: AGHT+IFo8QSMR5x70ZxacAYiDsgqN5V0KAJHsYDI4igY7kQSKbZjsJ+CS8YlcTb1rMB3LWCWyCrbOg==
X-Received: by 2002:a05:6a00:1702:b0:736:355b:5df6 with SMTP id d2e1a72fcca58-747bda36189mr2383978b3a.6.1748640692712;
        Fri, 30 May 2025 14:31:32 -0700 (PDT)
Received: from t14.. ([2607:fb91:20c7:44b2:2a24:2057:271e:f269])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed4399sm3496763b3a.77.2025.05.30.14.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 14:31:32 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v2 bpf-next 04/12] bpf: tcp: Use bpf_tcp_iter_batch_item for bpf_tcp_iter_state batch items
Date: Fri, 30 May 2025 14:30:46 -0700
Message-ID: <20250530213059.3156216-5-jordan@jrife.io>
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

Prepare for the next patch that tracks cookies between iterations by
converting struct sock **batch to union bpf_tcp_iter_batch_item *batch
inside struct bpf_tcp_iter_state.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_ipv4.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index ac00015d5e7a..c51ac10fc351 100644
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


