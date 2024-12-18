Return-Path: <netdev+bounces-152977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFD79F67D3
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A2C16A35F
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB0E1BEF61;
	Wed, 18 Dec 2024 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1ca3TGc+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D74156879
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530436; cv=none; b=rCkBBkhFrSZ5BXPftKYWaTn8yjYfhmjFMDbgzh5nGtLcNXDGM4T6K7MAfLlVko61McckbTZ0w0M0wEIvvjHpTct908PfN1WAhzZuq8dtNtbCaRS27YrIJtQeQPqbLozpk8/z+5cDC1K4yFqgYiusSK4dIj8IgaNtWD8jWUYl260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530436; c=relaxed/simple;
	bh=qmLse6/arsVHMl7nChpv2zM+lH/KOoVYEodZAGFr8oM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WwySi0YjxMiHpXetFngFK0Wbbdq+femNsrjKSwLfE2n9BOxhTRu4kl9QsklQPyvFIkvFHexWV7G4I418pU8GPOHJGkkfyZcSfxdBnQ3nmbfqAELQASd9yT0zV8NsZ+3YwZkRqSp1dYAXyc0qFzQTzifA5SrZByDLPQtz4I5kJl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=1ca3TGc+; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6ff72ba5aso396337885a.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 06:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1734530433; x=1735135233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SVF9Kq28WaP0otnc1frLq7fdAh6vv0DbUvUHNkUhFoI=;
        b=1ca3TGc+VGmS0BpO5hGf+cnI6R0i/kIluNR9tdPqhkaeZskyiZ6ko1rAwfn6N8gvNI
         9gQ3WWm7iWgpbwHeQ7fbbO8GTzgrLvB+fjh6MDOqx9G3A8D2RCq9GXFct+5cAXKz0kip
         VH4XEFvmZ7gYRzXs0GcjUkxrG0PYIyfXRxsEADqkf2wPk1WgFYSQubyTHedGFuaYKx6W
         BE5PiOA2ZqrixQLEFfiiIGCA17S0qaAk3bQt+e25tWeMpxbRkl9HO1gIfYaIXekLOjBj
         KHfA6/5z5ln3i08NUhetWvFr4LwqBGx+3uTLixZAgB3viNU5C1+QaQiEwm73OyKp45zY
         cUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734530433; x=1735135233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVF9Kq28WaP0otnc1frLq7fdAh6vv0DbUvUHNkUhFoI=;
        b=pFkVQGdCYCxPGCOlhZY++qh88ZZx6S14FGHf8NkfiFev0E5RRVkmAbZnUsolfHdbYp
         +NJPdBWb3AX+Ft99q288gXI6SUA0iwDu4gLi4vanwxnojpy1I48u2aWRSZ/bViGxEuhp
         gISxvhDryMOCbV4oAx1KZE8PCbH0gl7q2rXox48IjoOl+Wf+4RSvtxc8O9OQ4b1EwFBG
         Lur6zAXY2xMifoqjrHbkLvIEyMXn+TXbjwhQJYXgZgriyDWxIZjDwJz3PuYjakApV2xb
         fEcCNaCnR9fiEPGr0aVWA08dLd173ScAGvvaEYCJzSpapDLY4dvu4Dy1ja0JIvw0p4lw
         guPQ==
X-Gm-Message-State: AOJu0Yx8ZQpITHlOz6ZppXwE8pbrgm6dYFj5wWKg8X4nwVVRsWTzM4w8
	iXwLQ3rQ2ivFtyZqOCNlL9Fef9AmLgXhW8F1VEqJlyec5lrKov/59a9cEmtqGJFyWcO/NBX48bM
	=
X-Gm-Gg: ASbGnctQjJSvwySrjDOYfZrn0T8OpQs5qyCZ2q7Amz9I9LfEm7msLxXsLgYFJCczZd1
	zpvZXyrJljMFSTo8IXdq680lxzITtEmf3tz0vPLwFs6HmkeZsSlx0CUoH7tfPcLLpkLKRqOOCjJ
	ZmpJQ/fPNS3GWWB5+me6niapUjN0gW9rg609ZaOyNa4OixuXH7itzFbSld68lKv1RSctob6Q2WG
	JKfqxnSYflEil1marIUixwg7i+rQ4sw8Pr/YjjSXI75zUzsvlmM01zJmlq12n0=
X-Google-Smtp-Source: AGHT+IFwfgIEbkjqrp3Xj6rw7VEag9faUvhaac4xJoITXmdtyBWNt3pHG+KeJ9EZnCAFSLNMdCZA+A==
X-Received: by 2002:a05:620a:2781:b0:7b6:f1b7:c933 with SMTP id af79cd13be357-7b8637b17damr473501285a.47.1734530432873;
        Wed, 18 Dec 2024 06:00:32 -0800 (PST)
Received: from localhost.localdomain ([76.64.65.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7048bd8d8sm423967385a.91.2024.12.18.06.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 06:00:32 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	sdf@fomichev.me,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net-next 1/1] selftests: net: remove redundant ncdevmem print
Date: Wed, 18 Dec 2024 09:00:18 -0500
Message-Id: <20241218140018.15607-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove extrenous fprintf

Fixes: 85585b4bc8d8 ("selftests: add ncdevmem, netcat for devmem TCP")
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 8e502a1f8f9b..19a6969643f4 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -619,9 +619,6 @@ int do_server(struct memory_buffer *mem)
 	fprintf(stderr, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
 		page_aligned_frags, non_page_aligned_frags);
 
-	fprintf(stderr, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
-		page_aligned_frags, non_page_aligned_frags);
-
 cleanup:
 
 	free(tmp_mem);
-- 
2.34.1


