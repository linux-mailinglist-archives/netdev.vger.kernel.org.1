Return-Path: <netdev+bounces-222408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32300B54207
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 07:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA029580424
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 05:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD81324886E;
	Fri, 12 Sep 2025 05:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOTfgWqy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A27326A1CC
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 05:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757654916; cv=none; b=XV4+HncRwBBRnFgch+CbnC9O0KtljBqnPnv0Z49zqJaNlWDGs1Xj6+oZ3sJkW4Lt0yDrIc4gYVIGCSLh+T+T2sAfumpKJAJHS+RbgO95Uewd1cL7l2IE2uao0l6/T8pYdxD2+abL/WN6FEWtdrfxoX6c93qBC7YfcgJ+hrFVHiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757654916; c=relaxed/simple;
	bh=C8JVV4bUcTFEEeGNRls/ntZgm9B8MjrIt5pOjBz3Mag=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=URkGb2WyGsqCNUXR6l0ChGoDfpxxSQ/793u0FwMPaD3P36fwLS1imocW8aLxWKZ6V+ZQ5Zx2RP+mElDqcnLEialCFq/F7VcVc9SQiwrVFZyhkwJ67BPhAQdwZeEx8p5sJhLMwDJT4J0GrPfB2XEGFEfSrxF2s04GobeUDQn+xi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOTfgWqy; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d6051aeafso10686337b3.2
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 22:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757654914; x=1758259714; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4XSGekkpVkf5970c4lYR4Umh7DgDawDzZq6mi5cA7ps=;
        b=QOTfgWqy0PlFd9giVDGQA5ZMzBS8IES9+q8AVaLG+7NLyKJXsvArfe06TdGs06nirt
         Wv9jpmTJRitEAEEPvi4vQer3esDzpnr782ZeH8B1E3QDHIImVo/oNHFFud4A9aJ54xxG
         djM9hRqwSasKQAfphq6Dnh7T15Ctjrdxr0TuTb93Ad/3OP5sLv/5In1W/tKuedYHVJXl
         oDY/6MTI4QGc6N0HuZxe9HAr8vy0MdpHW7qGwGMxXqGBofReq4vcA4XeqBirYag7Ew/O
         KhwZ0hFUvTsCV1S/anns8uz1EhlZe0vEJR7kUoZ5YhN8sUHalaOl7583yuKvKrzFKjyz
         RXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757654914; x=1758259714;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XSGekkpVkf5970c4lYR4Umh7DgDawDzZq6mi5cA7ps=;
        b=VjCNmeFI3LONUz/aXDzpgrJ4A5eTqpwqLaurpcunM1bs3D79BLX+PW6N7LDxMcobgx
         2ZxJhatkWGviMFRfDQP7XcepkslGhI6AvQN1iq0XzprODFPA+Jb1FnD+w0Q5ihYvGt6b
         B55jSp47og6IG1j+IM1/Uf0Ta5iQ4Cv8yvRF7NgfEaVYj3KU5fIH0EI0oK2TpTaRxR+R
         zo2hkBsSiM1XOxx4XNIk3oegQkTilpX7rKau2Tf1/3hfL+HiwQt9xakSKRLwYxmqt1UI
         kmGSFcRS0nplYG0pvk3opBLDDm3Ff9EM5KJbLdr8bChLDK+GONTw2+3JWSLvjC2h4pqE
         Mavg==
X-Gm-Message-State: AOJu0YxyBgWKNKl0WejPlDt3IYKMaQ5ECm4o1HcND69wfdcxORl8AIOn
	AOouF9C9Cylivptg8xZZzWHHAtACV8kDl5ASIqPxAUJN017i2g/naZin
X-Gm-Gg: ASbGncv2lCIN7i+HFlnaB1HN/0b9ZmSwfsZBnAtF0tf4fbRynTPoiX93Ly4aeq0Ydde
	9+bMhlS+9Y2gVCrhuKitBsfNeyB9K0BJRg+XxYPC80pxey7kNheWWWyJYJseEhjnT4vYT1yjYW4
	xy4WH55gGOLZ486DVrgHCMDSr7m1FvzANorV/oWDw6b/qUrLOhoXuuSRdK/SY4FDSzdOjw+TTmz
	ni/r3mGa7W4qEriSo6mrjXAIXh8xEIT+SbKO1AaDMeXWsB+li/4So11y+neHeyC2MsYfCe9VsHi
	iUQmNvgVF46kURuQXi0ikWexjBBHytPn2H+/RExtw3Ee0Ln3H1bOnvcJUWCPJ+1qqIfU+n+fmMU
	m+aKHCVZqbJiwgnGoxopP7A==
X-Google-Smtp-Source: AGHT+IHZOsoQG3Mo3v3EOeqF8bboMj9971KyDVkVPirMtISex3gLsW9/Gx/3eBTrg0Qcgc+pWRzddQ==
X-Received: by 2002:a05:690c:6c01:b0:71f:95ce:ac82 with SMTP id 00721157ae682-730630941d7mr16426947b3.9.1757654913861;
        Thu, 11 Sep 2025 22:28:33 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f76234536sm8699127b3.13.2025.09.11.22.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 22:28:33 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v2 0/3] net: devmem: improve cpu cost of RX token
 management
Date: Thu, 11 Sep 2025 22:28:14 -0700
Message-Id: <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-0-c80d735bd453@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG+vw2gC/5WOSw7CIBRFt2Le2GcoliqO3IfpgM9TiAINYNOm6
 d5tugOHJye55y5QKHsqcDsskGn0xae4AT8ewDgVX4TebgycccGuXGIxWVXjUCetZyruQ0FFtDQ
 GCljNgDW9KeJ3KDWTCsgl19RcWivYGbbVIdPTT3vxAZEqRpoq9JtxvtSU5/3K2Ox+r0rG/66OD
 TK0su2aTmohBLsHqupkUoB+Xdcfw6CkQ/cAAAA=
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
Bobby Eshleman (3):
      net: devmem: rename tx_vec to vec in dmabuf binding
      net: devmem: use niov array for token management
      net: ethtool: prevent user from breaking devmem single-binding rule

 include/net/sock.h       |   6 +-
 net/core/devmem.c        |  29 +++++-----
 net/core/devmem.h        |   4 +-
 net/core/sock.c          |  23 +++++---
 net/ethtool/ioctl.c      | 144 +++++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c           | 120 ++++++++++++++++-----------------------
 net/ipv4/tcp_ipv4.c      |  45 +++++++++++++--
 net/ipv4/tcp_minisocks.c |   2 -
 8 files changed, 266 insertions(+), 107 deletions(-)
---
base-commit: dc2f650f7e6857bf384069c1a56b2937a1ee370d
change-id: 20250829-scratch-bobbyeshleman-devmem-tcp-token-upstream-292be174d503

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


