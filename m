Return-Path: <netdev+bounces-206807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CF3B04723
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 20:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859F64A685D
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7148026C3BF;
	Mon, 14 Jul 2025 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="z70Aqle/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1425626C39C
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516571; cv=none; b=nJE/f1HKfXS5lfct9FAh08TEDn3tAJW1JmOERMi5ktiMfWvrCOVamQt2IlTowQy+RXCMmGebgAuq4jipUxVUqAU0qirfpw1hwuno17JW9gyrSSJPe9aPj/h0gTLB3Z8F+VXk0T0ow4Uf1R9ltlpxFd8Xt+8v1HZBVSfZ8huAVgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516571; c=relaxed/simple;
	bh=P2TM48kjMxPSr7YwvwYsCNfh+euwlg0K2KRkqviR9cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4iPvMmIJVXAgcKP8xApEC4lYl35NbxXI1nXQ2K7Nu39PI35avm6LSxu1wxi7BGSYpkNIq7caCfLjsV/ZE2gNGT50li7cENLqlrVdK+fYdQEzl7fz9IcZ++SfNQeuFmPVqxBtwvV5FrsqxCFV9u96QFdH25xUkXhZmjBpdI9xos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=z70Aqle/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2352b04c7c1so6708375ad.3
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752516569; x=1753121369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=z70Aqle/3O7+PJwfMIvNPpoWy+yspKXbwojJ4/NwiEJcbPowtKYgMQBb6RgypGtUG5
         2vdzaygAD5PW8kYyBVGvhXouyihipW1IdNQ+Rz+voxk8vQ6/NFJy1vDicKGuVKdVj9vV
         UoueURcjvKXOlG+uxvYIp6FJ7jZQWVLjNhK47WNjyvTAqB/0hYMtKb9FpsE7s4sqGVFz
         /zoWuT90J3FWUMpIr+/Sz/8kImpO08b3yJ+M1BzUhpsDR2x8pN4zH6yfpMycl0hDGD1L
         rP97CbkGMUAf8A/xHUL4tOy6focqSQeaYvtlIh3OyxUgtJMsmkJ+elw0bkLTIyTTxUk5
         J6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516569; x=1753121369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=sX/wE1y0q/4N/QKXUJZyP/g3OO1Mpl7PYuWJE0eWCNZLjpvPTiggc3PrfL3mUn3JJD
         au9apJlY3Hjg91WPq34hGXUwP24fYs0/UqYKCkJzJBqGvzdEeM96tf6MBskOSPqCaVWH
         znoIoRnQn1iZmdYemfbSab/W290hV9TxNatnpnbLQgrw1yAHf45KtLs7rDwS/wfxtP4G
         G0QOi/7EYXrBHT4y+ML3dT94hdu7pYlrPWhRaknIvOVtY6+m1VuaRCrtFNkSI4Ccqg1j
         Vwfl1LAcbC5xpZ86uUqmUF0ACUuDIfwnSoDtxyOoMGA7uJc5yEnZyDfkbKKVRFX2d9X8
         rxZw==
X-Gm-Message-State: AOJu0YybEulPq/ygYzpFwg4CTwgdkhCFcBGOweHLPdxWyVs0uGtA/Bp0
	Y7xF1QIKam22En6onyFpMxQdmwjzWxjJQUV2kBV95MkKOxup2A8YD6o862S0o9M1LxI+AAqtvr+
	nVoWN
X-Gm-Gg: ASbGnctdCz4S+cS3MoCczBGujyil6GSm2LhF3GO97Ld/5ahMs6kFKydpkOwkP+MZFY6
	20/TOzGxpwtiQuUSPY5LFT+PAlVOdnpeW1pH3VYzn4rnttYwl/ZzaKI1CbjTyXI9LsTLqCfSmuW
	5bQj0ddZkzxgrT+w2jWwBnYQvxdn4IP89QTjRgB4HL7msjzTShTcSKX0psWo3DRWElBEbRfc9Ne
	1qvEo5FeEOPnnzszJEtFzE1+y0raSRXpE4UgYj2sMIHK2RBgGhdwr2HPaVBoVutxrRsSoT9TYCC
	m8Nm3rxIQeuxNPzJN0uelap9+83lCbMLUmZiRxsd0vx4LRZokCDigmKLgGrJ19ZWoLkG/YipmI1
	zgGmtYYqrZA==
X-Google-Smtp-Source: AGHT+IHGj1vCcS0CLgK3Kp/EBgZ+Da6Oruf//oEX98pjJ0JzI4SbBw1w9uGigeAP2k5IVwK5hzfGcw==
X-Received: by 2002:a17:902:e742:b0:234:bfe3:c4a3 with SMTP id d9443c01a7336-23def6f8af8mr75680625ad.0.1752516568491;
        Mon, 14 Jul 2025 11:09:28 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:84d3:3b84:b221:e691])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aeadcsm98126405ad.78.2025.07.14.11.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:09:28 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v6 bpf-next 01/12] bpf: tcp: Make mem flags configurable through bpf_iter_tcp_realloc_batch
Date: Mon, 14 Jul 2025 11:09:05 -0700
Message-ID: <20250714180919.127192-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714180919.127192-1-jordan@jrife.io>
References: <20250714180919.127192-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the next patch which needs to be able to choose either
GFP_USER or GFP_NOWAIT for calls to bpf_iter_tcp_realloc_batch.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_ipv4.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6a14f9e6fef6..2e40af6aff37 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3048,12 +3048,12 @@ static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
 }
 
 static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
-				      unsigned int new_batch_sz)
+				      unsigned int new_batch_sz, gfp_t flags)
 {
 	struct sock **new_batch;
 
 	new_batch = kvmalloc(sizeof(*new_batch) * new_batch_sz,
-			     GFP_USER | __GFP_NOWARN);
+			     flags | __GFP_NOWARN);
 	if (!new_batch)
 		return -ENOMEM;
 
@@ -3165,7 +3165,8 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 		return sk;
 	}
 
-	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2)) {
+	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
+						    GFP_USER)) {
 		resized = true;
 		goto again;
 	}
@@ -3596,7 +3597,7 @@ static int bpf_iter_init_tcp(void *priv_data, struct bpf_iter_aux_info *aux)
 	if (err)
 		return err;
 
-	err = bpf_iter_tcp_realloc_batch(iter, INIT_BATCH_SZ);
+	err = bpf_iter_tcp_realloc_batch(iter, INIT_BATCH_SZ, GFP_USER);
 	if (err) {
 		bpf_iter_fini_seq_net(priv_data);
 		return err;
-- 
2.43.0


