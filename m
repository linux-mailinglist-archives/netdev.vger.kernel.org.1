Return-Path: <netdev+bounces-195805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE00CAD2507
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 19:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D8816ED57
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9914F21B9FD;
	Mon,  9 Jun 2025 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZrkeR+p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7677121B9DB
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490495; cv=none; b=ta4opr9G1syEiK59sxs7seheFWTqkijXzcsroiWae8TTip6DugY8tEwDdJJIgpEoDeScUvYkkNluKoLazm2cER2ECyyJmw443Cqx9HJqfkZ+Fh0J7xPTvfclJWCmHqpE6evU9/HtedDexpIUP0zOBjMwTXfdyhC1f4Ha+ONB+JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490495; c=relaxed/simple;
	bh=RDGzMJh9IVNMFxuLiD1xgqLrhfqef+NsoHHTuI+IQk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNF0KhmM+p7nXjIp/KzKUa6wFwhlilopTAuH3mwZCgRl9nbTTleg5so4tq8HLsZdoPTePMlQyykBkZpf2up/FIhNi3op1YoNutkbyKci33zh1W/Xz/s7HBRzFJAGP2F5CRDYs4wiCWjSb0U9LgEhOmdYERJgX3AjpBRKsME9kJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZrkeR+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B80C4CEEF;
	Mon,  9 Jun 2025 17:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749490495;
	bh=RDGzMJh9IVNMFxuLiD1xgqLrhfqef+NsoHHTuI+IQk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CZrkeR+psqH4QC2z9KanpUM351btMssJeKNS2RBcdb8FA9iuHXdPoS11owC2uJNlb
	 tFDsXIT5q1gSLtVueXGjkvYpOR5kHXFBZjcy2V8ggUhJKsXKZXeiNJN0voVXgA9ndp
	 EzGuVOlZK9HpBywcu9Ayp5YEI0CLvWq5C+xSNOHaHOO+7il2PQUCtTASdg6pqRxsXu
	 RDzOXd6kaUaBHcKHSg8OXqZeN3bY7HuPjTKx84jpGa8zMzSCeaVgSdzLOz1A4MjiQx
	 atuivGWe6JeHVUXDMoBB1ihn3f2EMOJgluJrPBj/8o8NMa6pt3VbDhzXUV8zCr+98c
	 OVcUWd+tD3nXQ==
From: Jakub Kicinski <kuba@kernel.org>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com
Cc: willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	ecree.xilinx@gmail.com
Subject: [RFC net-next 1/6] net: ethtool: factor out the validation for ETHTOOL_SRXFH
Date: Mon,  9 Jun 2025 10:34:37 -0700
Message-ID: <20250609173442.1745856-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609173442.1745856-1-kuba@kernel.org>
References: <20250609173442.1745856-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll need another check for ETHTOOL_SRXFH input. Move the logic
to a helper because ethtool_set_rxnfc() is getting long.
No functional change.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: ecree.xilinx@gmail.com
---
 net/ethtool/ioctl.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 39ec920f5de7..e8ca70554b2e 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1060,6 +1060,27 @@ static int ethtool_check_flow_types(struct net_device *dev, u32 input_xfrm)
 	return 0;
 }
 
+static int
+ethtool_srxfh_check(struct net_device *dev, const struct ethtool_rxnfc *info)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	int rc;
+
+	if (ops->get_rxfh) {
+		struct ethtool_rxfh_param rxfh = {};
+
+		rc = ops->get_rxfh(dev, &rxfh);
+		if (rc)
+			return rc;
+
+		rc = ethtool_check_xfrm_rxfh(rxfh.input_xfrm, info->data);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
 static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 						u32 cmd, void __user *useraddr)
 {
@@ -1087,14 +1108,8 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
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
+	if (cmd == ETHTOOL_SRXFH) {
+		rc = ethtool_srxfh_check(dev, &info);
 		if (rc)
 			return rc;
 	}
-- 
2.49.0


