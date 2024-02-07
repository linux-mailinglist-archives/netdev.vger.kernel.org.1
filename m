Return-Path: <netdev+bounces-69991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B38284D30F
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 21:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253382815EB
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8551B942;
	Wed,  7 Feb 2024 20:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw1FFVBB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DD11DFF0
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707338017; cv=none; b=R8gACTEZWHfPchzVmRBsPi/xaMbRbQ0I0Eg0kgKZNXPSCN1frkSMMPGKFBZ9Dx/uBHlNmEtI4EaYyqr/KNlEUKkUhggvaRMlnST4WrY+XHdOqi2Bsve+MPBJBGfmw0bFtKr7kXhTd661Lh9b7nBhiimG7hW713DknCjt5Ztlt/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707338017; c=relaxed/simple;
	bh=5YoJ0JFcTWPovnx+WEr3N/HHn5i26ZVl3TcLqwoduSc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N9iBhPKbgK6Ns5ldyS8wJURzU8kiD0r/YaUTJeg05Uzfc7RTYiMDL7NarQAMzLS7FPEvUXC74FGI97rWEyud6hS2dqLeoRYsmJpQLg1O9g4U/JLQpC9n64Ef7ieFdBWRa6AdoalHfdHOHqSML7y6K3Rr6RzwDFjvE/8NEtEP4d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw1FFVBB; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d04c0b1cacso13657981fa.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 12:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707338013; x=1707942813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yJ59vd7uJpngZqrdqCnRfnOwReAMdZCrFP/3628XWWQ=;
        b=Rw1FFVBBAOyc5Ekl/3TMOhQ4pDQvjS36ZJ0O002ZqCE0gX3Gt6gTgZM2DwIQ83Cw8I
         THV/IVesFW2Rf3eEWtyj+EWmofy5Nzh077/xIVS1o19AjEDqEIwlXxIXIR6qjGj39Tsr
         Qt0KOESM8yXHK9zHUyiwD6MbcGoS8MyKWW92QanCT1toSLAKnlTST8uBw/pObnicaZjT
         sD2KMjWYZU+LN14tiratFFh59GeFU6Ui9goOH3XmudRwxp7wCl0lXHYeUEZA5+PTei8Y
         3PPVZRC+5I3DsE03OAcPxbfuvFmBSUx/fgmV0NAloR5qSmHFGugUueWKBFnlK6ohvRPU
         Ewcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707338013; x=1707942813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJ59vd7uJpngZqrdqCnRfnOwReAMdZCrFP/3628XWWQ=;
        b=K0eUlDHbF/BFWs3Libu79W7lyUv77Cx1enOdvuDw4VAQJgzzVG2SfW97mgf/rOdOeE
         GFKdiNvSZOCpw8Hj13V2leocqkIWGB70vGuPT6O3Hs008nLsy1oOwNx1d6KStWZRB3zn
         /7h0+blrYaIfnzoqiaUGsGTRc8HIa30y+d3UU10lNUOHHPP5ucIVh7nBntCfUW8XiZm8
         55zCti32Nz5Ha2vZVtCbLul76jx/EOHQjRrrdsmN9Bar34qmrAOanEMHT67uBIYHlz/W
         Du7XxU/UZRg1cFeFmlLIqh5+SKJt/dQ+6YBSE5lGveTDwRtko0SvpzlykROYqN/6Dbzh
         zZpw==
X-Forwarded-Encrypted: i=1; AJvYcCWYsljhm24OqC2gwl9UGpAsMFZ8UzHiKozhvqLfH1NN9vd4N0W+bB/YLe/qsPFuZvEBC35DiZcQYKZhv/8OGtY+ir08eduo
X-Gm-Message-State: AOJu0YwTai9J91HnA1ptXiB8TFuTXWpXxs/sAJA2ArFEkO02WVipcI+t
	jBjRCLEiRgoJwNXIzrZtyWFvGKvc3NOhcHfoV3jCiDCo9v9nICU2xqkNBpS/
X-Google-Smtp-Source: AGHT+IHgikFkgSNzLmV/2iGvV0OLo7qZLnB2WuYBQSj1nvGTBNrFywAVlR4W+QitN+wSfexPlm+pww==
X-Received: by 2002:a2e:a16e:0:b0:2cf:127d:a79f with SMTP id u14-20020a2ea16e000000b002cf127da79fmr5066303ljl.51.1707338013357;
        Wed, 07 Feb 2024 12:33:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW9IZ9JKpstQtGx8n+tMM52Srx0drcOElU/9niDkGyoxoTXFUDVdWLJkiOtO+fFcamuM9fblXbgD1wjO+HAWzbl++F5ixY6
Received: from mishin.sarov.local (95-37-3-243.dynamic.mts-nn.ru. [95.37.3.243])
        by smtp.gmail.com with ESMTPSA id y20-20020a2ebb94000000b002d0d22ebde6sm39646lje.92.2024.02.07.12.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 12:33:33 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] ll_map: Fix descriptor leak in ll_link_get()
Date: Wed,  7 Feb 2024 23:32:39 +0300
Message-Id: <20240207203239.10851-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found by RASU JSC

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 lib/ll_map.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/ll_map.c b/lib/ll_map.c
index 8970c20f..711708a5 100644
--- a/lib/ll_map.c
+++ b/lib/ll_map.c
@@ -278,8 +278,10 @@ static int ll_link_get(const char *name, int index)
 	struct nlmsghdr *answer;
 	int rc = 0;
 
-	if (rtnl_open(&rth, 0) < 0)
+	if (rtnl_open(&rth, 0) < 0) {
+		rtnl_close(&rth);
 		return 0;
+	}
 
 	addattr32(&req.n, sizeof(req), IFLA_EXT_MASK, filt_mask);
 	if (name)
-- 
2.30.2


