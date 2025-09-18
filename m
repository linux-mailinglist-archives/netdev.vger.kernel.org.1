Return-Path: <netdev+bounces-224229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7547BB829A2
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 04:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352475888F4
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 02:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221101F462D;
	Thu, 18 Sep 2025 02:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOSDPpqd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9611E194C86
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 02:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160936; cv=none; b=s80uhKSAOVoUbjGRXfvn3guz5UxG2NGuX0P9XUX2TYybDhoTmdGa0knPF8Q+pf0DbCe4YKlC8LdjVQezia0zi0ohWNucUmg1iMq2Emblz2MRUW8lQ0m1qcqP01mPmFSvPLLIJUkwgV/tctjST2m6Ojpnnng86dP4i3pvaEPSPjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160936; c=relaxed/simple;
	bh=39hZAvpQH7zkG6OlmutysyBwA764hUu1rnmxK5kLQDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CbU6S+fM0PMJ7Ydp5wDQhSBIDQ5mj/ogNdm1o4bBuQi+5kla9JaxenWHSkt7Mmm09ygARJVH2nlBVvySLUAvO2aC3gey+LbTph/h74a1gYEbfTZaNc/bXU7VwR/PO8FHAlAOMPxPU3Tkw6r/4QNIEaac7TDqGabgbJE6OjorxhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOSDPpqd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-26060bcc5c8so4219295ad.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 19:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758160934; x=1758765734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mbsjyy/pOrWCUEBY3PlLlv5Me9QJPNkU3Ay1k3n9YXQ=;
        b=FOSDPpqdR5jIIHmOiyPPvi3i2fI8q+almsd0gDv/2mcggfgOfxf3hZoS8dYnjHG/br
         mStApKQtHDrUfNoq4q7tWUE94L8+sICmgdDmGwj6BwjKQwzh+b/uyNNp/iGVFKN7Zflj
         1POJXfpf/iueeFdtLuP1x2Bzgp83qA4gOy2U3GxXwQnPWNG54uAJiR9ONc96B86tdowj
         nSWW8qwGpT5ukPjnQF3uafUSoClIlPdwC6qU/G9Vbzh5Isu6859a8pnjdtAklvPsUEVX
         Dkm7yfPCFnvlraKe4FHztqasFimU2Rp3bhtjl76b1m+v+SmEVX9GFihaoVjDxfSsSpOq
         WN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160934; x=1758765734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbsjyy/pOrWCUEBY3PlLlv5Me9QJPNkU3Ay1k3n9YXQ=;
        b=Ih/zMvmB0+fTNYq1DvleR8EbnJ6C1mXx//QnBaiHlsQvHAXGttJnNTW0hdbgYUFrIg
         6Nx3MUhOptQT3J38rvdZ4WvrCS304eYP+Qa8QHly4MVT1SizWfkWeOcFBKhZ60sVccVm
         bxJ4KCRlkl6LreJ6RSBzPqXyvn0AdTXZ6P/J9zO9own/LnCTkLPfTFU2wjsCZ0GsUIKj
         I+cF7qpH5ShGWgT6pFdDXoDIsJf01B5XUxwhYrXmKvG8o2AqnoGyN0E+RqsErWB57qLk
         cKtYofofC4daMChj9wCQFyqI2C3YSkT+2dmO3aRDXtmPQEMHlwF09E8ByJfXRnaC7Dkg
         eDPw==
X-Gm-Message-State: AOJu0Yy58OkDLeZ09kc1I2J+e418mM5v+H38jkGIWqXgi7o4Hk54VUcF
	zzKNc2be9JSqOBqxrSC49Au6aFU1ItDGDmxBMbxwZQe/WDMXJKoY1GknekhUFXZ0lW0=
