Return-Path: <netdev+bounces-88579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3DC8A7C4A
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED71D1C2231F
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 06:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D743254737;
	Wed, 17 Apr 2024 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Js5fwlK3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9E31851
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 06:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335258; cv=none; b=O5J+vrZesO3FE69+TK/B6ZPi8/YI+/eZ9F2TZk3StZLpdWFWYTuB7JVzZAKd1V7xn+MqWK2NcAtyJox4RxXRXi/XGc7Et47C/B3+KJv2VBhSg8NY09frIpYxDwfc3HDGSRrfKF53qiY+ST5qbmcWXeNIKohlJig/xPEeYc03A6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335258; c=relaxed/simple;
	bh=LjTSwOzUYwO9FexdpM432GBKfMVRd9Bn95OsvZKpLoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CZqIugyzxUYhBt4nfY22oVzKKbb4IwK4FFNiFVl5xVtbro8maw/a13nGYQA06UqAFkIrKzmSJLdqCIZlXu+AeorbiyeomlWPCprwSgleyrpFn+cU86Blq63We4zawzIeJHYp6lpQa547bZBjx97low/1mAjQeEMNsoQaBG0c6KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Js5fwlK3; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6eb7500abe3so2095981a34.2
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 23:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713335256; x=1713940056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+42Zh365pp6FZP2BKOJ2fToigQcA8JSYTE5I/4rSW0s=;
        b=Js5fwlK30P8v99UD67P5BOtPSL/pOUU5SPYP5Q9FTjtAHy2MXfXLek5Mwk2q+gi1I+
         7lydxlahxfLorADyrionWVpuWjNChTbbRpxCmuGMYbWWetmz8cVPrcPHUB7s248FwMbt
         kSw/49ntKao+s3R2UckgeEnz4tZB9GFJGAhQhAds7CyeVz7RIjE98TMukp5hm+PpfzG3
         0P/pJWRTgb8W2DR2/lfp0CNM40cUP0mPaaIreghAiOYZcRRCrfDsv23mzxisEvXbovgs
         5/NoGM6cedIY+PFLbEq41zEcpBFH+ujIgo0xa0jQKPIBpHx02pE2wJit1xxNcgCAaPTS
         5vKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713335256; x=1713940056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+42Zh365pp6FZP2BKOJ2fToigQcA8JSYTE5I/4rSW0s=;
        b=tkQx3niI/JIW7PcpFY3KUySyJ15zBC14bdXMX2N4VmohqJW75fLguNCjPbMPHVFvFp
         7ZptfOhONhdzImzLI85pvYbaPJTPR8PV+y8prSNK/nLwd06axAyuOET1p0IUYwJhy6Ym
         ahFJb944jePzyu0elbT/KzTekdojKSMXxbf7vR/4SeWYJpILGP9KwGputHuFyb2E745l
         xou9Sxvpa0erB42TbsDpDfHqAoa0cdNo7W7Bs0L7uObEkygqPXeMEI6SgiRWqqQwJjsT
         4rc0QSBeTERqVTM1AREHxD+CfVQ0rAKq9oCZCezijTde1bK8nVxzECakss4UvogE+lTS
         4xdQ==
X-Gm-Message-State: AOJu0YyEQUYVQL0tBGd5PRNODyFqVnDJkPKgfKNo8QQpQ2p3Ppl6MKfR
	h8sWGgRVRyK5zKOMBoEBdT6EaTc1RNKKezZl/lHpl55bZB30/v1O
X-Google-Smtp-Source: AGHT+IH4jooJQ/7n2N66IbCzrQULZATFieco1u2Vg2/GL+al1XBlx5oMKWPkUxL5N//uKsKbl6/X2g==
X-Received: by 2002:a9d:7616:0:b0:6ea:1d59:be71 with SMTP id k22-20020a9d7616000000b006ea1d59be71mr15787486otl.32.1713335256421;
        Tue, 16 Apr 2024 23:27:36 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id a193-20020a6390ca000000b005dc120fa3b2sm9821006pge.18.2024.04.16.23.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 23:27:35 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 2/3] net: rps: protect filter locklessly
Date: Wed, 17 Apr 2024 14:27:20 +0800
Message-Id: <20240417062721.45652-3-kerneljasonxing@gmail.com>
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

As we can see, rflow->filter can be written/read concurrently, so
lockless access is needed.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
I'm not very sure if the READ_ONCE in set_rps_cpu() is useful. I
scaned/checked the codes and found no lock can prevent multiple
threads from calling set_rps_cpu() and handling the same flow
simultaneously. The same question still exists in patch [3/3].
---
 net/core/dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 2003b9a61e40..40a535158e45 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4524,8 +4524,8 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 			goto out;
 		old_rflow = rflow;
 		rflow = &flow_table->flows[flow_id];
-		rflow->filter = rc;
-		if (old_rflow->filter == rflow->filter)
+		WRITE_ONCE(rflow->filter, rc);
+		if (old_rflow->filter == READ_ONCE(rflow->filter))
 			old_rflow->filter = RPS_NO_FILTER;
 	out:
 #endif
@@ -4666,7 +4666,7 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index,
 	if (flow_table && flow_id <= flow_table->mask) {
 		rflow = &flow_table->flows[flow_id];
 		cpu = READ_ONCE(rflow->cpu);
-		if (rflow->filter == filter_id && cpu < nr_cpu_ids &&
+		if (READ_ONCE(rflow->filter) == filter_id && cpu < nr_cpu_ids &&
 		    ((int)(READ_ONCE(per_cpu(softnet_data, cpu).input_queue_head) -
 			   READ_ONCE(rflow->last_qtail)) <
 		     (int)(10 * flow_table->mask)))
-- 
2.37.3


