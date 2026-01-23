Return-Path: <netdev+bounces-252679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FXWBoorc2mTswAAu9opvQ
	(envelope-from <netdev+bounces-252679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:04:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D52F72261
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AB1B30048C7
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB364339714;
	Fri, 23 Jan 2026 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjqxZ/Up"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F08331204
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155463; cv=none; b=bqbnphnVq13tQ+hzGRGb7vT+R9Pl2pDf9d0hARNCY+V3xjQhRTvRh0xfL1Cb3jawXHSUUwiPrU0O1u7fOJhNPJGLwP1DelaSHJfpng5GQ6Lf0vLfOnvbx9odb7Ihnc5veHOhZGbEWvL459S2++pRBwlORTEWesaavyBb9hd/8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155463; c=relaxed/simple;
	bh=dZaT9cSBNeM285PphXlT0/xB70LYV4cXn5X4Ku0z8wY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=raTNGzuxAsHoIfOXtYh6GT/YVn7uI/xtBswoBtxgJ7SOKpCW0jQeAINNJmWysL6SEIZHnY6caRSv+726rgjk4YoNLWAOvAYFCTHu3NRt0/X2k2Z1Y8WmPyDxuXQTBdcF9yUuS9dZ+skZw1Es58dupZ7JxWXKXvDyQmML0M8mo0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjqxZ/Up; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1233c155a42so2712809c88.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 00:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769155461; x=1769760261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9iUFL56beVY/iIEgFqGvI5oxeFHwKFv4+mDAz58zBhU=;
        b=VjqxZ/UpcakcriUiUkAdwZwlBsLwNLZTpHHvSQXevcgctZA3obknNAGHu+geIKEENi
         ugtxTOA2XzFyKUERGjoDA1QIbSTa9XCbRQjkIKuM8bY1pCMkzhOdXyq91bMnEn7lwQA1
         aCBKTawUbWl7bADYmNxCT/pyP47+KE0fmPyJjxDyng+uJPKY9lXn7gQnorSQd09hk/Yl
         Mz4HAOytYjxILh2GuflFinRd730wN5BLI221u6hlGO3HAGpbk43kYxtLUHwuYqpxoWZb
         V/j1pDRqgiRQGTDop3jXf47gRgXZOjLSlt8idfxNiAsyhYwPiquqZKooYA9c9xv+CML3
         I3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769155461; x=1769760261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iUFL56beVY/iIEgFqGvI5oxeFHwKFv4+mDAz58zBhU=;
        b=iHwSTB5XITC2LTARt0h9rMpzCG6N7VDT8JaeB/K3XBwc96Y6PaZPOcXsJvYBrO9F/x
         6xkZKGOGiwr8buANKFnP1gfRHAFO01FnNtFjZ0k+hALV5mPl93+ojtaFhr91GHI3+EtD
         er1SsYt8OQQSpyMl7M9ZmS/emjOkC74/M40RYidN9uvhHrsLkFCOrnTuc30HnLMhyqNy
         NEz3vh6j78vkTxdUwiMeIHgAyeJYYtGYAD3M20U2JwF87brsZunlISQALPx+hjmYjKnI
         9W7+WvnPbcv6MZIsuifme9UsK9A3SlmG/WAcg4F7USi6WFwrVnauEdQO2vAfGCTYj3+7
         PpuA==
X-Gm-Message-State: AOJu0YzN8/8u/FvjjwoCykUE2Pv0kCoCe96jQw7Oti2Cj2VYZTwfplOl
	jG9pWFqn6NEZ+aYAI9h90H1l1b2cswco6UYeh8wgW/u4TslUR1neOi/tjSFyIFfY
X-Gm-Gg: AZuq6aKHJKl0+LfBTwg+di/cCgd77vVdNxSQKo7LgpmqbysUAGysbY00v8SjIyApo+g
	o24rd12mXv/TOwbbDbfe1T8i4zdRRBw4WvK9Oh9eqoa+2F0GQFhqofqtYpHLQK39WTBsszndjAv
	HKyj2eXEC5mEDgoOE9B1by8ZBX+zogTxjDKeAm5Xi/6Ry+yib1YgajPcpVWuhMgnjc3xZ+Q3mPG
	nDWihLyWPF14x0ckQo4svOnxnPJl/nf5rJKigWy904B2J3YsRCCYPr6YL9/17209FXsIr5S1FWz
	mJMgtdVqzmQe2Gz/bt3+8np9FPKDSVQTc6PVmoZEIDYtYeZJxxBNZEq4YuVXgDAd/BrrCYuz7y+
	xnbGQc93fn+Ln0fZom82tcX9qoRkiwmLSvJrqBFczTqFRnZrDxyf7rOSNbEZhEX7rvYI3hEUC+m
	LhKgxHPLRZWP5gGXhG3Sj4vxwbDfqJrQmRg8fXWL3vD7DkO+SL/oa0datJXsi4x7Ft9Oce49KXH
	mXg6bmy9/1kncNQCsLp0kcQLBLtUZnfJSNAglXboHX8YEDjnSh1Ip2HZkNq/18qXfpyZQrXeBx1
	L/rx
X-Received: by 2002:a05:7022:fa8:b0:11a:335d:80d2 with SMTP id a92af1059eb24-1247dc08c24mr1070234c88.35.1769155461161;
        Fri, 23 Jan 2026 00:04:21 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d997f7bsm3395840c88.11.2026.01.23.00.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 00:04:20 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] net: usb: sr9700: rename register write commands for clarity
