Return-Path: <netdev+bounces-278143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCELI5cl3WlcaQkAu9opvQ
	(envelope-from <netdev+bounces-278143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:19:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F03F93F12B9
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5381305F755
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC3A346E72;
	Mon, 13 Apr 2026 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvzH1L/U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5819B346766
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100300; cv=none; b=J9SP1VSHqUsf8X/Ws05UP6lJfudFh/jbWBXorO9K8tolerkRcOgjKAoDzdE3kvt5APN5xd7iElD3xq+Sq33+E/G8NO9vxqfYUYaHbp2O592czRaaWzDmsEWqtM2gYl8dqPt66JMM6yV3weD/cHQ8GwHCMVCWzHLYX71/vnTZbEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100300; c=relaxed/simple;
	bh=lqJf2A8LgOM52ePgcRrCnQKgeLTib9NIaemHSM8bVdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jw1fprhNsg6zuVjj5dRu3FLTfis72aG2R8329Hj5K7ZS+87SmQq7m3ft0jGyeIHqDq5/NPcRkDejVHeO3kFVlnqxu6YupPN2AqGjFpqxU0KrZ8ypoP0fP+/CWeMMgsd2mQF6/XpgCkGdAt9tsAe9E9Z9FvWVqTstFLB0mnKeJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvzH1L/U; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-68a5e7b5b52so1941421eaf.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776100298; x=1776705098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USvislDHedA17UChRohdtoPvzSGeYQYcGb9R5/42pBo=;
        b=pvzH1L/UZldqEIU8r+F5x5bcD1z1nfl4j3yzmQWYgEH/Zp9+U5HkmVTcxF5su3RK/8
         44tHh6Wi1mCp/crkxfl9P/H+wDNFc8vVNGdvNb7g1hPdwosPzDm46uCu73/EtwRg4G22
         GuPncvNKwrpTx63p6jtLCYV3WS6bM6BkwUzXbZw+UyF/3bneyU2bOEszn+ENyWPMvT3Y
         vxRjwu4ck2O0fxZ6VifN8+EWcEvhhI6ZRaOmWbuPjWLZ4zR0ML4vv4KL5IWUlVLi6Faq
         pPeYxNmV+u11oJ4hil+SZIFJoLRTM0ZPVOuckteNuKoA1JEh+VXfjDAoh+bwDTy69Eoc
         HPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100298; x=1776705098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=USvislDHedA17UChRohdtoPvzSGeYQYcGb9R5/42pBo=;
        b=YUxu0L0z4DYJiiKr5U0zXIpTzjb0QAhMQAgU9mEpr0vnLSRzVjKx7qZyKaX87o3u6Y
         r2XG17qV6E8o5iaFLRnDYJr0yKsSDhvxqtvHz7bXlu0BuqT9gfB91QZI7ZreXnNR8LKV
         RcfhobkqUh/BeonmedRcoyb4WhDjWsdEjXZv9/qfmWibiK80u/Rdhcn+DWQi7q9J/Ck6
         S0Ak4U/Pzxt/uC5+x8QTxocQrKNumBfNxlbLaJQnaBAtTuIj25b86takpyJ1BAIfIzXo
         raYMf6tYDw7CZ5vfNqqF5u5timIgsCp+oNj0iL1HdOXaV9D3Ewu/x9rzjQf472/xvfmo
         teZA==
X-Gm-Message-State: AOJu0YxUGscOGItD0h8y1Apd9pmNrKjzmdmXU/nH4aCih6QRldsW6IIi
	vJh+EGnqJ0Un9MwOVCCyVTCp4GgtB0XPd7H0XI+DtVlTXSdBFijd3YaBKNFQyQ0h
X-Gm-Gg: AeBDieub8z0LhWnTMDgq8HQ4o7/xZzax8ryVnb6FEPHQfFwPX8PPWaJexlRg7FuZ/oW
	/VoHBaEi8ruml2gRAI541tN5pQ6Y4s9GgDnDhBWuYGIeFEzH3ojka+DXY/fJ5yrfWLBysInIJSR
	im90UJ4gwNeoHNkaEgfXdzBwsZnrUGFfmLyXQYtFOZnNUN8I7STqMXCPsbjrXtY19FOrlDMyjc3
	0Uz4wv2NwvRm8AX5Nfcnr+40uaQ4nuisLn4uk8FcR6xvrU8X9J6flqAycT8tBGxq+l6DCHqRIW2
	hek7/HoJ66ijfKQo/T3q/PGzfeOcUBv0ZRoyMWrc4Xl4s2fkc/lPxvQzfPcSCp47LQAFtuRBhL6
	Hcscc3nQcBAuutYFiMx2dGykPqCBtcIbq6zBnxFoWPpn6v4kWoX6UEztQ6PBGkoI2oKXZt0tSIK
	SrgPq9g+pTFxQT0UkBEg==
X-Received: by 2002:a05:6820:2905:b0:67c:28d6:430e with SMTP id 006d021491bc7-68bf8bca5c4mr6472868eaf.28.1776100298154;
        Mon, 13 Apr 2026 10:11:38 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:70::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68bcb882465sm6656687eaf.15.2026.04.13.10.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:11:37 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v7 05/15] fbnic: convert to ndo_set_rx_mode_async
Date: Mon, 13 Apr 2026 10:11:21 -0700
Message-ID: <20260413171131.550126-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413171131.550126-1-sdf@fomichev.me>
References: <20260413171131.550126-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278143-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid,intel.com:email,fb.com:email]
X-Rspamd-Queue-Id: F03F93F12B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert fbnic from ndo_set_rx_mode to ndo_set_rx_mode_async. The
driver's __fbnic_set_rx_mode() now takes explicit uc/mc list
parameters and uses __hw_addr_sync_dev() on the snapshots instead
of __dev_uc_sync/__dev_mc_sync on the netdev directly.

