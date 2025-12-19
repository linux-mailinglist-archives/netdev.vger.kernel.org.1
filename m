Return-Path: <netdev+bounces-245533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DD6CD0582
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 15:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D46CF300987E
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAAC329E75;
	Fri, 19 Dec 2025 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HmH1wL14"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C006B27FB2F
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766155507; cv=none; b=gvJr3qDxVaQOyGYY0gfLxZdqo7NGW0v+MBslk5w2oETLmp4KAtzzOauD+7dSnduaJoiEaEvCHd6PZqGounz+ASOml28mKE6Cwulx2WD3afBgsIvUbcbIqq4NzTxws0/OWO5JATt6TxHZvQkS06uWTS6Fg0rNaR5NHk9wA/3EFvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766155507; c=relaxed/simple;
	bh=3RlN2LCALAxWJvAvyZXuDyzIaXTDNUMsyXjrjfXCGyE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fyP84kGjf9HTgwFMknMw2NCbOW+u3bpawOvbJCxLvuLJnYhrjgQi0QEW71nY5qbCCybVIWL8M1oiKzt3T7EqD60Vfo5e5C8qlSO3nx0lgAknLI0s+c1B9e4WXwo6iMb6PcxMxQWIxMx+aZj/QDqXZ998LtaJuhot7iETl82pcDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HmH1wL14; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-78e728e39f5so19111867b3.2
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 06:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766155501; x=1766760301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P5aiNzVJFJvsiKVqIxUm10fZYLmS8pwSKdQL1cdV4Eo=;
        b=HmH1wL14KqMHRuG4utINsXttVcgD7boxmvMaOmaq0NpljcD0Llo5jR+6FUyweTIIR6
         ad9oDjZ6shSe3ysemX7WDVuHAj9siHVPcermXuUF1WPftvthTLG/zNhjdyaWjxKtBP2l
         YWUQllxeRmQbYyU1RKFXkaKLCaHg2V48HR+IW8UqvUSLCVIpMRrvgG50K3VUNvpMEZkO
         WEPzF07p0UUvgzm1422U6NOp+dBqfj7wjREz+tSRfDgXzrm/J5h64X81bNY+knty7uwy
         l2nGzYrc/MhxvFFeAwAc53A/qDNo//XAsGyg3F3ZdJbKecIq8UxZWXx27J4krig6GelY
         SpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766155501; x=1766760301;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P5aiNzVJFJvsiKVqIxUm10fZYLmS8pwSKdQL1cdV4Eo=;
        b=UXV1Ze+9Ig956KmBTVGnL6/gFKFJvzLVCAnZYAwS4+SqqTVmYUzWSh4USDRrWJEtUU
         Cdrz38VQQVzHzDAdr2fKIiW3BI7IbbttR9tu2gv4b2SggVFJpOTow924YVEFB8JGQd83
         sEiarygxePAa2ub4vrnoJgMNDhQPThA3LJm/lWMy0xvacHim3aiV1rlbWQiLadaKmcO4
         YS+gcFIWH/D1acVD/ZTw7biEvdqRG91aHVsjsVaUU6b7TMEo1jpdrxEnoNgq4YBNvbFC
         4+6VaxJ1jZSf7oKmoXKhGjRrmlb6NzRC6/oGiDmOZcnnBeYb93HjCsMkvOcka8oXVZp3
         5lyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+jTDqBvMTrHchGzLXsmN+RhDJaESgNza3hYGCLaqapMrrDv5EzDj5yjXyn1jBnvw/Fe7Q/oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw19p0OPuhtPUQny2pdsK8HXoEpO21yX2pi50EnzSGKLNKuvxKe
	DouN9BiNnZxQFVE50SjD3mxGcQPFbAb3D7Fpq47dCP26qx+jNpMSzxNhXjZJaviCFAkqOnQMNFv
	Zm1EhY8VkiCVBzg==
X-Google-Smtp-Source: AGHT+IHj7aEXyD96No2mv8WDslYNmLU0JQA+gtZdw499Ywwt4ZrNnEQ8iR/PVv/0KPtmCmn5kgYFNwhUQIVUfg==
X-Received: from ywbis10.prod.google.com ([2002:a05:690c:6c8a:b0:782:fcc0:46fb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:6f92:b0:786:4860:21fd with SMTP id 00721157ae682-78fb41326bdmr27172247b3.39.1766155501277;
 Fri, 19 Dec 2025 06:45:01 -0800 (PST)
Date: Fri, 19 Dec 2025 14:44:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
Message-ID: <20251219144459.692715-1-edumazet@google.com>
Subject: [PATCH net] usbnet: avoid a possible crash in dql_completed()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+5b55e49f8bbd84631a9c@syzkaller.appspotmail.com, 
	Simon Schippers <simon.schippers@tu-dortmund.de>
Content-Type: text/plain; charset="UTF-8"

syzbot reported a crash [1] in dql_completed() after recent usbnet
BQL adoption.

The reason for the crash is that netdev_reset_queue() is called too soon.

It should be called after cancel_work_sync(&dev->bh_work) to make
sure no more TX completion can happen.

[1]
kernel BUG at lib/dynamic_queue_limits.c:99 !
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 5197 Comm: udevd Tainted: G             L      syzkaller #0 PREEMPT(full)
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
 RIP: 0010:dql_completed+0xbe1/0xbf0 lib/dynamic_queue_limits.c:99
Call Trace:
 <IRQ>
  netdev_tx_completed_queue include/linux/netdevice.h:3864 [inline]
  netdev_completed_queue include/linux/netdevice.h:3894 [inline]
  usbnet_bh+0x793/0x1020 drivers/net/usb/usbnet.c:1601
  process_one_work kernel/workqueue.c:3257 [inline]
  process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
  bh_worker+0x2b1/0x600 kernel/workqueue.c:3611
  tasklet_action+0xc/0x70 kernel/softirq.c:952
  handle_softirqs+0x27d/0x850 kernel/softirq.c:622
  __do_softirq kernel/softirq.c:656 [inline]
  invoke_softirq kernel/softirq.c:496 [inline]
  __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:723
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:739

Fixes: 7ff14c52049e ("usbnet: Add support for Byte Queue Limits (BQL)")
Reported-by: syzbot+5b55e49f8bbd84631a9c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6945644f.a70a0220.207337.0113.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/usb/usbnet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 1d9faa70ba3b..36742e64cff7 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -831,7 +831,6 @@ int usbnet_stop(struct net_device *net)
 
 	clear_bit(EVENT_DEV_OPEN, &dev->flags);
 	netif_stop_queue(net);
-	netdev_reset_queue(net);
 
 	netif_info(dev, ifdown, dev->net,
 		   "stop stats: rx/tx %lu/%lu, errs %lu/%lu\n",
@@ -875,6 +874,8 @@ int usbnet_stop(struct net_device *net)
 	timer_delete_sync(&dev->delay);
 	cancel_work_sync(&dev->kevent);
 
+	netdev_reset_queue(net);
+
 	if (!pm)
 		usb_autopm_put_interface(dev->intf);
 
-- 
2.52.0.322.g1dd061c0dc-goog


