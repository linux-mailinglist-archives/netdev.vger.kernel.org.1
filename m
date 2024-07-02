Return-Path: <netdev+bounces-108511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C84B9240BD
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5641F24334
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77A31BA898;
	Tue,  2 Jul 2024 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsAz2sqB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8B11BA08F;
	Tue,  2 Jul 2024 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930358; cv=none; b=M8qz+FO52R3bZJeqvMD8wiIn1BIO9tS87LLiHF5qgn2QLw1attGPCDG9zz1397bmH2Y5nl6KbvfRvGYmqyNkyfzMKX5XXwr8uYhA2owVOonu7lasXaIEUZzFbEbGzPMeSFmI58pwGdOKg5MmbTROcZtDFPe+7E6cBVeRzLpL+Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930358; c=relaxed/simple;
	bh=MLZYFlsiS+kvju+BKYFcbKtNPb5CtXQPEdFDRDJl6zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PePTw1txkRiF4rtqitpc7dRICfdi7d37pjutPOUx7aA7WINfokIgjMX3rCsh31lW/frl0UCnV+n2Ki9YM46SyTw6eaVl4eLzJTfESQJNPZS4kq+AFzsCY580UDt1f26QRpmhrACWEwqI8wgF38uCx02tMoUwmiMjGCjWch1/New=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsAz2sqB; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-42563a9fa58so30231955e9.0;
        Tue, 02 Jul 2024 07:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719930356; x=1720535156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2+SoMSqztWhKLaH4TpbgJXuTayM16wclZV4EEtmxt8=;
        b=PsAz2sqBbdofxEyBgnJqeUuFK6YIKQ1aggQ6Ay3VMPXx3SKXZUXzDJG6KnMqo6ezxq
         ZQsVPOHHTFXDX7XgQJgdbzIDY0aB/9+ECZJQ21lvAhmk30pLKk/19OiNAvXqscwjLjGu
         Le8Pvg74xcpLeFth+SUCtr7KmPk8g2ilzVjiZe6I6/TmwVupXtBpGZ0zscsgR1jDvwRT
         BTwsHbeBbaH0cd0STfN2ZRX5LW6WkxlI0vi4w6wAs2WWXO5+OJD3SeLs8TqmSDKy5QVK
         nQcpGltHWc5o2Z4xG/cCyeYRXN9DMbz/j7IywM6FioB4PVSoBTzypXzanXCUp0uL2PcN
         e35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719930356; x=1720535156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2+SoMSqztWhKLaH4TpbgJXuTayM16wclZV4EEtmxt8=;
        b=LLO4421gJPLIdoKzKANOtboujHUoZPrYZ6cExYUSJgfuEItMdb98dRqKttJUgT3qPq
         VkXcPetErZ5+YFw9hzb1f2yoLY4Z271vfIjGhJRk2zWzqIxti8MTSDfBDGePhKyalgQf
         VWEuEeGp1axO+f7aDRXBEAnVUK/LekCQGXCKFK8WiW7WDJuP1SU1KFy036JzFBPZq0ks
         859xqLnQHrDhtYSXkqQkCpoFYsQWnByxFhIa08UEWuF0HwwNKSm27acy9He97FTp3iCi
         bsx6t2SgjqeSVTRwm53rs5wSRhiyWOXjZ9o5b/jeM1aZLwbyRade1Ntn6VT5p5mvDCUx
         rJNg==
X-Forwarded-Encrypted: i=1; AJvYcCWEsiCO7UkpHVCn8Ahi8BUUW5lnzir/S+RB73/7hSAQoiN3WU0NporgCbXS9zl4QZSc8JxaGUhYCpwyQfO5T8VkSf7sbrqWR2pkxNvk2wGIocK1Mq5S7zy3/xz55LGSmq72tFIZ
X-Gm-Message-State: AOJu0YxSGTXWkGkLr6ZyJWwHOLWek7QdflBjrJxVXQFOH/Ogc0M9VZdR
	XJX++XhJvhsYTq8L/b6nYchkabf6AKRXhWPJLVB3ZrUEUOAzPEv1
X-Google-Smtp-Source: AGHT+IH2gOpUBvCZ1EPNqzsj68Kd1RGqjiqeAZ/PKSIFasj9ODV1XpxTM/B3jZe0a8FBtmiOeFm1JA==
X-Received: by 2002:a05:600c:3515:b0:425:6f85:6013 with SMTP id 5b1f17b1804b1-4257a00aaaemr55217245e9.8.1719930355476;
        Tue, 02 Jul 2024 07:25:55 -0700 (PDT)
Received: from localhost ([45.130.85.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fba16sm13465151f8f.79.2024.07.02.07.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:25:55 -0700 (PDT)
From: Leone Fernando <leone4fernando@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leone Fernando <leone4fernando@gmail.com>
Subject: [PATCH net-next v2 1/4] net: route: expire rt if the dst it holds is expired
Date: Tue,  2 Jul 2024 16:24:03 +0200
Message-Id: <20240702142406.465415-2-leone4fernando@gmail.com>
In-Reply-To: <20240702142406.465415-1-leone4fernando@gmail.com>
References: <20240702142406.465415-1-leone4fernando@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function rt_is_expired is used to verify that a cached dst is valid.
Currently, this function ignores the rt.dst->expires value.

Add a check to rt_is_expired that validates that the dst is not expired.

Signed-off-by: Leone Fernando <leone4fernando@gmail.com>
---
 net/ipv4/route.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 54512acbead7..fd0883da7834 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -390,7 +390,8 @@ static inline int ip_rt_proc_init(void)
 
 static inline bool rt_is_expired(const struct rtable *rth)
 {
-	return rth->rt_genid != rt_genid_ipv4(dev_net(rth->dst.dev));
+	return rth->rt_genid != rt_genid_ipv4(dev_net(rth->dst.dev)) ||
+	       (rth->dst.expires && time_after(jiffies, rth->dst.expires));
 }
 
 void rt_cache_flush(struct net *net)
-- 
2.34.1


