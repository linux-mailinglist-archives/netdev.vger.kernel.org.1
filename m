Return-Path: <netdev+bounces-229189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA52BD904E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8A93AD83E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AD6310655;
	Tue, 14 Oct 2025 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/uM4FQO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C8310636
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441232; cv=none; b=ccx9YMOHigCb6YRPI8iaRP4w6Wnld9xXZfZLQoZpevG3m4FmQ3a8IKWmAm6amh7oGUah3NmLFIuYrj2W4H45+nApoxNpjrnaxBHkFDNXBxC5Z0lw8KQEXaiIdZ8qEo7ybSGMl0cNSUB3e4MvuRbJWYsH8cpXu9h9rM9qkSxtinU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441232; c=relaxed/simple;
	bh=LpUckPTb7jH/83BNuJSOxN+YPu0vw1zspxIFiooWH8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cea6QhhxA4MgwdyLF5xr1Hr3yhjhamyvP7+Fjdu6bcTaXL97yDKXYdKTnnrKnf1jvvq+Gg4WUFce04T+hpMM3tjbWhfhbgHTXq1HzKdC4+P1Caw2IEZyidcaCutgQOOFzetYkraMp0MwCvHnGQ+9xMsSg7eNqcEUdJPe7J2cFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/uM4FQO; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-782bfd0a977so4392158b3a.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 04:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441230; x=1761046030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hixVqDtG5kfwkDmbrI9+bLiGthHT6YGDBRV0eBz8fPk=;
        b=J/uM4FQOeU2neSw6b2Q3CXLQX41mnJa4xiREIUXU/k5ttB6Ai89oCC3oJO/zi0i4Em
         smD+9BI6AdsTdwtFbhYrqYUHdSxdu9dcNP/wQ81Q4ZN95YKF/kny8Pp3UJclJf57e+aD
         b7TYSrlIeHMzacKNdtSqkGLP2CpEOFMsLkedE6a+J0ft8tZrS9or9RTRHDoW2oaXIsu8
         2094ih3A3111ggguyWvHMGbKpekHw1efANGxwJKdFHhUrP3tu83hZO1WTPFMC8UjtYRo
         oYbfT7V9oBMni/HJZNScjSnxxfiTEAO5EJjhxCc9yM4nub+CBCDZxF5kvaAGqfkNrVxV
         6dRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441230; x=1761046030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hixVqDtG5kfwkDmbrI9+bLiGthHT6YGDBRV0eBz8fPk=;
        b=voCh/3Ww1Hvgvm8Pf7GISKlfFxLWXTgMUdsatWZYPkNwu87Q4LGrtkGBNApzQ8lhgu
         Y4OG7T1ajJGCIqEHhLAkKA+UmEPPcre0VpEyGRELv+uK9/sz+rcDs7QCVkcAn/T5B2L7
         LWYH4i2Gz8+y1O8g762uVFQlgTan08S3QioBPwIwzhLzyOiGjlw4jghs6db3KSjI9E1p
         PdyALXk51zq8x1pztj2e1F/eEDL2fDSde/35zP4PvcMaDTgAe5vS3c75+8WEmm7K9IA6
         8IecWOFvBh17GEZyC4dJWdASMwQo5a1wlE16JNHdPvaTvRilooZypjUwh1l9ohv7/su3
         OO0g==
X-Forwarded-Encrypted: i=1; AJvYcCWXCEWtlgPR1YDVcAhU4u0jea9HF0aTv3EizNZOq6sPQ+/+aQ0tkfSHGYamZql096M68xRy+zw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2AVenxic3hbJV8m+pHlpeL0DF1JwHDYOs09mui91B1DxwCrjG
	QQStg523F6SdV9zNuZzLczEeNTqXr2uRZX7K13z2FeOYdEsrS3/cJfjJNr6ZKK+Y
X-Gm-Gg: ASbGnctqaLvPgVAdus82TJZTCQJkSpOX41bGCLpWu2+k7FDzTcgp8/mYEJ7ViULdes6
	HAnRGTSDnKeAaqoU1iEmLkVuo7Aot5A0lLCSAyiWzTfo8DcizJNlCejxiqqxnGwjZF7mwuQSEGG
	sDV1P7vC6axNZVJjMPFtUxVQr03/6LFHwDE8R5/s2fANWXprFwTuKvK5HREMNDKgR6ddB9otytm
	+IvGdgTmjNwCXfQgtl0lDSaQPr5f6d9ZtUQWLamV8kLqFr4Sqa8aejPMJIrl9veoLWgeieztXyv
	dfaiApEBQxMcIRqEDZWAgpjTf26aPzB3VEQ5NFe8qVgz0NQXwP5H6b4XCtPqCmBygQ12vXPfnXm
	4O/rtFxjgqz/p4YI6q2VAtnx+iKimla5jawWwGaDzCQ==
