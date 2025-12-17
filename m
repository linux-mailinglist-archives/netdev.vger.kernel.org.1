Return-Path: <netdev+bounces-245042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A8CCC61A1
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 06:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 539D7301EFC1
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 05:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5655F2773D8;
	Wed, 17 Dec 2025 05:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EV/6+cx2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D4B2550D5
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 05:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765950561; cv=none; b=WyG3ztIxd6k4/uVdWNXnRRQ49LCMBDWpbP6tIsxtEUhjDpc9XkEVikJhhjW67f6rUTY0hhDwnrJqpEWC2q4nPjQedSUOk4uzEWJZocJqdrMBUNxGj1ihb/zid9GV1AwfaTjT+XQHPb9iCa0Z71HKEGm3NSQBMmcN7FZnmIVSfLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765950561; c=relaxed/simple;
	bh=Jasdg2EzwTY7FSm47ggmhbsuF/UFHqXNviT1u1N2ko0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aD33WsiEHZL8dkBTCZFhbpiDGKuMxMKg2CCge/DjBuQlb1p0nbX+6KO2YNrjUQutxh8IvUDrPsjyf6sdFBfrEhU7hKJKFvc/m5w+/jt3TursUeBY7wqbRe1vQ/uGLSUO9S/nDCa/79C5e2m0cAEOmywtLuxNxBVRz87Nkt+dWx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EV/6+cx2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a137692691so19620485ad.0
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 21:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765950559; x=1766555359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ssYksSavXezEQR7JdYALER94H5LUWurRQ5myT3AfS1M=;
        b=EV/6+cx2RTfYy85IsLHaF2RtQ83uU7sTQBxTMhis62QGDA1mFDWMFZe2u+VmbpMNBD
         WDZoU2X2SLDDYPqCjC+xllgx316VN+Rg2O+MygIPC0ghiUwRR6nLFr7Qxu3SY7we2Fj+
         AU3G9k8uveGz9WYz94wg62yFyPgpE6uZgcctLMcbfnRazpX8GCqBvcbNrYs1KjiSvg2o
         98yuE4G+IanW2IZiR/oDhoAxcAIGkvIfru3+dyJKcZ7cIA5hNbuQuIXbdqMGDyVexCId
         erO3GzH+7b+xaEwRdLPLMxYGstQ7+VkZSchBaCMxUJ/YjUAiSRqbk0kWLauFSh3QzuKx
         yvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765950559; x=1766555359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssYksSavXezEQR7JdYALER94H5LUWurRQ5myT3AfS1M=;
        b=mFWaUqITOiXJbz9PpWgDeRhhRyQ0kqvh8VrZmrQzTZ9R8ST4GIr+3C3+AHYl7G0S1Y
         OXVkzW801DevtBWqP26reUb5ZUaNQYXTo4GZJfZ27S0LPvYxX/xNpemrfDiCfUFf2eNe
         cq+lTWFR5t15t+Ho6h2ovS1753Jn9W7mw17AA7yJCjw6f9OdYSTPa+zFgPw2It/ZIsWr
         XV3cehtMvvlmY5ADKcpEo75ksT1MPioc2mYRkMzfH9LSVh6mhnoka9V1eGnmQhlpcpLW
         0GA7TFJNk5eL28aOAsA4Z7rFcDHv4akoIUjaMcx6gcUFDQkPAeQMKfpuqHgreBJXpehc
         8nBA==
X-Gm-Message-State: AOJu0Yy+sfcgJqi1U/1rsKbJzQwh55O0/E0VEIM6v3Thf4wzJA9R3R/x
	Bp8tdHkhL7NpDOzcZLP6J7SXDFUIvqTdz/tnh0xszlsfcggvZWiX+1gj
X-Gm-Gg: AY/fxX4ijgYjoxYtv09b5hia76FxXGTFi3oJhwKMsbSkyGEaSFzZuEEt4GficZqHzNK
	lhCCuSWQG9wEzGzZ0FD3JTLuziE5G5j0e9GdcmcaZ9aFl6RXxKHiaHo09p2scPODhmRzjEURX3k
	oGpX5TmiW2sbWThlUwwddQ9lSKX7S36DkJlOieYVecFs3VBnyo3IiFh/vgZz6FwGK1kEUbXsR/u
	jHjyNbRnYRMVO9O2a1KX2ffTFHycxi9W4wpUaUj2hGdabrJHl2fAEQTavcI3Tdwt1+IolJO+fIG
	hba1AliI03zOI0Hz6kvA+lmI0EEaHyxLRLGKpla2SyCgyduR4mu8Z0npFeEzn/+TyYy2PGTAS44
	BsjWHv7kfimBM0VrCGMlWF2fOd43otWtWIWvGn44dXvE1RsxXB/sIBEd6wr565Xq+Qoalnp1/ca
	i0Hc+ocnD2W/MmLtHBn2H1nSKpMIqjpoKsMFjDq6Eh5sLCFFgZww+9icXNdhU/UJt5JBw=
X-Google-Smtp-Source: AGHT+IFbOS4KtgflpeCAxeVKZkQD3BnzQeSs3E73leFX3w+DCXAhZSr7dwi+/mjwYHTL64MLw+S2Rg==
X-Received: by 2002:a17:902:d54d:b0:299:e215:f62d with SMTP id d9443c01a7336-29f23dfeb18mr167200505ad.5.1765950558942;
        Tue, 16 Dec 2025 21:49:18 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:d95a:1e5e:256b:2761])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a10e079284sm71689365ad.33.2025.12.16.21.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:49:18 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: krzk@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+4ef89409a235d804c6c2@syzkaller.appspotmail.com
Subject: [PATCH] net: nfc: fix deadlock between nfc_unregister_device and rfkill_fop_write
Date: Wed, 17 Dec 2025 11:19:08 +0530
Message-ID: <20251217054908.178907-1-kartikey406@gmail.com>
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
device_lock critical section. To ensure safety, set shutting_down flag
first and store rfkill pointer in a local variable before releasing the
lock. The shutting_down flag ensures that nfc_dev_down() and nfc_dev_up()
will bail out early if called during device unregistration.

Reported-by: syzbot+4ef89409a235d804c6c2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4ef89409a235d804c6c2
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 net/nfc/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/nfc/core.c b/net/nfc/core.c
index ae1c842f9c64..201d2b95432b 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -1154,7 +1154,7 @@ EXPORT_SYMBOL(nfc_register_device);
 void nfc_unregister_device(struct nfc_dev *dev)
 {
 	int rc;
-
+	struct rfkill *rfk = NULL;
 	pr_debug("dev_name=%s\n", dev_name(&dev->dev));
 
 	rc = nfc_genl_device_removed(dev);
@@ -1164,13 +1164,17 @@ void nfc_unregister_device(struct nfc_dev *dev)
 
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


