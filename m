Return-Path: <netdev+bounces-76377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3563C86D842
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 01:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619D6B21CD1
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 00:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC64464B;
	Fri,  1 Mar 2024 00:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbttejEv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FBE365
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 00:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252172; cv=none; b=SKYx/KAwPqDTz6i8M+WCrKHZg/LKLR4EQ60C2hrvHhVN6Qh04OWh6z88W3d7reB3h6epjLA06jHQKDWpuwBdDFTmlZH/rvzlos5VG0vz0qE+rYCoKbtURb4MYiIV4ew8Skmah7blEy00XBAXS5P6d8bnEn3p0ophY+hGsZZdtMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252172; c=relaxed/simple;
	bh=GUG5P6IPCFAXBVQRjeHpjmbdaAFnnclF/+A/w2B2Jp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/WxibMWX8v1o7xGJ9vt1r/vaaAv8YdFDBwYl23VvN98b0Hl8vt2c9DCLyjxddaQjnPNs6O8AvZgH9SfthJYpNS3LzBge9ZZK5nycwc7ZJhKm5G3gYNn4ePFRDIxVvmLf26MDAxpwaC1Dyb0K8+Buov03WY9tLPVmVrlJ0Cy76k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbttejEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A687C43394;
	Fri,  1 Mar 2024 00:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709252171;
	bh=GUG5P6IPCFAXBVQRjeHpjmbdaAFnnclF/+A/w2B2Jp4=;
	h=From:To:Cc:Subject:Date:From;
	b=JbttejEvi5w2r+u8WZPxMWsEdVzGZBQkp570chu+zDLxXjrCldfvBM6XGULXfxrCK
	 h+joFOvFhuZa/t3YvNqRriX65KovsoAbuPb1wxHkAJx6OftLAeKsJcBZjJfLD0UOJq
	 sC/Dj1yx9uQmlwnTPcQf6v8e+MIVZP8V8nCRT/aYlVe8bYN8qWylXqIaurrgv1GA1J
	 AcHpwTeG8UaAo1S7B+8ycYA57hbyyxJ95DOZ/abCrC93zMHYcWofJG7U24I0wGHWDC
	 BRbRLPJ4dsNJOGBIVtj7WC8Hsg5w6qiXKpZ2oBiqSg4vupbSYSr01nSbdNbyE2amSS
	 0ku7v1WX+R4HA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	jiri@resnulli.us
Subject: [PATCH net-next] dpll: avoid multiple function calls to dump netdev info
Date: Thu, 29 Feb 2024 16:16:07 -0800
Message-ID: <20240301001607.2925706-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to compiler oddness and because struct dpll_pin is defined
in a private header we have to call into dpll code to get
the handle for the pin associated with a netdev.
Combine getting the pin pointer and getting the info into
a single function call by having the helpers take a netdev
pointer, rather than expecting a pin.

The exports are note needed, networking core can't be a module.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
BTW is the empty nest if the netdev has no pin intentional?
Should we add a comment explaining why it's there?

CC: vadim.fedorenko@linux.dev
CC: arkadiusz.kubalewski@intel.com
CC: jiri@resnulli.us
---
 drivers/dpll/dpll_core.c    |  5 -----
 drivers/dpll/dpll_netlink.c | 38 +++++++++++++++++++++++--------------
 include/linux/dpll.h        | 19 ++++++-------------
 net/core/rtnetlink.c        |  4 ++--
 4 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 12fcd420396e..a87bf95216c1 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -44,11 +44,6 @@ struct dpll_pin_registration {
 	void *priv;
 };
 
-struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
-{
-	return rcu_dereference_rtnl(dev->dpll_pin);
-}
-
 struct dpll_device *dpll_device_get_by_id(int id)
 {
 	if (xa_get_mark(&dpll_device_xa, id, DPLL_REGISTERED))
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 1419fd0d241c..9be4ae35fea2 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -8,6 +8,7 @@
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/netdevice.h>
 #include <net/genetlink.h>
 #include "dpll_core.h"
 #include "dpll_netlink.h"
@@ -47,18 +48,6 @@ dpll_msg_add_dev_parent_handle(struct sk_buff *msg, u32 id)
 	return 0;
 }
 
