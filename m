Return-Path: <netdev+bounces-283707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pUF+Lkw7+GnvrgIAu9opvQ
	(envelope-from <netdev+bounces-283707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 08:23:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E3B4B8D4A
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 08:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2390830075E3
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 06:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6C625B2F4;
	Mon,  4 May 2026 06:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKwhjDfP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D438D14AD20
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 06:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777875784; cv=none; b=kQdwSmJVK+V0CYqLFLAQHn7yIM4pRG8Om7SSJcQJc4VJFnHWVD7p8ctH8RLTFMgeyAc1aV4cIZiuRBWH8XeRJjISVWtVjSv5RK26dFjvX70z5w0ytrGDxvnZOFkgO7l+JRxlYnBTHME/s9lBYllEdCcv6qYqF1mOeN4cytZoyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777875784; c=relaxed/simple;
	bh=OUJKAnSSKBK4NVixGUpnELUihzSk6cas2RIndIcRiLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PWdwvw79IkU7tlpaay7lb94ubJnZWW3/d8RVswqU5er/fpIjYRj9Ctt+T/NxHcXgSFlqmbMEgx7ZfgSdv1NvI0v73/MOzidroAoJnQYBPeWAnpGl+cQj232rYSUNG8DLjbGUhgX6mvF6+kUBPt+eD75mz5kJKly9+ZaA7h4qiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKwhjDfP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so34980745e9.2
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 23:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777875781; x=1778480581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SsKY674gEcmVloxh8QcPPtKruXs8CJmiJS+7itrX6N0=;
        b=jKwhjDfP55dnzcjlbdaQiQ13PX8YQ1gPGXHS/itau/WvctBdu6X6UmXC+78b2qCumH
         ypfRzhTGdLl774ejJN3UBrRpSUcDi4xiU1rlVDQXYSX8sH6vMFPzOIu/Hzk2FwPmf5QU
         dVzFzKO38MVPG0zF3WccKDLc7Rtcz6NV1vKTpmR6vypl2Jvqq82p6hbkPe73k4fZmVYf
         MV1xj3rs0oOI61stMMN0lwJo+eOak3KxssNpMSQeoOJyTa2VrVx3X3EmPYSL13XorJPk
         EfuT9uKshCuQKCoW4qj5bEDIhkCkIxn24wDhONI5OPtwNIXQPq3qeyCYaTnA/gQOJPAX
         +oug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777875781; x=1778480581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsKY674gEcmVloxh8QcPPtKruXs8CJmiJS+7itrX6N0=;
        b=lzcbi7cgZbVDUSu5U5wav+LfRq1N/ywEcpYEDQx/d/RTGlZ4ySwB70pE3+3QvH1SxZ
         x6xSgFXVr4wxNL7GRjCKI0uZxRLZ3u2Z0zgk+sHyoZT4Oms9Z6ID6GvoeCZXb7yzAyKR
         NAchyiWn91C8lXDfTnPXWhVw/dXi4ypCYp+RxxaTHhTME5ktX+ELUpOJoxem4kxIL8Ex
         Xs7BYtKDx0fNG4sMVecFHT1JIAWGl+QHnmoLVIvqNJi6umwVdr1SG4MJrV3QmYtsAJz5
         SSlEbGGh3M0xDye4w9MvKMEm1fqeKxAAAOT+DfYxVbrOgjfJv55OF9b3xJP/+g4t5A69
         nPCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/njfCmTRN2XKaUnk/QJ5qnLK8SvQBXa4PZGLMwJxLCxuEv4STzkdxWDFGARqIuGwuXRL79lkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi6IdZysdxlOT/2fA7ndDs/nO6FETBxfl2S5j4sBjujuA9td7k
	FaaWhu8eBq26z9/mbqacWPkMKkRXT4llusmTiOjOZXk+UPKRDM3I7EOs
X-Gm-Gg: AeBDieuC9VDB79XRA2KCxq/0RAFccmBujw5dOPprrQE5nTxIBLs5XMGJsDleqvlH+PZ
	c9qnbsG/4FxFarV+wABVUNSCcAjrdFB00oJZkkEI7VRh4bAozAOdwLwuOhBFkzEj4fpARPtoK6m
	ESjclUlueyEC33pYp3ZUfUM4Aq32vYgJRnpJLs5gzIRYvBESlizIb3H5OTgFMP5xcXoqwZKXJI8
	ZhuKSXzNJygeBDiagpdfNK4gC6DQ+dCl3OKliAnBZUdYNneVlc/pdmT6BLDn/aCZfEGHv2AfZMc
	oWKhEe49fgqDDh5u4jfhHR45DRvV7ucwut7p0CH+2NJtnqQ3rmaehbuC4xudJsrQBGy04Zlh0q+
	xIRclvn7Cp7yaHVwwDHv+ugmQAtUnU75PUgiHB3Zk1+hy2KF3ay/cN3WrKVgCmEBHfYUQWl2IvV
	jdCzkyqN4CGbaxSJaeFPuVEHxVfCTB9+UrFqFRlmKJT8YoU7ZNmOawOyqCQic/3t81AuM49H3m9
	QjGZ3r1to78lJ9dDOErjw==
X-Received: by 2002:a05:600c:8590:b0:489:1f3e:5f6f with SMTP id 5b1f17b1804b1-48a98636c00mr95678385e9.12.1777875780935;
        Sun, 03 May 2026 23:23:00 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81b99127sm297500385e9.0.2026.05.03.23.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 23:23:00 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>
Subject: [PATCH] ixgbe: E610: do not fill EEE lp_advertised from local PHY caps
Date: Mon,  4 May 2026 07:22:57 +0100
Message-ID: <20260504062257.77460-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 04E3B4B8D4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-283707-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]

