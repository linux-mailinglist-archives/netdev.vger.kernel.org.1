Return-Path: <netdev+bounces-116368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9D494A273
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 10:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9B41F25C17
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 08:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93BB1C9DE8;
	Wed,  7 Aug 2024 08:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="F4Tprxxe"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5AF13F435;
	Wed,  7 Aug 2024 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723018284; cv=none; b=q0VG2aOMtDfsn12KarPjSeVRCFRJ5PdhokWpWPamof6Ik9F6Y5f0A1ImJkk0ZzTeUzRQYbTHKyhTwOTEkXxIW9WKNA6E3WVMoJcKYMnCOPlvnXWnK/R7vJ+HkgwH1dnDBgUH53/7EByioao3LDSrRQw15tnWB/XTTxtYpRS2UPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723018284; c=relaxed/simple;
	bh=O7WCjeIvWkbZgBS6vM4vQIgl4u3loiquJKhsttv30Po=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfJCYBR5I6Bk5wJxmr9G/gydn9vMG5dR12NvH8yLlpinQQKsa46F67Mk6zV6ob2nZObQJEkCfFlIisIUgkjg0QWjAc1wmNQaItt3j0Ir7yOMRBSnDdHWVekjHUfLA2D5oKp2IPf7GXqKClcgAYkTiRgU/pxOWXcBL6M0tL4lUNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=F4Tprxxe; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 0EB16A05B2;
	Wed,  7 Aug 2024 10:11:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=KEun1WLwGlElpIBwl7qA
	hygYiEvU6poeyl+GGcKm/bA=; b=F4TprxxeNJ+M6GhE6PQniqBPwzBMc+icwTzv
	1BIsuzc2IezHaUkTzzuaZLcrvQwHj3yP92v4f8oKOabIhQCZkI5kUyaiir2vQEoM
	15RwQPKIuaC2zhXaO2iLINuGGtd7+4j1c0l/wEK9VbZSwFrpkXUiqslxlbxzVsjZ
	J1n73dXoH9jLgU2qnaURR3/otgTfqd5XPDk68AeLpKDP2NtMzOCsoJ0N0EDjMGhj
	/xqsCQ+9oJplBg1/3t3AlwIGRBhATFg7z99983wmrme/8KpoMdB3nL3MyophbCXH
	MbR3Eb1Ey2D8O1vA+4GSsOWnxybyG6yZfxsdca+8l3cBMTmAuY9ThL6wVPcvuCen
	yp/zJLHZFNSKAEs6GCAYHRdPJRo83L0iAMWtHI9NCZxJlfvT4Yu6uXgiwHKZGgVq
	gEDFV6CwniZaR+RkDRl7dSfoa9Elxhv67f7bzzuIYnonewjVehgFv5h8PPHaSXfw
	lwMk23fJWLzzyW1ZV0OaaPscbnKPegqlg/ciBrz5j9KHUdDLqNkGZdFAKl2WR0Ky
	S8W4FykvWAl7U+ICYzy4v6o39GHNMnaKeHArD6Z2xPXIKakuqDuiBU+WyBBQMtYr
	zOOYaCpNYIBBkI9gbhuOOQIkvdGU9wYBlJfBsnfkeqA1UAwojDLdhWOlcB/9hgXI
	i4AOvXk=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: Fugang Duan <B38611@freescale.com>, "David S. Miller"
	<davem@davemloft.net>, Lucas Stach <l.stach@pengutronix.de>,
	<imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Fabio
 Estevam" <festevam@gmail.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH resubmit net] net: fec: Stop PPS on driver remove
Date: Wed, 7 Aug 2024 10:09:56 +0200
Message-ID: <20240807080956.2556602-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805145735.2385752-1-csokas.bence@prolan.hu>
References: <20240805145735.2385752-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1723018272;VERSION=7975;MC=1504705215;ID=810479;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94854617461

PPS was not stopped in `fec_ptp_stop()`, called when
the adapter was removed. Consequentially, you couldn't
safely reload the driver with the PPS signal on.

Fixes: 32cba57ba74b ("net: fec: introduce fec_ptp_stop and use in probe fail path")

Reviewed-by: Fabio Estevam <festevam@gmail.com>
Link: https://lore.kernel.org/netdev/CAOMZO5BzcZR8PwKKwBssQq_wAGzVgf1ffwe_nhpQJjviTdxy-w@mail.gmail.com/T/#m01dcb810bfc451a492140f6797ca77443d0cb79f
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/net/ethernet/freescale/fec_ptp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index e32f6724f568..2e4f3e1782a2 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -775,6 +775,9 @@ void fec_ptp_stop(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
+	if (fep->pps_enable)
+		fec_ptp_enable_pps(fep, 0);
+
 	cancel_delayed_work_sync(&fep->time_keep);
 	hrtimer_cancel(&fep->perout_timer);
 	if (fep->ptp_clock)
-- 
2.34.1



