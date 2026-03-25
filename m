Return-Path: <netdev+bounces-271545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK5rJRTmw2lvugQAu9opvQ
	(envelope-from <netdev+bounces-271545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:41:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AB3325FA1
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DC9D30DDAEA
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1053DA5C4;
	Wed, 25 Mar 2026 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcwWwE64"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561B63D9DCC
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774444165; cv=none; b=PK3D4oEkp5YWoVCFJDEWmZvCbjNrduICeBAjgmKNp7qfMszksd6N1uzijs/3L8sLTYYymyGNc3mk616vR3YXHdwFyEcEw1Otrcw13tS9wxU/T3oS6Hja/aEhgdXTb7/hvvoy8t6ocDiq3lpbgW9wJKhKkiL8hPFDaweVxxgeJks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774444165; c=relaxed/simple;
	bh=9pVS1tph9jbVSLdoQwmJN+/bmkwxN4ab7cvUzQYqS3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKrrDHlgC6jFxyKzQ2WHUnLUnfylNm6AcESf4MG/+rzgmfjCkkO66Ve6qYjECdeWMe6siBAG0eweMbeDpqRHQhUJdXxIGFhw25kQ2W9wCe1GV+IssgkNlmjxTn3PxaQdqw74+c7Bu3hD62tPbDieTRbuSb2ZCmPduhdddPWVSi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcwWwE64; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439d8df7620so4185545f8f.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774444163; x=1775048963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uqkekRSIh11YxOvK1NGZWJnPZup9GIGf6LTY+NlKwY=;
        b=RcwWwE64KO2HxvYqlHJuwpu3p4IY4iG1MzYAU9w9l8k4mMb5qySFpHbkRXNNL47H8L
         6LKDLzdLVqZg7KrDnxK3hFVxrmuwBQ9FhM7ZsJz7cZh9/FGLNClnVwoP+D2yDsQh5XQS
         tGf7/vwS8n5blE0MsNKHxoFFjFPDQHWYo/BADFDrPA6VunEjEcZHUOpq7rz5ZZkL8FIz
         p56GVk8sO66GwODEU5CR92C/Sjr+m7LrlzGhmDYBqYq6CD1k6emimiKDzr7bru8BNhkc
         kqGooTJk+sUlYo1jxpBrJh8ezxXNyvCSOma4WW9FzG6ANGX6CqLGoVcPpKwas/p3gD0I
         8DsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774444163; x=1775048963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5uqkekRSIh11YxOvK1NGZWJnPZup9GIGf6LTY+NlKwY=;
        b=RPlSB7sk1DzgtO+yHgX6dqHnPiCYcEI7KKFLQXAkvMYvf5yja5AEt3Fg9aofJ4+Th3
         XANQL6WZLQrGkGj5PEw4aiDZXpkWJAHlZOmE7IUIEaVKKvMIXVMF/unFv2uyRr9QXSq3
         DpIonJGGXt13Q+3UiPovpnc3WbXzmzcxWVrmPCjSWpD68puPDvGkQmNdW9YBT3vcJ5Hx
         9vqc/LgkEzpXbnP9pZvx+qOLky+XK2nn5f7emeJJqqJyTbJVgQFIqXXC+U5uYFJ+E5bf
         hDLzwo49wcW31KrwdnwdDcLaVU+a4H3I0pAOtAvedUuKog1l+RQm6Ptz5JTTHUMXJcH4
         NmEA==
X-Forwarded-Encrypted: i=1; AJvYcCX4/JgCozgjC8OGS8vl6O3oewUhfDk8EX9x1MgjsliNhZygxph5u2Q7QoWee3rWk8Z4gHLa3ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAEZ7lA/TAue0zuwFBIQG8VRFXEAVlRnfR+xWzrC1uUEy/gZdp
	ya4rfENmqC8XZdmrxe1odOUNw4WizjmlJt851RSkPS+UWYZlY9VFByDJ
X-Gm-Gg: ATEYQzyUUoslSWVfqWMjVBPb83gLlAv8S/dZ/K41XiEHxiju2H0s6wbztFpptS0Y8GK
	vD7fW71XS7ii97tQEkrCNxHXuI+YAVs06sQ+5ihn8M0o45gDNfIQ86K/TPDaKhJFkQiMF/nlgSZ
	c8m57E+vU4yau5IhrTyLJqY0iCvxJ+PTpvFXZ8HDIdbdJNcGrMsYDS8KTp8WenQJV5OEN49Wzep
	oZ2OWhS3jzfA7Vd7J2GDrSBL6XfRmVEU6afXtN3dan4W1JQD+OCrxtCIzFT5upckFXZjVyRnOqM
	dB1EVMQ2RX2UT/CxaBsD7n1M+4Zkz2qvXQN432qhuDrQSa8FvYubp813TL3sE7xFBOwMBRRa+ux
	u6mPLutmf4719Cj0Z8IeO31pUW/sWyqxnac6yHoKYGqyaChAmQ33GFq2ohmX6C3lENGOT77NyMA
	2JCY5kLICexlq2+HEUpFQj7y0LpLIb32cEpMMnCEvjwCGNWnQMgUEF9QO1vDz+disrGK8TlUr66
	2MMSRBIfro6rQPjm7XU
X-Received: by 2002:a05:6000:2007:b0:439:c550:d920 with SMTP id ffacd0b85a97d-43b88a250e5mr5533066f8f.47.1774444162694;
        Wed, 25 Mar 2026 06:09:22 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd923sm54062611f8f.12.2026.03.25.06.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 06:09:22 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 v2 5/5] io_uring/zcrx: use correct mmap off constants
Date: Wed, 25 Mar 2026 13:09:22 +0000
Message-ID: <31f58c90bd1222b420f24a71f2b9eea4cccefe45.1774444007.git.asml.silence@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-271545-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4AB3325FA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

zcrx was using IORING_OFF_PBUF_SHIFT during first iterations, but there
is now a separate constant it should use. Both are 16 so it doesn't
change anything, but improve it for the future.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index e1d2e1f1b766..df8dae724be4 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -386,7 +386,7 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 		return -EINVAL;
 
 	mmap_offset = IORING_MAP_OFF_ZCRX_REGION;
-	mmap_offset += id << IORING_OFF_PBUF_SHIFT;
+	mmap_offset += id << IORING_OFF_ZCRX_SHIFT;
 
 	ret = io_create_region(ctx, &ifq->rq_region, rd, mmap_offset);
 	if (ret < 0)
-- 
2.53.0


