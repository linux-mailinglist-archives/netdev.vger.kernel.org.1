Return-Path: <netdev+bounces-274092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEeJD4oUzWmMZwYAu9opvQ
	(envelope-from <netdev+bounces-274092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:50:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 239FF37ABBE
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85E6E301258A
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 12:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C573A3F7E93;
	Wed,  1 Apr 2026 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="G4cWTPcQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353923E0C44
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047166; cv=none; b=QvAu4aTM1GaGO4umDUArDdgRMEZcOZ0tiINb2qkSyWJBS85l1BpsuE1N13gzQNbA6E3GgzGgdSuM80o6u0lZ4q8mE2e0acdLjbgtTmE+ESV3MaMrh6N1YhgjOK1A8VaC5Dc23ySP7cB3/9NIqq4yaYTwEuWQ3KsNN11K0uMk2cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047166; c=relaxed/simple;
	bh=OwXICggz84N7p+OQgKb24X/PrSUEc0WE1UwueAjz+lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzAKLIOy4SBeu444bMJeHSGWw2gDFFJxcDPgfgbjfKmZjF75Jw5ePIVISAaZBCjth2rALwtpL66xcLdFXitK+G31yXzQoFhODcUofwBGUnb0jPK0uzpkDYTdb3ur1JxINDyrdmol1SRtlZIcIst4AcdW5RT9aJ2kEt9uENnv6lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=G4cWTPcQ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C6261A5842;
	Wed,  1 Apr 2026 14:39:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775047158; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=2IVLKaycGaXgLsP9HspIEaxDXMjxc/z36Xv1mZjnLWY=;
	b=G4cWTPcQE5LJeAM2fvB1IkvTRNYIIXw93NH7SS3K/i16Ug6hW9VsmyoIjbUBA1bFPlPoCc
	4sZ4WOl+KORPzJioaRt/5+hlIcriA4rSF0DV4hKeyf73+qmAOKjHhFJJRAdY8hBWrVaSwv
	t2h5EzlGaDTbXUV8Ds/hOHOuDegm501yPthH04hQh7anI0aau9iCmN0d/SbBI7rcqW8NQh
	LKxvBUt5WDJuTTsBpkIrJ4NwQpZ+KFOjwPb16hoSFmmBFd7ulGOKigfY8WQs5dfs99KLQk
	kJ8oWcFMlo5dzEbhxVGuCsSaLh4EdbF7TyCKV5aEOrNdBVtQ95ymT1q3GlBWHg==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Phil Elwell <phil@raspberrypi.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v3 0/2] net: phy: microchip: add downshift support for LAN88xx
Date: Wed,  1 Apr 2026 14:38:43 +0200
Message-ID: <20260401123848.696766-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260329224202.500229-1-nb@tipi-net.de>
References: <20260329224202.500229-1-nb@tipi-net.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274092-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:mid]
X-Rspamd-Queue-Id: 239FF37ABBE
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
Patch 2 enables downshift by default with a count of 2. The setting is
stored in the driver's private data so that user changes via ethtool are
preserved across suspend/resume cycles.

Based on an earlier downstream implementation by Phil Elwell.

Tested on Raspberry Pi 3B+ (LAN7515/LAN88xx).

Changes since v2:
  - Store downshift count in priv struct and restore in config_init to
    preserve user settings across suspend/resume (Russell King)

Changes since v1:
  - Replace switch statements with FIELD_GET()/FIELD_PREP() (Andrew Lunn)
  - Drop unused per-count register defines from microchipphy.h

Nicolai Buchwitz (2):
  net: phy: microchip: add downshift tunable support for LAN88xx
  net: phy: microchip: enable downshift by default on LAN88xx

 drivers/net/phy/microchip.c  | 79 +++++++++++++++++++++++++++++++++++-
 include/linux/microchipphy.h |  5 +++
 2 files changed, 83 insertions(+), 1 deletion(-)

-- 
2.51.0