Date: Fri, 23 Jan 2026 00:03:58 -0800
Message-ID: <20260123080409.64165-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,korsgaard.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252679-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D52F72261
X-Rspamd-Action: no action

SR_WR_REG and SR_WR_REGS may be confused at a cursory glance. Rename
them to be more easily differentiated to prevent this.

Suggested-by: Andrew Lunn <andrew+netdev@lunn.ch>
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/sr9700.c | 8 ++++----
 drivers/net/usb/sr9700.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 9c7cd0db1768..e518e1710b18 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -37,7 +37,7 @@ static int sr_write(struct usbnet *dev, u8 reg, u16 length, void *data)
 {
 	int err;
 
-	err = usbnet_write_cmd(dev, SR_WR_REGS, SR_REQ_WR_REG, 0, reg, data,
+	err = usbnet_write_cmd(dev, SR_WR_MULTIPLE_REGS, SR_REQ_WR_REG, 0, reg, data,
 			       length);
 	if ((err >= 0) && (err < length))
 		err = -EINVAL;
@@ -51,20 +51,20 @@ static int sr_read_reg(struct usbnet *dev, u8 reg, u8 *value)
 
 static int sr_write_reg(struct usbnet *dev, u8 reg, u8 value)
 {
-	return usbnet_write_cmd(dev, SR_WR_REG, SR_REQ_WR_REG,
+	return usbnet_write_cmd(dev, SR_WR_SINGLE_REG, SR_REQ_WR_REG,
 				value, reg, NULL, 0);
 }
 
 static void sr_write_async(struct usbnet *dev, u8 reg, u16 length,
 			   const void *data)
 {
-	usbnet_write_cmd_async(dev, SR_WR_REGS, SR_REQ_WR_REG,
+	usbnet_write_cmd_async(dev, SR_WR_MULTIPLE_REGS, SR_REQ_WR_REG,
 			       0, reg, data, length);
 }
 
 static void sr_write_reg_async(struct usbnet *dev, u8 reg, u8 value)
 {
-	usbnet_write_cmd_async(dev, SR_WR_REG, SR_REQ_WR_REG,
+	usbnet_write_cmd_async(dev, SR_WR_SINGLE_REG, SR_REQ_WR_REG,
 			       value, reg, NULL, 0);
 }
 
diff --git a/drivers/net/usb/sr9700.h b/drivers/net/usb/sr9700.h
index 3212859830dc..5c04ea0306c7 100644
--- a/drivers/net/usb/sr9700.h
+++ b/drivers/net/usb/sr9700.h
@@ -150,8 +150,8 @@
 
 /* Register access commands and flags */
 #define	SR_RD_REGS		0x00
-#define	SR_WR_REGS		0x01
-#define	SR_WR_REG		0x03
+#define	SR_WR_MULTIPLE_REGS	0x01
+#define	SR_WR_SINGLE_REG	0x03
 #define	SR_REQ_RD_REG	(USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
 #define	SR_REQ_WR_REG	(USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
 
-- 
2.43.0


