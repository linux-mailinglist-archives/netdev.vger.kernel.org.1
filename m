Return-Path: <netdev+bounces-263580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJOdKjWzp2k6jQAAu9opvQ
	(envelope-from <netdev+bounces-263580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 05:21:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4161F1FAA96
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 05:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 635BB304C070
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 04:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BCA37F736;
	Wed,  4 Mar 2026 04:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpFP9Yf8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E325537DE94
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 04:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772598064; cv=none; b=gyCDd9hiJfBuh6QqdP6mLsVN6MJaEkDtkTKdCzOUHnvCCstsArFmPORHv4bIrHfYUyOvQELRktuf2FwpQzAJVAwPKno4zyd4kNuzeRNdYw+UYOwaX9bKZdfNgxXA4597yXDksuvOxsHSMZ4HHJDXgmfAmUtQDvjkHqaAIDETIBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772598064; c=relaxed/simple;
	bh=l4d6DC1THpFUrIjFAa1Siu6xdoT9cwAm9vhDbhIMKAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Drw0hSU2AVZeBN+KurCKpF8qESLuiMBPonbz0NWNhAWI7iAlIQGfYQkPPEsUFmIznuAm6MAAPqhev37uRoqmxchCl5qPLZUQPdExGunV7Zky9qL/7tcQClIm1fnzctxGp5xvpba+5hZvJDtZWbzSb0PwXgjSGnb/nZork3X9tU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpFP9Yf8; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-793fdbb8d3aso77788987b3.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 20:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772598062; x=1773202862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDy+kbw/8FC9faqHBjNSlqyFx7RPOn5A/oMrwXHhttk=;
        b=OpFP9Yf8fpmgqKTOYN+yj5TSXKFpKBtr6lH2dIDnQzgiZg+NSIl6HG3k2s08TdCqYL
         dPMSiXd+Vt1ulF8zoYeLo5Gd2lJVJfzkZlwL/RoRm0ojWgbxO9lA31HLWuqmgcDOxOJw
         lXUW4MJRdLXjkf3bqtpFnSPo1a5M1H+iRLDrZyu8zQAI6h2wOCD3kufG+g/n2YvTmVNa
         lWoE6jzBMUtXLPl/5OwP7wYHsYP19z8naUq28kdS1yLKRy5rL1PctfV4XBY3byKfHj2Y
         TAPeQ5h2Vr1rQa9sBvgswyzhgPZ4OChRY1t4KXonTouleazGPKLdwrooqri2AXQB1CXD
         7qJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772598062; x=1773202862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDy+kbw/8FC9faqHBjNSlqyFx7RPOn5A/oMrwXHhttk=;
        b=T7N9FYQhTaI1Hfvzo0LvS7fS5h4DWm4/g/gp4+2A69VSi9IFByB8OZfC9vu+uDadp3
         XJ2hBoHzExOU18Ul8ShE0QI6rtrbzJA8bYqr2eIHdg9InCHyP/DsVlq1bRmMkK8RSDw9
         5U28sXJuy+kuzBIkSAzYtkNLfhd4Ty/R9+UlWXxTFqpYR0FDWJ+2ivWnLIPws/ZROE6w
         A5mDvs4EVM9qIl76S2ZPb+zpQjS0Cr1ko5DAjlkT0+i6SVWoewnxIZ3zKcdqlKacKH9i
         vGFkkeoW7H9lguS1hYRhvazzHS/rhf0xiaEXFnxuPgTQ07vGrUZVjMWctddpnHX2csdN
         pdaQ==
X-Gm-Message-State: AOJu0YyT4NGkgoKV8kbiEglMqtgwXMD0/Du0Xx7CYwtWdiAbvSA8l1fg
	AWsKHC1g6bkOyX5IXDyfemWhTZhepSf6bNhlPsolLKdwnhNSD0NzxI6etfz99CEvNEI=
X-Gm-Gg: ATEYQzzNxyppQ2YsnZPF05yICZQdJjinuxGU9EzeoowjelhsA/57wp6+CcJ2d3owczW
	SONcEcQGQqB+X/xIEqmZBAZr9e1LOY8YfDZuJ7ZxSips4/L0zs5IqC+EYSPzwqqQE25CyrkB7tQ
	CVzq7kN20a88VOxNnEkmYLtvzfDBTYhzxi0UKdj5Oq5opgKzAIgQTyvQaz8dwdBIbfVarU0RlhP
	m/GMSECJQwwvTHNhmFoWuWo6RuA8oFiGUDHFha7DbuUjVxswiIqfkq9UT6tUAmk4NfbzwYrwBOG
	tPoF+LmvxoSFwoywUQgufpGTzWuz9tAS3twE6UZO6tOp/IhONbsvQJBd8UYryhh/rfPePiRjntC
	gAI0FDYDukam8uTbPGXJtIeCRGNejTdxxYw3xUzIWqcTBG9nDenNwPJ7p9bzFqrLUVNlBD2Flop
	QW/8tvei6JzA5wb7b/ewPfUOP/USzRsXCeZPiUVfawnwWJkJkpTzETkQ==
X-Received: by 2002:a05:690c:c223:b0:798:77bd:109e with SMTP id 00721157ae682-798c6d00ffcmr5204187b3.63.1772598061681;
        Tue, 03 Mar 2026 20:21:01 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876bf9270sm69852817b3.32.2026.03.03.20.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 20:21:01 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net/mlx5e: use flex array for rqns
Date: Tue,  3 Mar 2026 20:20:42 -0800
Message-ID: <20260304042042.7822-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4161F1FAA96
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263580-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Simplifies allocation. Separate kcalloc and kfree not needed anymore.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index 92974b11ec75..fc71dd72938c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -16,7 +16,6 @@ struct mlx5e_rx_res {
 
 	struct mlx5e_rss *rss[MLX5E_MAX_NUM_RSS];
 	bool rss_active;
-	u32 *rss_rqns;
 	u32 *rss_vhca_ids;
 	unsigned int rss_nch;
 
@@ -29,6 +28,8 @@ struct mlx5e_rx_res {
 		struct mlx5e_rqt rqt;
 		struct mlx5e_tir tir;
 	} ptp;
+
+	u32 rss_rqns[];
 };
 
 /* API for rx_res_rss_* */
@@ -316,7 +317,6 @@ struct mlx5e_rss *mlx5e_rx_res_rss_get(struct mlx5e_rx_res *res, u32 rss_idx)
 static void mlx5e_rx_res_free(struct mlx5e_rx_res *res)
 {
 	kvfree(res->rss_vhca_ids);
-	kvfree(res->rss_rqns);
 	kvfree(res);
 }
 
@@ -325,20 +325,13 @@ static struct mlx5e_rx_res *mlx5e_rx_res_alloc(struct mlx5_core_dev *mdev, unsig
 {
 	struct mlx5e_rx_res *rx_res;
 
-	rx_res = kvzalloc_obj(*rx_res);
+	rx_res = kvzalloc_flex(*rx_res, rss_rqns, max_nch, GFP_KERNEL);
 	if (!rx_res)
 		return NULL;
 
-	rx_res->rss_rqns = kvcalloc(max_nch, sizeof(*rx_res->rss_rqns), GFP_KERNEL);
-	if (!rx_res->rss_rqns) {
-		kvfree(rx_res);
-		return NULL;
-	}
-
 	if (multi_vhca) {
 		rx_res->rss_vhca_ids = kvcalloc(max_nch, sizeof(*rx_res->rss_vhca_ids), GFP_KERNEL);
 		if (!rx_res->rss_vhca_ids) {
-			kvfree(rx_res->rss_rqns);
 			kvfree(rx_res);
 			return NULL;
 		}
-- 
2.53.0


