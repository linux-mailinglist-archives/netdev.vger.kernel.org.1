Return-Path: <netdev+bounces-268360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FO1OmyluGkChAEAu9opvQ
	(envelope-from <netdev+bounces-268360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:50:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 529F72A253D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EAB63027104
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DB21A316E;
	Tue, 17 Mar 2026 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="dd6ULBh6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADDD18A921
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 00:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773708650; cv=none; b=c+x5a5DAw9j12KpRMIuS+kNeOFXLK8u4q/NpJD/kgYE54VDOa9jTTbvUpUe+Rb6AujhNsAa+/qU1D3PkCCTisdXTwWXUeGMlcePNe6xFYpGZ1AwKHb7WbQNc2TQkzk3/wVSLbzAcPZfAFmhZDKO8sSd6wJYuQOtZqBcaqECBKGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773708650; c=relaxed/simple;
	bh=KM7tir5IujC1yR++vgY1bNwFjKvf+W5KrfvsVptFnN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YYwiJZ1ItBwRr8AXvro0q/H5RzNbq6jlXLOkE5H8UjV9b7bQ3Hp9FesXbWrbFs1w4ifdQnEfQbeWPypzjUsLCgN6oygvh5J4GIPjlmNczNBkH4Vh0XgWhuB+qUdv5u9TYN0l0jdfx9ult7pMT0sLkL3lpRxhTwNEW0Q9Nq3r68w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=dd6ULBh6; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ba895adfeaso5035261eec.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 17:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1773708648; x=1774313448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dtQGs38p1kSrvt9+xtFa1nMwW44+cr4RmbEV83m07y0=;
        b=dd6ULBh6Hs3cGcA1YFu1cbcXNhr7rnVnXEIldqViIcaLJ2Ln8CDPUUD+DXclGRvlCb
         QdZvcRjnQ/aFlDLZs+FsBfa192N4EEWAwCcFTNfuJb7GIhayaYjUou+LpqklMtDQOBV2
         rIoqCIN7TbPPkwndsL49bMdenhgAcWyihVCuKJq2UEU6799sN3PfTflJwNmiy5wgRT/B
         BrUK0VFGsjwKTwUUVHke1SLidcl+IUeIJo1oT+hXRwy/Ry5VhuGq4z6KSNy8QrAdE7/i
         r6zpgQ9uU26LtRXZN1E+uBG4tKIYR3P+uwGS/oToqr++jVRoC/r4vVQ3/zBGE8eM0SOX
         ju/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773708648; x=1774313448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtQGs38p1kSrvt9+xtFa1nMwW44+cr4RmbEV83m07y0=;
        b=JTEzI32FNko3A02RjLozXMKcM8G+2pw+eKQQ0qT3JsFBYwIc1Y4coBoSU2x5z3C9qK
         bL6AKb8IOTpLUb4VUexb/ztqOceW7OUT+JdxrXTR4M9gjsxqAWpi7vF5iHhV63FZ2rPc
         8ZDNZTvRRdTQbyQpq5yEZ/SszR0skd2mfYQYr704UflZ1/iPY73kngonWl5w7ODKiBCX
         sriRTZ/K8yk2BWChiV5atO2YaMIyV5ZBI2fpFh1QVZNTwbB3ZFbCsXwJU1p6h03dA+nJ
         Dd+mR68ePOY29Jn6hOc1Hc2qYme0XXWGFF6FD31e05x2o7gIuZwn5f7AW0ajsyafLWLL
         cvsQ==
X-Gm-Message-State: AOJu0YzzczPwYx6MbEWW7gYfKu9SF+13/pbZoi7xo4L91olv9clFFX9u
	9LvPxx40rZ2aMppIX2LZ/+6iNGt1wePWlyXpidogZCU2bjkNaOIVFy8qJrA4eZgicZKK67cdUN2
	mOYYN+w==
X-Gm-Gg: ATEYQzygbvmUBs0b1loxF3Jmv2Xy5s9rZA6BOxPoY68BKQJM3lZ637bJCmHF/82EZog
	SLlmWhlG9dekY2JHu+/l/rnMmuK+hLDs3gHjE2crufGJQNp9fQSIWG+pYqbFRJlXuZUcS+cdI1z
	6igVXLBEn1qAV+7uLCHCb/+NXzJjUYO0zR29lTwuRMruqMz3UQorPD2VjXwTpm3R+x4r5aT8elr
	bFOtfMHocU0uOvwPPkSSGtFXaqPPGGAI4899nuyQjRLZENK5bm1CPPCvYZozng7eVg+H8gvp3Xa
	nwh2NY+ZNpzKMNa9szilAnjQNjS7WzMMeDf1FeEgz3NyMC5A439QVgziFdrsaKbjCLaqXZ0TBI5
	Yoa0uUbASaj2RbYs1jK9nkNGMZeVrL0Mo7oRJ93mNZJvqUHaSoruGuuB0T0Mhx48AS3lxal6j8/
	AnUexNg9TK85NAGMa+02jT2sCPvmTkY6aOSn+qa3XcCZCsNp4ORP/IY2MRxVrTuDD+
X-Received: by 2002:a05:7301:128d:b0:2be:19f3:5a03 with SMTP id 5a478bee46e88-2bea54a145emr7135861eec.17.1773708647788;
        Mon, 16 Mar 2026 17:50:47 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab555c44sm20154955eec.25.2026.03.16.17.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:50:47 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2] net: bonding: fix NULL deref in bond_debug_rlb_hash_show
