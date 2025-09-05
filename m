Return-Path: <netdev+bounces-220281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9FAB45287
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 11:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82ED175536
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 09:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9466230AAC2;
	Fri,  5 Sep 2025 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DYjaNE2t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B135227932D
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063120; cv=none; b=D0m8wDSKWwIzHaQvOMlAdC0Rq/hVK0hlgxMKKrKBncLV9QKgJJS+k6jrkgf6fLW7ifgPDygY6ge3z1QaaZNT9D1ae8JTe0PAA8tnvDp5qoHxLSL7JuVCrp7w9loUVY9+nCGqrC6Z+1J+2wNR6B5ZWme5weo10X6A9wjEZTbnvD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063120; c=relaxed/simple;
	bh=tkpTnSvsTVeadQu+R6KtlwfCPBOXazKYJ6mCD9nBZ54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MllkWRfUbAbbgcq0+/LC0LFyd7xy/C5mwFaTzGx/B5YjHdmXKPzAnzjluMtvosND4RL+HoR0wQQB9v2wRrNZX+bP1YOc7eKDu2Zhd/1lDXsVq7QeTu2zYQCkjTrCPtbaEOJIzkShzrwHraMwUhrXQlJsIG3FJMEw+3qDLMrteNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DYjaNE2t; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45cb5492350so12596835e9.1
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 02:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063115; x=1757667915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjgwxAkrVtHfV6W1dztk3Jt179FxDlZFaz1T04VTrBg=;
        b=DYjaNE2tnbxoVuxXKxkXVHBt+KOoUGyzKf/YutcgVDvz6hoY6+CXfJeJ1+lC23fcUL
         /RUbUTBvjYrAJaC1GPglyDp3HtSRpe7L+/OLlyyLZQdsXlg0kR7OqrIgtnuLKKUH7FAJ
         pwqIm+T7QULM7Y5aFsYlgUjIEz0OvAnol7kCmBmnJP242sB6n7jDvOV5rUau44PdsPsG
         weRVK646sT6uJPSPuPjIoCIdbU4R2SwocWZhKE+HnYqKdg44PuhyiCWZGnrCh5N4LUw2
         DhxVbmcUalOdEyJBxyj/ys0TqF9ngL5arImQLMO23CVEAUGPLACZrla8Z+beDX9uZ33K
         nxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063115; x=1757667915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjgwxAkrVtHfV6W1dztk3Jt179FxDlZFaz1T04VTrBg=;
        b=J8Y5Wy8Yu3eo3QgSZ3Cs/EYkb2dJWXAiM1XKin34VNryq0BiPiMJWY4htZ38CUs1sv
         U+V4HJL9hTh2T73zJfzCI/35CuQh/V/D92ItWmbTU/laGERK6QKR3gEPaAMaX9+C7wXV
         bBmgImPak1AVjut31SmeGEztTOX36p+Ui0GqpcJBXZui++uiItu+ojhAGpAljkiOzJ+d
         6k0/0NergXKhSqawJzXB5ti3UQcoVcOA/1DeRoVTNsd4Qj0heoNQIEo8AjaO961LUPsz
         0o9Xgy/UIU9jqVGi6i5oPCflApv/GTbDn2tay8pnDxWQw1Zd/RZOFGM7u17QH+vW0mxj
         D2rw==
X-Forwarded-Encrypted: i=1; AJvYcCVSFSVwdZCJXGUgwRBjf5iiqQFdVGjkd+fg1W0gRg1wofdCADk8zNaaaUEvGofs5e6B+ucqN/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRCnQc2+spCQg0Jgk7jqp3lQqslAcqhyMlKmGlor8RFNljSPCV
	9hrMSB15R3TiDPdZevpOQx9EnQ7cvbFBqjistcceV2g/EEIIg+xgN7xt42LvwShJVpQ=
