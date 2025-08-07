Return-Path: <netdev+bounces-212024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 545C1B1D51E
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 11:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6533BBA65
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 09:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4A8277CAC;
	Thu,  7 Aug 2025 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVVuUJo5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56F5277C90
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754559920; cv=none; b=qwQXSnZES0mshGrXfAeG4F6Zfv6yFzGiu41Z8HmoocticWlS4ygJlNpRVxWjdv8OUgUHfagf8wqrNie4KzeN2lrfRlkjtrjo7ghuWELHFxYi5BTtbN9wDzllNtff3C5k9R5acf/fcTy8rhsoRiOV7PdD65yudWyWhkRhoTxVVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754559920; c=relaxed/simple;
	bh=9CWqCoQd69akCMvnUCstVkxnK5EnbjHX63MZgi2hMIk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UUTwa/vnTzzE8GI6hQk9MJ3Go9+EukdDL2r59aap8AI2Y835uD6u5xoTXaLyTKAu2f1axAnCxtvHm9seiCJGJsk4k0WqvqEgTV1Czz9Qh4h0hrsrbdgwh3hmVK/ljG1aqoCT6Ivkw5kAwqhwKsyMNH6oZvDgryLbwvqHWVTb6ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVVuUJo5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32147620790so949735a91.1
        for <netdev@vger.kernel.org>; Thu, 07 Aug 2025 02:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754559917; x=1755164717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HqQFCr0puXBzxV1mM1+sQ3d9n1yvLLDEaN09Eux/FlI=;
        b=FVVuUJo5MVhgnf8wUYdsLSm9Zyq/ItWPTtbnnoc8GnP96kr3/ddACuMxeDKb/aIMeW
         jGBpLuHqlr0Ca3lDFxGVrKugrg94Zt8K2SetT/fYiVdmMEeqXg98vaDabY13tfqVAfsz
         RkosijVk+NjfAfIpYv5spQwzb6AVdBYJCQU63oIMpQH/nLAYrugqEMMbQMvlarF57Jzw
         QoS5WpClz+EzuqCVgxFCiLHTEbpBXYhlulhTPbSKsMpErIbDgKVF2Lp4IjxM7+A0LKEC
         mn33mIzYKnxqAr90VwCe25VYrAS2WFWdAhE3qNoMYrxL9kZtfhySJ04w2cb1AYvRGNvu
         /HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754559917; x=1755164717;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HqQFCr0puXBzxV1mM1+sQ3d9n1yvLLDEaN09Eux/FlI=;
        b=oFqYAb/qoG/lOpCvUh0jQg4sll/u0UXC5U+0OUuC5SL4f9vDzF35ODQcEDUduBKiUQ
         FQPs3Pa67E3zoX+YHY1h7Ww39Oo38jwo6qJ0ay6FqsE0ApVQ1w74twjjo8SUVKO7SCN3
         0tEfM4+hmZ2yTCsPJtHc3GPuBcLhT04aQj5ZXPfLCsdyBjXtaI64seKVz2931PkzKxIk
         84z/YUjLWcF4XMsCfKpNSZCJBoZ3JnUOWTUkm0eatLOb1LANzvxgEQrDsjWbUZZRHaqj
         M/d6zJ1x0S8QTaObDGXYeHM0xUt6HyoQFEOxrHj83mQb3yho/CBrCSevPLXfxZOTNGxB
         MTRA==
X-Forwarded-Encrypted: i=1; AJvYcCWDV/u/p9q8RE/6UBDk0dE8/CfDYk5AUhzh2zwNREKoLlI33jY6qXsNZ+RbaLGY5lKCXMCw2VA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1wQ/mapHdIrq3Z+80nlUzLPoCUk9hrdttZO2l5T1UZ0F9kWDZ
	ebzdAgPik68AIWxWepczWdw+RBhYO9jtul8B4Xc90NoK3qD4ePRuBhD7ZBuMVqL5jqFEpLFU+l8
	1mw==
X-Google-Smtp-Source: AGHT+IGgGH634jFvBjcMTqZUObCM6RH+x7mywZlvBZG1zN7YFs+cGifnMo7s9AOHUwNXLTWPVeH0PKoJEw==
X-Received: from pjoa7.prod.google.com ([2002:a17:90a:8c07:b0:31c:4a51:8b75])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1347:b0:321:729a:a421
 with SMTP id 98e67ed59e1d1-321729aa623mr3699563a91.32.1754559916863; Thu, 07
 Aug 2025 02:45:16 -0700 (PDT)
Date: Thu,  7 Aug 2025 17:45:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250807094511.1711013-1-wakel@google.com>
Subject: [PATCH] selftests/net: Ensure assert() triggers in psock_tpacket.c
From: Wake Liu <wakel@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	wakel@google.com
Content-Type: text/plain; charset="UTF-8"

The get_next_frame() function in psock_tpacket.c was missing a return
statement in its default switch case, leading to a compiler warning.

This was caused by a `bug_on(1)` call, which is defined as an
`assert()`, being compiled out because NDEBUG is defined during the
build.

Instead of adding a `return NULL;` which would silently hide the error
and could lead to crashes later, this change restores the original
author's intent. By adding `#undef NDEBUG` before including <assert.h>,
we ensure the assertion is active and will cause the test to abort if
this unreachable code is ever executed.

Signed-off-by: Wake Liu <wakel@google.com>
---
 tools/testing/selftests/net/psock_tpacket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/psock_tpacket.c b/tools/testing/selftests/net/psock_tpacket.c
index 0dd909e325d9..a54f2eb754ce 100644
--- a/tools/testing/selftests/net/psock_tpacket.c
+++ b/tools/testing/selftests/net/psock_tpacket.c
@@ -38,6 +38,7 @@
 #include <arpa/inet.h>
 #include <stdint.h>
 #include <string.h>
+#undef NDEBUG
 #include <assert.h>
 #include <net/if.h>
 #include <inttypes.h>
-- 
2.50.1.703.g449372360f-goog


