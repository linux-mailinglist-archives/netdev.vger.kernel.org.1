Return-Path: <netdev+bounces-116563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7DB94AF35
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 19:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497202834BB
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 17:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4F713C8EA;
	Wed,  7 Aug 2024 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ADb053Ly"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCD713DBB3
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053323; cv=none; b=TWpNmK82k6o8LvKL9Ii451S856o+BtpEDDZlzxGEapcyUOsQn0YSjQ8sAs4iNKysML3sQyfiblegJkkmy46lHssvLbPfwRJOK1ltosOyJtG0xDamXT8oK5nGI+/LfvsEGNz/g5pp/xr7M6XNfJcI+AFrUz/Z3dHzXpLSVEJkXK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053323; c=relaxed/simple;
	bh=2JW/030LNJ9G7Bu/MdbjLdUBoWTxgoU/+Vv6FaaAcKM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D8cyEfuxVbAXd1WNMcI6ouar2U3u8dGZ2t5933ADdoPRBMCa2IUxPcbI6lSZgaHftpBnUtfnyPPfLbFAjEJ3TJgTkWkeMO0sPKOjSrrbHoNdchE4EEfW83glrg8ZVUUeeuMi8VpAcPf674+ZsMkrCEp9viK+CoyNplqqdHhyG+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ADb053Ly; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso51642a12.3
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1723053320; x=1723658120; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CIEBxuSXI6y7R7S221NSUS/jJDG04bd+Z+TePbY6Yrw=;
        b=ADb053LyZkUxxEHdZM5AFzf+j7GYRG54z4X4JNGX3gki2YgjtMRGmnTOkKxdpOOukA
         v8J/AfPb328IMHYU4vibYaCiK+QqYf7QH4TBt+D3uTXTIWJirBZMApZxj7NzpvsASTHK
         WGfPhiOHi4ADzkKjo2DYZb81PvvtOzcn4tsTm/ejhZt5HObrmf5zA4Ra3JCxFmUN9GIU
         S7DrMl8bASbdEXJVhsLRU45pZTIjOz8dOod5geqLM3kyMyrKpqODKR2SR2Y8dI0U1+Gm
         Aky9gqPgWHUrNYk7rSHYZMWPiSex3CxT7K6RdPCZuYlI5CJeYQSPm4v1X/B0p0GZI3Cn
         TMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723053320; x=1723658120;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIEBxuSXI6y7R7S221NSUS/jJDG04bd+Z+TePbY6Yrw=;
        b=uVned2Z3DnLDFIgImySt8VZ2lvRF3rTjCOOM4aJSXxYC2FsoZ6EodiEBq+t3InrB+j
         qQkhNu4ZtQgorQqSQR9doIkl5fSAED1bWCQ0XDSEwPnl9oBObB0iINeT8PH/Q2TQoQxQ
         nS0swdvNPQFTD3Bp/Z7X3thrjzLLrQ9x5NMzy9uBd1nv1SJJyrYh3vsmdTBKkkF7F27V
         33UATKwvdA+zviRpBwRwL6SgVRLttRiF9dNl1RTd8gLLYqfdjy77Zsp9q1dg7fsI5w1u
         2g/LWUPCQ9XgF+FVzQEWmQuAiVWpJ0iQzG7hpvjEgzE++sk51PD2VQQUoEAmvFW7qc3z
         vsvQ==
X-Gm-Message-State: AOJu0YwhP64odpTSGc/5l7D51Z3FIvYB6qZe/QSS2k0paVCCpD7fkyN4
	Yyqcjm/fnCR/nzTkE01rElhQFQf96tIyG28Xwsu/sVOPKGlN81mH8qsaYxQk1r8=
X-Google-Smtp-Source: AGHT+IGC/Dh5Jgdjo4y9T8zXZUVZ0yRpLQAnR/mMQWkqHnoiFvlUec+bXADFS3D9n2h6ZPsn05wX5Q==
X-Received: by 2002:a17:907:724b:b0:a7a:a89e:e230 with SMTP id a640c23a62f3a-a7dc4fa8ddfmr1361989266b.30.1723053320235;
        Wed, 07 Aug 2024 10:55:20 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0c0e0sm662880466b.67.2024.08.07.10.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 10:55:19 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net v3 0/3] Don't take HW USO path when packets can't be
 checksummed by device
Date: Wed, 07 Aug 2024 19:55:02 +0200
Message-Id: <20240807-udp-gso-egress-from-tunnel-v3-0-8828d93c5b45@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPa0s2YC/43NQQrCMBQE0KuUrP2S/DZYXXkPcRGbnzbQJiVpg
 1J6d0M2LgRxOTPwZmORgqXILtXGAiUbrXc51IeKdYNyPYHVOTPk2PATSlj1DH30QH2gGMEEP8G
 yOkcjkDRkBCn9MA3LwBzI2GfBb8zRwu65HGxcfHiVwyTK9I+dBHCQJGXN84HE5tqNftVmVIGOn
 Z+KnfDjtVz89DB7Z4XKoBFSt/rL2/f9DY4NIvUeAQAA
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 kernel-team@cloudflare.com, Jakub Sitnicki <jakub@cloudflare.com>, 
 syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
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

 net/core/dev.c                       | 27 ++++++++++++++++++---------
 net/ipv4/udp_offload.c               |  6 ++++++
 tools/testing/selftests/net/udpgso.c | 25 ++++++++++++++++++++++++-
 3 files changed, 48 insertions(+), 10 deletions(-)


