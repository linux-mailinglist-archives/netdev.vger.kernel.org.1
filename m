Return-Path: <netdev+bounces-225843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B81B98D1B
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF2A4C3FF7
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5992877EA;
	Wed, 24 Sep 2025 08:21:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F7928507F
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702109; cv=none; b=bVXXFvMB/yduViYXuCiufGpc8PUsoG8xhOKlw/Mdde2pMYjfi8iMZDem/6GQNG42qadH0enB2pm6WjlfPTdgHNq/CQq5Z84TF40YoLJP6fEPVLcjp22MgXopC++x46CN7dOhtj+MIP11lxVOzXo9xZIc+OWv0OmgYG1RkE/jhJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702109; c=relaxed/simple;
	bh=uewvFQnZ6Op17EalGgdORNAEuWb7ymuY72lGUXbAp6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xp+XmrGvin7elKDA+cYzpFmo40JHvDnVrDqNt3Vvjm2MnXOnArimYafhyyBaVNF+6NDcSGuE7YgLa/pz1tsg8oaVkkOlCi4sm6O8Fo+pzE8HvzI7vSOk+jLMAXxBmEMoWXjVgPovhzcQmRZCWzNsV5heocTP2DMRPz/4D0kkVZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkf-0001Fy-2p; Wed, 24 Sep 2025 10:21:25 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-000Dw8-1P;
	Wed, 24 Sep 2025 10:21:23 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 866AB4788B0;
	Wed, 24 Sep 2025 08:21:10 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 38/48] can: netlink: add can_dtb_changelink()
Date: Wed, 24 Sep 2025 10:06:55 +0200
Message-ID: <20250924082104.595459-39-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Vincent Mailhol <mailhol@kernel.org>

Factorise the databittiming parsing out of can_changelink() and move
it in the new can_dtb_changelink() function. This is a preparation
patch for the introduction of CAN XL because the databittiming
changelink logic will be reused later on.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-canxl-netlink-prep-v4-10-e720d28f66fe@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 152 ++++++++++++++++++++--------------
 1 file changed, 88 insertions(+), 64 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index abff7b84fdce..5f2962aab576 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -221,12 +221,95 @@ static int can_tdc_changelink(struct data_bittiming_params *dbt_params,
 	return 0;
 }
 
+static int can_dbt_changelink(struct net_device *dev, struct nlattr *data[],
+			      bool fd, struct netlink_ext_ack *extack)
+{
+	struct nlattr *data_bittiming, *data_tdc;
+	struct can_priv *priv = netdev_priv(dev);
+	struct data_bittiming_params *dbt_params;
+	struct can_bittiming dbt;
+	bool need_tdc_calc = false;
+	u32 tdc_mask;
+	int err;
+
+	if (fd) {
+		data_bittiming = data[IFLA_CAN_DATA_BITTIMING];
+		data_tdc = data[IFLA_CAN_TDC];
+		dbt_params = &priv->fd;
+		tdc_mask = CAN_CTRLMODE_FD_TDC_MASK;
+	} else {
+		return -EOPNOTSUPP; /* Place holder for CAN XL */
+	}
+
+	if (!data_bittiming)
+		return 0;
+
+	/* Do not allow changing bittiming while running */
+	if (dev->flags & IFF_UP)
+		return -EBUSY;
+
+	/* Calculate bittiming parameters based on data_bittiming_const
+	 * if set, otherwise pass bitrate directly via do_set_bitrate().
+	 * Bail out if neither is given.
+	 */
+	if (!dbt_params->data_bittiming_const && !dbt_params->do_set_data_bittiming &&
+	    !dbt_params->data_bitrate_const)
+		return -EOPNOTSUPP;
+
+	memcpy(&dbt, nla_data(data_bittiming), sizeof(dbt));
+	err = can_get_bittiming(dev, &dbt, dbt_params->data_bittiming_const,
+				dbt_params->data_bitrate_const,
+				dbt_params->data_bitrate_const_cnt, extack);
+	if (err)
+		return err;
+
+	if (priv->bitrate_max && dbt.bitrate > priv->bitrate_max) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "CAN data bitrate %u bps surpasses transceiver capabilities of %u bps",
+				   dbt.bitrate, priv->bitrate_max);
+		return -EINVAL;
+	}
+
+	memset(&dbt_params->tdc, 0, sizeof(dbt_params->tdc));
+	if (data[IFLA_CAN_CTRLMODE]) {
+		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
+
+		need_tdc_calc = !(cm->mask & tdc_mask);
+	}
+	if (data_tdc) {
+		/* TDC parameters are provided: use them */
+		err = can_tdc_changelink(dbt_params, data_tdc, extack);
+		if (err) {
+			priv->ctrlmode &= ~tdc_mask;
+			return err;
+		}
+	} else if (need_tdc_calc) {
+		/* Neither of TDC parameters nor TDC flags are provided:
+		 * do calculation
+		 */
+		can_calc_tdco(&dbt_params->tdc, dbt_params->tdc_const, &dbt,
+			      &priv->ctrlmode, priv->ctrlmode_supported);
+	} /* else: both CAN_CTRLMODE_TDC_{AUTO,MANUAL} are explicitly
+	   * turned off. TDC is disabled: do nothing
+	   */
+
+	memcpy(&dbt_params->data_bittiming, &dbt, sizeof(dbt));
+
+	if (dbt_params->do_set_data_bittiming) {
+		/* Finally, set the bit-timing registers */
+		err = dbt_params->do_set_data_bittiming(dev);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			  struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
 {
 	struct can_priv *priv = netdev_priv(dev);
-	bool fd_tdc_flag_provided = false;
 	int err;
 
 	/* We need synchronization with dev->stop() */
@@ -273,8 +356,6 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		}
 
 		can_set_default_mtu(dev);
-
-		fd_tdc_flag_provided = cm->mask & CAN_CTRLMODE_FD_TDC_MASK;
 	}
 
 	if (data[IFLA_CAN_BITTIMING]) {
@@ -347,67 +428,10 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			return err;
 	}
 
