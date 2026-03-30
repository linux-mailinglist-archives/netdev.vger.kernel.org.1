Return-Path: <netdev+bounces-273356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBNiNbD9ymk2CgYAu9opvQ
	(envelope-from <netdev+bounces-273356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:48:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C22663621AD
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CF3B301EF22
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 22:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E784B3E558E;
	Mon, 30 Mar 2026 22:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="42X3MmJT"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E1833FE05
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910830; cv=none; b=qcAvYMzFXKi9XDasyz10PjHoSP+XmCZxxIVOc8tlH++ODYXy2LdKdecxZrPKV7sE3VQ1Cb8WM8q/62U03qjc3gF0NSVAaGlzwzMm5hRvA1Da7xcct8+hj3LV8dRAWJQmDVX6veDyg/JDr6C4V9xjVSvkciSKbIoX/QaZCG7q61s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910830; c=relaxed/simple;
	bh=SJS4sxqjaCFpDx3bZPnmhkMrdFDqUMPe/C2dRIB/ByE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HS5snq31G4wWygUgtoLrGg3PHYtt63kPEisHA6DxGqQH6pUPO2CwB8h43SWM9Ls5bafyuF5ij9wJdK378h3UxojYlT9FhslsiyJxjQukv5jL/H0/ObguxRxHrqexc6BD/goOyE7Ry0/8m87lrG9uDrFGH+ruXA6WC/+cPkZkxCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=42X3MmJT; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C06B4A587E;
	Tue, 31 Mar 2026 00:47:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774910823; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=6APDex8FZSZksu7DvpvXW7Jltmk8KR+z1wOQGR0gc7U=;
	b=42X3MmJTanejitOaTSvVa5SmebhxqJN/lxsByLk3MV4QnYK2klt8hJnhzfdLcbjmFJHgKE
	DBOEVpg0fQE0OvbfbadzBZB4QvWPqeRBRs1Oe1VupLw6zhegT6BpiQUyxCj2PLzDUhNrWR
	LuxJlUZIVYcHJbJo5gXZ3zTRZWW/PwVAuPx4z7QPkgKFgrQueBZ15gRMU6S6dx2z4TXJj+
	dtBcbzbr+pB99Qt6klJJr11km11OLPkLQO5rZkbNC0fwRTS2Ai9tkPmpMQ64jkX4iYEgKt
	v+Dche4X7tS9/Vx+wcdsSAIe16RPnQME1EWzon9qyIwZIsV85iGzWSV2xJzU/A==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Phil Elwell <phil@raspberrypi.com>,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v2 0/2] net: phy: microchip: add downshift support for LAN88xx
Date: Tue, 31 Mar 2026 00:46:25 +0200
Message-ID: <20260330224630.579937-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273356-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DMARC_DNSFAIL(0.00)[tipi-net.de : query timed out];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:mid]
X-Rspamd-Queue-Id: C22663621AD
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

Changes since v1:
- Replace switch statements with FIELD_GET()/FIELD_PREP() (Andrew Lunn)
- Drop unused per-count register defines from microchipphy.h

Nicolai Buchwitz (2):
  net: phy: microchip: add downshift tunable support for LAN88xx
  net: phy: microchip: enable downshift by default on LAN88xx

 drivers/net/phy/microchip.c  | 71 +++++++++++++++++++++++++++++++++++-
 include/linux/microchipphy.h |  5 +++
 2 files changed, 75 insertions(+), 1 deletion(-)

-- 
2.51.0


