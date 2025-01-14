Return-Path: <netdev+bounces-157979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94690A0FFBF
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F8817A24D3
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EC82327BA;
	Tue, 14 Jan 2025 03:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtQg1U2Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0FE232398
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 03:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736826692; cv=none; b=W+EehN6zjki4wRbGFp5P4Zpup253rKcF0V6IswOXE1oNeEw6vTy0AAlioyEf+7xPrxjaSwLq4wl76cSNWBQIB+DGkIMOyyiu9bHOXEJSI+mJvhpktsgDH1EGxZfa0MzKEA7E2zFxosHAUzsyCWlaMWBioMh9c5ojMtpMECqIQ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736826692; c=relaxed/simple;
	bh=5vpu9qlahrUJSP6WRQw6I7jtoO5NnZf0ODNBYcg1qy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMm3mQeT62NBnqFG2TyA0LFQxK/RMur1lrBzrfRL7HSRTMDg/KNFaYnfuYHrAO878o/lbPl8IyD/p/JV6YIIVuyvKJJyEPeh8KTR1Yp/GP1ue1Gig5VZT4dr1MEZL/N+IrXfCjESCdGnjtKY8Uho08iM2evXdpaVauWp4notIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtQg1U2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF361C4CEDF;
	Tue, 14 Jan 2025 03:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736826692;
	bh=5vpu9qlahrUJSP6WRQw6I7jtoO5NnZf0ODNBYcg1qy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BtQg1U2Q0jl/0AUPDHFYu3wZK2izZACg6XRd9SUTKAbeGFTlkD+f/jOvTFRMXj+1h
	 xbyIqQ95l2ESuoDuAlSEm6LdJPncz+SEtWAfpnnxRXp1musetS1JXZJtsP4HfGOSWK
	 QN6u7ChWfAzs4dXjd87KviRknfue94LHRZ43upMcoNeDI5mWTKkOCems4wfk6Gqh7S
	 HJnMPQPdVuofi4RL9HzkEza8Ofb8w7SGehIB/Axjqvlintyt8O5FarYhuicHmgkZDZ
	 27imBOn7MMQj33Ics9uY/O+mgG5vQoft6liwYjdEdkbO+BUfENQsBtAte15R5/ESKE
	 3kfaBrwyjk8PQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 03/11] net: make netdev_lock() protect netdev->reg_state
Date: Mon, 13 Jan 2025 19:51:09 -0800
Message-ID: <20250114035118.110297-4-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114035118.110297-1-kuba@kernel.org>
References: <20250114035118.110297-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Protect writes to netdev->reg_state with netdev_lock().
From now on holding netdev_lock() is sufficient to prevent
the net_device from getting unregistered, so code which
wants to hold just a single netdev around no longer needs
to hold rtnl_lock.

We do not protect the NETREG_UNREGISTERED -> NETREG_RELEASED
transition. We'd need to move mutex_destroy(netdev->lock)
to .release, but the real reason is that trying to stop
the unregistration process mid-way would be unsafe / crazy.
Taking references on such devices is not safe, either.
So the intended semantics are to lock REGISTERED devices.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h | 2 +-
 net/core/dev.c            | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0e008ce9d5ee..bdbc5849469c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2448,7 +2448,7 @@ struct net_device {
 	 * Should always be taken using netdev_lock() / netdev_unlock() helpers.
 	 * Drivers are free to use it for other protection.
 	 *
-	 * Protects: @net_shaper_hierarchy.
+	 * Protects: @reg_state, @net_shaper_hierarchy.
 	 * Ordering: take after rtnl_lock.
 	 */
 	struct mutex		lock;
diff --git a/net/core/dev.c b/net/core/dev.c
index 5c1e71afbe1c..2ded6eedb4cc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10778,7 +10778,9 @@ int register_netdevice(struct net_device *dev)
 
 	ret = netdev_register_kobject(dev);
 
+	netdev_lock(dev);
 	WRITE_ONCE(dev->reg_state, ret ? NETREG_UNREGISTERED : NETREG_REGISTERED);
+	netdev_unlock(dev);
 
 	if (ret)
 		goto err_uninit_notify;
@@ -11052,7 +11054,9 @@ void netdev_run_todo(void)
 			continue;
 		}
 
+		netdev_lock(dev);
 		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
+		netdev_unlock(dev);
 		linkwatch_sync_dev(dev);
 	}
 
@@ -11658,7 +11662,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 	list_for_each_entry(dev, head, unreg_list) {
 		/* And unlink it from device chain. */
 		unlist_netdevice(dev);
+		netdev_lock(dev);
 		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERING);
+		netdev_unlock(dev);
 	}
 	flush_all_backlogs();
 
-- 
2.47.1


