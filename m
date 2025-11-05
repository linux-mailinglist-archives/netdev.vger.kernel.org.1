Return-Path: <netdev+bounces-235660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B5DC33A2A
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 02:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34EF118C63C9
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 01:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9095D251791;
	Wed,  5 Nov 2025 01:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7lqQxG+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CDE231836
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 01:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305806; cv=none; b=ufIWNn18P+Vfcs7xvtJK/vdz8YpaMJErYtlPDWCKEJRLxBQ9FH0OYpBBzPlDy93Jh6NHr0HWF8BPueITfu6HnA/V1DsZWCWaCg22huvOustloI/hZW/2Q9kmT/GAxh2jd7ExWIWwIZC6hMNXZHjGZS7YQ7unKy2jCYfvInGkgPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305806; c=relaxed/simple;
	bh=RXbqfHG0a+IQy/+y+sqBKa7OAoDAqPEMrICB9KPpae0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FhsGXaPeejHmaW7dC7OJ5UOquSVO//CB+SOPD6kt6QG0pkboJlsci4Rz9KKuAR1n+vI/pjSA6/Izh4h7zF7dVHg94z9VoVyB2hzEnNy/49TxlOFIBy0l0p45Tl8BR31x/VCnLpkK8tgFqCzI2j/FrBlRwbWGLqfZ9+3QWtVdWyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7lqQxG+; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7866c61a9bbso31140197b3.1
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 17:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762305803; x=1762910603; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z9tMn1p2M/t5PL7qcirjOW1xEAHgQ7w+UJZU99+MumE=;
        b=Q7lqQxG+zDpZdDWuuOc3XJlQ+Dt2a5TeScHwinKT3fRkI/mLUtLfKl+O7+BrNEb1wP
         gCnVIJHpBShWpwqobWK7TCE21Ml2zGWMxQonpObByg0VkeSbgUzYY4jkDKXzplOj+86L
         1DeaJSlpBMgTGoHuhxZR8Yr1JyOPSp77znz0NgwYJ1gwaPo7bm06Bvj/1yNHmazkfnxs
         0MQBD3OtxxQNi4RdqbxyNjevkk5Ph+o0IMgCD0xCmHYhqYgbpyUtHgS3Y5WFpxmHF1ZE
         SsAndwTDQqFnyL/aozooFgdELuV7Ay8nlpHamWDtkHzEKx1uOLbPJr05iW2wWOpgOaRf
         Xeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762305803; x=1762910603;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9tMn1p2M/t5PL7qcirjOW1xEAHgQ7w+UJZU99+MumE=;
        b=oENDq5HrmBqIytvHsAIRrNQKLFFHnPAABgY/NbTC8broqQuNfTcEseTieViRyDmWo0
         bXYk9KwowkaWMa5IRXR3VDZ5+pHZ8YMuEuzJbdUJcF9u4SPf61cB0/mzCG3nQ5toUCGm
         y9VEPo8jdeqO1pYL27gXwRnLv2BTpu63oJYyIgaKSD2TRs7s/Sqjh6FJZzde8RF8K1u9
         8rUXlmsAKQ9WmeNMnfzvVSk2cKEAsvYKuCYz9QX06MjJxg4vHwV0Qhl2WZVP1SYBVBq/
         qnYNgdHxawFY/adIv6SMSHnPQ+igor90YIBBX4i3YsCWt1rgZhz7KypF58yOdEEnzwdT
         TlHg==
X-Gm-Message-State: AOJu0YwM6hxFYvYS735SYycPkGee3FfLUuVIdloNDu5JVYJn2Z1T5lC6
	8yr9W9WlJ4MFGtrQsOOhkd9utxgrS+6jyBjNfTijEZwd0Gw2NeMxxahw
X-Gm-Gg: ASbGnctS65LGG1ibZAb0NAm7B1e8IX4ZBZ6TKtHIzkKWibidCZO1zD404ldj0drBUNa
	umSBaxNr9daHvETqDhsFrsXq63FvYIfjX8Shr38e0gkiVtmrC46AGFRCBYViFNsQ6Bg8u4zP+1j
	0Yuh2uCOs5fbhQHQ8vKLGV8Nj1mU+RKjyAR3Y56GVVFPrGl37hIxgU0oCqIHC8GqFhrxaVt44CG
	xipEFI1Oy8YHkuf70IB05hAgrUw619zT81rnkp11msgmaUTuDjAiWP8ftE2LH45PPEmERBT6IhM
	WK4EWgmNjuU4Wj/pKz/iDjjBaE9J32gtYLJ5WTjIzM0HiK2TlvJgbEHhiYoZIorIGOynB5WjwmQ
	UBZQxSITMvALOAmuLIUkcmMb10myGabLJqWhLXsP6rVf4TBumFslmkDUlRhLk676vt5xDg+X0De
	dmt4Jv4i256g==
