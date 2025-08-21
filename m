Return-Path: <netdev+bounces-215474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3405DB2EB9E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 05:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD187B1B37
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7072D480A;
	Thu, 21 Aug 2025 03:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxTbJJqq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40605239E69
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 03:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755745437; cv=none; b=Rj3YuhTN1z27O8cmpGsvBwB/D+riwNtVc4ckUTAOfNTSPPu1VK5QC8IE8nPBxxsrBG5uXIywZ9wiUjdwmklYFLbqcJl3byEe9IMiAdQIhGsI27GecZrbpHCtEUQCP+Ef32ZLWw1dWc1q1lx9xIC5zSTkKOaLJfZRyfO/wKpKhFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755745437; c=relaxed/simple;
	bh=WQxV8eCKHDLNTYuB8FbxXXtqUtwpbbCpHsCWGZ5+d4c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LeDXLvwJrLv8ZPnSk1N4TdU/5irjDJRQnAWUfQRrD58+rHF3kimgEZnAqmN27kBoBYweqNanZlgkLqlcLJLDzRaqaU8n23A4Lrn3+AS8FZItLttizmCHby1gJ6gKgr9piiWvE05aYrr4CLm7bZqWnBQPsBRxZgRIZVKZe+fLUqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QxTbJJqq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-245fc7df071so3665205ad.0
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 20:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755745435; x=1756350235; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xsyX6nC2qbqoa3IXoqz2x0SSkvlofANuq+KCkgDhw1s=;
        b=QxTbJJqq9OFEoSbSAmDvGDR+vK9UrFvowhqeRG5QcbTiYp9LDhOCvcnUOOMKxklpci
         MZoukyNKWHtH47c79aRZMigr3xdrcDhHmZI4RG4JycFEUnvkt3/ykVWGxN/6sdOW6urf
         wQQ/Pipr3DrXQsNcDFNVSQyPJgotV8GGJgW3fYdTAvF0nxZlx10AUxpFaBYbGIhPEwG+
         mH6pZKXmdc4BeLgOhzR14953CVEmwfp7uZxdaTnqkAknh9XdEPGjjlPvbzAdFsaIPAUi
         EbvF8UXl/cjpV9ST9BiRTNTHjIVswtcAdlYQqvk7Nmty50RghoFJyhtjln9dnHga5t5N
         HcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755745435; x=1756350235;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xsyX6nC2qbqoa3IXoqz2x0SSkvlofANuq+KCkgDhw1s=;
        b=uCWdXpzAQ+3zh+q+FDuARZ6BLke5b4tkwRtbHMUTYTxws+Rw2jEegkCoShZK84VK+R
         j7/bLRBEdJuxxcHWdNAotaut1c2H05V3wjA6+Bs796xESS2wr7pArPqcCo6Yg+xv/6Xp
         djd74gs1SVRuX4GZj8JYdMQ/fmcbuks3bkUG6/7vZY3b2bbo/PJahHtaazaU5MZB+TGv
         aI1LdN+qYSVmcV1xV3rn0T7h0SPxDvsirtKFoP9ZJ1oaOydY6Q0dX3FmOTkiNI02LyRk
         /vfC11FgfI/5rrWlbcGtOFEZwsmeziJ/6lw8pH4wcKleeaXW9nLnG3nxun5QLlHuKiuG
         5H4A==
X-Gm-Message-State: AOJu0YxdH7Ul2XUobX7eAgl7l8Hmrw9KMdFYaYNrf6IGOMQ3dYmriyxh
	b+3zJbOhJ46jHOneaJQ5RXUgHXmIC+gCbgNe81FJ8iMkIfxZTBRem0BtFo3GPDEw6iAX5fhnRha
	wFBN/pqCk/toOMhnNkpikVrmu5HiG/zkF09xfaKQDwB30ukQgQ+aMxuKsf5f3ryqAMP0YnPZ8c7
	WNon5Rn8hBAJYi8F1lBmGEAUCwbpkZlXjz7dHVHwnGtWwhT5SWNuhvbjDPsuAVgVE=
X-Google-Smtp-Source: AGHT+IF0xP14Kr/6iRhQeskJ7eOXNJ0cD0inA3ghPz9y2YArBHaAeKeUcbp0uSaUE723wItGWda/EaS2MDoc0Rymdw==
X-Received: from plhv13.prod.google.com ([2002:a17:903:238d:b0:240:5505:5286])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:15c3:b0:245:fb83:25da with SMTP id d9443c01a7336-245fec07a9dmr12898165ad.22.1755745435498;
 Wed, 20 Aug 2025 20:03:55 -0700 (PDT)
Date: Thu, 21 Aug 2025 03:03:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821030349.705244-1-almasrymina@google.com>
Subject: [PATCH net v1] page_pool: fix incorrect mp_ops error handling
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Minor fix to the memory provider error handling, we should be jumping to
free_ptr_ring in this error case rather than returning directly.

Found by code-inspection.

Cc: skhawaja@google.com

Fixes: b400f4b87430 ("page_pool: Set `dma_sync` to false for devmem memory provider")
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 net/core/page_pool.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 343a6cac21e3..ba70569bd4b0 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -287,8 +287,10 @@ static int page_pool_init(struct page_pool *pool,
 	}
 
 	if (pool->mp_ops) {
-		if (!pool->dma_map || !pool->dma_sync)
-			return -EOPNOTSUPP;
+		if (!pool->dma_map || !pool->dma_sync) {
+			err = -EOPNOTSUPP;
+			goto free_ptr_ring;
+		}
 
 		if (WARN_ON(!is_kernel_rodata((unsigned long)pool->mp_ops))) {
 			err = -EFAULT;

base-commit: c42be534547d6e45c155c347dd792b6ad9c24def
-- 
2.51.0.rc1.193.gad69d77794-goog


