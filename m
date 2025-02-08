Return-Path: <netdev+bounces-164285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F93AA2D3AF
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 05:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866D23AD30E
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 04:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0C518E04D;
	Sat,  8 Feb 2025 04:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="pxdGGLII"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB76319DF8D
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 04:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738988081; cv=none; b=O4Kio74uZqkalFPNQLJ5hZQMoI1ZG1XNz11ZCVa7D70OMV7oF9qrvmjt9G0KLRFSLfZ8bBZ9v/3lJFpvyPx6AodR4Grc3nn5pd6Rh461oPdaZZ81ixhTVJf5mAYaDxIWQe1nito59qDjD7eYpgseAshjPoytp+Q7OrOTOOtC/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738988081; c=relaxed/simple;
	bh=qMU/SSD+GnDstgplnPhUezCKkpRh9MkYWQpob4UhFaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWB3M600Hwp9aUFBItOQeq111CNPQKxAnsF90FhQiJS1qHjQCwaRXLJNjmYU67cDjxcbHx8c8qMuFcxjoxV0P5FIXzeh7kmCB3TIx37Kpj1RRrxfa79w86b4YGbNpGdGSaglUQ5EMGhSsr8lQX/bidRNli+W8CB4yD4jDBk675g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=pxdGGLII; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f6d2642faso4400795ad.1
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 20:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738988078; x=1739592878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4DJzSaiR41L4hlteYq1D8hTA0O9UNuuENwILLXuiso=;
        b=pxdGGLII/xKi1lFhN8O+lLmzjTr0dbr6fo3JQmUS+Gyf95jSWX0BBxxGAVL9qODOef
         ykMxu4tUqeNjmLkOlhabSvKziab5u7ybG/cFoGa5RmozYQDhjnEjTM2P7Dn0bBZJ+0gf
         BLt89WSVTPMAEsEVitDUwPopWuipnUiQovh3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738988078; x=1739592878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4DJzSaiR41L4hlteYq1D8hTA0O9UNuuENwILLXuiso=;
        b=N9MXNeJuiI402Edn8LfnHccIh8lxuzoUp/xbz+CCcUXdUWhEjZkAPU1oa6oHfgngdT
         1ZNdZG1CoTn+umU0IPUgME6G/+x4zljdIToUEhOOMeuGucs8xm5FMLM6a+NTqTgJUe5p
         mT1AtvLoHYNwdKCad1C0nc/iFLOTi7VWJVUYtExcElADVQdBT7XlfvqzewVC7isij8Ts
         SA6RF94+0x0+vo1eET4MevXJLLm+gietP6oqE7LN8ee6Xnk37Aaj3SvJ8wZbcU53UCch
         aDAOUIRJeJQz4nR4g9VKPPj5gbxQQYLAi0oj24je1zzPq2hd5XaXyf6Fbx8yQoCYlC0y
         w4qA==
X-Gm-Message-State: AOJu0Yy4fN00ChHPl/DGUCIvf5A0VRuW9Zf2iMxzl4vc72fgV23WGHcq
	uJcHHySB1aojL+lP9/NCkCiieaPIpQFieSqsoZihbS/MGH5+il2zb0Y5C1DUEoNqmXsEpHwbTTk
	+96iNk+4HZMIQBOdslA2Wp9PyrOKQOohr6Ce/SMir2wCy+4CXYTvYK1AnW6ARbm6XEfy21qZNYg
	v0e03UEPYTOf1d37vJfBb/F9EcjUohTlWdlxU=
X-Gm-Gg: ASbGncsVw6JFGcYZ8v5woI5+kap3tAob4BZbpiREggbHYYiLgixtRHNhL8pNYGsok/r
	9hDTgiKY5/RTdPIbf4gkoi5hoKdRnFuUVNwOC1NZQ5Fkp3YL5NIPT2v2DQWbEpN2lZYYJxJXjCE
	x5WPm9nhaGFQCp4aGvlM/CxP3nia2N+RxIjaz44qc9aOK2AMu2BxIc4rye2ZL1TX+82NSYb3mfz
	SvHRg01Qo3HS1Y9gfZRjO0kvh33//AfqUD3z54A4u9JoGpWRZByY7Sx8+dHS63wh0L/2H0zYOjq
	K1N6Z1LGxr+TnezNKLbtCmw=
X-Google-Smtp-Source: AGHT+IFZ59NGSqTUMa/FLxvgaYbBKt8+YckD6RRdPZKX9/d1HXQ/rQ9E90HNh7Azr36Zxf8jvckMTA==
X-Received: by 2002:a17:903:1c4:b0:216:4169:f9d7 with SMTP id d9443c01a7336-21f4e6a00f4mr104632155ad.2.1738988078328;
        Fri, 07 Feb 2025 20:14:38 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650ce0bsm38567715ad.21.2025.02.07.20.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 20:14:37 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	David Wei <dw@davidwei.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v5 2/3] netdev-genl: Add an XSK attribute to queues
