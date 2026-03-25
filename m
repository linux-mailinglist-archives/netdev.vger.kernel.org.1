Return-Path: <netdev+bounces-271743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOCWCmdNxGljyAQAu9opvQ
	(envelope-from <netdev+bounces-271743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 22:02:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F5B32C11E
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 22:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23A203074A3D
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BBE3815F7;
	Wed, 25 Mar 2026 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WKfywbR8"
X-Original-To: netdev@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680CD372B3D
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472409; cv=none; b=nOTpsS9XgZB4qSJ0hfARcc+pV4SknfXHRHwhhTN31gYQTXs9yBi0v2F4Nb2+OPlmvB2gQxt5vzk5k/76ADYZBMIj3iJnrwSlgnA2PnE/DqTnGpTeArkyCdCNlC2J64I7S4uBdQGfkEOKHZLraMUn1uXlrrZ3OSzZ56ngQphQauA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472409; c=relaxed/simple;
	bh=BGyq3vnbc++78ejS9kJ0tHlrDWMJafXMYaaoZnGDiSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kBYuPeS9bTJ9UMWhbMJPhsMkqlVe+J74Z5rKFoH22ZSF9eF5++yNlY2h61nFMYHw/+YR5ds8Iu+qF9zXmNKRTYNxxGaAVU/zag0TXpVpwBkgKzZ3OHpNT5H3Beh9OU3NQAleA5ckBzM0h7GjqaAsOn6x71INsZQEb7g/ugncRVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=WKfywbR8; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 1E8CD225;
	Wed, 25 Mar 2026 21:58:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1774472327;
	bh=BGyq3vnbc++78ejS9kJ0tHlrDWMJafXMYaaoZnGDiSo=;
	h=From:To:Cc:Subject:Date:From;
	b=WKfywbR8CDmMPniTudknGbbfkZWKVGux82MZHxr4lxQ71HjtL6PcR92zA0tefCRvW
	 WjdswoQfr5IA0nsE15lx2lj1mS+r3e6UKr+8nnRYr29j9iwmD3GhOW01XWat167DLI
	 l7kL23AmyDXs5R3v9MJtmK/xHOnS/Wq2d5DBfPGk=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: netdev@vger.kernel.org,
	imx@lists.linux.dev
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Joy Zou <joy.zou@nxp.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v4 0/2] net: stmmac: Disable EEE on i.MX
Date: Wed, 25 Mar 2026 23:00:01 +0200
Message-ID: <20260325210003.2752013-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271743-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,gmail.com,toradex.com,nxp.com,kernel.org,ideasonboard.com,pengutronix.de,redhat.com,armlinux.org.uk,lists.infradead.org];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laurent.pinchart@ideasonboard.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,i.mx:url,ideasonboard.com:dkim,ideasonboard.com:mid]
X-Rspamd-Queue-Id: 77F5B32C11E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

This small patch series fixes a long-standing interrupt storm issue with
stmmac on NXP i.MX platforms.

The initial attempt to fix^Wwork around the problem in DT ([1]) was
painfully but rightfully rejected by Russell, who helped me investigate
the issue in depth. It turned out that the root cause is a mistake in
how interrupts are wired in the SoC, a hardware bug that has been
replicated in all i.MX SoCs that integrate an stmmac. The only viable
solution is to disable EEE on those devices.

Individual patches explain the issue in more details. Patch 1/2,
authored by Russell, adds a new STMMAC_FLAG to disable EEE, and patch
2/2 sets the flag for i.MX platforms.

[1] https://lore.kernel.org/r/20251026122905.29028-1-laurent.pinchart@ideasonboard.com

Laurent Pinchart (1):
  net: stmmac: imx: Disable EEE

Russell King (Oracle) (1):
  net: stmmac: provide flag to disable EEE

 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c   |  9 +++------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  7 ++++++-
 include/linux/stmmac.h                            | 13 +++++++------
 3 files changed, 16 insertions(+), 13 deletions(-)


base-commit: d1e59a46973719e458bec78d00dd767d7a7ba71f
-- 
Regards,

Laurent Pinchart