X-Gm-Gg: ASbGncsTTMa6hNNHx4dh3FvjnKevrbMr3NcJmSanA8dDiEAe0EFvOa/nSWx6bEsUc6O
	tS/UrhWufwRFR0DcXf7GGs34Xon3xJM+KazM9Rggj6H9DWwfqeghQS4rLlUk3OqxGBb8edKfdjA
	FaF7jBpdnuny5Yc6S5Os2ZEO+LwtD6U4ZIpN+HwR3E46co7Q9lM0VSXQF7N8INW9tfYA3zFBbJf
	M6lmAgbTdrNLNmk/bdmzF1v4TfdCmhm9GLk1p/iX/+dJptRRAhDgUznc85gN5XOrqLVvAXwRPZ+
	VaMYxq4a8OzdmEBVXxlo062KJis3H277uK9/ZNmjXMc6KQ3W3FBkIjbHkd8c3m89ESsqvbCFuXv
	YOXERYaMNQhy0yD81XfFdKndMfpvAZ6GsDhXRBBILEi6mGxoZnGQ4ds1BWQ==
X-Google-Smtp-Source: AGHT+IFc0lpmmk1SBvX9AIDtZdZhHW62mg1Km6v6BS0T01t+0rChjs88kYkD58jciUgtlH/+xqVinQ==
X-Received: by 2002:a05:600c:45c5:b0:45b:6743:2242 with SMTP id 5b1f17b1804b1-45b85589b3dmr179126555e9.22.1757063114609;
        Fri, 05 Sep 2025 02:05:14 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd07480d5sm34118215e9.8.2025.09.05.02.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:05:14 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/3] net: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 11:05:04 +0200
Message-ID: <20250905090505.104882-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090505.104882-1-marco.crivellari@suse.com>
References: <20250905090505.104882-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

queue_work() / queue_delayed_work() / mod_delayed_work() will now use the
new unbound wq: whether the user still use the old wq a warn will be
printed along with a wq redirect to the new one.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/ethernet/sfc/efx_channels.c          |  2 +-
 drivers/net/ethernet/sfc/siena/efx_channels.c    |  2 +-
 drivers/net/phy/sfp.c                            | 12 ++++++------
 drivers/net/wireless/intel/ipw2x00/ipw2100.c     |  6 +++---
 drivers/net/wireless/intel/ipw2x00/ipw2200.c     |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c    |  6 +++---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/init.c |  2 +-
 net/bridge/br_cfm.c                              |  6 +++---
 net/bridge/br_mrp.c                              |  8 ++++----
 net/ceph/mon_client.c                            |  2 +-
 net/core/skmsg.c                                 |  2 +-
 net/devlink/core.c                               |  2 +-
 net/ipv4/inet_fragment.c                         |  2 +-
 net/netfilter/nf_conntrack_ecache.c              |  2 +-
 net/openvswitch/dp_notify.c                      |  2 +-
 net/rfkill/input.c                               |  2 +-
 net/smc/smc_core.c                               |  2 +-
 net/vmw_vsock/af_vsock.c                         |  2 +-
 19 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
index 06b4f52713ef..4fba49d4f36c 100644
--- a/drivers/net/ethernet/sfc/efx_channels.c
+++ b/drivers/net/ethernet/sfc/efx_channels.c
@@ -1281,7 +1281,7 @@ static int efx_poll(struct napi_struct *napi, int budget)
 		time = jiffies - channel->rfs_last_expiry;
 		/* Would our quota be >= 20? */
 		if (channel->rfs_filter_count * time >= 600 * HZ)
-			mod_delayed_work(system_wq, &channel->filter_work, 0);
+			mod_delayed_work(system_percpu_wq, &channel->filter_work, 0);
 #endif
 
 		/* There is no race here; although napi_disable() will
diff --git a/drivers/net/ethernet/sfc/siena/efx_channels.c b/drivers/net/ethernet/sfc/siena/efx_channels.c
index d120b3c83ac0..2039083205bb 100644
--- a/drivers/net/ethernet/sfc/siena/efx_channels.c
+++ b/drivers/net/ethernet/sfc/siena/efx_channels.c
@@ -1300,7 +1300,7 @@ static int efx_poll(struct napi_struct *napi, int budget)
 		time = jiffies - channel->rfs_last_expiry;
 		/* Would our quota be >= 20? */
 		if (channel->rfs_filter_count * time >= 600 * HZ)
