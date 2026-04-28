Return-Path: <netdev+bounces-282006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZqZTDePo8GlObAEAu9opvQ
	(envelope-from <netdev+bounces-282006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:05:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8750489935
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E23430DB608
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F1833A039;
	Tue, 28 Apr 2026 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="otju8JuJ"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B99C33BBB1
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395532; cv=none; b=myRuB0laQrRi++23xsveZy80SLiVVEFpjP+8W/FewL/qpLD1LnpmpUe3k6yTMYi9odHDDkjOmxX1Rh+ekGx1ExWX00sux5posnACSynfb7cHVNDmhoBZSnyD5URL7IA7sciZi5T8COkh6DhvpAn2D/nhBIAZ9x1dFotR4LrTV4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395532; c=relaxed/simple;
	bh=AxYDfakJiQxU5ul/E84VacmriTxiXFo9Z1VTWO/+zFY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nckspNS7jo3R92JnwMK6uVKlQA5RH4dv64ufN5z3MSzJVkA41h4A98F9zOWWWu8hRiY7Rwblwxjj8LR9k47gNDNBnuaF9wN360QZ/BOHcFG2gy5f0eyuUQghYYQqeMPgaCJ5GlQxLtV5yn3wtrN0bbeDCvAxCmK0p7YkcSpd3vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=otju8JuJ; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1777395531; x=1808931531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c8sNKE6En7PrYmD8IEYD8eYaFFScNrO5dFuUZkK/cqs=;
  b=otju8JuJBdcdjIyv7aaqogjfu0hWMQtohWcsVc/Uf4kF4AmsTdHkknJO
   CsaIzJ+VwCzFdhv83vzUKORf5qi6ENpbYSfDldaZU9SbDr12PaxWSfdHg
   n8gL/zXvEPRNu0CcAj7jw+uvpEBwRaoACmo2r9K5rl3jMAgiQgaGL4BdD
   gcyKBVtQxr/Y8RlpNXuyIQlhS5+thRjfbk4C2dcdo3nvwtA/VAKwmZuHg
   hMu19bg9ZaYF+JBMvBFTs+tJhOuMAnT5FxEilzt7OFlReWodTsuUUggV6
   w17PpQ2kMDK2xW22GA6nd0CFtH29bHuhetZ5Tbxyhx/klmLyXt+OF9iFe
   g==;
X-CSE-ConnectionGUID: WfrbNNgfSB+34TmfxGxgUA==
X-CSE-MsgGUID: H/LYMfprRlChpiks1+gxKg==
X-IronPort-AV: E=Sophos;i="6.23,204,1770595200"; 
   d="scan'208";a="18269235"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 16:58:48 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:19122]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.77:2525] with esmtp (Farcaster)
 id 809062fd-9c68-4ceb-a03c-d7561b8dd918; Tue, 28 Apr 2026 16:58:48 +0000 (UTC)
X-Farcaster-Flow-ID: 809062fd-9c68-4ceb-a03c-d7561b8dd918
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 28 Apr 2026 16:58:47 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 28 Apr 2026 16:58:43 +0000
From: Arthur Kiyanovski <akiyano@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: Arthur Kiyanovski <akiyano@amazon.com>, Richard Cochran
	<richardcochran@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, "Woodhouse, David" <dwmw@amazon.com>, "Sarna,
 Yonatan" <ysarna@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Arinzon, David"
	<darinzon@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, Amit Bernstein <amitbern@amazon.com>
Subject: [PATCH net-next 6/8] net: ena: Update PHC admin interface for error bound support
Date: Tue, 28 Apr 2026 16:54:24 +0000
Message-ID: <20260428165659.2811-7-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428165659.2811-1-akiyano@amazon.com>
References: <20260428165659.2811-1-akiyano@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: C8750489935
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282006-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Extend the ENA admin interface to support error bound.

Add error_bound to the PHC response structure.
Introduce a feature version mechanism to indicate device supports
error_bound, and add an error flag for error_bound retrieval failures.

This enables the driver to retrieve error_bound information from the
device alongside timestamps.

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
---
 .../net/ethernet/amazon/ena/ena_admin_defs.h    | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
index 898ecd9..2d132c4 100644
--- a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
+++ b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
@@ -128,12 +128,14 @@ enum ena_admin_get_stats_scope {
 	ENA_ADMIN_ETH_TRAFFIC                       = 1,
 };
 
-enum ena_admin_phc_type {
-	ENA_ADMIN_PHC_TYPE_READLESS                 = 0,
+enum ena_admin_phc_feature_version {
+	/* Readless with error_bound */
+	ENA_ADMIN_PHC_FEATURE_VERSION_0             = 0,
 };
 
 enum ena_admin_phc_error_flags {
 	ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP   = BIT(0),
+	ENA_ADMIN_PHC_ERROR_FLAG_ERROR_BOUND = BIT(1),
 };
 
 /* ENA SRD configuration for ENI */
@@ -1035,10 +1037,10 @@ struct ena_admin_queue_ext_feature_desc {
 };
 
 struct ena_admin_feature_phc_desc {
-	/* PHC type as defined in enum ena_admin_get_phc_type,
-	 * used only for GET command.
+	/* PHC version as defined in enum ena_admin_phc_feature_version,
+	 * used only for GET command as max supported PHC version by the device.
 	 */
-	u8 type;
+	u8 version;
 
 	/* Reserved - MBZ */
 	u8 reserved1[3];
@@ -1224,7 +1226,10 @@ struct ena_admin_phc_resp {
 	/* PHC timestamp (nsec) */
 	u64 timestamp;
 
-	u8 reserved2[12];
+	u8 reserved2[8];
+
+	/* Timestamp error limit (nsec) */
+	u32 error_bound;
 
 	/* Bit field of enum ena_admin_phc_error_flags */
 	u32 error_flags;
-- 
2.47.3


