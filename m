Return-Path: <netdev+bounces-289826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLIjNp1tDWrgxAUAu9opvQ
	(envelope-from <netdev+bounces-289826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:15:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C205589843
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13AEF30CD794
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7E13AB292;
	Wed, 20 May 2026 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDGxBYAf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215C3A872D
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264640; cv=none; b=iIBWqG2kWkEHwkyYA2WLQKTxwuSpUrMmx/y2z9TPieadMFlpYY82QtIrZ0N8D1B64IFJ0b/Glnyg6CBU58lK9nz63uhxMLcvKkL3ohsY0DvTmZg8p6HJ3jRSLRfNovzu8z+ZDQmTPiC+unTR3yOXpb3ml+i8vyTnSl/P2+jns7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264640; c=relaxed/simple;
	bh=k+1bVDzpBLn4HjRGfnqPaZ2j211rDIpZJWTrRzdAZSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2yh9EmwjBiKz5UN72VYV4r+upw08Nn895l0ai+rW/se5iwQPhWK8uffzvTl7RoXJNg6aKvBrx62Qwr6572GK3LU0Wtr1vBJknC2FzpOX8N4olcLivIwnEiKLdl/uJxaBsLRhaaycarg+jLn1n2tdKlqvPhCk1if0M8QHXyl9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDGxBYAf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba928852a5so31204635ad.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 01:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779264637; x=1779869437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5id6WMBtbH44nKXBNyAlULAMrWlMSnG/2pQM6iYYZo=;
        b=aDGxBYAfRaf4smjiqu862z8rF6EZoW1Vyj6fVqZAfEascL3bqvXoU+6U6qdRmpIQG4
         YesQM5LccHLxW7r4Bqpov1qCxgifWQqSxrFqHVS5AJt2BtLwO1CPHguc6EvaTMy0hMRO
         8MxJ9D2tAXZTLicga23IShqCF1Gk9AMS+kpwT/tBL//IBrDft9BdFK3p7PrbmBeYx18R
         J+mBLLuj+2BmZN9m4jxCLb9Rf8uTcFrOByGj2hY37R4sfcF5ClFFlVwuSHAmZ11ye2MD
         ZbdpnuQhIxcZv3KmDDdaWhOhlBbUrBIiiLO5X24FQqj9fLMKkAkIdxJaSjfx+cjJu22b
         Nb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779264637; x=1779869437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y5id6WMBtbH44nKXBNyAlULAMrWlMSnG/2pQM6iYYZo=;
        b=SnUHS0HNUfXzu8ihDMA3D4hy8z5K0Pfs/C788uC0kYjuV85G7TvWvKrx1q7r4DLbWV
         vy5dk+07gRYmWUVWEXvtT5gmAvYhZsnmQZDUOsq//Ld7HzPx3E7ALcMoM0ddS1V9Ikt5
         MurisQCyQ/RKIF/EnwpmSMuzZextmuNl8DMTUag+X6lHc4vDVIWAJWeLM+oNRizYnHJU
         3h1rzole5oIdwAreKwX1BeYIQcZtUbupLjVHhOlv9SHG4ooikWztCNaU3pT7Wcu+CInM
         APoR3k/anBQtdfB+dGbUbYL7P8zvJeX1Zv6fCM1FDKCmuzXTNCcgER0LrLQ37Sj9qtmr
         ID/w==
X-Gm-Message-State: AOJu0YxaKD900y/f/5kBk9cdOG8Nf1xSm6gPnPjh74wJEPaV8bH6zVuG
	S7SiXkhN+M+mo8nbiWX8ZA1P6Qw5Cllsrqpg5jPaa2tl0zUPgz2woDkglcRDCJ3F
X-Gm-Gg: Acq92OHEcbN2hDjhx5ZsJkWv9P2fVNoAguW98FJURGtyCPrWbrK8DAM5pScgLhpBELA
	KtxSkEAFmLotWxNtgp04SGOoJfHCeMC+du9xWK9q8LfQf2tNESnMBLXvXIwb6BKsOGbEyM6ibRl
	GcUm03DpvoKURzSHOLJ/sXHyt+8j1b3eY5XvT92B9TlixoyULYcWDMCNcpruZ9/PavsdvTvJ6RI
	Q9EcyKX3khTF5BH6kzm00nClOT/7wc5UY6IaIvre7HInLfalduFURp2F3qUJBUWNoCC5aixNInw
	a8yChzGABVxDLdkJLmd1mEd8vwIZDFyLvrgOs1krI1pbT1iY4Ek+g3+3lc7svgKc6f4zpRSgGdB
	AMFDgIGlWP6BsiA3I0TdFjyu3GiVy5xZaxYkNRdJ2ENJOTQvXATEGSeTcVeCSoqQRthzEwWe/K7
	tihqflIWiwbitLicxZbjFGR7H2wEZhEQo=
X-Received: by 2002:a17:903:1209:b0:2bd:d4dc:a4f9 with SMTP id d9443c01a7336-2bdd4dcb523mr142439315ad.26.1779264636753;
        Wed, 20 May 2026 01:10:36 -0700 (PDT)
Received: from mincom1 ([14.67.155.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d116287sm211632735ad.68.2026.05.20.01.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:10:36 -0700 (PDT)
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
Subject: [PATCH RFC net-next 4/4] bonding: handle replicated IPsec SAs across LAG changes
Date: Wed, 20 May 2026 17:10:04 +0900
Message-ID: <20260520081004.2232091-5-hurryman2212@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,secunet.com,gondor.apana.org.au,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-289826-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6C205589843
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Keep replicated bonding IPsec state consistent as the LAG changes. Add
newly usable slaves to existing replicated states, remove only the
departing lower instance on down/remove, and update the usable slave
array before hiding lower handles.

Flush bond-owned XFRM offload state when mode or hash policy leaves the
LAG XFRM eligible configuration. Block new LAG offload adds while
pending replicated states are cleaned up and the XFRM table is flushed.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Jihong Min <hurryman2212@gmail.com>
---
 drivers/net/bonding/bond_main.c    | 45 ++++++++++++++++++++---
 drivers/net/bonding/bond_options.c | 57 ++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index d81dae5a1902..0243950c2fa6 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3104,6 +3104,18 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			bpf_prog_inc(bond->xdp_prog);
 	}
 
+#ifdef CONFIG_XFRM_OFFLOAD
+	if ((bond_dev->wanted_features & BOND_XFRM_FEATURES) &&
+	    bond_mode_can_use_lag_xfrm(bond)) {
+		bond_sync_slave_xfrm_features(bond, new_slave);
+		bond->notifier_ctx = true;
+		netdev_compute_master_upper_features(bond->dev, true);
+		bond->notifier_ctx = false;
+	}
+#endif /* CONFIG_XFRM_OFFLOAD */
+
+	bond_ipsec_lag_add_slave(bond, new_slave, extack);
+
 	/* broadcast mode uses the all_slaves to loop through slaves. */
 	if (bond_mode_can_use_xmit_hash(bond) ||
 	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
@@ -3222,6 +3234,9 @@ static int __bond_release_one(struct net_device *bond_dev,
 	}
 
 	bond_set_slave_inactive_flags(slave, BOND_SLAVE_NOTIFY_NOW);
+	if (bond_mode_can_use_xmit_hash(bond) ||
+	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
+		bond_update_slave_arr(bond, slave);
 
 	bond_sysfs_slave_del(slave);
 
@@ -3239,8 +3254,10 @@ static int __bond_release_one(struct net_device *bond_dev,
 			slave_warn(bond_dev, slave_dev, "failed to unload XDP program\n");
 	}
 
-	/* unregister rx_handler early so bond_handle_frame wouldn't be called
-	 * for this slave anymore.
+	bond_ipsec_lag_remove_slave(bond, slave_dev);
+
+	/* unregister rx_handler after lower IPsec state is gone so RX cannot
+	 * bypass the bond while a bond-owned SA is still installed.
 	 */
 	netdev_rx_handler_unregister(slave_dev);
 
@@ -4758,8 +4775,13 @@ static int bond_slave_netdev_event(unsigned long event,
 
 		if (BOND_MODE(bond) == BOND_MODE_8023AD)
 			bond_3ad_adapter_speed_duplex_changed(slave);
-		fallthrough;
-	case NETDEV_DOWN:
+		bond_sync_slave_xfrm_features(bond, slave);
+		if (bond_mode_can_use_lag_xfrm(bond)) {
+			bond->notifier_ctx = true;
+			netdev_compute_master_upper_features(bond->dev, true);
+			bond->notifier_ctx = false;
+		}
+		bond_ipsec_lag_add_slave(bond, slave, NULL);
 		/* Refresh slave-array if applicable!
 		 * If the setup does not use miimon or arpmon (mode-specific!),
 		 * then these events will not cause the slave-array to be
@@ -4771,6 +4793,19 @@ static int bond_slave_netdev_event(unsigned long event,
 		if (bond_mode_can_use_xmit_hash(bond))
 			bond_update_slave_arr(bond, NULL);
 		break;
+	case NETDEV_DOWN:
+		/* Refresh slave-array before deleting IPsec state so no new
+		 * TX path picks this slave after its offload handle is hidden.
+		 */
+		if (bond_mode_can_use_xmit_hash(bond))
+			bond_update_slave_arr(bond, slave);
+		bond_ipsec_lag_remove_slave(bond, slave_dev);
+		if (bond_mode_can_use_lag_xfrm(bond)) {
+			bond->notifier_ctx = true;
+			netdev_compute_master_upper_features(bond->dev, true);
+			bond->notifier_ctx = false;
+		}
+		break;
 	case NETDEV_CHANGEMTU:
 		/* TODO: Should slaves be allowed to
 		 * independently alter their MTU?  For
@@ -4809,10 +4844,12 @@ static int bond_slave_netdev_event(unsigned long event,
 		break;
 	case NETDEV_FEAT_CHANGE:
 		if (!bond->notifier_ctx) {
+			bond_sync_slave_xfrm_features(bond, slave);
 			bond->notifier_ctx = true;
 			netdev_compute_master_upper_features(bond->dev, true);
 			bond->notifier_ctx = false;
 		}
+		bond_ipsec_lag_add_slave(bond, slave, NULL);
 		break;
 	case NETDEV_RESEND_IGMP:
 		/* Propagate to master device */
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 634b42c0d8e9..ee3ffc698d7d 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -17,6 +17,7 @@
 
 #include <net/bonding.h>
 #include <net/ndisc.h>
+#include <net/xfrm.h>
 
 static int bond_option_active_slave_set(struct bonding *bond,
 					const struct bond_opt_value *newval);
@@ -894,6 +895,13 @@ static bool bond_set_xfrm_features(struct bonding *bond)
 static int bond_option_mode_set(struct bonding *bond,
 				const struct bond_opt_value *newval)
 {
+#if IS_ENABLED(CONFIG_XFRM_OFFLOAD)
+	bool old_ab_xfrm = BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP;
+	bool old_lag_xfrm = bond_mode_can_use_lag_xfrm(bond);
+	bool new_lag_xfrm;
+	bool flush_lag_xfrm = false;
+#endif
+
 	if (bond->xdp_prog && !bond_xdp_check(bond, newval->value))
 		return -EOPNOTSUPP;
 
@@ -918,8 +926,26 @@ static int bond_option_mode_set(struct bonding *bond,
 
 	/* don't cache arp_validate between modes */
 	bond->params.arp_validate = BOND_ARP_VALIDATE_NONE;
+
 	bond->params.mode = newval->value;
 
+#if IS_ENABLED(CONFIG_XFRM_OFFLOAD)
+	new_lag_xfrm = bond_mode_can_use_lag_xfrm(bond);
+	if (old_ab_xfrm && new_lag_xfrm)
+		bond->dev->wanted_features &= ~BOND_XFRM_FEATURES;
+	if (old_lag_xfrm && !new_lag_xfrm) {
+		bond_ipsec_lag_begin_flush(bond);
+		flush_lag_xfrm = true;
+	}
+
+	if (flush_lag_xfrm) {
+		if (bond->dev->reg_state == NETREG_REGISTERED)
+			xfrm_dev_state_flush(dev_net(bond->dev), bond->dev,
+					     true);
+		bond_ipsec_lag_end_flush(bond);
+	}
+#endif
+
 	/* When changing mode, the bond device is down, we may reduce
 	 * the bond_bcast_neigh_enabled in bond_close() if broadcast_neighbor
 	 * enabled in 8023ad mode. Therefore, only clear broadcast_neighbor
@@ -1575,12 +1601,43 @@ static int bond_option_fail_over_mac_set(struct bonding *bond,
 static int bond_option_xmit_hash_policy_set(struct bonding *bond,
 					    const struct bond_opt_value *newval)
 {
+#if IS_ENABLED(CONFIG_XFRM_OFFLOAD)
+	bool old_lag_xfrm = bond_mode_can_use_lag_xfrm(bond);
+	bool new_lag_xfrm;
+	bool flush_lag_xfrm = false;
+#endif
+
 	if (bond->xdp_prog && !__bond_xdp_check(BOND_MODE(bond), newval->value))
 		return -EOPNOTSUPP;
 	netdev_dbg(bond->dev, "Setting xmit hash policy to %s (%llu)\n",
 		   newval->string, newval->value);
+
 	bond->params.xmit_policy = newval->value;
 
+#if IS_ENABLED(CONFIG_XFRM_OFFLOAD)
+	new_lag_xfrm = bond_mode_can_use_lag_xfrm(bond);
+	if (old_lag_xfrm && !new_lag_xfrm) {
+		bond_ipsec_lag_begin_flush(bond);
+		flush_lag_xfrm = true;
+	}
+
+	if (flush_lag_xfrm) {
+		if (bond->dev->reg_state == NETREG_REGISTERED)
+			xfrm_dev_state_flush(dev_net(bond->dev), bond->dev,
+					     true);
+		bond_ipsec_lag_end_flush(bond);
+	}
+#endif
+
+	if (bond->dev->reg_state == NETREG_REGISTERED) {
+		bool update = false;
+
+		update |= bond_set_xfrm_features(bond);
+
+		if (update)
+			netdev_update_features(bond->dev);
+	}
+
 	return 0;
 }
 
-- 
2.53.0

