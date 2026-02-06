Return-Path: <netdev+bounces-257548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKPrNDHshWlvIQQAu9opvQ
	(envelope-from <netdev+bounces-257548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 14:27:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62637FE19F
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 14:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 711D4304BC0B
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 13:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075883AEF44;
	Fri,  6 Feb 2026 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b="B3j/3x5N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-108-mta64.mxroute.com (mail-108-mta64.mxroute.com [136.175.108.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA0236D50F
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770383703; cv=none; b=VnTT7Ymr+ptO4MS/nnrx4As965bD3SKdj0Pw+SdA78L9Pl+UhbZGammqyAx9e5moPOZx/TOS64KxtS0GF1RU4jWc1ilC3a1/DBbWptNhpowoRQ2YxEKFUx6CijiA1BlQHv8pg5hrKq7IbQeda1yPAAkpdgLoxc0n44yGQS5lzRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770383703; c=relaxed/simple;
	bh=pVE8CY0vlfW3Mb57nmMnjNNvBzYcywHtHiuhIJtvSU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TtpocZwTDDBcAq7aQqNB4DyV9r6Z/Ws9/DiybMewlPhLGY4iwagE6dBbQdccP3qed8ETRw8Re6bjeW0yAIJ35M0KC+I+X8wY8kKtJdskh3+07oozA8UKO5MxGh+Ns8MSgqRyXChMaxwBVXuaFoPwyflpY3na4xlxs46oYSG67V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com; spf=pass smtp.mailfrom=mboxify.com; dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b=B3j/3x5N; arc=none smtp.client-ip=136.175.108.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mboxify.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta64.mxroute.com (ZoneMTA) with ESMTPSA id 19c3312ba260009140.00e
 for <netdev@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 06 Feb 2026 13:09:51 +0000
X-Zone-Loop: 00f0e17410d847c76645ff86b7cb292815b26d9f5e59
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mboxify.com
	; s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fjermjITUCTuIJl1tKMjCFnYuxvivj1nC4sLm0pFRbQ=; b=B3j/3x5NOWqIlQVmDbM1qBeLcq
	aFnQy4wZc1Vxwq5WZUqXKQQcRhnYH+kMQTyA/IEWf1dToM/4iEAMTNvJ6P7GjIsx6J9sHX7eYlcxk
	iKMngCZ2LsR+OxJactL3aQDBNA1nBViUU944G8T1Kt1eQeCPNd0cRHyOfi+lWyE2LjRjnSOzQzsL4
	+5IOc2NquE0H2f9sz9syEfCqU0FezmfBT5LySpMaD9tsBsjvNJETi7gPHR4m4jUI9CfvhhIZ9s6Sl
	OoNx5CyVqaRaCSv/6JAVYdmRrpizr5p/3LMN2Tr8yhcVt+tHMULYL1LciGJlKvpFXEQfXSp7AVTPH
	tJwBCI2A==;
From: Bo Sun <bo@mboxify.com>
To: kuba@kernel.org,
	pabeni@redhat.com
Cc: gakula@marvell.com,
	sgoutham@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	horms@kernel.org,
	bbhushan2@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	sumang@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bo Sun <bo@mboxify.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] octeontx2-af: CGX: fix bitmap leaks
Date: Fri,  6 Feb 2026 21:09:24 +0800
Message-Id: <20260206130925.1087588-2-bo@mboxify.com>
In-Reply-To: <20260206130925.1087588-1-bo@mboxify.com>
References: <20260206130925.1087588-1-bo@mboxify.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: bo@mboxify.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[mboxify.com : SPF not aligned (strict),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[mboxify.com:s=x];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257548-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_NEQ_ENVFROM(0.00)[bo@mboxify.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.910];
	DKIM_TRACE(0.00)[mboxify.com:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mboxify.com:mid,mboxify.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[]
X-Rspamd-Queue-Id: 62637FE19F
X-Rspamd-Action: no action

The RX/TX flow-control bitmaps (rx_fc_pfvf_bmap and tx_fc_pfvf_bmap)
are allocated by cgx_lmac_init() but never freed in cgx_lmac_exit().
Unbinding and rebinding the driver therefore triggers kmemleak:

    unreferenced object (size 16):
        backtrace:
          rvu_alloc_bitmap
          cgx_probe

Free both bitmaps during teardown.

Fixes: e740003874ed ("octeontx2-af: Flow control resource management")
Cc: stable@vger.kernel.org
Signed-off-by: Bo Sun <bo@mboxify.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 42044cd810b1..fd4792e432bf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1823,6 +1823,8 @@ static int cgx_lmac_exit(struct cgx *cgx)
 		cgx->mac_ops->mac_pause_frm_config(cgx, lmac->lmac_id, false);
 		cgx_configure_interrupt(cgx, lmac, lmac->lmac_id, true);
 		kfree(lmac->mac_to_index_bmap.bmap);
+		rvu_free_bitmap(&lmac->rx_fc_pfvf_bmap);
+		rvu_free_bitmap(&lmac->tx_fc_pfvf_bmap);
 		kfree(lmac->name);
 		kfree(lmac);
 	}

