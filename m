Return-Path: <netdev+bounces-136745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0886A9A2D87
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 21:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0489285A71
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F0421C17C;
	Thu, 17 Oct 2024 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNJcGZ/Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CFC218D72;
	Thu, 17 Oct 2024 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192445; cv=none; b=P5F9tj+tWhodLkxjXE8OBQn3NCFvPW0BdhuZ+uMcsxTlFRpx4GsF02CUVIYhRhAv/JUDsWXbKBIcx+vU0TkL+dFYFSOlaC04K5TH8mTmuzwNaKqD7rgnM9ykyUA48xkfz6xOrqt8neRO7jhFMVel3vtStHvxnVYbbmPw5vQnO5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192445; c=relaxed/simple;
	bh=oKEev3EugVk+ubV7v2vIKE/rUvjLm33hhOkJwHMkBmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ru10U5XBWLpgTCG1lhv7np34oFwK4QDjoMWRuIKoPAxxwxo2KJeiBkm0fs66LBAXQMawaLd6y2s0zKOqz/ULTlSEDhE7uMMhcDsouy4LzGQexgLHDmUGeMCTCtx83NcUgDFwlVzczuF6wKR5mrC8yF8XmmrwuHQdCx+nydag8t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNJcGZ/Q; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e2dcf4b153so1019127a91.1;
        Thu, 17 Oct 2024 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729192443; x=1729797243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahFaJ8/guc7ie3rJ77irjN+5zBFR5O3hZmCpg9MelLo=;
        b=XNJcGZ/Qe+enJV8uc9kCfjPpC8/LqxMtbhy5OrrP/tUp9tZPdvDhnv0hhy6RBBL1Zc
         nB5sm127zSLnK/jiEkDXRhQXRP3tr4t2WpO7SbyZ4HIjzWBXuTblmMqlc6d7Pxoyh29w
         9ESNScYNJPFYgxNr53u/vtv1kKUjgbpfUjjY3QOab0WoDC60zj1KtIIG8K2tSGGdZJ+c
         CE3IlJ1ekQlj8fBigWVV6WJRNsyGE/KopPxDIuOpPIW1GVpkyJwj83ZFoAkO27WUbkNn
         ERZV0tt3Z1mRJgM6cvbEmr41kUF/qJ+aI4ollwuZxxDBmBHmHaj4ZeEPvl1eKrXkZ/Lq
         rKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729192443; x=1729797243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahFaJ8/guc7ie3rJ77irjN+5zBFR5O3hZmCpg9MelLo=;
        b=h0Bte+KLbag1cy4MW/l2srTxGqUPAJQwPaLrRcXJooDdt0/hUXaHsjSXDKfE7OYuQ9
         LqiX1wBtd76yeRQyiJjuCYX7LGLchaMsgJNhbfKf92cEZHIiq5N2l1A7qcOCDR2rLR2v
         HLSt1m8bUF7bHu3aJJud2Lg8DoY4BuuEcctGuPtUEpi1tOVw5nKiXSyvXHWee8qFeuIL
         fZZwUu3pkq68MaavVlXCYKY74NZPsHoNV/45/4POTDSn3w162udRKxj2CTomj5IlHl1S
         h6rdOUvsHujQzPXBHKhP7ieUV4j/+cF6utk5ItagfQXa6v5w4mxoaLcLOns3PBWMgZPj
         Dn4g==
X-Forwarded-Encrypted: i=1; AJvYcCVNrgTNCmREezxfq6LxnU+k6jSTjym/h/9WGEDbmMkG+AD0XIxGGYCOwYOELCLFulALVZF19JFq@vger.kernel.org, AJvYcCX4qea4JlKjeRIR4HjyigDmhNwQaLGTrY9MqeJGewj4geUQxMNGS1GUHoWrougMIyw/yBFL+JxRBi/0FXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo4+yQLG1TNvpKGD66ESZd3eEk/vB0TiBkZWrc9jE8c1esMu7l
	dZ0ZiissonebxNvjUPovic96rUXgZi1t4O7OFIVacYzLmEsBfiYv
X-Google-Smtp-Source: AGHT+IE1ac8B1kfyldFHM6YNOqOwjVQl7fWMYlyKMet9lF4khqCUNozyRY2HtHkWLcCXgAt2tZxsPA==
X-Received: by 2002:a17:90b:180a:b0:2e1:d5c9:1bc4 with SMTP id 98e67ed59e1d1-2e5616db895mr34808a91.7.1729192442934;
        Thu, 17 Oct 2024 12:14:02 -0700 (PDT)
Received: from ubuntu.worldlink.com.np ([27.34.65.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5610af81fsm61572a91.5.2024.10.17.12.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:14:02 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dmac_flt.c
Date: Thu, 17 Oct 2024 19:13:54 +0000
Message-ID: <20241017191355.32988-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017185116.32491-1-kdipendra88@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error pointer checks after calling otx2_mbox_get_rsp().

Fixes: 79d2be385e9e ("octeontx2-pf: offload DMAC filters to CGX/RPM block")
Fixes: fa5e0ccb8f3a ("octeontx2-pf: Add support for exact match table.")
Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
v4:
 - Sent for patch series consistency.
v3: https://lore.kernel.org/all/20241006164617.2134-1-kdipendra88@gmail.com/
 .../net/ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c   | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c
index 80d853b343f9..2046dd0da00d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c
@@ -28,6 +28,11 @@ static int otx2_dmacflt_do_add(struct otx2_nic *pf, const u8 *mac,
 	if (!err) {
 		rsp = (struct cgx_mac_addr_add_rsp *)
 			 otx2_mbox_get_rsp(&pf->mbox.mbox, 0, &req->hdr);
+		if (IS_ERR(rsp)) {
+			mutex_unlock(&pf->mbox.lock);
+			return PTR_ERR(rsp);
+		}
+
 		*dmac_index = rsp->index;
 	}
 
@@ -200,6 +205,10 @@ int otx2_dmacflt_update(struct otx2_nic *pf, u8 *mac, u32 bit_pos)
 
 	rsp = (struct cgx_mac_addr_update_rsp *)
 		otx2_mbox_get_rsp(&pf->mbox.mbox, 0, &req->hdr);
+	if (IS_ERR(rsp)) {
+		rc = PTR_ERR(rsp);
+		goto out;
+	}
 
 	pf->flow_cfg->bmap_to_dmacindex[bit_pos] = rsp->index;
 
-- 
2.43.0


