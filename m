Return-Path: <netdev+bounces-128397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3695C9796A9
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 14:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF283282A03
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 12:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5981C57A6;
	Sun, 15 Sep 2024 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AL/Bsuj4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB40184E;
	Sun, 15 Sep 2024 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726404740; cv=none; b=ntOWvgPtpPUR16cM5k2EMxd6GzZOeGhgVdxIOkzGXaALmj8o12ypUGRIyJTCB4SGe9smunHycFKMRRIkd6KnqoTHuESTrjRKM/vJMDzA/EW0vzLW8ZF8Lxf4YeyfevwxLgh3KpXZiSW6UVeCYTQvAAyJ7DjVgyGiOdZdljlpBo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726404740; c=relaxed/simple;
	bh=UD+FaTe/XS6BZJvtZd3fLAHoxC9hPqHBX2elpi9dmww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cBnH0/Nk3teVyQ+KWPXDdT4NBNoy5aUnHw/14zr0OZacbyz5TQaTqiVgcxRXiz3MSxe5411TCEKVsLHfy048WoGZEQflWtKhv2V+HdWeT3ef231ivLmpb44JAVouEhKWHdJa509iytu86mUmuiNGLYpBdhicvmeseiI7Xt4T9Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AL/Bsuj4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so35001025e9.0;
        Sun, 15 Sep 2024 05:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726404737; x=1727009537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CSOs8W1FAJEI0MCh2EABTXHbZJkcnbnhZeBAaKLM7nU=;
        b=AL/Bsuj4WZBFvn1JCdGLRDc+UAr7QcwT5XKWaFZle/ngOzKLOde/KXuuyFiihP520x
         doGAbB0g1EJcOXWp2pcwy8Oqr4i9BYCo4Tm3Sxpwv71ONFMFS3kJpERCsxgoKEFBO57A
         HGNfW9lJKdkpqGMFL7smP/Ms3ixJDBo6hQhKI7FQ4tJ3YKBb/6x/LGG1PZMLypaW9nj5
         ZPBkv++ozwKNbmzIdN5Mxu0yIUQB9eLrJ2u1/243V8T929FgcEXJ7sY/Vo84nNwa3NZp
         sWrYfJG2SfgYKE7GhY8QTmboalmDjEOStaplKmvNuaJPIDTPjobZ0jrDPrEAOPgraZD+
         BFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726404737; x=1727009537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSOs8W1FAJEI0MCh2EABTXHbZJkcnbnhZeBAaKLM7nU=;
        b=rOhqxIzKnbt7KKYaUV6LXX77QB5wVNTJdO9O1pNFofw1H5mis9RgOCuqqH8q/fT8E7
         vlsfBqEuJDC8J89+peVvGZhWQFNe1Tx47cKpiuKcN4o97cIlQc8/fkmchmT6c54NYebs
         1NMn2txjFX154GhOK1NK6/mRUWJnPTklV+22fHNu057v4x1wecNHApsVl5AgSipndywN
         IezdPOHvFtYmsg0xeqZBr40d99RE4/umxMKU0xJRMoCLjURfySPG0R+4gwIm17Cpqtv7
         1hFJhezb2v7AsDWco22cmDNoU2rCCWVyL32jT7l8eQRBqLk2lsIOfqDVs1PUDlhtwaHz
         lokw==
X-Forwarded-Encrypted: i=1; AJvYcCVUkwD7h4N+fVBJbWaJvCCTrPFNsXnOSbe3JHEVRsFO2l6rpeEcgSVqs0vpQ3mAhlCEkKq1+KUc5Vj/Km2V@vger.kernel.org, AJvYcCWhD9G5iZ9kTZ5TGM5k1MB2msOlpLEOaxcujyw3IeubBuX+1AO3b9EKbjxUrjDK8J2r7xNoylY6X44ZLoCR9y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8JO41VLFM6Xr5nrFMb/qm82sEHfBvR/C3DGHtQx0nkjg8YIUI
	NTd1m+ENlkG1rYZCOw+oNXWtTIra2vlvbzIiLjlKxYMiIy7bsD4n
X-Google-Smtp-Source: AGHT+IF8MKtgOrHnS3QqlOowMhjeIVw7D2zOA5gMTQlJio7smcc/kN3ZPm5lrm404ZVDP3NNZeAqeA==
X-Received: by 2002:a05:600c:5489:b0:42c:bb41:a05a with SMTP id 5b1f17b1804b1-42cdb5789fcmr94458055e9.34.1726404736632;
        Sun, 15 Sep 2024 05:52:16 -0700 (PDT)
Received: from void.void ([141.226.169.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f99ebsm4622911f8f.63.2024.09.15.05.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 05:52:16 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] ethernet: chelsio: fix a typo
Date: Sun, 15 Sep 2024 15:52:04 +0300
Message-Id: <20240915125204.107241-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h b/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h
index 4c883170683b..ad82119db20b 100644
--- a/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h
+++ b/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h
@@ -49,7 +49,7 @@
 /******************************************************************************/
 /** S/UNI-1x10GE-XP REGISTER ADDRESS MAP                                     **/
 /******************************************************************************/
-/* Refer to the Register Bit Masks bellow for the naming of each register and */
+/* Refer to the Register Bit Masks below for the naming of each register and */
 /* to the S/UNI-1x10GE-XP Data Sheet for the signification of each bit        */
 /******************************************************************************/
 
-- 
2.39.5


