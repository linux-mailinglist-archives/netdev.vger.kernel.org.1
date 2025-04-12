Return-Path: <netdev+bounces-181937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CDBA87040
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 01:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006D119E09FD
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 23:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462531A3169;
	Sat, 12 Apr 2025 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOSptyep"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215F21993BD
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744500617; cv=none; b=TSVHGUPJUSe1oMrRhEAJWfs2OilmeFpGKMiIrnxzTZw9m3EDlLKGZ2T/BIhPz/W1fmdbyUWbs6f8GSCszN823K+GkXIpGpVRqSFFj9nZtpv64CXyCuPZxwzF3BWOZOLr/323nB7nAZzlBnsVkoBm7EqXz4gqGUD3emic/WaqY/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744500617; c=relaxed/simple;
	bh=VE2+NexlsQkF1yffVVBLgIjSM/Dix2Wr3+JiVVDlO/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hxC8qbKTzGNE4b/WLWPZRSxHuBJZLbPRYhxLCDjBAEdMBXi9lm5vZGsmvqtkNNMTrLq9i/hZMAOeiIULX9LQOW7f2Y3TeWuoN91OqDKduv7HlkZjHwLQompy6bKmaSqLA76zR3acgUZxZROgk+GW4byDScw6/91lwLQMuxBmf5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOSptyep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B678C4CEE3;
	Sat, 12 Apr 2025 23:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744500615;
	bh=VE2+NexlsQkF1yffVVBLgIjSM/Dix2Wr3+JiVVDlO/w=;
	h=From:To:Cc:Subject:Date:From;
	b=eOSptyepqEI1muES+5xcdUridrV02v45KFWrG4946hLLCovMCIysxZ4hc7ud7ahle
	 LZyq3Ck0ucg0u5mVk5pAMh20yRBpERETRiU9j5bhrrT7EMNKCZ/gpxU+jTibHy9F5o
	 FfjzhcZoJgRdx9YDt9bgvudy1z1QGtscn/q4VmxujHprNXb/syoq2HrtiKxchQFMy4
	 bJQacIz7F9IsyHqXmL/Ef/5Yrhj8AXfiaxcdcIm0f6W4iNK+ZQglmEUhkfuwx5VHLg
	 sBG1H86gDUcdpaQ0NkkGtjRqlRqBLJ8t0+rpI1IhQ7rqxX7+c7Wcftni0PcvQC3SdC
	 YrOCvtzpTgxAQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+6f588c78bf765b62b450@syzkaller.appspotmail.com,
	sdf@fomichev.me
Subject: [PATCH net] net: don't mix device locking in dev_close_many() calls
Date: Sat, 12 Apr 2025 16:30:11 -0700
Message-ID: <20250412233011.309762-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lockdep found the following dependency:

  &dev_instance_lock_key#3 -->
     &rdev->wiphy.mtx -->
        &net->xdp.lock -->
	   &xs->mutex -->
	      &dev_instance_lock_key#3

The first dependency is the problem. wiphy mutex should be outside
the instance locks. The problem happens in notifiers (as always)
for CLOSE. We only hold the instance lock for ops locked devices
during CLOSE, and WiFi netdevs are not ops locked. Unfortunately,
when we dev_close_many() during netns dismantle we may be holding
the instance lock of _another_ netdev when issuing a CLOSE for
a WiFi device.

Lockdep's "Possible unsafe locking scenario" only prints 3 locks
and we have 4, plus I think we'd need 3 CPUs, like this:

       CPU0                 CPU1              CPU2
       ----                 ----              ----
  lock(&xs->mutex);
                       lock(&dev_instance_lock_key#3);
                                         lock(&rdev->wiphy.mtx);
                                         lock(&net->xdp.lock);
                                         lock(&xs->mutex);
                       lock(&rdev->wiphy.mtx);
  lock(&dev_instance_lock_key#3);

Tho, I don't think that's possible as CPU1 and CPU2 would
be under rtnl_lock. Even if we have per-netns rtnl_lock and
wiphy can span network namespaces - CPU0 and CPU1 must be
in the same netns to see dev_instance_lock, so CPU0 can't
be installing a socket as CPU1 is tearing the netns down.

Regardless, our expected lock ordering is that wiphy lock
is taken before instance locks, so let's fix this.

Go over the ops locked and non-locked devices separately.
Note that calling dev_close_many() on an empty list is perfectly
fine. All processing (including RCU syncs) are conditional
on the list not being empty, already.

Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
Reported-by: syzbot+6f588c78bf765b62b450@syzkaller.appspotmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: sdf@fomichev.me
---
 net/core/dev.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 75e104322ad5..5fcbc66d865e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11932,15 +11932,24 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		BUG_ON(dev->reg_state != NETREG_REGISTERED);
 	}
 
-	/* If device is running, close it first. */
+	/* If device is running, close it first. Start with ops locked... */
 	list_for_each_entry(dev, head, unreg_list) {
-		list_add_tail(&dev->close_list, &close_head);
-		netdev_lock_ops(dev);
+		if (netdev_need_ops_lock(dev)) {
+			list_add_tail(&dev->close_list, &close_head);
+			netdev_lock(dev);
+		}
+	}
+	dev_close_many(&close_head, true);
+	/* ... now unlock them and go over the rest. */
+	list_for_each_entry(dev, head, unreg_list) {
+		if (netdev_need_ops_lock(dev))
+			netdev_unlock(dev);
+		else
+			list_add_tail(&dev->close_list, &close_head);
 	}
 	dev_close_many(&close_head, true);
 
 	list_for_each_entry(dev, head, unreg_list) {
-		netdev_unlock_ops(dev);
 		/* And unlink it from device chain. */
 		unlist_netdevice(dev);
 		netdev_lock(dev);
-- 
2.49.0


