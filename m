Return-Path: <netdev+bounces-162762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 273ADA27DE5
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB721887A74
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B8021C167;
	Tue,  4 Feb 2025 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="J52Oj3cp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0FF21B1BF
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706191; cv=none; b=EmG33+R7T5POOjYBlQ6mvRJAaSt7ukQCGi1lRwWiFcAB7BbmqtQGGkrAeNZ+Jmmag+WJAS8bhf1tumHSym0y2/kJjYPqbvmk6+Qv+MN+owdwgWwi81Zy12hm8ELcetoyDvW58Jzmz+Cwn95MlDbbuGGbbbEztpqxFk3YXVBJVn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706191; c=relaxed/simple;
	bh=iwX3RnN9NnpgzE/vlb2BVlnnEFmEQ/G8Em5DRbix/fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ziy/GY2F3fXoFIoXCNM7JA4Mm5cVVPMr9veCx65Wp4DbyliwVjTO8njjOqvDsIBwxLvKnyPvvBDPRCkP8CKc19HhMn5UtY1Kp+u1Rgi7KEiwRL26JNpcVoYqHUUsiU5t6YqoPuxlYKte5gWKV+r9bM85fppYhc94SN7RElTnTkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=J52Oj3cp; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f13acbe29bso354697a91.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 13:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1738706189; x=1739310989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPSri8muoWoTXN531R9KlT5ZCocyL3/ObF5jo4x5P2A=;
        b=J52Oj3cpaqccz0iNFO14aXUsowdny9RsHq776IKDBarIeglsyq2GyjpR3j3I+7ZZxS
         yXSa2+b5EuauBDTus/RDCucIk+R+D4dCNgql0n0lLd607jtM9PLDevPJEpKmXRiJePI8
         NaCv1nCBs6UQlxfAf29acrP6wfTsFVHBCEGk4WehNV2rqTw4507/2EPeN9Gxj1ZsRPIX
         16MfK3DXRi//jIIAVK/F0Ag68JG+QeBfmpb7hykni7ibHtvxLaY8UpZE2jrosyIJe+LS
         8ZhZitd13abngAB/Km8JFz8IflUFf+1UyowyBZqQVNQlGpx6sC99664PzRPTUb/TT2ap
         YfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738706189; x=1739310989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPSri8muoWoTXN531R9KlT5ZCocyL3/ObF5jo4x5P2A=;
        b=ppcDVdSm7DlKpMXGg49WERFSHfA2DccVrdxP24pouHxZo6dsC9U6T3+C/goZS1C/S/
         lyxKZS5KicJttrghGJ4il4yyC70iultp8KXU+h6exu6uE2INRXBZLZMNalSv49XWUJ0a
         ix3RQ6MK3sexi3Cc32MNt4y48ME0wrbchq2YnlvE1K2DYua+doOTgWTLq1ujlioMZ3DC
         H6adaH7D14VzriaB05bpK0R5Xy7OoqqIYmaKwl+a4TPbkNJhGYWiC+FWA1dZTl+yiVcs
         27sf6Kh3cPf1Pm7i21EQdv4GQqpMy3qGT00RvBWYONq8VnpXeDNmFaFDt0t6ha+pNxt8
         /SMw==
X-Gm-Message-State: AOJu0YxmW2w3X32QNBbEoCDRcu4nUock2KCeDTOXaituBqkIy5SjIZGE
	rrQgYBoQ/nNr0FSsS5rc0CFC1VKxhTRBBef7T7Kq6duGZC4S3IJrpkqaJftSgJJjZKDK7WeLEaQ
	k
