Return-Path: <netdev+bounces-176899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CB5A6CAD7
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3478E487C71
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C7723314B;
	Sat, 22 Mar 2025 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="HxL+cQDg"
X-Original-To: netdev@vger.kernel.org
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD35922FE03;
	Sat, 22 Mar 2025 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654540; cv=none; b=H0ajjjR//6P3lNfnhmYwwsGPq0+w0VwivyoEx2J4rBsTr52aZu7vyS9XBjcogiGPZXqlTHG1TBQwv6sz4Swdo4FXDUMM2eHPB+g/dNFARXVoxviIHKYP8WwFRml/cm2XnzwRsyms7vhUW/xnrV27XOT98C715C9o8o4335F8rTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654540; c=relaxed/simple;
	bh=t3CTJxIr/L+qJQHfFfaUcl1nQlZGAayYjijIBAU4mVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8cPOVtG4t97oMqYFmoPdipp29c+HqWeYEOsTQXwUAOFalPkieMyZ9BTWkRneu2UY2jCWjkBFA8xRTCgXtKgsiVAGl4zCOmIMJ+w3PaCOnQD8Sfov7/qwmmDhJXoG6ImRVttGGRL/KwIb1WDUmfnU0AxqAJfHVF2x2Ig5xqoQCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=HxL+cQDg; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:7c8:0:640:150d:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 10A87608E7;
	Sat, 22 Mar 2025 17:42:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id EgNoG8VLZiE0-AMG8GvFy;
	Sat, 22 Mar 2025 17:42:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654535; bh=Ebnh/9PCK5RmHmO7wXmy4UHampymm+ETYckr1okzMSM=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=HxL+cQDgvRVVzFVgGVi3A8INpNXgAFk/wzlDAMYc9R8xUtEWoXHIezUVn4KrfpiFd
	 yXfq6MErUfMSZucpl4Q9jh3rr/t5qXeTjVJ0GHeP5YLRZQVGYTir1JoANEjTTJgjiO
	 J2il3scsqLCPXEhRcSg5PQowQXLuxS0q+fp61OXU=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 35/51] cfg80211: Use fallback_nd_lock for registered devices
Date: Sat, 22 Mar 2025 17:42:14 +0300
Message-ID: <174265453410.356712.9874476765501764676.stgit@pro.pro>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174265415457.356712.10472727127735290090.stgit@pro.pro>
References: <174265415457.356712.10472727127735290090.stgit@pro.pro>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

For now we use fallback_nd_lock for all drivers registering
via cfg80211_register_netdevice().

One of the reasons is that they are used as a bunch
in cfg80211_switch_netns(), while we want to call
dev_change_net_namespace() under nd_lock in one of
next patches.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 drivers/net/wireless/ath/ath6kl/core.c        |    2 ++
 drivers/net/wireless/ath/wil6210/netdev.c     |    2 ++
 drivers/net/wireless/marvell/mwifiex/main.c   |    5 +++++
 drivers/net/wireless/quantenna/qtnfmac/core.c |    2 ++
 net/mac80211/main.c                           |    2 ++
 net/wireless/core.c                           |   10 ++++++++--
 net/wireless/nl80211.c                        |   14 ++++++++++++++
 7 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/core.c b/drivers/net/wireless/ath/ath6kl/core.c
index 4f0a7a185fc9..8c28f5a476ef 100644
--- a/drivers/net/wireless/ath/ath6kl/core.c
+++ b/drivers/net/wireless/ath/ath6kl/core.c
@@ -212,6 +212,7 @@ int ath6kl_core_init(struct ath6kl *ar, enum ath6kl_htc_type htc_type)
 		ar->avail_idx_map |= BIT(i);
 
 	rtnl_lock();
+	mutex_lock(&fallback_nd_lock.mutex);
 	wiphy_lock(ar->wiphy);
 
 	/* Add an initial station interface */
@@ -219,6 +220,7 @@ int ath6kl_core_init(struct ath6kl *ar, enum ath6kl_htc_type htc_type)
 				    NL80211_IFTYPE_STATION, 0, INFRA_NETWORK);
 
 	wiphy_unlock(ar->wiphy);
