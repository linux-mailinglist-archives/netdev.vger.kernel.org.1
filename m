Return-Path: <netdev+bounces-304205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ClDhJzB3RmoxWQsAu9opvQ
	(envelope-from <netdev+bounces-304205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:35:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB4C6F8E89
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:35:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QTM3q55H;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QTM3q55H;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304205-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304205-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6353F300C5B9
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 14:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0124E3764;
	Thu,  2 Jul 2026 14:31:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264214B8DF8
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 14:31:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783002715; cv=none; b=duR+K52gfCqJkMhcGtMTWksIqOnOak7yNHuk1S8fNKLCoK/HejjFVdEVbNm69yvAIQvrY5YcuZzp1pEm3blYHxggkya8bWEVXBbwdlqwajAFULhKS2fNP0r9wokvRmrNlarF2JutsHtN0TG6vVWTx4njGpZtNtIcfHwifuMuH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783002715; c=relaxed/simple;
	bh=kQvdG1ro/qW7OGfA890KSZ36F9gY+uy5npmcKOKCAPo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=q0GCLi+wISCcG9I4UHIq4tx2OtVNu5l5x/xi/0NIxT+rNZckmwDb45b5y+DC+LGH3yENXqiHeUk6UEC4EpLfKTZCjd8IrUgYEJ7GDoFxFMGgOFDmBg4bpxlv8e4Vu7Ymt34w19cRrxM5tOYl/9CINMDvhPmMgjmm5T7yMfEkJIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QTM3q55H; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QTM3q55H; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 05D9E75DEB;
	Thu,  2 Jul 2026 14:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1783002708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kQvdG1ro/qW7OGfA890KSZ36F9gY+uy5npmcKOKCAPo=;
	b=QTM3q55HZ89qkyX3br16ATmPNJGJjWwhjA+GyD8JsCu/6Xu/RzGXNmD6YEk44uuOW+P/Zv
	kip1yAg77OpqXduqARlrEg5I8WX2Vw8vVz+NNL2iBc6482SrbvWfrYIJg3IpKRp1y2o4x7
	MojqtadMoDjSJTNWAcVOK+ivrrkaEdQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1783002708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kQvdG1ro/qW7OGfA890KSZ36F9gY+uy5npmcKOKCAPo=;
	b=QTM3q55HZ89qkyX3br16ATmPNJGJjWwhjA+GyD8JsCu/6Xu/RzGXNmD6YEk44uuOW+P/Zv
	kip1yAg77OpqXduqARlrEg5I8WX2Vw8vVz+NNL2iBc6482SrbvWfrYIJg3IpKRp1y2o4x7
	MojqtadMoDjSJTNWAcVOK+ivrrkaEdQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA2F0779AA;
	Thu,  2 Jul 2026 14:31:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4RVfLFN2Rmr0MwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 02 Jul 2026 14:31:47 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shaoxul@foxmail.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] net: usb: move exported code to usbnet
Date: Thu,  2 Jul 2026 16:25:29 +0200
Message-ID: <20260702143142.890654-1-oneukum@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304205-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foxmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shaoxul@foxmail.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.com:dkim,suse.com:mid,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAB4C6F8E89

Some drivers are reusing common code originating in other drivers.
This means that two drivers need to be loaded for one device.
Also maintainability is reduced if changes in one driver affect
another driver.
Shift common code to usbnet.


