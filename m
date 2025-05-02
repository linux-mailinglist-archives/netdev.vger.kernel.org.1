Return-Path: <netdev+bounces-187492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B995FAA76F6
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 18:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF5F4E3838
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 16:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2064B25FA09;
	Fri,  2 May 2025 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="FighO8W/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85F325E46D
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202542; cv=none; b=WUGm1PvMkswS4PZmgsFu0Jjjg7mJznKJpbjOpPUmxcClvXaR6rs018miKhniki8RBzYo/hjHSVsV+8WaGDlWJPnouJJunJrNQtG2AapD1hjbozDBVcut8USph6gIXyp8OFY6HRrLi6xlM1kUOFrGDWb3VYjKFa6SG1r1sLrhY9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202542; c=relaxed/simple;
	bh=OjOMJqOJGPBTNtnUtvDX2IcMPxfwj1uYp1dmaT526ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iacRmLzGXbl/mqwg8FdMQz+XwkoJWdMMemSyxaZlR6GyB72htFz3xc19RWo0wS7FyW3PUctpMB83CuVM0qr/8VtaVZNAbB0wkhhJP7MgiNH3LowkYsQa800gY/IPecHKLRwce/u4AT+R1AltqnNwStJujmnXclIqBvhzTKxg/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=FighO8W/; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b07698318ebso286794a12.2
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 09:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1746202540; x=1746807340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBd5lh473P+fBG0hZXEigls+jUY1DqU7IwX3LjM1SMw=;
        b=FighO8W/BDJuDnZfrlxhrl8FQa1p0/I1SfFaEDYzpaIl0ad0S8ZAgTahzRElZYmgqR
         gXwHjyZjBfN1gi9trcmHPMyHmd0WmGDITD/uzH6m/t85VuD1maT05zvy8fEAlCl7bpUI
         PyCYhtlpF38EeCt8zdl9tT48xtHFgTwIoH3thk/snBqibFhf+25ZMTMS2tMmXBxRFLpR
         CIP28upWfo/iQB27AtLW1QZIbMLLkzVzRYkfDUqEA79xdHiCieFiIxetWIs5dpIe+ieN
         srTPkVSac8pgv3sKVU/UhxqmkcXWRCbK4VEtN0KD0uOghDHFGlSqGyAQho5ZZAYL+mBB
         i16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746202540; x=1746807340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBd5lh473P+fBG0hZXEigls+jUY1DqU7IwX3LjM1SMw=;
        b=SscVuWpMr1rAp7b+llK8XIBmp4znK7c/TrKJC5IGb3JH+2tqg/J9V/CI2ZRZpmbyiG
         eeijvicKBcFN/wMyU0ie+EZcWngjSLnXWQ+tZrEIqtY2PTZkti23qPyDF6UTAUXGohPg
         uaHqWlejy4QKRym0/pNmHLJKpvw1DI43mwdorz67/v8FigiKrIBwVUFj5agiA30uakP6
         g1zXUvvhNQDgixvXfrTo7SzrdqtKenG1mfK5D2oiCJh6NMyWQNbEC0crYKdRRIbXohIn
         IWhXtsFwlAlpZis7i/Sbh8wHUiQ15ZYx4GbWszbYVOLkNRZE5/kU6vz0FcquCbzKmNUP
         Aotw==
X-Gm-Message-State: AOJu0YwwE7VVU5SgV/ao0rJHCpyphlmm27zplOJiwablt0lsD30DW53n
	MFciRR2mmgAJIqKv13oWOHbeNP6PmvMUUpBgh4W9UnJGLqF1G55yEBYlwH8B+EFSAd5Szl83xLU
	qMvo=
X-Gm-Gg: ASbGncu2b25QyXYMlDUo9VwtsCkzpD9fcPF6t/kV+3B+RSX5gUEB62wVNdV6rAL6DDv
	hwV02HcV8LyQ2rjh61OHXaq8wRiRbgb5NVROH9RY0NmoDiPlW1MA//EPQ4Nf2bI2cT6DcTDB2Tg
	fjTXGRTxNQiqng+5sGeTLgBLU+9VZgqNE4EhMS3QKl651OO9/B89NUMFlm48XSrt1/jU8HPdJG1
	ytyQl8TFNWIrU3qGsO/a9RFuzxcxCNqqVCGb4C+W/wQk8y0BRfT/ohzbpRGS8BvgqdrK8gbyCfJ
	tdW65Yu5PuKLsUWylF74yZ/tvN1TQw==
X-Google-Smtp-Source: AGHT+IF9wbjmN4oVb9vD42neTt/A3hNKgc+YHSRySUnFSFFXb8wo0QKQMMJx97fm+3JDTnSllf+6Lw==
X-Received: by 2002:a17:902:ce8a:b0:224:1936:698a with SMTP id d9443c01a7336-22e1031ef37mr18457475ad.5.1746202539682;
        Fri, 02 May 2025 09:15:39 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:7676:294c:90a5:2828])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e95c3sm9572135ad.68.2025.05.02.09.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 09:15:39 -0700 (PDT)
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
Subject: [PATCH v7 bpf-next 3/7] bpf: udp: Get rid of st_bucket_done
Date: Fri,  2 May 2025 09:15:22 -0700
Message-ID: <20250502161528.264630-4-jordan@jrife.io>
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

Get rid of the st_bucket_done field to simplify UDP iterator state and
logic. Before, st_bucket_done could be false if bpf_iter_udp_batch
returned a partial batch; however, with the last patch ("bpf: udp: Make
sure iter->batch always contains a full bucket snapshot"),
st_bucket_done == true is equivalent to iter->cur_sk == iter->end_sk.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/ipv4/udp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 5fe22f4f43d7..bc93d2786843 100644
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
@@ -3893,6 +3891,8 @@ static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
 	if (ret)
 		bpf_iter_fini_seq_net(priv_data);
 
+	iter->state.bucket = -1;
+
 	return ret;
 }
 
-- 
2.43.0


