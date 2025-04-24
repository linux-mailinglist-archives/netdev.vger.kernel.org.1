Return-Path: <netdev+bounces-185395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E225FA9A010
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 06:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87B819445A3
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 04:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947B91AA79C;
	Thu, 24 Apr 2025 04:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI9XbPBa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2DC1A5BB1;
	Thu, 24 Apr 2025 04:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745468568; cv=none; b=Ruyy6k4pKZVhbgMI1gOxolMkN1Pa/e0iHsHU9mrEZAmgMUzV0E2Y+DTc0LG9jOHV7hUzpyselHJhvwv1oDqytAYHicK9QODZ3xuvOEuZbOZXJ3zY5K1iEx2FaHDgTfoJ56cXDbI6Xc5NO5wErlMa2ruugcGsko0V/IgvuSdVcC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745468568; c=relaxed/simple;
	bh=k7mSNxJ42IeX8+oBaC+9eG5tV3rnJjf2hOQcjiFV+gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nu8JQFwYKDDlSqU1l6blk3H2AHdjwnHPCd6RQfwxjMHgwzJFk5xeb/MO1ZWV9u++5VV6RMXgIK2b83Ox2WEzkryFz1AGCP3i9e/RpmZeMVFmQMHeT8PiWEcxRZYCZytVYKQta5AQjvhn1gxbdgBiaRyATb5LMYkysxpSgN2Q/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI9XbPBa; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2279915e06eso5676895ad.1;
        Wed, 23 Apr 2025 21:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745468566; x=1746073366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l48VmKjyd1hjWyqdUCoWl1DRDQUWv3KroilCq6okbCU=;
        b=SI9XbPBaY59HtdvLbpXMBCvIn7npntcnZhFz8lNKu6PIq4tY9W8ua+Fp68ynuPmRGN
         W1M11FyIe6I4WAP+GVGzR3K8Sp2A0syhsqWzXBvt/3jyENnAnIN2EZK/DoS/yrI1y0O6
         uARRPsoZ3zyl3LSTBfpPFH+IK8znwmQFUu8SjwEzqQZwgRKpe3bKz0wfutRNFmhfGbRM
         TCWcocApv4SZSIhS+kthxtZIN68n8HYJDkzGH/Dph7kM72qqI8ZgLJdFBFyG/xZVqU08
         UHFEw2ia1AQNoksxgfpxn800J8yqQnDuQYLqvcgeS0aOYn82vX06HjA6ZcHiqYewau85
         u0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745468566; x=1746073366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l48VmKjyd1hjWyqdUCoWl1DRDQUWv3KroilCq6okbCU=;
        b=K3oVK7J1jhp5RQUkdErX9BqGIET0QgOrxv2U6A4qjakVmh9yRR4pC5aUGFW+TT5W/+
         +fnl9LhkKw8iObJjrEm9mh84i5crKBcdSAhrNA0njSQx+S6vrS7YCkgJFBJXfR6v7bSs
         e9kGLOzRff6qJD2uyQZPAdgQa4XeBJCTexSDwm/MhuJyOg1IyEHnUsJv+nj4YSXpMSLm
         i/ORKWJKb9PStPWPDxiXh8rA4p0dl6Zw2BSnZ7AtZkSLtG1SjeTJbxGifuNPuf0lZXFf
         bvPsn5JwKcsWCxREPGOkRWZ6LshHiWEG5nAPhe3IPaTE+3UFNAHZG5UlNV4gIIMc9CJD
         vDZw==
X-Forwarded-Encrypted: i=1; AJvYcCVA4cWb4xMJ3dK+di4mbCkoUSMBCQumEGVNq/nRaL2vZrBiMQCPN02ATDy6A/e9Mf0MXlCNJrAqwT3Ivf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIDZkfVksyhSaLTRvLg8DljfPlxoK4G1H9mV7w+/mNPmPaEbXX
	B4YcmNpaSCSS1CSW/Gb+3llt7Szh2MxpAFWyP0EcCLdsXmqAyl1LYmCjCPy6CEQ=
