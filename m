Return-Path: <netdev+bounces-242405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC64CC90291
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 21:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9573A35340A
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 20:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B73E3161A1;
	Thu, 27 Nov 2025 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqDhn6GK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B716B31A54B
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764276282; cv=none; b=Uq490KwRkBj3OS6KjhfpXbZ5MlP4s9Gu1XMm0/WgbMgGJkUEADUha/Vu/dO0p2QmNpqB9dRwwIfYWlLDPYgf0cyMIwBC/zP72u1Ggm3Rnc1ZEmJ5SEcnATIGov/p+fJfhePccqCdhshOjOLBUVbt40yQD1kKdGPdbPLE56d/CwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764276282; c=relaxed/simple;
	bh=axdc3q5KY7YeHULab/TvgzOYs0oof9ugiogriyYfhIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGMYzkta9Y2JR4ropm9dxxfED30TY2iT4gBflG0RZDwHMQykN+palcwlHKaxwgtNjpAk/0NNAZub41wz73cKdWId6N+NE/CKIKRF2tp1n58Lef+5/JzWwDvUTqHawrjLzr28NJZd4qASxReCI06lKDaf9CUfwfy/8shBk0K3NS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqDhn6GK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47796a837c7so7846595e9.0
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764276279; x=1764881079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiBEtLY6CE0u/w5HMF7IyfpDPmY7qzN3np9POU+8r/k=;
        b=bqDhn6GKwVSWrXbEMlo9ZGu0yzMC0QkDwYCXmcYQnyzym6MrPDUA4l1LiZIYhC+6/6
         Ihh5WsKL3Ta1Ki91SGuygKjQScfQocfdAr8n9AJK4u/N1Q3I8wGRgPkBKtXmwmjDiKqA
         PEUEtNQKPwzJvtHYA7H7z6OLouMgaqdzf55HXooUUJcaF1VozXD9q9VDDjdsILbYn2Ol
         TPEHHF1+RX+anO9mIsjpDsviMbLWmjyRlYtcp+4nX/jhyxoVj3204PQJFUtzOPkQfdop
         64cZsM+6f2un+Mkfr9JUTPWul0n1IwIFZqkUwn2hO9pPRxfQcEOzLud481IpAHWTIzLx
         WLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764276279; x=1764881079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kiBEtLY6CE0u/w5HMF7IyfpDPmY7qzN3np9POU+8r/k=;
        b=K4JHh8iJLBRHt9M6dIXseqS/d20d+iDZExgi0WkfzVDVos/EuvicDjoyn2Oa//XgiG
         E7N/zvYz14tMDaG8EGjVkoR91kZtfOqGPc1T2iPgJ2y/tDMR5n7CehWYSnlXddgFjSyH
         POzmAFYThCDbjKBA/4nk0cwL8SO1YBcYpZ8XU9dpqwt0koWkuVerjq5RVvcgjErA5LsC
         wunV/lp9wTLjCGZaC+9rVCoGZWFA753sSqX++cgHAjhkYyiVsSZIsYjZ3GZNUy5YcBc1
         tLa0Cv7xX1x93wsBpkgBU5r9wZ9T56J5hLE2oTjbvhxLlAkwCdAy5XW1nRwHCviWyOiT
         +s+w==
X-Gm-Message-State: AOJu0YxZdhWY8SwAGILk8mh+pjbvdkKNeupn564v3WAv4lPClVryPxy8
	LPExQIR3yM/hjz2n4qLO9/gAN/k9B1nfh4nr+BYk+KxXHCqKCpo093kg3l29gw==
X-Gm-Gg: ASbGncss7FQnW6JiUsdADE9Nq+0+yQhcDnFoz7BPEJllAGxLMlAf8LEADRjvIa79iMn
	HJkYlZZ24tOLMEAdcLWgX1Nzl99JBj6eZPZSaCu9gJJ/pQQ16z4hwEUezUdv7kto6rnn7t6MoO3
	MsuwGjFN5DQxGRWSMKPXiDpuYD6fBvh2FWQV+EUoRuB1kp//MixDE6Oea/XD/XiF0JniUK4YvUg
	xTkAOWvggkEkgTdtQ/uANUJcgnA6MopuueFpmyFHJoTP+EWAyqAkkcqVE7/GjYPwu3XhmNiLJga
	5f8T/DFWsLvSuo2dXJBu1V80TgehMG/jHG3bTCRrWxME6Q6EEmUNY2cTsUu8J/HK0nUjr5wQ2r+
	vt0j2cDPgl6XgR+gv0/VMmvmfiwNcanmO6ZvhiWDH32HAJnK2cOzMCUITUfKCksrubJs/C6kENV
	cRqqjLHsPYI6/SIePmqiu10+0a
X-Google-Smtp-Source: AGHT+IEQspnbxTQ8o9d1WAB81UB4DgymWXC24t8k33OrSVdVGqsW2IGOJclHPDPSInbs1ZNAtOHzXA==
X-Received: by 2002:a5d:5f93:0:b0:42b:3e60:18ce with SMTP id ffacd0b85a97d-42cc1ceea85mr27045133f8f.18.1764276278582;
        Thu, 27 Nov 2025 12:44:38 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d614asm5346105f8f.12.2025.11.27.12.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 12:44:37 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	io-uring@vger.kernel.org,
	dtatulea@nvidia.com
Subject: [PATCH net-next v6 7/8] io_uring/zcrx: document area chunking parameter
Date: Thu, 27 Nov 2025 20:44:20 +0000
Message-ID: <a17cb10f4595458bc892015a40aa07798936841b.1764264798.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764264798.git.asml.silence@gmail.com>
References: <cover.1764264798.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct io_uring_zcrx_ifq_reg::rx_buf_len is used as a hint specifying
the kernel what buffer size it should use. Document the API and
limitations.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 Documentation/networking/iou-zcrx.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/networking/iou-zcrx.rst b/Documentation/networking/iou-zcrx.rst
index 54a72e172bdc..7f3f4b2e6cf2 100644
--- a/Documentation/networking/iou-zcrx.rst
+++ b/Documentation/networking/iou-zcrx.rst
@@ -196,6 +196,26 @@ Return buffers back to the kernel to be used again::
   rqe->len = cqe->res;
   IO_URING_WRITE_ONCE(*refill_ring.ktail, ++refill_ring.rq_tail);
 
+Area chunking
+-------------
+
+zcrx splits the memory area into fixed-length physically contiguous chunks.
+This limits the maximum buffer size returned in a single io_uring CQE. Users
+can provide a hint to the kernel to use larger chunks by setting the
+``rx_buf_len`` field of ``struct io_uring_zcrx_ifq_reg`` to the desired length
+during registration. If this field is set to zero, the kernel defaults to
+the system page size.
+
+To use larger sizes, the memory area must be backed by physically contiguous
+ranges whose sizes are multiples of ``rx_buf_len``. It also requires kernel
+and hardware support. If registration fails, users are generally expected to
+fall back to defaults by setting ``rx_buf_len`` to zero.
+
+Larger chunks don't give any additional guarantees about buffer sizes returned
+in CQEs, and they can vary depending on many factors like traffic pattern,
+hardware offload, etc. It doesn't require any application changes beyond zcrx
+registration.
+
 Testing
 =======
 
-- 
2.52.0


