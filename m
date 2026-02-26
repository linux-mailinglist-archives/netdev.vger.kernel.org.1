Return-Path: <netdev+bounces-261307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLuwKCczoGmLgAQAu9opvQ
	(envelope-from <netdev+bounces-261307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:48:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB94B1A5530
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 344DB315E3C1
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2771C379978;
	Thu, 26 Feb 2026 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7kXG/zL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DA2377556
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106202; cv=none; b=mf6pb0KBX2vAuHsk9XWv6AHFYyi9GlNxFeleInbWNIezq4epYvEmABuijXTGrj/KXKbF5J5tq4fnk+IfImzPFMQkDCYkzls3j28i9NMblTXmNDmzCkpw3gC5D+9VnjmzUEk0CLRd4gqH/ZvY9sG2LBMLzdycckVg+byhjMWSBH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106202; c=relaxed/simple;
	bh=GzjQ1QrmncB3M8ZZh2gze1EuHsDImbS4oU69hNkTzxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+Cn32LQ9zrALW1LJ94dPVvJePIwi8TFZFU3hZQQuN2iCqOKEr85BrIMgH2fURsqK7HxMKnL8yqsvCi9y8Fh6gIogvKkMXKfPblAnEufLlgFi3wnl4UDZi6uGVKWH5vF52Ldn2QGr6LYCbjyf1+s072ZIF8vlOge/qLVsZs0Xv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7kXG/zL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a9296b3926so5847375ad.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772106199; x=1772710999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ciG01gWGaVHVP/mcZG8G3rAKieiLmIPuwLg8daH8Bc=;
        b=N7kXG/zLaNi1ZAQ7AJAqUJQxOVdwfK0I8LmmvNRfdxaEIybICnPjxHdN5HcT3A02HY
         oM2iVro0BLsp/WKWiGiwM4iOEHntbmvEGHUFbwmlFY8BEsrB30DEidmWOn3LuYlnJVkw
         dMMAXEnMRDu3grtp3+HJ8O9Id/ZIiofDu+2e3m4s4MISTCpR749peJb6VZrn+IQ40I5v
         qkQp5ZIJVmEMyHPmAKGMWmHrcw080Ylfc4t+BIL3Cyt81zaz6cUP3M8gRLQtXUP8AyDs
         7tC1XCUOUkd8sSfe+6juDnhdA8f5XEH+uDljxFyWg41bp6xMMQpkxJceoU6rx5XpMKa4
         zVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772106199; x=1772710999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ciG01gWGaVHVP/mcZG8G3rAKieiLmIPuwLg8daH8Bc=;
        b=h+YiuDvEAc+sGLKud9jtIWWFvYguWkaWdRzFnu6wkwsAgsXtEBleOoJYvxwR+NoHQm
         ejcq7zjTQgmE3CNesB01NdBZH0kXxJqPU653LZBDuPm/BOM+o2AozWNkOg6NjJNKsLsR
         s/Wna3yfCcw+f5DCSYl11NjU8N8s+9gZ2rqLXOCDmXlGnnhdouAwN/Eln/uM+1jb2IQ4
         Ej6qfrs9/uMZpUnbAgZPrqGwh/zYdlgZqOBMSFgTCqwMrZdvOMH+aT+RGBYDGtqytJKL
         Bm8zFg5YrThtijK2GRKf3xP+gTVkZPdBN2qNrQW8qq4biENktgBEECe9QnPnpvIub75D
         Y87A==
X-Gm-Message-State: AOJu0Yx91MjfcZ3YdTRZqYdOw3fcB1g6nTsdJTLjDWW/Df2MCwsD14kz
	CoLCS/qJz/3YXtZEKPrzj2bYd+gNIIcbxfexMuRDmZJKiNCji1YuZrJRtVENLMCd8SM=
X-Gm-Gg: ATEYQzzScJtW15JDy5MPwiV3gUVy3qGjXSpLoMwp8mUWoM/L3opQ0n03vJIsnd8fE9p
	j4DW1oLsJZCxeMTTBFVxuKE0LNNatMR2yZGG92TewlPNlDi6s2sHA9c8NJlGiI7Em7ynW8rMOup
	4Qxoo1Fa0EtRtJnldff3u+5RvS6n7gxG+aG/1sEOOInPoClN4f0u6+kzohdwmqinGIB0omqvA7S
	hbVg1cMK6uupZ4qZxCnxcx3daA+relds9e3ewGI354MheRierikgnSvdrbfZerLWmFIgTnK+xqf
	wDoQaMPzTLO9aOxGWXcoKudL7wIdRAXmTje9LVvRx2GU3P/eK0x9xT71aelE4XoXPu1DOtBzLXg
	GcH/jW4iMpUGOOhnrzdFMcfD9guoLFJL6agb/29q1Up0d4T7BLjrqeS0v40FEhMf7IL+GPNJkih
	cWxP94lvO0Wewe1IK9ypShZnTWJ9M=
X-Received: by 2002:a17:903:32d2:b0:2aa:f2f3:bcb0 with SMTP id d9443c01a7336-2ae036e631amr24181285ad.47.1772106199007;
        Thu, 26 Feb 2026 03:43:19 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dbac7sm34131545ad.37.2026.02.26.03.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 03:43:18 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [RFC PATCH net-next 1/3] net: add ndo_update_offloads
Date: Thu, 26 Feb 2026 11:42:06 +0000
Message-ID: <20260226114208.27774-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260226114208.27774-1-liuhangbin@gmail.com>
References: <20260226114208.27774-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,resnulli.us,blackwall.org,nvidia.com,fomichev.me,vger.kernel.org,lists.linux.dev,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-261307-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB94B1A5530
X-Rspamd-Action: no action

Add a new ndo_update_offloads callback to net_device_ops that allows
devices to compute and update their offload features during feature
updates.

This callback enabling master devices to recompute their features
based on current slave device configuration. This is particularly
useful for bonding, bridging, team, and failover devices that need
to aggregate features from their lower devices.

The callback is optional and only implemented by devices that need
dynamic offload feature computation.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 include/linux/netdevice.h | 7 +++++++
 net/core/dev.c            | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d4e6e00bb90a..1169091ccb9a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1281,6 +1281,12 @@ struct netdev_net_notifier {
  *	constraints, and returns the resulting flags. Must not modify
  *	the device state.
  *
+ * void (*ndo_update_offloads)(struct net_device *dev);
+ *	Called during feature update to allow device to compute and update
+ *	offload features (like vlan_features, hw_enc_features) based on
+ *	current lower device configuration. Typically used by master
+ *	devices to aggregate features from slave devices.
+ *
  * int (*ndo_set_features)(struct net_device *dev, netdev_features_t features);
  *	Called to update device configuration to new features. Passed
  *	feature set might be less than what was returned by ndo_fix_features()).
@@ -1558,6 +1564,7 @@ struct net_device_ops {
 							struct sock *sk);
 	netdev_features_t	(*ndo_fix_features)(struct net_device *dev,
 						    netdev_features_t features);
+	void			(*ndo_update_offloads)(struct net_device *dev);
 	int			(*ndo_set_features)(struct net_device *dev,
 						    netdev_features_t features);
 	int			(*ndo_neigh_construct)(struct net_device *dev,
diff --git a/net/core/dev.c b/net/core/dev.c
index 096b3ff13f6b..d05837c0713a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10982,6 +10982,9 @@ int __netdev_update_features(struct net_device *dev)
 	ASSERT_RTNL();
 	netdev_ops_assert_locked(dev);
 
+	if (dev->netdev_ops->ndo_update_offloads)
+		dev->netdev_ops->ndo_update_offloads(dev);
+
 	features = netdev_get_wanted_features(dev);
 
 	if (dev->netdev_ops->ndo_fix_features)
-- 
2.50.1


