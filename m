Return-Path: <netdev+bounces-285171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ++2rFtBC/GmPNgAAu9opvQ
	(envelope-from <netdev+bounces-285171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 09:44:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C40904E4373
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 09:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA383301624F
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 07:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D694D366049;
	Thu,  7 May 2026 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8hgz4sH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA44351C34
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778139852; cv=none; b=bfn804zY3o+Wz+x6cg20xvHA65o95SvRM04Z2ApzMRxbAzARu3B290ha9pq2okphqJoXcn50hxzTqYJTCOLa/FYdKCPy0W3U85i0CcEoH0/JNkZc97OBKGRAjbBHQp6Lmv3NrarxXzUdvWfWqjIvDAc+ZNjmBHzUF6v8+Dj9r98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778139852; c=relaxed/simple;
	bh=vwfHry98+JEpPVskwD/KJciAxWku8ClUkYKuaKh3goc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S28cYJGZimLc9VvsGTeX3tXkGsXugqKdPZ+FEIdDgoh/cIUaK73/2pHTFkGQCJnktQuNKqF5oPdogw6hvIXaEXpQqK2dSAKLaDFGdpmFKzjt0nyPXyo9Z2OjdB7AsxgLIBtxfKBSzDie91SmX4ssjXy81yY58ytMCkf29dbRJHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8hgz4sH; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso634157eec.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 00:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778139850; x=1778744650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s5Owz66v4XOfeCVfS1a+QKhvUs30nyL0lA5WOTRgKQk=;
        b=V8hgz4sH0Yi7GuS50goPaaE8MMq2e65tHZyh50BGQy6rj+deLB2tLPANdACz88kEki
         2YwTI97Qwsx/UmrULAMWw/Y3vhaL/KwpDVPbymQL1ZlCE9zWZn/LcyBQ559XvyLcb+aS
         bqQqlCh7vDza37jLefe6nJ+lUd7BQ12HP3dpYl+UOr1SL1k7MbH0EcFmqaLMGe5SSQVV
         mF9PcH8klZREJyQCmZDXfJxu67i2M6cWk06ygAvxlrvYtPtOneGwpj55ztrZ9AKqPTxg
         noJ+46igKTPe8U05NYfWndaFjsS2y38oH9jQ30lslhmEjVqiYC0TL/s+ABsz8PfIJ4t+
         WA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778139850; x=1778744650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5Owz66v4XOfeCVfS1a+QKhvUs30nyL0lA5WOTRgKQk=;
        b=RIjI8lRTL8LKhYNa/bErgsl/jsoEcdeNVSoYoTZwteRwki/MTi8bb3H7FwA7lpjkO8
         e+m4lSGK8zpY0Nltn4P82YKqgi8OGHf6Cr+G5qpBmbUHrZhuubHp1CB6IUr5WyUoaoXK
         tgFlngcnS4Nk61zUapNtO4ykkII/MZfIOjDGmAgJzBDqHGt1MSW7EWj6sSiVZdJLgZH8
         H7QlZhjbK/xOWAvGgEiFg9krNt8aLSb+x19+tStRiz4naY99jhfyakV4YXJXaDY4Z3Dc
         MU5gakq/OrbqJKeuNJtsbOKoj0ufmhVrplDCM/tm08+sUNBfXgY9MCHUhwEbz9J7nSZ6
         TxAA==
X-Forwarded-Encrypted: i=1; AFNElJ+LNK+ybpZ5hWexfeBHSlhkl4MJEVlKI7Wq3O9xD01t/ep4G6+zlx7GddfIwPe5GBJTSUyEk90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFelLRVvg8o7+udT7HAzvsBvrx8nuTQ4eWCW/renJ5e/rwfq6q
	bt3MT74nwmQhLizUTw7jKW7GFXgNEn3HlQxxcjKNmCX7frhhniteb2VR
X-Gm-Gg: AeBDieu6UJQMKkUccir0vtOC9n/K+7h+89ePRGQF8CA6r1XmAfrdLydIqtQLubDxrNJ
	0AY5YZRGEqZealbfP78hCIEnsaYZbia5S9Xmip+cxsW4fMQz6DGP5kUsJQ++EWs3QZMETcTHwY2
	+gNd4jh91pZGESgvaUqdnry6acNecU6SP+XsA8FxErA1LlvmZNL90AQkwilpnXUIj7dyd4WHW4m
	Jl9AK+4u0YaosLLOIJuv5AGBwO4zPMEZ204sZRetewp+Bw2srHDuupex4UUzeES8gz/SUrIMxKV
	Driz/YKNFMKW0Pt/FxrbfubC1XriN6wCL6AZIge+6VjFRqebVYrk3q/4QLXlngO6JIczQ8AfDRE
	atGmUVytrMsOnP1/i6T9b13QBfELCv7kvRq74GmSFx9jIYD+bEVuZg+iVrzlwqoCSpGrML0PPjx
	SiRJ4X+ZreH3ATY2IVDdFKrpBGbWiLiAlQ
X-Received: by 2002:a05:7300:e78d:b0:2d0:239a:23c9 with SMTP id 5a478bee46e88-2f54a7840c2mr2940572eec.16.1778139850437;
        Thu, 07 May 2026 00:44:10 -0700 (PDT)
Received: from dev-ubuntu.. ([128.14.159.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f57038c644sm7670950eec.29.2026.05.07.00.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 00:44:09 -0700 (PDT)
From: faicker.mo@gmail.com
To: faicker.mo@gmail.com
Cc: kuba@kernel.org,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] net: net_failover: Fix the deadlock in slave register
Date: Thu,  7 May 2026 15:43:32 +0800
Message-Id: <20260507074332.2543229-1-faicker.mo@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C40904E4373
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285171-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[faickermo@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Action: no action

From: Faicker Mo <faicker.mo@gmail.com>

There is netdev_lock_ops() before the NETDEV_REGISTER notifier
in register_netdevice(), so use the non-locking functions
in net_failover_slave_register().

Call Trace:
 <TASK>
 __schedule+0x30d/0x7a0
 schedule+0x27/0x90
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock.constprop.0+0x538/0x9e0
 __mutex_lock_slowpath+0x13/0x20
 mutex_lock+0x3b/0x50
 dev_set_mtu+0x40/0xe0
 net_failover_slave_register+0x24/0x280
 failover_slave_register+0x103/0x1b0
 failover_event+0x15e/0x210
 ? dropmon_net_event+0xac/0xe0
 notifier_call_chain+0x5e/0xe0
 raw_notifier_call_chain+0x16/0x30
 call_netdevice_notifiers_info+0x52/0xa0
 register_netdevice+0x5f4/0x7c0
 register_netdev+0x1e/0x40
 _mlx5e_probe+0xe2/0x370 [mlx5_core]
 mlx5e_probe+0x59/0x70 [mlx5_core]
 ? __pfx_mlx5e_probe+0x10/0x10 [mlx5_core]

Fixes: 4c975fd70002 ("net: hold instance lock during NETDEV_REGISTER/UP")
Signed-off-by: Faicker Mo <faicker.mo@gmail.com>
---
Changes since v1:
  - Fix the space chars (Simon)
  - Change the dev_close to netif_close (Simon)
  - Change the label err_dev_open to err_netif_open
Changes since v2:
  - Add lock ops in failover_existing_slave_register (Jakub Kicinski)
---
 drivers/net/net_failover.c | 12 ++++++------
 net/core/failover.c        |  5 ++++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index d0361aaf25ef..3f7d31033bae 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -502,7 +502,7 @@ static int net_failover_slave_register(struct net_device *slave_dev,
 
 	/* Align MTU of slave with failover dev */
 	orig_mtu = slave_dev->mtu;
-	err = dev_set_mtu(slave_dev, failover_dev->mtu);
+	err = netif_set_mtu(slave_dev, failover_dev->mtu);
 	if (err) {
 		netdev_err(failover_dev, "unable to change mtu of %s to %u register failed\n",
 			   slave_dev->name, failover_dev->mtu);
@@ -512,11 +512,11 @@ static int net_failover_slave_register(struct net_device *slave_dev,
 	dev_hold(slave_dev);
 
 	if (netif_running(failover_dev)) {
-		err = dev_open(slave_dev, NULL);
+		err = netif_open(slave_dev, NULL);
 		if (err && (err != -EBUSY)) {
 			netdev_err(failover_dev, "Opening slave %s failed err:%d\n",
 				   slave_dev->name, err);
-			goto err_dev_open;
+			goto err_netif_open;
 		}
 	}
 
@@ -562,10 +562,10 @@ static int net_failover_slave_register(struct net_device *slave_dev,
 err_vlan_add:
 	dev_uc_unsync(slave_dev, failover_dev);
 	dev_mc_unsync(slave_dev, failover_dev);
-	dev_close(slave_dev);
-err_dev_open:
+	netif_close(slave_dev);
+err_netif_open:
 	dev_put(slave_dev);
-	dev_set_mtu(slave_dev, orig_mtu);
+	netif_set_mtu(slave_dev, orig_mtu);
 done:
 	return err;
 }
diff --git a/net/core/failover.c b/net/core/failover.c
index 11bb183c7a1b..122fbcbf915a 100644
--- a/net/core/failover.c
+++ b/net/core/failover.c
@@ -221,8 +221,11 @@ failover_existing_slave_register(struct net_device *failover_dev)
 	for_each_netdev(net, dev) {
 		if (netif_is_failover(dev))
 			continue;
-		if (ether_addr_equal(failover_dev->perm_addr, dev->perm_addr))
+		if (ether_addr_equal(failover_dev->perm_addr, dev->perm_addr)) {
+			netdev_lock_ops(dev);
 			failover_slave_register(dev);
+			netdev_unlock_ops(dev);
+		}
 	}
 	rtnl_unlock();
 }
-- 
2.34.1