Date: Mon, 16 Mar 2026 17:50:34 -0700
Message-ID: <20260317005034.1888794-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,asu.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268360-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:dkim,asu.edu:email,asu.edu:mid]
X-Rspamd-Queue-Id: 529F72A253D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rlb_clear_slave intentionally keeps RLB hash-table entries on
the rx_hashtbl_used_head list with slave set to NULL when no
replacement slave is available. However, bond_debug_rlb_hash_show
visites client_info->slave without checking if it's NULL.

Other used-list iterators in bond_alb.c already handle this NULL-slave
state safely:

- rlb_update_client returns early on !client_info->slave
- rlb_req_update_slave_clients, rlb_clear_slave, and rlb_rebalance
compare slave values before visiting
- lb_req_update_subnet_clients continues if slave is NULL

The following NULL deref crash can be trigger in
bond_debug_rlb_hash_show:

[    1.289791] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    1.292058] RIP: 0010:bond_debug_rlb_hash_show (drivers/net/bonding/bond_debugfs.c:41)
[    1.293101] RSP: 0018:ffffc900004a7d00 EFLAGS: 00010286
[    1.293333] RAX: 0000000000000000 RBX: ffff888102b48200 RCX: ffff888102b48204
[    1.293631] RDX: ffff888102b48200 RSI: ffffffff839daad5 RDI: ffff888102815078
[    1.293924] RBP: ffff888102815078 R08: ffff888102b4820e R09: 0000000000000000
[    1.294267] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888100f929c0
[    1.294564] R13: ffff888100f92a00 R14: 0000000000000001 R15: ffffc900004a7ed8
[    1.294864] FS:  0000000001395380(0000) GS:ffff888196e75000(0000) knlGS:0000000000000000
[    1.295239] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.295480] CR2: 0000000000000000 CR3: 0000000102adc004 CR4: 0000000000772ef0
[    1.295897] Call Trace:
[    1.296134]  seq_read_iter (fs/seq_file.c:231)
[    1.296341]  seq_read (fs/seq_file.c:164)
[    1.296493]  full_proxy_read (fs/debugfs/file.c:378 (discriminator 1))
[    1.296658]  vfs_read (fs/read_write.c:572)
[    1.296981]  ksys_read (fs/read_write.c:717)
[    1.297132]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
[    1.297325]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Add a NULL check and print "(none)" for entries with no assigned slave.

Fixes: caafa84251b88 ("bonding: add the debugfs interface to see RLB hash table")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: trimed the crash log

 drivers/net/bonding/bond_debugfs.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_debugfs.c
index 8adbec7c5084..8967b65f6d84 100644
--- a/drivers/net/bonding/bond_debugfs.c
+++ b/drivers/net/bonding/bond_debugfs.c
@@ -34,11 +34,17 @@ static int bond_debug_rlb_hash_show(struct seq_file *m, void *v)
 	for (; hash_index != RLB_NULL_INDEX;
 	     hash_index = client_info->used_next) {
 		client_info = &(bond_info->rx_hashtbl[hash_index]);
-		seq_printf(m, "%-15pI4 %-15pI4 %-17pM %s\n",
-			&client_info->ip_src,
-			&client_info->ip_dst,
-			&client_info->mac_dst,
-			client_info->slave->dev->name);
+		if (client_info->slave)
+			seq_printf(m, "%-15pI4 %-15pI4 %-17pM %s\n",
+				   &client_info->ip_src,
+				   &client_info->ip_dst,
+				   &client_info->mac_dst,
+				   client_info->slave->dev->name);
+		else
+			seq_printf(m, "%-15pI4 %-15pI4 %-17pM (none)\n",
+				   &client_info->ip_src,
+				   &client_info->ip_dst,
+				   &client_info->mac_dst);
 	}
 
 	spin_unlock_bh(&bond->mode_lock);
-- 
2.43.0


