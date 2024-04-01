Return-Path: <netdev+bounces-83722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D67C88938AA
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 09:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E651C209B3
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 07:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB77947B;
	Mon,  1 Apr 2024 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHj7vA4x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C2D946C;
	Mon,  1 Apr 2024 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711956974; cv=none; b=KfG/MFAnk0LN9obF0dkqJpFMTuG23Maou5mOYGfMagKZVu9MVghjQaz2xxJQVhFrWqDeVFt3Z4ZQ4VEpwjxa2ptZHycYzZouYBz8fJmmpCR3wIneWMuPtQeLLBgFapnEy5ZQb7L+6zbXjZDCoSN08u5sJquxevVfKAnIVJzLeqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711956974; c=relaxed/simple;
	bh=F4r2v4sYFlNusIhpQp7QN37BuCP8TpV20N0WzGZgbhI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=etDLxV2HHdQBxZMI9LLejpV7x99TO3omXpM05kk+IvPwB+zqWvf1tXvWcKky4kwBWpL8SdxrlIYShM/GxddzFNI56xoKMh9oWFxkBJ6r2WW+QjtppSQnS94v8Em2L8rVY0cojHvpMj4CCrJqbgwOjc4ZNE/xyzDxNh6rCCyZRmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHj7vA4x; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e24c889618so5119465ad.2;
        Mon, 01 Apr 2024 00:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711956972; x=1712561772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qwxNZSXScVPuRA/Q7kuRVv3I03QI7By5tU3htQ8mH0I=;
        b=fHj7vA4xQ1l8Qx58aqU7JMCpH6us0+vRwRdVTKcEac0GxodGZb9AwOnBrEvT0IrW4y
         Px38B4dFq/Eg7v8VHjUyNmc+2pQ9UpqDZCHMOD2kB/KwW0iUbERKmZTMQYIslZqWlfDe
         +jeDMlshuL13d0yIfF2tvXXG19RxNb7ZxmEHdOu00bI3jcTqSNZB34RCR8yv6yePcL94
         o3lJ19h8bKgBmOnlYiUlmYuUinKKrhMEACfyh04Xi/JPf0SgTArPuh5BuIo8F8G/eZYe
         bUaJXkUZ2U2tiHkBz5VCVLWiCLRb7Vy+SPEQl4iu3IPwUQNaQlc/mqrIw9pwtVl9g7sC
         K30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711956972; x=1712561772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwxNZSXScVPuRA/Q7kuRVv3I03QI7By5tU3htQ8mH0I=;
        b=MwilebLs9JaIHlI+o+xMtA6t89CApGImtXOuvrBzhYKFwEwkGqo7aVCfs8I+3F0fBV
         auyx8nxP7uWThg06LvgcVjdiUieJ9KPA9ofd4yQ2ShopBbPlnA9y7K/YOYpBj/uCYb8u
         K6Rac/tNBhtdr93nekJblUk4jUhT/ROOa2x7iGRqPqYxAVSSDPt7Ts7ET8dj0E2iC8u5
         VWak6iXu50g4LZVJwfSsYz/ANZCrokkuE/uQEKdkXj0mVPr6/ceOKboojOvB9zSFW7aU
         EflgUZi3jnK2MZsRaXAugdOFf6xjxSqcEr+JiJnBsopoSXtzhS8RU6LsQL1xUb08ixHe
         cygQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNUWj/T6vgYtYpo/0fCi5kbsm9rVfZwUcPcrwpqMeL0qfrwsVFeiChlDCD5nVonSPwXjkWX2tAKo5gTeiVknq4lCySREwcjBtjES4bD1U7r5uh
X-Gm-Message-State: AOJu0YwvH8lIs4bIN5lCZtJaZ95UlBQHzCuwOh3FdZpY1VYqemIG2g7y
	+gMfmPzKj+boAYaLtNQXihLam7JNf8KZboN2y0JCZnUAHtdRGPs3
X-Google-Smtp-Source: AGHT+IGxNnlXQ6W+3ahtg28ZhiVd02yqOlVZeTXvwPpbvq64KLPRRksVIrF+svJE32N8jLQD3udCAw==
X-Received: by 2002:a17:902:dac6:b0:1e2:194a:3d22 with SMTP id q6-20020a170902dac600b001e2194a3d22mr10203764plx.32.1711956972537;
        Mon, 01 Apr 2024 00:36:12 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001e0f54ac3desm8363497plb.258.2024.04.01.00.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 00:36:11 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 0/2] tcp: make trace of reset logic complete
Date: Mon,  1 Apr 2024 15:36:03 +0800
Message-Id: <20240401073605.37335-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Before this, we miss some cases where the TCP layer could send RST but
we cannot trace it. So I decided to complete it :)

v4
Link: https://lore.kernel.org/all/20240329034243.7929-1-kerneljasonxing@gmail.com/
1. rebased against latest net-next
2. remove {} and add skb test statement (Eric)
3. drop v3 patch [3/3] temporarily because 1) location is not that useful
since we can use perf or something else to trace, 2) Eric said we could
use drop_reason to show why we have to RST, which is good, but this seems
not work well for those ->send_reset() logic. I need more time to
investigate this part.

v3
1. fix a format problem in patch [3/3]

v2
1. fix spelling mistakes

Jason Xing (2):
  trace: adjust TP_STORE_ADDR_PORTS_SKB() parameters
  trace: tcp: fully support trace_tcp_send_reset

 include/trace/events/net_probe_common.h | 20 ++++++------
 include/trace/events/tcp.h              | 42 +++++++++++++++++++++++--
 include/trace/events/udp.h              |  2 +-
 net/ipv4/tcp_ipv4.c                     |  7 ++---
 net/ipv6/tcp_ipv6.c                     |  3 +-
 5 files changed, 56 insertions(+), 18 deletions(-)

-- 
2.37.3


