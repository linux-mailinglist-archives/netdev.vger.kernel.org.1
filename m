Return-Path: <netdev+bounces-255325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KCsKHBnfWknSAIAu9opvQ
	(envelope-from <netdev+bounces-255325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:22:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40832C0448
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38CA130226A1
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08A42FB983;
	Sat, 31 Jan 2026 02:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSmLlzge"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2F935958
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769825969; cv=none; b=sgOf6ryPESkQ1VLFmxxLYFamEg/KFHou8UZDJD2kbeK+QM7G5oGIvLizruw1rA0baGPch3LDJAjVH/N6VTUCd+WJ9qfOO19qFm07CCcl4WFVs0uWah0qgZz18EcYdwRFCXUJsVBBXZ2s6YWJLHlT7p/etGJiu1YB8g7dq6kRBWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769825969; c=relaxed/simple;
	bh=sgh7hJVNFhCTfTrRbb4EG9cbyAS1H8ZBeLSD1XNo5Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHClKOfJbwuVq8/putQ+c+Zfa8RX8bRe+lCD8UzcyuekNcFOUcMIY3cyAP9dG6TmtZtYxcG+RXezB9qwy+ArmLkBK8IPJZ95bkfbwiUyS6JqEQkEha2EbfgmdgZeWJU2EMxNxbbryo6Sc73aRPqzsSSkfL/QUEYNtow+AsV0Zt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSmLlzge; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a7a23f5915so18043165ad.2
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 18:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769825967; x=1770430767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJxnT9j9UIq74UGQNxKGzKMBh+ob/VDSHrb2m9J27Hg=;
        b=XSmLlzgeqcYuFjUy5XZOcoa33UgzmnAMyPgKSvcohnn/kpo81CbYh6vIHnBsU/eM21
         wxBeU3iJEPrCHoUDrU09m7fGvG/2pdRAvlqSIqsgHGxnsgCTQ2QJ2LixATaSaGrqBsIl
         ISCngrSUFcy8sdRkpsZuNv+p1+d2lqYmJmzc+/EqLt1IaA7IJLrR1GlhzZTMU3SRktMT
         bShzynRDXkIoNZsJHcHe2qcl1zXLeaw2KZNNltPZR3qunWz1qz2PxCfGltIlcvSCyBTm
         t+Ata5gBtgt7nvnavoJr4UQ7BT+QRznYeUi/ESSluuaLJNdrWAnDse6S57sfRuQS6Hee
         3khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769825967; x=1770430767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YJxnT9j9UIq74UGQNxKGzKMBh+ob/VDSHrb2m9J27Hg=;
        b=m777Arr3tbmEjYmg9hqsZftXAAR5oB+idP4RTw0x7e0X8zbt+W3dM4+KvoPJNBvEyN
         ERnY18rK5APds7eEW0/MGO+eXM3ckxS1Ebip0KN4Z5K9VZBYJ7KNQ+fungpstmcUK758
         D6n9/m6hr/abzQdv9b2lm6pA6WygjSD4MZihgX471wPxQxAkVUJDZuxmb9SLBsvwI7+f
         gu6H28Wfnvt19uz+c/XDhF3h7L/7iMOW4B4i3sHXScgANon40hwwa339fKiyWzC9twxS
         p8kwr95LeavbH2EzjBZZrFkJSxHU+8/d8a2xmZqKH0nNXe4gk+gFKvACd73ivmZpkgji
         jMPQ==
X-Gm-Message-State: AOJu0YxjPMBUDK8vSwa6uVm1EVKPPFxZhaSJQq5mlI24vWG/KQV1pLbY
	B3m5o/JLlvlDvkSTPoMKkbhMLg9ixgPOLOLFtmlbpu2F4H0Sv0G2e8dSyeyXFA==
X-Gm-Gg: AZuq6aJMRMGIeDl59QB4eUWuqfNv/F8Dwfodk1iXgod59FZbaaTM7wQf6Q7VZB3FQFs
	D0OaDsDE8po8dcQ6mcIjbIt5Uq5PkHSmzEiaQzLjEbPw15p9x0nAz8I61ylLuP7PbQ+DY+nZnkr
	c2JIKgJsey0+o/sxUF9qRVKXABll4qfLDfixon7GypGjws8ux/6CNWbKm5dLYor55+cT9ZE0Cbx
	UYupVPMuzmaFzZfl69B+dz+ev3Tv1ZKLE/5ipHy0NyPiU1uBjtHZUMGvAyjMUtOdygRFPAoNIPB
	lEzgi1kNTMsNkDJG2DEef417gcVBnHlzqKh/HD7yG1/8rSs5Tv8tHa5N1CkQs1KvQLtUqJew5TK
	RZhoJr+R7vJu+aGTYFBV3hz9k1nWpq1qoWWcg6J/ps/KEFD3JwwhpTGLhLTWM0U7NODVu8BCVHP
	btseoDxvkfoH6rr3dqA/mnQGZ8DQuO5Ew4qGo=
X-Received: by 2002:a17:903:41d2:b0:2a7:63e4:b1aa with SMTP id d9443c01a7336-2a8d991a634mr56510565ad.35.1769825967283;
        Fri, 30 Jan 2026 18:19:27 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2a09:bac1:7680:d30::4:384])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eeebcsm83427365ad.10.2026.01.30.18.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 18:19:26 -0800 (PST)
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
Subject: [PATCH net-next v6 5/5] net: dsa: yt921x: Add DCB/QoS support
Date: Sat, 31 Jan 2026 10:18:51 +0800
Message-ID: <20260131021854.3405036-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131021854.3405036-1-mmyangfl@gmail.com>
References: <20260131021854.3405036-1-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-255325-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40832C0448
X-Rspamd-Action: no action

Set up global DSCP/PCP priority mappings and add related DCB methods.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/Kconfig  |   1 +
 drivers/net/dsa/yt921x.c | 253 ++++++++++++++++++++++++++++++++++++++-
 drivers/net/dsa/yt921x.h |  55 +++++++--
 3 files changed, 298 insertions(+), 11 deletions(-)

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
index 3128fe97b50f..98e8915dd6c2 100644
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
 
@@ -1774,8 +1778,11 @@ yt921x_vlan_aware_set(struct yt921x_priv *priv, int port, bool vlan_aware)
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
@@ -2976,6 +3166,47 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	return 0;
 }
 
+static int __maybe_unused yt921x_chip_setup_qos(struct yt921x_priv *priv)
+{
+	u32 ctrl;
+	int res;
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
+	/* 802.1Q QoS to internal priorities */
+	for (u8 pcp = 0; pcp < 8; pcp++)
+		for (u8 dei = 0; dei < 2; dei++) {
+			ctrl = YT921X_IPM_PRIO(pcp);
+			if (dei)
+				/* "Red" almost means drop, so it's not that
+				 * useful. Note that tc police does not support
+				 * Three-Color very well
+				 */
+				ctrl |= YT921X_IPM_COLOR_YELLOW;
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
+	return 0;
+}
+
 static int yt921x_chip_setup(struct yt921x_priv *priv)
 {
 	u32 ctrl;
@@ -2990,6 +3221,12 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
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
@@ -3105,10 +3342,23 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
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
@@ -3175,6 +3425,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
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


