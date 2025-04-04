Return-Path: <netdev+bounces-179405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52E2A7C622
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 00:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCEA3B8D62
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 22:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C9421C176;
	Fri,  4 Apr 2025 22:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="tIDQPNda"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDE5199E8D
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743804194; cv=none; b=tB4c8Vt20VDW8dRB5j6wg3w9X0rsJPoI+f5/d0QkeBcNNGYMGbFozBdeyKnQ5+hgCfdJbRc8gdAWi7B44BoqCgImS/616ap9DnzPrr45UwU7TRnqz0V6tLnHJM4g7Q5eMqv6w4HcwdPFts/opjSmIvV3PXEY6Lacve3UaNRbREE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743804194; c=relaxed/simple;
	bh=wEHFPVdrORgpLcGZ+GvRrXkyZBaib+TRXKwG8iJEyPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UC3gq9MzpKPPGUSemdxw0cPp2+587dq5uLFK8RG5fl3TfzIrNrd/WKqRUw8PrxcLSOq3BUP1yTMyq6G1Z85hZ63N8B1rzKOwGMhGLHTlOD13OIwdPIPcxe2s3AZbnRXv6MvON3oSLbAw87+hJWmO5AkpA1W3Hdz9hZM4uiGyuNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=tIDQPNda; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736ac19918cso468457b3a.2
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 15:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1743804192; x=1744408992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DntxylgD/bFAuSnepybtNVZWTfXmXLq0Ys2Pz9lSxJ8=;
        b=tIDQPNdaLXvzIWLU8VpVd3B/+DWAV4UeOf8mXDBMNpoj/p+wcHdJV6plAfDhjQ9EMk
         urFVXYaFO2fJcfctOGg+3seyetOMyz1kBjYaV96jUojOphHmlxkD0Z/UGAaVJhSkpmNz
         xnpnOOY1Dfi5O75NaSiChp60/ecniP3Li+tbt0rK+fC6TfqZsR4YvS0tPeUoFUuXBVGC
         2//u+Ueg6ZmbIOwpKzflwCHCCldOJnPv1oS92EXJBqS0l/T0PMbLE4ivcebfAsFOKBqi
         m0ctqgxOhiy4Hfl7UyHEf2JTSC5CjfQ7teWI5Oc/35yIeVkfqRKWwQfjRh/XhS0GEaHP
         /Y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743804192; x=1744408992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DntxylgD/bFAuSnepybtNVZWTfXmXLq0Ys2Pz9lSxJ8=;
        b=j2mzXXi8B8dwcE2NMSYd5/a8qqBQHfifW1r3w4dNBuVzDIJX3M/X3ltsd+dWXezbHU
         DBaJFkj0TQIwLW8TcyMzPFR43doMDFpFUIhxh4BQ76gDr5iEZxgUaPxHxnrVuEXmvxK5
         Cj7C1YaErJ2ficnboE/B2zqBlhdqyUrEWovBi0+mmX+lWCL6OirGOs6+EIYhoG63PlRu
         8lMiSA5wDdmsi71KUUlJDNlEqco29ZueHYbhlbxwy3trM24Y6I7hEeUPb9ho2OBRFUB1
         WYEfZ6eAQPyJxAYAfvfSPtJg8Q3OYFqV2org0TyKFUZC4SOtcDP53AsOJhzwTO5mkROc
         pfxw==
X-Gm-Message-State: AOJu0YzQNTPAaUaijMBqQYCNav/opH0iFg81TYbw3d/MMOBHK79ZIZhR
	3skg/oIKWFzsnKLAz39sPDTqH5ffhrlUUQaDuw2Kg8DZRmn51XEUAcPy8TQX00uoWEFCpD/2peO
	8UCg=
X-Gm-Gg: ASbGncuyJh6XpyoXKHQkHWCYl82guzs2G0e8ZT42fn9qLJrQJrWJey5G7Fpx8SxoBjy
	cAAnt+AjjofzA0xqMPRVqthLAQs3pE29zJX+BrwC/PjZwU+cjoDKp67HLv7OPdKFHScxJI/HZdm
	ETewBMa9+fAcPRGE8ByUkglzOZ/5TnSbeCDRdGBoS3hF6bY5kIDpXoA8LcQhl7ENZP+sWpCtbAK
	0pUIf5cQrji4hbUKGxpfCgqlaY+18/N7251kUnJPcnLDRTu67wZq6k+BaPPwOT/YNFqPRV55sBo
	IQbpWaaL9UHAQ3R/lXRF25U2CcRixWOZvQ==
X-Google-Smtp-Source: AGHT+IFWHYn0AllhS716qupxgtFwYzUHgec820X/2ZJk5CJ6oDSeh9cS8blGJ2dikfs/d28HhYpu4w==
X-Received: by 2002:a05:6a00:10d1:b0:736:6ecd:8e39 with SMTP id d2e1a72fcca58-739e48f069cmr2673314b3a.2.1743804191761;
        Fri, 04 Apr 2025 15:03:11 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d158:c069:399b:1ed0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0deddfsm3953570b3a.162.2025.04.04.15.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 15:03:11 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [RFC PATCH bpf-next 1/3] bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch items
Date: Fri,  4 Apr 2025 15:02:16 -0700
Message-ID: <20250404220221.1665428-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404220221.1665428-1-jordan@jrife.io>
References: <20250404220221.1665428-1-jordan@jrife.io>
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