Date: Sat,  8 Feb 2025 04:12:24 +0000
Message-ID: <20250208041248.111118-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208041248.111118-1-jdamato@fastly.com>
References: <20250208041248.111118-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose a new per-queue nest attribute, xsk, which will be present for
queues that are being used for AF_XDP. If the queue is not being used for
AF_XDP, the nest will not be present.

In the future, this attribute can be extended to include more data about
XSK as it is needed.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
---
 v5:
   - Removed unused variable, ret, from netdev_nl_queue_fill_one.

 v4:
   - Updated netdev_nl_queue_fill_one to use the empty nest helper added
     in patch 1.

 v2:
   - Patch adjusted to include an attribute, xsk, which is an empty nest
     and exposed for queues which have a pool.

 Documentation/netlink/specs/netdev.yaml | 13 ++++++++++++-
 include/uapi/linux/netdev.h             |  6 ++++++
 net/core/netdev-genl.c                  | 11 +++++++++++
 tools/include/uapi/linux/netdev.h       |  6 ++++++
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 288923e965ae..85402a2e289c 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -276,6 +276,9 @@ attribute-sets:
         doc: The timeout, in nanoseconds, of how long to suspend irq
              processing, if event polling finds events
         type: uint
+  -
+    name: xsk-info
+    attributes: []
   -
     name: queue
     attributes:
@@ -294,6 +297,9 @@ attribute-sets:
       -
         name: type
         doc: Queue type as rx, tx. Each queue type defines a separate ID space.
+             XDP TX queues allocated in the kernel are not linked to NAPIs and
+             thus not listed. AF_XDP queues will have more information set in
+             the xsk attribute.
         type: u32
         enum: queue-type
       -
@@ -309,7 +315,11 @@ attribute-sets:
         doc: io_uring memory provider information.
         type: nest
         nested-attributes: io-uring-provider-info
-
+      -
+        name: xsk
+        doc: XSK information for this queue, if any.
+        type: nest
+        nested-attributes: xsk-info
   -
     name: qstats
     doc: |
@@ -652,6 +662,7 @@ operations:
             - ifindex
             - dmabuf
             - io-uring
+            - xsk
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 6c6ee183802d..4e82f3871473 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -136,6 +136,11 @@ enum {
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
 };
 
+enum {
+	__NETDEV_A_XSK_INFO_MAX,
+	NETDEV_A_XSK_INFO_MAX = (__NETDEV_A_XSK_INFO_MAX - 1)
+};
+
 enum {
 	NETDEV_A_QUEUE_ID = 1,
 	NETDEV_A_QUEUE_IFINDEX,
@@ -143,6 +148,7 @@ enum {
 	NETDEV_A_QUEUE_NAPI_ID,
 	NETDEV_A_QUEUE_DMABUF,
 	NETDEV_A_QUEUE_IO_URING,
+	NETDEV_A_QUEUE_XSK,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 0dcd4faefd8d..b5a93a449af9 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -400,11 +400,22 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 		if (params->mp_ops &&
 		    params->mp_ops->nl_fill(params->mp_priv, rsp, rxq))
 			goto nla_put_failure;
+
+		if (rxq->pool)
+			if (nla_put_empty_nest(rsp, NETDEV_A_QUEUE_XSK))
+				goto nla_put_failure;
+
 		break;
 	case NETDEV_QUEUE_TYPE_TX:
 		txq = netdev_get_tx_queue(netdev, q_idx);
 		if (nla_put_napi_id(rsp, txq->napi))
 			goto nla_put_failure;
+
+		if (txq->pool)
+			if (nla_put_empty_nest(rsp, NETDEV_A_QUEUE_XSK))
+				goto nla_put_failure;
+
+		break;
 	}
 
 	genlmsg_end(rsp, hdr);
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 6c6ee183802d..4e82f3871473 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -136,6 +136,11 @@ enum {
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
 };
 
+enum {
+	__NETDEV_A_XSK_INFO_MAX,
+	NETDEV_A_XSK_INFO_MAX = (__NETDEV_A_XSK_INFO_MAX - 1)
+};
+
 enum {
 	NETDEV_A_QUEUE_ID = 1,
 	NETDEV_A_QUEUE_IFINDEX,
@@ -143,6 +148,7 @@ enum {
 	NETDEV_A_QUEUE_NAPI_ID,
 	NETDEV_A_QUEUE_DMABUF,
 	NETDEV_A_QUEUE_IO_URING,
+	NETDEV_A_QUEUE_XSK,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
-- 
2.43.0


