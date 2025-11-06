Return-Path: <netdev+bounces-236506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64082C3D5B0
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 21:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8D03A36F3
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 20:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2D12FBE12;
	Thu,  6 Nov 2025 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="128Y+g/6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C29E265CB2
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762460984; cv=none; b=AgvZlO5ImnKvymD5MNV7JbY5iqOnKIVkOJyU5AQq+2lVU8R6nnWg0IvYSfBc4wBOrzDvcawRX/IF7OObq6gMnk01TN+ZS3R6P0gvralKCpjSBvP3XyV/Jex86CKVN4ZsL8F+y5VGuuC748UvoLIQ2D1olRJeGUPM0lmvYZC1eUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762460984; c=relaxed/simple;
	bh=xHP6+YI5+E27meb2Nvs1MLP5kQRIT3dxXsVv8/qZlPg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CEGnEZ25hJgG0Z3OH8RndWZsZRHRIAEJi0WQgOQBjAbA8HUr74o6EOHWykba59P0sg+/wpk7Lb3Z0tc1DslBmX5PCr0RBHHl395isiExDXrh5z/0a4W6v/YJvO3rU34jTSSxsBh6uC8IeBLHcpSefP4oZKcFyXOXJpyBxGhRp/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=128Y+g/6; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-7868061f373so616937b3.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 12:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762460981; x=1763065781; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Oh496VGN8DiRIV3399Qmx6Pk3hP3M7c+iwr37LpbuwY=;
        b=128Y+g/6IYkUI7Y62f3aOyYOo2kiW+8lZtN2LPwdzxm8XxdUMnRLfEDfolLjrnM+r5
         9xXIC6Tm0XRKELLQe10ho87RRggRKUeGVx5qs5CPr0WK/0tb9e0M47JSQlk40Xe63975
         oSkCKN1/x+MNbFIzWv425++E6uIeFaacA+Ndb9DaS00CrPJ5T1s0xG/NU4VTkkulTK4U
         gOShbBOU07nUiUo2wgwCp3MdkfdVhnsVNZpopg1kI/E5wZ3CqzOZHbm9r9/9ga4TEOsI
         gjxMm6ovXSeElvOhsjom+XIuHyXN7L6ZwdS7n3OcqavHBJ+fMnYZ87YvMAMAwEOBFIn+
         Cl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762460981; x=1763065781;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oh496VGN8DiRIV3399Qmx6Pk3hP3M7c+iwr37LpbuwY=;
        b=YcuLY0iC+VJWdzOXhMrmeAh8SoRQBBgDtxABVFjCsHE0h1vjYL4+A8lPloaF5Fo6MH
         FdpJ6b4GK3ceD4zv0w5aYtk9GMauPtvlm6wn59gJU8G9xVDZqTmh4lcaI3/JDwL6fLyE
         hUlTbTA2r9BorRaA75vuooHTum9cSp3Mlf5OEcBAd6mz0Q9i7ZTZUmx3HENCSNTkzlmH
         KmYYrleOZyK5l0sirpNrZACQXYYMUjdId7+FxA1A78eeTFeHibJyeYHdM+r5pgNOsKHc
         3VBoUqY0Fro7fdHxSjVy2H/vhwhkI8FkTQ9zydVLLS9ziBhK/WAMuTa9Tcip+BnydXBl
         Ijng==
X-Forwarded-Encrypted: i=1; AJvYcCWAMRFkE2atfgkGvtG+wFb6ol1GJLkNw6PYO4/fvLTZlM0EEHDfC7tEhBtvpDbOmYeVkbql6W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGG9DVXZE3aG/5YiPt/DuJi+htwOHbTZC4UId4VfMiS5sX3+o7
	XESKJFAPuuNMRK7jBjIHO/BErmFJnc+I0zbxKgvEDdJcqdCmz7yozlklblz+8LKO427sYUapcsx
	12dbVqrx3p98XjA==
X-Google-Smtp-Source: AGHT+IGNxry3NxqklO9+d9cTTsbCINPR/5O0EkLLIxUk5Y7l2EdipIOduOkE5/1P0xply2yI+mGF38XluQqEwA==
X-Received: from ywzz25.prod.google.com ([2002:a05:690c:a719:b0:781:1c9e:fc79])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:7013:b0:786:8adb:8ae with SMTP id 00721157ae682-787c53cea4dmr5937677b3.44.1762460981548;
 Thu, 06 Nov 2025 12:29:41 -0800 (PST)
Date: Thu,  6 Nov 2025 20:29:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106202935.1776179-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] net: use skb_attempt_defer_free() in napi_consume_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

There is a lack of NUMA awareness and more generally lack
of slab caches affinity on TX completion path.

Modern drivers are using napi_consume_skb(), hoping to cache sk_buff
in per-cpu caches so that they can be recycled in RX path.

Only use this if the skb was allocated on the same cpu,
otherwise use skb_attempt_defer_free() so that the skb
is freed on the original cpu.

This removes contention on SLUB spinlocks and data structures,
and this makes sure that recycled sk_buff have correct NUMA locality.

After this series, I get ~50% improvement for an UDP tx workload
on an AMD EPYC 9B45 (IDPF 200Gbit NIC with 32 TX queues).

I will later refactor skb_attempt_defer_free()
to no longer have to care of skb_shared() and skb_release_head_state().

Eric Dumazet (3):
  net: allow skb_release_head_state() to be called multiple times
  net: fix napi_consume_skb() with alien skbs
  net: increase skb_defer_max default to 128

 Documentation/admin-guide/sysctl/net.rst |  4 ++--
 net/core/hotdata.c                       |  2 +-
 net/core/skbuff.c                        | 12 ++++++++----
 3 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.51.2.1041.gc1ab5b90ca-goog


