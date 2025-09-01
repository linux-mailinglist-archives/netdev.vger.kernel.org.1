Return-Path: <netdev+bounces-218935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B57B3F090
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511911A86FA2
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E162927B4E4;
	Mon,  1 Sep 2025 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzxVe4eH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A24B27AC43;
	Mon,  1 Sep 2025 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756762405; cv=none; b=cqbwtx1umxpiOyn8eKUHE2m0SWoCRSBtxlpZETnWUIFCfE6+YtIPDTjRJiRK0U9s15XviAotmTN7MP0m5tMp60PDuH3/k7cfTMWRn9PEV4QaoCrkyAzmjKcogqFqjOwwzCuJoe0/NIZ5C+ZQENXUl2bJ8GWVz+sLrLPt7t5hMC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756762405; c=relaxed/simple;
	bh=dUu2l823rAKlljI+lh82QZgONcoTyLES36Hf7O+e+ic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eWxIuMu20A/Egmh5+bnF5tIKhkGh5oaGfJSZAUyyOipTjSXWULA7QlIE+zLCA23UChQRlKfO2L0aEnGuxITRVdvnvJLt4/pxurZN19G9aq89VaSD0zyQX6xkjqOECwHpGcVrCAnsFYqbp+JVe7ujZ8a3QG3PbrBunEAo4XfBOYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzxVe4eH; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-327d47a0e3eso3156251a91.3;
        Mon, 01 Sep 2025 14:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756762403; x=1757367203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b06kRf6Nb7vVfuK1gZbo8oyR5EkAU/9kCYKfNJjL8Mc=;
        b=DzxVe4eH7fwx7mVyzXYF7psZNqiMXpZdRcUmXl5XdqOOZWrvqkuKik3Khg867bjuS6
         z/WB9/Q8k76hUM7NnLhLWLAkuqYdJq4umamOz0j18ON1MAYraOnnVM8BTiHnTQFST50E
         aaU9Ci4wiHLfL2OG16BdiFTjGTuM1+WKlN4IzvJ2k6xx1lZwz5oZho+/NiVDrJVkVCs7
         ztKgltCRCACQSlxk1SURYWJenuxA6LlN2CS8gtz/unksmcGw43OoEY1l0JtAsA6sDsPT
         nN0yB9YC15C3lXUHWAeg97A2WPFCqRg6Ebqw7H2qyRRtbVRw9mR/HHRrgkacJ9cOwNfa
         W9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756762403; x=1757367203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b06kRf6Nb7vVfuK1gZbo8oyR5EkAU/9kCYKfNJjL8Mc=;
        b=wtL7Iqt0HHiYraGxBHRjbYjgsbAOk5+CY7tsJBY1rIv5syZ2FBtZUqbYm1W+eRs23u
         ZdtTQIBDE8GyAYkuIP/67otDZzY7HOHEwYPtVjUOMP0HGPP/5/DQ+q6rd6zO9gz0SqU1
         5bdmR74fbxHj55/4343O4pmOxBsY7r+nc3n+fNkqOt4rddSeVvzhU3FjBck0nas8FhVZ
         0+ISU0HtZRRgu/ZnybvFc9PyEmJfqIya8Pp9UAtYOadxKx/lp27GTGChaB977s4CqkR6
         YVRaGQxIxDmR+XntD1cOGgz3pp85/5/Fju4EYfeS3yh2nbmyAK6fHDEslYZJOqL119Ie
         u4/A==
X-Forwarded-Encrypted: i=1; AJvYcCXoIe3cKQeP097fPEHHcNe8K8RN5HBM5a6j0LjtKthOaT7+gmKJKvZRMsa4FFqyWubFymNbXhICTPJYAq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN3gvdQxW7K2/wZX9C4IZIairWBYOYUQQyuvrE3U5sfLrim4kS
	3/PpsU7KJnUnkH52kE+BFu2OF6DrVpopRcaG49yBbj1aekuKgHHOlBb1JmG+WQ==
X-Gm-Gg: ASbGnct6kuxqtqBNOSTKREaLyxrAawwuPyyaE2Iuwu2GFfEKJIIXo95psF851DebU6G
	MSExMQoDhY/AAlAbM9sl0hsL11jwhCZEY+5NWsh1OY4GMHmPSE2bocD7353Mztit38JfvvN3y7b
	SMyOfi1kYvNp03FKG0AUo72pC+PA8HvtwHdAZx1SgRqaBxqd8UJoM/WciMsfQcMJB1tIXlE2fV6
	A8LLz1x70/7dkz3A5ofseRsbcP2P3KB8vc5RHvN5z4oCudod17Lkq1imvVWx6xG+RMxGo40sbgN
	I6O2EktbNWmBDfZ7sfxw4ZdsFP3mF+WGWGaNQzC94QTeScczoIFIrYwmuzgzvXQZMnxRma+IC75
	dELujcFWQJy1c2QuYtlfklxQsXgWmn/9RTEBWZSvLQLZY1TyOFZvSnErrtXWh5/1fBBioRc/9hY
	KzvDR2zw==
X-Google-Smtp-Source: AGHT+IH3NMenXx2Sa9UT22IbeL9ZxTctK80eQ8eKKHcZ6sShO6McF9d3HknM7Q2bDxzaFGV3/FbFbA==
X-Received: by 2002:a17:902:da88:b0:248:d84a:91de with SMTP id d9443c01a7336-24944a982e4mr126385765ad.38.1756762403450;
        Mon, 01 Sep 2025 14:33:23 -0700 (PDT)
Received: from archlinux ([2601:644:8200:acc7::9ec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da479asm111216905ad.73.2025.09.01.14.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 14:33:23 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Daney <david.daney@cavium.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/CAVIUM THUNDER NETWORK DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: thunder_bgx: decrement cleanup index before use
Date: Mon,  1 Sep 2025 14:33:14 -0700
Message-ID: <20250901213314.48599-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All paths in probe that call goto defer do so before assigning phydev
and thus it makes sense to cleanup the prior index. It also fixes a bug
where index 0 does not get cleaned up.

Fixes: b7d3e3d3d21a ("net: thunderx: Don't leak phy device references on -EPROBE_DEFER condition.")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 21495b5dce25..90c718af06c1 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1515,11 +1515,11 @@ static int bgx_init_of_phy(struct bgx *bgx)
 	 * for phy devices we may have already found.
 	 */
 	while (lmac) {
+		lmac--;
 		if (bgx->lmac[lmac].phydev) {
 			put_device(&bgx->lmac[lmac].phydev->mdio.dev);
 			bgx->lmac[lmac].phydev = NULL;
 		}
-		lmac--;
 	}
 	of_node_put(node);
 	return -EPROBE_DEFER;
-- 
2.51.0


