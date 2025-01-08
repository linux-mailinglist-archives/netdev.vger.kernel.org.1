Return-Path: <netdev+bounces-156461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5C1A067D6
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EF53A6D9D
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE60204C35;
	Wed,  8 Jan 2025 22:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ijaa+zOr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92F6204689
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374034; cv=none; b=e6S5CI/bHUfEOG+Li+gmpKAVGnfNOsAba7uCgrjb/tOdUYWD5LMkuRkpN1hPBCVhqkFlqYFKOVZ7v8tGkocp7mtGtIqbKp4th4KhxA7TaLcbTg+RHxCB5u9ZN4+zLablQV8/iLbxDRI+fIqdAkN7rBOJg+SrJO7DQxlYQ2vHRxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374034; c=relaxed/simple;
	bh=BLz2CIl+2gWaVD1yXUBMqm+9EtPiGKPqSFLgPfg/p4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwTDwoKbj8BhHR929NYC6I3hVtV7PFtUPI5BGtVvLXxIICr7mk5AHjWcr21NrNEhvXMnc65SR2pJrSxV3i8/QAgELymJXR+V03hP541frKnQSRGT9ZyVjVAbdEOu32QuqqG+4k0TbegScxb7J6n8tECKG9O/x8TqcOHxBRL/yBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=ijaa+zOr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21670dce0a7so4511005ad.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 14:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1736374032; x=1736978832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mX/tjyz7ib4qidu6OyYUCNKQIC8lKBXHPUPNB1Bean4=;
        b=ijaa+zOruUF1SCTIV7cKfw7SaBorWMxiJ9rmP3g2PvWOpmHCLTYggEcIPirDERYUy+
         FUhVGoqjNRETFL59QGx5QanS9pyvtZCLpaWqesEsaxGVQzzcXwOx1BRtk5Pq6xzedxhD
         k/DjrnEh21qvCn4kErJy3HZOjHh/KWWYknFTCe5gZTD0Vez3hGPiplitYvfGc4MDpvOv
         En1T3y/rDjIT0N4Qb/sCY6DFYbeTHyxkRJTLyQqD8UnuHR8G+bYMfq4yY/zlGVy01B4x
         w9a55vhrTt6LfDIrPxxBWz0EC5pNYL2ANrZdw4iMplSaNb6imhQlKIRq3lUs79rEGn1h
         8iPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736374032; x=1736978832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mX/tjyz7ib4qidu6OyYUCNKQIC8lKBXHPUPNB1Bean4=;
        b=s3SOuho/np5TrnBtlabzxiwVo8uwFhQaKHNZ3w0fb4DZopo2h6CN+wSYzDb1xnNGVf
         jR79UnG41pvBVIWIEJaUShQReFqC1nW9nWHTySNlI9idRPsRbi/+THzc2DfC4v+HOmmb
         Nx/ZvsGHauCi5HDQVnL8kQryLFA5r/0u/41z2cKa6B+UgkWwJ2fsmxb7pvVLITQaMjNd
         dRnLAhU0d9lT9N8iMEszSW6Nhr159xPptagLa/pd3mMBXTBARf2Op5mVMXJlwmZokMkD
         kbCZlifGecz60h+PJwCB4A8CDL6quJIEucDKG0vHNczTeAba9b9G7bkaCOTxd+lck9hb
         +9Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXIaUV7B+f8LXJYIWLlxYRDZwoKGRXNmTC2CI1/1Jq+ybVBWx2WmKqxZib4zltZ2KqY48XjAhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQaVeJWTEwVtRQtKbglN3Ebsww8Ax/5uMQvCOzR6u4zmbdJAIU
	9I42aycVkIFhCb7BYMNG6VWJYUMFAICLlfl2wgzR1Q8IyHn0Yzu8nsTeUVjuwjM=
X-Gm-Gg: ASbGncvjtTOBieCnHuxxyctMo+K3BTK5r8TKS7vFCgroBP5w+PYL62ZVGRMvulToVXh
	CJaWFenT2vQ+jrwV2YFTlS+DDK+kCNADr8H10ivYBj1Z6LaUCNyjcfq2xmCFBLun0WNW020ZSDe
	M+Ub6F4f/eRZRgZ0RMiwRegxD9csF6UekSGayOK2YBxfeBAZrJhDs0UUpAR1eEuZMwOSH2+vavv
	c2MtDnILvHGnlrFQC79frgpkgTBM8R3LAVRhv9dRg==
X-Google-Smtp-Source: AGHT+IFQ/fod37JQsWNUJCo1pK530n5DANk+hYj+5M6R5H9LpNdJGMMQyjPm5JTJAtys3l6Z+VUAHg==
X-Received: by 2002:a05:6a21:33aa:b0:1e1:f281:8cec with SMTP id adf61e73a8af0-1e88cfa61dcmr7504727637.10.1736374031918;
        Wed, 08 Jan 2025 14:07:11 -0800 (PST)