-			mod_delayed_work(system_wq, &channel->filter_work, 0);
+			mod_delayed_work(system_percpu_wq, &channel->filter_work, 0);
 #endif
 
 		/* There is no race here; although napi_disable() will
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 347c1e0e94d9..19fcff02db51 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -890,7 +890,7 @@ static void sfp_soft_start_poll(struct sfp *sfp)
 
 	if (sfp->state_soft_mask & (SFP_F_LOS | SFP_F_TX_FAULT) &&
 	    !sfp->need_poll)
-		mod_delayed_work(system_wq, &sfp->poll, poll_jiffies);
+		mod_delayed_work(system_percpu_wq, &sfp->poll, poll_jiffies);
 	mutex_unlock(&sfp->st_mutex);
 }
 
@@ -1661,7 +1661,7 @@ static void sfp_hwmon_probe(struct work_struct *work)
 	err = sfp_read(sfp, true, 0, &sfp->diag, sizeof(sfp->diag));
 	if (err < 0) {
 		if (sfp->hwmon_tries--) {
-			mod_delayed_work(system_wq, &sfp->hwmon_probe,
+			mod_delayed_work(system_percpu_wq, &sfp->hwmon_probe,
 					 T_PROBE_RETRY_SLOW);
 		} else {
 			dev_warn(sfp->dev, "hwmon probe failed: %pe\n",
@@ -1688,7 +1688,7 @@ static void sfp_hwmon_probe(struct work_struct *work)
 static int sfp_hwmon_insert(struct sfp *sfp)
 {
 	if (sfp->have_a2 && sfp->id.ext.diagmon & SFP_DIAGMON_DDM) {
-		mod_delayed_work(system_wq, &sfp->hwmon_probe, 1);
+		mod_delayed_work(system_percpu_wq, &sfp->hwmon_probe, 1);
 		sfp->hwmon_tries = R_PROBE_RETRY_SLOW;
 	}
 
@@ -2542,7 +2542,7 @@ static void sfp_sm_module(struct sfp *sfp, unsigned int event)
 		/* Force a poll to re-read the hardware signal state after
 		 * sfp_sm_mod_probe() changed state_hw_mask.
 		 */
-		mod_delayed_work(system_wq, &sfp->poll, 1);
+		mod_delayed_work(system_percpu_wq, &sfp->poll, 1);
 
 		err = sfp_hwmon_insert(sfp);
 		if (err)
@@ -2987,7 +2987,7 @@ static void sfp_poll(struct work_struct *work)
 	// it's unimportant if we race while reading this.
 	if (sfp->state_soft_mask & (SFP_F_LOS | SFP_F_TX_FAULT) ||
 	    sfp->need_poll)
-		mod_delayed_work(system_wq, &sfp->poll, poll_jiffies);
+		mod_delayed_work(system_percpu_wq, &sfp->poll, poll_jiffies);
 }
 
 static struct sfp *sfp_alloc(struct device *dev)
@@ -3157,7 +3157,7 @@ static int sfp_probe(struct platform_device *pdev)
 	}
 
 	if (sfp->need_poll)
-		mod_delayed_work(system_wq, &sfp->poll, poll_jiffies);
+		mod_delayed_work(system_percpu_wq, &sfp->poll, poll_jiffies);
 
 	/* We could have an issue in cases no Tx disable pin is available or
 	 * wired as modules using a laser as their light source will continue to
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index 215814861cbd..c7c5bc0f1650 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -2143,7 +2143,7 @@ static void isr_indicate_rf_kill(struct ipw2100_priv *priv, u32 status)
 
 	/* Make sure the RF Kill check timer is running */
 	priv->stop_rf_kill = 0;
-	mod_delayed_work(system_wq, &priv->rf_kill, round_jiffies_relative(HZ));
+	mod_delayed_work(system_percpu_wq, &priv->rf_kill, round_jiffies_relative(HZ));
 }
 
 static void ipw2100_scan_event(struct work_struct *work)
@@ -2170,7 +2170,7 @@ static void isr_scan_complete(struct ipw2100_priv *priv, u32 status)
 				      round_jiffies_relative(msecs_to_jiffies(4000)));
 	} else {
 		priv->user_requested_scan = 0;
-		mod_delayed_work(system_wq, &priv->scan_event, 0);
+		mod_delayed_work(system_percpu_wq, &priv->scan_event, 0);
 	}
 }
 
