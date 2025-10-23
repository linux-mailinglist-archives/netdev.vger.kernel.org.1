Return-Path: <netdev+bounces-232259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E345C03797
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 23:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90A93A3FED
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 21:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DE7286D5D;
	Thu, 23 Oct 2025 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDDAjSts"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BFC277CB3
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761253233; cv=none; b=ez8gCWkDkjeEm/HuFytmVdTOG0UrWjwvFZ7jVLDbhKeUhe27Rb5k+WsjvsQBF1Qm25SpZwiQGLn6+E6IuCFnyBnQzff4HeKbaOTzhJvXqCZCLUH1dQ5qFjPdRR2VreyH/0QnXKf92buphRe/3yrE7bPuWJPxAGch20vgnZEJxp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761253233; c=relaxed/simple;
	bh=mAxysNeIrHgaruiWFWQZqnXGyaXHdWk1zacyuJSvdq4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ou/yQDB/6mmqk1CUVklfYyh9uIaWR9F/9G4ZDoGcoR85Xm8nXWN/boj4Pss6UBPGajcYHeubbouPClAqIBZpOHYfUKro6nt7iw05wyWI5BFK03TzUTfuf0aqw3p5KqqWg3JTNjy4F8C0YcFg6DrFcTwBOL9LsYnhiA/ucscSOGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDDAjSts; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7849f01e56eso15967287b3.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 14:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761253231; x=1761858031; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUE2fgwmLwSez/53F3+hW+9Ssseh5miklnRUVCVob1w=;
        b=PDDAjStsBRozLIz2miDBzBJwtpxxEL1Py0de7ebAWKaE15UIp1PfqfaSRgDiIRyfIg
         ji+PSNG8kaKDvzw0sVCOyhjo7cbzQ9VUwIiJ3Lmps+9vkPHnVbu01kgZSOk/O/3dCfHU
         VIW5egR4ZitjyXe90lSBfVSSFLtMedkiVTsN80Oum1pByYptOOhMpWRK+BohpoRS1SlQ
         zLDMQMkePNGE2pJHz/pUAOB3UcjvseHw//foy7r40kHSZXFGC7prQ6GK1YMdYX2oradr
         i+vxJL4WXu5s0xie/XqvDGh3brHp/WUDBiAxxGKb09hUKjwspTcEsRN4RJG9tDOVzHcW
         eN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761253231; x=1761858031;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUE2fgwmLwSez/53F3+hW+9Ssseh5miklnRUVCVob1w=;
        b=LjE5MVpGKoPN6HEXIIpl7DfK5ak6aeNGSx8MAO1yq4z1vK4VHZAMVxcBcENhM58W48
         leVJ7DQFmbPoMvW7D8Wjdu0B6dGLdh+2PGru9vx/TVIdW3sD2L5cQipvutu8QC+vV0cb
         jhjmAoAOhZcD1xLBilJgLm6C8qnJxcM/3fkJwz6R2EpqXpJe+BIIew8IejoXy4t6d4dU
         HxvBXO9Fje677GzQmQLheh2HqguWPpX90Dln1WEhuaQ0noWhxrl2OzXJLdmAyJsMm2yT
         aSHqY/r89JODgVf5RyCy2cgIAeqpgnthdDP7j2op26CQZOhRSersinZVPwzrK1iXPWuV
         jFAw==
X-Forwarded-Encrypted: i=1; AJvYcCXsl7OdZsBFeCnGfcsKj+UGsl+mItxIvXTG2OytLxShNsW2QQ6y2gLBarBXkyYrq35I7pbUE2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRMASGVS+2OyvWRQQlEvz8Qz+8tW38EBI52TGj+0qUXgOadmZZ
	sTQCasw0o70btjjbpgI/SqO1x3oOCr99c4CkMmMs2+k84wKA7ol932/l
X-Gm-Gg: ASbGncs3wIhA/Tq1ss+n0WQvNOiYZ8/s8RJhGprG+LK2MQJW8gvNGyoqD/ZUrgSHgC7
	vC3dJXVUDX+OvpHmz/O0ERLNhdVW+RDbebdhvKq4rPcCoGDk/9FJOk/jtuLmp5XtD77wCCykXAD
	BXqjDwdt/l8jeSzfpEhaCiiBbR5l+HMb8bX6umwImGEk5XHpZXlDhlTvrpetzDRhtZCHYUsPr86
	t4nBXGyGcIzvpVL7rcmySImr8LN4J6l/FsL3w/fBTQivbWdtua7lt7Rmusm5gwWFLNqGbZBWDeZ
	5/V/HuIvE0PiRamtx3i4s2Ep7Ruj4ZhDNeEBQ6aBebo9SU8te73FPZLNydSKeanlBGbbD1i72Lo
	AyEBV3Y24Vld8tFXN5RHWotglm135x9p7l9v9WkDX8ID+cwHlLmfhp1RGXsXDlD2q0Ke43EFOhI
	WNPzGu3JdThss=
