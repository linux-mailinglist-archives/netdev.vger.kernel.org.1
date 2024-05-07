Return-Path: <netdev+bounces-94121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEB88BE43B
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 15:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FE11F252E6
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866CE15ECCA;
	Tue,  7 May 2024 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FdZDml55"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1933B15E1FD
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088441; cv=none; b=aoXN82CtEQXR2sMRcfGX0KImcVFBQveJH1EA9jdcwP9FskSEwd1OJz22nRW2xClYJeJs+YzIU/fUP6FE6gYuLAYXK4aaBL5G4Sc0GiGi9bKqAFeprl+1vm7+e6hBSbmCjeD4/l4aC0OSLYXPsy4oUXshgXxAxpm0XmJVXEPVero=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088441; c=relaxed/simple;
	bh=sDGYYcasbmfoMfvOhJtTsK6fpJUouFH+n1YhiZngR8w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gXrSC9gpVFsU83GbCwG3cOTlG1MaMxYXBEF1bfqR+BuccrfF3/t8tBc6jwk0PwtrlC6NmY565hUM8VFQUoy2jlUJBPahtwNoSNN7QRIJraYwFa6/tyH6H+yCXVbo5qmoCEmhP85y0z0Hd3D9iYvsxAs/xcw4ah1qR66UL01Yv8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FdZDml55; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61beaa137acso56473357b3.1
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 06:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715088439; x=1715693239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uJ/xlVmMc6qta+w7l88i+wDgvHBii6is57sK87RkHr8=;
        b=FdZDml55i3yp/fUjozDyU0GDxIa7twkP+5+FGJkqqYPNkXayyHDpBZJWZMSO4FjL2A
         kZhGV+/+n42YMFRhyKrpdlba9KDQwbo3TF4/fQXI3EqHi66r32TstV/iLlpguXjeIWvD
         oeDiyELYjMRqSerVZlWHSl94eBXto8loCHLezb1gj7z5zY8WobPhv/KU/KkR6na6YMdY
         NL1tZoEembpVLOCv1UhUL14a6qMfCkbIsaut/Zt92cWbesrz0ja4F2b9VpZlA8BnIBwy
         aZAt8kJHqj6v+AiW64vB84PU+YRh7zUsjEbEgOi+/VkdwVzOy0A2C6ljUDZXJTvQ7GBq
         ssRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715088439; x=1715693239;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJ/xlVmMc6qta+w7l88i+wDgvHBii6is57sK87RkHr8=;
        b=DKUjlUzugu0wY5HB4c30+CoAV3xg48O3yXhH7Djy2epNjCnSsZU0ax4wiKihzo0Ksl
         47+X5uGTUVhbsM7n5hsYB9R2RwobPzb1khUHbFvuFiW2EBg5HrnFgwgixGUO3+iNUn0W
         I1is1LMQS9JtfmIrGAmJ+/ShDBDgPbDj84XgJmFOiwMhJCyi4MdTFuRkdZlfjgHUUwHE
         UMOvBTBl+3Svj0ngGqtwa4MNihWdP4t7Ln7KjtGWOCedMCNpayHg4ZVNUyp4LeG680Fp
         DvdnJe1OwBOLZ5u1dVWu1jTs+Z49ribSRNKHL1xoKSYA/tABGuqdbNYPvUOdFMYvZtw8
         HnCg==
X-Gm-Message-State: AOJu0YyhvIgIh1f2MoL3rAdVFYCF93v636MSp2fLQcNEdnfnJWmzVjnE
	GBod2NAFsS/0WL/y2jCQbs66Nd2Pm26r7G+yF7Ci17d6QIwE3N9PzVXZSt4A2KlszBPjqMYmDk9
	wMKJsdHK0RA==
X-Google-Smtp-Source: AGHT+IEn8y1OUWEml2mAg6ZEkapDQ7fhjV/LcduH2rPhmvMwp48sutbVDMk8+hkL/biFtQhpPswTXLT+vlOc1w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2b0a:b0:de5:2ce1:b638 with SMTP
 id fi10-20020a0569022b0a00b00de52ce1b638mr1425536ybb.0.1715088439115; Tue, 07
 May 2024 06:27:19 -0700 (PDT)
Date: Tue,  7 May 2024 13:27:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507132717.627518-1-edumazet@google.com>
Subject: [PATCH net-next] net: dst_cache: minor optimization in dst_cache_set_ip6()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

There is no need to use this_cpu_ptr(dst_cache->cache) twice.

Compiler is unable to optimize the second call, because of
per-cpu constraints.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dst_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index f9df84a6c4b2dbe63c6f61fb431e179f92e072e0..6a0482e676d379f1f9bffdda51c7535243b3ec38 100644
--- a/net/core/dst_cache.c
+++ b/net/core/dst_cache.c
@@ -112,7 +112,7 @@ void dst_cache_set_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
 		return;
 
 	idst = this_cpu_ptr(dst_cache->cache);
-	dst_cache_per_cpu_dst_set(this_cpu_ptr(dst_cache->cache), dst,
+	dst_cache_per_cpu_dst_set(idst, dst,
 				  rt6_get_cookie(dst_rt6_info(dst)));
 	idst->in6_saddr = *saddr;
 }
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


