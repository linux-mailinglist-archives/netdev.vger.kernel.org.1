Return-Path: <netdev+bounces-305554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w4P7BHM7TWqmxAEAu9opvQ
	(envelope-from <netdev+bounces-305554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:46:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B25671E61D
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:46:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=vS115uFR;
	dmarc=pass (policy=none) header.from=samsung.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305554-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305554-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 941543009E06
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 17:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821C143C7B6;
	Tue,  7 Jul 2026 17:45:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C5420879
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:45:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446359; cv=none; b=L0ZoxjJAGWHFloWnUZiP58hePjyyMINgqB45FEwMnASjNnm4hPqJHboC9Xauh/kcTmqrSeng6UgFP/uif7yaccUkyGP8QHS6K5KeKhBR6hsygxDKkTfXEysFF6aqlR3ol5QVAytij13nEF2EW2CxRpuQX80r9Vj1fhJwPL+QDFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446359; c=relaxed/simple;
	bh=eEs/YQV/qeA9HZI+EBdLncpxBy0xa/0PUPdxwQPtSR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=fP1sOidGREGCRRao/hbY1mrwX39J0TPhIMmnLawdWBZTP0udTGgPSboFJX1cRpiUrJHr6rWuKpSXV80fZnbIevaGE3ke3DQN2dCxAtZpB76cc5FIM4Aq2smIDJ481/b3KUbiqmg22L3fc6tzkmu00jszP7kZrc4fT2//JsTtosk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vS115uFR; arc=none smtp.client-ip=210.118.77.11
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260707174556euoutp015154957414102b5d1bd6037a8b5c6133~AEwMiU0OT0163301633euoutp014
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:45:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260707174556euoutp015154957414102b5d1bd6037a8b5c6133~AEwMiU0OT0163301633euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783446356;
	bh=EouyGj5sjPo+B4PHzNf53hocta38XiCJlMuSXmrEmIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vS115uFRSA9jV+Q2D5fuZY7+w6Rjcc+W6YeD6PNNC3CVtcfRF431uRrj3+M9swFe1
	 Ae9pPmdRxYoXVUX2lRIEOA6RePzwAhFE8sGYYpt9P5fWQAljiRIbAtq9rXFVg6rayM
	 Kat5FZ0lyVtB7lSfUVBQEcONyZaPIeF8N+K+Wc2w=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260707174556eucas1p141142a61e5669032194f9eedf6393895~AEwMImIM00456104561eucas1p18;
	Tue,  7 Jul 2026 17:45:56 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260707174555eusmtip23cbd0982b060a2d218f86b6508de3608~AEwLe3I761463414634eusmtip2R;
	Tue,  7 Jul 2026 17:45:55 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: k.tegowski@samsung.com, k.domagalski@samsung.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jakub
	Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net v3 1/2] net/stmmac: Check for STMMAC_DOWN flag in all
 XDP paths
Date: Tue,  7 Jul 2026 19:45:50 +0200
Message-Id: <20260707174551.1264558-2-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707174551.1264558-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260707174556eucas1p141142a61e5669032194f9eedf6393895
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260707174556eucas1p141142a61e5669032194f9eedf6393895
X-EPHeader: CA
X-CMS-RootMailID: 20260707174556eucas1p141142a61e5669032194f9eedf6393895
References: <20260707174551.1264558-1-j.raczynski@samsung.com>
	<CGME20260707174556eucas1p141142a61e5669032194f9eedf6393895@eucas1p1.samsung.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[samsung.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305554-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:k.tegowski@samsung.com,m:k.domagalski@samsung.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:j.raczynski@samsung.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[samsung.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org];
	DKIM_TRACE(0.00)[samsung.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:from_mime,samsung.com:email,samsung.com:mid,samsung.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B25671E61D

Currently STMMAC_DOWN flag is only set/cleared by stmmac_reset_subtask(),
to notify driver to stop processing of TX/RX frames. One of these processing
paths is for XDP, but it is only ever checked in stmmac_xdp_xmit(), which
leaves all other XDP paths vulnerable to processing data while interface is
restarting.

Make verification of STMMAC_DOWN flag consistent by applying check to
all XDP paths.

Fixes: 8b278a5b69a22 ("net: stmmac: Add support for XDP_REDIRECT action")
Co-developed-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2a0d7eff88d3..b9ffff001baf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5260,12 +5260,18 @@ static int stmmac_xdp_xmit_back(struct stmmac_priv *priv,
 				struct xdp_buff *xdp)
 {
 	bool zc = !!(xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL);
-	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
+	struct xdp_frame *xdpf;
 	int cpu = smp_processor_id();
 	struct netdev_queue *nq;
 	int queue;
 	int res;
 
+	if (unlikely(test_bit(STMMAC_DOWN, &priv->state))) {
+		xsk_buff_free(xdp);
+		return STMMAC_XSK_CONSUMED;
+	}
+
+	xdpf = xdp_convert_buff_to_frame(xdp);
 	if (unlikely(!xdpf))
 		return STMMAC_XDP_CONSUMED;
 
@@ -5310,7 +5316,9 @@ static int __stmmac_xdp_run_prog(struct stmmac_priv *priv,
 		res = stmmac_xdp_xmit_back(priv, xdp);
 		break;
 	case XDP_REDIRECT:
-		if (xdp_do_redirect(priv->dev, xdp, prog) < 0)
+		if (unlikely(test_bit(STMMAC_DOWN, &priv->state)))
+			res = STMMAC_XDP_CONSUMED;
+		else if (xdp_do_redirect(priv->dev, xdp, prog) < 0)
 			res = STMMAC_XDP_CONSUMED;
 		else
 			res = STMMAC_XDP_REDIRECT;
-- 
2.34.1


