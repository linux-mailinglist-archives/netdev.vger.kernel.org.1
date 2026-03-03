Return-Path: <netdev+bounces-263357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id a5rLIj0mp2mSfAAAu9opvQ
	(envelope-from <netdev+bounces-263357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:19:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 400B01F52D6
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C188B3052722
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ED1359A77;
	Tue,  3 Mar 2026 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJbeg+Vz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3143563E8;
	Tue,  3 Mar 2026 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561753; cv=none; b=ZhT8sapFL0H1gtdOxz7lHS/PvVl7zYGWZSX3ypFw3J4nIAsLnj08fdg+FYJSvqvu71Yvt90zrYyaxJyubQVGtjlqgrhfj9fs7OJtXImqEPGfSP+HiH6uwNoomOEACmWBRguY/z52RSt1L73JDdd9YwgRCOpYiWvF7QCJIdb4qlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561753; c=relaxed/simple;
	bh=ZJrrcvwUAYxLUxim4bsp6pe5fYg435y8GXGkO1lIokk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFzL2UVQ5fzPf67fkwEdgj0aVHVu6BFLeFzha9BOablnhy4vcmO7Z4l7LKCd7wKInmGvF6CSDAwVamEwEdIx1kuByTvjHU2Jl4bUZEuH3bZiolUHYnnof4ATPt4N1KWpjwxbJ+J/3H2TiLeRnRyK8q+8+dKG8zAfu9j3z0ExsUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJbeg+Vz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85FAC2BC87;
	Tue,  3 Mar 2026 18:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772561753;
	bh=ZJrrcvwUAYxLUxim4bsp6pe5fYg435y8GXGkO1lIokk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cJbeg+VzcvZ8zhXh59pzMOHPFHBBB6PBmqZRfvi9yiht58lGvqhH0Ab4yR5NEfE3N
	 TlUHDnPh7kuEaKBesNUoQ3J+Rf+/4SDdjyBwzD5NHzqVQmFZlfJqrr7kEU8u5g7k4M
	 0GDpMlEsS0/XZe86xP2Us6EZgjg4A3gr162A0mOmN3DKLOa1GHhjQuL/wamUoSYMhG
	 Y4+fhsPDRldBxVXrbpPrzPKCCvrpEeJi3OipOaY/mvTrsrnDbXY2nERrbMEBe4469b
	 CmAQaeInod/R/5yH8TBQRO3Vk49P1fF5CxHGxGGVjV3V3NWS4+oRMQw/uD0Jjq6+4F
	 zyLgen89ERztQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 2/5] bnxt_en: Resize RSS contexts on channel count change
Date: Tue,  3 Mar 2026 19:15:30 +0100
Message-ID: <20260303181535.2671734-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303181535.2671734-1-bjorn@kernel.org>
References: <20260303181535.2671734-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 400B01F52D6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.96 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263357-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

bnxt_set_channels() rejects channel changes that alter the RSS table
size when IFF_RXFH_CONFIGURED is set, because non-default context
sizes were locked at creation.

Replace the rejection with the new resize helpers. All validation runs
before any mutation:

 1. ethtool_rxfh_indir_can_resize() checks context 0.
 2. ethtool_rxfh_contexts_resize_all() validates and resizes
    all non-default contexts (all-or-none).
 3. ethtool_rxfh_indir_resize() applies context 0 changes.

When context 0 uses defaults (!IFF_RXFH_CONFIGURED), steps 1 and 3 are
skipped; the driver regenerates the table via
bnxt_set_dflt_rss_indir_tbl().

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 26fcd52c8a61..7608e5d95630 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -977,11 +977,24 @@ static int bnxt_set_channels(struct net_device *dev,
 		tx_xdp = req_rx_rings;
 	}
 
-	if (bnxt_get_nr_rss_ctxs(bp, req_rx_rings) !=
-	    bnxt_get_nr_rss_ctxs(bp, bp->rx_nr_rings) &&
-	    netif_is_rxfh_configured(dev)) {
-		netdev_warn(dev, "RSS table size change required, RSS table entries must be default to proceed\n");
-		return -EINVAL;
+	if (bnxt_get_nr_rss_ctxs(bp, req_rx_rings) != bnxt_get_nr_rss_ctxs(bp, bp->rx_nr_rings)) {
+		u32 new_size = bnxt_get_nr_rss_ctxs(bp, req_rx_rings) * BNXT_RSS_TABLE_ENTRIES_P5;
+		u32 old_size = bnxt_get_rxfh_indir_size(dev);
+
+		/* Validate context 0 can be resized before mutating anything */
+		if (netif_is_rxfh_configured(dev) &&
+		    ethtool_rxfh_indir_can_resize(bp->rss_indir_tbl, old_size, new_size)) {
+			netdev_warn(dev, "RSS table size change not supported with current indirection table\n");
+			return -EINVAL;
+		}
+
+		rc = ethtool_rxfh_contexts_resize_all(dev, new_size);
+		if (rc)
+			return rc;
+
+		/* All validated; apply context 0 resize */
+		if (netif_is_rxfh_configured(dev))
+			ethtool_rxfh_indir_resize(bp->rss_indir_tbl, old_size, new_size);
 	}
 
 	rc = bnxt_check_rings(bp, req_tx_rings, req_rx_rings, sh, tcs, tx_xdp);
-- 
2.53.0


