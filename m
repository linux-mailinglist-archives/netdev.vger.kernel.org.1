Return-Path: <netdev+bounces-273746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCjHICk4zGn7RQYAu9opvQ
	(envelope-from <netdev+bounces-273746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:10:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EBE371651
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADDE5305F18B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 21:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98044219EA;
	Tue, 31 Mar 2026 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUNxUdgr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E59F318EC9
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991258; cv=none; b=bQLYahEThZvQknfz7HhhMmJ/cD4djvxgBtaXUHGul6JdKWLAFNK+0Rg+SPHyNIzWx7utGTsKSqJOJ4nrp9W6R9Evw8MaxuWX/C7hSK4Or/luLZly9UXPV633wHRx3NVw1XOeoq1Cxoe6LrdjBlOCmHSV1ILsSOiYdJvmiWYpaU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991258; c=relaxed/simple;
	bh=4x8RsRYHSVJ6BDghnxivghnDNMxFRg7y5DdK7gpMJIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkgiDzzp5cFh4K3/r4nfEc0MsrUglGPY0X6YXCLQOdHjzSBU9Q+CD4+AwYevp4QO9XM1LSyMT3XuJUjkslCIYEOmRBLc7MmgZqcIRuSN7L0zZK+rdKdi+Ph5tzJXfkVPiLOL9X3bQKA2oR2IDYWEex8S60rQgNoDe1mGrLDRb2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUNxUdgr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486fb112c09so56936425e9.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 14:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774991255; x=1775596055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZY44Vz+RRtLvJFlfTuASn8GA5yb2+/RMxxe6l4LE5sw=;
        b=dUNxUdgrS5+lK9Txe5EQtd34gvR7ys8FpMt38ovIQtYF76StCu96os33BJnq2Kdu5r
         hZ2AqpZWcUPEUaQ2cGAGB75oiClVjzFo8o/AfI3HKi9F+CfaRHtsiAwzq+nZFG45Ch0X
         ik1sqHYW0jIuVTybMfO8ERHdk/GNIjEYpU9Xi1U2HmROicxJczk8PXkIqjVintia8YCG
         MSCRaI3W+/yy15FI3KZK3Nze5eCDYYRz2CF1M8m9T8SijOwClhjAVgnG7x30xV9ylffH
         OJlVcAXyZSlLM6cvv7pwHmj/dkyAa2AGb1bWW+Cs7NBHcuUfmHjZExu0FZP8KiEsrFXc
         HuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774991255; x=1775596055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZY44Vz+RRtLvJFlfTuASn8GA5yb2+/RMxxe6l4LE5sw=;
        b=h+o7kOGnKdz7lkdIsAAlWbQSTV2q0j3sSyiSkEJ/GsRwg//NoCt0hXZGgT8BSGFq5B
         LacbGfhWGrhz0HQHUBgJR0UJ5NnWrdMTZ/ShnsBiTfCv2HE1+Un+E1s9kLsckeUFv0FN
         g99VzA1RwlPRoAeeM7FcJyaoR0fFPk7iBIXJm1nG8QgbygNagBx4+omz5XMeAZiX/mLu
         16Sj8GV33as2I7SyC5cOFxxC1hvGR0vZjn17UKTtoj6nWmqttmF4ckYZZN/JFVfYuRB2
         8ziESrpw4SRVTHkP83Besy0d7XInVORgsKZJx4IL+Bz6O2CTnnUwNnfB+ye+Sbo8LotR
         OHlA==
X-Forwarded-Encrypted: i=1; AJvYcCVOBIxgLf+eNxB4Erq6g3XArILCJdSh3oqMVFObnC4WnLh0CBhSujoVkXfiK/9xbyS2FNDLbKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywczvy3fLVDeCGZ6ilypmrQO/nmnf0uLZweV7m+xB0VINqYkqi5
	PuhzhDiLBTAowsKDP4V2nkITjzYc4PJJcH9WxoSh2gYbvnNCfQi/GRxU
X-Gm-Gg: ATEYQzxvw7T/h4buxN1HOPCNoK5BK9BZcRoSR4lyxR0L+XJ3gUlaa8zpya+Fo4atwX9
	dbCzXRS+HSPNY4gbgSNA6Bq7yKr+3O8S1gwyQkxkJJbMo2osaN5HSmDpfnr/B6NqBmJ1+VJOUlH
	8tTNU3LSyT57kON342LD2nEeb19wqOxp2XeKvXmc++4lo1lht1tCJJT3ce7sbWzh8oYIe/WODgD
	POa1jKWNa7vsW3FzDwrbhDqZYoarIeEfbWN9OF+LFudMVcwUgnp/UExqOxWXqX0rIlxmbs7kOIW
	gMXfg0NRDMzZ2n+YIhbKNzrqP86jl3jI90nEHNTbw7KQvEG8HC0+Zy8g6tKh+tkoB6IJNOF6MQH
	aqxV32lksSVsSwh17hKlhYlAjx3xYZW4r0yGQsOapla5OGSy4l/dBO5hcEkWO5Gg2QW9YWLEbur
	oEx/s17HckaaDxeFKXfVzpsgbgRFWFW2aTTxAg4DLLz5XyABijDAKtXH7jHC9z8DscYCRy0iSTF
	Ew867/mb4xByJSvYcfA9S6kR/MIkw==
X-Received: by 2002:a05:600c:354a:b0:485:3dfc:569 with SMTP id 5b1f17b1804b1-48883591d7amr14749635e9.16.1774991255327;
        Tue, 31 Mar 2026 14:07:35 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2570b18sm32431393f8f.31.2026.03.31.14.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:07:34 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 v3 1/6] io_uring/zcrx: reject REG_NODEV with large rx_buf_size
Date: Tue, 31 Mar 2026 22:07:38 +0100
Message-ID: <3e7652d9c27f8ac5d2b141e3af47971f2771fb05.1774780198.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774780198.git.asml.silence@gmail.com>
References: <cover.1774780198.git.asml.silence@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-273746-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28EBE371651
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The copy fallback path doesn't care about the actual niov size and only
uses first PAGE_SIZE bytes, and any additional space will be wasted.
Since ZCRX_REG_NODEV solely relies on the copy path, it doesn't make
sense to support non-standard rx_buf_len. Reject it for now, and
re-enable once improved.

Fixes: c11728021d5cd ("io_uring/zcrx: implement device-less mode for zcrx")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index f94f74d0f566..1ce867c68446 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -449,6 +449,8 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 			return -EINVAL;
 		buf_size_shift = ilog2(reg->rx_buf_len);
 	}
+	if (!ifq->dev && buf_size_shift != PAGE_SHIFT)
+		return -EOPNOTSUPP;
 
 	ret = -ENOMEM;
 	area = kzalloc_obj(*area);
@@ -462,7 +464,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 	if (ifq->dev)
 		area->is_mapped = true;
 
-	if (buf_size_shift > io_area_max_shift(&area->mem)) {
+	if (ifq->dev && buf_size_shift > io_area_max_shift(&area->mem)) {
 		ret = -ERANGE;
 		goto err;
 	}
-- 
2.53.0