Received: from localhost ([2a03:2880:ff:11::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fb9fcsm35897270b3a.164.2025.01.08.14.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 14:07:11 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v10 07/22] netdev: add io_uring memory provider info
Date: Wed,  8 Jan 2025 14:06:28 -0800
Message-ID: <20250108220644.3528845-8-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250108220644.3528845-1-dw@davidwei.uk>
References: <20250108220644.3528845-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a nested attribute for io_uring memory provider info. For now it is
empty and its presence indicates that a particular page pool or queue
has an io_uring memory provider attached.

$ ./cli.py --spec netlink/specs/netdev.yaml --dump page-pool-get
[{'id': 80,
  'ifindex': 2,
  'inflight': 64,
  'inflight-mem': 262144,
  'napi-id': 525},
 {'id': 79,
  'ifindex': 2,
  'inflight': 320,
  'inflight-mem': 1310720,
  'io_uring': {},
  'napi-id': 525},
...

$ ./cli.py --spec netlink/specs/netdev.yaml --dump queue-get
[{'id': 0, 'ifindex': 1, 'type': 'rx'},
 {'id': 0, 'ifindex': 1, 'type': 'tx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 513, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 514, 'type': 'rx'},
...
 {'id': 12, 'ifindex': 2, 'io_uring': {}, 'napi-id': 525, 'type': 'rx'},
...

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 Documentation/netlink/specs/netdev.yaml | 15 +++++++++++++++
 include/uapi/linux/netdev.h             |  8 ++++++++
 tools/include/uapi/linux/netdev.h       |  8 ++++++++
 3 files changed, 31 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index cbb544bd6c84..288923e965ae 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -114,6 +114,9 @@ attribute-sets:
         doc: Bitmask of enabled AF_XDP features.
         type: u64
         enum: xsk-flags
+  -
+    name: io-uring-provider-info
+    attributes: []
   -
     name: page-pool
     attributes:
@@ -171,6 +174,11 @@ attribute-sets:
         name: dmabuf
         doc: ID of the dmabuf this page-pool is attached to.
         type: u32
+      -
+        name: io-uring
+        doc: io-uring memory provider information.
+        type: nest
+        nested-attributes: io-uring-provider-info
   -
     name: page-pool-info
     subset-of: page-pool
@@ -296,6 +304,11 @@ attribute-sets:
         name: dmabuf
         doc: ID of the dmabuf attached to this queue, if any.
         type: u32
+      -
+        name: io-uring
+        doc: io_uring memory provider information.
+        type: nest
+        nested-attributes: io-uring-provider-info
 
   -
     name: qstats
@@ -572,6 +585,7 @@ operations:
             - inflight-mem
             - detach-time
             - dmabuf
+            - io-uring
       dump:
         reply: *pp-reply
       config-cond: page-pool
@@ -637,6 +651,7 @@ operations:
             - napi-id
             - ifindex
             - dmabuf
+            - io-uring
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index e4be227d3ad6..684090732068 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -86,6 +86,12 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+
+	__NETDEV_A_IO_URING_PROVIDER_INFO_MAX,
+	NETDEV_A_IO_URING_PROVIDER_INFO_MAX = (__NETDEV_A_IO_URING_PROVIDER_INFO_MAX - 1)
+};
+
 enum {
 	NETDEV_A_PAGE_POOL_ID = 1,
 	NETDEV_A_PAGE_POOL_IFINDEX,
@@ -94,6 +100,7 @@ enum {
 	NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
 	NETDEV_A_PAGE_POOL_DETACH_TIME,
 	NETDEV_A_PAGE_POOL_DMABUF,
+	NETDEV_A_PAGE_POOL_IO_URING,
 
 	__NETDEV_A_PAGE_POOL_MAX,
 	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
@@ -136,6 +143,7 @@ enum {
 	NETDEV_A_QUEUE_TYPE,
 	NETDEV_A_QUEUE_NAPI_ID,
 	NETDEV_A_QUEUE_DMABUF,
+	NETDEV_A_QUEUE_IO_URING,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index e4be227d3ad6..684090732068 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -86,6 +86,12 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+
+	__NETDEV_A_IO_URING_PROVIDER_INFO_MAX,
+	NETDEV_A_IO_URING_PROVIDER_INFO_MAX = (__NETDEV_A_IO_URING_PROVIDER_INFO_MAX - 1)
+};
+
 enum {
 	NETDEV_A_PAGE_POOL_ID = 1,
 	NETDEV_A_PAGE_POOL_IFINDEX,
@@ -94,6 +100,7 @@ enum {
 	NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
 	NETDEV_A_PAGE_POOL_DETACH_TIME,
 	NETDEV_A_PAGE_POOL_DMABUF,
+	NETDEV_A_PAGE_POOL_IO_URING,
 
 	__NETDEV_A_PAGE_POOL_MAX,
 	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
@@ -136,6 +143,7 @@ enum {
 	NETDEV_A_QUEUE_TYPE,
 	NETDEV_A_QUEUE_NAPI_ID,
 	NETDEV_A_QUEUE_DMABUF,
+	NETDEV_A_QUEUE_IO_URING,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
-- 
2.43.5


