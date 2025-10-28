Return-Path: <netdev+bounces-233403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6F2C12C73
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC074269A9
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49CD272E5A;
	Tue, 28 Oct 2025 03:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HQhEbkcE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5792438DD8
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622708; cv=none; b=rQfQsJW4Jq4qvQmIei9T0jO/lYdbwBHTLhUfyEv+sny6Fu3q49HZkg6YXCoz4y+cVLifaQSxJBydvvj17ckd7Hivl57K3dd9axNN1d7ElfumXf3Fm5PINPqku0HtOrbzlgySRwaVvC0t0fW49HW18dL+6wlTWmt6aEW90QjyVxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622708; c=relaxed/simple;
	bh=RKSf1DTN14jIQRAinPCIlH2+33N6D3M0pxiLrcypPoE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Bf84OYfFSuddzaTHa2EjrfUB634pB0RIFQEoOvAp4k/F5ZJhtzVCoXS22jq4nwg59VqXnUtfN3g+8Q6oDLlyIRqjOaK0d/TWbJNn5pIH9a+7oP98LeMH2TPNDmw8R1TRwLtCWZISjBmV01LXVYxdG0GmVKdbM5alPQi0mzAUhBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HQhEbkcE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-294a938fa37so53532125ad.2
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 20:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761622706; x=1762227506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7+KazomY0jSsNhmU1AfG4boyG9HK3mqLv5u8AnitkBo=;
        b=HQhEbkcEfrpJVkVxON6P4ZQYhwWPW0A6pUR1dEgFjOJeoUJqb9AG3wo70MuLTvX4e4
         X7Ngb+6HpszRqFJNHgFF/RDtaf3YZWiZJNwtF38RIjcPKztZSU7KmcY9fNz6Oy0xGKql
         Xd+d/hI8bI0nzA0RnvH4OCpdkXO6lvzX8kXHX7ZPC6DtB15KC2rT+cS7IeXrFiHa70Zn
         JUAGGetrmJ9aijexFTefSO+bZ0NHW6c841QcJTNUrUsZ8x4xGQodMN3OuCRCrUvAx2I/
         3OEqOFWiWEEZbY9MojODU+hyA6L8m4rzBcBPGNiMs5qn7F0/QC4DCsXq4cKnn2MTDAGi
         x2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761622706; x=1762227506;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7+KazomY0jSsNhmU1AfG4boyG9HK3mqLv5u8AnitkBo=;
        b=lW51GQjSN+z9rQu7DCttwW9E51HKQSw56PtEq7aOdcmxMEJR6yxsWdi1Dt/o3dLhOW
         DzJXtkw3Nxbf/s5C9yqtg8vEk9794UaTQj6bamialDmvkUQDXI7GmflG9RTbNDtgbpVx
         tNXFw5bkuMxYzNPnp/aeTDeHwGLu67Jdvo+9yAZKJFOdo7kT1kf6cH8JTjcGnHWte+Zp
         bGahQijROIwuXkAheCPyg9iE5l9b/5Uvy7NKuaRXUp7WjLgOABHDgOGBgKYRWV9jSDZ4
         edWE5cGmaeKpIB9Tr9mYERP/QEpwyen9VSVhfclRzqtyUgXmY3mZLAKcuezu5htbGEKQ
         oyDw==
X-Forwarded-Encrypted: i=1; AJvYcCU66SjKtK2Bpou3YxwgXLUxXDMbPj5P1OXIZxbQmUB7WiWM+H1SJFtaPq2ezex4p07RUEn0+Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyra1nkBN0M0oinIncK3cmFujx/9YMvJjylOnJ2s+ls4neULsmx
	fZjyB2uuQlKh/x1jrCkHeklA+lYfeFicE1wc5Iy9oBlL5oYMjzoDCage8XGUECuCdt1pBodzoQz
	cNta+iw==
X-Google-Smtp-Source: AGHT+IGrfQYaSSsn3G1BBDeiRpcRPXVpMzqJGa1S32/AQ6/7lYXbPEExYtN/5EweddVTkI6PHDf8FOTQaCA=
X-Received: from plsm19.prod.google.com ([2002:a17:902:bb93:b0:28e:7fd3:5812])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41c6:b0:24c:ca55:6d90
 with SMTP id d9443c01a7336-294cb6b10b7mr20112115ad.61.1761622706606; Mon, 27
 Oct 2025 20:38:26 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:36:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028033812.2043964-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 00/13] mpls: Remove RTNL dependency.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

MPLS uses RTNL

  1) to guarantee the lifetime of struct mpls_nh.nh_dev
  2) to protect net->mpls.platform_label

, but neither actually requires RTNL.

If struct mpls_nh holds a refcnt for nh_dev, we do not need RTNL,
and it can be replaced with a dedicated mutex.

The series removes RTNL from net/mpls/.

Overview:

  Patch 1 is misc cleanup.

  Patch 2 - 9 are prep to drop RTNL for RTM_{NEW,DEL,GET}ROUTE
  handlers.

  Patch 10 & 11 converts mpls_dump_routes() and RTM_GETNETCONF to RCU.

  Patch 12 replaces RTNL with a new per-netns mutex.

  Patch 13 drops RTNL from RTM_{NEW,DEL,GET}ROUTE.


Kuniyuki Iwashima (13):
  mpls: Return early in mpls_label_ok().
  mpls: Hold dev refcnt for mpls_nh.
  mpls: Unify return paths in mpls_dev_notify().
  ipv6: Add in6_dev_rcu().
  mpls: Use in6_dev_rcu() and dev_net_rcu() in mpls_forward() and
    mpls_xmit().
  mpls: Add mpls_dev_rcu().
  mpls: Pass net to mpls_dev_get().
  mpls: Add mpls_route_input().
  mpls: Use mpls_route_input() where appropriate.
  mpls: Convert mpls_dump_routes() to RCU.
  mpls: Convert RTM_GETNETCONF to RCU.
  mpls: Protect net->mpls.platform_label with a per-netns mutex.
  mpls: Drop RTNL for RTM_NEWROUTE, RTM_DELROUTE, and RTM_GETROUTE.

 include/net/addrconf.h   |   5 +
 include/net/netns/mpls.h |   1 +
 net/mpls/af_mpls.c       | 320 ++++++++++++++++++++++++---------------
 net/mpls/internal.h      |  19 ++-
 net/mpls/mpls_iptunnel.c |   6 +-
 5 files changed, 224 insertions(+), 127 deletions(-)

-- 
2.51.1.838.g19442a804e-goog


