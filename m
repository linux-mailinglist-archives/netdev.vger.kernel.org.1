Return-Path: <netdev+bounces-245265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D44CC9F90
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 02:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A0BA301C664
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 01:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8478253B59;
	Thu, 18 Dec 2025 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVHqy55U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39611FDE01
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 01:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766021048; cv=none; b=Uhs5a6RBtVHtghSke8yfKwi/bUsuQR4QYh7EDgykS4Kqcme9tbKVE1oL9g/J2B2h5fo1zE7KDJK3mv3MYpEvAxsIx6xNOR1t/RauZKzalAkTCnFn6EzPbZfb/mZXCHK7Pl9QDUPl1k+lhYlk2Jea/HA5Bhdhp8Rhh9d2jEdLfLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766021048; c=relaxed/simple;
	bh=e2uP0ZZrORin36qfUFZ4oiCOOcWKcoTH8uLPIBj5IWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5c4KncILIxpdRuIJ8TgVS1Ei3cX+do4SWSvuNGrqI68uYr2soAyTO1Jb3PV+bWRllY4158tH1pEO+C4SypSDnsikSOAJxQyVtEZ9fvnWUpTFnbWjTxDTe5yt9jO5Obc1xAUVDAcwBw4dE9NpNKXiZvbCUSLbvvFL8jCz/KAbCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVHqy55U; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso204586b3a.1
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 17:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766021045; x=1766625845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=emBNhNNlWqPOEEl6QlP0wn4wftIpig8p3Ziv36qR1o0=;
        b=TVHqy55U2/kSInDIDlmdhsVS35rK3YKQYBlOoNvOXVo52PMjq7fumiaUd6oWuluHxm
         zgX6sQxfxTWy7cvivpFvel2X42lLLVLxyYgsYdLd7xdAuOoOiq91ussaRqgD9WMKPjoo
         LLc6gIO1DgT1rKJ3jySJlCWAyxIUSiGWpPb40C2qE9kB/FOk9moMGWgUa5P8CHLdahK8
         v/B0QPXX7Rk/WlNYSPfQ/mbc/91pEx+iudU6rd+ck9oMw/eDVqyI0TurfJX/L9WNoYSs
         H2mb8k3li/ew7/wfzNStBNBgK7JU2NX1R9nrn1HTyE5w1C/e2x7Sy9mQoIew63SHSjmy
         Bwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766021045; x=1766625845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emBNhNNlWqPOEEl6QlP0wn4wftIpig8p3Ziv36qR1o0=;
        b=XvFoS0mRPHYKSOjgtcmr3+kSAeJS+2ZPLS05ri8BCm+KlcCv+1kwe4FPqb0Eg180HP
         9o7PooLnJ/pNM3tLPvSkEWBvpKhskPYIrlafo7SsO5E/A65l9W6dg7BGXByNYM+Hv6Pp
         0uTql1OVAxJ/7Jz9r4l1zl6aVM7DVeDs7fILAfM5mBOnqZ/8futJoErs9S9z0hvHiFlv
         UVUZ0NYGeMqoDhDnWfNwqDoozhxqYgLxZaZ31pYBxwabXVQ/5r0ELl6EvcH8JYozEQy8
         0qzJ8JSHvgnZyZtYf3n3Fsyln8yCEe9KmLPyKyDlNcjGbqVwTgNvCUHylDi0eWYsEUum
         knLg==
X-Forwarded-Encrypted: i=1; AJvYcCVC7NG9rtli4aO3PRXAjOF/a7OUwSb46UqaIjpYaNhyC8qpPNbLN3wT8QPGDf4jnULas9zVp3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnUQqEKz/NQ60SejImypqm8m5eEfjuUp2e/L3BdJBbRbeCgjdI
	TUY4ioveqTlaTqjFqDIQk6sTcbFTKz6Rzj4V6bfLw/rSP3D8/PVQlM34
X-Gm-Gg: AY/fxX61h5uASll0qL+iAWf/iWFiXbQYs5xqS9ybM/Io9uJwz07ISNin1pdPrf86PQN
	PNiAZYuUYCFwGeqRRh1RUwnfuPATEFRSIlIrFqvqsIn6Erhjo9YFrfOM3BNkUqlkhYVdQ7aZyWl
	3QUxK4Cll6MleWt3m6hka5TQGu0sYICEvOyTBF5uSsQsGSrdONSfgLnQwzuQRI7KM8IiKqDeufB
	9sj477YNdmLK9LDLyFuiUStK0YkXrQkbrkpKbKelGgiIkpqVTOlxAlleGE2K7Nmg0bGWofChAfB
	feiTeUwAtA5ZPZuLhzrzKXWVz3T81MEnAkxIGt95TAtXk6WhsX6XYngrgfk7QSc9+3CaTFA7YG1
	J40GLt2quqDwZPNPkofd4QTQjzq/TyMfBtMMaVZ7LzQEwVDzXFOxFOR3KCNVPVL2yJYTXqLJtfZ
	5a9G4eJybVQ3E4zK5hIiJxK9Kxf8olOEwgE9CFc2oH94i9gtZUU2/DB0Z+rmfWhFbh4JY=
