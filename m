Return-Path: <netdev+bounces-292758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I5eHHhsGGrpjwgAu9opvQ
	(envelope-from <netdev+bounces-292758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:25:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C25DB5F4F50
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDC3C3134050
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D21A3FD943;
	Thu, 28 May 2026 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gE6ni/Eh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BBA3FCB22;
	Thu, 28 May 2026 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984582; cv=none; b=HTKueTOp+qUZjU69tvnEcxRSnjIll0NcoSP5tM5EQJBJefuf4TqZgv94pOC2zMvYrErT0FqAsVXj3YZZycnN00y59eD8vlnyukdUDLLVRAqtNj/8onTlDa2DDHIg9PqRTDJFGs4hy+Et2+dD8SFsyzd/Erh79oTBiDA9urrzs5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984582; c=relaxed/simple;
	bh=Jn4zCyDtdzZFKJBpv0GY3uJJdOnFX6YBRr9wlEmxd88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VjXPN938WKwdK/M2vi/omJXcGtJw54U5JGP1VVIngIJLxbSZnDCc+BNpvK7jJTitPTeWQ4DO9rjZlimyCE5y15Es7DHuJZ5FMQUbnQ6D6UnPamgqgCQMM2FjBBtYrwf1og+Z0iKzZXEk6lLWKC02Jm/CszIR50khAzqLCTlt7EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gE6ni/Eh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C7A6C2BCC7;
	Thu, 28 May 2026 16:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779984582;
	bh=Jn4zCyDtdzZFKJBpv0GY3uJJdOnFX6YBRr9wlEmxd88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gE6ni/Eh5n0NZQVqVDukCpZHaX483wzzx3OzOFPukqNz4uSTt48gdyOIBrlrQSkdO
	 ZLWcoLXdobiY49u10L2uw3lfJhgaoIY4QR2xQtL95jhwv7cRj1HryveNiDPEfkn3zH
	 wT423FJ58+W8zquTycdWnki8C7BZ1bqMH62+3kbPcJBrqr+iMr5tgjMuGKasXO632y
	 GrWyS6TF6EKRfleASav7VPgwG+1FmuTQoFo3R/JvkhwadAlMJNAZP3jiHSErrpwG0T
	 61sjfLILMfgnTl0Mgr2mZkVnAENHXcGe5hdwjcIg52rjfFIFZZeDNVnUZUMNu3foy9
	 NOerWZLF7is7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38570CD5BD5;
	Thu, 28 May 2026 16:09:42 +0000 (UTC)
From: Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>
Date: Thu, 28 May 2026 18:09:33 +0200
Subject: [PATCH net-next v4 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-net-next-mv88e6xxx-cbs-v4-2-8bd13b906457@luminex.be>
References: <20260528-net-next-mv88e6xxx-cbs-v4-0-8bd13b906457@luminex.be>
In-Reply-To: <20260528-net-next-mv88e6xxx-cbs-v4-0-8bd13b906457@luminex.be>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luke Howard <lukeh@padl.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Cedric Jehasse <cedric.jehasse@luminex.be>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779984580; l=19671;
 i=cedric.jehasse@luminex.be; s=20260213; h=from:subject:message-id;
 bh=obl+8460QY/BjRTf9Vh/8gqIfyNaX7yRNjyaJ7NHzUU=;
 b=KBEtqLLlc2XxSe2Y5OVy1UwQxNiMYHUuYEXilMaT4qUCyG09Hcy7KHuBGtbEsvNN2ttYldI5D
 PVEDAOp7CHZBgSMyRacPYO5tTEQ3/1CbwfFtngrtXxHGJ9CPe6b4RPv
X-Developer-Key: i=cedric.jehasse@luminex.be; a=ed25519;
 pk=DL2RaHc2bc7tTDTMJdugm42BtJk4Ip+7V41Gkj+Avjk=
X-Endpoint-Received: by B4 Relay for cedric.jehasse@luminex.be/20260213
 with auth_id=638
X-Original-From: Cedric Jehasse <cedric.jehasse@luminex.be>
Reply-To: cedric.jehasse@luminex.be
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292758-lists,netdev=lfdr.de,cedric.jehasse.luminex.be];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,padl.com,kernel.org,gmail.com,luminex.be];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_PROHIBIT(0.00)[0.0.0.7:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[cedric.jehasse@luminex.be];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[luminex.be:replyto,luminex.be:mid,luminex.be:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,0.0.0.0:email,0.0.0.1:email,0.0.0.6:email,0.0.0.2:email]
X-Rspamd-Queue-Id: C25DB5F4F50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cedric Jehasse <cedric.jehasse@luminex.be>

Some of the chips supported by this driver have credit based shaper
support. Support is added for the 6341, 6352, 6390 and 6393 families.
This is configured using the Qav registers in the AVB register block.
There are small differences in the Qav registers between the chip
families (eg. the unit used for the rate and number of bits in the
registers). mv88e6xxx_qav_info is introduced to configure this per chip.

Eg. setting up 20mbps credit based shaper on a 1GBit link:
tc qdisc add dev p8 parent root handle 100: mqprio \
                num_tc 8 \
                map 0 0 6 7 0 5 0 0 0 0 0 0 0 0 0 0 \
                queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
                hw 0

tc qdisc replace dev p8 parent 100:8 cbs locredit -1470 hicredit 30 \
    sendslope -980000 idleslope 20000 offload 1

Note: only idleslope and hicredit can be programmed in the switch
registers, other parameters won't affect settings.

Signed-off-by: Cedric Jehasse <cedric.jehasse@luminex.be>
---
 drivers/net/dsa/mv88e6xxx/chip.c        | 130 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h        |  20 +++++
 drivers/net/dsa/mv88e6xxx/global2.h     |   3 +
 drivers/net/dsa/mv88e6xxx/global2_avb.c |  21 ++++++
 drivers/net/dsa/mv88e6xxx/port.c        |  63 ++++++++++++++++
 drivers/net/dsa/mv88e6xxx/port.h        |  20 +++++
 6 files changed, 257 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index ffd4fa41b7c5..5dc5961f37d6 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -32,6 +32,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/phylink.h>
 #include <net/dsa.h>
+#include <net/pkt_sched.h>
 
 #include "chip.h"
 #include "devlink.h"
@@ -5015,6 +5016,7 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.port_set_ether_type = mv88e6351_port_set_ether_type,
 	.port_set_jumbo_size = mv88e6165_port_set_jumbo_size,
 	.port_egress_rate_limiting = mv88e6097_port_egress_rate_limiting,
+	.port_set_scheduling_mode = mv88e6352_port_set_scheduling_mode,
 	.port_pause_limit = mv88e6097_port_pause_limit,
 	.port_disable_learn_limit = mv88e6xxx_port_disable_learn_limit,
 	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
@@ -5288,6 +5290,7 @@ static const struct mv88e6xxx_ops mv88e6341_ops = {
 	.port_set_ether_type = mv88e6351_port_set_ether_type,
 	.port_set_jumbo_size = mv88e6165_port_set_jumbo_size,
 	.port_egress_rate_limiting = mv88e6097_port_egress_rate_limiting,
+	.port_set_scheduling_mode = mv88e6352_port_set_scheduling_mode,
 	.port_pause_limit = mv88e6097_port_pause_limit,
 	.port_disable_learn_limit = mv88e6xxx_port_disable_learn_limit,
 	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
@@ -5446,6 +5449,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.port_set_ether_type = mv88e6351_port_set_ether_type,
 	.port_set_jumbo_size = mv88e6165_port_set_jumbo_size,
 	.port_egress_rate_limiting = mv88e6097_port_egress_rate_limiting,
+	.port_set_scheduling_mode = mv88e6352_port_set_scheduling_mode,
 	.port_pause_limit = mv88e6097_port_pause_limit,
 	.port_disable_learn_limit = mv88e6xxx_port_disable_learn_limit,
 	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
@@ -5515,6 +5519,7 @@ static const struct mv88e6xxx_ops mv88e6390_ops = {
 	.port_get_cmode = mv88e6352_port_get_cmode,
 	.port_set_cmode = mv88e6390_port_set_cmode,
 	.port_setup_message_port = mv88e6xxx_setup_message_port,
+	.port_set_scheduling_mode = mv88e6390_port_set_scheduling_mode,
 	.stats_snapshot = mv88e6390_g1_stats_snapshot,
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
@@ -5580,6 +5585,7 @@ static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	.port_get_cmode = mv88e6352_port_get_cmode,
 	.port_set_cmode = mv88e6390x_port_set_cmode,
 	.port_setup_message_port = mv88e6xxx_setup_message_port,
+	.port_set_scheduling_mode = mv88e6390_port_set_scheduling_mode,
 	.stats_snapshot = mv88e6390_g1_stats_snapshot,
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
@@ -5637,6 +5643,7 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.port_set_ether_type = mv88e6393x_port_set_ether_type,
 	.port_set_jumbo_size = mv88e6165_port_set_jumbo_size,
 	.port_egress_rate_limiting = mv88e6097_port_egress_rate_limiting,
+	.port_set_scheduling_mode = mv88e6390_port_set_scheduling_mode,
 	.port_pause_limit = mv88e6390_port_pause_limit,
 	.port_disable_learn_limit = mv88e6xxx_port_disable_learn_limit,
 	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
@@ -5679,6 +5686,27 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.tcam_ops = &mv88e6393_tcam_ops,
 };
 
+static const struct mv88e6xxx_qav_info mv88e6352_qav_info = {
+	.rate_unit = 32,
+	.rate_mask = GENMASK(14, 0),
+	.hi_limit_mask = GENMASK(14, 0),
+	.queue_mask = GENMASK(3, 0),
+};
+
+static const struct mv88e6xxx_qav_info mv88e6341_qav_info = {
+	.rate_unit = 64,
+	.rate_mask = GENMASK(15, 0),
+	.hi_limit_mask = GENMASK(14, 0),
+	.queue_mask = GENMASK(3, 0),
+};
+
+static const struct mv88e6xxx_qav_info mv88e6390_qav_info = {
+	.rate_unit = 64,
+	.rate_mask = GENMASK(15, 0),
+	.hi_limit_mask = GENMASK(13, 0),
+	.queue_mask = GENMASK(7, 0),
+};
+
 static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 	[MV88E6020] = {
 		.prod_num = MV88E6XXX_PORT_SWITCH_ID_PROD_6020,
@@ -6243,6 +6271,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
+		.qav = &mv88e6352_qav_info,
 		.ops = &mv88e6240_ops,
 	},
 
@@ -6380,6 +6409,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
+		.qav = &mv88e6341_qav_info,
 		.ops = &mv88e6341_ops,
 	},
 
@@ -6460,6 +6490,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
+		.qav = &mv88e6352_qav_info,
 		.ops = &mv88e6352_ops,
 	},
 	[MV88E6361] = {
@@ -6517,6 +6548,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_UNDOCUMENTED,
 		.ptp_support = true,
+		.qav = &mv88e6390_qav_info,
 		.ops = &mv88e6390_ops,
 	},
 	[MV88E6390X] = {
@@ -6544,6 +6576,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_UNDOCUMENTED,
 		.ptp_support = true,
+		.qav = &mv88e6390_qav_info,
 		.ops = &mv88e6390x_ops,
 	},
 
