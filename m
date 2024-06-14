Return-Path: <netdev+bounces-103735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370AC909405
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 00:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6E02B23866
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B821850BD;
	Fri, 14 Jun 2024 22:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esubgL+P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2877184134;
	Fri, 14 Jun 2024 22:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718402697; cv=none; b=IMrctt5NTXtd7/AY8qx0q8yFhCZa0X7FzsNOG+4zhcWpfi5zfnVci1OAU82iHuaBok+4MsxrKMawX6nbjXthXTAOSgXQzPT5i2Bm5zk9UGxNgjxmhFupj1QiADqtRt/3gvpak3rn7YPwHp4/4OjftOelKC3eDt6hW3153nzYGns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718402697; c=relaxed/simple;
	bh=n/dIbEBzku354LPAwJ5AA17Jtd1gqtcu4Ldd7iIeX6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CkpJhf0lLuBIGvmG++hSHmDZ8Q3SCGuPSOoRNW3WZcW6XUn0ltKZ1qlNtW36YBylcNb4nFfQsV+b0X2JjrstIZcnHAVt9kEUthzo1nZGhAAMvDp9+ropMzkCELCHjJ+DtiruoWYGvi/bRBW7Fm8L0ir9NvIeKKlKff2Ujb6POCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esubgL+P; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f717608231so20479855ad.2;
        Fri, 14 Jun 2024 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718402695; x=1719007495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3GvcueyQPUEu25Z3M+kcx0gqsGUqckbLKTeC7p2z6FQ=;
        b=esubgL+PWuEpJM9iOcUx1C2/51xpDwG/LETchk1NtGrtLBfscIHUP/qhD0p5JCkW73
         +VszzPC7PAYYPekcrAObhlMPPBFiZEDfO48BgKdvqEry8hCCBJ54dnufR7AToET3DFO0
         Dz/MpUIhCYbDhZ15JxR0QA33atxyRRlXCTHcfVl8NEK+iN/trKdeqykEWz6x8hbdnG3P
         xVvZ46PDcy1zSNw+v/s76P2HAoXVcrc9eTu1XgW2IPlXchdh4Z3AJSpu+DoyJgJwuu+Y
         s2i5Gx9aZRrjnW+dJ4I9MkMORoT8k2XJA6vQzeMURryfacAjO4/6B0oTbqM43E55PLuL
         YOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718402695; x=1719007495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GvcueyQPUEu25Z3M+kcx0gqsGUqckbLKTeC7p2z6FQ=;
        b=FPq1qXmz/bKEyDtaSPVvfhtj58uRWnYim8IvX81Gl3nISTaUHSnIu75i8fCsxcs4W9
         A4hdahVuhGy+W4NwyXXtFVh1gSGLDkSkvVtxk9JJWYOciaTnQk3ynxXSv7TMelljxe1W
         +1HWgv/L7npneonhZO4xFvxy1Z4O+QbUq8GyQEIoVPpCfWCJ81QGXsnI3FSqsXG7An4b
         uf/pX6DBI84Pddy92C/jqqbBq5+VZ3rE5w0sqm4nnRdIry5VIiIC4zjrdv+kOaqnChk9
         SGqhOd3TFqj1jxpmMtTSFp4+mbzgxCwKDV3PJnQ46yTVm3IXgrBpV8pkCG5NK/V6us0i
         lAMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJw0DuiE61EfbLFH440B6ZuzdqarXZH0Jsjo+U3NE42A3ArXVk9ovnMYm0m3jd9DyvNBzxCqcL4GO0er7RJEOcwv4r5rK8lWBp/w3FXHEvuvm0BCJzJrqlp92HBFTtQuXJwoNT
X-Gm-Message-State: AOJu0YyonlD+rFQDBVyfmzissrdiF0HKlZsy3vml7pVGZIOTelm/r+3A
	LB2YqR1G0jIAxVoCoXkX1Xj0ApdigSixMEJ8t5zbLcctYeus4Swq
X-Google-Smtp-Source: AGHT+IFqvmnvREoZpL4HIEpMIZNae92JdUxNXwL23tevbC6InKHNUqYV0Ja7ifE4kxB84ngtUtcjvQ==
X-Received: by 2002:a17:903:234b:b0:1f2:fb02:3dfd with SMTP id d9443c01a7336-1f8625c0deamr45197675ad.11.1718402694709;
        Fri, 14 Jun 2024 15:04:54 -0700 (PDT)
Received: from dev0.. ([49.43.162.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e7ca78sm37008375ad.106.2024.06.14.15.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 15:04:54 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	jain.abhinav177@gmail.com
Subject: [PATCH] virtio_net: Eliminate OOO packets during switching
Date: Fri, 14 Jun 2024 22:04:22 +0000
Message-Id: <20240614220422.42733-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable the network device & turn off carrier before modifying the
number of queue pairs.
Process all the in-flight packets and then turn on carrier, followed
by waking up all the queues on the network device.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 drivers/net/virtio_net.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 61a57d134544..d0a655a3b4c6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3447,7 +3447,6 @@ static void virtnet_get_drvinfo(struct net_device *dev,
 
 }
 
-/* TODO: Eliminate OOO packets during switching */
 static int virtnet_set_channels(struct net_device *dev,
 				struct ethtool_channels *channels)
 {
@@ -3471,6 +3470,15 @@ static int virtnet_set_channels(struct net_device *dev,
 	if (vi->rq[0].xdp_prog)
 		return -EINVAL;
 
+	/* Disable network device to prevent packet processing during
+	 * the switch.
+	 */
+	netif_tx_disable(dev);
+	netif_carrier_off(dev);
+
+	/* Make certain that all in-flight packets are processed. */
+	synchronize_net();
+
 	cpus_read_lock();
 	err = virtnet_set_queues(vi, queue_pairs);
 	if (err) {
@@ -3482,7 +3490,12 @@ static int virtnet_set_channels(struct net_device *dev,
 
 	netif_set_real_num_tx_queues(dev, queue_pairs);
 	netif_set_real_num_rx_queues(dev, queue_pairs);
- err:
+
+	/* Restart the network device */
+	netif_carrier_on(dev);
+	netif_tx_wake_all_queues(dev);
+
+err:
 	return err;
 }
 
-- 
2.34.1


