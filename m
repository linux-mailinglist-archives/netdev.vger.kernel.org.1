Return-Path: <netdev+bounces-244864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A92ABCC05EB
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 01:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A016A3014118
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 00:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4F22BCF5;
	Tue, 16 Dec 2025 00:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIz66vpI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AB43B8D55
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 00:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765846073; cv=none; b=LDMucnU+JHg8GfDweiaVw3sBld4hVmfGbZu7TDMhuwBSCoHhRi9i3v0LR+QFX2nFQVSz8qaeCjRHFphpIQnKWeY9zrGYizwl2sEUpPHRp76YKtawg6I7xS13tNTB4IXTvcqS7D/47SXl/j/xBU2eLNUEnNPoTg4FRycYjvxeeag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765846073; c=relaxed/simple;
	bh=HIaQjWfioV/QhO6O8UjvzgX1rLJudYj908F/ubxE8u8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b/hbM20I1LZmObsf5pSWvxN2+iHqQ96jyr8S0qa7bxOKDqxKM/RMAYT5zFGRC6dO3Ykyx5TYYX+9DwRdB4T1xdkBjzbHw8Ojz5ivSUQkVMfsju+5FmJwIOngIF8f0/nOLaRf0RM6DPR90pll2YaUEeG8+N07s4I6FxeHbzmtvrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIz66vpI; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-641e942242cso3211637d50.1
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 16:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765846071; x=1766450871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=htpnQg+KpeLBxyspd7VOYcBUfuFQaw1hHqa/WboeOvQ=;
        b=eIz66vpI7XfXOV2MoqIZis0ONkKRjb+EgA5AAwuQWIxda4xTPvUD6tBzRNXJrVBZnq
         vX+ktQlPyBDzAH1XBu6DxYveGOeAQAAMw0CUpKMQ+GCy/L7BY4OYQPD+lrdXJel12frD
         3QPg0CxG0NVUPYzl4FbR8dI89l5tvVWfyhIHy5S6YdzZS89j1eUKsAhEfVp2yPc6xdNk
         Ja3qfHiasZ3/Z44vcAIsUGSGYZ8TTb2zSe7G7RCm5dEkjw+Jsv3g8areuufg2nSDpQS/
         ZceQMK9GBwAhOiLpO3rqJb1djCJOHtE0YweBgUUjR57gn77ClpZ4q6yvt+BsfuaOp1ZM
         taDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765846071; x=1766450871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htpnQg+KpeLBxyspd7VOYcBUfuFQaw1hHqa/WboeOvQ=;
        b=t+HmffSlZYVsBeWZk5JtCG6WJK8LA5UQHYtmzjZc8PV08aJVyTW+Y4emzQlIgzqmSR
         dU+FQBvO0HEaZgXvd5sDuBJCF4lt8KVo8WEdtnyEQMzKmEWtyZLwn6am3L3JG05gHTui
         PEpPPf7kTOEjnf8Ii4lrC0lfZKNfeu7LrPykBXN15lua69m564cTrc5kuS70+mYK3Oza
         7zSvc0xxBTWmZeUMxOlpzaDIYwoVmsL76jcHirln12ovXNRWRk3h6Y/qfr30ggKl5ysm
         1IHok4tzFqft1vtysUdjMN/T2GHfYYohg/9KPtlI565eK9NfDaAqcuPkclgUD5pAdf9Z
         BgZw==
X-Forwarded-Encrypted: i=1; AJvYcCX1P98pGEVnqu3dKvu4nVG0UBDKmaW9adKBsJZLb42B5+aSRuH60WkksjlvDtvcVARtmBf+PAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzIGKvpjuJyXH1x2EKmOSiKQsIcVZ3TMJmQwCjMPnMmRM8A6gv
	yD+RQXI1RPYAEeFfnqbhBNFOXui62O08/akkXRzB1rt96vvkgNtbv6iI
