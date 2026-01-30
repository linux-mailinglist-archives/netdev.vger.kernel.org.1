Return-Path: <netdev+bounces-255158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLlcKzC8fGlVOgIAu9opvQ
	(envelope-from <netdev+bounces-255158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:12:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCA8BB796
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2CFF303FFEB
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75ED320A33;
	Fri, 30 Jan 2026 14:10:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A510320CD3
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769782249; cv=none; b=UF1slKE/lwSt76cxs6rsrmQJ+0p9OkhuNJUlM+2I8SqMERL2QTywaOwzBVq07ezDA/xZlMv5kMfEmlxY0PD1JtpKsBuPsW9fBgPo574ZDnLvLI/SDGrHT9kU2O+b4PP2Ii/x2NzohsMztoY8nFC36MDHsvVovn1+MjjO9XNJOu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769782249; c=relaxed/simple;
	bh=B5TGQ4AbtlGi0GS8u9VlYFM4E+h6F2piEFg/dPSzMhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVtdeUXSEapdSPVUXJ1ygMvsUD6bx22HUP4wDkUQFRNtzGPtBOicoUGTQFbD9uzEanRQfDNpHzaCYgEwmNIPwETIi5/zG6z3hjETzgyhnixvmQvKETQoIa2JPBIODOMaSos2uAzoUymdsxrAaLnYp80rT2notchoswp8A0MimZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D3E09200700;
	Fri, 30 Jan 2026 15:10:40 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C5E6A20070B;
	Fri, 30 Jan 2026 15:10:40 +0100 (CET)
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 724B220263;
	Fri, 30 Jan 2026 15:10:39 +0100 (CET)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: vladimir.oltean@nxp.com,
	wei.fang@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH net 3/4] net: enetc: Convert 16-bit register writes to 32-bit for ENETC v4
Date: Fri, 30 Jan 2026 16:10:34 +0200
Message-Id: <20260130141035.272471-4-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130141035.272471-1-claudiu.manoil@nxp.com>
References: <20260130141035.272471-1-claudiu.manoil@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255158-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.manoil@nxp.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BCA8BB796
X-Rspamd-Action: no action

For ENETC v4, which is integrated into more complex SoCs (compared to v1),
16‑bit register writes are blocked in the SoC interconnect on some chips.

To be fair, it is not recommended to access 32‑bit registers of this IP
using lower‑width accessors (i.e. 16‑bit), and the only exception to
this rule was introduced by me in the initial ENETC v1 driver for the
PMAR1 register, which holds the lower 16 bits of the primary MAC address
of an SI. Meanwhile, this exception has been replicated for v4 as well.

Since LS1028 (the only SoC with ENETC v1) is not affected by this issue,
the current patch fixes the 16‑bit writes to PMAR1 starting with ENETC
v4.

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 498346dd996a..c0859d200a2c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -59,10 +59,10 @@ static void enetc4_pf_set_si_primary_mac(struct enetc_hw *hw, int si,
 
 	if (si != 0) {
 		__raw_writel(upper, hw->port + ENETC4_PSIPMAR0(si));
-		__raw_writew(lower, hw->port + ENETC4_PSIPMAR1(si));
+		__raw_writel(lower, hw->port + ENETC4_PSIPMAR1(si));
 	} else {
 		__raw_writel(upper, hw->port + ENETC4_PMAR0);
-		__raw_writew(lower, hw->port + ENETC4_PMAR1);
+		__raw_writel(lower, hw->port + ENETC4_PMAR1);
 	}
 }
 
-- 
2.34.1


