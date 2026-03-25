Return-Path: <netdev+bounces-271513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJvWHqfXw2lwuQQAu9opvQ
	(envelope-from <netdev+bounces-271513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:40:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2550B325075
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08FDB324DA45
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D113D4137;
	Wed, 25 Mar 2026 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pesKVsqN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4243D1CC5
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440504; cv=none; b=CLEsdhsOV/Q7rufv1dXHsL8c3+EKt5AYJvspjgMW1IdvaLEkzfgK4dTZukIwjkTDJ1h3bLLLCgYvwCyFJ0raMqn1zJ4DvQP+NjrOdRt/NN0ozhfdutXCYbGC3+MgZ5eYfviLuh1OnSBmhGLDjIBqhPx8swNu0ujPz984zIA2tgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440504; c=relaxed/simple;
	bh=+z+O+5dG8yAqI5XIZ04nkzjm+SpGwED8gAiLniTpEX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vt4SMbzwyxGM2JA9Z7zdoPECtPB1BQuXwsh++Ht/3GapRpHZ5o+mftzlAwDREPzSNJfWZqPcFJRDB4lE3LhOsXCbkmoZyhCc5HF9FX/am19uXp5IstIGpGs4/IjZeLAh3IoSrxMjWZ29Le43wkqCPkL+GUgTvdAH2aGVFggQ4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pesKVsqN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486fd27754bso19739115e9.3
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774440501; x=1775045301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8aPi9VnJNqU9bs5WmBhwAhFZWUAOiIAxFjx2+/0cSY=;
        b=pesKVsqNsRSezWQawcp/p4DZZCzocAbSThGrzqdMffcmw6brLjc4layOZbDRfO44nd
         pnYcJOsCUkT5wk2/3g4anOQ5QLAAkOtTbRWsBlsVPc3+FxYzMiuoA3E5XkqrxtCSnZdl
         NeI6zKNibpHcla1vXMmvekO9g80TklBBTbJZGJz646Z4/Ja10A26BPUPvXEvuTgNF+T3
         cKsta8Jf9EvypeTP/Tim4iRpTfo2Kj4ZEtA7iAhPaj8BF3viuowV9bR9RQW87YyLw+ku
         ldJSlXYWlwH0Nfbivy1Y3RV0w1fkDiuFXYSECd8ByoEuEPJi94QxERFwtcZ2DzKPlp51
         h2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774440501; x=1775045301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p8aPi9VnJNqU9bs5WmBhwAhFZWUAOiIAxFjx2+/0cSY=;
        b=F1G0q1ouf5d+1ijrOJLMN/v4e2jqoiMchWermce/ju77S9qzDQYKaUkRNveOD1mFte
         iUZT1h3sH3XJj6c/3a95pKqW0cqmDK/LV5pRP8uVLXhkJudbIQV/cpsvboo58jXvSqiW
         QVeD/RLtzl0B1SVH6NZr2Fb0oV4wnqql4+QOb2V0Z/+Emj+ANZYzUe528hJamMj8Dc8k
         IpwIc/ZH7kt8sA2R8nn5unDblgALIyA/A/m6HCREarCIYhTfiynKkVTdSwRBvvggCqAj
         15hxRWExpzSgcspqas1CR/uUhZHF9hh35tdX5np5ymgH9D2aRiecSVfRWviYUFHioR8B
         2sOg==
X-Forwarded-Encrypted: i=1; AJvYcCWENW1U1daFUonujIv+YzF5SWZRurWVionlTcuR+PwM6sDb5hSrJpd1KXxa6B20c7UgGAQtvZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBhxJHkRGF3k3BbaKzRwoVMWrpt1RNmjb1Pi3XZPg/EwaWHxCE
	hNLKOWEoYAQcLhK/o8d8KJjC7kVmnRMosslcoYhfUqX8v+Yv559XSIYk
X-Gm-Gg: ATEYQzzSVDOH3KgwJeBon+kLhwaa50UGbE/YNC8dvYG4GVRYEKQr+Gv4mDeAMZv3Qvj
	VsUKq1U0aOOf2NL+zGytHCLSVKX6e1lBTLHVHA+tLrAphvk1OP2DHwWuJD4tTwxn9BBYrvIQCwm
	KXl4ErFA1/9w8SBhwhcfTp6+pILLKgQM61XLCXKgV01VVb4OCNxn8kLFeR6pGrxT3jqQH1Cjji1
	DpJx0cEb/UWmsnj7vMz8uK97lEG55xGEyotasQKRu645aQPc+Bqfah0yWPvFi4XqDS6xsFo0sIC
	5RjJ+rRkdJMFAlC2t2UoyEgSpRWXxiJKEzLMKv4fadJnA8W9FcBgyF9hzklANe7DKoG4nEROg4h
	Elaau3FYTsQlEvq8wAG7hwEO9EckEq+RJMtxwgBoYpDeUeeb6xcZDFU25hX+hKD8Lp9SkggJEdD
	bDelxLPKSEFuh48xkFlKseskJfKuEGxzUBf2AS7gD7dnetTluQW5mwaMcO9GTMz5Dr/vewLjuFd
	IJd3znBfg==
X-Received: by 2002:a05:600c:3154:b0:485:9a50:3369 with SMTP id 5b1f17b1804b1-487160846d9mr47262005e9.29.1774440501236;
        Wed, 25 Mar 2026 05:08:21 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae37dsm48618289f8f.2.2026.03.25.05.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 05:08:20 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 4/4] io_uring/zcrx: use correct mmap off constants
Date: Wed, 25 Mar 2026 12:08:21 +0000
Message-ID: <dc8c95b5abe9830eb5ee883caf240df67e6385e1.1774439286.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774439286.git.asml.silence@gmail.com>
References: <cover.1774439286.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-271513-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2550B325075
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

zcrx was using IORING_OFF_PBUF_SHIFT during first iterations, but there
is now a separate constant it should use. Both are 16 so it doesn't
change anything, but improve it for the future.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 0f98a3c74e2a..f38d30dc0ac7 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -386,7 +386,7 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 		return -EINVAL;
 
 	mmap_offset = IORING_MAP_OFF_ZCRX_REGION;
-	mmap_offset += id << IORING_OFF_PBUF_SHIFT;
+	mmap_offset += id << IORING_OFF_ZCRX_SHIFT;
 
 	ret = io_create_region(ctx, &ifq->rq_region, rd, mmap_offset);
 	if (ret < 0)
-- 
2.53.0


