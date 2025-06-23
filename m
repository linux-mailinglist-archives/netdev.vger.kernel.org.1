Return-Path: <netdev+bounces-200245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D02AE3D6C
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44AA97A620E
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8BA23C4F1;
	Mon, 23 Jun 2025 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/7dIcKv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1E9233701
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676083; cv=none; b=tTsKDtyhpRBCHP2uUSA8SIxu4nIB3xm5kb0n6DHDAIPB60tBsbjJDw2XL9zIDFWhLtIW2vwUsR7Z08ftyHLUnU2MosR6ou4WczD6REuZdv0mDZyeDekxAsUzRNMZaRiwhA50KVcEAvUPc3TNSqExg42WlQu6o8wAKRd9uSnVgCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676083; c=relaxed/simple;
	bh=rnz7A+bUMKwknsRgBwGvOSqTmRNgfmB4Gfj1UZB3G90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SGMVgzdmMmwXsk3Rwtq1gOTRdgkssndmnj0krpV4qDueadDAomJ82/kMfBHzbj6hCalYdSY6tskBvrFWUZooEEa/fIXz4IQ7YwZxgJWEsYYV4MlEZbE456mloKXNelpPzCvQNhuaJA+nif6zeNrJHo+umYH6aM+czNj5tiGtamc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/7dIcKv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750676081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9uVlOBl4JiN0W9ZdeX9DfLg4JhDRJ5g9Qa7grgLb1uo=;
	b=d/7dIcKvv2abNdc1c76+dS7iD1PJ0XQ8XW4l/x0fFz0e1VcdJgZTPG93jairLJT+7pQlvM
	1JmJnJj25gXlOxm4i22lggFirbn0+0sjIFYJO/f6JJx2bi5YmPPCD1NKMQpLNH3A0PPo97
	vrESyql1ojzmRpXp3bn4r4e5Bc+wrOg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-Q91YnK0mPgC9KtbUcnucjg-1; Mon,
 23 Jun 2025 06:54:35 -0400
X-MC-Unique: Q91YnK0mPgC9KtbUcnucjg-1
X-Mimecast-MFC-AGG-ID: Q91YnK0mPgC9KtbUcnucjg_1750676074
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CD2118011FB;
	Mon, 23 Jun 2025 10:54:34 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.58])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9185A180045B;
	Mon, 23 Jun 2025 10:54:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next] udp_tunnel: fix deadlock in udp_tunnel_nic_set_port_priv()
Date: Mon, 23 Jun 2025 12:53:55 +0200
Message-ID: <95a827621ec78c12d1564ec3209e549774f9657d.1750675978.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

While configuring a vxlan tunnel in a system with a i40e NIC driver, I
observe the following deadlock:

 WARNING: possible recursive locking detected
 6.16.0-rc2.net-next-6.16_92d87230d899+ #13 Tainted: G            E
 --------------------------------------------
 kworker/u256:4/1125 is trying to acquire lock:
 ffff88921ab9c8c8 (&utn->lock){+.+.}-{4:4}, at: i40e_udp_tunnel_set_port (/home/pabeni/net-next/include/net/udp_tunnel.h:343 /home/pabeni/net-next/drivers/net/ethernet/intel/i40e/i40e_main.c:13013) i40e

 but task is already holding lock:
 ffff88921ab9c8c8 (&utn->lock){+.+.}-{4:4}, at: udp_tunnel_nic_device_sync_work (/home/pabeni/net-next/net/ipv4/udp_tunnel_nic.c:739) udp_tunnel

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&utn->lock);
   lock(&utn->lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 4 locks held by kworker/u256:4/1125:
 #0: ffff8892910ca158 ((wq_completion)udp_tunnel_nic){+.+.}-{0:0}, at: process_one_work (/home/pabeni/net-next/kernel/workqueue.c:3213)
 #1: ffffc900244efd30 ((work_completion)(&utn->work)){+.+.}-{0:0}, at: process_one_work (/home/pabeni/net-next/kernel/workqueue.c:3214)
 #2: ffffffff9a14e290 (rtnl_mutex){+.+.}-{4:4}, at: udp_tunnel_nic_device_sync_work (/home/pabeni/net-next/net/ipv4/udp_tunnel_nic.c:737) udp_tunnel
 #3: ffff88921ab9c8c8 (&utn->lock){+.+.}-{4:4}, at: udp_tunnel_nic_device_sync_work (/home/pabeni/net-next/net/ipv4/udp_tunnel_nic.c:739) udp_tunnel

 stack backtrace:
 Hardware name: Dell Inc. PowerEdge R7525/0YHMCJ, BIOS 2.2.5 04/08/2021
i
 Call Trace:
  <TASK>
 dump_stack_lvl (/home/pabeni/net-next/lib/dump_stack.c:123)
 print_deadlock_bug (/home/pabeni/net-next/kernel/locking/lockdep.c:3047)
 validate_chain (/home/pabeni/net-next/kernel/locking/lockdep.c:3901)
 __lock_acquire (/home/pabeni/net-next/kernel/locking/lockdep.c:5240)
 lock_acquire.part.0 (/home/pabeni/net-next/kernel/locking/lockdep.c:473 /home/pabeni/net-next/kernel/locking/lockdep.c:5873)
 __mutex_lock (/home/pabeni/net-next/kernel/locking/mutex.c:604 /home/pabeni/net-next/kernel/locking/mutex.c:747)
 i40e_udp_tunnel_set_port (/home/pabeni/net-next/include/net/udp_tunnel.h:343 /home/pabeni/net-next/drivers/net/ethernet/intel/i40e/i40e_main.c:13013) i40e
 udp_tunnel_nic_device_sync_by_port (/home/pabeni/net-next/net/ipv4/udp_tunnel_nic.c:230 /home/pabeni/net-next/net/ipv4/udp_tunnel_nic.c:249) udp_tunnel
 __udp_tunnel_nic_device_sync.part.0 (/home/pabeni/net-next/net/ipv4/udp_tunnel_nic.c:292) udp_tunnel
 udp_tunnel_nic_device_sync_work (/home/pabeni/net-next/net/ipv4/udp_tunnel_nic.c:742) udp_tunnel
 process_one_work (/home/pabeni/net-next/kernel/workqueue.c:3243)
 worker_thread (/home/pabeni/net-next/kernel/workqueue.c:3315 /home/pabeni/net-next/kernel/workqueue.c:3402)
 kthread (/home/pabeni/net-next/kernel/kthread.c:464)

AFAICS all the existing callsites of udp_tunnel_nic_set_port_priv() are
already under the utn lock scope, avoid (re-)acquiring it in such a
function.

Fixes: 1ead7501094c ("udp_tunnel: remove rtnl_lock dependency")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/udp_tunnel.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index cbd3a43074bd..9acef2fbd2fd 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -339,9 +339,8 @@ udp_tunnel_nic_set_port_priv(struct net_device *dev, unsigned int table,
 			     unsigned int idx, u8 priv)
 {
 	if (udp_tunnel_nic_ops) {
-		udp_tunnel_nic_ops->lock(dev);
+		udp_tunnel_nic_ops->assert_locked(dev);
 		udp_tunnel_nic_ops->set_port_priv(dev, table, idx, priv);
-		udp_tunnel_nic_ops->unlock(dev);
 	}
 }
 
-- 
2.49.0


