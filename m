Return-Path: <netdev+bounces-178295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A63A766D3
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABEDF166400
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 13:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88EF211A0D;
	Mon, 31 Mar 2025 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TKRtfVRh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TKRtfVRh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3481421149F
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743427580; cv=none; b=HURagva2swxKgQfq9dVUS3hlZucGRxxEennJDu2Hn/1RbPTv1jduR86c8JTcJCD1t8O8yMwKPq3ThvSNJXhQPEBVhtd1u3qXE2H+LzEId0ekxfziVaDgTly0N4GQVb1HU9SOKeK0CYKiAdRiKEpyFHG0pv5uEiilh9/3CDZ73gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743427580; c=relaxed/simple;
	bh=HrGKD0KbZmhm6DKZt5OMcxAy1MWarDSf6WaP2/wp06Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STtwyst9OGv+uWvFvQ1YbwUvu1C+ReILhSB1r1zgAlYG0cFdNlJ3NcdYqGUaxWYGwuJ44dpjc6i+gWfJfIWwUx6LOpOU2eYZYWI/UC2tXqOu3Tgxd8LQkBa8UDallXq7/wNK+TIowm/CO1CYQLZ2XVsvSKYCWPQfd1NCjS8Zcgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TKRtfVRh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TKRtfVRh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2DBD51F456;
	Mon, 31 Mar 2025 13:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743427577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjSnAYDRUpOAk4hdheIUEiWeZ1WwxhmbKrlRr2urYws=;
	b=TKRtfVRhtAmJTtTvIdzhIm1Y7eede7SdNcl7tQ38ICgzuBxHkBGJe9UrFALLWNpape6Eov
	941tQV6FZ1VK6iwNlmhNVq0sY+AYKH7zX4DtIuEf5+pHgLqTEWApt/FA6aGcw1GDnUk7wf
	nqYv+B4kJ9Bjk3iHG0uAIKA1lZAQ3+Q=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743427577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjSnAYDRUpOAk4hdheIUEiWeZ1WwxhmbKrlRr2urYws=;
	b=TKRtfVRhtAmJTtTvIdzhIm1Y7eede7SdNcl7tQ38ICgzuBxHkBGJe9UrFALLWNpape6Eov
	941tQV6FZ1VK6iwNlmhNVq0sY+AYKH7zX4DtIuEf5+pHgLqTEWApt/FA6aGcw1GDnUk7wf
	nqYv+B4kJ9Bjk3iHG0uAIKA1lZAQ3+Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 012FB13A1F;
	Mon, 31 Mar 2025 13:26:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UN+9OviX6meJIQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Mon, 31 Mar 2025 13:26:16 +0000
From: Oliver Neukum <oneukum@suse.com>
To: gregkh@linuxfoundation.org,
	bjorn@mork.no,
	loic.poulain@linaro.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 2/4] USB: wdm: close race between wdm_open and wdm_wwan_port_stop
Date: Mon, 31 Mar 2025 15:25:02 +0200
Message-ID: <20250331132614.51902-3-oneukum@suse.com>
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
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

Clearing WDM_WWAN_IN_USE must be the last action or
we can open a chardev whose URBs are still poisoned

Fixes: cac6fb015f71 ("usb: class: cdc-wdm: WWAN framework integration")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/usb/class/cdc-wdm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 12038aa43942..e67844618da6 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -870,8 +870,9 @@ static void wdm_wwan_port_stop(struct wwan_port *port)
 	poison_urbs(desc);
 	desc->manage_power(desc->intf, 0);
 	clear_bit(WDM_READ, &desc->flags);
-	clear_bit(WDM_WWAN_IN_USE, &desc->flags);
 	unpoison_urbs(desc);
+	/* this must be last lest we open a poisoned device */
+	clear_bit(WDM_WWAN_IN_USE, &desc->flags);
 }
 
 static void wdm_wwan_port_tx_complete(struct urb *urb)
-- 
2.49.0


