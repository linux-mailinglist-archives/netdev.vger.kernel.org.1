Return-Path: <netdev+bounces-196619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 559F1AD596A
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 17:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71BF188AA9F
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B02E2BD589;
	Wed, 11 Jun 2025 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RN5dbkjs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16134295502
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653995; cv=none; b=dVQC3omnFJHh4TwmfwZvIK6ASv1JhuVpdwJzv85IlUpkJ9T2rjIjJuAy1J3SYKoD5cjn/JoospN41dlquU6q9S/lSY/TzlKTYVp9PM904HqUt9CupIinRNJSKuGl4omp3l+63yXT9zMBVgviNwFtlN5PaaYdMsp9nMhsWUZWa/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653995; c=relaxed/simple;
	bh=qps5Qr0BWB2lJ8BddifniUABiymQjkKfds2ACxiYV5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrQBIp23UoDpGTRZ7bL/6OBBgdNQyhMjEy3JXxKcorkuBA3bZYsU6y1gnpdJLA6d4Qa9LgI1nJIalQO3AmDvNC4ySX43HiyaQW1kkZgC/xeB4wjDbETjkcEcI85Vnil2zrXZbiridCdY9e5A58aTaUvp+54miNwwS0CRDYxFFOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RN5dbkjs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69817C4CEF1;
	Wed, 11 Jun 2025 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749653994;
	bh=qps5Qr0BWB2lJ8BddifniUABiymQjkKfds2ACxiYV5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RN5dbkjs+yVMmFFb2QGLGBvXZYkCAKzweQ9eG13dUMnHy+0aO5Oz1qD5QYLLL2tWZ
	 EeKHdZuQAB8hq0kBouheLIv7Cg/jeD1WtXs3FdWpmPeNrahawUIG5uftl3tmloiqfy
	 lgCUyWiY/uMrYK26SirACV72cYO4WsUf3f0xiu/B9EUBW95+G71GO4YGVlc0xddQhn
	 k6Y3pnvDqeMLTB39BGFFYDLYnQHfgEunfE9p9dbLuEa1SMc6FBLphZwp2eCvYsy9cr
	 SH/PWdlLk8c+aiASg7ySZGNho+HkJrb6PXp6IKYAN9Il+VuzxlWw0KoM+XpXpeGwP2
	 7U0hyoQeBylOw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch
Subject: [PATCH net-next 1/9] net: ethtool: copy the rxfh flow handling
Date: Wed, 11 Jun 2025 07:59:41 -0700
Message-ID: <20250611145949.2674086-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611145949.2674086-1-kuba@kernel.org>
References: <20250611145949.2674086-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RX Flow Hash configuration uses the same argument structure
as flow filters. This is probably why ethtool IOCTL handles
them together. The more checks we add the more convoluted
this code is getting (as some of the checks apply only
to flow filters and others only to the hashing).

Copy the code to separate the handling. This is an exact
copy, the next change will remove unnecessary handling.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: ecree.xilinx@gmail.com
---
 net/ethtool/ioctl.c | 93 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 39ec920f5de7..5c15eff53c80 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1060,6 +1060,93 @@ static int ethtool_check_flow_types(struct net_device *dev, u32 input_xfrm)
 	return 0;
 }
 
+static noinline_for_stack int
+ethtool_set_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxnfc info;
+	size_t info_size = sizeof(info);
+	int rc;
+
+	if (!ops->set_rxnfc)
+		return -EOPNOTSUPP;
+
+	rc = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
+	if (rc)
+		return rc;
+
+	if (cmd == ETHTOOL_SRXCLSRLINS && info.fs.flow_type & FLOW_RSS) {
+		/* Nonzero ring with RSS only makes sense
+		 * if NIC adds them together
+		 */
+		if (!ops->cap_rss_rxnfc_adds &&
+		    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
+			return -EINVAL;
+
+		if (!xa_load(&dev->ethtool->rss_ctx, info.rss_context))
+			return -EINVAL;
+	}
+
+	if (cmd == ETHTOOL_SRXFH && ops->get_rxfh) {
+		struct ethtool_rxfh_param rxfh = {};
+
+		rc = ops->get_rxfh(dev, &rxfh);
+		if (rc)
+			return rc;
+
+		rc = ethtool_check_xfrm_rxfh(rxfh.input_xfrm, info.data);
+		if (rc)
+			return rc;
+	}
+
+	rc = ops->set_rxnfc(dev, &info);
+	if (rc)
+		return rc;
+
+	if (cmd == ETHTOOL_SRXCLSRLINS &&
+	    ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL))
+		return -EFAULT;
+
+	return 0;
+}
+
+static noinline_for_stack int
+ethtool_get_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
+{
+	struct ethtool_rxnfc info;
+	size_t info_size = sizeof(info);
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	int ret;
+	void *rule_buf = NULL;
+
+	if (!ops->get_rxnfc)
+		return -EOPNOTSUPP;
+
+	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
+	if (ret)
+		return ret;
+
+	if (info.cmd == ETHTOOL_GRXCLSRLALL) {
+		if (info.rule_cnt > 0) {
+			if (info.rule_cnt <= KMALLOC_MAX_SIZE / sizeof(u32))
+				rule_buf = kcalloc(info.rule_cnt, sizeof(u32),
+						   GFP_USER);
+			if (!rule_buf)
+				return -ENOMEM;
+		}
+	}
+
+	ret = ops->get_rxnfc(dev, &info, rule_buf);
+	if (ret < 0)
+		goto err_out;
+
+	ret = ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, rule_buf);
+err_out:
+	kfree(rule_buf);
+
+	return ret;
+}
+
 static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 						u32 cmd, void __user *useraddr)
 {
@@ -3338,13 +3425,17 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 				       dev->ethtool_ops->set_priv_flags);
 		break;
 	case ETHTOOL_GRXFH:
+		rc = ethtool_get_rxfh_fields(dev, ethcmd, useraddr);
+		break;
+	case ETHTOOL_SRXFH:
+		rc = ethtool_set_rxfh_fields(dev, ethcmd, useraddr);
+		break;
 	case ETHTOOL_GRXRINGS:
 	case ETHTOOL_GRXCLSRLCNT:
 	case ETHTOOL_GRXCLSRULE:
 	case ETHTOOL_GRXCLSRLALL:
 		rc = ethtool_get_rxnfc(dev, ethcmd, useraddr);
 		break;
-	case ETHTOOL_SRXFH:
 	case ETHTOOL_SRXCLSRLDEL:
 	case ETHTOOL_SRXCLSRLINS:
 		rc = ethtool_set_rxnfc(dev, ethcmd, useraddr);
-- 
2.49.0


