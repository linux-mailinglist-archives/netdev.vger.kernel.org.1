Return-Path: <netdev+bounces-122845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0342F962C40
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 17:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853D81F23D84
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DBF1A7079;
	Wed, 28 Aug 2024 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Um+NmXV5"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1391A38D2;
	Wed, 28 Aug 2024 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858725; cv=none; b=dK8ys7u4XYgrZDTwLG+/WATBFgox4Lj52GFM7Zl5Op42NqXHrw+MjTP2nZibuMzDEMIAwckGhpvb3bTHNxl9JxM89Fz+lN37wKkbNFWFle9KqnvUyowZ77CJ6ssleyzI4Ry+5JvOIJaToPnelAK4tAwA+FJzh/SOkUU2m4iQ1ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858725; c=relaxed/simple;
	bh=XOnIHnAzGcvNb3/+PxifdldPSqUMn6wKk1c79lS1uzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPVhFR4q/e7TY1wgDcI1aWzk704+7P8RhyhRwgdPu2iBxAkrloDCY56Kswfqs0LSKZKQwdkt0dt6AGx5RcmRvtrHWB9jaie3GD33aYMWiqjQqMjAgv7s6SKS51h8eLiiHmz+txP1DKa8o3GWtD9XOVtoBFLmQ+UvVCO5e9JsgWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Um+NmXV5; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 004E0FF80D;
	Wed, 28 Aug 2024 15:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724858721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KzQLVkiBNJvK6DrODMY4izWhDhtO/PtQ39gm230BHl0=;
	b=Um+NmXV55A/neplMEEXXY4uaOf0dg9iKvPih+wFYKjhAtlMEJc2crS7tOgG+Q+FxlFLQE3
	dsy/K7C7zEfDuO9+aYSuuKGRUCMkNzYIqnbQE+il8Iupim0D0WfNHNPTT3Zq/vwY1YnwJb
	X399W2pzOQrEaQBBnGpb2Txq9fleB1joBzq0LAT8h9bDVS8HeXqAblGJY0FC32frDzVSQx
	7MjzL/xkOe5bfT8ndzc7HkUPeT38j8puXeDTD7bxtOj8bjn185wtAiKwSeUHDE1rvv+fE5
	I1XWzXuj47mjtdu0bbWEZ806teLClE+RijOlnES4/hhPX0oKmaJ5NUhgLSskvQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Michal Kubecek <mkubecek@suse.cz>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH ethtool-next v2 3/3] ethtool: Introduce a command to list PHYs
Date: Wed, 28 Aug 2024 17:25:10 +0200
Message-ID: <20240828152511.194453-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828152511.194453-1-maxime.chevallier@bootlin.com>
References: <20240828152511.194453-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

It is now possible to list all Ethernet PHYs that are present behind a
given interface, since the following linux commit :
63d5eaf35ac3 ("net: ethtool: Introduce a command to list PHYs on an interface")

This command relies on the netlink DUMP command to list them, by allowing to
pass an interface name/id as a parameter in the DUMP request to only
list PHYs on one interface.

Therefore, we introduce a new helper function to prepare a interface-filtered
dump request (the filter can be empty, to perform an unfiltered dump),
and then uses it to implement PHY enumeration through the --show-phys
command.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Makefile.am      |   1 +
 ethtool.8.in     |  36 +++++++++++++++
 ethtool.c        |   5 ++
 netlink/extapi.h |   1 +
 netlink/nlsock.c |  37 +++++++++++++++
 netlink/nlsock.h |   2 +
 netlink/phy.c    | 116 +++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 198 insertions(+)
 create mode 100644 netlink/phy.c

diff --git a/Makefile.am b/Makefile.am
index 5a61a9a..862886b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -48,6 +48,7 @@ ethtool_SOURCES += \
 		  netlink/desc-rtnl.c netlink/cable_test.c netlink/tunnels.c \
 		  netlink/plca.c \
 		  netlink/pse-pd.c \
+		  netlink/phy.c \
 		  uapi/linux/ethtool_netlink.h \
 		  uapi/linux/netlink.h uapi/linux/genetlink.h \
 		  uapi/linux/rtnetlink.h uapi/linux/if_link.h \
diff --git a/ethtool.8.in b/ethtool.8.in
index a455b5d..816ac22 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -547,6 +547,9 @@ ethtool \- query or control network driver and hardware settings
 .IR FILE
 .RB [ pass
 .IR PASS ]
+.HP
+.B ethtool \-\-show\-phys
+.I devname
 .
 .\" Adjust lines (i.e. full justification) and hyphenate.
 .ad
@@ -1822,6 +1825,39 @@ is downloaded to the transceiver module, validated, run and committed.
 Optional transceiver module password that might be required as part of the
 transceiver module firmware update process.
 
