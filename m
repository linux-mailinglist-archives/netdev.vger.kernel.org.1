Return-Path: <netdev+bounces-200424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C242DAE57D6
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB151C25B3D
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 23:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC6125CC44;
	Mon, 23 Jun 2025 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0DfnBXj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE29253F1D
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720646; cv=none; b=OUhvcztdb9FMm+UrUK8ITbAa6dR9Y6FUUduuCMDosUbOa9/ObJ0tF8HJy3uel3yojxXOgCbQpNOOhuyqdNujZ5I7yQdVjXJrfomWi0YHwjpaHUK+E6o7UlYqyGY02oAXPYbfVLQE4G/KC87hzTj91whQEo7blL/6hUZsdf+K6Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720646; c=relaxed/simple;
	bh=Zx11s1YucFMH1ZeVE8yR+BxFrskCjmQC0zphyCBX7kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m27Iaj3WyYR6spu+EXsYsjk/BNNeCj0wP9PJgqMtJrih1IqQWTJmLf4oTwuX/50ShqWBLGf9BTH4I+wGaRXXY8ZaIKl4u5R5qM4WB5th5Af+9/YpAVnn5M/ubjjWL83sm1GgJDK4a2/3v0WTwHAK4T8A/z8EaOJJAjJqbHGLVXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0DfnBXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B540C4CEF5;
	Mon, 23 Jun 2025 23:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750720646;
	bh=Zx11s1YucFMH1ZeVE8yR+BxFrskCjmQC0zphyCBX7kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n0DfnBXjGi90srMTlbwLHdPxwe96IGNXYHSaM8oyUBvZEcR/3cQWQcgIOSp81wixo
	 FNMoz9otmnd5ZegFDSsJiOOuSo3A7NFcBuS339bRyx1lpYGuB7iwJDJfsNm8q+dOXC
	 WkXJrgZXL2dxRHHkMTjqW8HaRNRSaRLIDgxcUJXCJRwb1J0t5qv/iwP0hr/Qr50Qc7
	 YfPkeLCEtzicsgEoCdP9su6CIIkNPoKNMgPHl4r8nP0bzpjUkTCGLC2c0DPP2YJDtF
	 zS9LNsuDo7cVFDPM2WmBIkL7FqfdoZ0IsuGJ0P/RjxnyZ0u7mWrxIUdKNyjmRZcmfy
	 vO6kQ0TxU8oeQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 4/8] net: ethtool: remove the data argument from ethtool_notify()
Date: Mon, 23 Jun 2025 16:17:16 -0700
Message-ID: <20250623231720.3124717-5-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623231720.3124717-1-kuba@kernel.org>
References: <20250623231720.3124717-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ethtool_notify() takes a const void *data argument, which presumably
was intended to pass information from the call site to the subcommand
handler. This argument currently has no users.

Expecting the data to be subcommand-specific has two complications.

Complication #1 is that its not plumbed thru any of the standardized
callbacks. It gets propagated to ethnl_default_notify() where it
remains unused. Coming from the ethnl_default_set_doit() side we pass
in NULL, because how could we have a command specific attribute in
a generic handler.

Complication #2 is that we expect the ethtool_notify() callers to
know what attribute type to pass in. Again, the data pointer is
untyped.

RSS will need to pass the context ID to the notifications.
I think it's a better design if the "subcommand" exports its own
typed interface and constructs the appropriate argument struct
(which will be req_info). Remove the unused data argument from
ethtool_notify() but retain it in a new internal helper which
subcommands can use to build a typed interface.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h |  5 ++---
 net/ethtool/netlink.h     |  1 +
 net/ethtool/ioctl.c       | 24 ++++++++++++------------
 net/ethtool/netlink.c     | 11 ++++++++---
 4 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 03c26bb0fbbe..db5bfd4e7ec8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5138,10 +5138,9 @@ void netdev_bonding_info_change(struct net_device *dev,
 				struct netdev_bonding_info *bonding_info);
 
 #if IS_ENABLED(CONFIG_ETHTOOL_NETLINK)
