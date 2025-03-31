Return-Path: <netdev+bounces-178296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E78B3A766D5
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE11188941C
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892CA211710;
	Mon, 31 Mar 2025 13:26:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96E22116F1
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743427586; cv=none; b=XTx+Fqc6+Y20Zl3IwtHGVRelV6eUbpED9ZypvmwVptQ7HFfrBd/4uKW4WPXpG1s5uV3spncxY03G56S4nuwL3hR0M2r19vMPHetX91nQHlCSsbGGonyG98l29k8AE1H9F6YHw00TUsT/CyWCph3NmOhYj1z6db9q09Ha72zOnBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743427586; c=relaxed/simple;
	bh=aU3au+otIKSxltUYnJ8K39yl1EqCoQKcIiDbdQBsWEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DImJFtDB4CfyjAxwkrHsmtXigURJZ+cLYyHnWR7Ji1OdNwawGO1wQzD+3N4qckGnqHcASWbQOVG8nCG2BxU451dcE1YcoFOdqfYxtuHzPMg5Ola61RDsC6s+XEJU4hWhoRzNYkR8LP86OmBV2ilKSICDjkwzX342h7vRsNWCx+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF4C1211EA;
	Mon, 31 Mar 2025 13:26:16 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C52AA13A56;
	Mon, 31 Mar 2025 13:26:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QCMJL/iX6meJIQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Mon, 31 Mar 2025 13:26:16 +0000
From: Oliver Neukum <oneukum@suse.com>
To: gregkh@linuxfoundation.org,
	bjorn@mork.no,
	loic.poulain@linaro.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 1/4] USB: wdm: handle IO errors in wdm_wwan_port_start
Date: Mon, 31 Mar 2025 15:25:01 +0200
Message-ID: <20250331132614.51902-2-oneukum@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331132614.51902-1-oneukum@suse.com>
References: <20250331132614.51902-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: EF4C1211EA
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

In case submitting the URB fails we must undo
what we've done so far.

Fixes: cac6fb015f71 ("usb: class: cdc-wdm: WWAN framework integration")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/usb/class/cdc-wdm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 856488a7cb6b..12038aa43942 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -831,6 +831,7 @@ static struct usb_class_driver wdm_class = {
 static int wdm_wwan_port_start(struct wwan_port *port)
 {
 	struct wdm_device *desc = wwan_port_get_drvdata(port);
+	int rv;
 
 	/* The interface is both exposed via the WWAN framework and as a
 	 * legacy usbmisc chardev. If chardev is already open, just fail
@@ -850,7 +851,15 @@ static int wdm_wwan_port_start(struct wwan_port *port)
 	wwan_port_txon(port);
 
 	/* Start getting events */
-	return usb_submit_urb(desc->validity, GFP_KERNEL);
+	rv = usb_submit_urb(desc->validity, GFP_KERNEL);
+	if (rv < 0) {
+		wwan_port_txoff(port);
+		desc->manage_power(desc->intf, 0);
+		/* this must be last lest we race with chardev open */
+		clear_bit(WDM_WWAN_IN_USE, &desc->flags);
+	}
+
+	return rv;
 }
 
 static void wdm_wwan_port_stop(struct wwan_port *port)
-- 
2.49.0


