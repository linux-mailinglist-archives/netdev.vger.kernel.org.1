Return-Path: <netdev+bounces-202407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83638AEDC90
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 204167A4FDC
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CE02836B1;
	Mon, 30 Jun 2025 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BxdI/7oz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C60127F001
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285978; cv=none; b=FtFdnn8WvqGfgMW78TxgAOgl0UNHp+WIy9jP/KwGpaV5x21HZNxNYUak6FiQND8eFgjf4ZRkq7/BwP19cTN0U7FiuKD3T/FGW0dTEvOhG7ZjZwjlOzR8VwAdthy2W0UCXvw29ab6OzgDXWRNQzNnr2VapCwSEKWHgtOJL7y7V88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285978; c=relaxed/simple;
	bh=awzDKZZukwttc9arpEd4Iqj78UFgmoy4nj67UcZg66g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dXYRzcfw+H5dY75OkZwwyOK76pxYJbUQmCXkQTmUFb1hZCwOyY+UwFzdS9K5ESSSdE1i3ZYSQEry/ftv9H9c8wuy0tURystsllhv+ZzR+6AKFLh0kK/1OXZMb40XjIGkd3gFIUhVzOYNMApG02zISs3BHSQ/go5WnL9CNH6ExUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BxdI/7oz; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7d09ed509aaso666494885a.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 05:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751285976; x=1751890776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AblNXpYXLFobArSwkz8vLXbc5Q9WghACeF+TvVaDtbs=;
        b=BxdI/7ozuaZCCEXoGGUSCy9A6if+EgF0YjRKLZrM9fBIVWpifdZnvxYD8EmurZ+aVM
         db5b5isPp7ZZooFLhm3bxpma4re2iQ/TrUOlZgogSmGo6Zep3KvK97WXa8D/nd/URvCk
         PGIFY1Lc24AlYvCMbnNoioRTzKWi3rKQapJOAvOblCIJCZyT6XNsnNHbJm+x67muWmWy
         3DIboAPEDDlpmgoDsIC7X6ZVCwDxGOjfcwB2+aKwgjib976/0I2vCaQkprb1D5k/6DKz
         1HNt8lYrauQonbA6scm3sOmwmbxq6eIJ1BtMg20ebF0RMI244H8nRgUUP7MoQ84g259b
         dWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751285976; x=1751890776;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AblNXpYXLFobArSwkz8vLXbc5Q9WghACeF+TvVaDtbs=;
        b=KEc6GPT53PcBA5ovM6pbWQo+GG/bHOHdmCKyI+KmdImEK3NXJPMXQkiE6SnxwNKakW
         ZhH8fisde3Gn0kUzZqVoWQj/pGYioH4Q/Za0Lg4szgdnz+v61RLcAkYnmtoyYKClvP2x
         k41gwRQBg2hFkV7n/Fyon/QTp+YAk95G5mshtudDiw3Yeo3WSwS6s77ThmJkK6nrtmDT
         /W0vbvqNds96cjaCGi7xcxCoFWEw5aUSG9lGyK2OESR+SncpKdNvrtPejgO8v6YSOYMu
         E0QLoGj0tTeKtX1FZAefSMjfvKC1Sn3De4BdIDK3lwzw60Id+Wx6rkSj75waMRaYk2AU
         l0Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUIDch2GGBPAY9EgFbtj/auGQ5ZHk2GE4dNDfAcQE9cLoUneqpdvNV2cNkTwkVripV/B4cIT0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSlJNNOqygDH2ZPZAASq6w9+6z9LtPV2tWBcYv0agzYvRENy1
	HGqdNEpl+vR2ToGlhWX4I72TRI8lm8gkKRq6nGsdIFXy/8XEXQ4NobvW6hAFNZVBDu+8hj6hmn0
	YTYR1jPO41RnoAg==
