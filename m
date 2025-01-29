Return-Path: <netdev+bounces-161543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6415FA222E7
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 18:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA391882063
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 17:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D159D1E282D;
	Wed, 29 Jan 2025 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="lxHNm7w8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409921E231D
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738171490; cv=none; b=WDQFeHhkYClHzaROILlBjMhO2zwOCEmefGwBmzWpswcpQGiqD0v2DBEDA2O0kF0JO5vYs5RK+jmy6BS5f6tu6mKcj5wQGOs6Rglo4/VcIB7qzvekjYgQnp++CbpCbZ7XM6IWGTGDsuJcYXlvde5QThN1hT8TOfIIz9aiu/1ceJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738171490; c=relaxed/simple;
	bh=uykqXMSlccPAcjKM9N0EQQCoYb+N/o3tTowzYUQaFlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vF5ZcfPkEf7CMlRVaOkxM+AmrCu4UCqwKHYNjwdPIg4nSySXsucun+wBb3gCOmLjTBj6k8j0WSYeWMLUlUpi5jAkry2giCEhaAHPrKTpu1+s0za9VXTklBkJYixu8H0VaV9TGgCr0+nYrJ7xltZQnjr8bw0YhoJqa0jJOGP1/is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=lxHNm7w8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-216728b1836so120174215ad.0
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 09:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738171488; x=1738776288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIJ1xscChyKe3/yp1TDRIO0yWrS/miXJHLckPibu4aI=;
        b=lxHNm7w8xYC7pDO9tsoP6DSpO7GhpGWeQfaZmGs+QcGj8SGiHqcz8vL7qjmwsxaJg0
         fnGOflPGBZnmqMIZekgjYofIttiuQga2mfqpyqh8aag9fR7P6K4heEwU1MYvPLraxnOl
         WVgKBKt7z43eD/WZKwRNdaPCWt2TO97YZ8FkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738171488; x=1738776288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIJ1xscChyKe3/yp1TDRIO0yWrS/miXJHLckPibu4aI=;
        b=n6xL4Ov5nb25P7a3vQIUxhXO1XUMXZ0PJbeUizZEZi+JKhDFwDaoZ3B4fxj3Chw/Ot
         ZMw4BOPyBspObPSeTArd35D8vA8edqSKvU7wYXzKtzBHawmxrZ1T1Jh/DiAysBVc6XKZ
         VzTQp5NkhXYmz9b4kypc/F/hm+pXZW3ivgDGgOfyaqQhsWOFNWgMehxMHChkqvc8onh/
         rUopeLKBXL92nA9DsUkgq+mDA2imORsihqvl4ZEG80hukP2pwe6uMNxshFhpwxDCHMME
         4DqdYnOvOJp7yp2ZLklRc8RjyuIKk9kYAkXwWqPDy7oVg+urDCe3snbLuAJpAkmM7HOW
         utMA==
X-Gm-Message-State: AOJu0YwbTR9SjaYa1Mz8MDUpp5jheX9CRmNc9C11DubnTwNBE3Z3q7eJ
	1IkQSZ6tvpFtFrQHDAmFyXVhsqmbnOtzlBOD35iUFEghc4EJUcimHJOnuqy8r55hosp7CG5s+qK
	BCCA7rDnylvG/tZCCc7CTN4XXF/yqBWuQwNgEEmYZXPSXz2McnLD+uvfE4sU1xo4jaNYchU9VZt
	a/RUFWHgCQV2YuNQdwCZSVXDwxTloEgyKJvzA=
X-Gm-Gg: ASbGncu+/bpEDC5X7WkpoX3eOfBdO8dtnPa4fr7d6iP53dTOaQa8vSlX4QG3fbyEyMy
	/PxLcKw+HbN4Olyw4JARMLNtgrCu1tYJeK09wGLRtivih0sPihvs3mp41ZI+QqQWHKv/DYG17No
	uuzeNGPuJXPdkYbcCVRt2qcXdvFlSwI6Bo93qFdHBtUM0f6/kRIPUk9lJYY1svTeftXrgmm00z+
	u9p6loQAl/2Hf0ADsFMDmJ5biL6YrLqGkOX8Zk+m0AGPc+qTNeQNHc2g4VlHpJyWqcrOQBu+oJA
	uppy2fbhoxZJ/Sp5bwX/7d4=
