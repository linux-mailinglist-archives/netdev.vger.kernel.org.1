Return-Path: <netdev+bounces-178204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 468CCA75789
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 19:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A02188E88B
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 18:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE861DED6F;
	Sat, 29 Mar 2025 18:57:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EAA1DF97F
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743274640; cv=none; b=b300gRtrvF21OTlu/omOS97oYG/W3b9Jp7iC/KsIVoKzSTxN/1d3vwazOzHVRg9vd26TnVQCGz1VIh4Cp98HQtv9+9ujE8D2xb15ohsozFQj4N4Zu0orbrdINCCwxw8yjJjfTlZj5aubAA9LebBF9bTjqXxm4fEGrl9/KyRkOpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743274640; c=relaxed/simple;
	bh=Btql8D+z61PeUR/qioHKtwL89Uw5YMz8yU1zPEYt1Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVC6VYtDIZ5pZF94e6XXZGOlhzyV0Yj1b2gjiEekeYJrwNXYcxETH9DGDPY5EXDLlGSGFym8rNSNYaHM6j7O0DdnegogrnYXgQBy05WFGD/s4O6eezZKdMA7kP6i6aGkQ+w6Obxq3MSYpohn6kG1E5PNxqL1Xms7pL/rcf4Rp5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22435603572so63825015ad.1
        for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 11:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743274636; x=1743879436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGUsnZ7P/Gy4hwM2m6cRQua0QteAzaougsYbfzZVkYM=;
        b=nwXHAXZbtsczmXiWoPyTqKh2ol3UtVe1qTY4429y9j+QaowwfQqPH3dZpkjF0iU+z4
         u22Y9auJucNlJr8Os/t9G+xHF1s2lWIGKXRrz3LXMdts8rRraY24HSOtGAL7bVu/rMEb
         K+iUICPRR0IGkc6T7fdtkEW5nMbAsIgLNH8DeRSj+7kxcwRv7YEnNpz2pIHiBcnaxVWG
         HgC6s6SLRlbLXDiEvgsju5NfjCIIyvnjoU7k7ttZiq7rhvT5w7MyUez+juMDbWSdz55F
         b7HuFrHZ6l1m5wdNgKLakXoAosebVCuytkT24sG7vFGLoa3RMhDxl23nKN20K58zC1Ot
         Gr2w==
X-Gm-Message-State: AOJu0Yy1VcmwP1a0OVJUWLZuhnArsMQRFRG7Oz2t3wR2+npMB3Z/cxUl
	5n/ipa4m+3jA3Br+F3umFnZGcNCuSAUOv5pjULWZWoTIRFLxtNfu3pJuVWo=
X-Gm-Gg: ASbGncuRBNwFsO5OOzukCXQ8P4/te71vC+0s4rSUbxL/ZLUUAfdRhtI/oM/nXTalcAr
	LeuMAbiolpKj/zKarcKHTyqAJMKpFHaDSGbAfD7VTYKJHF61MBtPLPHquPIze0I5cRZq2V3WVs3
	GdV4O60dAwN/MFUX5UYiv0NFZ8xJLIWN8VHgy4h1EDnmIz8nj1mMvs+2kJU1YX5zGHGUnP7ft0Z
	aIb5QhFnRLhyCYdy86jFzxeXXsNHYiaWKIxgKjkK8pyv4aRB2jfO/nXOKKbNDlIFhX+hop9Znfu
	KZBOLszbloFcX2CaKAAOp45NuS9/7DJBm+fBDJytG0zI
X-Google-Smtp-Source: AGHT+IHbm7PkZHY8e1VzU2s6E34GlqtHbIsjuKb4txeQWe4/xiBp9A++Qh7ccLBWHtE0OzKJiphLDw==
X-Received: by 2002:a05:6a20:9185:b0:1f5:81bc:c72e with SMTP id adf61e73a8af0-2009f778828mr4639733637.33.1743274636352;
        Sat, 29 Mar 2025 11:57:16 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af93b8adc83sm3590126a12.56.2025.03.29.11.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 11:57:16 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v3 07/11] docs: net: document netdev notifier expectations
Date: Sat, 29 Mar 2025 11:57:00 -0700
Message-ID: <20250329185704.676589-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250329185704.676589-1-sdf@fomichev.me>
References: <20250329185704.676589-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't have a consistent state yet, but document where we think
we are and where we wanna be.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index ebb868f50ac2..381243c002c1 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -343,6 +343,28 @@ there are two sets of interfaces: ``dev_xxx`` and ``netif_xxx`` (e.g.,
 acquiring the instance lock themselves, while the ``netif_xxx`` functions
 assume that the driver has already acquired the instance lock.
 
+Notifiers and netdev instance lock
+==================================
+
+For device drivers that implement shaping or queue management APIs,
+some of the notifiers (``enum netdev_cmd``) are running under the netdev
+instance lock.
+
+For devices with locked ops, currently only the following notifiers are
+running under the lock:
+* ``NETDEV_REGISTER``
+* ``NETDEV_UP``
+
+The following notifiers are running without the lock (so the ops-locked
+devices need to manually grab the lock if needed):
+* ``NETDEV_UNREGISTER``
+
+There are no clear expectations for the remaining notifiers. Notifiers not on
+the list may run with or without the instance lock, potentially even invoking
+the same notifier type with and without the lock from different code paths.
+The goal is to eventually ensure that all (or most, with a few documented
+exceptions) notifiers run under the instance lock.
+
 NETDEV_INTERNAL symbol namespace
 ================================
 
-- 
2.48.1


