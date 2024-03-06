Return-Path: <netdev+bounces-77990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9F0873B6F
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37A01C243AB
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FC5137923;
	Wed,  6 Mar 2024 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nJq3TCEg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A535013540D
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740836; cv=none; b=HqPBGZo5K3vVBUdmWwHiikgEP+2lRZnFhz8E0On1iOkvKQwVVu4itW2GhVKKqsVDjM8S0j7l+5pHKAj5b1IudX8Rn6/RHvx342ENJEOAu/Wf5W+wAwgB2xKQMfgNkTNwr+StYkElj1Hla1IqfVD4qQH0smofQacpHK3RMngGw18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740836; c=relaxed/simple;
	bh=XNOuwfbmYlM5DYyetC3N74B91irdDqbqm7ckvLESRoI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mcpHLQEzIe51MuceYPc+uFCCYA6p36CjSeokTgRWeDlbD/K1qb7zA7hSTG/5h8fBnE3V1hpx1Z/PIURo1NdeTxk3La+qtP/lec3Ja2HRA/lGgaNvEhonyQWOCJHLeCViBaScuEdr1XVX3otFCilbju4AGVpMFwgcbr33GGMEPyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nJq3TCEg; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-69046d68828so94381746d6.2
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 08:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740833; x=1710345633; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VrfWaaJ44JGFBsg3IftGkjEOYZCEAiVCH3gHodlL4cw=;
        b=nJq3TCEgWsHX/yA8X5TcxST3BaN1LP9tZxFpC8BmiyXi2sfkRvUcs9MGaPs9HnwKU/
         kvzWM4j83Fvppcu0Oy+avIe446iNdXFHPZMuhxPXzr5tXDdpjALDUWon3UoUAYK48xla
         fNoUYCfHpezRrrPlhCsdzEEsIri80YBMCnictdavuadIBYjGNt80bpTokSwhlqI7jblm
         OFxmnrEKISD8BTvbU7IZ6Ez/t1kt4VktfXonDLXKpQ7jH8Xnim/oAr2L2AyV7iXEKKij
         9pL49gU86tKmQoGxP2lDgmUovtUF8jlHRIAcGg2ELTyoBst7unbT4ypcJ6XO2Y+augPU
         kecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740833; x=1710345633;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VrfWaaJ44JGFBsg3IftGkjEOYZCEAiVCH3gHodlL4cw=;
        b=O0hXjqTYRbZGVCqcnYAWpaQ3tryqlhDVX/Y6z3d0Z3Odd5Y9603uZbA0Ck3j0MW9XU
         lXm7Mb+B+T+EPZ75q1JrermqzQjDC3bXAQ/0IcNXW4eWulUXhAJ5PJ5rQ8eF4OcUq1TS
         A9udA9jyViV21eCKYdTM6eZQszaLmZnvf4NJ+nJNACCdg2wVygeh6D6WKv0yHdxupepe
         wuhl4J8MDgtoZyyH4QFNy1LXYU/DZEqK0JQ5t37Cwl09Tv1fmBq+mE4LFiLutMSa5M+l
         kTo7vWjArPhD6bGF/4IlTtzUonqGXVShurMgDf7kqQMuFyQT1zSdYAGVliU57afKg0VU
         U4mA==
X-Forwarded-Encrypted: i=1; AJvYcCUGhSiop2F3PtR54u5zGNuZhBpc1RAaxbRT6KtEJIplWDdfk+j9lD6LbjCKTN78YVKt6YtTynM03RjUqEcOY4CTORrs1cca
X-Gm-Message-State: AOJu0Yw5E7MstbkxajqokcePoq62uRZO6rdcUKPFMW1UV7MYk/o0kW71
	WHGKtycpelV/v9t7oczXAfjLuoYGGVPX0likJfMxcxSTmSYNmzBdUDSmqWUlNKHKNDAO3XWcYPy
	5iNsos0ywhw==
X-Google-Smtp-Source: AGHT+IFxDfVc9sfcuefxPIE81+DpsHSREWbDwcNsi/YKlzIjsljx2XwuAlpsD1cSD+KqoTVqCaA9Qw+7bmUztg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:ad4:5dc2:0:b0:68f:d2f2:860f with SMTP id
 m2-20020ad45dc2000000b0068fd2f2860fmr127124qvh.11.1709740833679; Wed, 06 Mar
 2024 08:00:33 -0800 (PST)
Date: Wed,  6 Mar 2024 16:00:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306160031.874438-1-edumazet@google.com>
Subject: [PATCH v2 net-next 00/18] net: group together hot data
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

While our recent structure reorganizations were focused
on increasing max throughput, there is still an
area where improvements are much needed.

In many cases, a cpu handles one packet at a time,
instead of a nice batch.

