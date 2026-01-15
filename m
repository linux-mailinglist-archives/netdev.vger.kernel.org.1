Return-Path: <netdev+bounces-250072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC7FD23AAB
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84A3A3040F36
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8A0334695;
	Thu, 15 Jan 2026 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v0+Xsi4T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D18635B130
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470108; cv=none; b=XakWZrOEQe3YH2wzNt3H5r4xWs7Hvu57IyNUGF2qU9eXaH877oWFZYM6DT62qEmY5M5pKEdE/9aE4O68IzQ8Zw7fjoXZVoAY1fkR2G6waJwbUNrvII8+uIk8R8otrBMLCS2PMbF66cHXo5Nb2qKJcPa1JljvDUo0PXi9/i/xAN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470108; c=relaxed/simple;
	bh=qrFT6sja5gQP2TWrUd+U/7m0MO8ayyP5R3WP7X/5F7c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GQCHcC+4X9E/OCD3WdF9VOIh9KJdz6tnWeLedx894U34LJprULlwfVnykyV1umsdYgO+3babIfhYbnO6obvn5izTa0gUvek349iHaTa41RXeQ5Kvfnofjin4zVHPp4lx3pxOfOoEqsVi0602HS3RLh2+W8S1+uXTEHNlor/WblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v0+Xsi4T; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50147745917so29385361cf.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 01:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768470105; x=1769074905; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=piA5HijB020l8/ztEAXnkgFoK3EatsUXxqPaokjDQgw=;
        b=v0+Xsi4TAucpqJ2GFTqyKFA1M0uuseMvKxWBO4PTNWIGDoikvCgaGucCQSmyL+ipjl
         bZ4ox7GbLGy4sApLPmkmxvxGlvp6Y7/9bxPw3yQE+Xr/9RMp0xCjHO95wWCqm+DdLd8/
         otowjcNNahNMHnGtFQNxsAVA1K6dWN2BH8fikUK8mhjhWglP8lgzk9r9asB1sK+R1HNN
         sTyU45v+ly2Blfi/DbbQa/FPLv231RhWUyh9htZnKKHTvXi8A6m+7GgHaYNYKFxq2494
         UkAz0GEZhoYTM0p5+EhO86oG6kJ8S1/AwUgHAA8d0Uh4A/PO+i9IrYh/VqKTo0/uYZBk
         39vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768470105; x=1769074905;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=piA5HijB020l8/ztEAXnkgFoK3EatsUXxqPaokjDQgw=;
        b=kNedQLBPISpK9bqHsQ+sgWJCnivfsJKcMZqK3r5zYKPrSiYsX9vibQsyOPNxZwOLlK
         nPwP8M8tl+8zmNLRYK7ZH+L6BGFQBEpY0SeNHnSH8IZW/AFq/UqD2zBfs6FLdOLrZ7KD
         J1k6Rd3Tei9FZYT1pN5Uq+ncjrsIQ9+DxuwUsodIQPINC5OIXXAHSQKgwhaPqeWkdpfs
         ItN3tv4EImo8z8J3T47v4MizXxhkkTEE0TbKrz6VGPPkDOsUkvllvzbJpFscMr4eN00y
         EB4J1z7xg4wznZvczNLCr1vnYLxpS/rFcNREuzLeB5RvM3LxtPZa2LE5NE0eIfQneq4G
         2rdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0uum+U5GvhdijBBQkDJtpGVUDWseipDXVh1u9GUEG5fsNXMGXSsSoWNtwOQfrP3nqoFcGFak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgOo7NtudfulMnNhDYcyfqchFs7AOOoMiL2Y4/VGtcGWg/i1nx
	eDJ9GvZxBsL2jV1zTzNSKFsuDat/sTZXSoK04HODebGGvx+GdtQ3x5v4m63lCoUvEyPjhMEzWac
	lbvRbxM/ErBlFow==
X-Received: from qvbon10.prod.google.com ([2002:a05:6214:448a:b0:88a:3392:f43d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4203:b0:501:3c88:131 with SMTP id d75a77b69052e-501481f8ff5mr65995061cf.22.1768470104963;
 Thu, 15 Jan 2026 01:41:44 -0800 (PST)
Date: Thu, 15 Jan 2026 09:41:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115094141.3124990-1-edumazet@google.com>
Subject: [PATCH net-next 0/8] ipv6: more data-race annotations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Inspired by one unrelated syzbot report.

This series adds missing (and boring) data-race annotations in IPv6.

Only the first patch adds sysctl_ipv6_flowlabel group
to speedup ip6_make_flowlabel() a bit.

Eric Dumazet (8):
  ipv6: add sysctl_ipv6_flowlabel group
  ipv6: annotate data-races from ip6_make_flowlabel()
  ipv6: annotate date-race in ipv6_can_nonlocal_bind()
  ipv6: annotate data-races in ip6_multipath_hash_{policy,fields}()
  ipv6: annotate data-races over sysctl.flowlabel_reflect
  ipv6: annotate data-races around sysctl.ip6_rt_gc_interval
  ipv6: exthdrs: annotate data-race over multiple sysctl
  ipv6: annotate data-races in net/ipv6/route.c

 include/net/ipv6.h       | 34 +++++++++++++++++++---------------
 include/net/netns/ipv6.h | 10 +++++++---
 net/ipv6/af_inet6.c      |  4 ++--
 net/ipv6/exthdrs.c       | 10 ++++++----
 net/ipv6/icmp.c          |  3 ++-
 net/ipv6/ip6_fib.c       | 12 ++++++------
 net/ipv6/route.c         | 24 +++++++++++++-----------
 net/ipv6/tcp_ipv6.c      |  3 ++-
 8 files changed, 57 insertions(+), 43 deletions(-)

-- 
2.52.0.457.g6b5491de43-goog


