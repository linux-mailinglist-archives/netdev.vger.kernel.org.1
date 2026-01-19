Return-Path: <netdev+bounces-251257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16824D3B6C0
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1E06309564F
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C686F3904FB;
	Mon, 19 Jan 2026 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzq/p7an"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4744E3933E6
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849238; cv=none; b=suusE2jQ9xLhgLKBGNcD+ygRDi+Nqu/5AHzInc+MnDHuNDJM0tt7+jzQEHg8X/eAo+aLs4AXrSXkQ6b+oeLr6okkbh3TWsQm8s9gWdtDn6X7luUeBbbc9ZjRRdnAH+vHAH16EmT0SrTSF7SKqVxsF0xm+pXNEdShKe4Xa3uf44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849238; c=relaxed/simple;
	bh=eUk5NnrWGkTea+b0s8gPt/se8S4pLyFzQqyKQAYCcFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVtD1SLJZSB2I5Xrughv4NQuzkm9Tny5JGLHouw+P4rh9Dh9WpI77K3RVQzP7vUXon/o/LFNVO7aUrTytx8RiCnk9W2Zo6VGNkD69Oc/45mwRZhwDORN9P0V8ybAyU7BlGsUEyKMBV+0HPxj3Qu9Ycwu0DFbAVdlZQs8nXVCvF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jzq/p7an; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81e9d0cd082so3608868b3a.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 11:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768849230; x=1769454030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLDjO1BA4xRAZCOZPgoFOn1B18tvPgLyPShu1UdFGME=;
        b=Jzq/p7anfWDQaMK9UovkQlqbwTec96eGY09mHzasx1Ot9CMO6PwaPMy8zRsSRt/CAg
         ywJWLfC1uz2obbLgGHSDozcVxAluvTc0EhPwR7GK/OcQ6YFNSkY8MtGm26wuaTnnHqAh
         uwwDLd885Mf3aSc+Wp4ucrd0tBGYiW1MbVKVCcH4QVG/XZOOgfsc75vqISEU6DMyCFg0
         RtekCe16sV4R4G/jpi70djCS2HeoSkk0hDStYe06EUsHK9+y643S/92aKh3Vp/DeggC6
         2l6lKtwPHX5NTYBOhf0wp3sZSjHAkAk0mwjmBnxRnyxrj97eMU574+aYIq4jt6T+wcVm
         CFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768849230; x=1769454030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oLDjO1BA4xRAZCOZPgoFOn1B18tvPgLyPShu1UdFGME=;
        b=MO5OFlDIbWqGtlw4x4h4+jtp1xXV3I6+ryFMuw+k5HusqSX8aywC0+F9WkZyE0BMs+
         0UR3iNyfEdQ96+FBgqjkDCWeJTmcLehRvvNDkduX9oTAs915osLPNLHJtvhI3so/Q/0+
         FS4Xuf7QqE22Kk1b+NeQuBm0OlYarDai09v2yNmgxeRxN8y9M/C9ycwLEYdxBVqJsaTD
         Ua+a5uGnXt/UmYaIzCnIFf4GhRBF9HI9pXNpmTGmkQIQ+3LUikFT8CyqVA/dtWcD70Pk
         YeV+bBKi8cGVU5DY7+BsLZet5wMGPEy7ChMsnshfl2XJefAs55I9lDo3shPO9GwURVJV
         fERA==
X-Gm-Message-State: AOJu0Yzs8EyQvgUwruJbMYkcGdCZbSY/lCkJfbRyGtoNs3uFxLngNRfu
	s3pTQWv5YV4q9t2ZXDi2AyOtI83hOCAqnfNpXdNG9u7L92vXLrdHe/bjX+kIaA==
X-Gm-Gg: AY/fxX4zBFJGUa1e0Or/EaHGxCqKCW4GNlgxc5T8cODpZK28jhsUFolUjwO6eeyxnMl
	Ga/no/oGEq5G/ThNVs/mqqX8az/fWNlFMH7U9Av1wKwO6wzLRtoR1lSV5sLqtS5gPADrwNjUCrP
	Wqx8prfTSPthyJDveYk/yOw65u9+oi9oFAdksWPOZd8nqn5fzjhTaNsARV/ll/+1MD1mYQx2rL6
	PfERYi0NibbRLksm/wxzDCVvSkmvMbZ+6H/7Es8KFoRUgJw3j9jxbkq5QXvgo2xy5BHru2YDp8C
	CZe2biqqv+6x/ATrk5jxIjsHCUkU7UsWfgaMvYSQMq7cE6MSsIW3g3C7eyEG8ZU14lm9mjK+z5I
	AuxKKpk07ZQaOFM9lOWasedxyG3M/MHYTECLl60OFIYkdb8H4VvLU+7sbiLaPQyzITtdLet9Irw
	6ketJRU/Z/ueE573YpLs2fZPjhYPfKWkvaQsH4IA8hTZmWjy6srA==
