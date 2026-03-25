Return-Path: <netdev+bounces-271512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMapEZbXw2lwuQQAu9opvQ
	(envelope-from <netdev+bounces-271512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:39:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA757325058
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BBEA3249466
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8C53D4102;
	Wed, 25 Mar 2026 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcJdWU1M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88963D348C
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440503; cv=none; b=hfVyajEHjIh6xVPbV9A+88ON57PGt1XTaaYMSdmjFU6NuLcb5J3GklIlmrT89ejXQbDToQOKiioej4uTEilsf5QEvWgeVZmJ5imhai1iNzME2px7M0MjXgMhEthNPoe6Uq5Xjn0Ya8zifhias5NIwlrvURomOzklOcph0CmerOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440503; c=relaxed/simple;
	bh=dKr8ItYR/xRgX9rJwnDJD6z2YohTUPCel0evOU/cPFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVZ9wLQK2EPS1+9eTqaW051SmDUrkm7PqIn1mXweYIRTD2g3uGWUBjhnZGz7DWTbPk99semTNytdXvdOdQ2514X2DmAoGQ9+INv7dYYv0n9iAhiuFdecGywUixclEc7xoZPkDLdtQGhB+VHTpbat7sItylVdbN1gjNJoFC6PKKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcJdWU1M; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43b527ac5d0so2670108f8f.2
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 05:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774440500; x=1775045300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NzWApGyalK1lCcNJCPfUV/C8rVwugjAkMDoOJ2vMPc=;
        b=RcJdWU1M4p4jVitHxD0M7IHjuE6OP1qGz7Mktx7SL+kTjgvAIwC7FSar7f82Kv4pU3
         N31gJe5dXm9Qilhfo2+wgk/7my9exCfalZGeXPjCRVCcuiPXJcpUJTa2//a8Bj0c9O4C
         9pDE4mHIupXnJacQZPlz3JdeF3vqHsP6W77VO34c9DVZXmgjgDb1V5OFQWWF/mszNfy3
         urwISCuoJ+DklUTRGktpOzO2QGlne3ojvYEm804q6H4t5HBUetrRV6NrPppUGRbSSdXE
         k9bIDGNxur9hI/gG01KQY3GCF0MqcfiVCB49JFhaNxF/lamPyTRdyRxl7BSrDNVHCXsw
         voSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774440500; x=1775045300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0NzWApGyalK1lCcNJCPfUV/C8rVwugjAkMDoOJ2vMPc=;
        b=M0fy8rYVMxZBDDHu2OndbT6847Pk3SLM7UJ0mD34q3P3kBQCTDJzgRHvawgEsJ41Im
         iz0R666YhrKyMfrYScVpOqXK6bc1R/rBMGMsQyxyZkQvxqufvj9ZR2BYywdoBxUawHC3
         VGE3o7GrVAiqGvt+r/uJJYkjsxKQ3XX5pmPW694fJ2havKibjfiQWdJnF/2CJMXuuoWe
         A8QTfbntSvsgxH/+GzVPqTfueTafrS8qIy5dhO4W8MfKgy5tJQw3oZhGDcHWRzn65SCQ
         TnsgIoVy6oe7ZJh5/1/nFymdVlBDmxfz9HAU2QlbNZs6HXC8w3BSAukEZJ8WwZwwoz11
         u3yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlJcvFl8Dnm98wi3Jki6jUEbJ9VxEbZUkGWTk1tm9ekOZbIti4qlZv0ho6qOQs0B9STZFEZW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YymRTigT6PRGGDbZh5b4peovm43gb6WuX2DE0iXxRKIv6WcHfju
	kWoJDhwIKI5lc5QdqvA0M+nrG+N0shzrifZ7VJwFlX4U9p1YHpCkZ5rF
X-Gm-Gg: ATEYQzyUKOPgNdhC3CfvBOMzBnp9dWoLwDZHBkwo0o7wmOMMCw0XRqwfYJW2wruTogU
	hL76xHtPUsvmnxc8WksYYdNduVWfKRAkiJPFO3I8OUMZI9/pJ2nnmDy503DvPe7cnliAGzAoQFJ
	ydSccoqLoRk8fdSpaXLQ8QOpWnnMRv7DQFq9aEEnSN+wIxgc+Tp9mwdjZ8UU+jOHb6ugjn8fmte
	Da3o1DepXC4XsnavqIdx3j9gcSBOB2BP03GSrK9AskBuimtvnr/TVM7bXhn+2+7G43P+6Ibe6tI
	Mzbl8SzBgSaLhcK8ADU3vFvZ+p13s7TThAIvUUwWAIfQ6/jZttOC0gtUrKUPey4KGIlCAMqlQnl
	blzmqWP87I2UyJa1DUuxG+Fk7kV6A6AkOavnyCVisJZBjy9fewG2l3lQeKNX/K7hFoP1hPlA6CU
	LaHCPbXM05iZHeK53d3ccDI40ZinN7qLfm8mD3ZKQnuFU6ssAeyQ5wdHouyS1gpOwHFS8fXGDgr
	HST0lsCaw==
X-Received: by 2002:a05:6000:2681:b0:43b:43d3:62ac with SMTP id ffacd0b85a97d-43b889c857bmr4679989f8f.18.1774440500021;
        Wed, 25 Mar 2026 05:08:20 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae37dsm48618289f8f.2.2026.03.25.05.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 05:08:19 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 3/4] io_uring/zcrx: use dma_len for chunk size calculation
Date: Wed, 25 Mar 2026 12:08:20 +0000
Message-ID: <554b00a178c93ad65861a58a656ebbbf04b13a8c.1774439286.git.asml.silence@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-271512-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA757325058
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Buffers are now dma-mapped earlier and we can sg_dma_len(), otherwise,
since it's walking with for_each_sgtable_dma_sg(), it might wrongfully
reject some configurations. As a bonus, it'd now be able to use larger
chunks if dma addresses are coalesced e.g by iommu.

Fixes: 8c0cab0b7bf76 ("always dma map in advance")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index fc6199edad34..0f98a3c74e2a 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -63,7 +63,7 @@ static int io_area_max_shift(struct io_zcrx_mem *mem)
 	unsigned i;
 
 	for_each_sgtable_dma_sg(sgt, sg, i)
-		shift = min(shift, __ffs(sg->length));
+		shift = min(shift, __ffs(sg_dma_len(sg)));
 	return shift;
 }
 
-- 
2.53.0