@@ -6572,6 +6605,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.pvt = true,
 		.multi_chip = true,
 		.ptp_support = true,
+		.qav = &mv88e6390_qav_info,
 		.ops = &mv88e6393x_ops,
 	},
 };
@@ -7193,6 +7227,101 @@ static int mv88e6xxx_crosschip_lag_leave(struct dsa_switch *ds, int sw_index,
 	return err_sync ? : err_pvt;
 }
 
+static int mv88e6xxx_setup_tc_cbs(struct dsa_switch *ds, int port,
+				  struct tc_cbs_qopt_offload *cbs)
+{
+	const struct mv88e6xxx_avb_ops *avb_ops;
+	struct mv88e6xxx_chip *chip = ds->priv;
+	const struct mv88e6xxx_qav_info *qav;
+	const struct mv88e6xxx_ops *ops;
+	int hilimit_reg;
+	int rate_reg;
+	u8 queue_bit;
+	u16 hi_limit;
+	u16 rate = 0;
+	int err;
+
+	ops = chip->info->ops;
+	avb_ops = ops->avb_ops;
+	qav = chip->info->qav;
+
+	if (!qav || !avb_ops || !avb_ops->port_qav_write ||
+	    !ops->port_set_scheduling_mode)
+		return -EOPNOTSUPP;
+
+	if (!dsa_is_user_port(ds, port))
+		return -EOPNOTSUPP;
+
+	if (!(qav->queue_mask & BIT(cbs->queue)))
+		return -EOPNOTSUPP;
+
+	queue_bit = BIT(cbs->queue);
+	rate_reg = MV88E6XXX_PORT_QAV_CFG_RATE(cbs->queue);
+	hilimit_reg = MV88E6XXX_PORT_QAV_CFG_HI_LIMIT(cbs->queue);
+
+	if (cbs->enable) {
+		if (cbs->hicredit <= 0 ||
+		    cbs->hicredit > qav->hi_limit_mask)
+			return -ERANGE;
+
+		rate = DIV_ROUND_UP(cbs->idleslope, qav->rate_unit);
+		if (rate > qav->rate_mask)
+			return -ERANGE;
+		/* avoid using zero rate */
+		rate = max_t(u16, rate, 1);
+	}
+
+	mv88e6xxx_reg_lock(chip);
+
+	if (!cbs->enable) {
+		err = mv88e6xxx_port_qav_write(chip, port, rate_reg, 0);
+		if (err)
+			goto unlock;
+
+		if (!(chip->ports[port].cbs_active_queues & ~queue_bit)) {
+			err = mv88e6xxx_port_set_scheduling_mode(chip, port, 0);
+			if (err)
+				goto unlock;
+		}
+		chip->ports[port].cbs_active_queues &= ~queue_bit;
+		goto unlock;
+	}
+
+	hi_limit = cbs->hicredit & qav->hi_limit_mask;
+	err = mv88e6xxx_port_qav_write(chip, port, hilimit_reg, hi_limit);
+	if (err)
+		goto unlock;
+
+	err = mv88e6xxx_port_qav_write(chip, port, rate_reg, rate);
+	if (err)
+		goto unlock;
+
+	err = mv88e6xxx_port_set_scheduling_mode(chip, port,
+						 chip->info->num_tx_queues - 1);
+	if (err) {
+		mv88e6xxx_port_qav_write(chip, port, rate_reg, 0);
+		chip->ports[port].cbs_active_queues &= ~queue_bit;
+		goto unlock;
+	}
+	chip->ports[port].cbs_active_queues |= queue_bit;
+
+unlock:
+	mv88e6xxx_reg_unlock(chip);
+
+	return err;
+}
+
+static int mv88e6xxx_port_setup_tc(struct dsa_switch *ds, int port,
+				   enum tc_setup_type type, void *type_data)
+{
+	switch (type) {
+	case TC_SETUP_QDISC_CBS:
+		return mv88e6xxx_setup_tc_cbs(ds, port, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct phylink_mac_ops mv88e6xxx_phylink_mac_ops = {
 	.mac_select_pcs		= mv88e6xxx_mac_select_pcs,
 	.mac_prepare		= mv88e6xxx_mac_prepare,
@@ -7252,6 +7381,7 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.port_hwtstamp_get	= mv88e6xxx_port_hwtstamp_get,
 	.port_txtstamp		= mv88e6xxx_port_txtstamp,
 	.port_rxtstamp		= mv88e6xxx_port_rxtstamp,
+	.port_setup_tc		= mv88e6xxx_port_setup_tc,
 	.cls_flower_add		= mv88e6xxx_cls_flower_add,
 	.cls_flower_del         = mv88e6xxx_cls_flower_del,
 	.get_ts_info		= mv88e6xxx_get_ts_info,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 19d8eda19b78..8768d599f8fc 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -125,6 +125,7 @@ enum mv88e6xxx_edsa_support {
 };
 
 struct mv88e6xxx_ops;
+struct mv88e6xxx_qav_info;
 
 struct mv88e6xxx_info {
 	enum mv88e6xxx_family family;
@@ -177,6 +178,9 @@ struct mv88e6xxx_info {
 	/* Supports PTP */
 	bool ptp_support;
 
+	/* 802.1Qav credit based shaping */
+	const struct mv88e6xxx_qav_info *qav;
+
 	/* Internal PHY start index. 0 means that internal PHYs range starts at
 	 * port 0, 1 means internal PHYs range starts at port 1, etc
 	 */
@@ -304,6 +308,9 @@ struct mv88e6xxx_port {
 
 	/* MacAuth Bypass control flag */
 	bool mab;
+
+	/* Queues with CBS currently enabled. */
+	u8 cbs_active_queues;
 };
 
 enum mv88e6xxx_region_id {
@@ -607,6 +614,8 @@ struct mv88e6xxx_ops {
 				   size_t size);
 
 	int (*port_egress_rate_limiting)(struct mv88e6xxx_chip *chip, int port);
+	int (*port_set_scheduling_mode)(struct mv88e6xxx_chip *chip, int port,
+					u8 mode);
 	int (*port_pause_limit)(struct mv88e6xxx_chip *chip, int port, u8 in,
 				u8 out);
 	int (*port_disable_learn_limit)(struct mv88e6xxx_chip *chip, int port);
@@ -764,6 +773,10 @@ struct mv88e6xxx_avb_ops {
 	int (*tai_read)(struct mv88e6xxx_chip *chip, int addr, u16 *data,
 			int len);
 	int (*tai_write)(struct mv88e6xxx_chip *chip, int addr, u16 data);
+
+	/* Access port-scoped 802.1Qav registers */
+	int (*port_qav_write)(struct mv88e6xxx_chip *chip, int port, int addr,
+			      u16 data);
 };
 
 struct mv88e6xxx_ptp_ops {
@@ -799,6 +812,13 @@ struct mv88e6xxx_tcam_ops {
 	int (*flush_tcam)(struct mv88e6xxx_chip *chip);
 };
 
+struct mv88e6xxx_qav_info {
+	u16 rate_unit; /* in kbps */
+	u16 rate_mask; /* QPri Rate valid bits mask */
+	u16 hi_limit_mask; /* Qpri Hi Limit bits mask*/
+	u8 queue_mask; /* supported queues bitmask */
+};
+
 static inline bool mv88e6xxx_has_stu(struct mv88e6xxx_chip *chip)
 {
 	return chip->info->max_sid > 0 &&
diff --git a/drivers/net/dsa/mv88e6xxx/global2.h b/drivers/net/dsa/mv88e6xxx/global2.h
index 82f9b410de0b..f1cdc33dd418 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.h
+++ b/drivers/net/dsa/mv88e6xxx/global2.h
@@ -186,6 +186,9 @@
 #define MV88E6352_G2_AVB_CMD_BLOCK_MASK		0x00e0
 #define MV88E6352_G2_AVB_CMD_ADDR_MASK		0x001f
 
+#define MV88E6XXX_PORT_QAV_CFG_RATE(queue)	(((queue) & 0x7) << 1)
+#define MV88E6XXX_PORT_QAV_CFG_HI_LIMIT(queue)	((((queue) & 0x7) << 1) + 1)
+
 /* Offset 0x17: AVB Data Register */
 #define MV88E6352_G2_AVB_DATA		0x17
 
diff --git a/drivers/net/dsa/mv88e6xxx/global2_avb.c b/drivers/net/dsa/mv88e6xxx/global2_avb.c
index 657783e043ff..6b54e275d21a 100644
--- a/drivers/net/dsa/mv88e6xxx/global2_avb.c
+++ b/drivers/net/dsa/mv88e6xxx/global2_avb.c
@@ -110,6 +110,15 @@ static int mv88e6352_g2_avb_port_ptp_write(struct mv88e6xxx_chip *chip,
 	return mv88e6xxx_g2_avb_write(chip, writeop, data);
 }
 
+static int mv88e6352_g2_avb_port_qav_write(struct mv88e6xxx_chip *chip,
+					   int port, int addr, u16 data)
+{
+	u16 writeop = MV88E6352_G2_AVB_CMD_OP_WRITE | (port << 8) |
+		      (MV88E6352_G2_AVB_CMD_BLOCK_QAV << 5) | addr;
+
+	return mv88e6xxx_g2_avb_write(chip, writeop, data);
+}
+
 static int mv88e6352_g2_avb_ptp_read(struct mv88e6xxx_chip *chip, int addr,
 				     u16 *data, int len)
 {
@@ -149,6 +158,7 @@ const struct mv88e6xxx_avb_ops mv88e6352_avb_ops = {
 	.ptp_write		= mv88e6352_g2_avb_ptp_write,
 	.tai_read		= mv88e6352_g2_avb_tai_read,
 	.tai_write		= mv88e6352_g2_avb_tai_write,
+	.port_qav_write		= mv88e6352_g2_avb_port_qav_write,
 };
 
 static int mv88e6165_g2_avb_tai_read(struct mv88e6xxx_chip *chip, int addr,
@@ -174,6 +184,7 @@ const struct mv88e6xxx_avb_ops mv88e6165_avb_ops = {
 	.ptp_write		= mv88e6352_g2_avb_ptp_write,
 	.tai_read		= mv88e6165_g2_avb_tai_read,
 	.tai_write		= mv88e6165_g2_avb_tai_write,
+	.port_qav_write		= mv88e6352_g2_avb_port_qav_write,
 };
 
 static int mv88e6390_g2_avb_port_ptp_read(struct mv88e6xxx_chip *chip,
@@ -197,6 +208,15 @@ static int mv88e6390_g2_avb_port_ptp_write(struct mv88e6xxx_chip *chip,
 	return mv88e6xxx_g2_avb_write(chip, writeop, data);
 }
 
+static int mv88e6390_g2_avb_port_qav_write(struct mv88e6xxx_chip *chip,
+					   int port, int addr, u16 data)
+{
+	u16 writeop = MV88E6390_G2_AVB_CMD_OP_WRITE | (port << 8) |
+		      (MV88E6352_G2_AVB_CMD_BLOCK_QAV << 5) | addr;
+
+	return mv88e6xxx_g2_avb_write(chip, writeop, data);
+}
+
 static int mv88e6390_g2_avb_ptp_read(struct mv88e6xxx_chip *chip, int addr,
 				     u16 *data, int len)
 {
@@ -236,4 +256,5 @@ const struct mv88e6xxx_avb_ops mv88e6390_avb_ops = {
 	.ptp_write		= mv88e6390_g2_avb_ptp_write,
 	.tai_read		= mv88e6390_g2_avb_tai_read,
 	.tai_write		= mv88e6390_g2_avb_tai_write,
+	.port_qav_write		= mv88e6390_g2_avb_port_qav_write,
 };
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index c90117d2dd83..23d1435db0d8 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -1348,6 +1348,51 @@ int mv88e6097_port_egress_rate_limiting(struct mv88e6xxx_chip *chip, int port)
 				    0x0001);
 }
 
+int mv88e6352_port_set_scheduling_mode(struct mv88e6xxx_chip *chip, int port,
+				       u8 mode)
+{
+	u16 reg;
+	int err;
+
+	if (mode > 3)
+		return -EINVAL;
+
+	err = mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_EGRESS_RATE_CTL2,
+				  &reg);
+	if (err)
+		return err;
+
+	reg &= ~MV88E6XXX_PORT_EGRESS_RATE_CTL2_SCHEDULE_MASK;
+	reg |= mode << MV88E6XXX_PORT_EGRESS_RATE_CTL2_SCHEDULE_SHIFT;
+
+	return mv88e6xxx_port_write(chip, port,
+				    MV88E6XXX_PORT_EGRESS_RATE_CTL2, reg);
+}
+
+int mv88e6390_port_set_scheduling_mode(struct mv88e6xxx_chip *chip, int port,
+				       u8 mode)
+{
+	u16 reg;
+	int err;
+
+	if (mode > MV88E6390_PORT_QUEUE_CTL_SCHEDULE_MASK)
+		return -EINVAL;
+
+	reg = MV88E6390_PORT_QUEUE_CTL_UPDATE |
+	      (MV88E6390_PORT_QUEUE_CTL_SCHEDULE <<
+	       MV88E6390_PORT_QUEUE_CTL_PTR_SHIFT) |
+	      (mode & MV88E6390_PORT_QUEUE_CTL_SCHEDULE_MASK);
+
+	err = mv88e6xxx_port_write(chip, port, MV88E6390_PORT_QUEUE_CTL,
+				   reg);
+	if (err)
+		return err;
+
+	return mv88e6xxx_port_wait_bit(chip, port, MV88E6390_PORT_QUEUE_CTL,
+				       __bf_shf(MV88E6390_PORT_QUEUE_CTL_UPDATE)
+				       , 0);
+}
+
 /* Offset 0x0B: Port Association Vector */
 
 int mv88e6xxx_port_set_assoc_vector(struct mv88e6xxx_chip *chip, int port,
@@ -1761,3 +1806,21 @@ int mv88e6393x_port_set_policy(struct mv88e6xxx_chip *chip, int port,
 
 	return mv88e6393x_port_policy_write(chip, port, ptr, reg);
 }
+
+int mv88e6xxx_port_qav_write(struct mv88e6xxx_chip *chip, int port, int addr,
+			     u16 data)
+{
+	if (!chip->info->ops->avb_ops->port_qav_write)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->avb_ops->port_qav_write(chip, port, addr, data);
+}
+
+int mv88e6xxx_port_set_scheduling_mode(struct mv88e6xxx_chip *chip, int port,
+				       u8 mode)
+{
+	if (!chip->info->ops->port_set_scheduling_mode)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->port_set_scheduling_mode(chip, port, mode);
+}
diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
index f6041f91215e..cf8655a13729 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -241,6 +241,18 @@
 
 /* Offset 0x0A: Egress Rate Control 2 */
 #define MV88E6XXX_PORT_EGRESS_RATE_CTL2		0x0a
+#define MV88E6XXX_PORT_EGRESS_RATE_CTL2_SCHEDULE_MASK	0x3000
+#define MV88E6XXX_PORT_EGRESS_RATE_CTL2_SCHEDULE_SHIFT	12
+
+/* Offset 0x1C: Port Queue Control */
+#define MV88E6390_PORT_QUEUE_CTL			0x1c
+#define MV88E6390_PORT_QUEUE_CTL_UPDATE			0x8000
+#define MV88E6390_PORT_QUEUE_CTL_PTR_MASK		0x7f00
+#define MV88E6390_PORT_QUEUE_CTL_PTR_SHIFT		8
+#define MV88E6390_PORT_QUEUE_CTL_DATA_MASK		0x00ff
+#define MV88E6390_PORT_QUEUE_CTL_SCHEDULE		0x00
+#define MV88E6390_PORT_QUEUE_CTL_SCHEDULE_MASK		0x07
+
 
 /* Offset 0x0B: Port Association Vector */
 #define MV88E6XXX_PORT_ASSOC_VECTOR			0x0b
@@ -569,6 +581,10 @@ int mv88e6165_port_set_jumbo_size(struct mv88e6xxx_chip *chip, int port,
 				  size_t size);
 int mv88e6095_port_egress_rate_limiting(struct mv88e6xxx_chip *chip, int port);
 int mv88e6097_port_egress_rate_limiting(struct mv88e6xxx_chip *chip, int port);
+int mv88e6352_port_set_scheduling_mode(struct mv88e6xxx_chip *chip, int port,
+				       u8 mode);
+int mv88e6390_port_set_scheduling_mode(struct mv88e6xxx_chip *chip, int port,
+				       u8 mode);
 int mv88e6xxx_port_set_assoc_vector(struct mv88e6xxx_chip *chip, int port,
 				    u16 pav);
 int mv88e6097_port_pause_limit(struct mv88e6xxx_chip *chip, int port, u8 in,
@@ -613,5 +629,9 @@ int mv88e6xxx_port_hidden_read(struct mv88e6xxx_chip *chip, int block, int port,
 			       int reg, u16 *val);
 
 int mv88e6xxx_port_enable_tcam(struct mv88e6xxx_chip *chip, int port);
+int mv88e6xxx_port_qav_write(struct mv88e6xxx_chip *chip, int port, int addr,
+			     u16 data);
+int mv88e6xxx_port_set_scheduling_mode(struct mv88e6xxx_chip *chip, int port,
+				       u8 mode);
 
 #endif /* _MV88E6XXX_PORT_H */

-- 
2.43.0



