Return-Path: <netdev+bounces-173243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDD1A582BD
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 10:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1594C168916
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 09:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B31813AD05;
	Sun,  9 Mar 2025 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULI/EFqJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028071A3177
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741513174; cv=none; b=XP8N8ZtmTBXZU9cEXgXUIGZSUrLOdwN66/OtDbHUwb6SwdWUeCEqhSmm3IR1k9GPEexJ/53p43hD7OUS4ZCKB2zPUIH2crGGJ3t7bHFtsCIR8k/mvgLSkNW8rhas0Z9a/ZSUxysuhGsgm8mW79IX3zeUsqhbWrnTSeGZFkTLdA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741513174; c=relaxed/simple;
	bh=GnNnoLWvrNzt/V14i42cXk9YuvZjtcgAtlkxYDoXHLI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aZD5rJWStq4Jz9WjGbZo6enxTCgM3u6B+WhdY/e+ZEfy/57+moZmcPiL/79Pa1TG21BN+TMiNr/MTwB1PIjk2ZAw5LtO8V2GrqAYnrl0pry90ly/oXGW9oNTqlwCh84wMSu+7WClAJ0+skpLQ8YPabUN6cB3Vamc2wcfZg9MbjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ULI/EFqJ; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e905e89798so25844786d6.3
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 01:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741513172; x=1742117972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BLVAVONPH2ISN2Orc1l44Sb4SE9x2ISZsKj1Uv9z1yM=;
        b=ULI/EFqJAv/lwVmqigmujf1Vhb6FjsabCZdShEpd+9sOgJ/7cDKgMfAzW0eNRAF9gy
         U3Cc+bhQiW2PJBC0/FM4pZTk5EBCaJMGsM7JO9J0J17RQ9gX9TSKsibyWOtiT7TBxL+X
         7ftqyk9tjIgNrd6ICcp1MuFDWwXdCJgf9wAhBiwGErWfnhmIoGqMkFVsguq1Ut65NBI2
         M4CTDRpX2aHiCNloAFFhXQHg3lfP8E6IQcOIEcWE1b45HKq3jbSGgL/mmL7GoDSmqtdq
         08y8TkDDjcDookIrVxD5vDDCxwJJYGTU30KGqE51xPzfi0zPL4vRwCPtMde2kPpW2mgE
         3ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741513172; x=1742117972;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BLVAVONPH2ISN2Orc1l44Sb4SE9x2ISZsKj1Uv9z1yM=;
        b=OugJpbL5i9lmPv7Ag2zreSS6ClHXzMjhEPQ/c0/d7OlFyqYSEJmgHFgwg9qfurUYen
         BOshsSwzeg6c8+L7yOd050YgFYxyjktvUZsvGNPb0cLc1CzXjhuPdyVNrOCBSP7XO+Vc
         /+N2ALjuUBNG1Oh1hAuRvCovDvbxF8UfTZBqI/ntefgooG+ySRZRv/Pn4P1qELnFnZwQ
         ++XU+w7MH7y2JE3ItaDC/w/sOfd+FWe3S3ncaxNW+EeLcvQul/aw73iWmNEeYJvc1aHT
         kqLZU2O2ENqGiuEpuFegp7zNNTWnWwSDbRrETyx8etCs7aBNtGlN56Ni+N/+pIzYuy4k
         CHTw==
X-Forwarded-Encrypted: i=1; AJvYcCUE+kd0YvCKHb19pPdGYCA6W1yu/h4fjU0ya13+LHgCU5CeVXOnaEgCXZr/MmjUtrMOCeejFmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG8LLhMSJHUueqSHXAWzsfV3dTMcdDFOt6TOgLCdpUbbRQiHyM
	tGBoT6ZXws0ptexV3EHlciFkNxyfehvgdHPg5hLFsm04v0mtQBBL9m5Ct+YG+G921fltDNZNpXE
	gLOQ7Lb1yrw==
X-Google-Smtp-Source: AGHT+IGwuMemn8J9CcNzq/t87TxiDu3382GH8nT9Ngg7B5kk9u8P3uA20r6sFK6HfY67+7AUIsq98GbuJ8NnMg==
X-Received: from qvbny6.prod.google.com ([2002:a05:6214:3986:b0:6e8:9afa:145c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2425:b0:6e8:9021:9095 with SMTP id 6a1803df08f44-6e90066b6efmr159208556d6.32.1741513171846;
 Sun, 09 Mar 2025 01:39:31 -0800 (PST)
Date: Sun,  9 Mar 2025 09:39:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250309093930.1359048-1-edumazet@google.com>
Subject: [PATCH net] net: lapbether: use netdev_lockdep_set_classes() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+377b71db585c9c705f8e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

drivers/net/wan/lapbether.c uses stacked devices.
Like similar drivers, it must use netdev_lockdep_set_classes()
to avoid LOCKDEP splats.

This is similar to commit 9bfc9d65a1dc ("hamradio:
use netdev_lockdep_set_classes() helper")

Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
Reported-by: syzbot+377b71db585c9c705f8e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67cd611c.050a0220.14db68.0073.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/wan/lapbether.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index 56326f38fe8a30f45e88cdce7efd43e18041e52a..995a7207bdf8719899bbbe58b84707eb4c2e9c1d 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -39,6 +39,7 @@
 #include <linux/lapb.h>
 #include <linux/init.h>
 
+#include <net/netdev_lock.h>
 #include <net/x25device.h>
 
 static const u8 bcast_addr[6] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
@@ -366,6 +367,7 @@ static const struct net_device_ops lapbeth_netdev_ops = {
 
 static void lapbeth_setup(struct net_device *dev)
 {
+	netdev_lockdep_set_classes(dev);
 	dev->netdev_ops	     = &lapbeth_netdev_ops;
 	dev->needs_free_netdev = true;
 	dev->type            = ARPHRD_X25;
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


