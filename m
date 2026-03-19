Return-Path: <netdev+bounces-269572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONFLD8gxvGnxuQIAu9opvQ
	(envelope-from <netdev+bounces-269572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:26:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BB42CFF4E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AD2730B761B
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B3D30E838;
	Thu, 19 Mar 2026 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="khPvm4sj"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7791FF5E3
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940626; cv=none; b=Q4hpzTftpbHu0JQ1zeKxjn9aypIMsTbtV4Qqdqa0e7OMhLpinF/6owO2wQAKxgqewmM1Gb6rwDx3OahbvAk4wbYbWEjSHm424CdtAudORSuBNuMheYoenMhU10DAdbbkN26h+zjHUPKAM8kz0NDT8ZYNcLgXqUgmzoFeocpgWdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940626; c=relaxed/simple;
	bh=lKQ6eDeu1WkFg9oqQ7mW5zcSTKGNXEMrd/NK4m5OaF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWI3xJUmP6AOwRD+UwbDmD50U2Mq6h6RJ0Vht6zPFV3iTj1BT1+/K6sYKf1/OITwdUQGrFwxleqcHzqQgrZpbUJ7bQvIJ8VSuWPzgXGVc4oXLniWlOQ8JOICtZZoswFIfETQbWxJ8sculpvOno0k5hCh5l1i/9GI1ulEagMpIoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=khPvm4sj; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (122.24.31.150.dy.iij4u.or.jp [150.31.24.122])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62JHH2oJ076820
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 20 Mar 2026 02:17:02 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=H3BlQ+dOv/udM0aaUOjA1M+YqN6bfxaU8xOaQjLz84I=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1773940622; v=1;
        b=khPvm4sjbytDE+ryWZb5mvByATeK8ZG5rDM0TLZut7GnUr4dkiJejIBI6FccssNW
         ZvTFm+viZSy5xL9rSnfX5DnFGHNfmoemw6YAlbkuLuxv0k+v6p2Pl8gRUABgMEpH
         axpmLZouQiz05mhQUsvls/oVRKZfYFU8af7eCoa3pX7VoF25NBoJq2zyz/PqsZMt
         VwsBGHcD4RidF+buWK7nBSWQECF2p5sKsGpfvH3l8mPZec2PhrsZYCc3CYbkHnli
         U+qPsyP9HTLSu49T/yBh0E0+I9HO6MvvQvVTGNM4dvfbpItZKT5QXVvn4CRhScgS
         dRPf9Z5CBL3VJh2aGSHXgw==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kohei.enju@gmail.com,
        Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH iwl-next v1 2/3] i40e: add support for bpf_xdp_metadata_rx_hash()
Date: Thu, 19 Mar 2026 17:16:43 +0000
Message-ID: <20260319171650.5815-3-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319171650.5815-1-kohei@enjuk.jp>
References: <20260319171650.5815-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,enjuk.jp];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269572-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	NEURAL_HAM(-0.00)[-0.964];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,enjuk.jp:dkim,enjuk.jp:email,enjuk.jp:mid]
X-Rspamd-Queue-Id: A5BB42CFF4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce i40e_xdp_rx_hash() which takes the same approach as
i40e_rx_hash() to extract the hash from RX descriptors.

Tested with X710 adapter using xdp_hw_metadata, and verified hash
consistency between bpf_xdp_metadata_rx_hash() and skb->hash.

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 30 +++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_type.h |  5 ++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 7966d9cb8009..6b7e34b16a8d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4,6 +4,7 @@
 #include <generated/utsrelease.h>
 #include <linux/crash_dump.h>
 #include <linux/intel/libie/pctype.h>
+#include <linux/intel/libie/rx.h>
 #include <linux/if_bridge.h>
 #include <linux/if_macvlan.h>
 #include <linux/module.h>
@@ -13585,6 +13586,34 @@ static int i40e_xdp(struct net_device *dev,
 	}
 }
 
+static int i40e_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
+			    enum xdp_rss_hash_type *rss_type)
+{
+	const struct i40e_xdp_buff *ctx = (const void *)_ctx;
+	const union i40e_rx_desc *desc = ctx->desc;
+	struct libeth_rx_pt rx_ptype;
+	u8 raw_rx_ptype;
+	u64 status;
+
+	status = le64_to_cpu(desc->wb.qword1.status_error_len);
+	raw_rx_ptype = FIELD_GET(I40E_RXD_QW1_PTYPE_MASK, status);
+	rx_ptype = libie_rx_pt_parse(raw_rx_ptype);
+
+	if (!libeth_rx_pt_has_hash(ctx->xdp.rxq->dev, rx_ptype) ||
+	    FIELD_GET(I40E_RX_DESC_STATUS_FLTSTAT_MASK, status) !=
+		    I40E_RX_DESC_FLTSTAT_RSS_HASH)
+		return -ENODATA;
+
+	*hash = le32_to_cpu(desc->wb.qword0.hi_dword.rss);
+	*rss_type = rx_ptype.hash_type;
+
+	return 0;
+}
+
+static const struct xdp_metadata_ops i40e_xdp_metadata_ops = {
+	.xmo_rx_hash		= i40e_xdp_rx_hash,
+};
+
 static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_open		= i40e_open,
 	.ndo_stop		= i40e_close,
@@ -13788,6 +13817,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 	i40e_vsi_config_netdev_tc(vsi, vsi->tc_config.enabled_tc);
 
 	netdev->netdev_ops = &i40e_netdev_ops;
+	netdev->xdp_metadata_ops = &i40e_xdp_metadata_ops;
 	netdev->watchdog_timeo = 5 * HZ;
 	i40e_set_ethtool_ops(netdev);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index ed8bbdb586da..16a65c6e5153 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -4,6 +4,7 @@
 #ifndef _I40E_TYPE_H_
 #define _I40E_TYPE_H_
 
+#include <linux/bits.h>
 #include <uapi/linux/if_ether.h>
 #include "i40e_adminq.h"
 #include "i40e_hmc.h"
@@ -699,6 +700,10 @@ enum i40e_rx_desc_status_bits {
 	I40E_RX_DESC_STATUS_LAST /* this entry must be last!!! */
 };
 
+#define I40E_RX_DESC_STATUS_FLTSTAT_MASK                   \
+	GENMASK_ULL(I40E_RX_DESC_STATUS_FLTSTAT_SHIFT + 1, \
+		    I40E_RX_DESC_STATUS_FLTSTAT_SHIFT)
+
 #define I40E_RXD_QW1_STATUS_SHIFT	0
 #define I40E_RXD_QW1_STATUS_MASK	((BIT(I40E_RX_DESC_STATUS_LAST) - 1) \
 					 << I40E_RXD_QW1_STATUS_SHIFT)
-- 
2.51.0