-	if (data[IFLA_CAN_DATA_BITTIMING]) {
-		struct can_bittiming dbt;
-
-		/* Do not allow changing bittiming while running */
-		if (dev->flags & IFF_UP)
-			return -EBUSY;
-
-		/* Calculate bittiming parameters based on
-		 * data_bittiming_const if set, otherwise pass bitrate
-		 * directly via do_set_bitrate(). Bail out if neither
-		 * is given.
-		 */
-		if (!priv->fd.data_bittiming_const && !priv->fd.do_set_data_bittiming &&
-		    !priv->fd.data_bitrate_const)
-			return -EOPNOTSUPP;
-
-		memcpy(&dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
-		       sizeof(dbt));
-		err = can_get_bittiming(dev, &dbt,
-					priv->fd.data_bittiming_const,
-					priv->fd.data_bitrate_const,
-					priv->fd.data_bitrate_const_cnt,
-					extack);
-		if (err)
-			return err;
-
-		if (priv->bitrate_max && dbt.bitrate > priv->bitrate_max) {
-			NL_SET_ERR_MSG_FMT(extack,
-					   "CANFD data bitrate %u bps surpasses transceiver capabilities of %u bps",
-					   dbt.bitrate, priv->bitrate_max);
-			return -EINVAL;
-		}
-
-		memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
-		if (data[IFLA_CAN_TDC]) {
-			/* TDC parameters are provided: use them */
-			err = can_tdc_changelink(&priv->fd,
-						 data[IFLA_CAN_TDC], extack);
-			if (err) {
-				priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
-				return err;
-			}
-		} else if (!fd_tdc_flag_provided) {
-			/* Neither of TDC parameters nor TDC flags are
-			 * provided: do calculation
-			 */
-			can_calc_tdco(&priv->fd.tdc, priv->fd.tdc_const, &dbt,
-				      &priv->ctrlmode, priv->ctrlmode_supported);
-		} /* else: both CAN_CTRLMODE_TDC_{AUTO,MANUAL} are explicitly
-		   * turned off. TDC is disabled: do nothing
-		   */
-
-		memcpy(&priv->fd.data_bittiming, &dbt, sizeof(dbt));
-
-		if (priv->fd.do_set_data_bittiming) {
-			/* Finally, set the bit-timing registers */
-			err = priv->fd.do_set_data_bittiming(dev);
-			if (err)
-				return err;
-		}
-	}
+	/* CAN FD */
+	err = can_dbt_changelink(dev, data, true, extack);
+	if (err)
+		return err;
 
 	if (data[IFLA_CAN_TERMINATION]) {
 		const u16 termval = nla_get_u16(data[IFLA_CAN_TERMINATION]);
-- 
2.51.0


