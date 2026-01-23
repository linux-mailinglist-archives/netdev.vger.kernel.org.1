Return-Path: <netdev+bounces-252830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAn8I5Rkc2mivQAAu9opvQ
	(envelope-from <netdev+bounces-252830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:07:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E45D758BC
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0691300158C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2232D0605;
	Fri, 23 Jan 2026 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="dJlnlGr3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFCB1B808
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170062; cv=none; b=OrznaV1UlNznigylypUpfQw+u4rZtioQSWqa4yMeZT0RBIfOk0ImFm5ZlMPtK0AfvxjEJ+HfeZNDs2A5oLmzegOymbdWljJuQtbPS2OOUrUQKRu+iBLkT+tXf3TtXDdUW/IeZo38/XZthXu9yQC2ed9kh8YL1lRdYjHcLOUOv1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170062; c=relaxed/simple;
	bh=figv+wmaa+4WC9gkxO+g8sC1FxX5E/jWdTvrsu+qWuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cjBEIdOfgAFdPVkzOWLJ0b//5whUCETqtwJyc9cFNB2YaJfS07wyoN9+4ATvCTK7h+zhHnO254sN/mRZnslnjhZ7V3nMJC76RjP5GwymP1ZXIQpqIRiY+n9h++muX1ypVLUc/Yb905MqjFegS0Lad0sPkfzdOxgamRgGHpmxBI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=dJlnlGr3; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4801c1ad878so21785075e9.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 04:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1769170059; x=1769774859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=csWiFggnlzzQqaTFBhcmY3kJIz5jKn4iXDqtXXVFf7k=;
        b=dJlnlGr3Xjz7qzvHpGscnnqHCu4UisZ3S3l/EHmAKpmm88pzE9yoj/gJry38FY37gh
         bqLUd/HAQ3eK70IHmnEyFRqc4w2VWV8Pk0G2E1EUxyYdBz8LOSnG1DtqYvMcoKSIWEPc
         UfgpVSDAnf3Z0LbHISrhXXcY0U+VhABV+TIDhhjQbkYd2WalVHd+W4XmzttR78xvlFbe
         7g+9W8lCeXU+Ej30+aCr7t0SfysO8D5umlXpf3m+NmgM8R+RGIFxo7y/3dw81Y28zSwc
         +GJd0spS50VmuG1WGVDaE8aOwalCumtGOEkVwPsAwVolWfmmfDSyiUs91SEi8xHg2+hq
         FP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769170059; x=1769774859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csWiFggnlzzQqaTFBhcmY3kJIz5jKn4iXDqtXXVFf7k=;
        b=rz8uNOMBhu/kXu47vkxJX0togXFS0johUi45kQI9bFb5hw297EczoSXFrh47EgfRez
         IaOOXByhFJJp+O3k9cYf4yYujoi/cw8zfO+C3+707fK40OONJ8oiWZKwwyIQJQxtIUaL
         JqKd1U4lTlcmdz8MKU+aputeciSqD3MjK1/W4HVT9d984HsEP8yPVZyqH82glQ1Z9x0i
         mzm2+/vxTrrE0mpPXEVLnpOIiu51tDfGfpX+uzc566rJRSU9JVmHm16tWnHM72n2+AAi
         i0sOePmBhxY3bt8Q0Y+F6FC/50GeeRkPmdm/w31jEkowlxaEsb58ISSR09DSliSsomr8
         GXIA==
X-Gm-Message-State: AOJu0YzmXZ6uFIqoTToxpDmHhVRzGy/IkT1U/WQK6q9HQiQyMc3o0pxF
	9Rl5766M8683TrzhV42lySUVvzjOT7OQ3b2Kpoase+Mk0J7SdRcsUvghKyT/lYlDNIjjCW673wG
	0dprUQOc=
X-Gm-Gg: AZuq6aJbDGuvhluMgD5TuvPc2KL12XVXUqxdlSNvn4kLHSxlz2j0F5LMVJg/wn6bFBo
	hIDBd+CfnEjA4mONgBjM2y4XuSwabS7dLb6G326GOOtwoVhf5zb+gima2h/k7D4louatuEebNv9
	P8o0Rz/Cf0anuU+fea4dEgZAo4xG6EFYqE5TyZ1MAlboaIYnFlAPNVEYC59SavZIs6HDOnBXOBv
	NBS0JPwdgRq5sZALx/GkWSno1ynTrDzTgmb1hyNAlKlKw+hG4UXZYvBUgeJJehjdD5kPUYkW/w7
	0FzSOkDO/KpHO2kRDMEwZ7AtpwclnsFZ7g1wM++XhAnq0zZZftbDavdfD8FajJJ5irKUdvMv5Vt
	uOLYdB3JcdxG99BeX35r2/pgBvKUgP40S3JECyOIsVFB8KLFrVz/5KtPX0INeyPOk+B9DuWyv8L
	KXwxNDceh2283TpRNMPTrp5w5SX9cvF7ku2GvwYWvtaLLb/n9c0ckAhY8PVN89Zj4C51S029i8Y
	jbcvA==
X-Received: by 2002:a05:600c:4e4e:b0:47d:4fbe:e6cc with SMTP id 5b1f17b1804b1-4804c9596aamr43962955e9.13.1769170059106;
        Fri, 23 Jan 2026 04:07:39 -0800 (PST)
Received: from localhost.localdomain (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e715bfsm6654115f8f.22.2026.01.23.04.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 04:07:38 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Chen Zhen <chenzhen126@huawei.com>,
	Jussi Maki <joamaki@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net] bonding: fix use-after-free due to enslave fail after slave array update
Date: Fri, 23 Jan 2026 14:06:59 +0200
Message-ID: <20260123120659.571187-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,blackwall.org,huawei.com,gmail.com,iogearbox.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252830-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1E45D758BC
X-Rspamd-Action: no action

Fix a use-after-free which happens due to enslave failure after the new
slave has been added to the array. Since the new slave can be used for Tx
immediately, we can use it after it has been freed by the enslave error
cleanup path which frees the allocated slave memory. Slave update array is
supposed to be called last when further enslave failures are not expected.
Move it after xdp setup to avoid any problems.

It is very easy to reproduce the problem with a simple xdp_pass prog:
 ip l add bond1 type bond mode balance-xor
 ip l set bond1 up
 ip l set dev bond1 xdp object xdp_pass.o sec xdp_pass
 ip l add dumdum type dummy

Then run in parallel:
 while :; do ip l set dumdum master bond1 1>/dev/null 2>&1; done;
 mausezahn bond1 -a own -b rand -A rand -B 1.1.1.1 -c 0 -t tcp "dp=1-1023, flags=syn"

The crash happens almost immediately:
 [  605.602850] Oops: general protection fault, probably for non-canonical address 0xe0e6fc2460000137: 0000 [#1] SMP KASAN NOPTI
 [  605.602916] KASAN: maybe wild-memory-access in range [0x07380123000009b8-0x07380123000009bf]
 [  605.602946] CPU: 0 UID: 0 PID: 2445 Comm: mausezahn Kdump: loaded Tainted: G    B               6.19.0-rc6+ #21 PREEMPT(voluntary)
 [  605.602979] Tainted: [B]=BAD_PAGE
 [  605.602998] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 [  605.603032] RIP: 0010:netdev_core_pick_tx+0xcd/0x210
 [  605.603063] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 3e 01 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 6b 08 49 8d 7d 30 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 25 01 00 00 49 8b 45 30 4c 89 e2 48 89 ee 48 89
 [  605.603111] RSP: 0018:ffff88817b9af348 EFLAGS: 00010213
 [  605.603145] RAX: dffffc0000000000 RBX: ffff88817d28b420 RCX: 0000000000000000
 [  605.603172] RDX: 00e7002460000137 RSI: 0000000000000008 RDI: 07380123000009be
 [  605.603199] RBP: ffff88817b541a00 R08: 0000000000000001 R09: fffffbfff3ed8c0c
 [  605.603226] R10: ffffffff9f6c6067 R11: 0000000000000001 R12: 0000000000000000
 [  605.603253] R13: 073801230000098e R14: ffff88817d28b448 R15: ffff88817b541a84
 [  605.603286] FS:  00007f6570ef67c0(0000) GS:ffff888221dfa000(0000) knlGS:0000000000000000
 [  605.603319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [  605.603343] CR2: 00007f65712fae40 CR3: 000000011371b000 CR4: 0000000000350ef0
 [  605.603373] Call Trace:
 [  605.603392]  <TASK>
 [  605.603410]  __dev_queue_xmit+0x448/0x32a0
 [  605.603434]  ? __pfx_vprintk_emit+0x10/0x10
 [  605.603461]  ? __pfx_vprintk_emit+0x10/0x10
 [  605.603484]  ? __pfx___dev_queue_xmit+0x10/0x10
 [  605.603507]  ? bond_start_xmit+0xbfb/0xc20 [bonding]
 [  605.603546]  ? _printk+0xcb/0x100
 [  605.603566]  ? __pfx__printk+0x10/0x10
 [  605.603589]  ? bond_start_xmit+0xbfb/0xc20 [bonding]
 [  605.603627]  ? add_taint+0x5e/0x70
 [  605.603648]  ? add_taint+0x2a/0x70
 [  605.603670]  ? end_report.cold+0x51/0x75
 [  605.603693]  ? bond_start_xmit+0xbfb/0xc20 [bonding]
 [  605.603731]  bond_start_xmit+0x623/0xc20 [bonding]

Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
Reported-by: Chen Zhen <chenzhen126@huawei.com>
Closes: https://lore.kernel.org/netdev/fae17c21-4940-5605-85b2-1d5e17342358@huawei.com/
CC: Jussi Maki <joamaki@gmail.com>
CC: Daniel Borkmann <daniel@iogearbox.net>
---
 drivers/net/bonding/bond_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e7caf400a59c..9a9edf52b651 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2202,11 +2202,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		unblock_netpoll_tx();
 	}
 
-	/* broadcast mode uses the all_slaves to loop through slaves. */
-	if (bond_mode_can_use_xmit_hash(bond) ||
-	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
-		bond_update_slave_arr(bond, NULL);
-
 	if (!slave_dev->netdev_ops->ndo_bpf ||
 	    !slave_dev->netdev_ops->ndo_xdp_xmit) {
 		if (bond->xdp_prog) {
@@ -2240,6 +2235,11 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			bpf_prog_inc(bond->xdp_prog);
 	}
 
+	/* broadcast mode uses the all_slaves to loop through slaves. */
+	if (bond_mode_can_use_xmit_hash(bond) ||
+	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
+		bond_update_slave_arr(bond, NULL);
+
 	bond_xdp_set_features(bond_dev);
 
 	slave_info(bond_dev, slave_dev, "Enslaving as %s interface with %s link\n",
-- 
2.47.3


