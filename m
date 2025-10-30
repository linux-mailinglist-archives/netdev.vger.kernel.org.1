Return-Path: <netdev+bounces-234208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5469BC1DDAD
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8AF3A99E8
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC17933987;
	Thu, 30 Oct 2025 00:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJwUmwK7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAD9537E9
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782821; cv=none; b=ssGK6m74QyiEY6fZCCEUFWzip1ib069RlwqVBmcdYBy10IRxsVUKtlZDr197AB2Fee+QJDyiMHmCT0APtgtp5JhaJGUBrT0Zfyzc0e/9LxHRZB62lYVQmlK1yOSZ+D18lLKv1xOYTp2pUHhH+xeI7Tyu7Uaae5MWFsEYTVQA5Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782821; c=relaxed/simple;
	bh=AYPjqNcwVUU3ApBqlupS9wezW4XvBqnQkHDFkW4K42c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mo88KvQUnzHNUmGVdj7zFs+Y17iOQcxYgdAmgmwGH5ewab6LrQaVPm4ST41yoIoIO044I1WAEi2kQm513k6b0ijtg3fdR8xrNwNxTxHdsKUCIFEyqMDQ+ZF/PJDVoN7uIi6fF6RLc9eJ/mHxLJVUQa7Qo2G3d1mQIno5tevQm2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJwUmwK7; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b67684e2904so241511a12.2
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 17:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761782819; x=1762387619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ihZUDqcy6spGWNnOmC2eoR8HcqnGXih2DjGhY/ZWgM=;
        b=nJwUmwK7d2umQcjr7AGsjZgSdm0ovSEPiH2V+7JfmMp1jugMbzwXDfMuusc362kg7v
         YHeoF4sliumqUET25RasvkyCrtiRAqsQaxDIHDyPOYnumtkDAAWYhMXFpHJlG89qOGfX
         jkt8JRGV1RHy6m0EsXC6KIt9fE1lpopvfkGkSbJT8wyyWP9FWBPsRwbk0wQGASudULhb
         Hg4QEdJqJ5/Nh4wgeev0NWg7NlqHiZwqvr0ZAnVPnnbcUjx4cMusPEbMsPqGZaJBzsKh
         oaqiSrf5FMIcxDVtZqEwSDythqNuKqntgQmdmWJxw42gUmyxFtCN/0ygfRAAr64zylAJ
         0bDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761782819; x=1762387619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ihZUDqcy6spGWNnOmC2eoR8HcqnGXih2DjGhY/ZWgM=;
        b=Htu+8na9qkUteMSn7pCEjQ2O0wb9OUeD8bbBpUlg9JNKxTg2qD+lzqFFKjt7SkKOAW
         7YIcFUIj5F8l44DfPoUsr89GNvLmpMaLsPstk3JdJeOffTh/72vqWyosjrorkcVM9D4L
         PWY39BbVK+QU3yaO3h5MeVSQt++E65zhKIIHPOv3xQQzHwvJzhxP2cMtD66SEMaGA079
         1mHXf/7qQ6v7oJO9gGyjwcWZB1B81v8mR0vC+wDZczkVRBLqXymCoHZWllrdPtyZaMOm
         bPtvaAYwcQSk+3OPwcsuY0ruQz/6eEHJZH7aicJA6ARXMN5ruOKkPhnwjVPWya4jPVDL
         OujA==
X-Forwarded-Encrypted: i=1; AJvYcCXe/P5ICEOUY37wxVYZq+4qo9yJLd7T0wAqwPEvpXmlZY6Dnya3eQRmVzP7X16RS2Gw1CjaRjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz1YxSObxnZ8+mJKhh5R9/DGW0Vxar3Eo2IllCb6j8fAg6XtK2
	hRE7DNgT0XpEpVgwpU+4GhTqpaTbJhpTPB6Xxl9/AK4HtrPwapAoCEmS
X-Gm-Gg: ASbGncsrIxNs7N/4fFCJFq/seujLxAxQgJlBUUNrF3THbJOqJrUCYqxTKzd3FklCag/
	CNF6tgpPAIckf2JrkF2/yTG2R0+9ICwk6WVMmbf+hjq+ZdH9RXvpWh+phJfc/IdpGADxd2Hlouf
	gmSCpulyCOoTFBUF7x8kDAe44Np+NYETOKI/VhGVfz/scp2BvMBa4kd9GPOrgsbZDm73779fF2S
	+VJPZs9INwabqd7+gu4kzb3ilkhDvXmYyYXo2mPt+5zxWIiwhwHVK2FYgjsvfdfRMGoWTVymypj
	wb5lHoRzjxye/EEP/yk912J3Qv0iv2qjybIPOHpC5phMqspWRtlAU1dea2CRImPTqIYF7r6QuSA
	MszcKyU0mpyDihkObvW9ainON/q5u78TG6Qo7eDmR2TQi2me2peR/rul5M8nBd/60l07Ctq++vn
	MLBx9p6drU159ChOhvm7RKh1roPlKYychhCNEuRg==
X-Google-Smtp-Source: AGHT+IHfzO51jU4FTr+0/WJvTJ8uZSRuqnOOvC0JMH8kyyo2rr+JY4nR0a1e58DqwIJXv6nb9orgVw==
X-Received: by 2002:a17:903:ac6:b0:290:b53b:745b with SMTP id d9443c01a7336-294deedabdfmr58912405ad.39.1761782818969;
        Wed, 29 Oct 2025 17:06:58 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4117esm162900155ad.93.2025.10.29.17.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:06:58 -0700 (PDT)
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
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 1/2] xsk: do not enable/disable irq when grabbing/releasing xsk_tx_list_lock
Date: Thu, 30 Oct 2025 08:06:45 +0800
Message-Id: <20251030000646.18859-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251030000646.18859-1-kerneljasonxing@gmail.com>
References: <20251030000646.18859-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The commit ac98d8aab61b ("xsk: wire upp Tx zero-copy functions")
originally introducing this lock put the deletion process in the
sk_destruct which can run in irq context obviously, so the
xxx_irqsave()/xxx_irqrestore() pair was used. But later another
commit 541d7fdd7694 ("xsk: proper AF_XDP socket teardown ordering")
moved the deletion into xsk_release() that only happens in process
context. It means that since this commit, it doesn't necessarily
need that pair.

Now, there are two places that use this xsk_tx_list_lock and only
run in the process context. So avoid manipulating the irq then.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk_buff_pool.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index aa9788f20d0d..309075050b2a 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -12,26 +12,22 @@
 
 void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs)
 {
-	unsigned long flags;
-
 	if (!xs->tx)
 		return;
 
-	spin_lock_irqsave(&pool->xsk_tx_list_lock, flags);
+	spin_lock(&pool->xsk_tx_list_lock);
 	list_add_rcu(&xs->tx_list, &pool->xsk_tx_list);
-	spin_unlock_irqrestore(&pool->xsk_tx_list_lock, flags);
+	spin_unlock(&pool->xsk_tx_list_lock);
 }
 
 void xp_del_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs)
 {
-	unsigned long flags;
-
 	if (!xs->tx)
 		return;
 
-	spin_lock_irqsave(&pool->xsk_tx_list_lock, flags);
+	spin_lock(&pool->xsk_tx_list_lock);
 	list_del_rcu(&xs->tx_list);
-	spin_unlock_irqrestore(&pool->xsk_tx_list_lock, flags);
+	spin_unlock(&pool->xsk_tx_list_lock);
 }
 
 void xp_destroy(struct xsk_buff_pool *pool)
-- 
2.41.3


