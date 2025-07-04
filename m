Return-Path: <netdev+bounces-204026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB12AF87F1
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC2A1631EA
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C26B262A6;
	Fri,  4 Jul 2025 06:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u3ugOZ/b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196CE230269
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 06:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751610261; cv=none; b=BBzHxIqCWn+ePoZKqPYD7Hnz9LT+eK2AbcK1JXOql+uNTManVtttqzV1eOklJkz4/dSJK2m+7BEAjrasdu5DyHRku6WGF8MrHM55dG+J8zYm1R5nF4JJFbIu8LU2RcmWAtPTsHZunTRofhztWexEh+ExvHsipRwSlw1ogYNOALk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751610261; c=relaxed/simple;
	bh=KNlJ6SKXk9vFaic+qHIpuiWNHMBBXuQDjbUCgfHgZm0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BgmoBQUwfCMw1Tij83f9zZqZ4MNy2cKhsPmOL1qJ7czmtyk7VX+U8nzlo0cSZFpqEOiATcSSYYsgvENVnXT01YDJU3mmScrTXirSV17Jomi01bVLOImtQyAhRKXwGt7BWAZmFvu/Tv526fwZU8MmhUr7y1yC7RWOQMlanvq5S0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u3ugOZ/b; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3139c0001b5so683695a91.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 23:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751610259; x=1752215059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=th9+JXhu2sR1hMGcK2QjyP9l5Cqx3GAVSQmo8JFtPVI=;
        b=u3ugOZ/b8dxdMc7j2TIhs+iKnRocrTxw90J+MfXFQm3roTCVLyDCV9dLFbMZRfSVvM
         PcQ5YscMsoPYWewD7YY325gEsrnuRTX5KzzUOISfs3NfvBf6NYGzaJ7tu0js+cbfz4bN
         /91j3C8XMnpT1ItcmxSMoJiiFCTq3DayJ22YPL4wNHLDyTzlPbw+rw76H912Lm1T7mWV
         xekF9+/t+imXiOuN8e73GeVVb4oRQAXQOFv8+KBhikyKyagd/ugKk8Q7vs8RSZ3aV9Wn
         KcIB4n4vuzCmGJsoZAQUsQIr01S8YPnS/hb1Cbm/ZgyR21qLvOEovFZjaDL0rnve5znL
         HUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751610259; x=1752215059;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=th9+JXhu2sR1hMGcK2QjyP9l5Cqx3GAVSQmo8JFtPVI=;
        b=i82VsvXDTyj2L3WuYWekXyvcwsAXlq7uZtqi2dELC0JMQn0RLprzza2lM0FQ32Q7E0
         tSdFuy4I9OhJteBIx3u5IlSwYPoIDuwLghY34mzh40oe6XPLAgt2mDEEB2swvNgen+vp
         g/mqgh/P6ltqUHWh4u4swcdi1XN0AZbpZJevvTqJwUtYpVS3fte+KAyGl5XvCvsW1Oog
         IEPJQJvxw8rfbUS8P2vGpZjltguJKhMALAvQSld/g3WtDpFYlJcSiRhuyXojinlVpc+o
         lKjSLzR4+uOxy+XwN5T95xG7boZvbK9TMC7liA3AeDZ6xX1Wh5IbXCUk8aip3v3b94P1
         y7Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUUBKhBNOf3KxTQI1ReGiJeDsb6OpmRzDin0DX9qOY8pDVlkwSZn1+NxMFY3rAYNXgc06ZVENk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp8cZAwUJPLN4VuXkEBWwuOO48PWB0q7DYeyN/if3WQDZOiUrl
	hD0OZWBIYKCOjo18gra+fCPOCaAzytXFtMTIsG0H52UrTlX7sYPGfstdSwcLBH8BemA6A5XgP/y
	NPPxuNg==
X-Google-Smtp-Source: AGHT+IF1xBnYVRijo4xEoU1iXqFQQxVPJT1mLkTY+RJhsOrxcyPuRxiNeoufz73F8ENje24LDcJla/ZZgqA=
X-Received: from pjbnd10.prod.google.com ([2002:a17:90b:4cca:b0:313:2213:1f54])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d8b:b0:311:abba:53c9
 with SMTP id 98e67ed59e1d1-31aac4392bbmr2576553a91.7.1751610259442; Thu, 03
 Jul 2025 23:24:19 -0700 (PDT)
Date: Fri,  4 Jul 2025 06:23:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250704062416.1613927-1-kuniyu@google.com>
Subject: [PATCH v2 net 0/3] atm: clip: Fix infinite recursion, potential
 null-ptr-deref, and memleak.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patch 1 fixes racy access to atmarpd found while checking RTNL usage
in clip.c.

Patch 2 fixes memory leak by ioctl(ATMARP_MKIP) and ioctl(ATMARPD_CTRL).

Patch 3 fixes infinite recursive call of clip_vcc->old_push(), which
was reported by syzbot.


Changes:
  v2:
    * Add patch 2
    * Patch 1: Silence Sparse __rcu warning

  v1: https://lore.kernel.org/netdev/20250702020437.703698-1-kuniyu@google.com/


Kuniyuki Iwashima (3):
  atm: clip: Fix potential null-ptr-deref in to_atmarpd().
  atm: clip: Fix memory leak of struct clip_vcc.
  atm: clip: Fix infinite recursive call of clip_push().

 net/atm/clip.c | 54 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 15 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


