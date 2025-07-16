Return-Path: <netdev+bounces-207617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0E2B08046
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BBE56646F
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A722EE295;
	Wed, 16 Jul 2025 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TVPxDp+C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE3DEACE
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 22:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703946; cv=none; b=aYxqqn4pLvUhHbwa6WAns7jS304B8xCFPbXpGw22jbOjpufMJjDLpMhTp7aJ+/4zm+ZTLJ/1IdGLKK3GAjo9rivKLj+LWj9GcV4R3EdCXnerFUEqIQFowBBQ6u9pUxVD/HsjGiGAOME1XN37Htq2PCl655L5RzgfFFbD5S3vQO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703946; c=relaxed/simple;
	bh=k+Mesw1RnjtaPwmMiUut0dQ9KglVoII7wx/HezRggqo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WJC8tWEAhAAmopnOqMBdRK4b9r+OreaGiFJ4F3zlc3vDXRpzBl+XREzj389vfJiYtVMLuZv/Ku1+60BVuvCsNwvNAztXpV5vMOQZT+YSn8qC2OiI/uTQ0QsXTOcBMd7y6C95PTS7c2Bi8F5DsBmpjgz2lkh2Gjv3Nq1TEQFpJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TVPxDp+C; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c00e965d0so184667a12.2
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 15:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752703944; x=1753308744; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ACyA4jZEQy+g0hj67FmINgzKcsu3Ytkey1UJGietB3E=;
        b=TVPxDp+C392DR/ajy6mGBqi/j4OoAe5h28pFpEy+KH07QV+3CSZdPLmDEMQ+5Aau9w
         cnumBHfCfIEIT3dGWlb/ryuwoDJ0b7FYBULEu8mhy9qofkQdVEDfZLMW68Aj8p904mGf
         vwPORJkwaXG3UsMX+2jQr+ZkwSwpL2Yyvh91dIOeAwEmy72iS3vjyR562jXwaRLB1KlZ
         5bKoDP4PXFj5LK+MHjLDM3SEgOxV5Ulq78ydaUW25gB1Sy0Y/GdQv7D9ze9iVUmt/6qP
         NaSuCwSdNDgWlaRHJ+rlTXASwl1RG1UAdeGN3IzLYDWH1mMDfFmXRp8RBU5Bpm9G7uNx
         57/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703944; x=1753308744;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACyA4jZEQy+g0hj67FmINgzKcsu3Ytkey1UJGietB3E=;
        b=V2OuJsLZW+kvX3DH8NjqPxaOvX8vym9vV/XFXdKKVdXQN4xq2E8QEY2bgyz3pyCKPL
         nFqyBNcCEeJ+eh3wBxXfiJUja3vrJ8cZ+yklbG0hpT5kNtlscmpUJ448G3VPeda9gMFu
         prtM6fSvSKxwbRST4CsU8zaHvHAnd3KsYnWGoBQAupVSsTNm4aQdBLjAJHSqktZyxd2Z
         a7JoYUoJ6hPDjAzCGn9ma2ZnUCULHhTMppFTBsg7ByJZIFImD9tLsMYA8HeQBL5ttCPM
         P/soFFLRK8Uhvoclg+/oXn0hu966krnTlPaK8JSQC/Wsinbm11pLQGN9V883/VxyXNPX
         OquA==
X-Forwarded-Encrypted: i=1; AJvYcCWBCg2rQ5eCOKEq5wTi/8kgXxb4CrgWzY37GKP0A0FIJqqLK76IJPQpP0take/NmiywMJP1YZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFlKBpIE2tyiNpXH7ufhuOedSI8hyXjlf7Ma4yXPMhfpySmoYd
	oOgHQ7HgZTsbqUZ/NrZU6lrWxPH4UC5Ma+MbLxDpNN8eW+yHcgpy0W9KxX/xx/nk7IuGNm57SPT
	6jhXrww==
X-Google-Smtp-Source: AGHT+IHuzFFC+YqmDOfppBhKEc+ATiDAs5fAwLDqAqWudrqI8U+P9D0mg223Zs3uu1DiD5NRon95BycvkE4=
X-Received: from pjq16.prod.google.com ([2002:a17:90b:5610:b0:311:485b:d057])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ecd:b0:313:20d2:c99b
 with SMTP id 98e67ed59e1d1-31c9e6f680emr6171381a91.9.1752703944173; Wed, 16
 Jul 2025 15:12:24 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:08:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716221221.442239-1-kuniyu@google.com>
Subject: [PATCH v3 net-next 00/15] neighbour: Convert RTM_GETNEIGH to RCU and
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
  v3:
    * Patch 1:
      * Return ERR_PTR() direclty instead of goto in neigh_valid_get_req().
    * Patch 2:
      * Use NL_SET_ERR_ATTR_MISS() for NDA_DST
    * Patch 3:
      * Rename err label to err_free_skb
    * Patch 8:
      * Cache pn->protocol in pneigh_fill_info()
    * Patch 9:
      * Rename err label to err_unlock

  v2: https://lore.kernel.org/netdev/20250712203515.4099110-1-kuniyu@google.com/
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
 net/core/neighbour.c    | 384 ++++++++++++++++++++--------------------
 net/ipv4/arp.c          |   6 +-
 net/ipv6/ip6_output.c   |   2 +-
 net/ipv6/ndisc.c        |   8 +-
 5 files changed, 207 insertions(+), 210 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


