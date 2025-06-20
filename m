Return-Path: <netdev+bounces-199773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DAEAE1C3B
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6558818877AE
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269B7290DA1;
	Fri, 20 Jun 2025 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HoHWs2iN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CFD28B4FA
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750426207; cv=none; b=HNxjEEV60kdtvq+pTZcbw4UZNdpYXeznALO+H4L5aYqVIeufVZXEznRPtSNhT0+waZNFePZv+BCEvU8ZBEF9nIWDBMf1BbnYQw1+zSF0RY4hRmOi2CD/nAF3rgjjt0xt65YcHJ0cQ7q34zK6TI9zdIUZn7l5iJ/LYXYaiVzy34k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750426207; c=relaxed/simple;
	bh=nZkuuEyfuaVO0XXmx2tkWuwFZJQ1cabjaIjQX97nggA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p/GB5QRRZhbGILPL/92fffRUBJhu4/45hzDNCk2vB9kDZlWfK2gLdsk0cx3BqOwDExZe2DnMLH8fpiYrkN0x7SHZ3ET1LJcOCLcoffBz8TLb40DFpysmwadbDtGY8nScVSaLUFWL6zbDj9GErOyktU8+RCqdAjkrn+ZxI57fGWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HoHWs2iN; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a442d07c5fso40888671cf.3
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 06:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750426204; x=1751031004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Zv8YWD38FTy9cq6OIlDw5YmFeduJRX4kILxbP0uFDs=;
        b=HoHWs2iNI42kWkn2b5Y+z8kj5Qm3G3khV2GXlYHnW8KuDtJREIOU4x3UQoRzXeUZJH
         zeQ/NHdmU15GyqhasFF9Ronuy9JdBKlCIXb+tQxmzrUE8zgD7XgZXpMuzehWZdG+cBbt
         YZ8J2SjJ1DFRjhBw/4lNe0cWKlvHgOXjxhc6ASAMiknWVP4cW8bMPysERj3qT3jNhgUz
         MTlKi+Cu8U4/9a7spFE21JiQDb4d6uV4o6jtZshe5rzReNx/tZPov3J4oM20I9MEBlWl
         yrZL8lN9jP2cl3S8JX5Vtwva3RFWPxNA3VaovZl2eLoTdexgOFGiYam6fIL9QQkyNhPe
         A0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750426204; x=1751031004;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Zv8YWD38FTy9cq6OIlDw5YmFeduJRX4kILxbP0uFDs=;
        b=o/eKaG8ymZf36z6WLCROCRywRmUh9Qou9ebKQzaVfgvifhXC/gInnp3XBk7WENW88K
         UL68vEQe5oxz0bOYU+LpTbpRxiW7+HagXpaxV0CMnKLAV3/iGRA6wRGIZRwXHoIshRN3
         Xb658iq0IOKk3AAyDtrejZzFu7eAXA+C8kBUTiwfnAIxsxBQGyqpT7J4CSAbwRuUM/0u
         aypC1pQkYUDzvfm3ko93C1b5pN3YiT/5/3qUKPXwQ2xZoI1sFkz4bD6QiuY93rmCaOKt
         HUVMaLR+P40GHcCWKMRqRMaa5RYTiPRbnlQDEdzZlm26C7iyc5lJ26yAr4aKT93pWOqb
         Tciw==
X-Forwarded-Encrypted: i=1; AJvYcCV01jdylwUO0Zok/kRyMsydQ1yeOC9xz/gHHAxU++Ef4bj6yLmtXTedZwE2MYd6l1ucvRrZJXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPq0U/duE+7b6fpNAFPNjf8tMl7okZ9ycr/5oAY0daVqz36Lm0
	sHYqKm2/R4W6qTqvGcAzhot0tNxEfcJn8S3FVZs1qP0zF/+aD2BMofQDe3pRBaRg1f84JsS2l2f
	u5aYXIM0jjQPxLA==
X-Google-Smtp-Source: AGHT+IH0A14623UjPBpdViN6183ez5xSsaHSzORIRKdLfvHxhMk55sYKqDWc7gkku6HiibpwpQoow8beMl593A==
X-Received: from qtbbz14.prod.google.com ([2002:a05:622a:1e8e:b0:4a5:86d9:6811])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7f87:0:b0:4a4:4165:ed60 with SMTP id d75a77b69052e-4a77a23a330mr40230141cf.3.1750426204379;
 Fri, 20 Jun 2025 06:30:04 -0700 (PDT)
Date: Fri, 20 Jun 2025 13:29:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620133001.4090592-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] net: replace sock_i_uid() with sk_uid()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Lorenzo Colitti <lorenzo@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

First patch annotates sk->sk_uid accesses and adds sk_uid() helper.

Second patch removes sock_i_uid() in favor of the new helper.

Eric Dumazet (2):
  net: annotate races around sk->sk_uid
  net: remove sock_i_uid()

 include/net/route.h              |  4 ++--
 include/net/sock.h               | 12 +++++++++---
 net/appletalk/atalk_proc.c       |  2 +-
 net/bluetooth/af_bluetooth.c     |  2 +-
 net/core/sock.c                  | 11 -----------
 net/ipv4/inet_connection_sock.c  | 31 ++++++++++++++-----------------
 net/ipv4/inet_diag.c             |  2 +-
 net/ipv4/inet_hashtables.c       |  4 ++--
 net/ipv4/ping.c                  |  4 ++--
 net/ipv4/raw.c                   |  4 ++--
 net/ipv4/route.c                 |  3 ++-
 net/ipv4/syncookies.c            |  3 ++-
 net/ipv4/tcp_ipv4.c              |  8 ++++----
 net/ipv4/udp.c                   | 19 ++++++++++---------
 net/ipv6/af_inet6.c              |  2 +-
 net/ipv6/datagram.c              |  4 ++--
 net/ipv6/inet6_connection_sock.c |  4 ++--
 net/ipv6/ping.c                  |  2 +-
 net/ipv6/raw.c                   |  2 +-
 net/ipv6/route.c                 |  4 ++--
 net/ipv6/syncookies.c            |  2 +-
 net/ipv6/tcp_ipv6.c              |  6 +++---
 net/ipv6/udp.c                   |  5 +++--
 net/key/af_key.c                 |  2 +-
 net/l2tp/l2tp_ip6.c              |  2 +-
 net/llc/llc_proc.c               |  2 +-
 net/mptcp/protocol.c             |  2 +-
 net/packet/af_packet.c           |  2 +-
 net/packet/diag.c                |  2 +-
 net/phonet/socket.c              |  4 ++--
 net/sctp/input.c                 |  2 +-
 net/sctp/proc.c                  |  4 ++--
 net/sctp/socket.c                |  4 ++--
 net/smc/smc_diag.c               |  2 +-
 net/socket.c                     |  8 +++++---
 net/tipc/socket.c                |  2 +-
 net/unix/af_unix.c               |  2 +-
 net/unix/diag.c                  |  2 +-
 net/xdp/xsk_diag.c               |  2 +-
 39 files changed, 91 insertions(+), 93 deletions(-)

-- 
2.50.0.rc2.701.gf1e915cc24-goog


