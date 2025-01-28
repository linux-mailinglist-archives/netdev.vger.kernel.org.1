Return-Path: <netdev+bounces-161397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D95E7A20EF6
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 17:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C22167930
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6931B041A;
	Tue, 28 Jan 2025 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1TAWdvZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7B31ACECE;
	Tue, 28 Jan 2025 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082818; cv=none; b=HlSrwqWUME4JMYIp6UreWbTMYlRYHthZV59elWUg4XSy5aHVLd12j0H7ftScurI+QZYogg9N7G45mC0pii154v6A1aHYwEkZ+aIB10vPK04UZZ5+afKfIPff5ze18aLjlu0dDFXAaKd8qCDeIImddUqvouasspXPG1W2q4+rRqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082818; c=relaxed/simple;
	bh=fY1Ht0lNOAKw8K5OedtmKPz5PbDJBPdWABo+iz3tz/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWWutrQjhP1KzMMV4Ck7KXzL8my11Jh/Ut4oljUSZlDKJsFy7Ms+d1g4R+n7i3Eix/OFNb5LXgGB4tqjRr8WpBGnxmUBMFCNeZQxQPO/7ik68nsbmh3Diqgli94/ppTh6M5G02kA8y6he2gleHKTQ1qkWtqQutrIo+xCe7l+6BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1TAWdvZ; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so8106006276.0;
        Tue, 28 Jan 2025 08:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738082815; x=1738687615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izBUo6HsqfmU6F4r4wLj8SjU7ULP/X7gCkrYK1n4Pjw=;
        b=X1TAWdvZvEmSq8O+R8nGaOHzciU2ZHi2ckJnhAw0L50ukgebW3HesnyJ8xk33mZYip
         apOchJFozQNJpf1DDYGR2Gb5Kp4tFiV4jkI2lbhZn3ElIkNv2V/yafMiMkEmXbzOaJWL
         gNlq6zChGxvxisU3SRKQ1jgNleJF9mwgUTT/A0fLYOL9ckh4f0RMXTGguX0fHr+cpTVq
         ReHbxWU9mFnReLQmHE2G4hrydFGrqm1u9wzvCG8odQiGBHodC3Ylt3TCxr3QmGjAgFi5
         FFSkMhXhmgzyd+7bfRQqFAxi4V1QHG2KiT46adsI3jziUZxHiDIxSDnD38sWn8kfZJDe
         h/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738082815; x=1738687615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izBUo6HsqfmU6F4r4wLj8SjU7ULP/X7gCkrYK1n4Pjw=;
        b=dTzCRmXC3lmwtT8G4+eNPZh+wPq0gZG2CJWuKTmAx0qUiVbeQG6iMX2cd8FIHkwXjg
         Ska+aeWWQFMHYDtpXmxNZIXZUUD24JrPr4D6uMh05H89362dMkHKFRWAj+iTrNja2vSS
         onFmxOVc/GuXJinKzJm6UPTbJ4LmxhHci1PQ21J8NRmCDG4Pxscs9YvNY6nOamFheBN2
         LBo8deR2cMsnaD8yAEZZ9O772E1DAQPYkEnmpV4blzQLVfUlPpy7Pa46limBS0Nnk2BN
         8iBlNtJTRvFJrSmg/S61nwhJhTytDIxVTY0povCkiYrW1q1AtLzmsS3p6eqWaW7lhfFt
         eXew==
X-Forwarded-Encrypted: i=1; AJvYcCVoUpg2MHFLHTkUAVaf05AfKfgwhCYpUma25XoG2Btq3zTYhZBA9NRI0jpzJhlOL5Ghtovebz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9q+RnwnfxEIxrN8jk6DgZHRqIdCzYB2C2/jXXfEUWeSxhLMui
	XOy/DHVlW9Z7hPzcEwNz/27tpCxcEqVtyry+9sKTF9Rr4WHtkbo4fPCSl4Ab
