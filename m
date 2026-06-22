Return-Path: <netdev+bounces-301139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XwsiFXpJOWrqpwcAu9opvQ
	(envelope-from <netdev+bounces-301139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 16:40:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CD36B0670
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 16:40:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codethink.co.uk header.s=imap4-20230908 header.b=nWTKzmrd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301139-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301139-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=codethink.co.uk;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EB99302FA94
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103E53BB131;
	Mon, 22 Jun 2026 14:37:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCD13AFD16;
	Mon, 22 Jun 2026 14:37:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139059; cv=none; b=mYh4HmzVWzFZgZsQt51SipLYkmQBLLwTwvSpVMPsnGjW99Hi6eRnXCakQ6iXkoYRvYc3bDnNS9R7jyufYJKXA3fivpStrn9oMpZfKGc2nI09ECGW+FlBO5hiRpBUliX9ZYXGtKg55OQvfthD5qyGwtRbFcDXe2bpHMvFKllzcJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139059; c=relaxed/simple;
	bh=DDQCwvPIno1RwvT/9XpgR+AZHAnpICCgVyFNZg4C5M0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=l3zglF4wBFVaiM2fZPK2rsjeAQ8/zSt06soe9wNyoPzLeEXnsH2DcxE5/dE3gMIWIvcaOW8yNbgOion/BkHEE92Er4ifjGLT8/aJCVnzv399Xad3ZGAHCX5SoN4oPn8DgcIOn2mxICUGjDw3As+0EecKXtldBg+/S3IZudbZxQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=nWTKzmrd; arc=none smtp.client-ip=188.40.203.114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:In-Reply-To:
	References; bh=byJmp20ozUXMyoKY5EOWJZujkHr16poyflFSxhdQvxg=; b=nWTKzmrd4iK95s
	PDDmh2o+j1xgFfJJKO8SOtPNODbt39YHDkQunnC/Szi8IjIUfQmLP4J5lMC1W62l95nWo6ce/nHHH
	+s1QAQcRoFOgkeIZIAo05FBsGdL1pM50bMAsQ34a0e3i6o3d30avo/cT9DRzjosUZXpBYx5m9IXTO
	ODvXdNhXY/gZ5y6nzMnwsARJI3tZf6Gd0uQPpiQORYDuIMCs5M1gDjuxUy/ydxoS31CcU8FbJskV4
	sDuBmcWL+4cn7J5W0+ARrFfrkyXrydZ1jguzI+OsgQuJ9NMgRiXp0LXgiZdYQYOT6wRV3htGM/XJs
	pfRdirhSLo68+Xzw7VdA==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wbflu-00EqWl-D2; Mon, 22 Jun 2026 15:37:10 +0100
Received: from ben by rainbowdash with local (Exim 4.99.4)
	(envelope-from <ben@rainbowdash>)
	id 1wbfls-000000025LX-32iL;
	Mon, 22 Jun 2026 15:37:08 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: fix missed le32_to_cpu()
Date: Mon, 22 Jun 2026 15:37:07 +0100
Message-Id: <20260622143707.497198-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[codethink.co.uk,reject];
	R_DKIM_ALLOW(-0.20)[codethink.co.uk:s=imap4-20230908];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301139-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,codethink.co.uk,bootlin.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:ben.dooks@codethink.co.uk,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ben.dooks@codethink.co.uk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.dooks@codethink.co.uk,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[codethink.co.uk:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codethink.co.uk:dkim,codethink.co.uk:email,codethink.co.uk:mid,codethink.co.uk:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8CD36B0670

The print in ndesc_display_ring() sends the des2 and des3
to the pr_info() without passing them through the relevant
conversion to cpu order.

Fix the (prototype) sparse warnings by using le32_to_cpu():
drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17: warning: incorrect type in argument 6 (different base types)
drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17:    expected unsigned int
drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17:    got restricted __le32 [usertype] des2
drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17: warning: incorrect type in argument 7 (different base types)
drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17:    expected unsigned int
drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17:    got restricted __le32 [usertype] des3

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index c4b613564f87..74c9b7b1fe8f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -258,7 +258,7 @@ static void ndesc_display_ring(void *head, unsigned int size, bool rx,
 		pr_info("%03d [%pad]: 0x%x 0x%x 0x%x 0x%x",
 			i, &dma_addr,
 			(unsigned int)x, (unsigned int)(x >> 32),
-			p->des2, p->des3);
+			le32_to_cpu(p->des2), le32_to_cpu(p->des3));
 		p++;
 	}
 	pr_info("\n");
-- 
2.37.2.352.g3c44437643


