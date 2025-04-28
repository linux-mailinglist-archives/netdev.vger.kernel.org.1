Return-Path: <netdev+bounces-186510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 295C8A9F7DB
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 995257ACA5B
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 17:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3172951CE;
	Mon, 28 Apr 2025 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="IjzI0z3f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A345E2951A8
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863250; cv=none; b=N+p6O/py9fZvAWH00uQZuY41JOPa7H59oEH3PP+mqgmufxpfVzT5+ZRaIW9IQU8ihPTcInZO5B5bwMK4K0Na5mHuR8OLojBnlJC/OsqKJqT1DBTmqFfIs2OjAK9IZuqBuAJefYi6t2bUpdYV+pSiHfZhNeo9BXUq8pw6VNL0cy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863250; c=relaxed/simple;
	bh=FE4N9q4IrPGuc5oTUxK2galKDV4gY01q9sMpfWfCE8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4DkN44XGyceEISh7dw09rMX5MyxgNFjST+EPlB4RYEC5RDFCEsE4GSSHxf8YdTgz0ywzkcWZUhZ1KDZ/R5iSNZumyI+Qtw5IBCY0uzvJFHoG0ePBNhdAgWJldvbQbpWR0vx2fqDU/AZGTNw00dPluFcfID+dOZynm1ncWTrRrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=IjzI0z3f; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223fd44daf8so10509295ad.2
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 11:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745863248; x=1746468048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/v9cZZawYO8IzuXBE+ZYLFioHdu6gAmN1PnK662kQA=;
        b=IjzI0z3fKjglNIuN7gT9tw+roDITakINyy1ET4WjVtrkfXwBUlvKXJj1gEKM0QJJoo
         gv7Is5Gpbxv1AFWMHhV8iy/xmcH2KcGDTRSzoENbAu9YTqJc2/C7mxfmsKItGg7fW2PN
         QIv58qbMBJPDB1w1WRLChBfyCh3cjmdmn9Qw7lSUBQv278ZuPVRdBcQBI/NrNiACUpJL
         inganawETFhYkwwXS4SUKRMkZ25nWhYnnr+hvnepSz/2K3yFqsIUYF5+gOlNl1fkKyI2
         OPJ5UL2wqU53RtiZq0CVoxk9Ll4n23kZS4rxGLb3mszyFCyrySsu0uMUqZk7sYF6Zh8N
         vWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745863248; x=1746468048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/v9cZZawYO8IzuXBE+ZYLFioHdu6gAmN1PnK662kQA=;
        b=Xfa92fsVo7TRRgNJW2OJ21IDAeMHVDxM3dk3D8YG7hMzwCZca+UZM+wuEUb2vlRSKE
         u6MNI/uoYPUGWwYNbqDeSgJHAhXPvJH79IrR+kxCls0W7c0G4m7AQok+JntmeCHwoFBT
         hgwMPz4ymaS6ELPkNBsoWToYiokkJkqq/0336ZBV95VqEasaQsSK/Sa2zWTZFfNP9+tx
         lcEuZ9FWhCF1z4wP1+NAcX58UrqRyyGnBYZr79tVGbbIqRfHt+AH+tEJsTyzEbF0iXDR
         gsth8yMG3dELL5DkyomSH6yBfDGktSQxaTjmIw02uC3BPqpOHPP/iwbka2b22LqaKy93
         OxcA==
X-Gm-Message-State: AOJu0YzYBUaGijWEzZbYvrCOgA5FSaNiPW3/gHqqCBCCrK18+LIgSCJD
	r5oAUR3c2pxN2g/wSjjdGWs+FGKBjJtRpjC4n+c6jFzOrigeQJwO0RLBFdYR3nBDZNP2JjlpB8r
	vJqo=
X-Gm-Gg: ASbGncsv5X82wXAuVysc/18pPepsT2jxgapf79bvwVpCmZie82oLzw2+qPN8Ze+SBt4
	s6JEIkxnS/09yvbjOp4EehZ4oZ8pDBH1x4pNKDze63uoY6PASTZREWdgqF0pND9IivWQt5IQ1aU
	39uhrcAiGdcbzoTKHCgO0mrsY0z23S5eWDQ6vEa0Up8j+Q8AledLBjLGsHoXKXPP3weWV16Illv
	OE7vn+ZYP56SS2SJggoP+eNFxN2pnLZ6kRcmfNqpVSK6Q8paKoi9bVyiPdY4hwJUy6mmJgxnUEP
	XRU6lqievB2hqInR/0i9ZBVzug==
X-Google-Smtp-Source: AGHT+IGjufvM1H55aaaDht34xKNWU1wC+Lu5KCcr4QZ6tKCyck7RQfZWfrwVW8hJE58JGJ9iCYsUVQ==
X-Received: by 2002:a17:902:f684:b0:22a:bbea:6ab8 with SMTP id d9443c01a7336-22de6f214c6mr170615ad.12.1745863246966;
        Mon, 28 Apr 2025 11:00:46 -0700 (PDT)
Received: from t14.. ([104.133.9.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52214ebsm86204235ad.246.2025.04.28.11.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 11:00:46 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 1/7] bpf: udp: Make mem flags configurable through bpf_iter_udp_realloc_batch
Date: Mon, 28 Apr 2025 11:00:25 -0700
Message-ID: <20250428180036.369192-2-jordan@jrife.io>
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

Prepare for the next patch which needs to be able to choose either
GFP_USER or GFP_ATOMIC for calls to bpf_iter_udp_realloc_batch.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/udp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 2742cc7602bb..6a3c351aa06e 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3401,7 +3401,7 @@ struct bpf_udp_iter_state {
 };
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
-				      unsigned int new_batch_sz);
+				      unsigned int new_batch_sz, int flags);
 static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 {
 	struct bpf_udp_iter_state *iter = seq->private;
@@ -3477,7 +3477,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		iter->st_bucket_done = true;
 		goto done;
 	}
-	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
+	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2,
+						    GFP_USER)) {
 		resized = true;
 		/* After allocating a larger batch, retry one more time to grab
 		 * the whole bucket.
@@ -3831,12 +3832,12 @@ DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
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
 
@@ -3859,7 +3860,7 @@ static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
 	if (ret)
 		return ret;
 
-	ret = bpf_iter_udp_realloc_batch(iter, INIT_BATCH_SZ);
+	ret = bpf_iter_udp_realloc_batch(iter, INIT_BATCH_SZ, GFP_USER);
 	if (ret)
 		bpf_iter_fini_seq_net(priv_data);
 
-- 
2.43.0


