Return-Path: <netdev+bounces-253660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BxABsoeeGkKoQEAu9opvQ
	(envelope-from <netdev+bounces-253660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:11:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 803A18EE8C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 307233002E54
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 02:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCED12D73B5;
	Tue, 27 Jan 2026 02:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0aajvd3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C253D2D7DDD
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479764; cv=none; b=WfXNg3s5pM+rIp2aLC6aFvmQi1UDu2Nw/HR9yYqAQE8RMHS17797PQbeqS6Nuswmzbg8f+9LpJ9vrB33GJxvPkSSockItGRYv37nldOoraSyjiH+IDGo//aNCFQanycNhq4IiaSvihgdufQX8fYxLquc1LQgY1beDDIAQCX/gek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479764; c=relaxed/simple;
	bh=Bm9bRj8OGkXsxjvRTdCkznjsqkzjmpFFXIjUXWcI7O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bi+QrP91ccRjzq9PT2Rs0psD9c/cfbf5L0/2Hz5HD2Hn3QSdMd9ufZHnz6ySZxYyorex/Klltd8fRf8tz9VJAZ0ASeKttAG1EMsdtI8SbbGyt2taBQWrpBkCIYUozrmJjRRYSY+2qC+9wfbSNZuHt8+1hmgdzj9eXos13Td9/ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0aajvd3; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3532aa9a77eso2334232a91.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 18:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769479760; x=1770084560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfXyKfcUXIm04kvDDBIE4tsKOMPf0rdN8lz9+k00dGo=;
        b=X0aajvd3NBpFwgGY4qe7x9y765hOYL6YT9pjr2RUWb244w74/rltKbumsayfQkrZ+1
         uzVMT56+PJ8gcRcMsyWPuHqjZpslH5x05n/pCWJYq32HxvSXVHOEb+wZBa+LoXB1711G
         mWsZiFZXTQeS4zrAFou3BXaptRbS2QB0lazYXX/iCMqFrqcpfZUeeN5BRhGWcF4pqT9+
         kkTDHDLb8RD7NcLw/1qluyT/uzT06qFI7EYnFx+65Ba1KXwufC0SvUr8N7Vm+PZzR5+C
         XGPriypRv4uyXjrtCcKyCw2ZEaqYA9X9v4qErDp0yU24ddReWPkesJOvB+zc8F2CfNm0
         0f6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769479760; x=1770084560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cfXyKfcUXIm04kvDDBIE4tsKOMPf0rdN8lz9+k00dGo=;
        b=qmvEN5EQjZQftmYh13CulizzQ9NGG0ZtHpIzimnbMXCx4OPHPTJfHprwpbEzSjTN7q
         XbPGd2oPjEBbx4zxajpJEw9Wnzxj3UWx+wCeazW70q9tXutzoBoFgXoRQ0MO6NvCO9vN
         mv/OdG2vlJJ/Ze2AkgXiwCq+dU9HhGLImhMccXos3ghcixnzGiyaPhd3nolq1WCxvOHk
         FPwOQpoPevnjmwpsib8mS3UkkPpSwI2+aNxpsR8JedUJhD/zRcUykNFDufOSoHrb3Xpy
         7QGhhtL+EDunSf5j2Le2Pl2YuRKmgxnH3zcCfLuuhGHXMFRhIyOiHLx/C+bjNLoOnZGV
         y1tw==
X-Gm-Message-State: AOJu0YwN7zOqwXdWd4kSei8H23jsKtYwNFwN78vhyrWKKWHdWCGjBXZ7
	uwfOEXda3v29eZ6lOea/R4pqulxrCSazgGR90Le1uofPXLsB/DSVCjcc0nma8A==
X-Gm-Gg: AZuq6aLMUH3we/8os8VFvuVzQN8W3vZSam7gqP1wJIN3hxpnlm3eRFTbEZVclIPugaF
	seyan3seGEEmYXoFvtK81BuoBuGMB+KmSFjm+O+qTAuh1gXuPP0fkwvHwKQTlQDlbUW8sP4AWL+
	EXhCQeOqkaBmF0j1D47M9FqOWGpz5rg0wh22a9ATtzpgl7z0zPetqjQfH80MN4t6WJb/shaFXZt
	lXU/irQC8f9tchfLQeAlBwhG0UgJONtQ3eqMKxkET/bDKY10zgkWHvbT648aeB3u4hJBYlqEIZE
	vN7L+2kavnDrZ3ChzlCKptJLeoMghXeBqjIWjZNG6wMOA1YJzpCUO5SX5lUwFga7hIblbdIYD21
	QVBO/BKFqbR6iYFy37etqUPgYEZZUAvg05EKOqwt8HuNJe0pn9icGjT2+W+moNUL2iNrDori3Pw
	g39H41BDNC2Fhs//Yo049Ff8AAUdt9ojFYbkMHRoKmsk3jDHR3vHE9JNKd8fRfJrxc
X-Received: by 2002:a17:90b:57d0:b0:34c:3501:d11c with SMTP id 98e67ed59e1d1-353feda5540mr250569a91.37.1769479760153;
        Mon, 26 Jan 2026 18:09:20 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f613fc36sm693540a91.10.2026.01.26.18.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:09:19 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 4/4] net: dsa: yt921x: Add DCB/QoS support