X-Received: by 2002:a05:6a20:4321:b0:35e:6c3:c8d6 with SMTP id adf61e73a8af0-38e00d5c77emr11388890637.41.1768849230166;
        Mon, 19 Jan 2026 11:00:30 -0800 (PST)
Received: from d.home.mmyangfl.tk ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf354b24sm9677431a12.28.2026.01.19.11.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 11:00:29 -0800 (PST)
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
Subject: [PATCH net-next 2/2] net: dsa: yt921x: Add DCB/priority support
Date: Tue, 20 Jan 2026 02:59:30 +0800
Message-ID: <20260119185935.2072685-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119185935.2072685-1-mmyangfl@gmail.com>
References: <20260119185935.2072685-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set up global DSCP/PCP priority mappings and add related DSA methods.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/Kconfig  |   2 +
 drivers/net/dsa/yt921x.c | 232 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  54 +++++++--
 3 files changed, 278 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 7eb301fd987d..d73d7fa7f7d2 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -158,6 +158,8 @@ config NET_DSA_VITESSE_VSC73XX_PLATFORM
 config NET_DSA_YT921X
 	tristate "Motorcomm YT9215 ethernet switch chip support"
 	select NET_DSA_TAG_YT921X
+	select NET_IEEE8021Q_HELPERS
+	select DCB
 	help
 	  This enables support for the Motorcomm YT9215 ethernet switch
 	  chip.
diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 0b3df732c0d1..cf811545fb8b 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -18,8 +18,11 @@
 #include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
+#include <linux/sort.h>
 
 #include <net/dsa.h>
+#include <net/dscp.h>
+#include <net/ieee8021q.h>
 
 #include "yt921x.h"
 
@@ -2209,6 +2212,140 @@ yt921x_dsa_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 			port, res);
 }
 
+static int
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
+static int
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
+static const u8 yt921x_apps[] = {
+	0,	/* MAC SA */
+	0,	/* MAC DA */
+	0,	/* VID */
+	0,	/* ACL */
+	IEEE_8021QAZ_APP_SEL_DSCP,	/* DSCP */
+	DCB_APP_SEL_PCP,	/* CVLAN PCP */
+	0,	/* SVLAN PCP */
+	0,	/* Port */
+};
+
+static int appprios_cmp(const void *a, const void *b)
+{
+	return ((const u8 *)b)[1] - ((const u8 *)a)[1];
+}
+
+static int
+yt921x_dsa_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel,
+			     int *nselp)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	u8 appprios[ARRAY_SIZE(yt921x_apps)][2];
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
+	for (int src = 0; src < ARRAY_SIZE(yt921x_apps); src++) {
+		appprios[src][0] = yt921x_apps[src];
+		appprios[src][1] = (val >> (3 * src)) & 7;
+	}
+	sort(appprios, ARRAY_SIZE(appprios), sizeof(appprios[0]), appprios_cmp,
+	     NULL);
+
+	nsel = 0;
+	for (int i = 0; i < ARRAY_SIZE(appprios) && appprios[i][1]; i++)
+		if (appprios[i][0]) {
+			sel[nsel] = appprios[i][0];
+			nsel++;
+		}
+	*nselp = nsel;
+
+	return 0;
+}
+
+static int
+yt921x_dsa_port_set_apptrust(struct dsa_switch *ds, int port, const u8 *sel,
+			     int nsel)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	u8 prios[ARRAY_SIZE(yt921x_apps)] = {};
+	u32 ctrl;
+	u8 prio;
+	int res;
+
+	if (nsel > ARRAY_SIZE(yt921x_apps))
+		return -EINVAL;
+
+	/* always take the port prio (port_set_default_prio) into
+	 * consideration, by giving it the lowest priority
+	 */
+	prios[7] = 1;
+	prio = 7;
+	for (int i = 0; i < nsel; i++) {
+		bool found = false;
+
+		for (int src = 0; src < ARRAY_SIZE(yt921x_apps); src++) {
+			if (yt921x_apps[src] != sel[i])
+				continue;
+
+			prios[src] = prio;
+			prio--;
+			found = true;
+			break;
+		}
+
+		if (!found)
+			return -EOPNOTSUPP;
+	}
+
+	ctrl = 0;
+	for (int src = 0; src < ARRAY_SIZE(yt921x_apps); src++)
+		ctrl |= YT921X_PORT_PRIO_ORD_SRCm(src, prios[src]);
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
@@ -2577,6 +2714,58 @@ static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
 	return res;
 }
 
