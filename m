Return-Path: <netdev+bounces-192914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4464DAC1A04
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 04:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606C19E46B4
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 02:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31325170A0B;
	Fri, 23 May 2025 02:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPxJLOqu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DC23B7A8;
	Fri, 23 May 2025 02:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747967005; cv=none; b=ejAjiO16IzxmQGXtm41gJbzWFJYnw0P3LWQKD/j976xkkFnFajBTtat1ROFyh69Bstw0dZaAlmRG+p81uYv7MtnRviKi3nPjedYLhT9iUXNS72bgmPZyYtI+J+UNjUVwrvAkMbNysBmC9tVL1dbolIwDbjktKsyEW9lvuHF994I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747967005; c=relaxed/simple;
	bh=TF+xokCPhoXV3uQH9vkP5LG3jLW10BUQ6yKU+QJC6Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FdW3VDmpMHCpu/Zn0MX5wS9XbkRYpLV4gzm+IS8v0r5NYvfx5ZMjQY0m/b3MNTSyT9Da77M3h6bVB88EgsF4s5LtTCE9EEwee3k2TInnTsmWlhIZwvGYvoza6RW59OIe6/d01GYeXVcv2e3UETLq3X67OWKUB9999YJ3m68Zbi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPxJLOqu; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b1f7357b5b6so5493387a12.0;
        Thu, 22 May 2025 19:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747967002; x=1748571802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PFQ//U4oIhIXdrjEYifV2TUXSUu8792YPU9aygo692Y=;
        b=CPxJLOquTLYbzvwUHmvgRBdNYXgtNQcbv23cl8dtX52yuuI4wJ5lwDzNiAZDOktuDx
         au+eXz7qkns08h51PnxZTFjIyGY0FFZl5SulTloNyj7s9WzjUnhf9KORSd0DFSN7P93U
         +qNjL9RM7rVoZKR8UW4xU5fo1n5SZ6YpKAGrxw+awdinGNIlBwWGAGtGsImIY6zNiG0O
         /yrDypL1/ttc/QavjNHZuSHPOzLeQL4NRmFQiQ4Bq8FN+prrVchQo4PCs9Qss/TJmMxo
         Cj9k7lol2FIgWEOhpJnqI3B3M6PA7KjfWYZdoJGqozFdy5/oWHSlBhRue9JdcdY4Cmdr
         ZvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747967002; x=1748571802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFQ//U4oIhIXdrjEYifV2TUXSUu8792YPU9aygo692Y=;
        b=fZ6skZCYnMS4hxHual4LeBqxWslbokC1wS/ePHGKbOFIHW9kGZ7Fh8Yi7qydSn3AMa
         c5CPhGnKafg5mEiUq1eoGuQuzFr3ucV7kMUEvxdy2TSwb3iI/pBr3vkU2vKbsMy+8rIO
         mzlsHw3Z7uFwnyum59MVF05ZPaZsTznDaclA814UEjbqShKMN1CG7YZstsIhMf7AGdhQ
         E4xT54UfW7CQEQCzauKg4Ubw+F+fm+zS4i5EBJQTI/+yGJZCXxsPcmfNt6r7+0weBz3u
         ROWelI6H3EDjN1yiXOrIgIDtjVKhabXnC0QyUdf5zg4NORDfjdf42YiFxmZrtv2Id3nq
         zr7g==
X-Forwarded-Encrypted: i=1; AJvYcCVYV7Ge0eYsS4ANahXTl30/9/dnUGSvCyQtRlHhhIOkIi69LixgS+QO+2KI1XJ3n2t7yIvcRq02mxHGZMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg+BRajtVVXGqcM77qCwhqdhnyQPRU2EJDasYw+qF6kqKQJB7o
	l4wB7xHRuf+LWgippOjMj0tJvn+KaAs6y377cm0j7BVS5mTNuWCb55zjPH6+eRwFDAvvxQ==
