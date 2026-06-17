Return-Path: <netdev+bounces-300197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QAjAOZ69Mmr/4wUAu9opvQ
	(envelope-from <netdev+bounces-300197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 17:30:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9786269B010
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 17:30:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b="IIy 2Qdk";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300197-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300197-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4825A3035CCB
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 15:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7727481651;
	Wed, 17 Jun 2026 15:22:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B63D48124B;
	Wed, 17 Jun 2026 15:22:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709769; cv=none; b=oWpOOxlM5qJRnQGAdpalOdFD/uiXoyHnGpErwRud1tN94cckjIo4hfcJTiihZqaN03D45W7knAa1AfWQYGMZivHuG0lxk6wlYgskV3+b1HNIEZ4Ywd1OyaMSxd8yk9JeciAMC9jrfdgZHOH1foipG1rj0860sShnwRF0MuVc4NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709769; c=relaxed/simple;
	bh=c7LifRHfpxprihIq3Hya/HAQQqwRx1QCp4FlrNqFmvM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tddsC4KCQrZ2meN+el1j2rZ4d5r27QL+EpQI7Zp0hpz8DfZ7Ks+OM0TF1sxXxRAyosv/p4H/RTjrFRqAGwjvw2ah/cfoELdr3ZCMjql+PRzCmCVMU/WmsK/IjSOLH4UdGjsO9cCxTfGQ4512Qw7F7biW2tZa7YUuPdkkMPJ617Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IIy2Qdkl; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HEGPVr2252290;
	Wed, 17 Jun 2026 08:22:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=3Do1feV2y8PXaWZ6/Cx1WHXVX3co6azH55bNI566uDQ=; b=IIy
	2QdklsMX7A6776fY7cgxSU+UEKdNoSi52g81S8OONd1D2hGY9VUyNLgDAywXyKVV
	LZhv5qP0ThVh/92M4K4ypqu/SLcIXP3UIXuaT3NGtX9n/rIhp1hAZ+3Bfaz2hzjp
	2dcEeW0Fq0xRfASrgR8gVVxoO+S8WJovM9hX4+5qiA6jWrfA2uJf9DdkrCD0y+Ll
	5Du2/Mp7OkiTpLEDlVDRAF8raLpyABVOpbkOHlyiwp9h6XfobGwCNKaMCDq0ePDj
	YdVyV8DBjGEatReOMaBMp3XbWr/rK9Mopka+h9cW/ve1qZAInn+lSi7NEXaTv+/y
	/3SEi5pEm8QZnpzCV3w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eueg4k3tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 08:22:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 17 Jun 2026 08:22:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 17 Jun 2026 08:22:36 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 068133F703F;
	Wed, 17 Jun 2026 08:22:32 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>, <rkannoth@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [net PATCH v2] octeontx2-af: Validate NIX maximum LFs correctly
Date: Wed, 17 Jun 2026 20:52:30 +0530
Message-ID: <1781709750-23218-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE0NiBTYWx0ZWRfX4hqhG5yd0rZK
 FQ1j2SNRBI+/uJmaWW8pQMlXn5osPlgVuo1S1SgSqt+6BgYX+M3dATjohWYht8s8jQ/9GaZ3oem
 NbRU0ECRyzBBB0myHDN5Ppfd8QjiVY5g+gJHpyYPIC46q+Qc/iQXixqXkHXWMxmAzf8Z9qclTwn
 Tz52BJZID6HOTxgXUlgOOZ55AuBIhicKXM5l9wGXq4/L/eV/ApyODO6VgW+P6FXV2e1fMSh3kMn
 7yxv4VnLT87Q+eL8U0AnPXOwbZJyLwkHKoPJoPlk/4hPXsuSEiBsb3fJNyI79B+7lCAYirOe+HD
 a+Ulik6xQm/AdA0FVDvYa7DlmUK7BHShnnr0ALU0+fkaVpjuqbwacTSi3FahE5DOo3Dxrrbpngy
 QMqIb0Q6CzDSrW8qEG4R1EvcJSbsXe5CbbR5PY7yBnNuo6qZK7g8OCnV5eBqG43YZ5NVsFuCH01
 hD0oOdwPrE1R1XFAw7w==
X-Proofpoint-ORIG-GUID: vsfGpfTDfurJVe8TuOl2C3a0Xn3J5Wa8
X-Authority-Analysis: v=2.4 cv=JZqMa0KV c=1 sm=1 tr=0 ts=6a32bbbd cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=uS7SUEiOpQzJ16ilQwoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE0NiBTYWx0ZWRfX8KByKZQY232m
 ftlLtcz9u7EDFTWypI8UdgN052PE8FbBl2cb/xLlWNDmtqY/Faj0W8b7K9l3fDNSqEXtgzXR1/y
 owxOkKSDsaVxpGyk5DTYwzY6Ewbp55Y=
X-Proofpoint-GUID: vsfGpfTDfurJVe8TuOl2C3a0Xn3J5Wa8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-16_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300197-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:gakula@marvell.com,m:bbhushan2@marvell.com,m:rkannoth@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sbhatta@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9786269B010

NIX maximum number of LFs can be set via devlink command
but that can be done before assigning any LFs to a PF/VF.
The condition used to check whether any LFs are assigned is
incorrect. This patch fixes that condition.

Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../marvell/octeontx2/af/rvu_devlink.c        | 27 +++++++++++++------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 6494a9ee2f0d..3b47ecb44d51 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -1510,7 +1510,9 @@ static int rvu_af_dl_nix_maxlf_validate(struct devlink *devlink, u32 id,
 	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
 	struct rvu *rvu = rvu_dl->rvu;
 	u16 max_nix0_lf, max_nix1_lf;
-	struct npc_mcam *mcam;
+	struct rvu_block *block;
+	int blkaddr = 0;
+	int free_lfs;
 	u64 cfg;
 
 	cfg = rvu_read64(rvu, BLKADDR_NIX0, NIX_AF_CONST2);
@@ -1518,14 +1520,23 @@ static int rvu_af_dl_nix_maxlf_validate(struct devlink *devlink, u32 id,
 	cfg = rvu_read64(rvu, BLKADDR_NIX1, NIX_AF_CONST2);
 	max_nix1_lf = cfg & 0xFFF;
 
-	/* Do not allow user to modify maximum NIX LFs while mcam entries
-	 * have already been assigned.
+	/* Do not allow user to modify maximum NIX LFs while NIX LFs
+	 * have already been assigned. Note that modifying NIX LFs count
+	 * can be done only before any LF attach requests from PFs and VFs
+	 * and not later or concurrently.
 	 */
-	mcam = &rvu->hw->mcam;
-	if (mcam->bmap_fcnt < mcam->bmap_entries) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "mcam entries have already been assigned, can't resize");
-		return -EPERM;
+	blkaddr = rvu_get_next_nix_blkaddr(rvu, blkaddr);
+	while (blkaddr) {
+		block = &rvu->hw->block[blkaddr];
+
+		free_lfs = rvu_rsrc_free_count(&block->lf);
+		if (free_lfs != block->lf.max) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "NIX LFs already assigned, can't resize");
+			return -EPERM;
+		}
+
+		blkaddr = rvu_get_next_nix_blkaddr(rvu, blkaddr);
 	}
 
 	if (max_nix0_lf && val.vu16 > max_nix0_lf) {
-- 
2.48.1


