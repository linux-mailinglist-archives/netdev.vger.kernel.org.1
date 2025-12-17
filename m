Return-Path: <netdev+bounces-245137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E364CC7B8D
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 13:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9651F304B72B
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 12:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2F834D383;
	Wed, 17 Dec 2025 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/K0abf0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1BD34CFB8
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975672; cv=none; b=sb7LCCuPQHvlKs7wYRjnBEV0XDl24XoUAR8FFdj3BrdKyMx6PqsuTm2BIxa3rZ5shgZU4WquWDxT8o5UftcMyXDKqtjdrQ2u3NBaJqPInUw+mlYWK8wOLWrXviE1TpccXvT/QATJMADy6+x/AeA4OPjjwEu4Fs9m6Sb6jEOaGMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975672; c=relaxed/simple;
	bh=SZnCdTyKaSLAbq/w5ae+5W9P3TCfTqARU6rrGxRItYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u4ZGQsXEFXq8orbZ87r5LpNdHSv+xS8BbhEqmRvvIrVZTxvJr0yX+6JPPN0fPGt2mqlG1CKRDKD9RInHGVBdt/Bk+hx30lE4XAATCKtIXoRE6gONN2Lq9PzxPGqcvgRucDHq5SkGNkFHIbfByMsmUCL6l4l7qxb5bNNZOaZPdTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/K0abf0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a08cb5e30eso9548315ad.1
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 04:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765975670; x=1766580470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19nxpEKwGS7FQgHQH9ItvDMFClxV8pWJ4CiL9LfKCs0=;
        b=d/K0abf0T9Ea9DYjJQPet0lgAjIUMYS4C6uS8sC6xu1g8Lbqs5gmaCkDa6pwCa/5UZ
         Z7rrStNd2wCnjDrhAWsq4gUJlPu3uJJxS3ynjzsbVaXAZ2g8IBzP5F2mpFQA6X1dN1Tq
         rsUcHd+LzsIRVzxwJESrpF1yZ7b1PaoDb63GpF1d8QmwTdV4Wj3AKy7E6MlWWo/SL/4+
         NuIMynKhfr+PWxXZhJsxU6sZV0mmgNcgzM+10JXyLkd7acetlXL26H3C9JuI2YFAP85N
         qID2UDGPJ7I9KhxdyvePmiy2mdkCVZawlC1EskrRTif9ngd4wkI0z7Dg8He1fdd9RJlV
         +x+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765975670; x=1766580470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=19nxpEKwGS7FQgHQH9ItvDMFClxV8pWJ4CiL9LfKCs0=;
        b=dRs5ljDBL7dUvLeZ5ZtHq45ONWSIbnu/jhTvUMwasBml1VkdcZwf5AqKFXHWWzUb/4
         DW+c1r+Co6tYehE30jXkRumMBKGaos9CgMKzH7LvVvd1P82zOzNSfNFHr5/FkkO55bnN
         qd+d2WQysOHdfEwTUt/SebdZK7AWaIY68QKzV+GTyae8mN8tEyFuKk2rgCGN8+QIh0Hu
         5jvQ/lKGEejMAzgkkuJE5f4KybUw+HNbT6KYjnY06xeDd0bJ0OFqQiGPNGH70vGemj3V
         411PLPvaoOvWjDcUSUL9GQ0JoL7e5UyylvbuhjOSbiB5vARrqNh65gw5XjGVvY/AzqJo
         JBPg==
X-Forwarded-Encrypted: i=1; AJvYcCVkWmR6VOxKAOGe+Yz9Ee1j2jBKF9LRvHhK91FhRuSIimbj59NO0dtgM/Pmq2+PK5BtZiSxJJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfyM9hWdjxBVo9+YZsD1pYpsTfgqp30C75pKfKCSfVADS5kt2k
	IxKGfjVRwWzok7jQ/gT9AojSUWJxKkRC9kDyY3NQPus70udxd6bOIQNg
X-Gm-Gg: AY/fxX6K2/A7uyiR5x2eqSk8BLa6Xh3g4urer2sYt8YSdZhytwg2XFkLUEhurZCSiki
	eWCImTEsHZzbx2tBbITV9OmmKAUdMw02pfR82SLSIQD3aPWQNPpnpdfOWsWdSKSFRiDzdqZkEXQ
	FSxtNolsFnhLmMiz52tn2OYYr+Gl8TlExlIBMQ478FHIH9eUnJSlhdd1kEgjEFJ+bKhqMj5FK/O
	llE2u71kOIUAtexaNQMvdFaG4xWEoMzFNDJ5AqYstImY8lWD3cnjWD91dw2xxQEUfs4t3Prn98z
	BvTJHbKbKrX0o4K1APADFNGX51/0Q9JopHS7+sp8MCnqlIjROJqHax58zRJi8QbqBg3DqfVeR6P
	z83+UIbT1Sf8l2NnzUI0lobmWEUvbed745boSDS+AGKQPihn/2Y4a3UcJGeETTSboPy2EHH5W/b
	6bM57qUpWOWXSyKPlWsACgBzpmg9HL/jaCCNOzbnokDFvy93qI8/FBZSJGZ4toFZezYHjfWGI5
X-Google-Smtp-Source: AGHT+IH6CTUoiN9TTvjJhEgQ4KoyPFZSBuBAt90acyYepnVfobHn4rbasfVfqTeJCH+U+41FauhvTw==
X-Received: by 2002:a17:903:3d0c:b0:2a0:992c:1ddd with SMTP id d9443c01a7336-2a0992c1f83mr119457175ad.8.1765975670618;
        Wed, 17 Dec 2025 04:47:50 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0e96df1c9sm98306795ad.39.2025.12.17.04.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 04:47:50 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: linux-nfc@lists.01.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Qianchang Zhao <pioooooooooip@gmail.com>
Subject: [PATCH v2 1/2] nfc: llcp: avoid double release/put on LLCP_CLOSED in nfc_llcp_recv_disc()
Date: Wed, 17 Dec 2025 21:46:58 +0900
Message-Id: <20251217124659.19274-2-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217124659.19274-1-pioooooooooip@gmail.com>
References: <20251217124659.19274-1-pioooooooooip@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llcp_sock_get() takes a reference on the LLCP socket via sock_hold().

In nfc_llcp_recv_disc(), when the socket is already in LLCP_CLOSED state, the
code used to perform release_sock() and nfc_llcp_sock_put() in the CLOSED branch
but then continued execution and later performed the same cleanup again on the
common exit path. This results in refcount imbalance (double put) and unbalanced
lock release.

Remove the redundant CLOSED-branch cleanup so that release_sock() and
nfc_llcp_sock_put() are performed exactly once via the common exit path, while
keeping the existing DM_DISC reply behavior.

Fixes: d646960f7986fefb460a2b062d5ccc8ccfeacc3a ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 net/nfc/llcp_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index beeb3b4d2..ed37604ed 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1177,11 +1177,6 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
 
 	nfc_llcp_socket_purge(llcp_sock);
 
-	if (sk->sk_state == LLCP_CLOSED) {
-		release_sock(sk);
-		nfc_llcp_sock_put(llcp_sock);
-	}
-
 	if (sk->sk_state == LLCP_CONNECTED) {
 		nfc_put_device(local->dev);
 		sk->sk_state = LLCP_CLOSED;
-- 
2.34.1


