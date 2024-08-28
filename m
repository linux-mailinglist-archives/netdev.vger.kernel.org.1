Return-Path: <netdev+bounces-122722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434E49624FD
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A305B22709
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBD216BE29;
	Wed, 28 Aug 2024 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETs31IWJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAFC16087B
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841190; cv=none; b=Mqu8c2EHZiw0u964G3KjBxM8Pzpo6tWsZwfyf3IsJDwsBo9uVCgYEcGCQEFzzQl6/vB58a0lJ63ghCACxUfoHn9WLF3JUe/hg1eS3In2mLnA7qFqosF/zS2dqxl8LzoImIhaawN7Gad+nN9PsmwafAlBmNkvEx1UlZjDSP8ECX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841190; c=relaxed/simple;
	bh=hWEdMYIVxWFBoN/vtuEcjWh8etmv1bwlfhmtqhlWI1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNR8t+rAbYgLgfLEzAQaE77ttlvJP7Za9lS+03O+3hrVm98EaJx0FLV/z9f5OfOjCvF9EUryuUw0/HMnb+as5fZ0D6gW0SOfyCS3zxvnqch7xodQZjh/cI4h5ous5M5/uJkmFohpcfgqyPMJyytDYj87+dRmrpYue/bGOHu6Kv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETs31IWJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20231aa8908so52303955ad.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 03:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724841188; x=1725445988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUJk5mVFW3si3tuxhc7HSbmdH4wdSm60g5pd0yn/6gA=;
        b=ETs31IWJri9vwI6i8j2z8y7tjuuGYzkV5gkTBPs0RzraJ/elEEAVAcLpc4QU2GudaR
         wrbOyIJ2nZ98nsNcBFXdLnWQgHSi1Rq8joiegYVvLxjtAZTyL6YQHagssZco0SOQK853
         rsMa4/HmnGlDI/Se0m1bICQ+guqEP/lmsUQMwPv5zqykONFd3SVrugqCviVp8IOzW7iD
         9aatbP9bpI0iYxihZgTvGgcYhD+MqMq4sgiVEZHH12piW03MECRlylVOaSKayU/dyN0E
         eTACBuJuK6DAi++Q1FQbSCY65E+LqOrdVdsDWrd8/uRsBVzjISOgheFOJh01+Bk+2EtE
         r7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724841188; x=1725445988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUJk5mVFW3si3tuxhc7HSbmdH4wdSm60g5pd0yn/6gA=;
        b=v286J38c/ngxWSnja5Oj8277XUdIl5TE9dUEj6XElWNKxMMe5PwmgtzotCY2OomWwg
         vYeaJLTENG7SbdxFgAqUjlc28hI6GCruXS4WSTcZpZXJoVDnRwHyxq6BXmwezClkPWJk
         A74MCsijwQDkUPZ/Mnr5FC/ywfVCmdpBUkFpJORfg/576jBvC/QOfnVtrqAx0X0wLizY
         s8knkCa7PNdq+RtbUMqJdpwXp9+Ub7smtD2OzcK5H1SsuvIvq6pS67S/7icv9cq90aJT
         WPCD3E3Ks00rodK86ZzsYL64BpPh+M0Ppw4IdQZKJS/zae7EoA1U/fKmjXkc+fR/8o2M
         CN+Q==
X-Gm-Message-State: AOJu0Yx3ZpZpoK8/mvVeEXOo4qfNp006X3QwoO+H3xJsChuXdNZWMb3Q
	EzUGu2d3D9kXMklRRfJswBMbUs4nTnaGXMKZ/h6V52Nam+19fFJX6M+6K1G9inSCfA==
X-Google-Smtp-Source: AGHT+IFk9za7/fA6v5jbv0nF+yOP0ddhNlpdGeVkvR7PEWwC7teqrKLkKSfjzhmlAmvuyIFnNhtWaw==
X-Received: by 2002:a17:903:3547:b0:1fc:4f9b:6055 with SMTP id d9443c01a7336-204f9a60e54mr14839895ad.1.1724841187669;
        Wed, 28 Aug 2024 03:33:07 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855ddaeesm96298835ad.124.2024.08.28.03.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 03:33:07 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>
Subject: [PATCHv5 net-next 1/3] bonding: add common function to check ipsec device
Date: Wed, 28 Aug 2024 18:32:52 +0800
Message-ID: <20240828103254.2359215-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240828103254.2359215-1-liuhangbin@gmail.com>
References: <20240828103254.2359215-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a common function to check the status of IPSec devices.
This function will be useful for future implementations, such as IPSec ESN
and state offload callbacks.

Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 50 ++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index a3b6e6c696b4..adc47e6e6d19 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -418,6 +418,41 @@ static int bond_vlan_rx_kill_vid(struct net_device *bond_dev,
 /*---------------------------------- XFRM -----------------------------------*/
 
 #ifdef CONFIG_XFRM_OFFLOAD
+/**
+ * bond_ipsec_dev - Get active device for IPsec offload
+ * @xs: pointer to transformer state struct
+ *
+ * Context: caller must hold rcu_read_lock.
+ *
+ * Return the device for ipsec offload, or NULL if not exist.
+ **/
+static struct net_device *bond_ipsec_dev(struct xfrm_state *xs)
+{
+	struct net_device *bond_dev = xs->xso.dev;
+	struct bonding *bond;
+	struct slave *slave;
+
+	if (!bond_dev)
+		return NULL;
+
+	bond = netdev_priv(bond_dev);
+	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
+		return NULL;
+
+	slave = rcu_dereference(bond->curr_active_slave);
+	if (!slave)
+		return NULL;
+
+	if (!xs->xso.real_dev)
+		return NULL;
+
+	if (xs->xso.real_dev != slave->dev)
+		pr_warn_ratelimited("%s: (slave %s): not same with IPsec offload real dev %s\n",
+				    bond_dev->name, slave->dev->name, xs->xso.real_dev->name);
+
+	return slave->dev;
+}
+
 /**
  * bond_ipsec_add_sa - program device with a security association
  * @xs: pointer to transformer state struct
@@ -594,23 +629,12 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
  **/
 static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 {
-	struct net_device *bond_dev = xs->xso.dev;
 	struct net_device *real_dev;
-	struct slave *curr_active;
-	struct bonding *bond;
 	bool ok = false;
 
-	bond = netdev_priv(bond_dev);
 	rcu_read_lock();
-	curr_active = rcu_dereference(bond->curr_active_slave);
-	if (!curr_active)
-		goto out;
-	real_dev = curr_active->dev;
-
-	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
-		goto out;
-
-	if (!xs->xso.real_dev)
+	real_dev = bond_ipsec_dev(xs);
+	if (!real_dev)
 		goto out;
 
 	if (!real_dev->xfrmdev_ops ||
-- 
2.45.0


