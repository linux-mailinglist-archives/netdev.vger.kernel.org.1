Return-Path: <netdev+bounces-134228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBBC998740
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0B06B2625B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327FE1C8FD2;
	Thu, 10 Oct 2024 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5inw+6+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751761C6F76;
	Thu, 10 Oct 2024 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565889; cv=none; b=b6WmyI3xDIgEqDFiAD/FfPElOcmgpu08kjQKx9TQM+MnkcJ+4f7XsQZgKvDyDUk8j5F7TQoJ82EavXvmUfpambtPYIHrOU4ydaWEQ5abM3vPUl0aKYmwWgdpwlEqTFdzZxV8cGcwYYYMKzxpRnrtIk16KhHn/nCPA8wLlIUIkD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565889; c=relaxed/simple;
	bh=IglgbHRjhUSfOQlT92qpAWChlpTrkPBOSqCNLG6Lse8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rK+3kFpC+9R8r08OWmtTmIOKTYCjl8czm6MZf3XOCR46BEZ5iIycXGJk17dCmVayo94Bx94brQKtGRiCm5gLd5Vf5o4j7fIzYt5IBEaGPviW9l7E3q8rUi1sppYLNrZ1VFZnLVBlMLPIeMcIIIVy7M+9C56YOAC7pnmlSiWL53M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5inw+6+; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5399041167cso1424490e87.0;
        Thu, 10 Oct 2024 06:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728565884; x=1729170684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b82Aus5yQF7fu+hcCctT8VXV2Zx7u+Vxmum8cj0Haxg=;
        b=d5inw+6+6cFzR6a5OfCt40m9FE19ieAsy1mtMUFv5CRFb3GFAoi7GIpn6uoVZlrIX+
         md+bkSfgN3H9PEzedLisKUBCpUTyWZuUpaguS29teli6C59NBR1//24hyyCMcGrf21we
         GX7DvEuom84nOPc3P9kmzZZDEpFWokqV+qmlri0pVKybCRD5qtowvHFgcA2fufjZKf7B
         WnBKATpB8mtzy7e+nwIk5lEe+5mLSxFD5ycgXQnXfe2XqUDQjVdtlU1lOyAEVFDyEBrw
         8RA7dOPTpoC1c0BorH8NOtvOEhpdVogAQvtj71zdfIljn1AB/rM2q95SNPGGWQXcTZrb
         x0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728565884; x=1729170684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b82Aus5yQF7fu+hcCctT8VXV2Zx7u+Vxmum8cj0Haxg=;
        b=ElOVA3eKpAwSMrZKkYgyh2FPPg66l1q84J1rzBlwUAOtr5OI5XF9KaNPPRjQsaYdYv
         wdRHhVThpeKW2DDOni17ohEzTLir2GhOD+mbTpqBkVtEUZHmnpjNZiMUB8SOvm6VpX/P
         KAzvTnz9HBx6lp+J+bHUkLozFeS7W+e7tyC0SKxtwgL+IcIK0K5CLMZzjx82Yv+m5TW7
         tiZxAzeUc1jdmDIjS6TBeR6Obi2nf7nPplSO/gmjI/tvcNgcJz0oSz07OJzPzaZREju9
         D/NBQJL0bYEobOwG9+sf3U8oHn5ymNu+KFyrYo/Zn9fGedNv1En8wJeZl5yuV7YGKVA4
         Or4w==
X-Forwarded-Encrypted: i=1; AJvYcCUKuMc2nWTzN7oXRexzM3IXh76I4IIGa6M5PtcrVzOVbkbciWnt6MbbnePQlfdGTwMHWxmdHTX+5xEDvog=@vger.kernel.org, AJvYcCVmXvHffKL92Pke+y5/Nv/rK7F1CtxYUlzcjcmfR9lruYU/uhQiCmvV5Ly4NHBqfmKA/Ml0XwfY@vger.kernel.org
X-Gm-Message-State: AOJu0YyvWrcJ/36ATb1noBwZTu1gVNgxLFBpoH05vDoUVoIq5khWPlsv
	DGU6Wte9gh4Pr2TkP4NuktDBtFFctzTBCT3pZKJS2Q7V6qxfE9xz
X-Google-Smtp-Source: AGHT+IGn++pLa76YEUOfxNoXXWxoqjBWGOBOrgK7W3R7P75fXxwvpyYZWqGPdPwFUhfwJIfCRkwTxA==
X-Received: by 2002:a05:6512:280a:b0:539:9fbb:4331 with SMTP id 2adb3069b0e04-539c4967f41mr5717675e87.54.1728565884237;
        Thu, 10 Oct 2024 06:11:24 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7ede920sm87476966b.8.2024.10.10.06.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:11:23 -0700 (PDT)
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
Subject: [PATCH][next] octeontx2-af: Fix potential integer overflow on shift of a int
Date: Thu, 10 Oct 2024 14:11:22 +0100
Message-Id: <20241010131122.751744-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The left shift of int 32 bit integer constant 1 is evaluated using 32 bit
arithmetic and then assigned to a 64 bit unsigned integer. In the case
where the shift is 32 or more this can lead to an overflow. Avoid this
by shifting using the BIT_ULL macro instead.

Fixes: 019aba04f08c ("octeontx2-af: Modify SMQ flush sequence to drop packets")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 82832a24fbd8..28f917a37acf 100644
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
-- 
2.39.5


