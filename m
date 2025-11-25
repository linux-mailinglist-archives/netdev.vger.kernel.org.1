Return-Path: <netdev+bounces-241492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D58C84711
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9CC934FBE1
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD79C2FF147;
	Tue, 25 Nov 2025 10:20:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD702F99AD
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066005; cv=none; b=sCExfgeZ7oN2pXMhwDZC9BhzgFEvWXRSnJM4DbdP6ldW0afuic5mDwkJSdF7Vhx/7PSvyxlenJ0oV89FBlUXp3DKjRv0Qz2ptMHZ6vCAmvT0CYpsTV9lQ7iPGKiGtX8NCFvY/ZfRa2LezRdgEfp0Wq7pJx7wLHSknIIdei3CvK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066005; c=relaxed/simple;
	bh=OkmNiQ6YYv3uc0G7OY7lyiSTVze+U7ucr00ng0VO9JY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mhe/oN8nAVrOJBiSlaIj4TwmV22fDL6UHPGumhNdV+Vh3KRUzlEvDg28XlPzxAgOGBLRoANbsF6QBwITvFD1cbuK1UWNVc2E9/UZkv3n57mtIDZs3oZgVepGTRJmN0Whk5FTIX4/GQZ8VTK6/45Skbn0RoWyPmmd5cga/iBuovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45076d89e56so2428093b6e.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 02:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764066003; x=1764670803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PU9hyC9362jDv5FXyh0OOcazyjJD28LuH+4Fj57jjN0=;
        b=OLiFBeIlbbaz3JleDWHhLdT6uvhmKOfOKwhgWKQIUwBuc2zQlpIP79losRZdJSvEXi
         c5UAJFYU03muWBSQnfeAH4r1pgDsThXgtr03s8dh7bVI1cG3+2cfYlPmflRovrGFCRGz
         cWjvHbMArMKD24pAl44LNOWzhqe747coJYTLyPMjna/e457ZIr7yVdfufHNe8DRYHsvk
         UvpfwjehnpvYPK+nu7rIwJYqLH+hQIVCgp3C3mA+ID9QPM2SlsD1enzI7nrVWhwftwdV
         a7Z1dJIaQRpDySIM/9LyNcG/5etBmgodiswh/hx+tgqQX++ODX3GVFLHLKHDBVkJlPvo
         68gg==
X-Forwarded-Encrypted: i=1; AJvYcCX02zAVADqNhK4v9s5fqGWx3eHUXp64bGCo+LLmMLS+sBWkeKFGVQXyKRg71GJ78KYjDptK/uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YygLzW31om4zyKL8+8ryRM/beA0HSGsIsDQ33GurqF4OrAmuUkC
	mqBIUy7p5+d8NpJ2RbQm3bann/avI7e5Gy4mcFbIDinQczVGAEOQOr4a
X-Gm-Gg: ASbGnctf7b+9MPaopCWeAhF8GjITsws5AERhXZEd7s8dWJb7iNsf0WCToQEHUdkbKSY
	E73sFUHDrgdJXmaUN3SfPXLmmluGsM/tTdXEHPaCRT8e6pOt6ACbG7Zy0gmQ6AxZcnJquUkJOl8
	3E/MsWF7fRTFP0VQ+wQ6HbyO0QEwzYGlgNVy1NYibqJyK2JdDruD1aU98dJErZO3oGcMmN7bz6/
	dOf/mKP2ntuota/LvnGJJdQzvvU89VWK3NtSaiv19WqRdyD656maBHNYEux0thTkGGDoHIVoY4w
	8E2rt8ikLyzogXglqZsYZXOCtwhi5/VFMVeK70dP9KHCoXgWtZnU5wx5nWS2SHRNyE8mpUn18tc
	6E2ipCcUUjCPkQ1Vfyx9inJg24KuE39/kyYVnkNZ2L+70diRqOYzSPsT9sre06sMkTtONgR9kLL
	7UCsvdtYKSZ8is
X-Google-Smtp-Source: AGHT+IHthk47k/0+mFB4/rU+D8HcVb5Zhji+7aaqntTqAXc55L/5R9rvQ4fRXAMNxSE4hloiSbB5jQ==
X-Received: by 2002:a05:6808:2227:b0:43f:5c61:448d with SMTP id 5614622812f47-4514e60108emr894047b6e.9.1764066002689;
        Tue, 25 Nov 2025 02:20:02 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65782a38456sm4189883eaf.3.2025.11.25.02.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 02:20:02 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 25 Nov 2025 02:19:50 -0800
