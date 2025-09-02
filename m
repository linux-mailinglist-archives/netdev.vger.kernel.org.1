Return-Path: <netdev+bounces-219322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6EAB40F80
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8651B60BF1
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F195D35A2AB;
	Tue,  2 Sep 2025 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E40Slw9m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6960DE573;
	Tue,  2 Sep 2025 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756848992; cv=none; b=XY/Mb/C6yHMrxT17/iER2FxagnLgQJTTC4KldmjGpf1/KaT2MNCeNw4DnAyBqIsu4Y6vqGCvxVG51ORgtjAH2ZnHs3iB2Hp6KuvPH5EcissWx8OpuHha4DVMReq7asMCZTBUwp1XTk+eDMLJLhaXDup3mSXt7ODZeuUNXyuZTtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756848992; c=relaxed/simple;
	bh=PFJoxksXvVyv60IuEoymZjKpZJY4cpVTuJ34D3w4n4k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qrUZwPCIAmrAUc009Yz9EXC+wZkx5lk8Z4O/Iq+kDhhbqPcXronJRQnFeQGRabQUbCv1zZm/CDQBvdMxoMS+ZxG8HJnoSHEOJtKkAFE8aVsiAkHdhCi5LqQmeHZNKx1xlP8RgaFNebCsQjRzP4Cx2CzfDKfHeWVoz8yItTnrHmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E40Slw9m; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e96c77b8dc1so4302418276.1;
        Tue, 02 Sep 2025 14:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756848989; x=1757453789; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FAPHCVdbTi45r+VRL9Ex+aqP39iJNroR5Vm08l1W8sg=;
        b=E40Slw9mjkCeRU4iQvEQk5wF4nj83GCfDhJ7h2VAgGOyvd3LxCllEoPve/6RP8pb4Z
         8D5tKBTVGW+kD7pPrkEe696EdQ4rZFGMBOSQnCSh1MjIM8Va8kmByJfXD7OoZlieQZOj
         4wiXaJ8E5HFKXt8pkRXh9XhnY7yWK7pWuR9O5PQhuOG7C6F8rVDoLtZDVt4uziwxZ6wP
         GtvgtXMKw3KL4qknW2HA5+uD4Rybh9/AypkL689+v7mdTRnvh9qF/ApxvBekx5MTh5ar
         FGeMKPoiPKoce9FR9AR2bUGh14Z5XrdgKOfL7MpU1v2pXiCLRsjO9AgdEktCx3YqSURL
         stlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756848989; x=1757453789;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAPHCVdbTi45r+VRL9Ex+aqP39iJNroR5Vm08l1W8sg=;
        b=OrXAfiR5PEOVs2BpuKqQLdauZOg60iJ60ODtjr9QJ/VOwU9zw8hbsLzCbvbEALtUW6
         MHTi/6f+vuu7dCZ8Rc4CPK4rnTM6tXIYJQ8+JgwkvduFW+nWyCWERyJDsLrez/fnXM8Q
         rQpJB3SBp3tHy7ZmR0Iz62PAydr/6KBW10ckF4jqv/HIILLJn/E92Hn0iqmkhMB4HQqh
         DKKEuw+G2etV6z7cv2syw/93obdAvv6J33imXhQu9edA1ay2BZRgS7q7dv7j7OBl9HVE
         HUFr5F+ARYaJXJpX9y1FKHN3/Dgx+XXPaOfbaPZp/y85T2ilkuufApPMU07Gb/yHAT9N
         T/dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSRBL4ws0VaAj7p5LztIt/1V7adp5T4cO1M5jEb3Qji10fJgWDGBGsoALBr53M+XtEWz3FhyScclNydO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBaiGbqn+0yH5OM3QKIn3WOGhul58Fp2P2LNB5q3QYFcIt9g0u
	td5E9BFYVVkMP2J3C7aQgyj9uxGiJbkzOKjKUGhLpQurC8NA2H90YYlh8vL1oxHiU5vXPw==
X-Gm-Gg: ASbGncs9elDIoZ7uxvwsgk/537AVz932cFWbivX03T2Nnm2J7YzaGZtwOeU9mmTXqCG
	6OPmJYqhPFqhIKInfn4UyKEZDi6v1LDhLQC4XTS3DneB+jegDpWnU7XGujEpI+1/cn79HtANuhd
	3flU5Xpq4SYAg/q2IoxNOHOO4aNE5+oK4jBzmHFBzxfOPqcEmq4c06W0d6LiRO6wtOS1gyYh/yR
	GB72aJqygxBOLVxLq+L49U4TYiPLCtNDmRdgvUO6up/JIawslgCok6NYxniJuypo/1rlCgpyh1H
	qiu4oY1VNkpK6tGzoEGLbpjqzh+JACy6XFW2DbbB7ikZpj8wQ4Cn8b2OHbO9ZKDf2+1UZdMNLCQ
	Vr7Gji37z+l8U8CzNwux2kn94hVe62k0=
X-Google-Smtp-Source: AGHT+IFrSsduSAWeSsUdzbQ9p+RE/QxtJMCf31/DpYhssGwJOcJ5RimU3aSLChHQyzKBLTSMdUzEjg==
X-Received: by 2002:a05:6902:72b:b0:e87:b880:7dee with SMTP id 3f1490d57ef6-e98a577e559mr15064554276.12.1756848989281;
        Tue, 02 Sep 2025 14:36:29 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbe19decfsm914291276.34.2025.09.02.14.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 14:36:28 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next 0/2] net: devmem: improve cpu cost of RX token
 management
Date: Tue, 02 Sep 2025 14:36:26 -0700
Message-Id: <20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-0-d946169b5550@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFtjt2gC/x3NSwrCMBRG4a2UO/ZCGi1atyIO8vg1QfMgiaVSu
 neDw29yzkYVxaPSddioYPHVp9gxHgYyTsUn2NtukkJO4iJnrqaoZhzrpPUX1b0RVGSLJSBwM5l
 beiHyJ9dWoALLWWqM55OdxJF6NRc8/Po/3iiiccTa6L7vPzZD5iyLAAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

This series improves the CPU cost of RX token management by replacing
the xarray allocator with a normal array of atomics. Similar to devmem
TX's page-index lookup scheme for niovs, RX also uses page indices to
lookup the corresponding atomic in the array.

Improvement is ~5% per RX user thread.

Two other approaches were tested, but with no improvement. Namely, 1)
using a hashmap for tokens and 2) keeping an xarray of atomic counters
but using RCU so that the hotpath could be mostly lockless. Neither of
these approaches proved better than the simple array in terms of CPU.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Bobby Eshleman (2):
      net: devmem: rename tx_vec to vec in dmabuf binding
      net: devmem: use niov array for token management

 include/net/sock.h       |   5 ++-
 net/core/devmem.c        |  31 +++++++-------
 net/core/devmem.h        |   4 +-
 net/core/sock.c          |  24 +++++++----
 net/ipv4/tcp.c           | 107 +++++++++++++++--------------------------------
 net/ipv4/tcp_ipv4.c      |  40 +++++++++++++++---
 net/ipv4/tcp_minisocks.c |   2 -
 7 files changed, 107 insertions(+), 106 deletions(-)
---
base-commit: cd8a4cfa6bb43a441901e82f5c222dddc75a18a3
change-id: 20250829-scratch-bobbyeshleman-devmem-tcp-token-upstream-292be174d503

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


