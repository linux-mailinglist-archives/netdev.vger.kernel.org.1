Return-Path: <netdev+bounces-139442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 216769B2869
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 08:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75DB2819E9
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 07:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFADA18F2DB;
	Mon, 28 Oct 2024 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="mwuscbhN"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288C31422AB
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 07:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099348; cv=none; b=tX3nuG33UW6GPmVFs9p9jWW3Q2Mioy0IyoeJMUKN5nv/Wm2Lb3J2JWFQ+6wBy2AxI0RfP28GLmYuBlljuxMYKigz1L5k2dbBRVoiCICmXtU6lcwW+czv9sx0IkDbDXPJrum6bohrFF+gttO/blAekuGN1s869SwmNYmx/pnPv+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099348; c=relaxed/simple;
	bh=7CT19zqzfqf6vQD4ld+QXm2X3P0kRN9QLEmcWLUS7x4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CTBN8HjfpX1TQAA0Yb9mZwA5p7QQZjrjg6piEtUabz0Zz2duAehdHkHzpIpOD0nAVBji9g3uIm9L7hCkoZmR8DaGt1cpkASsDCB3mHTiJvfbITBEo2kUZAkMzh6Jl+1Y7G0XGKEy0dYTb4uqDBIRgbf7mxJqAmpREKg938iIsYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=mwuscbhN; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730099343;
	bh=SDSGI3WkOErni2SLVzkh2hftg5VUUWYduQLoSwOC25M=;
	h=From:Date:Subject:To:Cc;
	b=mwuscbhNzWEgPbOQHrcpZ4vKpmA+3OcIi2oWHMCRHnmKWkec0DmJbwGQc9XkGQ4+6
	 St/+Z95Lvb17cmuabceT2hVOSYhO984CW6jerf2BHBRkfdh0IS2HDkWfIRKRq5uUpk
	 jHFZt444Ihy/xhQDm5zQkkfpCXcFw49r0QVo52vI+o/yf28Qudy/3LXvs42U9qHrNo
	 2JGtvbhTp+KK6/Sf69isp3MF9jFrXLH+kLDnn7jj0HV15LMVLAFNEfVezlzZDC+5ti
	 yXF7qgMdsfl6HQotIIctjPLl2OkHoFBOWrogtJg4bhEEmarfRYMyp6Ua1qePyXJNPu
	 L3s9NOTDK2Xxg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id F258669EC8; Mon, 28 Oct 2024 15:09:03 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 28 Oct 2024 15:08:34 +0800
Subject: [PATCH net-next] net: ncsi: check for netlink-driven responses
 before requiring a handler
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-ncsi-arb-opcode-v1-1-9d65080908b9@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAHE4H2cC/x3MPQqAMAxA4atIZgO2ihSvIg79iZolLa2IIL27x
 fEb3nuhUGYqsHQvZLq5cJQG1XfgTysHIYdm0IOe1KANii+MNjuMycdAaMdpDsEZY2YNrUqZdn7
 +4wpCFwo9F2y1fjH1r+NrAAAA
X-Change-ID: 20241028-ncsi-arb-opcode-a346ddb88862
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Currently, the NCSI response path will look up an opcode-specific
handler for all incoming response messages. However, we may be receiving
a response from a netlink-generated request, which may not have a
corresponding in-kernel handler for that request opcode. In that case,
we'll drop the response because we didn't find a opcode-specific
handler.

Perform the lookup for the pending request (and hence for
NETLINK_DRIVEN) before requiring an in-kernel handler, and defer the
requirement for a corresponding kernel request until we know it's a
kernel-driven command.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/ncsi/ncsi-rsp.c | 61 ++++++++++++++++++++++++-----------------------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index e28be33bdf2c487c0fbfe3a1b4de6f52c8f923cc..882767c138895eba5bd7e413b7edb6480d5807bf 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -1205,12 +1205,6 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	if (!nrh) {
-		netdev_err(nd->dev, "Received unrecognized packet (0x%x)\n",
-			   hdr->type);
-		return -ENOENT;
-	}
-
 	/* Associate with the request */
 	spin_lock_irqsave(&ndp->lock, flags);
 	nr = &ndp->requests[hdr->id];
@@ -1228,43 +1222,42 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 
 	/* Validate the packet */
 	spin_unlock_irqrestore(&ndp->lock, flags);
-	payload = nrh->payload;
+	payload = nrh ? nrh->payload : -1;
 	if (payload < 0)
 		payload = ntohs(hdr->length);
+
 	ret = ncsi_validate_rsp_pkt(nr, payload);
-	if (ret) {
+	if (ret)
 		netdev_warn(ndp->ndev.dev,
 			    "NCSI: 'bad' packet ignored for type 0x%x\n",
 			    hdr->type);
 
-		if (nr->flags == NCSI_REQ_FLAG_NETLINK_DRIVEN) {
-			if (ret == -EPERM)
-				goto out_netlink;
-			else
-				ncsi_send_netlink_err(ndp->ndev.dev,
-						      nr->snd_seq,
-						      nr->snd_portid,
-						      &nr->nlhdr,
-						      ret);
-		}
-		goto out;
-	}
-
-	/* Process the packet */
-	ret = nrh->handler(nr);
-	if (ret)
-		netdev_err(ndp->ndev.dev,
-			   "NCSI: Handler for packet type 0x%x returned %d\n",
-			   hdr->type, ret);
-
-out_netlink:
 	if (nr->flags == NCSI_REQ_FLAG_NETLINK_DRIVEN) {
-		ret = ncsi_rsp_handler_netlink(nr);
-		if (ret) {
-			netdev_err(ndp->ndev.dev,
-				   "NCSI: Netlink handler for packet type 0x%x returned %d\n",
-				   hdr->type, ret);
+		/* netlink driven: forward response to netlink socket */
+		if (!ret || ret == -EPERM)
+			ncsi_rsp_handler_netlink(nr);
+		else
+			ncsi_send_netlink_err(ndp->ndev.dev,
+					      nr->snd_seq,
+					      nr->snd_portid,
+					      &nr->nlhdr,
+					      ret);
+	} else if (nrh) {
+		/* not netlink driven: process the packet in the kernel. We
+		 * need to have a handler for this
+		 */
+		if (!ret) {
+			ret = nrh->handler(nr);
+			if (ret)
+				netdev_err(ndp->ndev.dev,
+					   "NCSI: Handler for packet type 0x%x returned %d\n",
+					   hdr->type, ret);
 		}
+
+	} else {
+		netdev_err(nd->dev, "Received unrecognized packet (0x%x)\n",
+			   hdr->type);
+		ret = -ENOENT;
 	}
 
 out:

---
base-commit: 03fc07a24735e0be8646563913abf5f5cb71ad19
change-id: 20241028-ncsi-arb-opcode-a346ddb88862

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


