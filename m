Return-Path: <netdev+bounces-206362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65119B02CDC
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8282D1AA5645
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC3F21A433;
	Sat, 12 Jul 2025 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T3SJoc17"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4389E10F2
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752352522; cv=none; b=GmMLvaLs/VvzkolwxuP9PvNw9ET5pnscnRkQFB/mNs83A9gVPB149ZKV6DRLVAAySAbChTdmkNmhxb8kvSsDpm6AuB1/rbvak2qe1qbGxCNN15E7vWhnqX1SWZDbMGlbFA/1ZTM+txP4IHkUi5saQV5sEmYfQrMqd+XEt2VhUAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752352522; c=relaxed/simple;
	bh=/kcKw4ZmwFFGjpUYHmAYDecqS82qz5QyEWDfBcPgvbk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b3FusfU0dgaYqYV60o1FM5Y92qZ4IJZiJEZVit4X0/SzXpbIruF1p+YoCLwM7LDDm8PIb61338c0GhzAi39zl8NUnv8489S7C7DeSA3YSi0snEF8pOzRC6+jOMqEOGyKOulI9JmbPCAzk4VJczrwTcelIpDVmzgD+iLisU2J0Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T3SJoc17; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b34abbcdcf3so2311723a12.1
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 13:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752352519; x=1752957319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t7s658iomEd5obLlOk+QsUbFSaVt7QT1QUhfqIbXu5c=;
        b=T3SJoc17W46tGJmv25EhLhCfmq37yBwlJK20hbepnqZ+4Gk0QHXXxyZNUIal7Yu5O8
         viiF17tmvyXve2KL9c+HegtuDGy7SEhBjzrkTTG7B9eq5ZZmRURDuX+aphcvfDXF2Emv
         oGhRhgivyYOQ8iivYnD6eiC4+uSvAdO4l7/+lYdqKuxwnvC4GZmVaLtFoOVLbouHyowY
         t5m0qdIlrS3Y4W6quwHTEAlI6k6bF9CZD7Q1UT5XeaGu+Tt4vWAlo4pgM1hxE+nk7fOj
         JGDKEJNnKjzPdXhLsDvP5OwAydbobWCZPfUPbhzMvkR68jj+Wvx90u18G2zTPcshlZlY
         BM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752352519; x=1752957319;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7s658iomEd5obLlOk+QsUbFSaVt7QT1QUhfqIbXu5c=;
        b=cxcDGGAUMJYMRcmFBUDHD7z+/kqcISkC5r/XAFa4TCkvEzUEsws6Y1nyUVQbxrn4EI
         L7jhSt6wv3GE0y5RnmJHOOyCj6k4cvtG61TeM90/1KO1qs/WVWtvKesslyBCNrpBAoYd
         WR0bdo3JL3K8uzKpIsxgu4nver0Wp5li6zgM1YoqrzlUdJnl++SI7qDplUfUvFophIq6
         yNnfrnA3NsFG5oNaqupPP1mLRMwAnaaLo2OaHQ1PF/VxodMzrPOlh3CIaeab7qPjUGUf
         Nl4088G/f7+rSeF6WEJYi56IU66EA4XdyI7TY0oUkhTPr8C8WY7gzE/NUwHJn4bTXE88
         4kow==
X-Forwarded-Encrypted: i=1; AJvYcCXbezWDGBg4MAxFrRM2XGIy85RUtdGpyVA7r4rE2kSZCmrLLnIADvI3xVDYykpGGEUWd/ijF5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFV3/NgYsBHtdrrWVIpenD3Xb4ARR1HBT2hDP9o9lykisotO32
	IQqXhSERcpSqVaCfSkSTaokX6Xr0L+g2obuDRtExb3QDt6w3eWJRxq67ASDwHou/u+LkQOBiK9M
	wU6viqg==
X-Google-Smtp-Source: AGHT+IHhN4n74e7g2keCT0VEe5Zm7m7m7IR+B94uC2ODPbj8KxTuLHiuCTIbYmZfGzJHjo34bxZX5vAqNho=
X-Received: from pfbik4.prod.google.com ([2002:a05:6a00:8d04:b0:748:e276:8454])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:138c:b0:748:f1ba:9af8
 with SMTP id d2e1a72fcca58-74f1eeca8e2mr10419873b3a.21.1752352519425; Sat, 12
 Jul 2025 13:35:19 -0700 (PDT)
Date: Sat, 12 Jul 2025 20:34:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712203515.4099110-1-kuniyu@google.com>
Subject: [PATCH v2 net-next 00/15] neighbour: Convert RTM_GETNEIGH to RCU and
 make pneigh RTNL-free.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is kind of v3 of the series below [0] but without NEIGHTBL patches.

Patch 1 ~ 4 and 9 come from the series to convert RTM_GETNEIGH to RCU.

Other patches clean up pneigh_lookup() and convert the pneigh code to
RCU + private mutex so that we can easily remove RTNL from RTM_NEWNEIGH
in the later series.

[0]: https://lore.kernel.org/netdev/20250418012727.57033-1-kuniyu@amazon.com/


Changes:
  v2:
    * Add patch 6 to silence Sparse __rcu warning

  v1: https://lore.kernel.org/netdev/20250711191007.3591938-1-kuniyu@google.com/


Kuniyuki Iwashima (15):
  neighbour: Make neigh_valid_get_req() return ndmsg.
  neighbour: Move two validations from neigh_get() to
    neigh_valid_get_req().
  neighbour: Allocate skb in neigh_get().
  neighbour: Move neigh_find_table() to neigh_get().
  neighbour: Split pneigh_lookup().
  neighbour: Annotate neigh_table.phash_buckets and pneigh_entry.next
    with __rcu.
  neighbour: Free pneigh_entry after RCU grace period.
  neighbour: Annotate access to struct pneigh_entry.{flags,protocol}.
  neighbour: Convert RTM_GETNEIGH to RCU.
  neighbour: Drop read_lock_bh(&tbl->lock) in pneigh_dump_table().
  neighbour: Use rcu_dereference() in pneigh_get_{first,next}().
  neighbour: Remove __pneigh_lookup().
  neighbour: Drop read_lock_bh(&tbl->lock) in pneigh_lookup().
  neighbour: Protect tbl->phash_buckets[] with a dedicated mutex.
  neighbour: Update pneigh_entry in pneigh_create().

 include/net/neighbour.h |  17 +-
 net/core/neighbour.c    | 390 ++++++++++++++++++++--------------------
 net/ipv4/arp.c          |   6 +-
 net/ipv6/ip6_output.c   |   2 +-
 net/ipv6/ndisc.c        |   8 +-
 5 files changed, 213 insertions(+), 210 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


