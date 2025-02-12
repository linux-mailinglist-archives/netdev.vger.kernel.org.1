Return-Path: <netdev+bounces-165546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C52A32763
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218353A8577
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F8D22331E;
	Wed, 12 Feb 2025 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Psn+i1jE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BA321E0BA
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367730; cv=none; b=cQRs6t5//8QmdisrIJstIUIEbUFAYI9x/3XDI22ysy+znmfnmQ0257mwmvRmT3a31K4QND0x4JeB4CkkCF6Z9B7TgOOWg3H8FQOndRxWm4NMipxATOa97uY5n/XEcQhufuNznnok53G4JXEbADwjF9BabxzNlWh1PhObgUzrVls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367730; c=relaxed/simple;
	bh=TV/csn2MeuCyr9NpkdQjzCj+Hi5ItYyxW+2FTOAo7ag=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5yEil/o1fK/9b3GyHsqmTaq/OAd+7uOHBIoo49QrtJtSwjVbG40n6zaML3ZN8jnUoOu9GwT194wcCtsp62rWlG4gACb7Bw4CsxaNUoYPxvHG38yPOBpW5uC6JhNeeASsXuSWBnzWfKAvXUx1UNhybnSNSvQQ2QCaGNjNgqmkg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Psn+i1jE; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de64873d18so7480198a12.2
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 05:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739367726; x=1739972526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+hJNHXVdFzI/PjG9+nE/x/pwz5kjQzwUzjrVXRDNdk4=;
        b=Psn+i1jEqNn8hGMuLxLLHZgyuqCvPYNgKoQzbcw7YuaFwYs/0CzTfxJmavOE5ZX3g+
         eyMumXlmsu1cMRACDyTcUKQH2yyujY2K8lePkM++hqgbAEqzP804GOOoNtgw2jfF0Cjz
         u+LGNtkleVG/5/GCcTS9aZcJVRnTmUX9LdU70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739367726; x=1739972526;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hJNHXVdFzI/PjG9+nE/x/pwz5kjQzwUzjrVXRDNdk4=;
        b=uKVc1RbQxQwhGxR1cLeRnbx9qOBMlUlGdQA5euk/6kSoyOKMt/fMl5iwRwGKp/13Ov
         YT2hNgTqM4JRB00QE1TAtU5+3z8FLHQMyltHOW4f+WgpbnaEpNM+eNsuHNqemPH0HNvL
         jR1j5D/bFoTjhmo9kOUZc0z/qOxApV6rSrOxJEycHl7m/ZfdRnAkwa5TCYDJOp9Cwh1+
         4jxaGEcM4dss82kkwNc07L2Hbg4/FbMMmQpBFo4+hEl73YUNI/qA9AtpMzk7ndkEleCD
         LbGs5bdpOj61yYSqENWWVpWcjSlMPF/tpWTB4JPeJuowbiYebJOfh4ucG2UlN9307VUN
         SpDQ==
X-Gm-Message-State: AOJu0YxU038/LCen8Y05w3y8N6PNAOzadtDAvWB6t/+JCD0k3XtX5lAN
	2OWiyJOlnfOJysqcyACObWBbI3tY5bw83EMHHoQyxQuryJWkKGxrEUMA/8Qw3vJ8+NknPoe44lQ
	kHAOChbP4L+Yy6viliNtEIRmkvI6lKyCiz1ds2JyuZnKDRm/V1Co=
X-Gm-Gg: ASbGncujJY6+GCAHfY7wbBsGJ72ZVlsaw8QZW+NA4a16u6jIxMBM8oDSz1FpNvXV3gw
	AiWFJxSrhBXBLi70kBHaQdgE0LYhyFTyD+gFLxbCI2COeVuA8O2yQN6T+P7F2Hmf2t8rSd/+iZP
	i0J95+qnWrYCNhdgf1ke2HXkGl
X-Google-Smtp-Source: AGHT+IHKB30+TzYECFLvw4UW4QXtX7+Ra4ihraMnLZsD4teEZZYZi71gLqZDwPC2TABhZhs8RUcrHUzDAItnTqUeYlo=
X-Received: by 2002:a05:6402:34c7:b0:5dc:1f35:56a with SMTP id
 4fb4d7f45d1cf-5deadd7b8demr2864231a12.5.1739367726306; Wed, 12 Feb 2025
 05:42:06 -0800 (PST)
Received: from 155257052529 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Feb 2025 13:42:05 +0000
From: Joe Damato <jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212134148.388017-1-jdamato@fastly.com>
References: <20250212134148.388017-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Feb 2025 13:42:05 +0000
X-Gm-Features: AWEUYZmNVcSIQGW9iq-Cs6PnCjWJlzSOCN6Ng4591Xu9dzdyrBAFRcC8rP7-8oA
Message-ID: <CALALjgw44T3tHWVUCPXe1vQZ-2LcohxP+Zas6yHubMOjTeoLbA@mail.gmail.com>
Subject: [PATCH net-next v7 2/3] netdev-genl: Add an XSK attribute to queues
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, stfomichev@gmail.com, horms@kernel.org, kuba@kernel.org, 
	Joe Damato <jdamato@fastly.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, David Wei <dw@davidwei.uk>, 
	Daniel Jurgens <danielj@nvidia.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

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

diff --git a/Documentation/netlink/specs/netdev.yaml
b/Documentation/netlink/specs/netdev.yaml
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
index 0dcd4faefd8d..49b2b2248821 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -400,11 +400,23 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp,
struct net_device *netdev,
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
diff --git a/tools/include/uapi/linux/netdev.h
b/tools/include/uapi/linux/netdev.h
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

