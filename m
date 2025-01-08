Return-Path: <netdev+bounces-156456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC86FA067CF
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5321888312
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC692046B6;
	Wed,  8 Jan 2025 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="BAV2BZ3k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AAF204687
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 22:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374027; cv=none; b=Ugl3BaJRDuS3MDodrvw909LWVylbxXocGPE4CjRy9bqBGe38k6HYD2QMdI660VJCyd3RcgGHKIGq1liQjKvyPXqd8+kbeeYgcaqDM38P3kV9MJdUEPlfJsiYJgjXatw5GdmRrQqCpo9qKCPxDxE8q0sbfK8v1HL6mUxnLXn2nv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374027; c=relaxed/simple;
	bh=RN9FRieTmgxqv0c+YKrWG+l7gQJLp/gap7HunHQoqkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxRyjSGLWbdLxhZXLhqNer7cpvcVz8j88MXnQS0uqBpfICEhAO9sFdp1A2xdazxujZgy90wlqgr+SfrbeUpDj/PJY2/UOhmY5URlHe/yFLR1SU5fgbCgCAWs30AuYxrZnsnLxxGFa81tV+OzmBVelHpFebNaHhvrOTLXtwGXk8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=BAV2BZ3k; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so401655a91.3
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 14:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1736374025; x=1736978825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BJhQIF+q/BdwFZrWY61E+04UcDJKhF4LPhTAqO37Wg=;
        b=BAV2BZ3kQYK6YyEsezI1M8hrzvZs5pJh8WP2ve3NvkeKK60GuSHIblp91jGSHwB1mM
         nky2Hg/boYDQVEyGdpcpfbYfFYcUq8wr7LyUS1lc9oYWTmQqwXiCV1Uz0oTJsNS5PB5r
         vf/cRwig1oVZ4TGSqOgLlZ8tmQQ+CqRXB+HDG8sIADBE2hFxGi9cqNPahffFib4uKQ2y
         QavVf+isq3xY/ZF5+zswvCXJAV2WrFnkTW17qsju8cJROYRiEt6HDlVGPz8wbO+2BSUi
         iHVw4Rc31Y8KxkrEV24leFxHvM+JM9Rs4QpTNADFe1EZYiY4aaRrl6zghwq/A6/GQk7Q
         Cb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736374025; x=1736978825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BJhQIF+q/BdwFZrWY61E+04UcDJKhF4LPhTAqO37Wg=;
        b=NnEmptrjZOXKQKLiYtLHLbmzdZHvWt5J3U0w8MQPWGy1yyuBMr5qIEHuFRD8iZAG/k
         Bt75ThMYU92muHTEaOn9dNQL9Kx1/s873swGnPU80sHJvR4MMFRJDRJveP2aZHbPkDXJ
         hmQxBif2t1bJ4iS8hCdqhElNlBNeewXBfvGKM0kiufWLqzfb06xFBCCH6vI5txFBNh5y
         KmQB8wUtvS7mQ5S26abZyS1CQEel+Y9yeyRUmfTPoyBdITzmP6aSpHLHixAbKGkG1ffa
         t/ubXQ5tagaVVJIlJ/qnl8eDIdLvkIqvU24GvNFGeyGfIVh74E+wbpHmZvEl1k3ieIXR
         CeGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHDsqE559G0jTcqXlBTU0IeJrtYoeoezQ4BRe7NvVQQtykncfD3UYpYdcVH1ZeqeKK/Ef+mKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrQ6bh3yN7MDebuDpG2FAd8WOS5akPnTTIfK4abHHjFNsPq3cm
	uJAPUXxeqo1IQ2Zed/klqvLKvs8SCCbGASK0ifpCcpJPyjlzvPBElej+XjJ8A0Y=
X-Gm-Gg: ASbGncvk9jsiaWedLA/nT1qUE06X0dZT5bB5NbZ71N40dqclw8L5xqKc0h/tgWDIqGc
	/mfe9NO1tjzhhisivHoZ8eWtJ0wn+HJ65vb/BD4dtyTaLDopvq3Pw4p0pFNKcaSLXypBuy+tbsr
	IeC7/ppRmglGxnMZmfZF7NYSCtXVrRNpEd0p4iSCgBXwO4zQeojBeoQRVgJPXNVOUp8c+DVCos+
	61sWg8P2nRXoEF8/v1Pf72ebv51bbTAbDDS5yTsGQ==
X-Google-Smtp-Source: AGHT+IG30t7WuCDSwHCzEWAOGT9TEAdPgdISqVX1a/HXZhmUwyes9kCEGDD0QvKCmgEhlrcZgDT4AA==
X-Received: by 2002:a17:90b:2f0e:b0:2f4:49d8:e718 with SMTP id 98e67ed59e1d1-2f548eac0bfmr6895925a91.9.1736374025407;
        Wed, 08 Jan 2025 14:07:05 -0800 (PST)
Received: from localhost ([2a03:2880:ff:17::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a2ab6e8sm2096423a91.23.2025.01.08.14.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 14:07:05 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
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
Subject: [PATCH net-next v10 02/22] net: page_pool: don't cast mp param to devmem
Date: Wed,  8 Jan 2025 14:06:23 -0800
Message-ID: <20250108220644.3528845-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250108220644.3528845-1-dw@davidwei.uk>
References: <20250108220644.3528845-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

page_pool_check_memory_provider() is a generic path and shouldn't assume
anything about the actual type of the memory provider argument. It's
fine while devmem is the only provider, but cast away the devmem
specific binding types to avoid confusion.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/core/page_pool_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 48335766c1bf..8d31c71bea1a 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -353,7 +353,7 @@ void page_pool_unlist(struct page_pool *pool)
 int page_pool_check_memory_provider(struct net_device *dev,
 				    struct netdev_rx_queue *rxq)
 {
-	struct net_devmem_dmabuf_binding *binding = rxq->mp_params.mp_priv;
+	void *binding = rxq->mp_params.mp_priv;
 	struct page_pool *pool;
 	struct hlist_node *n;
 
-- 
2.43.5


