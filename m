Return-Path: <netdev+bounces-245224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E07ECC940A
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 19:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D5E730AC4F7
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 18:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D991629E0E7;
	Wed, 17 Dec 2025 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUGTr0S1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AC5271448
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995157; cv=none; b=uGCDrfUnl6FMjXYhlyPLdgD48NdFyfo2j8xk15Ce0jYnM5Q6MFZ+3a3EDqvT8r8N0qabkUlnfoS6rt+psFOcFGgsmJHN3E5sl/0PPsPzpO7pjRn6JtSiIBHPIh7oh3Hva3L2AhEJcN9yWgiuN00oab61enYR2E7zfqhevHwZhcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995157; c=relaxed/simple;
	bh=Jmqh+IeYEuPfjt31rwC4R8TE4lp1zQaI90wvXPqlmWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bbYGNpmbHUJFJlmXkyeYEYNyE1FMYx9nA6dcZaF62B6jIwn0sQkozUZVV+0ww5lPdkMmVBbRCdUf1LC3g9RBzLEzL0trT93STMNklcFYiM1zbv1yIIR8EZrJC2+H/o83RCzaYX1uumbIhl28ev0c8gprjJhTq3KxbLpzU/wShiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUGTr0S1; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-597d57d8bb3so5188329e87.3
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 10:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765995150; x=1766599950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+qEOT5fYFn8bKw8MykPWrfcTTy8Zhs7SgEc83K5GNw=;
        b=mUGTr0S1hNDy11oFxzMwD6LIKfLNvr29epV5m9bRtT4p3FFDNHk96OuCvO4caJorqU
         CwlVDtic3mu7OYvHghSRdxATFA2aPLkp6yH2XG5H4VAnLRW0RPh2pmMB4fB4i+VYBmyc
         MVSwQIG7oEO8JFc+oT+Aa5ZiGU4rbUubz3zvqT3gscIhbHOEXzMoFj1c2V2wrDzoFzKm
         2JeSratQTkZ/bEVzatEiYo330fqsneTSbf0ME9/gLzhXv3iMAf7xI9dQeRQaiTpjx+Gd
         Jj26DaEmjhBZQsKjJv9z5mLJNrA/ggtruEliL+NZGwpAErA0Hx7u0ZHdp3+z8wwQa8OP
         FpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765995150; x=1766599950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F+qEOT5fYFn8bKw8MykPWrfcTTy8Zhs7SgEc83K5GNw=;
        b=PURzLj577sKgMMv6NsUwnrhMNE7RbDk6imIl9+YDAEOPS27ndN9by6vfoIvA4ZLsZq
         y7+yfTcsUxdIozhlmnB1M4OXG8CfIHIyU2EgAcLSR4my4Nm6vqD+FIWc4EuWj+yOEaHq
         GLXPLXuMJmsJPANDR9xd+/pRcvhDcW19KuSSadGBftWzP1OabsKmb8Ly6ESEew9JTvMU
         d7xDP+Wy4WlWyjrb1e8Nqr+NknSk6AXyxVv/3mHJkiRZUDhbvpew0ZqDFSzq9MrwDv3E
         LsIi4jp/Eb1NUE7ZFIqKI6oe/weyZyVUr7xlWogdJPtkMj6Ad41r8SHvU8pjxK4J9B37
         oy7g==
X-Forwarded-Encrypted: i=1; AJvYcCU9MFPYkc35jpw6iWKVsyp/kjWX2d7U9sqM9TqD3gcJhghpqVgQhKqhy7oBLy+fZdNu/YIHL5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNG9HqVTBS+6A8gvCQqNJQROhcJDzoGFTaYCTbnsQd8n2OQYfQ
	BSYG4zIbeWD+iQirnoEltTiij/LrpNh8ai5M0GXjxwPP5CkOIaZiKxdo
X-Gm-Gg: AY/fxX6UhsCsdX4USWWBb5Bgn1jk0ShppuHM6YOibAodIA90RyO6x8zHJBa1aFRL+9y
	o9NbVUpX5qpHcF+tl5n/VOFQkK1PDkgIJ3qO+dotVy7N2vLyKUKzzdt1w5/CkCliTZHIpobXovn
	P/gMcF2enhZNGxvjfrvFu8zEnwgw6ksjxGBZzSghLbBXdxMvalFxYnVwepVM0cMMa5ZRtHiRErV
	6n3Qw/vKPu6YZrrnEsVUt7ghHPVyTgQcWc7KdYI88FM4d5emrHW+QA4iOv0dntsK4oiDQ9/KHta
	Q38C8UBc28io2x1wzqsnzwl04vFchqf6/6Dpb8ciCGVPiliOdSj8X1ipAvPYgSvOqCxlaknTqBv
	rtHAMDxypSgf4+hgp8EH1oZAqZ3Us4X65fu1L8Lv7GSYcVodwu+7R95GrpD30gzg9qb0j5cUE9R
	WeCjYuOdNou/U=
X-Google-Smtp-Source: AGHT+IFaImgQ8mUsB8FX9vCVAZe8oyinyLF2HvL8aiazJQVjXwZSAkQ7Y1ZG0/etX5aTcNag1fMWgA==
X-Received: by 2002:a05:6512:3e0e:b0:595:840c:cdd0 with SMTP id 2adb3069b0e04-598faa14759mr5788325e87.2.1765995149770;
        Wed, 17 Dec 2025 10:12:29 -0800 (PST)
Received: from Ubuntu-2204-jammy-amd64-base.. ([2a01:4f9:6a:4e9f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5990da790efsm2591419e87.102.2025.12.17.10.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 10:12:29 -0800 (PST)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com
Cc: kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH net v4 1/4] vsock/virtio: fix potential underflow in virtio_transport_get_credit()
Date: Wed, 17 Dec 2025 19:12:03 +0100
Message-Id: <20251217181206.3681159-2-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217181206.3681159-1-mlbnkm1@gmail.com>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The credit calculation in virtio_transport_get_credit() uses unsigned
arithmetic:

  ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);

If the peer shrinks its advertised buffer (peer_buf_alloc) while bytes
are in flight, the subtraction can underflow and produce a large
positive value, potentially allowing more data to be queued than the
peer can handle.

Use s64 arithmetic for the subtraction and clamp negative results to
zero, matching the approach already used in virtio_transport_has_space().

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d5851e..d692b227912d 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -494,14 +494,25 @@ EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
 {
 	u32 ret;
+	u32 inflight;
+	s64 bytes;
 
 	if (!credit)
 		return 0;
 
 	spin_lock_bh(&vvs->tx_lock);
-	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
-	if (ret > credit)
-		ret = credit;
+
+	/*
+	 * Compute available space using s64 to avoid underflow if
+	 * peer_buf_alloc < inflight bytes (can happen if peer shrinks
+	 * its advertised buffer while data is in flight).
+	 */
+	inflight = vvs->tx_cnt - vvs->peer_fwd_cnt;
+	bytes = (s64)vvs->peer_buf_alloc - inflight;
+	if (bytes < 0)
+		bytes = 0;
+
+	ret = (bytes > credit) ? credit : (u32)bytes;
 	vvs->tx_cnt += ret;
 	vvs->bytes_unsent += ret;
 	spin_unlock_bh(&vvs->tx_lock);
-- 
2.34.1


