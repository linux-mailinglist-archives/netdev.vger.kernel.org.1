Return-Path: <netdev+bounces-228050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2FEBBFE09
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 02:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD81189B9D6
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 00:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593A11D63F7;
	Tue,  7 Oct 2025 00:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCvpPNDf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87B942AA3
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 00:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759798073; cv=none; b=I66TZM8KlXCk9aIf6QVPXPkqSP0m7Sg/O9214W6b0/hhdVSMuienVMfBR99Q/KB1/K2Y19GMdHHLaA8F0YADWz6h48MIxjOFUiPzjpTybQLN6lhon4ctiHPLdB7vRTex3RZ1+AyyTGMS6/hUezjtYFcQiBHWYDy9oobJC2deaJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759798073; c=relaxed/simple;
	bh=1XL2wNRN0F30fQxUtHkkK3QNV4GjsRj9jIuYs+uhi2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fKBGdqY/vtqrhHAeg67QSLRomH8JYCIE6pMY1r3OIKnJ2GntNANrQUR5bHkCydLpWFbYqmqPO47Qj6DzSKPk4v0Vr4e+FkfpXIsolFyj53v1quKejNZ9uvFUWthPf+8ExKYEhZDPalWJbnDtPzGYrk/GcIQfBEORccdBiLFH5dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCvpPNDf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-26983b5411aso36959295ad.1
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 17:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759798070; x=1760402870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2UxzPjq4bfBAqt8odMbxV/jMDGXYJds2ek2mqe8HYOw=;
        b=ZCvpPNDfC7HZlb1rrGqqrT2d0kUTcKvN8H57HjPkFvDFr67jEeoI1Vuc1SVr0rP8ow
         n49hoMd5Wgaug4pOxy5F+/DB4AjdBluzgYKT0QwBLOFvJkoREUBo9o5CaMnMDDztUnu5
         gNRvJKVYUHY/suNk265B/YVMqkD8GwPtztMGDdaVw/F5Vs3144fJpPXqNne7xN29PAiC
         YvZEY5BsP6of/Rmi9bny7SnXRj0df8nHz5y+mLLGyxVtpb7KW+wD4nrO+SXcV4qiM77A
         PaKufkqqmJuyYnE2FuepiakHTDUH0Ips0cUBzptiTr+lGZAfkr7OH0XHu93f6haLwL31
         5zGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759798070; x=1760402870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UxzPjq4bfBAqt8odMbxV/jMDGXYJds2ek2mqe8HYOw=;
        b=SaooKEUa+d7bPXS2C6xPJcdD9tLD03tQmGl2VRKCN7Aei0nc1k6evOXChgiEdXZ7yv
         LX+ud/O3ZI9TTjBj28E6aD4kKcXH0XRTZSlM30NAxFWb15ZcB9NdkdikENnPIIFm6KvP
         /El1608sRTvVswzgt6Jli3izj22Svf1elymCXboliSuj2Yn/BwTF7B79kWCc8htSaWEX
         E2i6S+5C5sbREvChyCSJUaKu1Y3e37vOnXY3U7hqhaMAHt1L6yxu6uPvUzHiPx2f8HbF
         7urIY5FkOr4KD95E5XCGavMSz6m9vBh9S4ExjnrFmnDCEObXPlD5tdsJaC7WizEmjJ4I
         CzvA==
X-Forwarded-Encrypted: i=1; AJvYcCWLdYP1w3c4JERBrW086vgE+8KuLCsLjka6SANqyGVnXlQaPoDB19J7tsW2Td6Otyil0xRwf8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj6WTRywR3RKa4PD1cFaNLRaDuF5j1WfL9djBqHXP6sAkaVNOu
	a2gUs/7W0pb7agxxlO/cO49ZARRyCQ1cdXaJ779f04UPr4C0t5yG3E81
