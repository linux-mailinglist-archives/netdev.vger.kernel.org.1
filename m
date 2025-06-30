Return-Path: <netdev+bounces-202361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FAFAED8D8
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7531886E42
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 09:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6253246BAF;
	Mon, 30 Jun 2025 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s35wKdMn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EDC24679D
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751276147; cv=none; b=KpUrH5WWltoQV/cqaR0rcAHbV16V+8Yd5+PHqX7fiBHEiFHtAvsgtqclJ0OAe33yM+yUHTSGnNMq2vmPrW2YraLOUjJHkNxXnmqsgPdVgMSoOQYPhJl1B9ePVN1apzGld5Xda+q4ZT9AmjsueMXmboVt07u0OFX6mNcGrHRKyG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751276147; c=relaxed/simple;
	bh=ox1mnmNRyeX2rX6eJiBs/6xcHWU1+ilcr8oDrL8Nht4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DDgrshzGnOu0z4fTE6k3ATJRGjA7S5GGI7IfiS7jMPUwoT900ifX+Ny95t0Qb81jPzaN5sn1pcR7KrKGXKbCdx9YNagSPoeriFAa0bX+QOMiZfQh1YVCuArswtJPb7kzHgPklMNdbJC/VpaiA90Pc6hRnQwgePakV/Hn48wYrxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s35wKdMn; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6fb1f84a448so18525076d6.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 02:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751276145; x=1751880945; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N1+nhCRwmQCGzufOp3Ydp6B4HR8f8fk/P6h2k76BTvw=;
        b=s35wKdMnVlq70RLAWribNgMOANaXdpIkMfdMQEbXXVr8eW6nSKGf1/JFzfKWRTwAae
         r57ZqWtwhRN8Ix6a57gEJIJeWP5mm3zGXV1Q1hKfKkfDeQ3DiXtrCGKNC7+5iosnFZvi
         zxu4jEs8QTiTeHY1F9tH1cFfOV6JMBtnhCYPRrAmWhwRMGCX7eNZDGPOa81fvrnJrJ4g
         p45UG0UYWXQv5WiqhL8OuV9vkJvOUnN31kQMdnZ65gU6dziWmz/fxQ5PaHqLykJFnbLR
         IcDyMKfHnsRWs462r144kX4IUT5y8jHAl1cirK7+4of19A8kk1TN18btQQn0953B2Bcw
         rxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751276145; x=1751880945;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1+nhCRwmQCGzufOp3Ydp6B4HR8f8fk/P6h2k76BTvw=;
        b=fSW+Y9BWu1bs3iCiKc3Td7lOhyTYQcfKfCYhg+6rOu91p5rVKH1heNUDUupo/XnzNx
         Ff90pLJtYSUgxgl27DQ6P2Mh0grk3VBzbiJhOfBXN83wmeCG7oKItKGqhcQ1g9BeZyDV
         9r3yS3cbX8oipE5mSBbCMs014+JKIfCyHs8/5JrqO+NBTx0houLnKvg3fm5A0tts5Pov
         gSzjToI7REh2fKkbgZS15FpuDn3pjhduUeA0s3mcCn2PdHGP7VW9U6HuHznykf5FFap3
         n2J5J/YNnd7NUQ8CQfN8aLGFMk+Ggpbc+COktC/7tOVFpaDywyvBnHktKzr3dHkijFE/
         6gPw==
X-Forwarded-Encrypted: i=1; AJvYcCUhdOu96rN0Y0FtIEDrm84hcflu6LfJFpr/28HwrQdY83h4zu2iTAPLNtwUEgy1j24hrwBgEng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx0DNXnShwiKdzc+n7yqh3AI221obvEfkAljnJVtWYE4t5+3Q8
	La9WORiZTGwP30w+Uuz8zu7RuubZVyIeYpqnA/52iIBtxobxjtRHqKBUZ2ZitkauUykGmxk0jr2
	IWFd8WxTghuunMg==
X-Google-Smtp-Source: AGHT+IGhI8DtjEUDksWPtAUsmR1bQkEd2UZGQKE+LI5a8DetzGdcy4O/Myzb8we3idAMc6W+Il7T1zDJTtY+zQ==
X-Received: from qvac21.prod.google.com ([2002:a05:6214:8215:b0:6fb:4dd0:2483])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:76f:b0:6fa:c81a:6204 with SMTP id 6a1803df08f44-6fffdcff257mr185025526d6.10.1751276144955;
 Mon, 30 Jun 2025 02:35:44 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:35:37 +0000
In-Reply-To: <20250630093540.3052835-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630093540.3052835-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630093540.3052835-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/4] net: add struct net_aligned_data
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This structure will hold networking data that must
consume a full cache line to avoid accidental false sharing.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
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


