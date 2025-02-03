Return-Path: <netdev+bounces-162205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 807EDA26329
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 19:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637791886390
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 18:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40CA20CCDE;
	Mon,  3 Feb 2025 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="W1nuQqVG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F0315530C
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738609125; cv=none; b=uW21JO87bjD4mAxeg7hBy/FS+jk5MxYhEkuo8a7rFC7ue+PsMUvhRzdGjDrNGxpO7h01GpHWaRcKcdqf4jDYidmCF4jjO4ovTeN4pd0z/7rVzGBQ81OAATRd+9KIhD5ja4+chkQKF8pDPoSr8jewELOrKoZ66RY7H9/ZVrF/eHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738609125; c=relaxed/simple;
	bh=YWLna/hYKjLDp7e2BU26uo0pe/VQo3Rev1AkrtIgSNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OcygyyYwWvZrCFYhPVYA09jvbwJcE+BfIS0+tQZrPuW3LFRUfHs7aGLwzjRvxrYdpjvHdGWlUZtzdniYDFL/GsTJTjwmDjI5yl3lRojuO4Z21TbutJpGJIHY+JPwiOgYC6viUlfhDkNsvlRrRtDpY/LZvId+ZhBPCQXzjUVEW80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=W1nuQqVG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-216426b0865so82264815ad.0
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 10:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738609123; x=1739213923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFV2H1044MDUFJDVaW9wXukAW/miUUhwpjp4ACnOm8o=;
        b=W1nuQqVGjDmqtI6W8MrpVvYXD1rN8Yw9HdM9XJbjJCiMgmgoU2NDLHvEj0rClrdlCc
         tXwpNwi6Mdd0BhU/oLWXvqfw0eH6OisSxj3lQKAJv4Dk7hV/1pibnSuWrYNzfGPf9lpG
         GgDXFNrV8BIi6e7QQtzV3YqSZ8fMsM2M3fAcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738609123; x=1739213923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFV2H1044MDUFJDVaW9wXukAW/miUUhwpjp4ACnOm8o=;
        b=Nrmk1zbhvm7JuisujB8vUKA/6fo0H0soXAlna8NsFl39nsEeC5tD3GPHGB4Q5rOIt4
         +VCL8IXdE5MpG28z1POj3JucTWlftJ2jPf+l43yYEgAO/XZmrO2cE4g2Vy1Hq+aezPMW
         WKkeHIQIkXkvFeTSzfTFUbNQtEDrtxHl+oNFuylucDqBgAySZa/joTE4Eled1MkL6En7
         i1iNl9J4QjQxw/LXg/EnGCPmSxfBVGmoA2OQg2jYim716vI+fQrJiUGjVPmU1RHYkpI2
         IqRmh7vi5Rf5qslH8UYwthPq+zwSAFBNYXGA1ylD2D2Kd3o9wIImK9xrIGbdeHoyzv0r
         fiGA==
X-Gm-Message-State: AOJu0YxHbtwcU1g7KWe24uznNsqjg/EPB+j5nbzJSCNQ8xuuT5pFYAQh
	CNbFr158SkiPFZ8Xen2BNeH9VH5FFDjwXjviBJiP8/BWiBsUNMOdV2VLT7pqBSnEeCgNzK9x0FU
	ZCuhIBoJA89m3W3zHRnaM1FHyHb21RA65PdhClinEX/REGadqACV0gJsr+PXw2QI5h9C5OOm/tA
	3Ib+LYPMsswvvJn7fMmY9p3JYuVHvXNZeNJoY=
X-Gm-Gg: ASbGncvdVO9O4xP5prKkl1iTXa1/JWn1+9ZE4oVZgjQOFxqtmObrXEu86F7LJBtIqBy
	R9EWx/yGGzMipmI/1lBFC1CS1v6B+YwIU/NYlpTQFLqvqR31b5oT9akqiV/BCJpafHbnGvu50HP
	pBwIXnaSL/3pmav081crDS1g3r9aPPNulW7mWmwZeEBoI3LwAQMlVJcE8eIlVce2OmBKMLTjs2C
	kd2R8NYEdi2TA8C0RA5tAOXe1AjM30JB3tsiLqUpMlEbi5VH4gpETZXN8v04qatD6U+5/plQ7z1
	vDYv3bVJgAu5bFmoyKmtkqA=
