Return-Path: <netdev+bounces-131332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B48A98E19F
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 19:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939E31C22A00
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0144A195FEC;
	Wed,  2 Oct 2024 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HOHVh76u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766F21854
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890246; cv=none; b=jNE2XYkFOmbaD4Pe/FJBl8zMPYYULmYAmteMVoqqXLqOyWyULQbVUPFAE8ljernfqLWxx7VqlX2zLQNdy1GwS+VtTS3mPuVOodkC5O6hAxKyjPUzbqoEuGUQrF4g5oGzwZvRnzRdOsoMFdSyruCJ759mg3+JZX1RhQwmzc/3nbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890246; c=relaxed/simple;
	bh=n6Dg+bTzAitKXi8IWQ5o2KkOC7e/8NtEp9QNzfnD3Dc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tR0lpzC+yZ2AIG8ht6wEQBKZ1fmYkAO8QKMQ3sC/rLa0FJtYQVbrUS+w4q+ppYdMemkQwUDUkzvCBLK5um+GYmpCYYawoBMsXgkUz6scPTmHM/oj0UQtsrx1O9UcOaa2yUA8A62t6JzgjwgWA2Vnb/aIepqF18YFTWUqYfp22CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HOHVh76u; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b5792baaso63083276.2
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 10:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727890244; x=1728495044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zRtC09pOegCwzTo4z3NDadbR69x1j1MWeSTa7y6ckJg=;
        b=HOHVh76uKVMkj7GrOcrmagUb2EHC4F+L5hkEgqqACK3LWx6DR4ak8xmpmrq9bw0NA2
         0eXMqbgNUx3rBDgg6kb8O4f9Js1GX2z3/vT7UyJBltw0JVB5O7w2GdBotkMdvOsNHQH9
         vUEFevX+Q7s/gSHJ1AIkJodGfpPlk4z6CIsOq2udwnR3V5fkniTq19dV3f0gfTKKrbKQ
         wacvjtufRS57202dQZbLGsAkpnl6mShduf2IbUiW+taPARpVdGRYKLfVu5XTY7LWUGtc
         LwC00vjJMFwuIG/ZGB5XemUXhnwE7I45MKaQh4plpVXfxWGkPElDxGan3qxCz2QsJv+q
         iKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727890244; x=1728495044;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zRtC09pOegCwzTo4z3NDadbR69x1j1MWeSTa7y6ckJg=;
        b=c6q6GrrFoYkoovOTdbzixoDkdvCqc9GXsg1xi4J8A0ng0j8w8KXbigx5Pv8p13Hfsa
         PrRRT8Lqs3n+yiNV3UGDKV12drYAYVqvMnkNmuSVmnkubnHyOzLXMDRA5At/Xnur+QBh
         7ZZ19cBdVnTfOjVdxZoNXc0FvPVGaaHGH5Yf808lnANNT+FI3o6S3p1PF2pI2fku0U62
         GEThEM4cmVaBIU7WsPHLn32raBv9lgZrQqP9VO7umiJUOKRTXtmqjDr7sH12cQ/3LvoO
         +wOSunDSeh7EXIXaycFFZy4Yw0/8gCMHQIbUp1TIuT/LI3c4UwnzwHvmoB4MlwsdGYFo
         mrUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPaYafAyhtSHpKhY3zwEdSRBTjZ5NICP7hAPLLlI3sDJ1kXIeTzLSft4QWsqEMbfZtNeORLeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjb1gsYS/3y/o4GErzvL57D6FKhPQKZLLzerRCMsogqttB5Q8T
	hQCHR7sbh6tMo7gprdEUCmOQIZtMOR26IOXDaxXU5gnWBviP9Qzf+LWTdENXRPho1VuI7clwUnx
	Wxdiz8runOQ==
X-Google-Smtp-Source: AGHT+IFIUuK6zKkPJVwpBMSeoNvJgOtMxDAfoMxMnLo86jUlw6CT6ZM4qONtopv52XolnjQ2Z9LyEY04mow68w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:ab61:0:b0:e0b:a712:2ceb with SMTP id
 3f1490d57ef6-e26383c0975mr15024276.5.1727890244131; Wed, 02 Oct 2024 10:30:44
 -0700 (PDT)
Date: Wed,  2 Oct 2024 17:30:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241002173042.917928-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] tcp: add fast path in timer handlers
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

As mentioned in Netconf 2024:

TCP retransmit and delack timers are not stopped from
inet_csk_clear_xmit_timer() because we do not define
INET_CSK_CLEAR_TIMERS.

Enabling INET_CSK_CLEAR_TIMERS leads to lower performance,
mainly because del_timer() and mod_timer() happen from
different cpus quite often.

What we can do instead is to add fast paths to tcp_write_timer()
and tcp_delack_timer() to avoid socket spinlock acquisition.

Eric Dumazet (3):
  tcp: annotate data-races around icsk->icsk_pending
  tcp: add a fast path in tcp_write_timer()
  tcp: add a fast path in tcp_delack_timer()

 include/net/inet_connection_sock.h |  9 +++++----
 net/ipv4/inet_connection_sock.c    |  6 ++++--
 net/ipv4/inet_diag.c               | 10 ++++++----
 net/ipv4/tcp_ipv4.c                | 10 ++++++----
 net/ipv4/tcp_output.c              |  7 ++++---
 net/ipv4/tcp_timer.c               | 18 ++++++++++++++++--
 net/ipv6/tcp_ipv6.c                | 10 ++++++----
 net/mptcp/protocol.c               |  3 ++-
 8 files changed, 49 insertions(+), 24 deletions(-)

-- 
2.47.0.rc0.187.ge670bccf7e-goog


