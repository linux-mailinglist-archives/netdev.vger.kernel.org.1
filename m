Return-Path: <netdev+bounces-97080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35458C90E8
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6EC81C2100E
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737B14CB4B;
	Sat, 18 May 2024 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tY6V2iu/"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2F945BE3;
	Sat, 18 May 2024 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036202; cv=none; b=LXTaMajYsofvfKriuiHXxPeT0ITeE4wmnB+8RjrNO+qMtGdU9qmwG8cVzabi4JTuZudE9YMJB3XpZq3uzczWXbU0jz9vhvcRry3zpsHWX402RDRWGQMK/jKtNi3q/jUwUpU3pENBBqCRhgpAjmrP1eeIcX4yJkkRwOGd6DSGNAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036202; c=relaxed/simple;
	bh=4gljx4eIYU2HWXd7cv80y4hDjxq0FtnAm5MHqUBitOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDBcuxso24UPHx17+KHQgiD+pQs/guRYqJcweBEDOP4V64arq/N4f//57xB+G9+CDSqXtXL5hIrQVVwPwaAc1Kj8XfYxuvIIen+CvBxHYc2DzGZwNXK4fwhODV/C5wWS4cLjlBctwZm7TLc0RY/PfgGf/jEKphiy29wfFSvOBFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tY6V2iu/; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ICh24Z110064;
	Sat, 18 May 2024 07:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036182;
	bh=pwsEoFlTYu9+D4B/5o/60VHvS9uGtvdc6Hi7yXMznp8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tY6V2iu/EDwPj0nVEsIeZdPPd6MvjjVGGJsg7KSLZ9sXL5f37GVOCzmoJ92Ckk/1z
	 qY3bvG+qZ90Zc1SHF5eILN13EIeekOmy+p5NdDm7OgtBMh8SyXVAMcuw6eFght5Mx4
	 EtVbNtVyfVqsg6XXkkAKZ7Uuwwueq7NnBCrPSM8g=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ICh26n129305
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:43:02 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:43:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:43:02 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9L041511;
	Sat, 18 May 2024 07:42:58 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 05/28] net: ethernet: ti: cpsw-proxy-client: enable message exchange with EthFw
Date: Sat, 18 May 2024 18:12:11 +0530
Message-ID: <20240518124234.2671651-6-s-vadapalli@ti.com>
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

Add a new function which sends RPMsg requests to EthFw and shares the
response for the request. The RPMsg callback function copies the response
it receives from EthFw to the driver's private member, thereby allowing
the response to be shared with the newly added function which sends the
request.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 112 +++++++++++++++++++-
 1 file changed, 111 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index 3533f4ce1e3f..70b8cfe67921 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -12,6 +12,8 @@
 
 #include "ethfw_abi.h"
 
