Return-Path: <netdev+bounces-262922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BhPKwEVpmnlJgAAu9opvQ
	(envelope-from <netdev+bounces-262922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 23:53:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA8C1E5F65
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 23:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F43B3030079
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 22:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD3831A06C;
	Mon,  2 Mar 2026 22:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnCf88kX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4368282F1F
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 22:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772489756; cv=none; b=UEPrE8UITam7mZR9M5y8PdX9uqc4KckX4g3rYsEk+7CSh+AhqTlqYXZvUSw65t1yAle28Qm/ZRrnxSmF5Bo0MVhjjcqu8ad2nC4P2CAJ/EyKHvDUi8sOq5ruprkPsZ0CtGgyYlsm3M4HK6wrUZ90TjYQuwsy3WIqWCc9Fc5XSmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772489756; c=relaxed/simple;
	bh=YUz7XkOJSBI3WZbGiiZQlw/847UhILJigam52BcVlq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CfVlMq/RovjWDw+PhR0VbZgZ9E9+U96eSu7Kaa6VQOfE7/tzLzOvmLJ6XdvtsDrBVK4XGomvNAQWLd9pQ/tYujyM4KV1a6NbgUBkHprGQ/1bkxC5Nw01PqubsjLHOy2hC8Y5XS/x28CDY5NcUIOj3m12Ycj2WIHWOlioMw7xx0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnCf88kX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48336a6e932so31101985e9.3
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 14:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772489753; x=1773094553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tjm/TIZUMwWxgmitP9S97CxYmmwICsTxtpvet48XIIw=;
        b=EnCf88kXZy7wtQwiUXFh3CvBPHA2VAIJo6XPd9L2v9WtVZKr1YbQec7ctEGncqdvr+
         K4+uA7RZHSLLAu6NHqo4+Ph8rgGvTx8Tuw/gNEOh+ROsXpIN/AQYzJ4ofVzimNdKtl/8
         FC3AMEcmFVrpTb82m3j0qcawpfJKMw2f41EPejTzmOvd7UK/skB7ibMDvFDrBhlW/DZY
         NfgiXaVJ4OeKir6hkqAPOohgaxsu7BXYFCJThqOZ5lwsCA2S6eDE/vhi5Kx2onOJREu5
         YfmSdrD1Va7TPKrKfDf6O4maNJ7we7n+6KEt06UcbCeefIgvLYpR5HZl7sl4rTZAlwlb
         r8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772489753; x=1773094553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjm/TIZUMwWxgmitP9S97CxYmmwICsTxtpvet48XIIw=;
        b=ZfmrFqqGL1ExFQB0Vp6g3/bqwBPaTqo9v81xa96Z1r9kl4i+Gj37LgRO+gIMlt0tQ6
         C0EJMIjWAwtt5w1iYjhZFfWtRkoie/0qA8V+xb1Ibr91pq0hceuX7Ajho6MoHpaSpCVJ
         HBrt1/++aHfrhyIujMPcMoJmU35nk6xWjKp34Obch7E6LLIK6jBbeNjq+HdW2bxgsGZo
         srOOS/lxxJP89Mhh4z/m5UraiV/0+PLcvlPpdPP43la1AJ+DhhTYytKpMzLtl4W1ZEpf
         VEkVLtK6GtLolAv/2+g4FV1dT1WMuPK2gs7KHMynVMQc+RZ+veCUY5VhEENVO4kRd8B6
         NhLA==
X-Forwarded-Encrypted: i=1; AJvYcCWImS8xXGhpo26cD0IE7WujEnuzHRxgjrMokjmf/mSWCVrQ5n0vdDgCfJhhqE+44MGHT8xnXXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKTvX4EiMWnHmTyTW4hRlr+HSGW10fPF7aZmXjTgs1De/lhLi5
	ezmDcuP4Hpb8Uvr4bsmB2ese7+Ls7N+l+sd3ND2a/mFTVXWJjiMPmzJV
X-Gm-Gg: ATEYQzzoMTCGU72j9ekqFFWw3KPDUMRZMhFgFluBtLouO/gqi/0DHvVwXq6Xn9nTpx9
	UiPelBT+LXppzdNSyiN8g6zyr9emumoIPF7GkxhlzJ1KsOwysgmleetznrZlWbUCTiZCkkraYbz
	+IzSjT/Ii/j96Q3sbR2BL62XQ4nnqig7pzhP1hQkrZu+YAEGivTsjZsqY55lknjFOJg1/b97M5M
	OLF9o5dLCDBIWsjKuJU1TvzeKXwkXptnar1kKmwWLyVU7Rxu1hKp+F9mVCwts2izRR/i+GXOji4
	sdDxPfT9V6+JvnX39mgWuWbYoRsq4lWECGReuZO18NmQeNR7QaY7Xdoxgt1ZU42wjWOAfMPt4Do
	+VeJpgmngrT52jHzk1J8eG+ZIwn4W5/CYKZcQjGEKp3o1BRS6RtR+b91Jq9sdsbequzYkUqY1Rr
	pg1Gsi3/o75onWQnoBsm7NqSPw0fbI49R06asnoQCqY3TMZNRcqVHIMBHy4CM0kNIi4gW4CMGmx
	STCpY+EK2KZangl+MkERkm47LDpHg==
X-Received: by 2002:a05:600c:5306:b0:483:6d42:25c6 with SMTP id 5b1f17b1804b1-483c9bc4210mr262615115e9.23.1772489752652;
        Mon, 02 Mar 2026 14:15:52 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c60f764sm30736816f8f.3.2026.03.02.14.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 14:15:52 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 1/1] io_uring/zcrx: fix post open error handling
