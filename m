Return-Path: <netdev+bounces-300410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0GTFNmrRM2ogGwYAu9opvQ
	(envelope-from <netdev+bounces-300410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 13:07:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAE269F9E7
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 13:07:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ead9Ts7Y;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ead9Ts7Y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300410-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300410-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DD9C3028011
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A743E0C47;
	Thu, 18 Jun 2026 11:06:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3622A3B2FED
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 11:06:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781780784; cv=none; b=VaIcrYWxWYlNmGh7FyfczdPgl6JQe+LrNo6m0QcstRa12m6EVtnjM3tXTAKp0BLV8kkpT1bbXGpCycHBBnW+14MLNrFvuTjtWBAmWh2T4seBN9Z1is7BPvtXSDdnyaMaoO/RvIL49NAJcHIa5ySjhfjGmcQjHQcQFXSpZsTmWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781780784; c=relaxed/simple;
	bh=FNeYfy1SwZzgug/EO0lY6WxpmJZk7+D32D2cjfIbjmk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gjiYCxfs4cE1Jll9lCeFXEnSsh1hR1bAShPAoCPCh8POd8VCMdJ3ejvSvGdhe0WISqAl1axHOaPOMFW5V78dZ2E0EmWMfXnbcHmq0wzlCVtM6d45thdW4CkZgymeSo1ZJTIdUX5oTj7EQmJ9ZI6EgHLEOCG47RBom2QhWi+eMhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ead9Ts7Y; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ead9Ts7Y; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49EC26C34C;
	Thu, 18 Jun 2026 11:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1781780776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZKHyBef4sxWkE+7l0tdtcOPsu+LbeJVuTP+qVBmXQ8s=;
	b=ead9Ts7YxghhKEwC0SCpZ+OLYpDXhmFpnK+TRm/jfocEwEBkN9ZDhfAW2CV2BaTZMR+XK6
	1gbQR60oDB/D5x03THyZLoJbWA6KfVysQ2O7dDwQfJYyhYqUveK3s8q0h4s4hzN9j3h3vA
	OWgS2IJERnhkI+cyeMbD3PT2SqlHzFI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1781780776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZKHyBef4sxWkE+7l0tdtcOPsu+LbeJVuTP+qVBmXQ8s=;
	b=ead9Ts7YxghhKEwC0SCpZ+OLYpDXhmFpnK+TRm/jfocEwEBkN9ZDhfAW2CV2BaTZMR+XK6
	1gbQR60oDB/D5x03THyZLoJbWA6KfVysQ2O7dDwQfJYyhYqUveK3s8q0h4s4hzN9j3h3vA
	OWgS2IJERnhkI+cyeMbD3PT2SqlHzFI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24012779A8;
	Thu, 18 Jun 2026 11:06:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YyBDByjRM2q7TgAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 18 Jun 2026 11:06:16 +0000
From: Oliver Neukum <oneukum@suse.com>
To: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: 
Date: Thu, 18 Jun 2026 13:04:14 +0200
Message-ID: <20260618110612.439021-1-oneukum@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.32
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	EMPTY_SUBJECT(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300410-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.com:dkim,suse.com:mid,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EAE269F9E7


Hi, unfortunately my old phne broke, so I am out of options for
testing patches for WDM. I need testers.

This patch is a major modernization of the driver in that it
switches it to using a kfifo.

	Regards
		Oliver


