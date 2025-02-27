Return-Path: <netdev+bounces-170344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E41C6A48479
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825DA1892B00
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB9B2222BA;
	Thu, 27 Feb 2025 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMMf+ygx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA64B1DE3DC
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672267; cv=none; b=oCHaEKA7uCTu5RK9xQYSRGc20m4DdyJ//YDfXze2zcQXQl8A3s7xsx+y7FndmD9Wh8FTA5mXHCo9+kulYJfa+W7JS1s1GIELg/Hw6EMUbKYQuK7F9Nw3luqD3Py4j1a3dedB1stdW4wbrEfC7FrGzMEC75ZUjX7ADNnCG37ZRtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672267; c=relaxed/simple;
	bh=aQ5XckA8vTqXPTypuwSjzIG6pSFrlPThzam8D0lLKkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f2rEkLUqMA2yBgn6Fkd2ChJAw6euE75AU+ZO9b8uR+mbSuAPUcv7OeoBcofokrXizrRXxpBCVj8I/S7ZyCgwnx228884fTZq+Nyl32JlnshPcO/Q9XLHlS/4OMzN6/cnJCPGY/voekGMvs140yUfPgxwRbB5H0r2FXx8Sf5qmgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMMf+ygx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22185cddbffso40075405ad.1
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 08:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740672265; x=1741277065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QgRkOay8wqsOuKwF5FjepFqr5KSlTxi61MFKNp0lZvQ=;
        b=fMMf+ygxv4N8fKyD1Ega1lbQNhgyMv3sJHGoRrq/z61D3M3EbwOCtH4LG9Xf2enqSJ
         L59UPb9Rco0d5aZ1TjVvMy2keAvx7OFs6EbzeSLO0Mi722O5Lwvl29cFW+oB5Of1tdi+
         ZLPy9lcvkaoniPd9FEkrGnRYvkc1GF7SGrQ5uAXfTfaOWM2QYu/JPC51yfE7ZtaIk0da
         jVlNGn/SpmTGRKp6kmTzYSc2YYhTXrnqrwDGZQS0fnrOc3aCrijMowBHbYHtsOUBWsM9
         uY8l7UBoz/qtDOTTDcneLKAPmz4BtsaKmnZR8G/n4hMn1cUw0To66EWfE1wCKRmDeObk
         C4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672265; x=1741277065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgRkOay8wqsOuKwF5FjepFqr5KSlTxi61MFKNp0lZvQ=;
        b=uRpIDqYjD2HeauoRkl135FCGKnpVCR3/CXNXOLPlzTWxXuNioFU7VHTcg5MeNsefDb
         a7KrjVo/mgUNRKRIMFmKiJK7DIKrTD5ob4UPDGsIX2ojueZttnJ2u+4xFTt+u8KLxJqe
         TpdCoTK0psbJvRehm8Ho9ZX53AL/aLaHrsvOI7uhPRFOotTbg9+gRCfZWW6qTlXT2WUp
         /MVhzCHREGcxvNCbrE2gkB3z5+5dPnFOjuDgwpI4XkiH9rJsbZcGluFLwcCf0gocCgJA
         /xvMoZ3AyG8OegrOQGHq2dOfT5UYG83eVTO7YuRjClaqhn73/123k45sNqQJ+YurOIdV
         jW3g==
X-Gm-Message-State: AOJu0Yy25MrSNaUiUDPKqzRe63rPtbQfpVRIdoZxi7fs7jk/abBD+L3R
	qFpraUzjWzP3WNXtUDRBykYX9E9sWy2XAG/biPBOrTHqC66PPytVqI4X9gfwl/jxhQ7A
X-Gm-Gg: ASbGnctFLCt77trAtizCsytbqvLes4TZoPmnryNDIOJQZQMEPzLzVvK/xC6ddBlRBo0
	nOeu7N5ncALDdZqLDZPSVmuKm2AQC7TjeR5wvPrJcGCV1sR2mUG/0/Dc78NSvejfXkNQQ0Zqr1m
	R1Ph1sBhTrXI1dqFXncnKVR5799sk8UfBJuqdeB9zAZWBKUCeynGuk3uYa3Mxlfs/GSpnaKdYMx
	eZunZnCrj4h91C9CJJvaDEoFZ0VDDZ/5rjmvDMtzPbAFoOVOrkjpod9FUB7gbeKUh+5Ymw6FV6Z
	6a26Afbk0ocrsrn9hOPntKcYDcmeEtQUG3FB2i6f
X-Google-Smtp-Source: AGHT+IHB1qHi6fBy1SWVAaP3nUYNFroFZhw9y2E31D3RTNtaRJBeeDCChjRXBFZccvzFhJA9TaTkww==
X-Received: by 2002:a05:6a00:998:b0:726:a820:921d with SMTP id d2e1a72fcca58-7349d2a31a5mr6347407b3a.10.1740672264452;
        Thu, 27 Feb 2025 08:04:24 -0800 (PST)
Received: from localhost.localdomain ([2a02:6ea0:d612:0:6f72:8d23:acb5:6c4b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a0024c04sm1833133b3a.105.2025.02.27.08.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:04:23 -0800 (PST)
From: kwqcheii <juny24602@gmail.com>
To: netdev@vger.kernel.org
Cc: kwqcheii <juny24602@gmail.com>
Subject: [PATCH] sched: address a potential NULL pointer dereference in the GRED scheduler.
Date: Fri, 28 Feb 2025 00:04:19 +0800
Message-ID: <20250227160419.3065643-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If kzalloc in gred_init returns a NULL pointer, the code follows the error handling path, invoking gred_destroy. This, in turn, calls gred_offload, where memset could receive a NULL pointer as input, potentially leading to a kernel crash.
---
 net/sched/sch_gred.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index ab6234b4fcd5..fa643e5709bd 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -317,10 +317,12 @@ static void gred_offload(struct Qdisc *sch, enum tc_gred_command command)
 	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
 		return;
 
-	memset(opt, 0, sizeof(*opt));
-	opt->command = command;
-	opt->handle = sch->handle;
-	opt->parent = sch->parent;
+	if (opt) {
+		memset(opt, 0, sizeof(*opt));
+		opt->command = command;
+		opt->handle = sch->handle;
+		opt->parent = sch->parent;
+	}
 
 	if (command == TC_GRED_REPLACE) {
 		unsigned int i;
-- 
2.48.1


