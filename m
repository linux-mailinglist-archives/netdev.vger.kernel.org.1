Return-Path: <netdev+bounces-60331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2F181EA37
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 22:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7F51F21CF0
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 21:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3F15223;
	Tue, 26 Dec 2023 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="I7EOp/xM"
X-Original-To: netdev@vger.kernel.org
Received: from mx09lb.world4you.com (mx09lb.world4you.com [81.19.149.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FB14C6D
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 21:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ef9YeevTYFrhPhDSJP55hFxC7KJgHYQXlvjB+r62CKI=; b=I7EOp/xMaUkCS8c+P1+rasJ3fl
	JqmuoBkxRdfRomuFVydk+A7bwudSG7PFC6hXLybQB7cGmQjWBMgkl+zn1NoPdL/gYsNMMuk9rOn1U
	XevRo9kNFg7wnjeBrbjgsWTmnMj7RECwqkeL75qZMW+vVzy1oARhENi8hw3sMn6e1u9M=;
Received: from [88.117.59.246] (helo=hornet.engleder.at)
	by mx09lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1rIESo-0005wB-0u;
	Tue, 26 Dec 2023 21:55:46 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: ahmed.zaki@intel.com,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jia.guo@intel.com,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net-next] net: ethtool: Fix symmetric-xor RSS RX flow hash check
Date: Tue, 26 Dec 2023 21:55:36 +0100
Message-Id: <20231226205536.32003-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

Commit 13e59344fb9d ("net: ethtool: add support for symmetric-xor RSS hash")
adds a check to the ethtool set_rxnfc operation, which checks the RX
flow hash if the flag RXH_XFRM_SYM_XOR is set. This flag is introduced
with the same commit. It calls the ethtool get_rxfh operation to get the
RX flow hash data. If get_rxfh is not supported, then EOPNOTSUPP is
returned.

There are driver like tsnep, macb, asp2, genet, gianfar, mtk, ... which
support the ethtool operation set_rxnfc but not get_rxfh. This results
in EOPNOTSUPP returned by ethtool_set_rxnfc() without actually calling
the ethtool operation set_rxnfc. Thus, set_rxnfc got broken for all
these drivers.

Check RX flow hash in ethtool_set_rxnfc() only if driver supports RX
flow hash.

Fixes: 13e59344fb9d ("net: ethtool: add support for symmetric-xor RSS hash")
Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 net/ethtool/ioctl.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 86d47425038b..ec27897d1b24 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -973,32 +973,35 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 						u32 cmd, void __user *useraddr)
 {
 	const struct ethtool_ops *ops = dev->ethtool_ops;
-	struct ethtool_rxfh_param rxfh = {};
 	struct ethtool_rxnfc info;
 	size_t info_size = sizeof(info);
 	int rc;
 
-	if (!ops->set_rxnfc || !ops->get_rxfh)
+	if (!ops->set_rxnfc)
 		return -EOPNOTSUPP;
 
 	rc = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
 	if (rc)
 		return rc;
 
-	rc = ops->get_rxfh(dev, &rxfh);
-	if (rc)
-		return rc;
+	if (ops->get_rxfh) {
+		struct ethtool_rxfh_param rxfh = {};
 
-	/* Sanity check: if symmetric-xor is set, then:
-	 * 1 - no other fields besides IP src/dst and/or L4 src/dst
-	 * 2 - If src is set, dst must also be set
-	 */
-	if ((rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
-	    ((info.data & ~(RXH_IP_SRC | RXH_IP_DST |
-			    RXH_L4_B_0_1 | RXH_L4_B_2_3)) ||
-	     (!!(info.data & RXH_IP_SRC) ^ !!(info.data & RXH_IP_DST)) ||
-	     (!!(info.data & RXH_L4_B_0_1) ^ !!(info.data & RXH_L4_B_2_3))))
-		return -EINVAL;
+		rc = ops->get_rxfh(dev, &rxfh);
+		if (rc)
+			return rc;
+
+		/* Sanity check: if symmetric-xor is set, then:
+		 * 1 - no other fields besides IP src/dst and/or L4 src/dst
+		 * 2 - If src is set, dst must also be set
+		 */
+		if ((rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
+		    ((info.data & ~(RXH_IP_SRC | RXH_IP_DST |
+				    RXH_L4_B_0_1 | RXH_L4_B_2_3)) ||
+		     (!!(info.data & RXH_IP_SRC) ^ !!(info.data & RXH_IP_DST)) ||
+		     (!!(info.data & RXH_L4_B_0_1) ^ !!(info.data & RXH_L4_B_2_3))))
+			return -EINVAL;
+	}
 
 	rc = ops->set_rxnfc(dev, &info);
 	if (rc)
-- 
2.39.2


