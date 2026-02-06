Return-Path: <netdev+bounces-257546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FqAIXPqhWk0IQQAu9opvQ
	(envelope-from <netdev+bounces-257546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 14:19:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E5CFDFF7
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 14:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BD9C3068A1D
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 13:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504BE3D4103;
	Fri,  6 Feb 2026 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b="XztLg8BH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-108-mta59.mxroute.com (mail-108-mta59.mxroute.com [136.175.108.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EFE3D331B
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770383408; cv=none; b=BhFIsxvWU3PggGsRKpC96+JamAzKER0xHJ379UZYY/YEqiPUDeQH3IxswTe7uM4fuV0xkkBTVGyH1z73D81oSb4npJDPwUbKYQChKK51FukAHwNJLKKnm4/+jnzIvMcqTwjPebHeB8ri9hb9JJeuHto7d8snDOdWqR00lC01bxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770383408; c=relaxed/simple;
	bh=gFYsxyC9dgDjeDfBVtcYJzyaGuVUUL/UvNe3j9g5oh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FRD3iIQLLhfCAjkjQBwVBilfR+gOhNXUtSCBJvcrkBpP9HJE5CdjWfTjbmytAC2CGUyqV59lHdljNV99jsQF+1KQmOT7czl/xi2JoWGLn3GqlqQ68R+8X1LBIv0D372n4F7XvQJIiHeL44zGIEHg/u46XfFpojAUDu3SWMa274c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com; spf=pass smtp.mailfrom=mboxify.com; dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b=XztLg8BH; arc=none smtp.client-ip=136.175.108.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mboxify.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta59.mxroute.com (ZoneMTA) with ESMTPSA id 19c3312d2440009140.00e
 for <netdev@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 06 Feb 2026 13:09:57 +0000
X-Zone-Loop: b4fd4d5327c98dd8f57f42161c88558bc0c503fb09eb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mboxify.com
	; s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xX1GX2YlUSWR6zjeumqZ1M4CyIIwVy3o6ga5DLteJqg=; b=XztLg8BH0PMtZbWfT3Dfhtxf5L
	KKZk2Qb7M5CA7qaSwXo0XxmJpjjZirQiQVzpJnJsdwT/2Ql6aYpvDTOIz+zqmUSCuVRDf0CoKW2Cw
	IL5T6kefFpwvqvgJKdUM+q1VTsk2z/qjgqmWp0WB53UEcJgbFqrHnO/XtlU/dbetv6LvnQ4xDpwEG
	ViKkVm+5YnOYwb3i9qPDqyAIBSZXVJlp1Flr7h+xwj2zmb/jy1B+1tMNyL8DGoCUzi3ULc47U3te3
	1VE/rxQ+rTG/zfIwe4/FWTY7BzARXESPmxX250vxZ5D0RigMVSqXA7lIgd1Y+b0+xLxEzK9TVduQy
	F+peWmUw==;
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
	Bo Sun <bo@mboxify.com>
Subject: [PATCH net v2 2/2] octeontx2-af: CGX: replace kfree() with rvu_free_bitmap()
Date: Fri,  6 Feb 2026 21:09:25 +0800
Message-Id: <20260206130925.1087588-3-bo@mboxify.com>
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
	TAGGED_FROM(0.00)[bounces-257546-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_NEQ_ENVFROM(0.00)[bo@mboxify.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.915];
	DKIM_TRACE(0.00)[mboxify.com:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mboxify.com:mid,mboxify.com:email];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[]
X-Rspamd-Queue-Id: 00E5CFDFF7
X-Rspamd-Action: no action

mac_to_index_bmap is allocated with rvu_alloc_bitmap(), so free it
with rvu_free_bitmap() instead of open-coding kfree(.bmap) to keep
the alloc/free API pairing consistent.

Signed-off-by: Bo Sun <bo@mboxify.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index fd4792e432bf..29f5def796ba 100644
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

