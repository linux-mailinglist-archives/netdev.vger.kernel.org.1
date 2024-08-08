Return-Path: <netdev+bounces-116769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CCB94BA2B
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C4A1F221D4
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF481494BB;
	Thu,  8 Aug 2024 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SxjVHzRQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3B1DFD8
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111000; cv=none; b=hvJZTjgSnkr2iQHKQiQxe90HzZKnYnwv0f51w9K4Bt/O/mhzo1sEk8RhoZV2XCeW1lYm22GzBSAojMBwW/miYHFI81iomd3M2n60yGJgUmBRATnt1i85GLcPME8rNjrgwIN/Ae7BN1DD3nQTpMeMijJi2nZOKWeU2jlas20zRSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111000; c=relaxed/simple;
	bh=njibVmUWz/hfGy2H8uHvhI1EGhbGrSUsnLGx4s2Dj7k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bcuTf9p26IJ7TVjd/uYmfpbAvI9kUKEqx03AMubcBFI8f8oTWNYxw2++cs8iN9dwxf1lq2/StKucltt8Fg7ybI+eaGmjkhrXafg9j9TmY7Xz4QLHQtq/WCep+dRj3Fn4yAfMZ5yBPHei7UrItiKe6KrUr4Q1CowxFu42nzYu1nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SxjVHzRQ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efdf02d13so1407560e87.2
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 02:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1723110996; x=1723715796; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tdBRqDEkBKRal+TWe0Pt6bd5DsCwnKSiVeXb/ps7byE=;
        b=SxjVHzRQFcVMS1Scakmx5XP5CSubX0TBs8AwQlGsES1++u4qR+ve+vKemu9fV4oiGk
         O/mFYC/nugI6HWo4+CkUso/AuPj23pskeWd/NPzbqPeaShRhpXND2rjdku7CUEF4lm2U
         CXaddzkX7Y877FodP130jGsjVg5FkPvW96QQ9l7+fqGvI3Q6wN3VDakoI7pfuaYRB0E9
         mrquMv2U9uNvAG/7xnH48lCAFSgVA9xNntelsRGk8xqtWVce2eByZ487Iz3lLt2Y7e9E
         oPzYon+7X9xLAPg8/oqu6RTgSskv3VsXW8AS7EaW1qscOlx1XG486cN6VuLQBEmaajZu
         +6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723110996; x=1723715796;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdBRqDEkBKRal+TWe0Pt6bd5DsCwnKSiVeXb/ps7byE=;
        b=g/c2MO0osjriOX6D4Y0lqGIgf4kspyqRJnArrrrO7V/TpTn+boPID4PfCAKdfy4GnY
         eWXZ0gTLNLxNMUlsB2Lzz3gT5UrTlk4Kwwuy5mh+8WAjJvQMPklzTE2RNZ389bacGRwN
         aIQK8Yvvx+Cl3WoI5Az+fB/uLYWU7cRaGguOIhtxJeIcwVApDiWJSTu/tEJ9HYoTtkVO
         hBLVUumY6yYRITwSr7F/2/5HPAxAQe1hvtd1b1yxjS1W+IJ1hOalfeBtXb71YkHmftcG
         7F7N/yIQ0eL7YPDatbsQnvvasfOFrqL4m6jPB93kdPb9YIawD1Dxj+jAhbEDNLxwced0
         0GDA==
X-Gm-Message-State: AOJu0Ywrr430JZQpgM9Z8BX9OJB4gHRWdR1UkuyjAcX50WmzRwIepjf/
	1BRmRd7Mim++ibfqRmr41GFzxY7gThDw7TPflCCVHc3DYKWFERbxSlK7AyfDbxanSqTYhe4eiJe
	d
X-Google-Smtp-Source: AGHT+IF7VlCgi5IWPNqFBFswzUdvBAK2QEWdEhIL/rE05w1qZ6oKSE9+KzHrALozUpcauHK/Ii1nqQ==
X-Received: by 2002:a05:6512:2253:b0:52c:8075:4f3 with SMTP id 2adb3069b0e04-530e585087amr1345310e87.36.1723110995769;
        Thu, 08 Aug 2024 02:56:35 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80e6asm724427766b.165.2024.08.08.02.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 02:56:35 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net v4 0/3] Don't take HW USO path when packets can't be
 checksummed by device
Date: Thu, 08 Aug 2024 11:56:20 +0200
Message-Id: <20240808-udp-gso-egress-from-tunnel-v4-0-f5c5b4149ab9@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAESWtGYC/43NwcrCMBAE4FeRnF1JtlmMnv73+PEQm00N1ESSt
 ijSdzf0oqCIx5mBb+6icA5cxH51F5mnUEKKNej1SrQnGzuG4GoWKFHLLRKM7gJdScBd5lLA53S
 GYYyRe2Dy7BVbd/RaVOCS2Yfrgv+LyIM41PIUypDybTmc1DL9Yk8KJBATNbIeEOq/tk+j873Nv
 GnTebEnfHpGqq8eVm9n0Xr0ipxxH73m1dt+9ZrqGYPG7ZqWjprevHmeH0z9LQVuAQAA
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 kernel-team@cloudflare.com, 
 syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com, 
 Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.14.1

This series addresses a recent regression report from syzbot [1].

After enabling UDP_SEGMENT for egress devices which don't support checksum
offload [2], we need to tighten down the checks which let packets take the
HW USO path.

The fix consists of two parts:

1. don't let devices offer USO without checksum offload, and
2. force software USO fallback in presence of IPv6 extension headers.

[1] https://lore.kernel.org/all/000000000000e1609a061d5330ce@google.com/ 
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=10154dbded6d6a2fecaebdfda206609de0f121a9

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in v4:
- Change Fixes tag in patch 1 (Willem)
- Turn IP_CSUM_MASK define into a local (Willem)
- has_ip_or_hw_csum -> netdev_has_ip_or_hw_csum (Willem)
- Link to v3: https://lore.kernel.org/r/20240807-udp-gso-egress-from-tunnel-v3-0-8828d93c5b45@cloudflare.com

Changes in v3:
- Make USO depend on checksum offload (Willem)
- Contain the bad offload warning fix within the USO callback (Willem)
- Link to v2: https://lore.kernel.org/r/20240801-udp-gso-egress-from-tunnel-v2-0-9a2af2f15d8d@cloudflare.com

Changes in v2:
- Contain the fix inside the GSO stack after discussing with Willem
- Rework tests after realizing the regression has nothing to do with tunnels
- Link to v1: https://lore.kernel.org/r/20240725-udp-gso-egress-from-tunnel-v1-0-5e5530ead524@cloudflare.com

---
Jakub Sitnicki (3):
      net: Make USO depend on CSUM offload
      udp: Fall back to software USO if IPv6 extension headers are present
      selftests/net: Add coverage for UDP GSO with IPv6 extension headers

 net/core/dev.c                       | 26 +++++++++++++++++---------
 net/ipv4/udp_offload.c               |  6 ++++++
 tools/testing/selftests/net/udpgso.c | 25 ++++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 10 deletions(-)