Subject: [PATCH net-next v2 7/8] ixgbevf: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-gxring_intel-v2-7-f55cd022d28b@debian.org>
References: <20251125-gxring_intel-v2-0-f55cd022d28b@debian.org>
In-Reply-To: <20251125-gxring_intel-v2-0-f55cd022d28b@debian.org>
To: aleksander.lobakin@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2009; i=leitao@debian.org;
 h=from:subject:message-id; bh=OkmNiQ6YYv3uc0G7OY7lyiSTVze+U7ucr00ng0VO9JY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpJYLIUkKS6lrxmxJ+rShJYVwYFd7lG986d7poy
 OhlH+xcpDKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSWCyAAKCRA1o5Of/Hh3
 bQ9VD/sGdvKkjtI6Tc77NNcYNT6lJ/PYEYfiEz4K+4k+XKrA09ddP/hGGQMqNPBbXkKnsvhUgz7
 uzvBCrI24UvzI8yJ32aCGYndKQQ0yfnoG6357aIi++DDz3EiViD4S2j75kDFLBTHzJwN4sS0F9a
 BffhCmk/eUc8vv8DdGcSYjKldgJwYEkl5D++Xz0OC1HDdYTYuTCx/AvSRm1hkBKH2Z80JWL/M5d
 a9e6NbDKjJYiQZIS5opkVPN3Ank3bT8KYjz3iyHoBVObVyXhydZ4r8cOzgcj3vBTABKa7BPA358
 qinhzpWXB7BJZt5NIrRradIPWk8iRMhwpyLiH5Iyb/31ZMJ1cC1EHCiXNwsaslS4Dt+PDMf/sHU
 Dbfqhzi7XxOP3tQoBDSnYuc7kZ2nj1JHYQ1ds2j+YQ+dYL8TDvii+GB1htOd7ayeEA1rI1EBDup
 V7jyPhuaIGCfoya61WeVI5YJmtZieJF6zk6U8okXvNhutZlS19rrlQAyV5gozOGCWHeZCkH8X7n
 3+ErTSefDVJBSu2xTHUXQzpLsVOnmBHfknyZidg6wyQVM3ViyPOELt3KvYwXuPpFu+6s/At8kf+
 hduzrQB5WAXjFtsgzsKWlONlhCyezQWqVjMo/AiM2rMSRQhSwFkjAoZXQ6L4PM+yt1X/ixEprqk
 q0kyk+sG9bre7Hw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns ixgbevf with the new
ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ethtool.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index bebad564188e..537a60d5276f 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -867,19 +867,11 @@ static int ixgbevf_set_coalesce(struct net_device *netdev,
 	return 0;
 }
 
-static int ixgbevf_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
-			     u32 *rules __always_unused)
+static u32 ixgbevf_get_rx_ring_count(struct net_device *dev)
 {
 	struct ixgbevf_adapter *adapter = netdev_priv(dev);
 
-	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = adapter->num_rx_queues;
-		return 0;
-	default:
-		hw_dbg(&adapter->hw, "Command parameters not supported\n");
-		return -EOPNOTSUPP;
-	}
+	return adapter->num_rx_queues;
 }
 
 static u32 ixgbevf_get_rxfh_indir_size(struct net_device *netdev)
@@ -987,7 +979,7 @@ static const struct ethtool_ops ixgbevf_ethtool_ops = {
 	.get_ethtool_stats	= ixgbevf_get_ethtool_stats,
 	.get_coalesce		= ixgbevf_get_coalesce,
 	.set_coalesce		= ixgbevf_set_coalesce,
-	.get_rxnfc		= ixgbevf_get_rxnfc,
+	.get_rx_ring_count	= ixgbevf_get_rx_ring_count,
 	.get_rxfh_indir_size	= ixgbevf_get_rxfh_indir_size,
 	.get_rxfh_key_size	= ixgbevf_get_rxfh_key_size,
 	.get_rxfh		= ixgbevf_get_rxfh,

-- 
2.47.3


