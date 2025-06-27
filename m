Return-Path: <netdev+bounces-201903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D973EAEB63D
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8115318832A9
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3797B29A9E4;
	Fri, 27 Jun 2025 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/7Rvo4o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912AF294A1A
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023541; cv=none; b=NvoKgIew2h+k0JIoTVEgBMfneO5StLpRZ5Pa9u2VOLH/yi8TqzybUzebCxEM7jdSGrkvt8+rgpO+cTWFLw1JbOnua9kjkrnD9zkNUfoRRyGVxzikTbOkWyGVBLIVku3679UdzfzgWnhOvBbIBoRt2csfjw3kETkXgFJJUZcOTMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023541; c=relaxed/simple;
	bh=qlfQp5PGp3Df6VNzZBvcgp+XImLPaCnZAuZIplse1zg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rVEzjBqV48TqHzSiGx8FwGNvdQRcC560c7RFr2qkWkb7Jf6+jvFDDdu9gy+3td1BDGrFHubikTsOwBREv4JFcr6NCqJhPHpV9fkLN0b66PpgbIT40sz2rrJIDSwH+eFbA9eyiGVnv3DeGfK72hX1Bi7qi6xsdsS3eRGp/gR7Bkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J/7Rvo4o; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7d0aa9cdecdso156197885a.3
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751023537; x=1751628337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pO4/9OXkkwv9flbOJ0kr//I1xHvpAfZs7I21uWI0eXA=;
        b=J/7Rvo4oqmdXDCgY3VGSdyvuK8GrnySAECLe+dBdKhxO++KdJHqfz2n5ipF5yAwvh2
         f4biIHj+0y7Ksv1fu5zn0QZyz2H5XaP2TwCxRdCtoBoIshNkNbygdSahezdb0J7yj+TX
         sjJsVHNOYOj1obA2LWr+GM0gGD1QrTXBjd7/u6s9MXDDkisYVNI1i0duHBWJnkp48Tep
         qSLaF4kRT/yG5TBqxQCFLNyNTpgr/xgIGUojJ6UDDVOC1oOl+ONCbQ800cLhemoPS8c4
         /cO6Fcv3u3EenoZx2gFYw7EzBsNO6ySIsytF+8rb864xg5KJEnjChxeSXhUgVVOY8Pgb
         1A0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751023537; x=1751628337;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pO4/9OXkkwv9flbOJ0kr//I1xHvpAfZs7I21uWI0eXA=;
        b=qkQSTj4CVSgsWkP0OkBxaaxU8d5FJ2u8l15gkUCzr68uGpBbuULRXVojxQ+2y7+DHV
         4V1Aw6zIRt0ZBtZYBbRB6P1s1IUGyV3usDWtkSqkdzQnocdu6EzWTEYz7x1OJBl6+OaW
         u/1zTVdPr4vb8KAqfa84v6bOiXrDXagCIdyQF82+qfUJbdCzfgCisZOfEeipDgMSdcNA
         nfihYsNbML5KWIlprg9ia29BkOaP4qH53kqcc0RoZ2KkgoNiD8mT3rpKMuHREiF+b4oM
         vKKLmtD0K78tVpXdJ4OhDqZa1imenVDVdmtbMXfk9RktrYsgpHOt0KfnsltvSTl/Iedw
         qp6w==
X-Forwarded-Encrypted: i=1; AJvYcCVf4bUCE2cSVwGJ/KGAluDyooVi+2FJjvR4szZFGyqVlGzj4Nm8FleIwq6k0vwWN0hHe9sP0Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxebs69Cx+TWXg8ZThLfgunpmTiS1my+ODam9DRT8QOFVBMAIMb
	k1cXIvQWmbQSuaJUuBvRvRxjQFqpTZ6PuMBmPGNLxtfrbn2fR+BhVAfNSHmBLQYnu8+09fW7KPR
	FcSUH/zdhlxE36Q==
X-Google-Smtp-Source: AGHT+IGG5SYqiqnYCmgstQDrhE6UcSwiwsAvclV81ByuIJQOCLkpMKJSfIjR5N5DmdFGo8QhdOIsR1wA8s8Y4g==
X-Received: from qkmy8.prod.google.com ([2002:a05:620a:e08:b0:7cc:e0a6:c827])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:424d:b0:7d3:c4cb:1b76 with SMTP id af79cd13be357-7d4439fb0f4mr426045185a.41.1751023537272;
 Fri, 27 Jun 2025 04:25:37 -0700 (PDT)
Date: Fri, 27 Jun 2025 11:25:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627112526.3615031-1-edumazet@google.com>
Subject: [PATCH net-next 00/10] net: add data-race annotations around dst fields
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add annotations around various dst fields, which can change under us.

Add four helpers to prepare better dst->dev protection,
and start using them. More to come later.

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


