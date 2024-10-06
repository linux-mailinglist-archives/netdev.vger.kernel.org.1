Return-Path: <netdev+bounces-132541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21D3992129
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 22:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618511F2102D
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 20:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ADE165F13;
	Sun,  6 Oct 2024 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pz1oT3+5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2509C1537CE
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728246750; cv=none; b=erJ0IDXLddkojL4n0Jv4poYmT/c1UbDhYDOPW+ko2/75quaJmCmMcDN3BB88+9rJ+Af8oF+R/KAp/bMyzq000Bfko/PPaZVWtH2pRdkhmidm1z24EAHX6JHKOr0LfZte+xF/HHLWR6jr8fUMqmO/0f74BSA9YW3qpsQhyfkiNtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728246750; c=relaxed/simple;
	bh=NdxfZwSQBpoqEe1WypDgdVckJndMq/meBTy/2JOs+Pk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eW4U/88KEVjoh1EIn4V8+dL6CKH6jFGSiyS2PUHZRWK9H7vEcPKI8QMDBkt2HsaHeSbfTBHTx8WUJn4yToswUnjgI1bd3Ait/LNyFVnJCVuKMRuGmcl/tcakx07Pl78/+Nm69jntvP8dt4sBOJ9jzxZku3wX/SuVgEYxMcTtnlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pz1oT3+5; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e165fc5d94fso5860589276.2
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 13:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728246748; x=1728851548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C2BcTD1PFRkm1/PIowQ7GoBbqYxvczxrQ5IravXE7Fg=;
        b=Pz1oT3+58w5EP6FY3Y5G2/5GO+bEI9RmI9Gqk8R61wdhlaUZjHgYY8c2aYtlVFWpE5
         coCzRlQhqZJorvVHbKF3fODm78+NAjLB7YBQz6nBwe8g7OfrqniMAd4SPraF4hpR4IET
         JB6bryIVEY1O6wAmzT3RvMmwTltHQpy0s3P9Gz3VVQlmALljNuZSzZjW94bgiTUkrWZ/
         pk1TXu1CaS3oWVE0rcFpQXiCwsl9RWZ208bu2siFcTUiBn2DsOS0p5zlmxVW4hFUs+4s
         bKSkaCmKgXncPe5qtjHQSgn8h0AdS/f9Mp/0jIw4oQFkPD/5uzAf8hQ/KL9kWf1KcHUE
         LzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728246748; x=1728851548;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2BcTD1PFRkm1/PIowQ7GoBbqYxvczxrQ5IravXE7Fg=;
        b=LUtNpi864doK9qjc51BCdW6JEpmTPf2e20jFZGMKh6TFxibkYOm3B8pqMAx5Edu7wq
         V1pM885Jzl2RGJ/N/QvvC2huGm48AG24vF5990ATR5RytI7oPiYHmyjgMysiAv/FsIPF
         ZHT1ayYBc8ph9dDmuJ7yEWBIMS+2szvJWgUa3pSok6jwkAoJEf2MnggIVBXEALKOgLaD
         zYDAkBuxdUUfeaWqEsN543c4HQpsvSiftPXuSFwiTewKbIoITvGJXGWTAl3QR3vvsXx0
         g7Bhk7ouwYFaQKpKEkXrTHROfGNa3Ur6gIx8ctTPi1/I/uAoo8KWmzJDuHUE8uql1dXm
         NBgg==
X-Gm-Message-State: AOJu0YwVKNUTA+xyBSXmwXIV/idg9T7E8BkSCjeC7lC/UJ6xh48Lh78Y
	dYwmO2j5cysASF4Z2qtoY+QZolCV7iqmvmkm4kGriWBr/H9ZI2YifLmyUimT8+OIameGbx3HPss
	vRPRbJx7OWw==
X-Google-Smtp-Source: AGHT+IH5TLazwr3fx61eORK5dklZ6KudCQ4MIwvBahDDm5sLEYRB5Im1Y6K//hFyxmHYrOi9SVLgic8Qto4v0g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:ac56:0:b0:e0b:ea2e:7b00 with SMTP id
 3f1490d57ef6-e28936e61camr22365276.5.1728246747992; Sun, 06 Oct 2024 13:32:27
 -0700 (PDT)
Date: Sun,  6 Oct 2024 20:32:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241006203224.1404384-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/5] tcp: add skb->sk to more control packets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, TCP can set skb->sk for a variety of transmit packets.

However, packets sent on behalf of a TIME_WAIT sockets do not
have an attached socket.

Same issue for RST packets.

We want to change this, in order to increase eBPF program
capabilities.

This is slightly risky, because various layers could
be confused by TIME_WAIT sockets showing up in skb->sk.

v2: audited all sk_to_full_sk() users and addressed Martin feedback.

Eric Dumazet (5):
  net: add TIME_WAIT logic to sk_to_full_sk()
  net_sched: sch_fq: prepare for TIME_WAIT sockets
  net: add skb_set_owner_edemux() helper
  ipv6: tcp: give socket pointer to control skbs
  ipv4: tcp: give socket pointer to control skbs

 include/linux/bpf-cgroup.h |  2 +-
 include/net/inet_sock.h    |  4 +++-
 include/net/ip.h           |  3 ++-
 include/net/sock.h         | 19 +++++++++++++++++++
 net/core/filter.c          |  6 +-----
 net/core/sock.c            |  9 +++------
 net/ipv4/ip_output.c       |  5 ++++-
 net/ipv4/tcp_ipv4.c        |  4 ++--
 net/ipv4/tcp_output.c      |  2 +-
 net/ipv6/tcp_ipv6.c        |  3 +++
 net/sched/sch_fq.c         |  3 ++-
 11 files changed, 41 insertions(+), 19 deletions(-)

-- 
2.47.0.rc0.187.ge670bccf7e-goog


