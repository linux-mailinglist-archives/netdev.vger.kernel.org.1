Return-Path: <netdev+bounces-139445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F529B28D5
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 08:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B341F21F8D
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 07:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7187A1D934B;
	Mon, 28 Oct 2024 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9F/kH/S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671BE1D7E4A
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100643; cv=none; b=u+mJDMdOe5FHvyiiYCKPM/28Ygak1YRQFrpGU6ATSe7NTBf9cDyf0b53/gKayhEJ9Pje95IXgRQzM7DxvorAa6QVrFJL0pzWi9CJuNpUuB/DcdfYIq4Zykm0pXhtuQ0GVl8HdHEv6hYCaQC60tZpbsX/Aozmff6ZjACnqFZnu8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100643; c=relaxed/simple;
	bh=vgc1Ys9QkOqUWQKYHzFMYSA3Go6hm/nnPiQ2TU1a1TM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QGa8HUs8awUIFjDne3t2iCZMAPvR6JMGAyUZegpSnyMUbe359vvSLjWIn25utD4InmLz4JD5JwQOU/NxIwI6Y0pL99YKI/zZ7ggRXEulZWAw1E/66V5qTQs5IvhQ9xwqt9DSadVgAQYyTdKGZUtTuzlG8C+CQuU+QV1lY2aTLIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9F/kH/S; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b5affde14so27363445ad.3
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 00:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730100640; x=1730705440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vQpKY05JOYjPURTPx5+mIgiP69yD+/zLK9ykR+kpvfU=;
        b=c9F/kH/S7zVyP027ApRdKiIvuErkqAH0uS4f9YEdoPqxVd6BHVKKetFsVcIxx7emDF
         zL/Gn7PUt4A2ywAU4NshdlgUodReR1d1JHbCJ/752s87LO7nNx5IKq9ktqS3LuZKnBwr
         7VMYqBCtMmN4l19SM1U0+CZ7uyKc2ShX4mJxI3zc3GXqsQNlwq61hLG3IrSVEI/pz9jZ
         pYQ+ehQRu7/2ffPYYauddS/pdHOyZqedmEcVsxFRNFsMb1CnAL7gRQgMVScEw4TKlQ7B
         +gluJUH8JiA6aeNSB0hlE6VOl6WzXBRe5zu64FZ7k+fkh9b0DMQLK2UjHoOe1Y+iyeob
         M22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730100640; x=1730705440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQpKY05JOYjPURTPx5+mIgiP69yD+/zLK9ykR+kpvfU=;
        b=jWX4w412IljcKPhMYW9r72mie3mJVP3U++Tg5N+PGLSkRIJjcOdGslttWnl97TwMqQ
         7qqA90IK2a3M3NhZCiZRzN7l9BxjLFDT2UaSNdyJcrIrtqgU+svthQ23JG3cRjSEzhos
         k5vCEYFUfDd4ZxODTQK2WXwsQGPB4dt8++3GJoHQsrv3fXzIXieSJfQhCntP85H5T1bv
         kmEzvk+Zn6BlcZEXelilXt6Tkx/1eh37C3eA8GgIv7AngxA93NhrE51qx3sTCcVUvcMm
         cUbHHyNOvrmMpaPqG91uhPsk+iWKjrbi0caUa6vU19b27JqB0vjvgnrmjN3RC9jLeFSq
         Wlzw==
X-Gm-Message-State: AOJu0Yz9M4Wo3+hRUrFCJ5e/lE4FeCZfosMYUzELThUTuBI3qWqJmnkq
	mUjgvvIa1a/e3h1gclWIXWCwqynWPpNADTrrZEBjGxRSKGNihT8a+0G9bchA
X-Google-Smtp-Source: AGHT+IG6Z7wprymZITZX9ht6+gTXW4oYosIHVkICug2xUmTPYybbwDluebNPlHjwGju13EkHTSJBCw==
X-Received: by 2002:a17:903:41c4:b0:20c:6b11:deef with SMTP id d9443c01a7336-210c6c3692dmr101371385ad.48.1730100640505;
        Mon, 28 Oct 2024 00:30:40 -0700 (PDT)
Received: from localhost ([2402:7500:488:6621:2441:dc7a:ff1b:984a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc08883esm45645735ad.301.2024.10.28.00.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 00:30:40 -0700 (PDT)
From: wojackbb@gmail.com
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	Jack Wu <wojackbb@gmail.com>
Subject: [PATCH] [net] net: wwan: t7xx: Change PM_AUTOSUSPEND_MS to 5000
Date: Mon, 28 Oct 2024 15:30:15 +0800
Message-Id: <20241028073015.692794-1-wojackbb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Wu <wojackbb@gmail.com>

Because optimizing the power consumption of t7XX,
change auto suspend time to 5000.

The Tests uses a script to loop through the power_state
of t7XX.
(for example: /sys/bus/pci/devices/0000\:72\:00.0/power_state)

* If Auto suspend is 20 seconds,
  test script show power_state have 0~5% of the time was in D3 state
  when host don't have data packet transmission.

* Changed auto suspend time to 5 seconds,
  test script show power_state have 50%~80% of the time was in D3 state
  when host don't have data packet transmission.

Signed-off-by: Jack Wu <wojackbb@gmail.com>
---
 drivers/net/wwan/t7xx/t7xx_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index e556e5bd49ab..dcadd615a025 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -48,7 +48,7 @@
 #define T7XX_INIT_TIMEOUT		20
 #define PM_SLEEP_DIS_TIMEOUT_MS		20
 #define PM_ACK_TIMEOUT_MS		1500
-#define PM_AUTOSUSPEND_MS		20000
+#define PM_AUTOSUSPEND_MS		5000
 #define PM_RESOURCE_POLL_TIMEOUT_US	10000
 #define PM_RESOURCE_POLL_STEP_US	100
 
-- 
2.34.1


