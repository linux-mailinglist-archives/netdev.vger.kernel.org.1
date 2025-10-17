Return-Path: <netdev+bounces-230281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E595BE62E0
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 05:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D3134E440B
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 03:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C968122A4EE;
	Fri, 17 Oct 2025 03:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duPOScv+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAA8130A73
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 03:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760670202; cv=none; b=hOn/DczJ+UQ7ME+BbFaznRrWhigoZzCIL2Wicn4WP3tn6k3Vsz2WrgcfWx6hTDb8121JdGYT384M5b1PYJ3zGjJxqIk8UP8wz80I+Cg5XggcvHhPSlzrEnSFwL8MCyQ2OedFL9qRbs3rd+IcSN5uVCU0WlORVrHsB2ud+pQOx4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760670202; c=relaxed/simple;
	bh=1B4E51onwsNNiRfncFUibshDpTbkfPUB0hQ0l1hmEXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gmbhLtisqEZmd4IZ2xmtxclpVdeNtAEBVD1PnRywLIjeE3trX+naZfpj+tJIw2eCxrRKIggqRt5P4sEhzJu4xU0gw13KV6rCz4330Ywye1GhhOsM0CQTijEWIw8k5MvfTGU/scbRMSJYAyNK3K5naLZUmKVtW2+xViy20BvqayU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duPOScv+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-789fb76b466so1418167b3a.0
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 20:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760670200; x=1761275000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZtF98NWa2X51rR/Kih4oN8w/UI8MUbJoL/ouk+zwMU=;
        b=duPOScv+uvDyngqg7J1VNAzoKoaQ9cSVmbm32+4liSbm1Ki52liKQfRxW12dh75ANX
         ZyhtPYd65NCBdIFpOO+N59T2WpNpXVarPtYOfe2kjUIvXA7BzZ5+bw7BkQeoTcCaNHrx
         zVeOh6bo8Z2Gnd5QP6ZoPPK0Zf8Tz+HlPz6EiQivTu7W9qi1/oX3f+Rwh/K1fx06R8HR
         5MMk6eXwVmemPSoC0I5FOrc/UxdN5642FTfX4A1C8i62BH9wkIVxydcjvvdiBhkLgrTi
         AgkHphY2IchQYTobk4Ax7E9Z7Hoj+depBNfF0wPEiNCLCbtYGUNzejWTZSrFLqVwTmhl
         Hbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760670200; x=1761275000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ZtF98NWa2X51rR/Kih4oN8w/UI8MUbJoL/ouk+zwMU=;
        b=lzFBqDBri1IkWgRVRGIaGtaFnuekkpEq3Zgys8S5U23FwQhlvYmBaCV1ToiC0bUjEt
         NmgZDUKJi7g3FibXr2NqaEN1Oa6ml1o4RjpWK2CHyhnVXt3gbFG0/vnjRFD81WmiknAC
         ZLRDBf3+TM2Fsig15AMNBCmY84ktMi2V9zO5c5xh1Rg0FO2mnLrSBu6dOgvETEwKI02t
         uu/8dNsofS4d0BfHEYYZliq/HhOnDYlZBPYubub7KmgzROLq28WcLAlAKFhKeRO3Pn/9
         cfvjkQ7ivOVevETypU5FevgZrmJkXyFyM+9S0GCaZLbXnwpukYcSEf5auf89yLG9YMVn
         hH1A==
X-Gm-Message-State: AOJu0YzdsMpT85PH0Jy8KXP/ZigwUGdQdOBFQ+6oTyAZw5rCUWx4wPCt
	zEpnqPr1iSiYhsXPZdslhB9oWERrF6DUzcqUdCQAAd7vyAYFcCO/ZXLiIEXtLWRYhLU=
X-Gm-Gg: ASbGncsNGJGpDoIMi3KTm2hP0oBtfaUoueXvEB7S49cy3JqO8cuspW3eRDmlC7BRgGI
	4ncSUnuQ44Vz0W/0YcH2tV6APS8Uq9IGx3O1gzwGSwf80qvrOLwDThucOHDhrnP1yRC5PSrFyYN
	36x8z653bT/V0h6mjM5TCLLFqLVFmlKmwgPOMSdpO3KYwsYqWRsLQheFfYvJfW5YE7FNpIHzxf+
	bnBINlZ+xEVGgUJXs3wkemAkGEyDoRu70P/Bef544tb7avaRNgVDS9NZPbi6lO0kigZZAMydsIX
	wHErNWbnlmvVmRYfMSO4nVNmhLul0nGroLiyIl9Ms5JOrc9h7ABnSFzq0IDv640cGI/l8g41LBg
	VfF1pcV8CkO6xFeZxyf6S9G+e4Xl7ZhfouQZV+GKUu7OVjZoRY7Fur1T/F8FXoohLulAki8jju8
	gMskD/FioLbi8qRiU=
X-Google-Smtp-Source: AGHT+IEE2CjQtwKykmr71vE4TiWtSb8glnok2mfsqd6fWZASwTaDzcijb+Z64VK4T/D89eoeF3yUMw==
X-Received: by 2002:a17:903:46cd:b0:28e:7fd3:57f2 with SMTP id d9443c01a7336-290cb65ca5emr28692925ad.49.1760670200195;
        Thu, 16 Oct 2025 20:03:20 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7c23fsm46351905ad.74.2025.10.16.20.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 20:03:19 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next] bonding: show master index when dumping slave info
Date: Fri, 17 Oct 2025 03:03:10 +0000
Message-ID: <20251017030310.61755-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, there is no straightforward way to obtain the master/slave
relationship via netlink. Users have to retrieve all slaves through sysfs
to determine these relationships.

To address this, we can either list all slaves under the bond interface
or display the master index in each slave. Since the number of slaves could
be quite large (e.g., 100+), it is more efficient to show the master
information in the slave entry.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_netlink.c | 4 ++++
 include/uapi/linux/if_link.h       | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 286f11c517f7..ff3f11674a8b 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -29,6 +29,7 @@ static size_t bond_get_slave_size(const struct net_device *bond_dev,
 		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE */
 		nla_total_size(sizeof(s32)) +	/* IFLA_BOND_SLAVE_PRIO */
 		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_ACTOR_PORT_PRIO */
+		nla_total_size(sizeof(u32)) +	/* IFLA_BOND_SLAVE_MASTER */
 		0;
 }
 
@@ -38,6 +39,9 @@ static int bond_fill_slave_info(struct sk_buff *skb,
 {
 	struct slave *slave = bond_slave_get_rtnl(slave_dev);
 
+	if (nla_put_u32(skb, IFLA_BOND_SLAVE_MASTER, bond_dev->ifindex))
+		goto nla_put_failure;
+
 	if (nla_put_u8(skb, IFLA_BOND_SLAVE_STATE, bond_slave_state(slave)))
 		goto nla_put_failure;
 
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 3b491d96e52e..bad41a1807f7 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1567,6 +1567,7 @@ enum {
 	IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE,
 	IFLA_BOND_SLAVE_PRIO,
 	IFLA_BOND_SLAVE_ACTOR_PORT_PRIO,
+	IFLA_BOND_SLAVE_MASTER,
 	__IFLA_BOND_SLAVE_MAX,
 };
 
-- 
2.50.1


