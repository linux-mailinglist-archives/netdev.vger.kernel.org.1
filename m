Return-Path: <netdev+bounces-196620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE9BAD596B
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 17:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F06497A9955
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 14:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1212BD5B6;
	Wed, 11 Jun 2025 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqR0pAw1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DB62BD5AE
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653995; cv=none; b=lgLPwPa+PkylpbZM8iAFb9mpmk5lskfSzFH+FcguxM8QkkJD4pzbZboEkB0Vwwg9q+B1XvdXx9izs4gCzerqA9IOrltPIs7vJ4dVPQXkoLFVEvM8p63ZgIPsDYKD7j3ECMRg3cO4+imyEEYjGGQoQtUUwIbheqjhcDSGP+avTcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653995; c=relaxed/simple;
	bh=hJr5ArsZVTk1RL9zS9O5FFq35JxWT+PZFs6G0NpS7aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGoR2mZdc+jjKaoSD/CuF3gYiRrBXUHkRUOmUhYk57hS1UBJG+KBWoD5jbl0TPMFnjeMX36SFH9RwuDEf/EPD6Hpg0Q8W1s2N5ot+ROYq53BGgFGRhrW64M4JunynC6uqZK8ILVMjcAxqxPXGlMeNse8NyWUxlZAHkaya8TXwh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqR0pAw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50C2C4CEF0;
	Wed, 11 Jun 2025 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749653995;
	bh=hJr5ArsZVTk1RL9zS9O5FFq35JxWT+PZFs6G0NpS7aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uqR0pAw1MC7xa9dZcBZFu2xchEDFZ18w5TswBMs0B4FJNOkaJwdhq1H9sSbfqGsKR
	 T1Ip+V4qT8qPcueZOtWtXu1TckfG0ejVOU/dzHAm/XE+DZ7aUod74QIZNkcmz2/kpD
	 2hf3xXz68xjmbRc7p8+147Pb5eU4IA/oiNg1si9J/b9+fQLo0Jl8hcQLshPfhvvgdd
	 5zgQw7XUq27GG3aK658eOjJIUVC2/nC/p+V070RNaAc1GRH5g7Dle1vb7+WjjPE7dP
	 zl7k5QZlZnGEcIooY+Cc8B8t8PsnoIwKsJ16JkSYdyPf6zh5KRyIre0OjALEYUiD9x
	 vnHEmqNqcR3pg==
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
Subject: [PATCH net-next 2/9] net: ethtool: remove the duplicated handling from rxfh and rxnfc
Date: Wed, 11 Jun 2025 07:59:42 -0700
Message-ID: <20250611145949.2674086-3-kuba@kernel.org>
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

Now that the handles have been separated - remove the RX Flow Hash
handling from rxnfc functions and vice versa.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: ecree.xilinx@gmail.com
---
 net/ethtool/ioctl.c | 57 ++++-----------------------------------------
 1 file changed, 5 insertions(+), 52 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 5c15eff53c80..330ca99800ce 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1075,19 +1075,7 @@ ethtool_set_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 	if (rc)
 		return rc;
 
-	if (cmd == ETHTOOL_SRXCLSRLINS && info.fs.flow_type & FLOW_RSS) {
-		/* Nonzero ring with RSS only makes sense
-		 * if NIC adds them together
-		 */
-		if (!ops->cap_rss_rxnfc_adds &&
-		    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
-			return -EINVAL;
-
-		if (!xa_load(&dev->ethtool->rss_ctx, info.rss_context))
-			return -EINVAL;
-	}
-
-	if (cmd == ETHTOOL_SRXFH && ops->get_rxfh) {
+	if (ops->get_rxfh) {
 		struct ethtool_rxfh_param rxfh = {};
 
 		rc = ops->get_rxfh(dev, &rxfh);
@@ -1099,15 +1087,7 @@ ethtool_set_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 			return rc;
 	}
 
-	rc = ops->set_rxnfc(dev, &info);
-	if (rc)
-		return rc;
-
-	if (cmd == ETHTOOL_SRXCLSRLINS &&
-	    ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL))
-		return -EFAULT;
-
-	return 0;
+	return ops->set_rxnfc(dev, &info);
 }
 
 static noinline_for_stack int
@@ -1117,7 +1097,6 @@ ethtool_get_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 	size_t info_size = sizeof(info);
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	int ret;
-	void *rule_buf = NULL;
 
 	if (!ops->get_rxnfc)
 		return -EOPNOTSUPP;
@@ -1126,25 +1105,11 @@ ethtool_get_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 	if (ret)
 		return ret;
 
-	if (info.cmd == ETHTOOL_GRXCLSRLALL) {
-		if (info.rule_cnt > 0) {
-			if (info.rule_cnt <= KMALLOC_MAX_SIZE / sizeof(u32))
-				rule_buf = kcalloc(info.rule_cnt, sizeof(u32),
-						   GFP_USER);
-			if (!rule_buf)
-				return -ENOMEM;
-		}
-	}
-
-	ret = ops->get_rxnfc(dev, &info, rule_buf);
+	ret = ops->get_rxnfc(dev, &info, NULL);
 	if (ret < 0)
-		goto err_out;
+		return ret;
 
-	ret = ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, rule_buf);
-err_out:
-	kfree(rule_buf);
-
-	return ret;
+	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
 }
 
 static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
@@ -1174,18 +1139,6 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 			return -EINVAL;
 	}
 
-	if (cmd == ETHTOOL_SRXFH && ops->get_rxfh) {
-		struct ethtool_rxfh_param rxfh = {};
-
-		rc = ops->get_rxfh(dev, &rxfh);
-		if (rc)
-			return rc;
-
-		rc = ethtool_check_xfrm_rxfh(rxfh.input_xfrm, info.data);
-		if (rc)
-			return rc;
-	}
-
 	rc = ops->set_rxnfc(dev, &info);
 	if (rc)
 		return rc;
-- 
2.49.0