+	mutex_unlock(&fallback_nd_lock.mutex);
 	rtnl_unlock();
 
 	if (!wdev) {
diff --git a/drivers/net/wireless/ath/wil6210/netdev.c b/drivers/net/wireless/ath/wil6210/netdev.c
index d5d364683c0e..57958b44717d 100644
--- a/drivers/net/wireless/ath/wil6210/netdev.c
+++ b/drivers/net/wireless/ath/wil6210/netdev.c
@@ -474,9 +474,11 @@ int wil_if_add(struct wil6210_priv *wil)
 	wil_update_net_queues_bh(wil, vif, NULL, true);
 
 	rtnl_lock();
+	mutex_lock(&fallback_nd_lock.mutex);
 	wiphy_lock(wiphy);
 	rc = wil_vif_add(wil, vif);
 	wiphy_unlock(wiphy);
+	mutex_unlock(&fallback_nd_lock.mutex);
 	rtnl_unlock();
 	if (rc < 0)
 		goto free_dummy;
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 96d1f6039fbc..c4b112d2f0b2 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -623,6 +623,7 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 	}
 
 	rtnl_lock();
+	mutex_lock(&fallback_nd_lock.mutex);
 	wiphy_lock(adapter->wiphy);
 	/* Create station interface by default */
 	wdev = mwifiex_add_virtual_intf(adapter->wiphy, "mlan%d", NET_NAME_ENUM,
@@ -631,6 +632,7 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 		mwifiex_dbg(adapter, ERROR,
 			    "cannot create default STA interface\n");
 		wiphy_unlock(adapter->wiphy);
+		mutex_unlock(&fallback_nd_lock.mutex);
 		rtnl_unlock();
 		goto err_add_intf;
 	}
@@ -642,6 +644,7 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 			mwifiex_dbg(adapter, ERROR,
 				    "cannot create AP interface\n");
 			wiphy_unlock(adapter->wiphy);
+			mutex_unlock(&fallback_nd_lock.mutex);
 			rtnl_unlock();
 			goto err_add_intf;
 		}
@@ -654,11 +657,13 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 			mwifiex_dbg(adapter, ERROR,
 				    "cannot create p2p client interface\n");
 			wiphy_unlock(adapter->wiphy);
+			mutex_unlock(&fallback_nd_lock.mutex);
 			rtnl_unlock();
 			goto err_add_intf;
 		}
 	}
 	wiphy_unlock(adapter->wiphy);
+	mutex_unlock(&fallback_nd_lock.mutex);
 	rtnl_unlock();
 
 	mwifiex_drv_get_driver_version(adapter, fmt, sizeof(fmt) - 1);
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index 825b05dd3271..7952e3314aca 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -597,9 +597,11 @@ static int qtnf_core_mac_attach(struct qtnf_bus *bus, unsigned int macid)
 	mac->wiphy_registered = 1;
 
 	rtnl_lock();
+	mutex_lock(&fallback_nd_lock.mutex);
 	wiphy_lock(priv_to_wiphy(mac));
 	ret = qtnf_core_net_attach(mac, vif, "wlan%d", NET_NAME_ENUM);
 	wiphy_unlock(priv_to_wiphy(mac));
+	mutex_unlock(&fallback_nd_lock.mutex);
 	rtnl_unlock();
 
 	if (ret) {
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index a3104b6ea6f0..bacea2473a21 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1582,6 +1582,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	ieee80211_check_wbrf_support(local);
 
 	rtnl_lock();
+	mutex_lock(&fallback_nd_lock.mutex);
 	wiphy_lock(hw->wiphy);
 
 	/* add one default STA interface if supported */
@@ -1597,6 +1598,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	}
 
 	wiphy_unlock(hw->wiphy);
+	mutex_unlock(&fallback_nd_lock.mutex);
 	rtnl_unlock();
 
 #ifdef CONFIG_INET
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 4d5d351bd0b5..8ba0ada86678 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1439,7 +1439,11 @@ int cfg80211_register_netdevice(struct net_device *dev)
 	/* we'll take care of this */
 	wdev->registered = true;
 	wdev->registering = true;
