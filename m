Return-Path: <netdev+bounces-199133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA80ADF290
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 18:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D75F7AAEDE
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA112EFD94;
	Wed, 18 Jun 2025 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="ANU3+UJY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241572EF2B0
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263952; cv=none; b=mVfbncVQ5VFXv503+1euiUcNPx6FpSVxL4YOHHcxjBb41RGlUchbJAD4tVXGS4WqJuZp2Qr2N0JkFSzbwPQqypa+yHJNJRvm0X9kEhba+kCPv8gc48RN45ybVjBPQzUSHUIWfwpBnphHUYOPtN+7QYuqBAAck+EFqcAwCiKvFRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263952; c=relaxed/simple;
	bh=P2TM48kjMxPSr7YwvwYsCNfh+euwlg0K2KRkqviR9cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjLtiFHopwH3nIP1F0LsgRWlYvZbQmucdAEj/LduUYNACkFeqj+dVQedV3PIMwk+bTwigsr8lsUify3418FjcR0UbOIO9eAJcl5eXeS/jzCz44ulMSwSjoVX2qfqK37LoneznHeb5xVhmMSF6JGYeLSEAkIfk7hubqhTQCcgkg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=ANU3+UJY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234d3103237so8146945ad.0
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1750263950; x=1750868750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=ANU3+UJYNTxRBY3+jhnVmgrpz0+cLKPnWKQNYCog7ChxF63L/4lZP22y7Mkl9LQ2r0
         yol/RaNxgaqQV46mfagTKT9c/kRmJEiUhxCQgbmbyj9o36331lebjN7tTqZNirJdI9PP
         2nqoDoSg+09VelHWjYhL8M5sfiJ3mYT6JhCrl+r+6nxBo7vKTS4f1ZXfug+9UIbVsofQ
         YLwV3Tz6vkIXxrsaFmh9hS1lWHsntZwVU3VveBLGInaWmBe8fOb4pHvOqNLyFS3pJyhl
         JjtIMN1eQmyrrApCeN7obgg7MIc7aOHZHAb1mIMsHHDw8DeVW36LkA/PKu8sIGGQx3OX
         F4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263950; x=1750868750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=DxGB2+c2wogK19zB4XnR+I8U206zf5x72UFZBhobm4xXp+7fmbrjvyElGZwonI1slC
         8J5zSaJst3jeLjTT6iXhccosZYp4q8RgsRkXonkvIddZbd6xr5T3KJe3fzUaxfPhTRqB
         ly9duicaZCqU+kmd/A5QVrOlizP5kEOuWPnmeIDmYN6U3HRDCgrtu7pSPaOMAhFQ+PBc
         t36QHw1b1tHorX5RPa6AMyyqXIa3Qphg57Z0AuzuCVjRA6/+WCs13JoAt4t+PdS+U9B7
         Ucp9sGxt6Fz7druQk0BhIxnOsY5tOMG0qAFmXIJbmzODJpeTzhgFPI400DZGzmyAdswA
         Hs0g==
X-Gm-Message-State: AOJu0YxrfMB/+mhuBhi7gCT41JzogGYrVDPW7mediJPxsdYfZ4PpW/Ei
	fo1kxx6Et80h6AgYMK+r3HxqQBotYZrFa0bTYfghDBkhHV+iKD9Bk9ZFQSI2LZrTHJz+BilHL5m
	BNe6Ssp8=
X-Gm-Gg: ASbGncvwTayG5wQFJIBQjZ3CfBpgj5KyfOixFywHOpHUmsB3yCoyAx2syfFwAT98wUM
	mD9eYGN7gcPLXoGLAt6UktzJySCCKXz3K/BhviPYVVfRGc/btH/K5flqhTKrmHV8eW0iW+BGf30
	gYjgIUVAMPuucJ3keyp5e+3diC0XLIfammPSBfibMKd0vGfQsoPupMDWGb3mojzdr5/5zrXikji
	wcS27lbxZAni4dGb46XBgzTJhRU2sNAmzjHaHE5X5aSlJo9dgZ3kcZk7pcV9xEWVLR5vYVc/9Tq
	LhURDElJm5Evnh+gJxmoCGb/nCNq+0wGTvyybtMMUa+X0wiPm68=
X-Google-Smtp-Source: AGHT+IHBnBzJv+dzgpv/IuYTGHbecuVl5lsIV9fwbs0EUNNaa/Op/2bayR7I9w9fVA/TzuUlwT9wMw==
X-Received: by 2002:a17:903:32c3:b0:234:ed31:fc97 with SMTP id d9443c01a7336-237cc112182mr542725ad.12.1750263950166;
        Wed, 18 Jun 2025 09:25:50 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d683:8e90:dec5:4c47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2768c6sm137475a91.44.2025.06.18.09.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:25:49 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RESEND PATCH v2 bpf-next 01/12] bpf: tcp: Make mem flags configurable through bpf_iter_tcp_realloc_batch
Date: Wed, 18 Jun 2025 09:25:32 -0700
Message-ID: <20250618162545.15633-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618162545.15633-1-jordan@jrife.io>
References: <20250618162545.15633-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the next patch which needs to be able to choose either
GFP_USER or GFP_NOWAIT for calls to bpf_iter_tcp_realloc_batch.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_ipv4.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6a14f9e6fef6..2e40af6aff37 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3048,12 +3048,12 @@ static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
 }
 
 static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
-				      unsigned int new_batch_sz)
+				      unsigned int new_batch_sz, gfp_t flags)
 {
 	struct sock **new_batch;
 
 	new_batch = kvmalloc(sizeof(*new_batch) * new_batch_sz,
-			     GFP_USER | __GFP_NOWARN);
+			     flags | __GFP_NOWARN);
 	if (!new_batch)
 		return -ENOMEM;
 
@@ -3165,7 +3165,8 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 		return sk;
 	}
 
-	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2)) {
+	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
+						    GFP_USER)) {
 		resized = true;
 		goto again;
 	}
@@ -3596,7 +3597,7 @@ static int bpf_iter_init_tcp(void *priv_data, struct bpf_iter_aux_info *aux)
 	if (err)
 		return err;
 
-	err = bpf_iter_tcp_realloc_batch(iter, INIT_BATCH_SZ);
+	err = bpf_iter_tcp_realloc_batch(iter, INIT_BATCH_SZ, GFP_USER);
 	if (err) {
 		bpf_iter_fini_seq_net(priv_data);
 		return err;
-- 
2.43.0


