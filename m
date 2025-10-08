Return-Path: <netdev+bounces-228212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D68BC4D8A
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 14:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A8519E1C96
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 12:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8650A248861;
	Wed,  8 Oct 2025 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnRBCKW3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B83F9FB
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926995; cv=none; b=igKjukRh9kH2aRA3EVtKruqjYnStlDtO8pc9IBcpNUr2q5MGghcVumetdCx0wh/ASXBoqtoj4FWl9NK21gYqCFNQno+ZuT7i7Di4eY5Q5jDcRxDGRQMb37RgkBCy3eTbK60S6RPji3VuQFziw/N0bLCM/hwGRULmxcsayGr9PrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926995; c=relaxed/simple;
	bh=+aIC047GhiBphGidHfz+QV4GqetGV7y8jq9FC37CcQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aH0B+gqIx6QASzUV72rUqA1GQ5pMrWp5K8NHGA+G1cOm5bCHALMw6GD5HBPjO2uVy53yAbSqZYo4N/V3Fuz+Y75dohXFH9nIUJHTzBam93uc6vxqfSJ/QFQ+LD77ytD3DgFpwvei1JCrsemKR6LepWZWo2ptwacQyCIuBzrzams=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnRBCKW3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3fa528f127fso740306f8f.1
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 05:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759926992; x=1760531792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nx6oINGF5HKLwp7WkUz37F0BvYl4MRcOkRkrhp85qcw=;
        b=OnRBCKW3GKcxrg01gwZ4/alSTFjqM/Y5acdKPjkdgCtEK8MCi7DfcJB/et4TXtfXZF
         3Nm0epBTZe+STorWtLpUUNOPyoL90Lmol+ly+/qB0U4ZdeieO+e2U7L+Wwfwc3KiLejl
         eLBQUoVQeBFRCACfTE2yHj0bH614cEECJ1R5m48TMqfB/KDtav2hraCZ/CNzzIadA2cT
         4bBMvGSJiRxS48V9Lya9V4UbUD4ZpYN41E30xYA3T2QEf0dmHnoz8rB4y5vu4EgGYaqd
         amG71rHE6QB28bHIYmWQn+dc9I6OkTJxwOHyONaf5UYo3oFV2MdVAFCuNhqbJEj/XjfM
         bmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759926992; x=1760531792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nx6oINGF5HKLwp7WkUz37F0BvYl4MRcOkRkrhp85qcw=;
        b=bYEUXNeCVwBSMiOtuvVq/R2IePuPxSjo5uSKGoUQVsoFwnW6EPuMOSNPR3r9iS/Zg+
         3tUlKAQ/gqoCL7ks/dB4Ni/+mhwBMUlz97Yyfop59UVnF0BlAzeFB2rUFWWjQ7w5IgTy
         zSIJ+czBDljTnZgLGBurmn15zoFKKq9usoCXF3ENTTcmyqxlz6ErWx5AVnqvmRIVLEmC
         beCMntBOhPKQpnm+8mnN8z348a0Or38+X8JhJhs07aO6PFhsCVjOkzDIAVsbcwfPWDub
         e8Kya33cckeF2HpmhIgu2BQXKBuGhOhNExkeZGNZEy2totMLuYcDlkWf+KSf4Bb7bkPo
         TYGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM65S463RhRZo3oLs+eXKijiztNJfr/7rJNJHbz5ADgHSQd7geXwbMje1a3RbiOkFdZBn2Q8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXk+mIS7CvVxUFy1Qyb6JrqQzHsyY7V2rfUo0x+/ZXzEHmh3gr
	rw0JzsxZnb9o+1K3u20OSdkeyrE1HzE5MBRklQpByxmv0NkTukEEwWpQ
X-Gm-Gg: ASbGncsNXfF1OBbYRZTTH1vx9LZM8ba+xLHcXLGJCzCOj1c+Emogqqm83NgAHz55llT
	9+lXuJNfjh96O5KXj5WSMOlx4RGeO1qCtQWYw77WW7OVnQxbBl31jQt+cF7dDDalL4oAm+t+eUj
	PluSOIkVqJXeVv4vFGtNalcwIsa9cA4CvJKaoX/XVvdEzCNUW2g6L68t/33Ozdixuab1bQxkNUR
	zGzgUjAGdHJiZNyF18Hw/PpEnNFh0NNDjlf/YcuuPi89f1hD8gYOzl9Uz44mxwwryrxdbjtREmB
	Luz8oqbD/Gdt8BiQEQdhelK0/MLndWVTDw8RQ0FYDxmE8988BDNPy03oRwylZRZeoYnkbMsHg93
	Sn070a1lBthdkfFO6Apa1e+rKqMxVTA==
X-Google-Smtp-Source: AGHT+IHBwzFZ1BAgN9wywEcc3pOtjkCY++l+dUBvhhk0BS+igZeRAbRPqebdxDb6FvFYFecs3sDC4A==
X-Received: by 2002:a05:6000:1f09:b0:425:86b1:113a with SMTP id ffacd0b85a97d-42586c057f2mr3631229f8f.16.1759926991884;
        Wed, 08 Oct 2025 05:36:31 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:b002])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8abe90sm29631170f8f.23.2025.10.08.05.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 05:36:30 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org,
	Matthias Jasny <matthiasjasny@gmail.com>
Subject: [PATCH 1/1] io_uring/zcrx: fix overshooting recv limit
Date: Wed,  8 Oct 2025 13:38:06 +0100
Message-ID: <b0441e746c0a840908ec3e3881f782b5e84aa6d3.1759914280.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's reported that sometimes a zcrx request can receive more than was
requested. It's caused by io_zcrx_recv_skb() adjusting desc->count for
all received buffers including frag lists, but then doing recursive
calls to process frag list skbs, which leads to desc->count double
accounting and underflow.

Reported-and-tested-by: Matthias Jasny <matthiasjasny@gmail.com>
Fixes: 6699ec9a23f85 ("io_uring/zcrx: add a read limit to recvzc requests")
Cc: stable@vger.kernel.org
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 723e4266b91f..ef73440b605a 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1236,12 +1236,16 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 
 		end = start + frag_iter->len;
 		if (offset < end) {
+			size_t count;
+
 			copy = end - offset;
 			if (copy > len)
 				copy = len;
 
 			off = offset - start;
+			count = desc->count;
 			ret = io_zcrx_recv_skb(desc, frag_iter, off, copy);
+			desc->count = count;
 			if (ret < 0)
 				goto out;
 
-- 
2.49.0


