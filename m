Return-Path: <netdev+bounces-136746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 563619A2D90
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 21:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2BA1F2169B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C5D227377;
	Thu, 17 Oct 2024 19:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsInjQeD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3FA17D366;
	Thu, 17 Oct 2024 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192592; cv=none; b=LFzl/kkZ7fo7eP64gfFG9Vnr+VRXM7o4CK5eJH7Q89QlVgsy+Q/ZX6ql3a4xj2GavfBBjxybLdWB33LzDSQqP/YisOdn76uCeYXAwFN7aTIMQyuX6Pajpgxh8vvV35HPN5b7cv3dJvDJavzoJvZMPHutsHxs/XLfPTwAsh7s/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192592; c=relaxed/simple;
	bh=Zy0KeOH3rfx0NRa+0mQP3NWmpLl47s0dJOyjL7Tjpkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqs+f+kx/FIeBBkstKGnkSbdbuqajZwQcDkVgeuLJVEmx4i0u8mCiUp/f7qKbD5TLWQ3E27OtdqaTnj46er2Nc1DZ3sZAKjwR2P/JgAsggyKZhP1W6fISU1ugcQij56OugRebXGq/CbvkXBO7ojzb2Nr6b629gZi+sXaYbBY07Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsInjQeD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e28b75dbd6so982602a91.0;
        Thu, 17 Oct 2024 12:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729192590; x=1729797390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyFF8AVZvYcYdFwhR+QVeVGuJ37N0O1GZiqzyAabKk4=;
        b=lsInjQeDvPI9O/34jLSJIr2ud6Fjqi0PzxBnSBcRwFc1polSh5zRs1xPf4bqkK58z7
         02Sd9wqMoBXbn4K+BQrpkmQeMQEjzBqkZR9Q8xAjFSE+d/T2rSiQDJOKGuViJvoTAdNn
         4M3v+GKto3Vv/YkAA9n/FVzJORUtd6c5ERqrApvw9xYfPlUQyIz0vSPtTyjFx7XddlfA
         KELcoyN3CcHlSkI74AYd3B8v/pOkEbpceyzC64YV10sLzGoIKjyecmMT2T8nCsjIt571
         GFNROPWgh5vqc6p25q5xdnxk49Yr9Llt7uGDVk3vO2jansg9EiiZ8yz5izCr4LXy3Bzh
         qXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729192590; x=1729797390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyFF8AVZvYcYdFwhR+QVeVGuJ37N0O1GZiqzyAabKk4=;
        b=Vi7+opQoRfPDdXTIOG1XvIZXIkhYysmcOY40bYwsnD5VvAcRkTdlekxtM3/cBREkXp
         /eLlVb3xv1NhBiHKxuArpbxEMEQaRnnKAP2bGgOlicViInaKOUQW2EeizZLeNTctQ3a8
         wJqaiunAgLVReWbzqd8HR8W0yrnsc6o+03Wc+T8Na9k7gmry63LvGgpQS8BzqWCvfva7
         Bc/KFWPgG4BB5+AH2QU+Aoy7wjTHp7GrlYd+TNOOcl6HG+7LtHqklkr+7WUT1cONdFeB
         lvKAVeKvV4sbIJMZdLnIqSwoW1FOCg4oq0mpguUlSya6PoFoOlDUD228nVP0cTS5ROuk
         oqjA==
X-Forwarded-Encrypted: i=1; AJvYcCV/TuyNzfYvzFwbOzfF0GqtSJrqfD+5x2APc/1Jn9oF8EXqn/SIkHbnDvPqSADHV1QxuqaavNGPXqDHJWs=@vger.kernel.org, AJvYcCV4diOAZ3ErJ43esHaGG78YqSltn4wXK2G+vLDXr9hVkb18QXxIYN0rhjGwi0dKb2Jp12zDq2Hg@vger.kernel.org
X-Gm-Message-State: AOJu0YzHR4183ys+9RBFZTJFKEToI6y02gtBXua9k18NW3bfdrYE0OA9
	MVPprcXl257ooBANEOsZq9FD5wzJp+WFJ6ZmmXON8WgZD7SseAyp
X-Google-Smtp-Source: AGHT+IHDnFUtJu9IEcK0BaHoH2ChfojrCgVLmLF5pqkq/68tai2SKRJRr1qbAC75er/m5ilFpnZ4gg==
X-Received: by 2002:a17:90a:a897:b0:2e2:b64e:f506 with SMTP id 98e67ed59e1d1-2e5616e6fb2mr47298a91.13.1729192590517;
        Thu, 17 Oct 2024 12:16:30 -0700 (PDT)
Received: from ubuntu.worldlink.com.np ([27.34.65.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55da3d512sm228127a91.41.2024.10.17.12.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:16:30 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dcbnl.c
Date: Thu, 17 Oct 2024 19:16:16 +0000
Message-ID: <20241017191620.33047-1-kdipendra88@gmail.com>
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

Fixes: 8e67558177f8 ("octeontx2-pf: PFC config support with DCBx")
Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
v4:
 - Changed Fixes commit has to 12 count.
v3: https://lore.kernel.org/all/20241006164703.2177-1-kdipendra88@gmail.com/
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index aa01110f04a3..294fba58b670 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -315,6 +315,11 @@ int otx2_config_priority_flow_ctrl(struct otx2_nic *pfvf)
 	if (!otx2_sync_mbox_msg(&pfvf->mbox)) {
 		rsp = (struct cgx_pfc_rsp *)
 		       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
+		if (IS_ERR(rsp)) {
+			err = PTR_ERR(rsp);
+			goto unlock;
+		}
+
 		if (req->rx_pause != rsp->rx_pause || req->tx_pause != rsp->tx_pause) {
 			dev_warn(pfvf->dev,
 				 "Failed to config PFC\n");
-- 
2.43.0


