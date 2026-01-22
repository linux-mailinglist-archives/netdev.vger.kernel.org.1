Return-Path: <netdev+bounces-252165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCpCDW6bcWmdKAAAu9opvQ
	(envelope-from <netdev+bounces-252165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:37:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2786160D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84E8D4E066B
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550053F0742;
	Thu, 22 Jan 2026 03:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="g5rPP77A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5123232C302;
	Thu, 22 Jan 2026 03:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052733; cv=none; b=uyG/rC599x997E+fdJXL6VeJUnx8sGUXCndlp5CyCyX9U+xcO0k3ZEyvk2xhV/q0fj2OUY7AXHFVpvgemyUOcWNYCOprCfMdiF7Q3byl51gbYDAH4SMg8yvrlJp5iKMrNxs33rMguFDzQZ5tWLbiK91SEM+ELLCwABfTdsOzFNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052733; c=relaxed/simple;
	bh=m2grbUK5F7bq3r74dZ5BxpA3geRC+FVcS3Ipoa77T0M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T1N5jscnX5UKJeFFhFDGJFD7iYNr9nOsOMbLZOunuspuM3aRhgZd76LRIDwU1zpPlqCmEUC6eiQxt8+9KM96rBHeUxv9FLsqYQflvSPZuL/K78ckbjJ9uFnp2++0otRrL9a4hmQ7b/BGH27EIIJklE6d4yNh+Dl2beCuy2bZBuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=g5rPP77A; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 318765b89;
	Thu, 22 Jan 2026 11:26:48 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: anthony.l.nguyen@intel.com
Cc: przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net] ice: Fix memory leak in ice_set_ringparam()
Date: Thu, 22 Jan 2026 03:26:44 +0000
Message-Id: <20260122032644.183754-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9be3bd8a0103a1kunm23da51ae25240
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSEIdVkxPHk1DH00fGU5LGFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=g5rPP77AIAadHAgYTZtwYjnRmlYV8BfmdytF13ibzbRfLNRYo+N2ZiuuBTT/BPd2Ga+itEls8A3dlRwyPtZaIutl/yw422dm8A08PmPG923QRndV0C6v3rQ+ifFMzR7CGgGMPQdGQe0DVTc+p4vkFZtLbUyx5aS44cNf+/4bE/A=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=ffflAwULRkleIYICFHP/WFtQuZMy6nCm9F9CV+XYt/M=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252165-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[seu.edu.cn,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CF2786160D
X-Rspamd-Action: no action

In ice_set_ringparam, tx_rings and xdp_rings are allocated before
rx_rings. If the allocation of rx_rings fails, the code jumps to
the done label leaking both tx_rings and xdp_rings. Furthermore, if
the setup of an individual Rx ring fails during the loop, the code jumps
to the free_tx label which releases tx_rings but leaks xdp_rings.

Fix this by introducing a free_xdp label and updating the error paths to
ensure both xdp_rings and tx_rings are properly freed if rx_rings
allocation or setup fails.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
Fixes: efc2214b6047 ("ice: Add support for XDP")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 969d4f8f9c02..1643b118144a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3318,7 +3318,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 	rx_rings = kcalloc(vsi->num_rxq, sizeof(*rx_rings), GFP_KERNEL);
 	if (!rx_rings) {
 		err = -ENOMEM;
-		goto done;
+		goto free_xdp;
 	}
 
 	ice_for_each_rxq(vsi, i) {
@@ -3345,7 +3345,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 			}
 			kfree(rx_rings);
 			err = -ENOMEM;
-			goto free_tx;
+			goto free_xdp;
 		}
 	}
 
@@ -3398,6 +3398,13 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 	}
 	goto done;
 
+free_xdp:
+	if (xdp_rings) {
+		ice_for_each_xdp_txq(vsi, i)
+			ice_free_tx_ring(&xdp_rings[i]);
+		kfree(xdp_rings);
+	}
+
 free_tx:
 	/* error cleanup if the Rx allocations failed after getting Tx */
 	if (tx_rings) {
-- 
2.34.1