+.RE
+.TP
+.B \-\-show\-phys
+Show the PHY devices attached to an interface, and the way they link together.
+.RS 4
+.TP
+.B phy_index
+The PHY's index, that identifies it within the network interface. If the
+interface has multiple PHYs, they will each have a unique index on that
+interface. This index can then be used for commands that targets PHYs.
+.TP
+.B drvname
+The name of the driver bound to this PHY device.
+.TP
+.B name
+The PHY's device name, matching the name found in sysfs.
+.TP
+.B downstream_sfp_name
+If the PHY drives an SFP cage, this field contains the name of the associated
+SFP bus.
+.TP
+.B upstream_type \ mac | phy
+Indicates the nature of the device the PHY is attached to.
+.TP
+.B upstream_index
+If the PHY's upstream_type is
+.B phy
+, this field indicates the phy_index of the upstream phy.
+.TP
+.B upstream_sfp_name
+If the PHY is withing an SFP/SFF module, this field contains the name of the
+upstream SFP bus.
+
 .SH BUGS
 Not supported (in part or whole) on all network drivers.
 .SH AUTHOR
diff --git a/ethtool.c b/ethtool.c
index 3bd777e..3591767 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6254,6 +6254,11 @@ static const struct option args[] = {
 		.xhelp	= "		file FILE\n"
 			  "		[ pass PASS ]\n"
 	},
