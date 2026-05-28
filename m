Return-Path: <netdev+bounces-292889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJNFOf3NGGpjnggAu9opvQ
	(envelope-from <netdev+bounces-292889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:21:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F00A05FB5E3
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E6C13045B36
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A420D370AF1;
	Thu, 28 May 2026 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e74JMC/v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F4936B043
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010220; cv=none; b=I992PNTD6FrfIymxu/YvOY0KhNvWzSYsKhTjG0fbEpaXTD5Mnv51bwTrUK3QjEZKjRIxFX/K3Px9AYwi+ySv2k92zy3TTp6fBBrg8QnXtLwbxedbiOlkk/Gl8k+XKQC5pyO/65ahc15zD5JaFD8AQ21ZgHSnEzlTRJ8BBZm43Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010220; c=relaxed/simple;
	bh=RgP7uuD2GYCHhDUWeDvPbUOBJkllkoCX7L09s7tcjwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdZBRWaREPJulaD59/5tEPCSHDudINrJYQh7Z4M5FppGX3BSJLAP3ZgVYI1nh67RbBiowKkfnpXbNIE96qIFkOSKmHdmAYxh4WUZU0Y3l7elU5FC83OYk7oKEBa8MqfEEBfRf+ruB0bCZlIo6BHDEP2sCAJnVEJzfoDszG7/ZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e74JMC/v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6821F00A3E;
	Thu, 28 May 2026 23:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780010219;
	bh=KTQp6wn7XnN+tsO6HiISSLdK9Ryr20ZMYyNVcaa+Qwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e74JMC/vvSk8VRCPs6vs9o5bwirZjdaXQ8sana41gStmuxm28RlkNlY5rmBozIUiI
	 9qwEth+wYe6Qf+T2cxaYobxX6OBPxDSThWXQRGsDUiTMs2N1E7nL2r3yCHDh/m/ErX
	 IKDkEegiTE6iZHLcKQyijTArPCnUJTdU9hPV8qhXExDiaMLqgIURmwXKtvyM97dz1x
	 Gtj4SWUnU3sc/lBcfdk3fpBR/mY5jPSKUIGItuNqCHqTlp9rBnS0rAFzxEs7v9bOSl
	 /yM5VWdUFUOZqR8WIBS0lA9gCZP6fXkkbzG76tPJI8xwafFQlcvIFvVAIc11SAOde6
	 H16T0I53b69Sg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	haiyangz@microsoft.com,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	willemb@google.com,
	ernis@linux.microsoft.com,
	sdf.kernel@gmail.com,
	kory.maincent@bootlin.com,
	danieller@nvidia.com,
	idosch@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 12/14] net: ethtool: ioctl: concentrate the locking
Date: Thu, 28 May 2026 16:16:35 -0700
Message-ID: <20260528231637.251822-13-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528231637.251822-1-kuba@kernel.org>
References: <20260528231637.251822-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,nvidia.com,microsoft.com,armlinux.org.uk,bootlin.com,linux.microsoft.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-292889-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F00A05FB5E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add another layer of helper functions to make upcoming locking
changes easier. Otherwise we'd need a pretty complex goto
structure. netdev instance lock is now taken slightly sooner
but that should not be an issue since rtnl_lock is already held,
anyway.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/ioctl.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 1d74ee67e77a..6c3a7e8644ae 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -3257,18 +3257,14 @@ static int ethtool_set_fecparam(struct net_device *dev, void __user *useraddr)
 /* The main entry point in this file.  Called from net/core/dev_ioctl.c */
 
 static int
-__dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
-	      u32 ethcmd, struct ethtool_devlink_compat *devlink_state)
+dev_ethtool_locked(struct net *net, struct net_device *dev,
+		   void __user *useraddr,
+		   u32 ethcmd, struct ethtool_devlink_compat *devlink_state)
 {
-	struct net_device *dev;
 	u32 sub_cmd;
 	int rc;
 	netdev_features_t old_features;
 
-	dev = __dev_get_by_name(net, ifr->ifr_name);
-	if (!dev)
-		return -ENODEV;
-
 	if (ethcmd == ETHTOOL_PERQUEUE) {
 		if (copy_from_user(&sub_cmd, useraddr + sizeof(ethcmd), sizeof(sub_cmd)))
 			return -EFAULT;
@@ -3319,7 +3315,6 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 			return -EPERM;
 	}
 
-	netdev_lock_ops(dev);
 	if (dev->dev.parent)
 		pm_runtime_get_sync(dev->dev.parent);
 
@@ -3559,7 +3554,29 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 out:
 	if (dev->dev.parent)
 		pm_runtime_put(dev->dev.parent);
+
+	return rc;
+}
+
+static int
+__dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
+	      u32 ethcmd, struct ethtool_devlink_compat *devlink_state)
+{
+	struct net_device *dev;
+	int rc;
+
+	rtnl_lock();
+	dev = __dev_get_by_name(net, ifr->ifr_name);
+	if (!dev) {
+		rc = -ENODEV;
+		goto exit_rtnl_unlock;
+	}
+
+	netdev_lock_ops(dev);
+	rc = dev_ethtool_locked(net, dev, useraddr, ethcmd, devlink_state);
 	netdev_unlock_ops(dev);
+exit_rtnl_unlock:
+	rtnl_unlock();
 
 	return rc;
 }
@@ -3587,9 +3604,7 @@ int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr)
 		break;
 	}
 
-	rtnl_lock();
 	rc = __dev_ethtool(net, ifr, useraddr, ethcmd, state);
-	rtnl_unlock();
 	if (rc)
 		goto exit_free;
 
-- 
2.54.0


