Return-Path: <netdev+bounces-63765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF4882F51C
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 20:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3C41F21A34
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 19:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C381CFA9;
	Tue, 16 Jan 2024 19:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNX4z+4Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35C21CF9A
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432444; cv=none; b=exk5MuzEnVQcuE8wQSP/PZvWmaRRfVEcbK73Nkz+eMS43nWuRuXe3HHOr1KxNAWggvZJ1UzFHzgk2OpRRbie9QhLYgbeORhgZnWnAqP1BLuWCw6dLF6hmVkcX+CkZE8WSs5v3ypEsy2EY6GwUOqcdfMdnfVbnj7zzuBXJ6s5FEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432444; c=relaxed/simple;
	bh=ZUmIxi/797W1LKgMdqkXCyaSk1XIZJQbQMaWh4HR6kU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=oY66Bmy6lF6qA+WhMwOwC/WTaBOmnlweXCyksIzmjALQnloQcr9Nep3OOqarX3gGaqC1twchD/4IfnACOSVyEB9JgEbrfia7HyxmZTvDpFJNGNKm6t1gQY+SHreJPvSfB5WvWYm93D9+wGXSM0Kcg/B3J+LzvYHNnFx4MwWqqng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNX4z+4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CC9C433C7;
	Tue, 16 Jan 2024 19:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705432443;
	bh=ZUmIxi/797W1LKgMdqkXCyaSk1XIZJQbQMaWh4HR6kU=;
	h=From:To:Cc:Subject:Date:From;
	b=hNX4z+4ZlssK0oIGx4PiswPiN09Qyec2Suc6jI7xDrEERck9oH6G3jTGt+YhEgCN4
	 /TrgmvbKCcAc0ZL+gQxvHMTTvPK6iXqmZsoiXWGyxCA+iYDCiFrCM4BTIhJXtvXITV
	 bjyL/LP6DGtn2PsSoYJnS1IdlTuINYY4Y+CQ4Dxp69HSxUCLoZJRTw4uEyX3FuQSDi
	 LhZqYEydb+6y/vLcmH60HwylL3KwSybk3cwE5+PNKyXbpqRC+Wi57//Jo64HQAs20P
	 zCxCe/RQuANgZgIZgnFdJngfT966LuOSx2ONBtNflPHUmC6ow2aEAdOfGDLA7yZf+q
	 meGs/eANp6HTQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	vladimir.oltean@nxp.com
Subject: [PATCH net] net: netdevsim: don't try to destroy PHC on VFs
Date: Tue, 16 Jan 2024 11:14:00 -0800
Message-ID: <20240116191400.2098848-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PHC gets initialized in nsim_init_netdevsim(), which
is only called if (nsim_dev_port_is_pf()).

Create a counterpart of nsim_init_netdevsim() and
move the mock_phc_destroy() there.

This fixes a crash trying to destroy netdevsim with
VFs instantiated, as caught by running the devlink.sh test:

    BUG: kernel NULL pointer dereference, address: 00000000000000b8
    RIP: 0010:mock_phc_destroy+0xd/0x30
    Call Trace:
     <TASK>
     nsim_destroy+0x4a/0x70 [netdevsim]
     __nsim_dev_port_del+0x47/0x70 [netdevsim]
     nsim_dev_reload_destroy+0x105/0x120 [netdevsim]
     nsim_drv_remove+0x2f/0xb0 [netdevsim]
     device_release_driver_internal+0x1a1/0x210
     bus_remove_device+0xd5/0x120
     device_del+0x159/0x490
     device_unregister+0x12/0x30
     del_device_store+0x11a/0x1a0 [netdevsim]
     kernfs_fop_write_iter+0x130/0x1d0
     vfs_write+0x30b/0x4b0
     ksys_write+0x69/0xf0
     do_syscall_64+0xcc/0x1e0
     entry_SYSCALL_64_after_hwframe+0x6f/0x77

Fixes: b63e78fca889 ("net: netdevsim: use mock PHC driver")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: vladimir.oltean@nxp.com
---
 drivers/net/netdevsim/netdev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index aecaf5f44374..77e8250282a5 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -369,6 +369,12 @@ static int nsim_init_netdevsim_vf(struct netdevsim *ns)
 	return err;
 }
 
+static void nsim_exit_netdevsim(struct netdevsim *ns)
+{
+	nsim_udp_tunnels_info_destroy(ns->netdev);
+	mock_phc_destroy(ns->phc);
+}
+
 struct netdevsim *
 nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
 {
@@ -417,8 +423,7 @@ void nsim_destroy(struct netdevsim *ns)
 	}
 	rtnl_unlock();
 	if (nsim_dev_port_is_pf(ns->nsim_dev_port))
-		nsim_udp_tunnels_info_destroy(dev);
-	mock_phc_destroy(ns->phc);
+		nsim_exit_netdevsim(ns);
 	free_netdev(dev);
 }
 
-- 
2.43.0


