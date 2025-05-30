Return-Path: <netdev+bounces-194432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D297AC970C
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 23:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0009E1C07020
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 21:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F9228368B;
	Fri, 30 May 2025 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="Pb6f1J9D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3987D27C17F
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640679; cv=none; b=K02BH88mnL+oO5nKqN7Nq+RCcfcJPC557wl8D7MmDzVVvLFgvllRq+BVZUvQ0NoUjWwwfBO/wmKqpVQpv/Zh2S7KFDS6KUwaBHg3pCikn8ZKeXkt4Go7l97xFgY5n9gGawE+YDVh9EldyK8mP5xFikX8GGvCUsAkLYPt/Q7V7fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640679; c=relaxed/simple;
	bh=P2TM48kjMxPSr7YwvwYsCNfh+euwlg0K2KRkqviR9cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOclEYesL28u5/K6SXhlAVM+bdC0RM9+OSeZYFtzdCudH+s17VO5D+Kuf7+RK31zhTpo+f5iUgJccPSI+YXBygDaBSGnGIzucAfUU1qEaPz9tcNmJ9mweOcnmgu8lAl/lKgHBi/3ZyeuY6wwlApmCwtrH1wCrevcx2TeQPGVxTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=Pb6f1J9D; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af90510be2eso328071a12.3
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 14:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748640677; x=1749245477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=Pb6f1J9DrRZp+E2U3Adml0QNBo2Ng8fDzyFTAq4e+/F046+G5EZGw85Od47604x1Yf
         cgkAZa9FWzYQv15z6CxW4pEOc0gAlQi2xd+QIqANwvqPA5I3agUSICHWKh+pJOa7qSCC
         mXPqJSa3KWrAA2FZFk6M/VCkDxEuEOQYh0YdH/uGM9QnMLbbe73nUGz7brU4nEUHPlER
         iKQYEOTm8vAGzNoa/7DUbvbJixYu41neXJKdo5CmcVr3D8MMmWFN4hYGgueQsjolKTw0
         RMAaOggoDRiXw4C5cIriT3CwIeY7MTCLDsVAQ0TDt5vKGHGbBqpNncBCSq5E9fn8EXEG
         n3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748640677; x=1749245477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=MGe57zNt+Bt8Rd51Eu+4LndFjuj2gxdgCaCZ9mDZkAM3UzE3rgUUwJPXFYYuyjJFKF
         7HScKMOjiz5Cs9xe4Sd51CBLok9hg6hGDHZNTnqFIfD26yKeSEsPRK+IWkOTgkY05zdW
         Oo6DrtWNsBg7hRoul1dHX680AtbzGByixEt3knW3pfBvPaGffNKrE4wvGCVTbxlj5JFT
         5+Znl49UgMD2Krjdz9C7fNpAupP4IeKEcJhteeU6sT616NTcNd5c6uCwPeVA9SdhDhCH
         U8pUpUDk7NrQHTjFD/hhlxXbMfOkK/F03S4JkhRODrr52ikdi3SlNA+IZtcej+OX1PXG
         o1FA==
X-Gm-Message-State: AOJu0YyjoTXpMukqFtZJVYORmjjmJNFzTsGa74PCjcA4+jj2pEPy6O8P
	PuTgeUxExz7nB0V0aPEKLbT7aIIl0Y4QlYzTcuHg9UuXn8H90JEiHRHGmCKe1exsU9i+HOuWm/U
	Lq+cbpvY=
X-Gm-Gg: ASbGnct5tYP8Dm180C+/8XEebSFiocvF6h8Tk17mpdc9C4+/Z7QMYSeZXA9QH2q3hY8
	ooJi0QI9nUkAxhp5IJryXGwB47k/Ro0I/8Pw5cuKSd9orR1J+SYxpvZI9vBXbvty4pXwO9h4Ikr
	ogGyvkagtFslfIea7uftAqDdDqTIrK5b1m9zo6+4oA+xGNxI+au9HCMSFUMIGl1lgnV1JmgEYTV
	XsGb/2grTiIoUEKkcvvA2TxxPXU0adhWyiVz+g7/bPqjiz/Jej9YUwc5Tiq+i1F6r9y+U5mje22
	wkA5b8F2VsADG15yLysqumL8zmG31eqNZ4G0t0YZ
X-Google-Smtp-Source: AGHT+IFhjU9YgCkKX/W7AlHjSgNtaoHVqxi7E0v23gqepaBq+8zMR/9FQcqI9m81n6pHLdIvvWbjSw==
X-Received: by 2002:a05:6a00:3a21:b0:730:9a85:c931 with SMTP id d2e1a72fcca58-747c0efa956mr2096680b3a.7.1748640677098;
        Fri, 30 May 2025 14:31:17 -0700 (PDT)
Received: from t14.. ([2607:fb91:20c7:44b2:2a24:2057:271e:f269])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed4399sm3496763b3a.77.2025.05.30.14.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 14:31:16 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v2 bpf-next 01/12] bpf: tcp: Make mem flags configurable through bpf_iter_tcp_realloc_batch
Date: Fri, 30 May 2025 14:30:43 -0700
Message-ID: <20250530213059.3156216-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530213059.3156216-1-jordan@jrife.io>
References: <20250530213059.3156216-1-jordan@jrife.io>
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


