Return-Path: <netdev+bounces-72810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E26859B04
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B146280E3B
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 03:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15828442D;
	Mon, 19 Feb 2024 03:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+9/zENp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA582BE71
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 03:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313385; cv=none; b=bfbi6dUSRBBe2NH0TbnHIOkEmgwnhfW8wfKG7UQdWxLKiNOZQc/byo55Z5r8T0zspEl5OKnzvkVlGtWzcdZMjKKUU2Vm+rvWxem/ay5x72lmBk3ncuW6aFoReQR2GtUft3yS5vVtJuW9N3dxzwHMoCNmfrqWYueXOJQFosVwg3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313385; c=relaxed/simple;
	bh=tn2LVqo0RMEJilwRLKsaihvQyhTgPFdgRigOcEEXbb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c4sseEK51Q8NQize92Rgf2nD3kylU1fBS9kpjgdynrVPhXIrqPGBnA6xeSsbQtQ5k4gQSfsVVWHCLGG/LgWr7MBaZ7HDbKQRxcYB+fiqvFQh9VafGQsYP6U/2gRQkKIL4sAAJVbuJUn3uydZ56b6mC7Udk+Uj7TrRsiJPscs7Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+9/zENp; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-299354e5f01so1577350a91.1
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 19:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708313383; x=1708918183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDlY8tz5WzHsF/5Yj0J9U/DDfujUDO6GbrYQnuFTuuw=;
        b=f+9/zENpiwPH9fniWk2FtRyqvpLKRxZRCVUhxbqqL18Wb6CGFW2AC11gfvPXsO6NZs
         9EovhGjg4ONilQ9jgllY5y6kipMYXxvIL1v8sQsMTCAJnH2BY5AMvq1vUe0blk4oJQox
         SAkC1cQd3cBYqkSZtVumh84Ib7z7TyF1eMwR8A2UXJ+/YyVukhr/K42RkGgmi+UAMulo
         X/FpBV9ECFgfo3GWHmTYuSd66QjRs3ombTsofSk2YSyHjUF2tqV1R2O6o43uJp8kXzrD
         pg0UhzvFDjv0771GhibmKKqhU5vOcp7HDlypHomHe3As3tEixRODPshysSqojaUXvYlw
         2whg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708313383; x=1708918183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDlY8tz5WzHsF/5Yj0J9U/DDfujUDO6GbrYQnuFTuuw=;
        b=AYZ410rVfz5pUsiFwX9zrIjjO2ihVv5GXuHnW3VFJhhCfBra3HlObUnJgA3Zna+KEW
         mxKvjVwd532O3pAMGjLyyP8YjYshW6ueNEySgYpDc3oESgBRFzJ1BcNcqiF7sSfX34yh
         IlFrIm9LyuhSOcF+LZgzZwlRgZ/CkpLhDDZOY3qfzJyQ+yMiFvDdxMbm/NItXQ2b6+hz
         zEFQK7lO2jHfnGmEK/fN35Eh2eryDCsu3D59MlCBOQ+LSM4Cv0tywvjyKZyvV2Rch7sS
         pymkpp/iIhnazf7ho3CZKjGzhUMJ5j0r8jOIDNLnfHfcToGuYzUzm1tvCbESE929rC5S
         T/hA==
X-Gm-Message-State: AOJu0Ywf1qr+hflIpMek+OIxh2O3aUfDrjxgIUB/akTLpn/0ZEPoRUU6
	9I/N1tbMHWa206HnzApMAw91IMMp0//v1ZpsHZ73Sy06x5XRZ7oG
X-Google-Smtp-Source: AGHT+IGw0Wc72DIH9WNFYDczYCnqw5XqX0o/cQevjYX9I06W2K/Cav9PWzXfjSxdmqhWRQDlHErkQg==
X-Received: by 2002:a17:90a:e517:b0:299:3469:832 with SMTP id t23-20020a17090ae51700b0029934690832mr10695462pjy.1.1708313383024;
        Sun, 18 Feb 2024 19:29:43 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm3968921pjb.25.2024.02.18.19.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 19:29:42 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v6 11/11] tcp: get rid of NOT_SPECIFIED reason in tcp_v4/6_do_rcv
Date: Mon, 19 Feb 2024 11:28:38 +0800
Message-Id: <20240219032838.91723-12-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240219032838.91723-1-kerneljasonxing@gmail.com>
References: <20240219032838.91723-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Finally we can drop this obscure reason in receive path  because
we replaced with many other more accurate reasons before.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
--
v5:
1. change the misspelled word in the title
---
 net/ipv4/tcp_ipv4.c | 1 -
 net/ipv6/tcp_ipv6.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c886c671fae9..82e63f6af34b 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1907,7 +1907,6 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		return 0;
 	}
 
-	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (tcp_checksum_complete(skb))
 		goto csum_err;
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d12a2a3d565a..c710d6ad46ef 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1623,7 +1623,6 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (np->rxopt.all)
 		opt_skb = skb_clone_and_charge_r(skb, sk);
 
-	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
 		struct dst_entry *dst;
 
-- 
2.37.3


