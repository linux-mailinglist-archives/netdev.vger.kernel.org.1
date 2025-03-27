Return-Path: <netdev+bounces-177955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF7DA733A9
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5519179AE4
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 13:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17160215F7C;
	Thu, 27 Mar 2025 13:57:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B6B215799
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743083825; cv=none; b=T6gC8OelGNLI2CJbfp2PoPNKf3NsbECEwJQFYMWfP68GSgyTifkiokzhWRohB5UdhBFEF2ZVwd0uBvL/537v+ALYi5SCuxoN6xvtCUCYiHBEFMmj5SpqsINOhAE+LWbLnTcszQPBujvBwkIehImq91czQbmugt+wHwYeu6FO2II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743083825; c=relaxed/simple;
	bh=pPFaAHqfz6cidUBHyUpb67Pq1vZfAV2J6zGyohzFVqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYtCv0hO+bcp9/HdYbrRedjajhClXKbBImTOgbQlm8kSUdYwtmpbor9mpI6ig7QT7729yG4uCFVIEZUZKn+eVcpP5SPZf2oqUDuzjhXkrvsljL4hqtvoqVm9PLYObAZhm4iKdkDK5Hlio7SK4JMxn0bsvI90EdgekUaCeNY9xa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-227cf12df27so15114045ad.0
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 06:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743083822; x=1743688622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3B4DIcH2JGv8yKOtHByBvLXwJNtNg6sNAoCwNYSok4=;
        b=YNkzfUzJd6TfPCkbKLewp1jdL3cr8JXFSr54vonJzYD1f0Zc00BDNvJnB6QkxpkPFF
         dKD+zw2uTMCtc4HF4Mr78ZiqKXkOM6p0V2z0pwrJEwUdR6Y9UmxhYzAa7xIGwnsHhZ/x
         xkWC6zQS9GgX+YZ26Nf9oYISLKgTrILRDU21BHBNfk5ue9neOtoeagLhX2Q4S0DmJKWR
         aiIBvbFa8AQ9KMj+VUpt8Amka8fUauiFHQ6iU1AwLTPLFWmeso3vv/iiJ4UQj6G0LBzG
         JJ1ZFvxxCLgB2UOWe8d864z8rXx9l9iR6V4TN/r01Xg6izPDWLwm0EHbHdsq1Op4iju0
         PeVA==
X-Gm-Message-State: AOJu0YzyrysgulHdsn8SIu7et8NHYU/PBMlLoUuuW6SLxh+YEMoaoKqb
	GU/pmBMN/wSHKLd1ELzNPVKY35TlMWrzsYSktRgPvepgKnmJ+zo6UZGC+zx0cQ==
X-Gm-Gg: ASbGncuJk49oBBCNG0eFNq3HqAa0J3q27ocjh91nnh9+t/Wn8QLRO3sRh0Z20u8BQrr
	TxfBpSHvSkL7GXuqk11zUOj/p+a/G7E25p2tWxpkJRaVODkEtscS/78lGwJ36if7XeYSkeOzIEt
	j0vc1bJIYLYEDVaRuxmB7tocpM//ASTN1ps3b/KdTnDhncDh5eSBtOUpBD6XJazsxHlmjAdadD0
	VteO67lTcvXP1V6oi+29l+XOhF9FOvbj+ACZ9UtiF/g0rXzi2KwCKquEk7wm4F/rmH2U6h+Pd9I
	snkxFGCbZOIlUROUNmQ1xXY3I7mCP5GwZEWD2JaCIlmN
X-Google-Smtp-Source: AGHT+IHt6DwK9WA7Xf9MIR4Nr+m82LBrzkCgO0ztOnf6ePj2X4cmQN3I/L9/km6eG8NUysSUXXEfDA==
X-Received: by 2002:a17:902:ce08:b0:224:3d:2ffd with SMTP id d9443c01a7336-2291ddd8289mr3923185ad.17.1743083821986;
        Thu, 27 Mar 2025 06:57:01 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22780f4a075sm127937855ad.100.2025.03.27.06.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 06:57:01 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net v2 01/11] net: switch to netif_disable_lro in inetdev_init
Date: Thu, 27 Mar 2025 06:56:49 -0700
Message-ID: <20250327135659.2057487-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327135659.2057487-1-sdf@fomichev.me>
References: <20250327135659.2057487-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cosmin reports the following deadlock:
dump_stack_lvl+0x62/0x90
print_deadlock_bug+0x274/0x3b0
__lock_acquire+0x1229/0x2470
lock_acquire+0xb7/0x2b0
__mutex_lock+0xa6/0xd20
dev_disable_lro+0x20/0x80
inetdev_init+0x12f/0x1f0
inetdev_event+0x48b/0x870
notifier_call_chain+0x38/0xf0
netif_change_net_namespace+0x72e/0x9f0
do_setlink.isra.0+0xd5/0x1220
rtnl_newlink+0x7ea/0xb50
rtnetlink_rcv_msg+0x459/0x5e0
netlink_rcv_skb+0x54/0x100
netlink_unicast+0x193/0x270
netlink_sendmsg+0x204/0x450

Switch to netif_disable_lro which assumes the caller holds the instance
lock. inetdev_init is called for blackhole device (which sw device and
doesn't grab instance lock) and from REGISTER/UNREGISTER notifiers.
We already hold the instance lock for REGISTER notifier during
netns change and we'll soon hold the lock during other paths.

Reported-by: Cosmin Ratiu <cratiu@nvidia.com>
Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/dev.c     | 1 +
 net/ipv4/devinet.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index be17e0660144..80523f75ee6b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1771,6 +1771,7 @@ void netif_disable_lro(struct net_device *dev)
 		netdev_unlock_ops(lower_dev);
 	}
 }
+EXPORT_SYMBOL(netif_disable_lro);
 
 /**
  *	dev_disable_gro_hw - disable HW Generic Receive Offload on a device
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 754f60fb6e25..77e5705ac799 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -281,7 +281,7 @@ static struct in_device *inetdev_init(struct net_device *dev)
 	if (!in_dev->arp_parms)
 		goto out_kfree;
 	if (IPV4_DEVCONF(in_dev->cnf, FORWARDING))
-		dev_disable_lro(dev);
+		netif_disable_lro(dev);
 	/* Reference in_dev->dev */
 	netdev_hold(dev, &in_dev->dev_tracker, GFP_KERNEL);
 	/* Account for reference dev->ip_ptr (below) */
-- 
2.48.1


