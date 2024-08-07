Return-Path: <netdev+bounces-116371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD4894A315
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 10:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28432B2D6F4
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 08:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBAA1CB30A;
	Wed,  7 Aug 2024 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="uX/Go35j"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3315C1BDAB6;
	Wed,  7 Aug 2024 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019392; cv=none; b=fXOcVca6QBxfh/pKIhYJbhC7hnY959p2Lw8Si7O+Zp3vVF/QYLrAMDPGc8H6CBQn6WZrFd/+1wNDXkbcdSAZH0topTy3X0pKziL5nOpYv/h3Gz0wUIkAKo6Ded/kZoX3Db+1HYB3A4MM4AKw3jztwcoLBrH0owZt7wCRH7e+NtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019392; c=relaxed/simple;
	bh=OnapAem2E91EqGGMAh397ud0U7heFVYvLvbFISX8OlM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ARwTDVq1suVPoDRvGQDgDqekD5NPG3pDw5Ia5I4W3VgDpPWgJwMRWH/nmcPjE/WUkVI91k8EBQcePMBveuGm0yH5+DixlB5eAyU7RM8YczhSrAV+ByY3QEfwHI1Bs5TRcrspo68MCWHTtLTUPcf7ICni+qm2hKf9LveB1RcHv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=uX/Go35j; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id D9631A050F;
	Wed,  7 Aug 2024 10:29:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=Hg5GSTMLl38WzLZ42vBN3FPT2wlT/tDURwfZyb8EsxM=; b=
	uX/Go35jJLVi8M3I+eRiMjuuU4AQ62Fo8BAu2mA0r1i8GZJ9GyBpJpq5DD0rZWM6
	eTwatiBDY4gQpe/RGKJgD/LVm3g2UuCj2mH4/cTvCBLNxoEIzFLm+GDI1eiYcAPa
	KutoNa7C216JHgA4ggZqsp5S6kdZNMaxf1RBxzAq6BvTgbVMfWL1pt2fnPweG6+r
	fR8wI5/QmOHv8zhGFCCeNnnsg8jfadFYYpzSLqOgeall9AaoHT51e9RZNZo3aHMC
	zXOoVQLD5xcFou/aM1p0+dkB1lcbazsWU3Fw8V9+PEf83E3Qk6/49net0uJdSdZs
	/lD5GTmiWNQIfif+4uNH8AHn2FJDhlUpKrC6OUA0Ak1qiuqgnOyfPZmrlSiPRI2n
	+5ovph72+t3PMaZzizIYcM8qFNFFMgIErAAzi/FmTjEI7pRkCjEN9iwjYnos+aWQ
	JQUf3jMCG2ZTt9cZa9QFYUpwoWxbPnLW5MI7nBWyxEEFRp4mJqaUEMKYE/3FoHwR
	eBwpUJOXSxB4ROyN2xttY5TrU8qIo3TenHFcOJDRcVlT0SpMBR3jqM98CAJzNfIl
	6/YUFFdnzZgEmtG6XOA8MSfNoACd3TrQj+tIBs+F9ahr9f9G5f4xp2mvLHFV31DT
	BBAf8WSv/j12zSqXFuHOKLJfh2IkrGBBFxwL8lzLIu4=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>, "Jakub
 Kicinski" <kuba@kernel.org>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Frank Li <Frank.li@nxp.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH resubmit net 1/2] net: fec: Forward-declare `fec_ptp_read()`
Date: Wed, 7 Aug 2024 10:29:17 +0200
Message-ID: <20240807082918.2558282-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1723019386;VERSION=7975;MC=2323596704;ID=189166;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94854617461

This function is used in `fec_ptp_enable_pps()` through
struct cyclecounter read(). Forward declarations make
it clearer, what's happening.

Fixes: 61d5e2a251fb ("fec: Fix timer capture timing in `fec_ptp_enable_pps()`")
Suggested-by: Frank Li <Frank.li@nxp.com>
Link: https://lore.kernel.org/netdev/20240805144754.2384663-1-csokas.bence@prolan.hu/T/#ma6c21ad264016c24612048b1483769eaff8cdf20
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/net/ethernet/freescale/fec_ptp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index e32f6724f568..fdbf61069a05 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -90,6 +90,8 @@
 #define FEC_PTP_MAX_NSEC_PERIOD		4000000000ULL
 #define FEC_PTP_MAX_NSEC_COUNTER	0x80000000ULL
 
+static u64 fec_ptp_read(const struct cyclecounter *cc);
+
 /**
  * fec_ptp_enable_pps
  * @fep: the fec_enet_private structure handle
@@ -136,7 +138,7 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
 		 * NSEC_PER_SEC - ts.tv_nsec. Add the remaining nanoseconds
 		 * to current timer would be next second.
 		 */
-		tempval = fep->cc.read(&fep->cc);
+		tempval = fec_ptp_read(&fep->cc);
 		/* Convert the ptp local counter to 1588 timestamp */
 		ns = timecounter_cyc2time(&fep->tc, tempval);
 		ts = ns_to_timespec64(ns);
-- 
2.34.1



