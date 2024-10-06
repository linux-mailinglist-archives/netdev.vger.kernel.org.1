Return-Path: <netdev+bounces-132514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3317F991FA6
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 18:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3002F1C20DA5
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 16:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB95189B95;
	Sun,  6 Oct 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHpQnH0p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E5813D53D;
	Sun,  6 Oct 2024 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728232941; cv=none; b=SCg+qL5loytucp0IM4u530A8FgdHED6mJy0RLTE4j/C1BmNkG0hcwRMIkP9WYcMOISaFJHCjqaSAROHyCpuClYQf4H1sCywi3VSPn8o3JHuXdMLSdAC75YSJIJLCh5SHBMxdy2WbDg71ObFyxsmQR71rc36yJCUEUvM0V3HS7L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728232941; c=relaxed/simple;
	bh=OSA/UttSCQ+RJb0fDFlEFoIymDBh8vyh4InGFlWqfsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FT6RQGAXUcOe69Rm7hKDpQI3pg3AxU/7t0lqRYTJGHS0DGixMt4ZLOGzyFz2khx8SNc6e9O4zoBShwjEWaGn85s7An/t8Q5qPuJgM6wGMCjrq1k28fyzdXwKFfAlqDUxyZTxPMMuPto58SQgyYRq1Oic2kuzxrcqlNm5WBn+KOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHpQnH0p; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b0b2528d8so41983135ad.2;
        Sun, 06 Oct 2024 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728232940; x=1728837740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LxQpJ5hCgYcs/trf4+eyErsC4uM3M9gAv+Z4ofoIijc=;
        b=EHpQnH0poEO8UO/NSazmi5Vr4Ucf9yJKgocdGFSUbsPAKWySouwBdMfk3VxH3XhgrP
         APY2qo2q7S3en6mFAw8XK9qguiO+jzTkFTumfc3vT+G/JVpz/8s4wjH1oSSdbsX9jLQL
         Qb+Rgofpw7Sr556BN5oZI4h0h8olsHvK5hucAKG5A3kz0xwVG391lwS/fbqcMuvQUMfK
         7nvsRRpNnK8rnmLixPoYNQ5LAImxMGDNE8WbeX8FmwrrF3lakBYoCLWeY89P+kk5ujLg
         zbVUI5rTgbUK/GaTXr0XA4+7nTtJaEUpJW3GARDjCFcLPEgkt4DMbZLf1zzq+mn0GYxr
         ptaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728232940; x=1728837740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxQpJ5hCgYcs/trf4+eyErsC4uM3M9gAv+Z4ofoIijc=;
        b=FUROl0SSSsM24m+EHxE4A8IySwDONbFXUT8d9J8EOJ8umrtlr4kFUBrYrbGrIuN3fd
         d+/8Yn2IHxOrcbnGpgqdDEZmdt51hMIGzsBz8biVNJUmwESZD58GlwpWk/zyvyROUgji
         KuE00AXIXVUxAJCCUvstqAEBSaRzBLEEIsowJHs2ekzziJT4u8Gexf4+4/+9GE2b7CEk
         uap1uKmFF/MlVIuPDjkMbnqrVFyrSvyINFAdHbFYsH0OXfb2um+ql0GzukDz4wtSTLr7
         yd3pBudiGo7fnV0/peKc9TsM/Fu8Vh1Wq1BYpkDPYN0b6lEV5OfbGCKMqs/ue2YKben2
         AFRw==
X-Forwarded-Encrypted: i=1; AJvYcCUW34/+K2U7v3YUukorpjqKjZM6tHSWKcqeuyaSyldO1rptRbX+QCYHy5REhWgcD6HyA2Rcl7jUX65QWBk=@vger.kernel.org, AJvYcCX29f28sB7E6CEXiRzW1swc2oieH3o49bK0EdkEK0fr5UpJNXcsNUGOWAMH65y0Stm9YcB0RJzu@vger.kernel.org
X-Gm-Message-State: AOJu0YwKeb/W4128QO98eRuBeH6K/yXh2HrY0QmrmtqbAfUOO/o7Lq6H
	DzQzFfQd69+JyonkiAoNqgfh02EYXGVUv0iHW9o8aUfa1HFOmtor
X-Google-Smtp-Source: AGHT+IErEEs+qwJd+gGXbQxfLJJkKdz5qkgd/3vADcl5eLKkIigD8X4oh7mIRAAj0BZbol0fGw6aqw==
X-Received: by 2002:a17:902:ce87:b0:20b:8341:d547 with SMTP id d9443c01a7336-20bfe01d7acmr114226585ad.26.1728232939686;
        Sun, 06 Oct 2024 09:42:19 -0700 (PDT)
Received: from ubuntu.. ([27.34.65.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13968b62sm26751615ad.203.2024.10.06.09.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 09:42:19 -0700 (PDT)
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
Subject: [PATCH net v3 2/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_ethtool.c
Date: Sun,  6 Oct 2024 16:42:09 +0000
Message-ID: <20241006164210.1961-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error pointer check after calling otx2_mbox_get_rsp().

Fixes: 75f36270990c ("octeontx2-pf: Support to enable/disable pause frames via ethtool")
Fixes: d0cf9503e908 ("octeontx2-pf: ethtool fec mode support")
Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
v3:
 - Included in the patch set
 - Changed the patch subject
 - Added Fixes: tag
v2: Skipped for consitency in the patch set
v1: https://lore.kernel.org/all/20240923113135.4366-1-kdipendra88@gmail.com/
 .../net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 0db62eb0dab3..09317860e738 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -343,6 +343,11 @@ static void otx2_get_pauseparam(struct net_device *netdev,
 	if (!otx2_sync_mbox_msg(&pfvf->mbox)) {
 		rsp = (struct cgx_pause_frm_cfg *)
 		       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
+		if (IS_ERR(rsp)) {
+			mutex_unlock(&pfvf->mbox.lock);
+			return;
+		}
+
 		pause->rx_pause = rsp->rx_pause;
 		pause->tx_pause = rsp->tx_pause;
 	}
@@ -1074,6 +1079,11 @@ static int otx2_set_fecparam(struct net_device *netdev,

 	rsp = (struct fec_mode *)otx2_mbox_get_rsp(&pfvf->mbox.mbox,
 						   0, &req->hdr);
+	if (IS_ERR(rsp)) {
+		err = PTR_ERR(rsp);
+		goto end;
+	}
+
 	if (rsp->fec >= 0)
 		pfvf->linfo.fec = rsp->fec;
 	else
--
2.43.0