X-Google-Smtp-Source: AGHT+IE0LIRLznkQNnvceo02Dvgp5yqa0t710bCiAdIPw+Fl4wFqN5N+gSlsnaiGqNY/5wP/Y1I7mw==
X-Received: by 2002:a53:d007:0:b0:63f:b444:da92 with SMTP id 956f58d0204a3-63fd3571a70mr1136853d50.31.1762305803173;
        Tue, 04 Nov 2025 17:23:23 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63fc95a3ae1sm1285712d50.16.2025.11.04.17.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:23:22 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v6 0/6] net: devmem: improve cpu cost of RX token
 management
Date: Tue, 04 Nov 2025 17:23:19 -0800
Message-Id: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAenCmkC/5XOO2rEMBSF4a0I1XODnrbkKvsIKfS4jkVi2UiKm
 WHw3gMugpnO9YHvP09asSSsdCBPWnBLNS2ZDqS7ERoml78QUqQDoYIJzYywUENxLUzgF+8fWKc
 fnF2GiNuMM7SwQlu+McPvWltBN4OwwiPvVdRM0huha8Ex3Y/iB83YIOO90c8boVOqbSmP48rGj
 /2oWiYuVzcODKJVHe+s11qz9xmbewvLfKQ2ceI5v84LYBAMi73UPiotX3h54kV3nZfAgBnlVee
 jM2Z84fU/z5mQ13kNDFQfvNGjFtriid/3/Q+WGmxbFAIAAA==
X-Change-ID: 20250829-scratch-bobbyeshleman-devmem-tcp-token-upstream-292be174d503
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

This series improves the CPU cost of RX token management by adding a
socket option that configures the socket to avoid the xarray allocator
and instead use an niov array and a uref field in niov.

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

The sockopt SO_DEVMEM_AUTORELEASE is added to toggle the optimization.
It defaults to 0 (i.e., optimization on).

Note that prior revs reported only a 5% gain. This lower gain was
measured with cpu frequency boosting (unknowingly) disabled. A
consistent ~13% is measured for both kperf and nccl workloads with cpu
frequency boosting on.

To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemb@google.com>
To: Neal Cardwell <ncardwell@google.com>
To: David Ahern <dsahern@kernel.org>
To: Mina Almasry <almasrymina@google.com>
To: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Corbet <corbet@lwn.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: Shuah Khan <shuah@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Changes in v6:
- renamed 'net: devmem: use niov array for token management' to refer to
  optionality of new config
- added documentation and tests
- make autorelease flag per-socket sockopt instead of binding
  field / sysctl
- many per-patch changes (see Changes sections per-patch)
- Link to v5: https://lore.kernel.org/r/20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com

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
Bobby Eshleman (6):
      net: devmem: rename tx_vec to vec in dmabuf binding
      net: devmem: refactor sock_devmem_dontneed for autorelease split
      net: devmem: prepare for autorelease rx token management
      net: devmem: add SO_DEVMEM_AUTORELEASE for autorelease control
      net: devmem: document SO_DEVMEM_AUTORELEASE socket option
      net: devmem: add tests for SO_DEVMEM_AUTORELEASE socket option

 Documentation/networking/devmem.rst               |  70 +++++++++-
 include/net/netmem.h                              |   1 +
 include/net/sock.h                                |  13 +-
 include/uapi/asm-generic/socket.h                 |   2 +
 net/core/devmem.c                                 |  54 +++++---
 net/core/devmem.h                                 |   4 +-
 net/core/sock.c                                   | 152 ++++++++++++++++++----
 net/ipv4/tcp.c                                    |  69 ++++++++--
 net/ipv4/tcp_ipv4.c                               |  11 +-
 net/ipv4/tcp_minisocks.c                          |   5 +-
 tools/include/uapi/asm-generic/socket.h           |   2 +
 tools/testing/selftests/drivers/net/hw/devmem.py  | 115 +++++++++++++++-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c |  20 ++-
 13 files changed, 453 insertions(+), 65 deletions(-)
---
base-commit: 255d75ef029f33f75fcf5015052b7302486f7ad2
change-id: 20250829-scratch-bobbyeshleman-devmem-tcp-token-upstream-292be174d503

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


