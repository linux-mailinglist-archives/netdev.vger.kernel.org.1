Return-Path: <netdev+bounces-246699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 395C5CF078C
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 02:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A84453001035
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 01:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02852142E83;
	Sun,  4 Jan 2026 01:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myvRqccz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D57D273F9
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767489699; cv=none; b=j9UWEW/xCN/Ftyg2DL2qOnKMDj6NbTz6wGavGMom7kTsQWSw6eRv8CMGvX+gvdC7tr3FdpYDNO66DZfSElfzIbO9r5xgClYveVPAhsN7bUF4cBnWZOmFum+hCje3lkng69JNGk1+UCIXjLJbSpNU5Qr8Jpk4Zys9sNJDdF6NU9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767489699; c=relaxed/simple;
	bh=687vFU+Ac3ElVt5OfIK9YxqFBQwJpgACGGszq/z+ks0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CDZ5IVIK7z1cwwe/7lGKSqSKYAarmY1QHVJimlSJTzErHxRyWBj/5pqetDIsUGVhmsPM5X/CKN/z4YsFda59YoqU4+XzaDdr+mzfGCu0GPwAy1YhaEq9egneK700BdgQRVRCb9nFhaID4L8vWjDwNMni4PQIaVQbl54KOAYMu8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myvRqccz; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so10808976b3a.3
        for <netdev@vger.kernel.org>; Sat, 03 Jan 2026 17:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767489698; x=1768094498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw/KQU3zYxL/kw3hU57BvEqlVos5RIoPuX74COM6oHw=;
        b=myvRqcczVWERbnCl80RejvdYLzJviPI7D/RNVEb8Gmp9jCH0EqUng7WGTPAl+bliGI
         MK+xr9u3Sb5oJCfjc9Z9Ah9BOE12p+X/7QabaUPNatNKSkDxCJwOM/9cJXr/z74zNukN
         LjxoaBSe86HBR6jRlvbBnFef8CJ7vSx22qlbqtUTCTGgy9m/4xTVQPfPVZ4fWoEbdOfw
         J1FpP1Qaxu4o+LGK5yGCdNxcZ6f8M/UchPnjc+XLz+SGtKa5qcpv762Kpuuj0F4JOPEg
         2UqrFVPib1h6rl8HP3XRkf8pZeoihrUfLjlaU3+ozBTT5pqMYlXydWsK4dY6HFsicbsT
         +2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767489698; x=1768094498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qw/KQU3zYxL/kw3hU57BvEqlVos5RIoPuX74COM6oHw=;
        b=wqFMWEg+MW8+e9Q7hrhsgHekHFB8civfquKARNpfaTLReol/CLt+ifayOrN4ptD6Y8
         h4sghtrsP/I/cwZClzKQOe93/xhYBe/84JEFQW74QXUTh9HAh/ZwLII2ErzJhGWKnxMU
         0VsJzXeaFjHeZD5uC9owCZKIDAfyx3tlLOZ194ty36Nk/bFZyZepX1+WB19OuhHLKC+0
         Hw7voWGHcypqxvLt35vcXxNOIiddJ+HjLd1Oak8ycKAK6D2fiai2bDSwUKyY5sRe+Opw
         rZuh5peS/ez/STqioDrY9DEkHulXuV08n77ADnPFjaczFTinHSVDjiS+2z9eYoakRMQd
         ARuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqAgSu2Y4SnGv6BAQi93Y36qhZm9tDysSD1q25ivG5sDWxS9x6x23tmCe/z4PmQwCLwjrJHtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Y7yJW6LCEQ1eixqwrxlkSqVz3dJyntFsStkApjatq9Z2BB3v
	ZP49aT7i1+ElbRDI+DpW2sR+/oK6zSPRXmfycsq8h9k1QiIA2I+7tRrP
X-Gm-Gg: AY/fxX6wgYNbNHgM6aGnfBPVTn9SGv/zAWNBzIJbPv5MhFsslKxjNF+BKYo1e1Dk3DU
	n+vA5iMGDTYHcoF3ZHJP/Lb4RS6LewhzVq1ygiqfzAGX+vjZdzJV0hdDBKt8qQ9/vyEw0cOQEDt
	YiCLtWJKzln5YvHV5oS+T7E1e8q/R8z43/TUAvhVPHF3xjmP/OnEkpecOPJZ2haY6llBppmSotn
	fx8gRz6TTWH9K0tuWnU9B8T44lVC8O06aIxu2vmf9Lqe3iQcWAQ564WoMtCT6TOTFY9rH1Boghp
	Q/xz6yjy6Xwnp+oLRSQlsotes07QloAfYIirfzcA973zLK0c8bZMs57T0Kb4j6lh4dFoQuwsuMU
	UsYnb8PX05qVigKayfNxHDpg0MiL7CGDImUdUJqohXu3bBY8BynZ1+hRo8t1fZ+5OCZWD9Hf/8S
	55kIBuYfRASEkE2OMWfeItp7BRJNOm2eIEBCjfwp+OoZZZacNqBA1+ALQGIw==
X-Google-Smtp-Source: AGHT+IEKWnD4epXXeTEC3lbcdS2+1wBtn4kSsifXIKD0EXqGLXf5GqvVdXiwWJ3KHtMCs9pUQoNyAA==
X-Received: by 2002:a05:6a00:4509:b0:7e8:4587:e8c1 with SMTP id d2e1a72fcca58-7ff6647983bmr37764640b3a.52.1767489697811;
        Sat, 03 Jan 2026 17:21:37 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f3d7sm44484500b3a.51.2026.01.03.17.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 17:21:37 -0800 (PST)
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
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v6 1/2] xsk: advance cq/fq check when shared umem is used
Date: Sun,  4 Jan 2026 09:21:24 +0800
Message-Id: <20260104012125.44003-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260104012125.44003-1-kerneljasonxing@gmail.com>
References: <20260104012125.44003-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In the shared umem mode with different queues or devices, either
uninitialized cq or fq is not allowed which was previously done in
xp_assign_dev_shared(). The patch advances the check at the beginning
so that 1) we can avoid a few memory allocation and stuff if cq or fq
is NULL, 2) it can be regarded as preparation for the next patch in
the series.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c           | 7 +++++++
 net/xdp/xsk_buff_pool.c | 4 ----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f093c3453f64..3c52fafae47c 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1349,6 +1349,13 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 		}
 
 		if (umem_xs->queue_id != qid || umem_xs->dev != dev) {
+			/* One fill and completion ring required for each queue id. */
+			if (!xsk_validate_queues(xs)) {
+				err = -EINVAL;
+				sockfd_put(sock);
+				goto out_unlock;
+			}
+
 			/* Share the umem with another socket on another qid
 			 * and/or device.
 			 */
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 51526034c42a..6bf84316e2ad 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -247,10 +247,6 @@ int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *umem_xs,
 	u16 flags;
 	struct xdp_umem *umem = umem_xs->umem;
 
-	/* One fill and completion ring required for each queue id. */
-	if (!pool->fq || !pool->cq)
-		return -EINVAL;
-
 	flags = umem->zc ? XDP_ZEROCOPY : XDP_COPY;
 	if (umem_xs->pool->uses_need_wakeup)
 		flags |= XDP_USE_NEED_WAKEUP;
-- 
2.41.3


