Return-Path: <netdev+bounces-142148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F249BDA6F
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B282844BB
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 00:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5F177102;
	Wed,  6 Nov 2024 00:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jcdAslJ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516BC824A3
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 00:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853559; cv=none; b=WUpuiU9zpc758nh6vYLSENdSwRIV0HyGU66Lkj4YgemyvQbLwS6Ap4Ucku9eQAHhqFoF8pZ/q2oRW8erTbDF+QeMn6i++JM6JJtn6YE3Bzu+IEtLr9KhMnNo6HRbTYrXAImUbg0wm/O+WR2HLcKhTOmOyNvtVXtD8WPU6dqAZlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853559; c=relaxed/simple;
	bh=by32IE336Hfg1ZepFFKUXShaPRejDSuxD4y4RsG8xZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lsaY6hPnFmUWuX2zZ/HNi/ZYDXiKc36cVRN26O3p+g/mfBS5V5gbYcSZsEUP78akgwnppnCG/uh6in/hIS4pT9Re+YqAMHq+A7hCxNRqJWGLCks2AWHNCCDZV+CmaUk4TggSqgxVGnDOR7WYxjW8h3VYBVq4tlMx6CudqA5KU0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jcdAslJ8; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cbce16d151so39453076d6.2
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 16:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730853556; x=1731458356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MFE3rnWlDO9TOPgU/x/PksWFDjGN+EdAstAvxKzsDPc=;
        b=jcdAslJ8tdzM+RtK8KxFcqN/XcxIHRaNz3jrpj4FWUKoDwSbdzGPubSqxLof8zDDin
         PYpRAzq294se2zWBDTbWXdtWqBnVoaC7q3J66ncyXyIFaeqnyoG3LRcaZxWwIj5xHWU7
         w1NnV6I/qC2hamq4NxCPbRqBCOnZWfebEePOLYceTOr3ewotydsRIEM89l6yPqpZKoXD
         QyFqXo1ciswYE9BHe0lgeYOo4cL7VTCXA1lN+yZrFbVSHbpAPhSSRZMr5QMA+/6zATqt
         NVTmjabcm/Vnj7+clHuRJ7vXfpns8F8HTk4aKcSVyvr/9tMkQN7Q57MHKJzM5oMkRvD4
         uBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730853556; x=1731458356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFE3rnWlDO9TOPgU/x/PksWFDjGN+EdAstAvxKzsDPc=;
        b=ClLaUlvC1YShUgXvN/Pj0MYhASltZ+3GfDx9wyyfcGzypvD1+4gq39bvkWUZXn7rBZ
         RAxyO6HOAD3DBAGUjH5vjuFNV+CKQgyviGy0kXACyFhq4+YjkryjCFD65razR4t9H5SK
         eA/TybBy+cV1ckKIAnJ2nUsPP9WXfGMEi0RUkhaNq/VkHLzEpwDBPyDkkrHkpLikA4yq
         P1W/VnWXoAmk/QTspFmzknKP3FOUJGSWwljBIfVTZcVcLnw4GGRQFzyKibw57miBT7gy
         qZk0lVWStvWGLD9Z2yD19ztlRy9q0n10pXT/mNZSlxHCNwR2bsw9OGdjJ9lvYTUna8Ps
         hJJw==
X-Forwarded-Encrypted: i=1; AJvYcCVyJoCjUEcmGlAooAHDjju0+8unoeQcgTC71yrQcnqihxyk/L6MRZXUtDq5+eOQ+mqU9HgTCvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqTtCUvKXJ7kX0U8WYSO3HohZ7FIWSDmox1QgN18P6nrLJTiXZ
	ner8yTcDgKCGDRK9LbCnysw6a2upZt8o7BajTRjExZwLFgLYDb8uHxdHlQYsHYs=
X-Google-Smtp-Source: AGHT+IFTwjnl/SA5Vgvx0PPRcekCctjJ0j0BLw89Hg8POpY6eepXTU4rnj8e8tV9p3J1Vc/PgvabsA==
X-Received: by 2002:a05:6214:5a0d:b0:6cc:2c7c:92e2 with SMTP id 6a1803df08f44-6d18568f553mr537291756d6.18.1730853555966;
        Tue, 05 Nov 2024 16:39:15 -0800 (PST)
Received: from n191-036-066.byted.org ([147.160.184.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3541614e1sm66312226d6.86.2024.11.05.16.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 16:39:15 -0800 (PST)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	mst@redhat.com,
	sgarzare@redhat.com,
	bobby.eshleman@bytedance.com,
	jakub@cloudflare.com,
	andrii@kernel.org,
	cong.wang@bytedance.com,
	jiang.wang@bytedance.com,
	netdev@vger.kernel.org,
	Zijian Zhang <zijianzhang@bytedance.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH v3 bpf] bpf: Add sk_is_inet and IS_ICSK check in tls_sw_has_ctx_tx/rx
Date: Wed,  6 Nov 2024 00:37:42 +0000
Message-Id: <20241106003742.399240-1-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

As the introduction of the support for vsock and unix sockets in sockmap,
tls_sw_has_ctx_tx/rx cannot presume the socket passed in must be IS_ICSK.
vsock and af_unix sockets have vsock_sock and unix_sock instead of
inet_connection_sock. For these sockets, tls_get_ctx may return an invalid
pointer and cause page fault in function tls_sw_ctx_rx.

BUG: unable to handle page fault for address: 0000000000040030
Workqueue: vsock-loopback vsock_loopback_work
RIP: 0010:sk_psock_strp_data_ready+0x23/0x60
Call Trace:
 ? __die+0x81/0xc3
 ? no_context+0x194/0x350
 ? do_page_fault+0x30/0x110
 ? async_page_fault+0x3e/0x50
 ? sk_psock_strp_data_ready+0x23/0x60
 virtio_transport_recv_pkt+0x750/0x800
 ? update_load_avg+0x7e/0x620
 vsock_loopback_work+0xd0/0x100
 process_one_work+0x1a7/0x360
 worker_thread+0x30/0x390
 ? create_worker+0x1a0/0x1a0
 kthread+0x112/0x130
 ? __kthread_cancel_work+0x40/0x40
 ret_from_fork+0x1f/0x40

v2:
  - Add IS_ICSK check
v3:
  - Update the commits in Fixes

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Fixes: 94531cfcbe79 ("af_unix: Add unix_stream_proto for sockmap")

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Cong Wang <cong.wang@bytedance.com>
---
 include/net/tls.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 3a33924db2bc..61fef2880114 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -390,8 +390,12 @@ tls_offload_ctx_tx(const struct tls_context *tls_ctx)
 
 static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
 {
-	struct tls_context *ctx = tls_get_ctx(sk);
+	struct tls_context *ctx;
+
+	if (!sk_is_inet(sk) || !inet_test_bit(IS_ICSK, sk))
+		return false;
 
+	ctx = tls_get_ctx(sk);
 	if (!ctx)
 		return false;
 	return !!tls_sw_ctx_tx(ctx);
@@ -399,8 +403,12 @@ static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
 
 static inline bool tls_sw_has_ctx_rx(const struct sock *sk)
 {
-	struct tls_context *ctx = tls_get_ctx(sk);
+	struct tls_context *ctx;
+
+	if (!sk_is_inet(sk) || !inet_test_bit(IS_ICSK, sk))
+		return false;
 
+	ctx = tls_get_ctx(sk);
 	if (!ctx)
 		return false;
 	return !!tls_sw_ctx_rx(ctx);
-- 
2.20.1


