Return-Path: <netdev+bounces-167871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091E2A3C9B5
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 21:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BEDF18994DA
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 20:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6E1239589;
	Wed, 19 Feb 2025 20:27:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514A523645D
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996855; cv=none; b=MrxQzd/KPudUH2MtNREkDUjTS4VxdE8yOYRN5CJ+WuuQ8qNbBiDu+1ePOvzRTbCwOYq0S/UjdR/r4rrKtSmUKM6Cjqx3eNjjQB6lqUhoiXRDb+8+euVzWNAtvipeNUFXGDW5+caEamf+F8vs0cme/2/ZPsT7KR+mwLZ2M8rPQvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996855; c=relaxed/simple;
	bh=Xt/SRg5cE8VwEFTtceTF/3Z/ZKPFfNIDmluepDbpjnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5FOhhp7z24GoqmlmyDexfvX1kk6M8OYanafn0vUxWvHBqX89HCg3/oWH4xZO71JCvYsWmcmd4n2SaklAUCl77CtZ0GoXf8qvE3At+Fx7umIx5wdEDvNuXUCCZtQX67L4mPbAD4fSCbgZ/edLw4KIc0cB4WtfiOF7IkASUHUR0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c4159f87so2477815ad.0
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 12:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739996853; x=1740601653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMe2MNnkcaGV+T8TRcI0BTznwxRg23rHTwn7iJmxr8o=;
        b=CU4tHR0QPgu3If/WZYjeF2paHdYpVhuzRTDNhlO5JPGcpxGwnFNFIOeAjMak7caLy6
         ABaKh6wNCFvcFOjPyUCQ8jl+3KHkEstpt9QmAzwjj9BH+/5Wwx+CJYK9n0qQiBFjqOCS
         6kIW6Q8aECi1L4rHwwBdjXtZm8q9FNk7wzPeyvVWRIwPokceW8beAn2FtzEDSCXIl41i
         qtFSZU5FoVmg2d73pHyXgapeTjmfC1XmOMiI0An3Gq9qegr6ySPs8MbRBUa7EOxaUak3
         N7diOOHoFF2S6DKTi4AHgauNhlNlI53VnCr11/NPePSbrgG24taUNyFyfxvN5oT9kYzb
         LO7g==
X-Gm-Message-State: AOJu0YzIVfec8NeYsJ32Hdm3tQ2C8+NKsiAHn+IeyTPeiVTYM+VJebz6
	sSNHY0lDa0kvqpWuvKZuFLecfFXpTxo/prk1sYKsZssgb9zZMbAArSZq
X-Gm-Gg: ASbGncs9vZdIy6oW0RcdwCTxojhwH07fPMa/0G4BUjPKW0Wyt0kCyBc/asK8DID8/7l
	v18Wa6n24CWsZwlhA7PInKAytG4jZa0ajW3PtepU+kv7Z3URTxWmH0LY3zLPP9vJwyAKad4AgLL
	FIPUomccIyel9kg5B/11BlodJ+pUDAEXy9c+H95+pr1bgvIhIBi8wepzOLsEkf4b7rIHQwBcXAp
	64UyMUCc0eT7e20dK1sEjsCvyX+Nuhn5mFOFChoaXwvIHALI19u1DiAro8k1oGyJBxyK5SUqwJj
	TWlCNar6yW4iDT0=
X-Google-Smtp-Source: AGHT+IF/+3wIUjBfR6p0BqUIX0StSyYxech1PwjH23hgh2/MnD941OzL7pvmg95Rz1U13byZS1joCQ==
X-Received: by 2002:a05:6a21:390:b0:1ee:d656:c14c with SMTP id adf61e73a8af0-1eed656c222mr8103704637.29.1739996853208;
        Wed, 19 Feb 2025 12:27:33 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7324fb3a761sm10995197b3a.178.2025.02.19.12.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:27:32 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v5 10/12] net: add option to request netdev instance lock
Date: Wed, 19 Feb 2025 12:27:17 -0800
Message-ID: <20250219202719.957100-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219202719.957100-1-sdf@fomichev.me>
References: <20250219202719.957100-1-sdf@fomichev.me>
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
index eb44b2ecc076..4a11e78b1a60 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2456,6 +2456,12 @@ struct net_device {
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
@@ -2743,7 +2749,7 @@ static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
 
 static inline bool netdev_need_ops_lock(struct net_device *dev)
 {
-	bool ret = !!dev->queue_mgmt_ops;
+	bool ret = dev->request_ops_lock || !!dev->queue_mgmt_ops;
 
 #if IS_ENABLED(CONFIG_NET_SHAPER)
 	ret |= !!dev->netdev_ops->net_shaper_ops;
-- 
2.48.1


