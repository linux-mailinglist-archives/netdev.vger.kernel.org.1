Return-Path: <netdev+bounces-178520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 875D6A776D6
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53FC3188D460
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 08:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7A81EBA14;
	Tue,  1 Apr 2025 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fvT8JSmi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fvT8JSmi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CB01EB5CD
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497288; cv=none; b=gcI27d8/bFERYEp0N7MSvOcXMAquOibY6umF/VcgIJkFZ5tK2Oh419lesQjj4U6VNK/Iu+PK5BXjfSn1sKy+NI9fdRuxCZSxfnSZlQCGdFZGPHihBnaPLSU2Cno+lIER36jAnQdVNo0zxis+VaNk6aco1Lq6atLa3OMPLPOIHrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497288; c=relaxed/simple;
	bh=cpTAyHqjQvWCmMiwfjUNvv7XfUupoy/wYj/US+dD7QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izNpL/UI5g7CpoQzoRGmTLeWzSdTF287MlSBBMVGUK9CSHJDraLSZyZCAgFGhl2ty5n/laOCitfSQ65VamjGZZWWXehYfLRDtcDSTAilnBygKWfaqxO8SV56Usddv1eMmJvYDQvi8/ykh6NGS75bYYW8K8Al9DVKz69wLXkOQSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fvT8JSmi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fvT8JSmi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4CC41F391;
	Tue,  1 Apr 2025 08:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743497271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nvbVPKtcp5y3ocnBZksieUB/EW50VUkcDueS+Szze4U=;
	b=fvT8JSmis1o7Y5brA92zgGX8BFH8orUBN/ow49L6aCz42GHh7n15ojtXQX1AO0wK/9P7UE
	pI6U7Wovvfg6JapH2CyGagQCxbl5jBxYHs+g6E0Sla2npHVenzuLNjSssmFo9QoQMcw46U
	8e7/dqSLmeaGYWS2DXYQjeG/yWU5XEw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743497271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nvbVPKtcp5y3ocnBZksieUB/EW50VUkcDueS+Szze4U=;
	b=fvT8JSmis1o7Y5brA92zgGX8BFH8orUBN/ow49L6aCz42GHh7n15ojtXQX1AO0wK/9P7UE
	pI6U7Wovvfg6JapH2CyGagQCxbl5jBxYHs+g6E0Sla2npHVenzuLNjSssmFo9QoQMcw46U
	8e7/dqSLmeaGYWS2DXYQjeG/yWU5XEw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F9BE13691;
	Tue,  1 Apr 2025 08:47:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mAHhJTeo62cRcQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 01 Apr 2025 08:47:51 +0000
From: Oliver Neukum <oneukum@suse.com>
To: gregkh@linuxfoundation.org,
	bjorn@mork.no,
	loic.poulain@linaro.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCHv2 4/4] USB: wdm: add annotation
Date: Tue,  1 Apr 2025 10:45:41 +0200
Message-ID: <20250401084749.175246-5-oneukum@suse.com>
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_RATELIMIT(0.00)[to_ip_from(RLikj1p7yq1njapebq4rcw7c5p)];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

This is not understandable without a comment on endianness

Fixes: afba937e540c9 ("USB: CDC WDM driver")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/usb/class/cdc-wdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 8b99db506b71..840cf45b791e 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -911,7 +911,7 @@ static int wdm_wwan_port_tx(struct wwan_port *port, struct sk_buff *skb)
 	req->bRequestType = (USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE);
 	req->bRequest = USB_CDC_SEND_ENCAPSULATED_COMMAND;
 	req->wValue = 0;
-	req->wIndex = desc->inum;
+	req->wIndex = desc->inum; /* already converted */
 	req->wLength = cpu_to_le16(skb->len);
 
 	skb_shinfo(skb)->destructor_arg = desc;
-- 
2.49.0