Date: Tue, 27 Jan 2026 10:08:01 +0800
Message-ID: <20260127020847.1482724-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127020847.1482724-1-mmyangfl@gmail.com>
References: <20260127020847.1482724-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253660-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 803A18EE8C
X-Rspamd-Action: no action

Set up global DSCP/PCP priority mappings and add related DCB methods.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/Kconfig  |   1 +
 drivers/net/dsa/yt921x.c | 249 ++++++++++++++++++++++++++++++++++++++-
 drivers/net/dsa/yt921x.h |  55 +++++++--
 3 files changed, 294 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 7eb301fd987d..24c37cbf70d7 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -158,6 +158,7 @@ config NET_DSA_VITESSE_VSC73XX_PLATFORM
 config NET_DSA_YT921X
 	tristate "Motorcomm YT9215 ethernet switch chip support"
 	select NET_DSA_TAG_YT921X
+	select NET_IEEE8021Q_HELPERS if DCB
 	help
 	  This enables support for the Motorcomm YT9215 ethernet switch
 	  chip.
diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 9ac0e4e236c6..0383cc28ac67 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -8,6 +8,7 @@
  * Copyright (c) 2025 David Yang
  */
 
+#include <linux/dcbnl.h>
 #include <linux/etherdevice.h>
 #include <linux/if_bridge.h>
 #include <linux/if_hsr.h>
@@ -18,8 +19,11 @@
 #include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
+#include <linux/sort.h>
 
 #include <net/dsa.h>
+#include <net/dscp.h>
+#include <net/ieee8021q.h>
 
 #include "yt921x.h"
 
@@ -1773,8 +1777,11 @@ yt921x_port_set_vlan_aware(struct yt921x_priv *priv, int port, bool vlan_aware)
 {
 	u32 ctrl;
 
+	/* Abuse SVLAN for PCP parsing without polluting the FDB - it just works
+	 * despite YT921X_VLAN_CTRL_SVLAN_EN never being set
+	 */
 	if (!vlan_aware)
-		ctrl = 0;
+		ctrl = YT921X_PORT_IGR_TPIDn_STAG(0);
 	else
 		ctrl = YT921X_PORT_IGR_TPIDn_CTAG(0);
 	return yt921x_reg_write(priv, YT921X_PORTn_IGR_TPID(port), ctrl);
@@ -2396,6 +2403,122 @@ yt921x_dsa_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 			port, res);
 }
 
