Return-Path: <netdev+bounces-102498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 040829034C7
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 10:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82190282CEC
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 08:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB96C17556F;
	Tue, 11 Jun 2024 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="ihrH9Hfe"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7AD174ED2;
	Tue, 11 Jun 2024 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093089; cv=none; b=FGUwOCgqGaECJG9Rc52ofFr/OzOyTSapkMPetQIp65eIrgqCM/aid59tinBcxkoXgTGbpgCuus51Iv/Fu+zWyLlm2sBy1VpoP/EmPTfmcFxdBYR8c3dal6rBzXvqRzEBUXpMuzSqIrG7oEejfuLZ9jVVDK3Bk9+OB3UUktXyJ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093089; c=relaxed/simple;
	bh=yYgTt6VYlpyrsw+D+VczHVk7t9so6lEWB9yYmW1KwQk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oi6ZufArZi282/JfGKTFIcRWFq650TNw55qSZaO5XSbEsJ9OW+1OqeVtKg80XiWQGp1t6dBVhzOO53Z0latccbFUKMpyMRAVX8pOuXlcN1nicH5vUQEpjgBXsIzbhLyzc+xtxQ9R6rMSq5eHlj7nQzEYexU3AouzAZAGDRM3Cgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=ihrH9Hfe; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 98DC9A06AD;
	Tue, 11 Jun 2024 10:04:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=Izsbb6raQToVG/aAGBJ/FcHgN/EZ3prel7zQ0hy+F3I=; b=
	ihrH9HfemSg2O2YmL0yzx+eQQ1a+OmA9Ar9/h5Aw57XoQdR8rtGI7xbhIQHJlQFd
	N7foldjGv8XBW8UeywUQksm7S/Wm9rKOJcmBIEaWNp5PfE8m2FhAqg+vamfH9gq6
	Jr6Oih/CsMN6xIeZb/IBwYV+WY7I7/eCxgm7gxlhDKBfNsut5SL7FaWYEsggI5n+
	2m9wpAm15zFknc2k3WCB9KK1A/WkEWIylO/PkAOI1l0zRiI1gFncQTAJrH8YBwja
	mLfM1vGpr6f/s/2EUFhHIL9KDkVVOiA37+oGnh+0R874fH4UzunDac7RgusG0Wdg
	7AlubpKjZ3Qr2UEFVjwm8yNltReLE9SWsSUx3oWwaO9SbQeO+ZbWEDZcnXs0Mr0V
	aFeYG3Zgdm9V9m4JqYHGrKIziSp8yQUkyqvelHxteVqp4asftkavj8dKzsFXeHYf
	jMlEhVM4CQR8jvSKjye7nDjO4MHx8OTsLUC/j5NaYXoo7s18o/LgsLYcYz0yRCtk
	Tpj9RxrALUhobuzo8b9WRthmla3OE7FgpAG+7EH2wHFRXWWpwOq9iLAA0++GT3Pd
	Xak1zv5ZDoU0aS2WplR7KdmmTwVbgLZIp+gHcZg3JLUT+WyBzfCQLYWyr9CTw6Ik
	PLPIOhbLYLO1pYCt1SyFS5S2SUyWm847xx4+2/JBbh0=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: Frank Li <Frank.Li@freescale.com>, "David S. Miller"
	<davem@davemloft.net>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Richard
 Cochran" <richardcochran@gmail.com>, Wei Fang <wei.fang@nxp.com>, Shenwei
 Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH resubmit 2] net: fec: Fix FEC_ECR_EN1588 being cleared on link-down
Date: Tue, 11 Jun 2024 10:04:05 +0200
Message-ID: <20240611080405.673431-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.45.2.437.gf7de8c0566
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1718093086;VERSION=7972;MC=1588675963;ID=228453;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2945A12957627C61

FEC_ECR_EN1588 bit gets cleared after MAC reset in `fec_stop()`, which
makes all 1588 functionality shut down, and all the extended registers
disappear, on link-down, making the adapter fall back to compatibility
"dumb mode". However, some functionality needs to be retained (e.g. PPS)
even without link.

Fixes: 6605b730c061 ("FEC: Add time stamping code and a PTP hardware clock")
Cc: Richard Cochran <richardcochran@gmail.com>

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/net/ethernet/freescale/fec_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 881ece735dcf..fb19295529a2 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1361,6 +1361,12 @@ fec_stop(struct net_device *ndev)
 		writel(FEC_ECR_ETHEREN, fep->hwp + FEC_ECNTRL);
 		writel(rmii_mode, fep->hwp + FEC_R_CNTRL);
 	}
+
+	if (fep->bufdesc_ex) {
+		val = readl(fep->hwp + FEC_ECNTRL);
+		val |= FEC_ECR_EN1588;
+		writel(val, fep->hwp + FEC_ECNTRL);
+	}
 }
 
 static void
-- 
2.34.1



