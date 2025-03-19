Return-Path: <netdev+bounces-176027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E444A6866D
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 09:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB37719C5F60
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 08:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0352505A6;
	Wed, 19 Mar 2025 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9ph8WfQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10AE211484;
	Wed, 19 Mar 2025 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742371806; cv=none; b=OokdUGPcbtdPNIENQPuKJ8YYvfE4KGVmE4p02OJCIG4RB5iw/eFelcWBV947ZSAs0kGR6D8hzC7VzC9R0ZfQKVcpXf85h7JXdangMBeHN//ASu8h3N1mfFFT4J7JudR/wu2rWtB7Ha82gecEiIf/i9gmEtUR7h5zPC/SQHeVCjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742371806; c=relaxed/simple;
	bh=UWwDxgD2Dkqyxh4zYhiRoW7Q5tRrS3UFVxMch/bPwUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bJgzSc530dIVfPMRwqexyr2g1mL91V4ap9cxX4dTH8DS9f0e5y5/k4eFEd0oKWEYdmJVkSkp0irkk1VqyN7Gu4FL+mR4yqshSty2OrZJMgxaClxwNU4ToC+fid0YwiHpCSHMjouvV/z9EZkXGouDvTduLVM9UkeH5kvH8uTOaAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9ph8WfQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2239c066347so139795285ad.2;
        Wed, 19 Mar 2025 01:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742371803; x=1742976603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ghVx15wxQvBHmCmVmekyri1ddef/5H7N9UsltOiVuHA=;
        b=Q9ph8WfQwyxYEYHDiOSywNdsavK595ifvXyOmRHVN4O+BcrAXQqaJ1YpB0aJ0h6jJ3
         ToF5+O+jRk8PZ5iFhpsxBnfpacat7hItSk7oSmxE6hlLKQaKiBmigbR8QLAtgOr6VeLB
         WvqtG8pR0JpWIE1qh1AUV5mALJGqPgsrWSNn8DohbDkjFim69unGhs9PoPOOtNoGYOPH
         hfqyY0I5gcxdLNkrt0MGlOjdrcoY0EY2XVLJXMw97g3OjhJuU/CdeXrGqg3prkA6uE1d
         l+yQGo8MzaJeUCeLZyCjtSFW+MGakV73xvs5I2fu6HVCeMmBFiKPclMQBvzJh5uyKkwF
         Gerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742371803; x=1742976603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghVx15wxQvBHmCmVmekyri1ddef/5H7N9UsltOiVuHA=;
        b=lBJHktL9uXeDcQqaLfilynYJc8XK9UqiKiB+FOMrL5w/l7rSVGUeRb1wfh/0/j4LEG
         EavEH0yCUekh+GWbDMHL2WtGwiRbQnJYjjVWglY2pbo9MzV2OPBdWhLRqeUasv9JjVAg
         eJwD6NGU4GfXg0ugUIUJ5P03oWHWUsLnAb/lRBYWcwQpGurC4uHEpXi8hLJhZP5fn+29
         0spT1gwxyMpY2X+mLZ6XlkTeqKxpO4DvxlIrrHrzlbJAwCd1xRBKuyOuGppK1JPpRABf
         sgsb7pvs5L9yQyFnduDADhRCVVyF9BFQrxDt/u0WLjRir59SudzNczIiynpdu1U0ZLp5
         M/ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVo1WU4/443/zHt1AJY50bn077/Deo/92gTLXqTqG2txY/RWI3mTDMvMqbfRY+EU6UK87xS/14x9ByGaY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn2Gz6WJKYz/I/HkXWBJhowX3Tgiv7Nn3xlLukKDTKzAaXui+/
	GENakvwa8wRK/vsE1l7+kCCVrIIOlIz8+aFJUhCMg81cJq0YpaNQViwTW2MfbIM=
X-Gm-Gg: ASbGncuEcKca6kUsgKXrPkxDcsgwbKaOZU+IRhXg1KnpO0ZFcjq1IuxWA7xh5lH4vYB
	VLogci9uUEo6872uYboepvL/1SwCJRd2mxtEChR5/nw+bnHpVVdHUdxff25frZkUi2udA2Km2XO
	2++BrISE4QRRE2LlHF4/l/ejpeutfAVjZmeFmFw54SwSCCQrreiv2Zz2pp3lypkuLxjNLVH/LHT
	/UluJ3vLcnShZ0ModqNb9+Gd1Hdo/ckVBL0xOJ+4htOhgSQEwBNbs9aBs8I5MCCXgcJlh6u6tb9
	mxy0Y0ahfOlDTytiwSxk5LyzmbG7FjwL9OQYINm7/kKr/QYKsHNw+43j3RsdfFay
