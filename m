Return-Path: <netdev+bounces-136742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE249A2D56
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 21:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7413428349A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A075121BB0B;
	Thu, 17 Oct 2024 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMi1f/bC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E4921BAF3;
	Thu, 17 Oct 2024 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192135; cv=none; b=TwGGwWj7mgAtYXgiGkGW3pnXzlaRoy9DjQysxuNN1rFSrxMbTrPnTIczr3T++T62Pa9iSjmBFpZ2Naa1SNdDONbU+AJZWygNB7JsHCOuegcmqQONkE+gh5hB6mC5w+/O6bkzEl3pfXrkZKPnZOqHWcAQvL2EgQapSBhBOV5pDg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192135; c=relaxed/simple;
	bh=s7U0icbK7FENRImx1tbz0XdY3NYXf6UP4UcAkP83OCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GypwjKGfOtPLSaT1nwvxs5Y+jKXjFC0CRQsP07N/wiaZADAslMmYE4FxcUnBngYeJOrltRpPzneqPk8BRWuqKNFd2tfTaeYboxHShkUnTLJ28fHqHw2AGlHvkAeZuZfS3Ep/zvbHL8BkRa60WU5t6W/NjynPKGh++jLPlwEd0jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMi1f/bC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cb47387ceso11406135ad.1;
        Thu, 17 Oct 2024 12:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729192133; x=1729796933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2o9SjO3DgGlhTD4DQ2cq3Udc0mM0ErlixCRYYej+Hw=;
        b=GMi1f/bC9l+mAenVJzAKw/ZGElDtGrYPU9jQ6aUsQPpPG6kGCrYeWKU67ZtoNIxUi7
         5lH0Sl0Jti7cP8/EH+dZRH4z1P+WI/6l0isfG6lFZc8TOqXwH9Ce3Kd99G3tAaQSNf4E
         DYD62UGrcRd92tnjhuVvz+ymzE1y5lTXb4H/1mXJJw5LRlXcE5aJLfQv1qIChXGkqsJK
         4BL8VvGcAFFWMuygbrto8Xxs0N+/efh72mdBdmDvztoO+ApaQ+GEfD3lxNFjE7mas9ul
         ahgTYkrFrZX347j88xdi7ezyKF6E1yGnbOKxZ//i1UKR1P68upgERXiyM230ZwEu2+jl
         Mklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729192133; x=1729796933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2o9SjO3DgGlhTD4DQ2cq3Udc0mM0ErlixCRYYej+Hw=;
        b=TrjbuqC6hNWSQIuJfuWFIU9JsEsKjCS6dIWZglw3Vq+ite7hrfTtdCcOBS29xn4iM1
         rns8SBEoWEQd2SRM+fE25QYgQPIkIE+lhKuNdvITwRhgMTl957e0CVAhLG532tyK//ip
         uTfn3TkDbzo1tonz8BnafZGSnrrA9XiA2amMchcEuwnOycKRAn7nsBg9bbnMJplkIxbD
         9y9vSKmCL2JcCeiGXIaFThS0dZ5vFovNs/LWGhpReYA/yNdwwFjkkEy2stytuBLQLIQ8
         4OK4yISnpX+I3nt6h6S4FLpVsYwP6dLTKGZ35Z6rsOFbO8FOivUCTMLwGvABGzUxVO5h
         7SGA==
X-Forwarded-Encrypted: i=1; AJvYcCWlEEszpeT5ixk8MccqYVj6ul5bxMpqR06SfA5d56/GBOp8CZYq/l+pcKa/oboebYR6VncLlj+u@vger.kernel.org, AJvYcCXRmBMipm6wwGdYtPBvnvEC+7hb6H2swk9yJeAGyxU/CKhJjf+fSbF+2rnGrC1FpZ8C+VgB6CKF9/YkK0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNg8OZ+JAk8M4ymiPFfmwHATLu03AfGpm+pw3hZZD/sa8ajonV
	AA2NBYSq9E0JY8n94JI6LKayRsmSEMJOeX+Rp2eFHaZBHLHDLx4I
X-Google-Smtp-Source: AGHT+IEM0k8ZiOeY14Pp43NqAoSKS90Nlmf+JIqLSYjbZzH5X+8zlLg8hxHFM6roJOB/MeNcYJkLeg==
X-Received: by 2002:a17:903:1cd:b0:20c:7a0b:74a5 with SMTP id d9443c01a7336-20d27f1c789mr129133675ad.39.1729192133287;
        Thu, 17 Oct 2024 12:08:53 -0700 (PDT)
Received: from ubuntu.worldlink.com.np ([27.34.65.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f8b4e1sm47210085ad.49.2024.10.17.12.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:08:53 -0700 (PDT)
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
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Suman Ghosh <sumang@marvell.com>
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_flows.c
Date: Thu, 17 Oct 2024 19:08:44 +0000
Message-ID: <20241017190845.32832-1-kdipendra88@gmail.com>
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

Adding error pointer check after calling otx2_mbox_get_rsp().

Fixes: 9917060fc30a ("octeontx2-pf: Cleanup flow rule management")
Fixes: f0a1913f8a6f ("octeontx2-pf: Add support for ethtool ntuple filters")
Fixes: 674b3e164238 ("octeontx2-pf: Add additional checks while configuring ucast/bcast/mcast rules")
Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
v4:
 - removed unnecessary line "allocated = PTR_ERR(rsp);"
v3: https://lore.kernel.org/all/20241006164322.2015-1-kdipendra88@gmail.com/
 - Included in the patch set
 - Changed patch subject
 - Added Fixes: tag
v2: https://lore.kernel.org/all/20240923063323.1935-1-kdipendra88@gmail.com/
 - Changed the subject to net
 - Changed the typo of the variable from bfvp to pfvf
v1: https://lore.kernel.org/all/20240922185235.50413-1-kdipendra88@gmail.com/
 .../net/ethernet/marvell/octeontx2/nic/otx2_flows.c    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 98c31a16c70b..58720a161ee2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -119,6 +119,8 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 
 		rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp
 			(&pfvf->mbox.mbox, 0, &req->hdr);
+		if (IS_ERR(rsp))
+			goto exit;
 
 		for (ent = 0; ent < rsp->count; ent++)
 			flow_cfg->flow_ent[ent + allocated] = rsp->entry_list[ent];
@@ -197,6 +199,10 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 
 	rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp
 	       (&pfvf->mbox.mbox, 0, &req->hdr);
+	if (IS_ERR(rsp)) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return PTR_ERR(rsp);
+	}
 
 	if (rsp->count != req->count) {
 		netdev_info(pfvf->netdev,
@@ -232,6 +238,10 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 
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


