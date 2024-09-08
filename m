Return-Path: <netdev+bounces-126290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 783BC9708A7
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 18:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F57B21310
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 16:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB34C176ABB;
	Sun,  8 Sep 2024 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="HPjlKk2Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBDD176255
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725811721; cv=none; b=isy5oO7LV56Zo9qMczzZoEytMqyr1ywslYePMQH1yaW56MlrwBQlCud6VKKyFcWkAlhT4fPe8xi3ITCOnVKW5462Hv5TIJT7YmQ0YklaajM4KcbRO55lhoARjXJzJRrmMlLbDW8GO5lqgoiimjEpDb2J4/mjD5LyJfJ8if858fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725811721; c=relaxed/simple;
	bh=BNKvxVYTuL++N+ZYm9W5qpapoauvjei5NqpfkRAMLoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tu8DjdkeGS9qKtsO/IsQIeteI58o1YS1uWkqlxPX+a7IgLnNxn0gbQ6rFmUADYe1KxdTHY1Jbvf2VIltNVfTRKQc2OlJIfd7DgqQqcv3sP4+Ghsx55qvQg4r9GHi8MQM51e9tlaU525ImgMUMQrvHKUC6jB1pxUKkZG3HzWxYbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=HPjlKk2Z; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718da0821cbso1697736b3a.0
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 09:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725811719; x=1726416519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XALJ7SdzaDOWVbMSTdcXBR+9NoF8QqBzXwj7wqN3oPE=;
        b=HPjlKk2ZuTa/atl77mD7Im12rUTZ0Z0HtN55HX4fx7qAQVRzjx7R4pwu/D9ReNtMx1
         7434M3+Lg/FGOJT4qbEe0XODccNBfUZWbBzcBd4wuQP77g/DdDy+bMg14PaZhn2Gnakg
         GYw9vn0O6CZC3n+RDSqQYGOU+zlMKvYAAlXNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725811719; x=1726416519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XALJ7SdzaDOWVbMSTdcXBR+9NoF8QqBzXwj7wqN3oPE=;
        b=Wr3SxFioiN5a1Y1ka/I9GGoTYHopeQQdLr6Qvec3OOLr+uZYC1LfCvcIBvuKv1vewf
         ukYBhS4vJpA2kcjZAfyMe92nXBNtuOMvhGsED94KjPAy0UfTJEPHKugFB3Et4ybHLN/6
         XDJo2LKj8J7K99i7jrVZJ0NqFaj/oAPqhdHd5UwkSUI0ZB0ZNrj08riUMZCZLj4cyJwd
         n6is1REJ90c9zbomHX5cQZsJFkKdPo3Mm3lYgB2dSih+br6r/aXNwHAZF9wsQA5rWXCu
         3sj2rwzJRUTP52sLvUJk3Itai3Jg1S9ld8YTgaacTmnAl6KJ107suYt25j5fjhhl1IMy
         Tlkg==
X-Gm-Message-State: AOJu0YwiGgnnjCkmL0TuhoLBcvb0Z6wjSKoahBAmOHjTUmK7/tGj/qA1
	1WP1DNKTjS1a2ysKg0tzSOsLuCzkPOupFrZmp74eXVE0SSGrYHt56KMy8kIrWGHeTFMpK2rUSnr
	BBWn+7yvsyJ/uVO5n0/cM6+2QHtlCIx68YoE6scax8DIptosv5g4lhGVMwrhRtdsdc1OPV0xGfC
	mF2185PwMKIHWK2KUw+y4poXlaq1j41QfG1p/Jvj2Q
X-Google-Smtp-Source: AGHT+IFSF82ScYVZRAI2likR2SsKzoBk6rQOgSbeMrGcT+1n67/wRDaY703WCe1MsbvqtuQbVhJ/Ww==
X-Received: by 2002:a17:902:f68e:b0:202:9b7:1dc with SMTP id d9443c01a7336-2070c1c74c7mr74584625ad.54.1725811718448;
        Sun, 08 Sep 2024 09:08:38 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f3179fsm21412535ad.258.2024.09.08.09.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 09:08:38 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	kuba@kernel.org,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v2 2/9] netdev-genl: Export NAPI index
Date: Sun,  8 Sep 2024 16:06:36 +0000
Message-Id: <20240908160702.56618-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240908160702.56618-1-jdamato@fastly.com>
References: <20240908160702.56618-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export the NAPI index on napi-get operations. This index will be used in
future commits to set per-NAPI parameters.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 Documentation/netlink/specs/netdev.yaml | 9 +++++++++
 include/uapi/linux/netdev.h             | 1 +
 net/core/netdev-genl.c                  | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 959755be4d7f..cf3e77c6fd5e 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -244,6 +244,14 @@ attribute-sets:
              threaded mode. If NAPI is not in threaded mode (i.e. uses normal
              softirq context), the attribute will be absent.
         type: u32
+      -
+        name: index
+        doc: The index of the NAPI instance. Refers to persistent storage for
+             any NAPI with the same index.
+        type: u32
+        checks:
+          min: 0
+          max: s32-max
   -
     name: queue
     attributes:
@@ -593,6 +601,7 @@ operations:
             - ifindex
             - irq
             - pid
+            - index
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 43742ac5b00d..e06e33acb6fd 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -121,6 +121,7 @@ enum {
 	NETDEV_A_NAPI_ID,
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
+	NETDEV_A_NAPI_INDEX,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index a17d7eaeb001..9561841b9d2d 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -182,6 +182,9 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 	if (napi->irq >= 0 && nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, napi->irq))
 		goto nla_put_failure;
 
+	if (napi->index >= 0 && nla_put_u32(rsp, NETDEV_A_NAPI_INDEX, napi->index))
+		goto nla_put_failure;
+
 	if (napi->thread) {
 		pid = task_pid_nr(napi->thread);
 		if (nla_put_u32(rsp, NETDEV_A_NAPI_PID, pid))
-- 
2.25.1


