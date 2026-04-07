Return-Path: <netdev+bounces-276052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMlqNrgk1WnK1AcAu9opvQ
	(envelope-from <netdev+bounces-276052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:37:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E233B122F
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B85C30E13A8
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAE63BE65F;
	Tue,  7 Apr 2026 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgUKfOjE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150633859FC
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575903; cv=none; b=BFULBPGB5rXU/MU6VDYaOG48vYR5G+WtYvVXyACBH7tWutccHRXBwpV2LP7eVi+9guRXpx6zGwqTmxSej0wTZSr9TqURYIEjyAI1qkTc+kmBpFHqxLV/d/xSn2/Jad+m3DhbiVpyFIFCiEPTudXqfY7xJ8Rq5ml/go7H6HQrUwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575903; c=relaxed/simple;
	bh=o09WtNxu5Zi8a0iPWHJi+lGKxIT2tfrnM7MeAojXDEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qdcpy/N/HR+XVbP1jBBC0xU4GzBlL6x/HfCGmN8ekTrBZSWKgAk7B8KgIVgSgSGLBVhlVdOfVLOxMqNbeiCFla18uOzyzAlWn+D1ECf13UQ/C29yfJYqypMwTgzkaxWoTJiwmImgcyb776nW1CM12jXK+r33wFSgD52WhbGZgPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgUKfOjE; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-415e568a7ecso1904495fac.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775575889; x=1776180689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mg6drz+QVpKB5/V38R1gb2bDU9OtbCKCHb/PPel8U0=;
        b=cgUKfOjE674QV/+ZOdN0yga3NbNB/fwsu0iawnxDxGFV52+xjKVlAumWkXdsASOykg
         3dJetV+p6SzoBItQ0TxETl7wWuHIq/z3DEd84U/fqBMwKAKKInS6mKEuM0BeGMWLIe/R
         +S2sP31c04CeMS1e+CPONZeZfisxBe7dYO70VSrJ0luvlrHw2vTr0pMIH/4Kjjc0MNxw
         yS3ezkx66Gh6KIaUmdjDE79Y5/LvNm7ujh7F58K/pmcD0G7DGBMVGH+6nX9efAJJXFKV
         COHVqUsoR2dcVAsrooaZb+03YwyzCVjZd9Uc5+i2dSC1C+r7lUPLAZfqlSTrpnEsEcVH
         529g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775575889; x=1776180689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7mg6drz+QVpKB5/V38R1gb2bDU9OtbCKCHb/PPel8U0=;
        b=OInnYKFmbyuyIXn2f8mm6QudgXJivio4Sl/QPaUX+phPNR9Q3jXUDciarsXn1+X1/W
         MrtpWPe7wyVZjhgq6z7Bw1lulD4dUCAxLzg2tz7ftYapI2sf/8YRWKTRnf2Hej01+fur
         549B11B1ACwbmJTvloB4B1WqCrFufFGlq45FeL2IM5F4MULlU0hmI9xsbgF4LNpWVrkW
         LqTgfQN0hvu/97olgTGB8e5Wp9aWzEukQkht0kwg4yXa8wiroubAbriIJelk5qNCktC/
         XQjj9tYz5TmW2JRTg3tMT8Kw44ku4xQFx0CmuiM8Y28FLixJksj0NBGTjb5On869iCXw
         VRVg==
X-Gm-Message-State: AOJu0Yzu42A33dU3nYSfSVNDHuX0xg9mKlEymnnIJIzlmrUiq7/Fy/1a
	i4kpA/R7StHUmvQLvM7NSEFtNgSzQzbFPF5VNv/4KtVmcme9rFryIW0TllcfkaWaACs=
X-Gm-Gg: AeBDietPm1MAqGFtOuW/cz3R5mowqY4z1kwhqS7RPsNC087gNi0o2FcvCIvHeTCY8w5
	E7XP7jAVMPriu/s8KyER/zymMVdcx8MePRj22XzNpqpaA26p1TQaVmB1OsXreZM/BtCjKUc0tjz
	nZMJH49Sa4GAItwpO0AjwA93w8/XWoYyLw3vxyYDypzP/ZJdPnuOYHDZGRZ29/+A/6oUMWsRktn
	TigqNCj2NuukneiEdF3EOH+y2rmI1s9rqSSJXOsZ13vpaXaGBVmXxcbY/p+th9Qbq6wXRDb3sNQ
	eGUWw9QsMhnd3MIyKYz0V5AMdCGIq/LbV4buDiFh7thkCcORe2ru/5qIXFWTsvt9UX48C6EJ8BQ
	ElPLxpPwvdutMQE/4wz62mjXwZMbT3nVPkloNZKunamNcAS0Kd2Skz8XtQkRIdJOI8yRMkZ1Ujh
	vQZNXRJ56BS9ifjvPLyQ==
X-Received: by 2002:a05:6870:aa05:b0:41c:9c4a:151f with SMTP id 586e51a60fabf-4230fdb45b9mr10004426fac.14.1775575873695;
        Tue, 07 Apr 2026 08:31:13 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:72::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4231f7712bcsm11143944fac.18.2026.04.07.08.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:31:13 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v6 09/14] iavf: convert to ndo_set_rx_mode_async
