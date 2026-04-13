Return-Path: <netdev+bounces-278006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLVPNHaz3GkDVgkAu9opvQ
	(envelope-from <netdev+bounces-278006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:12:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 318D73E9A73
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7770F308DF60
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F313AB29F;
	Mon, 13 Apr 2026 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9jORgaZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B33B3815DB
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776071068; cv=none; b=FHN7Q7Sp1bdh9S5oahkKBZBV4S6z4EdxpZThi53aegexVXBlG8SdypTDQsPU4lL+tBciNys4ZIOlMFIBldr9TIElFJvJMPn2/dB1bPU3vYVx5Ite2qQmdIW0KtOrfrIyoK2Gpa2/dS7XYdQzeZ8Nb6CJRbECzHiGNKHlwV74Csc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776071068; c=relaxed/simple;
	bh=j9DbkxGjjhLQ37OULLXeKhJqrrJZVUQQqkJiFfzyetc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mJI9m0E0QRUGkbGhR83nvG+YHyIkXRf/9CHOuj3ZfYBia0Pz1KdYC6t4M8DsGa7gaSChZuCl4mAZid+bMQP3ThJzR7o33Vt54OQVHTGNt+9745CWKx0Bv0VVtLME0zKVXIrW4t0iN+CC0yCIsBrkYpDnFqXToq1RugIHL4oG5PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9jORgaZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d95017a68so2595151a91.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 02:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776071066; x=1776675866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qcRkOF/7t4w3Ox0FBB7eWEDMSnmUZdYvny+jzZre+vw=;
        b=A9jORgaZXeHi0oUkwZ8sg1ffr8XvwvYygLvCgiCo4vCmGNq3/TlsHi0Q2Pp3xnebMf
         okyeXBi0xaGJGIXpF37MAD8/GyQXz+99OnpkAJk/A43SkKTvhlRcDkXGd1be5RR2qtXI
         Fj/qfF34/v87ISM40L2XybAAH+M7gYS5Ie8TxkwwXE6GTaAforzBUI7UzGIc9FH9oAI+
         ySja1Rbu/8i7uQy2nwCzD4LGuEm3vMr/xPqXVwzHGS5ZnQdGdyBgOC6Y/JOV3E9Atgbs
         1XWM7Hf8Wh0w/cJsbftCQERmLPbWWyoncdd7KpEX0pn7H+JrF43kN0HwmpDb/PqkUY2Y
         N01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776071066; x=1776675866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcRkOF/7t4w3Ox0FBB7eWEDMSnmUZdYvny+jzZre+vw=;
        b=pyiNUzUp2To71uQifvYMTeyhqcuBtvZzTXxC4UdhAF4ll2wFWGg+v1zjLMvNy6fL0g
         0hoBVub8w2MwSYBDjW3/HiS3azd6gy5XVyXE6RfY2KaV/0MZDMfw8tpJjCddjDFnqrkJ
         0JosfQqCrq5CJflj6Y3dQY05wsJbAQ3Jat2bn8DfzGkNWR1srqz5Af8jaBwvfYU9SvyG
         mpHHzLGtUUZqmJBCXUW3tKdugMOrNNXwPW0NUJPDbCJ9mcJB6KAIISZ8gKCc+VJM0Ykn
         boSosjr89LBN1FKftgN+LsRKmjOo4b8I3i6RbiCkiPi1yfixXkWvh0neEL2B0z6nzklv
         hnCw==
X-Gm-Message-State: AOJu0Yz74RSwOC9Xx6Aj0LH063D5OEYftyEcHxTR0zbbWVX76GlFnA6u
	Vi1iAP1WTPasggabNT2U6JOE1jAYr07FWDnyt4xm0Unb9T/ej53/HGmSqEbd6w==
X-Gm-Gg: AeBDievHyZ1HCfJcqBzmkeQ+rEmFWVXabXhP9nGILcSGCHMJmc80hZb0PcqvpmM88kl
	eaYjEZlD+P99+MmsCcGTEUvjv7D1yAoBD46VgBqxs9IzHeTnk3zHxMl1ZLZrABJXG2NhQ5kJ61j
	cnFQ+55QKAmmb1JtpQrmNNeSPcpKsqoLGge2KaJUAYFgKXZ4rLb/iRVP8TLKXzhzs5nb6QHGXkb
	9cwGIigtnuzQQYBsvG7Fppteez9fGUHDtu7wwxHZpzhawMTUusHYs66+ibCfNWREgiFkodMhZ12
	5icPvcrv+rcRjWDTiyzjYrX5acLiGp6NE6EARG+Pp/PTO9Ri69lpKGXakNfDP9jv5a7w53kMqNq
	3qJIH9TuTlQMaL0L+9AIELM1MQAnbHOP3LRmTh9r2o9+WLetZfcNqS0Yh+1UpldNhTP2aoIun0S
	IaulZ5Nw6hOoNKwrqSON2RcisbPwXPjWAVWmTRJNSVB6aZTTFG4jegoGIOWzqqiIGI
X-Received: by 2002:a17:90b:3f8e:b0:35f:b647:d973 with SMTP id 98e67ed59e1d1-35fb647dbbamr3094427a91.0.1776071066292;
        Mon, 13 Apr 2026 02:04:26 -0700 (PDT)
Received: from gmail.com (69-172-89-235.static.imsbiz.com. [69.172.89.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dd67ecsm111538695ad.21.2026.04.13.02.04.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 02:04:25 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH] rose: Fix rose_find_socket() returning without sock_hold()
Date: Mon, 13 Apr 2026 17:04:20 +0800
Message-Id: <20260413090420.79932-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-278006-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phx0fer@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 318D73E9A73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rose_find_socket() returns a raw socket pointer after releasing
rose_list_lock. The socket can be freed by a concurrent close()
between the unlock and the caller's use of the pointer, leading
to a use-after-free.

Add sock_hold() before returning the found socket, and update
callers to sock_put() when done.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 net/rose/af_rose.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index ba56213e0a2a..b32b136f80aa 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -1,4 +1,5 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+	if (s)
+		sock_hold(s);// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  * Copyright (C) Jonathan Naylor G4KLX (g4klx@g4klx.demon.co.uk)
-- 
2.39.3 (Apple Git-145)