ixgbe_get_eee_e610() fills kedata->lp_advertised from pcaps.eee_cap
returned by ixgbe_aci_get_phy_caps() with IXGBE_ACI_REPORT_ACTIVE_CFG.
That report mode (and the other IXGBE_ACI_REPORT_* modes) describe the
local PHY only, not the link partner. The X550 path uses a separate
FW_PHY_ACT_UD_2 activity for partner data; the E610 ACI has no
equivalent.

Leave lp_advertised zeroed via the existing linkmode_zero() and drop
the now-unused ixgbe_eee_cap_map[]. eee_active/eee_enabled are
unaffected (sourced from link.eee_status).

Fixes: b61dbdeff3a9 ("ixgbe: E610: add EEE support")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 6990fe53f049..36e43b5e88d1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3558,17 +3558,6 @@ static const struct {
 	{ FW_PHY_ACT_UD_2_10G_KR_EEE, ETHTOOL_LINK_MODE_10000baseKR_Full_BIT},
 };
 
-static const struct {
-	u16 eee_cap_bit;
-	u32 link_mode;
-} ixgbe_eee_cap_map[] = {
-	{ IXGBE_ACI_PHY_EEE_EN_100BASE_TX, ETHTOOL_LINK_MODE_100baseT_Full_BIT },
-	{ IXGBE_ACI_PHY_EEE_EN_1000BASE_T, ETHTOOL_LINK_MODE_1000baseT_Full_BIT },
-	{ IXGBE_ACI_PHY_EEE_EN_10GBASE_T, ETHTOOL_LINK_MODE_10000baseT_Full_BIT },
-	{ IXGBE_ACI_PHY_EEE_EN_5GBASE_T, ETHTOOL_LINK_MODE_5000baseT_Full_BIT },
-	{ IXGBE_ACI_PHY_EEE_EN_2_5GBASE_T, ETHTOOL_LINK_MODE_2500baseT_Full_BIT },
-};
-
 static int ixgbe_validate_keee(struct net_device *netdev,
 			       struct ethtool_keee *keee_requested)
 {
@@ -3645,7 +3634,6 @@ static int ixgbe_get_eee_e610(struct net_device *netdev,
 	struct ixgbe_aci_cmd_get_phy_caps_data pcaps;
 	struct ixgbe_hw *hw = &adapter->hw;
 	struct ixgbe_link_status link;
-	u16 eee_cap;
 	int err;
 
 	linkmode_zero(kedata->lp_advertised);
@@ -3670,14 +3658,6 @@ static int ixgbe_get_eee_e610(struct net_device *netdev,
 	if (kedata->eee_enabled)
 		kedata->tx_lpi_timer = le16_to_cpu(pcaps.eee_entry_delay);
 
-	eee_cap = le16_to_cpu(pcaps.eee_cap);
-
-	for (int i = 0; i < ARRAY_SIZE(ixgbe_eee_cap_map); i++) {
-		if (eee_cap & ixgbe_eee_cap_map[i].eee_cap_bit)
-			linkmode_set_bit(ixgbe_eee_cap_map[i].link_mode,
-					 kedata->lp_advertised);
-	}
-
 	for (int i = 0; i < ARRAY_SIZE(ixgbe_ls_map); i++) {
 		if (hw->phy.eee_speeds_supported &
 		    ixgbe_ls_map[i].mac_speed)
-- 
2.53.0


