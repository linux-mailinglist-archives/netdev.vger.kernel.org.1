Return-Path: <netdev+bounces-136738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BB89A2CD0
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8C51F22E3B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF233219488;
	Thu, 17 Oct 2024 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3owkIRg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE351DF754;
	Thu, 17 Oct 2024 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191405; cv=none; b=K0tNcpKUEw3amDP9YEMHJq6rH91/fI30KfWgbRrvYV5lh57KLwBinwAH0awF17yspquajUxY4PXDXbQryffULQ1TRxLWkDEKAjOUUpQyLnLhQH7xawlriuPxiKTkyJRDCCV4GrL7wJQFpumofUHnbx3Od+omhuNei0azqdnl8/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191405; c=relaxed/simple;
	bh=1jWi19cLw/O33YUTHG2Apv87raGY8kQsXoFmbI0GCSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHFZ2xgmU0xxkqke0VnKTOi3NJuGZa5WkbFjPNQL7by3yhPUbgY5CB3/ZY8tYryOBV+vJ94YeueBWActh57ygfhE3vwdcIfb7tiC8oc5JO74zVVI+uCAf8syfBPFvSCRQ17RgBMQ2dQIAP5PLYaq9DlcRwrkJHf8JU7r33o1Z3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3owkIRg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cbca51687so14394475ad.1;
        Thu, 17 Oct 2024 11:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729191404; x=1729796204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZGaeyV9U4r0R6f6UfyYJ79PA19GqkLIm1iDSxXpf74=;
        b=J3owkIRgcjdwtjjnV2qGIvhHFcWHcxQuTI1gPLdeKlKUaHrdl9IBW1P9211dF1E44W
         Ncy/OGO9gbOn9SLXKBZwf3kMlnaKFReiPl70fgbwg5Upyw+vDOWxWRJsGvOHQM7utPBy
         lBg1pynJgFD8rHOLGG5RCeuxE5pnfTxDombOt1jQPR0/ywXxBjZ+8JSaaKonH2siFlfU
         wHM6gaNPn6+qVOVJcOvX8mufvKl8Vy11U177/SMrSWO4QXeQLlPYRiv+iZtuWyi1HK40
         L0Zu8higQgejvqv7H7h1zpFVaN29FZST0oMrdZ6ppFEncTaNyI9rbE2W/Qu1bVuGektt
         N8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729191404; x=1729796204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZGaeyV9U4r0R6f6UfyYJ79PA19GqkLIm1iDSxXpf74=;
        b=qc0qrYJoqtBwOksWMGWFgyVAOwUqEJ7xmCWLUMh8PdbNwPbx/3NSDaAbyYBHWR3dMZ
         RS8ySRiywBN4jRlQQvH0cy0HOj2E9FaYMKaIANu3au0ZB8PHWcBsIaIY48HbIh6v/CTQ
         aLJRymGXtP0itlzgQ6gS5+KepeaTc1T4oOvt116Ez0jK4O4gRkAvcxi2ijhBRRwwceGz
         CmJDE6sbozerIyzPN/iPOxpyaZla8R8+5diwbwFQRUkDerBY4alpXtGthkeubSPv+yvt
         T17AQQQhzSlxag19lsB6pu04qY863Xvvi19MXKQMZqu+E6d0plsgpy/KU11pnWDrI3lR
         /zHw==
X-Forwarded-Encrypted: i=1; AJvYcCUeoGjxoGgYBqtN5tMD6MxCOzoDLRMrau/ll/j8Bmk3+n69GImG7b/ABI4hgqBv4D9OTikgyzws@vger.kernel.org, AJvYcCXe/zEwasU8GlgpfMvik7RT/Ha1Jm/RML0nLBJ0p8vr9ePiZXVEVR7j2Vjl93p1jVJXc1FQI+KbQdp3Mzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCavXfx6HQNG8iaUknC0iaOkpnHOCkLjdB1bObS/pNApZ/v20o
	7ADokNgrChKldPtzlItCJoqeukbWK+NgX8yjd/hy/owYYmu9RkTD
X-Google-Smtp-Source: AGHT+IEN8L3F+2UOnnf6YIXnuEGWgGPfecKEnJlHK6uTQIVyKYblzyxlvKNGAeKYZY3Du56J3b42Qw==
X-Received: by 2002:a17:903:2283:b0:20c:92ce:359d with SMTP id d9443c01a7336-20cbb2845b9mr353494695ad.45.1729191403573;
        Thu, 17 Oct 2024 11:56:43 -0700 (PDT)
Received: from ubuntu.worldlink.com.np ([27.34.65.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1806b5ebsm47546335ad.293.2024.10.17.11.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 11:56:43 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.cocdm>
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_common.c
Date: Thu, 17 Oct 2024 18:56:33 +0000
Message-ID: <20241017185636.32583-1-kdipendra88@gmail.com>
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

Add error pointer check after calling otx2_mbox_get_rsp().

Fixes: ab58a416c93f ("octeontx2-pf: cn10k: Get max mtu supported from admin function")
Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
v4:
 - Sent for patch version consistency.
v3:https://lore.kernel.org/all/20241006164018.1820-1-kdipendra88@gmail.com/
 - Included in the patch set
 - Changed the patch subject
v2: https://lore.kernel.org/all/20240923161738.4988-1-kdipendra88@gmail.com/
 - Added Fixes: tag.
 - Changed the return logic to follow the existing return path.
v1: https://lore.kernel.org/all/20240923110633.3782-1-kdipendra88@gmail.com/
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 87d5776e3b88..7510a918d942 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1837,6 +1837,10 @@ u16 otx2_get_max_mtu(struct otx2_nic *pfvf)
 	if (!rc) {
 		rsp = (struct nix_hw_info *)
 		       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
+		if (IS_ERR(rsp)) {
+			rc = PTR_ERR(rsp);
+			goto out;
+		}
 
 		/* HW counts VLAN insertion bytes (8 for double tag)
 		 * irrespective of whether SQE is requesting to insert VLAN
-- 
2.43.0