X-Google-Smtp-Source: AGHT+IGSGyLntq28lnbnZr4P0EjlrHeHsCeSBY4tltUAlQ5AUSXAYfEcRW/aomPwYfhGFSurWqTmGA==
X-Received: by 2002:a17:902:ef06:b0:24c:ed95:2725 with SMTP id d9443c01a7336-290272135camr265404925ad.4.1760441229532;
        Tue, 14 Oct 2025 04:27:09 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e2062fsm161807285ad.48.2025.10.14.04.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:27:09 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	paulmck@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jakub@cloudflare.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 3/4] bpf: use bpf_prog_run_pin_on_cpu_rcu() in skmsg.c
Date: Tue, 14 Oct 2025 19:26:39 +0800
Message-ID: <20251014112640.261770-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014112640.261770-1-dongml2@chinatelecom.cn>
References: <20251014112640.261770-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace bpf_prog_run_pin_on_cpu() with bpf_prog_run_pin_on_cpu_rcu() in
following functions to obtain better performance:

  sk_psock_msg_verdict
  sk_psock_tls_strp_read
  sk_psock_strp_read
  sk_psock_strp_parse
  sk_psock_verdict_recv

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/core/skmsg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 2ac7731e1e0a..1d3f47b07659 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -908,7 +908,7 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
 
 	sk_msg_compute_data_pointers(msg);
 	msg->sk = sk;
-	ret = bpf_prog_run_pin_on_cpu(prog, msg);
+	ret = bpf_prog_run_pin_on_cpu_rcu(prog, msg);
 	ret = sk_psock_map_verd(ret, msg->sk_redir);
 	psock->apply_bytes = msg->apply_bytes;
 	if (ret == __SK_REDIRECT) {
@@ -993,7 +993,7 @@ int sk_psock_tls_strp_read(struct sk_psock *psock, struct sk_buff *skb)
 		skb->sk = psock->sk;
 		skb_dst_drop(skb);
 		skb_bpf_redirect_clear(skb);
-		ret = bpf_prog_run_pin_on_cpu(prog, skb);
+		ret = bpf_prog_run_pin_on_cpu_rcu(prog, skb);
 		ret = sk_psock_map_verd(ret, skb_bpf_redirect_fetch(skb));
 		skb->sk = NULL;
 	}
@@ -1101,7 +1101,7 @@ static void sk_psock_strp_read(struct strparser *strp, struct sk_buff *skb)
 		skb->sk = sk;
 		skb_dst_drop(skb);
 		skb_bpf_redirect_clear(skb);
-		ret = bpf_prog_run_pin_on_cpu(prog, skb);
+		ret = bpf_prog_run_pin_on_cpu_rcu(prog, skb);
 		skb_bpf_set_strparser(skb);
 		ret = sk_psock_map_verd(ret, skb_bpf_redirect_fetch(skb));
 		skb->sk = NULL;
@@ -1126,7 +1126,7 @@ static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
 	prog = READ_ONCE(psock->progs.stream_parser);
 	if (likely(prog)) {
 		skb->sk = psock->sk;
-		ret = bpf_prog_run_pin_on_cpu(prog, skb);
+		ret = bpf_prog_run_pin_on_cpu_rcu(prog, skb);
 		skb->sk = NULL;
 	}
 	rcu_read_unlock();
@@ -1230,7 +1230,7 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
 	if (likely(prog)) {
 		skb_dst_drop(skb);
 		skb_bpf_redirect_clear(skb);
-		ret = bpf_prog_run_pin_on_cpu(prog, skb);
+		ret = bpf_prog_run_pin_on_cpu_rcu(prog, skb);
 		ret = sk_psock_map_verd(ret, skb_bpf_redirect_fetch(skb));
 	}
 	ret = sk_psock_verdict_apply(psock, skb, ret);
-- 
2.51.0


