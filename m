Return-Path: <netdev+bounces-284061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GM2Hngb+Wng5gIAu9opvQ
	(envelope-from <netdev+bounces-284061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:19:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F54B4C457E
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B90C300A324
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 22:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D188A37FF4D;
	Mon,  4 May 2026 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ0sQ5KN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4193803E0
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777933172; cv=none; b=MzuxcuZNNaOs3iqu2lYFuTbgScPGGygv/sVfVekShTZFBTCE8V3jATRfXMmRR+I1qD/EedxuGe17nJVTMna6d7HvIMkUx/x52S6H+iSLAT8GEjwzcgovC97oRVRFrJmU+y2YuPDDrPXY2za5s6Bejx7iQ8pSR+LUHmhQ5t9bo0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777933172; c=relaxed/simple;
	bh=ztdrt9vzdAq7Eb3jA8QSH/Kuq6wH7FHBH/eCinh7P78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXLPw8yt6jkroR2ebVcPXAgeaSeOaIeq7UBw7cFXhleSzF3x8Pt5mbym/r54qCCuzO5lmbUdh3csx5WAALL1KVbjxRHgTxlXy+LVjpgvx3qKbeqUwuVVwoxt5NrzL+dRzxeAEI/CQPKxHvRG4Lh3HUAE3kJ1coviWXzM7dzKl4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZ0sQ5KN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48d146705b4so3198055e9.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 15:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777933168; x=1778537968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KI2VHwPQhpEIeLDiMOieSMNQDxnxTzAkBbt4N2Gn7vk=;
        b=WZ0sQ5KNwc9UKb87PbRpwUbhzHCinR220WgIiug2lm5Bi43pCTBtxHXdBQsO4So5v9
         6k1JykPH3zptZbL8xYFjIFYoaUOC34LyYGg9RGPusyw+nzwyNv5p/WLRLlft9sPWeLuN
         PY05vc8/7VKF/tzXexpNum/VRNtOaCRAmbBiM82Bqn4l0FrBc+2NIj7OG6Un5kL1yAnU
         aPpmAx7LYaUlTLyyqH62NjJVi7wZIUFk+WVfPLIKCaz64XBC+n9NCNGwPKwz3BzuRa39
         SZydJIGuQNk7m1SfgSlsoECv3b2V+OYzxlw1NU9fk2Ab77rq1UuvCiMrdg0fA/q8hBZ6
         AZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777933168; x=1778537968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KI2VHwPQhpEIeLDiMOieSMNQDxnxTzAkBbt4N2Gn7vk=;
        b=Pn1PP75fg8QA6/tY/7690yzSdbT0UdO+LasAs8Y7HYqyMNTmCmG5cmH5wlx/yLYyY+
         y95Pb6IF2EV7m5e9YuGyuRB9cCbjUZ7r20zIZQcY1AQ8/GbN+qddwsYnAzU2f/Q1BTrJ
         4Ti89k6W6mjOCAJSjiOtHda8wJiJLADa6BXKqQ0cHkFANhQtpO7FbUh2Bf8Qt6o+g293
         iUieFMnoMMNz6u+aFofSE8h6HhQQntrkliZeuxOMXXtU2gx1ibl6wkCTcFjZQznwCDNf
         fPlvcips1cXda97fzB7SKVpbVK2XmJTfU5ZUhfGIJQWIsOPMoiOcKYYjVXYYj85vlynM
         Ew1g==
X-Forwarded-Encrypted: i=1; AFNElJ/KAVJ+bBpBpzf7SrTzfPISRcaQxZyfa1sYTfcZ6J8/uxN1SasBX6mLPSapMR2AibrVyVNEVig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcgZt8pn1hP4B27tyey0QIczYGHztzhcc66MIRjepuUigAWHvE
	IXKvSFSlf7JxBXbulq4m3hBNr1c0DRLI7KvfLKpFNpWZPbHev3mkFZHO
X-Gm-Gg: AeBDievno1K2ivBWpU4S9+KHMVOVU1WZZH/SMuC3vbsO+fQaO8A8wZvmLC2GgAjr0Dq
	dJV/VxfaA/DdUq9UNik24lriEID7/3yLCij8+phYt7/OhSzLyCVguyLcWZeB0QWohpbc7Ooevsc
	OOTO3tsSk2aJTDwMGezzj0ZVL/q/Hqd0QujgUe9KBuSLULNR8/nITq6QVFb/lzgJa7uV7DDbbg5
	LAiC0sqdkuhOe7OmsbykaVcLncRMkbrtM0W1XwDPD1G0q1CFeJQYi/NKhDxubbCnuxUMsZcWbRS
	a+3Cl+dMogxdBCUz4FQYuIU36In/CglQgE49DjSaN0VoDeTolru7pcyqoBM0w6w705rEhOzN+R5
	tRBIXmYV81/j7k7WbL6CtFP49s+l1zvdzcENK5pvD//+rJEBqx8ayM5MYo9gOtiuiZLrF9674ZP
	3NUvBNB588HAlJFdCYM3rRTbwbRqaW8HX3Tg9BDdHkPRQQIjeyLqpSo7nYHVVrh6ZuCasGXJlej
	NWy9w7Guv0d83bp9yC87CFF393uaCtJFIZpoVZkew==
X-Received: by 2002:a05:600c:4f05:b0:488:c683:be89 with SMTP id 5b1f17b1804b1-48d188dcc95mr6010225e9.9.1777933168454;
        Mon, 04 May 2026 15:19:28 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8ebc4201sm484802335e9.15.2026.05.04.15.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 15:19:27 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Cc: Moshe Shemesh <moshe@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH net v1] net/mlx5: Fix HWS L2-to-L3 tunnel reformat release
Date: Mon,  4 May 2026 23:19:17 +0100
Message-ID: <20260504221920.48685-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1F54B4C457E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284061-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

mlx5_cmd_hws_packet_reformat_alloc() allocates
MLX5_REFORMAT_TYPE_L2_TO_L3_TUNNEL objects from el2tol3tnl_pools with
MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L3.

The deallocation path uses el2tol2tnl_pools with
MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L2 instead. This releases the
packet-reformat entry through the wrong pool, corrupting pool accounting
and potentially moving the bulk entry onto the wrong pool list.

Use the matching L2-to-L3 tunnel pool and action type when releasing the
object.

Fixes: aecd9d1020e3 ("net/mlx5: fs, add HWS packet reformat API function")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index aca77853abb8..60fbb048db10 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -1396,8 +1396,8 @@ static void mlx5_cmd_hws_packet_reformat_dealloc(struct mlx5_flow_root_namespace
 						    pr_data->data_size);
 		break;
 	case MLX5_REFORMAT_TYPE_L2_TO_L3_TUNNEL:
-		pr_pool = mlx5_fs_get_pr_encap_pool(dev, &hws_pool->el2tol2tnl_pools,
-						    MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L2,
+		pr_pool = mlx5_fs_get_pr_encap_pool(dev, &hws_pool->el2tol3tnl_pools,
+						    MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L3,
 						    pr_data->data_size);
 		break;
 	case MLX5_REFORMAT_TYPE_L3_TUNNEL_TO_L2:
-- 
2.43.0


