Return-Path: <netdev+bounces-118836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89098952E85
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9D71F237E2
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1911ABEA7;
	Thu, 15 Aug 2024 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+sXrDAV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594101ABEDC;
	Thu, 15 Aug 2024 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725988; cv=none; b=Wjgyw8m/EwsFzzxrKIb8KMk/3P/PAKQ9X2hRJ14vp4UONQjB4C7yhkBu8O6umbghgtBvE9YoR4SJXyWcrh+RY86uJ7xFrDTL9DNsJMrhkKpyDg/fIluqOefbz8T2Vy98QG2a2dKoZVIw8/mLyMc8flMELcbuoTu5MP05KxH2opc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725988; c=relaxed/simple;
	bh=apx84xl4/3+KifGzwzFZZG6iLBWLTuAtEndWD7esMFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W6VWIj3H8PMRIw6vt6D0qayy1P1sB0gJ7Z8LDGLYnDwNFr3hBtrwXTJmFFEQe83lPqX3afES+4UmGIFwmt4WEaE4+Zw7QdchFInCacldwqFHgjhIT+MhnuIj0jphWtl7Z1zhEIGIDd9VjCCuYA1g2byyKa+wurIknsTEPAhDX4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+sXrDAV; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7163489149eso717759a12.1;
        Thu, 15 Aug 2024 05:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723725986; x=1724330786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQpzojWjKJEQFjwLDMnb7FOqAkEetAGb87y57DtpsyU=;
        b=a+sXrDAVTg6O/mJ82NlHK11ie+jmbDef0ZQQ8ZlLCiPQAvKC/M8qpa9gqKrKODtPoT
         y45psOuqA4DI0vhaZrFJ+8T1M2xgQTZxX5q0vCjVh5r0m+MWfaOvs/00qMjIw+Fku/xz
         4VrqWgDIOMvMwoKvwaAd3UUu/5aNuZtU/yw/AUW4k6cpTVh6idG2fdU/w/Wt9xk0J8t1
         OCyYxywTdsBPbbxv4ojC8q2hEClITvXRxNNriHDAIV5uuPQLVPLefDVE8uh8VfuxaHKQ
         QxMrT+JG7xV4biqOaSmmxt1Vi34gegHGApJwYiM9WGPufFquhmdz73NvJnPwzL5feqxu
         p3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723725986; x=1724330786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQpzojWjKJEQFjwLDMnb7FOqAkEetAGb87y57DtpsyU=;
        b=K9R6JmIIGdmEQk9+kpSohxRoJlj+YiW4QJFssSEokeMMAYC0XA45oLDQk2nEIDRIPg
         3Y1tPWM9bfhwJHgElyFuehcasJk2M6kE/8pSzTgXTQI51LQzX0FGQ8a7imCgdIiaA1at
         uQ6si7ihtKmuZl8LyRk+nHAOhQLY2S33KHM7A67FUdB04UNBZ+KR/DK0fSzufRZirqpa
         HTNMlh1BznTfhe+vmfRImq8ne8Pwx062s05G7MtKNmMsy6R4dqH+fdpIB/9r5RirdFwQ
         I2xLLKD1sqI2+iRCiv2/gQey1pvvZIcY4vhtuy9l+cFYq+0h3kCSpFnnhHif8FLW9+pi
         XTFg==
X-Forwarded-Encrypted: i=1; AJvYcCW55lNKbKEGLDX3x9UX1BZqtzoWtAFeDvltBuHNB9MZUsra4iQ9W+S6LE3n50gvUe5V9pISQhLzGXXn3zlvcANRXugn74vu2mSEveebGpzgRtLOhx0tKYIHOlUS+LPdmP9w2fdJ
X-Gm-Message-State: AOJu0YzOAoIrz5TVtQHkSDwkRJk9dQRm0JkRfdW9PmyM4XQqO8gjmsKv
	2tUShxAAk4Oa6aBdE4KDkvBdeY6XAnHcV1ohPOJaxF003rgo8bfNL7wq9QKK
X-Google-Smtp-Source: AGHT+IGBfBjK+pv5E9XrEQyGMsWZeB2VO5qfAApVeAJWiNlOX+1Bq0JOqOOLa5naW35ArBLz/1BipA==
X-Received: by 2002:a05:6a20:d50c:b0:1c3:b61c:57cb with SMTP id adf61e73a8af0-1c8eb049b00mr7080122637.53.1723725986537;
        Thu, 15 Aug 2024 05:46:26 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af2b942sm923605b3a.183.2024.08.15.05.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:46:26 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	idosch@nvidia.com,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 09/10] net: vxlan: use kfree_skb_reason in vxlan_encap_bypass
Date: Thu, 15 Aug 2024 20:43:01 +0800
Message-Id: <20240815124302.982711-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815124302.982711-1-dongml2@chinatelecom.cn>
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree_skb with kfree_skb_reason in vxlan_encap_bypass, and no new
skb drop reason is added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index c1bae120727f..885aa956b5c2 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2289,7 +2289,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	rcu_read_lock();
 	dev = skb->dev;
 	if (unlikely(!(dev->flags & IFF_UP))) {
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
 		goto drop;
 	}
 
-- 
2.39.2


