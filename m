Return-Path: <netdev+bounces-165612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30429A32C13
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 17:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51BA3A815A
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 16:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E9424CEE7;
	Wed, 12 Feb 2025 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1eE4/wHy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25327243945
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378607; cv=none; b=GV0nF/9j8OwM1xBzFzBQ8hqpYBxzLCItHuo6GWur/cD4MQa0YXiMHHNp0GBd28lQRNHn9x2CiQdoOI8sC4GIoD7keXm4k80GAQ1wnJmTp8/mSbNk+tVaLoOBaZKrAuPc2P3BjUVqFggKFDAii9TLyYCA+tnZ4zN1+vMB3wlDn7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378607; c=relaxed/simple;
	bh=ZLnMYDLCOWZLgLlUUVNj/Kugbl6UaOyZJtCl+eT1kuc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UvaxyW4REq47nfORB1pwo/AnAfRgiKIf78k79lqdiU4shhfdPWklgmOZVuafbfZ5/3ZVHiky7BW4QEbtiVkcMTNRLUxN1tGJ3rc9SRTNidT6iIPQSMMPPT3YYVWECBeWVroJyQTdSsmDH1qM7WJtYC7ZS5SL1k+/ujCSge9Zydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1eE4/wHy; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4719a88385cso50031711cf.2
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 08:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739378605; x=1739983405; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ikFqcDgco3iJtU0bplnmMhcD+waGprtvHyGJfWxc04E=;
        b=1eE4/wHyz+ojMuspFywk7P2LbC2Nu5xQ1iFeMuGi+iRRg4ksWUjjFSWbKmgeWo+sZL
         Ai3zWDUKev6GrTsSh9OxGnxCMxFtUjD1fjXYPtVQkdcwbRhE6ZnNI6Q2ekmdpR47Olfw
         /8ygPBxtg2LdzBXnGnttau4EyUaNDUOImlBH+ei8lJtVhALZuRb8g+Qdh5xOJIrM/bUx
         RixgeAHOiAFrR+vutzfO7iXwyw8wYdv7h+PK89DtBVCmgEGyF6e46Lpip63Z1lBVAVyT
         Cl0hKfJiRxe9FKZscEpQ09q1W9yAAgHOzZa5eg5apEVhcxZTrbUA/7eDwPtqfeHuSr6s
         gHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378605; x=1739983405;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ikFqcDgco3iJtU0bplnmMhcD+waGprtvHyGJfWxc04E=;
        b=M/zohrMRn385NzclX5+neKgy8zH5w/7ifAQxV6E+23lZqTU82ygqds6psKqxzL3HnH
         /DsxjnoonUSBNMuGMdlA8NaYikQndDGJ828l1IbfT/00oWVxk8Z6YFA2LWUVVV45Vq8t
         OS40EvXv1EAy56zHV1smAulP82cbjRTpWK+OUHGgmS7NaF3/ZE82j/k7Vs36lUAmcDb7
         YiVXU2hACk9IF2ZSMNMXUUhUOGfTCcFwryWlcJ/OhxSQ5kGdnbK1LFypYdoCh9e4/e1V
         jABm91gn9yetqnuVS+00GygIDoe0zmyAd1gIs9xTBAS/e/QceVgbEC/byHYHBOMisOy7
         k4pQ==
X-Gm-Message-State: AOJu0YxXhWJ2xYl/o1xDI/ClloAUyBadLUr/J/6IotHGsD7rJojtTguQ
	92i5xLQaqEmmeqp2PwO7wiCpwq5krsLm927uKX5Eb8FEd34C2IzXIPJ6+K7TJKxZX7wFlBdJjFG
	z2bdU5iFCiQ==
X-Google-Smtp-Source: AGHT+IEBW7NTcqNjzIlEg+G1N7neNiSUmsZa7GkTcvijAIlvxUuX/bTELqqvv+dKWZT5Ntp22AzHcLBegPbg8A==
X-Received: from qtbay29.prod.google.com ([2002:a05:622a:229d:b0:471:b323:1344])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4188:b0:461:169e:d2dc with SMTP id d75a77b69052e-471bedbc5f8mr673291cf.49.1739378605009;
 Wed, 12 Feb 2025 08:43:25 -0800 (PST)
Date: Wed, 12 Feb 2025 16:43:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212164323.2183023-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] net: better support of blackholes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Paul Ripke <stix@google.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

First patch is adding a new drop_reason, for packets
that are dropped by route blackhole.

Second patch changes ipv6 to no longer report
local errors for blackhole users.

Eric Dumazet (2):
  net: dropreason: add SKB_DROP_REASON_BLACKHOLE
  ipv6: fix blackhole routes

 include/net/dropreason-core.h | 5 +++++
 net/core/dst.c                | 2 +-
 net/ipv6/route.c              | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.48.1.502.g6dc24dfdaf-goog


