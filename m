Return-Path: <netdev+bounces-177621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BD0A70C09
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CDD7A6A9F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B691EA7D3;
	Tue, 25 Mar 2025 21:31:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CF0265CC8
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 21:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938262; cv=none; b=upv5BSiBkMFOIDGHupjBPfHrvPPA/zH8mttGsEpIBIQvRCZ9Gx+rodb0ClCVZEglHeRbbtczv2QmHXx9bBcrN2drDj5OdnrwjWhjCKAPNdGc5ZwATayb8yhh5M9ecpNtocI8EJ3TE5T+KIoE1xW7DOgPnmIkbUzGnQaiOP+t3rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938262; c=relaxed/simple;
	bh=ubvtV00usCUlu4B15x0IskAav2vYjGL/C0e+ijFYpXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/w3HgFPDXn1BMOvJAiiKnIy0U3WFgXPpDH2wkCgBvtSb3q3Rfgwvtk+Gc4WUDg3BVrZAQgqLfA732/2GXVoYwGnfMwOKrc7D0DOtCVl5KsptH3h+x1kMLksXBtarEzW3znfqymXhJDo2FXYyEEHqa9+W5WnsFDK1ScfpL8rxTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22409077c06so134701915ad.1
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 14:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742938259; x=1743543059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFPA1zqSSDNpg8Ij+teJMS0m0J223HfVwa79DP8ntPA=;
        b=Ltl/Y838UaOq+NWQoKRjzWZuJo8fKN/TmHfkclSStgsVMRZZM17i9/yalk2n7SKHhn
         tMAkD3l880Omb4C66y93tv7NSZeUaEqMdWOvUvYEGkakUwp0iqYuW6FTSjbua1AQVDcH
         Ieh0UrXveG70+9Crzg8cX37NPBnpy7VUvVZv47xUaB+27QPLKbKgqAWa0BFrPZr0erld
         JU7hwtnE/O4oGbM7zepoY8Re9ye/BIS74/JNbqJMmX7/qGhWJvPqRJR4TIdJ1lKIaPA4
         mP62UoOfXz8INgH6FH14QwKaNPcKHqp3nE9C54zPpnWlP3t7wvxkYe3fmoDBY89coOR/
         DT0w==
X-Gm-Message-State: AOJu0YxqufZIFymODX7Z5RPY9e9G0PAotQnAXG9xcwjEXYhzqYk98KUT
	nJT3rdAxK2Rd15FnIUOo1K0GEnamAe9FtnEs8HH43gSayFo5TqM0ufBVp8y9RA==
X-Gm-Gg: ASbGncsc6t//gzdLV+VEVhcyreWOjXNeql2HpFfi3mNiefjl6+BBdLUgSj+1QsVVKBw
	uGZaMLPJOAw1BhXB3mqC9Ic7NTTxUqpEevp+RsYNLyVio3hBbYwChnEqur+MATPjop2l9twF9m+
	U0OZiAKqIYBg/6mCwIr+fodzXxDAcj/RQ7H/pU5pMMm6f7pKIdFwFMcwW3Iyw+9x1RNvDirY/GX
	2Tnhhn4k/GBkpt/5XAJrtrsrx9RRkqFrBZCBFZm6y2JEBSsXxI7SpEsrX5aA46NSFeO45R2Q3Sq
	BR6IVQuEHAbIIkdcYvmncu3jQQM07NkJXT+k62/80/EJ
X-Google-Smtp-Source: AGHT+IHBdyaN3xPMkmk9cPzSbNW3vmvw++RyLMVuv4hgv1uTh9fMo0g7x/GCAJX4BGDvdyEr0DpczA==
X-Received: by 2002:a17:903:166d:b0:224:584:6f05 with SMTP id d9443c01a7336-22780e09d81mr283233815ad.41.1742938259024;
        Tue, 25 Mar 2025 14:30:59 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73905fd57casm11055546b3a.65.2025.03.25.14.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:30:58 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next 1/9] net: switch to netif_disable_lro in inetdev_init
Date: Tue, 25 Mar 2025 14:30:48 -0700
Message-ID: <20250325213056.332902-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325213056.332902-1-sdf@fomichev.me>
References: <20250325213056.332902-1-sdf@fomichev.me>
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
index b597cc27a115..8df428fc6924 100644
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