X-Google-Smtp-Source: AGHT+IE60+L8TG1H5hAGOW+FcGHHNvbExdUzbyadSWQCoD6D3xa2yre0fB7tmeRoBJZcTO57oPVImw==
X-Received: by 2002:a05:690c:600d:b0:782:f343:62af with SMTP id 00721157ae682-7836d374562mr228723197b3.61.1761253230843;
        Thu, 23 Oct 2025 14:00:30 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd6ec6besm8578607b3.50.2025.10.23.14.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:00:30 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v5 0/4] net: devmem: improve cpu cost of RX token
 management
Date: Thu, 23 Oct 2025 13:58:19 -0700
Message-Id: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOuW+mgC/5XOTW7DIBCG4atErDsVYHCgq96j6oKfSY1awAJqJ
 Yp89yJWVndefhrpeedJKpaAlbxdnqTgFmrIqQ/5ciFuMekLIfi+CadcUsU1VFdMcwvYbO0D6/K
 D0STwuEWM0NwKLX9jgt+1toImAtfcIrsKL+lEuroWvIX7KH6QhA0S3hv57Jcl1JbLY7yysXEfV
 U356erGgILXYmaztlJK+h6xmVeX40ht/MAzdp7nnXeK+uskrRdy+sdPB57P5/mp81QJK2brjVK
 3A7/v+x8pILDmtQEAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

This series improves the CPU cost of RX token management by replacing
the xarray allocator with an niov array and a uref field in niov.

Improvement is ~13% cpu util per RX user thread.
    
Using kperf, the following results were observed:

Before:
	Average RX worker idle %: 13.13, flows 4, test runs 11
After:
	Average RX worker idle %: 26.32, flows 4, test runs 11

Two other approaches were tested, but with no improvement. Namely, 1)
using a hashmap for tokens and 2) keeping an xarray of atomic counters
but using RCU so that the hotpath could be mostly lockless. Neither of
these approaches proved better than the simple array in terms of CPU.

The sysfs /proc/sys/net/core/devmem_autorelease is added to opt-out of
the optimization, but give users the performance gain by default.

Note that prior revs reported only a 5% gain. This lower gain was
measured with cpu frequency boosting (unknowingly) disabled. A
consistent ~13% is measured for both kperf and nccl workloads with cpu
frequency boosting on.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v5:
- add sysctl to opt-out of performance benefit, back to old token release
- Link to v4: https://lore.kernel.org/all/20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-0-39156563c3ea@meta.com

Changes in v4:
- rebase to net-next
- Link to v3: https://lore.kernel.org/r/20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v3-0-084b46bda88f@meta.com

Changes in v3:
- make urefs per-binding instead of per-socket, reducing memory
  footprint
- fallback to cleaning up references in dmabuf unbind if socket
  leaked tokens
- drop ethtool patch
- Link to v2: https://lore.kernel.org/r/20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-0-c80d735bd453@meta.com

Changes in v2:
- net: ethtool: prevent user from breaking devmem single-binding rule
  (Mina)
- pre-assign niovs in binding->vec for RX case (Mina)
- remove WARNs on invalid user input (Mina)
- remove extraneous binding ref get (Mina)
- remove WARN for changed binding (Mina)
- always use GFP_ZERO for binding->vec (Mina)
- fix length of alloc for urefs
- use atomic_set(, 0) to initialize sk_user_frags.urefs
- Link to v1: https://lore.kernel.org/r/20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-0-d946169b5550@meta.com

---
Bobby Eshleman (4):
      net: devmem: rename tx_vec to vec in dmabuf binding
      net: devmem: refactor sock_devmem_dontneed for autorelease split
      net: devmem: use niov array for token management
      net: add per-netns sysctl for devmem autorelease

 include/net/netmem.h       |   1 +
 include/net/netns/core.h   |   1 +
 include/net/sock.h         |   8 +++-
 net/core/devmem.c          |  57 +++++++++++++++-------
 net/core/devmem.h          |  13 ++++-
 net/core/net_namespace.c   |   1 +
 net/core/sock.c            | 115 +++++++++++++++++++++++++++++++++++++--------
 net/core/sysctl_net_core.c |   9 ++++
 net/ipv4/tcp.c             |  69 ++++++++++++++++++++-------
 net/ipv4/tcp_ipv4.c        |  12 +++--
 net/ipv4/tcp_minisocks.c   |   3 +-
 11 files changed, 229 insertions(+), 60 deletions(-)
---
base-commit: 61b7ade9ba8c3b16867e25411b5f7cf1abe35879
change-id: 20250829-scratch-bobbyeshleman-devmem-tcp-token-upstream-292be174d503

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