Date: Tue,  7 Apr 2026 08:30:56 -0700
Message-ID: <20260407153101.3694714-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407153101.3694714-1-sdf@fomichev.me>
References: <20260407153101.3694714-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276052-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65E233B122F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert iavf from ndo_set_rx_mode to ndo_set_rx_mode_async.
iavf_set_rx_mode now takes explicit uc/mc list parameters and
uses __hw_addr_sync_dev on the snapshots instead of __dev_uc_sync
and __dev_mc_sync.

The iavf_configure internal caller passes the real lists directly.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index dad001abc908..3c1465cf0515 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1150,14 +1150,18 @@ bool iavf_promiscuous_mode_changed(struct iavf_adapter *adapter)
 /**
  * iavf_set_rx_mode - NDO callback to set the netdev filters
  * @netdev: network interface device structure
+ * @uc: snapshot of uc address list
+ * @mc: snapshot of mc address list
  **/
-static void iavf_set_rx_mode(struct net_device *netdev)
+static void iavf_set_rx_mode(struct net_device *netdev,
+			     struct netdev_hw_addr_list *uc,
+			     struct netdev_hw_addr_list *mc)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
-	__dev_uc_sync(netdev, iavf_addr_sync, iavf_addr_unsync);
-	__dev_mc_sync(netdev, iavf_addr_sync, iavf_addr_unsync);
+	__hw_addr_sync_dev(uc, netdev, iavf_addr_sync, iavf_addr_unsync);
+	__hw_addr_sync_dev(mc, netdev, iavf_addr_sync, iavf_addr_unsync);
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
 	spin_lock_bh(&adapter->current_netdev_promisc_flags_lock);
@@ -1210,7 +1214,9 @@ static void iavf_configure(struct iavf_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 	int i;
 
-	iavf_set_rx_mode(netdev);
+	netif_addr_lock_bh(netdev);
+	iavf_set_rx_mode(netdev, &netdev->uc, &netdev->mc);
+	netif_addr_unlock_bh(netdev);
 
 	iavf_configure_tx(adapter);
 	iavf_configure_rx(adapter);
@@ -5153,7 +5159,7 @@ static const struct net_device_ops iavf_netdev_ops = {
 	.ndo_open		= iavf_open,
 	.ndo_stop		= iavf_close,
 	.ndo_start_xmit		= iavf_xmit_frame,
-	.ndo_set_rx_mode	= iavf_set_rx_mode,
+	.ndo_set_rx_mode_async	= iavf_set_rx_mode,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address	= iavf_set_mac,
 	.ndo_change_mtu		= iavf_change_mtu,
-- 
2.52.0


