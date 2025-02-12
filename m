Return-Path: <netdev+bounces-165660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CE8A32F1B
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 20:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0543A7728
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E399A263C77;
	Wed, 12 Feb 2025 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ftrWzmuJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD6D263C61
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386755; cv=none; b=c0hag6eCVWw3FaRbp4KVtt4iIkHfG82SBSCOiRUno2UjVJnfdX9OiO6/xulMjULyD99X+JNDxMXfANVyp7H4EzTLcAiXSArtAvMG6jGhrZjiyE0cOFGcRTNzSjebQug5ovV8lxVCYI9dwPQGR1Ayi3+vUR6C26XGBGRC0p00BKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386755; c=relaxed/simple;
	bh=ee/nN2D6QNSrV0ltZWEtUTkHe8hZqD01WUDrrxCQo70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmgRW4Q1DZh2eQeGFV8fR7+3l8VaFz1ExCb6Y8BydskORIomaxaAcd/cWLxH6SpeWrPST8vymLThe/CKU4hSinFNhcWSbYQwPZIFt7EycG84SH82ehDW+9zPps0aYQT3/UmRfiAOa7CTYLhHF73xr86Wlcc98MR5YJKVR/E4aHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=ftrWzmuJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f818a980cso70797405ad.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 10:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1739386754; x=1739991554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwmwJaLfYGswpQ8xBKMbzXODDugRtY7fPeN6XrAbeLU=;
        b=ftrWzmuJtqIMkJa6jAxpWUC81DHa51Zk8fQ1Xa3CLpEg8VAgI/H0kSii8DIk+CVyk5
         Dc42oAhXA2uGZdgmdlFnhcjwF+mMbjnPiiB7FazAjsI7HruAxhHER1Lzf/6KohmQcH/y
         +NEOS5no4YHDQm3KDN8NbmqwiobBvAxADjsG6nIQkuaYYRKxTuVUqlmev4GEKXKRlEg0
         U+lp+Jq3Bl0PfcrsL67nanN9h6QkaAmxm1Ppoi18RMyXUmMQH3lYwnfr1oMNIMwhecrQ
         TMbJ6tHKCkmCO10KljZxovzNnLpX8JlazIVKg45kVT9N2t9acc2m9Q1kJEtMtBPDUQfu
         rs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739386754; x=1739991554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwmwJaLfYGswpQ8xBKMbzXODDugRtY7fPeN6XrAbeLU=;
        b=aqsHQPXPBauLMV4QnBWXp5atFtHDVRmyZC176qo9Rdui2v79jODNGyWOpmjYqSJMfI
         yKYAo6wMhZl6GqD6BxID+E1meuTlup1ZDYEhB9PJLKfNvWp67vTm+YXyGV+KwZ+vxtxW
         F42s3miGEbGpGJGEeNnUYfOclKzMEpI3XiscYiaa8fwBfXiThK0hQSZrm1w2kD7QW0xE
         SXeUPYfcA/jV+NCXApqI/e3IDzg/Tt+HJawFAwqGzRWCvvBqylhptlxgaPH3tzIbZn3y
         B8oriYYtUxFZWAJI6wyll9eP8Ah03vqUdDuH20kt4GRSS5cxXZSNddAxDHWr7NmkAh+Z
         rXiw==
X-Forwarded-Encrypted: i=1; AJvYcCVjgkKqpmJXRb707uA/+E7gHTJ9VrEVtzBKZDfrJISjASTbcCpuJhsOQhQgOmkgJJQg26UPXF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd1BO3AGF4noajcBect2uaOUqHp089VM1Uv/iNFhW/HLnDR7ix
	qpCgAbgGVIjw3zbvCkvn2HISrBQRkuW3ULmMRSZdCRe9BsHVLWLzG4OtS97spSU=