-/**
- * dpll_msg_pin_handle_size - get size of pin handle attribute for given pin
- * @pin: pin pointer
- *
- * Return: byte size of pin handle attribute for given pin.
- */
-size_t dpll_msg_pin_handle_size(struct dpll_pin *pin)
-{
-	return pin ? nla_total_size(4) : 0; /* DPLL_A_PIN_ID */
-}
-EXPORT_SYMBOL_GPL(dpll_msg_pin_handle_size);
-
 /**
  * dpll_msg_add_pin_handle - attach pin handle attribute to a given message
  * @msg: pointer to sk_buff message to attach a pin handle
@@ -68,7 +57,7 @@ EXPORT_SYMBOL_GPL(dpll_msg_pin_handle_size);
  * * 0 - success
  * * -EMSGSIZE - no space in message to attach pin handle
  */
-int dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin)
+static int dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin)
 {
 	if (!pin)
 		return 0;
@@ -76,7 +65,28 @@ int dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin)
 		return -EMSGSIZE;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(dpll_msg_add_pin_handle);
+
+static struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
+{
+	return rcu_dereference_rtnl(dev->dpll_pin);
+}
+
+/**
+ * dpll_netdev_pin_handle_size - get size of pin handle attribute of a netdev
+ * @dev: netdev from which to get the pin
+ *
+ * Return: byte size of pin handle attribute, or 0 if @dev has no pin.
+ */
+size_t dpll_netdev_pin_handle_size(const struct net_device *dev)
+{
+	return netdev_dpll_pin(dev) ? nla_total_size(4) : 0; /* DPLL_A_PIN_ID */
+}
+
+int dpll_netdev_add_pin_handle(struct sk_buff *msg,
+			       const struct net_device *dev)
+{
+	return dpll_msg_add_pin_handle(msg, netdev_dpll_pin(dev));
+}
 
 static int
 dpll_msg_add_mode(struct sk_buff *msg, struct dpll_device *dpll,
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index e3abde993244..ff14d1e88f87 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -123,15 +123,17 @@ struct dpll_pin_properties {
 };
 
 #if IS_ENABLED(CONFIG_DPLL)
-size_t dpll_msg_pin_handle_size(struct dpll_pin *pin);
-int dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin);
+size_t dpll_netdev_pin_handle_size(const struct net_device *dev);
+int dpll_netdev_add_pin_handle(struct sk_buff *msg,
+			       const struct net_device *dev);
 #else
-static inline size_t dpll_msg_pin_handle_size(struct dpll_pin *pin)
+static inline size_t dpll_netdev_pin_handle_size(const struct net_device *dev)
 {
 	return 0;
 }
 
-static inline int dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin)
+static inline int
+dpll_netdev_add_pin_handle(struct sk_buff *msg, const struct net_device *dev)
 {
 	return 0;
 }
@@ -170,13 +172,4 @@ int dpll_device_change_ntf(struct dpll_device *dpll);
 
 int dpll_pin_change_ntf(struct dpll_pin *pin);
 
-#if !IS_ENABLED(CONFIG_DPLL)
-static inline struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
-{
-	return NULL;
-}
-#else
-struct dpll_pin *netdev_dpll_pin(const struct net_device *dev);
-#endif
-
 #endif
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 780b330f8ef9..e0353487c57e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1056,7 +1056,7 @@ static size_t rtnl_dpll_pin_size(const struct net_device *dev)
 {
 	size_t size = nla_total_size(0); /* nest IFLA_DPLL_PIN */
 
-	size += dpll_msg_pin_handle_size(netdev_dpll_pin(dev));
+	size += dpll_netdev_pin_handle_size(dev);
 
 	return size;
 }
@@ -1793,7 +1793,7 @@ static int rtnl_fill_dpll_pin(struct sk_buff *skb,
 	if (!dpll_pin_nest)
 		return -EMSGSIZE;
 
-	ret = dpll_msg_add_pin_handle(skb, netdev_dpll_pin(dev));
+	ret = dpll_netdev_add_pin_handle(skb, dev);
 	if (ret < 0)
 		goto nest_cancel;
 
-- 
2.43.2


