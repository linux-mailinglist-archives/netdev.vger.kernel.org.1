Return-Path: <netdev+bounces-179991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF724A7F0D0
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 01:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A223AC7AA
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF7C22B5AD;
	Mon,  7 Apr 2025 23:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="umOxltOt"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8B922A80D;
	Mon,  7 Apr 2025 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744067888; cv=none; b=Rhy9lMKZs+U3bRH8/s8oCCVRc4D1W+HKFKoBiqWKJ7j5/2BxxC5tjoviL65iM/RxT6HLeMKreNeFda5DQO5yeGhjpNcGniG7HKuipF7hW4FX+81ogjlhrojmIh1viCAnSrPIFaAXuD26zk0qrQNvxZs4wDn5gWpgiuFrsa3L5Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744067888; c=relaxed/simple;
	bh=dWjOjsTrYbBpz2dj2hY7wJ2k4rrN31bKVK8cHOUCjPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vp+Dnj4MR5rAoYZuGDum/ohaZnr7WZjD7kNDOs2Zj3qaMf90MqFlw3YNu1h/tpC+3esuTP+Nvv7Fhs2xLDUHpxmHiCQBkPdFS+P5ePK3EOjmzxyg5AwZ3rkMfd1rc+71uejVdcktnWxD5RLxAk1jwZCTZVNjuSCFV4MW0h/Xhko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=umOxltOt; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744067883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpxVE6UWC4i9Tj174l5nfhvQ+bKWt6zi9RLVO+q8jfQ=;
	b=umOxltOtftHqiVYo//KqTtwdHnQLUiAGn/3t8vNL++anaJxttQft8FaSJUeNrnxZyIlGRe
	E1LLRZgYh8aQkMAAKyg+E97C+aQ3iuVCw93zaGWWHPT73eRx2D3YZmGytVogYif5nOZVt8
	5LQZ6IBtHaEI77aDJRrtOiog/8WgvmY=
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
Subject: [net-next PATCH v2 03/14] device property: Add fwnode_property_get_reference_optional_args
Date: Mon,  7 Apr 2025 19:17:34 -0400
Message-Id: <20250407231746.2316518-4-sean.anderson@linux.dev>
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

Add a fwnode variant of of_parse_phandle_with_optional_args to allow
nargs_prop to be absent from the referenced node. This improves
compatibility for references where the devicetree might not always have
nargs_prop.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---
This commit has been submitted separately as [1] and is included here
solely so CI will run.

[1] https://lore.kernel.org/all/20250407223714.2287202-3-sean.anderson@linux.dev

Changes in v2:
- New

 drivers/base/property.c  | 46 ++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  4 ++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 049f8a6088a1..ef13ca32079b 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -618,6 +618,52 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);
 
+/**
+ * fwnode_property_get_reference_optional_args() - Find a reference with optional arguments
+ * @fwnode:	Firmware node where to look for the reference
+ * @prop:	The name of the property
+ * @nargs_prop:	The name of the property telling the number of
+ *		arguments in the referred node.
+ * @index:	Index of the reference, from zero onwards.
+ * @args:	Result structure with reference and integer arguments.
+ *		May be NULL.
+ *
+ * Obtain a reference based on a named property in an fwnode, with
+ * integer arguments. If @nargs_prop is absent from the referenced node, then
+ * number of arguments is be assumed to be 0.
+ *
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * @args->fwnode pointer.
+ *
+ * Return: %0 on success
+ *	    %-ENOENT when the index is out of bounds, the index has an empty
+ *		     reference or the property was not found
+ *	    %-EINVAL on parse error
+ */
+int fwnode_property_get_reference_optional_args(const struct fwnode_handle *fwnode,
+						const char *prop,
+						const char *nargs_prop,
+						unsigned int index,
+						struct fwnode_reference_args *args)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(fwnode))
+		return -ENOENT;
+
+	ret = fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
+				 0, index, args);
+	if (ret == 0)
+		return ret;
+
+	if (IS_ERR_OR_NULL(fwnode->secondary))
+		return ret;
+
+	return fwnode_call_int_op(fwnode->secondary, get_reference_args, prop, nargs_prop,
+				  0, index, args);
+}
+EXPORT_SYMBOL_GPL(fwnode_property_get_reference_optional_args);
+
 /**
  * fwnode_find_reference - Find named reference to a fwnode_handle
  * @fwnode: Firmware node where to look for the reference
diff --git a/include/linux/property.h b/include/linux/property.h
index e214ecd241eb..a1662b36d15f 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -139,6 +139,10 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 				       const char *prop, const char *nargs_prop,
 				       unsigned int nargs, unsigned int index,
 				       struct fwnode_reference_args *args);
+int fwnode_property_get_reference_optional_args(const struct fwnode_handle *fwnode,
+						const char *prop, const char *nargs_prop,
+						unsigned int index,
+						struct fwnode_reference_args *args);
 
 struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
 					    const char *name,
-- 
2.35.1.1320.gc452695387.dirty


