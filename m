Return-Path: <netdev+bounces-294965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cualNv20IGrz6wAAu9opvQ
	(envelope-from <netdev+bounces-294965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 01:13:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAE063BCC5
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 01:13:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BmmGgDXd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294965-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294965-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98C8B305B30E
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 23:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727614DC532;
	Wed,  3 Jun 2026 23:08:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408884C0433
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 23:08:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528121; cv=none; b=JT8nTo2b1aKEeIhaoQELrTeCk/XrHcHzgwtosASe9kjFjeEButm5alsB5tGLFqid58Z03RZ+iXehdReMbXELn4SbRzm1+lf7WUz+FXVvMpjU4eMQZzBfj6s/YYBBd52c6KCuKoM3LI0jkZ/Xn5Zx6qk3E541DM5cp2BRTeuVEmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528121; c=relaxed/simple;
	bh=mvMXAeKnhvVptjL1j7dx1Pw9pBTw7uUxEAUeEWuqz7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KcW4EV75kH5+JSAaL4CuBJwGmo2uxvFULxa28kxoI1qMw9RIkyrTGV8dwYPrckdKRbPOVz952/T7ssmpQ7NG51NZ+5Iz/KQP4vpl647jXdwJXyCo4ctCr3pIbMLP6sWssetLKOTI9beN23nn+GICi4Nayszbk561151CH4Kz1Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmmGgDXd; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c3543590so495885ad.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 16:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780528119; x=1781132919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hV0J7oFoI3Myn5A3Ui4tQdFzpR5d7gJH/YG9o82Ci0o=;
        b=BmmGgDXdzYiEGM9KRydreLHHDBJHqniocWyTVHME4NfwdrbFV/jv71ZYcQT8RP4kGi
         ZeZ5pweRGh3H8VPfTjARR7t6UN4uE20eOUS3jIMNMovGRIqVMMSgVjvYTs8Nliv9fpB3
         ZrgpkxMx35M0As43tn0YR806/1SAtxixiuOaX/lUjs2Gvvr541iHbTPatDesEdeo9tnI
         ujGMM7pqUJ2O+S4F+2mTcWii64GFvxqNTgHvVS0cATVBYRmINZcqcGcQGE0SaVxxr7wN
         BQ38J9CmZi6Olbd60QT/XM2uBB0nvmTCgDoOj8eRXgJuqL3SPn+v4KfX6XyIsQbULe32
         mVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780528119; x=1781132919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hV0J7oFoI3Myn5A3Ui4tQdFzpR5d7gJH/YG9o82Ci0o=;
        b=e4kZ5BOuT3DRrpdwzTWv/ZbQhQawRcQcdZl6FYXJBByqn8Mm6A6WSXYpQpajx3ZdX9
         DnPccirLqqv6exU1q3mYGBt2FAKo4cCsyxESM4ORMmSuTHxYnhHMdc7vQbnAIo2h45+a
         qqGO9KUOqfEr5p+a24AqEA2ltCCVgvOhwwE8HEWKaSH7YreCayv8GMK83o67t68Qz55i
         sycMNknDzDkeKGz7M8SSy866sO7mCiWbp7RXBERX6MPxgXU0em1OKs8/b0KeG3/FuXkV
         OkhfJYWTHVj7eSIUc5k791fMWtf5QCNkNDI1kfJxi6NxzioRqyHHsuFgEvF0bxwJzwvQ
         gCUA==
X-Gm-Message-State: AOJu0YzQaSBQMcIDuC0Tl+d4ILIu9yxl/7qPTwmRdB0eS93bJ0J6uH2b
	eigdaBhY7sdyyLlHfgTBjxksr3NNlIXPjk/D8q6DAoTOQQA3YzLtFEQ6t0fcNYKE
X-Gm-Gg: Acq92OF0LP0HMXnE0djbYEmju4IuYZiFFGx+xXeGxObwLtirNhK1yGmxtXivvl06OUf
	RNUehxFDW9l9ykRw9mQRuWCPDsgoTxpFrH8uOw0lNpL4w4Ueb5AOcgKRflQbBMjBHmf4IbXS/Un
	ploRW5a/PhQ7NpHXABts6odaRIbzmLNcyjV+O1f46OrkfJRn4sy8VeLF/ZZpfB0ec8cY5TWHIZ5
	Ohew3zXQ2hQFeP2YtfaJ3rObBxROS0fwA/b1iVu5uFwH0usi9dADj+4fqvyf1NJLY5qws8zmgIw
	SG2cIwjS4qSQWPHnT3c43hPSsUxHqPO0XQ/GEQbIxrmaqMKgpEGcFuqTjs+KqIvEDlfhTmh+9Go
	uX0pkDI7wIyQkHD/M2zYIkBUGyWs8tgIT/twu3m2bjXxVhqrRYtDujlhm8uWCATtgoGI8xdoKEV
	eUh0PUUEtJnCMTQACEfrwQ7Bb8JBjV2OPSZIE5lGqlb4k2d0CX56l33K+tnOhz91738Xt2l+gzh
	l4IFhGCuXnku1r7aYfGtrUJF8LvQsHhUP49qNl+W8vuTA==
X-Received: by 2002:a17:903:3888:b0:2c0:ab82:6b9d with SMTP id d9443c01a7336-2c163fb26ebmr60242675ad.29.1780528119434;
        Wed, 03 Jun 2026 16:08:39 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6ce98sm33036905ad.10.2026.06.03.16.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 16:08:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jeff@garzik.org>,
	Roland Dreier <rdreier@cisco.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: ibm: emac: mal: fix potential system hang in mal_remove()
Date: Wed,  3 Jun 2026 16:08:21 -0700
Message-ID: <20260603230821.5619-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jeff@garzik.org,m:rdreier@cisco.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294965-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEAE063BCC5

napi_disable() is not idempotent and calling it on an already-disabled
or unenabled NAPI context will cause the kernel to spin indefinitely
waiting for the NAPI_STATE_SCHED bit to clear.

In mal_remove(), napi_disable() is called unconditionally. If no MACs were
registered, NAPI was never enabled. Also, if they were registered but
subsequently unregistered, NAPI was already disabled in
mal_unregister_commac(). In either case, calling napi_disable() causes
the kernel to hang upon module removal.

Fix this by only calling napi_disable() in mal_remove() if the commac list
is not empty (which implies NAPI is enabled).

Fixes: 59e90b2d2250 ("ibm_emac: Convert to use napi_struct independent of struct net_device")
Assisted-by: antigravity:gemini-3.5-flash
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 83dd7f99d8d5..74526002d52b 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -712,13 +712,13 @@ static void mal_remove(struct platform_device *ofdev)
 	MAL_DBG(mal, "remove" NL);

 	/* Synchronize with scheduled polling */
-	napi_disable(&mal->napi);
-
-	if (!list_empty(&mal->list))
+	if (!list_empty(&mal->list)) {
+		napi_disable(&mal->napi);
 		/* This is *very* bad */
 		WARN(1, KERN_EMERG
 		       "mal%d: commac list is not empty on remove!\n",
 		       mal->index);
+	}

 	mal_reset(mal);

--
2.54.0


