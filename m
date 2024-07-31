Return-Path: <netdev+bounces-114680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C849436FF
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 22:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D8A28452D
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 20:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149C91607B6;
	Wed, 31 Jul 2024 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cx2j4/Bi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4FA155CB3;
	Wed, 31 Jul 2024 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456938; cv=none; b=rfXXyjbBJDEDo/JbzFl7SWN2CnlJZW8OCfWPClypNZwlR5TUriYPcCWpfo8g2vv88aHanIxxK1XhquILgmE7DuDBMbh6UDX+M14jLn6tYaW9s9mtR9mazNJr0k8EDW2Qz5WvmS+ku1DQOsI0OMotjaqQcK3NLRWThscF8V2Gv9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456938; c=relaxed/simple;
	bh=OYc0eqnvCS57Vh46JZhj/LGq/WMkCP5RJW2wrFRMGMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=avKCJROJosgpF+9tdQTLoJeDVyR3wENWN9jWw/AFGsJb3cLWljuXSJbDCm6B2tdjwMciHMHtgFBzvZuTsocKhGA/k2Utk5ChXv45T0wkZVfniw5coeo1b3EUdgs43KEAj24bO80ttDEzagkC+k3veNdR+svvlLjRB/uofcWbcNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cx2j4/Bi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27949C116B1;
	Wed, 31 Jul 2024 20:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722456937;
	bh=OYc0eqnvCS57Vh46JZhj/LGq/WMkCP5RJW2wrFRMGMY=;
	h=From:To:Cc:Subject:Date:From;
	b=cx2j4/BieCcl37yPXillkjdBsnCLcDzsRb3aexsfzim2vLt2O+oiAUG4wzFbxM+Dn
	 AqQOcxrmUt5YnQUs6kSCO63i/vHhTU7lqbR/57BOMpkLMjf5nizZhGw9XMlANQMjlb
	 /mi1p7GM2YYz2q6RDH2JP8K0uFey4OsZo1CDGUYCOUTPk6WMxB+nyr2uACJfHNqK5m
	 9uWSSXD2EM5Iy2LHZOlTT7JuBdAy9LSSGNggBvRveZA6f2Ux7GyMTuH9Z8g9S0evqJ
	 Lv5EusMjNC+qCPKO6HVTxfM2gOc7os35pbg/4JYKZCCEBwodmAALXsYJUw+A6yzaMj
	 CPyc7SPVnVdxQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: mdio: Use of_property_count_u32_elems() to get property length
Date: Wed, 31 Jul 2024 14:15:15 -0600
Message-ID: <20240731201514.1839974-2-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace of_get_property() with the type specific
of_property_count_u32_elems() to get the property length.

This is part of a larger effort to remove callers of of_get_property()
and similar functions. of_get_property() leaks the DT property data
pointer which is a problem for dynamically allocated nodes which may
be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/net/mdio/of_mdio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index 08e607f62e10..2f4fc664d2e1 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -390,7 +390,7 @@ EXPORT_SYMBOL(of_phy_get_and_connect);
 bool of_phy_is_fixed_link(struct device_node *np)
 {
 	struct device_node *dn;
-	int len, err;
+	int err;
 	const char *managed;
 
 	/* New binding */
@@ -405,8 +405,7 @@ bool of_phy_is_fixed_link(struct device_node *np)
 		return true;
 
 	/* Old binding */
-	if (of_get_property(np, "fixed-link", &len) &&
-	    len == (5 * sizeof(__be32)))
+	if (of_property_count_u32_elems(np, "fixed-link") == 5)
 		return true;
 
 	return false;
-- 
2.43.0


