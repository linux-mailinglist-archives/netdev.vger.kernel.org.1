Return-Path: <netdev+bounces-184288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70205A9444D
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 17:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F0F8E1EBA
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 15:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BAC1DF738;
	Sat, 19 Apr 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="bFlqG/bF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254151D54FE
	for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745078292; cv=none; b=hUWQ+s1ql5r8gyuapHg2G5rtDfo4xFeAjANM+NT6iQmtvIieinoCZBMvrpN7sVs/NARvn6c1Fk4ADjLD99BOJUmOrEzGdKpiTwx4EPd+6D6zGbbh+kdwNmvvggWD5sgEaWZKIG7NYSgqXZDMqTCaYh1IyZXRrLwZe6qV30uuq8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745078292; c=relaxed/simple;
	bh=aaNcjAggGzajn421WtwlUUhGoU4T/w9h9mWzPOqksEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlRZFsus0jDX2LX8vujlDlUR+nQb/iYRZTAmh5F7xiYBIoHLNsSOGhbge6fu0fri06IW1m5/+vNyZO/NUe79eEqjARPes4swUz93ElniXLQFKCrcUFHysXO1NsuFBJc9HCRMjW28U9WAMpvo6gaitm1Tqoa+WzLolnQVu9bWEeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=bFlqG/bF; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3054e2d13a7so436219a91.2
        for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745078289; x=1745683089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcR3qNY5OnJnRoRte86S6UevB3XwzFNbcqfVprWZqms=;
        b=bFlqG/bFlpkY/ykt2Aeh270yxBfDq5qCbmKwkbmoOUGpvZy7mc0WMcqr2nLBj0Pz6+
         nCy4krfEUWj8zDOMjQyvCjLPFfNI46yHsE8pvBCcG8dTyy7mw5U7J8Ne3XQLZiciuLBc
         44AOX8Y6Kmw9qhW8RY1cQQ9ea12xpE/8mQztxLcAmGU8JWI6gVbqjoEqn54rnIbQuyms
         8hc0TIi+lIHbNMtz90D1v1UIDeFEZXR8lOHh3VgEckSk4TDVYdBqyi7fOEF17bdLVzfv
         tApQbodlnfDlpvqWZv9uaY7iq5PzhrZuygqFO2p1L2TfL5nqbo/0crL9BcKzpAupmoiV
         SrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745078289; x=1745683089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcR3qNY5OnJnRoRte86S6UevB3XwzFNbcqfVprWZqms=;
        b=qxCNe73dnwn15sZIEtAZCelLIgo4a2Nf6RoIDb7ejlUAE+FWqqSUlgZrej8fILnqfi
         oH4MHZvG4zhVAzRbRbADuuSnEqNil47X6FxpXzxuRYmbBirvAwgxd9Z0iHcYgf3L8+2V
         PepzDSob3+0PqIcmzUDvWBEdE7+Cxxnjke3ffQNOZUpfOmNCXdfyK+zuRiCTHF3gncjK
         L5as/YLvYdzeVWjxgZbnMCNVso6MFc3tN77PzD/4EgjcW8XCAD1qpGsB++4fQhr5/guO
         zsPpdGahZ50tI5K9pjhUVGg34JbfSA3CqDwVgzCEKGKzZBQ5aqFGQIXZnaHfdYUbR/NR
         uRJA==
X-Gm-Message-State: AOJu0Ywo9xMIZirDfxWRct4ZbNS07gfLm3by773FJqDQYf3peFTPXj8/
	+PWw8pNWr3qgyVGprw1/ibL3wn3pal5hmzdascks+nwcQ6+v2NH3+kmX/q8kmfz2i5atg2WCzFO
	nILs=
X-Gm-Gg: ASbGncuZA2XJ7fIcivadUUd+Bklk5gm6zAeegz8Gk9I0zPFOYWyDb0SI6JcFFO3t6Fk
	HZhtQIfratYYSi6KZTWHh5hyXoy8YURiuy6djXKnyTufOJofo7QoWzBw+fgA9Jz5JyXzSwnXIq2
	tGSJSc6iMQmYnX+JT5utCCNV6HWjhvbyBf3J8xptbVBFHZ8pPY+j5g1LARuBchuQuzYdOMxqmJj
	PdvMattePfDsoi8nSf2DYuvS5kvgKHaveVQo8zX8t138AihoIra/9CoO8GGzjoS3IkFvf9N2qnj
	s1RcowZ+f46EDijrDYCUCYPr5OiMLA==
X-Google-Smtp-Source: AGHT+IHpSG1Yw8p+U7M76MoE3JR+c3kgUiqxOUfo8o+bN/9pt5LExG/gfMiODUgLiOCcO6yzjdCIXQ==
X-Received: by 2002:a05:6a00:a95:b0:736:4d90:f9c0 with SMTP id d2e1a72fcca58-73dc144d908mr3018415b3a.1.1745078289029;
        Sat, 19 Apr 2025 08:58:09 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:1195:fa96:2874:6b2c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8be876sm3464157b3a.36.2025.04.19.08.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 08:58:08 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v4 bpf-next 1/6] bpf: udp: Make mem flags configurable through bpf_iter_udp_realloc_batch
Date: Sat, 19 Apr 2025 08:57:58 -0700
Message-ID: <20250419155804.2337261-2-jordan@jrife.io>
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

Prepare for the next two patches which need to be able to choose either
GFP_USER or GFP_ATOMIC for calls to bpf_iter_udp_realloc_batch by making
memory flags configurable.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/udp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index d0bffcfa56d8..0ac31dec339a 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3395,7 +3395,7 @@ struct bpf_udp_iter_state {
 };
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
-				      unsigned int new_batch_sz);
+				      unsigned int new_batch_sz, int flags);
 static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 {
 	struct bpf_udp_iter_state *iter = seq->private;
@@ -3471,7 +3471,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		iter->st_bucket_done = true;
 		goto done;
 	}
-	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
+	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2,
+						    GFP_USER)) {
 		resized = true;
 		/* After allocating a larger batch, retry one more time to grab
 		 * the whole bucket.
@@ -3825,12 +3826,12 @@ DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
 		     struct udp_sock *udp_sk, uid_t uid, int bucket)
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
-				      unsigned int new_batch_sz)
+				      unsigned int new_batch_sz, int flags)
 {
 	struct sock **new_batch;
 
 	new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
-				   GFP_USER | __GFP_NOWARN);
+				   flags | __GFP_NOWARN);
 	if (!new_batch)
 		return -ENOMEM;
 
@@ -3853,7 +3854,7 @@ static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
 	if (ret)
 		return ret;
 
-	ret = bpf_iter_udp_realloc_batch(iter, INIT_BATCH_SZ);
+	ret = bpf_iter_udp_realloc_batch(iter, INIT_BATCH_SZ, GFP_USER);
 	if (ret)
 		bpf_iter_fini_seq_net(priv_data);
 
-- 
2.43.0


