Return-Path: <netdev+bounces-273679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHubFDPqy2myMQYAu9opvQ
	(envelope-from <netdev+bounces-273679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:37:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2328C36BD45
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E73AE3051F22
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376A1413241;
	Tue, 31 Mar 2026 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YM6e041D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625CD2BDC2A
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971179; cv=none; b=BFtlTz+9u9QL3kVOJBu7KZd2UjOy7QrdpXCxe4vI3Qzn2h1gMrC6iPZREo8GpDJBWSx9sXA8iBec81DWEJRUuA5QxR9up/BtO1Q22xxERk3y7Z/CIuwhGxr9paxBQ7crKMH99aMF1PXSKZlyP+Kp2xXA5K4PQNsvFmZkaifPGlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971179; c=relaxed/simple;
	bh=sq6xb1uQpPCxAKf1n02HR0j56fcBej+bOep9xHO9y90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gRDE3zhFUDR1a2quc4YhdiYNpwRzKccBWdFosvz5fltRerdxVz53dQQ3jnOfQCe4IT52TXMSx0FHOWrshmuA08nBQzV8G8C6v5OQKCpjm07FRW+xkOCfODXOoIlvuWvYWeh2CxGIrVZ86OzUM60UwlBpyB1JN6hr2+ydta2F1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YM6e041D; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fe655187so76388195e9.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 08:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774971166; x=1775575966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FwR2mxqLujSdr9bI9JYKZsbivVm2a+2JAgTiRA8SLEY=;
        b=YM6e041DX/x3aGnUHEZb6REb6VQLiLuyvjnmD1UtNbB/QwfmURMbyScTo/ehcm5VAH
         jHMO2IDt95mSfCuObQReB3uNDNF6nMexi17XcOjFCRaUOfq3Kw0v081BCAeGCPghLD6r
         XE1/kBs7NyuUPn6cGEpoYyezdFYwNXnScxomiyVtUDkhTxZaDPhbrsXiL/0/qkF8c1LY
         brM4LersWeNvHLlWzqf8S8xHGzSMMA+a86KdJF5g3AJGLWaIL1ZuiuxscRlcDJfvP3x1
         KL3IvM9fkfJLFN6tpE20Z+ylf7YOtDzhSvmRF5yFRTBLMH0puuomJaCtkeZCDklpg1lw
         mKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971166; x=1775575966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwR2mxqLujSdr9bI9JYKZsbivVm2a+2JAgTiRA8SLEY=;
        b=Fde+r+PQM6HsTRn7extMxSoEJDiLe+eVnz5f+S+h9LccILAWP7t0Ljd7S5FxXlIm7f
         hFvAbT8RFfla2AkbS0B5lxV1o2QyQLGVXrnjZt113JVxfJTMon5px9ylRRN7rnK0GMbd
         e2HCyA2RHUKc83qzHiilFACOSdHOUXGr95ZTRa5ylP/iP6YWpvmUCH4P5GnTdegWR2vk
         J9JQ2WwNlBWq2dqB3Fl2QehiBsh4wxO9ktaJ1BSczltpVm3QzcQM/fMIKAsLLFQINEQo
         eeGvWSk8LXi0NHFud0kAvm58jnOK1/Cf5opNMhT3Ah+kYVYe/bwkv3CdaWtWzOJJ9yJp
         KiIA==
X-Forwarded-Encrypted: i=1; AJvYcCXF+ts9a/Fg7030eI0+1+81YV+fbGp1ifSqaCTF8eMbc59FAt0cz1r4aeez+tXSs2S4qlapd2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHaciaEnIzM6LN30pzHap9xRdGWx2MT+wEeEBiwLh78L/H2w/4
	o4sJpvJpi5CZYPo0HpD9fsTAe7X/GgyMPAeSMWJDgerp8v+IthhOuEQxj4xD5t6O
X-Gm-Gg: ATEYQzwXb2SpgQmwR2YOjPpCZHMrTVxavNMeXET7oHguqu/x92DGOrqxVw7E5YphYOm
	4qe+4MWnJe1PnIUdLvz5x5kJ2iv83PxGCaNZlp5a1EhRlrIEe/qS2SCGqPwOyEpElYjVxuKNAMM
	mLteKOTnCDJGDiKUjpolEh6TQYihuWEreYxFf3BaZhN1oqFam5zk6r+p8GaalIAG1pMX2SeCmDS
	jjD76oXFyLcGhMoGhspnVlGiRxDLuYtEXsDZ8TbfNcvmjxw6TGeE43c7apub4AUMfCLLqnMJN8q
	jeQVHbIxXKcxZXUzM8fEchhv1Lf/Sv1CbBM35ADiStxRfIPPQ3eSYQZmNGPLbbel45VgwekzuIa
	Em1XnRlr6duqhCyWIDa2sjlJ8CnXDXrVL7uJdwtGgATZP8sHuNsPKQrSJvTl1o/0lMqf38wGR9g
	Ntp9/8AEOgN85Lua8drASBln8KS7VqznlP0vdLwqAVHLiZSHv3EmHB+uBMJvqGpeh2EMR0bHNwA
	+xD5iUCizBX6GvI8CkgfR0HUYQxMP4hXN5HHkyse0V55tCu
X-Received: by 2002:a05:600c:5303:b0:487:2439:6266 with SMTP id 5b1f17b1804b1-48727ee5445mr282184885e9.30.1774971165955;
        Tue, 31 Mar 2026 08:32:45 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c769841sm23908335e9.7.2026.03.31.08.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:32:45 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH] net/mlx5: Fix potential NULL dereference in PTP event handling
Date: Tue, 31 Mar 2026 16:31:51 +0100
Message-ID: <20260331153152.16766-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273679-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2328C36BD45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mlx5_ptp_pps_event(), a TODO comment correctly identified that
clock->ptp can be NULL if ptp_clock_register() fails. However, the
code proceeded to call ptp_clock_event() with that NULL pointer,
leading to a potential kernel panic.

Fix this by adding a NULL check for clock->ptp before calling
ptp_clock_event(), ensuring the driver handles failed registration
gracefully.

Fixes: 7c39afb394c7 ("net/mlx5: PTP code migration to driver core section")

Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index bd4e042077af..9e9f844935b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -1185,8 +1185,8 @@ static int mlx5_pps_event(struct notifier_block *nb,
 		} else {
 			ptp_event.type = PTP_CLOCK_EXTTS;
 		}
-		/* TODOL clock->ptp can be NULL if ptp_clock_register fails */
-		ptp_clock_event(clock->ptp, &ptp_event);
+		if (clock->ptp)
+			ptp_clock_event(clock->ptp, &ptp_event);
 		break;
 	case PTP_PF_PEROUT:
 		if (clock->shared) {
-- 
2.43.0


