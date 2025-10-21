Return-Path: <netdev+bounces-231264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10096BF6B1F
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB8719A4F15
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FD33346BA;
	Tue, 21 Oct 2025 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOd8hT8P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFFD336EFF
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052375; cv=none; b=k52rMCZOhEBe1k8z3K5ftmEjovW2LTvffOdc0Hk39kzuWuTn+sRbnMQJXtM39J+m5C9Tzr8AR6O4R2PPxCF3x2MuMbwKaKfQOpXFUNYa4RvHmXg4rH3jBN0xyAVrJTAmkHTDWtKpWdJb56DP94jPMhFYHQR7ut+QZTevJrMXIho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052375; c=relaxed/simple;
	bh=XV21u0o1UkZ+p4SG4ifSb/1NsJU2+4TPwZ/wKgidg9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aNvjjCpfotOKZTTMU9bxJQQ72JiWekDKOkE4wNvrj/+bc3BnytTop+kWJpWIOKdUwiSqnBOeNVY8o6rRR2BJTH/euSGD4EV6NOiEZuf9buhC/LgU/zh4aapXRyInSECZNWjuSdr8lgN5DCv/+6wT08TJdeCAhEjSSchr6GfC/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOd8hT8P; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so69872885ad.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761052373; x=1761657173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GWp0OdfmGSSPSvRPpG1fQFRxJdjlWQ03bu+3XaH0mY=;
        b=dOd8hT8PjQN9mr095IScPRjpkydZo4/CEvbRYBQX0hmqEiWQrXRlhbGhswXC3K/VsO
         sY6qZwAj18EdyKPZ8MJeqAex6323FgcMYk57MmatXFsO9DGbmaKepOl1B99SKj+G0gsD
         W+2eblDGb5s0VZfF7Xyn0U8ulL4SI1BvtMQtWPlDKl9LSMgdgV2dGsH0D05jDQXZQh+Y
         UgdSnZruzmTohOin45EinXrga0pMOmZ0OSrszvuKU595Y84oplbWOP7jelwRf2EkLW5o
         IQAgQ7ZQw9nTlRVNK03phzIfWbQrlgssQtb45QRz5MFow3Zitkce4Rg/i9MQ89uYWPnf
         gwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052373; x=1761657173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GWp0OdfmGSSPSvRPpG1fQFRxJdjlWQ03bu+3XaH0mY=;
        b=EcEIsBwvIVuhaBCUp8h3yrkyFPqDyutQlpG1B7SoQbB9jDbltJ+ualiPqyKjLc3CzY
         KI/TSwn7x+lyuOduIgpgYFRgGnvZkqQ05gBCNvGUTbiDhdewXzP5u3heQzIvumuDDceJ
         ywrIE3LHG76hjIx1mK6v57uxZhW3I2RJ4eS/7O3WeLAt6AW6l2uTBE5IKO9Tvol4dic7
         T3fOS9XuEhV3p0VecnZIAX77aUZdiGkK63Ilhd8C3nBPbRuWZvZqC6f3v/zOvTvTyz5R
         Vg6dZ/E9hA+D+A79xe9OrYf5h8hrVNZ7UO+JDueVCpF8cRfUNC8fhs5wU57TMzUB3d6a
         94mA==
X-Forwarded-Encrypted: i=1; AJvYcCVQDHi94c9Tcu37zXMaqCQi0WUQHLO2e9vX/JzW6CaKMpnm+3PqwP9le8iW/uXkzUrc1ZzNbf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk19TNroB4fZJc5TUH2C70DM1w57G5w4zxy8xQjuyMIL887+Nr
	olRbo6uAd0cnGbsgZT4QRWx6+daJV2OHZ92csNtUfbW2n43e4X2ABtHv