X-Google-Smtp-Source: AGHT+IESIhCz7ML6SwSzNiBcyZzznvhnJO0qEuOdgB/0kuxq4jyReViny+3evauwGJjBwpWmbT/qzCa38QFznQ==
X-Received: from qkbbk27.prod.google.com ([2002:a05:620a:1a1b:b0:7d0:99ad:840f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:7185:b0:7c7:a602:66ee with SMTP id af79cd13be357-7d443923419mr1505685085a.10.1751285975848;
 Mon, 30 Jun 2025 05:19:35 -0700 (PDT)
Date: Mon, 30 Jun 2025 12:19:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630121934.3399505-1-edumazet@google.com>
Subject: [PATCH v2 net-next 00/10] net: add data-race annotations around dst fields
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add annotations around various dst fields, which can change under us.

Add four helpers to prepare better dst->dev protection,
and start using them. More to come later.

v2: fix one typo (Reported-by: kernel test robot <lkp@intel.com>)
v1: https://lore.kernel.org/netdev/20250627112526.3615031-1-edumazet@google.com/

Eric Dumazet (10):
  net: dst: annotate data-races around dst->obsolete
  net: dst: annotate data-races around dst->expires
  net: dst: annotate data-races around dst->lastuse
  net: dst: annotate data-races around dst->input
  net: dst: annotate data-races around dst->output
  net: dst: add four helpers to annotate data-races around dst->dev
  ipv4: adopt dst_dev, skb_dst_dev and skb_dst_dev_net[_rcu]
  ipv6: adopt dst_dev() helper
  ipv6: adopt skb_dst_dev() and skb_dst_dev_net[_rcu]() helpers
  ipv6: ip6_mc_input() and ip6_mr_input() cleanups

 include/net/dst.h                   | 38 +++++++++++++++++-----
 include/net/inet6_hashtables.h      |  2 +-
 include/net/inet_hashtables.h       |  2 +-
 include/net/ip.h                    | 13 ++++----
 include/net/ip6_route.h             |  4 +--
 include/net/ip6_tunnel.h            |  2 +-
 include/net/lwtunnel.h              |  8 ++---
 include/net/route.h                 |  2 +-
 net/core/dst.c                      | 10 +++---
 net/core/dst_cache.c                |  2 +-
 net/core/neighbour.c                |  3 +-
 net/core/rtnetlink.c                |  4 ++-
 net/core/sock.c                     | 12 +++----
 net/ipv4/datagram.c                 |  2 +-
 net/ipv4/icmp.c                     | 24 +++++++-------
 net/ipv4/igmp.c                     |  2 +-
 net/ipv4/ip_fragment.c              |  2 +-
 net/ipv4/ip_output.c                |  6 ++--
 net/ipv4/ip_vti.c                   |  4 +--
 net/ipv4/netfilter.c                |  4 +--
 net/ipv4/route.c                    | 34 ++++++++++----------
 net/ipv4/tcp_fastopen.c             |  4 ++-
 net/ipv4/tcp_ipv4.c                 |  2 +-
 net/ipv4/tcp_metrics.c              |  8 ++---
 net/ipv4/xfrm4_output.c             |  2 +-
 net/ipv6/datagram.c                 |  2 +-
 net/ipv6/exthdrs.c                  | 10 +++---
 net/ipv6/icmp.c                     |  4 ++-
 net/ipv6/ila/ila_lwt.c              |  2 +-
 net/ipv6/ioam6.c                    | 17 +++++-----
 net/ipv6/ioam6_iptunnel.c           |  4 +--
 net/ipv6/ip6_gre.c                  |  8 +++--
 net/ipv6/ip6_input.c                | 33 +++++++++----------
 net/ipv6/ip6_output.c               | 24 +++++++-------
 net/ipv6/ip6_tunnel.c               |  6 ++--
 net/ipv6/ip6_udp_tunnel.c           |  2 +-
 net/ipv6/ip6_vti.c                  |  4 +--
 net/ipv6/ip6mr.c                    |  9 +++---
 net/ipv6/ndisc.c                    |  6 ++--
 net/ipv6/netfilter.c                |  4 +--
 net/ipv6/netfilter/nf_dup_ipv6.c    |  2 +-
 net/ipv6/netfilter/nf_reject_ipv6.c |  2 +-
 net/ipv6/output_core.c              |  4 +--
 net/ipv6/reassembly.c               | 10 +++---
 net/ipv6/route.c                    | 49 +++++++++++++++--------------
 net/ipv6/rpl_iptunnel.c             |  4 +--
 net/ipv6/seg6_iptunnel.c            | 26 ++++++++-------
 net/ipv6/seg6_local.c               |  2 +-
 net/ipv6/tcp_ipv6.c                 |  4 +--
 net/ipv6/xfrm6_output.c             |  2 +-
 net/netfilter/ipvs/ip_vs_xmit.c     |  2 +-
 net/sctp/transport.c                |  2 +-
 net/xfrm/xfrm_policy.c              |  4 +--
 53 files changed, 242 insertions(+), 202 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


