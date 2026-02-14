Return-Path: <netdev+bounces-258747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKswHk71kGkCeAEAu9opvQ
	(envelope-from <netdev+bounces-258747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 23:21:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3FC13DB36
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 23:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F8953014645
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 22:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB735311956;
	Sat, 14 Feb 2026 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/wMUkSn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FC023C8A0
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 22:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771107659; cv=none; b=LcJ6ZAuCtVxwt4OFMNFFVVLgM/deS8eR5ol8ZklhMGGKUg4E/H/d8eDxMGNtRo60mLyMAZip4Qw3exWZyCZM93x4N6HIoN5DHT4BLZX2J0bV3W34yH0c4Q88BLOLqlJV3kuYqrEsixAknwcuWTQ/2pP9tDdevOv61TslH2giEj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771107659; c=relaxed/simple;
	bh=frTtZD09f8Bf8Zgam8XeXKfFPpeUui99DGoCniHzJ5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kOfltWpPsNRUlbCjvaw/+WyVHTT9iatDxSXO1RCMWyxihRq2R5mN2e5V1r4b2a9ctEkZCc2sRX1B7jWOa+FnxvEtJqR8cxrG2qF0xN7Onz1uck2I6CukpssA6jQYgGky2eKvi822WNt+zhjGkYo6PNojmvGNKTRbAITxuKzTyU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/wMUkSn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4833115090dso18390515e9.3
        for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 14:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771107657; x=1771712457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tdYzr1MdBQ+TSUvklAXfAzoZEsF9B2NkCtirq2Cu9Bg=;
        b=X/wMUkSnC2FZrPH9FGQFcQXiqsHWe53NgwSGGUl8OdYTzSp6D8Byv8SX8NuL9KyQFy
         bkqfJF55I8ccEpi/R8cQBlY+1V12FGnunfARN+FhNOAtZd3k7OD74mDxTFD/JcPz0cg4
         EePJFxe97hGjH20lmCqD8nUz6z0m4QZyg9K41AZZPmfSs3donTWIKkQk9UdAr+AivSwi
         fR7U24fnY0tsEa1tstYZXzL+StSsr7HgIha8o29Ddt1ZQXrevwwsYgEHA4YTyr2NA0uk
         DsMHeT9/ekO//m1Df48pfoSGrih7s1ekWMVhKmNsZsiy0aaz4YkIKC9b3ANcYZ9st8LY
         Dqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771107657; x=1771712457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdYzr1MdBQ+TSUvklAXfAzoZEsF9B2NkCtirq2Cu9Bg=;
        b=fh+0Cwxs93thmQWG/iFpK0EZ+9qvqcnaoBazcTApUBMMHCZ1zUURsIleF/fpH3xxlo
         yBDWTG/hdKJjgq5pdFnnnjRoOVxHTQphWkiNY0Cd2Dp6VmdJvrJqy4PjgDelWSyGP5vH
         zn9liplq95a7z07VQ43bDpqnK4Y52ys+1kex2brIRefZdK3MnfDreHeSu5Kv13HSzbRD
         gCu7C03vls5sxsx3XseOM94YwS9IqbVYM9H8ZrLB1Q6Mkbrbrynqicd7nrgpkhmZRzne
         PxiT9Pr6l3qt2rw9xsL+QoZ/zlpRe3XUvFS2lB2SUhiZu6UzAr7wktLrfPRowrWU4MLu
         T/ng==
X-Forwarded-Encrypted: i=1; AJvYcCUmutw+KgQv+8bgA3ddv3JG4AhQWRmC0ULL87xXn4Y5Mmtr03fojPoIwyIQ4mXdjmicd8W9D4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx53jEhftdQ9GpQU8dQxLeIu061Jd77b0WIuJ83hm+n+YJkm8Ai
	KIwRiTXQf4XhgR5wf1LqlwzknDNwbU3O18soDB6rmfTU8MoBhmDTCtxM
X-Gm-Gg: AZuq6aLeVxE1NpIqTCNq5wc/pj8IAE0Zh5mWP132SylseeKLKILjcdlgmuL96BoxYpG
	JOYnVhCn8T3BlTVR/ea9UJ2BpoQW20oe1CTyUftyJHeBBVNwSK0/5OZsWgtCsWdiwXfo7/EiDX6
	P4Sy4a6KU718UevfftOZHwfkhry24YwXQ0APWcXaVFL+SnE5F6LN+tW89/MFqfGk+5pF5z8ixUu
	MWyWXdy0RQ6KZRDtaleABUpGSVh4mG0+dF2Z1Hi2ByFHOJDCaBj/iACvcNr71q0eubVSjcg878s
	B8S1zptpfblTv2dTn2v7NB29bCC8+vFz5c/YoRxQl06A3O4p60bnEhvrlbNlOwRQ3V6qQbWD7kc
	UhhShn0VuPvT7tidpAKkQYQaOhos7a3qOJnVUtmxTG8C/TSfr+Md8xn1kFTnxjSZV+ywlcevORQ
	J8xMQoLTxg1NtVzPV0UQCPpKjYU5n3qmNeDlyWe0xsZsp5dsAR3Q9rHBF0OUhVAPrrR8DpDX8EA
	hMV0FUhPdNENmVi13Dak7rCZEsyxA==
X-Received: by 2002:a05:600c:1d0a:b0:483:3380:ca12 with SMTP id 5b1f17b1804b1-48373a74357mr93484705e9.29.1771107656914;
        Sat, 14 Feb 2026 14:20:56 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483801ff9b3sm38743745e9.13.2026.02.14.14.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 14:20:55 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] io_uring/zcrx: fix post open error handling
Date: Sat, 14 Feb 2026 22:20:47 +0000
Message-ID: <9d9cdc9ae6c6d59154e68f65054d75893a749d14.1771091720.git.asml.silence@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258747-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
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
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE3FC13DB36
X-Rspamd-Action: no action

Closing a queue doesn't guarantee that all associated page pools are
terminated right away, let the refcounting do the work instead of
releasing the zcrx ctx directly.

Cc: stable@vger.kernel.org
Fixes: e0793de24a9f6 ("io_uring/zcrx: set pp memory provider for an rx queue")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 006e1bfefa5f..b24d1da2e1ca 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -515,9 +515,6 @@ static void io_close_queue(struct io_zcrx_ifq *ifq)
 		.mp_priv = ifq,
 	};
 
-	if (ifq->if_rxq == -1)
-		return;
-
 	scoped_guard(mutex, &ifq->pp_lock) {
 		netdev = ifq->netdev;
 		netdev_tracker = ifq->netdev_tracker;
@@ -525,7 +522,8 @@ static void io_close_queue(struct io_zcrx_ifq *ifq)
 	}
 
 	if (netdev) {
-		net_mp_close_rxq(netdev, ifq->if_rxq, &p);
+		if (ifq->if_rxq != -1)
+			net_mp_close_rxq(netdev, ifq->if_rxq, &p);
 		netdev_put(netdev, &netdev_tracker);
 	}
 	ifq->if_rxq = -1;
@@ -833,13 +831,12 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	}
 	return 0;
 netdev_put_unlock:
-	netdev_put(ifq->netdev, &ifq->netdev_tracker);
 	netdev_unlock(ifq->netdev);
 err:
 	scoped_guard(mutex, &ctx->mmap_lock)
 		xa_erase(&ctx->zcrx_ctxs, id);
 ifq_free:
-	io_zcrx_ifq_free(ifq);
+	zcrx_unregister(ifq);
 	return ret;
 }
 
-- 
2.52.0


