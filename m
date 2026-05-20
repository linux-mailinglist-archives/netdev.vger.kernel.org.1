Return-Path: <netdev+bounces-289825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPPoGYFtDWrgxAUAu9opvQ
	(envelope-from <netdev+bounces-289825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:14:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D540758983B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6231730846AA
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA6B3A873D;
	Wed, 20 May 2026 08:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFN2bEbs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BEE3A9618
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264638; cv=none; b=VLpWHmggTasc+bNtPE32qSES+vc3vpxnKgMCkplc6UynAVU13zAnYenMaVaCpqHqw8aoTdIj4XRtHer2IsvLg5typvD2H3d0O6hYaLK52QHuwy9WoyNGKMJZEg4xcneGO3nXg+YLyfwUnUhQT8TrOfNcmjya8aojEZ+sqqjfWzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264638; c=relaxed/simple;
	bh=4ND/hhTipseeVwzG+pxwJxvXf1aZaEOHsBBDRic9/Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJVhcN/dgJT+jxqhQYW7QafWxwVh8BYhWRhYu+bv0I8ZF+Ewx5rfsqR1bFFO5QBfC09c9ibMb68uLtXGNvA442TsxdXnwA9a5jyx5BPY3n3ScPWJae4fsFkdVph7qwxSQhtmiVIx0mgFF8cEOIs6CSeshIRVcq/54akobISu9hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFN2bEbs; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c8173b2af32so3533664a12.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 01:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779264634; x=1779869434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lF/xBy0b+pG1BSktUEe93aPhpfzhEzGrgWB/FDUpwfM=;
        b=dFN2bEbsSig7CXMMUlHEvPJ7vEnxhyDyz+6UubH7TXUVg4JAdbr2GpAvBxXnVXpbSe
         bLqxRX4bpTwrTngeTj2Qa1m/pvrpDuPybMVPnWhB0+l+IRAuH5G340jyu/Ej8Ps2xKgV
         pIDu1LP3hA2KFSFU1g+nBB1X74Ew7fz7cMs30vtQe7Bfn+EBCQ40joXH8Oic6Csc1A5Z
         m1HSSeTjjB4B+fApK7igAU6i7Cuj931VurPZgvurlgmvniynHDKh7154Px8tyKL1kZzY
         Wwzk65mzO2fSpe9w74UH7lmJFymawIVFMVD+QwYGO4ERW/kWYpZ36wOWcrJTm0Gt285v
         pXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779264634; x=1779869434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lF/xBy0b+pG1BSktUEe93aPhpfzhEzGrgWB/FDUpwfM=;
        b=LjFAxXmljW1SlHYnFKkyTiP/7MZpP4V9FH2WNRQMwyKvFu1BsGAkEpHBHOCXvemzh8
         dXD50Z9LZ852pP1OVRkFdFHeqPk6vzZYuR6NRh6FRXu5TheknL7nh5bk++y375fzXST8
         m0UkMoBqOWTbA/rm3d+P4qBB93X4VlrmESyycymdkwtYEuUbp+yW6KTJUZGJ4eTSEm0A
         UAd/RvK2g0D4N4VuKzzag7UpCx3LkJlcHAdjLwgC59c6/hOZMI2M8V2mulPXwLbxOQHG
         BJCz3cNf9WJsTtRipkCAyHErcUCjPvyKIcv6IevmnsH0zZeRDUqZbtquqAwwiksI5iNC
         g4Nw==
X-Gm-Message-State: AOJu0YydMR0o9R5dD+ih9dkAIVgNcyBPSb2rGAyMlfoSZsLfzFb6Cjcm
	KdZTepOzDlTldRCCKWEfzPo03h8mpUI+lBhNgcUgM9LEqrGO9FKa3cGiR6lViW5O
X-Gm-Gg: Acq92OEXATXoHBx2HTNE/CzInb0PQgIt69Xw/pQ/qf4EMV/fkk/EACKqd6wriHXbBH6
	XxDdh44WXnmdEu2SA8oyoeSWKYZxzqkHlZd5q7tIpXy05Ri1j+b6fCGmDYppy96cOIRbK30aOdc
	RSj+BzkT7Fnm2TBHqOCwVwVP3GNDZYbFO+eaCTQDr3uFYIouzmxqmELqMEHvWC0OeheHgm1jCwe
	Q7j0Sb6QBKb4nPoNH4d+TecklLPX+xurDs8FeRMejIkEcPqcMuOlcqNgqZYeKFXWqVWAv83apCD
	VPUl8HZBQ+zW5V3kA0bOUehoSqlzDBWc88r8a27atsABW93wnA6lFYggRYy+oJaqx3pqO0s1fjt
	iHBgaAPLbT9lEwK8GSpLKbmxIno/NoKMR9Y/EJXiJm9OPOtOOQbjEkyiZENpFKNBdMf/hraIuZA
	6V0Tv+mPh9ViTzNzUuAXzA
X-Received: by 2002:a17:902:da8a:b0:2bd:eb0d:efb7 with SMTP id d9443c01a7336-2bdeb0df7b4mr117589775ad.1.1779264634180;
        Wed, 20 May 2026 01:10:34 -0700 (PDT)
Received: from mincom1 ([14.67.155.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d116287sm211632735ad.68.2026.05.20.01.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:10:33 -0700 (PDT)
From: Jihong Min <hurryman2212@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org,
	Jihong Min <hurryman2212@gmail.com>
Subject: [PATCH RFC net-next 3/4] bonding: expose user-controlled IPsec features for LAG
Date: Wed, 20 May 2026 17:10:03 +0900
Message-ID: <20260520081004.2232091-4-hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520081004.2232091-1-hurryman2212@gmail.com>
References: <20260520081004.2232091-1-hurryman2212@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,secunet.com,gondor.apana.org.au,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-289825-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D540758983B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Expose LAG IPsec offload as user-controlled bonding features instead of
enabling it by default. Keep the existing active-backup default behavior,
but make newly eligible LAG bonds start with ESP/XFRM features explicitly
disabled so users opt in with ethtool.

Let 802.3ad and balance-xor with layer3+4 advertise the intersection of
XFRM features across running eligible slaves, with supported features
shown as mutable off features rather than fixed-off capabilities.

Propagate mutable XFRM feature requests to running lower devices, verify
that requested features are actually enabled, and roll lower devices back
if propagation fails. Disable dependent ESP checksum and segmentation
features when HW ESP is not available.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Jihong Min <hurryman2212@gmail.com>
---
 drivers/net/bonding/bond_main.c    | 232 +++++++++++++++++++++++++++++
 drivers/net/bonding/bond_options.c |   2 +-
 2 files changed, 233 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 66435de852e9..d81dae5a1902 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2048,6 +2048,13 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 	struct list_head *iter;
 	netdev_features_t mask;
 	struct slave *slave;
+#ifdef CONFIG_XFRM_OFFLOAD
+	netdev_features_t lag_xfrm_features = BOND_XFRM_FEATURES;
+	bool ab_xfrm = BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP;
+	bool lag_xfrm_ok = true;
+	bool lag_xfrm = bond_mode_can_use_lag_xfrm(bond);
+	int lag_xfrm_slaves = 0;
+#endif /* CONFIG_XFRM_OFFLOAD */
 
 	mask = features;
 	features = netdev_base_features(features);
@@ -2056,12 +2063,234 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 		features = netdev_increment_features(features,
 						     slave->dev->features,
 						     mask);
+#ifdef CONFIG_XFRM_OFFLOAD
+		if (lag_xfrm && (mask & BOND_XFRM_FEATURES) &&
+		    netif_running(slave->dev)) {
+			netdev_features_t slave_xfrm_features;
+			netdev_features_t slave_xfrm_enableable;
+			netdev_features_t missing;
+
+			slave_xfrm_features = slave->dev->features &
+					      BOND_XFRM_FEATURES;
+			slave_xfrm_enableable = slave->dev->hw_features &
+						mask & BOND_XFRM_FEATURES;
+			slave_xfrm_features |= slave_xfrm_enableable;
+			missing = (BOND_XFRM_FEATURES & mask) &
+				  ~slave_xfrm_features;
+			if (missing)
+				slave_dbg(dev, slave->dev,
+					  "missing LAG XFRM feature(s) %pNF\n",
+					  &missing);
+			lag_xfrm_features &= slave_xfrm_features;
+
+			if (!(slave_xfrm_features & NETIF_F_HW_ESP) ||
+			    !bond_ipsec_lag_slave_has_ops(slave->dev)) {
+				slave_dbg(dev, slave->dev,
+					  "missing LAG XFRM offload ops\n");
+				lag_xfrm_ok = false;
+			}
+			lag_xfrm_slaves++;
+		}
+#endif /* CONFIG_XFRM_OFFLOAD */
 	}
 	features = netdev_add_tso_features(features, mask);
 
+#ifdef CONFIG_XFRM_OFFLOAD
+	if (!ab_xfrm && !lag_xfrm)
+		features &= ~BOND_XFRM_FEATURES;
+	else if (lag_xfrm && (!lag_xfrm_ok || !lag_xfrm_slaves))
+		features &= ~BOND_XFRM_FEATURES;
+	else if (lag_xfrm)
+		features = (features & ~BOND_XFRM_FEATURES) |
+			   (lag_xfrm_features & mask);
+	if (!(features & NETIF_F_HW_ESP))
+		features &= ~(NETIF_F_HW_ESP_TX_CSUM | NETIF_F_GSO_ESP);
+#endif /* CONFIG_XFRM_OFFLOAD */
+
 	return features;
 }
 
+#ifdef CONFIG_XFRM_OFFLOAD
+static int bond_set_slave_xfrm_features(struct bonding *bond,
+					struct slave *slave,
+					netdev_features_t features)
+{
+	struct net_device *real_dev = slave->dev;
+	netdev_features_t xfrm_features;
+	netdev_features_t mutable;
+	bool notifier_ctx;
+	int err = 0;
+
+	mutable = real_dev->hw_features & BOND_XFRM_FEATURES;
+	if (!mutable)
+		return 0;
+
+	xfrm_features = features & BOND_XFRM_FEATURES;
+
+	notifier_ctx = bond->notifier_ctx;
+	bond->notifier_ctx = true;
+	netdev_lock_ops(real_dev);
+	real_dev->wanted_features &= ~mutable;
+	real_dev->wanted_features |= xfrm_features & mutable;
+	err = __netdev_update_features(real_dev);
+	if (err)
+		netdev_features_change(real_dev);
+	netdev_unlock_ops(real_dev);
+	bond->notifier_ctx = notifier_ctx;
+
+	return err < 0 ? err : 0;
+}
+
+static void bond_restore_slave_xfrm_features(struct bonding *bond,
+					     netdev_features_t features)
+{
+	struct list_head *iter;
+	struct slave *slave;
+
+	bond_for_each_slave(bond, slave, iter) {
+		if (!netif_running(slave->dev))
+			continue;
+
+		bond_set_slave_xfrm_features(bond, slave, features);
+	}
+}
+
+static void bond_sync_slave_xfrm_features(struct bonding *bond,
+					  struct slave *slave)
+{
+	netdev_features_t requested = bond->dev->wanted_features;
+	netdev_features_t old_wanted = slave->dev->wanted_features;
+	netdev_features_t available;
+	netdev_features_t missing;
+	int err;
+
+	if (!bond_mode_can_use_lag_xfrm(bond))
+		return;
+
+	if (!netif_running(slave->dev))
+		return;
+
+	requested &= BOND_XFRM_FEATURES;
+	if (!requested)
+		return;
+
+	available = slave->dev->features | slave->dev->hw_features;
+	missing = requested & ~available;
+	if ((requested & NETIF_F_HW_ESP) &&
+	    !bond_ipsec_lag_slave_has_ops(slave->dev))
+		missing |= NETIF_F_HW_ESP;
+	if (missing)
+		goto disable_missing;
+
+	err = bond_set_slave_xfrm_features(bond, slave, requested);
+	missing = requested & ~slave->dev->features;
+	if (err && !missing)
+		missing = requested;
+	if (!missing)
+		return;
+
+	bond_set_slave_xfrm_features(bond, slave, old_wanted);
+
+disable_missing:
+	if (missing & NETIF_F_HW_ESP)
+		missing |= BOND_XFRM_FEATURES;
+	slave_warn(bond->dev, slave->dev,
+		   "disabling XFRM feature(s) %pNF after slave enable failed\n",
+		   &missing);
+	bond->dev->wanted_features &= ~missing;
+}
+
+static int bond_set_features(struct net_device *dev, netdev_features_t features)
+{
+	struct bonding *bond = netdev_priv(dev);
+	netdev_features_t changed;
+	netdev_features_t enabled;
+	struct list_head *iter;
+	struct slave *slave;
+	int err = 0;
+
+	if (!bond_mode_can_use_lag_xfrm(bond))
+		return 0;
+
+	changed = (dev->features ^ features) & BOND_XFRM_FEATURES;
+	if (!changed)
+		return 0;
+
+	enabled = features & BOND_XFRM_FEATURES;
+	if (enabled) {
+		int targets = 0;
+
+		bond_for_each_slave(bond, slave, iter) {
+			netdev_features_t available;
+			netdev_features_t missing;
+
+			if (!netif_running(slave->dev))
+				continue;
+
+			available = slave->dev->features | slave->dev->hw_features;
+			missing = enabled & ~available;
+			if ((enabled & NETIF_F_HW_ESP) &&
+			    !bond_ipsec_lag_slave_has_ops(slave->dev))
+				missing |= NETIF_F_HW_ESP;
+			if (missing) {
+				slave_warn(dev, slave->dev,
+					   "missing XFRM feature(s) %pNF\n",
+					   &missing);
+				return -EOPNOTSUPP;
+			}
+			targets++;
+		}
+		if (!targets)
+			return -EOPNOTSUPP;
+	}
+
+	if ((dev->features & NETIF_F_HW_ESP) &&
+	    !(features & NETIF_F_HW_ESP)) {
+		bond_ipsec_lag_begin_flush(bond);
+		xfrm_dev_state_flush(dev_net(dev), dev, true);
+	}
+
+	bond_for_each_slave(bond, slave, iter) {
+		if (!netif_running(slave->dev))
+			continue;
+
+		err = bond_set_slave_xfrm_features(bond, slave, features);
+		if (err)
+			break;
+	}
+	if (err) {
+		bond_restore_slave_xfrm_features(bond, dev->features);
+		if ((dev->features & NETIF_F_HW_ESP) &&
+		    !(features & NETIF_F_HW_ESP))
+			bond_ipsec_lag_end_flush(bond);
+		return err;
+	}
+
+	bond_for_each_slave(bond, slave, iter) {
+		netdev_features_t missing = enabled & ~slave->dev->features;
+
+		if (!netif_running(slave->dev))
+			continue;
+
+		if (missing) {
+			slave_warn(dev, slave->dev,
+				   "failed to enable XFRM feature(s) %pNF\n",
+				   &missing);
+			bond_restore_slave_xfrm_features(bond, dev->features);
+			if ((dev->features & NETIF_F_HW_ESP) &&
+			    !(features & NETIF_F_HW_ESP))
+				bond_ipsec_lag_end_flush(bond);
+			return -EOPNOTSUPP;
+		}
+	}
+
+	if (features & NETIF_F_HW_ESP)
+		bond_ipsec_lag_end_flush(bond);
+
+	return 0;
+}
+#endif /* CONFIG_XFRM_OFFLOAD */
+
 static int bond_header_create(struct sk_buff *skb, struct net_device *bond_dev,
 			      unsigned short type, const void *daddr,
 			      const void *saddr, unsigned int len)
@@ -6510,6 +6739,9 @@ static const struct net_device_ops bond_netdev_ops = {
 	.ndo_add_slave		= bond_enslave,
 	.ndo_del_slave		= bond_release,
 	.ndo_fix_features	= bond_fix_features,
+#ifdef CONFIG_XFRM_OFFLOAD
+	.ndo_set_features	= bond_set_features,
+#endif /* CONFIG_XFRM_OFFLOAD */
 	.ndo_features_check	= passthru_features_check,
 	.ndo_get_xmit_slave	= bond_xmit_get_slave,
 	.ndo_sk_get_lower_dev	= bond_sk_get_lower_dev,
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 7380cc4ee75a..634b42c0d8e9 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -885,7 +885,7 @@ static bool bond_set_xfrm_features(struct bonding *bond)
 
 	if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP)
 		bond->dev->wanted_features |= BOND_XFRM_FEATURES;
-	else
+	else if (!bond_mode_can_use_lag_xfrm(bond))
 		bond->dev->wanted_features &= ~BOND_XFRM_FEATURES;
 
 	return true;
-- 
2.53.0

