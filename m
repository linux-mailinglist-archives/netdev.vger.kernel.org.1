Return-Path: <netdev+bounces-135625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0339599E946
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC21B1F2151F
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7A21EF932;
	Tue, 15 Oct 2024 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1VK+X9i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642CA1EABCC;
	Tue, 15 Oct 2024 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994411; cv=none; b=T5gDdn0VzdZ3bh5AHyV2LFmEiRmLvNb3as0MxGj8BhCDkB7PjObtjXoYdl4vgBFrmlsPwD4HOcTKkc9raudV7rdQERJBH5VPt4IxdfaKHynV1nzal5w3tGvlbDZgcoTP5v4aNCgIwQZFKKqd1yuImu1zhMfBX7qRK29lllrhX40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994411; c=relaxed/simple;
	bh=KXWCJOpbHpL9DIZ5J7xh0XTLCqFDtsOZ+XU1CgD8GPU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UOP4JqFQBu4AyfoAq/3iyr1lMydxUrbSRvbqBFIRs6qAx4ybAE/2Voj8895d+FBcWyojkgbnGJ9cdEqVvf6N6KEDLdxpLDQ/TJCRJpD4uT26kXHH4Hq+X3g/f/v6GS5n4xOTDTrt0PFmaudoeeFYQIPgZN/aU5VZZXaHTOvS5m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1VK+X9i; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5e7e1320cabso1858751eaf.0;
        Tue, 15 Oct 2024 05:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728994409; x=1729599209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pCA2dSjig9QjhuM6n0is+Pu4ptTOUVUC6+z7okb0WPo=;
        b=H1VK+X9iyUJI8xGDD9N38lph9HmLhjk24+INSsSOIhu97V9cQt2C2bkdzH5k4Zh3nS
         zBF5x7kS+2D0C5He0dP+bem8aCZKksGtkalU0PtDFrj/f1xkNlGQy8DHrrn62XoWgPUz
         cxmDJIvgn3X7S67jL/hqqiz+pYp8/qY0yuvywGN7IfbhJgY5zl362y1tzuWshhBKjK8V
         F5At84/2Og04wg53al2Ws5nFKqgxAOtq6MMzLkCNIrRaGY1W2h4TvXQ7MUeoqjYBo7Jf
         +DblqXJGCW8oV+qPjfKfwppbRGGZAsZzU1vwPzyhFj9+ck50UT1AWabIusRrR0AbM8zs
         zMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728994409; x=1729599209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCA2dSjig9QjhuM6n0is+Pu4ptTOUVUC6+z7okb0WPo=;
        b=oucAwDYiAZEoBvdGhnSFZx6rOZ0PkYY4r8vfz3LKvxxp5OKwKmk9Rtk8wbOh+tdr3j
         x8AF2iVsR6kgGA8T7jQPeuEVEXep/w2WuAylEJnXgkXf//BxcLFy9yRa8paKP4YXMCKh
         S8JwjjJDegaNpARuGl5P/l/8ukPyHKaV6Ve/S7ri2dElyBVvihFrTxpYk83NJm0haTuR
         OfEcRh51GtP7wf3hvz8uoYQPy+h0HlK+MgMCm9gw8YpF1Fjb4XY1zQ6B9+CZBu6l5Edf
         jY60lVqdtLK/XlxsCc3+0z2zFa2Wsogx1phbDzyImYSo76vCOEtpvv8DVHsMh2ZznRFz
         P0nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZY2/y+30rfsjjI5QtMcA3JA4T9X0XmcJLSWMQKH70eB2WzmIPeFNJmikggbcOoBURbY3GoOsb@vger.kernel.org, AJvYcCWqEjPV6/VC2gob6eG8OTxrP6j73lRpagDfOs+I6w6LwYiED8HYOkZvo3HfGFHXluyfaQep5tZbcyJsYU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAwG2yULa/JAJVQZ3PFQ8lHoIn+IBma8Pz4tpLhJkLch37H44U
	XU4PzLV7TCuZ/fjhzHF6pvMhPaQYZYlid/rDXaG70+u7oF4WstFwfxzoLDwB
X-Google-Smtp-Source: AGHT+IFPkOyYwKlqlonc6AecyXi5LVJvxeKZb47a5nMJmH80bHoTjjV4mLMp38pzBiftIDpx6dPrdA==
X-Received: by 2002:a05:6358:7603:b0:1c2:f910:c2b3 with SMTP id e5c5f4694b2df-1c340dd2636mr92620155d.21.1728994409342;
        Tue, 15 Oct 2024 05:13:29 -0700 (PDT)
Received: from dev.. ([129.41.59.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c707839sm1179839a12.69.2024.10.15.05.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:13:28 -0700 (PDT)
From: Rohit Chavan <roheetchavan@gmail.com>
To: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] octeontx2-af: Use str_enabled_disabled()
Date: Tue, 15 Oct 2024 17:43:00 +0530
Message-Id: <20241015121300.1601108-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 Use str_enabled_disabled() helper instead of open coding the same.

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 7498ab429963..5d09cb56e67a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -1251,7 +1251,7 @@ static int rvu_af_npc_exact_feature_get(struct devlink *devlink, u32 id,
 	enabled = rvu_npc_exact_has_match_table(rvu);
 
 	snprintf(ctx->val.vstr, sizeof(ctx->val.vstr), "%s",
-		 enabled ? "enabled" : "disabled");
+		 str_enabled_disabled(enabled));
 
 	return 0;
 }
-- 
2.34.1


