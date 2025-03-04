Return-Path: <netdev+bounces-171666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169CEA4E111
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20ED13A433C
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B46205AB1;
	Tue,  4 Mar 2025 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0kwdmpM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BF4207657
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098424; cv=none; b=YqLCcRVNpDS/00+c32tm3Hzqg6LgEbTYcATAPPIPcqf2g2++66dZ0B44GXh9ZVhMc5oZ98mMSxxhgCfN1u0XgM8Nnqfo1HT0XFex/UR9fwolx3Xbokn5ADXISnlYU9wEkk3nq25SJ6BtryJZdxyosGtw7NPEL9dDJyPkMiOjY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098424; c=relaxed/simple;
	bh=zdmxs6VsXw14yr85AedGsfgI317UadTw9G/y0Eo+IT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mf8GvW19mkh6IReiq5lGuHXye36APhU0hE5KF/Z5gZPDM6AEKNR/NxR/MIqLRc3fcSzkcB01ixuIuDUmr/HSftjSqBnhYOfTrKIjm1Yp03mXXE2XNBffgvDoOAGG4QV4LBkT5XrCh5lKfBKltXxTo/n36AAoCOpXksVDqD0wJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0kwdmpM; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fec13a4067so6725199a91.2
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 06:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741098422; x=1741703222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwXdOvbbbLdu50pXhFTdO8hht9jHfvqFnYYcdEDP0o8=;
        b=Q0kwdmpMJgoigiiELntJFwxdP8KzIm8vUHzb8F4DakuQIOaVHw5GpJoIMar09adcUQ
         73bSybgHl1QWhNoO096n68/1cHvca/SL2fc6djI+Ti5a+ykOnkVgvZq+3Y1jzspc0Z3P
         sYRmMGJECDRy6JRjIuniRqnLIXeGEhcLXF+yZsirr6xjjjvjML1ZHDs+rp+x761/39Dn
         M6vaKTSklE5R+nzUKuRAJ3NKf83Q9lQB0nxrCcCuCm+dlt1KLkzr1bQDjyNuhDLiJ24O
         pJnqtkNqlzHBDdvpUYKyg5RnFbxgwTpV5aECZqXIPu05fhRpeNKsdvMDuvyFwNnMwLn3
         4x3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741098422; x=1741703222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwXdOvbbbLdu50pXhFTdO8hht9jHfvqFnYYcdEDP0o8=;
        b=Lm2wM2rKFLC2euXpkle035rPq+zslfmfG54nO8vLMWWKqiTIrZeqEx7qwxydYa+6F7
         XxS15FXhdoZ+cqix+t+63nD/bZKVmjY+7dFvRcLQhdaGeFpDwNzr2+47HZecWdQJPDjt
         lv5uMf1VDIWlkc+dALKwYl8an+httjM7AAEIkdu19SYhAJLv10bmZk5sF1zG3dLavOVb
         2Qo5SrLlIkU/WUCv6QFK6asqZSJ5PWCSlVsYPm4+LRfz9iyQQQuGUCWnIDqFw7x1bqxj
         JHzet0TJXSly8ZGcW2LHNx1FvOXhxZQ/Mgw6eAqEQSkbD6oBbmf2jHNclDs3yIg53tlp
         MwxQ==
X-Gm-Message-State: AOJu0Yx+js0AcA2Sv+FlMQ4UzJQmG8uKgpTZbtaZW4mmwWFr9jelxa19
	t5JZG9KWstFXppzFa2Y3VrRafMtKDS7oRDUvyxIJ+EMD3+P8CShYTRAZohPGjyWpYJjK
X-Gm-Gg: ASbGncu5sk1PIxVf6KDVevDb8DL8DZfKhhp3tWPL6DQPKZeVHXO0MVlolCUZJeZrV4l
	kJRk7gmnwYPZBtyaFHE6sWvhSAqk3KwdkFjoiQxt9q9yVvzMCng4FnHsB8FCli3U3fBPj54C8py
	vGzNFMay+wNehG7UvaHOOEB4EIx44ZYSy+YpEW16+1lwR39A12/SoK3quF7pw8nRwE8+697OrMJ
	NU4xltvnmGi4MZ1/RSGdERGrAbmsU3UPOKxcT+wVtJQ+Gh1Tlu/q0biq9rK13hzH+285+HDUtRz
	FIPwH650bFTG+muxdSNd7SPCuODJpFg5mqXf65pg/Sf3e/mmK/b2cdYY
X-Google-Smtp-Source: AGHT+IGne9y3wK6UyaqZ5AZvT/y8Vy1CNjgF2Xhb+/NgwU1dEquorNFbSLqae1No5WdiiXxUh/9Q4Q==
X-Received: by 2002:a17:90b:1ccb:b0:2fe:b470:dde4 with SMTP id 98e67ed59e1d1-2febab3c659mr32250918a91.12.1741098422016;
        Tue, 04 Mar 2025 06:27:02 -0800 (PST)
Received: from localhost.localdomain ([2a02:6ea0:c807:0:fa79:f8bc:7c1:855])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea676b133sm11076532a91.13.2025.03.04.06.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:27:01 -0800 (PST)
From: kwqcheii <juny24602@gmail.com>
To: netdev@vger.kernel.org
Cc: kwqcheii <juny24602@gmail.com>
Subject: [PATCH] sched: address a potential NULL pointer dereference in the GRED scheduler.
Date: Tue,  4 Mar 2025 22:18:59 +0800
Message-ID: <20250304141858.3392957-2-juny24602@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227160419.3065643-1-juny24602@gmail.com>
References: <20250227160419.3065643-1-juny24602@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If kzalloc in gred_init returns a NULL pointer, the code follows the error handling path,
invoking gred_destroy. This, in turn, calls gred_offload, where memset could receive
a NULL pointer as input, potentially leading to a kernel crash.

Signed-off-by: kwqcheii <juny24602@gmail.com>
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


