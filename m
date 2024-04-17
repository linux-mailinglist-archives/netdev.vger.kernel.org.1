Return-Path: <netdev+bounces-88578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9F38A7C49
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4C7285619
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 06:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143FE57898;
	Wed, 17 Apr 2024 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9Lmwzu/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15BA1851
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335256; cv=none; b=E/1zmHUkgO66G6aQevzTINldG2L/rO1qGOcol1hpb7W4QcuXI3HXYCCi8C95P29PT2Y+DwH0DaQ+qemAtr3YsZQIDW6J6Sv0Llqmb7A2+qmJIucAjf1YQg7o1U9+84K5CgWMCXRxZjbgVXg6mhxsATaBk7G3Q34vlaDNlW/XGvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335256; c=relaxed/simple;
	bh=Gs5gJJVIQpozdEczY9HzZUbRSJ4pmuUyr8VWAYt7Krc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IeN+VW0HvD5kfh4s/m1AEeCqVf+ZzHJOSQZfqR81JDsUe1++TmkIpe647ih8Ud2S/TbUser2axpypvWD4vx/k0SLXCix0eys1lPAZfggE2xiAYhKRGkdjaQJEtsdkybnXb45lhtE196h+ulDMGrmj/FVoVIETwsgIkalbYmY5Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9Lmwzu/; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e9e1a52b74so877936a34.0
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 23:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713335254; x=1713940054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3Izpu42pBrVzasccWQKJO3uxRg0LVnG55BW/QOwOnE=;
        b=f9Lmwzu/p5H33fpERWjBiwramsmASMx+e2CQH7bD97D9UeMBravBwVVHCI/RZlMjVT
         LQrpMKZ3VETOl7Ax6VZ3f+IHupRIGeoKLlcC+kgrwPU8ybSh10hWzBgSngzXI9zBG6W7
         tBBUsOqZlARLZsLLYJorp0zoKkQRWVhB90stmAlzCFH2z5vH7cVytm3TZ4Q6vmE92oGx
         EJtb60pRsMkgYcanSVXvjBVrQu/nmWmHQKyrttu7UjJwTzVwuk+URC2+Hd49X/yRDWJd
         KgPM40MVD/CdonDn0C24Sex88wgqO6oSy5jAGFveShClGmwKn0Nvn4eIxK1z8anFL9Yb
         iIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713335254; x=1713940054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3Izpu42pBrVzasccWQKJO3uxRg0LVnG55BW/QOwOnE=;
        b=IEY+25r0QLabGd/2R/+cDjFHyMzg8qeGiXR6iwRdGSGButeo7Jhh/upCDSgWvbFjmW
         qdJSGi92fEzKwgGog/AJS/5hkxArixSmniSJ1hjeSW6DbH3xnV3iMO5Vqw3+YPte9iDE
         YIzWzRhJRA18c44MTrCmm7DZQrbs/AKgwFX2eR6d+VVK2YvRMICSCW5yskXBiXJW9te3
         4/8hmh84m5/tzvM+mmktLcLrTUXJL1hNO4yRIPmLiNIF3H9hAhwfqqNX3mF86ff0XweN
         +0sNSLRTbRbKqh0e+nuT6Q0mF5BvQNV2Lnx1d4tql1Lkt1+O8dzmztT0xsrTOwlmzSbH
         7HyQ==
X-Gm-Message-State: AOJu0YwFgSb01iz+AT/TDf6f5SXThLHs5pAHVHYX3mWtyic8UYiRcvSg
	PJCvrExmvcM3vNyvyWJAFdZv5zetjiVY7IklggYMYa2X2OxJFqjg
X-Google-Smtp-Source: AGHT+IHBcmUh2cdIERP7iuXpWYeY6yJE7hNqNPqY4dr12QHvXmYc4VZc55CD6x9YdSp1Eb6etAlD2g==
X-Received: by 2002:a05:6808:1708:b0:3c4:f1a1:b7b2 with SMTP id bc8-20020a056808170800b003c4f1a1b7b2mr19818475oib.55.1713335253743;
        Tue, 16 Apr 2024 23:27:33 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id a193-20020a6390ca000000b005dc120fa3b2sm9821006pge.18.2024.04.16.23.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 23:27:33 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 1/3] net: rps: protect last_qtail with rps_input_queue_tail_save() helper
Date: Wed, 17 Apr 2024 14:27:19 +0800
Message-Id: <20240417062721.45652-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240417062721.45652-1-kerneljasonxing@gmail.com>
References: <20240417062721.45652-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Only one left place should be proctected locklessly. This patch made it.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 854a3a28a8d8..2003b9a61e40 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4501,7 +4501,7 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		struct netdev_rx_queue *rxqueue;
 		struct rps_dev_flow_table *flow_table;
 		struct rps_dev_flow *old_rflow;
-		u32 flow_id;
+		u32 flow_id, head;
 		u16 rxq_index;
 		int rc;
 
@@ -4529,8 +4529,8 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 			old_rflow->filter = RPS_NO_FILTER;
 	out:
 #endif
-		rflow->last_qtail =
-			READ_ONCE(per_cpu(softnet_data, next_cpu).input_queue_head);
+		head = READ_ONCE(per_cpu(softnet_data, next_cpu).input_queue_head);
+		rps_input_queue_tail_save(&rflow->last_qtail, head);
 	}
 
 	rflow->cpu = next_cpu;
-- 
2.37.3


