Return-Path: <netdev+bounces-206236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45CDB02444
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313721699DB
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2545D2D3ED6;
	Fri, 11 Jul 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AzfdsjqZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1A65FDA7
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261014; cv=none; b=bFq16w5QGcVYnFsC3Ktr6SRiY73DqxkU9QLgKDSlqRFBs2KFvIOBnWxQaahgs3k8ULJHlIyA13+rxH7+EprSQXGWPfGaa+DI34HSX9thvB1rXlzUengxq5pm6ZVlFukKWDwiopPNHWG1zz+eC6QHr/HkZH04sqcgtJ4g4YJklZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261014; c=relaxed/simple;
	bh=Y/5M12zJLIKUrWV0NyXeUfhHXn3KDlgG3bAehWL39hI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iUiamD1QHy5wufOmXoGmwDYkN8Nv+yNA7Uqfq7WbpYQnH9yY0PpCAFBrwJBlz7eGDt1U4YfCBYI/9bR9510UKamHirNbAPpykRGigjE/2zIpnMvricVJuzznWG7jykxMfNPBfwsLPnjtlpziHFsOag7SGCuKQh+sA15FQ0p5utE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AzfdsjqZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31327b2f8e4so2453966a91.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752261012; x=1752865812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dC5AbYeA3G9FzuMg/xh/H7gRYrmuyRcD2A+Q7SzqQt8=;
        b=AzfdsjqZYtoq6Hng5KZJ1MMEOs4JSTUWESyeAYY30homGTN25IsTsQuGoZ377KoCKk
         5OzVxjktgGLR+zFh/pIYb/OMCrumU3iB+9L5LNjvEepjZN9RdHLwE4LZIqLWofE0HL4P
         hHvqiC9f+ao/Jok7/umL2BO+UW6x7zu22KsboMq8oejzaW1ZQjUhWdLsTxrkIMmGok8O
         1IX8zZzxvLL2ED6zvKzK4kOkfMacR/qPnEb9eYRGcVblCFP5efOUc32LExRLX7QrCoMI
         8a9ViZvLloeGyRSzqS9RaDf30kCgcsu5EOHuNGeKh4qU12R81hqhfTYHoVuyt37mjaAF
         ZFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261012; x=1752865812;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dC5AbYeA3G9FzuMg/xh/H7gRYrmuyRcD2A+Q7SzqQt8=;
        b=dD/PoyPD4+FmRm+b5feq6COnD0tGvK4xNx0XTda6xMtv+jpTcBgkgdyorsM01wMaQR
         dUaoybM17KEjLm9thsKL+Gb1S+PsuR2F6kIEHVT0NXYJ/TdpWcz+btHR/SWFXbaJzA+p
         Vc9pETEkYGK51qlcsG+PemvTWcN5nSiV2qujJlNUvo5KxFZM+SbJq78hPTWH4Rg3/Oya
         Gk4MDL18Mz/gSr0H57q6bSEPIsxNzsxnFYMobugWprtal6RxMDM7t1cexHPqXfYxWjvU
         nR3X2e9/b0LK5OgA2AtiHs8q8Lrd+Cw3tbWu8oxNESukxVdkQeNOITE2mbTEV65euO+V
         nFsA==
X-Forwarded-Encrypted: i=1; AJvYcCVzAlmntLl5I7cOgbSrbCgWlDhQjSPjb5JUhHfZ6XuyvDsVVi+JgnzkRibhHK76+JIyxgu7ILQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV2jRfFdV0dY4nrDHelju7eBW6rjWO1JJk8W+jxrEe8iVXIL06
	hbQonIIOxmETBgJEl2cJ8xDf5dmXqT3jTnbs7Op4JpRytu2hyVerOiIQMsDlF9zxnhEiXP0iaUM
	tk+2CKQ==
X-Google-Smtp-Source: AGHT+IHVof7DRvi5rm/Fim/GxlGM1psIhXI5RdVs+QBD3YIYHM4AnS2Xeh6yj8YBwp8DJt5tQayNNiP6xCU=
X-Received: from pjf14.prod.google.com ([2002:a17:90b:3f0e:b0:31c:160d:e3be])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d8c:b0:311:e8cc:4264
 with SMTP id 98e67ed59e1d1-31c4ca84ac1mr6926042a91.12.1752261012059; Fri, 11
 Jul 2025 12:10:12 -0700 (PDT)
Date: Fri, 11 Jul 2025 19:06:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711191007.3591938-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 00/14] neighbour: Convert RTM_GETNEIGH to RCU and
 make pneigh RTNL-free.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is kind of v3 of the series below [0] but without NEIGHTBL patches.

Patch 1 ~ 4 and 8 come from the series to convert RTM_GETNEIGH to RCU.

Other patches clean up pneigh_lookup() and convert the pneigh code to
RCU + private mutex so that we can easily remove RTNL from RTM_NEWNEIGH
in the later series.

[0]: https://lore.kernel.org/netdev/20250418012727.57033-1-kuniyu@amazon.com/


Kuniyuki Iwashima (14):
  neighbour: Make neigh_valid_get_req() return ndmsg.
  neighbour: Move two validations from neigh_get() to
    neigh_valid_get_req().
  neighbour: Allocate skb in neigh_get().
  neighbour: Move neigh_find_table() to neigh_get().
  neighbour: Split pneigh_lookup().
  neighbour: Free pneigh_entry after RCU grace period.
  neighbour: Annotate access to struct pneigh_entry.{flags,protocol}.
  neighbour: Convert RTM_GETNEIGH to RCU.
  neighbour: Drop read_lock_bh(&tbl->lock) in pneigh_dump_table().
  neighbour: Use rcu_dereference() in pneigh_get_{first,next}().
  neighbour: Remove __pneigh_lookup().
  neighbour: Drop read_lock_bh(&tbl->lock) in pneigh_lookup().
  neighbour: Protect tbl->phash_buckets[] with a dedicated mutex.
  neighbour: Update pneigh_entry in pneigh_create().

 include/net/neighbour.h |  13 +-
 net/core/neighbour.c    | 372 ++++++++++++++++++++--------------------
 net/ipv4/arp.c          |   6 +-
 net/ipv6/ip6_output.c   |   2 +-
 net/ipv6/ndisc.c        |   8 +-
 5 files changed, 198 insertions(+), 203 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