X-Gm-Gg: ASbGncsK+DNgFMis4h7znJQedc5/DnQ0JTA6GLAU6b+xNBNltUFpLr/wvEd++BqoFx1
	cggQmJxSRZhqh/xFBoFEQ8+xDH+4+84H/S9LauTuQ1MChoh54/4vlgZXV4uST+sd96+FlhLU5tz
	3Or/J1Hhx32WtoZ7zBGSPaRwCYxrlYZhnwxjP2Fkjwf2XIa1Y72cBS9XODNYlGRi+eQ++zzauJE
	LviYPNSHJ+CNI+GDXNNlVJxgXii7CCRfzPSUg3AbQIKDAUfhslMFCjMtzZ0uMWC+i79oqNRsh8=
X-Google-Smtp-Source: AGHT+IGkJfXdujRU0F8nZ6hdYhVO5j5ImD/O0TRvDZK+ZbotWaEdBuH2VVaRcUnlK5mYeCQG3oVABA==
X-Received: by 2002:a05:6a00:3a19:b0:729:1c0f:b94e with SMTP id d2e1a72fcca58-73035131885mr923620b3a.6.1738706189241;
        Tue, 04 Feb 2025 13:56:29 -0800 (PST)
Received: from localhost ([2a03:2880:ff:e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a1a773sm11179239b3a.166.2025.02.04.13.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 13:56:28 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
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
Subject: [PATCH net-next v13 05/10] netdev: add io_uring memory provider info
Date: Tue,  4 Feb 2025 13:56:16 -0800
Message-ID: <20250204215622.695511-6-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250204215622.695511-1-dw@davidwei.uk>
References: <20250204215622.695511-1-dw@davidwei.uk>
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

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 Documentation/netlink/specs/netdev.yaml | 15 +++++++++++++++
 include/uapi/linux/netdev.h             |  7 +++++++
 tools/include/uapi/linux/netdev.h       |  7 +++++++
 3 files changed, 29 insertions(+)

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
index e4be227d3ad6..6c6ee183802d 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -86,6 +86,11 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+	__NETDEV_A_IO_URING_PROVIDER_INFO_MAX,
+	NETDEV_A_IO_URING_PROVIDER_INFO_MAX = (__NETDEV_A_IO_URING_PROVIDER_INFO_MAX - 1)
+};
+
 enum {
 	NETDEV_A_PAGE_POOL_ID = 1,
 	NETDEV_A_PAGE_POOL_IFINDEX,
@@ -94,6 +99,7 @@ enum {
 	NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
 	NETDEV_A_PAGE_POOL_DETACH_TIME,
 	NETDEV_A_PAGE_POOL_DMABUF,
+	NETDEV_A_PAGE_POOL_IO_URING,
 
 	__NETDEV_A_PAGE_POOL_MAX,
 	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
@@ -136,6 +142,7 @@ enum {
 	NETDEV_A_QUEUE_TYPE,
 	NETDEV_A_QUEUE_NAPI_ID,
 	NETDEV_A_QUEUE_DMABUF,
+	NETDEV_A_QUEUE_IO_URING,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index e4be227d3ad6..6c6ee183802d 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -86,6 +86,11 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+	__NETDEV_A_IO_URING_PROVIDER_INFO_MAX,
+	NETDEV_A_IO_URING_PROVIDER_INFO_MAX = (__NETDEV_A_IO_URING_PROVIDER_INFO_MAX - 1)
+};
+
 enum {
 	NETDEV_A_PAGE_POOL_ID = 1,
 	NETDEV_A_PAGE_POOL_IFINDEX,
@@ -94,6 +99,7 @@ enum {
 	NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
 	NETDEV_A_PAGE_POOL_DETACH_TIME,
 	NETDEV_A_PAGE_POOL_DMABUF,
+	NETDEV_A_PAGE_POOL_IO_URING,
 
 	__NETDEV_A_PAGE_POOL_MAX,
 	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
@@ -136,6 +142,7 @@ enum {
 	NETDEV_A_QUEUE_TYPE,
 	NETDEV_A_QUEUE_NAPI_ID,
 	NETDEV_A_QUEUE_DMABUF,
+	NETDEV_A_QUEUE_IO_URING,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
-- 
2.43.5


