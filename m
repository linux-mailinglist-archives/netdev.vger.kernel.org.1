Return-Path: <netdev+bounces-261309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLlxAE8yoGmLgAQAu9opvQ
	(envelope-from <netdev+bounces-261309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:45:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D611A5431
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04B8130BB296
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3E5377556;
	Thu, 26 Feb 2026 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERy1PxuB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4FE376BFB
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106215; cv=none; b=JCou2Pty0kDddu3Lvjn6aebv3JnIcM9xsKc/Smj1Iaw6aUsmUzXq1AEts8FuHrMUaasjkfGdDKxVM474oNLE2qif389KolfPJ8bUHJoznyY++4paTehiOD49ZwAiq8XGg5WgcsAE6UwccDtgejzi57V4ej+TYLjwwEb9xoZKHWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106215; c=relaxed/simple;
	bh=W8/P9pOZ2TaGtqC+2IqlgV4WZxsB2rdjDd83Ft34dw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9/OCWC5qUuFMr3F/Ff9YP9BU2mDXUgGo2ax5yNOm+qW7GaYU4CUTMtvh01HtOvg9adqgKl4w5LKpYfPnjUvVhY87egNDZrGde/JQeG/yZ9/wutZnHrOHbxVucj91b/RIeYBXAsoa/USdrn8Pq9O2ktnfSk7RI4E6Tm73FlEHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERy1PxuB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a871daa98fso5739505ad.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772106213; x=1772711013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbhS0NvKYgSA4IUttJNgnpP91LFlge369iIxmO7B660=;
        b=ERy1PxuBzHujcE1H+s+0KuXiE01OUdcIDWsRStKHS7fjsmiGejgn0LtD7JWVlS8xe0
         jM5FwmnimPE+AQG1gOPPqx9uZoGEADLI9ww2DYFUJLX2bNracRCBjr03iqm3a8iAIYNU
         yTETcdfxXLctMH5wn/77vfQYGgUYiPqoiI+iDbH6qa9ROJ6755NOXHJRugP3X3BPbYl1
         K271h7Lq5XaWmIHTEy9+aTr+9Fewnitp8wrPy2WfyrqUWR6/T8n9ab7XrR5zNMZ98nrb
         uncN3fcEk7dEvhBkmLSNhi2c/JzrwegcCwMo8eN4KXN7cm4VuUN4JE5oDU3cZK8FCRUI
         SO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772106213; x=1772711013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PbhS0NvKYgSA4IUttJNgnpP91LFlge369iIxmO7B660=;
        b=inzQLOttqd/z8h/kmePRgoeLr2TXo4BIzn4GCziIobHhm8BVBbD3JNnXEuZxXe8U3r
         ziTC1Cv3b+flSaeIBhfhmRRAFe2/e1c1sD9yLPsG56SBBj9vyNdn6tQmSKFKrn7mWdJG
         TcAVTV5vKHZKP1Tv+kAspbnUy0Oj62d/f3sRICrqAmTY5rTNL1kgxq1apIuPwbwYzoLI
         ftOaxmWk+3NNZC758R0F3DRL3NLn2W0av8lsBpWZiabeVGs9CHCFLpW1YbZFz/OpD5lo
         BVvflnNfFVkoar9cOCQJrO7WiCJfTyM9HEljmgtpj79YA+Y3i6q5Cz6KNZmQ7CEJYJ06
         axdw==
X-Gm-Message-State: AOJu0YwXlejl7kQdc9Hnu5Bz9rkefX2Q/WQ8LEH/hAzGVxFfgdcwNkE6
	DPb3hSgThTrg4Xm5Q7oKR8GAsuFXtiD6asVY6/MBBOD5g/9QeOE1TdRfiQ0NCdTs+2A=
X-Gm-Gg: ATEYQzxa/A5hgxnk6AZV8B8uzj0U4dWU5QGQSQxkX5S2Asd6sz0uu5cbBw+Y016mOHe
	BXMaKQalkisOBZeLOI7m6j1kOUIdrTW1FHZ4EO54H+m+/xkeAfdLoTjxvwQDXQm6FlOqZmib6Wp
	hHYtrk1LBplaPgpWtYMYYkF9K2Ck08+M0rC9o/CrjvtByJl8TM7CnUEPoXHjHejC8ODduLPX0jF
	2el2DXkjw0ERsuXUhICOv5z+b1rqC2HNeIWS6jh3IpwKk7l4w3T9UvjdpCjEYKKVQ2mbyj6zq2Z
	EftmYibizs1ALt+c4utqsEArmIh9gVH3O3Ohor66yALUNTSYInHSgSI9S3/ZtHF1I56LdQdkPQ6
	Zv+Fsgf+E6nec9FgsDuDpRaK/u56fKVqz5PJYQfGhLTEF5nHZ1ljv6eYQEnWIt6VSjZTpZM7LRQ
	BCU35wAITUz3ZbRZ4RljEYoJT7CWk=
X-Received: by 2002:a17:902:f68c:b0:2ad:ae4f:3468 with SMTP id d9443c01a7336-2ade9a4fd5cmr39424435ad.38.1772106213588;
        Thu, 26 Feb 2026 03:43:33 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dbac7sm34131545ad.37.2026.02.26.03.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 03:43:33 -0800 (PST)
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
Subject: [RFC PATCH net-next 3/3] failover: use .ndo_update_offloads for failover
Date: Thu, 26 Feb 2026 11:42:08 +0000
Message-ID: <20260226114208.27774-4-liuhangbin@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,resnulli.us,blackwall.org,nvidia.com,fomichev.me,vger.kernel.org,lists.linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-261309-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 63D611A5431
X-Rspamd-Action: no action

Convert net_failover to use the new ndo_update_offloads callback
instead of manually calling netdev_compute_master_upper_features()
during slave registration/unregistration.

This simplifies the failover code significantly by removing the custom
feature computation logic and relying on the centralized feature update
mechanism. The callback is automatically invoked during feature updates
when upper/lower device links change.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/net_failover.c | 64 ++++----------------------------------
 include/net/net_failover.h |  7 -----
 2 files changed, 6 insertions(+), 65 deletions(-)

diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index d0361aaf25ef..527175f554a6 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -300,6 +300,11 @@ static int net_failover_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
 	return 0;
 }
 