X-Gm-Gg: ASbGncvKOVyPdK776AniJPu2ZVhUuNs0n5kJ8m6RL+JA2xe7lwjMn7AOX3xNHsD3HUJ
	7SXTtDsyUvGYLoqDoP0KKg6vS1NvL21ajokMVcrgdrD5jWqByZOBtZLF2avB4B2JbcfQBdQWIhp
	WwvbrToqVlryoljop91ka8z/I3Lv/DRoDjovnscLhqyGH+NXG/sglrPSIqjCr+nZ0E9C2UtVIy2
	Eay3FtYDBw+9kHWYCLIaCiVnE6xRyuDbvjqve025+rh1rliDqzD/YaosdFbjnpVDmzXXRvvorgp
	gm4lE+K/kig2GQpT1LQgUDld2eEAkcru4MyTMiubXaXnWHVjzsWHIuFSCdeoGcGjuBNAUj808Wq
	d5/2fS0FIdo6/j0gYd87PSQpz+oAIHoHq8AhmFYZl/1i5UQk7Rs3k7BRd6Ap1
X-Google-Smtp-Source: AGHT+IGXc2xH+niF5ulVpEiSUmB6Qzqg84j71AZ3b/oFBF3ivS6u/trbL+s7z2H9LCc7pVEKwI9DkA==
X-Received: by 2002:a17:903:1108:b0:267:8049:7c7f with SMTP id d9443c01a7336-268118b3f91mr56656115ad.7.1758160933498;
        Wed, 17 Sep 2025 19:02:13 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff38eaf1sm806417a12.24.2025.09.17.19.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 19:02:10 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net 1/2] bonding: fix xfrm offload feature setup on active-backup mode
Date: Thu, 18 Sep 2025 02:02:01 +0000
Message-ID: <20250918020202.440904-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The active-backup bonding mode supports XFRM ESP offload. However, when
a bond is added using command like `ip link add bond0 type bond mode 1
miimon 100`, the `ethtool -k` command shows that the XFRM ESP offload is
disabled. This occurs because, in bond_newlink(), we change bond link
first and register bond device later. So the XFRM feature update in
bond_option_mode_set() is not called as the bond device is not yet
registered, leading to the offload feature not being set successfully.

To resolve this issue, we can modify the code order in bond_newlink() to
ensure that the bond device is registered first before changing the bond
link parameters. This change will allow the XFRM ESP offload feature to be
correctly enabled.

Fixes: 007ab5345545 ("bonding: fix feature flag setting at init time")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2: rebase to latest net, no code update
---
 drivers/net/bonding/bond_main.c    |  2 +-
 drivers/net/bonding/bond_netlink.c | 16 +++++++++-------
 include/net/bonding.h              |  1 +
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 57be04f6cb11..f4f0feddd9fa 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4411,7 +4411,7 @@ void bond_work_init_all(struct bonding *bond)
 	INIT_DELAYED_WORK(&bond->slave_arr_work, bond_slave_arr_handler);
 }
 
-static void bond_work_cancel_all(struct bonding *bond)
+void bond_work_cancel_all(struct bonding *bond)
 {
 	cancel_delayed_work_sync(&bond->mii_work);
 	cancel_delayed_work_sync(&bond->arp_work);
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 57fff2421f1b..7a9d73ec8e91 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -579,20 +579,22 @@ static int bond_newlink(struct net_device *bond_dev,
 			struct rtnl_newlink_params *params,
 			struct netlink_ext_ack *extack)
 {
+	struct bonding *bond = netdev_priv(bond_dev);
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
 	int err;
 
-	err = bond_changelink(bond_dev, tb, data, extack);
-	if (err < 0)
+	err = register_netdevice(bond_dev);
+	if (err)
 		return err;
 
-	err = register_netdevice(bond_dev);
-	if (!err) {
-		struct bonding *bond = netdev_priv(bond_dev);
+	netif_carrier_off(bond_dev);
+	bond_work_init_all(bond);
 
-		netif_carrier_off(bond_dev);
-		bond_work_init_all(bond);
+	err = bond_changelink(bond_dev, tb, data, extack);
+	if (err) {
+		bond_work_cancel_all(bond);
+		unregister_netdevice(bond_dev);
 	}
 
 	return err;
diff --git a/include/net/bonding.h b/include/net/bonding.h
index e06f0d63b2c1..bd56ad976cfb 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -711,6 +711,7 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
 int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave);
 void bond_slave_arr_work_rearm(struct bonding *bond, unsigned long delay);
 void bond_work_init_all(struct bonding *bond);
+void bond_work_cancel_all(struct bonding *bond);
 
 #ifdef CONFIG_PROC_FS
 void bond_create_proc_entry(struct bonding *bond);
-- 
2.50.1


