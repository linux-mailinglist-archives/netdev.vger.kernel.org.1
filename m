Return-Path: <netdev+bounces-170576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2100A49098
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 05:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FB63B851F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 04:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE971BC064;
	Fri, 28 Feb 2025 04:54:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741C71ADFEB
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740718449; cv=none; b=OvkPpUaQ+uV1uAfARgf0QETlOIL62qXD9roYwQmkUJd+193ij9CwIEvdl+PG/cnsQjD0FMbYpBxONWwAs7Jdbr4hzsAaNgckbLfyh+MIpEGJHCR9Pv5g0+jkGjTPYue++XsIyU1j6j9eUFXi/blunemO4PSfLxMGERE4ic+ruzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740718449; c=relaxed/simple;
	bh=9GiT7L4h1luVUM8cTStiFw368eZQXH488W4KA610ib4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t68a1Fu+Y1vIcDjgRl1qawGBDL34SV/a+FdwD93AUiQeDuBAb7oelCnouEOkVZFR5n5EcrwXE83mUcuB+h0R/cVsCxtMMSdkZqTIEsky1R1aeOffSAbTOiXCJ6Ff9EUDmkcllTsGgcF+4j/OpwA8KRgiaMRUrK8JOV260rZ1KSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-221057b6ac4so27436355ad.2
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 20:54:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740718447; x=1741323247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Utg/GA8D1tIDHyPHqqvW1lSCX2gznfLGXZdJnASz7U=;
        b=IQtW2n/ipTI68JLi1UoWVFjBll0qZeYtHB26RfNCYeVSYJppMBAHPttjeCRBK8TRgz
         HqWcoFQihRilOyYTujtotVcc2JlwLtm4puhCusTozjMYzHeO21TMRPg1gX9fJca+q++O
         kbjdXvaRxbunv09OqPTM1ijBiwuE542hadG/T4+rO7YybVrtdbPFyCuOuJ/FeobINai+
         rIs4/TUwbKgCFP2Cc5DGWuxbPlWbuCKlfOH+VhxuKB24tdUFU2j8b72ZjU9v8InvuYwV
         X8fzzJS3ejsuHIkQfInPyogf+ha1bbcPRrXbJXqurnNA2Sg0M8ekO0N8aE8clmRfW5Rh
         xi/A==
X-Gm-Message-State: AOJu0YxUQnFqnzZQwoiEGouzsZxi80r38XtoCTy7DjXf1ugKNh66VAlZ
	TDXeomo60dOLSpJLiV5MHlyNULgYvy7W16wS+z6MBZBep0/1OAXWS131
X-Gm-Gg: ASbGncscGFtcQEeDoQBJy0HPAh0l7HU6Y5JkLHNL70sBumiEKML8nyEWT9QeoaY4pp8
	g737XzU0MZyJ/mKvOne1XZu1Cv+hGWHhRF8L4cbft7Dh4PreKEFYtICn4W2RzFAxcG3Amq08NQF
	8KqjEU3NLJ3aYGDf68FgiYpjltsR4fmSd14aJdkRWiZmUsxz6E8B6sxcAd4+XZ3xHcwFq9iSvcR
	//xpNt6Aez8ZI9OIo7/juT7Bg4KfgROkEHYv6iQc5DqwXiTXNttuULf8UHB6+xTlYrvUU6m0hIO
	7lidBSQaLfHVKx+hlA/HSDJFCg==
X-Google-Smtp-Source: AGHT+IHl2XnoEKmfyInbZ+fmdimAaq1ooS4M56KNzgmEJq7gyN5wIoEhfv7gEvo1h1H0zlMH01MWyw==
X-Received: by 2002:a17:902:e54e:b0:220:c113:714e with SMTP id d9443c01a7336-22368f95697mr33579045ad.21.1740718447504;
        Thu, 27 Feb 2025 20:54:07 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504c5c67sm24516325ad.135.2025.02.27.20.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:54:07 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v9 10/12] net: add option to request netdev instance lock
Date: Thu, 27 Feb 2025 20:53:51 -0800
Message-ID: <20250228045353.1155942-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228045353.1155942-1-sdf@fomichev.me>
References: <20250228045353.1155942-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently only the drivers that implement shaper or queue APIs
are grabbing instance lock. Add an explicit opt-in for the
drivers that want to grab the lock without implementing the above
APIs.

There is a 3-byte hole after @up, use it:

        /* --- cacheline 47 boundary (3008 bytes) --- */
        u32                        napi_defer_hard_irqs; /*  3008     4 */
        bool                       up;                   /*  3012     1 */

        /* XXX 3 bytes hole, try to pack */

        struct mutex               lock;                 /*  3016   144 */

        /* XXX last struct has 1 hole */

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/netdevice.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index efa0e3755a27..1813dc87bb2d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2485,6 +2485,12 @@ struct net_device {
 	 */
 	bool			up;
 
+	/**
+	 * @request_ops_lock: request the core to run all @netdev_ops and
+	 * @ethtool_ops under the @lock.
+	 */
+	bool			request_ops_lock;
+
 	/**
 	 * @lock: netdev-scope lock, protects a small selection of fields.
 	 * Should always be taken using netdev_lock() / netdev_unlock() helpers.
@@ -2774,7 +2780,7 @@ static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
 
 static inline bool netdev_need_ops_lock(struct net_device *dev)
 {
-	bool ret = !!dev->queue_mgmt_ops;
+	bool ret = dev->request_ops_lock || !!dev->queue_mgmt_ops;
 
 #if IS_ENABLED(CONFIG_NET_SHAPER)
 	ret |= !!dev->netdev_ops->net_shaper_ops;
-- 
2.48.1