X-Gm-Gg: AY/fxX5IHznyyfS0nebq+8rvzM/gQjelgO3C2K4AuPluAmewutVIYdliJeUWU3N/L4t
	F11Ozm21xs0B0B96+CPBdk0yC0XepfIYFUjymCYJjFnAQCiZnwF25kgGP8uRAt9DegK9SwBrIXm
	1yGHIRrF9pRq4RWmnY9k53Wqb6XBoO5ZuQG7MgOjRqQILUH1AMEvKahdFFLA3Sbt+ejJ0VM3Sfx
	M6VtF+g4XOuX6vIHU+4CeEiqvsP0b3j2B91M7tsSzYJUySBT55sMgSyfdWrLvLqZfAhnHvsoDrD
	gXzIra+vGb6WkZLcXgGQpEnV7bzQ6133gN7kBx2dUqMSaOb1y9kut7w0iDnCBbkP72jcYq/o+J6
	RBombZjV0qM1iRsGC9nP9nd4Usntv2NR1mCHd+nQ4Z8FJ2yfc8H26Brma5qRrspNNqUodFVwKCz
	U5IWr9PQ==
X-Google-Smtp-Source: AGHT+IFq+15LrM8DYkmiFJs04hZ8RTo3rucE4z/jkGAw/h4CjNSMcfqoxeOPS87HxufEvEDGqMvAqQ==
X-Received: by 2002:a05:690e:4185:b0:644:60d9:866b with SMTP id 956f58d0204a3-6455567bd76mr8079705d50.92.1765846071260;
        Mon, 15 Dec 2025 16:47:51 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:6b0:1f10:bc87:9bd7])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64477dab686sm7019840d50.16.2025.12.15.16.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 16:47:50 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH] Octeontx2-af: use bitmap_empty() where appropriate
Date: Mon, 15 Dec 2025 19:47:41 -0500
Message-ID: <20251216004742.337016-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bitmap_empty() is more verbose and efficient, as it stops traversing
bitmap as soon as the 1st set bit found.

Switch the driver from bitmap_weight() to bitmap_empty() where
appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 6 +++---
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 42044cd810b1..2958522f3198 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -672,7 +672,7 @@ void cgx_lmac_enadis_rx_pause_fwding(void *cgxd, int lmac_id, bool enable)
 		return;
 
 	/* Pause frames are not enabled just return */
-	if (!bitmap_weight(lmac->rx_fc_pfvf_bmap.bmap, lmac->rx_fc_pfvf_bmap.max))
+	if (bitmap_empty(lmac->rx_fc_pfvf_bmap.bmap, lmac->rx_fc_pfvf_bmap.max))
 		return;
 
 	cgx_lmac_get_pause_frm_status(cgx, lmac_id, &rx_pause, &tx_pause);
@@ -970,13 +970,13 @@ int verify_lmac_fc_cfg(void *cgxd, int lmac_id, u8 tx_pause, u8 rx_pause,
 		set_bit(pfvf_idx, lmac->tx_fc_pfvf_bmap.bmap);
 
 	/* check if other pfvfs are using flow control */
-	if (!rx_pause && bitmap_weight(lmac->rx_fc_pfvf_bmap.bmap, lmac->rx_fc_pfvf_bmap.max)) {
+	if (!rx_pause && !bitmap_empty(lmac->rx_fc_pfvf_bmap.bmap, lmac->rx_fc_pfvf_bmap.max)) {
 		dev_warn(&cgx->pdev->dev,
 			 "Receive Flow control disable not permitted as its used by other PFVFs\n");
 		return -EPERM;
 	}
 
-	if (!tx_pause && bitmap_weight(lmac->tx_fc_pfvf_bmap.bmap, lmac->tx_fc_pfvf_bmap.max)) {
+	if (!tx_pause && !bitmap_empty(lmac->tx_fc_pfvf_bmap.bmap, lmac->tx_fc_pfvf_bmap.max)) {
 		dev_warn(&cgx->pdev->dev,
 			 "Transmit Flow control disable not permitted as its used by other PFVFs\n");
 		return -EPERM;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index 2e9945446199..fba76846fcbb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -178,7 +178,7 @@ void rpm_lmac_enadis_rx_pause_fwding(void *rpmd, int lmac_id, bool enable)
 		return;
 
 	/* Pause frames are not enabled just return */
-	if (!bitmap_weight(lmac->rx_fc_pfvf_bmap.bmap, lmac->rx_fc_pfvf_bmap.max))
+	if (bitmap_empty(lmac->rx_fc_pfvf_bmap.bmap, lmac->rx_fc_pfvf_bmap.max))
 		return;
 
 	if (enable) {
-- 
2.43.0


