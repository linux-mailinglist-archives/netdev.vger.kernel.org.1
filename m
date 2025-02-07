Return-Path: <netdev+bounces-163798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5B6A2B978
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 04:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CD63A4950
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 03:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67382187872;
	Fri,  7 Feb 2025 03:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="sM9k2lNd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B8D156236
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 03:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738897789; cv=none; b=N2G+D5wfOzg5DZClaP6ffcLls8u9tl/kYbPF3hU2QJOyhQXNB9OWRTm4sUioHhFW9bGWm1EVwq61VkrpG3acIelqoGj1hhYl7YadOhD10LrF0/tFoRvQ/urFac8jSK8PyPsicPiuqsdx81b9L2oW/++5UgSdmkcu5g6l/p4o7f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738897789; c=relaxed/simple;
	bh=t2bdWXIhCRgtjCrRvBiAo9wr6E1Q0gMByrBMpkptx1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXy62e3+6D26/RfLDzs9SUe7IY1rhsLxmPg9v5QGsN84tdNHS34jpv1pUelxFoaAZLRYFNtbsbhVsQLGG/a7AJqrnf+uemTj59YFfpPOI/w/VLDNml1Tpc+kfq1zVFw6o/+77YPdWvUD/j3tYbyI55iRorczmCdfUTCBG/i27vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=sM9k2lNd; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f9cd9601b8so2850798a91.3
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 19:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738897785; x=1739502585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvN5IEuSm1GAFZydLhqU2iZKnjJwS5x3mE7p0JmTwi4=;
        b=sM9k2lNdHYMkyZ0xvtGYwtcJTcA/JUCWZxTT4IhUx85n1yg2Dqe2HQWNa767ORoIUq
         1t+U7wxIpLSBGYW5gNSe6DMY+eWhUI62ROjQO2Zv+PA1Y3QRsWgvJpont40UEFFRx/SF
         Jdc4jltJtMuvBJpCQvptA/GWd00n3gXvZBd44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738897785; x=1739502585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvN5IEuSm1GAFZydLhqU2iZKnjJwS5x3mE7p0JmTwi4=;
        b=f6zEu3K6ApLi2olRYzvvzxjowkTWPTC2uX+K5fysiBXn0PjUS6ns6QgcK23ZV87c2W
         9mrc/ArevLThhoTrBKd8NpEJ/6DfxTWZ0CC9pBs7pxFnmQkBRonRSHdZECbnMFh+Pva7
         06Y67fW6i+8AcZbytNXrTaf0xiY0xqYawvq07pcmjBLrE+7f2Ja78XPfDgZb7aTHpxgC
         hfSerazdOceHtvL1vciyqOGMFttrz86VQ2cKtE0BcvBqN/1H9DxcHpgIO44Q+RfvNjuw
         xYGRTizH871XqU1erWtElGCO2u9va6sxJfwEnVCdq1amU8cUWa2DMiSzF1wwlhIjZk5k
         MYyw==
X-Gm-Message-State: AOJu0Yx6LGY71mfQFSemN5vzPpBneUl0iy8wnGklaMWagV/aYH54/7Lm
	nc4QzYu4OZMI44KPrEPQdG/TrV6QaZb5G138lAVCYeq7tkqWkBqRO2MywzlP+sMa8oJQgMdrXbk
	LQNT+/h9weD00tmmXnVyzRfd+YjabNTHnrF0+CaWw9ImWp/WTJ1mQ+A/kDU3aubatXlBAVl/Jjk
	h6fTErsIE+VxYgjcVZLnHnKL6LJPiSLR5Mea8=
X-Gm-Gg: ASbGnctKtyxVuDJU59j4bDolxhCbNdIVxjEhAsibLZEILSA3ugtl8XVvCzr1AjUpo14
	ZaRFrqTl0t54AZiZ03adUkrvNxUwrI3iMI84mt0CLZu5PNNNP3sQvugZgPvI0s21PkhH8qq9TMC
	BlloR56BDvawPnKXZI2BOcPGj0fz8oo4eTWQx7uusXDQXTwnLgIZfqKlTkzr6Fi8s3w+Gue13yD
	40ulIGULtshATYtz/ynp/wlimnKum0vgIxur/1qPwKsMskiuIYkIXb5kLqw73ZqRY9/Kd/Olcwt
	VESb0fJE1RAEliH4qe+BSac=
X-Google-Smtp-Source: AGHT+IGNhUT+Jhkp7Cdh5BBlscWIQjRyb/gjVd9oZk2GyDRuojRmIDKCiibURXvJHpU9HUPT4RJIwA==
X-Received: by 2002:a17:90b:23cb:b0:2ee:d63f:d77 with SMTP id 98e67ed59e1d1-2fa24063c18mr2555688a91.9.1738897785457;
        Thu, 06 Feb 2025 19:09:45 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368ab196sm20348955ad.222.2025.02.06.19.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 19:09:45 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	David Wei <dw@davidwei.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v4 2/3] netdev-genl: Add an XSK attribute to queues
Date: Fri,  7 Feb 2025 03:08:54 +0000
Message-ID: <20250207030916.32751-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207030916.32751-1-jdamato@fastly.com>
References: <20250207030916.32751-1-jdamato@fastly.com>
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
index 0dcd4faefd8d..75ca111aa591 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -380,6 +380,7 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 	struct netdev_rx_queue *rxq;
 	struct netdev_queue *txq;
 	void *hdr;
+	int ret;
 
 	hdr = genlmsg_iput(rsp, info);
 	if (!hdr)
@@ -400,11 +401,22 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
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