X-Gm-Gg: ASbGnctzUbplfuayCvlxKYbn16Ny6XEvZ+XnFqgz71jeNSmclg7ywu2KJujYvtArkCQ
	7bH1iiWr68uOp1Y2ASd6ZqW67Owyn50gJafQunlgS7n7NLCyhxzNyPXylKnBtJwiNwqtCeORmdA
	PciOcRZ87AA3aBYkInjyLYX3CGDqJCfru6XHSwLl167eVjGCA6hj0V2soNeZpb/BgUV1nvBJzma
	YAbOsawpAPa2/wcMWc+DwwdSW7lM2exT4YbPJvt3mRzQAba6JSj7bNZkV1/BbKzxNsJKNIo/vGM
	teqPKK9oacE3XeTc3emuO7RSiga0BMBwjcepD9/f+3tzxwmCr8TggpI8zlaH
X-Google-Smtp-Source: AGHT+IEvkFE8TXwi6L8GeJFyOrztsPHvNnXtU+cFg0F+RstDB/vbewYAizz+P7uUkYua0v28Kb61hQ==
X-Received: by 2002:a17:903:22ce:b0:221:85:f384 with SMTP id d9443c01a7336-22db3bf170amr17099125ad.16.1745468565954;
        Wed, 23 Apr 2025 21:22:45 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef09689fsm239050a91.22.2025.04.23.21.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 21:22:45 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net] bonding: assign random address if device address is same as bond
Date: Thu, 24 Apr 2025 04:22:38 +0000
Message-ID: <20250424042238.618289-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change addresses a MAC address conflict issue in failover scenarios,
similar to the problem described in commit a951bc1e6ba5 ("bonding: correct
the MAC address for 'follow' fail_over_mac policy").

In fail_over_mac=follow mode, the bonding driver expects the formerly active
slave to swap MAC addresses with the newly active slave during failover.
However, under certain conditions, two slaves may end up with the same MAC
address, which breaks this policy:

1) ip link set eth0 master bond0
   -> bond0 adopts eth0's MAC address (MAC0).

2) ip link set eth1 master bond0
   -> eth1 is added as a backup with its own MAC (MAC1).

3) ip link set eth0 nomaster
   -> eth0 is released and restores its MAC (MAC0).
   -> eth1 becomes the active slave, and bond0 assigns MAC0 to eth1.

4) ip link set eth0 master bond0
   -> eth0 is re-added to bond0, now both eth0 and eth1 have MAC0.

This results in a MAC address conflict and violates the expected behavior
of the failover policy.

To fix this, we assign a random MAC address to any newly added slave if
its current MAC address matches that of the bond. The original (permanent)
MAC address is saved and will be restored when the device is released
from the bond.

This ensures that each slave has a unique MAC address during failover
transitions, preserving the integrity of the fail_over_mac=follow policy.

Fixes: 3915c1e8634a ("bonding: Add "follow" option to fail_over_mac")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v3: set random MAC address for the new added link (Jakub Kicinski)
    change the MAC address during enslave, not failover (Jay Vosburgh)
v2: use memcmp directly instead of adding a redundant helper (Jakub Kicinski)
---
 drivers/net/bonding/bond_main.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 8ea183da8d53..b91ed8eb7eb7 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2118,15 +2118,26 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		 * set the master's mac address to that of the first slave
 		 */
 		memcpy(ss.__data, bond_dev->dev_addr, bond_dev->addr_len);
-		ss.ss_family = slave_dev->type;
-		res = dev_set_mac_address(slave_dev, (struct sockaddr *)&ss,
-					  extack);
-		if (res) {
-			slave_err(bond_dev, slave_dev, "Error %d calling set_mac_address\n", res);
-			goto err_restore_mtu;
-		}
+	} else if (bond->params.fail_over_mac == BOND_FOM_FOLLOW &&
+		   BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
+		   memcmp(slave_dev->dev_addr, bond_dev->dev_addr, bond_dev->addr_len) == 0) {
+		/* Set slave to random address to avoid duplicate mac
+		 * address in later fail over.
+		 */
+		eth_random_addr(ss.__data);
+	} else {
+		goto skip_mac_set;
 	}
 
+	ss.ss_family = slave_dev->type;
+	res = dev_set_mac_address(slave_dev, (struct sockaddr *)&ss, extack);
+	if (res) {
+		slave_err(bond_dev, slave_dev, "Error %d calling set_mac_address\n", res);
+		goto err_restore_mtu;
+	}
+
+skip_mac_set:
+
 	/* set no_addrconf flag before open to prevent IPv6 addrconf */
 	slave_dev->priv_flags |= IFF_NO_ADDRCONF;
 
-- 
2.46.0


