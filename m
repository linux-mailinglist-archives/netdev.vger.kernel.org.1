Return-Path: <netdev+bounces-274707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB0mHIDhzml2rAYAu9opvQ
	(envelope-from <netdev+bounces-274707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:37:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA59F38E654
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41EA73045004
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 21:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B05C3B7777;
	Thu,  2 Apr 2026 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="vOUmI1T4"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp10.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57C03AC0FD;
	Thu,  2 Apr 2026 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775165813; cv=none; b=YVLQvNShYh11dcnPpJqhS+Sx4ECjgS9OlyJ+nt9fpxopmuuPWsOus7BXqIYELNF1A6uFV0Q2myhH5Am4cBEayllbFL5D36xo6Peo244MIA3DKwUoV2C27sRqWWdeQSDLmYxLyN2vVqnSI2Hry82JAReDZAWju5/VM0ZkVIsG/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775165813; c=relaxed/simple;
	bh=/7pvxyjAbdC+aTRnvIOLO3AixVnSpkXmZjLfqfwJpuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5GLzz2XdDp0Aax9KhhF3UdTfi3pgloDQH/tWJNiFGDpttvJJCvhEMMTc8yXi9EXRJ3ynki9m1FOG4esm+4CfaREpxCxMAsyzo3NrHKrOy/jRgbS6LUbBqhFNJ+6rHi1wMk38vSHPGlCzPZhH6ourunx68A4Ruju+upeDNdL33E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=vOUmI1T4; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 8B81AC002831;
	Thu,  2 Apr 2026 14:36:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8B81AC002831
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1775165805;
	bh=/7pvxyjAbdC+aTRnvIOLO3AixVnSpkXmZjLfqfwJpuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vOUmI1T4by8hVOXZej67/qQCr6ywynB3MwsLJD7A1olaKD0QYRlDRAQ4Zu4fQlIKz
	 rdx7aAhxNBIZ+I+vGfhQu+bSyV8PC1PPrxEdFu9QCvFAbSkum2oXgNV5P/kbpM3W0a
	 gNxBLTg+xderkqw8laVxDdBi0LGOef2SevTZWyc8=
Received: from lvnvdb8054.lvn.broadcom.net (lvnvdb8054.lvn.broadcom.net [10.17.214.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 4A1C1AE80;
	Thu,  2 Apr 2026 17:36:43 -0400 (EDT)
From: "Jitendra Vegiraju" <jitendra.vegiraju@broadcom.com>
To: netdev@vger.kernel.org
Cc: alexandre.torgue@foss.st.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	jitendra.vegiraju@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	richardcochran@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	rmk+kernel@armlinux.org.uk,
	rohan.g.thomas@altera.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	me@ziyao.cc,
	siyanteng@cqsoftware.com.cn,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	vladimir.oltean@nxp.com,
	lizhi2@eswincomputing.com,
	boon.khai.ng@altera.com,
	maxime.chevallier@bootlin.com,
	chenchuangyu@xiaomi.com,
	yangtiezhu@loongson.cn,
	ovidiu.panait.rb@renesas.com,
	chenhuacai@kernel.org,
	florian.fainelli@broadcom.com,
	quic_abchauha@quicinc.com
Subject: [PATCH net-next v9 2/4] net: stmmac: Integrate dw25gmac into hwif handling
Date: Thu,  2 Apr 2026 14:36:27 -0700
Message-ID: <20260402213629.1996133-3-jitendra.vegiraju@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260402213629.1996133-1-jitendra.vegiraju@broadcom.com>
References: <20260402213629.1996133-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=dkimrelay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274707-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[foss.st.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,iogearbox.net,armlinux.org.uk,altera.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lunn.ch,fomichev.me,ziyao.cc,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,nxp.com,bootlin.com,xiaomi.com,loongson.cn,renesas.com,quicinc.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jitendra.vegiraju@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[38];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid]
X-Rspamd-Queue-Id: CA59F38E654
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>

Integrate dw25gmac support into stmmac hardware interface handling.
Added a new entry to the stmmac_hw table in hwif.c.

Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 511b0fd5e834..a69f558c0db0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -287,6 +287,26 @@ static const struct stmmac_hwif_entry {
 		.mmc = &dwxgmac_mmc_ops,
 		.est = &dwmac510_est_ops,
 		.setup = dwxlgmac2_setup,
+	}, {
+		.core_type = DWMAC_CORE_25GMAC,
+		.min_id = DW25GMAC_CORE_3_20,
+		.regs = {
+			.ptp_off = PTP_XGMAC_OFFSET,
+			.mmc_off = MMC_XGMAC_OFFSET,
+			.est_off = EST_XGMAC_OFFSET,
+		},
+		.desc = &dwxgmac210_desc_ops,
+		.dma = &dw25gmac400_dma_ops,
+		.mac = &dwxgmac210_ops,
+		.vlan = &dwxgmac210_vlan_ops,
+		.hwtimestamp = &stmmac_ptp,
+		.ptp = &stmmac_ptp_clock_ops,
+		.mode = NULL,
+		.tc = &dwmac510_tc_ops,
+		.mmc = &dwxgmac_mmc_ops,
+		.est = &dwmac510_est_ops,
+		.setup = dw25gmac_setup,
+		.quirks = NULL,
 	},
 };
 
-- 
2.34.1