X-Google-Smtp-Source: AGHT+IErgFj1XPbmmXgg/gDjbp8GmtedVOyxQtSlr57wVEkQTED5pVfME7Sn7Hyyby02uOUYqVHkqA==
X-Received: by 2002:a05:6a00:140f:b0:72d:b36a:4497 with SMTP id d2e1a72fcca58-72fd0bcd59cmr40027431b3a.3.1738609122729;
        Mon, 03 Feb 2025 10:58:42 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec0a666ddsm6899673a12.73.2025.02.03.10.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 10:58:42 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2 1/2] netdev-genl: Add an XSK attribute to queues
Date: Mon,  3 Feb 2025 18:58:22 +0000
Message-Id: <20250203185828.19334-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250203185828.19334-1-jdamato@fastly.com>
References: <20250203185828.19334-1-jdamato@fastly.com>
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
 v2:
   - Patch adjusted to include an attribute, xsk, which is an empty nest
     and exposed for queues which have a pool.

 Documentation/netlink/specs/netdev.yaml | 13 ++++++++++++-
 include/uapi/linux/netdev.h             |  6 ++++++
 net/core/netdev-genl.c                  | 11 +++++++++++
 tools/include/uapi/linux/netdev.h       |  6 ++++++
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index cbb544bd6c84..4c3eda5ba754 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -268,6 +268,9 @@ attribute-sets:
         doc: The timeout, in nanoseconds, of how long to suspend irq
              processing, if event polling finds events
         type: uint
+  -
+    name: xsk-info
+    attributes: []
   -
     name: queue
     attributes:
@@ -286,6 +289,9 @@ attribute-sets:
       -
         name: type
         doc: Queue type as rx, tx. Each queue type defines a separate ID space.
+             XDP TX queues allocated in the kernel are not linked to NAPIs and
+             thus not listed. AF_XDP queues will have more information set in
+             the xsk attribute.
         type: u32
         enum: queue-type
       -
@@ -296,7 +302,11 @@ attribute-sets:
         name: dmabuf
         doc: ID of the dmabuf attached to this queue, if any.
         type: u32
-
+      -
+        name: xsk
+        doc: XSK information for this queue, if any.
+        type: nest
+        nested-attributes: xsk-info
   -
     name: qstats
     doc: |
@@ -637,6 +647,7 @@ operations:
             - napi-id
             - ifindex
             - dmabuf
+            - xsk
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index e4be227d3ad6..46bdb0b67a39 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -130,12 +130,18 @@ enum {
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
 	NETDEV_A_QUEUE_TYPE,
 	NETDEV_A_QUEUE_NAPI_ID,
 	NETDEV_A_QUEUE_DMABUF,
+	NETDEV_A_QUEUE_XSK,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 715f85c6b62e..efaccfb6438e 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -371,6 +371,7 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 	struct net_devmem_dmabuf_binding *binding;
 	struct netdev_rx_queue *rxq;
 	struct netdev_queue *txq;
+	struct nlattr *nest;
 	void *hdr;
 
 	hdr = genlmsg_iput(rsp, info);
@@ -394,12 +395,22 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 		    nla_put_u32(rsp, NETDEV_A_QUEUE_DMABUF, binding->id))
 			goto nla_put_failure;
 
+		if (rxq->pool) {
+			nest = nla_nest_start(rsp, NETDEV_A_QUEUE_XSK);
+			nla_nest_end(rsp, nest);
+		}
+
 		break;
 	case NETDEV_QUEUE_TYPE_TX:
 		txq = netdev_get_tx_queue(netdev, q_idx);
 		if (txq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
 					     txq->napi->napi_id))
 			goto nla_put_failure;
+
+		if (txq->pool) {
+			nest = nla_nest_start(rsp, NETDEV_A_QUEUE_XSK);
+			nla_nest_end(rsp, nest);
+		}
 	}
 
 	genlmsg_end(rsp, hdr);
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index e4be227d3ad6..46bdb0b67a39 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -130,12 +130,18 @@ enum {
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
 	NETDEV_A_QUEUE_TYPE,
 	NETDEV_A_QUEUE_NAPI_ID,
 	NETDEV_A_QUEUE_DMABUF,
+	NETDEV_A_QUEUE_XSK,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
-- 
2.25.1


