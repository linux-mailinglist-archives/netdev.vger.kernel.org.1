Return-Path: <netdev+bounces-270948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPygDPJZwmnQbwQAu9opvQ
	(envelope-from <netdev+bounces-270948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:31:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A44F3059F0
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA5513197E32
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963F53DCD95;
	Tue, 24 Mar 2026 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VzyXjdRB"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473D63C6606
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344091; cv=none; b=XGbvXENEq4HzN6e8GMJArxKCurQhWiQvESCqydxv287YAgWEKk90dCPbuvOC7+bTdRc4L87QV6/2c43zFIICq4jE08V/sOOUsELGpiUIcUi8PbG390Xz/svzs333oqPr3qRHpGX6QK4kenAO5H8LYl1+g6t2hr5Wk/P/mbJk+xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344091; c=relaxed/simple;
	bh=fNA1e7ZNX7i4vtJ0ITF6r61k4CcaRdjJqqu3qAQBnl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gf+eyv5RD5U+qF+QELKM7jr5Kptot0X88Dk2Joy671FJnVrp3quVW9PjT0x6m9qWWDi6zO301//KtqL8qM4yKUZZonEYK+lPdD0GXIVTeisLJNpp1HyHjkVjvnxbZqpGpYWVij4ZL7xwm6Gh9hX1j5NewgPX9hf4oP8NOXd0ZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VzyXjdRB; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D64BE4E427C5;
	Tue, 24 Mar 2026 09:21:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9439C6011D;
	Tue, 24 Mar 2026 09:21:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BED0610450A18;
	Tue, 24 Mar 2026 10:21:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774344079; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=XijWvmr2G4/VSAMzAQPTLjRdqgm3qgu6QZB5IohDwQI=;
	b=VzyXjdRBB14XeFJ4BD1hGxlYC8ZBdMbt1OFR4Bu4zRp8XrdeeoLebzetzQJZQLdvaOVhWZ
	g0ZsM4r+0lrk8kIRI3iMaeupBBI/e3dRgx2xtmJDuyAcEZWab7WL9ElWCD+qaUGhsn5Wlx
	m30E8TpAYU2cThJhur+u9TUedmFddFoQ7P0Oz5IlqKCQGXvbOh6sq6n2hLJzutVswiZ/QU
	OUoo14Rab1A7/f+3n05Ik0uDOWcfHRQ2dKz79OOl9jRgUYqRSh/ZjOvsW0bTEXWAJObG/S
	WNGWRQ/ml+L+ZMHQktcmrcPkGTopJrERcrRQ5biLv5jP6zlEUSwbvPWNwHej1A==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Rohan G Thomas <rohan.g.thomas@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 0/5] net: stmmac: dwmac-socfpga: Cleanup .fix_mac_speed
Date: Tue, 24 Mar 2026 10:20:55 +0100
Message-ID: <20260324092102.687082-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-270948-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8A44F3059F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi everyone,

This small series does a bit of cleanup in the dwmad-socfpga glue
driver, especially around the .fix_mac_speed() operation.

It's mostly about re-using existing helpers from the glue driver, as
well as reorganizing the code to make the local private structures a
little bit smaller.

No functionnal changes are intended, this was tested on cyclone V.

Maxime Chevallier (5):
  net: stmmac: dwmac-socfpga: Move internal helpers
  net: stmmac: dwmac-socfpga: Use the socfpga_sgmii_config() helper
  net: stmmac: dwmac-socfpga: Use the correct type for interface modes
  net: stmmac: dwmac-socfpga: get the phy_mode with the dedicated helper
  net: stmmac: dwmac-sofcpga: Drop the struct device reference

 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 58 +++++++++----------
 1 file changed, 28 insertions(+), 30 deletions(-)

-- 
2.49.0


