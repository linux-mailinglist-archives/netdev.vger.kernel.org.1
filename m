Return-Path: <netdev+bounces-142999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9E19C0DD8
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF151C22FC9
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851432170AD;
	Thu,  7 Nov 2024 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="I3mmtVAr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f226.google.com (mail-yb1-f226.google.com [209.85.219.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62EB1DB350
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004303; cv=none; b=ZcWW4kR6o41I5bc7ic/TT6HwhubaLWjsjiY8TXUsWKq2PugQzRUmr0dApbAeEdI3yNJKx6THx4+/O7TaNnMa89Wse2C1feY9eOSqElcYfI4omTfHwW5Rm6sgOZWLJnm1fbAlGg9+ILqLVQntdeD1McH2fJIv/zrdMFvlXjc7uKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004303; c=relaxed/simple;
	bh=vb2oy9sCtacw/TXgOT7kaZXJblOW4SHOKBYJ4mHT4RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M14msTHTy+UEMiWZ9bAkvOQzV+0drfAoJULbHi4rCkAZsJ85AD+pnWjUjiiy7HR/Tm0t696kXxe6IkFHwMR32GjQf7eQ27zlWY3a8y9DY8d4Xk6z5ea1/d6qMV2oHpxQf9f1p5k2qhzq9/uvuTOYuKiclS6nebWu3JrpYOq7KnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=I3mmtVAr; arc=none smtp.client-ip=209.85.219.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yb1-f226.google.com with SMTP id 3f1490d57ef6-e2bd1bbaf03so198323276.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 10:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1731004300; x=1731609100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Up78lUxvH9q9ucvQFWkY0ZlRiNJvCC25wLA/XPV5mzI=;
        b=I3mmtVArg5JiIGWdM+enyHGpiKuFJDKGMIktw3AlQmIUH1S8IVBI/zgzShqmIqnOHz
         1RBDam4e8K375p17dFf8xb2mdEu0nQ/CkWiaTtadnxqwNMD3+PWNkdvJfKKc6M1FY22L
         JRAja/HNNfBvXMiAN3vWCx6/rrgatMmyaQVeHh03xA59lCMxMz4kNHu8YwQIUzRQSjhD
         ZiDJYrq8pud9gvMGRjzYJsA+tAint2QByUDnPKblFesSaNGCVTv8RZenJQPDAsa59v4D
         POVQyAVNJDuBrUiRkiVSVylpW/cT4wydGh6Uqf05+tLp7vQQM0dZbTIgj4mnAkXTsg2M
         SC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731004300; x=1731609100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Up78lUxvH9q9ucvQFWkY0ZlRiNJvCC25wLA/XPV5mzI=;
        b=p/4SsZX9tejyoOZCR4rhtSpMN8m1iJgrH09J88oMhaEFS5cuy8TEZnsiB0tinvzGN3
         hOeKREFiSv4L1H3q7MoxQ+8thCtcFEFar+BaQf9XKYcXriwYZvemZBHvXbu/XlHrdTkF
         z/eQUtM8nyx8dabNtACqZawd9PnSAh/r1H7nbGEv8r2IynB3dNlrvH1oabldBenshSjP
         4tKi59cUddh8Tfo9iLOoQWl44ieyhI5Wo8tXS9Qp8JZysduEQ0/4QInoqvrYVBu+HgKz
         BKuN4eXKz9kWaR0cJb4yNTnusMCGblIrtlPn8Y2jnY4cpwmOxT9iO8+W7N6j6FNHMPww
         ruIA==
X-Forwarded-Encrypted: i=1; AJvYcCU1i30HSV+Wl479vkrFdZSWKii8b7ztOaPOHEbtPRMMv5sVO7FckjOzwkLgEi21MikSRLo1NtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgi5wErWPwSX+EaUpPYmBCJox6C2y6OfwXnGPytYPo+rlXdbp/
	7OkdTaIHqvTjYrEFLRJtzDgE02Kf7WE66AjnEaOplO39k6ypFRI+XKOJUl76jBKYlt4D28xDOyE
	YRUafWbZx3MQSGSZwdhRCXZf8KVsj6VPG
X-Google-Smtp-Source: AGHT+IHkNn1fUaPKRrk4GNrGShUQeVPPntfaW5wXlnQMhTdZSLEcd0EO6uh8H27y5Qp0Bw5n86Lhjh9hr0bz
X-Received: by 2002:a05:690c:6f05:b0:6e7:32a5:6566 with SMTP id 00721157ae682-6eadae3316cmr5535257b3.4.1731004299727;
        Thu, 07 Nov 2024 10:31:39 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-6eace8f1da7sm1104997b3.19.2024.11.07.10.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:31:39 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 1FF783401E5;
	Thu,  7 Nov 2024 11:31:38 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2D9ABE40DC8; Thu,  7 Nov 2024 11:31:08 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] mlx5/core: deduplicate {mlx5_,}eq_update_ci()
Date: Thu,  7 Nov 2024 11:30:52 -0700
Message-ID: <20241107183054.2443218-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107183054.2443218-1-csander@purestorage.com>
References: <ZyxMsx8o7NtTAWPp@x130>
 <20241107183054.2443218-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic of eq_update_ci() is duplicated in mlx5_eq_update_ci(). The
only additional work done by mlx5_eq_update_ci() is to increment
eq->cons_index. Call eq_update_ci() from mlx5_eq_update_ci() to avoid
the duplication.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 859dcf09b770..078029c81935 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -802,19 +802,12 @@ struct mlx5_eqe *mlx5_eq_get_eqe(struct mlx5_eq *eq, u32 cc)
 }
 EXPORT_SYMBOL(mlx5_eq_get_eqe);
 
 void mlx5_eq_update_ci(struct mlx5_eq *eq, u32 cc, bool arm)
 {
-	__be32 __iomem *addr = eq->doorbell + (arm ? 0 : 2);
-	u32 val;
-
 	eq->cons_index += cc;
-	val = (eq->cons_index & 0xffffff) | (eq->eqn << 24);
-
-	__raw_writel((__force u32)cpu_to_be32(val), addr);
-	/* We still want ordering, just not swabbing, so add a barrier */
-	wmb();
+	eq_update_ci(eq, arm);
 }
 EXPORT_SYMBOL(mlx5_eq_update_ci);
 
 static void comp_irq_release_pci(struct mlx5_core_dev *dev, u16 vecidx)
 {
-- 
2.45.2


