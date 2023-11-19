Return-Path: <netdev+bounces-48993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6963E7F04F9
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 10:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D6F280F1A
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 09:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957DF7475;
	Sun, 19 Nov 2023 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="UpJnNI1g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900F8126
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 01:25:46 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b2e73a17a0so2363651b6e.3
        for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 01:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1700385946; x=1700990746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FD0yKcX7kb1gSGQ8bjxMh0bsMglpu98y3UOeL+swq7s=;
        b=UpJnNI1gUBRN5wInuTBJwDa0M3BX3ItfR9/62g7jCoGn1Au4zpDw1NCriO4KISsfyd
         XLaOHrHqZ+xfI8MV60hF/1suplUD/D2ZoxVuL1QUDXfvHgLdm+SwCgTd5kcJKLxkmx5g
         XgKpkdG5BmSdsuPqBaaWT+DaBIzR7T80pbn+cNaPIMc19qzzZ1N0MgJlKkazmRuFfveY
         aFfyngqgmHoed7TyFOGj8n3RheNeLIz1sp98RyG+lEd9JC2oB1EowvsU0H8z+P1OOgqe
         PKhFcgWv9/3auf8Dyh3I7p0HzemFogneF+/jJgMM3VB4Zc6xNjA0l0Mtj0yDc/2oGFg6
         tm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700385946; x=1700990746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FD0yKcX7kb1gSGQ8bjxMh0bsMglpu98y3UOeL+swq7s=;
        b=J8nEA1E2lL2Ythm4+l4XEpUSQltHoPzYbERBkV8Y7F+GYw+ox3G0qzefmER1eZzx93
         i0OAR6gAD8V8MqzeRN62GKRzG+SvgNRJquZQU9aZc+0q4VdZW8y8G7EzFsnR+MmYNfW0
         vb3v9Yd5uqtXPtNutpnN5MKM4DZSqfmG3JbidrCz0JF91kZuFrq45z4iGjqCuyS0et9c
         WR21/5HzzH6M6SD9EaVewnpSPgI9BFERX0oAB4+wEeNIchbKb9emiatPn+mn/heUXQFs
         qsy+N+GPaS9S0YMQbiSi1Y9M53ENgfNtshyMJQU8ZX3nyqPNFpOUdTMdjCf2zxkkazMd
         Qikw==
X-Gm-Message-State: AOJu0Yz68pMzQasVtgqE5+I73k/9kIfnH/fZjc1lUNkbs624m64lwzza
	2Gln81btHlYVKTzrpgtYWENQOA==
X-Google-Smtp-Source: AGHT+IFO3PUO8cjn+I99JfAVxnBNNpjCqvobLaIcZMSfHpc3ahoKwFZ3EOdta2OymcCDqTlB/F73Cg==
X-Received: by 2002:a05:6808:f02:b0:3ae:3bd:d3d2 with SMTP id m2-20020a0568080f0200b003ae03bdd3d2mr6355804oiw.10.1700385945893;
        Sun, 19 Nov 2023 01:25:45 -0800 (PST)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b001cc0e3a29a8sm4060770plh.89.2023.11.19.01.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 01:25:45 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: edumazet@google.com
Cc: andy@greyhouse.net,
	davem@davemloft.net,
	j.vosburgh@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v3 1/2] bonding: export devnet_rename_sem
Date: Sun, 19 Nov 2023 09:25:29 +0000
Message-Id: <20231119092530.13071-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CANn89iKsirkSvxK4L9KQqD7Q7r0MaxOx71VBk73RCi8b1NkiZw@mail.gmail.com>
References: <CANn89iKsirkSvxK4L9KQqD7Q7r0MaxOx71VBk73RCi8b1NkiZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch exports devnet_rename_sem variable, so it can be accessed in the
bonding modulde, not only being limited in net/core/dev.c.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
---
 include/net/bonding.h | 3 +++
 net/core/dev.c        | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/bonding.h b/include/net/bonding.h
index 5b8b1b644a2d..6c16d778b615 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -780,6 +780,9 @@ extern const struct sysfs_ops slave_sysfs_ops;
 /* exported from bond_3ad.c */
 extern const u8 lacpdu_mcast_addr[];
 
+/* exported from net/core/dev.c */
+extern struct rw_semaphore devnet_rename_sem;
+
 static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *skb)
 {
 	dev_core_stats_tx_dropped_inc(dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index af53f6d838ce..fdafab617227 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -197,7 +197,8 @@ static DEFINE_SPINLOCK(napi_hash_lock);
 static unsigned int napi_gen_id = NR_CPUS;
 static DEFINE_READ_MOSTLY_HASHTABLE(napi_hash, 8);
 
-static DECLARE_RWSEM(devnet_rename_sem);
+DECLARE_RWSEM(devnet_rename_sem);
+EXPORT_SYMBOL(devnet_rename_sem);
 
 static inline void dev_base_seq_inc(struct net *net)
 {
-- 
2.25.1


