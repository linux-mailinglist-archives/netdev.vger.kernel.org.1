Return-Path: <netdev+bounces-248883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1912D1096C
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 05:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 742D530334E5
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 04:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BC63043BD;
	Mon, 12 Jan 2026 04:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3QCIJMv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15DF2882CE
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 04:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768192933; cv=none; b=jJJtu7OOyP0PJ1Z5Q8lmP25EH/KY0PN3cG4aNEJmko+WnkFFtTvTMLeoSQ4TrSu0cGbc7nKcN2u7/Zs2h4guj1Sb+jlCR+KHcr5qfhjCSNgMSmcC5tN3Vdp3fAv1pbcT64iyFLXzZA7gXTCCi1rN3+ZAdUHyDwDJmNXcCU2kR/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768192933; c=relaxed/simple;
	bh=gSP/gOHfZnG50RaSVavpEGROjWx5RAuT7ip/PUEVQ5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OSKtgzxUmdqIM9w5j51Bjfr05rLVb3mXf5WfW4o7P8AdCC/F15TNINXHJKX6LhU7/YXR4QSV4FVak2ZKBUM1piBmi56c89mftzQ4tcwQgOZ3obzI3YfRbryvDC52ErTYCGQzRqNRtVWJaSWXaCXoORWD7He2kMlD7yG97CeQoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3QCIJMv; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a09d981507so36298085ad.1
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 20:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768192932; x=1768797732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EIPM5cCx444nBn0MvLsYoHTfL8W/YpOsMH+8k6GGwPc=;
        b=N3QCIJMv3bgH9d8BrHgkCpPwfArgbEmsfifLPkCSenm+CR1jnGK5xSk0nktMZBSDEH
         9aW1AEMYpeXkU/aTaI8E5MXSVD5QHwHTJhmuoqHiLDgkE5cDukp8SfKcuChMjP0RCEE1
         qdvSGON8r7kJ3KuYj+rN08hqcS4evH/YTFZfy/18MQWHFEfI1UWokJsTdcKVOKl/QASr
         hTTsx+hT20oH2kbHNr2QZC2w0TEFCRPDxMgqgRyxCzMj0rlGKMjthuSblaEVICKwaSwr
         tJP5TxH3EAYDeRK9X5HTPVEYF4NV8gTPyo8V9FuYcNIcrSuLHBuNHBOLXGCaAGi+BxE4
         QQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768192932; x=1768797732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIPM5cCx444nBn0MvLsYoHTfL8W/YpOsMH+8k6GGwPc=;
        b=Uh9V6Kr8CeQoewe02GLXwhw7kF6MBG9mIoo+QKJ3OWZCGTl0vXrJ9txJfGMUJkVMIl
         LHbDSIpJs782uuiKyE0gmzSJwNVvnv17u8SwXil2FXS4dnRK1/IReeIL/JFoFNH2vSZz
         RLZQrKbihJCI9gf7VSyj/eKGtjetiMGZoR+MXZZRJUqktqu4ev+aFXFstYohIfHJuboz
         o7PEu7UK6vFsS/OvquomcjM5IF5R7/0XAAvaxrJw65Ih8JWig4vhhwXBX8u+DANrePlm
         G7tRa6dIcEnmIU+vwv7cbDZg7KkA6GNm+6sqWwPJBJ3PQJj4C4PrDAHn4bpD3XrmmEoD
         0jqA==
X-Gm-Message-State: AOJu0YyB0fGnibP23lOFYgV1t9LnzX04WxRu57hHu5z+oNdO2MioC/Hu
	YLV7f0aWZsqb3nQifaQk9GTnlgnbHX/pBO9K+ekRWU3xBZVNzqmFC6s=
X-Gm-Gg: AY/fxX5SinRFYKxXM9gFRdfBKoTy+4ohfXD2xLk67vSRkzfiaUimnyx4tTX9gHkskUi
	13M8+HJmPd+DqtAxPvV9LarZOUUAXsho+QkvqirgHTO0L9Y/TgtYaHkVw4SLXOdzVSzBv6IwEV2
	SnigEkhruqvIMCp+U69Wrikx+Yepja4DlTt5Y98bHAxzMvlz+s/MdlwRbuSKxaHaMoiLmQAKiB8
	e3YMq/sYqllF3XU+q4o2OjJncN4eSt0O35tlTRl9XawMu49CdVp1m4//1nmYoSK6+ks7JUk8EwY
	ySzlp+vs81fC6b+cWzDKH0DoxPS29azigaPWH0ku88ikdXGXl6UMOlyTiLN4efdBt/vvBFRff7I
	9uv++pfZIP/O0LTJgLzTCgK7g00zgJT3yNUHLCZLQSDESkXfIjxVmvgYbDTWeE+XJfwLTj9zyZO
	33MCGtBnl7fHXKoDFH/ck12+Syo2nGyQ==
X-Google-Smtp-Source: AGHT+IEzuN7aNtn1J2FG5qZS/N7WMbBL2GDIYWYs/IyqTtYi8PseFK1ZsKILx3DgykynShtWDppx3g==
X-Received: by 2002:a17:903:1ce:b0:296:547a:4bf2 with SMTP id d9443c01a7336-2a3edba6a48mr157822475ad.27.1768192931941;
        Sun, 11 Jan 2026 20:42:11 -0800 (PST)
Received: from localhost.localdomain ([38.190.47.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2b4dsm164011585ad.54.2026.01.11.20.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 20:42:11 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: bh74.an@samsung.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinseok Kim <always.starving0@gmail.com>
Subject: [PATCH] net: sxgbe: fix typo in comment
Date: Sun, 11 Jan 2026 20:41:47 -0800
Message-ID: <20260112044147.2844-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a misspelling in the sxgbe_mtl_init() function comment.
"Algorith" should be spelled as "Algorithm".

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 drivers/net/ethernet/samsung/sxgbe/sxgbe_mtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_mtl.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_mtl.c
index 298a7402e39c..66e6de64626c 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_mtl.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_mtl.c
@@ -25,7 +25,7 @@ static void sxgbe_mtl_init(void __iomem *ioaddr, unsigned int etsalg,
 	reg_val = readl(ioaddr + SXGBE_MTL_OP_MODE_REG);
 	reg_val &= ETS_RST;

-	/* ETS Algorith */
+	/* ETS Algorithm */
 	switch (etsalg & SXGBE_MTL_OPMODE_ESTMASK) {
 	case ETS_WRR:
 		reg_val &= ETS_WRR;
--
2.43.0