@@ -4252,7 +4252,7 @@ static int ipw_radio_kill_sw(struct ipw2100_priv *priv, int disable_radio)
 					  "disabled by HW switch\n");
 			/* Make sure the RF_KILL check timer is running */
 			priv->stop_rf_kill = 0;
-			mod_delayed_work(system_wq, &priv->rf_kill,
+			mod_delayed_work(system_percpu_wq, &priv->rf_kill,
 					 round_jiffies_relative(HZ));
 		} else
 			schedule_reset(priv);
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 24a5624ef207..09035a77e775 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -4415,7 +4415,7 @@ static void handle_scan_event(struct ipw_priv *priv)
 				      round_jiffies_relative(msecs_to_jiffies(4000)));
 	} else {
 		priv->user_requested_scan = 0;
-		mod_delayed_work(system_wq, &priv->scan_event, 0);
+		mod_delayed_work(system_percpu_wq, &priv->scan_event, 0);
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
index 36379b738de1..0df31639fa5e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
@@ -234,7 +234,7 @@ void iwl_mvm_rx_tdls_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	 * Also convert TU to msec.
 	 */
 	delay = TU_TO_MS(vif->bss_conf.dtim_period * vif->bss_conf.beacon_int);
-	mod_delayed_work(system_wq, &mvm->tdls_cs.dwork,
+	mod_delayed_work(system_percpu_wq, &mvm->tdls_cs.dwork,
 			 msecs_to_jiffies(delay));
 
 	iwl_mvm_tdls_update_cs_state(mvm, IWL_MVM_TDLS_SW_ACTIVE);
@@ -548,7 +548,7 @@ iwl_mvm_tdls_channel_switch(struct ieee80211_hw *hw,
 	 */
 	delay = 2 * TU_TO_MS(vif->bss_conf.dtim_period *
 			     vif->bss_conf.beacon_int);
-	mod_delayed_work(system_wq, &mvm->tdls_cs.dwork,
+	mod_delayed_work(system_percpu_wq, &mvm->tdls_cs.dwork,
 			 msecs_to_jiffies(delay));
 	return 0;
 }
@@ -659,6 +659,6 @@ iwl_mvm_tdls_recv_channel_switch(struct ieee80211_hw *hw,
 	/* register a timeout in case we don't succeed in switching */
 	delay = vif->bss_conf.dtim_period * vif->bss_conf.beacon_int *
 		1024 / 1000;
-	mod_delayed_work(system_wq, &mvm->tdls_cs.dwork,
+	mod_delayed_work(system_percpu_wq, &mvm->tdls_cs.dwork,
 			 msecs_to_jiffies(delay));
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 14e17dc90256..cb97f69a9149 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -341,7 +341,7 @@ int mt7921_register_device(struct mt792x_dev *dev)
 	dev->mphy.hw->wiphy->available_antennas_rx = dev->mphy.chainmask;
 	dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
 
-	queue_work(system_wq, &dev->init_work);
+	queue_work(system_percpu_wq, &dev->init_work);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 63cb08f4d87c..090ecd1f2a0a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -410,7 +410,7 @@ int mt7925_register_device(struct mt792x_dev *dev)
 	dev->mphy.hw->wiphy->available_antennas_rx = dev->mphy.chainmask;
 	dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
 
-	queue_work(system_wq, &dev->init_work);
+	queue_work(system_percpu_wq, &dev->init_work);
 
 	return 0;
 }
diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index a3c755d0a09d..c2c1c7d44c61 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -134,7 +134,7 @@ static void ccm_rx_timer_start(struct br_cfm_peer_mep *peer_mep)
 	 * of the configured CC 'expected_interval'
 	 * in order to detect CCM defect after 3.25 interval.
 	 */
-	queue_delayed_work(system_wq, &peer_mep->ccm_rx_dwork,
+	queue_delayed_work(system_percpu_wq, &peer_mep->ccm_rx_dwork,
 			   usecs_to_jiffies(interval_us / 4));
 }
 
@@ -285,7 +285,7 @@ static void ccm_tx_work_expired(struct work_struct *work)
 		ccm_frame_tx(skb);
 
 	interval_us = interval_to_us(mep->cc_config.exp_interval);
-	queue_delayed_work(system_wq, &mep->ccm_tx_dwork,
+	queue_delayed_work(system_percpu_wq, &mep->ccm_tx_dwork,
 			   usecs_to_jiffies(interval_us));
 }
 
@@ -809,7 +809,7 @@ int br_cfm_cc_ccm_tx(struct net_bridge *br, const u32 instance,
 	 * to send first frame immediately
 	 */
 	mep->ccm_tx_end = jiffies + usecs_to_jiffies(tx_info->period * 1000000);
-	queue_delayed_work(system_wq, &mep->ccm_tx_dwork, 0);
+	queue_delayed_work(system_percpu_wq, &mep->ccm_tx_dwork, 0);
 
 save:
 	mep->cc_ccm_tx_info = *tx_info;
diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index fd2de35ffb3c..3c36fa24bc05 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -341,7 +341,7 @@ static void br_mrp_test_work_expired(struct work_struct *work)
 out:
 	rcu_read_unlock();
 
-	queue_delayed_work(system_wq, &mrp->test_work,
+	queue_delayed_work(system_percpu_wq, &mrp->test_work,
 			   usecs_to_jiffies(mrp->test_interval));
 }
 
@@ -418,7 +418,7 @@ static void br_mrp_in_test_work_expired(struct work_struct *work)
 out:
 	rcu_read_unlock();
 
-	queue_delayed_work(system_wq, &mrp->in_test_work,
+	queue_delayed_work(system_percpu_wq, &mrp->in_test_work,
 			   usecs_to_jiffies(mrp->in_test_interval));
 }
 
@@ -725,7 +725,7 @@ int br_mrp_start_test(struct net_bridge *br,
 	mrp->test_max_miss = test->max_miss;
 	mrp->test_monitor = test->monitor;
 	mrp->test_count_miss = 0;
-	queue_delayed_work(system_wq, &mrp->test_work,
+	queue_delayed_work(system_percpu_wq, &mrp->test_work,
 			   usecs_to_jiffies(test->interval));
 
 	return 0;
@@ -865,7 +865,7 @@ int br_mrp_start_in_test(struct net_bridge *br,
 	mrp->in_test_end = jiffies + usecs_to_jiffies(in_test->period);
 	mrp->in_test_max_miss = in_test->max_miss;
 	mrp->in_test_count_miss = 0;
-	queue_delayed_work(system_wq, &mrp->in_test_work,
+	queue_delayed_work(system_percpu_wq, &mrp->in_test_work,
 			   usecs_to_jiffies(in_test->interval));
 
 	return 0;
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index ab66b599ac47..c227ececa925 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -314,7 +314,7 @@ static void __schedule_delayed(struct ceph_mon_client *monc)
 		delay = CEPH_MONC_PING_INTERVAL;
 
 	dout("__schedule_delayed after %lu\n", delay);
-	mod_delayed_work(system_wq, &monc->delayed_work,
+	mod_delayed_work(system_percpu_wq, &monc->delayed_work,
 			 round_jiffies_relative(delay));
 }
 
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 0ddc4c718833..83fc433f5461 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -855,7 +855,7 @@ void sk_psock_drop(struct sock *sk, struct sk_psock *psock)
 	sk_psock_stop(psock);
 
 	INIT_RCU_WORK(&psock->rwork, sk_psock_destroy);
-	queue_rcu_work(system_wq, &psock->rwork);
+	queue_rcu_work(system_percpu_wq, &psock->rwork);
 }
 EXPORT_SYMBOL_GPL(sk_psock_drop);
 
diff --git a/net/devlink/core.c b/net/devlink/core.c
index 7203c39532fc..58093f49c090 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -320,7 +320,7 @@ static void devlink_release(struct work_struct *work)
 void devlink_put(struct devlink *devlink)
 {
 	if (refcount_dec_and_test(&devlink->refcount))
-		queue_rcu_work(system_wq, &devlink->rwork);
+		queue_rcu_work(system_percpu_wq, &devlink->rwork);
 }
 
 struct devlink *devlinks_xa_find_get(struct net *net, unsigned long *indexp)
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 470ab17ceb51..025895eb6ec5 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -183,7 +183,7 @@ static void fqdir_work_fn(struct work_struct *work)
 	rhashtable_free_and_destroy(&fqdir->rhashtable, inet_frags_free_cb, NULL);
 
 	if (llist_add(&fqdir->free_list, &fqdir_free_list))
-		queue_delayed_work(system_wq, &fqdir_free_work, HZ);
+		queue_delayed_work(system_percpu_wq, &fqdir_free_work, HZ);
 }
 
 int fqdir_init(struct fqdir **fqdirp, struct inet_frags *f, struct net *net)
diff --git a/net/netfilter/nf_conntrack_ecache.c b/net/netfilter/nf_conntrack_ecache.c
index af68c64acaab..81baf2082604 100644
--- a/net/netfilter/nf_conntrack_ecache.c
+++ b/net/netfilter/nf_conntrack_ecache.c
@@ -301,7 +301,7 @@ void nf_conntrack_ecache_work(struct net *net, enum nf_ct_ecache_state state)
 		net->ct.ecache_dwork_pending = true;
 	} else if (state == NFCT_ECACHE_DESTROY_SENT) {
 		if (!hlist_nulls_empty(&cnet->ecache.dying_list))
-			mod_delayed_work(system_wq, &cnet->ecache.dwork, 0);
+			mod_delayed_work(system_percpu_wq, &cnet->ecache.dwork, 0);
 		else
 			net->ct.ecache_dwork_pending = false;
 	}
diff --git a/net/openvswitch/dp_notify.c b/net/openvswitch/dp_notify.c
index 7af0cde8b293..a2af90ee99af 100644
--- a/net/openvswitch/dp_notify.c
+++ b/net/openvswitch/dp_notify.c
@@ -75,7 +75,7 @@ static int dp_device_event(struct notifier_block *unused, unsigned long event,
 
 		/* schedule vport destroy, dev_put and genl notification */
 		ovs_net = net_generic(dev_net(dev), ovs_net_id);
-		queue_work(system_wq, &ovs_net->dp_notify_work);
+		queue_work(system_percpu_wq, &ovs_net->dp_notify_work);
 	}
 
 	return NOTIFY_DONE;
diff --git a/net/rfkill/input.c b/net/rfkill/input.c
index 598d0a61bda7..53d286b10843 100644
--- a/net/rfkill/input.c
+++ b/net/rfkill/input.c
@@ -159,7 +159,7 @@ static void rfkill_schedule_global_op(enum rfkill_sched_op op)
 	rfkill_op_pending = true;
 	if (op == RFKILL_GLOBAL_OP_EPO && !rfkill_is_epo_lock_active()) {
 		/* bypass the limiter for EPO */
-		mod_delayed_work(system_wq, &rfkill_op_work, 0);
+		mod_delayed_work(system_percpu_wq, &rfkill_op_work, 0);
 		rfkill_last_scheduled = jiffies;
 	} else
 		rfkill_schedule_ratelimited();
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index ac07b963aede..ab870109f916 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -85,7 +85,7 @@ static void smc_lgr_schedule_free_work(struct smc_link_group *lgr)
 	 * otherwise there is a risk of out-of-sync link groups.
 	 */
 	if (!lgr->freeing) {
-		mod_delayed_work(system_wq, &lgr->free_work,
+		mod_delayed_work(system_percpu_wq, &lgr->free_work,
 				 (!lgr->is_smcd && lgr->role == SMC_CLNT) ?
 						SMC_LGR_FREE_DELAY_CLNT :
 						SMC_LGR_FREE_DELAY_SERV);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index fc6afbc8d680..f8798d7b5de7 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1569,7 +1569,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 			 * reschedule it, then ungrab the socket refcount to
 			 * keep it balanced.
 			 */
-			if (mod_delayed_work(system_wq, &vsk->connect_work,
+			if (mod_delayed_work(system_percpu_wq, &vsk->connect_work,
 					     timeout))
 				sock_put(sk);
 
-- 
2.51.0