+#define ipm_drop(prio) \
+	YT921X_IPM_DROP_PRIO((prio) <= IEEE8021Q_TT_EE ? 2 : \
+			     (prio) <= IEEE8021Q_TT_VO ? 1 : 0)
+#define ipm_ctrl(prio) (YT921X_IPM_PRIO(prio) | ipm_drop(prio))
+
+static int
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
+static int
+yt921x_dsa_port_del_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_write(priv, YT921X_IPM_DSCPn(dscp),
+			       ipm_ctrl(IEEE8021Q_TT_BK));
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int
+yt921x_dsa_port_add_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	int res;
+
+	if (prio >= YT921X_PRIO_NUM)
+		return -EINVAL;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_write(priv, YT921X_IPM_DSCPn(dscp), ipm_ctrl(prio));
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
 static int yt921x_edata_wait(struct yt921x_priv *priv, u32 *valp)
 {
 	u32 val = YT921X_EDATA_DATA_IDLE;
@@ -2796,6 +2985,40 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
+	/* 802.1Q QoS to priority mapping table */
+	for (u8 pcp = 0; pcp < 8; pcp++) {
+		u32 drop = ipm_drop(pcp);
+
+		for (u8 dei = 0; dei < 2; dei++) {
+			ctrl = YT921X_IPM_PRIO(pcp);
+			if (!dei)
+				ctrl |= drop;
+			else
+				ctrl |= YT921X_IPM_DROP_PRIO(2);
+
+			for (u8 svlan = 0; svlan < 2; svlan++) {
+				u32 reg = YT921X_IPM_PCPn(svlan, dei, pcp);
+
+				res = yt921x_reg_write(priv, reg, ctrl);
+				if (res)
+					return res;
+			}
+		}
+	}
+
+	/* DSCP to priority mapping table */
+	for (u8 dscp = 0; dscp < DSCP_MAX; dscp++) {
+		int prio = ietf_dscp_to_ieee8021q_tt(dscp);
+
+		if (prio < 0)
+			return prio;
+
+		res = yt921x_reg_write(priv, YT921X_IPM_DSCPn(dscp),
+				       ipm_ctrl(prio));
+		if (res)
+			return res;
+	}
+
 	/* Miscellaneous */
 	res = yt921x_reg_set_bits(priv, YT921X_SENSOR, YT921X_SENSOR_TEMP);
 	if (res)
@@ -2902,10 +3125,19 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.port_mst_state_set	= yt921x_dsa_port_mst_state_set,
 	.vlan_msti_set		= yt921x_dsa_vlan_msti_set,
 	.port_stp_state_set	= yt921x_dsa_port_stp_state_set,
+	/* dcb */
+	.port_get_default_prio	= yt921x_dsa_port_get_default_prio,
+	.port_set_default_prio	= yt921x_dsa_port_set_default_prio,
+	.port_get_apptrust	= yt921x_dsa_port_get_apptrust,
+	.port_set_apptrust	= yt921x_dsa_port_set_apptrust,
 	/* port */
 	.get_tag_protocol	= yt921x_dsa_get_tag_protocol,
 	.phylink_get_caps	= yt921x_dsa_phylink_get_caps,
 	.port_setup		= yt921x_dsa_port_setup,
+	/* dscp */
+	.port_get_dscp_prio	= yt921x_dsa_port_get_dscp_prio,
+	.port_del_dscp_prio	= yt921x_dsa_port_del_dscp_prio,
+	.port_add_dscp_prio	= yt921x_dsa_port_add_dscp_prio,
 	/* chip */
 	.setup			= yt921x_dsa_setup,
 };
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 61bb0ab3b09a..1498ccdb3932 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -269,6 +269,37 @@
 #define YT921X_TPID_EGRn(x)		(0x100300 + 4 * (x))	/* [0, 3] */
 #define  YT921X_TPID_EGR_TPID_M			GENMASK(15, 0)
 
