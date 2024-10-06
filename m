Return-Path: <netdev+bounces-132513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72957991FA4
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 18:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396FD2820B4
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 16:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A99189B8A;
	Sun,  6 Oct 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JK6LxRdl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71AF1C6B2;
	Sun,  6 Oct 2024 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728232827; cv=none; b=lp3PiKEKzMFIQv1IH5g+XLfNIVbhrVwHFUHeUeULap7KXKQhooeOf7L7TxKL13CX/aYDUw/2+p8Rcqt/N3bPi7ctuaoakCKrMbKkNzNucz4JUIvME7IUMQubGt19v2IZgms7c6+2+m3+IaIE2S2sfyUsVOX8rRCZVjc9WJAXlzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728232827; c=relaxed/simple;
	bh=4VLrjRk5EDWQdgrMct646ETLNR7dC+9hDpCqHUCaPmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EvU6AWvmxa3Yg2raMwlCsl6g0wgbELETVRXKQ29Ki33CiK1lFNAbqtoj3Vp8pT1Pe1D6I7PlbjeetSNjpxpzFJdcMBtxb9vJ21OEokERRBhxQ08irDjm2VuIKEk5RZ8bTHljdeOKSqOayPzWct8EqnRZK9tcX6mWK7XSgq1telU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JK6LxRdl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71dfc1124cdso470203b3a.1;
        Sun, 06 Oct 2024 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728232825; x=1728837625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M6WeitElHDxgk3iGAm5xEDsCx0Na0thFcP57uVIR3NA=;
        b=JK6LxRdlTX1VczVNh3zcYfPdu90Yr8BUV+H3V79XRme18YbPAMUOP2LixMwGfKVR6N
         3CboMlPGznPPxf3gOKvR2ev5TACAs3MzZvSxO5DgdXbp0Bro3KrpX39S/xkKXGuBwpam
         1JoBaj9vbAIS6pnolpwYum0Ud4i93i5cgLTh/Dd+GfdSmq989vVRge4JdIVP3IR+1M3e
         a3gfD2stPnuUgM+2Bc8kIKBLRHalyYrLMeWNN+8hBBD4fiBu0P8gF9iy6eIiCTrYxfDb
         JMNtR6ppS/mawk2ozcn3w+cDP7lElLOsJJGp00FdEc17otruX1v1BFTuNbcICeuTwW7D
         nN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728232825; x=1728837625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M6WeitElHDxgk3iGAm5xEDsCx0Na0thFcP57uVIR3NA=;
        b=At7mO2/Pbm0POAj4JdRwodhsX9xpTNZwj4Ggjjownq/iVrj5cxefpn1MFz5r8FSHP4
         J6hnUO+g1cD/Cnm8W6W6wgyVq1DRAph8XGpusS2G18WiXf4lPKTOT6ax8S2pavYnbFjx
         7g3bzIyOrvyBrHdaKVxd814Qu6fcXzurQWZFFKqmv4B6+Itoy1KWIW86k5uVUgYunS4K
         wc5Qsrx0I5openitVbS8TfyMR3GgCq73fxNuJ0ddDi40CJVs2yu/o6LfuEvejyGSdo4t
         Yy6nLAyC2t2AhthYv1/qWOUgspEFLjavKkaE+fUitYFKU7Pj16+3O+pZJw0FPPE0XGlb
         3GfA==
X-Forwarded-Encrypted: i=1; AJvYcCUR3EnoeL7QJgr0t+tfHQSvQR8TshbSP6v7LrevdhIP8oqPmlCn88IWeI5yHyJzSRyJn/RHiIdm@vger.kernel.org, AJvYcCW6vkPEzk9Sjk713+I/uyBQ7iCUEP+0es0FKlgZLK9+okq2uYN4smutC/Mzl/DQygAuyzHWIs86GDHSdxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA6fuAFpehqTGueUpCvCliTY6tBgvgGcSvNxJH06KQSO3Jy1l/
	Q1eKN2WecRmROmyTCjwxfbo15DHkdWMbk3EbfCdrWXJoqF146pDK
X-Google-Smtp-Source: AGHT+IEizIA7EmpDUsnPiQDZMRkbEqHXrl+d94x34Yer+wBUsuE/CIHZM0CBCP5HaqbO/k2tD5CS3Q==
X-Received: by 2002:a05:6a00:1250:b0:71d:fd03:f041 with SMTP id d2e1a72fcca58-71dfd03f290mr4530666b3a.2.1728232825107;
        Sun, 06 Oct 2024 09:40:25 -0700 (PDT)
Received: from ubuntu.. ([27.34.65.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4632csm2943704b3a.115.2024.10.06.09.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 09:40:24 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	maxime.chevallier@bootlin.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 1/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_common.c
Date: Sun,  6 Oct 2024 16:40:17 +0000
Message-ID: <20241006164018.1820-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
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
v3:
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


