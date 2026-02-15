Return-Path: <netdev+bounces-258801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMTzNbI6kmnUsAEAu9opvQ
	(envelope-from <netdev+bounces-258801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 22:29:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F57113FC3A
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 22:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CC3030094CF
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 21:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A95D285C91;
	Sun, 15 Feb 2026 21:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGUuqp4v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C54F273D75
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771190960; cv=none; b=dAlMXu10zq1NEXeH/TRTdppfgDVPkFQVKnlqsrpHRmTYc2J25f03EA83jtxdq0nmwdNqGbiVPSZRLaGrmujgX10rSZhVRT0Sz+YXlYeDFOKy8hwhn4h5+qxHt2VrD7zuK92pvR8vsFTpIdcPGmRARqiqR2Ky8H3I24jTqRZkCbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771190960; c=relaxed/simple;
	bh=8B4rXAz9X0DmROqROTQqwmDddKFeM/oPYgvUCG7iZJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVuLbzP+E1s3x6meJF46avFWrvBJa6jkGk6ZocRxWitwl3TFYdoV9FSOl3LoG4uoH9cQIqWYpSWJWEJO0dVAijrHw8KijyYgFGz2OAeqn/DHUXsSDFgAE8XWTrADQwoSIX09hvlzzBtGoG3gv2n/EK+00LvdLBD+zncJ+QLkE90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGUuqp4v; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-481188b7760so21147145e9.0
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 13:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771190958; x=1771795758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mWyuroIb5nKyvTV5TUC4bt9dw2HBcrZYzowX9Pd+2cg=;
        b=MGUuqp4vL9PksM3ghlxoGbDa1R8WKusiky56oEWNv72184zLM1/uLg2T3UHVFiXHK/
         +VTH3wtgtCF1m00R2zGwVG8f6EsGdNkpnaq1bgtuD2EKYsk+a7waBT+x0kT1A2YWQmT1
         KxR3MydEuNc6QB0l4NyUCiMJbqPkLPFIr2XTeOIoDPsgly+suPxwnaqtMSkpAftXT9AF
         qk+J/avKtbH+BSTH1orn0CWajoeeJD5cNSN9iE1L9kV6Y0ZZXAWt4zA777aIARh2kuRL
         XXdMnjKVGKk7awaAfC9GAvVcycObVJaY6hBeXJ6td+FAxZl8C1S5gUbEVwilVfOUAPd0
         ifDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771190958; x=1771795758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWyuroIb5nKyvTV5TUC4bt9dw2HBcrZYzowX9Pd+2cg=;
        b=UUq8Z2/fqlrGaqr/zMDy+5S7GidMZQJZHcbX/mtscN9v7hHiNPXsyaXGFw81orG8N5
         qpmgDkmoXq4KCZ10uk4aOQIhCs1ejxqbNWn9qfnLXVP92gx4LD7FXFcIt0eakIKdhUmw
         bbaTzSiU44/NsZV0ktHkN2jF4YMuvH9XhmuRi38W3cSKY4lBwckZxzVR4wF2butH2Utu
         ppjJf7uE4Xk1aV8b6vxUDZqcFVbM2OpxVprM9bBKdr82ltmgc8X6B/6nzOGYadSsnRsB
         CYk2oR1f99pMrTVPjxClJLeFXfnt9f9gurT9ghanhCJUEu0xt64phcnHiHlJEgNlB6BH
         JtlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF1l0wpPbWcbyo3CSNC13EPEwQ5ScWAUppZ4TT8sTJs2kV5n7U9JH5V80Z8M2uzfK8ovmngq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE5lDS3VPhOJUBAp0WZp/FhMwFeLX6wME/UwyofHvDqF9mjf4R
	7fGGOBJY4d4+eWA2xAecBae7OJw6OMDSTa6FgBlxC5Z7dvW8bE7hMW9MHxltlg==
X-Gm-Gg: AZuq6aJEbRpb46Ai9r/Z3OE112J+WXXrTDN96jLgLjIT2x6K5rIO3chfHV39pmFUsI3
	3xKOClOwfjGgqjpl1bMlNaNZ9GM1fsJR/PwZlIiqGntmVXJgUhaXriu6nlEpBSsSt70yhnUf50M
	i/a9eTE9gffBU3U+8FwSx3pEx75dCQuN8D5Va/sIeCNl5Wf6Ii3k08AsX/wh8UYIGzHvkwQWRAj
	ha2krG3tyeAnOww4NIvLCv7K9B/RSR6pHJseHlI3RZZ2y/zoNy/WpUux+9mo7sUAqSwpI48knY8
	zDusk9vIYzms8/s+srzmiOaLxOVEMzj3hqgNRqpFy5V7UFmXBWjcIS2F/JAVuTtl5HHZQgw5Jeb
	ncRQFmdjTlVUuzB8YdRW92Rmr9HNe6xbrWrZz4uDBKe77Esk53xnB+p8YyMhhtYbIyB3H7qeh+8
	I79lxLOlz2GziXy0sELry6BECSNuzVFQcNoqtigGYkRgmhayr2hsYysFXHwQ/hYrOLKC0KLHkyh
	oULYRAlFuthax8tFtLxGtX65+ifvY8m5erPwQgF
X-Received: by 2002:a05:600c:a43:b0:477:89d5:fdb2 with SMTP id 5b1f17b1804b1-48373a0808amr131695255e9.14.1771190957421;
        Sun, 15 Feb 2026 13:29:17 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a409a5sm66790415e9.26.2026.02.15.13.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 13:29:16 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] io_uring/zcrx: check unsupported flags on import
Date: Sun, 15 Feb 2026 21:29:12 +0000
Message-ID: <0e2e7c6211f2b40fb830f69f1084f0a3948bf2ee.1771190842.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258801-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F57113FC3A
X-Rspamd-Action: no action

The imoorted zcrx registration path checks for ZCRX_REG_IMPORT, as it
should, but doesn't reject any unsupported flags. Fix that.

Cc: stable@vger.kernel.org
Fixes: 00d91481279fb ("io_uring/zcrx: share an ifq between rings")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 29ca1d897be9..13646d09885c 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -702,6 +702,8 @@ static int import_zcrx(struct io_ring_ctx *ctx,
 		return -EINVAL;
 	if (reg->if_rxq || reg->rq_entries || reg->area_ptr || reg->region_ptr)
 		return -EINVAL;
+	if (reg->flags & ~ZCRX_REG_IMPORT)
+		return -EINVAL;
 
 	fd = reg->if_idx;
 	CLASS(fd, f)(fd);
-- 
2.52.0


