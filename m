Return-Path: <netdev+bounces-271542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL9PNh/iw2lvugQAu9opvQ
	(envelope-from <netdev+bounces-271542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:24:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 511DD325AFC
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0497F3108EC3
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57E63D8137;
	Wed, 25 Mar 2026 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xg/6L6nw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B343D8918
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774444162; cv=none; b=d8P0IMEfITwahEVCyJkbS5ZphyBT0qEkhBAjYcrXzqY/iuaiQqtDZCWO/zSMkGAPumNQw6n7aeposoAtUfe6fznip5aD62TXIeAduwxYlFxa2xtIpTOl/b6xbcdiJqREXaVSYDvqCSUrXF9uQnb6eL1GiZfxnkFhgv4jqVUrcqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774444162; c=relaxed/simple;
	bh=r7gVySrUUNsfBFCPZKXFqbsg/O6mHB+cNjJyBEtDGEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uY52QyuXdK4iCwOb9m/6Jo/OVD5yUXVeskzQoeUXVDSld373xJWVoMIKL8SJW1rbX2vp61Xxmd1sMbouxchwlJTC6xT2NwElKbGiimcO+BW/zMIuRZ5BxQW+UK6Uvan41v1yYtc7+1CaS9vFKpAM+B+wUJ/d7tYqHAWvu68JOcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xg/6L6nw; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso5340594f8f.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774444160; x=1775048960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAc4mOPKFfNTckqGfMJzU1oKEn8ryqKVY5PrIYqGkRA=;
        b=Xg/6L6nwusJlKn3TzOUIApUWgodS1tPyL0p2LNCR60T9mgVXZqB+k2X9FyetxG2xWJ
         UUEp6Sn8fUKJXPWu7Ke1zJ1BhyvjLsRODH6cvhmz05iFHbDVdRYRm1K2cY0B3Jqt0HT1
         Yt0K2+FPFFf/5OlkLKU62yYSHlKA5oS4s/23G852lb7urzetIxmQIomIxln5IPte5Xob
         ZXJMU5+4EsYWSDAbO315xMb4lv13LbF6/BucRlcxHyd/kKQ37vr89yUfT3XljPLUvepZ
         JqpD4Que1lxYr9HaCaTC2v+6L6hjvjEq5Akqkngr0xbAW/9eXiITi7s41h6huTEy9xuY
         sGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774444160; x=1775048960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WAc4mOPKFfNTckqGfMJzU1oKEn8ryqKVY5PrIYqGkRA=;
        b=lMsYPIJsbO+Zm0oLhkjtTeavuLCdzwFwbhZj9TIKhBn9O7ByajWKqVNS7/XcouV/9R
         2dvAvdubmLX/CHKSOFLOIIVhKJ3RZUIHgroEyA3bxAhU6wfFJC6wKeqiqme9wZQf5lGY
         CtyIzp813QYpNRjCGrSd8HQbPksdC3fhdAKplGE3howKVzu64IcTuQHBYAX2bbQIBdWq
         7nWH7trGtkmLxc0E2jmMhSqaGOyzrXrzP6X14dOvpcnEjH4FQTEp6y/RcL2sw8ke2/xG
         OS5CgQwgfOaJC6pXbhNePENJ/TFPsPP3Ti5/B2XQ7mjf8e452FOJsf7Bn8EpG6DL34Rx
         /kkw==
X-Forwarded-Encrypted: i=1; AJvYcCVrCHuZmGgYoaxJQpbjoU7pWckTo1APvNI4eXyZsdEzr+y66SY6JO3dbdASjk+74USxJz47UQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDhNJVq2byVe4LsNw0XeYCqEeHhVtP+JBCWqVUsmLRyOBsmL5F
	XGH3DkWacTtDUKzURGb6oRSmalD9iInAGQGy0B2nMsH7qAaOC6GDe5GK
X-Gm-Gg: ATEYQzya9JZz7/6zI8npaoYReiFe+EsVuZF0SfoxaBaquTowdkjJ9+auvfokjpcnEka
	L4HDNcsYLnZLtIKyvaFm6uqAvfZCvcCS/ULt6+oIL7EUDA7i3Vl4PWb3vGUQhj6e+ifb4Rn4DEH
	wZ02GMkfIRQq8y0xO11OoTGULBeneplKLZ6GPpu/GlVIbJX/AGO3quijJFz0KuKcHODTmog2Ptd
	QjPJgdEgJfN3F4kQDSwSn07e9lnrfNHiPR+qX5aaeplIUYc/pip3gaA/svEi3AmgNKoUcrXnseg
	7W7mV1R2K3FQmURtBMIBbQtgVi3IETuGouZnI2zKsyJHKChfxQEIdwT5To1SqS6Z1CBo4YExwR2
	VZo2/4+Ee8bfksTCOs50sRIy4+ueA5nCz3GTcm6kZsHAF85p1Oa0JX5g5EGH0HGKoD8BcsO+2MN
	4vfWygdWS5p+FT7v92NMOOBt1wshjWYgEKKyMjgk+l6nRZJ7jEVIZK3sltfnsji5Kt2eLVzjP8g
	L7shqQqfg==
X-Received: by 2002:a5d:5f47:0:b0:43b:4a2a:2cd4 with SMTP id ffacd0b85a97d-43b887f3e18mr5165518f8f.0.1774444159848;
        Wed, 25 Mar 2026 06:09:19 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd923sm54062611f8f.12.2026.03.25.06.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 06:09:19 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 v2 2/5] io_uring/zcrx: don't use mark0 for allocating xarray
Date: Wed, 25 Mar 2026 13:09:19 +0000
Message-ID: <b5be2425e187942277ecebec034a2294794bffcb.1774444007.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774444007.git.asml.silence@gmail.com>
References: <cover.1774444007.git.asml.silence@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-271542-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 511DD325AFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

XA_MARK_0 is not compatible with xarray allocating entries, use
XA_MARK_1.

Fixes: fda90d43f4fac ("io_uring/zcrx: return back two step unregistration")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 1ce867c68446..dede892bdda9 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -929,12 +929,12 @@ int io_register_zcrx(struct io_ring_ctx *ctx,
 
 static inline bool is_zcrx_entry_marked(struct io_ring_ctx *ctx, unsigned long id)
 {
-	return xa_get_mark(&ctx->zcrx_ctxs, id, XA_MARK_0);
+	return xa_get_mark(&ctx->zcrx_ctxs, id, XA_MARK_1);
 }
 
 static inline void set_zcrx_entry_mark(struct io_ring_ctx *ctx, unsigned long id)
 {
-	xa_set_mark(&ctx->zcrx_ctxs, id, XA_MARK_0);
+	xa_set_mark(&ctx->zcrx_ctxs, id, XA_MARK_1);
 }
 
 void io_terminate_zcrx(struct io_ring_ctx *ctx)
-- 
2.53.0


