Return-Path: <netdev+bounces-216914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00073B35FA3
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D857C3A1D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 12:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310E213DDAA;
	Tue, 26 Aug 2025 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRBiC6Nj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CAF18C008
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212636; cv=none; b=gdg4UV/TU7/HHIZ8YpkGPFbG9OeFps29d4fVO2oxJ9P0kqLX2sR+m9T0+NXAyaXiLU7iMDvE76zW5vDhQhkQrzxDYZadIO655hJ2WaK+kcPvK3fK4rXFpT1ahyp5kWsAZSIUrkERGShNTHIAWkMDQD2HfTk4/0bQhBl5+v3M1no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212636; c=relaxed/simple;
	bh=u+OhSq1oyx03qNpnX+3ykMqIdzJBMhxdFcKL7+pYi8A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dV9lqfbVRgq42RAW4QKWPIW93jUY1P2BE/9ZGYHY0WuMQVMtSzO0/62idC1IffEswu6SOioo2+KZTXzyTi2FXQMtslcmctg1Lx0uGJfsUxbUGthbp+w930FCbsB/QmRDL5tnua7JfTZjEgkyFEg4nZC5ZrGEPW7tBm1g1hUZjgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sRBiC6Nj; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-70dd6d255c4so11167076d6.0
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 05:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756212633; x=1756817433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xKOZxyzqZL0Lg3m41mWT4OP50kbxX8EAV6AfHBSUE60=;
        b=sRBiC6NjVQD/dKYAf4FiCwV0XC83JGTGN+jeekObdFaaC8DccdzTvZd5Rw0YVDhtrH
         5ZP1Nmj16lUM7fP27ngSdNfD/Sh/AEoFbVX+rBflGIgMMgItTQhkjGHFN8ynx6e2qc4U
         Y+EIHW/7jAFdkRFNP3Ww3wxLhDWV0nVrlQF8mG0I6MDIqYWo7I67DdRBbk6s/h28Ot7G
         0iWMuViqAkmhxhRa0V+fK3l5bgiS2UQo7B2NAgvgGlwQ9EJkFIWCv4Fjo1bFNyxbczoZ
         SpOLgWTeARzL6b4oOv06c3X/fzc2ZLI+uqo1p+mbHWPkT0tVg8S41++smwBFtGFrxFAC
         dySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756212633; x=1756817433;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKOZxyzqZL0Lg3m41mWT4OP50kbxX8EAV6AfHBSUE60=;
        b=BrUG/zhZmRmOSaicRoio5lt3GL9+s1cOMi+GRBO7Ky2a9LaWtDqOEuwb6cvfY421tp
         hfIfJQWJoRJHZGl4EUlaLRife9fkOuS6McRA4ScLiVgZrhPzkdV4NilSwRIgOf3H0EIs
         nTp7uyllyCpI+blla/JzGKaVW8GgFBBMtx1aDRzdzaUA9pq1597putfZYIvT7YLwujm6
         NF8kMgoqys7jx3F+STsQ55cFNtREfgjf5GCdfVZ2RHgullHAzk6vK42SAZ91Dzc8Kx2p
         t+3F/RN3woJo4D28DQv3T93ATK4XyUuASIxrRNwmXRBb+mO4sCCUaQBQxR59wYtoYSeF
         6rhw==
X-Forwarded-Encrypted: i=1; AJvYcCUca3CKVRBN2fHXasPVCWioyN0cH2M9CkwAjF5VgkUiZIioBVfZ2ophuQavI9uC9tOc+hB5log=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrfpeOIpKXp52uesGtxSXaH3OGOjMxf2gn96VOo0z3a1nDJY3r
	8sC4oOw7wDSMdmW8KEvYmALtLO+YVQitoEfEiNYhjrZg5nu91bO6CzurkwMOMblvxTFQq+nOU85
	9aA4YCqhLEq8MKA==
X-Google-Smtp-Source: AGHT+IG3rm5I/2CECT7GeU/hFhIENkv1kLbmvdsBWziHRG4+85MC7GiVweW7WzBm99rYAXTi50j5AexXwZB7sw==
X-Received: from qvxm13.prod.google.com ([2002:ad4:4b6d:0:b0:70b:ab14:b996])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:21e7:b0:70d:bdee:ce29 with SMTP id 6a1803df08f44-70dbdeed241mr74409956d6.44.1756212633386;
 Tue, 26 Aug 2025 05:50:33 -0700 (PDT)
Date: Tue, 26 Aug 2025 12:50:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826125031.1578842-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/5] net: better drop accounting
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Incrementing sk->sk_drops for every dropped packet can
cause serious cache line contention under DOS.

Add optional sk->sk_drop_counters pointer so that
protocols can opt-in to use two dedicated cache lines
to hold drop counters.

Convert UDP and RAW to use this infrastructure.

Tested on UDP (see patch 4/5 for details)

Before:

nstat -n ; sleep 1 ; nstat | grep Udp
Udp6InDatagrams                 615091             0.0
Udp6InErrors                    3904277            0.0
Udp6RcvbufErrors                3904277            0.0

After:

nstat -n ; sleep 1 ; nstat | grep Udp
Udp6InDatagrams                 816281             0.0
Udp6InErrors                    7497093            0.0
Udp6RcvbufErrors                7497093            0.0

Eric Dumazet (5):
  net: add sk_drops_read(), sk_drops_inc() and sk_drops_reset() helpers
  net: add sk_drops_skbadd() helper
  net: add sk->sk_drop_counters
  udp: add drop_counters to udp socket
  inet: raw: add drop_counters to raw sockets

 include/linux/ipv6.h                          |  2 +-
 include/linux/skmsg.h                         |  2 +-
 include/linux/udp.h                           |  1 +
 include/net/raw.h                             |  1 +
 include/net/sock.h                            | 56 ++++++++++++++++++-
 include/net/tcp.h                             |  2 +-
 include/net/udp.h                             |  3 +-
 net/core/datagram.c                           |  2 +-
 net/core/sock.c                               | 16 +++---
 net/ipv4/ping.c                               |  2 +-
 net/ipv4/raw.c                                |  7 ++-
 net/ipv4/tcp_input.c                          |  2 +-
 net/ipv4/tcp_ipv4.c                           |  4 +-
 net/ipv4/udp.c                                | 14 ++---
 net/ipv6/datagram.c                           |  2 +-
 net/ipv6/raw.c                                |  9 +--
 net/ipv6/tcp_ipv6.c                           |  4 +-
 net/ipv6/udp.c                                |  6 +-
 net/iucv/af_iucv.c                            |  4 +-
 net/mptcp/protocol.c                          |  2 +-
 net/netlink/af_netlink.c                      |  4 +-
 net/packet/af_packet.c                        |  2 +-
 net/phonet/pep.c                              |  6 +-
 net/phonet/socket.c                           |  2 +-
 net/sctp/diag.c                               |  2 +-
 net/tipc/socket.c                             |  6 +-
 .../selftests/bpf/progs/bpf_iter_udp4.c       |  3 +-
 .../selftests/bpf/progs/bpf_iter_udp6.c       |  4 +-
 28 files changed, 114 insertions(+), 56 deletions(-)

-- 
2.51.0.261.g7ce5a0a67e-goog


