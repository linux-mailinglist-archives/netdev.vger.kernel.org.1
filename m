Return-Path: <netdev+bounces-154430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C27419FDBEB
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 19:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11003A1523
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EB41990D8;
	Sat, 28 Dec 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie3EDXK8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED75D198E80;
	Sat, 28 Dec 2024 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735411800; cv=none; b=ungicrXBIaCrBHkBPK5uPaApfudLpm0dURSQR6uqr9KiQBUlrhg7XFYVmqPct82OwP02xwOqs+Zr67OfavULvmg/xIRaNGk3aCwGmUGtAcoNFWkVIqEF7k89oN4BYDmxS13oTfQR41o48KzES4/U0vhXXHr9dxD+84ryaKa7gcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735411800; c=relaxed/simple;
	bh=rjLiHSvKUq/eF1loio7Yr9yGD09W83hpAJm71ZhEPPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adjKImLt9iZkFIEC7asea1zInp5AJTFzWyp+/wi1GYZ7MRzmNWreTZ5GBCC/psxEV/98r03ELCHt2ut1sVacV6142nxg5nAnZkMJdB16+rUiigR+M8Jz8q5QRqlTTJeeWhtUAXuD2MAhiVLqZqwOQOdVZIuAd0eFbfsZEFL/HYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ie3EDXK8; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e479e529ebcso8993600276.3;
        Sat, 28 Dec 2024 10:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735411798; x=1736016598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyD/SfnxslLrliyoyVIe5C8rt51G8jW8D1jt5/B6HkA=;
        b=Ie3EDXK8YB+0UqQFBuZBg36/iBJPsGE76Dk8BCK5qmiwpIWJ37JfKFOgie4mvkQMrZ
         5Fh9uW6GjDeHLa902qDMlm1qflbhGpcQshpBSdK/tEyUxzKPq3DuCS95BlB78MqmXYcy
         ZKw/Qw1ZR4nT/tj+EglcUAExuecgV4enDupqCrNr3bsqqZL8qE/nOK4zebGkgpLUVOEL
         QzHHrfyIJ/Jx8WoJ/CitKmHQU0Ehz1T2mG5UM3tXtI3YB8FNVUnxs5DYnmQgP+VHxXAJ
         KqGIU2/WcPXkiLCEZiUiE24PUDpQb3XayVbZLDBiFGIh6cRpXh4xBmnz+6sU3h7dZVGH
         +t9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735411798; x=1736016598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyD/SfnxslLrliyoyVIe5C8rt51G8jW8D1jt5/B6HkA=;
        b=tW24j5svFOOq7OCFvOGBW1K122raCaivuZlbSlP8gVIpgz3AyMSHH8OkTpg4iVRAXp
         6mGLM86Bllp+O2OIWWdHpX5DUbzNUX6Dk4lAMrVJ69/iYAUXbkq3VywN3lrNB09QSLzv
         qY42MmL2qT5ZPIXU5zqhiRansd8nbgLxbZDQOz6a5OSuXPpWSgQK6J/ZcnO66lCW+7jc
         35asGOyagfwgxED2DN3Go3QR/NvCP7tAD3GLSI1nvCB//SannJGoWwdrcJecwWdfhiJR
         tzyNyMh7QzVjfc8/zC7UWiyDCLRJaj5qphIggYyRRhXYYWgOYn0c8fL0BTADIVwomNlk
         eJ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFGJ7G+52QkbWjmebddEPQXNQsKB0/w1clOeervJeazOEeR8kvClQf7WVElD8d6kUckKifxE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUxlAq4UOGgtD0uq83GEA0X/CFgPniRAKWei1YETlEOMXs5zkD
	QcA7m/yi3gBspD/GB3sAA6TNmMIWsUyJJKax3FoEyeFh131m0PNokPyNDniQ
X-Gm-Gg: ASbGncv5oSutyQX3lWHmmjDTCTSB/6AJMYbs+HoNfAYKsy8U1xDHIl7VvxaVQVnIpRJ
	CVzYM7wOStsDpkF1iS0XaxuNbciBtI3CuTti3D8vI4mk0cZzIYpyH1IMDZ2oFmheQag3CohulxU
	gjNxhflmiTnMl3//Oukj+wjQZb1Z3erWyddve6eqzfN7Gbbdr1zhrLZY1M6uOSib1sIJZfLM0nR
	V4A9LEkjnB6suO6NGNWDh5brFafBf2vMtKNbzCw6Axdif6T/t0yYp4++mBU0s6qFNIUBTc48VAc
	Zgm54JJi1aCuqbbl
X-Google-Smtp-Source: AGHT+IGiqvJf1RliBJCBp61gtA5mmGJsJtIiqDmDHZDVegn/DpktFuOcGR3eHMQYzJgC1Tq1ntdg3A==
X-Received: by 2002:a05:690c:6c08:b0:6ef:4a57:fc7c with SMTP id 00721157ae682-6f3f8115430mr229828487b3.16.1735411797858;
        Sat, 28 Dec 2024 10:49:57 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e77ed1fdsm48567247b3.84.2024.12.28.10.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 10:49:57 -0800 (PST)
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
	Paolo Abeni <pabeni@redhat.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 02/14] virtio_net: simplify virtnet_set_affinity()
Date: Sat, 28 Dec 2024 10:49:34 -0800
Message-ID: <20241228184949.31582-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241228184949.31582-1-yury.norov@gmail.com>
References: <20241228184949.31582-1-yury.norov@gmail.com>
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

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/virtio_net.c | 12 +++++++-----
 include/linux/cpumask.h  |  4 ++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7646ddd9bef7..5e266486de1f 100644
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
+			if (!group_size--)
+				break;
 			cpumask_set_cpu(cpu, mask);
-			cpu = cpumask_next_wrap(cpu, cpu_online_mask,
-						nr_cpu_ids, false);
 		}
+
+		start = cpu < nr_cpu_ids ? cpu + 1 : start;
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