X-Google-Smtp-Source: AGHT+IG8qEk4VvEgkvsi2+A4qbe7sf1FK993lwy81zhcYcsjR16OvYCzjdL3HruD2xxF4O/sLvNhJA==
X-Received: by 2002:a05:6a00:27a4:b0:7e8:4433:8fa3 with SMTP id d2e1a72fcca58-7f6694ac050mr18922276b3a.43.1766021044963;
        Wed, 17 Dec 2025 17:24:04 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:a45b:c390:af5a:2503])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe12315ea4sm694602b3a.28.2025.12.17.17.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:24:04 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: krzk@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linma@zju.edu.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	stable@vger.kernel.org,
	syzbot+4ef89409a235d804c6c2@syzkaller.appspotmail.com
Subject: [PATCH v2] net: nfc: fix deadlock between nfc_unregister_device and rfkill_fop_write
Date: Thu, 18 Dec 2025 06:53:54 +0530
Message-ID: <20251218012355.279940-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A deadlock can occur between nfc_unregister_device() and rfkill_fop_write()
due to lock ordering inversion between device_lock and rfkill_global_mutex.

The problematic lock order is:

Thread A (rfkill_fop_write):
  rfkill_fop_write()
    mutex_lock(&rfkill_global_mutex)
      rfkill_set_block()
        nfc_rfkill_set_block()
          nfc_dev_down()
            device_lock(&dev->dev)    <- waits for device_lock

Thread B (nfc_unregister_device):
  nfc_unregister_device()
    device_lock(&dev->dev)
      rfkill_unregister()
        mutex_lock(&rfkill_global_mutex)  <- waits for rfkill_global_mutex

This creates a classic ABBA deadlock scenario.

Fix this by moving rfkill_unregister() and rfkill_destroy() outside the
device_lock critical section. Store the rfkill pointer in a local variable
before releasing the lock, then call rfkill_unregister() after releasing
device_lock.

This change is safe because rfkill_fop_write() holds rfkill_global_mutex
while calling the rfkill callbacks, and rfkill_unregister() also acquires
rfkill_global_mutex before cleanup. Therefore, rfkill_unregister() will
wait for any ongoing callback to complete before proceeding, and
device_del() is only called after rfkill_unregister() returns, preventing
any use-after-free.

The similar lock ordering in nfc_register_device() (device_lock ->
rfkill_global_mutex via rfkill_register) is safe because during
registration the device is not yet in rfkill_list, so no concurrent
rfkill operations can occur on this device.

Fixes: 3e3b5dfcd16a ("NFC: reorder the logic in nfc_{un,}register_device")
Cc: stable@vger.kernel.org
Reported-by: syzbot+4ef89409a235d804c6c2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4ef89409a235d804c6c2
Link: https://lore.kernel.org/all/20251217054908.178907-1-kartikey406@gmail.com/T/ [v1]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v2:
  - Added explanation of why UAF is not possible
  - Added explanation of why nfc_register_device() is safe
  - Added Fixes and Cc: stable tags
  - Fixed blank line after variable declaration (kept it)
---
 net/nfc/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/nfc/core.c b/net/nfc/core.c
index ae1c842f9c64..82f023f37754 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -1154,6 +1154,7 @@ EXPORT_SYMBOL(nfc_register_device);
 void nfc_unregister_device(struct nfc_dev *dev)
 {
 	int rc;
+	struct rfkill *rfk = NULL;
 
 	pr_debug("dev_name=%s\n", dev_name(&dev->dev));
 
@@ -1164,13 +1165,17 @@ void nfc_unregister_device(struct nfc_dev *dev)
 
 	device_lock(&dev->dev);
 	if (dev->rfkill) {
-		rfkill_unregister(dev->rfkill);
-		rfkill_destroy(dev->rfkill);
+		rfk = dev->rfkill;
 		dev->rfkill = NULL;
 	}
 	dev->shutting_down = true;
 	device_unlock(&dev->dev);
 
+	if (rfk) {
+		rfkill_unregister(rfk);
+		rfkill_destroy(rfk);
+	}
+
 	if (dev->ops->check_presence) {
 		timer_delete_sync(&dev->check_pres_timer);
 		cancel_work_sync(&dev->check_pres_work);
-- 
2.43.0