X-Gm-Gg: ASbGnctWqc0L7aDl7E6ZQr1D/uhVkCIRQj/rRWe83KKexbCP5fsr1X9joU2RMGTwziN
	ZTK3nXAGp8mUD2efQKY/nxAdgcjCxsnVTq+0y/NctI85Ty2we5LDe/eddkAc5/E09F3DuU8O2HQ
	UVwTHT5rshOrJR13IB7jIubDie+XfSZHu/nL19/4OG5AtAHI/fLEO1y27nvIDYQW0zTV6waMT2T
	GJAo7svK9+XRvitplPRR91qsCbTX0B4mClIYLywAd98vEB+5QKvO2NeVfLkF0lIF9WujwJ0HWRm
	sGiin9mHiW8M3URWn4kCYpEfwwmR0tlu4l/8Pgy0wtlVYS+Xb5J/Tw1TapCqAQYPIwzyLxQbV4m
	lqgQjttwz/ZafOK2pZw4fpcvPJkITrVkmU1fdg2uhKxyBzE/YgPX+ck1xpUoRVj6QkFiGRYVpQU
	8evfch6wOKTN7/dyQlU5Qe8fKtxD5UkTrM1Q8j/9issOIqwnU=
X-Google-Smtp-Source: AGHT+IHz7PPIn6WpcJnf0x8j9af9ACfhUzxhHdjR5t5W79Y7Grn/3zWUmVDFNk1/IgZQS3aQUA1F5A==
X-Received: by 2002:a17:902:ccc8:b0:27e:f201:ec94 with SMTP id d9443c01a7336-290c9d1c446mr225901315ad.18.1761052373383;
        Tue, 21 Oct 2025 06:12:53 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fd9ddsm109248175ad.89.2025.10.21.06.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:12:53 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 8/9] xsk: support generic batch xmit in copy mode
Date: Tue, 21 Oct 2025 21:12:08 +0800
Message-Id: <20251021131209.41491-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251021131209.41491-1-kerneljasonxing@gmail.com>
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

- Move xs->mutex into xsk_generic_xmit to prevent race condition when
  application manipulates generic_xmit_batch simultaneously.
- Enable batch xmit eventually.

Make the whole feature work eventually.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 1fa099653b7d..3741071c68fd 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -891,8 +891,6 @@ static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
 	struct sk_buff *skb;
 	int err = 0;
 
-	mutex_lock(&xs->mutex);
-
 	/* Since we dropped the RCU read lock, the socket state might have changed. */
 	if (unlikely(!xsk_is_bound(xs))) {
 		err = -ENXIO;
@@ -982,21 +980,17 @@ static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
 	if (sent_frame)
 		__xsk_tx_release(xs);
 
-	mutex_unlock(&xs->mutex);
 	return err;
 }
 
-static int __xsk_generic_xmit(struct sock *sk)
+static int __xsk_generic_xmit(struct xdp_sock *xs)
 {
-	struct xdp_sock *xs = xdp_sk(sk);
 	bool sent_frame = false;
 	struct xdp_desc desc;
 	struct sk_buff *skb;
 	u32 max_batch;
 	int err = 0;
 
-	mutex_lock(&xs->mutex);
-
 	/* Since we dropped the RCU read lock, the socket state might have changed. */
 	if (unlikely(!xsk_is_bound(xs))) {
 		err = -ENXIO;
@@ -1071,17 +1065,22 @@ static int __xsk_generic_xmit(struct sock *sk)
 	if (sent_frame)
 		__xsk_tx_release(xs);
 
-	mutex_unlock(&xs->mutex);
 	return err;
 }
 
 static int xsk_generic_xmit(struct sock *sk)
 {
+	struct xdp_sock *xs = xdp_sk(sk);
 	int ret;
 
 	/* Drop the RCU lock since the SKB path might sleep. */
 	rcu_read_unlock();
-	ret = __xsk_generic_xmit(sk);
+	mutex_lock(&xs->mutex);
+	if (xs->batch.generic_xmit_batch)
+		ret = __xsk_generic_xmit_batch(xs);
+	else
+		ret = __xsk_generic_xmit(xs);
+	mutex_unlock(&xs->mutex);
 	/* Reaquire RCU lock before going into common code. */
 	rcu_read_lock();
 
-- 
2.41.3


