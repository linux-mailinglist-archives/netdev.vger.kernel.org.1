Return-Path: <netdev+bounces-193947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E548CAC680C
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 13:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4934A0CFD
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 11:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167D12153C6;
	Wed, 28 May 2025 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZG6TK4Wh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZG6TK4Wh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E6821858A
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748430273; cv=none; b=NRtIyo7tIXgsKQEU4FPuxVvg3D2c1hfVN0gAB1ngJMSwpZb2te6nACs4apsaHr9rIYQzRrRGMdd3rFw6GbQp6sqvy7gpA+vRL1XR8kShs+4N3uH2Wd5m+gK3ReJtBf2hRCiuMADDQ0kVE1V7pMBpDUuNdQ2SJE7SIyhXA761veI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748430273; c=relaxed/simple;
	bh=te1vESWc2jjWEpbp9H3j/svSJPfhxMetuz1m9dX2YB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K6qtFGixE6mgJm1EElId4xoGNjHBiPqqLFA6/PXYHjPP52JEJ5i8VwIdCfkMqH5yMTcqhuXNIYnRVzvvXBFAgpwVO7P+wh8h4fiuyPvpDSYjuz9H9pL7W64cFV09tA24cbEUYk/9QQHP9n23xH4p8Gw4Fln/x4AonQHN3OIFyrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZG6TK4Wh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZG6TK4Wh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C25CD21A07;
	Wed, 28 May 2025 11:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748430262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nb+Vk4qE0FZEq30M5YgRWdbftqWIc4arKkKTIxx/nO0=;
	b=ZG6TK4WhJBHsMgNx08FHVTSGt9Fj3THyD5XNfqI/WcnaEuUgFlGnrfGWUDhdwXcoOv2u6I
	TE/1HWyNeEVZcjCOVvvO/OLWice60nnbC1HlRD7parDe5M5oAN1q+DWJMqotjqOrsoGOJ/
	vY2DVtKt6jUULk0b/38yIxMB8Y+vZ28=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748430262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nb+Vk4qE0FZEq30M5YgRWdbftqWIc4arKkKTIxx/nO0=;
	b=ZG6TK4WhJBHsMgNx08FHVTSGt9Fj3THyD5XNfqI/WcnaEuUgFlGnrfGWUDhdwXcoOv2u6I
	TE/1HWyNeEVZcjCOVvvO/OLWice60nnbC1HlRD7parDe5M5oAN1q+DWJMqotjqOrsoGOJ/
	vY2DVtKt6jUULk0b/38yIxMB8Y+vZ28=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8816F136E0;
	Wed, 28 May 2025 11:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rv9+H7btNmi6CgAAD6G6ig
	(envelope-from <oneukum@suse.com>); Wed, 28 May 2025 11:04:22 +0000
From: Oliver Neukum <oneukum@suse.com>
To: netdev@vger.kernel.org,
	n.zhandarovich@fintech.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] net: usb: aqc111: debug info before sanitation
Date: Wed, 28 May 2025 13:03:54 +0200
Message-ID: <20250528110419.1017471-1-oneukum@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

If we sanitize error returns, the debug statements need
to come before that so that we don't lose information.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Fixes: 405b0d610745 ("net: usb: aqc111: fix error handling of usbnet read calls")
---
 drivers/net/usb/aqc111.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index 453a2cf82753..9201ee10a13f 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -31,11 +31,11 @@ static int aqc111_read_cmd_nopm(struct usbnet *dev, u8 cmd, u16 value,
 				   USB_RECIP_DEVICE, value, index, data, size);
 
 	if (unlikely(ret < size)) {
-		ret = ret < 0 ? ret : -ENODATA;
-
 		netdev_warn(dev->net,
 			    "Failed to read(0x%x) reg index 0x%04x: %d\n",
 			    cmd, index, ret);
+
+		ret = ret < 0 ? ret : -ENODATA;
 	}
 
 	return ret;
@@ -50,11 +50,11 @@ static int aqc111_read_cmd(struct usbnet *dev, u8 cmd, u16 value,
 			      USB_RECIP_DEVICE, value, index, data, size);
 
 	if (unlikely(ret < size)) {
-		ret = ret < 0 ? ret : -ENODATA;
-
 		netdev_warn(dev->net,
 			    "Failed to read(0x%x) reg index 0x%04x: %d\n",
 			    cmd, index, ret);
+
+		ret = ret < 0 ? ret : -ENODATA;
 	}
 
 	return ret;
-- 
2.49.0


