Return-Path: <netdev+bounces-204625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC40AFB7F0
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C1316ED28
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050F5215F42;
	Mon,  7 Jul 2025 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="vJCMhfP+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BFE214801
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903473; cv=none; b=GvtEI3uYtKJdyJoKZnAlThhzKi49NMBY9Ak4ZtLgSCDYZb/tqqwhYL1Ne+JZ2UBal1WlYVv9tMwmDLvjWNmSXRWdAlX9ocxE7ghT7JVIgwCPhtQ4GJILvDfcpprLgdXEpu+eSlZ4P4SnwryhQaIbmAp4G5KZHrf2c6nyXlahzIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903473; c=relaxed/simple;
	bh=e8mBfD/Mf3WsGUcN/cZCls6eAizCzOkMUL7ooN31tjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9POaL8JtKh26afwuPHISgCa02wLNO+PoyAdOqnmuFSnmiPobVLZ3WdXoCDxXLLT6FDseAMyHfODv/vGDiDYTZmjM6FBLmuHA9/k8Id53kHaBpJMYS96DuNewU1Ai3RTXIVOmqRD1h74O74Q9dgL0QJrZ3eArIbpBqWGhC9Zlsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=vJCMhfP+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23c71b21f72so4261655ad.2
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 08:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751903472; x=1752508272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RahNzvE7Os+o3No4Ak4PR/YrMMvz2u9H0FwyM+5TYQY=;
        b=vJCMhfP+SFDz4wPYQl6FVyH2otz5f8be83Todi329VdhuKWDQguEU0MVAvBe5L1u0g
         zNLwjJxVH41pic5CT+FZWaNgxug8dlxD6DWOiaUGfcsxYJWrrd5ZLgChO0c484RKTsDA
         T4/gP/IV7RAHTnRDSyT1gNTmA0lcUyyjOb7zd+KGdwaynb257xlsAVuZFxMADrSaOJQ4
         cDnUxl0bHkSxnOOO6UdtCd8cz29u1c1g33n6Sq6PwUEChBTEV8eCTPDBFqB7YcIOGr1I
         OSW3zODly3w2vCEgeNQN7ZhRyuzKtERkOh+uoOe8yMoZQHgLkvkaTZ/NulqPqIlM4Idq
         iL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903472; x=1752508272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RahNzvE7Os+o3No4Ak4PR/YrMMvz2u9H0FwyM+5TYQY=;
        b=X7RPdjF/aOnGkZJmL2FVoFeltpJpNxzJHSEY2uK0drLs38LZPnevgIby2qfmV0CEdl
         iu+xcby7RLQ61CxWFayeZsQ/x5G7fP20OW2Yp4n5F6rrYi05o7iIQ5gBpCRDqf8X3JD1
         Wq2WHp+LWyLQMNL7X1+RnNAD9FaapYp0sIgcBJ+5t65XmSPyq+TDSIf32SAcGjE3kEq5
         IZYS2lon5WdJZZtphOXVecRyD6gzMI1Ecs5K1IKWXaPN7FyfJqKFyYRmn96QfcvrImEc
         T2pyBfI3VdGF6pJUbZlwjZe816Jm3k99+NKHJ7hhpKcdi2Hu046tDdEKgl1N7ZTf5I76
         zR/A==
X-Gm-Message-State: AOJu0Yxe+iTXHkAL2/0pSzGBeYJMki+wwOOPB2jM1gwXnsxe04594E0A
	IhYGGSp9k66kLFXmJSj8TNDNA7/E0+7pme0wufOVsonzPrf6nji5Bg2QePouKRxIdCmAeUsRcwy
	spI2T
X-Gm-Gg: ASbGncubhg1dWojwfhKKYthbWKL27ExZW6HDrtdxIaIHbO42KWAPAYVhoZlXT27c6t4
	AUYYoIihwWCz8u21E5q69lPponMq3sFSIlvUXeFDSdw6T3rL6xzbQvkJUj/7I2scl0mmloDbsEw
	WNpNWFwa8DR6byyR2didooPonOBSAVSdb9k0QMxzoHVZb80CtIMpXFKQe4Pk+WrVgMKqUU6iPd0
	NPbPu4NX6YycfFYDH9cGrXYpb5oaJnRf4PBuSUBc1bYHGFj0DjgXKkky/UHMS1FvAEse3zpefzn
	cGhmvub9WVwoJDmw7dk5APd5vR40b9AZN2n72n8hx/ONoNneCfk=
X-Google-Smtp-Source: AGHT+IH6IkZ61Q4RdWlbcMoS/QrTX2L0cUPDRjHCnUFiQTwiLkIu8zdDVNY8MTVLkGFEtfPP3jFRsQ==
X-Received: by 2002:a17:903:2302:b0:234:bfcb:5c0a with SMTP id d9443c01a7336-23c8726fe7emr74216665ad.5.1751903471664;
        Mon, 07 Jul 2025 08:51:11 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:e505:eb21:1277:21f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455eb3bsm95772065ad.115.2025.07.07.08.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:51:11 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 03/12] bpf: tcp: Get rid of st_bucket_done
Date: Mon,  7 Jul 2025 08:50:51 -0700
Message-ID: <20250707155102.672692-4-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707155102.672692-1-jordan@jrife.io>
References: <20250707155102.672692-1-jordan@jrife.io>
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
index 565afaa1ea2f..8a1fd64d8891 100644
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


