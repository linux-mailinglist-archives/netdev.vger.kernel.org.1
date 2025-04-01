Return-Path: <netdev+bounces-178517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0ACA776CF
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F283AA008
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 08:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FB31EB5F0;
	Tue,  1 Apr 2025 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="asUcIdFW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="asUcIdFW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCC31EB1AF
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497274; cv=none; b=cg2NLiRJWNB5AsF1zYoPVy6UXb3RJ8p6BvfpN6ait6ILPEcIQiYxpnGkqw3Q9qFQRACDx88Fbnn1NqGwoiPWP3b9FyLMyyCbL97DCfrzAnYU7uxIoJ0mWXoHaRULfk2Js8TLVMVnnx2PzdTiiSA/XZCWgS6pW1CFPA0xnZOjP2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497274; c=relaxed/simple;
	bh=aU3au+otIKSxltUYnJ8K39yl1EqCoQKcIiDbdQBsWEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQuKuzq4Vwdd2w+tFAyyGG1FKYI1oXuovZLEncFI+NmPKi3dTqeburSfszDBQol8yxwmamp6/k3ERsUF1P2Mfl4dXtb2rcXoRx9WsJwyQ/u29we3eA8tarc7WDhMfphfiAVuZ9VYCNcE8p4NUxVXBNg43QibDa5keI44cQfK7qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=asUcIdFW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=asUcIdFW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A1DB1F38D;
	Tue,  1 Apr 2025 08:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743497271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAWzvUvIce3uGPLV0zmT3epi+cTKOT1jtdNwIQTSGNE=;
	b=asUcIdFWXuRZY/jfB+paOJV5NCPHdwX4aBxnvTYQhn/nv98h76KCXGw1HHEQq5NSmJp1aS
	i9gc73k/WAkFUAQhr3Tcjhnbe0z94HsOfgwm+tq0ZwpwjV0u4MkzSK9WKYEHKchR8Tlt9/
	Iw1lVKzqDiQMo9K5E/uVtDY8qCLM9SY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743497271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAWzvUvIce3uGPLV0zmT3epi+cTKOT1jtdNwIQTSGNE=;
	b=asUcIdFWXuRZY/jfB+paOJV5NCPHdwX4aBxnvTYQhn/nv98h76KCXGw1HHEQq5NSmJp1aS
	i9gc73k/WAkFUAQhr3Tcjhnbe0z94HsOfgwm+tq0ZwpwjV0u4MkzSK9WKYEHKchR8Tlt9/
	Iw1lVKzqDiQMo9K5E/uVtDY8qCLM9SY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C7B913A50;
	Tue,  1 Apr 2025 08:47:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SCTsATeo62cRcQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 01 Apr 2025 08:47:51 +0000
From: Oliver Neukum <oneukum@suse.com>
To: gregkh@linuxfoundation.org,
	bjorn@mork.no,
	loic.poulain@linaro.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCHv2 1/4] USB: wdm: handle IO errors in wdm_wwan_port_start
Date: Tue,  1 Apr 2025 10:45:38 +0200
Message-ID: <20250401084749.175246-2-oneukum@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250401084749.175246-1-oneukum@suse.com>
References: <20250401084749.175246-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
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


