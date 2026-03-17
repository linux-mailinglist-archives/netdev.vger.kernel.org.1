Return-Path: <netdev+bounces-268489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CZWCUoSuWm8pAEAu9opvQ
	(envelope-from <netdev+bounces-268489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:35:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4512A5BE6
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C84B3055800
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1446934F486;
	Tue, 17 Mar 2026 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/uAHByN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362030ACF0;
	Tue, 17 Mar 2026 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773736434; cv=none; b=ap3EJt+VLGQbDKu+tai+tg1m5FnRFBWYzgC+me9mHF/6K5qClt5MRheYMbBy3UV/9t18k4W9wR/Oar4Cuiy+W1aE+6aPFbUzrHV9mqwuEwR9V6WI6QFIIME5DVNVjtdFSnD0YQXukP+6Z1bAAyHOZuINGWI3XbD05lZvpDvn4BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773736434; c=relaxed/simple;
	bh=2LvIUNGqZF1pgPqATaopqQEldh/YSfdPyM64qeShD9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SRlsYIOLYLQd5lBgOjUC0tc4+WlESH1aAn/ctWHDFlVVFg80TbR8IFR7aHfkBmwxqwv+UPVMGI7p0MVH6/Ago84DNRzIRAWNeJquM/MkO1te04LDqfDI1SO2XpiF0iekUZ/4OmXmUZHsjhAvbqwaKi0O1ykG6gG8wOID3aY6+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/uAHByN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D935C2BC9E;
	Tue, 17 Mar 2026 08:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773736433;
	bh=2LvIUNGqZF1pgPqATaopqQEldh/YSfdPyM64qeShD9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J/uAHByNzfJeHF2K2DaWg473WoWfKfvmEsmtLX/EoqM0wIJt4+yHTUXa08/2+gCdw
	 Azmv1kavwSGPa2fmuUc2VXCop7lF6mbUaJ5LemVATPCUtMJuX59+Ta59+KGKiVDgio
	 b8fxBbCkPJ1BtTGnHKThWMIPT0zecMCC2qmoEJ7C/NxsRCe1VOGn5IbiEj+Tc8+0m/
	 Gj3aTumKJ+ji7Bj6+GSUyvlpe3rlAkt9sjcV7etZo77igOY1c946/gyxTpeBeD3EX7
	 hsBYqSS92xpiIn7hM3SsQF8zgcWB5J59ngnPlrHgnAjCOe85E1IIlvYtKerzY5RVxX
	 oc4gK5S6ZTL3w==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v5 2/3] bnxt_en: Resize RSS contexts on channel count change
Date: Tue, 17 Mar 2026 09:33:35 +0100
Message-ID: <20260317083339.2811865-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317083339.2811865-1-bjorn@kernel.org>
References: <20260317083339.2811865-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.93 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268489-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D4512A5BE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bnxt_set_channels() rejects channel changes that alter the RSS table
size when IFF_RXFH_CONFIGURED is set, because non-default context
sizes were locked at creation.

Replace the rejection with the new resize helpers. All validation runs
before the device is closed; actual resize is deferred until after
bnxt_close_nic():

 1. ethtool_rxfh_can_resize() checks context 0, passing
    dev->ethtool->rss_indir_user_size as the user_size floor.
 2. ethtool_rxfh_ctxs_can_resize() validates all non-default contexts.
 3. After bnxt_close_nic(), ethtool_rxfh_resize() applies context 0
    changes, and ethtool_rxfh_ctxs_resize() resizes non-default
    contexts.

RSS table size only changes on P5 chips with older firmware; newer
firmware always uses the largest table size.

When context 0 uses defaults (!IFF_RXFH_CONFIGURED), steps 1 and 3 are
skipped; the driver regenerates the table via
bnxt_set_dflt_rss_indir_tbl().

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 38 +++++++++++++++----
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 48e8e3be70d3..469f4720c1d7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -942,6 +942,7 @@ static int bnxt_set_channels(struct net_device *dev,
 {
 	struct bnxt *bp = netdev_priv(dev);
 	int req_tx_rings, req_rx_rings, tcs;
+	u32 new_tbl_size = 0, old_tbl_size;
 	bool sh = false;
 	int tx_xdp = 0;
 	int rc = 0;
@@ -977,19 +978,34 @@ static int bnxt_set_channels(struct net_device *dev,
 		tx_xdp = req_rx_rings;
 	}
 
-	if (bnxt_get_nr_rss_ctxs(bp, req_rx_rings) !=
-	    bnxt_get_nr_rss_ctxs(bp, bp->rx_nr_rings) &&
-	    (netif_is_rxfh_configured(dev) || bp->num_rss_ctx)) {
-		netdev_warn(dev, "RSS table size change required, RSS table entries must be default (with no additional RSS contexts present) to proceed\n");
-		return -EINVAL;
-	}
-
 	rc = bnxt_check_rings(bp, req_tx_rings, req_rx_rings, sh, tcs, tx_xdp);
 	if (rc) {
 		netdev_warn(dev, "Unable to allocate the requested rings\n");
 		return rc;
 	}
 
+	/* RSS table size only changes on P5 chips with older firmware;
+	 * newer firmware always uses the largest table size.
+	 */
+	if (bnxt_get_nr_rss_ctxs(bp, req_rx_rings) !=
+	    bnxt_get_nr_rss_ctxs(bp, bp->rx_nr_rings)) {
+		new_tbl_size = bnxt_get_nr_rss_ctxs(bp, req_rx_rings) *
+			       BNXT_RSS_TABLE_ENTRIES_P5;
+		old_tbl_size = bnxt_get_rxfh_indir_size(dev);
+
+		if (netif_is_rxfh_configured(dev) &&
+		    !ethtool_rxfh_can_resize(bp->rss_indir_tbl,
+					old_tbl_size, new_tbl_size,
+					dev->ethtool->rss_indir_user_size)) {
+			netdev_warn(dev, "RSS table resize not possible\n");
+			return -EINVAL;
+		}
+
+		rc = ethtool_rxfh_ctxs_can_resize(dev, new_tbl_size);
+		if (rc)
+			return rc;
+	}
+
 	if (netif_running(dev)) {
 		if (BNXT_PF(bp)) {
 			/* TODO CHIMP_FW: Send message to all VF's
@@ -999,6 +1015,14 @@ static int bnxt_set_channels(struct net_device *dev,
 		bnxt_close_nic(bp, true, false);
 	}
 
+	if (new_tbl_size) {
+		if (netif_is_rxfh_configured(dev))
+			ethtool_rxfh_resize(bp->rss_indir_tbl,
+					    old_tbl_size, new_tbl_size,
+					    dev->ethtool->rss_indir_user_size);
+		ethtool_rxfh_ctxs_resize(dev, new_tbl_size);
+	}
+
 	if (sh) {
 		bp->flags |= BNXT_FLAG_SHARED_RINGS;
 		bp->rx_nr_rings = channel->combined_count;
-- 
2.53.0


