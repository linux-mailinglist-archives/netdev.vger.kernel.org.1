Return-Path: <netdev+bounces-122723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D35459624FF
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D045B1C22352
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7D516C6A0;
	Wed, 28 Aug 2024 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrUMj2J3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C55F15B0F9
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841195; cv=none; b=Hy1r9uPxKExX40UQzcWPK7vADGh5+0Rj5L28r0ZIngxCpf4jGayrqC2VvQdjM9iMnUqcbjabJpnx5LYrxGkZskRpMDe5/EWp2M73HbeWK1d7j2WtPIrWJNmpWTBT7xISrUyz7NWqwmzq9sEu9ttlG7SVyJeJmKajLLMwqPeE4/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841195; c=relaxed/simple;
	bh=ClqbiPv5F2QqJM8Yj3VbTynT2F5L6UKPt4B/V8VqkSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xx3EYu7oD9oyq0B5vFUdaoLJv0gb5gSd3sqb5JuvEYZlSQBPknC81NJMPmk5J+iMURToPcn40cIsNPO4MLxgyHpC0332FJPfICzEPXecewFCOOkMHVPjUTs8Dx5zwN3t20FpCDz9lmwyYEoFcx5rSWXAn4bJjolDqXgecNv3PJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrUMj2J3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201e64607a5so46896965ad.2
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 03:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724841193; x=1725445993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2F3B7sBLl8yLVD29O4UtpiYlRm9MEK77/El8e5ciEPc=;
        b=SrUMj2J3O0Zs2/04d9H4v8EYikaWBxdFeMzI0u08KKR2KKZ2XD91kdKIYGcLdxoneC
         c3b+YsYhO4K+PA7plJ3DzY/AVPF3xmoEojF8SNiIhClG8pyQwyqzz+cLFiqRVkA8W+SV
         gQIvjO6lHF1+oL8G3ZovYNbnVRX42s1F4NxwvDrP6JbLNL9cBTShHXsUBKMWjbA/XEhH
         ol5RR4Jg9N0PZ7Tb0BwQw0nlEgdqlYCHv9pnqH5sSQLdHc/n1JdalvX3CGzyIOJOjanY
         aj+34lwsmKnQff7iXkT6gdHCNnDiwSTC21D4KTS/RZseuHE4lS5sps/HGQcs5vcGCS0o
         uTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724841193; x=1725445993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2F3B7sBLl8yLVD29O4UtpiYlRm9MEK77/El8e5ciEPc=;
        b=RFEgxASThRCW/sO7k9gB2msB97vzYE1JsCc0OXgaX5cWPzudIhQ4QSxHmoyqOElGoL
         xM4ulbOGKs1yj3zivYoyTEerKL0G85KojiK16TMmpo/v1OwK4VfR5YCKJ/Mn229QuX3u
         twuH3xTGYqesSpbk3a1r0WpKIlXXhTTSW/ve/aUeos2GNuxdktPRS4AGJT4y5vLGrkJV
         TNCuWZOjGSc8bBZqPm0eR1f1MY2fVBfk+pAW/csRrepvUUMDVBOQT+WzqmZHkxv3cfzs
         mxi0MsZA6QNH7R9cTxtrIQ4ZOf17EHeziiardgq51YbjEMeiWHe2v2XKR4hCA0THg4UR
         AvLQ==
X-Gm-Message-State: AOJu0Yw7OKmiWHPeP9okYqdJrHUOtZ7wwpOOdJwmHIWV3rAzEIeHQBsk
	wlwdBhLFoAs0fAmyRCOwV6PZT/zyMRHkO8ghG0DlBb8f8oe18ECKHQjt7d6TvAVF6w==
X-Google-Smtp-Source: AGHT+IGFH/IcDkGb2mx55h50ILZD2hC1Y6UNi6BojKGfkA2pOaVnEJWjXsqB6mjAZQCbyO5L+fpMEA==
X-Received: by 2002:a17:903:1c8:b0:202:cf5:1014 with SMTP id d9443c01a7336-2039e44159bmr200328455ad.4.1724841192665;
        Wed, 28 Aug 2024 03:33:12 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855ddaeesm96298835ad.124.2024.08.28.03.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 03:33:12 -0700 (PDT)
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
Subject: [PATCHv5 net-next 2/3] bonding: Add ESN support to IPSec HW offload
Date: Wed, 28 Aug 2024 18:32:53 +0800
Message-ID: <20240828103254.2359215-3-liuhangbin@gmail.com>
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

Currently, users can see that bonding supports IPSec HW offload via ethtool.
However, this functionality does not work with NICs like Mellanox cards when
ESN (Extended Sequence Numbers) is enabled, as ESN functions are not yet
supported. This patch adds ESN support to the bonding IPSec device offload,
ensuring proper functionality with NICs that support ESN.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index adc47e6e6d19..c0a20b834c87 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -648,10 +648,35 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 	return ok;
 }
 
+/**
+ * bond_advance_esn_state - ESN support for IPSec HW offload
+ * @xs: pointer to transformer state struct
+ **/
+static void bond_advance_esn_state(struct xfrm_state *xs)
+{
+	struct net_device *real_dev;
+
+	rcu_read_lock();
+	real_dev = bond_ipsec_dev(xs);
+	if (!real_dev)
+		goto out;
+
+	if (!real_dev->xfrmdev_ops ||
+	    !real_dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
+		pr_warn_ratelimited("%s: %s doesn't support xdo_dev_state_advance_esn\n", __func__, real_dev->name);
+		goto out;
+	}
+
+	real_dev->xfrmdev_ops->xdo_dev_state_advance_esn(xs);
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


