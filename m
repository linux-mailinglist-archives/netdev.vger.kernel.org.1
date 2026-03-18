Return-Path: <netdev+bounces-268992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ0LDTWZumnaZQIAu9opvQ
	(envelope-from <netdev+bounces-268992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:23:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA5F2BB643
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73508303A6FD
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 12:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC68638F924;
	Wed, 18 Mar 2026 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b="FDTv+W2I"
X-Original-To: netdev@vger.kernel.org
Received: from mail.amicon.ru (unknown [77.108.111.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7064E37AA63;
	Wed, 18 Mar 2026 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.108.111.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836446; cv=none; b=Jg9gX6PBEwVhOKxLjPKl9E584ARBwEY9rPx29fo6YuAyBel5ouYDusfvzYd8k3Ra+OUISuyHXQsuIAuMyW4ahTWlnmlXcH/dxhrxgNTyx4PsGmP9NApSiw2R4EgRrTMDBCFoVwAQVg/taVKNE8pfn+pm/UNXIrjjZhq75GGtB/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836446; c=relaxed/simple;
	bh=ItOuvsOZrEPLHOd5gWwx5fQdWlJ4DU7hNyCbq1giguU=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=gC0myHuUym+rnTEsgsxsE8eXJHSf+CUMWXabdSDRKIewzG10JJvyIGIBtNQfubxLjt04xKGQ3+16guH+9S7luc+XzKLBs8sp7yjDU2fPwdxdfAsyafu+XsCCJoEctuBI7InQff1XX/DF++zUYtVrgwMo0FUuQS0/kbHm/nIwF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru; spf=pass smtp.mailfrom=amicon.ru; dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b=FDTv+W2I; arc=none smtp.client-ip=77.108.111.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1773835531; h=from:subject:to:date:message-id;
	bh=ItOuvsOZrEPLHOd5gWwx5fQdWlJ4DU7hNyCbq1giguU=;
	b=FDTv+W2IZK87rI9ZMckRMex3s4IPtz7Ep4mzUZIZ14/ZYQu+fbGmG5g0EIHwYZv9Cw+BZQT95vm
	xG7LiN9iG1V8yNCs9+TM9224RVmtLqjUG1NbNQlb8zMwYfxCOhXumt7RvDlH1OyYQ/fFMKdIWnACm
	IFJrIpTvaYYXszKUnz/ckQ57a1XItP/U1OpzWVZU6vyCkqrZGXWB/uGacjY3s8xElmfjIYcTP09yr
	ihjgcCUvlQ8gZ/DdnFwWa1dbz1enCBi9rYI/Qviv5fJeh77Petpz18txs7wYCWwIaQHrMhPHUIE78
	RYSGsdThtw7zk9tqX+P8qiUZu9K0IMfb0++g==
Received: from example.com (172.16.2.46) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 18 Mar
 2026 15:05:30 +0300
From: Agalakov Daniil <ade@amicon.ru>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Agalakov Daniil <ade@amicon.ru>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, "Daniil
 Iskhakov" <dish@amicon.ru>, Roman Razov <rrv@amicon.ru>
Subject: [PATCH net 0/3] e1000/e1000e: fix uninitialized memory access in EEPROM write
Date: Wed, 18 Mar 2026 15:05:04 +0300
Message-ID: <20260318120512.687149-1-ade@amicon.ru>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amicon.ru,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amicon.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-268992-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ade@amicon.ru,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amicon.ru:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amicon.ru:dkim,amicon.ru:email,amicon.ru:mid]
X-Rspamd-Queue-Id: ACA5F2BB643
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series addresses a common issues related to uninitialized memory
access during EEPROM write operations in the e1000 and e1000e drivers.

In the e1000 driver, the return value of e1000_read_eeprom() was not
checked, and both e1000 and e1000e drivers performed endianness
conversion on the entire buffer, including uninitialized interior words.

The changes are:
 - add missing error checks for e1000_read_eeprom() in e1000;
 - limit endianness conversion to the boundary words being read,
   avoiding a loop over entire (and partially uninitialized) buffer in
   both e1000 and e1000e.

Patch 1: e1000: check return value of e1000_read_eeprom
Patch 2: e1000: fix endianness conversion of uninitialized words
Patch 3: e1000e: fix endianness conversion of uninitialized words

Co-developed-by: Iskhakov Daniil <dish@amicon.ru>
Signed-off-by: Iskhakov Daniil <dish@amicon.ru>
Signed-off-by: Agalakov Daniil <ade@amicon.ru>
---
 .../net/ethernet/intel/e1000/e1000_ethtool.c  | 18 +++++++++++++-----
 drivers/net/ethernet/intel/e1000e/ethtool.c   | 19 ++++++++++++-------
 2 files changed, 25 insertions(+), 12 deletions(-)

-- 
2.51.0


