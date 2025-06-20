Return-Path: <netdev+bounces-199738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441D4AE19ED
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AEAF7AA587
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 11:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0FB257AF2;
	Fri, 20 Jun 2025 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+2tHfKb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C786278F4A;
	Fri, 20 Jun 2025 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750418568; cv=none; b=t5tkmqP2Zfji1FRnOaki40aF25Ox6SUoJtMpfaAMY2G4eTjww9xB/k8iXyS+SbkSbKPUri7P7wkcVph/gjrwq8O0pPKINfLNc5DbTTsqwRPSgOiRfrN7wsYBWlXGVRWYZruAoI+cnzXiXsPxatlbVnjh5x1XOk6b3vlpfeLtrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750418568; c=relaxed/simple;
	bh=QBFJzVVrfVoyGIEd3fk1LqSlNLHOElDjvujD8eKPQIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eZB99bqX+6prafH1fsfZE67Oi+jsnOa6UAwCoSly6BGhT0G5AHX35JIuCBTWnoytLUt4ZRq/n4xsYRT1IEFXUykmm8OFz2J3lIJH49e4kNUe2IzsIHRZbrzuV+KgcVaub7+6LTGRUHGiBnlw/fg4VCw7Tin9yO044cTwtRrPQzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+2tHfKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC88C4CEE3;
	Fri, 20 Jun 2025 11:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750418568;
	bh=QBFJzVVrfVoyGIEd3fk1LqSlNLHOElDjvujD8eKPQIw=;
	h=From:To:Cc:Subject:Date:From;
	b=H+2tHfKbk0CjhBzyiqzIoioVXNchfu684gcdExNICGG0E8f9LWlKIwb/PD2xKkMhP
	 NpeGKwOYqpIKscYKovXrO1h0TY7rTFS+5pcY79bZOxkXLXt2xec6cIpIj+zIUn98H9
	 q39XaAPds05Lm2Ey2FcE/UQyYOBacES9fXQuAy5BzsqvNlhvRDN3VNEI1Trgi8Qm9d
	 jxno7LYJxiWYFGDZftxZKwl3/bgCn8hV1Hy3Y9/n2qwIj9RkCUke2eiCzRgzmfb8al
	 l188xmUF8JPUgmBcPRs5FWOAf1yWii7elT1K32xAp1kTYK4B1/lIcOwIZLDLNVQ5Hz
	 eAJskdotPxunw==
From: Arnd Bergmann <arnd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] caif: reduce stack size, again
Date: Fri, 20 Jun 2025 13:22:39 +0200
Message-Id: <20250620112244.3425554-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

I tried to fix the stack usage in this function a couple of years ago,
but there is still a problem with the latest gcc versions in some
configurations:

net/caif/cfctrl.c:553:1: error: the frame size of 1296 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]

Reduce this once again, with a separate cfctrl_link_setup() function that
holds the bulk of all the local variables. It also turns out that the
param[] array that takes up a large portion of the stack is write-only
and can be left out here.

Fixes: ce6289661b14 ("caif: reduce stack size with KASAN")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/caif/cfctrl.c | 294 +++++++++++++++++++++++-----------------------
 1 file changed, 144 insertions(+), 150 deletions(-)

diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
index 20139fa1be1f..06b604cf9d58 100644
--- a/net/caif/cfctrl.c
+++ b/net/caif/cfctrl.c
@@ -351,17 +351,154 @@ int cfctrl_cancel_req(struct cflayer *layr, struct cflayer *adap_layer)
 	return found;
 }
 
