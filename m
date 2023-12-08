Return-Path: <netdev+bounces-55429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D7580AD4E
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92C5281C1E
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ECF50242;
	Fri,  8 Dec 2023 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwYtWjaj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA8E1729
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 11:45:30 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5d7692542beso23455287b3.3
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 11:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702064729; x=1702669529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ia8qknjLKSvKTXzYAjgYpkbB7UyTjbmhiTr12f51P2M=;
        b=HwYtWjajxN1LMfckP+y2zZJuVQgKJ7O6MAn9bGBNDX3Zu77RZ8fns5EW6MuE2kUW0O
         pK0A+BQroDMrjUnzVY95cY67LcpbmcbgRW1gGAn5UitDdCxgrGGhq/5Oug5lStD8ZJDC
         ivUxum4RF+7zh3yWUxB5aoFptsz433D/S69JaQ4kuMhz6urex9ijC22/qEUOxMfB4PHS
         4APaBzOgh3N7f92bZKhC5PTgqrumiQSDNYm0lYjmj4gJD4nRGIYVi0ZwUyN8bC7XeYI5
         d2HNIz5zbMrS7n+glbS3E0d2q9xmmmySqk/yDRyvp7xn4V8MjH0gPeFItm7fYdYO8G3G
         9BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702064729; x=1702669529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ia8qknjLKSvKTXzYAjgYpkbB7UyTjbmhiTr12f51P2M=;
        b=EhS1x36i/WZSL0eWeat0VYb077xYeSuy2Q6Hgkkaw0bR/fk8bU3X7uKN8XTCErrJCT
         gzW5U8Ngkv64i+L13ma6X2CEC02LZ+riTgBNlAKPcvU0l+4WKXS3Z3k4SZuhtovlF+Er
         xAGQnvmoBRm4c7EinoMhCyxH+7OTUx+eOlE15ngqgzewSyBpT4Y9BeU/Pk2C+H+ijvwl
         b+frJSkDhCzWVQKOQQpaw132wBVHqfLchvoYkdmMYImnRYSfEZSeg0eYZUxlqGDlZ6JN
         uAdo9IUXY+FaL22/cXNDOy6PLsRjcWHn2OmmtPebFXaYKYpuxbeFFWQgbgOmsG1UB295
         kw6w==
X-Gm-Message-State: AOJu0YxseKzum/16qU9qPyVF1HHICWsBMNFufqrnVaQOti9g6LoPe+/m
	aMy6KbwLSNw6wrwt9CR40ZVGcoCjD6A=
X-Google-Smtp-Source: AGHT+IGl9u7LIy0hDWc3fr/1Ruw8rDr+gL996rv7KpdXZ1+j8HZ2BHVFe2lwPgcQny1Qn+BpxatwLQ==
X-Received: by 2002:a0d:f347:0:b0:5d7:1940:53df with SMTP id c68-20020a0df347000000b005d7194053dfmr490277ywf.87.1702064729175;
        Fri, 08 Dec 2023 11:45:29 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:65fe:fe26:c15:a05c])
        by smtp.gmail.com with ESMTPSA id w5-20020a0dd405000000b005d23b8a7e1bsm887414ywd.91.2023.12.08.11.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 11:45:28 -0800 (PST)
From: thinker.li@gmail.com
To: netdev@vger.kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	edumazet@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net-next v2 0/2] Fix dangling pointer at f6i->gc_link.
Date: Fri,  8 Dec 2023 11:45:21 -0800
Message-Id: <20231208194523.312416-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

According to a report [1], f6i->gc_link may point to a free block
causing use-after-free. According the stacktraces in the report, it is
very likely that a f6i was added to the GC list after being removed
from the tree of a fib6_table. The reason this can happen is the
current implementation determines if a f6i is on a tree in a wrong
way. It believes a f6i is on a tree if f6i->fib6_table is not NULL.
However, f6i->fib6_table is not reset when f6i is removed from a tree.

The new solution is to check if f6i->fib6_node is not NULL as well.
f6i->fib6_node is set/or reset when the f6i is added/or removed from
from a tree. It can be used to determines if a f6i is on a tree
reliably.

The other change is to determine if a f6i is on a GC list.  The
current implementation relies on RTF_EXPIRES on fib6_flags. It needs
to consider if a f6i is on a tree as well. The new solution is
checking hlist_unhashed() on f6i->gc_link, a clear evidence, instead.

[1] https://lore.kernel.org/all/20231205173250.2982846-1-edumazet@google.com/

---
Major changes from v1:

 - Split fib6_set_expires_locked() and fib6_clean_expires_locked()

 - Use hlist_unhashed() on gc_link instead of checking RTF_EXPIRES to
   determine if a f6i is on a GC list.

 - Add tests on toggling routes between permanent and temporary.

v1: https://lore.kernel.org/all/20231207221627.746324-1-thinker.li@gmail.com/

Kui-Feng Lee (2):
  net/ipv6: insert a f6i to a GC list only if the f6i is in a fib6_table
    tree.
  selftests: fib_tests: Add tests for toggling between w/ and w/o
    expires.

 include/net/ip6_fib.h                    | 46 ++++++++++++----
 net/ipv6/route.c                         |  6 +--
 tools/testing/selftests/net/fib_tests.sh | 69 +++++++++++++++++++++++-
 3 files changed, 105 insertions(+), 16 deletions(-)

-- 
2.34.1


