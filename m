Return-Path: <netdev+bounces-123829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A4B9669CD
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B7528768C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 19:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6FF1C3F00;
	Fri, 30 Aug 2024 19:27:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5EF1C1721
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046037; cv=none; b=GAKuseTnA9UbE9LTGZpjKQ+rD2RU0bN6lq0MGYoD6aWAcibN6sOkfVCUOjsguuROprUOJy9KCBqeQ5/4HW08aNMOX05tvk4GtzTMvLft0vvKwUp3PqDdaK/j2r0DkIhQJxpSLnmiIb9nRC33khbXRymbcAYpL58eF8QcwlIO/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046037; c=relaxed/simple;
	bh=bzaZeLqVpFxgzGtxEbJ+YPhAuZF1PlCPIMtvxQ/VRUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DWOUAWRUDTj6aYB3eQIoTPZWbctqIfrrVBWmXGk7yAAXXi2pUcwnfBCEiZgEv3+oa0LgWYmSElq1j6TJVIqYOjhzseuJNPqExm51cGgjK4Jdn3fSypf/omJ0YNZWa+oX8gA70eiXnC56P+HJavasPTDLLxXHoA4v8jbbt4C8JqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7H4-0006cj-Jw
	for netdev@vger.kernel.org; Fri, 30 Aug 2024 21:27:10 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7H0-004Dz4-MW
	for netdev@vger.kernel.org; Fri, 30 Aug 2024 21:27:06 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 5D6B732E2D6
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 19:27:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 8E6D132E118;
	Fri, 30 Aug 2024 19:26:47 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c1f7dc44;
	Fri, 30 Aug 2024 19:26:45 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 30 Aug 2024 21:26:13 +0200
Subject: [PATCH can-next v3 16/20] can: rockchip_canfd: prepare to use full
 TX-FIFO depth
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-rockchip-canfd-v3-16-d426266453fa@pengutronix.de>
References: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
In-Reply-To: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=4154; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=bzaZeLqVpFxgzGtxEbJ+YPhAuZF1PlCPIMtvxQ/VRUA=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm0hzt6d6pYBLK48sMQGSY882lzbTcdr+7oJsrB
 mrUjTtmcLiJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtIc7QAKCRAoOKI+ei28
 b30oB/9naTa2umyplhGaEfflNa5JhTvYvmeKclM+xu9sV+u9MtvGvr2NCQHeJNazDIJT8bRiYdN
 O2bqwe44lCnbl81sr8yu65bIBkHywW7G8N6M65RWODarTfGz4SVwBYtQktODBEYVDqbU+PHTsT5
 su4RySf58wUJ+8nJQHkWKfbUMjIGAiIpnSrRxBkgJDBbFt6ihskwbJoPW6zMv5pgWdKVYw5j03F
 5kOqrkMfMqyAfSUABQe7sDos46UlGAz4GoszjFu7uDIOl3Hrg1dmlBDxOnXgoQ3O1sYAT5VPN8H
 KcJDsy5ey/wDipODrnv3ZbJE58F2kegnR+ASjoNQFtYHTsxJ
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

So far the TX-FIFO is only used with a depth of 1, although the
hardware offers a depth of 2.

The workaround for the chips that are affected by erratum 6, i.e. EFF
frames may be send as standard frames, is to re-send the EFF frame.
This means the driver cannot queue the next frame for sending, as long
ad the EFF frame has not been successfully send out.

Introduce rkcanfd_get_effective_tx_free() that returns "0" space in
the TX-FIFO if an EFF frame is pending and the actual free space in
the TX-FIFO otherwise. Then replace rkcanfd_get_tx_free() with
rkcanfd_get_effective_tx_free() everywhere.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-rx.c |  2 +-
 drivers/net/can/rockchip/rockchip_canfd-tx.c | 38 ++++++++++++++++++++++++++--
 drivers/net/can/rockchip/rockchip_canfd.h    |  1 +
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 9f72483dab18..bacef5e5dc39 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -124,7 +124,7 @@ static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
 
 		WRITE_ONCE(priv->tx_tail, priv->tx_tail + 1);
 		netif_subqueue_completed_wake(priv->ndev, 0, 1, frame_len,
-					      rkcanfd_get_tx_free(priv),
+					      rkcanfd_get_effective_tx_free(priv),
 					      RKCANFD_TX_START_THRESHOLD);
 
 		*tx_done = true;
diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index f8e74e814b3b..d10da548ba71 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -8,6 +8,40 @@
 
 #include "rockchip_canfd.h"
 
+static bool rkcanfd_tx_tail_is_eff(const struct rkcanfd_priv *priv)
+{
+	const struct canfd_frame *cfd;
+	const struct sk_buff *skb;
+	unsigned int tx_tail;
+
+	if (!rkcanfd_get_tx_pending(priv))
+		return false;
+
+	tx_tail = rkcanfd_get_tx_tail(priv);
+	skb = priv->can.echo_skb[tx_tail];
+	if (!skb) {
+		netdev_err(priv->ndev,
+			   "%s: echo_skb[%u]=NULL tx_head=0x%08x tx_tail=0x%08x\n",
+			   __func__, tx_tail,
+			   priv->tx_head, priv->tx_tail);
+
+		return false;
+	}
+
+	cfd = (struct canfd_frame *)skb->data;
+
+	return cfd->can_id & CAN_EFF_FLAG;
+}
+
+unsigned int rkcanfd_get_effective_tx_free(const struct rkcanfd_priv *priv)
+{
+	if (priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_6 &&
+	    rkcanfd_tx_tail_is_eff(priv))
+		return 0;
+
+	return rkcanfd_get_tx_free(priv);
+}
+
 static void rkcanfd_start_xmit_write_cmd(const struct rkcanfd_priv *priv,
 					 const u32 reg_cmd)
 {
@@ -42,7 +76,7 @@ int rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		return NETDEV_TX_OK;
 
 	if (!netif_subqueue_maybe_stop(priv->ndev, 0,
-				       rkcanfd_get_tx_free(priv),
+				       rkcanfd_get_effective_tx_free(priv),
 				       RKCANFD_TX_STOP_THRESHOLD,
 				       RKCANFD_TX_START_THRESHOLD)) {
 		if (net_ratelimit())
@@ -99,7 +133,7 @@ int rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);
 
 	netif_subqueue_maybe_stop(priv->ndev, 0,
-				  rkcanfd_get_tx_free(priv),
+				  rkcanfd_get_effective_tx_free(priv),
 				  RKCANFD_TX_STOP_THRESHOLD,
 				  RKCANFD_TX_START_THRESHOLD);
 
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index f24a1d18be66..37d90400429f 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -533,6 +533,7 @@ int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv);
 
 void rkcanfd_timestamp_init(struct rkcanfd_priv *priv);
 
+unsigned int rkcanfd_get_effective_tx_free(const struct rkcanfd_priv *priv);
 void rkcanfd_xmit_retry(struct rkcanfd_priv *priv);
 int rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev);
 void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,

-- 
2.45.2



