Return-Path: <netdev+bounces-273118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDxeD9hSymkQ7wUAu9opvQ
	(envelope-from <netdev+bounces-273118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:39:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2019359829
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5047F3010B67
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565483BD644;
	Mon, 30 Mar 2026 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAIeWD0i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232F18FDDE;
	Mon, 30 Mar 2026 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867036; cv=none; b=CUrwRyQiw/p6yojD08qqeHaFAtCEFhwCCP1Pu3tixIlR2J9VjYsRaBHvVCuTrRfJSUkNOWExJZx5F70nLUeITBtmheRY0mN/LvAOsZVn0/B0/9dKkODPfOJtYiAKPIU0/zsZ/XzMD4nGXgf7rJ7vlsvUBGju7hAwg8tkjbDNi1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867036; c=relaxed/simple;
	bh=c1UJOJbhnuvVw3/vN6mUKkKNVK970uCZo6pBXU+o9IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cd857QvDRaDgdvGQfStdD2xgrwD79x3euPJ+t8EDq3FYYKVKdb2ZDXQ6VsQonubYqFFWrUu95dm8k6KwFywvuf6xAZYdcSdHEnsAMJzjsh/gVqXkzlj9jSNCXuUaDSFDqHLQdLCCpWPe73zajDSJAdO7HAMrNVAlhgTOwR1LkZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAIeWD0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1365AC2BCB2;
	Mon, 30 Mar 2026 10:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774867036;
	bh=c1UJOJbhnuvVw3/vN6mUKkKNVK970uCZo6pBXU+o9IA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nAIeWD0i6VC1tfp5A2kCQfL3tngLxrZN+DrbMzGiBR6rNBSFvqZH33iJ+QNZlONOA
	 3ETP9RIRUXzUhanKZdUwk2C6+Ni7kp0UmQUxQtv88MlldSiEWVgnaW7kc57dxRYXbx
	 KiLIaKJ+VF5rvqzJexITFZbzh8u/9/l6lGgP8/Eyw8ylDZ5sA78e2L/6BLGrQW8RyG
	 KueATLMMfJGlIdsW0enD9vrtiUBrxXILIGuzqSyaaysrX+iqsqLJRO3popM8Z+6Ecr
	 kBftVcnVe05FCFtI4wph7HsT38tFNYFflQK4NCaNf14lyrRYAXfqHPQxKkLxP6xqxQ
	 tY7VKNTu6mK5A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w79ze-0000000713U-02T7;
	Mon, 30 Mar 2026 12:37:14 +0200
From: Johan Hovold <johan@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/3] nfc: nfcmrvl: refactor endpoint lookup
Date: Mon, 30 Mar 2026 12:36:53 +0200
Message-ID: <20260330103655.1672331-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330103655.1672331-1-johan@kernel.org>
References: <20260330103655.1672331-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273118-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2019359829
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the common USB helper for looking up bulk and interrupt endpoints
instead of open coding.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/nfc/nfcmrvl/usb.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/usb.c b/drivers/nfc/nfcmrvl/usb.c
index ea7309453096..6c4711c869f0 100644
--- a/drivers/nfc/nfcmrvl/usb.c
+++ b/drivers/nfc/nfcmrvl/usb.c
@@ -288,9 +288,9 @@ static int nfcmrvl_probe(struct usb_interface *intf,
 {
 	struct nfcmrvl_usb_drv_data *drv_data;
 	struct nfcmrvl_private *priv;
-	int i;
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct nfcmrvl_platform_data config;
+	int ret;
 
 	/* No configuration for USB */
 	memset(&config, 0, sizeof(config));
@@ -302,21 +302,9 @@ static int nfcmrvl_probe(struct usb_interface *intf,
 	if (!drv_data)
 		return -ENOMEM;
 
-	for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
-		struct usb_endpoint_descriptor *ep_desc;
-
-		ep_desc = &intf->cur_altsetting->endpoint[i].desc;
-
-		if (!drv_data->bulk_tx_ep &&
-		    usb_endpoint_is_bulk_out(ep_desc)) {
-			drv_data->bulk_tx_ep = ep_desc;
-		} else if (!drv_data->bulk_rx_ep &&
-			   usb_endpoint_is_bulk_in(ep_desc)) {
-			drv_data->bulk_rx_ep = ep_desc;
-		}
-	}
-
-	if (!drv_data->bulk_tx_ep || !drv_data->bulk_rx_ep)
+	ret = usb_find_common_endpoints(intf->cur_altsetting, &drv_data->bulk_rx_ep,
+					&drv_data->bulk_tx_ep, NULL, NULL);
+	if (ret)
 		return -ENODEV;
 
 	drv_data->udev = udev;
-- 
2.52.0


