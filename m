Return-Path: <netdev+bounces-268197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML++AfgnuGnhZgEAu9opvQ
	(envelope-from <netdev+bounces-268197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:55:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6044829CD2B
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD165307BD80
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9F33A7F78;
	Mon, 16 Mar 2026 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKRe4kkC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9BB3A6EFF
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676180; cv=none; b=UYF4JOOZJjKzr/b04ncaIowvXtnoF4KvAvSjsBE81eClYopK1Q+lQ694kyiH1YQsfgvE9sOjTFHGlsepPWdRnEPeBI1WxT5IbooR636zrapF9L5EKQprVIdykiMIi4EEQGud/F7vnYYy7/IgYSNf6PrC1ysmNnGf3ryvFYSeZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676180; c=relaxed/simple;
	bh=xhj7V5VOHhyPhjZT8w+2BQtGE00MYdrzk3o+IvpVuEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hrrcUaL5I/nVmX1bwX+0N7foY0rBmyfuKtTI8SGlPnIZ77YveKW+CUCxn5zWCFqsWj1TOJvLrGeRmSYuOOfPMOMzAu11bpvA2oI77YbMD0QDaLDb0OIaO/Q22b8+mF8FQQAQgjBU7f/b+Ac0FLWM8YlanugoVLOoG9+r7r44Wao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKRe4kkC; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82a3d3235c9so1105413b3a.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 08:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773676177; x=1774280977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I6uZPXtzqz7Sbxlt8I3hTrbR+x+36hfWguC11NiV9bo=;
        b=cKRe4kkC59oBmJ/78byqIkDm1LmxXNPPoJGE8qOKBJuQZUCnYTODgvPMoeLThip/gH
         cqtA+wF5+eH2EZECS59Udi4JZTc6pOhB1Xb3+hd79gnVLdOxmsIS9wwt/cLohLhKnYJk
         SJor9rSTQSIsr4Dbw0k44e8Dm6bahMoB7uUDQmhhnDcqu95UQX/XRomcik9/P16Btifk
         kuntQnF/vDpwF/5cptIlXTe+aanMzsuWtFmftowKxVncKxL+GqEDFxIGeQkcAgL2ZfJU
         /7+AbgolCVryXr6K2oEIt+5dz+39+J0H3e5FsNHWUiR8/jl4c6LtEFyby+lmigFcVP87
         gckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773676177; x=1774280977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6uZPXtzqz7Sbxlt8I3hTrbR+x+36hfWguC11NiV9bo=;
        b=gVW0uRoZMqARCPsXLAg26v1HY4yLsssifiwxsgRXyTlBzCL3tsihYQ/OdDoofO05hQ
         GTb54z+3gCYDh/YfewdGHQ0NhTCPbMEQTXHQBjARZral8D0Tx6lFQQRQYvkUWnmhmMSR
         YS33HjXdtcYsV8MK6+GAIGSAtRC3D1YcUgwsaQDA8McX1DDBh16tLi2iOQhTi1YL9IeR
         z7NHlscs9OBhENKXubUdlOypMX7GTZBtsDnmCwXwAl1A9x//bvqEmNe4eHS8pCJFuZDs
         tpMxtJlVOrZsbIhgLQNCBOL+swEiYIkt1ppZ9DNrcXKy8gPlGfEQ6+VRKWMtLaO05ziy
         i09g==
X-Forwarded-Encrypted: i=1; AJvYcCVSZA+I6BGKyt/nNMP/+QfN5SNWZMDdnjWWREVtUnR4wwYKubemcbB5dK4KGoQIpbN93BnwEUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhhXysT3IOPr/AmIATPQBL/qwCyLxF7h4mCuD9SQSd1RJfMBwx
	SgwzwSPlgrGP0IG+K20ADl3EhTIz0RIAHj3Vox983CXeauYF7IZ3n43m
X-Gm-Gg: ATEYQzw8LYC8IcoEscCDjHTQesSS4wiHP+eYmx61ZI8/LoXdCfc00bYiy8xj5pHJmhv
	+CGKihqTURFDCZQFSa/Pq/w2aTO1WcacQTd+Kp/9iFQOQnGQGP379R20h6WP+IHywWecvgYwXmR
	K5SwsM51McIAlyyjFESfldFiFcMsto9inzhcXM/pzUc4o087qwZ79biVQPrpekDIDdr1WA//VpL
	ZxDJxBL6jsm0WotB+B0q0LBsUwCKseNEdNeik6Wa3boGG2mZ3Qk/vIfkBJCngAQVfXeWCExaaez
	1p9KdN/YK8pvNWeMyuuZfx7B316omVzJo1v0vOQn3/XpP4qRgQfbDxRpYzWeN+KLZpI5AbejvaM
	3CBOb3Pa4H4Aqpa0/3gCjgKuW39usaJcryWu6dAtd78tM7oGhXWuBwSxr0N1bqcNvuYQ1MeZ9pV
	v5oMbVShznBR6OjBzm8sXdyxo3
X-Received: by 2002:a05:6a20:a111:b0:398:72b7:ec8f with SMTP id adf61e73a8af0-398eca384d3mr12261294637.18.1773676177484;
        Mon, 16 Mar 2026 08:49:37 -0700 (PDT)
Received: from ubuntu.. ([152.58.131.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb993e40sm9149350a12.8.2026.03.16.08.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:49:37 -0700 (PDT)
From: Anas Iqbal <mohd.abd.6602@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anas Iqbal <mohd.abd.6602@gmail.com>
Subject: [PATCH] io_uring: cast id to u64 before shifting in io_allocate_rbuf_ring()
Date: Mon, 16 Mar 2026 15:06:36 +0000
Message-ID: <20260316150636.2123-1-mohd.abd.6602@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-268197-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.dk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohdabd6602@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6044829CD2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Smatch warns:
io_uring/zcrx.c:393 io_allocate_rbuf_ring() warn: should 'id << 16' be a 64 bit type?

The expression 'id << IORING_OFF_PBUF_SHIFT' is evaluated using 32-bit
arithmetic because id is a u32. This may overflow before being promoted
to the 64-bit mmap_offset.

Cast id to u64 before shifting to ensure the shift is performed in
64-bit arithmetic.

Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 62d693287457..d96d2802f3da 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -390,7 +390,7 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 		return -EINVAL;
 
 	mmap_offset = IORING_MAP_OFF_ZCRX_REGION;
-	mmap_offset += id << IORING_OFF_PBUF_SHIFT;
+	mmap_offset += (u64)id << IORING_OFF_PBUF_SHIFT;
 
 	ret = io_create_region(ctx, &ifq->region, rd, mmap_offset);
 	if (ret < 0)
-- 
2.43.0