X-Gm-Gg: ASbGncsRVkmfJPy0ldxGq/BCxwQxBIOiUJr0qa4EA+kU6cZ7GH9icvZeQftzX/6a5Sh
	8PvjWZerdLckQuaFZ6GL/ZVWSll89R2rHgMiWV8iX+RV88loKgDz3F3Jy5qj0LPsOQJwobgKES+
	z3BvMQwHGYOJjibedw2mhPX3OsyeDiTPmqDZRr9BhAS2UorRzIvq64jbUgKbUwgOa8b4oSVvaKi
	g4E5wDgCK+8IDZRqqeT7wN6WSE6AyR/rCi/KVu/GIaxrBWCHcx3xjHVUuI1PI9XVWQH59YVUtxE
	1KklREPqJruTmHWpLHXwyQGo4ocyaFAKUk1vmVI335xxma0IR6Q=
X-Google-Smtp-Source: AGHT+IHc113oUWa4lQB5S7fsBtzpiuhJaSRgwEzNaVPqu/U+wdu2NqhKKZn6+Jf4YhXOVOV+JKbd/g==
X-Received: by 2002:a05:690c:9681:b0:6f5:393f:cf48 with SMTP id 00721157ae682-6f6eb684324mr340143727b3.21.1738082814734;
        Tue, 28 Jan 2025 08:46:54 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f757a00e4asm19752577b3.73.2025.01.28.08.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 08:46:54 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nick Child <nnac123@linux.ibm.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 02/13] virtio_net: simplify virtnet_set_affinity()
Date: Tue, 28 Jan 2025 11:46:31 -0500
Message-ID: <20250128164646.4009-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250128164646.4009-1-yury.norov@gmail.com>
References: <20250128164646.4009-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inner loop may be replaced with the dedicated for_each_online_cpu_wrap.
It helps to avoid setting the same bits in the @mask more than once, in
case of group_size is greater than number of online CPUs.

CC: Nick Child <nnac123@linux.ibm.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/virtio_net.c | 12 +++++++-----
 include/linux/cpumask.h  |  4 ++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7646ddd9bef7..9d7c37e968b5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3826,7 +3826,7 @@ static void virtnet_set_affinity(struct virtnet_info *vi)
 	cpumask_var_t mask;
 	int stragglers;
 	int group_size;
-	int i, j, cpu;
+	int i, start = 0, cpu;
 	int num_cpu;
 	int stride;
 
@@ -3840,16 +3840,18 @@ static void virtnet_set_affinity(struct virtnet_info *vi)
 	stragglers = num_cpu >= vi->curr_queue_pairs ?
 			num_cpu % vi->curr_queue_pairs :
 			0;
-	cpu = cpumask_first(cpu_online_mask);
 
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		group_size = stride + (i < stragglers ? 1 : 0);
 
-		for (j = 0; j < group_size; j++) {
+		for_each_online_cpu_wrap(cpu, start) {
+			if (!group_size--) {
+				start = cpu;
+				break;
+			}
 			cpumask_set_cpu(cpu, mask);
-			cpu = cpumask_next_wrap(cpu, cpu_online_mask,
-						nr_cpu_ids, false);
 		}
+
 		virtqueue_set_affinity(vi->rq[i].vq, mask);
 		virtqueue_set_affinity(vi->sq[i].vq, mask);
 		__netif_set_xps_queue(vi->dev, cpumask_bits(mask), i, XPS_CPUS);
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 5cf69a110c1c..30042351f15f 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1036,6 +1036,8 @@ extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
 
 #define for_each_possible_cpu_wrap(cpu, start)	\
 	for ((void)(start), (cpu) = 0; (cpu) < 1; (cpu)++)
+#define for_each_online_cpu_wrap(cpu, start)	\
+	for ((void)(start), (cpu) = 0; (cpu) < 1; (cpu)++)
 #else
 #define for_each_possible_cpu(cpu) for_each_cpu((cpu), cpu_possible_mask)
 #define for_each_online_cpu(cpu)   for_each_cpu((cpu), cpu_online_mask)
@@ -1044,6 +1046,8 @@ extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
 
 #define for_each_possible_cpu_wrap(cpu, start)	\
 	for_each_cpu_wrap((cpu), cpu_possible_mask, (start))
+#define for_each_online_cpu_wrap(cpu, start)	\
+	for_each_cpu_wrap((cpu), cpu_online_mask, (start))
 #endif
 
 /* Wrappers for arch boot code to manipulate normally-constant masks */
-- 
2.43.0


