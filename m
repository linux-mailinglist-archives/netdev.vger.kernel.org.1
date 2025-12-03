Return-Path: <netdev+bounces-243385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F639C9E9F9
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 11:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF61A3A4677
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 10:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3BA2E1EFD;
	Wed,  3 Dec 2025 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhI9phI+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7869F2D9EE3
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764756090; cv=none; b=VKkaFl/Q1/ZvyqNF60uXn5t+G5jHbljCb8es97rHIapig5p9x3FeyTLXz6fm5mCRei69ZF7gBm8t2EAM79Q3Ofqq1X8YviEMnNG9nA3nx543KuZGv0FIy6oLI9VkF4i2AGwN0mVFbQCWdYpTkRSQIdfOkytB0lCiPMwTdKERRUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764756090; c=relaxed/simple;
	bh=DNwM0vYKDwHCsQMpT7B3J90L91QZZmc41tdLYqtl1E0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=scjDUHaT+aSikVo8LxoOGWEJvU7hQZlXjKTEb8CKybti2hg+wCNvx/njEGCEZtErazAHlxd6TN1aTET89D7L8xIGWXQdMtx/xXXhVR+Anz6S+963d0zp990o7C2nhHkZH8kgxzXEqeVW7Dz8hBT9Z4dEoTXEEukO4dSVeQn61F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhI9phI+; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so11889472a12.0
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 02:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764756087; x=1765360887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P8gWPwEb7dSVJDeoCrH0jGwjEnAK0RGLIDEIFEgeITQ=;
        b=hhI9phI+WcX+Ia9ENPGg0wrBRJlJb+cbzsrqn1aFRvC/lPD2NirnLC4XbtoCyR0z7f
         LkWQzcnnBopt0A42fYyZFKVtujgQ9FlHZxq2uAiUipy1hsWlJICL2qFUihcrRqb6Vjsg
         gchJyMHgG8qknKzSicao6uGh0h79O+cuzpY3k/SrepMk7k+EGphzEeOtvkXAhdq6qllE
         cxMZI74GaDDQFmexpKbXUZtXLasIXGDfwGIFW1fEFLmsM9/p1W442eJrhSOIc9nQZOxa
         XpLVWDbQx+SHWqkz0M6gWyD2FGKK1vsbl8jW/LvV0q7wqgoF5Ckyo+gNGgQgO4Bp6WON
         YKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764756087; x=1765360887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8gWPwEb7dSVJDeoCrH0jGwjEnAK0RGLIDEIFEgeITQ=;
        b=eHq88DrPL4RoCJhiAAJPeBH/9oR8Pfn+8T4PhxSMxJAetvlfCUrW3e47Kma4i+lYqd
         bWUNrOlybp5r24I+Vyjcu6csc9cPu7723pSvblBc7osRM4K+cXTwErRQyuDTkgIzDurD
         6HPYVnVeYclv2OO+SDg4R4SKxiMmKFYcV2nswD3P66VZJxrWQg9oNdsQ7B6KfWh8gbAT
         +VdrOkS7knfYw2m5N+Y/VLsq5wNXCjLXqb4JU88bKf2IFVIeWLg3aSTWMpizO1CepkTs
         kP/F8KHg3n85uYyaKC8Q9KtKQLoAwJPhYIavLnY9AOALq1Tf4jimR/hvuoUJGjJVKd52
         uE+w==
X-Forwarded-Encrypted: i=1; AJvYcCUbggujKRIP4mYfPYRtLYQaLAItAH2KV8F96evKVdF51kyCD5O/eJyQJOf8jP9RpPWGKCzAcN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWIE9TV/OPtNcwVXHoOcE+yRwoHSlQEiTMzSFFBz8gPsQ73sz4
	FYufGn+HtgOD0gKr74ODpWxkhIjJ6AlvNfJa8DjjdMCFjb+qu1nAcRxp
X-Gm-Gg: ASbGncsVlTdcpqb83r57ATHGuJaRmqw0zM3xH1dFy3USsv3drmIWVDUOi+Snmv8slPb
	DcYobJDxiY+6EURben63UuZasfNEwUUFYl53WnqlSRv/0caWfgm7et81g04/eEnNnKR3mnWoRl9
	6d4PNb7S1Srrpo32Ukgbq46kucKAAmrsys2gInQube5lQHiP5zxV+VKFS6r5hXeJSLwruORlLdn
	Ja4xLaZV/QTvxW+cz3X1EgEpn9Yzut2558+HNaAgmcsNfYFdQHm680fGXdER6mzUHbuQL0UIVp+
	ySBGMBclIY1YT3q9h8np8kfJ1W0VccNsGm7bE3Zf4VfBhqHr+bdp96xGnaZZtEzHmibPD4cKcGo
	kGAl+OvG0tX0jhNM5wdqt4Oa32w/wSm5L4sUZRGyvQ9UPPUzIVVnfcFo/PDS/H4/bwCEeGvtA3B
	884rDVyMRzf130vRFtod0UQDZzrSZWses9mTc5j0b6PRQ5BY40ecImvqwfIqQ=
X-Google-Smtp-Source: AGHT+IHD1uymmFOCt2+j1N3ScKsBEa2nSyZWt6KqzieBiqC+wPDsG4T3k9CBXns+D0kFko6BWJkLTw==
X-Received: by 2002:a17:907:3d8b:b0:b73:7b97:5bfb with SMTP id a640c23a62f3a-b79dc51a4cdmr147681966b.33.1764756086564;
        Wed, 03 Dec 2025 02:01:26 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f4d533f2sm1753948866b.0.2025.12.03.02.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 02:01:26 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: kuniyu@google.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	oliver.sang@intel.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] af_unix: annotate unix_gc_lock with __cacheline_aligned_in_smp
Date: Wed,  3 Dec 2025 11:01:22 +0100
Message-ID: <20251203100122.291550-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Otherwise the lock is susceptible to ever-changing false-sharing due to
unrelated changes. This in particular popped up here where an unrelated
change improved performance:
https://lore.kernel.org/oe-lkp/202511281306.51105b46-lkp@intel.com/

Stabilize it with an explicit annotation which also has a side effect
of furher improving scalability:
> in our oiginal report, 284922f4c5 has a 6.1% performance improvement comparing
> to parent 17d85f33a8.
> we applied your patch directly upon 284922f4c5. as below, now by
> "284922f4c5 + your patch"
> we observe a 12.8% performance improvements (still comparing to 17d85f33a8).

Note nothing was done for the other fields, so some fluctuation is still
possible.

Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 net/unix/garbage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 78323d43e63e..25f65817faab 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -199,7 +199,7 @@ static void unix_free_vertices(struct scm_fp_list *fpl)
 	}
 }
 
-static DEFINE_SPINLOCK(unix_gc_lock);
+static __cacheline_aligned_in_smp DEFINE_SPINLOCK(unix_gc_lock);
 
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 {
-- 
2.48.1


