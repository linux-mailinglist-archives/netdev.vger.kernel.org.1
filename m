Return-Path: <netdev+bounces-284064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAP2ASQe+Wlw5wIAu9opvQ
	(envelope-from <netdev+bounces-284064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:31:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B624C4654
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D7173029E4E
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 22:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444F238643B;
	Mon,  4 May 2026 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sx4q/bGW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1E2386576
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777933826; cv=none; b=d9RLCGuauc3nNavo/skLjg3K4J2ky74e/gNU0qCKUzIv951kcFEoDCIO0sU9bX0cG8XEVLf0DUYjgUJkgbaM5DcNI9TRtmMXJ4cwvkh6WxJfpyXUPpoR1kVUIuwTAQuOiqNGjsKukqjHhcUEYO8zs1fmfSVRqG7gWTUAe7HEW8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777933826; c=relaxed/simple;
	bh=cOYBuqi/VNzz2C0cy5p2PKu3wLi5vzljAJiS8TAEd2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BwjkHma+IThCYDt9JR8+ZVgT8eB+GlkB8He7aFuQBcTpmrIsbuI1cGKsKgDlYnpFcOcnjQ+0bt/h5HGQx+h/8MFkqcK/Pys5w2DhRmuNzSILEZXAyXM9oExewjiDrAfIN+1rDtUHqY5T1hO7owcY5eBOo889C0ANsg+AARVC5L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sx4q/bGW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b150559bso31171415e9.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 15:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777933822; x=1778538622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T8YNj/CzrqnJauyF8qzb/2yp6o5yAPhiMcAgKOfOpJ0=;
        b=sx4q/bGWbYMbJ84fbGEaB0LNIP524Azl/87gJ29wgq50Uszj0PmamYNc2+vc/Czw/9
         IOcpyXRjuDLOtM1RSi4WO4ceCVY24boni+owH+nRISQ1o/gyqCJZWeByotq5wxmzqTnq
         kP46+n6MtMrBDIj+3zToCNbtWnQ1JM/QeIhrr89b/9pNPn0HDuRaEIDBJVwYDUm+BASr
         ckpW0pKAb08/ZzfL5RmhRHiTrGB8gvPX6XkfKou4h3SmRQAyHBvhXX8AIvxUNfkdhUCu
         dl29fI7MqllHZf7GPTAMU23yo3lpMlPs+9z4PcZfANbrinKJd8KwSnZapWGV1OADBmLP
         hOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777933822; x=1778538622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8YNj/CzrqnJauyF8qzb/2yp6o5yAPhiMcAgKOfOpJ0=;
        b=n5QIdwY0inYBH10ErALin8y5d7zf7Im/wP31Hy6BxFJgR1059/OgXCsaKqBzz7LC0X
         S8gFtMOGQQOf3WuH87njc2MzSbGoWRtttXIsQiEAa09uzYVRxyGKeBKGAykyzj7LYYFO
         D+SMyeNz4+vliS94eoci0rP8L766wOBhotX6UavdO+lWszqcdp8BLpsJ+KI8pYMkESah
         OydK3sDLmSOFO9lDSsoHIgMAMffBh81sQTN+eHKKyiWjHQxPLf3rqPYgwDhYQyi/+kFC
         1fx6yhR7JFoEUZ2dUk0FvD5Fz9RXT3GQbySDeGoGRNhXibr2ya5nBJU4vogJL9Oyd00W
         rLtw==
X-Forwarded-Encrypted: i=1; AFNElJ9qeW+N+z96MfP9knl4DKT5EwzEMBy8Vt/sg4nMd/DcVCmsp/OaIddpysSHOzWRI+GJX7w2Wn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCO0WvbtRKZ0vTMTXoR+PEI8duUuQUU+1Y1QPom9051FO6cXig
	lT/ihPG0q+tmZiH5NphyQFjJaHA1lJ5uVv50EN8aKWXpTt8UGvZoFX5UmSs5n/uf
X-Gm-Gg: AeBDievlszC5ZhNCKJPoFmEW4RxOiR5ubI95lRLWVSyV9IytbSto6Qn0lpVqiU/7/yn
	Q86YxaSwkdVvS/awnZbC/FcCBN0J/qeDUApJWa6SG5eT8fqlow8D2zLDiRzmGbNMPzAtBK2CbGq
	0EFKHO+XSQEG4+XJH9K8oBkVIq4/9QkmwY85UFbj+VQlEzOUkAg7waD9O06iB8xl3mkAu5NnqRz
	9Hrll+JBgsCruX7ksp1rZS00yJrQA0P8+NiJDGVw93RZHksz6tBwzaoa6rNHWLvzr0bf/Zp7qSO
	L9RgviazpSwJnNgI6Xy2NkREOMJJ1XZfUByh9UJF/ZUUihfIU3qv+RTROIhzyYFJ1Sa0TQGwi9o
	/8olWs9xgXQO10vgD0acJMXN8YI0C7rNcGiOyLLhMHIKioWVqXEcuT/PjPLpF6YoauP7GXMlGF/
	Usy3VjqsSpfJF5NgahFBBC8BF639nlP3cSd8hs8wKv6bHrv/7RdOR0QJLwB92J6w/8jjELDYtcR
	Fm1UOiv0Z4ZILGKtIf+SJYCkruUTRGA9rI3gyOWnw==
X-Received: by 2002:a05:600c:444c:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-48a9866aa1amr196231205e9.21.1777933822449;
        Mon, 04 May 2026 15:30:22 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb72a17sm319020415e9.6.2026.05.04.15.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 15:30:21 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Eran Ben Elisha <eranbe@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH net v1] net/mlx5e: Fix PTP TX SQ cleanup on metadata DB failure
Date: Mon,  4 May 2026 23:30:05 +0100
Message-ID: <20260504223018.49556-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 60B624C4654
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284064-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

mlx5e_ptp_open_txqsq() creates the hardware SQ before allocating the PTP
traffic metadata database.

If mlx5e_ptp_alloc_traffic_db() fails, the error path frees the software
TX queue state but skips destroying the already-created hardware SQ.

Add a dedicated unwind label that destroys the SQ before freeing the TXQ
state.

Fixes: 1880bc4e4a96 ("net/mlx5e: Add TX port timestamp support")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 723f66a6bd63..45db2dd7408d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -489,12 +489,14 @@ static int mlx5e_ptp_open_txqsq(struct mlx5e_ptp *c, u32 tisn,
 
 	err = mlx5e_ptp_alloc_traffic_db(ptpsq, dev_to_node(mlx5_core_dma_dev(c->mdev)));
 	if (err)
-		goto err_free_txqsq;
+		goto err_destroy_sq;
 
 	INIT_WORK(&ptpsq->report_unhealthy_work, mlx5e_ptpsq_unhealthy_work);
 
 	return 0;
 
+err_destroy_sq:
+	mlx5e_ptp_destroy_sq(c->mdev, txqsq->sqn);
 err_free_txqsq:
 	mlx5e_free_txqsq(txqsq);
 
-- 
2.43.0


