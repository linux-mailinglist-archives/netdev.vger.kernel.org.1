Return-Path: <netdev+bounces-258424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH0cBNmRjWl54QAAu9opvQ
	(envelope-from <netdev+bounces-258424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 09:39:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF4012B723
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 09:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99CB03007AE6
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 08:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594062C0F89;
	Thu, 12 Feb 2026 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lzyphsLO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lzyphsLO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C4B29D289
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770885512; cv=none; b=k7SRWw9kwlw2COAOXpJi0Cyzvn64kGsA2lYqmZmVk1z02nSonJwIvyeiI9oOVSj7jbdiAqaih4Cz+oyiw0cpozb5HsTeKs9UyYeIDNOwwB4eU56JRiApwNzTKFGl+A23Krv87V7ywyZsNVKYRRK5/UWcNjSbtFxdFIaSZQi3bV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770885512; c=relaxed/simple;
	bh=KMLLpzrdJekqFStk19wKmwaOUMApCpjv22EIeOh7Wjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=njj82T2NBJtHIJnSM0f2VSVSIhoI5cqgWqcZhe5zkSy1cTiiD8gyhYbSjoibeYVE6HbHmk+pD5bGUIMt+bUYnrlcScqL/fMoC4e/yTMjQF4tpU6t6R/RpEbn8IgkaVHq2tth8lMKdHcngf7diK4T7SEMRj1gceCMLql6khbsL1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lzyphsLO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lzyphsLO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 633153E6C2;
	Thu, 12 Feb 2026 08:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770885509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cg0lfHNLzOa86C9goVRT4Xy+ihFyb7RvSBqibZQ3pAc=;
	b=lzyphsLO0wfPGC/c7CNXE8WJNAh+YzVpYhWXqpX5zPZGahN1cMVeBrhCH0LRCxj4NOqlws
	7TIYX5K+G0U2OjVHhxkXh1GDuPcV84YGSPTJZm7CXOXH+JX4+dcToQgqFH2SIzfFev7u68
	SkWA3wJSFbnKiYDvU5Txh8Go5e5z3oE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770885509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cg0lfHNLzOa86C9goVRT4Xy+ihFyb7RvSBqibZQ3pAc=;
	b=lzyphsLO0wfPGC/c7CNXE8WJNAh+YzVpYhWXqpX5zPZGahN1cMVeBrhCH0LRCxj4NOqlws
	7TIYX5K+G0U2OjVHhxkXh1GDuPcV84YGSPTJZm7CXOXH+JX4+dcToQgqFH2SIzfFev7u68
	SkWA3wJSFbnKiYDvU5Txh8Go5e5z3oE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E95C63EA62;
	Thu, 12 Feb 2026 08:38:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I/3JN4SRjWkRMgAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 12 Feb 2026 08:38:28 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH 0/2] xen/xenbus: better handle backend crash
Date: Thu, 12 Feb 2026 09:38:24 +0100
Message-ID: <20260212083826.136221-1-jgross@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258424-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgross@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 9BF4012B723
X-Rspamd-Action: no action

This small series fixes PV-device frontend side handling in case the
backend crashed and has come up again.

The old device will be discarded and the replacement can be used
instead. 

Juergen Gross (2):
  xenbus: add xenbus_device parameter to xenbus_read_driver_state()
  xen/xenbus: better handle backend crash

 drivers/net/xen-netfront.c                 | 34 +++++++++---------
 drivers/pci/xen-pcifront.c                 |  8 ++---
 drivers/scsi/xen-scsifront.c               |  2 +-
 drivers/xen/xen-pciback/xenbus.c           | 10 +++---
 drivers/xen/xenbus/xenbus_client.c         | 16 +++++++--
 drivers/xen/xenbus/xenbus_probe.c          | 42 ++++++++++++++++++++--
 drivers/xen/xenbus/xenbus_probe_frontend.c |  2 +-
 include/xen/xenbus.h                       |  4 ++-
 8 files changed, 83 insertions(+), 35 deletions(-)

-- 
2.53.0


