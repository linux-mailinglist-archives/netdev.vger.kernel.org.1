Return-Path: <netdev+bounces-289423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO9jO8dNDGpIeQUAu9opvQ
	(envelope-from <netdev+bounces-289423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:47:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF2257DF44
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E18D304A8D6
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8988A4ADD86;
	Tue, 19 May 2026 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1jvXZc6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2293B35201F
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191086; cv=none; b=QwoF4VtnNTJ6VD6VHB5OKpU8j4UzD40s0tqJT6Dr+o3VDuhqFsCg3tSO7DJIG2nOk3m081nVUwhHccqZRkDGCZS5WLpqviVHuTJUpTZDlifr642ycmIHweF5jWkEtYtut5VVcXeCP3iZ8dEGr6cKt7anOpFl0fgOANInRSgEFzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191086; c=relaxed/simple;
	bh=smbb5f+MTzgWTNcXfgixllw7irmF+kG3BO/t7kkRLlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JV536by/F0hPhAWOsMWjcC3uyNiL8iGw0x1wDnLJY2wmMhDt+LJsCt0ncr3LVxuEmacFE3/4eyIt6qYDKIsOk5FwzT+Uz/xyQdUFrMVxruKkalyu7zuHL1hQPF3Q5Y2KuTx0Z6IX+2hZUCdSZFHxkOnzv6gR3kO4DnRYzCWCDAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1jvXZc6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso25113665e9.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779191083; x=1779795883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUOFBS5qjwcHKBbh8i3Q6c8n431FFzTbA8NMglOxXrw=;
        b=l1jvXZc6CiRyEhflrMXlf5BcFtjqyKEcrhtG51G9t57f7C/G0WZoyRNp0ba1Iy4pfp
         mhCPBWCn89xT5+JSWjwKs2NndH2f5koOQPmVqfKfYEe8gHFHfUAH8/6/RitUV/cc0imi
         v297h5Wxv+YE2mHQP3ukzvM5FlvZUwXQ9XldGSQpnRkzGdZSD+n7yzqCU0LRihQhOaZG
         9z92LXj33gRjHbSbnf+nY5TRlpa2s8xBBnrrc6Z6oPzwBgPtxVdHB8wzEXWT9wBTy4RU
         pdZb2tmJ6wgJlN4HmSVan48SCk+TRfscmLF6Mb3cw4vWJgK/lwj7/TU5SWyTQxIYdXdv
         6rTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779191083; x=1779795883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cUOFBS5qjwcHKBbh8i3Q6c8n431FFzTbA8NMglOxXrw=;
        b=hpeEZKlwiJsfrAUbmVp1tY8ISXWQOvgTs0yVF5tTprcXXE1nhLAb50uN7uTmNgh2y8
         3q62BqSWtY5R/gA3xKFgTVYNfWxBnNs84XHG7/cPOmpkxIzSHeFRcgpi6zddU//zXvvf
         S2KTYtFUeMVIRsd3qi0vS8hGcPRkI1U6gceRnFHGNNf7cGICiRttq3arci5WF5nMGwla
         7RUMi7h3NFeW2MwnIHdiz3qqOL2GBQJga1gAqEMJTxe8ho5zozHcmadCbX5U2JbkOWjN
         wvtrtHKHiDQ4biwnDzPmQ7ycgAydoJdCUjJqdDuckjNy8ZVlKQ3wSGTxKvyAZw/RBGDc
         4s3Q==
X-Forwarded-Encrypted: i=1; AFNElJ8oN6Rdu2u993I8YZI/gZZcsBh+4aQjOUwo5UEtppdLY4OrNNQ2ogAioojUB4w8ccH2S0ODjxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGGsVd5oXIz3wjQtR8B6Wp8t3RrZn98i5+HlAeGzFaGr0w0hKG
	amTDAMERz9Q9KHSCVx0z4T7crbQ135KKeYd84rqai7UH2OmlIZN/OTMEFL4wBQ==
X-Gm-Gg: Acq92OH0XvVKrjdAnj0xKKBXNenV9DSXBF3cjWKxyuIO8LALyncqsISa0CQo/U1drK5
	1tIGgeGQiuiFJx/ih6kwZ7t8SX3ZLLBcH+s1woweLt+3yF1ltv80d6/P5n6P944YKX/G9/777SH
	meeJX/9unSOajQd0vIVyQiNMQ97YysPDAlMXmilfUoDFgLeByegYKWDXTZYg7Q6vUeGfO7iGtxz
	f5kirx2FnqdmoCbWA0wbzOK3M86xIYZpHJRe+OFR7PZSvoD6Siqgvc9wk8engNInil8OnPDNtgP
	0qjEAuXRDRR8Wm1JUcsA9iJ49o6P6fpYN11ozlG3gpc4CevsNHpqayCtV6RjDvMWXWrjMnRZc+G
	MIQAU59qhXPQOaTqnXTo9enwPDCnG8bu04semRF794zdeHfKnvlU00qDIxF1pXQTvFDypRVSQOo
	DuyVhxBiStREJbtHGBVjsVEaegauet2PXwHFm6nA4fjtT4GhE9XHFtBYd4ReebbOwOZQjdK3p43
	vx8y6Im7bFpAWtxViIicmHkoryovHnMbQtlyfkp
X-Received: by 2002:a05:600c:8189:b0:48e:89f9:9408 with SMTP id 5b1f17b1804b1-48fe632374fmr292720615e9.20.1779191083401;
        Tue, 19 May 2026 04:44:43 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5694f2csm323392445e9.4.2026.05.19.04.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:44:42 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH 1/8] io_uring/zcrx: make scrubbing more reliable
Date: Tue, 19 May 2026 12:44:27 +0100
Message-ID: <c4ea127023494cbbedebd21a2b7ae5ff0448eb95.1779189667.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779189667.git.asml.silence@gmail.com>
References: <cover.1779189667.git.asml.silence@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289423-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4EF2257DF44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, scrubbing is done once before killing all recvzc requests.
It's fine as those are cancelled and don't return buffers afterwards,
but it'll be more reliable not to rely that much on cancellations.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 7b93c87b8371..60cef10dc491 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -986,6 +986,12 @@ void io_unregister_zcrx(struct io_ring_ctx *ctx)
 		}
 		if (!ifq)
 			break;
+		/*
+		 * io_uring can run requests and return buffers to the user
+		 * after termination, scrub it again.
+		 */
+		if (refcount_read(&ifq->user_refs) == 0)
+			io_zcrx_scrub(ifq);
 		io_put_zcrx_ifq(ifq);
 	}
 
-- 
2.54.0


