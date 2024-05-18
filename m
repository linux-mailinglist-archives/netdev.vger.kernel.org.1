Return-Path: <netdev+bounces-97096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0C88C9117
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C7428174B
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842D54501C;
	Sat, 18 May 2024 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fexKLyd8"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF55770FA;
	Sat, 18 May 2024 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036281; cv=none; b=qQfgq1od/sQ+qujdaPmAY0RkoqpikRRB6Ry7oONVlBOEVWtTywjbFfYK0f9AC+gOUQq/5/dqAcZ7LM7LBR02cV4Vc4ahtufilTuVrIMVgaUSGU7g7rb/ezUWckHSdrp8URepgoQPqUXTwwdWp7+s70zpfH74FN0Ebs+AE6ybyW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036281; c=relaxed/simple;
	bh=TkZ8YCzGf3L4/woShJhNStGq6ph3UlMnPIzsSyhl65U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLxtHjJwS/u923/lxbDxiYARoWKwzXdoXNqxCBBrk6nBVK7Apj6qLyuSMi0e1mDNjSTQ2Hakv99CubinPJin/6qCarBjnL0Kt57yBqs3VbGyRiLSCR8p+eZbkcYdd+Jk3HJtMZJQb7X6l8jCobffrR9g63+82rfQ/9EoNu2jjl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fexKLyd8; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ICiK5o017356;
	Sat, 18 May 2024 07:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036260;
	bh=bhrgTDMVzI0dP8d/KQcIUJP6wdPok2F5QjLOlXwW5rY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fexKLyd8OlzpsoOiCIHCWanAWn6FgEqgJxW9JEEkeDcJbDPxC7oMezMsQt4DoUe2M
	 za+kMTvGs69pY1hUWwdwgvWDkykQ5rkjFX5HxjniZVIIHlih+qVSFb4vfZtceLmFsS
	 sK9nu5OtJ9APr88pxlv4bhQ+IXeRgwZy1cUYHXSU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ICiKAF130101
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:44:20 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:44:20 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:44:20 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9c041511;
	Sat, 18 May 2024 07:44:16 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 22/28] net: ethernet: ti: cpsw-proxy-client: implement .get_link ethtool op
Date: Sat, 18 May 2024 18:12:28 +0530
Message-ID: <20240518124234.2671651-23-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240518124234.2671651-1-s-vadapalli@ti.com>
References: <20240518124234.2671651-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add the "vport_get_link()" function and register it as the driver's
.get_link ethtool_ops callback.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 32 +++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index be42b02c3894..450fc183eaac 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -284,6 +284,7 @@ static int create_request_message(struct cpsw_proxy_req_params *req_params)
 	case ETHFW_ALLOC_MAC:
 	case ETHFW_VIRT_PORT_DETACH:
 	case ETHFW_VIRT_PORT_INFO:
+	case ETHFW_VIRT_PORT_LINK_STATUS:
 		common_req_msg = (struct common_request_message *)msg;
 		req_msg_hdr = &common_req_msg->request_msg_hdr;
 		break;
@@ -1184,7 +1185,38 @@ static int vport_rx_poll(struct napi_struct *napi_rx, int budget)
 	return num_rx;
 }
 
+static u32 vport_get_link(struct net_device *ndev)
+{
+	struct virtual_port *vport = vport_ndev_to_vport(ndev);
+	struct cpsw_proxy_priv *proxy_priv = vport->proxy_priv;
+	struct port_link_status_response *pls_resp;
+	struct cpsw_proxy_req_params *req_p;
+	struct message resp_msg;
+	bool link_up;
+	int ret;
+
+	if (vport->port_type != VIRT_MAC_ONLY_PORT)
+		return ethtool_op_get_link(ndev);
+
+	mutex_lock(&proxy_priv->req_params_mutex);
+	req_p = &proxy_priv->req_params;
+	req_p->request_type = ETHFW_VIRT_PORT_LINK_STATUS;
+	req_p->token = vport->port_token;
+	ret = send_request_get_response(proxy_priv, &resp_msg);
+	mutex_unlock(&proxy_priv->req_params_mutex);
+	if (ret) {
+		netdev_err(ndev, "failed to get link status\n");
+		/* Assume that link is down if status is unknown */
+		return 0;
+	}
+	pls_resp = (struct port_link_status_response *)&resp_msg;
+	link_up = pls_resp->link_up;
+
+	return link_up;
+}
+
 const struct ethtool_ops cpsw_proxy_client_ethtool_ops = {
+	.get_link		= vport_get_link,
 };
 
 static int register_mac(struct virtual_port *vport)
-- 
2.40.1


