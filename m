Return-Path: <netdev+bounces-242850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 114C3C9565D
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 00:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2370E4E05C5
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 23:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494472FF64D;
	Sun, 30 Nov 2025 23:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+se13Sj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3002FE585
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764545737; cv=none; b=KparahwtNzjQLvNStSQp/J1dLQAfwUBeMhw3itWnskrzRw7rwdxceTS08cm7lj/Yk+DChghsq6zTynyL4PLr1FHSPfzKSTMYaMMSzPc+CqBTofNZto0hQkYQtDqTa8S1zqrxygDSOkWsZ6JIDZmBKajVFvh+ZducHhREutWvXac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764545737; c=relaxed/simple;
	bh=J+v78DVUuvU5F3kifckIxv2vG5fH2TZFf9LLLr3M6jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdEa0rG3G73zt5gVxxLTdlp1tZG7K2mbiHG+YDzEXqbcQHghUw734eDq+3AGlko5RyTlmRS2WmqrCXS6eUIE12vlirABehUGTqG5UMUIv29GrJJ2W5djCFgs+UhIhiALgLV6w0aS/jiPzsv+EA/gHU13WBcucsUV7SrVtpxiSDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+se13Sj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso18657005e9.1
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 15:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764545733; x=1765150533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGfI5v2bo8QpS6mN8gMlhUgE+Lz+xF251MkehL1RpaY=;
        b=S+se13SjkHj/Mp9LCNMSncllJh85+8gmEePKyT9QQ1FeU1NvA4/hKKHhtgxeY22vuA
         RezFwgh7Zx6Tvg0ocqgegG0eczuKVtH2u3dBoZV0GE86hPg6BOGNtEX4DHQJVlSHniIr
         rNaablOfsG333wImhegHcAcvHj+KnTDJiw0aFsWHNStAn6oXX50ViBNQ4iMAIgLqaxOM
         AhuwWCzFBZSgZJw14DjgVoa8icC/ZLgZAGsgAa4oZdx/vRpTJksBJWpriR1ABkAVL3Gx
         rwo7hR9F5GiAGeEJBhr/wqfzTqitjKfSqWIjJdL0iShISoRwma0XU4o0vdhkOkjnmJVK
         E37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764545733; x=1765150533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CGfI5v2bo8QpS6mN8gMlhUgE+Lz+xF251MkehL1RpaY=;
        b=Kp53t7VKROsxFbUQeIGfN6nzAoBpaKzhw8kaQrKPt68DAqxxMYrNPBWhldSpUQLUhf
         PdxbczDLwQatlPvdLE/ZiKEX1nvnuCNbbM5RSsTGs3oRAD7Ku+f3KlgS4sdALVnWLyJJ
         A2EvEfBriU3iD/TZKgSzn5YpGRxp9jlpw3kfNCLEm4jYFlzBP0vf4RFgM+VybCSJ4TsM
         yAXKvkFIhXSTUGvcJPCpzmgFirVfe6JXE0fGrJVN4yAyU/n/v7OBIlfvWiYJVM/owTh+
         TlJX+gg63Db/bAP2U4fEQL2dUs1y6PoxA/64wlg2lPiIx6j9LLVCLsPB1fFCdu6MmEyJ
         ZuYA==
X-Gm-Message-State: AOJu0YwQHkD36Oz8aP6TEkKOTysZpymLZz705pVOrZyQ+Jf6qV6fJN8F
	wSiIwjs2NaI+p+U09jZbtxpvHRAvy3dBd3vIKXZKl9HgqSdmbaEh+BceyUIB3Q==
X-Gm-Gg: ASbGncs4kwGXF6WX9qEhNpDU9VMqjhR0EK+Yp+8JXlwOhizD/4Oe38I+iIgrmL78aOr
	gUi+uRTku0mwPS6NVy5KwCQ/9iZkhDmufRYa+2X1pOINUZPhG/I3oxDSHK+Bgy+4mpcZzBLYKEi
	bnpz5+lwOK6P3EVoQ7o3eP0dUWDYk8iSmQQtkA2p199UnVD2VAeS5DxQbLhmirqTHDHhZmENaQM
	cWmHadeJtPzA36oyq0cqQ8GoiOb2UGKv46AgtL33NboJ1AseJ0TX3y2qsOPF1mnFmnJnXjD8JTM
	+UiViBkzhX2MHzy2AaBkE+5LuiicMvgIzf6+PXG30EUikZFM+09MtWLQ/rVIhAekjJxw+XDxg8m
	9N65+0AGDCxo0zOkObhsy1BE3edUIRVGmJU1r7AFUUzM/gM/jKP+GuckEqBhvtahpjoAfBFTpu5
	801GDOnBulqEK8mqaYxigH48xsunsVkaphdMBgtLcJSDMFKWeeklfj+kszhWMeM2y7eewuDezYO
	znqqCd91SnywEwXZHYfa46ce/E=
X-Google-Smtp-Source: AGHT+IF67CntAQ/arhcWo5ytqV99C28dV2Q49OsMgdQEXfIMhJP+Hcig8yH6oHJJ/T2ZRfd3/soE3A==
X-Received: by 2002:a05:600c:c490:b0:477:b734:8c41 with SMTP id 5b1f17b1804b1-477c10c8596mr322154935e9.1.1764545732812;
        Sun, 30 Nov 2025 15:35:32 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040b3092sm142722075e9.1.2025.11.30.15.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 15:35:30 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Yue Haibing <yuehaibing@huawei.com>,
	David Wei <dw@davidwei.uk>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Joe Damato <jdamato@fastly.com>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	io-uring@vger.kernel.org,
	dtatulea@nvidia.com
Subject: [PATCH net-next v7 1/9] net: page pool: xa init with destroy on pp init
Date: Sun, 30 Nov 2025 23:35:16 +0000
Message-ID: <02904c6d83dbe5cc1c671106a5c97bd93ab31006.1764542851.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764542851.git.asml.silence@gmail.com>
References: <cover.1764542851.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The free_ptr_ring label path initialises ->dma_mapped xarray but doesn't
destroy it in case of an error. That's not a real problem since init
itself doesn't do anything requiring destruction, but still match it
with xa_destroy() to silence warnings.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/page_pool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 1a5edec485f1..a085fd199ff0 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -307,6 +307,7 @@ static int page_pool_init(struct page_pool *pool,
 
 free_ptr_ring:
 	ptr_ring_cleanup(&pool->ring, NULL);
+	xa_destroy(&pool->dma_mapped);
 #ifdef CONFIG_PAGE_POOL_STATS
 	if (!pool->system)
 		free_percpu(pool->recycle_stats);
-- 
2.52.0


