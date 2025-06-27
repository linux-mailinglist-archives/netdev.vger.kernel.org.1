Return-Path: <netdev+bounces-202026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AA4AEC09C
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBF11C485CB
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 20:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5444F2ECD2B;
	Fri, 27 Jun 2025 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TeLESdPQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3D52EBBA2
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054762; cv=none; b=X8Wgzw6pLRIcIkW8GYIGnGZKrxAepL81G4FDPKNT3tIb9S1dclwaIlcWk6GgSSGYp7TUqhQ1JzMgeotF/9MYUb+fnHt4+23BGh59gzoEjCAtgLcB4vFOded2/PLv0uht3Hv8ZSSmgBAei2+Z0JLasafnzEy35uxIwQbkp2iNhZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054762; c=relaxed/simple;
	bh=Du1qZrT3TOJNH6FmPwsangSCzhKd8CnHvM4SYt9pHhc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=db6HILWAPgHIUXnr1g4rGY+Zii7WJNjtNTbXMnPDxjJhO+anRp685rFdMirGsJsR1l5hcCzbcg1uuXUjp/cQvBvZvzsc35Dw/YQY21QdklByfpg1Z8KQcWGhFIJpZ/wz/aZyzqYYj8SfuQ/+zkyBDtRCL+McGK5IMn6U0ZbvcLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TeLESdPQ; arc=none smtp.client-ip=209.85.217.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-4d5ef3b8038so70108137.1
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 13:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751054759; x=1751659559; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=57UsLn7SBpqt8BKXbwjQjMf0Ho5ZNSkxI4OBXU+iVcw=;
        b=TeLESdPQjwDkYlTHH7llYZndPQmoI8XjWzRHUP/1ZG7P2mUzoUB3U2xKu/8ovF6+fi
         QPjDCgAffM7eJ7O6jeKPqT4HgdeL/v+txuBYStBTiyfIT9KYeE93viuJ8dbwSDEKzlDu
         iH4KyhCU4z+LxGt8kYOSnWwgbW5n16lk95wI3q2HwFJV6xrEBl+T400LafbKKIxQYwJA
         HmvvAUqjy5NL8tab0MkJPeIDfX8YtDMl1RyHitPe81EePXtbBUilDL+7emAGdncjB6VW
         tttkuTBafSIOCGckaXSlTX0t+EOjBAbaNkcGgKfNy7qKm3MmrHupkYEi6B5Wp5N9indf
         uIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751054759; x=1751659559;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57UsLn7SBpqt8BKXbwjQjMf0Ho5ZNSkxI4OBXU+iVcw=;
        b=n/cPh64wHJ5wRb86Vi6G+eBjsHCODOoC1RGD/tFW05CB4E5mXt0GE/wAH9c/KPmN43
         UinluKnW2Wz8TkIn7icWmGjCQ8X8HBIzxKfhuDjlSoh5DaXpipv74v6FP9jw6IZAofxu
         aNzr+EmGdhJVebLE4DAh6kui3AnNC9zTPc7L35dWr65ZM61ojFwZWsSGvZk82ieO2qjr
         3Xx5I+8xqX4WwvX3lSY5ZGU9Rw+qOMognS+RtiWCD28na0p0QOlFDZcB2p1k6T6rIQ2H
         cijVLg9tVOQqzPRnfczn+R8w51Yq/+SFjec4IuJYCjxRJPW/etISOJ93QCMyKDxe+WKE
         PgPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFwGDfsyhc61muuAwPV55NtKiB05CDGrycCbcr4mAClJct5xz9mlmvlT52KU0+iRE6DEvxw0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJk2099LP6ZofWupTJMe/zb2w9tFN/K2DfuYGcTR5vDblr5ulX
	xa5KlBtx3mxY1YQeHy5mKDu6UjZN5WKwh0qo5Dl7iKmNS7GDYqB5EZA3D2btZ48su24Igs1rtkN
	nViy+6bfcmgAQaQ==
X-Google-Smtp-Source: AGHT+IEzXZ6ShOa4b2rxvx1lEwTHY3dYELpkYDjdIavxLGMMuz/9JHhPfjhJA3S8al+Q6BSql1rdXvuh9swtpg==
X-Received: from vsbbu3.prod.google.com ([2002:a05:6102:5243:b0:4eb:eedf:3181])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:3712:b0:4e9:b793:1977 with SMTP id ada2fe7eead31-4ee4f0a83cfmr4609485137.0.1751054759562;
 Fri, 27 Jun 2025 13:05:59 -0700 (PDT)
Date: Fri, 27 Jun 2025 20:05:48 +0000
In-Reply-To: <20250627200551.348096-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627200551.348096-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627200551.348096-2-edumazet@google.com>
Subject: [PATCH net-next 1/4] net: add struct net_aligned_data
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This structure will hold networking data that must
consume a full cache line to avoid accidental false sharing.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/aligned_data.h | 16 ++++++++++++++++
 net/core/hotdata.c         |  3 +++
 2 files changed, 19 insertions(+)
 create mode 100644 include/net/aligned_data.h

diff --git a/include/net/aligned_data.h b/include/net/aligned_data.h
new file mode 100644
index 0000000000000000000000000000000000000000..cf3329d7c2272ec4424e89352626800cbc282663
--- /dev/null
+++ b/include/net/aligned_data.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _NET_ALIGNED_DATA_H
+#define _NET_ALIGNED_DATA_H
+
+#include <linux/types.h>
+
+/* Structure holding cacheline aligned fields on SMP builds.
+ * Each field or group should have an ____cacheline_aligned_in_smp
+ * attribute to ensure no accidental false sharing can happen.
+ */
+struct net_aligned_data {
+};
+
+extern struct net_aligned_data net_aligned_data;
+
+#endif /* _NET_ALIGNED_DATA_H */
diff --git a/net/core/hotdata.c b/net/core/hotdata.c
index 0bc893d5f07b03b31e08967a2238f63d218020d7..e9c03491ab001cc85fd60ad28533649b32d8a003 100644
--- a/net/core/hotdata.c
+++ b/net/core/hotdata.c
@@ -2,6 +2,7 @@
 #include <linux/cache.h>
 #include <linux/jiffies.h>
 #include <linux/list.h>
+#include <net/aligned_data.h>
 #include <net/hotdata.h>
 #include <net/proto_memory.h>
 
@@ -22,3 +23,5 @@ struct net_hotdata net_hotdata __cacheline_aligned = {
 	.sysctl_mem_pcpu_rsv = SK_MEMORY_PCPU_RESERVE
 };
 EXPORT_SYMBOL(net_hotdata);
+
+struct net_aligned_data net_aligned_data;
-- 
2.50.0.727.gbf7dc18ff4-goog


