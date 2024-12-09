Return-Path: <netdev+bounces-150116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1B89E8FB2
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 11:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701CB1885CB0
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA95E2163A1;
	Mon,  9 Dec 2024 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dFAI0al/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498E514658C
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738871; cv=none; b=ZM96TCbKOa04FH8es56de8SzzAvwNeQQ9TX3A0Osz8QiUXoF6kojR/SMYrytEU1fds0d0s+Rc0rfbqCLBr859VrgKcyZHXNSPs+NEj4hnHcLo82T9MFiaDLGx5M7rVoo6au0lLAbXGr4n8waqsCS/vqW8ksk0aYMyaBY2Ku4eYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738871; c=relaxed/simple;
	bh=7/QFYrIucxIu4JVKWt8Fr/FXGcFt4I6k8ZCkoCQc/0U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bRsr61A592wX0mFizZcFe7wgrdJ2iCc+iW/PN3cXAsQdz36AY+eFJF6pkPX2rA8PxVyTNn3k8DLZ6J7IoLH9WnNkIfkhUkANdceoRcedJlHl+vpoV9qjaA8gnVSH1UVW0TJX2hAMTPlfQA3BpecUFPtBvD69YuV7aTKVbgc0j8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dFAI0al/; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b6c6429421so282138185a.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 02:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733738869; x=1734343669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uANFO7U/koncysZn4RWMzdRkXZdHaxrLS1LM/vb954k=;
        b=dFAI0al/7j+OLws/dAFYREIb5qeW027LpMpoZSfV/vbyYiVKhIX1Tx9piCEoo1PMd8
         f/MpQ3dAk60BQif3KbBoeZ0h+iABHbqhn3B1jfK+0XZ1EkcPvMtpmycSS4Fs9x9y5dWf
         ZL3xW6tlweNPdYjLEu2g35EAtS3G4tRpzV5RRItht9jgDB9FdJ9n1ftLWW51GtnlSsN4
         RUwbZvRQdI+cj2OiW2wFkdVqmmuXqRyruZ4rw1DsWjbDgk5zlPGe8h9pj7kOABJCszq/
         gAW1DW3oyvvbU+w32bPLT1ObZb7IXiBoWJdmWS/ZsNlFKnVAYsP0lVTECAbM8QYdc9fZ
         vYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733738869; x=1734343669;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uANFO7U/koncysZn4RWMzdRkXZdHaxrLS1LM/vb954k=;
        b=EU8tfC+d+44tl2MfVhTFiheMX8HBUj7MYyscnLv2Uw9CdBKtk6dnRP6wtXSXg49Swe
         pKJiGGGte3rQZocvo6qku+XaAWtPqlWoMJFKsnxlkpsGZTv8JRU4YlvkxoHhW1hXm5RL
         O7Mf8+h0zMh3c8+76cDVUI2H8MY0RVRgGjkDvXkyQYKq/i0Stx+sPLtwHyZEyo5ES8XK
         1eiMr5sNSEkX4KXmwy1YUcT25s8/eLD1H9sZ9qRhYuUf5Zs0504hm2GT73jaLa3sRCu9
         icXvhhWD74a+6R4L0CCXTqYfn5KTdPwt/VsyjdT520Qkl6zGhut/ubuohfgGoHnYGtPs
         VyTg==
X-Gm-Message-State: AOJu0YzVHbFpr5MTPx5qdFuTxdbVeAXAhfFr/HZ1dp7fc507WAda3Wmq
	SnZODoFLOddthUL5sKVJ/mpOfkreWVgvlT5H/TUu7/tWSOJzr8TmB2i4ri9P0k0g44k8CU6C2Ns
	U0/jY8H1r/A==
X-Google-Smtp-Source: AGHT+IGRL8Yrr3ulMwVe2w7GQPI8sUw87ZjYqz8ltSnFKSL6uB74VXGnMUXoyeIy3ADLsA5Hv5jereJm7FA66Q==
X-Received: from qtcw37.prod.google.com ([2002:a05:622a:1925:b0:466:867e:7235])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:288b:b0:7b3:5858:1286 with SMTP id af79cd13be357-7b6bcb65a41mr2261462085a.47.1733738869264;
 Mon, 09 Dec 2024 02:07:49 -0800 (PST)
Date: Mon,  9 Dec 2024 10:07:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209100747.2269613-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/3] net: prepare for removal of net->dev_index_head
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Roopa Prabhu <roopa@nvidia.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Ido Schimmel <idosch@nvidia.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series changes rtnl_fdb_dump, last iterator using net->dev_index_head[]

First patch creates ndo_fdb_dump_context structure, to no longer
assume specific layout for the arguments.

Second patch adopts for_each_netdev_dump() in rtnl_fdb_dump(),
while changing two first fields of ndo_fdb_dump_context.

Third patch removes the padding, thus changing the location
of ctx->fdb_idx now that all users agree on how to retrive it.

After this series, the only users of net->dev_index_head
are __dev_get_by_index() and dev_get_by_index_rcu().

We have to evaluate if switching them to dev_by_index xarray
would be sensible.

v2: addressed Ido feedback
v1: https://lore.kernel.org/netdev/20241207162248.18536-1-edumazet@google.com/T/#m800755d4b16c7f335927a76d9f52ebd37f7f077c

Eric Dumazet (3):
  rtnetlink: add ndo_fdb_dump_context
  rtnetlink: switch rtnl_fdb_dump() to for_each_netdev_dump()
  rtnetlink: remove pad field in ndo_fdb_dump_context

 .../ethernet/freescale/dpaa2/dpaa2-switch.c   |   3 +-
 drivers/net/ethernet/mscc/ocelot_net.c 	   |   3 +-
 drivers/net/vxlan/vxlan_core.c 			   |   5 +-
 include/linux/rtnetlink.h					   |   6 +
 net/bridge/br_fdb.c						   |   3 +-
 net/core/rtnetlink.c						   | 108 +++++++-----------
 net/dsa/user.c 							   |   3 +-
 7 files changed, 61 insertions(+), 70 deletions(-)

--
2.47.0.338.g60cca15819-goog


