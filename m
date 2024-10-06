Return-Path: <netdev+bounces-132515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA521991FA8
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 18:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51AFAB212F4
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 16:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211C7189BA5;
	Sun,  6 Oct 2024 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOD32BJ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8B1189B8B;
	Sun,  6 Oct 2024 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728233013; cv=none; b=EJe+ODV2q5qnywej5xCtpTvqRnR1PmKROH2fJketpUy5w0NOG1F1X4t9HsorU7+c3tlh/G1/GZ++1FoHKT9Rcl/xyzlpqWUMgD8WS/qxpgC9tK3HBHQRXZPz0fUvTiPCMl2Q8+VFI9+USXA4oJebeT5UXO6hN/TcdTAjc/22ZKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728233013; c=relaxed/simple;
	bh=Q8g3holWCmt4KRRwSk6tBXgvpK13/hoLyqz5wayyThE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oardLcE4pdwnvuylnbRvd5vGCZ8BmHQKnbhTta6VW+RDaL7c1tziwI0DzWylipNQ5JpHNhjG+hTco4OJTmVA11NQRc28mHuE+2yvGehMymWf3vJtfr9ITwnzqT2TiJlBADw6cZGE+nKPxrDht6J5sitwcukdSWyrObYix/teq7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOD32BJ6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b1335e4e4so36636665ad.0;
        Sun, 06 Oct 2024 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728233010; x=1728837810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NcTqkghSEH/q4hS2U1EtYqhdI2AKRpEW4xQ96+uRbkA=;
        b=kOD32BJ60+2rYkzdb/6/pT/hTynktYDdXyOdojcxJWW4sFH8EZyEnBDpMuZtHCDJ3/
         aQBf/ymAayK22jpZbhUsfIxgPFwjL7e5DWOfKcz00m4p3enDvQJvYdU1kV5EixSDfNqZ
         6218pUcTXzuhdtJh2mP7ZjGzNMcxtsP0qS9/+cpv8BcDmMckQGrmWx0y8xQw2Coodbc0
         xSfLSsHKvveYBsdWD8SRKuOlDnriS4E+6DaWJe8GitkaJdayhuU/W6zQL/W9o1CjU+WY
         odJgNQ1BVJ363nIA0FPZx6yZyLirGAr0I/i8n3zZeCv1EWHYc6HOe5Lr0+KO0ppd7wgI
         nLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728233010; x=1728837810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcTqkghSEH/q4hS2U1EtYqhdI2AKRpEW4xQ96+uRbkA=;
        b=pUYWMoLZUatYMd/MRj7DC4xrUsYJLNIm3JF2XbtxR3063IMI/xxuQxnQj1r45jHRW1
         yugYOgFEOzbeQr8zZweOTKiCMORYMppRJRfAyVNITNLRiVifmwl13DFJP+jFuVUpBa8d
         xTBy2ywolt+iVF2ylYoUNbPLExL9nmL43OYXhDgSf0LV5eV0+QZrHVhA/GGggeqLpRm6
         okslTncYFpB3m5eKZuUOR8rW3pLLN0tFsoZ2Vf6VykxDCeBbSVhScrMsAwsdx2bv6/qb
         v3QEZeAR6VZcLeEQSJRSsKr+ON1Pw86ti9/0g4F9RAxWnTcKm66vp3J8+Qae4tw7K3RD
         DKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4TRHxMv8b43J6Wx44MdK0zCY1FqkyCg2Eg9LSxiiz4sEqhF/o4nSUP9bH6qJ4B7ZqsZ1OAwe2@vger.kernel.org, AJvYcCXPT+fr7qSAH1yN5Fj+cn6d/sbAZFF3sfGXqmpNfZ1+DreEnDiJd+s8lZNITTH8suN9e5Gg6e3IwmCRYXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2mV2ogF7+iUo+9hND0npkjs9zMMJV2ydWRFd7wzEsV0RkrNg3
	jeffzBdHfVd2DxaCAPQK+LjS7EZTi4iH92UAZxW5gAiIgA9zhmXO
X-Google-Smtp-Source: AGHT+IE+oXMDeSfi7ThB0cWJtlPa+K/pDk7A51QXl7QpMbzhMpnq3SMwAmcNpjioJe1vcpG+iXW/Iw==
X-Received: by 2002:a17:902:d483:b0:20b:6208:b869 with SMTP id d9443c01a7336-20bfe01dbedmr130055505ad.24.1728233009847;
        Sun, 06 Oct 2024 09:43:29 -0700 (PDT)
Received: from ubuntu.. ([27.34.65.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138af935sm26880845ad.54.2024.10.06.09.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 09:43:29 -0700 (PDT)
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
Subject: [PATCH net v3 3/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_flows.c
Date: Sun,  6 Oct 2024 16:43:21 +0000
Message-ID: <20241006164322.2015-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding error pointer check after calling otx2_mbox_get_rsp().

Fixes: 9917060fc30a ("octeontx2-pf: Cleanup flow rule management")
Fixes: f0a1913f8a6f ("octeontx2-pf: Add support for ethtool ntuple filters")
Fixes: 674b3e164238 ("octeontx2-pf: Add additional checks while configuring ucast/bcast/mcast rules")
Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
v3:
 - Included in the patch set
 - Changed patch subject
 - Added Fixes: tag
v2: https://lore.kernel.org/all/20240923063323.1935-1-kdipendra88@gmail.com/
 - Changed the subject to net
 - Changed the typo of the vairable from bfvp to pfvf
v1: https://lore.kernel.org/all/20240922185235.50413-1-kdipendra88@gmail.com/
 .../net/ethernet/marvell/octeontx2/nic/otx2_flows.c  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 98c31a16c70b..c96f115995f8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -119,6 +119,10 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)

 		rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp
 			(&pfvf->mbox.mbox, 0, &req->hdr);
+		if (IS_ERR(rsp)) {
+			allocated = PTR_ERR(rsp);
+			goto exit;
+		}

 		for (ent = 0; ent < rsp->count; ent++)
 			flow_cfg->flow_ent[ent + allocated] = rsp->entry_list[ent];
@@ -197,6 +201,10 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)

 	rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp
 	       (&pfvf->mbox.mbox, 0, &req->hdr);
+	if (IS_ERR(rsp)) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return PTR_ERR(rsp);
+	}

 	if (rsp->count != req->count) {
 		netdev_info(pfvf->netdev,
@@ -232,6 +240,10 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)

 	frsp = (struct npc_get_field_status_rsp *)otx2_mbox_get_rsp
 	       (&pfvf->mbox.mbox, 0, &freq->hdr);
+	if (IS_ERR(frsp)) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return PTR_ERR(frsp);
+	}

 	if (frsp->enable) {
 		pfvf->flags |= OTX2_FLAG_RX_VLAN_SUPPORT;
--
2.43.0


