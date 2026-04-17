Return-Path: <netdev+bounces-279398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCn1IeR14mnh6AAAu9opvQ
	(envelope-from <netdev+bounces-279398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 20:03:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CF541DC8F
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 20:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67B89325AAC6
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8BE39BFE7;
	Fri, 17 Apr 2026 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C76L2RaN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFB0284B4F
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776448415; cv=none; b=llQaS+crXo35etJupHuXD/GDsSm3FqyVZBVTQxQIBBDYeaGwIi1K5xY5tI4YOFi6oCeUt6e6dRMCAW7AidD8tBHqQQav/hUMjf82F2LzpY4+4PowLO7okQ1T/UJSx9pBWFrr5/eX0BHB+i6AhuovDnYuaixQ2J6ZmUl37lIRHCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776448415; c=relaxed/simple;
	bh=dK++D2vkZK9PleCJEUILLOoQHPIMUWDT9hGB56F7SL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i8HGY4g+GogMAFguLc+wWgc0bIrLVuzIRno46eq/42ynXPCejyT/j77qFuQ0juXzlXTa1H938EQVRDm86Y4BEutzpl3VcyxvufcqgSW0HJ4T166o5/Jx1wv9F6eOhiH8d1WcJt6bSUNY4MEJHDfd6dlEl+maEv5o4K4RnTJ06rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C76L2RaN; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35d965648a2so929511a91.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776448410; x=1777053210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9tvUjnR9lJQhfo2LmiLM4HfIXmeGrC2pRLAfvNcBl30=;
        b=C76L2RaNASwd4Q4JOakug1LcA+bXbIcUuVnso6LTgR3LNij6Ie67XVr8Zvwt9NgviG
         nCxHyCUtekSVG/7+YzSgana55uHEXmL8oqztCjXkMR5nLvMOMmcKUam5jFYxYYVQOXCE
         iKhPaTJ4bq5TkGaG9O/RVUYKBLPqqVAnWtqk70lkys4NLFMNnGwW8gpz1Sis4xaD/td4
         3hXwu1nm56jX974HldsrHoFESGffwYVQh8WO1fPNEA1uQFp3vrOjogexoJpzpJyWF5Yr
         mCMRkk+T5QyOmbHqGw2FshR03iV/76X++yfn+JLs9I52VnT61/oPijDLiYyBKsfRZbLS
         yi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776448410; x=1777053210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tvUjnR9lJQhfo2LmiLM4HfIXmeGrC2pRLAfvNcBl30=;
        b=rS1gSlRuLgeCDVRvDrr3T63AUu5rlirLMcVrng6vf8A0d3gdEJRLl7+vReMgbv98hn
         5Qb3xAS1oXliOeN05zAfj6GLB3z1hDdAHNbjOaIidMyx2nGmt9QN2DH4B6CP7pUViyVt
         l1HQpBWlWaKpk+yFVNx6DUiZpOQ4s1iy8GdayPmBeGkDeF5NicfHgqJNuUYeWxE2gdZY
         BMFo5p0CRVAZg642r09blH1yVX+nPpFq2mj0FNOv0y7CgG6DDC1eykor9kD8t4wH0iC8
         vlzMhZBTEvNRKw9ojO4FaGvx2gK45Aa/Xoy+NwejVZfZFOVnL7QQLt7uhDOk7qIjma/O
         OlqA==
X-Forwarded-Encrypted: i=1; AFNElJ93j4CzPTNTIEBKDBI7hB5XIbyw8vcaP+RBQ6kQ+qpI+53YppdeFhO6Z9ikWtxfWUz8K3AqgNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA3aTTULP7mkt1GfVyLGzoOjAtOGXfnEzXnM5/0v0SEIt9qKGX
	sQ/7xbisxIEykaruu5lt/VEZtdRkbsrAgKkZ638OGvsRNFHZSSS2Bo38
X-Gm-Gg: AeBDievjRIBoCR2x6Jg52ZB1BoNPfaf5+Jbn7K64qpWTKpi6rSzmhzuixvZ30cecrHf
	KYETQUKRJ48efdxmORkPVckfGSwKSGsYpWio2a27vgSP/ofvqUlDyxNtAj/bugamjhrlWHi9Ota
	JTzHH+72SPeu81wsRdNwoxtZg7Nbf3mIvDMihtPTE6BQVeAU8bCohai+P4fJTKDWY9nlxeeE8Ag
	kaQzV2pMWA6uNY2CkkQCFBFxCzyWYzXxuFGnbpxjKyoIKm+QFntB1dqyfHSLk24knLAujAQdkHZ
	QplbDwtQZRMnDT/ev7DPLFS1yaTg25NtW1P+K4e/ZaLIoqmfveBJ6c7JE4/+bZBzm9Vhdpfc7wM
	OVvTks4RjBmmtWCda++ufi9BhIF1uyPonUynCBjI9ftVMmOqhJWP2Hxg6jvyxloAD4wh2eX9pCo
	zPLVPY9lWHKIxFy8j6A8rrVDv31mlur0GbMqs5S+5SyVs=
X-Received: by 2002:a05:6a21:e082:b0:39f:2dd0:65bf with SMTP id adf61e73a8af0-3a08d8d9a7amr4193251637.28.1776448409644;
        Fri, 17 Apr 2026 10:53:29 -0700 (PDT)
Received: from localhost ([223.185.42.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797701f622sm1949898a12.21.2026.04.17.10.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 10:53:28 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
X-Google-Original-From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: liuhangbin@gmail.com,
	lukma@nabladev.com,
	acsjakub@amazon.de,
	kees@kernel.org,
	xiaoliang.yang_1@nxp.com,
	fmancera@suse.de,
	linux-kernel@vger.kernel.org,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com
Subject: [PATCH] net: hsr: avoid synchronize_net() in hsr_del_port() under rtnl_mutex
Date: Fri, 17 Apr 2026 23:23:22 +0530
Message-Id: <20260417175322.2701465-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279398-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nabladev.com,amazon.de,kernel.org,nxp.com,suse.de,vger.kernel.org,mpiric.us,mpiricsoftware.com,syzkaller.appspotmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardulsb08@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,f2fbf7478a35a94c8b7c];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28CF541DC8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hsr_del_port() calls netdev_rx_handler_unregister(), which calls
synchronize_net() while rtnl_mutex is held.  During netns teardown,
cleanup_net() walks pernet_list and reaches default_device_exit_batch(),
which takes rtnl_mutex and iterates devices calling
rtnl_link_ops->dellink() for each.  For HSR this resolves to
hsr_dellink() -> hsr_del_ports() -> hsr_del_port(), so the
synchronize_net() call runs under rtnl_mutex.  Under contention this
stalls other rtnl_mutex waiters long enough to trip the hung-task
detector:

  kworker cleanup_net -> default_device_exit_batch -> hsr_del_port
    -> netdev_rx_handler_unregister -> synchronize_rcu_expedited
    [slow, holds rtnl_mutex]
  syz-executor -> ksys_unshare -> setup_net -> ip_tunnel_init_net
    -> rtnl_lock  [blocked on rtnl_mutex]

Open-code netdev_rx_handler_unregister() in hsr_del_port() without
the synchronize_net() step.  This is safe because hsr_del_port()
already defers the port free via kfree_rcu(port, rcu), so the
rx_handler_data memory remains valid until an RCU grace period
elapses naturally.  hsr_handle_frame() additionally re-validates
rx_handler via hsr_port_get_rcu() before dereferencing
rx_handler_data, so a reader that observes rx_handler_data == NULL
in the brief window between the two clears takes the NULL path and
returns RX_HANDLER_PASS without touching the port.

Reported-by: syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=cb64c22a492202ca929e18262fdb8cb89e635c70
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
Testing status:

The hang was originally observed on 7.0-rc6 (commit 7ca6d1cfec80) with
the syzkaller reproducer and a KASAN+LOCKDEP config.  Subsequent
reproduction attempts with the same reproducer on current mainline did
not retrigger this specific signature, so I could not verify the fix
against a live reproducer.  The patch is submitted on the basis of
code analysis.

 net/hsr/hsr_slave.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index d9af9e65f72f..5e92f23fa1a5 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -239,7 +239,18 @@ void hsr_del_port(struct hsr_port *port)
 	if (port != master) {
 		netdev_update_features(master->dev);
 		dev_set_mtu(master->dev, hsr_get_max_mtu(hsr));
-		netdev_rx_handler_unregister(port->dev);
+		/* Open-code netdev_rx_handler_unregister() without the
+		 * synchronize_net() step: holding rtnl_mutex across the
+		 * grace-period wait stalls other rtnl_mutex waiters long
+		 * enough to trip the hung-task detector under load.
+		 * Skipping synchronize_net() is safe because the port is
+		 * freed via kfree_rcu() below (so rx_handler_data memory
+		 * outlives any in-flight reader), and hsr_handle_frame()
+		 * re-validates rx_handler via hsr_port_get_rcu() before
+		 * dereferencing rx_handler_data.
+		 */
+		RCU_INIT_POINTER(port->dev->rx_handler, NULL);
+		RCU_INIT_POINTER(port->dev->rx_handler_data, NULL);
 		if (!port->hsr->fwd_offloaded)
 			dev_set_promiscuity(port->dev, -1);
 		netdev_upper_dev_unlink(port->dev, master->dev);
-- 
2.34.1