+static int cfctrl_link_setup(struct cfctrl *cfctrl, struct cfpkt *pkt, u8 cmdrsp)
+{
+	u8 len;
+	u8 linkid = 0;
+	enum cfctrl_srv serv;
+	enum cfctrl_srv servtype;
+	u8 endpoint;
+	u8 physlinkid;
+	u8 prio;
+	u8 tmp;
+	u8 *cp;
+	int i;
+	struct cfctrl_link_param linkparam;
+	struct cfctrl_request_info rsp, *req;
+
+	memset(&linkparam, 0, sizeof(linkparam));
+
+	tmp = cfpkt_extr_head_u8(pkt);
+
+	serv = tmp & CFCTRL_SRV_MASK;
+	linkparam.linktype = serv;
+
+	servtype = tmp >> 4;
+	linkparam.chtype = servtype;
+
+	tmp = cfpkt_extr_head_u8(pkt);
+	physlinkid = tmp & 0x07;
+	prio = tmp >> 3;
+
+	linkparam.priority = prio;
+	linkparam.phyid = physlinkid;
+	endpoint = cfpkt_extr_head_u8(pkt);
+	linkparam.endpoint = endpoint & 0x03;
+
+	switch (serv) {
+	case CFCTRL_SRV_VEI:
+	case CFCTRL_SRV_DBG:
+		if (CFCTRL_ERR_BIT & cmdrsp)
+			break;
+		/* Link ID */
+		linkid = cfpkt_extr_head_u8(pkt);
+		break;
+	case CFCTRL_SRV_VIDEO:
+		tmp = cfpkt_extr_head_u8(pkt);
+		linkparam.u.video.connid = tmp;
+		if (CFCTRL_ERR_BIT & cmdrsp)
+			break;
+		/* Link ID */
+		linkid = cfpkt_extr_head_u8(pkt);
+		break;
+
+	case CFCTRL_SRV_DATAGRAM:
+		linkparam.u.datagram.connid = cfpkt_extr_head_u32(pkt);
+		if (CFCTRL_ERR_BIT & cmdrsp)
+			break;
+		/* Link ID */
+		linkid = cfpkt_extr_head_u8(pkt);
+		break;
+	case CFCTRL_SRV_RFM:
+		/* Construct a frame, convert
+		 * DatagramConnectionID
+		 * to network format long and copy it out...
+		 */
+		linkparam.u.rfm.connid = cfpkt_extr_head_u32(pkt);
+		cp = (u8 *) linkparam.u.rfm.volume;
+		for (tmp = cfpkt_extr_head_u8(pkt);
+		     cfpkt_more(pkt) && tmp != '\0';
+		     tmp = cfpkt_extr_head_u8(pkt))
+			*cp++ = tmp;
+		*cp = '\0';
+
+		if (CFCTRL_ERR_BIT & cmdrsp)
+			break;
+		/* Link ID */
+		linkid = cfpkt_extr_head_u8(pkt);
+
+		break;
+	case CFCTRL_SRV_UTIL:
+		/* Construct a frame, convert
+		 * DatagramConnectionID
+		 * to network format long and copy it out...
+		 */
+		/* Fifosize KB */
+		linkparam.u.utility.fifosize_kb = cfpkt_extr_head_u16(pkt);
+		/* Fifosize bufs */
+		linkparam.u.utility.fifosize_bufs = cfpkt_extr_head_u16(pkt);
+		/* name */
+		cp = (u8 *) linkparam.u.utility.name;
+		caif_assert(sizeof(linkparam.u.utility.name)
+			     >= UTILITY_NAME_LENGTH);
+		for (i = 0; i < UTILITY_NAME_LENGTH && cfpkt_more(pkt); i++) {
+			tmp = cfpkt_extr_head_u8(pkt);
+			*cp++ = tmp;
+		}
+		/* Length */
+		len = cfpkt_extr_head_u8(pkt);
+		linkparam.u.utility.paramlen = len;
+		/* Param Data */
+		cp = linkparam.u.utility.params;
+		while (cfpkt_more(pkt) && len--) {
+			tmp = cfpkt_extr_head_u8(pkt);
+			*cp++ = tmp;
+		}
+		if (CFCTRL_ERR_BIT & cmdrsp)
+			break;
+		/* Link ID */
+		linkid = cfpkt_extr_head_u8(pkt);
+		/* Length */
+		len = cfpkt_extr_head_u8(pkt);
+		/* Param Data */
+		cfpkt_extr_head(pkt, NULL, len);
+		break;
+	default:
+		pr_warn("Request setup, invalid type (%d)\n", serv);
+		return -1;
+	}
+
+	rsp.cmd = CFCTRL_CMD_LINK_SETUP;
+	rsp.param = linkparam;
+	spin_lock_bh(&cfctrl->info_list_lock);
+	req = cfctrl_remove_req(cfctrl, &rsp);
+
+	if (CFCTRL_ERR_BIT == (CFCTRL_ERR_BIT & cmdrsp) ||
+		cfpkt_erroneous(pkt)) {
+		pr_err("Invalid O/E bit or parse error "
+				"on CAIF control channel\n");
+		cfctrl->res.reject_rsp(cfctrl->serv.layer.up, 0,
+				       req ? req->client_layer : NULL);
+	} else {
+		cfctrl->res.linksetup_rsp(cfctrl->serv.layer.up, linkid,
+					  serv, physlinkid,
+					  req ?  req->client_layer : NULL);
+	}
+
+	kfree(req);
+
+	spin_unlock_bh(&cfctrl->info_list_lock);
+
+	return 0;
+}
+
 static int cfctrl_recv(struct cflayer *layer, struct cfpkt *pkt)
 {
 	u8 cmdrsp;
 	u8 cmd;
-	int ret = -1;
-	u8 len;
-	u8 param[255];
+	int ret = 0;
 	u8 linkid = 0;
 	struct cfctrl *cfctrl = container_obj(layer);
-	struct cfctrl_request_info rsp, *req;
-
 
 	cmdrsp = cfpkt_extr_head_u8(pkt);
 	cmd = cmdrsp & CFCTRL_CMD_MASK;
@@ -374,150 +511,7 @@ static int cfctrl_recv(struct cflayer *layer, struct cfpkt *pkt)
 
 	switch (cmd) {
 	case CFCTRL_CMD_LINK_SETUP:
-		{
-			enum cfctrl_srv serv;
-			enum cfctrl_srv servtype;
-			u8 endpoint;
-			u8 physlinkid;
-			u8 prio;
-			u8 tmp;
-			u8 *cp;
-			int i;
-			struct cfctrl_link_param linkparam;
-			memset(&linkparam, 0, sizeof(linkparam));
-
-			tmp = cfpkt_extr_head_u8(pkt);
-
-			serv = tmp & CFCTRL_SRV_MASK;
-			linkparam.linktype = serv;
-
-			servtype = tmp >> 4;
-			linkparam.chtype = servtype;
-
-			tmp = cfpkt_extr_head_u8(pkt);
-			physlinkid = tmp & 0x07;
-			prio = tmp >> 3;
-
-			linkparam.priority = prio;
-			linkparam.phyid = physlinkid;
-			endpoint = cfpkt_extr_head_u8(pkt);
-			linkparam.endpoint = endpoint & 0x03;
-
-			switch (serv) {
-			case CFCTRL_SRV_VEI:
-			case CFCTRL_SRV_DBG:
-				if (CFCTRL_ERR_BIT & cmdrsp)
-					break;
-				/* Link ID */
-				linkid = cfpkt_extr_head_u8(pkt);
-				break;
-			case CFCTRL_SRV_VIDEO:
-				tmp = cfpkt_extr_head_u8(pkt);
-				linkparam.u.video.connid = tmp;
-				if (CFCTRL_ERR_BIT & cmdrsp)
-					break;
-				/* Link ID */
-				linkid = cfpkt_extr_head_u8(pkt);
-				break;
-
-			case CFCTRL_SRV_DATAGRAM:
-				linkparam.u.datagram.connid =
-				    cfpkt_extr_head_u32(pkt);
-				if (CFCTRL_ERR_BIT & cmdrsp)
-					break;
-				/* Link ID */
-				linkid = cfpkt_extr_head_u8(pkt);
-				break;
-			case CFCTRL_SRV_RFM:
-				/* Construct a frame, convert
-				 * DatagramConnectionID
-				 * to network format long and copy it out...
-				 */
-				linkparam.u.rfm.connid =
-				    cfpkt_extr_head_u32(pkt);
-				cp = (u8 *) linkparam.u.rfm.volume;
-				for (tmp = cfpkt_extr_head_u8(pkt);
-				     cfpkt_more(pkt) && tmp != '\0';
-				     tmp = cfpkt_extr_head_u8(pkt))
-					*cp++ = tmp;
-				*cp = '\0';
-
-				if (CFCTRL_ERR_BIT & cmdrsp)
-					break;
-				/* Link ID */
-				linkid = cfpkt_extr_head_u8(pkt);
-
-				break;
-			case CFCTRL_SRV_UTIL:
-				/* Construct a frame, convert
-				 * DatagramConnectionID
-				 * to network format long and copy it out...
-				 */
-				/* Fifosize KB */
-				linkparam.u.utility.fifosize_kb =
-				    cfpkt_extr_head_u16(pkt);
-				/* Fifosize bufs */
-				linkparam.u.utility.fifosize_bufs =
-				    cfpkt_extr_head_u16(pkt);
-				/* name */
-				cp = (u8 *) linkparam.u.utility.name;
-				caif_assert(sizeof(linkparam.u.utility.name)
-					     >= UTILITY_NAME_LENGTH);
-				for (i = 0;
-				     i < UTILITY_NAME_LENGTH
-				     && cfpkt_more(pkt); i++) {
-					tmp = cfpkt_extr_head_u8(pkt);
-					*cp++ = tmp;
-				}
-				/* Length */
-				len = cfpkt_extr_head_u8(pkt);
-				linkparam.u.utility.paramlen = len;
-				/* Param Data */
-				cp = linkparam.u.utility.params;
-				while (cfpkt_more(pkt) && len--) {
-					tmp = cfpkt_extr_head_u8(pkt);
-					*cp++ = tmp;
-				}
-				if (CFCTRL_ERR_BIT & cmdrsp)
-					break;
-				/* Link ID */
-				linkid = cfpkt_extr_head_u8(pkt);
-				/* Length */
-				len = cfpkt_extr_head_u8(pkt);
-				/* Param Data */
-				cfpkt_extr_head(pkt, &param, len);
-				break;
-			default:
-				pr_warn("Request setup, invalid type (%d)\n",
-					serv);
-				goto error;
-			}
-
-			rsp.cmd = cmd;
-			rsp.param = linkparam;
-			spin_lock_bh(&cfctrl->info_list_lock);
-			req = cfctrl_remove_req(cfctrl, &rsp);
-
-			if (CFCTRL_ERR_BIT == (CFCTRL_ERR_BIT & cmdrsp) ||
-				cfpkt_erroneous(pkt)) {
-				pr_err("Invalid O/E bit or parse error "
-						"on CAIF control channel\n");
-				cfctrl->res.reject_rsp(cfctrl->serv.layer.up,
-						       0,
-						       req ? req->client_layer
-						       : NULL);
-			} else {
-				cfctrl->res.linksetup_rsp(cfctrl->serv.
-							  layer.up, linkid,
-							  serv, physlinkid,
-							  req ? req->
-							  client_layer : NULL);
-			}
-
-			kfree(req);
-
-			spin_unlock_bh(&cfctrl->info_list_lock);
-		}
+		ret = cfctrl_link_setup(cfctrl, pkt, cmdrsp);
 		break;
 	case CFCTRL_CMD_LINK_DESTROY:
 		linkid = cfpkt_extr_head_u8(pkt);
@@ -544,9 +538,9 @@ static int cfctrl_recv(struct cflayer *layer, struct cfpkt *pkt)
 		break;
 	default:
 		pr_err("Unrecognized Control Frame\n");
+		ret = -1;
 		goto error;
 	}
-	ret = 0;
 error:
 	cfpkt_destroy(pkt);
 	return ret;
-- 
2.39.5


