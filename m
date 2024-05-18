Return-Path: <netdev+bounces-97102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E2F8C9129
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EC228284F
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D4B7D40E;
	Sat, 18 May 2024 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ByCjHYP+"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B47D3EC;
	Sat, 18 May 2024 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036296; cv=none; b=tfIgHLvYFr4leaDvHP2/T/7u3XLItdQxQ4Q5dzEjP0AFB0HRwGzNUub9gclD7iDHxhGvmn3I5yAqsDK2Q2mmqM8qb/iH9crBOfQhomht/KxaW0JmxgKvQkOwwAPfP4JcQhhxKzkPsdLjKa0gfmXRNwcnx3BrZtbr6rd+v60B1qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036296; c=relaxed/simple;
	bh=rhZhZefae0cACIc1qoO4sSovAhZuNhhVUznYmRvSPBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8wOvrer/hYcbSbaUj2lDB79Nz7BhhoL8aNVe3jFk7FMSIRXUL0zl588MjKscWqk3nUxONy7YcEr5YmpYw3Al/bk7UR+hCRJU/CQtrCB+N4qpecwi3N+cnlMt2vLJZpNRfzEMtAZpKulwY/X21Vb3sKYJzCNHPmguYmklnPXPQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ByCjHYP+; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ICii3d055090;
	Sat, 18 May 2024 07:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036284;
	bh=gd1CjXaEXO/rtJ2evrOBvHAAqqCDyXL/UmbLLmBB14E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ByCjHYP+PB07MHKGquA8vnYjE04cA+G93Mc87eFvhoHPd+51/1AReXp032LxL10X7
	 rR4ZUGsyPI3dcQ/Tmw38tfd9a6yPCxndOeBTzGQ6h5ItH+L3USN7+47v+t07kVJ+jA
	 1Lkj4qY5xcX9cYx0K30qgVdFteSLFLKlJAcAeoaY=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ICiiT1130472
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:44:44 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:44:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:44:43 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9h041511;
	Sat, 18 May 2024 07:44:39 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 27/28] net: ethernet: ti: cpsw-proxy-client: add helper to detach virtual ports
Date: Sat, 18 May 2024 18:12:33 +0530
Message-ID: <20240518124234.2671651-28-s-vadapalli@ti.com>
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

Add the helper function "detach_virtual_ports()" to release all resources
held by the virtual ports and send the ETHFW_VIRT_PORT_DETACH request for
each virtual port. This notifies EthFw that the virtual ports are unused.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index 56311b019376..90be8bb0e37d 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -672,6 +672,29 @@ static int allocate_port_resources(struct cpsw_proxy_priv *proxy_priv)
 	return -EIO;
 }
 
+static void detach_virtual_ports(struct cpsw_proxy_priv *proxy_priv)
+{
+	struct cpsw_proxy_req_params *req_p;
+	struct virtual_port *vport;
+	struct message resp_msg;
+	u32 port_id, i;
+	int ret;
+
+	free_port_resources(proxy_priv);
+	for (i = 0; i < proxy_priv->num_virt_ports; i++) {
+		vport = &proxy_priv->virt_ports[i];
+		port_id = vport->port_id;
+		mutex_lock(&proxy_priv->req_params_mutex);
+		req_p = &proxy_priv->req_params;
+		req_p->request_type = ETHFW_VIRT_PORT_DETACH;
+		req_p->token = vport->port_token;
+		ret = send_request_get_response(proxy_priv, &resp_msg);
+		mutex_unlock(&proxy_priv->req_params_mutex);
+		if (ret)
+			dev_err(proxy_priv->dev, "detaching virtual port %u failed\n", port_id);
+	}
+}
+
 static void free_tx_chns(void *data)
 {
 	struct cpsw_proxy_priv *proxy_priv = data;
-- 
2.40.1