X-Google-Smtp-Source: AGHT+IFKmpB83PfEQAhGR1Rnnzf7CHGoeSGxrvIuzBE4olcAzPcraktOLFKC9AqQGWnS68sQlWYxgQ==
X-Received: by 2002:a17:902:ce83:b0:223:4e54:d2c8 with SMTP id d9443c01a7336-22649a36694mr29731675ad.21.1742371803474;
        Wed, 19 Mar 2025 01:10:03 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a40a7sm108023855ad.59.2025.03.19.01.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 01:10:02 -0700 (PDT)
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
	Hangbin Liu <liuhangbin@gmail.com>,
	Liang Li <liali@redhat.com>
Subject: [PATCH net] bonding: use permanent address for MAC swapping if device address is same
Date: Wed, 19 Mar 2025 08:09:47 +0000
Message-ID: <20250319080947.2001-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Similar with a951bc1e6ba5 ("bonding: correct the MAC address for "follow"
fail_over_mac policy"). The fail_over_mac follow mode requires the formerly
active slave to swap MAC addresses with the newly active slave during
failover. However, the slave's MAC address can be same under certain
conditions:

1) ip link set eth0 master bond0
   bond0 adopts eth0's MAC address (MAC0).

1) ip link set eth1 master bond0
   eth1 is added as a backup with its own MAC (MAC1).

3) ip link set eth0 nomaster
   eth0 is released and restores its MAC (MAC0).
   eth1 becomes the active slave, and bond0 assigns MAC0 to eth1.

4) ip link set eth0 master bond0
   eth0 is re-added to bond0, but both eth0 and eth1 now have MAC0,
   breaking the follow policy.

To resolve this issue, we need to swap the new active slave’s permanent
MAC address with the old one. The new active slave then uses the old
dev_addr, ensuring that it matches the bond address. After the fix:

5) ip link set bond0 type bond active_slave eth0
   dev_addr is the same, swap old active eth1's MAC (MAC0) with eth0.
   Swap new active eth0's permanent MAC (MAC0) to eth1.
   MAC addresses remain unchanged.

6) ip link set bond0 type bond active_slave eth1
   dev_addr is the same, swap the old active eth0's MAC (MAC0) with eth1.
   Swap new active eth1's permanent MAC (MAC1) to eth0.
   The MAC addresses are now correctly differentiated.

Fixes: 3915c1e8634a ("bonding: Add "follow" option to fail_over_mac")
Reported-by: Liang Li <liali@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 9 +++++++--
 include/net/bonding.h           | 8 ++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e45bba240cbc..9cc2348d4ee9 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1107,8 +1107,13 @@ static void bond_do_fail_over_mac(struct bonding *bond,
 			old_active = bond_get_old_active(bond, new_active);
 
 		if (old_active) {
-			bond_hw_addr_copy(tmp_mac, new_active->dev->dev_addr,
-					  new_active->dev->addr_len);
+			if (bond_hw_addr_equal(old_active->dev->dev_addr, new_active->dev->dev_addr,
+					       new_active->dev->addr_len))
+				bond_hw_addr_copy(tmp_mac, new_active->perm_hwaddr,
+						  new_active->dev->addr_len);
+			else
+				bond_hw_addr_copy(tmp_mac, new_active->dev->dev_addr,
+						  new_active->dev->addr_len);
 			bond_hw_addr_copy(ss.__data,
 					  old_active->dev->dev_addr,
 					  old_active->dev->addr_len);
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 8bb5f016969f..de965c24dde0 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -463,6 +463,14 @@ static inline void bond_hw_addr_copy(u8 *dst, const u8 *src, unsigned int len)
 	memcpy(dst, src, len);
 }
 
+static inline bool bond_hw_addr_equal(const u8 *dst, const u8 *src, unsigned int len)
+{
+	if (len == ETH_ALEN)
+		return ether_addr_equal(dst, src);
+	else
+		return (memcmp(dst, src, len) == 0);
+}
+
 #define BOND_PRI_RESELECT_ALWAYS	0
 #define BOND_PRI_RESELECT_BETTER	1
 #define BOND_PRI_RESELECT_FAILURE	2
-- 
2.46.0