-	ret = register_netdevice(dev);
+
+	if (!mutex_is_locked(&fallback_nd_lock.mutex))
+		return -EXDEV;
+	attach_nd_lock(dev, &fallback_nd_lock);
+	ret = __register_netdevice(dev);
 	if (ret)
 		goto out;
 
@@ -1447,8 +1451,10 @@ int cfg80211_register_netdevice(struct net_device *dev)
 	ret = 0;
 out:
 	wdev->registering = false;
-	if (ret)
+	if (ret) {
+		detach_nd_lock(dev);
 		wdev->registered = false;
+	}
 	return ret;
 }
 EXPORT_SYMBOL(cfg80211_register_netdevice);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7397a372c78e..0fd66f75eace 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16455,6 +16455,7 @@ nl80211_set_ttlm(struct sk_buff *skb, struct genl_info *info)
 #define NL80211_FLAG_NO_WIPHY_MTX	0x40
 #define NL80211_FLAG_MLO_VALID_LINK_ID	0x80
 #define NL80211_FLAG_MLO_UNSUPPORTED	0x100
+#define NL80211_FLAG_NEED_FALLBACK_ND_LOCK	0x200
 
 #define INTERNAL_FLAG_SELECTORS(__sel)			\
 	SELECTOR(__sel, NONE, 0) /* must be first */	\
@@ -16477,6 +16478,11 @@ nl80211_set_ttlm(struct sk_buff *skb, struct genl_info *info)
 		 NL80211_FLAG_NEED_WIPHY |		\
 		 NL80211_FLAG_NEED_RTNL |		\
 		 NL80211_FLAG_NO_WIPHY_MTX)		\
+	SELECTOR(__sel, WIPHY_RTNL_ND_LOCK,		\
+		 NL80211_FLAG_NEED_WIPHY |		\
+		 NL80211_FLAG_NEED_FALLBACK_ND_LOCK |	\
+		 NL80211_FLAG_NEED_RTNL |		\
+		 NL80211_FLAG_NO_WIPHY_MTX)		\
 	SELECTOR(__sel, WDEV_RTNL,			\
 		 NL80211_FLAG_NEED_WDEV |		\
 		 NL80211_FLAG_NEED_RTNL)		\
@@ -16545,6 +16551,7 @@ static int nl80211_pre_doit(const struct genl_split_ops *ops,
 	internal_flags = nl80211_internal_flags[ops->internal_flags];
 
 	rtnl_lock();
+	mutex_lock(&fallback_nd_lock.mutex);
 	if (internal_flags & NL80211_FLAG_NEED_WIPHY) {
 		rdev = cfg80211_get_dev_from_info(genl_info_net(info), info);
 		if (IS_ERR(rdev)) {
@@ -16621,11 +16628,15 @@ static int nl80211_pre_doit(const struct genl_split_ops *ops,
 		/* we keep the mutex locked until post_doit */
 		__release(&rdev->wiphy.mtx);
 	}
+
+	if (!(internal_flags & NL80211_FLAG_NEED_FALLBACK_ND_LOCK))
+		mutex_unlock(&fallback_nd_lock.mutex);
 	if (!(internal_flags & NL80211_FLAG_NEED_RTNL))
 		rtnl_unlock();
 
 	return 0;
 out_unlock:
+	mutex_unlock(&fallback_nd_lock.mutex);
 	rtnl_unlock();
 	dev_put(dev);
 	return err;
@@ -16656,6 +16667,8 @@ static void nl80211_post_doit(const struct genl_split_ops *ops,
 		wiphy_unlock(&rdev->wiphy);
 	}
 
+	if (internal_flags & NL80211_FLAG_NEED_FALLBACK_ND_LOCK)
+		mutex_unlock(&fallback_nd_lock.mutex);
 	if (internal_flags & NL80211_FLAG_NEED_RTNL)
 		rtnl_unlock();
 
@@ -16821,6 +16834,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags =
 			IFLAGS(NL80211_FLAG_NEED_WIPHY |
+			       NL80211_FLAG_NEED_FALLBACK_ND_LOCK |
 			       NL80211_FLAG_NEED_RTNL |
 			       /* we take the wiphy mutex later ourselves */
 			       NL80211_FLAG_NO_WIPHY_MTX),


