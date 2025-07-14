Return-Path: <netdev+bounces-206809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F10B04727
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 20:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E73164B34
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4D426D4E4;
	Mon, 14 Jul 2025 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="2XlkrjZa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E7126CE3E
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516574; cv=none; b=p40PCyUa9MPXHBVo/cDItpnjEnNUjORMk4KyEGoy71H+VeQ2UquY76Y+uWOfnwX46RT0ZNPlp6ekzl4h+FbYIBvegcghd+kNU549dRC3MCe21pqhd9TOAHzkRPCNjzoEmeta6EJYtux9KCJaclZJechXHKGhIlEN55uOJDvw1mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516574; c=relaxed/simple;
	bh=+RKf0LxsahCX0ru/helpwnqrzojewAmbV20fE5ht/Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzXFYA10Ow+EwkkEQ04lPWL1k/rAAPejii6kM+EUHG6zO8rW8Y51iKoLNgg0PTrIBXebNu0fpmbxecOUDkfpIe6ttpOyJjJUqIeOu5F/wDtZ2B8vyJxuOHTxHG6MOANnfjaHXLIekUrQvjMQyOLvKiVr4BxevN1N0aVUP+cg9gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=2XlkrjZa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23c8f163476so3651885ad.2
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 11:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752516571; x=1753121371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAN5AN0xB7TXy/kniPi44+90iocjGvN8izS4op7BZfg=;
        b=2XlkrjZayJJU1LMdUuGvmhToX1Sf++XCI5iQujp2ANINZJ95ieS5J9mij/io0/b3aq
         TaZJvwXUHWD4F64VCvUiKprgQ+LoxY68DjZ2RyPL0fny3BloF9RN3fSPeiCfUcfVmH+W
         KXFBcv7531ZpxQXvIG0c4kN5AaEFffzjud27NnjgkVIVnDNmeOLxjra/GNJlgD2Zqy4O
         EbztMtrzyYL+cQbxl/QcWmHHkOUJCJhUagAoBW+qXbBbMU0+Q/wdN9+o6CmoULcm7Zis
         urdni6DAlyo7mtlxqdInNsqAAXIdG4QIG89inCTYvDabl9LgpwyEZlpjyD1kAptL56jx
         VKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516571; x=1753121371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAN5AN0xB7TXy/kniPi44+90iocjGvN8izS4op7BZfg=;
        b=dsljxThTI3Z1GVhVfaILFMgNs2716UHnJJqaNZvOrZn7nBukTasaDGdZgbtGVdCuCh
         XnDdeFDerU99xLNgS3T4E0tFFBoRxdAjd+CHMt+xuE4VGIgaeJv4IfMuUtC8Ch/gYbqj
         Q4LWi21d9UDbCpaV6Gv+O7saXpr3Xxtb+tdRnwo8vGNA6yoKyIAUrwrgBBRANqariVYX
         b4EncnxEMR0qYQTt39fVAPmiEkxQYvTD3L+s4m9oJwHj8EoOMMZICwfwwBGQRMi4nUZU
         /Mz2MQwHlnMFyU5/OhU00L24cp4PcW/h5lz/63EmFFFVWZLr2kyc6RMIsYJfozPAA9gP
         c6Gg==
X-Gm-Message-State: AOJu0Yx0TXdAqQBryrtJ4nTw83/ulihteQzKCW2Mk72rHcMvm/P5wSB+
	U00oJVoS3X+V7j71H9McybeI26IankuKOSi6MGxRzGBaBDTnXVUlhzVp0h8VZmd0BxzQL91v1eB
	NNiIm
X-Gm-Gg: ASbGncsxwGTQZqB9CkrJLx815uKPA0xHZOQMn6wrt6yshrSqjTn54tajk1Lzdp6tT/e
	LwudceOTqOznLuKGjvaQ6/s7rxIYKDvu5G1meX2fD0SoI5Pzp0k/ZGTghK/2W7xHRr3OvAKQedX
	ZQ0iWKWE6LMruUOt1baMiwZ/EquzMcEWI4iqT3FUBLeBzNeCRP/8aL9IpCy5eSySsCWB3TLH5RI
	SHwMAp7L1q0/aFDhBwiLnh1C3yKFDVaxki3gQUMp3q+gaGCuTFlA1QsMZ2e6Fx5gEWTGJHirtoX
	Y+AQrnDz4mo1iSDjKTS7NFJ/QNnMdUini+eDQssFc8SfL3WnOjhmdIvJQ/jAh/PUx51uBheQPlJ
	QwH4N2b+q2w==
X-Google-Smtp-Source: AGHT+IEIUNu2yQWp1c+rwcTYXm3EveQBiLSX+CaRm74lfj21g0/JJjjjItMKcG/CVoL0G8j+e5P4Jg==
X-Received: by 2002:a17:902:ec8e:b0:235:ed02:2866 with SMTP id d9443c01a7336-23def8e443dmr77543945ad.4.1752516570755;
        Mon, 14 Jul 2025 11:09:30 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:84d3:3b84:b221:e691])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aeadcsm98126405ad.78.2025.07.14.11.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:09:30 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 03/12] bpf: tcp: Get rid of st_bucket_done
Date: Mon, 14 Jul 2025 11:09:07 -0700
Message-ID: <20250714180919.127192-4-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714180919.127192-1-jordan@jrife.io>
References: <20250714180919.127192-1-jordan@jrife.io>
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
index 8dfb87be422e..50ef605dfa01 100644
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
@@ -3161,7 +3162,7 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	 * one by one in the current bucket and eventually find out
 	 * it has to advance to the next bucket.
 	 */
-	if (iter->st_bucket_done) {
+	if (iter->end_sk && iter->cur_sk == iter->end_sk) {
 		st->offset = 0;
 		st->bucket++;
 		if (st->state == TCP_SEQ_STATE_LISTENING &&
@@ -3173,7 +3174,6 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 
 	iter->cur_sk = 0;
 	iter->end_sk = 0;
-	iter->st_bucket_done = true;
 
 	sk = tcp_seek_last_pos(seq);
 	if (!sk)
@@ -3321,10 +3321,8 @@ static void bpf_iter_tcp_seq_stop(struct seq_file *seq, void *v)
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


