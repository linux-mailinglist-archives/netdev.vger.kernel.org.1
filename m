Return-Path: <netdev+bounces-166562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7945A36756
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F59B3AA477
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5551DA634;
	Fri, 14 Feb 2025 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="RSd7CIWH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7902F1D95A3
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567599; cv=none; b=gD1nQp7v65NNHvT3jnZKNcgwbN25dJlXZZYnORWMjHk68zGudk0VZegLg89kLCk0tfdpJJRFb+SXV/F5IY11xYlHd6YYrhyhw0cHOEZzjj5g+MN/NdpYu5fSE2hJpTjlRx+/tMk+meQj23f7ImtfrSPlqGkwet9pmS8qaZ0WR+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567599; c=relaxed/simple;
	bh=mPuhF130ax/7GB13RCt7Li/n+rP3TtOcYvGXiH7f4No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvUNha2IeD6A5YYt636muFBrZ+nZFw7qZ8dTjeXaQq3taHw8vqR0x3JZVOSSl58qN/XwiA9SulpEOVNhj5aUC4lgtDWEKwqOyDxAm0Xc+3g5Crju/T+h6uIA4cDXVwsQSs7vuRONftpsndDwLkOQC8j+8qlyUZhj90hqpojWR20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=RSd7CIWH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f55fbb72bso47939345ad.2
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 13:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739567596; x=1740172396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/SwDJv69vExAVSJvdtCIxYScbgvivss7r+DNLYoyxA=;
        b=RSd7CIWHalzilPJwWPpOpTMGw9ix2wbm6X8vrf7kzD8S1tKly3hKS7ahkdaGUCC3Z8
         tbftzr1NUG/1ZyAkgq0u/WR2wZMyv+fjK1uTubTeSWiNqZn/oFcNI7vM/Uhxyk4XJGOa
         dOIdzr/8J1kl7h3go7kWkJb8gn3WmDPimeE8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739567596; x=1740172396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/SwDJv69vExAVSJvdtCIxYScbgvivss7r+DNLYoyxA=;
        b=Ur7ymtbYl46BpcMNWLg6a8BYuCxAgdCpj/WZw5Inye0GKIyiat5SkcMgkfbhhJ2igp
         ZTi5JrKUISdgk0WSFFHpX/2L9HjiPiqV/QZEizhroE+myfaIGYvaUjF5F74wEbcGJ9Fx
         otZLPCGI+9C7iQ2WxJbZ0FJpaJID73NXwNYgNBdFCw6QSVvu/qa2gdiE2vRILE/ujM+k
         2WbkC8JzisNmX7IjwediBqBjLdsDhnh1WqesuEke8ig/PuKqwjf2sNiKhSB1Jyso2moG
         xN/cqUWxw8PgxdIQiZxHbo5yOlX6QBEWdnmrEwRLVEDNUAK4vn0J9B9SkaOcZlPUyVI5
         vwQg==
X-Gm-Message-State: AOJu0YzDmpsPkMaeDRW0fUKVPKY6w5DbkonlYe5WXuZ/PRNIxRJeaV+p
	URxfD/F7VOarCgxEhj0R8DNJYfojxCIGyonPpb1e6/if4E2gZti9UQVwmXCBWd1uS1T6qCXrTVH
	Vzvv0d9Mixsqsj363DefclJkAtiLQvLh660FvWMcJhxu7I36g3hCWsW6hfns6Suim6KSO2kApPI
	QHc9Nf1WH2ST7u/Py6c1toSNd2cYH7uYRbwpeb+w==
X-Gm-Gg: ASbGncsLd28rLghuvmpQ0bg8SKmHqqGQOX0r2zkNjfqD7kpf95/DQJPUciyMqUYqLwh
	e5oluIMfIM++1IgS4+wuG5+WmZZEnToCO2+2YqQsLW4FGeTxKnN6eX3VLX6wIxkKptQSiDZ9j/q
	jEHEh5ZTzk8qNLoUwC5eQxvEPrP0ace6EVpLixSztVcNVXLvHru5+VemmQDo194fkqua1qwzubk
	mquoRacmYOqvlAJwL+kUJLEXsqjW5NHCtyfGSKb6I6bhsTCqhmS2VH7U9JGejvVaNFQ1ZuuHOJI
	pbIRWKpz7FpTms7zkoQd/kU=
X-Google-Smtp-Source: AGHT+IEW74IZ924sIDJL2hMkAeBC+xS5FAhDGZrCYUaEeaFkkBcD4GGittPhCyL0tVhl3nEXmJRZ6Q==
X-Received: by 2002:a17:902:ef49:b0:216:6769:9ed7 with SMTP id d9443c01a7336-221040b131dmr13212605ad.40.1739567596408;
        Fri, 14 Feb 2025 13:13:16 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55908a7sm33285265ad.240.2025.02.14.13.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:13:16 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: stfomichev@gmail.com,
	horms@kernel.org,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	David Wei <dw@davidwei.uk>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v8 2/3] netdev-genl: Add an XSK attribute to queues
Date: Fri, 14 Feb 2025 21:12:30 +0000
Message-ID: <20250214211255.14194-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214211255.14194-1-jdamato@fastly.com>
References: <20250214211255.14194-1-jdamato@fastly.com>
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
 v6:
   - Added ifdefs to netdev_nl_queue_fill_one for CONFIG_XDP_SOCKETS.

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