+#define ETHFW_RESPONSE_TIMEOUT_MS	500
+
 struct cpsw_proxy_req_params {
 	struct message	req_msg;	/* Request message to be filled */
 	u32		token;
@@ -31,16 +33,50 @@ struct cpsw_proxy_req_params {
 struct cpsw_proxy_priv {
 	struct rpmsg_device		*rpdev;
 	struct device			*dev;
+	struct cpsw_proxy_req_params	req_params;
+	struct message			resp_msg;
+	struct completion		wait_for_response;
+	int				resp_msg_len;
 };
 
 static int cpsw_proxy_client_cb(struct rpmsg_device *rpdev, void *data,
 				int len, void *priv, u32 src)
 {
+	struct cpsw_proxy_priv *proxy_priv = dev_get_drvdata(&rpdev->dev);
+	struct response_message_header *resp_msg_hdr;
+	struct message *msg = (struct message *)data;
+	struct cpsw_proxy_req_params *req_params;
 	struct device *dev = &rpdev->dev;
+	u32 msg_type, resp_id;
 
 	dev_dbg(dev, "callback invoked\n");
+	msg_type = msg->msg_hdr.msg_type;
+	switch (msg_type) {
+	case ETHFW_MSG_RESPONSE:
+		resp_msg_hdr = (struct response_message_header *)msg;
+		resp_id = resp_msg_hdr->response_id;
+		req_params = &proxy_priv->req_params;
 
-	return 0;
+		if (unlikely(resp_id == req_params->request_id - 1)) {
+			dev_info(dev, "ignoring late response for request: %u\n",
+				 resp_id);
+			return 0;
+		} else if (unlikely(resp_id != req_params->request_id)) {
+			dev_err(dev, "expected response id: %u but received %u\n",
+				req_params->request_id, resp_id);
+			return -EINVAL;
+		}
+
+		/* Share response */
+		memcpy(&proxy_priv->resp_msg, msg, len);
+		proxy_priv->resp_msg_len = len;
+		complete(&proxy_priv->wait_for_response);
+		return 0;
+
+	default:
+		dev_err(dev, "unsupported message received from EthFw\n");
+		return -EOPNOTSUPP;
+	}
 }
 
 static int create_request_message(struct cpsw_proxy_req_params *req_params)
@@ -166,6 +202,79 @@ static int create_request_message(struct cpsw_proxy_req_params *req_params)
 	return 0;
 }
 
+/* Send a request to EthFw and receive the response for request.
+ * Since the response is received by the callback function, it is
+ * copied to "resp_msg" member of "struct cpsw_proxy_priv" to
+ * allow sharing it with the following function.
+ *
+ * The request parameters within proxy_priv are expected to be set
+ * correctly by the caller. The caller is also expected to acquire
+ * lock before invoking this function, since requests and responses
+ * to/from EthFw are serialized.
+ */
+static int send_request_get_response(struct cpsw_proxy_priv *proxy_priv,
+				     struct message *response)
+{
+	struct cpsw_proxy_req_params *req_params = &proxy_priv->req_params;
+	struct message *send_msg = &req_params->req_msg;
+	struct rpmsg_device *rpdev = proxy_priv->rpdev;
+	struct response_message_header *resp_msg_hdr;
+	struct device *dev = proxy_priv->dev;
+	unsigned long timeout;
+	u32 resp_status;
+	bool retry = 0;
+	int ret;
+
+	ret = create_request_message(req_params);
+	if (ret) {
+		dev_err(dev, "failed to create request %d\n", ret);
+		goto err;
+	}
+
+	/* Send request and wait for callback function to acknowledge
+	 * receiving the response.
+	 */
+	reinit_completion(&proxy_priv->wait_for_response);
+	ret = rpmsg_send(rpdev->ept, (void *)(send_msg),
+			 sizeof(struct message));
+	if (ret) {
+		dev_err(dev, "failed to send rpmsg\n");
+		goto err;
+	}
+	timeout = msecs_to_jiffies(ETHFW_RESPONSE_TIMEOUT_MS);
+	ret = wait_for_completion_timeout(&proxy_priv->wait_for_response,
+					  timeout);
+	if (!ret) {
+		dev_err(dev, "response timedout\n");
+		ret = -ETIMEDOUT;
+		goto err;
+	}
+	ret = 0;
+
+	/* Store response shared by callback function */
+	memcpy(response, &proxy_priv->resp_msg, proxy_priv->resp_msg_len);
+	resp_msg_hdr = (struct response_message_header *)response;
+	resp_status = resp_msg_hdr->response_status;
+
+	if (unlikely(resp_status != ETHFW_RES_OK)) {
+		if (resp_status == ETHFW_RES_TRY_AGAIN) {
+			dev_info(dev, "resending request\n");
+			ret = -EAGAIN;
+			retry = 1;
+		} else {
+			dev_err(dev, "bad response status: %d\n", resp_status);
+			ret = -EIO;
+		}
+	}
+
+err:
+	req_params->request_id++;
+	if (retry)
+		ret = send_request_get_response(proxy_priv, response);
+
+	return ret;
+}
+
 static int cpsw_proxy_client_probe(struct rpmsg_device *rpdev)
 {
 	struct cpsw_proxy_priv *proxy_priv;
@@ -176,6 +285,7 @@ static int cpsw_proxy_client_probe(struct rpmsg_device *rpdev)
 
 	proxy_priv->rpdev = rpdev;
 	proxy_priv->dev = &rpdev->dev;
+	dev_set_drvdata(proxy_priv->dev, proxy_priv);
 	dev_dbg(proxy_priv->dev, "driver probed\n");
 
 	return 0;
-- 
2.40.1