Update callers in fbnic_up, fbnic_fw_config_after_crash,
fbnic_bmc_rpc_check and fbnic_set_mac to pass the real address
lists calling __fbnic_set_rx_mode outside the async work path.

Cc: Alexander Duyck <alexanderduyck@fb.com>
Cc: kernel-team@meta.com
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 20 ++++++++++++-------
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  4 +++-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  4 ++--
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |  2 +-
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index b4b396ca9bce..c406a3b56b37 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -183,7 +183,9 @@ static int fbnic_mc_unsync(struct net_device *netdev, const unsigned char *addr)
 	return ret;
 }
 
-void __fbnic_set_rx_mode(struct fbnic_dev *fbd)
+void __fbnic_set_rx_mode(struct fbnic_dev *fbd,
+			 struct netdev_hw_addr_list *uc,
+			 struct netdev_hw_addr_list *mc)
 {
 	bool uc_promisc = false, mc_promisc = false;
 	struct net_device *netdev = fbd->netdev;
@@ -213,10 +215,10 @@ void __fbnic_set_rx_mode(struct fbnic_dev *fbd)
 	}
 
 	/* Synchronize unicast and multicast address lists */
-	err = __dev_uc_sync(netdev, fbnic_uc_sync, fbnic_uc_unsync);
+	err = __hw_addr_sync_dev(uc, netdev, fbnic_uc_sync, fbnic_uc_unsync);
 	if (err == -ENOSPC)
 		uc_promisc = true;
-	err = __dev_mc_sync(netdev, fbnic_mc_sync, fbnic_mc_unsync);
+	err = __hw_addr_sync_dev(mc, netdev, fbnic_mc_sync, fbnic_mc_unsync);
 	if (err == -ENOSPC)
 		mc_promisc = true;
 
@@ -238,18 +240,21 @@ void __fbnic_set_rx_mode(struct fbnic_dev *fbd)
 	fbnic_write_tce_tcam(fbd);
 }
 
-static void fbnic_set_rx_mode(struct net_device *netdev)
+static void fbnic_set_rx_mode(struct net_device *netdev,
+			      struct netdev_hw_addr_list *uc,
+			      struct netdev_hw_addr_list *mc)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
 	struct fbnic_dev *fbd = fbn->fbd;
 
 	/* No need to update the hardware if we are not running */
 	if (netif_running(netdev))
-		__fbnic_set_rx_mode(fbd);
+		__fbnic_set_rx_mode(fbd, uc, mc);
 }
 
 static int fbnic_set_mac(struct net_device *netdev, void *p)
 {
+	struct fbnic_net *fbn = netdev_priv(netdev);
 	struct sockaddr *addr = p;
 
 	if (!is_valid_ether_addr(addr->sa_data))
@@ -257,7 +262,8 @@ static int fbnic_set_mac(struct net_device *netdev, void *p)
 
 	eth_hw_addr_set(netdev, addr->sa_data);
 
-	fbnic_set_rx_mode(netdev);
+	if (netif_running(netdev))
+		__fbnic_set_rx_mode(fbn->fbd, &netdev->uc, &netdev->mc);
 
 	return 0;
 }
@@ -551,7 +557,7 @@ static const struct net_device_ops fbnic_netdev_ops = {
 	.ndo_features_check	= fbnic_features_check,
 	.ndo_set_mac_address	= fbnic_set_mac,
 	.ndo_change_mtu		= fbnic_change_mtu,
-	.ndo_set_rx_mode	= fbnic_set_rx_mode,
+	.ndo_set_rx_mode_async	= fbnic_set_rx_mode,
 	.ndo_get_stats64	= fbnic_get_stats64,
 	.ndo_bpf		= fbnic_bpf,
 	.ndo_hwtstamp_get	= fbnic_hwtstamp_get,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 9129a658f8fa..eded20b0e9e4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -97,7 +97,9 @@ void fbnic_time_init(struct fbnic_net *fbn);
 int fbnic_time_start(struct fbnic_net *fbn);
 void fbnic_time_stop(struct fbnic_net *fbn);
 
-void __fbnic_set_rx_mode(struct fbnic_dev *fbd);
+void __fbnic_set_rx_mode(struct fbnic_dev *fbd,
+			 struct netdev_hw_addr_list *uc,
+			 struct netdev_hw_addr_list *mc);
 void fbnic_clear_rx_mode(struct fbnic_dev *fbd);
 
 void fbnic_phylink_get_pauseparam(struct net_device *netdev,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index e3aebbe3656d..6b139cf54256 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -135,7 +135,7 @@ void fbnic_up(struct fbnic_net *fbn)
 
 	fbnic_rss_reinit_hw(fbn->fbd, fbn);
 
-	__fbnic_set_rx_mode(fbn->fbd);
+	__fbnic_set_rx_mode(fbn->fbd, &fbn->netdev->uc, &fbn->netdev->mc);
 
 	/* Enable Tx/Rx processing */
 	fbnic_napi_enable(fbn);
@@ -180,7 +180,7 @@ static int fbnic_fw_config_after_crash(struct fbnic_dev *fbd)
 	}
 
 	fbnic_rpc_reset_valid_entries(fbd);
-	__fbnic_set_rx_mode(fbd);
+	__fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->mc);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index 42a186db43ea..fe95b6f69646 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -244,7 +244,7 @@ void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
 
 	if (fbd->fw_cap.need_bmc_tcam_reinit) {
 		fbnic_bmc_rpc_init(fbd);
-		__fbnic_set_rx_mode(fbd);
+		__fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->mc);
 		fbd->fw_cap.need_bmc_tcam_reinit = false;
 	}
 
-- 
2.52.0


