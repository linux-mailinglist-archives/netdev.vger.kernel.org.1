Return-Path: <netdev+bounces-134319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3B4998C3E
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3371F21274
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EFD1CCB59;
	Thu, 10 Oct 2024 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpjEzUaQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB46E7DA62;
	Thu, 10 Oct 2024 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575130; cv=none; b=LOP+hhB/3+ZeqLn5CE9eOr9BbBO4e51vIP/2+tOekGbc9wo0QR8BqP6r4Ze7dKlYWFtTYqztpxD2rR/BY4wvj9XWF7ZQtABY/UWVAx+c4a/YCJYQ8qJ0QAMdjUN3kryIudyfqgFhjv4+y0iqjCL2aC1MzIWCqn5rpAKb5wzD0ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575130; c=relaxed/simple;
	bh=FaZgrYXc5o2/CBC9caeUU0JWFjKlCFfVDG+pD5/WsRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KKzpVbdc3B9QG1ArasfnyYv7wve+E3m0ohlPiCb6ZKGytRLdgZERase1nkSyml1ptsasr2LsKIh8uP2czouWYcY9kBQURsG6SgGbLBa2hI7c2umYPS1qlZnu+aPbWv+TiZGUQo/DJ9SfmhRMKqQClmiTP99eAArrYsJuCiYga3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpjEzUaQ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c942815197so276363a12.1;
        Thu, 10 Oct 2024 08:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728575126; x=1729179926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jTc+I2w2hhlqIY2pAipx9CwfTckiLBy2dTG4NBsK3Ek=;
        b=hpjEzUaQrRy9xTK2WEfINKwK5BrIS52ZDjAAUEAxyaG+zZ4Dep/66dxaoGCfXkp7EJ
         YpZ5b2j1XrCJtepvmcGVAQBY6e8iVdDGuZ4vn9M4RiCrMv1C6j8dkBkwJQ4pkoLL0xdH
         bilG3fqBw6Y9Vw/FVMN5pjnfY/tTuc7FjbrojRIOR+lH/grAGUgwEYF+tMqeFfryJz0K
         vcbxbmh814VJCA8/lxzoKmJtsd5nZVvdvXUgMfRoNH2mmV05aUufakPsk70wwK/2eK7e
         klmA+rx/McD6ynrsFAu8O+jSSQ6Mlf9nmRnZlqUO0wH929rNAIBq/NktpyrN6TxP9TKN
         FcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728575126; x=1729179926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTc+I2w2hhlqIY2pAipx9CwfTckiLBy2dTG4NBsK3Ek=;
        b=jNBRQ+npVXc+9WmZKHqhhL3QYB8GPeLJxgIFLdsYEM38JpEiHXtx1G0fvlELedaoYl
         9ac8BX4EOYNUWMhSiEtm5uH/nqP6LSNE40NsVNSKGltoiVJ4c0zvZp8j9BcymE4ezdAj
         8p3Vu526g2pOC8F+QQ5furFdptJX72RQCDfz+KSW2P8PSB7/YddNNaVtu397GUeDYaaN
         sEO1W+IGuGhdWsgt0h3r0quwMm6h732Ia/mprVcngQzMQD//HRxdLrZEcMto9EFof2OU
         QYDxjoy9J7mfVTbLE81mmU60uwnlhhFITtrJWGD7EmmVTAsE5G9FZ6VR7fhw1ZPhKBwS
         VaiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdm7+r6Slfm5scJoem2MbN8FOaMQOce5oCQq5xVUoSYkGAPjO9p+w70rFQGWSqD0UifdMswSlhVTGZ9rY=@vger.kernel.org, AJvYcCWIK8YlrQC8TCfYhxP0Bn+mzXaaNJ/S+PQA/RGdopKLiS/xb+q25dhYzuU2TNmX262FzUcuz4i+@vger.kernel.org
X-Gm-Message-State: AOJu0YzF1/0EiVOGVsqlBFgnWj8PVZXCZXbk9ujnPlAlnixgqjvikNPL
	8ptGBCHkNd/apxBOysC4sns1DIbzQfAOhLqyHzQHQ/6JyftSmo1j
X-Google-Smtp-Source: AGHT+IG0jeJWdLIT94qSOZbGLGB2k9FA+DbhnpHm3ocn7eFqBjG5DNS6xpG0tUS62GqJn4wkY/nnVA==
X-Received: by 2002:a05:6402:510f:b0:5c9:21aa:b145 with SMTP id 4fb4d7f45d1cf-5c921aab83amr6135256a12.36.1728575120295;
        Thu, 10 Oct 2024 08:45:20 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c93f78a671sm708180a12.55.2024.10.10.08.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:45:19 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Naveen Mamindlapalli <naveenm@marvell.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] octeontx2-af: Fix potential integer overflows on integer shifts
Date: Thu, 10 Oct 2024 16:45:19 +0100
Message-Id: <20241010154519.768785-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The left shift int 32 bit integer constants 1 is evaluated using 32 bit
arithmetic and then assigned to a 64 bit unsigned integer. In the case
where the shift is 32 or more this can lead to an overflow. Avoid this
by shifting using the BIT_ULL macro instead.

Fixes: 019aba04f08c ("octeontx2-af: Modify SMQ flush sequence to drop packets")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---

V2: Fix both (1 << i) shifts, thanks to Dan Carpenter for spotting the
    second shift that I overlooked in the first patch.

---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 82832a24fbd8..da69350c6f76 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -2411,7 +2411,7 @@ static int nix_smq_flush(struct rvu *rvu, int blkaddr,
 				 NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link));
 		if (!(cfg & BIT_ULL(12)))
 			continue;
-		bmap |= (1 << i);
+		bmap |= BIT_ULL(i);
 		cfg &= ~BIT_ULL(12);
 		rvu_write64(rvu, blkaddr,
 			    NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link), cfg);
@@ -2432,7 +2432,7 @@ static int nix_smq_flush(struct rvu *rvu, int blkaddr,
 
 	/* Set NIX_AF_TL3_TL2_LINKX_CFG[ENA] for the TL3/TL2 queue */
 	for (i = 0; i < (rvu->hw->cgx_links + rvu->hw->lbk_links); i++) {
-		if (!(bmap & (1 << i)))
+		if (!(bmap & BIT_ULL(i)))
 			continue;
 		cfg = rvu_read64(rvu, blkaddr,
 				 NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link));
-- 
2.39.5