+static int __maybe_unused
+yt921x_dsa_port_get_default_prio(struct dsa_switch *ds, int port)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	u32 val;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_read(priv, YT921X_PORTn_QOS(port), &val);
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		return res;
+
+	return FIELD_GET(YT921X_PORT_QOS_PRIO_M, val);
+}
+
+static int __maybe_unused
+yt921x_dsa_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	u32 mask;
+	u32 ctrl;
+	int res;
+
+	if (prio >= YT921X_PRIO_NUM)
+		return -EINVAL;
+
+	mutex_lock(&priv->reg_lock);
+	mask = YT921X_PORT_QOS_PRIO_M | YT921X_PORT_QOS_PRIO_EN;
+	ctrl = YT921X_PORT_QOS_PRIO(prio) | YT921X_PORT_QOS_PRIO_EN;
+	res = yt921x_reg_update_bits(priv, YT921X_PORTn_QOS(port), mask, ctrl);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int __maybe_unused appprios_cmp(const void *a, const void *b)
+{
+	return ((const u8 *)b)[1] - ((const u8 *)a)[1];
+}
+
+static int __maybe_unused
+yt921x_dsa_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel,
+			     int *nselp)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	u8 appprios[2][2] = {};
+	int nsel;
+	u32 val;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_read(priv, YT921X_PORTn_PRIO_ORD(port), &val);
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		return res;
+
+	appprios[0][0] = IEEE_8021QAZ_APP_SEL_DSCP;
+	appprios[0][1] = (val >> (3 * YT921X_APP_SEL_DSCP)) & 7;
+	appprios[1][0] = DCB_APP_SEL_PCP;
+	appprios[1][1] = (val >> (3 * YT921X_APP_SEL_CVLAN_PCP)) & 7;
+	sort(appprios, ARRAY_SIZE(appprios), sizeof(appprios[0]), appprios_cmp,
+	     NULL);
+
+	nsel = 0;
+	for (int i = 0; i < ARRAY_SIZE(appprios) && appprios[i][1]; i++) {
+		sel[nsel] = appprios[i][0];
+		nsel++;
+	}
+	*nselp = nsel;
+
+	return 0;
+}
+
+static int __maybe_unused
+yt921x_dsa_port_set_apptrust(struct dsa_switch *ds, int port, const u8 *sel,
+			     int nsel)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	u32 ctrl;
+	int res;
+
+	if (nsel > YT921X_APP_SEL_NUM)
+		return -EINVAL;
+
+	ctrl = 0;
+	for (int i = 0; i < nsel; i++) {
+		switch (sel[i]) {
+		case IEEE_8021QAZ_APP_SEL_DSCP:
+			ctrl |= YT921X_PORT_PRIO_ORD_APPm(YT921X_APP_SEL_DSCP,
+							  7 - i);
+			break;
+		case DCB_APP_SEL_PCP:
+			ctrl |= YT921X_PORT_PRIO_ORD_APPm(YT921X_APP_SEL_CVLAN_PCP,
+							  7 - i);
+			ctrl |= YT921X_PORT_PRIO_ORD_APPm(YT921X_APP_SEL_SVLAN_PCP,
+							  7 - i);
+			break;
+		default:
+			dev_err(dev,
+				"Invalid apptrust selector (at %d-th). Supported: dscp, pcp\n",
+				i + 1);
+			return -EOPNOTSUPP;
+		}
+	}
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_write(priv, YT921X_PORTn_PRIO_ORD(port), ctrl);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
 static int yt921x_port_down(struct yt921x_priv *priv, int port)
 {
 	u32 mask;
@@ -2721,6 +2844,13 @@ static int yt921x_port_setup(struct yt921x_priv *priv, int port)
 	if (res)
 		return res;
 
+	/* Clear prio order (even if DCB is not enabled) to avoid unsolicited
+	 * priorities
+	 */
+	res = yt921x_reg_write(priv, YT921X_PORTn_PRIO_ORD(port), 0);
+	if (res)
+		return res;
+
 	if (dsa_is_cpu_port(ds, port)) {
 		/* Egress of CPU port is supposed to be completely controlled
 		 * via tagging, so set to oneway isolated (drop all packets
@@ -2764,6 +2894,66 @@ static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
 	return res;
 }
 
+/* Not "port" - DSCP mapping is global */
+static int __maybe_unused
+yt921x_dsa_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	u32 val;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_read(priv, YT921X_IPM_DSCPn(dscp), &val);
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		return res;
+
+	return FIELD_GET(YT921X_IPM_PRIO_M, val);
+}
+
+static int __maybe_unused
+yt921x_dsa_port_del_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	u32 val;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	/* During a "dcb app replace" command, the new app table entry will be
+	 * added first, then the old one will be deleted. But the hardware only
+	 * supports one QoS class per DSCP value (duh), so if we blindly delete
+	 * the app table entry for this DSCP value, we end up deleting the
+	 * entry with the new priority. Avoid that by checking whether user
+	 * space wants to delete the priority which is currently configured, or
+	 * something else which is no longer current.
+	 */
+	res = yt921x_reg_read(priv, YT921X_IPM_DSCPn(dscp), &val);
+	if (!res && FIELD_GET(YT921X_IPM_PRIO_M, val) == prio)
+		res = yt921x_reg_write(priv, YT921X_IPM_DSCPn(dscp),
+				       YT921X_IPM_PRIO(IEEE8021Q_TT_BK));
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int __maybe_unused
+yt921x_dsa_port_add_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	int res;
+
+	if (prio >= YT921X_PRIO_NUM)
+		return -EINVAL;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_write(priv, YT921X_IPM_DSCPn(dscp),
+			       YT921X_IPM_PRIO(prio));
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
 static int yt921x_edata_wait(struct yt921x_priv *priv, u32 *valp)
 {
 	u32 val = YT921X_EDATA_DATA_IDLE;
@@ -2976,6 +3166,43 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	return 0;
 }
 
+static int __maybe_unused yt921x_chip_setup_qos(struct yt921x_priv *priv)
+{
+	u32 ctrl;
+	int res;
+
+	/* 802.1Q QoS to internal priorities */
+	for (u8 pcp = 0; pcp < 8; pcp++)
+		for (u8 dei = 0; dei < 2; dei++) {
+			ctrl = YT921X_IPM_PRIO(pcp);
+			if (dei)
+				ctrl |= YT921X_IPM_COLOR_RED;
+
+			for (u8 svlan = 0; svlan < 2; svlan++) {
+				u32 reg = YT921X_IPM_PCPn(svlan, dei, pcp);
+
+				res = yt921x_reg_write(priv, reg, ctrl);
+				if (res)
+					return res;
+			}
+		}
+
+	/* DSCP to internal priorities */
+	for (u8 dscp = 0; dscp < DSCP_MAX; dscp++) {
+		int prio = ietf_dscp_to_ieee8021q_tt(dscp);
+
+		if (prio < 0)
+			return prio;
+
+		res = yt921x_reg_write(priv, YT921X_IPM_DSCPn(dscp),
+				       YT921X_IPM_PRIO(prio));
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
 static int yt921x_chip_setup(struct yt921x_priv *priv)
 {
 	u32 ctrl;
@@ -2990,6 +3217,12 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
+#if IS_ENABLED(CONFIG_DCB)
+	res = yt921x_chip_setup_qos(priv);
+	if (res)
+		return res;
+#endif
+
 	/* Clear MIB */
 	ctrl = YT921X_MIB_CTRL_CLEAN | YT921X_MIB_CTRL_ALL_PORT;
 	res = yt921x_reg_write(priv, YT921X_MIB_CTRL, ctrl);
@@ -3105,10 +3338,23 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.port_mst_state_set	= yt921x_dsa_port_mst_state_set,
 	.vlan_msti_set		= yt921x_dsa_vlan_msti_set,
 	.port_stp_state_set	= yt921x_dsa_port_stp_state_set,
+#if IS_ENABLED(CONFIG_DCB)
+	/* dcb */
+	.port_get_default_prio	= yt921x_dsa_port_get_default_prio,
+	.port_set_default_prio	= yt921x_dsa_port_set_default_prio,
+	.port_get_apptrust	= yt921x_dsa_port_get_apptrust,
+	.port_set_apptrust	= yt921x_dsa_port_set_apptrust,
+#endif
 	/* port */
 	.get_tag_protocol	= yt921x_dsa_get_tag_protocol,
 	.phylink_get_caps	= yt921x_dsa_phylink_get_caps,
 	.port_setup		= yt921x_dsa_port_setup,
+#if IS_ENABLED(CONFIG_DCB)
+	/* dscp */
+	.port_get_dscp_prio	= yt921x_dsa_port_get_dscp_prio,
+	.port_del_dscp_prio	= yt921x_dsa_port_del_dscp_prio,
+	.port_add_dscp_prio	= yt921x_dsa_port_add_dscp_prio,
+#endif
 	/* chip */
 	.setup			= yt921x_dsa_setup,
 };
@@ -3175,6 +3421,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 	ds = &priv->ds;
 	ds->dev = dev;
 	ds->assisted_learning_on_cpu_port = true;
+	ds->dscp_prio_mapping_is_global = true;
 	ds->priv = priv;
 	ds->ops = &yt921x_dsa_switch_ops;
 	ds->ageing_time_min = 1 * 5000;
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index bacd4ccaa8e5..3f129b8d403f 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -269,6 +269,38 @@
 #define YT921X_TPID_EGRn(x)		(0x100300 + 4 * (x))	/* [0, 3] */
 #define  YT921X_TPID_EGR_TPID_M			GENMASK(15, 0)
 
+#define YT921X_IPM_DSCPn(n)		(0x180000 + 4 * (n))	/* Internal Priority Map */
+#define YT921X_IPM_PCPn(map, dei, pcp)	(0x180100 + 4 * (16 * (map) + 8 * (dei) + (pcp)))
+#define  YT921X_IPM_PRIO_M			GENMASK(4, 2)
+#define   YT921X_IPM_PRIO(x)				FIELD_PREP(YT921X_IPM_PRIO_M, (x))
+#define  YT921X_IPM_COLOR_M			GENMASK(1, 0)
+#define   YT921X_IPM_COLOR(x)				FIELD_PREP(YT921X_IPM_COLOR_M, (x))
+#define   YT921X_IPM_COLOR_GREEN			YT921X_IPM_COLOR(0)
+#define   YT921X_IPM_COLOR_YELLOW			YT921X_IPM_COLOR(1)
+#define   YT921X_IPM_COLOR_RED				YT921X_IPM_COLOR(2)
+#define YT921X_PORTn_QOS(port)		(0x180180 + 4 * (port))
+#define  YT921X_PORT_QOS_CVLAN_PRIO_MAP_ID	BIT(5)
+#define  YT921X_PORT_QOS_SVLAN_PRIO_MAP_ID	BIT(4)
+#define  YT921X_PORT_QOS_PRIO_M			GENMASK(3, 1)
+#define   YT921X_PORT_QOS_PRIO(x)			FIELD_PREP(YT921X_PORT_QOS_PRIO_M, (x))
+#define  YT921X_PORT_QOS_PRIO_EN		BIT(0)
+#define YT921X_PORTn_PRIO_ORD(port)	(0x180200 + 4 * (port))
+#define  YT921X_PORT_PRIO_ORD_APPm_M(m)		GENMASK(3 * (m) + 2, 3 * (m))
+#define   YT921X_PORT_PRIO_ORD_APPm(m, x)		((x) << (3 * (m)))	/* 0: disabled, except PORT_QOS_PRIO */
+
+enum yt921x_app_selector {
+	YT921X_APP_SEL_MAC_SA,
+	YT921X_APP_SEL_MAC_DA,
+	YT921X_APP_SEL_VID,
+	YT921X_APP_SEL_ACL,
+	YT921X_APP_SEL_DSCP,
+	YT921X_APP_SEL_CVLAN_PCP,
+	YT921X_APP_SEL_SVLAN_PCP,
+	/* The physical port, i.e. YT921X_PORT_QOS_PRIO */
+	YT921X_APP_SEL_PORT,
+	YT921X_APP_SEL_NUM
+};
+
 #define YT921X_VLAN_IGR_FILTER		0x180280
 #define  YT921X_VLAN_IGR_FILTER_PORTn_BYPASS_IGMP(port)	BIT((port) + 11)
 #define  YT921X_VLAN_IGR_FILTER_PORTn(port)	BIT(port)
@@ -337,7 +369,7 @@
 #define YT921X_FDB_OUT0			0x1804b0
 #define  YT921X_FDB_IO0_ADDR_HI4_M		GENMASK(31, 0)
 #define YT921X_FDB_OUT1			0x1804b4
-#define  YT921X_FDB_IO1_EGR_INT_PRI_EN		BIT(31)
+#define  YT921X_FDB_IO1_EGR_PRIO_EN		BIT(31)
 #define  YT921X_FDB_IO1_STATUS_M		GENMASK(30, 28)
 #define   YT921X_FDB_IO1_STATUS(x)			FIELD_PREP(YT921X_FDB_IO1_STATUS_M, (x))
 #define   YT921X_FDB_IO1_STATUS_INVALID			YT921X_FDB_IO1_STATUS(0)
@@ -356,9 +388,9 @@
 #define   YT921X_FDB_IO2_EGR_PORTS(x)			FIELD_PREP(YT921X_FDB_IO2_EGR_PORTS_M, (x))
 #define  YT921X_FDB_IO2_EGR_DROP		BIT(17)
 #define  YT921X_FDB_IO2_COPY_TO_CPU		BIT(16)
-#define  YT921X_FDB_IO2_IGR_INT_PRI_EN		BIT(15)
-#define  YT921X_FDB_IO2_INT_PRI_M		GENMASK(14, 12)
-#define   YT921X_FDB_IO2_INT_PRI(x)			FIELD_PREP(YT921X_FDB_IO2_INT_PRI_M, (x))
+#define  YT921X_FDB_IO2_IGR_PRIO_EN		BIT(15)
+#define  YT921X_FDB_IO2_PRIO_M			GENMASK(14, 12)
+#define   YT921X_FDB_IO2_PRIO(x)			FIELD_PREP(YT921X_FDB_IO2_PRIO_M, (x))
 #define  YT921X_FDB_IO2_NEW_VID_M		GENMASK(11, 0)
 #define   YT921X_FDB_IO2_NEW_VID(x)			FIELD_PREP(YT921X_FDB_IO2_NEW_VID_M, (x))
 #define YT921X_FILTER_UNK_UCAST		0x180508
@@ -406,8 +438,9 @@
 #define  YT921X_VLAN_CTRL_FID_M			GENMASK_ULL(34, 23)
 #define   YT921X_VLAN_CTRL_FID(x)			FIELD_PREP(YT921X_VLAN_CTRL_FID_M, (x))
 #define  YT921X_VLAN_CTRL_LEARN_DIS		BIT_ULL(22)
-#define  YT921X_VLAN_CTRL_INT_PRI_EN		BIT_ULL(21)
-#define  YT921X_VLAN_CTRL_INT_PRI_M		GENMASK_ULL(20, 18)
+#define  YT921X_VLAN_CTRL_PRIO_EN		BIT_ULL(21)
+#define  YT921X_VLAN_CTRL_PRIO_M		GENMASK_ULL(20, 18)
+#define   YT921X_VLAN_CTRL_PRIO(x)			FIELD_PREP(YT921X_VLAN_CTRL_PRIO_M, (x))
 #define  YT921X_VLAN_CTRL_PORTS_M		GENMASK_ULL(17, 7)
 #define   YT921X_VLAN_CTRL_PORTS(x)			FIELD_PREP(YT921X_VLAN_CTRL_PORTS_M, (x))
 #define  YT921X_VLAN_CTRL_PORTn(port)		BIT_ULL((port) + 7)
@@ -433,14 +466,14 @@
 #define  YT921X_LAG_HASH_SRC_PORT		BIT(0)
 
 #define YT921X_PORTn_VLAN_CTRL(port)	(0x230010 + 4 * (port))
-#define  YT921X_PORT_VLAN_CTRL_SVLAN_PRI_EN	BIT(31)
-#define  YT921X_PORT_VLAN_CTRL_CVLAN_PRI_EN	BIT(30)
+#define  YT921X_PORT_VLAN_CTRL_SVLAN_PRIO_EN	BIT(31)
+#define  YT921X_PORT_VLAN_CTRL_CVLAN_PRIO_EN	BIT(30)
 #define  YT921X_PORT_VLAN_CTRL_SVID_M		GENMASK(29, 18)
 #define   YT921X_PORT_VLAN_CTRL_SVID(x)			FIELD_PREP(YT921X_PORT_VLAN_CTRL_SVID_M, (x))
 #define  YT921X_PORT_VLAN_CTRL_CVID_M		GENMASK(17, 6)
 #define   YT921X_PORT_VLAN_CTRL_CVID(x)			FIELD_PREP(YT921X_PORT_VLAN_CTRL_CVID_M, (x))
-#define  YT921X_PORT_VLAN_CTRL_SVLAN_PRI_M	GENMASK(5, 3)
-#define  YT921X_PORT_VLAN_CTRL_CVLAN_PRI_M	GENMASK(2, 0)
+#define  YT921X_PORT_VLAN_CTRL_SVLAN_PRIO_M	GENMASK(5, 3)
+#define  YT921X_PORT_VLAN_CTRL_CVLAN_PRIO_M	GENMASK(2, 0)
 #define YT921X_PORTn_VLAN_CTRL1(port)	(0x230080 + 4 * (port))
 #define  YT921X_PORT_VLAN_CTRL1_VLAN_RANGE_EN	BIT(8)
 #define  YT921X_PORT_VLAN_CTRL1_VLAN_RANGE_PROFILE_ID_M	GENMASK(7, 4)
@@ -478,6 +511,8 @@ enum yt921x_fdb_entry_status {
 #define YT921X_LAG_NUM		2
 #define YT921X_LAG_PORT_NUM	4
 
+#define YT921X_PRIO_NUM	8
+
 #define YT9215_MAJOR	0x9002
 #define YT9218_MAJOR	0x9001
 
-- 
2.51.0


