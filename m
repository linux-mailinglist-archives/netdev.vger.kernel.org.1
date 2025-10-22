Return-Path: <netdev+bounces-231530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE0DBFA14B
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFF318C71E5
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 05:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B732EC0B0;
	Wed, 22 Oct 2025 05:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="scwqqgCU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C62DECB4
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 05:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111617; cv=none; b=sUEdaGn95jiuG6Q+vWFxgxDCWCG/2wfqQa24NGZGJTZ8ZvcXCYFlEW05zrgi7WXzMXfq1AxIO9/rTs3azRM3NkZgx75XksHJz9rdj0JTKutIDO2njzABEEuUtLJwZ7met/Zl7WLRm60c4mYhZAXURKVCscMz/tXz+9OSrFffrZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111617; c=relaxed/simple;
	bh=wuoBnpV07fd3ioouVaXDJ4oOXJ4LjSLez5DTh7HFZ04=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NIdYusV0+KdOwtckyfa8xdHGEiYE6eu2K2yOr7MIJoN12Vcdd0vNRvFJhD8rSmA7/Qs31yIzXR0pvTnsSUmmW8qCbK3gsxHl1MV8SrCn2RvSFbDYTd2x82cwSY8iLWZSvLzKLNbeO3FqiTWC8mNQLg4l3D8rkEEWRHW9vmsfH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=scwqqgCU; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ee62ed6beso10818281a91.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 22:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761111616; x=1761716416; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S7u6MUQsMIqgLEPWcDA7jElaDFkXwJv3Z0Z6kL16ils=;
        b=scwqqgCUnQUyGYvU1kVFh424z9LSYN/QAL/VWbKXWC3VHer8tlPQzCo5BqRQv97ED5
         aBARVNogkVk/9NN0d7QhSS08SRz7+Xoorturnv04yVvmyzmU6JsEtSQAqOCPSno0VzkK
         KsoiVcqr7zJiPDVS3O8dCfMDxrFEeNAqmK7R1tUhVcpl3rGBb0XtE8aXpv4OJq10MARX
         PXWPQ02mc+z2gdjO5bSYi/bs4ur3NTZ9kaDfirceAdtTf3jhDIQHvfZ35zBUHkyKwE+X
         n67h/N+viIk+5qEB2qfIqgaoqPvmGV/LufmEwIV9N0N1Ho4yRaOWMJIMPkA83HCWHVqC
         KSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111616; x=1761716416;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S7u6MUQsMIqgLEPWcDA7jElaDFkXwJv3Z0Z6kL16ils=;
        b=XWwobnTnhPqHi3EP/OdYJHWSFFGbZQji4ah27RgvWlNtKFrp2Qd/eI7ZiHhHFRaegR
         dZkZJ6qZnq1TkWUHgFV8XfrxkoCY8HFTtaHO6DruptZfXNQK5nDjq2G9d/50sI6JphZQ
         +SkdlVIVj0vSsP4+AHgKK5eawny5osVAw7odf85mprv2rYSTfoyPrRCAvioM3rUtGbgb
         eBTgfLBhzFMfAz4icVUB1Ag8pPu6Y+2D7NWG8thLXeWYkzzLBZDAWx4LwlC4hK0E2Q6r
         bxEXA3DGEUrYLITA2hYtQ/bv1llPAP/GqFfk/GqX0oW/5a12OF5fYwOyPfbE19caGA0e
         QV3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaoS7xMdUZqTXpgcoibBltqQQEO86X3uyFyItZTh+1D00PmvHKfYJJ+eGP2TLIrdtIMiQFSAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkq2L2V7YB7JxkKXs/NP3W2uGmMXTbYgqkfotxRPQbB/CweMWC
	xQoBNjFi3i7246m2Mej5nR8ATo6CvLYMFJsMi67Is6M1AJeZbchdInVtltGLCytovZW7+zHZ3KI
	Gfrb6zA==
X-Google-Smtp-Source: AGHT+IF54QRTZEobUsPbnLcuB55WFeN4Cs+/nxt0eMoHXBsNFa9jDyp+02ZpaHoqT5JLrYzf59NN2v0F0iw=
X-Received: from pjsg6.prod.google.com ([2002:a17:90a:7146:b0:33b:9e06:6b9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2692:b0:32b:9506:1780
 with SMTP id 98e67ed59e1d1-33bcf88821emr26054273a91.9.1761111615688; Tue, 21
 Oct 2025 22:40:15 -0700 (PDT)
Date: Wed, 22 Oct 2025 05:39:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251022054004.2514876-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/5] neighbour: Convert RTM_GETNEIGHTBL and
 RTM_SETNEIGHTBL to RCU.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patch 1 & 2 are prep for RCU conversion for RTM_GETNEIGHTBL.

Patch 3 & 4 converts RTM_GETNEIGHTBL and RTM_SETNEIGHTBL to RCU.

Patch 5 converts the neighbour table rwlock to the plain spinlock.


Kuniyuki Iwashima (5):
  neighbour: Use RCU list helpers for neigh_parms.list writers.
  neighbour: Annotate access to neigh_parms fields.
  neighbour: Convert RTM_GETNEIGHTBL to RCU.
  neighbour: Convert RTM_SETNEIGHTBL to RCU.
  neighbour: Convert rwlock of struct neigh_table to spinlock.

 include/net/neighbour.h |  17 ++++--
 net/atm/clip.c          |   4 +-
 net/core/neighbour.c    | 131 ++++++++++++++++++++--------------------
 net/ipv4/arp.c          |   4 +-
 net/ipv6/ndisc.c        |   8 +--
 5 files changed, 87 insertions(+), 77 deletions(-)

-- 
2.51.0.915.g61a8936c21-goog


