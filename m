Return-Path: <netdev+bounces-210268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A64B1285D
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 03:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CDAD1CC4006
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 01:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F30199FD0;
	Sat, 26 Jul 2025 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6UbF1p5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC3B80B
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 01:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753492131; cv=none; b=JkjggJYdKmCDQXinl52uXUp2BXQvYdN7UCGGfuJ4TZQdbUx49z760QKyB5YO/3rfgeMqPHSK6bf1JDeRPBpBRQnyqu1+XyHwCX8KeGGNuV0iJ4VCssdyGOLxNVQtsQ4Zf9MY9vhIWZs+jHN4xhlkIBsnhcix5mJxKazWFVE4Qt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753492131; c=relaxed/simple;
	bh=UU2Tqztz/UjFhqca6DLskZ8xYn393SkotGRFbADWzGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a95qpM856LGeBB+6bAfNVIiIlihjqm+nD10+/x8hRBN6QCjc9b/mqL/7dP4bTttNyPMfHhZl51ZDa89YWABBoxFKYbHLNdH8ie0GknG3Xt4BrIId+tM6U6c2JOvpm1FFQyImUpTGouqQnwdixLcoIixTUaps2BsbOV7SzqKA7ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6UbF1p5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F50C4CEE7;
	Sat, 26 Jul 2025 01:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753492130;
	bh=UU2Tqztz/UjFhqca6DLskZ8xYn393SkotGRFbADWzGg=;
	h=From:To:Cc:Subject:Date:From;
	b=j6UbF1p5nXxlC0BCqv6RWwdUDRejN0at+ln1xrSJHiCyyvMUkEXfxWYlrUijUx2vR
	 iBc0HCirPzyW+xlQsTjHfeJYPIFKLvTOSG2Qc69LwZKpTahaH2VnyhleQLKj8N1c0M
	 KhWPPYZWi8J24H5F/ZBnoueBSaNinh6zsR/4sUeyzFO32Y9GFWk76SzsUemDnh4HQU
	 rEDMbTx5aOm7dkeJGPY9gvHjp30kepVvGjJM4oOl2jULi1PhNnU4GIAm8b/cIaEXYI
	 AeoSEM6SqLjZdHV4hTXaoaPSziziQkcbUTnEfMdtmwjawlIrcHgI3WhJwLW2I0sqg4
	 OUqs0rEyPHDhg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Zigit Zo <zuozhijie@bytedance.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	leitao@debian.org,
	sdf@fomichev.me
Subject: [PATCH net v2] netpoll: prevent hanging NAPI when netcons gets enabled
Date: Fri, 25 Jul 2025 18:08:46 -0700
Message-ID: <20250726010846.1105875-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Paolo spotted hangs in NIPA running driver tests against virtio.
The tests hang in virtnet_close() -> virtnet_napi_tx_disable().

The problem is only reproducible if running multiple of our tests
in sequence (I used TEST_PROGS="xdp.py ping.py netcons_basic.sh \
netpoll_basic.py stats.py"). Initial suspicion was that this is
a simple case of double-disable of NAPI, but instrumenting the
code reveals:

 Deadlocked on NAPI ffff888007cd82c0 (virtnet_poll_tx):
   state: 0x37, disabled: false, owner: 0, listed: false, weight: 64

The NAPI was not in fact disabled, owner is 0 (rather than -1),
so the NAPI "thinks" it's scheduled for CPU 0 but it's not listed
(!list_empty(&n->poll_list) => false). It seems odd that normal NAPI
processing would wedge itself like this.

Better suspicion is that netpoll gets enabled while NAPI is polling,
and also grabs the NAPI instance. This confuses napi_complete_done():

  [netpoll]                                   [normal NAPI]
                                        napi_poll()
                                          have = netpoll_poll_lock()
                                            rcu_access_pointer(dev->npinfo)
                                              return NULL # no netpoll
                                          __napi_poll()
					    ->poll(->weight)
  poll_napi()
    cmpxchg(->poll_owner, -1, cpu)
      poll_one_napi()
        set_bit(NAPI_STATE_NPSVC, ->state)
                                              napi_complete_done()
                                                if (NAPIF_STATE_NPSVC)
                                                  return false
                                           # exit without clearing SCHED

This feels very unlikely, but perhaps virtio has some interactions
with the hypervisor in the NAPI ->poll that makes the race window
larger?

Best I could to to prove the theory was to add and trigger this
warning in napi_poll (just before netpoll_poll_unlock()):

      WARN_ONCE(!have && rcu_access_pointer(n->dev->npinfo) &&
                napi_is_scheduled(n) && list_empty(&n->poll_list),
                "NAPI race with netpoll %px", n);

If this warning hits the next virtio_close() will hang.

This patch survived 30 test iterations without a hang (without it
the longest clean run was around 10). Credit for triggering this
goes to Breno's recent netconsole tests.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/c5a93ed1-9abe-4880-a3bb-8d1678018b1d@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - move the sync to netpoll_setup()
v1: https://lore.kernel.org/20250725024454.690517-1-kuba@kernel.org

CC: Jason Wang <jasowang@redhat.com>
CC: Zigit Zo <zuozhijie@bytedance.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: Eugenio Pérez <eperezma@redhat.com>

CC: leitao@debian.org
CC: sdf@fomichev.me
---
 net/core/netpoll.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index a1da97b5b30b..5f65b62346d4 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -768,6 +768,13 @@ int netpoll_setup(struct netpoll *np)
 	if (err)
 		goto flush;
 	rtnl_unlock();
+
+	/* Make sure all NAPI polls which started before dev->npinfo
+	 * was visible have exited before we start calling NAPI poll.
+	 * NAPI skips locking if dev->npinfo is NULL.
+	 */
+	synchronize_rcu();
+
 	return 0;
 
 flush:
-- 
2.50.1


