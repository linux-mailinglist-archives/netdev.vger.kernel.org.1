Return-Path: <netdev+bounces-216609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815DFB34B46
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 21:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E381C7A6895
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 19:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFF428314E;
	Mon, 25 Aug 2025 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3IofVtIW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E4BA41
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151991; cv=none; b=MBNhFwKDIgszHsqxswYoVMYidwja8CE20x3CdTIgUIm9E/cTWRdldXm+wRpovxHOaTxge3KrcDOaCHHJY8c2l7urp9zXMyuovK95sj5njA0UFy/KpZSwtNQvYoSEL8s8ay4ohTMruVkPXV1xuWNO0lE5Ai+NrlLxYg43nYJxHyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151991; c=relaxed/simple;
	bh=glsm83R6oNoVhhgrfjwM08D8039fsQNqkjfxbjJ2ffE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=a36ftL884cJK+Xc8cOpGelbd+wmeLeAuw1XNhGPAUAlEWBElXACK84dlZbL5MPo1V5OV8cPF5rv0zIzM3vK8UvXNTbWX+ifh6uXu8CyyezJOHQI41L2WZw6lkICiaYDO6WGeSznZkEp/jzb9WdwZrxvViXTqehufYoHugHvfWQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3IofVtIW; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7e8706abd44so1212224385a.3
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 12:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756151989; x=1756756789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g+VF5JeaL2SpqPPN38+S2J3BhfJbB+3/JLIjXWvGWzY=;
        b=3IofVtIW1yWEohFN2fYvTfPC8HBeAvrlyIkue1GvBphCdA2/Ma4vbVLPWkbM+vEHn/
         hA60DKLTXRheSNL1UpzdyPBKXsYdZwiDKA1u6fU22tabjUORw7nGfpkP80ovA0FfPigJ
         Zu6wsWz8zpkr+nrYSkRCT+00o8y6UdWmHe3KufeJh2cRl4Uq/syUsIMlBbX/ot9WvC7K
         8mrnKvDyGYqlEY6I+B1/HjnsuJScrtO+xdl6CN69UzhlvyUmZ1+TRx7BvtBgA92//2rX
         R3P578t589PRzOa34vUERyRNFV+oV/nQGY36AeJ79es33gV8dV/NvLQltkotB6mBlj9o
         AjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151989; x=1756756789;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+VF5JeaL2SpqPPN38+S2J3BhfJbB+3/JLIjXWvGWzY=;
        b=T2+GWgbTZ216m/7NaAu4jQ1bsH0nNu8cKoLoW0G3s2tGAU0I5iazixouK9A9ZZyKQL
         EA0RSFCH7uW7RMV0FK1c6h92ko3vVq+A7bLkSme/gab+kH/IBaZPHgtmeZRQMJHp1qKA
         cQXUu8eyO7AjHTlajTSKY+4Bhpmw72oIOaaJfYDNrm0ocCAyt/nMmLO/9zBfhdMbSvTZ
         xKn0Wc4F0Ov1y4gFXNBxw9xhv2Zbo0nJlMeP2ZOdK/Zuibo3QjEgR4xFpOc3xhgvbL/Y
         RzE9YNs1Yh3ILuwri54/0HekL0JJtHOyyjbHN+V7JTGqtw+sOJz3zzoJcrHMI+5LkIJu
         43yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOzf2cQpaqQLPyUCP2YyN2wYr8hcoj+Uk6cnB5Y/QYAAOo+27+Ev4mEl7PBRW4cQnALmWrP5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoUa9UmPu6PyJ9uFZuODyLMdPQ2XR4mhHKxDypU3wmjWAJkr1a
	brRIyoclsZczcyf5o3O/mhwjxtVj2ZoTRqqTypkE8yxP6FGThKwubh6kpHfCp6LCQme5E3DRZEp
	MkCF99/bnw4stFw==
X-Google-Smtp-Source: AGHT+IFEWTkmWFqqU9uC3yPnlRh8CjzOFfpX93y6JrmmEGK1eF8VqyQvmGl3nYf8nWRbb0XT6dNZIVfw/e59xg==
X-Received: from qknpq1.prod.google.com ([2002:a05:620a:84c1:b0:7e2:e9ed:1448])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a80c:b0:7e8:18d5:4b8d with SMTP id af79cd13be357-7ea11096af1mr1341562185a.42.1756151989047;
 Mon, 25 Aug 2025 12:59:49 -0700 (PDT)
Date: Mon, 25 Aug 2025 19:59:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825195947.4073595-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] net: better drop accounting
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Incrementing sk->sk_drops for every dropped packet can
cause serious cache line contention.

Move sk_drops into a separate cache line so that
the consumer reads packets faster.

Add sk->sk_drops1 field for basic NUMA awareness
at low memory cost.

Tested:
see the 2nd patch changelog for test setup.
(One UDP receiving socket)

Before:

Udp6InDatagrams                 615091             0.0
Udp6InErrors                    3904277            0.0
Udp6RcvbufErrors                3904277            0.0

After:

Udp6InDatagrams                 914537             0.0
Udp6InErrors                    6888487            0.0
Udp6RcvbufErrors                6888487            0.0

Eric Dumazet (3):
  net: add sk_drops_read(), sk_drops_inc() and sk_drops_reset() helpers
  net: move sk_drops out of sock_write_rx group
  net: add new sk->sk_drops1 field

 include/net/sock.h                            | 43 +++++++++++++++++--
 include/net/tcp.h                             |  2 +-
 net/core/datagram.c                           |  2 +-
 net/core/sock.c                               | 15 +++----
 net/ipv4/ping.c                               |  2 +-
 net/ipv4/raw.c                                |  6 +--
 net/ipv4/udp.c                                | 14 +++---
 net/ipv6/datagram.c                           |  2 +-
 net/ipv6/raw.c                                |  8 ++--
 net/ipv6/udp.c                                |  6 +--
 net/iucv/af_iucv.c                            |  4 +-
 net/netlink/af_netlink.c                      |  4 +-
 net/packet/af_packet.c                        |  2 +-
 net/phonet/pep.c                              |  6 +--
 net/phonet/socket.c                           |  2 +-
 net/sctp/diag.c                               |  2 +-
 net/tipc/socket.c                             |  6 +--
 .../selftests/bpf/progs/bpf_iter_netlink.c    |  3 +-
 .../selftests/bpf/progs/bpf_iter_udp4.c       |  2 +-
 .../selftests/bpf/progs/bpf_iter_udp6.c       |  2 +-
 20 files changed, 84 insertions(+), 49 deletions(-)

-- 
2.51.0.261.g7ce5a0a67e-goog