X-Gm-Gg: ASbGncvfE01tH2lyHRIeKaikJyxO7Ea8+lkL+GhIg5TVxrBsMXP2hlxEkz22RgsFafC
	bRKPt7UGpW2yVgUo7j8foPSPvHwAW1wBkPuqVzIiO2qjdbp64Ekc5z0A6Vt0tVHUSy2Un/Gv++J
	Hk4BHKk53bFr6c6AgnTgrQVVvlRcmWKo56OKj8oqSYgRVOpS6NtDucmf+29MjpyfiaOSzMeGIdW
	BiPap4A3NUQFcx0TlxfDTp3QkT+28FzeWIlwEGKwI38c+Dzt7ImpJWl47k57QEq5QOpwnObbwH+
	YnZF8WNlhFB3UqTvJPpEaurjU0v6zLwqczS8qUkLYd3fgo6ANQAn7VTz6s3+qViRbe5HzEWNjRZ
	Hb2qNUiTzfw9HryEZkHOoZ/yu0YYY7ZQvUiA0oBfjYPSkrnpRkEZwWOc=
X-Google-Smtp-Source: AGHT+IFMHyFATUeNe+Fl/tyGv+NYdpmbcD1fdDtkwTi3zmOMHIkIEROkuXuqnLBQ4I7USPiqifZxCg==
X-Received: by 2002:a17:902:f54e:b0:24b:1625:5fa5 with SMTP id d9443c01a7336-28e9a54ed9dmr169316955ad.11.1759798070010;
        Mon, 06 Oct 2025 17:47:50 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1ba19asm146468945ad.64.2025.10.06.17.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 17:47:49 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH] nvme/tcp: handle tls partially sent records in write_space()
Date: Tue,  7 Oct 2025 10:46:35 +1000
Message-ID: <20251007004634.38716-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

With TLS enabled, records that are encrypted and appended to TLS TX
list can fail to see a retry if the underlying TCP socket is busy, for
example, hitting an EAGAIN from tcp_sendmsg_locked(). This is not known
to the NVMe TCP driver, as the TLS layer successfully generated a record.

Typically, the TLS write_space() callback would ensure such records are
retried, but in the NVMe TCP Host driver, write_space() invokes
nvme_tcp_write_space(). This causes a partially sent record in the TLS TX
list to timeout after not being retried.

This patch aims to address the above by first publically exposing
tls_is_partially_sent_record(), then, using this in the NVMe TCP host
driver to invoke the TLS write_space() handler where appropriate.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
---
 drivers/nvme/host/tcp.c | 8 ++++++++
 include/net/tls.h       | 5 +++++
 net/tls/tls.h           | 5 -----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1413788ca7d5..e3d02c33243b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1076,11 +1076,18 @@ static void nvme_tcp_data_ready(struct sock *sk)
 static void nvme_tcp_write_space(struct sock *sk)
 {
 	struct nvme_tcp_queue *queue;
+	struct tls_context *ctx = tls_get_ctx(sk);
 
 	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
+
 	if (likely(queue && sk_stream_is_writeable(sk))) {
 		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		/* Ensure pending TLS partial records are retried */
+		if (nvme_tcp_queue_tls(queue) &&
+		    tls_is_partially_sent_record(ctx))
+			queue->write_space(sk);
+
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
@@ -1306,6 +1313,7 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_request *req;
+	struct tls_context *ctx = tls_get_ctx(queue->sock->sk);
 	unsigned int noreclaim_flag;
 	int ret = 1;
 
diff --git a/include/net/tls.h b/include/net/tls.h
index 857340338b69..9c61a2de44bf 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -373,6 +373,11 @@ static inline struct tls_context *tls_get_ctx(const struct sock *sk)
 	return (__force void *)icsk->icsk_ulp_data;
 }
 
+static inline bool tls_is_partially_sent_record(struct tls_context *ctx)
+{
+	return !!ctx->partially_sent_record;
+}
+
 static inline struct tls_sw_context_rx *tls_sw_ctx_rx(
 		const struct tls_context *tls_ctx)
 {
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 2f86baeb71fc..7839a2effe31 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -271,11 +271,6 @@ int tls_push_partial_record(struct sock *sk, struct tls_context *ctx,
 			    int flags);
 void tls_free_partial_record(struct sock *sk, struct tls_context *ctx);
 
-static inline bool tls_is_partially_sent_record(struct tls_context *ctx)
-{
-	return !!ctx->partially_sent_record;
-}
-
 static inline bool tls_is_pending_open_record(struct tls_context *tls_ctx)
 {
 	return tls_ctx->pending_open_record_frags;
-- 
2.51.0


