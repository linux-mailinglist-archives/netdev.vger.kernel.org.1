Return-Path: <netdev+bounces-197274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A30AD7FF1
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568B81E2B46
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DE01DACA7;
	Fri, 13 Jun 2025 01:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9LVt8oE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58101D7E54
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 01:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749776496; cv=none; b=DlTv0EVVIFYfoRrQn05iNVJCxlNyzRGIpy7eMfaGFzaChEg023+NciAJhD0Ix+z9hxGZdu1ubX+onfENmtfav2ewbwTztxAvpXC7wI0l3GFoICLeUBjdLL8vvib7WAC3zk7RBpupqbT28HHSnYHVGxcjkiSDE2oUv04cWxRz8L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749776496; c=relaxed/simple;
	bh=d2+I9YrQ6+9TmowGEFVu3ZWD3zNPnAHlGJF1Pf4TYAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCSMizYN+enSmdn4SuTre3I9Qv4ICDvFDKCo/1jJ+o8GVl2UWesYbL+cFJvnqm1m2M1HZu8mwkLVTgyESCzEWgCLiUTgQCTSn4OwpE/hnrWBhmsRjDGC4HHERWn61B0w1LEVB/CoVowZLfxyQDVxxRpJYsR0Z9683Ow5F00thRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9LVt8oE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED06EC4CEF2;
	Fri, 13 Jun 2025 01:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749776496;
	bh=d2+I9YrQ6+9TmowGEFVu3ZWD3zNPnAHlGJF1Pf4TYAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k9LVt8oEGDAnyEfChvF+i5kE2mtmN2rBQHRz0XKP49lfglPB8IhEx5QocqsBJOmrr
	 PwBWBmGOpBhBSy2JbRGJRYdcHpmO2TMH75oHtQY7oFyDANqxldKRZmtEqID/C15pbG
	 WoWP0B9OZsHPH4+MvV0hUJu+nkyMr7Qd+ga2aGsyHOox4vl7gCOaAM4pmDNHQ+UF2N
	 qbaWIdCJz0CN3+KrH4ZI/wyPOGVs/q43ozGaSxwM1XN1aaog8eT1uVldOSF8Fhzngm
	 bi9IuOxL42+qQVwwrhHNfXKXuj8G16JpsJlcR7WdVGiMyf7q+tQnvxLKTjhMflVJOD
	 A41KNAtR3m7+w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/7] eth: ixgbe: migrate to new RXFH callbacks
Date: Thu, 12 Jun 2025 18:01:07 -0700
Message-ID: <20250613010111.3548291-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613010111.3548291-1-kuba@kernel.org>
References: <20250613010111.3548291-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
add dedicated callbacks for getting and setting rxfh fields").

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 1dc1c6e611a4..8aac6b1ae1c7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2753,9 +2753,11 @@ static int ixgbe_get_ethtool_fdir_all(struct ixgbe_adapter *adapter,
 	return 0;
 }
 
-static int ixgbe_get_rss_hash_opts(struct ixgbe_adapter *adapter,
-				   struct ethtool_rxnfc *cmd)
+static int ixgbe_get_rxfh_fields(struct net_device *dev,
+				 struct ethtool_rxfh_fields *cmd)
 {
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
+
 	cmd->data = 0;
 
 	/* Report default options for RSS on ixgbe */
@@ -2825,9 +2827,6 @@ static int ixgbe_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	case ETHTOOL_GRXCLSRLALL:
 		ret = ixgbe_get_ethtool_fdir_all(adapter, cmd, rule_locs);
 		break;
-	case ETHTOOL_GRXFH:
-		ret = ixgbe_get_rss_hash_opts(adapter, cmd);
-		break;
 	default:
 		break;
 	}
@@ -3079,9 +3078,11 @@ static int ixgbe_del_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
 
 #define UDP_RSS_FLAGS (IXGBE_FLAG2_RSS_FIELD_IPV4_UDP | \
 		       IXGBE_FLAG2_RSS_FIELD_IPV6_UDP)
-static int ixgbe_set_rss_hash_opt(struct ixgbe_adapter *adapter,
-				  struct ethtool_rxnfc *nfc)
+static int ixgbe_set_rxfh_fields(struct net_device *dev,
+				 const struct ethtool_rxfh_fields *nfc,
+				 struct netlink_ext_ack *extack)
 {
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
 	u32 flags2 = adapter->flags2;
 
 	/*
@@ -3204,9 +3205,6 @@ static int ixgbe_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	case ETHTOOL_SRXCLSRLDEL:
 		ret = ixgbe_del_ethtool_fdir_entry(adapter, cmd);
 		break;
-	case ETHTOOL_SRXFH:
-		ret = ixgbe_set_rss_hash_opt(adapter, cmd);
-		break;
 	default:
 		break;
 	}
@@ -3797,6 +3795,8 @@ static const struct ethtool_ops ixgbe_ethtool_ops_e610 = {
 	.get_rxfh_key_size	= ixgbe_get_rxfh_key_size,
 	.get_rxfh		= ixgbe_get_rxfh,
 	.set_rxfh		= ixgbe_set_rxfh,
+	.get_rxfh_fields	= ixgbe_get_rxfh_fields,
+	.set_rxfh_fields	= ixgbe_set_rxfh_fields,
 	.get_eee		= ixgbe_get_eee,
 	.set_eee		= ixgbe_set_eee,
 	.get_channels		= ixgbe_get_channels,
-- 
2.49.0


