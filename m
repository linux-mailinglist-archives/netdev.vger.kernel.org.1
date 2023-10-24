Return-Path: <netdev+bounces-43970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 935717D5A51
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 20:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E401C20AAC
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7513B291;
	Tue, 24 Oct 2023 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9DO/aCY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2446FA6
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 18:21:02 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B0210A;
	Tue, 24 Oct 2023 11:21:01 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-577fff1cae6so36653a12.1;
        Tue, 24 Oct 2023 11:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698171661; x=1698776461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dRlXCpMCmorDXOQl5AgNkn9c/v2fok4N7mYXHXKr4U4=;
        b=b9DO/aCYjUCg6N/1ZzVx+QXyGGHy7YK5i5x1HX+1RFfzXuei1THCtRaIIh+uZ3eGAY
         x/A2VXlliQ/7l32IfqhPe9+tvAeNp+itSdVxrBgvUP4kEBAqCcT1+qbXmwXP4utlQ6MN
         wyiBhSSLya2opWHfk58mKMbDThcsNnIxZxp6PR83/31QT34DYnC04ufnwu5RMeWDSixT
         kIDBXITs0OZfnVR4eyrht2Nww3ratpLICTkIMQfpsB+XzQbeBW8bkCqfr0rtLfqOk4gj
         sZzIRqz1v8/9IhNHukJP4zZuz6SzTSCXDRWHQv0j1G+wrsor+0cpaXzx8O+eNqC39+Ol
         u7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698171661; x=1698776461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRlXCpMCmorDXOQl5AgNkn9c/v2fok4N7mYXHXKr4U4=;
        b=BsG8QYjHKgwiXlocyQcNdXxGBi8LlmUtvaWuXUMQ/S89kquHR3q61u7pslkEGsnVSm
         PZqCgs0nxCb2TIojalpQxgdvCgahgbYF52S+dM6QYgnfu7Msk4tyinOvwnq7I1haGF2z
         56RXniQeC4PxAUESyFb3DK0w0QW4OPlIyjCoJ44CkOTOGMPm6XFZ6ZjiZVxTLxSzUs/d
         TYMmkBIq6BjwpVDeDGBjmgVuggthSa1xcbMKu1s4gk5lha1uEzpf5OadRu3RK1qCjzKx
         Dxd0QMVNa73Ml2l370dLo4SQKbMoE+X6Zu6tFzVXnY6Zu7v8uAe6ludaWzY6RE20kTTL
         Ob8g==
X-Gm-Message-State: AOJu0YykZz7bLS9SUurUuZVf4xK3s8QVw5/oGWWz3lUkzGXzAF6+fT7i
	lzLxMtV/h38lAzvmwTXV8HI=
X-Google-Smtp-Source: AGHT+IF9Oz5kRrdI+pmGEoGEJWNvqhDPhWIslaqJL9uAJb2+QwlbXjHaS7rUXRsLBBI3Ot5sGIFOLg==
X-Received: by 2002:a05:6a20:9187:b0:17a:eff5:fbbe with SMTP id v7-20020a056a20918700b0017aeff5fbbemr4716343pzd.8.1698171660904;
        Tue, 24 Oct 2023 11:21:00 -0700 (PDT)
Received: from brag-vm.. ([117.243.121.127])
        by smtp.gmail.com with ESMTPSA id b28-20020aa78edc000000b006be0c9155aasm8105219pfr.91.2023.10.24.11.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 11:21:00 -0700 (PDT)
From: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To: shannon.nelson@amd.com,
	brett.creeley@amd.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] amd/pds_core: core: No need for Null pointer check before kfree
Date: Tue, 24 Oct 2023 23:50:51 +0530
Message-Id: <20231024182051.48513-1-bragathemanick0908@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kfree()/vfree() internally perform NULL check on the
pointer handed to it and take no action if it indeed is
NULL. Hence there is no need for a pre-check of the memory
pointer before handing it to kfree()/vfree().

Issue reported by ifnullfree.cocci Coccinelle semantic
patch script.

Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 2a8643e167e1..0d2091e9eb28 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -152,11 +152,8 @@ void pdsc_qcq_free(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 		dma_free_coherent(dev, qcq->cq_size,
 				  qcq->cq_base, qcq->cq_base_pa);
 
-	if (qcq->cq.info)
-		vfree(qcq->cq.info);
-
-	if (qcq->q.info)
-		vfree(qcq->q.info);
+	vfree(qcq->cq.info);
+	vfree(qcq->q.info);
 
 	memset(qcq, 0, sizeof(*qcq));
 }
-- 
2.34.1


