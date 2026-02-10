Return-Path: <netdev+bounces-258119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOnhNt9ci2mbUAAAu9opvQ
	(envelope-from <netdev+bounces-258119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:29:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F7711D2C4
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D2233045024
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17EA38A705;
	Tue, 10 Feb 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="NONzSL45"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D830F389E0B
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740913; cv=none; b=kQeiHYeFFXw7iANShv3Gye1yMn2Bg4Fs5nA2L/fVzOgQVCtM2rANrF1gq4lgfjQU0qBOp8GftyMkM6y5FVIc5mSD0lsr6bkTNZeF+SSyO+XVqC+VD/agGtfV5KAUiBWOUQZwI6S7hK3Ms/8WHcA2xks18whONcIsdsJHilmY7OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740913; c=relaxed/simple;
	bh=/X0/LB+LrQSCGEL4h9BfSJ+Zisjd/PZ0fufTa8o3x3Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IM+iqlLGEevPt5LBmq8WcZrhS/LymUjmWn13J6SakE8wPTC+Amdu1HNuX2VoD2rxdMzHh2nl0AQX2lt7/NPO4RNoFCCI2M2mQ+zHT3QhwRtx3klCUj4pBGWCP427QSB4r4V0EEsCPUwZcUCLy9X+DcQ4BCMHBoq668HXPMkdU5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=NONzSL45; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026021016282095b60725f200020767
        for <netdev@vger.kernel.org>;
        Tue, 10 Feb 2026 17:28:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=sPP0Oz/1LcJ2dWkaUHEgPKlZBEdmg2TasEBz6nxriO8=;
 b=NONzSL45uoyKbwE6fE25ZyReRDaU14KXJOY0/YgjzHltwU+kTEw75HtLOvhtfKQHF+JDxE
 o4iKZ9ER7dzKg2yPhdfGobB4aYRd88UurZwlmBodLXI7bJYReECE7Yz/9vkrSXuBmgDVDrCh
 yThCKRqT4+x8YoDhMhgLwt0OHYEYh5LnkxtT6/skKomfcxJJ6moYYdNTGJ4Cp12yL36wqdUv
 wnhO0xcNykoR+2y6B7PxSJvRmBdD7dQ61dM/OU55DMj6ESEUzxpGxncTcQELq4E7knU+NMFs
 yVWjrbi24U+am/S6JySCuIpp1HSXEQaanO0JKjzehFZf0t+7HiNJWPxw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH net-next 0/2] net: stmmac: Fix MSI vector leak, make stmmac
 NUMA aware
Date: Tue, 10 Feb 2026 17:28:13 +0100
Message-Id: <20260210-flo-net-stmmac-default-affinity-core-v1-0-4e76612444e1@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ1ci2kC/x3NQQ6CQAyF4auQrm0CCCR6FeOizLTSZChmZiAYw
 t0dXf5v8b0DEkflBPfqgMibJl2sRHOpwE1kL0b1paGt26FumhtKWNA4Y8rzTA49C60hI4moaf6
 gWyKj6zuhrhcerh4KNVJiHCOZmwpmawhlfEcW3f/fD/iRxnuG53l+AQH/7CCVAAAA
X-Change-ID: 20260119-flo-net-stmmac-default-affinity-core-c54fa45fe63d
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Voon Weifeng <weifeng.voon@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258119-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.bezdeka@siemens.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[siemens.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens.com:mid,siemens.com:dkim,siemens.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79F7711D2C4
X-Rspamd-Action: no action

Hi all,

This are some fallouts of a quick stmmac "review", while trying to
understand some issues that we have around the IRQ spreading implemented
by stmmac.

The root cause turned out to be something more generic, so not limited
to stmmac. I will try to prepare a discussion starting point later. This
is more a RT specific problem, so I have to bring in more people.

Meanwhile I think it's worth to share some first findings.

---
Florian Bezdeka (2):
      net: stmmac: intel: Fix IRQ vector leak
      net: stmmac: Use cpumask_local_spread() for IRQ spreading

 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 41 +++++++++++++++++++----
 3 files changed, 39 insertions(+), 6 deletions(-)
---
base-commit: 6d2f142b1e4b203387a92519d9d2e34752a79dbb
change-id: 20260119-flo-net-stmmac-default-affinity-core-c54fa45fe63d

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>


