Return-Path: <netdev+bounces-164901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D25CA2F917
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BE816686D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5262D253F21;
	Mon, 10 Feb 2025 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="abmVMmn/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA67253F10
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216368; cv=none; b=KSHRQwlbrf6wED17tPlAEawseDhz+QYmqKLYyw6C5LDMNl7NHZeMNEicogL5AzLXm5KP5MEZAq9jpQUKSqMWYoywvuGq+67MuCYoMDo8041TAwvuAoiBzIdWB5gFsCSizjZovDDh/zyANF51r357adwSULY0+/YTEERp9ERhtH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216368; c=relaxed/simple;
	bh=hMmqLC7rYBOTSWKloyLAMgjzYZ7GVSeG1WEosbA+PJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpmiLA6bBc41ODClhSsAIKeYGnJaBIKTouoeyPJ6TqwUL6xgUMJeP5XGdhZA/YktMqRDeBFUuzvvlLmfnkpKFYOcc47aVaxKI41v8BztY8NBSsohzHLacK+AQXnJaIXnAUX7YKEV3iPPWAXvisdOpFJWpTbG2xB/B4MMxQDhRYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=abmVMmn/; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so1565196a91.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739216365; x=1739821165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjSm8SciJzh3IllyDU052OHbkLq8PHE5L98omSDGOLg=;
        b=abmVMmn/NbJp1ZOshLZu90Vm5VGiUOixYZmY90VuYcXbs6/poT4/YqmCvutDOgC/7Q
         EMpg5vXqs5NQKAQ6sUSo6U/RFaFANHj12UsPs9xrvs9WV8Hx/YrAXblwYIDo4E6pjATP
         3nhqri1zRRDcDBmwcjofT3DNDJMvs2Mggy6EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216365; x=1739821165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjSm8SciJzh3IllyDU052OHbkLq8PHE5L98omSDGOLg=;
        b=HpLR+SDs91iLJBcUza50P7bhFtTK/sNq69XOaZW+0msZSpqkbM/ftLpuenH8fTQYgZ
         9nk17HZJolbnKXwhOCEmc5x2W8N5X3J662P2ROX2fI6Sa9mDrBM3YEUmhzeGwH1H7lj9
         6lOLMfRM8uxTET0y87tmuEoES8Ak/QteVGChwHPJKxcRHRrFtusuAtLMc1hEiq62hNCg
         xMOaLwtSoo/G41F1pGrtwqZemTHwP+2sPz5VdSOo3tWn8vucaw/W5r0eDT4vbUYfwBIp
         /M81VfjrSA6MesdreUEPelqS/nw6sHNB1uhgAr1HMyAg4mTzkngif6OMyBjd6fnZ5ZQI
         nJyw==
X-Gm-Message-State: AOJu0Yzz+wiFbmxnUur41exrPq7/E7WAmX8lAcs1nw0bukTl33Ce9Ae3
	2pdy+ZKRx+8jVZ0jhuhBYbFAZT9vnnmaAaeop+z5lEirUizA2JC9VoLZF5WWVORFsSo0I+WGfXh
	j0HLNn7Iuokk29NkpKAM2cSDnxBHfVhoUT41eimpNRdiVXdW6T9BZS7WN1e5EHF1CfWcXytUrhd
	h4ombkDbskx7Yq3pCB3tiO4IsYtzc68hVdjSA=
X-Gm-Gg: ASbGncvGy+jQU1+fDGsuca4Vbwd6vjlwkAYVF8c6R80X5N1rOAWlCxG1NuSsxNmhBUO
	Vt+HNDVOZrmQJMBlz/vZb2xcq8kX3s4GPig3UYspR2Pp1DlyEIMRKU44be9rcftMXZmRLYYdtej
	MPeV6BVe3UmBQB2OYLcrycVyp52YaHAAf5bqL3KhD6bDMBC7hmEidCI5t4Cm3t2/8VX0NLNIUfx
	B2DKETye0qvkE5hMGprF8sW6JjXucXlgKAurwIzDvU444gdjNjv/DgjDimI8jFOTheI+C4R85Cc
	UgnMHV6w3xdX5L0YRZMefXM=
X-Google-Smtp-Source: AGHT+IH/yLGsQ5ai7U7Bkr2H+eeSCW+22PccYgnQz5Obbw7zdbZ6IeR4y1tv0W+bzubZOpOmWCy85w==
X-Received: by 2002:a17:90b:4aca:b0:2ee:f80c:6889 with SMTP id 98e67ed59e1d1-2fa243ef19cmr26320757a91.33.1739216365432;
        Mon, 10 Feb 2025 11:39:25 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa2ecbca6dsm4226510a91.0.2025.02.10.11.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:39:25 -0800 (PST)
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	David Wei <dw@davidwei.uk>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v6 2/3] netdev-genl: Add an XSK attribute to queues
Date: Mon, 10 Feb 2025 19:38:40 +0000
Message-ID: <20250210193903.16235-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250210193903.16235-1-jdamato@fastly.com>
References: <20250210193903.16235-1-jdamato@fastly.com>
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
index 0dcd4faefd8d..49b2b2248821 100644
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