-void ethtool_notify(struct net_device *dev, unsigned int cmd, const void *data);
+void ethtool_notify(struct net_device *dev, unsigned int cmd);
 #else
-static inline void ethtool_notify(struct net_device *dev, unsigned int cmd,
-				  const void *data)
+static inline void ethtool_notify(struct net_device *dev, unsigned int cmd)
 {
 }
 #endif
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 91b953924af3..4a061944a3aa 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -23,6 +23,7 @@ void *ethnl_dump_put(struct sk_buff *skb, struct netlink_callback *cb, u8 cmd);
 void *ethnl_bcastmsg_put(struct sk_buff *skb, u8 cmd);
 void *ethnl_unicast_put(struct sk_buff *skb, u32 portid, u32 seq, u8 cmd);
 int ethnl_multicast(struct sk_buff *skb, struct net_device *dev);
+void ethnl_notify(struct net_device *dev, unsigned int cmd, const void *data);
 
 /**
  * ethnl_strz_size() - calculate attribute length for fixed size string
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 82cde640aa87..96da9d18789b 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -617,8 +617,8 @@ static int ethtool_set_link_ksettings(struct net_device *dev,
 
 	err = dev->ethtool_ops->set_link_ksettings(dev, &link_ksettings);
 	if (err >= 0) {
-		ethtool_notify(dev, ETHTOOL_MSG_LINKINFO_NTF, NULL);
-		ethtool_notify(dev, ETHTOOL_MSG_LINKMODES_NTF, NULL);
+		ethtool_notify(dev, ETHTOOL_MSG_LINKINFO_NTF);
+		ethtool_notify(dev, ETHTOOL_MSG_LINKMODES_NTF);
 	}
 	return err;
 }
@@ -708,8 +708,8 @@ static int ethtool_set_settings(struct net_device *dev, void __user *useraddr)
 		__ETHTOOL_LINK_MODE_MASK_NU32;
 	ret = dev->ethtool_ops->set_link_ksettings(dev, &link_ksettings);
 	if (ret >= 0) {
-		ethtool_notify(dev, ETHTOOL_MSG_LINKINFO_NTF, NULL);
-		ethtool_notify(dev, ETHTOOL_MSG_LINKMODES_NTF, NULL);
+		ethtool_notify(dev, ETHTOOL_MSG_LINKINFO_NTF);
+		ethtool_notify(dev, ETHTOOL_MSG_LINKMODES_NTF);
 	}
 	return ret;
 }
@@ -1868,7 +1868,7 @@ static int ethtool_set_wol(struct net_device *dev, char __user *useraddr)
 		return ret;
 
 	dev->ethtool->wol_enabled = !!wol.wolopts;
-	ethtool_notify(dev, ETHTOOL_MSG_WOL_NTF, NULL);
+	ethtool_notify(dev, ETHTOOL_MSG_WOL_NTF);
 
 	return 0;
 }
@@ -1944,7 +1944,7 @@ static int ethtool_set_eee(struct net_device *dev, char __user *useraddr)
 	eee_to_keee(&keee, &eee);
 	ret = dev->ethtool_ops->set_eee(dev, &keee);
 	if (!ret)
-		ethtool_notify(dev, ETHTOOL_MSG_EEE_NTF, NULL);
+		ethtool_notify(dev, ETHTOOL_MSG_EEE_NTF);
 	return ret;
 }
 
@@ -2184,7 +2184,7 @@ static noinline_for_stack int ethtool_set_coalesce(struct net_device *dev,
 	ret = dev->ethtool_ops->set_coalesce(dev, &coalesce, &kernel_coalesce,
 					     NULL);
 	if (!ret)
-		ethtool_notify(dev, ETHTOOL_MSG_COALESCE_NTF, NULL);
+		ethtool_notify(dev, ETHTOOL_MSG_COALESCE_NTF);
 	return ret;
 }
 
@@ -2228,7 +2228,7 @@ static int ethtool_set_ringparam(struct net_device *dev, void __user *useraddr)
 	ret = dev->ethtool_ops->set_ringparam(dev, &ringparam,
 					      &kernel_ringparam, NULL);
 	if (!ret)
-		ethtool_notify(dev, ETHTOOL_MSG_RINGS_NTF, NULL);
+		ethtool_notify(dev, ETHTOOL_MSG_RINGS_NTF);
 	return ret;
 }
 
@@ -2295,7 +2295,7 @@ static noinline_for_stack int ethtool_set_channels(struct net_device *dev,
 
 	ret = dev->ethtool_ops->set_channels(dev, &channels);
 	if (!ret)
-		ethtool_notify(dev, ETHTOOL_MSG_CHANNELS_NTF, NULL);
+		ethtool_notify(dev, ETHTOOL_MSG_CHANNELS_NTF);
 	return ret;
 }
 
@@ -2326,7 +2326,7 @@ static int ethtool_set_pauseparam(struct net_device *dev, void __user *useraddr)
 
 	ret = dev->ethtool_ops->set_pauseparam(dev, &pauseparam);
 	if (!ret)
-		ethtool_notify(dev, ETHTOOL_MSG_PAUSE_NTF, NULL);
+		ethtool_notify(dev, ETHTOOL_MSG_PAUSE_NTF);
 	return ret;
 }
 
@@ -3328,7 +3328,7 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 		rc = ethtool_set_value_void(dev, useraddr,
 				       dev->ethtool_ops->set_msglevel);
 		if (!rc)
-			ethtool_notify(dev, ETHTOOL_MSG_DEBUG_NTF, NULL);
+			ethtool_notify(dev, ETHTOOL_MSG_DEBUG_NTF);
 		break;
 	case ETHTOOL_GEEE:
 		rc = ethtool_get_eee(dev, useraddr);
@@ -3392,7 +3392,7 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 		rc = ethtool_get_value(dev, useraddr, ethcmd,
 				       dev->ethtool_ops->get_priv_flags);
 		if (!rc)
-			ethtool_notify(dev, ETHTOOL_MSG_PRIVFLAGS_NTF, NULL);
+			ethtool_notify(dev, ETHTOOL_MSG_PRIVFLAGS_NTF);
 		break;
 	case ETHTOOL_SPFLAGS:
 		rc = ethtool_set_value(dev, useraddr,
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index c5ec3c82ab2e..129f9d56ac65 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -911,7 +911,7 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 	swap(dev->cfg, dev->cfg_pending);
 	if (!ret)
 		goto out_ops;
-	ethtool_notify(dev, ops->set_ntf_cmd, NULL);
+	ethtool_notify(dev, ops->set_ntf_cmd);
 
 	ret = 0;
 out_ops:
@@ -1049,7 +1049,7 @@ static const ethnl_notify_handler_t ethnl_notify_handlers[] = {
 	[ETHTOOL_MSG_MM_NTF]		= ethnl_default_notify,
 };
 
-void ethtool_notify(struct net_device *dev, unsigned int cmd, const void *data)
+void ethnl_notify(struct net_device *dev, unsigned int cmd, const void *data)
 {
 	if (unlikely(!ethnl_ok))
 		return;
@@ -1062,13 +1062,18 @@ void ethtool_notify(struct net_device *dev, unsigned int cmd, const void *data)
 		WARN_ONCE(1, "notification %u not implemented (dev=%s)\n",
 			  cmd, netdev_name(dev));
 }
+
+void ethtool_notify(struct net_device *dev, unsigned int cmd)
+{
+	ethnl_notify(dev, cmd, NULL);
+}
 EXPORT_SYMBOL(ethtool_notify);
 
 static void ethnl_notify_features(struct netdev_notifier_info *info)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(info);
 
-	ethtool_notify(dev, ETHTOOL_MSG_FEATURES_NTF, NULL);
+	ethtool_notify(dev, ETHTOOL_MSG_FEATURES_NTF);
 }
 
 static int ethnl_netdev_event(struct notifier_block *this, unsigned long event,
-- 
2.49.0


