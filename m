Return-Path: <netdev+bounces-226706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B3EBA4556
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46773A6C20
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D201F1E7C2D;
	Fri, 26 Sep 2025 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbvyHGad"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E18886329
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898978; cv=none; b=mmErvGXugwBHs3eTOBpYMkG1cX62KVtbNtIPspkn8SIDte/DRvltAUrRVXNQ3PkiTgPOXN2MTw5kE27Mxg55nC1NFeoPtLsSu/XbLH1vlOlfon/UI0uniM73zO9FDudN7wOzVFxPMM4jRNPjH8doHzl3zd2KPk4K0qPZ6eTtlhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898978; c=relaxed/simple;
	bh=6Cjo7453gcsAZ3b3AJ+K3qw1bp5kC6Dg80+11KpUsjo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cbJyTfWw+0lFgACDpVE6IgqpWmEq8xJB4DplQNW7ychCHPFr9oPIiIBmkl/nuK23A+sb4MwKlz41cEmLoHpLmqxBWIgZt85of6+Tkd1HtrNElnuPyP8hAG7E1EZZaS6+8JOKB26PR0ySTvQ659dk7eJLeP9AZICo5Y9DWNRJR5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbvyHGad; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-633b87e7b9fso1622093d50.1
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 08:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758898976; x=1759503776; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2NK1+qNpVHuxCsWsinsmU1XOieK9VkSoD8m9MtoYpA=;
        b=cbvyHGadkJ6TUy1wEGF5Zsbh6ltxOXenixQAon1X5fMpHxB9L/6pp02diTU7XXX7+I
         kvHudl1zO+2yIx3jYhtuG3k8e0HQFMa73JdyxOlFyDhpCiW2uDaSEVyrC2Fh+SWT8zlF
         4UHVkMfP2zIJJlO1S/K9y7e2X4qceI/swCY/wzvxHMOIFwvAEHB1VEMa5OfuzqGutnr5
         4HKHyIaEUevK984Pgo92t+O5QtZsSEeUpOACBYdoHudQGp6BPzu6NeEECC3OS6PnjhMc
         jTpcS1WNUSdnmak0U4jf8lcvYUETP6P4OuOvobo4YaLMV//94qflsGcWle/p8oWt1iWJ
         npxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758898976; x=1759503776;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2NK1+qNpVHuxCsWsinsmU1XOieK9VkSoD8m9MtoYpA=;
        b=ku3Byt2YiQMMYnT7lO8+8GaXET0wxjUVl3eHgAytaKyCraawFDwJsHEneFeGLjcyAi
         hBAr1CDxkbVWI/HuLAOINfrpxxQI45blBjSX8ZuSQQQluYDwudLuTHJ0a/4UadjtYyf/
         MWi/RPmOc53PAisOHd+lIT6Ch6AuD5pFL06H5RBCWIbqMM6u0wLVDPSbVWhK47gA9et5
         XJpcVD6xdUTCMWBnQCN/sJozLPl3SptDDyoC+UiHmBMbkKjGd4hFeTkAE1EPHCC/zk7K
         hmrHDNIak8DsiLsY4ayP5IeBUjlfDyJ68LlY7Vez+PTfqpaxHVcxgWbyK9ea0apuNKV1
         UPSQ==
X-Gm-Message-State: AOJu0YwazNsyxI1BAH5+41gdV6dYaVitNf9CPn7604hWlpZesZO4VYIv
	qpKXpWAQUWRavYZwC62iNcb6o81/gsfVggd/jzG0Bu42CVtIfI8GAEft
X-Gm-Gg: ASbGncs2KnTMTkg4zrbTMG00SneyLB8Dfc4QCnsdwP7Zw9umpw0WYGMIoMrRTUg0ci7
	Tq2ePkZYoWnGaLXdmavX6DTutgcmi0cJ8DWfmAjLy3VhCJeLVnwSoNDfL20u70EDV3FHuMIFvqu
	dcEDRjBpumqB4jX3Pm/QzeEGGvU1EjHWm6j3V82kF494btvdz/iIC0hPI6d8OBIqaGBUsZ41osJ
	/3ErYfKBR+b3lfKT+KbmmDwO3NryUh6yr0nNuEQda/WqnVPPUxzBPg2/m9WCvLmwdWktj4U5dgM
	bP27h3F5VwtW5Lt8cE0st1ZO9MNxMlD6nwfsqb1EqJuNyu9HPK+J/X8rBMawdoyqcV/wFoJNVnc
	5LX7xKeclmgEJv3EbVFMenf4KdBmepket
X-Google-Smtp-Source: AGHT+IGN7lutBxmNpnjeMEWOO/IMFULl4v8R8dPpfbxhnimX82dFlrbOOG3JwMAj4RAFC1/vkaLJew==
X-Received: by 2002:a05:690e:1607:b0:635:4ed0:5730 with SMTP id 956f58d0204a3-6361a862bf9mr6223018d50.52.1758898975497;
        Fri, 26 Sep 2025 08:02:55 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765c91e226csm11365617b3.68.2025.09.26.08.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:02:54 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v3 0/2] net: devmem: improve cpu cost of RX token
 management
Date: Fri, 26 Sep 2025 08:02:52 -0700
Message-Id: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v3-0-084b46bda88f@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAByr1mgC/5WOuw4CIRQFf8VQew2wi4qV/2EseFxdosAGkKwx+
 +8SKlvLyUlmzodkTA4zOW0+JGF12cXQYNhuiJlUuCM425hwygU9cgnZJFXMBDpq/cY8PdGrABa
 rRw/FzFDiAwO85lwSKg9cco3sMFpBB9Ksc8KbW3rxQgIWCLgUcm3L5HKJ6d2vVNb3XpWU/12tD
 ChYOe7ZXmohBD17LGpnou+pyn/0jP2v501vjtQeBqHtKIYf/bquX5+bNyhWAQAA
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
the xarray allocator with an niov array and a uref field in niov.

Improvement is ~5% per RX user thread.

Two other approaches were tested, but with no improvement. Namely, 1)
using a hashmap for tokens and 2) keeping an xarray of atomic counters
but using RCU so that the hotpath could be mostly lockless. Neither of
these approaches proved better than the simple array in terms of CPU.

Running with a NCCL workload is still TODO, but I will follow up on this
thread with those results when done.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
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
- Link to v1:
https://lore.kernel.org/r/20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-0-d946169b5550@meta.com

---
Bobby Eshleman (2):
      net: devmem: rename tx_vec to vec in dmabuf binding
      net: devmem: use niov array for token management

 include/net/netmem.h     |  1 +
 include/net/sock.h       |  4 +--
 net/core/devmem.c        | 46 +++++++++++++++---------
 net/core/devmem.h        |  4 +--
 net/core/sock.c          | 38 ++++++++++++++------
 net/ipv4/tcp.c           | 94 +++++++++++-------------------------------------
 net/ipv4/tcp_ipv4.c      | 18 ++--------
 net/ipv4/tcp_minisocks.c |  2 --
 8 files changed, 85 insertions(+), 122 deletions(-)
---
base-commit: cd8a4cfa6bb43a441901e82f5c222dddc75a18a3
change-id: 20250829-scratch-bobbyeshleman-devmem-tcp-token-upstream-292be174d503

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


