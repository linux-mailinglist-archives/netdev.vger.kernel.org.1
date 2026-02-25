Return-Path: <netdev+bounces-260790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILT6EpG0nmnZWwQAu9opvQ
	(envelope-from <netdev+bounces-260790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:36:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 862BD1944CF
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10B173018AFA
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2386D2FFFA4;
	Wed, 25 Feb 2026 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b="IDR2C0mu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-108-mta144.mxroute.com (mail-108-mta144.mxroute.com [136.175.108.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBA41E98E3
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772008161; cv=none; b=IQZ/cOdBKS3xSS7EmQEZ7yGqID8v3sV9ZFeRnCBix+Z2t/iv7H0ZQgOdsmRO6LgCZYtFpH7ZhH1OIecdIZTdUPYclfzffs9nIJ+PRnDHC/uYBBth4H/JsMYgTH2WpkNfL4Z7/vH3Zu1S5Vd4zom5decptteD9cSQABkj8R8zf1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772008161; c=relaxed/simple;
	bh=aQRhbWCBRikgCi38TLJTo2ik4H5DsWb012cZkV0R0Ic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uvv5xz0cgcFJ/TuFUkXW7GP5w2NFoT6d1pFt3ilG+P2FGmSI1I2O1VNqvNh0mqkhtxYOX2mxLLiE77W6KbsIv7NURvZ2++ZE+uWe6geeGNXwXaZqMAqkY34M715jqclmnL+z8npSdkqreDyyrgxmU1Y9zf1YhK3nAN5kitnnukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com; spf=pass smtp.mailfrom=mboxify.com; dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b=IDR2C0mu; arc=none smtp.client-ip=136.175.108.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mboxify.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta144.mxroute.com (ZoneMTA) with ESMTPSA id 19c93e5e47b0007228.00e
 for <netdev@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 25 Feb 2026 08:24:02 +0000
X-Zone-Loop: 52738d06c64c1cccf64e94f2321ad777ed966fd61ea6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mboxify.com
	; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To
	:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=IlL1ZRWyTyhu1iPuaOuSM6UXp3d14WDk/bOmhY6qguc=; b=I
	DR2C0muAscQ3Zfc6Myqxl66C86hDQ9GAOXJ7wINyvzq7FPUitW9SO4FaGHmG2GS+E0M2RFc7niAsj
	XgLZZUdYZD4+E95zMcXgwLNUfW2Q2uUs7hCDmd6ygfqN1lkwHR5odhIgxJ+s5lrWVD9K+Z4Ae3aTx
	abZkjgKxl/5qhD3xPgkdPXbGL/EUqRdqZnk2qd5KkWk6ghUTKN7uIEhzIfRbGDB1/QLcu3HZfbS8G
	I/X4IoX7Ra21V3Fht952T64u7Qf0nf/94C84Vu/39goHb7bPQvLeWFHGuplu/k0Y7eZ5z1Cw4S+3e
	oVouKTFjtIdyjfTDp3OKRJ2v6IRKSgL3w==;
From: Bo Sun <bo@mboxify.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	vadim.fedorenko@linux.dev
Cc: pabeni@redhat.com,
	jerinj@marvell.com,
	lcherian@marvell.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	Bo Sun <bo@mboxify.com>
Subject: [PATCH net-next] octeontx2-af: CGX: replace kfree() with rvu_free_bitmap()
Date: Wed, 25 Feb 2026 16:23:48 +0800
Message-Id: <20260225082348.2519131-1-bo@mboxify.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: bo@mboxify.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.44 / 15.00];
	DMARC_POLICY_REJECT(2.00)[mboxify.com : SPF not aligned (strict),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[mboxify.com:s=x];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	URIBL_RED(0.50)[mboxify.com:mid,mboxify.com:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	HAS_ANON_DOMAIN(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260790-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.952];
	FROM_NEQ_ENVFROM(0.00)[bo@mboxify.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mboxify.com:-];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mboxify.com:mid,mboxify.com:email,linux.dev:email]
X-Rspamd-Queue-Id: 862BD1944CF
X-Rspamd-Action: add header
X-Spam: Yes

mac_to_index_bmap is allocated with rvu_alloc_bitmap(), so free it
with rvu_free_bitmap() instead of open-coding kfree(.bmap) to keep
the alloc/free API pairing consistent.

Signed-off-by: Bo Sun <bo@mboxify.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 6000795823a3..4f33a816bc7a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1822,7 +1822,7 @@ static int cgx_lmac_exit(struct cgx *cgx)
 			continue;
 		cgx->mac_ops->mac_pause_frm_config(cgx, lmac->lmac_id, false);
 		cgx_configure_interrupt(cgx, lmac, lmac->lmac_id, true);
-		kfree(lmac->mac_to_index_bmap.bmap);
+		rvu_free_bitmap(&lmac->mac_to_index_bmap);
 		rvu_free_bitmap(&lmac->rx_fc_pfvf_bmap);
 		rvu_free_bitmap(&lmac->tx_fc_pfvf_bmap);
 		kfree(lmac->name);

