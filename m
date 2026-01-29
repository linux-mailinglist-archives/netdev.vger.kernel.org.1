Return-Path: <netdev+bounces-254866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M8aG9SVe2nOGAIAu9opvQ
	(envelope-from <netdev+bounces-254866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:16:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 155E6B2B8C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63873306F3D1
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0B133ADAF;
	Thu, 29 Jan 2026 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dvwWxufp"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2ED27B32C
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769706751; cv=none; b=m2t8lBaaI65RDHtE0aAf4tHEKeXTfryTt46MG0xNpaauaVg/GCHg0e/ugYOL05G6nj6uDiIhGlv764mT/JoWlgQuzYu8L8EcN1mF54xJUaWMV6QLokA5zf8m2vP3VuDu2DFABZ+AOBQKz0T439LRH6Gq/b7bO6co9/VANAZoEhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769706751; c=relaxed/simple;
	bh=chokkzrhokBlW6Eu3mi0ECCuv3BjTVGRkCY1AjYaSKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SG69X41s4faGsno5Zzzee8Y00kaeoNKUEFq62yVf3Hpl/xUfSf8loGCCXVoHsmG7qzlop6m00KnI7cIVu6EZwSBtxOuRACRPT/kgOzbFqGPLEUHM4h+wnN2linl2xr6JeWDmmEbEGofYP9ewjr8O21KxLkWHW/LVG37bRZLbSUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dvwWxufp; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769706737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=stFWWTtZs7GzaidvdT/QOzObWpEgxLSIW1ZsArAZkOw=;
	b=dvwWxufp6FlmfbRm5GDStCpHBsWPAP1nL3vdz8wtA/3glm/YPLs35zxOIeL7pfiyF7zzvM
	Cx/tz3rdGX0WzqwlJMUDkQZso2CFyvAopfcvYLCwnf80xM4Z+UeuxI4gQmsGNr3B4Gd7De
	F+WJxB7WPuTb4SlJSyTM6ufzVko/RAE=
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next 0/2] net: phy: dp83867: Always program R/SGMII enable bits
Date: Thu, 29 Jan 2026 12:12:03 -0500
Message-Id: <20260129171205.3868605-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254866-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.anderson@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 155E6B2B8C
X-Rspamd-Action: no action

The hardware designers at my company neglected to read the datasheet for
this PHY and did not add appropriate resistors to configure it for
SGMII. Add support for configuring the it based on phy-mode instead of
relying on the resistors for a suitable default.


Sean Anderson (2):
  net: phy: dp83867: Program TX FIFO for all interfaces
  net: phy: dp83867: Always program R/SGMII enable bits

 drivers/net/phy/dp83867.c | 63 ++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 40 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


