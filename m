Return-Path: <netdev+bounces-271510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEYzEdfSw2lLuQQAu9opvQ
	(envelope-from <netdev+bounces-271510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:19:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1085324B9C
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A7DA30D91E5
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9786F3D3304;
	Wed, 25 Mar 2026 12:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHObvrpC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340F13CF698
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440500; cv=none; b=dPibYe0K+gUeHT4zO8u8/0uDtkJtpy5hdNt7Pg5GfcGtD2uKhN88v574j2ePhEGEFGBoX7HgND2FFsO7tyfm93DpU4uycRGGc+cZFk+XBUG3YWHog5qCv/FUobbYYwobUM9TsVCGyQXzU4ixOHdy4kQd99MHcvL+IuGoQiE4FnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440500; c=relaxed/simple;
	bh=wslwPRuez/NmFoaze+wn7942cE05rZxcs4td3vhq7ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvsGJmDSTcHwbYlFcUYXGPcOBf8I2Irzd1xdowPFojUqEf1Bqvrhg2rc1mEMFMLKEFbud8KDtbe3qPaBRM0Uha0+rNAnXlKFcJ7YTBnD4EuqwXMGEtCkqpb4LC+man0A8ABSoWcliHCJ8/Yo4KcLZotl15TmF2hW3AEuGbVzI14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHObvrpC; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b88b7ca76so720379f8f.3
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 05:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774440497; x=1775045297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LF7HDkm7p7yh4zq6uV49ZitMLpCTOaJYCPmWeD6AH8k=;
        b=LHObvrpCExTg1a7BUNAzfSSedPgaqlMglrPEAtumuxax6BFdQPyp219nbkUcQWgmka
         wBX48xXzC4vx21+poPaipsaUIJfKqNHYSSIyU4V/6XEdpq4NCpyaLmX9t1/C88SMNTVq
         6DHVSglok9ovU8W+592z4xgzB1oDjLXbl4RTBL//IGLRYA6QEZyH33mtGYDqcfApLF/3
         0cVLXMfHhpyUsGwMb7cwpCSQaGIbHmuySYfJN2nmat1Z1gH+hcxs6BuTczY94RC7tyTL
         3f4ouxmVBnao6NB1bfo1CLIbuw8sNfz/VsFje7DuxCy97pIrfgOQK8wHq7uXspVXJN7S
         T+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774440497; x=1775045297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LF7HDkm7p7yh4zq6uV49ZitMLpCTOaJYCPmWeD6AH8k=;
        b=NUbz4cL30YNTkeL/LXL94y/HT1oZGh4rhVktQrcCOYqeF3tvQ4/T7dtEV8nEowY780
         K9Acii15tCebec9oYYEaII7aVKWFduYCBScD8BGJ9O3AXEztEfwHLrUjCX5reCFJ+G8e
         8DaAksep8+MA/+QY4qmqTTe28mGq9nfrgOMBRIBR+5iEQWxLxQClycuNKQzf9GUW4LHE
         I2izc5r9FJgyHal6U1lxnlnI7V33ui3bM/sGNFhF/YL89ALaSkSBNaH64q/oSayDf0mW
         e/sZmFgvFSyILjQk5QBrOxf4oRe2rQFlxIGviJ8yA5qlGX8JnSJ3kdCceWYQvaC5aYjt
         L/yw==
X-Forwarded-Encrypted: i=1; AJvYcCUFPTqGaOY313ptrd6hUBgIOlEYwAG6TwZ9wCdqCvBMf+FGy4EJzmWvIhnkR6Q8RAB4HmD46vE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvysYTwTc2QgpRF1ErznBAVcWbuSVDNd59muk9kyugncdSFxg+
	mWls2JWbBc8W8u8oNA0q0vSaIRRwKvx50Uu9/UIdTaWXkdZ/jLVfDwDo
X-Gm-Gg: ATEYQzytVVlEk4wOpF0jXXtCseqVLbV2ZiPmmXZo45hLGo8vh3hxFFHI+x7SV0PT8ec
	p4Kx6uADdaTGMNd0eMe2CNw9GRQqRS4+kByOwCYRgsNvKEHJEWpKGs1A99G8+6QT7BvaEQGFGVL
	/ppOcaBqi4/jU+XH+ls9/uSDbMywnLqOJ8am0nqzB2seV4z4xJFojUH7PDGzaS5JNcin9WZdaUs
	uP/VV5e9s9GLduFzxbZm6vyTjugeHPv6bDM5B7I+I+MjGE42q504RIuROvU6GnHuNrVIVh9P7Ie
	lJ8dPxaz92g0oiUAQ2VMY+oEr9vfWWDAn+6uioACFyL5bS3xnWGx3PAT7HmCKfh/aqboka+cbL9
	9BFfRCXDwcJ/UL84Y/fpldrm7eGtm5OT4iYIyJivjxWfvduuIxm8tptAMCVVVVQICE4dDYiKroh
	alNwR9b1qb/x5WoNQuUMDre6HbIg65ONk/Cz055yMVpRDZG8xMb2o9cUmK4r9dkWQ7dmgRC4Mvo
	205av3Fog==
X-Received: by 2002:a05:6000:2287:b0:43b:3d80:b0b9 with SMTP id ffacd0b85a97d-43b8898607fmr4698257f8f.12.1774440497351;
        Wed, 25 Mar 2026 05:08:17 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae37dsm48618289f8f.2.2026.03.25.05.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 05:08:16 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 1/4] io_uring/zcrx: don't use mark0 for allocating xarray
Date: Wed, 25 Mar 2026 12:08:18 +0000
Message-ID: <28d55404178759ad982e1c750741bb16356271d6.1774439286.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774439286.git.asml.silence@gmail.com>
References: <cover.1774439286.git.asml.silence@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-271510-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: B1085324B9C
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
index f94f74d0f566..695398d2f2e0 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -927,12 +927,12 @@ int io_register_zcrx(struct io_ring_ctx *ctx,
 
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


