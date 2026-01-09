Return-Path: <netdev+bounces-248468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F89D08E19
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 12:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F735301266C
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 11:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76D33590DB;
	Fri,  9 Jan 2026 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/ZG7m4w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C0F358D15
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958142; cv=none; b=J7xoQ7sgyiTgCRvtS3mdf/+6GDq8zTFUq8CayvTpEOpx8axskjcs3vhqJMpnpzO88XG0eHxi/6HCi9Va732G/2Hwnm15i7ZCKBKL7xI43T3IkBwAyiTI9Lm+XtEMOcHNdg88VT/J3nxH1UA2kn36S4B8L2HoyNIrMBebzt0dLVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958142; c=relaxed/simple;
	bh=LSh5hLuiJCxDRwJ+BQ+Xc7tCZE16QA/b770rYhc+vp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REh1ARO4S8u9YywKRDxtPHUzbNu0rHyZhdc1XMp0EzlCyxlxDB53ZoLl7ZIN3PSfHGDz1GfuvUN+vrjk0pb/eeXqIT94fxPtybFmm32l1mnKiONYbW7La54qWMdN/8+CrP2lC4yh4Cni4U3rHYD5gVJoVVrzCYX4VJEW+ausThE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/ZG7m4w; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47aa03d3326so35198095e9.3
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 03:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767958136; x=1768562936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BopLoWIhKj7xpDJExutQghL/d96/x+rVfP3p1ohtywE=;
        b=b/ZG7m4wKVzkwXfuLm6QGnOAJp/HgaQTkKoDf4PPERpRrW/xfPh/U86HYEqTVWFaAG
         g2ZzP0xHeWS/pnMNnNON5RAq/fUxI0a+XKI8/U/MRV7sY/5X834K0gd3oCw3qkjULuVk
         zbg+ctPuua5VxpGTkqH/YoBA+YIjplcnWshRHz0iUllOQ/X9O5k22kzUU2zJQtShydIU
         mYFw3/HG9Rqu5xERUCHnvYY18SouLf5BPujcesnOYA8lX1gDF5I65J6qayMEbAQ0GvL1
         1zXiO/qOJFWNfcQS8VLSgL6nKXibWjKJq+OG6dGZBG2AfAP763X1NOgvjYBmNjMevPAR
         7Ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767958136; x=1768562936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BopLoWIhKj7xpDJExutQghL/d96/x+rVfP3p1ohtywE=;
        b=PxKZd2ftU3UbzlxtqBjM60fB5nkqwi7jQf5Aw7PGnuAeTarp2ZHZ/UjxOSGVuMwhf2
         CzhQ4UsLcXa5TA/TSFs8vDc8JHJGEMeJshGk1iMy4Jo+QjqLECkZgxcWb3uGeDswDyPP
         DdpZnvnd9KDKvK59x9lvLdU9iWlIsHJCJdn+g7orMPTkDCrY3bOssLb3Zrr4yctGC335
         Dj+u7HI27naAfFf8iLONobAavNhWVx9C2+b3jmYRgZ6Uh0u0KygNo+yBlpVzwggHCoTH
         ttGTSUtpz7RoYcdBvac+76HMHTfBquFWhY1d85kbFDpLV7PgA/oJfM9bBHPWG0+sogEO
         NzNA==
X-Gm-Message-State: AOJu0YwNhmtvPF/8kSBZ1w0YwRV7It1JTNwi2jJwtADxKrOvwhhftdaX
	gd3Mlyw2VZOKXWEgVQ6eaefhS87KRg99yvvFKo9mOO2VVkflHib8mQWo27pl+Q==
X-Gm-Gg: AY/fxX5x8qJNJGe/EKZtcetjEjgoOWZkUf2DvO05RNiokB3WC5EuO3L5YEa0v/f6uYq
	H5VT9Z19N2S2fRPQIBou/DWALB3MgXS3mqg5hs1xVYXW5JRWu2vP6m9iTqYQGcj+hzn0izoVFh7
	IK04/seHKQKCYXHaw9KSJSS7z5c4ZkDhmaYZlc/GrpPgBcLhYaJYNBgdyExbKHKYS72wI2wJHGU
	JfOE25CiqHF8Lmjy7Z3trgogmarNwIphMA6FX4+BohTQRng6N0sw1LTJ/exyYobFswrIwmVO+oP
	AmfwdHXCWXr7iaW6FtMpLWIHJJrBEGKjNVZ6aYDZl5okwNWPVukweN7G7nhYmk7802sGdWJenOl
	MpmVyeCVYQTWlC5yvyaMOi2wLn+rIWu5/h98rFh60Y9/cG1qgvjIRK9V6re5jn4cZp/3gsVCzvp
	HSoXPyDOOnmDTZNZz9HtWxLXJnvJbjPsmL3WQdUOTZN52rzFfvZPUAwj+eA/UYEVGeLCU2tA==
X-Google-Smtp-Source: AGHT+IEDJTcPs3tUFs8ntvCdNub/oE0byZocsnwzSH3zb12a+mdPTDeqfaJ1kCUtNpxFLR0tZ3foXw==
X-Received: by 2002:a05:600c:620c:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-47d84b3be47mr99997755e9.32.1767958135835;
        Fri, 09 Jan 2026 03:28:55 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:69b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8636c610sm60056985e9.0.2026.01.09.03.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 03:28:55 -0800 (PST)
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
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Tim Hostetler <thostet@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	John Fraker <jfraker@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Joe Damato <joe@dama.to>,
	Mina Almasry <almasrymina@google.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Yue Haibing <yuehaibing@huawei.com>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dtatulea@nvidia.com,
	io-uring@vger.kernel.org
Subject: [PATCH net-next v8 1/9] net: memzero mp params when closing a queue
Date: Fri,  9 Jan 2026 11:28:40 +0000
Message-ID: <1414450be1abf13a812cbcfc3747beb6b6f767a4.1767819709.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767819709.git.asml.silence@gmail.com>
References: <cover.1767819709.git.asml.silence@gmail.com>
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


