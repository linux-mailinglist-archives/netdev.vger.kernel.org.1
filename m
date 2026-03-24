Return-Path: <netdev+bounces-271087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MzPMfuTwmkXfAQAu9opvQ
	(envelope-from <netdev+bounces-271087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:39:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2773C309922
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61BA33041BF3
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A729E3FBEC6;
	Tue, 24 Mar 2026 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="EUcwtJUv"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AC63845C1;
	Tue, 24 Mar 2026 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774359162; cv=none; b=RkTccak4kee84Gwo/a15+chVFKPSyOu692TbUt5mWB5gHQrjg5bfP5q0OF+TIrPGKmvmLrCSmuxXbFw+ITFbhSrPdiHpH41Ky9wD/OppeYfa/0Qkk9nLSo1qvocgqanNnpr/YvjCk8jBjVJluZFSkPswma0GdZaUXwkSAhg9Vos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774359162; c=relaxed/simple;
	bh=uRREZHQ6UvLvw+UtUfpgXFm6p/fFCBlLtr3me5Hydxc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q2QmMC53DNLeH4XZi0diRUz4EkKbaoMVGDtm2kJhasNd1iHQzXSohSabVI61GeTKr41I25KM2efHvCx3gACHllbOVkmU/fJHFgtPwhf7vvULa8deyVbpTFL2A/+VXtKhSFrKp8LtFT6F5J8tEwrjj2fjnWHh4zzqGqcVojJUn9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=EUcwtJUv; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 7BDB6A0CB0;
	Tue, 24 Mar 2026 14:32:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=yQvc1G0NsM7Wd8sgPniOCT4tfMBGaEGtNGqp9sTR2l4=; b=
	EUcwtJUvbIZXdg1Mkg/TKgz8uLIV0XcM42jNwFvFDcZE1X5GD+C82D99/D81frfe
	IeH9B5TCvZsk0k3G69xUXnwzurHN51DzulEmZkN8j3NZrx0fxgxLSNbg4P9ZJPUv
	6rh0jEhy9U2cCQKTmVC4jdLRuIMo6OSxsLLf378dIo6kzPoKe89o5mJBPiGYu+AV
	wQiPgrImF22F/iPb+4EkQCjoPQD3cJxDGJJcot5G3dkZZ+OobCTP/DVPwmgRXbxd
	APUe6QvZsvJ7oMRQd/efF1Qv3kH/urXlLZcvDVT9DZmAhCvk2iGWkc+t31SridBC
	6inxaC26wYB+5rYOQ+Z8bVm3j+tGc1pP3WizlA1iOlwbaEptCvA3HznJYdNgt25a
	+AwBHH2TF4F4I/zzVpVt5SNUDOS9+xAfTKmgapoGNfE9/xcPCyqsB/jFRk77pQl9
	djk2TCoGZTTpLN5fRHPjpUMmuvqy/IY8Hv/ADobCbMjkleuWbprG4vxAiSIRXIec
	kAZ6JAeTZ7YOVqvidpGKv+KnG9z+LxOApeDK/8Zh/lYy2wb78R4vdkkIIlEMrSpX
	OxVbxdCOYLY/ExG9dBavnQE2C5FDNyyn/APYSmD2eE+2zX9q44DGDqzD2W7gJSxz
	HMCLrW0etYeca1wwpq7C8HCVsbI6qm9y0YceH3USqeA=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>, =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?=
	<bence98@sch.bme.hu>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net v3 1/1] net: fec: fix the PTP periodic output sysfs interface
Date: Tue, 24 Mar 2026 14:32:30 +0100
Message-ID: <8ec2afe88423c2231f9cf8044d212ce57846670e.1774359059.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1774359153;VERSION=8008;MC=4004315875;ID=133597;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29676715506D7162
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[prolan.hu,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[prolan.hu:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271087-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,toradex.com,sch.bme.hu,lists.linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[prolan.hu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[buday.csaba@prolan.hu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,prolan.hu:dkim,prolan.hu:email,prolan.hu:mid]
X-Rspamd-Queue-Id: 2773C309922
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the PPS channel configuration was implemented, the channel
index for the periodic outputs was configured as the hardware
channel number.

The sysfs interface uses a logical channel index, and rejects numbers
greater than `n_per_out` (see period_store() in ptp_sysfs.c).
That property was left at 1, since the driver implements channel
selection, not simultaneous operation of multiple PTP hardware timer
channels.

A second check in fec_ptp_enable() returns -EOPNOTSUPP when the two
channel numbers disagree, making channels 1..3 unusable from sysfs.

Fix by removing this redundant check in the FEC PTP driver.

Fixes: 566c2d83887f ("net: fec: make PPS channel configurable")
Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
 drivers/net/ethernet/freescale/fec_ptp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 4b7bad9a485d..56801c2009d5 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -545,9 +545,6 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 		if (rq->perout.flags)
 			return -EOPNOTSUPP;
 
-		if (rq->perout.index != fep->pps_channel)
-			return -EOPNOTSUPP;
-
 		period.tv_sec = rq->perout.period.sec;
 		period.tv_nsec = rq->perout.period.nsec;
 		period_ns = timespec64_to_ns(&period);

base-commit: 8a63baadf08453f66eb582fdb6dd234f72024723
-- 
2.39.5



