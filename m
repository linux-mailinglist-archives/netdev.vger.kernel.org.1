Return-Path: <netdev+bounces-238292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F33C57006
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BF69351E38
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B2933E36B;
	Thu, 13 Nov 2025 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWaqmh+C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8020F33891A
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030801; cv=none; b=X1uTp+l8pPmFPNxD7hYg3si3hxAsbPBf+5KRVuar36aUNbQF8jDmBtQdYpZiiYh8ZIjihpcbkW+dE8nHZvj8ct5R+Di4YYoA1ZIq9NqI0o9UH9is+IZXmGLAJfvhxo7avQnpXiyGg2Lp8oHeekK+Q4SAerbAFyDdFoChISzVcqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030801; c=relaxed/simple;
	bh=2ypS9DvI73TQm/nsZ2AWCmKcadNpnTBFDaJdrPMz0hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4g3eSb0aLfvMp04zKghn/+3ZUhlwgcE5sPsFgHoHw4Ya//hTLpKuJHff/hXxWpLQ/Ep7Jxoia/HuTxZM6lc7AT94Hme/gu0VP3f2CQxzzkAIsa7+Ai6t5/lEVEZw4FaiHE8GQrfNF6JlDYzQDBFe2G+AQOsJPkNUUbYQL4y0uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWaqmh+C; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so524475f8f.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 02:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763030798; x=1763635598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zn8GNBB+bN4FycJtZrpgXRXM66N2+u9/9LPVLRwSaIs=;
        b=HWaqmh+CTHJ+JQb7BsUoQ/tnutFGnnmOFDwXxmeG6wKrqy6sNfzmBDZPuSFt590Uh4
         bGnbk1fVSdHN9NI3rvx3RLFo7raykOU2L9uHWPCDcrMXZPjHAD8PyRgDR5hXhM58Ilw0
         5xODCoywBkeuAIdTdGxTj0o9lnDoyds9F/x9pIJ3iP9Giu/M4P+oVcXjxFBlf91pgkEm
         TPwzojosrwXs+qzJjdM/Ol6izLp433eRYtiK/If5val3NdkBxWsmp9RrGCrk7Dgf8qkX
         mRl4m8o+E8GtJodFoMoS5/+35xB/4uLu9+h8Ziso2of7bp7SGT9X9+iUogqzJ/e2u857
         4UJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030798; x=1763635598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zn8GNBB+bN4FycJtZrpgXRXM66N2+u9/9LPVLRwSaIs=;
        b=bKAACNFyr14bcC3Upvt237FFPW5WvQF5VFzsjaN0RhUpZ8EUb2VfkIGtUoRPZ8+b5r
         kbVn40AuQOHq2FlblX4citlhE6cZtL74kcuPs5uud1r+63CZjFUTA1QLaduxpINEZeTd
         t9abd170bF/E6/nTpI042ktHXd5khey3ipN1ApNDJFha1ba559IVIqd8MpNoAPIIiKe0
         BrlL35+GWFRNH1K7k8+mAYM2YgEzFQIHMfTTCer6o79RS4sWUkJycMFTtS6IA2myQZRR
         XIoBg+9nffZNqr0+n8iRY55huJJxVZ2G4Cv7CZBCeO50Kv7vXHrdFoYfxqM9LgfKLW8F
         tj6g==
X-Forwarded-Encrypted: i=1; AJvYcCWQ+aEpCI7biLFPxjcYgdBWTuqaf3a/YX/TUMM3JDpKMYWSQazCb/U1JqYfm3QiJKs0yHyFhjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKMd4utrHuNB/u8W8l2aPvPAwwezPlQbSzPL7HFDr+2CHk/2Pz
	NmQgLJhZA+R9+BPfvvffpy5Ckp5GlPu00ZuHjZul4QdXSuQsYhK9YIY5
X-Gm-Gg: ASbGnct7iQJevQczJi6fG97AT3rNo1iSkx4bVUZcjG1xkkfMDtEM0YK5m4sN10v6aAZ
	gsWQuNRzkmSNdHaUk/1hGr+OZKfO8+NaF5rSiM45wU9nD4YKHoExJ6XtuBtoswd6R6Q5hyEBmff
	bchbhl1M1yhbaeXuh17DSjs+6bLLzLwmQ9VwBP7tEQWx5I2Nh9MEOs5q3hKfKQCYlHY84EtvMkb
	f35exoATFLpxVW4zOjYFgF/yauuu0nbBMXg2G/YNytx12CqGfI/QqXEUgyIuufuqSBoIQC3tDsX
	YXhFA1szinF5bQnen+uiUZhaujPymYd1hEDVhkwdp5dwZ+viFgrgF6r7sr2mzKHI8dXgNRjq81E
	EleXbM3qGkF2UdrMpVy9+apPs8YgmlcNqqZaxb9AZuvoge0vYIx6wtuLm9Fk=
X-Google-Smtp-Source: AGHT+IFw6KBW2F2q2IxZ+P2DoEMbqT5+Sji/bb71LNKvGOQ8o2XkKNtBgNfuboSX7YU5Q9rY5JxF1w==
X-Received: by 2002:a05:6000:2c0b:b0:42b:3e0a:64b7 with SMTP id ffacd0b85a97d-42b4bdd68d1mr6516630f8f.53.1763030797780;
        Thu, 13 Nov 2025 02:46:37 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:6794])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b12asm3135210f8f.10.2025.11.13.02.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:46:36 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org,
	David Wei <dw@davidwei.uk>
Subject: [PATCH 09/10] io_uring/zcrx: add io_fill_zcrx_offsets()
Date: Thu, 13 Nov 2025 10:46:17 +0000
Message-ID: <fa48b1d6ee57977c7f4abb774aa888c474c295e0.1763029704.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1763029704.git.asml.silence@gmail.com>
References: <cover.1763029704.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Wei <dw@davidwei.uk>

Add a helper io_fill_zcrx_offsets() that sets the constant offsets in
struct io_uring_zcrx_offsets returned to userspace.

Signed-off-by: David Wei <dw@davidwei.uk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 815992aff246..da7e556c349e 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -345,6 +345,13 @@ static void io_zcrx_get_niov_uref(struct net_iov *niov)
 	atomic_inc(io_get_user_counter(niov));
 }
 
+static void io_fill_zcrx_offsets(struct io_uring_zcrx_offsets *offsets)
+{
+	offsets->head = offsetof(struct io_uring, head);
+	offsets->tail = offsetof(struct io_uring, tail);
+	offsets->rqes = ALIGN(sizeof(struct io_uring), L1_CACHE_BYTES);
+}
+
 static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 				 struct io_zcrx_ifq *ifq,
 				 struct io_uring_zcrx_ifq_reg *reg,
@@ -356,7 +363,8 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 	void *ptr;
 	int ret;
 
-	off = ALIGN(sizeof(struct io_uring), L1_CACHE_BYTES);
+	io_fill_zcrx_offsets(&reg->offsets);
+	off = reg->offsets.rqes;
 	size = off + sizeof(struct io_uring_zcrx_rqe) * reg->rq_entries;
 	if (size > rd->size)
 		return -EINVAL;
@@ -372,9 +380,6 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 	ifq->rq_ring = (struct io_uring *)ptr;
 	ifq->rqes = (struct io_uring_zcrx_rqe *)(ptr + off);
 
-	reg->offsets.head = offsetof(struct io_uring, head);
-	reg->offsets.tail = offsetof(struct io_uring, tail);
-	reg->offsets.rqes = off;
 	return 0;
 }
 
-- 
2.49.0


