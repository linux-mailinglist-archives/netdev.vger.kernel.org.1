Return-Path: <netdev+bounces-273030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KVu+AfmqyWmO0wUAu9opvQ
	(envelope-from <netdev+bounces-273030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 00:43:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9666035450E
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 00:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3CC0300C035
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4E33043CF;
	Sun, 29 Mar 2026 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="4R9gBMrw"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B641547C0
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 22:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774824172; cv=none; b=qPuAwdcIfI0ZodIA0DL2WASMSvfiQCENKoBtCmyD55HUw1mL/YtGd9GvZ3qw7hg5a9F2F66GtskeA9UfHSLvGyGUGtpe+JqcMKB68y93HoPMsybk9/GiTQE6muDBSPiOY9eMEFDlsIC6lLKYqhejUeUN69fspIs+AYfTYgPKYbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774824172; c=relaxed/simple;
	bh=D/EETRuBRvXLCxFVJbBJqhykDeqaXnQZUxfjKU6RlAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i+PVT+Yl72D994sIn5KGOWMfMX/Jg5b6T+w5bi20hGKsQFIuNHweBbSwQO3bqbsjcIqN7Ha8JV713vDiFVC0UOThsnglvqze6tQ8Gwp5nkY+qsH7D7HdJ5cjOIsn5aXvLhwdy3j5tefS/+I06iu/ITlfxiGNeHUd6JufOzWGhNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=4R9gBMrw; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 84C1DA01B0;
	Mon, 30 Mar 2026 00:42:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774824151; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=dA4Rs9Jb5I2ZpDuifAoeSxEzZ8pORM0cDNmRTw+QskQ=;
	b=4R9gBMrwxdScZ8wGlCGUNtQdFzg/fPOnWlAKA4fGLblQ7IOezSzBbHmYgHDsYDBsgJ2dne
	LoOwj+Ln4ZEw2UOa3qObqYBK3JyjTurOLQpYnIvUD2wCtgFPX0PStK/Lg/A6kLk//Rt/zQ
	znk4jaQ1Md3eGjxH7XBRafMHlSebqhDdti/PaRsBbKBfK++IO0e2p+hMV83z4bZzYoOHdH
	xQbbpdfzAx2F3p98S7vGwpIp19304GGwZJK5cEpk97DYUH8g8jpOk8LrqebOjOo++Xgu4A
	z3/S30KuSJaV3dhrqtBRditQtCZ3gF2ypy4OdXzRc4p5/JO1MoI6ReWvG+fXMg==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Phil Elwell <phil@raspberrypi.com>,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next 0/2] net: phy: microchip: add downshift support for LAN88xx
Date: Mon, 30 Mar 2026 00:41:58 +0200
Message-ID: <20260329224202.500229-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273030-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:?];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.077];
	DMARC_DNSFAIL(0.00)[tipi-net.de : query timed out];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[tipi-net.de:s=dkim];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9666035450E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add standard ETHTOOL_PHY_DOWNSHIFT tunable support for the Microchip
LAN88xx PHY, following the same pattern used by Marvell and other PHY
drivers.

Ethernet cables with faulty or missing pairs (specifically C and D)
can successfully auto-negotiate 1000BASE-T but fail to establish a
stable link. The LAN88xx PHY supports automatic downshift to
100BASE-TX after a configurable number of failed attempts (2-5).

Patch 1 adds the get/set tunable implementation.
Patch 2 enables downshift by default with a count of 2.

Based on an earlier downstream implementation by Phil Elwell.

Tested on Raspberry Pi 3B+ (LAN7515/LAN88xx).

Nicolai Buchwitz (2):
  net: phy: microchip: add downshift tunable support for LAN88xx
  net: phy: microchip: enable downshift by default on LAN88xx

 drivers/net/phy/microchip.c  | 96 +++++++++++++++++++++++++++++++++++-
 include/linux/microchipphy.h |  9 ++++
 2 files changed, 104 insertions(+), 1 deletion(-)

-- 
2.51.0