+static void failover_update_offloads(struct net_device *dev)
+{
+	netdev_compute_master_upper_features(dev, true);
+}
+
 static const struct net_device_ops failover_dev_ops = {
 	.ndo_open		= net_failover_open,
 	.ndo_stop		= net_failover_close,
@@ -312,6 +317,7 @@ static const struct net_device_ops failover_dev_ops = {
 	.ndo_vlan_rx_kill_vid	= net_failover_vlan_rx_kill_vid,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_features_check	= passthru_features_check,
+	.ndo_update_offloads    = failover_update_offloads,
 };
 
 #define FAILOVER_NAME "net_failover"
@@ -373,61 +379,6 @@ static rx_handler_result_t net_failover_handle_frame(struct sk_buff **pskb)
 	return RX_HANDLER_ANOTHER;
 }
 
-static void net_failover_compute_features(struct net_device *dev)
-{
-	netdev_features_t vlan_features = FAILOVER_VLAN_FEATURES &
-					  NETIF_F_ALL_FOR_ALL;
-	netdev_features_t enc_features  = FAILOVER_ENC_FEATURES;
-	unsigned short max_hard_header_len = ETH_HLEN;
-	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
-					IFF_XMIT_DST_RELEASE_PERM;
-	struct net_failover_info *nfo_info = netdev_priv(dev);
-	struct net_device *primary_dev, *standby_dev;
-
-	primary_dev = rcu_dereference(nfo_info->primary_dev);
-	if (primary_dev) {
-		vlan_features =
-			netdev_increment_features(vlan_features,
-						  primary_dev->vlan_features,
-						  FAILOVER_VLAN_FEATURES);
-		enc_features =
-			netdev_increment_features(enc_features,
-						  primary_dev->hw_enc_features,
-						  FAILOVER_ENC_FEATURES);
-
-		dst_release_flag &= primary_dev->priv_flags;
-		if (primary_dev->hard_header_len > max_hard_header_len)
-			max_hard_header_len = primary_dev->hard_header_len;
-	}
-
-	standby_dev = rcu_dereference(nfo_info->standby_dev);
-	if (standby_dev) {
-		vlan_features =
-			netdev_increment_features(vlan_features,
-						  standby_dev->vlan_features,
-						  FAILOVER_VLAN_FEATURES);
-		enc_features =
-			netdev_increment_features(enc_features,
-						  standby_dev->hw_enc_features,
-						  FAILOVER_ENC_FEATURES);
-
-		dst_release_flag &= standby_dev->priv_flags;
-		if (standby_dev->hard_header_len > max_hard_header_len)
-			max_hard_header_len = standby_dev->hard_header_len;
-	}
-
-	dev->vlan_features = vlan_features;
-	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL;
-	dev->hard_header_len = max_hard_header_len;
-
-	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
-	if (dst_release_flag == (IFF_XMIT_DST_RELEASE |
-				 IFF_XMIT_DST_RELEASE_PERM))
-		dev->priv_flags |= IFF_XMIT_DST_RELEASE;
-
-	netdev_change_features(dev);
-}
-
 static void net_failover_lower_state_changed(struct net_device *slave_dev,
 					     struct net_device *primary_dev,
 					     struct net_device *standby_dev)
@@ -550,7 +501,6 @@ static int net_failover_slave_register(struct net_device *slave_dev,
 	}
 
 	net_failover_lower_state_changed(slave_dev, primary_dev, standby_dev);
-	net_failover_compute_features(failover_dev);
 
 	call_netdevice_notifiers(NETDEV_JOIN, slave_dev);
 
@@ -621,8 +571,6 @@ static int net_failover_slave_unregister(struct net_device *slave_dev,
 
 	dev_put(slave_dev);
 
-	net_failover_compute_features(failover_dev);
-
 	netdev_info(failover_dev, "failover %s slave:%s unregistered\n",
 		    slave_is_standby ? "standby" : "primary", slave_dev->name);
 
diff --git a/include/net/net_failover.h b/include/net/net_failover.h
index b12a1c469d1c..f0f038d113a0 100644
--- a/include/net/net_failover.h
+++ b/include/net/net_failover.h
@@ -30,11 +30,4 @@ struct net_failover_info {
 struct failover *net_failover_create(struct net_device *standby_dev);
 void net_failover_destroy(struct failover *failover);
 
-#define FAILOVER_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_FRAGLIST | NETIF_F_ALL_TSO | \
-				 NETIF_F_HIGHDMA | NETIF_F_LRO)
-
-#define FAILOVER_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_RXCSUM | NETIF_F_ALL_TSO)
-
 #endif /* _NET_FAILOVER_H */
-- 
2.50.1