X-Gm-Gg: ASbGncv1gtcKU/4iAbvUcHvvmsC/8pCBw2yGOLMuW59Dv7G1K/RKvfbhusAhOo439Xd
	AE0cC+YgKpVj4+L0L53RD9v0wxARMoWqLJFp9J3VIN9WLUNK96+ikxM3NYEwnShUtXHvcTDYrCI
	uKL1KqMLuB0j8yRIg+pqwY4oXd5PYD3XgoD5kW6iqa4xFDbV9hU66nE+C30pBHdVnfEPi25W8b6
	VJN0E3WP1piJevCNte4t1epiV2/tjv8lZ3E0frxyc+ay0g6gOHstWH4HHKz7W9aaW5HnKbFuK/0
	Ar+VoaVgMhFV5rZVmv3Yes8WkZhjtOqKGpREDAkMKEFBKF8jRqEQbB6fq2ykkTKbeq0Z7XQ=
X-Google-Smtp-Source: AGHT+IF+vdL+C7aa2hcNhReRVwiOAXc03EchlafM5myjN7kJ5idf22mz1Phve5rX0+oMHMIie71tww==
X-Received: by 2002:a17:903:1987:b0:223:5e76:637a with SMTP id d9443c01a7336-231d451906dmr410903445ad.23.1747967002497;
        Thu, 22 May 2025 19:23:22 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e988c3sm115034915ad.120.2025.05.22.19.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 19:23:21 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Liang Li <liali@redhat.com>
Subject: [PATCH net] bonding: fix multicast MAC address synchronization
Date: Fri, 23 May 2025 02:23:13 +0000
Message-ID: <20250523022313.906-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a corner case where the NS (Neighbor Solicitation) target is set to
an invalid or unreachable address. In such cases, all the slave links are
marked as down and set to backup. This causes the bond to add multicast MAC
addresses to all slaves.

However, bond_ab_arp_probe() later tries to activate a carrier on slave and
sets it as active. If we subsequently change or clear the NS targets, the
call to bond_slave_ns_maddrs_del() on this interface will fail because it
is still marked active, and the multicast MAC address will remain.

To fix this issue, move the NS multicast address add/remove logic into
bond_set_slave_state() to ensure multicast MAC addresses are updated
synchronously whenever the slave state changes.

Note: The call to bond_slave_ns_maddrs_del() in __bond_release_one() is
kept, as it is still required to clean up multicast MAC addresses when
a slave is removed.

Fixes: 8eb36164d1a6 ("bonding: add ns target multicast address to slave device")
Reported-by: Liang Li <liali@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 9 ---------
 include/net/bonding.h           | 7 +++++++
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 8ea183da8d53..6dde6f870ee2 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1004,8 +1004,6 @@ static void bond_hw_addr_swap(struct bonding *bond, struct slave *new_active,
 
 		if (bond->dev->flags & IFF_UP)
 			bond_hw_addr_flush(bond->dev, old_active->dev);
-
-		bond_slave_ns_maddrs_add(bond, old_active);
 	}
 
 	if (new_active) {
@@ -1022,8 +1020,6 @@ static void bond_hw_addr_swap(struct bonding *bond, struct slave *new_active,
 			dev_mc_sync(new_active->dev, bond->dev);
 			netif_addr_unlock_bh(bond->dev);
 		}
-
-		bond_slave_ns_maddrs_del(bond, new_active);
 	}
 }
 
@@ -2350,11 +2346,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	bond_compute_features(bond);
 	bond_set_carrier(bond);
 
-	/* Needs to be called before bond_select_active_slave(), which will
-	 * remove the maddrs if the slave is selected as active slave.
-	 */
-	bond_slave_ns_maddrs_add(bond, new_slave);
-
 	if (bond_uses_primary(bond)) {
 		block_netpoll_tx();
 		bond_select_active_slave(bond);
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 95f67b308c19..0041f7a2bd18 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -385,7 +385,14 @@ static inline void bond_set_slave_state(struct slave *slave,
 	if (slave->backup == slave_state)
 		return;
 
+	if (slave_state == BOND_STATE_ACTIVE)
+		bond_slave_ns_maddrs_del(slave->bond, slave);
+
 	slave->backup = slave_state;
+
+	if (slave_state == BOND_STATE_BACKUP)
+		bond_slave_ns_maddrs_add(slave->bond, slave);
+
 	if (notify) {
 		bond_lower_state_changed(slave);
 		bond_queue_slave_event(slave);
-- 
2.46.0


