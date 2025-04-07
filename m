Return-Path: <netdev+bounces-179990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA61A7F0CB
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 01:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D05F7A691B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E2922ACD3;
	Mon,  7 Apr 2025 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a5d+LaDx"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F30922A1E2
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 23:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744067886; cv=none; b=JJ1gvS1A//F85lU/hdWKeD5sz8EI2P5v8dyJ8JWFXMbcj85timFEl0pqoL3dkLH8J/FStppjBitm0Ulkvh70zUdMWIIiYeGHdZ3TtjfjNBIMPPCxibsq3xfB7CMVYrEAj55mcobERh325v2ykjKDqZrljj4FzJq2/0HDwbnIMW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744067886; c=relaxed/simple;
	bh=prlVXMIm/IyzRJG01fRQFtYuEC0d9hNE4jg//LTIq2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nEV8GUhU8aXmUIfsCv5VZgpAos8KV9laxRoHNiuAzcmeidb/EoDgic1dSap9T7OLwvOFzoQNvR4TX1auTli3k82DqkwynyZZ2toqmoNpVcv05tk0ueF2bePdTGg66u7lcpDLWI/OpXRNY19Rmfo/dbkHf23x0Tj/ahujXSRVZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a5d+LaDx; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744067881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RBAVY7AqAx/BkqtLYLu/lWNBEK2/ZgF8XsCuXLDoulw=;
	b=a5d+LaDxluS6fy8BnFbwv+mSyf5epFJ3mhQYNgW0uCtUGMJ86zj60H4JdcbgZ4J/AtSfDe
	aq+/SIfotJHBP9yzpw2axtmOtqMIjg+XJoleXT+PYbjBBHyBM13PVIO5tToeGyosfGwJAa
	/vvs7N6PE0ChIhRGuSei5kNbtvfwmEg=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	upstream@airoha.com,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [net-next PATCH v2 02/14] device property: Add optional nargs_prop for get_reference_args
Date: Mon,  7 Apr 2025 19:17:33 -0400
Message-Id: <20250407231746.2316518-3-sean.anderson@linux.dev>
In-Reply-To: <20250407231746.2316518-1-sean.anderson@linux.dev>
References: <20250407231746.2316518-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

get_reference_args does not permit falling back to nargs when nargs_prop
is missing. This makes it difficult to support older devicetrees where
nargs_prop may not be present. Add support for this by converting nargs
to a signed value. Where before nargs was ignored if nargs_prop was
passed, now nargs is only ignored if it is strictly negative. When it is
positive, nargs represents the fallback cells to use if nargs_prop is
absent.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---
This commit has been submitted separately as [1] and is included here
solely so CI will run.

[1] https://lore.kernel.org/all/20250407223714.2287202-2-sean.anderson@linux.dev

Changes in v2:
- New

 drivers/base/property.c |  4 ++--
 drivers/base/swnode.c   | 13 +++++++++----
 drivers/of/property.c   | 10 +++-------
 include/linux/fwnode.h  |  2 +-
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c1392743df9c..049f8a6088a1 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -606,7 +606,7 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 		return -ENOENT;
 
 	ret = fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
-				 nargs, index, args);
+				 nargs_prop ? -1 : nargs, index, args);
 	if (ret == 0)
 		return ret;
 
@@ -614,7 +614,7 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 		return ret;
 
 	return fwnode_call_int_op(fwnode->secondary, get_reference_args, prop, nargs_prop,
-				  nargs, index, args);
+				  nargs_prop ? -1 : nargs, index, args);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);
 
diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index b1726a3515f6..11af2001478f 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -503,7 +503,7 @@ software_node_get_named_child_node(const struct fwnode_handle *fwnode,
 static int
 software_node_get_reference_args(const struct fwnode_handle *fwnode,
 				 const char *propname, const char *nargs_prop,
-				 unsigned int nargs, unsigned int index,
+				 int nargs, unsigned int index,
 				 struct fwnode_reference_args *args)
 {
 	struct swnode *swnode = to_swnode(fwnode);
@@ -543,10 +543,15 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 		error = property_entry_read_int_array(ref->node->properties,
 						      nargs_prop, sizeof(u32),
 						      &nargs_prop_val, 1);
-		if (error)
+
+		if (error == -EINVAL) {
+			if (nargs < 0)
+				return error;
+		} else if (error) {
 			return error;
-
-		nargs = nargs_prop_val;
+		} else {
+			nargs = nargs_prop_val;
+		}
 	}
 
 	if (nargs > NR_FWNODE_REFERENCE_ARGS)
diff --git a/drivers/of/property.c b/drivers/of/property.c
index c1feb631e383..c41190e47111 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1116,19 +1116,15 @@ of_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 static int
 of_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
 			     const char *prop, const char *nargs_prop,
-			     unsigned int nargs, unsigned int index,
+			     int nargs, unsigned int index,
 			     struct fwnode_reference_args *args)
 {
 	struct of_phandle_args of_args;
 	unsigned int i;
 	int ret;
 
-	if (nargs_prop)
-		ret = of_parse_phandle_with_args(to_of_node(fwnode), prop,
-						 nargs_prop, index, &of_args);
-	else
-		ret = of_parse_phandle_with_fixed_args(to_of_node(fwnode), prop,
-						       nargs, index, &of_args);
+	ret = __of_parse_phandle_with_args(to_of_node(fwnode), prop, nargs_prop,
+					   nargs, index, &of_args);
 	if (ret < 0)
 		return ret;
 	if (!args) {
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 0731994b9d7c..2f71830a1418 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -163,7 +163,7 @@ struct fwnode_operations {
 				const char *name);
 	int (*get_reference_args)(const struct fwnode_handle *fwnode,
 				  const char *prop, const char *nargs_prop,
-				  unsigned int nargs, unsigned int index,
+				  int nargs, unsigned int index,
 				  struct fwnode_reference_args *args);
 	struct fwnode_handle *
 	(*graph_get_next_endpoint)(const struct fwnode_handle *fwnode,
-- 
2.35.1.1320.gc452695387.dirty