X-Google-Smtp-Source: AGHT+IGe/oRF+IwKmYQvS9DZ5Fk0mURK77saF2TL7uM8Xp2N5QXboCJz7UEH45qrt1hOoyv0K85XIg==
X-Received: by 2002:a17:903:2f8c:b0:215:b9a6:5cb9 with SMTP id d9443c01a7336-21dd7c3555bmr65528075ad.5.1738171487942;
        Wed, 29 Jan 2025 09:24:47 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4bc5c1fsm101147295ad.82.2025.01.29.09.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 09:24:47 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Daniel Jurgens <danielj@nvidia.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 1/2] netdev-genl: Add an XSK attribute to queues
Date: Wed, 29 Jan 2025 17:24:24 +0000
Message-Id: <20250129172431.65773-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250129172431.65773-1-jdamato@fastly.com>
References: <20250129172431.65773-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose a new per-queue attribute, xsk, which indicates that a queue is
being used for AF_XDP. Update the documentation to more explicitly state
which queue types are linked.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 Documentation/netlink/specs/netdev.yaml | 10 +++++++++-
 include/uapi/linux/netdev.h             |  1 +
 net/core/netdev-genl.c                  |  6 ++++++
 tools/include/uapi/linux/netdev.h       |  1 +
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index cbb544bd6c84..7a72788cce03 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -286,6 +286,8 @@ attribute-sets:
       -
         name: type
         doc: Queue type as rx, tx. Each queue type defines a separate ID space.
+             XDP TX queues allocated in the kernel are not linked to NAPIs and
+             thus not listed. AF_XDP queues have the xsk attribute set.
         type: u32
         enum: queue-type
       -
@@ -296,7 +298,12 @@ attribute-sets:
         name: dmabuf
         doc: ID of the dmabuf attached to this queue, if any.
         type: u32
-
+      -
+        name: xsk
+        doc: Non-zero for queues which are used for XSK (AF_XDP), 0 otherwise.
+        type: u32
+        checks:
+          max: 1
   -
     name: qstats
     doc: |
@@ -637,6 +644,7 @@ operations:
             - napi-id
             - ifindex
             - dmabuf
+            - xsk
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index e4be227d3ad6..4d2dcf4960ec 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -136,6 +136,7 @@ enum {
 	NETDEV_A_QUEUE_TYPE,
 	NETDEV_A_QUEUE_NAPI_ID,
 	NETDEV_A_QUEUE_DMABUF,
+	NETDEV_A_QUEUE_XSK,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 715f85c6b62e..964aebfcb079 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -394,12 +394,18 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 		    nla_put_u32(rsp, NETDEV_A_QUEUE_DMABUF, binding->id))
 			goto nla_put_failure;
 
+		if (nla_put_u32(rsp, NETDEV_A_QUEUE_XSK, !!rxq->pool))
+			goto nla_put_failure;
+
 		break;
 	case NETDEV_QUEUE_TYPE_TX:
 		txq = netdev_get_tx_queue(netdev, q_idx);
 		if (txq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
 					     txq->napi->napi_id))
 			goto nla_put_failure;
+
+		if (nla_put_u32(rsp, NETDEV_A_QUEUE_XSK, !!txq->pool))
+			goto nla_put_failure;
 	}
 
 	genlmsg_end(rsp, hdr);
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index e4be227d3ad6..4d2dcf4960ec 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -136,6 +136,7 @@ enum {
 	NETDEV_A_QUEUE_TYPE,
 	NETDEV_A_QUEUE_NAPI_ID,
 	NETDEV_A_QUEUE_DMABUF,
+	NETDEV_A_QUEUE_XSK,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
-- 
2.25.1


