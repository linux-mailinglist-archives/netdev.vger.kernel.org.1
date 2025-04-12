Return-Path: <netdev+bounces-181920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C8BA86EC8
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 20:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D7F17B261
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 18:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04BF204F99;
	Sat, 12 Apr 2025 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCc0Ts9+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491821392;
	Sat, 12 Apr 2025 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744482812; cv=none; b=dxQgqOcTPxUFA/qPDgeIISPAqAaWVZSh516yw3/WNNNwEF9Rt+DDcTWrAFt8xzXh+EPIKqRgUetupnUCFIVfjx8zjIyMUncXzPIZho/Uy8gx2FSek4h58iuTsIEjGcvtsL/grG/2VHJchemYtPUoyrmJH6ViHztQbQlFcP4a92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744482812; c=relaxed/simple;
	bh=xb//l84OJHLSYzy/HLq0aIAbpNr7GXlOxuv33T7qDIs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fMFLI2MctObvfsH3oeLWQaLKbfMfz9KRrrjXfpX9Go6oBTrEgIFOobRhLEe/MNzltnTc/KqJZ1w+jHamMOcPfdigM0uzUsYngxKMUC5j7z9Exjza/Mms9Z8RBcD6OMH2D5etvOMx5dFU9oiO8w7ui5yXozl3NLp5dtzl0nE6w2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCc0Ts9+; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c553948ab4so24932485a.2;
        Sat, 12 Apr 2025 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744482810; x=1745087610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iOe+2E1QLPcYCD67YCrKIDFqiQ5cbueVE7XFqwDxXd0=;
        b=GCc0Ts9+Uf/5DI43MxPat/2KIWJj46XNLi3eMMsxzas+FWLKar6Tdvb9sS560FwboF
         6jsZ6hTs9Qea3sdjXDWek8MmsR5zs1fIx2lGgrxExPccFL+VMcYAobYXvho+/frIvdej
         H3Y3VSh1xhQJL06Jmwf0wtv2e5SJl8jSfcnrmmgsWVKX+40OGo9dv/I6pFs9/j/2B8CQ
         44mUCUyLX3/10prdM9Njf29vkny3gNhybDPIgBR/kXyRSjqSYI8oGQbw2+kaRf1ZLyyR
         FNreSbe0KNHqWl6qmQzSnwVDSeXbtOa5kN838no3ULpOmlCXDXhIHbjaPUGAsdDC9oDG
         XkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744482810; x=1745087610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOe+2E1QLPcYCD67YCrKIDFqiQ5cbueVE7XFqwDxXd0=;
        b=dEn87yd4Mkf8y19BwBCzbNlnS1qUJ1edksCluQthChqxeX+Gb9zqMVjsTq8o66W/9A
         jfHiWpdFG4YnIFiLxFqUXpW3feTCyBM5bSPDVNqcq3Ld7049doUcrOuVQcV6YCzEuDHs
         0dt09joQJy3eHCqYGIPyMjr0H7PXp9pJPys9FnJULOyZHoXzRLSATb3zalYzvjkPjUSM
         uKLpk1kUYA1KvfQ2YCo7MeXw7Adf7IcYnaaJFKaxdubRR0gl924+Fx1XDmOftUZnV0Ly
         FubjQzvIWK3AvID1fI67fUbPTlGmUl2Sdf8XI8abazFAE0NlXbIw7gq3hr5KbQ5k5Qip
         JXlA==
X-Forwarded-Encrypted: i=1; AJvYcCUwBss0bkiQjQ43gwvJAJj0LQkUSXk5BZQLfYJuwutcFWUqdOjR+4vPEI1l9bdv8fSPVWtxZ0G4k2dqUJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Wes5feerjNNBqQltfdOs4phGE3aBRD7A0qreUrkQirF91q0e
	+57aWW0vk8fjUXYDOy4HaEXzKwNqg1W0tOSFOEeNMFn/K/Nz2ks=
X-Gm-Gg: ASbGncshnOO2v5py5K20278peJYbIblONCNVeTT6DmpX41ystgyg23vtkSkj/JPS1eq
	ca8uxMk2Luo5nwyAgpqweT0eO44iF1zt2V54LWlTVeFr5g1FMzD8j3KxHUXXGTSfT7/YqbluSIQ
	pxXxymoESwoi4d+/3qPr4x0zB3O5v5i5GtK4Xc4Hv4p8+ukAXfP6zWdBHwY6m4K/jG4n6DY9elb
	McLGJ//MMFskCDEwoTjonjYPinXgVkVonkfPw5Nm+mtZZ9cJ0xDRfAun/XvQt2Lr6A+C3HcmoRj
	eBCKq9B0Zmda2W7Oh3g1e0fdYXbrKfQag7YyYQ==
X-Google-Smtp-Source: AGHT+IHQ1+zwUyKk2IKbG0nEF7wWlrdrJDYmToU0h136mmDeu4b6sPcAeNjNH+8tsg9wxyRU73k0Ag==
X-Received: by 2002:a05:620a:319e:b0:7c3:cf04:112b with SMTP id af79cd13be357-7c7b1ae7de9mr318376385a.10.1744482810000;
        Sat, 12 Apr 2025 11:33:30 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8a0dc9fsm435941285a.96.2025.04.12.11.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 11:33:29 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	bbhushan2@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] octeontx2-pf: handle otx2_mbox_get_rsp errors
Date: Sat, 12 Apr 2025 13:33:27 -0500
Message-Id: <20250412183327.3550970-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding error pointer check after calling otx2_mbox_get_rsp().

This is similar to the commit bd3110bc102a
("octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_flows.c").

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Fixes: 6c40ca957fe5 ("octeontx2-pf: Adds TC offload support")
---
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 04e08e06f30f..7153a71dfc86 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -67,6 +67,8 @@ static int rvu_rep_mcam_flow_init(struct rep_dev *rep)
 
 		rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp
 			(&priv->mbox.mbox, 0, &req->hdr);
+		if (IS_ERR(rsp))
+			goto exit;
 
 		for (ent = 0; ent < rsp->count; ent++)
 			rep->flow_cfg->flow_ent[ent + allocated] = rsp->entry_list[ent];
-- 
2.34.1