Hardware interrupt.
 -> Software interrupt.
   -> Network/Protocol stacks.

If the cpu was idle or busy in other layers,
it has to pull many cache lines.

This series adds a new net_hotdata structure, where
some critical (and read-mostly) data used in
rx and tx path is packed in a small number of cache lines.

Synthetic benchmarks will not see much difference,
but latency of single packet should improve.

net_hodata current size on 64bit is 416 bytes,
but might grow in the future.

Also move RPS definitions to a new include file.

v2: - Added tags from Soheil and David (Thanks!)
    - took care of CONFIG_IPV6=n (kernel test robot <lkp@intel.com>)
Closes: https://lore.kernel.org/oe-kbuild-all/202403061318.QMW92UEi-lkp@intel.com/

Eric Dumazet (18):
  net: introduce struct net_hotdata
  net: move netdev_budget and netdev_budget to net_hotdata
  net: move netdev_tstamp_prequeue into net_hotdata
  net: move ptype_all into net_hotdata
  net: move netdev_max_backlog to net_hotdata
  net: move ip_packet_offload and ipv6_packet_offload to net_hotdata
  net: move tcpv4_offload and tcpv6_offload to net_hotdata
  net: move dev_tx_weight to net_hotdata
  net: move dev_rx_weight to net_hotdata
  net: move skbuff_cache(s) to net_hotdata
  udp: move udpv4_offload and udpv6_offload to net_hotdata
  ipv6: move tcpv6_protocol and udpv6_protocol to net_hotdata
  inet: move tcp_protocol and udp_protocol to net_hotdata
  inet: move inet_ehash_secret and udp_ehash_secret into net_hotdata
  ipv6: move inet6_ehash_secret and udp6_ehash_secret into net_hotdata
  ipv6: move tcp_ipv6_hash_secret and udp_ipv6_hash_secret to
    net_hotdata
  net: introduce include/net/rps.h
  net: move rps_sock_flow_table to net_hotdata

 drivers/net/ethernet/intel/ice/ice_arfs.c     |   1 +
 .../net/ethernet/mellanox/mlx4/en_netdev.c    |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_arfs.c |   1 +
 drivers/net/ethernet/sfc/rx_common.c          |   1 +
 drivers/net/ethernet/sfc/siena/rx_common.c    |   1 +
 drivers/net/tun.c                             |   1 +
 include/linux/netdevice.h                     |  88 ------------
 include/linux/skbuff.h                        |   1 -
 include/net/gro.h                             |   5 +-
 include/net/hotdata.h                         |  52 ++++++++
 include/net/protocol.h                        |   3 +
 include/net/rps.h                             | 125 ++++++++++++++++++
 include/net/sock.h                            |  35 -----
 kernel/bpf/cpumap.c                           |   4 +-
 net/bpf/test_run.c                            |   4 +-
 net/core/Makefile                             |   1 +
 net/core/dev.c                                |  58 +++-----
 net/core/dev.h                                |   3 -
 net/core/gro.c                                |  15 +--
 net/core/gro_cells.c                          |   3 +-
 net/core/gso.c                                |   4 +-
 net/core/hotdata.c                            |  22 +++
 net/core/net-procfs.c                         |   7 +-
 net/core/net-sysfs.c                          |   1 +
 net/core/skbuff.c                             |  44 +++---
 net/core/sysctl_net_core.c                    |  25 ++--
 net/core/xdp.c                                |   5 +-
 net/ipv4/af_inet.c                            |  49 +++----
 net/ipv4/inet_hashtables.c                    |   3 +-
 net/ipv4/tcp.c                                |   1 +
 net/ipv4/tcp_offload.c                        |  17 ++-
 net/ipv4/udp.c                                |   2 -
 net/ipv4/udp_offload.c                        |  17 ++-
 net/ipv6/af_inet6.c                           |   1 +
 net/ipv6/inet6_hashtables.c                   |   8 +-
 net/ipv6/ip6_offload.c                        |  18 +--
 net/ipv6/tcp_ipv6.c                           |  17 +--
 net/ipv6/tcpv6_offload.c                      |  16 +--
 net/ipv6/udp.c                                |  19 ++-
 net/ipv6/udp_offload.c                        |  21 ++-
 net/sched/sch_generic.c                       |   3 +-
 net/sctp/socket.c                             |   1 +
 net/xfrm/espintcp.c                           |   4 +-
 net/xfrm/xfrm_input.c                         |   3 +-
 44 files changed, 391 insertions(+), 320 deletions(-)
 create mode 100644 include/net/hotdata.h
 create mode 100644 include/net/rps.h
 create mode 100644 net/core/hotdata.c

-- 
2.44.0.278.ge034bb2e1d-goog


