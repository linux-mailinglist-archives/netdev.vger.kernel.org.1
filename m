Return-Path: <netdev+bounces-129201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD6797E2E9
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 20:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A131C20B9C
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 18:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7223A268;
	Sun, 22 Sep 2024 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNWxsSZQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA342F43;
	Sun, 22 Sep 2024 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727031164; cv=none; b=SJMiK0NHWBT98gNlmgHbqxIaoYbZ23/ayo+V5WSlytLItXLIw2QcmMKxw0tIKm14yYiK7AFDyNs/sfk+CQ/KK35pqNRopU4IZAs5tiKq63FHiu1QqmyFKi3Vy/Lt0n+JSu/23mb31bFXD77dIM90V8YMtUbQCSz1ZfCt5h9r/rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727031164; c=relaxed/simple;
	bh=DqXKF1RT60rtiu31yXnwKTQ9+eUdeOQBjhAMWSOd5E4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gDAIVN47ZCGFF/thTPjRyft+Et2QRJinl1TXs1bxGrcVzwAnL0eJZ1fGO6awtdCzUaVkeNItOT6OOOz0swSx9CeEGcDvAoYWPwMWGQYe4nsc6Y8GE4k1eL6CR/Ra0Oq0n7vvfGx3KU6kgnCRWcFi8s6nn+T+kR+jR1jT1dYGQtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNWxsSZQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-718e2855479so2736962b3a.1;
        Sun, 22 Sep 2024 11:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727031163; x=1727635963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9LEyLu2SgjZjEDt1WzzFvyTgfaI962+j1MBQ/3CmLwA=;
        b=FNWxsSZQddKIitooSpatGps2j3Yz7cyPrSOgmER6/lQ8Q/wENhqJjib0gz/LyW7xP4
         LFe1UUZw6TLk8L2OSiBc5vr59gYbajeCoRHa7fp2M4W8ZImqhsF3y5HXUJzfOS2+l6O+
         trUj6H7RCvbJxNWBUtnM7PnXFsZYZR8tc2QXtxP0ggrZjTBP5SFNg1QnvbD+wuXorr93
         nIyabjV9JC/QVIi+2c1rPZgQCASNzM+Qgblpgw41uwGYc8noVBeDCGZWAQwT8J0euC6v
         vcZN50F+AXCrznoS8QvHuYQO6z55IN0jP1XCJ9nVxpNGKi8S71Sv6F7MDyv1ve40zsEl
         lvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727031163; x=1727635963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LEyLu2SgjZjEDt1WzzFvyTgfaI962+j1MBQ/3CmLwA=;
        b=EaPlgWobl8Hbmho10gPz2BFvuQgjvbXMnfVDDbf7yKeVp2oKyV9WtXbawYFuWXI9zE
         Ansni/TgBCIa9rd8c2vKqlELGB80h1BdH1QR/bDakBTwhJJlKfiM7gXStcoKnbwX+q8n
         W+e0/YL87x21JKYb1z6gulWltWVXVrBWhOqzvx4FDltceh63nfH+uhc5UpOk3PiLzS2g
         lbB2kBDAsaMycXCBX+M7WdKspc6PKqRya3Y9lfgo37nerF0r+aRqSsrgDqb7qI3AKjHF
         y5WUZICrpaC+DGifWx5bSWIUidyvMkTlLyDJX0k2pvA/5RjoY/q2Fy/LvmOJ8rLmJLLH
         kXKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSOAMUU6OvDqSnAR8ln1kU5IelMUJQz/OUrnIGbwe1ORP0gRp7FO7TZvQGtpOHufqxrAkPTqWB@vger.kernel.org, AJvYcCX1XSBhBuzhqWh10w51m+fJMh1lQFh8JZXAh2tymPlFegIyNM+O0/6kl3u0kK9S8MYPYSYm9RieURkx4X8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+pOq7A8heLLxOvcc6VTc4JaFFWoIO11klJmltHAsOEgZMkazw
	bLSKNdumaRdtfOSTT7Q9jTLP+oZ2miI9Bk53VZ07bcTbXGjX2snN
X-Google-Smtp-Source: AGHT+IGczZ4PLtCoPBgLba6blac55lFFYzbd9jv3J6Jjwl+Gslp/QRZo6URU+PwboaOsdo4CpjkbVA==
X-Received: by 2002:a05:6a00:3d06:b0:70e:a42e:3417 with SMTP id d2e1a72fcca58-7199cd8e815mr13109890b3a.10.1727031162635;
        Sun, 22 Sep 2024 11:52:42 -0700 (PDT)
Received: from ubuntu.worldlink.com.np ([27.34.65.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a980bfsm12641137b3a.30.2024.09.22.11.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 11:52:42 -0700 (PDT)
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
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: net: nic: Add error pointer check in otx2_flows.c
Date: Sun, 22 Sep 2024 18:52:35 +0000
Message-ID: <20240922185235.50413-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Smatch reported following:
'''
drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:123 otx2_alloc_mcam_entries() error: 'rsp' dereferencing possible ERR_PTR()
drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:201 otx2_mcam_entry_init() error: 'rsp' dereferencing possible ERR_PTR()
drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:236 otx2_mcam_entry_init() error: 'frsp' dereferencing possible ERR_PTR()
'''

Adding error pointer check after calling otx2_mbox_get_rsp.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 98c31a16c70b..4b61236c7c41 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -120,6 +120,11 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 		rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp
 			(&pfvf->mbox.mbox, 0, &req->hdr);
 
+		if (IS_ERR(rsp)) {
+			mutex_unlock(&bfvf->mbox.lock);
+			return PTR_ERR(rsp);
+		}
+
 		for (ent = 0; ent < rsp->count; ent++)
 			flow_cfg->flow_ent[ent + allocated] = rsp->entry_list[ent];
 
@@ -198,6 +203,11 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp
 	       (&pfvf->mbox.mbox, 0, &req->hdr);
 
+	if (IS_ERR(rsp)) {
+		mutex_unlock(&bfvf->mbox.lock);
+		return PTR_ERR(rsp);
+	}
+
 	if (rsp->count != req->count) {
 		netdev_info(pfvf->netdev,
 			    "Unable to allocate MCAM entries for ucast, vlan and vf_vlan\n");
@@ -233,6 +243,11 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	frsp = (struct npc_get_field_status_rsp *)otx2_mbox_get_rsp
 	       (&pfvf->mbox.mbox, 0, &freq->hdr);
 
+	if (IS_ERR(frsp)) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return PTR_ERR(frsp);
+	}
+
 	if (frsp->enable) {
 		pfvf->flags |= OTX2_FLAG_RX_VLAN_SUPPORT;
 		pfvf->flags |= OTX2_FLAG_VF_VLAN_SUPPORT;
-- 
2.43.0


