Return-Path: <netdev+bounces-96954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DED88C8672
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 14:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532642831A6
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 12:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF004E1C9;
	Fri, 17 May 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=georgemail.de header.i=@georgemail.de header.b="hs14MQEv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp6.goneo.de (smtp6.goneo.de [85.220.129.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F097F9;
	Fri, 17 May 2024 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715949951; cv=none; b=SHYxgl6J/MsoHbJPnBpkay2Il2NycxTChy4mW2rH6o6Cwb1SUS32jv+QmEjPUdMaBVxUjCqL3KhKbeB7PaNtysX71rNoItj/XQ/R4dew93s/JsXF7m1+eUKpVyP2mpc1odjfExZE3ZrwqPgPSSwkPuVVuGJ/PUSuQFFD+i4bbMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715949951; c=relaxed/simple;
	bh=zzowSdOcccsefcTCdPDByVjsT65OHarNBb65thFvtzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n+xbFlDJR8YYInmMfNtNv96/zpY6fLXj4QkCAbpeXmF9mSl0T/h9TTZwRqKlZhBYeWb1wmg3gKLW2T0MT24u4Y1mSohZ9KnI10CB2qcfGEeYclA5BZIRsXUiicAKJ9XSQ59qaz2pKE2ZgzwMYuEVY2GbTigGFBS7a/gwN0oYFLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=georgemail.de; spf=pass smtp.mailfrom=georgemail.de; dkim=pass (2048-bit key) header.d=georgemail.de header.i=@georgemail.de header.b=hs14MQEv; arc=none smtp.client-ip=85.220.129.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=georgemail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=georgemail.de
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp6.goneo.de (Postfix) with ESMTPS id 90048240DD7;
	Fri, 17 May 2024 14:39:19 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id B06F1240442;
	Fri, 17 May 2024 14:39:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgemail.de;
	s=DKIM001; t=1715949557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ETo/7t0jMfRcqI4JYOD11QlXjc/nqxz/zTNoMnf3Kp4=;
	b=hs14MQEvIiLON4mkZqC0IbPeSwdMp4CJ0XOd3tE1VTfFIN3DZJFwPDD/tSYf0MQSjGHUOP
	dnqZqP0B/4FQGZ5HtUKAR61cKW3JNiaAkRiWAtwCIbQaf6Vp/obsTcON1Q5/eDMQIhxyxK
	vCTxO9uuUdgIm4VGvT3PoyJZleCn0UQLnXARrVXI7QlGQNhP0Vh/K+1+ZFvBs3qHF7u3m9
	pBIbBCLaExSgzzIe4fu0ST4cksyf9sc5m1BhHopbIy6qeFoiTp00buJT379pxAt6elVcXf
	uVmfTlXDwIafIjc5hhIjciIMGQm2vEv/bYfDl1z1v53/1p0dKUfsYxnzHlYQZQ==