+	{
+		.opts	= "--show-phys",
+		.nlfunc	= nl_get_phy,
+		.help	= "List PHYs"
+	},
 	{
 		.opts	= "-h|--help",
 		.no_dev	= true,
diff --git a/netlink/extapi.h b/netlink/extapi.h
index c882295..fd99610 100644
--- a/netlink/extapi.h
+++ b/netlink/extapi.h
@@ -56,6 +56,7 @@ int nl_set_mm(struct cmd_context *ctx);
 int nl_gpse(struct cmd_context *ctx);
 int nl_spse(struct cmd_context *ctx);
 int nl_flash_module_fw(struct cmd_context *ctx);
+int nl_get_phy(struct cmd_context *ctx);
 
 void nl_monitor_usage(void);
 
diff --git a/netlink/nlsock.c b/netlink/nlsock.c
index 0b873a3..5450c9b 100644
--- a/netlink/nlsock.c
+++ b/netlink/nlsock.c
@@ -298,6 +298,43 @@ int nlsock_prep_get_request(struct nl_socket *nlsk, unsigned int nlcmd,
 	return 0;
 }
 
+/**
+ * nlsock_prep_filtered_dump_request() - Initialize a filtered DUMP request
+ * @nlsk: netlink socket
+ * @nlcmd: netlink command
+ * @hdr_attrtype: netlink command header attribute
+ * @flags: netlink command header flags
+ *
+ * Prepare a DUMP request that may include the device index as a filtering
+ * attribute in the header.
+ *
+ * Return: 0 on success, or a negative number on error
+ */
+int nlsock_prep_filtered_dump_request(struct nl_socket *nlsk,
+				      unsigned int nlcmd, uint16_t hdr_attrtype,
+				      u32 flags)
+{
+	struct nl_context *nlctx = nlsk->nlctx;
+	const char *devname = nlctx->ctx->devname;
+	unsigned int nlm_flags;
+	int ret;
+
+	nlctx->is_dump = true;
+	nlm_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_DUMP;
+
+	if (devname && !strcmp(devname, WILDCARD_DEVNAME))
+		devname = NULL;
+
+	ret = msg_init(nlctx, &nlsk->msgbuff, nlcmd, nlm_flags);
+	if (ret < 0)
+		return ret;
+
+	if (ethnla_fill_header(&nlsk->msgbuff, hdr_attrtype, devname, flags))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 #ifndef TEST_ETHTOOL
 /**
  * nlsock_sendmsg() - send a netlink message to kernel
diff --git a/netlink/nlsock.h b/netlink/nlsock.h
index b015f86..6a72966 100644
--- a/netlink/nlsock.h
+++ b/netlink/nlsock.h
@@ -38,6 +38,8 @@ int nlsock_init(struct nl_context *nlctx, struct nl_socket **__nlsk,
 void nlsock_done(struct nl_socket *nlsk);
 int nlsock_prep_get_request(struct nl_socket *nlsk, unsigned int nlcmd,
 			    uint16_t hdr_attrtype, u32 flags);
+int nlsock_prep_filtered_dump_request(struct nl_socket *nlsk, unsigned int nlcmd,
+				      uint16_t hdr_attrtype, u32 flags);
 ssize_t nlsock_sendmsg(struct nl_socket *nlsk, struct nl_msg_buff *__msgbuff);
 int nlsock_send_get_request(struct nl_socket *nlsk, mnl_cb_t cb);
 int nlsock_process_reply(struct nl_socket *nlsk, mnl_cb_t reply_cb, void *data);
diff --git a/netlink/phy.c b/netlink/phy.c
new file mode 100644
index 0000000..7578191
--- /dev/null
+++ b/netlink/phy.c
@@ -0,0 +1,116 @@
+/*
+ * phy.c - List PHYs on an interface and their parameters
+ *
+ * Implementation of "ethtool --show-phys <dev>"
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include <string.h>
+#include <stdio.h>
+
+#include "../internal.h"
+#include "../common.h"
+#include "netlink.h"
+
+/* PHY_GET / PHY_DUMP */
+
+static const char * phy_upstream_type_to_str(uint8_t upstream_type)
+{
+	switch (upstream_type) {
+	case PHY_UPSTREAM_PHY: return "phy";
+	case PHY_UPSTREAM_MAC: return "mac";
+	default: return "Unknown";
+	}
+}
+
+int phy_reply_cb(const struct nlmsghdr *nlhdr, void *data)
+{
+	const struct nlattr *tb[ETHTOOL_A_PHY_MAX + 1] = {};
+	struct nl_context *nlctx = data;
+	DECLARE_ATTR_TB_INFO(tb);
+	uint8_t upstream_type;
+	bool silent;
+	int err_ret;
+	int ret;
+
+	silent = nlctx->is_dump || nlctx->is_monitor;
+	err_ret = silent ? MNL_CB_OK : MNL_CB_ERROR;
+	ret = mnl_attr_parse(nlhdr, GENL_HDRLEN, attr_cb, &tb_info);
+	if (ret < 0)
+		return err_ret;
+	nlctx->devname = get_dev_name(tb[ETHTOOL_A_PHY_HEADER]);
+	if (!dev_ok(nlctx))
+		return err_ret;
+
+	if (silent)
+		print_nl();
+
+	open_json_object(NULL);
+
+	print_string(PRINT_ANY, "ifname", "PHY for %s:\n", nlctx->devname);
+
+	show_u32("phy_index", "PHY index: ", tb[ETHTOOL_A_PHY_INDEX]);
+
+	if (tb[ETHTOOL_A_PHY_DRVNAME])
+		print_string(PRINT_ANY, "drvname", "Driver name: %s\n",
+		     mnl_attr_get_str(tb[ETHTOOL_A_PHY_DRVNAME]));
+
+	if (tb[ETHTOOL_A_PHY_NAME])
+		print_string(PRINT_ANY, "name", "PHY device name: %s\n",
+		     mnl_attr_get_str(tb[ETHTOOL_A_PHY_NAME]));
+
+	if (tb[ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME])
+		print_string(PRINT_ANY, "downstream_sfp_name",
+			     "Downstream SFP bus name: %s\n",
+			     mnl_attr_get_str(tb[ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME]));
+
+	if (tb[ETHTOOL_A_PHY_UPSTREAM_TYPE]) {
+		upstream_type = mnl_attr_get_u8(tb[ETHTOOL_A_PHY_UPSTREAM_TYPE]);
+		print_string(PRINT_ANY, "upstream_type", "Upstream type: %s\n",
+			     phy_upstream_type_to_str(upstream_type));
+	}
+
+	if (tb[ETHTOOL_A_PHY_UPSTREAM_INDEX])
+		show_u32("upstream_index", "Upstream PHY index: ",
+			 tb[ETHTOOL_A_PHY_UPSTREAM_INDEX]);
+
+	if (tb[ETHTOOL_A_PHY_UPSTREAM_SFP_NAME])
+		print_string(PRINT_ANY, "upstream_sfp_name", "Upstream SFP name: %s\n",
+			     mnl_attr_get_str(tb[ETHTOOL_A_PHY_UPSTREAM_SFP_NAME]));
+
+	if (!silent)
+		print_nl();
+
+	close_json_object();
+
+	return MNL_CB_OK;
+
+	close_json_object();
+	return err_ret;
+}
+
+int nl_get_phy(struct cmd_context *ctx)
+{
+	struct nl_context *nlctx = ctx->nlctx;
+	struct nl_socket *nlsk = nlctx->ethnl_socket;
+	int ret;
+
+	if (netlink_cmd_check(ctx, ETHTOOL_MSG_PHY_GET, true))
+		return -EOPNOTSUPP;
+	if (ctx->argc > 0) {
+		fprintf(stderr, "ethtool: unexpected parameter '%s'\n",
+			*ctx->argp);
+		return 1;
+	}
+
+	ret = nlsock_prep_filtered_dump_request(nlsk, ETHTOOL_MSG_PHY_GET,
+						ETHTOOL_A_PHY_HEADER, 0);
+	if (ret)
+		return ret;
+
+	new_json_obj(ctx->json);
+	ret = nlsock_send_get_request(nlsk, phy_reply_cb);
+	delete_json_obj();
+	return ret;
+}
-- 
2.45.2


