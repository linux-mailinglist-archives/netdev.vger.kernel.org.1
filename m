Return-Path: <netdev+bounces-119097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E1B954028
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 05:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F095B1C2226E
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA906A8C1;
	Fri, 16 Aug 2024 03:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chz464Sr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B6754F87
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 03:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723780534; cv=none; b=BU2tuwsFMNP8i/UGetfYS266b40yBdFthNjR/qvPGB1fuqVXyoYtTebbbfUfTsj1NPf8nr4WEbl42jedlaps1XotIc1WgvZOlh1gxbp8DgYf1wSHsxfpnuj8U/O62xeom64R8N5SnV9ftwlvovTM12syUnmrYKMoEAnh2XD2BCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723780534; c=relaxed/simple;
	bh=/SCSfYCiqVONLw677BN/ybQPhGeQWUJHvAar0f4hd0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaGE+EVheopr1HgJ0+5GxWsTn4TkEvZOGljlZbEhL6r6JcnpaPuXGxKLwDv2RG7ZqbmwHVVXAVhNxab+i10320H0WfMhwDnfA9cfa6SM4vnIa+q001Kyhtw3lMvacoWf2r9XHVIUoZfP21yCDPui6CGb4UV3tW5bUU3llTfOSb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chz464Sr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201f2b7fe0dso10606665ad.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 20:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723780532; x=1724385332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X29KUg7v3bdgkh3yCqFBDEscioym2OEzSDPA/5CisPA=;
        b=chz464SrLyQb2bi98xR0wRTpbx7tn5G8ngR3WDmLKmnH6GbivJ+cXhTccF1BDnnlNV
         UqSBP5AdAlZbOF26yAC029LKJWiYnsxRulCqjlz6sE8JOsZubsWvvf6B2OGgVIzElGyr
         sc09RVcgBMtpk2bFXLkNmcMUNxtEUF6HMFnGnvLWJ3Dj/iDggPvZIuqKxfpUCYRz2Vgm
         6la+inc6Ysm+k1Ptz8dez0kPq8vjgx6lXPI7ST45rXz9twTbZSXLD466D/8G1/Lzv/Fe
         av6RhINBMQXyUY6PkKKP4sjiLx1QIF2GF8hnv2qt9/R1ZclMryTderAI4UEE055SzBtt
         /9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723780532; x=1724385332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X29KUg7v3bdgkh3yCqFBDEscioym2OEzSDPA/5CisPA=;
        b=HyG4v5c18GexpzYyhY9LVaNCGFbTDKOZkp6xNJo6S0j0h0PkOzJtTOxkKVP4wQ0GVB
         /45QcjnDzEWY50/eJV9xVpg/7sgNn1fOXv6kuZ0tKCdQjS3eGTsGly8u1Zca5LQL+izF
         /RupstRt2QTiMHDUe0zzD08U+uU821mdvhEBslPyjCXskD/5XESq1Zuu4+AxXAXjqbdH
         UX7eBDhpzqIzS7/sIRKRYCXG4aZLJZSL/EtFS7dMhdDx4I7Jsy7rH7VavTgS+G7iLzR8
         jy5URvdpgIKsGlox1pISS3MYJRIMrMKGQPxXB0JS9CMPQrPcs+9IkWFsau1jK7mLQSrs
         H4fQ==
X-Gm-Message-State: AOJu0YyiUEIZsmOjnyHf2IH2fmdLvRLU1iPxGd26w8R0LEq9d5RpDTuX
	fxD9/F0CfeSC/NWAPwjrAljg87DX2vNA5oP4qUXhQZQAZP4dhznVPnY7v19cNTs=
X-Google-Smtp-Source: AGHT+IG8D4DZyVNCUEJZgYHjCyiLCnjZRKx7EYkFiVxWi9LONxlrnib28892ZQdPvXwWUxX99QrHew==
X-Received: by 2002:a17:902:8685:b0:1fd:6c5b:afbc with SMTP id d9443c01a7336-20203f31ec6mr16364115ad.49.1723780531712;
        Thu, 15 Aug 2024 20:55:31 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f037563dsm17112105ad.131.2024.08.15.20.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 20:55:31 -0700 (PDT)
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
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 1/2] bonding: Add ESN support to IPSec HW offload
Date: Fri, 16 Aug 2024 11:55:17 +0800
Message-ID: <20240816035518.203704-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240816035518.203704-1-liuhangbin@gmail.com>
References: <20240816035518.203704-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, users can see that bonding supports IPSec HW offload via ethtool.
However, this functionality does not work with NICs like Mellanox cards when
ESN (Extended Sequence Numbers) is enabled, as ESN functions are not yet
supported. This patch adds ESN support to the bonding IPSec device offload,
ensuring proper functionality with NICs that support ESN.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f9633a6f8571..4e3d7979fe01 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -629,10 +629,48 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 	return err;
 }
 
+/**
+ * bond_advance_esn_state - ESN support for IPSec HW offload
+ * @xs: pointer to transformer state struct
+ **/
+static void bond_advance_esn_state(struct xfrm_state *xs)
+{
+	struct net_device *bond_dev = xs->xso.dev;
+	struct bond_ipsec *ipsec;
+	struct bonding *bond;
+	struct slave *slave;
+
+	if (!bond_dev)
+		return;
+
+	rcu_read_lock();
+	bond = netdev_priv(bond_dev);
+	slave = rcu_dereference(bond->curr_active_slave);
+
+	if (!slave)
+		goto out;
+
+	if (!xs->xso.real_dev)
+		goto out;
+
+	WARN_ON(xs->xso.real_dev != slave->dev);
+
+	if (!slave->dev->xfrmdev_ops ||
+	    !slave->dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
+		slave_warn(bond_dev, slave->dev, "%s: no slave xdo_dev_state_advance_esn\n", __func__);
+		goto out;
+	}
+
+	slave->dev->xfrmdev_ops->xdo_dev_state_advance_esn(xs);
+out:
+	rcu_read_unlock();
+}
+
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_state_add = bond_ipsec_add_sa,
 	.xdo_dev_state_delete = bond_ipsec_del_sa,
 	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
+	.xdo_dev_state_advance_esn = bond_advance_esn_state,
 };
 #endif /* CONFIG_XFRM_OFFLOAD */
 
-- 
2.45.0


