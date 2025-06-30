Return-Path: <netdev+bounces-202606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D25AEE577
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A588C7AAA66
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA084292B4E;
	Mon, 30 Jun 2025 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="q9G1YIaK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8728228B7DF
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303850; cv=none; b=ll8P76biQBawsdHO7Fo5Ph3JaOar1PC/Ar9mqhRJ/cNt0qrjdY5eVsQQ+rwYuO12uYrCRu3pybO/QP9cbV0RqoSMjiVCzwSZ17D2IZ/AsrDFeMIOx3F7bow3JnFtXsbhY9C0rYlSvIk/JoOJxLblyUD7chGc/xFeEYfJVSDP/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303850; c=relaxed/simple;
	bh=P2TM48kjMxPSr7YwvwYsCNfh+euwlg0K2KRkqviR9cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2diH5pPHxWWWKSWB1OgaX4SlwQhTIlQtXSbloBrb+GZOv9TwKm/0qQo+td4lpGkJbI2HC8zwH/JgOnKegPeUR7YTTqFpmkS5HhUlSy1SaZEFKCa6JM622Uu7AFxEr8Erz34KCCO8wRp+8WnjWH6GGhDB1bZGJvcUHNocQn/tBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=q9G1YIaK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742ad4a71a0so276700b3a.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751303849; x=1751908649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=q9G1YIaKfMtFMMDFtr6iLQzISckJd6FBYr9JIR6886XM59vHD6N7cbvTvb9yNQiYKH
         6FLfqpCDg5MqVyWwjHWXoHOANeaR5wvUjod3iBd+xo3Lhcquj+mQPLQ6p2qjdVVCtBwy
         BoXXBwE9Q3y9nj3WudZ4hh74NQjGupxl6DLvB+DadfQP4UmXWP2pSy9QNAMK8PZJO3Od
         /np3ra2fI3ov5r0o1W0arg9CDCPXbQkYYGIsES3M0RcpxeX5dIpvsSsKXK8TuPwRL4lA
         0PaUbKOmlVXL8Pb5pdUeK6QbNeUUcP8E/m3aoeVfk834HgbQ3hRK+tWYegQBmuRfgnlH
         YYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303849; x=1751908649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=pKq4e6MLPN/EQALowGlN+SIUI+SWp1vcnFBjwMZ3gi5AK9+z/K2y9xlWsRhB1uYx/v
         eV5b58XKRckfScX3TIUMsbRiOEbRfT247JtVDvLupoxDTEyXl8yFhLte9QQbuSE2iQ8i
         KBN7Jb8gsDFjI6Co0JcXtFCJD3zVKTYuV9isOnaPH7v5xPfNTudRH0t29vKXfQuaW2ib
         BLq63a+SxYg3g7WqeDv45lT7SiPz27EA+46cOkgbPVNpGe0z6Re/U/D1HCZ/bXzgdMri
         9u86ABY12M2HRtNSx8Frlk3v9ln1LxOLg3hooz7p1wSbKRa1e0MikgR/5QcPQD4nOZgy
         4D4w==
X-Gm-Message-State: AOJu0YyGpzUFPxrqy6jk5/kvn4EgsM5rBAvNE+wUXmBaN9E/yIUqbzvk
	1+ZFYaF56w8bXRHkXGdxKsDaf/LoNaTZXcdfZZFbYAiqJtCuG0qTgHF+zAfTJbo/7aQUuT25Vwe
	rPPSxeSo=
X-Gm-Gg: ASbGncvekiQUuZ65zHr3HvTzQ/vY7J0N/1dd6RM6Ry/IujCXzMrJNkpcILUjWVNmb4P
	kDVb2NVFeit0fBkzecFzAoaZmTsdTCV0OcAMryxad7k78E0ZtDfft+W39bXK+XEkc7UiipXV3+q
	Ix/Je6/a8qN6LX+fipyJopAaLKFMOuDaOkKGqoTkh0pnBC5YUKhk3EdzmDxMZNjY1sgPIcafU0y
	aS9Ck/pS5/aG+SEj3xgOwlnr8YNXbHszy5yc5OIOXVSi8FCFrxgPjj1BzGdoT7PWQ7c/V4+XTK0
	D6s782OaeKntVUSRfun2vVw1pHuDSAc0d1856M43Sz4FrGdDJXiX2/uS/eCu
X-Google-Smtp-Source: AGHT+IEHjfbIiymPPKtQQ5dFAvdqRmi1SUi7T7b54y72xb3Dwj1I1VzH7q/9bSodgZcp6Wd0cpY/Ug==
X-Received: by 2002:a05:6a21:9985:b0:1f3:478d:f3b4 with SMTP id adf61e73a8af0-220b1665595mr6030424637.10.1751303848581;
        Mon, 30 Jun 2025 10:17:28 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:9ab8:319d:a54b:9f64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a846sm9229232b3a.31.2025.06.30.10.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:17:28 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 01/12] bpf: tcp: Make mem flags configurable through bpf_iter_tcp_realloc_batch
Date: Mon, 30 Jun 2025 10:16:54 -0700
Message-ID: <20250630171709.113813-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630171709.113813-1-jordan@jrife.io>
References: <20250630171709.113813-1-jordan@jrife.io>
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


