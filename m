Return-Path: <netdev+bounces-178519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B681A776D7
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0A53AB11B
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 08:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FBC1EBA0C;
	Tue,  1 Apr 2025 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dhArXzm6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dhArXzm6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80AC1EB5C9
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497282; cv=none; b=YYtoL/ENuQNaz76fb4ERcDohufhtr5CTVGreKnU1vUnHFpm4VDBGrtBcyEo9/weCmZZxmwQ8hlQ4Vg/puu8o5qvDgtoTbbKaX2C7pNUjV3StAS+A6NbRtBBWnn4IIJaCNWbO46P5AwSEoisRa/tQmwsivE5CrMyD3SYzwVlgni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497282; c=relaxed/simple;
	bh=UOvbgh36k7g6Wtfi8274ibUf/WShtaJAHsIC1v4bej4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zgi9H+UVYm9FXh3aM8EXSWq6fh7H79RGafWd1dmk4GXnYlgKFTH4bh3kmYCNhvsSEl0zeXjYc/RL1Ah5ZIV5YADj0AMku9GKKHY8/wmHUx7e4F65gwlRz17/Rk9cCMqrQOKPXSigPg1hYHuLPncpn+GVC4O0WaXYjB3jo6kwJqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dhArXzm6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dhArXzm6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B0A21F38E;
	Tue,  1 Apr 2025 08:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743497271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4q1iJBZ60vR+H7kuKUrKnPh7h0YbIz5fYsxm9hBxh8=;
	b=dhArXzm6nLOAOr9gsYE/2Imhwfchek+ixEMCzSPxfTBKb8xxgUnzVYVp4Stb4GKenhUm1K
	zzyX/v4W6+WGXwrA1J18mPSPMp7KeVQr1DQi0mi2NFV9ILvzJPIn35FBHXd3JpCoI5oxuX
	gc5XRxcsRb5rqecG8q0ay4VZnxr9Qog=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743497271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4q1iJBZ60vR+H7kuKUrKnPh7h0YbIz5fYsxm9hBxh8=;
	b=dhArXzm6nLOAOr9gsYE/2Imhwfchek+ixEMCzSPxfTBKb8xxgUnzVYVp4Stb4GKenhUm1K
	zzyX/v4W6+WGXwrA1J18mPSPMp7KeVQr1DQi0mi2NFV9ILvzJPIn35FBHXd3JpCoI5oxuX
	gc5XRxcsRb5rqecG8q0ay4VZnxr9Qog=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EF8213691;
	Tue,  1 Apr 2025 08:47:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8LlCDjeo62cRcQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 01 Apr 2025 08:47:51 +0000
From: Oliver Neukum <oneukum@suse.com>
To: gregkh@linuxfoundation.org,
	bjorn@mork.no,
	loic.poulain@linaro.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCHv2 2/4] USB: wdm: close race between wdm_open and wdm_wwan_port_stop
Date: Tue,  1 Apr 2025 10:45:39 +0200
Message-ID: <20250401084749.175246-3-oneukum@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
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
X-Spam-Score: -6.80
X-Spam-Flag: NO

Clearing WDM_WWAN_IN_USE must be the last action or
we can open a chardev whose URBs are still poisoned

V2: added memory barriers

Fixes: cac6fb015f71 ("usb: class: cdc-wdm: WWAN framework integration")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/usb/class/cdc-wdm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 12038aa43942..355627982343 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -728,7 +728,7 @@ static int wdm_open(struct inode *inode, struct file *file)
 		rv = -EBUSY;
 		goto out;
 	}
-
+	smp_rmb(); /* ordered against wdm_wwan_port_stop() */
 	rv = usb_autopm_get_interface(desc->intf);
 	if (rv < 0) {
 		dev_err(&desc->intf->dev, "Error autopm - %d\n", rv);
@@ -870,8 +870,10 @@ static void wdm_wwan_port_stop(struct wwan_port *port)
 	poison_urbs(desc);
 	desc->manage_power(desc->intf, 0);
 	clear_bit(WDM_READ, &desc->flags);
-	clear_bit(WDM_WWAN_IN_USE, &desc->flags);
 	unpoison_urbs(desc);
+	smp_wmb(); /* ordered against wdm_open() */
+	/* this must be last lest we open a poisoned device */
+	clear_bit(WDM_WWAN_IN_USE, &desc->flags);
 }
 
 static void wdm_wwan_port_tx_complete(struct urb *urb)
-- 
2.49.0


