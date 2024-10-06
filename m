Return-Path: <netdev+bounces-132517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2168991FAF
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 18:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D98E1F21973
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 16:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDF6189913;
	Sun,  6 Oct 2024 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaHPTrnI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30B9101C4;
	Sun,  6 Oct 2024 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728233116; cv=none; b=et3t8hZuxOC84sUuAAdzM5dd0Rb9VbAKUw6ukh0d1YvdjYmk433F5TpNGLe55lh4cisTnQBtHLdFiU6CePBTGpsc5JKjUKZlmEgjS8fkJ21lrjQb8FWuYQ5K9IjwQLEzGerfX2ufwtTiNR9tPRvSqxHhF5JGMncJK0Y7V8I/nSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728233116; c=relaxed/simple;
	bh=QbZnEnt1banKnTIbdv1SzAoVyjQs4f5eql/pK7NjcXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WDmypjG/IF/6TEEjaq7HaDX9HRz3vWKFJr1W4lgzu2b3RL+JLsv3B0ebJuscxTjxXGphUk4GyP7vZfgt0qCl+hNh7o6F6M31NYKsuPMu+LKquqaBhZB1SbAc/aBRm4DFDEnRfnfeOMAXDn9xiTLC8Q5dCLuY7Zd8iMrMyKZLtL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaHPTrnI; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso2510383a12.2;
        Sun, 06 Oct 2024 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728233114; x=1728837914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gDSXLjvpLxqWxXHVbrKPpR5QLgHr8pG6IHSrQY1XA8c=;
        b=RaHPTrnIhGa2OJN9Cds2aUTram16yXsjPmy6ftfEe6l/I0HApDZQarG2aCFo85EgIz
         h1pb5IYkBngb1bB56rczectERW5YQj/7XfLXE1Q9o23taL0VohdCvmVLmJSvnCTBeijk
         ye12CGwMctZPxpThxVFe7ugGU+xlwg3aD4GpCxctzYnvGCEbsvBPEuZNPgU+kRR8P4hJ
         W7sjodTB6jLqIi9/4dI8Kt8DuV9PfMtrz5uxD+rJItBroXkW7+Cl0LtxD9aC4eqc/Fi8
         kxeNls+e+QEsFYkw8GuFvU0fkcsAV3EYwPcAOl6hm/2NPOhVvd+I6w3/0zUmeSYxYDKg
         oX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728233114; x=1728837914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDSXLjvpLxqWxXHVbrKPpR5QLgHr8pG6IHSrQY1XA8c=;
        b=WzvqJAHc0Hz5x0onG3LzSBJtHQUsQ/u8tlCXP1F3FWtwP3ojBBPVpK+k7y5nZm85dk
         UmPMQzNLLD7xQY6oI9qSgIfs4+820+M3fYd2rR+J687ZJRSdp8nsg+de1eeKmwla5Doh
         WWnxP02n5cfiLyfJ/fCxZ/YxSAg6UJpkO/qz5QKD48KEjoGrz5/CcDYw9wuuseYm3agr
         SKGVSk0+GIVuaLz2o0HYabEj/DfGIM/kHTzsAhP1Sly1Pgf3b1MLpyhWiKSdW7AXZWcE
         1qlW2V7Jb302PQ1dfio09P2BAxfRpv0f2P34jNx2sbcX8oagU5oO7Y4dDAl6AOONmbaj
         q2kA==
X-Forwarded-Encrypted: i=1; AJvYcCU7BR05NE0NlkAx8tN2zQ/XaI30nTEKigC7SRcwxNyt5MUCEiM/5dpr1uG7QUFJanPqzAyt8lpMyQfdvJI=@vger.kernel.org, AJvYcCUX3CH024/9k8dnC8UlZd/qbRApsDWuDhhhD1LGeMPSz9XND0Qbc6njraYpjy3QW5WeuDFAQjmL@vger.kernel.org
X-Gm-Message-State: AOJu0YwD/FcfBbL3VHvTMce8dPq0LVdzmpuK6qLLuttFWz9MLXZA1hat
	HGSc25l407JZMZRc+4Wa0uDFm1wFgExJ0b93x3EsYPGOEy8PI8ED
X-Google-Smtp-Source: AGHT+IGjuI5jIj7YSmywhBivlbOrhgRxaq6MB/mcaHO1MKIYwlSHETQBuB0Qogj9l5rAMcV9SPQLTg==
X-Received: by 2002:a05:6a21:118e:b0:1cf:6625:f05 with SMTP id adf61e73a8af0-1d6dfafccebmr12808603637.50.1728233113906;
        Sun, 06 Oct 2024 09:45:13 -0700 (PDT)
Received: from ubuntu.. ([27.34.65.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c35e68sm3330942a12.65.2024.10.06.09.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 09:45:13 -0700 (PDT)
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
Subject: [PATCH net v3 4/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in cn10k.c
Date: Sun,  6 Oct 2024 16:45:05 +0000
Message-ID: <20241006164506.2082-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error pointer check after calling otx2_mbox_get_rsp().

Fixes: 2ca89a2c3752 ("octeontx2-pf: TC_MATCHALL ingress ratelimiting offload")
Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index c1c99d7054f8..7417087b6db5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
@@ -203,6 +203,11 @@ int cn10k_alloc_leaf_profile(struct otx2_nic *pfvf, u16 *leaf)

 	rsp = (struct  nix_bandprof_alloc_rsp *)
 	       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
+	if (IS_ERR(rsp)) {
+		rc = PTR_ERR(rsp);
+		goto out;
+	}
+
 	if (!rsp->prof_count[BAND_PROF_LEAF_LAYER]) {
 		rc = -EIO;
 		goto out;
--
2.43.0


