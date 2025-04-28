Return-Path: <netdev+bounces-186512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6373A9F7E4
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D6537AD3AF
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B88429614A;
	Mon, 28 Apr 2025 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="OnpqG/EW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC12957B3
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863254; cv=none; b=ioSpqpw5RumXGi/aEP1eL4HasWeIof2LUFlodQ00JY0OTWA4pd2eMI9SxK8oTLBMw5uAaIdLW1HGqE3HDEMi1iRpiCqd9/arc3KHGdlrXwKvwfnFT7b6EYXVAFV6Ub0tJEcWilejWCNryltv28wDm0jppGOCD00bHWxNq4oXXXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863254; c=relaxed/simple;
	bh=hVcaTKt+iszIasco79l44dPfxtLmpHpJm+A1tw9CwD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+J6+YDeGhDJnbAoxeCqUndJ/kQmZVXEApZcO7KVbWB/VS8NamMbQDHxlppZIuj05qwOBy528iTpxyGWgWf2dpSjWCgFOBZM2YEHHye2FGmd/wWNTNoh9R8sPeJwzHfkHhwV+BFR2e4Wy1lFAi7qDIVyLnnN7SeaNgCRV+mdUoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=OnpqG/EW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22403c99457so11828915ad.3
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745863251; x=1746468051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lXIvd+Bwv1ZCEE4NHcc/W0ZeyVCwUwS6L0uza6G9I8=;
        b=OnpqG/EWV5Fzis/W59/C27EJUn4QEQlJV/lpnQvvUfCKOpxhqyMrHHj+ZaPCscltP1
         sl85OKdtBbzePebSxXRgXScn6MMzwj7Oczer886/jpFKfR/y50/No9uyjs9FYx9lXudl
         Srn1H67e3/nn0kS+LcC5bNaXlS8L3wu9/gPzhDB6cRzqXuWY/zUAhTguFih7B4+zcvNk
         +dQU8FmWZpCnimQbAQJa/1YZJAAC4XZsiE8Q1nrOpO1714UurpjNwCnPj/Zj5dDRWLMC
         zc0fjFhVbbJG/cDAsf5iwzkwlB08okcGycwsnnPQ8JkMLrGpB8gRtpM1ukADzszedilM
         rJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745863251; x=1746468051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lXIvd+Bwv1ZCEE4NHcc/W0ZeyVCwUwS6L0uza6G9I8=;
        b=lvqrppWTZ5oCowCrjXcCdJEzMS0a6DWCBRoL/nc6tNsGYkxw0CT6EsflpWhUqbVpHQ
         5FKbcTeugcYZq+OnAPbW5b45ijdU4QdTjhZPpNEcySIay6bjYIXx7Ay7vduEP96y7i7G
         CozJmavsok7M9AO0XOUrWW9A00G4hV5r19C5fXH+mwaUY/1yKqH2/2HvYfmivt+a/BIc
         B3S/Dz2oeFJXwM9RCATV4L+OuOVENvIG5FH3mn0iKvgvHCsXElSydKfW4oGJCv/yP7qS
         ICAu87SZ80rqLni/EepOZ5vDxARIOC0ATpLsIdrDgdIxCmO2Uq3DxwHDZ5ocvHuJxmgD
         fSBw==
X-Gm-Message-State: AOJu0YyjmB3K4EW0JLh4oPuk3CPttpLbmy0j4kZmLtgX3+CVPxZTbChk
	S/rH28gSOyoeN8sLowHh1YUooTvGVD1xLkv1dHPzKjRjhgERqAE1qi4ZDATTiBvNtRkY8OGoCcl
	97l8=
X-Gm-Gg: ASbGncvv8EFnzd9z9LhOJubTNuD9pUa0ILQ7v+xWAKkY1PxaLK6dkoqv3T7B6o6qDLO
	cKk2g383drtyAq4v4P4r/vbdBD5hHTg17hqtzDDQxbNGgueqPEtMN9alxvPtYvgLyG2ssm+QPT0
	bywRHVuC+LgC7l2SVHJ/TKKHt3QTe6TEa0h2slWdBceNlHSHa2Ehlkp2lasYfMRbZVBG+8RkhfG
	OywLKctq8yOgJhScojVklOx9jDIKN2hq9wMsHNKPWP+jG2hVmPFYO1BvOqHQycLu05tjM0Czpa1
	7hAzLfgXwiahjAhWAbqBO4dsUw==
X-Google-Smtp-Source: AGHT+IFwuJ39QFgHSmK1OhTb5CX+GoomUkhaYSki6PhJF2vvcS+aeS/GLoglU6ZlWSgttkUtdICyqw==
X-Received: by 2002:a17:902:c40e:b0:21f:1365:8bcf with SMTP id d9443c01a7336-22de6edcecbmr209585ad.10.1745863250737;
        Mon, 28 Apr 2025 11:00:50 -0700 (PDT)
Received: from t14.. ([104.133.9.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52214ebsm86204235ad.246.2025.04.28.11.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 11:00:50 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 3/7] bpf: udp: Get rid of st_bucket_done
Date: Mon, 28 Apr 2025 11:00:27 -0700
Message-ID: <20250428180036.369192-4-jordan@jrife.io>
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

Get rid of the st_bucket_done field to simplify UDP iterator state and
logic. Before, st_bucket_done could be false if bpf_iter_udp_batch
returned a partial batch; however, with the last patch ("bpf: udp: Make
sure iter->batch always contains a full bucket snapshot"),
st_bucket_done == true is equivalent to iter->cur_sk == iter->end_sk.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/ipv4/udp.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 5fe22f4f43d7..57ac84a77e3d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3397,7 +3397,6 @@ struct bpf_udp_iter_state {
 	unsigned int max_sk;
 	int offset;
 	struct sock **batch;
-	bool st_bucket_done;
 };
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
@@ -3418,7 +3417,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	resume_offset = iter->offset;
 
 	/* The current batch is done, so advance the bucket. */
-	if (iter->st_bucket_done)
+	if (iter->cur_sk == iter->end_sk)
 		state->bucket++;
 
 	udptable = udp_get_table_seq(seq, net);
@@ -3433,7 +3432,6 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	 */
 	iter->cur_sk = 0;
 	iter->end_sk = 0;
-	iter->st_bucket_done = true;
 	batch_sks = 0;
 
 	for (; state->bucket <= udptable->mask; state->bucket++) {
@@ -3596,8 +3594,10 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
 
 static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
 {
-	while (iter->cur_sk < iter->end_sk)
-		sock_put(iter->batch[iter->cur_sk++]);
+	unsigned int cur_sk = iter->cur_sk;
+
+	while (cur_sk < iter->end_sk)
+		sock_put(iter->batch[cur_sk++]);
 }
 
 static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
@@ -3613,10 +3613,8 @@ static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
 			(void)udp_prog_seq_show(prog, &meta, v, 0, 0);
 	}
 
-	if (iter->cur_sk < iter->end_sk) {
+	if (iter->cur_sk < iter->end_sk)
 		bpf_iter_udp_put_batch(iter);
-		iter->st_bucket_done = false;
-	}
 }
 
 static const struct seq_operations bpf_iter_udp_seq_ops = {
-- 
2.43.0


