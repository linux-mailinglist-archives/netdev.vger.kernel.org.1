Return-Path: <netdev+bounces-200311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99330AE47FF
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5016216457D
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA199275AF0;
	Mon, 23 Jun 2025 15:08:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E92275AE0
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691304; cv=none; b=tI9/5fQ+CxNzfTMKTlv8+2xTahtks5ODpQDf3Qz2ski/i3RqlZb9/KaSYMVDRHe9Jqk5yr64i+GvwLjBiZ/YBIDa7dwVfBweh6JW3QtGaJ1j1xbMvHyyHfmH0cYm5Hk2O4yrHpDdAgDwx1xh6p6++jkpR5JksQqldPVNP9sa3P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691304; c=relaxed/simple;
	bh=zqifPVfp22C2tGBUrMMusTQrukGVLfapzHq0JQ2Xu5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXWpmG0QPQxIJFLPlR7Bt+ssLZebSo06dF401y8Elad/aLHe9ptIvZXjSsDfX1Fsw6WFIhcagdLiE1xxZRXq4lTyBUzVOpRAcX1f1euUEmfzHDCOW1ToubeWnFMzn7xBQq0CSuDCiU+IFW6fEdSCCG2TgKigQ8khMcsQWRTBu4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234d3261631so29397065ad.1
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 08:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691302; x=1751296102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLZ1vVALwhU6Q8MeOmfMoMjF0TnYYiDT372IZqmcQlA=;
        b=Ez9mzGepNORXVAWMBGnnR60gMI0LqmsGnzId8LWVTsGPhBdw5DHiV898pclj7N0atF
         lUzGB4+3AN89U9R/6TXILxiFyxv7XEFyDflw5px94eZDP2PhP5+JvijSrXbjovZ0WTKQ
         BbRJwr7joVjqcWncSvMNm8rjuYaVi0P7HJVXcb5JPQjFkyxnt3iNG35q/32HNhCBe+6S
         7cUiKUaQHqPvKFYIg7jyH5OljnStNR6H4LddrjMEKRl09JQWpfBq/w1Fym5jeQ09RcY+
         9pwfBUsTn8vbIWhHii/NnGelfvaFyUcnLIDjufrO1abQwRqRANhN2c+MVSHt6kOrpqkz
         ZHHw==
X-Gm-Message-State: AOJu0Yx1xt9/MPNlRAmgdoL/D724O5zIq63Rz9H6dVopphdZ7fIe7OWn
	CX2ISIs5LUsVv3wj/71xi1xBjTQ3yn1U2hTW5qumKdC0nIjdN4qtlM/FeE6D
X-Gm-Gg: ASbGnctsBVPJou//v/OL46Syyd07RpIpWpeuS2IYPIh635Pu6I386YG9bMkFS1cnPct
	rsWtmEBzGxkeyqlipW8ovqLwGDwOavmmp45SuRAhDzRx1Nat841acT3gs55p2MYmUlx7st/zsch
	mrwRH7GR7oStx1bknvlDtwIu87nbty69/cpysfs0X3UbaFxeElW/6OSzsvYMku5WYiaDgHH+3r/
	3GXZcZ52GR95PHlVLhTRB/gfD0fRPLL+kI8z8oziSYYYcszqr5+HiiVcAgGF+323e1xlesesVtn
	99EJDL8yRhbmPDkLyvwQNL0B/GUtmHdXnaUg/pBB7SulN8z/LYGIdb2AztCJUMW4JTF3HP83vGU
	n6yTvmFMHGhEEjhTd/50P2aw=
X-Google-Smtp-Source: AGHT+IEMf/54M0ijWmBYmI8tjp1gGQkE2m+EPfA6ZeU/avXzSAR2l0u3baFitUCQtrNYYR39IPiZDQ==
X-Received: by 2002:a17:903:2388:b0:235:e1e4:ec5e with SMTP id d9443c01a7336-237d9acc6f2mr216474875ad.49.1750691302358;
        Mon, 23 Jun 2025 08:08:22 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-237d839332bsm86430195ad.40.2025.06.23.08.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:08:22 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 5/8] net: s/__dev_set_mtu/__netif_set_mtu/
Date: Mon, 23 Jun 2025 08:08:11 -0700
Message-ID: <20250623150814.3149231-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623150814.3149231-1-sdf@fomichev.me>
References: <20250623150814.3149231-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Maintain netif vs dev semantics.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/bonding/bond_main.c | 2 +-
 include/linux/netdevice.h       | 2 +-
 net/core/dev.c                  | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 17b17584de83..dd8389d20a60 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2652,7 +2652,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 
 	if (unregister) {
 		netdev_lock_ops(slave_dev);
-		__dev_set_mtu(slave_dev, slave->original_mtu);
+		__netif_set_mtu(slave_dev, slave->original_mtu);
 		netdev_unlock_ops(slave_dev);
 	} else {
 		dev_set_mtu(slave_dev, slave->original_mtu);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 678ddeada19c..0de01d2e115b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4217,7 +4217,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 			       struct netlink_ext_ack *extack);
 int dev_change_net_namespace(struct net_device *dev, struct net *net,
 			     const char *pat);
-int __dev_set_mtu(struct net_device *, int);
+int __netif_set_mtu(struct net_device *dev, int new_mtu);
 int netif_set_mtu(struct net_device *dev, int new_mtu);
 int dev_set_mtu(struct net_device *, int);
 int netif_pre_changeaddr_notify(struct net_device *dev, const char *addr,
diff --git a/net/core/dev.c b/net/core/dev.c
index 750abd345bdc..4ad8ea83b125 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9566,7 +9566,7 @@ int netif_change_flags(struct net_device *dev, unsigned int flags,
 	return ret;
 }
 
-int __dev_set_mtu(struct net_device *dev, int new_mtu)
+int __netif_set_mtu(struct net_device *dev, int new_mtu)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
 
@@ -9577,7 +9577,7 @@ int __dev_set_mtu(struct net_device *dev, int new_mtu)
 	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
-EXPORT_SYMBOL(__dev_set_mtu);
+EXPORT_SYMBOL(__netif_set_mtu);
 
 int dev_validate_mtu(struct net_device *dev, int new_mtu,
 		     struct netlink_ext_ack *extack)
@@ -9624,7 +9624,7 @@ int netif_set_mtu_ext(struct net_device *dev, int new_mtu,
 		return err;
 
 	orig_mtu = dev->mtu;
-	err = __dev_set_mtu(dev, new_mtu);
+	err = __netif_set_mtu(dev, new_mtu);
 
 	if (!err) {
 		err = call_netdevice_notifiers_mtu(NETDEV_CHANGEMTU, dev,
@@ -9634,7 +9634,7 @@ int netif_set_mtu_ext(struct net_device *dev, int new_mtu,
 			/* setting mtu back and notifying everyone again,
 			 * so that they have a chance to revert changes.
 			 */
-			__dev_set_mtu(dev, orig_mtu);
+			__netif_set_mtu(dev, orig_mtu);
 			call_netdevice_notifiers_mtu(NETDEV_CHANGEMTU, dev,
 						     new_mtu);
 		}
-- 
2.49.0


