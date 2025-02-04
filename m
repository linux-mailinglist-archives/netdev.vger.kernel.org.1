Return-Path: <netdev+bounces-162705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD3EA27AEE
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 20:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58341167C0F
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 19:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC40219A9E;
	Tue,  4 Feb 2025 19:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="OQWImNpN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BC0153828
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 19:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738696281; cv=none; b=vFi4aBVgQfnDzzsWt9z55IBb5u+tJib+39K51x08EkItbQM5a7/tzt469oD56+lGnEr3ReARbI7MT00HduUEBF/Jr2NgwWiw30v3J11tYLrgpwbZLsjjOMc1eIf+mCl+fTie/t+5yiL0lTmQQLX65bJVZ5SuOXw4Q2SuM7J+x34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738696281; c=relaxed/simple;
	bh=fgvav/VSEIHUhdT3806VLJC6JLGbBXBOxRebuhnQQjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udCiNiSPvNCjZoWsNPIPXyw05QOnmgM96Fk0g/DeZCDxvYsPUWLwS01BCSO7CStgyTLaMhyU8wv4V51WBaMJqvHAUEtRR4Rg5exjsh8C9kfVaRlxK3/kGtCgrva8yqA1kAMkJRl6mJ+ALm49KTq+93A7fp1wt5/7S2aRFkVJgJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=OQWImNpN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216728b1836so103898475ad.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 11:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738696279; x=1739301079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ei3U9MNfcrzrg5+3o/MWatj/iskGcRz4y7XoQJ1XwqM=;
        b=OQWImNpNhViTmOEBUaszmLwtXp5zOCoHastSl5nYsGF+bA+9jEgqXOb5g+eSe1OL4S
         +rr8MWb73du0gRKwU+2kr/h/3td1m4SM1YwNIjZr34G8IjdJ/tvRDznjQQFGcOq6W32D
         ECS+9WxWfO8NJbeTbShHDIQ9RsmvXI48iBmWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738696279; x=1739301079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ei3U9MNfcrzrg5+3o/MWatj/iskGcRz4y7XoQJ1XwqM=;
        b=VcJEc7vCKJpwn/GnAQxsoUcHgvXg+jM8NP4LE3aCD+hUdwt6l/WZewOsRupym96b8C
         PFljPaq/3vH9WWdUY9e8LnqbZ8RkoDwx4kxz04iQXjYaaBgxUedtpCvX5p4oNXeaakvv
         2Ys4BmMvX6V8KkcVDoyo9pDmgt/uJqXAc4zfgQe9iKkOUJhOPnv9RSbo2Kls8EhxfTVD
         f5f1DSc4rT7IIWg4i2gkaLuHUpKtmf0fOCZUlqFN/08xhlGoaD28a/BQugPZSRnmsM9k
         5/iNyFR/8k4SkKAMVTqa8wXHWkTC5ISTCuhFj5R+EyrM5qqr5tXW3mKLa0VFkx6UxGq5
         2MYQ==
X-Gm-Message-State: AOJu0YyPVZhd3XY/VgYt/UJgDJrAGTHvLcYZkMQvIjvLcSEhkNrwCFeS
	IAM0JWWaJbbUG+toT7UM7Ilv53bDin1NdiLtQo4AnYh5clgV4CIxGpyHM6GqT9mfPdjIL+FJDWv
	QhKJxF8HYvAZ724wmEp7n0mn5XyaAgjVmnQZW6Jbl0wB9BnS7s8uRjzqKKihXpHmD7LM3hFN2uP
	LMW2+uCrja9mZg1GXBEGXDeQCZr12xVUyQk5s=
X-Gm-Gg: ASbGncvqUn2mSBXzA64oBvgDwEAe7NnmpxJ5cUxQI4RbSM1ZZWOTWvFwxeM6OuMf5ad
	cJnR+W9vchleibJdNmvs4PT7m2C76REkEZtgUwj9BW4oTPBNR9j1mwri1hbE9M7unBpUkecY3O8
	O/TA/5xm2URLnlGdyJQFw7UZzR4JgAf6HrdIj4aE9F8nEqBLmYSCR91RB1Pc4giLq2p6zZNQdsN
	bHUXbWqFvSFbci9Qh5XH+AQqEkSpQfAIRLm5lPYlSFsobfdeDl9GZYaS72TjbXLg1WXdAlzTKTC
	9BnvyeDz+ytf2beMVg8+DpY=
X-Google-Smtp-Source: AGHT+IFDh9gs6Xfs+/RVL/J/t2NGVsuVNJafDRrtG3U1S6uJvHYeab0nLFKvV5EhsD7qlxJ2kf73GA==
X-Received: by 2002:a17:902:cecd:b0:21e:ff31:531 with SMTP id d9443c01a7336-21eff31073fmr77506595ad.22.1738696278887;
        Tue, 04 Feb 2025 11:11:18 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ea5f1sm100749785ad.130.2025.02.04.11.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:11:18 -0800 (PST)
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
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3 1/2] netdev-genl: Add an XSK attribute to queues
Date: Tue,  4 Feb 2025 19:10:47 +0000
Message-ID: <20250204191108.161046-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204191108.161046-1-jdamato@fastly.com>
References: <20250204191108.161046-1-jdamato@fastly.com>
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
2.43.0


