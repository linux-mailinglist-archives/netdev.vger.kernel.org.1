Return-Path: <netdev+bounces-166198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF71A34E6D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 20:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875BE16B352
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90417245B16;
	Thu, 13 Feb 2025 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hla3EaoG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F349E245B0C
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739474637; cv=none; b=bPJuGXyrAX4t8JsEHAOQRb6olSgjGj5YfBjbqEv17U0Rr461V38xi1q2mkBC/U2ELkxCaFwPD+rlDw6Be/BeVbtGc+dZ4pNMlXxVa1NXlkk+q2+3IyAa2whhpvHH6AMKxn84AwgyqnQdnGwra7dWm327Oh68ifvKuWaSuc3+dbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739474637; c=relaxed/simple;
	bh=JmmEchmG/T2KTFE40ANXceRTnPYqC6cBJs+eCktZTEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjjoQImboQ95PLFW/fK8GD9VDkCghwSMcBHZ2iGJdHk34DMnZve4JPgNrwMWNlaRx1oU1NifE61Znmm0YSQfyWSCnrjzywbishdiZYF0O5qTpCvZvPu2p5jT+L+xaAu48oXJN3vURemfgEtfnmdTd8/x5irPGOzcEFkBn8w8O8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hla3EaoG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f92258aa6so32957395ad.3
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 11:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739474635; x=1740079435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFmTLGonL9CPxuqbAvj4+M2PsmUtQYzlnrZXTFj7G1o=;
        b=hla3EaoGeiuwikkVALHwiCnDgXvcJhH3hZ8OPOQ1d5zmcm7oARpxdzPEvfL1VtsvLT
         73MWEg/TpcvWp2yhm4qIIOpTvYtgx55sHfmlxfGPjkfwH939RKa1st7qkR8g1ZDuQK/7
         HIJtOxGgPU90VEiYkrH0EniZa+nVBzF6eNVrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739474635; x=1740079435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFmTLGonL9CPxuqbAvj4+M2PsmUtQYzlnrZXTFj7G1o=;
        b=R6lh+Q3MEh0e20HM52OcocPAeZbPW+vt478ydl49NCFKaC0bRVXp1QTkGc4ApcgZk9
         iNhq8ZmdMzKBFIgNgtMyLvXVTMpchymdXt38smwZaKssIRxwOTLNkhMO0FxRgZMqAql/
         yhNftuePmIdC6p0Ij4xpfTSdywFG62pSekSWJGAcrfqDwscjxmCum4DOsx4egQ6ZyrLr
         gfXDIF8wWNpEUUj6D7HvV81eFRUTfXazBh99r3TX+jDKSUN9E1zIFH++LWNRR3s3YP8m
         aK2OPffXNOZrbxJCjIA/OQlnDD4tH2xEWmIArm955/UL0/6iUGzqMUiHhjrznOYOrXGY
         K9zg==
X-Gm-Message-State: AOJu0YzBCbHLBQAcjIG4vVlOzulF+vgM/DhIoMLPycuF1cTngY8xUe5j
	hLPa+RVxTRJlwrk0zEbV/rtl3aX1ayI5CvkDvvCaUV+Wxr5eOuB0+WcGn2bW8ROV2yt4mcUA+5K
	OBgajunM5gxFcB1kLl3jKXJ8SFnNM5Ayj7pgoXCCdGIsdCe+0zQIAL1whadfuHHLHANEkLlT5kr
	P/DCggS1TurLBJp5quTNMqHncPeTbDMjXOIVzutg==
X-Gm-Gg: ASbGncuoLJvHHJ3vStT7D5vNdnioD6u7xGxgyLgtGPirBSiyVMVqmh9GwU/VPTxuJDL
	4tYlU9QNnGNYrT5M8C7HsY4EepHjlEgJPCvnwVAgQOkt1gSKpHucudLNRk8gNNU1FJHXr7BJhxo
	ueSRprD258c3fDVGesx7qSItNwr07t6rX4MHPRv5LL3BErnfKI1qMdOCi7r3w1dD6nUMTPYLYBY
	V9cC6hjnRqRIbDOqXzJs/ufi1VSbUMWy3rCdBuRAoZbVtLwJQxzMr8XE0q/cydOLSVnYFwOeq7d
	zKYit0SSXKUwxt3JJtZKMxU=
X-Google-Smtp-Source: AGHT+IFMQ8my9cYQBxHI0GOl+/Lvp33Cz51AIR5j+cNuRCPKxqLDZLIFO+x8S8OnRWe8Ul/XBnnUvA==
X-Received: by 2002:a05:6a20:3d88:b0:1ee:7c01:d16 with SMTP id adf61e73a8af0-1ee7c0112abmr2336436637.30.1739474634856;
        Thu, 13 Feb 2025 11:23:54 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568a9esm1633458b3a.45.2025.02.13.11.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 11:23:54 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: stfomichev@gmail.com,
	horms@kernel.org,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	David Wei <dw@davidwei.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next RESEND v7 2/3] netdev-genl: Add an XSK attribute to queues
Date: Thu, 13 Feb 2025 19:23:12 +0000
Message-ID: <20250213192336.42156-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250213192336.42156-1-jdamato@fastly.com>
References: <20250213192336.42156-1-jdamato@fastly.com>
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
 Documentation/netlink/specs/netdev.yaml | 13 ++++++++++++-
 include/uapi/linux/netdev.h             |  6 ++++++
 net/core/netdev-genl.c                  | 12 ++++++++++++
 tools/include/uapi/linux/netdev.h       |  6 ++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

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
index c18bb53d13fd..2a0b6a452356 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -400,11 +400,23 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 		if (params->mp_ops &&
 		    params->mp_ops->nl_fill(params->mp_priv, rsp, rxq))
 			goto nla_put_failure;
+#ifdef CONFIG_XDP_SOCKETS
+		if (rxq->pool)
+			if (nla_put_empty_nest(rsp, NETDEV_A_QUEUE_XSK))
+				goto nla_put_failure;
+#endif
+
 		break;
 	case NETDEV_QUEUE_TYPE_TX:
 		txq = netdev_get_tx_queue(netdev, q_idx);
 		if (nla_put_napi_id(rsp, txq->napi))
 			goto nla_put_failure;
+#ifdef CONFIG_XDP_SOCKETS
+		if (txq->pool)
+			if (nla_put_empty_nest(rsp, NETDEV_A_QUEUE_XSK))
+				goto nla_put_failure;
+#endif
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