Date: Mon,  2 Mar 2026 22:15:43 +0000
Message-ID: <ae4f2296e2c33bb65ef2a1487b120033879e493f.1772489730.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ECA8C1E5F65
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262922-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

[ upstream commit 5d540e4508950c674d6feef1d95463d039bbf4f5 ]

5d540e4508950 ("io_uring/zcrx: fix post open error handling") fixes some
post queue open problems. Instead of picking all dependencies for that
patch just move post open error handling out of the way, so once a queue
is open we can always report a success.

Move copy_to_user earlier before open,  and xa_store() should already
never fail as the slot is explicitly pre-allocated.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index c524be7109c2..208d03443020 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -625,6 +625,14 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	if (ret)
 		goto netdev_put_unlock;
 
+	reg.zcrx_id = id;
+	if (copy_to_user(arg, &reg, sizeof(reg)) ||
+	    copy_to_user(u64_to_user_ptr(reg.region_ptr), &rd, sizeof(rd)) ||
+	    copy_to_user(u64_to_user_ptr(reg.area_ptr), &area, sizeof(area))) {
+		ret = -EFAULT;
+		goto netdev_put_unlock;
+	}
+
 	mp_param.mp_ops = &io_uring_pp_zc_ops;
 	mp_param.mp_priv = ifq;
 	ret = __net_mp_open_rxq(ifq->netdev, reg.if_rxq, &mp_param, NULL);
@@ -633,21 +641,11 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	netdev_unlock(ifq->netdev);
 	ifq->if_rxq = reg.if_rxq;
 
-	reg.zcrx_id = id;
-
 	scoped_guard(mutex, &ctx->mmap_lock) {
 		/* publish ifq */
-		ret = -ENOMEM;
-		if (xa_store(&ctx->zcrx_ctxs, id, ifq, GFP_KERNEL))
-			goto err;
+		xa_store(&ctx->zcrx_ctxs, id, ifq, GFP_KERNEL);
 	}
 
-	if (copy_to_user(arg, &reg, sizeof(reg)) ||
-	    copy_to_user(u64_to_user_ptr(reg.region_ptr), &rd, sizeof(rd)) ||
-	    copy_to_user(u64_to_user_ptr(reg.area_ptr), &area, sizeof(area))) {
-		ret = -EFAULT;
-		goto err;
-	}
 	return 0;
 netdev_put_unlock:
 	netdev_put(ifq->netdev, &ifq->netdev_tracker);
-- 
2.53.0