Received: from couch-potassium.fritz.box (unknown [IPv6:2a02:8071:5250:1240:f4e6:f6d2:6d95:e0c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id 0E74E240300;
	Fri, 17 May 2024 14:39:17 +0200 (CEST)
From: "Leon M. Busch-George" <leon@georgemail.de>
To: linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 1/2] net: add option to ignore 'local-mac-address' property
Date: Fri, 17 May 2024 14:39:07 +0200
Message-ID: <20240517123909.680686-1-leon@georgemail.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: cd6231
X-Rspamd-UID: c7a6c2

From: "Leon M. Busch-George" <leon@georgemail.eu>

Here is the definition of a mac that looks like its address would be
loaded from nvmem:

  mac@0 {
    compatible = "mediatek,eth-mac";
    reg = <0>;
    phy-mode = "2500base-x";
    phy-handle = <&rtl8221b_phy>;

    nvmem-cell-names = "mac-address";
    nvmem-cells = <&macaddr_bdinfo_de00 1>; /* this is ignored */
  };

Because the boot program inserts a 'local-mac-address', which is preferred
over other detection methods, the definition using nvmem is ignored.
By itself, that is only a mild annoyance when dealing with device trees.
After all, the 'local-mac-address' property exists primarily to pass MAC
addresses to the kernel.

But it is also possible for this address to be randomly generated (on each
boot), which turns an annoyance into a hindrance. In such a case, it is no
longer possible to set the correct address from the device tree. This
behaviour has been observed on two types of MT7981B devices from different
vendors (Cudy M3000, Yuncore AX835).

Restore the ability to set addresses through the device tree by adding an
option to ignore the 'local-mac-address' property.

Signed-off-by: Leon M. Busch-George <leon@georgemail.eu>
---
 net/core/of_net.c  | 18 ++++++++++--------
 net/ethernet/eth.c | 10 ++++++----
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/core/of_net.c b/net/core/of_net.c
index 93ea425b9248..4cf4171bc7fe 100644
--- a/net/core/of_net.c
+++ b/net/core/of_net.c
@@ -104,11 +104,11 @@ EXPORT_SYMBOL(of_get_mac_address_nvmem);
  *
  * Search the device tree for the best MAC address to use.  'mac-address' is
  * checked first, because that is supposed to contain to "most recent" MAC
- * address. If that isn't set, then 'local-mac-address' is checked next,
- * because that is the default address. If that isn't set, then the obsolete
- * 'address' is checked, just in case we're using an old device tree. If any
- * of the above isn't set, then try to get MAC address from nvmem cell named
- * 'mac-address'.
+ * address. If there is no valid 'mac-address' and `ignore-local-mac-address'
+ * isn't set, then 'local-mac-address' is checked next, because that is the
+ * default address. If that isn't set, then the obsolete * 'address' is
+ * checked, just in case we're using an old device tree. If any of the above
+ * isn't set, then try to get MAC address from nvmem cell named 'mac-address'.
  *
  * Note that the 'address' property is supposed to contain a virtual address of
  * the register set, but some DTS files have redefined that property to be the
@@ -134,9 +134,11 @@ int of_get_mac_address(struct device_node *np, u8 *addr)
 	if (!ret)
 		return 0;
 
-	ret = of_get_mac_addr(np, "local-mac-address", addr);
-	if (!ret)
-		return 0;
+	if (!of_find_property(np, "ignore-local-mac-address", NULL)) {
+		ret = of_get_mac_addr(np, "local-mac-address", addr);
+		if (!ret)
+			return 0;
+	}
 
 	ret = of_get_mac_addr(np, "address", addr);
 	if (!ret)
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 049c3adeb850..8f4efba90d96 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -582,9 +582,10 @@ static int fwnode_get_mac_addr(struct fwnode_handle *fwnode,
  *
  * Search the firmware node for the best MAC address to use.  'mac-address' is
  * checked first, because that is supposed to contain to "most recent" MAC
- * address. If that isn't set, then 'local-mac-address' is checked next,
- * because that is the default address.  If that isn't set, then the obsolete
- * 'address' is checked, just in case we're using an old device tree.
+ * address. If there is no valid 'mac-address' and `ignore-local-mac-address'
+ * isn't set, then 'local-mac-address' is checked next, because that is the
+ * default address. If that isn't set, then the obsolete 'address' is checked,
+ * just in case we're using an old device tree.
  *
  * Note that the 'address' property is supposed to contain a virtual address of
  * the register set, but some DTS files have redefined that property to be the
@@ -600,7 +601,8 @@ static int fwnode_get_mac_addr(struct fwnode_handle *fwnode,
 int fwnode_get_mac_address(struct fwnode_handle *fwnode, char *addr)
 {
 	if (!fwnode_get_mac_addr(fwnode, "mac-address", addr) ||
-	    !fwnode_get_mac_addr(fwnode, "local-mac-address", addr) ||
+	    (!fwnode_property_present(fwnode, "ignore-local-mac-address") &&
+	      !fwnode_get_mac_addr(fwnode, "local-mac-address", addr)) ||
 	    !fwnode_get_mac_addr(fwnode, "address", addr))
 		return 0;
 
-- 
2.44.0