X-Gm-Gg: ASbGncto1drVgCy5hLNRyhqTgJ7BY04/d1OOBb18csosgzI6nVXexYPYiGJ+VcwWIt8
	h/6rifOcAGMr2QpxSz/WfMtKvwYjRdWdpYMLowlAQsUD49Mc/nn6x/OTBsSzphoZ3J0HsGIcy86
	lUiZTNn2GyCjJZGW+mwlVjVyv5/tfdkgvdVg+ccLnEBlRxv/6sHa9/BSqqfc682an0DoiN0kOm0
	7v0Naw3s5Rim4duXPYM3Pu1ZvKe6zLI9Gkc0QJ0GjE+CS1DB+ovVI6QsytMWgGXimxMD+xcRTY=
X-Google-Smtp-Source: AGHT+IG7KHjLnWLQTFWVT1k+WnOpKOaw9wmIuzkylonZYRxl3HKxiIApLSWaXxMBbETPpgwijus8UA==
X-Received: by 2002:a05:6a20:2583:b0:1ed:a4b3:800 with SMTP id adf61e73a8af0-1ee5c747328mr7052965637.12.1739386753847;
        Wed, 12 Feb 2025 10:59:13 -0800 (PST)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad54f1691ddsm6075971a12.61.2025.02.12.10.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 10:59:13 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v13 08/11] io_uring/zcrx: throttle receive requests
Date: Wed, 12 Feb 2025 10:57:58 -0800
Message-ID: <20250212185859.3509616-9-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250212185859.3509616-1-dw@davidwei.uk>
References: <20250212185859.3509616-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

io_zc_rx_tcp_recvmsg() continues until it fails or there is nothing to
receive. If the other side sends fast enough, we might get stuck in
io_zc_rx_tcp_recvmsg() producing more and more CQEs but not letting the
user to handle them leading to unbound latencies.

Break out of it based on an arbitrarily chosen limit, the upper layer
will either return to userspace or requeue the request.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/net.c  | 2 ++
 io_uring/zcrx.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/io_uring/net.c b/io_uring/net.c
index 260eb73a5854..000dc70d08d0 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1285,6 +1285,8 @@ int io_recvzc(struct io_kiocb *req, unsigned int issue_flags)
 	if (unlikely(ret <= 0) && ret != -EAGAIN) {
 		if (ret == -ERESTARTSYS)
 			ret = -EINTR;
+		if (ret == IOU_REQUEUE)
+			return IOU_REQUEUE;
 
 		req_set_fail(req);
 		io_req_set_res(req, ret, 0);
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index af357400aeb8..8f8a71f5d0a4 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -92,10 +92,13 @@ static void io_zcrx_sync_for_device(const struct page_pool *pool,
 
 #define IO_RQ_MAX_ENTRIES		32768
 
+#define IO_SKBS_PER_CALL_LIMIT	20
+
 struct io_zcrx_args {
 	struct io_kiocb		*req;
 	struct io_zcrx_ifq	*ifq;
 	struct socket		*sock;
+	unsigned		nr_skbs;
 };
 
 static const struct memory_provider_ops io_uring_pp_zc_ops;
@@ -717,6 +720,9 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 	int i, copy, end, off;
 	int ret = 0;
 
+	if (unlikely(args->nr_skbs++ > IO_SKBS_PER_CALL_LIMIT))
+		return -EAGAIN;
+
 	start = skb_headlen(skb);
 	start_off = offset;
 
@@ -807,6 +813,9 @@ static int io_zcrx_tcp_recvmsg(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 			ret = -ENOTCONN;
 		else
 			ret = -EAGAIN;
+	} else if (unlikely(args.nr_skbs > IO_SKBS_PER_CALL_LIMIT) &&
+		   (issue_flags & IO_URING_F_MULTISHOT)) {
+		ret = IOU_REQUEUE;
 	} else if (sock_flag(sk, SOCK_DONE)) {
 		/* Make it to retry until it finally gets 0. */
 		if (issue_flags & IO_URING_F_MULTISHOT)
-- 
2.43.5


