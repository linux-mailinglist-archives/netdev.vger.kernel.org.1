Return-Path: <netdev+bounces-49560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCECB7F26BA
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 08:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B6F2824FC
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 07:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC48A37157;
	Tue, 21 Nov 2023 07:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkHDFR7x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C484F5;
	Mon, 20 Nov 2023 23:54:17 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6c431b91b2aso4543164b3a.1;
        Mon, 20 Nov 2023 23:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700553257; x=1701158057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qjc16JuS7TAuQqo8p3/31+saz9w95ZEEb8nNI+ow3gQ=;
        b=EkHDFR7xz9PNxxqqZRhW8kLmDKxtbU3Dh1Gf26FOwN9BHKb7JsvxLTSqEvBDG0IWu4
         VUvoY4Woqob/NWvXsbOGe8wAlJnWlSPKViI1clF5arubP6Olt2/GObm/xk4coLDLw9SR
         x2TA9xYcpJsj8U3LFv+rnVwOfHqWoX8z83HbgwWTt9UBOadWw9Ad4c/mo2bUp6UYGY66
         afteGZ9/6C0kMBzTwQGizIQ1K+ysHPgFtka48sN0mBW3NYQQwmpm/M7XAmVSpsYldxvf
         mzNIpCVaKZCi63gyILBxNXUG+AW22cRw+yvGq9dVQA+IIMwm/HfwKtLrcTm2OET2onDm
         Kppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700553257; x=1701158057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjc16JuS7TAuQqo8p3/31+saz9w95ZEEb8nNI+ow3gQ=;
        b=n+T3xmJ3Q1zRcwJzhp64TnyQVHb829NjccV1ceDsljYV0VSGprxjaaUHocLayqjvR0
         mcU6OLISsB8ifOIx2bGQgm//NgoMnDxQzDVF3GZmTHbCm2CN7uMgH8pYtRFkDIBSrEua
         LkMJDJLmABL/hkNms9k1jx1jPXy1q5i7OSbPYWd2+25m9VSSPWkpDJEMBHppg4gO7Wid
         jdeeT5gPp6NIBZnWN9i0qjeGXdANV+ReVmuluTeRk45z3Q5dIWMdeeDIJE9hPZwd2sTl
         w2WyLR9pZKVcrYbx/wAfg9WZ15AeCo2tCM4iFZ0xCX5BLyQTt8TIlMkSvUen/b1O642s
         0MNw==
X-Gm-Message-State: AOJu0YxwsTiktoug7Mt5aZFmzpNS3WY8KptrNmcS7gncw8TI4Xl8ZFB0
	MydIL+H7o+g3BBcpoap4LQs=
X-Google-Smtp-Source: AGHT+IHmx+BCCvq9TOrQr1ZNmUidt63T8RizvZ6XaK5A8mdY2UcjGtGAnaEP/4zwq26hqi7BpmKGiA==
X-Received: by 2002:a05:6a21:6d88:b0:18a:b5c3:55c1 with SMTP id wl8-20020a056a216d8800b0018ab5c355c1mr3151932pzb.57.1700553256707;
        Mon, 20 Nov 2023 23:54:16 -0800 (PST)
Received: from ubuntu-VirtualBox.. ([122.11.166.8])
        by smtp.googlemail.com with ESMTPSA id z15-20020a170903018f00b001cf54e6b385sm5026931plg.203.2023.11.20.23.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 23:54:16 -0800 (PST)
From: Nguyen Dinh Phi <phind.uet@gmail.com>
To: Bongsu Jeon <bongsu.jeon@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nfc: virtual_ncidev: Add variable to check if ndev is running
Date: Tue, 21 Nov 2023 15:53:57 +0800
Message-Id: <20231121075357.344-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported an memory leak that happens when an skb is add to
send_buff after virtual nci closed.
This patch adds a variable to track if the ndev is running before
handling new skb in send function.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Reported-by: syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/00000000000075472b06007df4fb@google.com
---
V2:
    - Remove unused macro.
    - Re-adding a line that was removed wrongly.
 drivers/nfc/virtual_ncidev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
index b027be0b0b6f..590b038e449e 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -26,10 +26,14 @@ struct virtual_nci_dev {
 	struct mutex mtx;
 	struct sk_buff *send_buff;
 	struct wait_queue_head wq;
+	bool running;
 };
 
 static int virtual_nci_open(struct nci_dev *ndev)
 {
+	struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
+
+	vdev->running = true;
 	return 0;
 }
 
@@ -40,6 +44,7 @@ static int virtual_nci_close(struct nci_dev *ndev)
 	mutex_lock(&vdev->mtx);
 	kfree_skb(vdev->send_buff);
 	vdev->send_buff = NULL;
+	vdev->running = false;
 	mutex_unlock(&vdev->mtx);
 
 	return 0;
@@ -50,7 +55,7 @@ static int virtual_nci_send(struct nci_dev *ndev, struct sk_buff *skb)
 	struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
 
 	mutex_lock(&vdev->mtx);
-	if (vdev->send_buff) {
+	if (vdev->send_buff || !vdev->running) {
 		mutex_unlock(&vdev->mtx);
 		kfree_skb(skb);
 		return -1;
-- 
2.39.2


