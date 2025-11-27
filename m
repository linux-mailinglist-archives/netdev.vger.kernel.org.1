Return-Path: <netdev+bounces-242400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B70A9C9024F
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 21:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93FA34E31F7
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 20:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53398319847;
	Thu, 27 Nov 2025 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4Vq6lT8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474F8314B65
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764276276; cv=none; b=F3DiG4XFK1lieP420HUZ/8dJFrCTKirZgJOKh5DZ5DIH/U4X7HKcz7ggCGKKGgV5vYXpwAJnW3ZA40HsDT/crHxjkRQa1MxMMtywiPEl2vrGN9UvOgnsP1ueQJBNhDs0i43HBNgM6+UpPIeHdyz57qKup2PKKV3EBAKoTJGPekM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764276276; c=relaxed/simple;
	bh=LSh5hLuiJCxDRwJ+BQ+Xc7tCZE16QA/b770rYhc+vp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5icvYql3utZiUH1g5wt9IQm+ErBrVPzzvY9Csxyd6VxeJMctNv48/HYA0KpIhEPxy6dp0W7j8Ze77ufMvM/25xh4nJp8WBF/gp3XGERD4qoRcvSbyE2OlPGJM2XCpdYUUcxBlVEaJteJ6jioQY/cRTegk1u/OMR4Edtd1w8P/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4Vq6lT8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4775ae77516so11988345e9.1
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764276272; x=1764881072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BopLoWIhKj7xpDJExutQghL/d96/x+rVfP3p1ohtywE=;
        b=h4Vq6lT8dw57ZZH9qYwYgKj40DBAQA5xlFNwfRYEnrpMIrT0ISZ16ioVBQSBDlNS5s
         OKr7CBmJc7rpRztUcdIkdL20sYQCEqxfKNw9S2pTWdajS5IV8p+8OjSZ8vj4uLU0N8fc
         BUB0mMsV84s6iwxryLWxQUiMKv1OHPAmWpc5cbJCvnslwq/szwv6Gw/5Cv9PyXQe0ZS9
         opRJkfbKBH0wdTl1SrYT5U33BidBSxKRl+rXISl9ELU6C/NDEj3X7MYJdMAQgB8NLQOm
         mgAt2pktouiiow4hpjQgQZ+orqEmk9O0VTQbD04Yz5QaSYRPoBsLTLImjlrBB6FLho3i
         AMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764276272; x=1764881072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BopLoWIhKj7xpDJExutQghL/d96/x+rVfP3p1ohtywE=;
        b=eNMIsY40ax6/KBOaWlzuj4niU8fiOZYdvamAL28qHQfnu7rU+CUOOW5DvioxXvK9tX
         97Nb+3pKlNM50LWPUYgbhFfyMV9qKL63+o9MD2s5A1hY9MQAYqw0rYHho4l4qq69cYjr
         e7DuXiGH37drMwzrC4A9iQS3+XDDCarC6JuMZP1MnrVY8Y0zEdd80gsZP+Sea/10V6+P
         Mbgte8BI/NzB1E7tBD12RbOCCBAq9QcLB5UtEz9rTKsHX2JO1dIZdUjeODH6kJQM5goQ
         jZOnFpkSyoTBfl1JYHsTQlrL/JJDMaj3B4eAWd/WHmPfF/+Yg6j1nU0msw5ud82NZFZa
         03vw==
X-Gm-Message-State: AOJu0YxzOg4CF8D8nYcpohNO1NV13/x4GDFpOzwlpza5QQRZX7Q4fIMe
	0R/22o4+NblWO1FyiGy7MJJbCVkwIyNb2r0tfFioCPam2jeVdIews2jo2AcFIg==
X-Gm-Gg: ASbGncsWvh8JWdBeZdlqErJOeIwEaeQAe3cR8HgIM+YUEGYV4EoiP6HGDMF/oes+MWr
	1rIYcHzGxZ3lkJ0MZ1aqzHmyIaGNH8VLajnQ8/kjcHQv5wirs7+6k8AiIVpi+X7ilC1JbBWXSWz
	FmARNqNR9azNAWFLGfJqI8d+otvf5DjzEhSW3qXvQU9kADutygy3oiEGgLaZlA4WzBa6zYbic1z
	NdB8e2YCVsR0LnXNyot0RdahbcgFe1cg70LGBa71UdqJtwYQQ/ksb30FHSjzw2oAhXg92WcnVWx
	NNDlI9LzmJG1iTg3Eiai+f8IBDPVtShkjkrKhEI+t5I21BoWdaZNyfBaXwf2WoMT8jUM3zry6iN
	5pzIoRz2/Phe+BzKHGP/wMHOyrfrgpq1OJuJzgF23+RsRCI8FNBEUCj0Ncs11Wmb8SFwiq39F0P
	xaBDffiLybIRBVfw==
X-Google-Smtp-Source: AGHT+IFwRmakImgODlTFBacPBXxUnLB6FVPSTpr1ZGMe5y5759YvSUHXOymgL600ltx5XYutVYMrKw==
X-Received: by 2002:a05:6000:40c9:b0:429:b5a8:5c65 with SMTP id ffacd0b85a97d-42cc1d2d5d1mr27183858f8f.30.1764276271798;
        Thu, 27 Nov 2025 12:44:31 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d614asm5346105f8f.12.2025.11.27.12.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 12:44:31 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	io-uring@vger.kernel.org,
	dtatulea@nvidia.com
Subject: [PATCH net-next v6 2/8] net: memzero mp params when closing a queue
Date: Thu, 27 Nov 2025 20:44:15 +0000
Message-ID: <cea893ad1560a47f6a1c6c8fbfe1a308613d11cd.1764264798.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764264798.git.asml.silence@gmail.com>
References: <cover.1764264798.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of resetting memory provider parameters one by one in
__net_mp_{open,close}_rxq, memzero the entire structure. It'll be used
to extend the structure.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/netdev_rx_queue.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index c7d9341b7630..a0083f176a9c 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -139,10 +139,9 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 
 	rxq->mp_params = *p;
 	ret = netdev_rx_queue_restart(dev, rxq_idx);
-	if (ret) {
-		rxq->mp_params.mp_ops = NULL;
-		rxq->mp_params.mp_priv = NULL;
-	}
+	if (ret)
+		memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
+
 	return ret;
 }
 
@@ -179,8 +178,7 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 			 rxq->mp_params.mp_priv != old_p->mp_priv))
 		return;
 
-	rxq->mp_params.mp_ops = NULL;
-	rxq->mp_params.mp_priv = NULL;
+	memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
 	err = netdev_rx_queue_restart(dev, ifq_idx);
 	WARN_ON(err && err != -ENETDOWN);
 }
-- 
2.52.0