+#define YT921X_IPM_DSCPn(n)		(0x180000 + 4 * (n))	/* Internal Priority Map */
+#define YT921X_IPM_PCPn(map, dei, pcp)	(0x180100 + 4 * (16 * (map) + 8 * (dei) + (pcp)))
+#define  YT921X_IPM_PRIO_M			GENMASK(4, 2)
+#define   YT921X_IPM_PRIO(x)				FIELD_PREP(YT921X_IPM_PRIO_M, (x))
+#define  YT921X_IPM_DROP_PRIO_M			GENMASK(1, 0)
+#define   YT921X_IPM_DROP_PRIO(x)			FIELD_PREP(YT921X_IPM_DROP_PRIO_M, (x))
+#define YT921X_PORTn_QOS(port)		(0x180180 + 4 * (port))
+#define  YT921X_PORT_QOS_CVLAN_PRIO_MAP_SEL	BIT(5)
+#define  YT921X_PORT_QOS_SVLAN_PRIO_MAP_SEL	BIT(4)
+#define  YT921X_PORT_QOS_PRIO_M			GENMASK(3, 1)
+#define   YT921X_PORT_QOS_PRIO(x)			FIELD_PREP(YT921X_PORT_QOS_PRIO_M, (x))
+#define  YT921X_PORT_QOS_PRIO_EN			BIT(0)
+#define YT921X_PORTn_PRIO_ORD(port)	(0x180200 + 4 * (port))
+#define  YT921X_PORT_PRIO_ORD_SRCm_M(m)		GENMASK(3 * (m) + 2, 3 * (m))
+#define   YT921X_PORT_PRIO_ORD_SRCm(m, x)		((x) << (3 * (m)))
+#define  YT921X_PORT_PRIO_ORD_PORT_M		GENMASK(23, 21)
+#define   YT921X_PORT_PRIO_ORD_PORT(x)			FIELD_PREP(YT921X_PORT_PRIO_ORD_PORT_M, (x))
+#define  YT921X_PORT_PRIO_ORD_SVLAN_M		GENMASK(20, 18)
+#define   YT921X_PORT_PRIO_ORD_SVLAN(x)			FIELD_PREP(YT921X_PORT_PRIO_ORD_SVLAN_M, (x))
+#define  YT921X_PORT_PRIO_ORD_CVLAN_M		GENMASK(17, 15)
+#define   YT921X_PORT_PRIO_ORD_CVLAN(x)			FIELD_PREP(YT921X_PORT_PRIO_ORD_CVLAN_M, (x))
+#define  YT921X_PORT_PRIO_ORD_DSCP_M		GENMASK(14, 12)
+#define   YT921X_PORT_PRIO_ORD_DSCP(x)			FIELD_PREP(YT921X_PORT_PRIO_ORD_DSCP_M, (x))
+#define  YT921X_PORT_PRIO_ORD_ACL_M		GENMASK(11, 9)
+#define   YT921X_PORT_PRIO_ORD_ACL(x)			FIELD_PREP(YT921X_PORT_PRIO_ORD_ACL_M, (x))
+#define  YT921X_PORT_PRIO_ORD_VID_M		GENMASK(8, 6)
+#define   YT921X_PORT_PRIO_ORD_VID(x)			FIELD_PREP(YT921X_PORT_PRIO_ORD_VID_M, (x))
+#define  YT921X_PORT_PRIO_ORD_MAC_DA_M		GENMASK(5, 3)
+#define   YT921X_PORT_PRIO_ORD_MAC_DA(x)		FIELD_PREP(YT921X_PORT_PRIO_ORD_MAC_DA_M, (x))
+#define  YT921X_PORT_PRIO_ORD_MAC_SA_M		GENMASK(2, 0)
+#define   YT921X_PORT_PRIO_ORD_MAC_SA(x)		FIELD_PREP(YT921X_PORT_PRIO_ORD_MAC_SA_M, (x))
 #define YT921X_VLAN_IGR_FILTER		0x180280
 #define  YT921X_VLAN_IGR_FILTER_PORTn_BYPASS_IGMP(port)	BIT((port) + 11)
 #define  YT921X_VLAN_IGR_FILTER_PORTn(port)	BIT(port)
@@ -337,7 +368,7 @@
 #define YT921X_FDB_OUT0			0x1804b0
 #define  YT921X_FDB_IO0_ADDR_HI4_M		GENMASK(31, 0)
 #define YT921X_FDB_OUT1			0x1804b4
-#define  YT921X_FDB_IO1_EGR_INT_PRI_EN		BIT(31)
+#define  YT921X_FDB_IO1_EGR_PRIO_EN		BIT(31)
 #define  YT921X_FDB_IO1_STATUS_M		GENMASK(30, 28)
 #define   YT921X_FDB_IO1_STATUS(x)			FIELD_PREP(YT921X_FDB_IO1_STATUS_M, (x))
 #define   YT921X_FDB_IO1_STATUS_INVALID			YT921X_FDB_IO1_STATUS(0)
@@ -356,9 +387,9 @@
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
@@ -398,8 +429,9 @@
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
@@ -416,14 +448,14 @@
 #define  YT921X_PORT_IGR_TPIDn_CTAG(x)		BIT(x)
 
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
@@ -458,6 +490,8 @@ enum yt921x_fdb_entry_status {
 
 #define YT921X_MSTI_NUM		16
 
+#define YT921X_PRIO_NUM	8
+
 #define YT9215_MAJOR	0x9002
 #define YT9218_MAJOR	0x9001
 
-- 
2.51.0


