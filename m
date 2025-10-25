Return-Path: <netdev+bounces-232929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F27C09F27
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 21:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1F584EA61C
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 19:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08BB307ACA;
	Sat, 25 Oct 2025 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="uPOtzORs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4BC30595F
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761419717; cv=none; b=Qas2voCU1mTOuW5SrLQiXslcOSwnI4IsCCh7fp0pZx1giKD+yiCZZZEj8j0j6EiQNEuaTbJj835SPCTXcOzZrY11EAf5a/q0+ypswzL3Xf84LprQnUwAhhEmqsz/DosOAaDOXI35BrPcxudQZhv0hl52zlPFrUcZGyE6kNMru+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761419717; c=relaxed/simple;
	bh=WTDNM0tr/INgV5OTYW/ZlWdr+6NafVTLdbzbyoyRu8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHhXfD5gBHasuRtjBAPPTd4WMzcNjZ8Z/x01ZLMXw4QxEs3IgrVaawDsbTL7yXXY53hq2r9GmkWq7ytEsghh1fwquIWqmYAwZOCfxBb0bwTuyfT+qlfJsIFG5rJg/pi5pKO3fFgHDX3/Apa0eRpF7SuayVcwoHncTIOZc6U5wc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=uPOtzORs; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-654eb2b1146so377843eaf.1
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 12:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761419715; x=1762024515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2SzGzX4o+SmFbTrBRXjjlJNGzurz8IutLnIyEojtEM=;
        b=uPOtzORs7pvzZE3Lr2PlhsjQ7zaF0FyAn8M89VQ0bN+87kw0q0Rm2G68YYXuXRFyVq
         4KVA7eiE09bigjkj2aKSO+nVOs28IdmQ4lwCfGTME42vlAW6JSurMtfFW2UVsM1CHVJO
         nqzCfvT2drmlVLZfqpZ4b1QdJ6JXSOBxK1jNOheTdh8yMqIMNbV06xQE9Fok/LwHjsiU
         1J/iROV3qS5ZQwpq6SNYyak8M5PQxgb71S4CsLLspTzjZ80r8omILa3LsiNnCE4ZmtfA
         j0shY83MCrrOQeEMP8xnsdR/gP/nmwq42hnHt7SjD1mhobhDpnOmt9H7Id+2AKUCkfQd
         +qUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761419715; x=1762024515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2SzGzX4o+SmFbTrBRXjjlJNGzurz8IutLnIyEojtEM=;
        b=SyNUx22tKZLZNlXIvpuFW+fT4/NMrvVNSiKqTmNELvLJ5eoGst5RSBkKYTfBRzjC9W
         j2iEYHs5v8PMuWpggIslcfqqiobhFq75qC+IaxYFHFwtZ3oLJdkpJeCNK1NLSQuZ5Vm8
         jlavoUA+Vi14BBHvxe0Yk5Y2I94uDSX3QOYDrdZNxZ3VoER3WDBd5nt7ulOVetUG6EXB
         /YTC/6asA7NR3fLJwVNZNp8Z7EwBjEB38mlkm7OmDcfFanMUIQEcd3iOrW/5CQD7Zkpz
         uRjpUjEVM+Hbel1n9TqCF7XTaO+6PBARsfJEATkMhYHTTe1Bs90o90ze9XEnj/zfEBWD
         oGeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS32wAg2KQ7azzwc57j8xwZKkWSSALHpte2gQINujlAy2HDkbOMOEbbjCGKv5xrcji2Fyq2pM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxejl21W9sit0zpSxosfYyUh/ZvuRQ9P10H9WDDLHL1G6u43foX
	BoPupaiBG/pLxJt45mkIAYIgCB/nyryUj0KLA8eZxcQMY4H6fT8hF8JeSqyhWZsz57c=
X-Gm-Gg: ASbGncu+/o908W2Xu39hQf4CqUb3/0pN1INNPMGMaNxl4VIQ/SmeSCjdUsY/FF2pyq7
	fxgmXUvibxrLy8TQNNktFpqdQweb9DvtQsA0WJk+rLRrmklFe4hS1tMRNLuNB/qYemy4yAlRzzb
	Tqfff6rCBS98ybLTz+1BQxzbCnpEJboj6ZpV1YwbyfWMuJE+PeIu18uIL8PzND+cHAWlfK/OE9h
	ezlIFbhA31rMTPkCzV/1j7AxtqWyrll53hRSAujlU33DvggEfDWpZO1MLaBnujwClUD5hpMG6rb
	pgEKc2q76WLfRt6Ykx7CYZ+rUbpLARxXoRGQ6qnEAnvB2nUaBw8fnef3ZQ64WpsbepZwRXH6Mic
	nXQkZCtkvxuFzqtE8bFUnH73lMQRx6zbNdZ1W9OFYoNn4Ykztcl9k0MBJwxipWgbpf0/1hFcJOa
	1HlYsxSb+kbdeKGdu48YM=
X-Google-Smtp-Source: AGHT+IGMWeQ40VXo50EDlyowTbWMhv9Icclx7VY02gK0gDsjo+EjMOo5ZkmWECFH/FkXBkoi56h6dw==
X-Received: by 2002:a05:6808:2122:b0:441:8f74:fac with SMTP id 5614622812f47-44bd433199dmr5000811b6e.57.1761419715369;
        Sat, 25 Oct 2025 12:15:15 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:72::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-44da3e9ccd4sm646578b6e.19.2025.10.25.12.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 12:15:14 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2 4/5] io_uring/zcrx: redirect io_recvzc on proxy ifq to src ifq
Date: Sat, 25 Oct 2025 12:15:03 -0700
Message-ID: <20251025191504.3024224-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251025191504.3024224-1-dw@davidwei.uk>
References: <20251025191504.3024224-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Technically there is no reason why one ring can't issue io_recvzc on a
socket that is steered into a zero copy HW RX queue bound to an ifq in
another ring. No ifq locks are taken in the happy zero copy path; only
socket locks. If copy fallback is needed the freelist spinlock is taken,
which ensures multiple contexts can synchronise access.

Writing to the tail of the refill ring needs to be synchronised, though
that can be done purely from userspace.

The only thing preventing this today is a check in io_zcrx_recv_frag()
that returns EFAULT if the ifq of the net_iov in an skb doesn't match.
This is the ifq that owns the memory provider bound to a HW RX queue.

The previous patches added a proxy ifq that has a ptr to the src ifq.
Therefore to pass this check, use the src ifq in io_recvzc.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/io_uring/net.c b/io_uring/net.c
index a95cc9ca2a4d..8eb6145e0f4d 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1250,6 +1250,8 @@ int io_recvzc_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	zc->ifq = xa_load(&req->ctx->zcrx_ctxs, ifq_idx);
 	if (!zc->ifq)
 		return -EINVAL;
+	if (zc->ifq->proxy)
+		zc->ifq = zc->ifq->proxy;
 
 	zc->len = READ_ONCE(sqe->len);
 	zc->flags = READ_ONCE(sqe->ioprio);
-- 
2.47.3


