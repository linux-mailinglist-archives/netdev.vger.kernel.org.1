Return-Path: <netdev+bounces-187490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 365CDAA76EC
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 18:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91931C06EED
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2BA25D55B;
	Fri,  2 May 2025 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="1RQcOA5j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0650319D081
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202539; cv=none; b=VLmPhWKA+3+XryOw5mrdEe5PlIrQIphkomb2j863bAK9qA/Zqf7tv0sDbweduD07Ph2fHi2ZWOF+eehocOCCU9GXsSnqF9XK3sjFd2oGXdPxTHb0Q9CNu/4d9h5rzFGDJSIgWYZt8vsM5hmVS+vKoLBYFWz5CvQriN5lIfo/dJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202539; c=relaxed/simple;
	bh=0K881L74U7bYvvdXN0+69csdt06AemHwLvp1HDC8jxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkPWt4bc7DFoSaRA77SN9v/Xd1X3UCsJI1gX75d7tLdqh1IHsviyhD9NnoYH9/FY7kAhCI5K3ErHHn7OCq+4B09Y1PSmSfn5gI4y1SxSsVBzojN1l2BAXQl5kYliJKr4Gd/fkiNTHP8YL3R/dzLqcWOolvEa1sIfc18K5s5BUlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=1RQcOA5j; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2240d930f13so4733425ad.3
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 09:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1746202537; x=1746807337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXF8c7fWh50nxaBovQJDy07kpqb+C38tl5eUnuOLhaQ=;
        b=1RQcOA5j4OB5iLHJLhOSqZ3E9TZxA/StIhGFeBdFjL2l1wYOv453DePYx1KgRgAK6D
         7MQrVQ87IOydFDzKgPk3mf/BPFka4xuuTvL700nLipUYaeHLFZGEjUa+17CKuDLtODhs
         XdjwC3ra+wz34+D3e14CxmOv3ZsQ7l4aR9yIFC4jIEStYDmV1wKi1/OAAPliJEWrvNBg
         HLK/SuD0dNwkFkWWILV5apI27o5z5HOeX8YpHO+mKvklJaxO9hr38oJ9hTKvY/dlLEnU
         e0ASWu7e6fBkfJoIGJFzjVQ0/n6cD/oFpD86siyxGMoZxaRe9mjyCcDTm5YY1QqQ3R2w
         mVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746202537; x=1746807337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXF8c7fWh50nxaBovQJDy07kpqb+C38tl5eUnuOLhaQ=;
        b=E7sW8QKLWsh7leX9MELwl9rwEPvrBbXMP9YeYGzvwv4fBBIGEMeQlv/XAzklVPTb3F
         5gziXimKCyw8nPghxfDji+QIK9Yw1dDb5CdRqUG9VRP7v6ozKTzsI7znu8MVMpM3T/JI
         uzzNGUC/15e8XZR76GBo3aUjgl6AFvazCuU3k4BK+EX+RdgkJIKhBQSYqnmC3cE43EeV
         ZAccpQckyNeowG3QH8Ura6JQNj9JaEPPPShGZZYvxTNEVolBOkynSEzZEHoqXIenXolY
         BoPmpf3uMD2EH3rx9FJvhTPj23yqFr7QjugcFzw2TTa/LfOJAwV/+lMkasM29CnJUhsZ
         GC8Q==
X-Gm-Message-State: AOJu0YxtF/CdRaptYBmBlRseNdYW2qUJufEUYY74dWfhvjw6WbWC+4vw
	8K45vJF+ozpkT6+gwtrCOjTWOwrAEwzNJbq2ZLnsODhd1ofCpeVCwVPjUty2rY+AUZMOzokYElk
	tgOY=
X-Gm-Gg: ASbGncsAs61SkPSQLNQabbj+xzDB9igqFQv4hKylkIIGbJZiLzjnezL6Dkg+dV41GNe
	MmFlSobB2fvyWWGuMIBm2PLQ5gnWIeYqhyTgHuPcF0Hdi0S019++Xp35n+NiOtcyJ/fW0g9i+j8
	y8tKdXnZAxmN9LPvanc4KKdgaT9Y1R7Yw0UxqWdxoERtgyPAAuG+kQ4GqBSY8ZBbJgLpC8VHQqu
	zFOy7U64L9YjNHckhVM4Q5k61Ix40wy7ncxUi/sULZSlCzWkhrSaILQerTUuys5FEOPs8d0vuyo
	IFaOHW0LL4n+085uShGSHGyw6x17wQ==
X-Google-Smtp-Source: AGHT+IGIBhdyH0LCnt3a+G1gksyDPFu2aJ2gq3b2jxlpjr2Q+iqAeP8wdeOaWzpRq7ngR0KZWVnsMQ==
X-Received: by 2002:a17:902:c947:b0:221:751f:dab9 with SMTP id d9443c01a7336-22e103958e7mr20596455ad.14.1746202537166;
        Fri, 02 May 2025 09:15:37 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:7676:294c:90a5:2828])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e95c3sm9572135ad.68.2025.05.02.09.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 09:15:36 -0700 (PDT)
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
Subject: [PATCH v7 bpf-next 1/7] bpf: udp: Make mem flags configurable through bpf_iter_udp_realloc_batch
Date: Fri,  2 May 2025 09:15:20 -0700
Message-ID: <20250502161528.264630-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502161528.264630-1-jordan@jrife.io>
References: <20250502161528.264630-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the next patch which needs to be able to choose either
GFP_USER or GFP_NOWAIT for calls to bpf_iter_udp_realloc_batch.

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


