Return-Path: <netdev+bounces-225603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BE9B96117
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBD4444061
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9661A4F12;
	Tue, 23 Sep 2025 13:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xk0sn/S1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2141DD0D4
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635271; cv=none; b=dWoVamIFrnOfYw/7MQvd4cL6/qONuWLYymiStsSRh272BcsPP7FdIbonCyKjjivaz8IVzU/F9MftZMXZU+ZGEnzivripA38p9X04cmLukbuHX1B+yxPg5V3MVAjec2ame+hDzJRz6NYrZzp7TjAyii8TtO+M+VuvOSt7lKZmHbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635271; c=relaxed/simple;
	bh=DsbjiGHlLUq4V9W2zrXeg8EXXR3QutkNtEvnzZOuJ8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oWyhlTmPPZzu1IXYbLGh3WbCMo6efGlrN/rrmC7FaVkGvVPJHI/z6Ys8CuPfB36AgeJ53HiilPoB6RiqoRgZywDx9xtzR+b2tThM4L0BWjh0omMvTjmACi8CzC832WLfaR58F/JVNAZnDSgg5Pb3HgYxVATPzjKLCU5BmpEnSco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xk0sn/S1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ece1102998so3557616f8f.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 06:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758635268; x=1759240068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=itAvX3hB1qz6eonkBcKywNsEaMgbTwm8NpUY2huFizg=;
        b=Xk0sn/S16t7LRbSW9xNoSFf9kiMoxUamHn9G2qvMLkINWQaGcLS2lHLxRPylwQUBsj
         7eVtjeUgfR6iepOwbEpNHmOlk9eH/P39qold01dV08Xwx9G1Ny2V3T+VJHqD9D78aJZW
         yBKZcEqnvhyd02s3+7OQOGCKC3QXb3dkitcuo2fhew8CzHXhGJUG4CSiTESnZLJK2MGQ
         6Tsoc998oAYwqvy5vuKAslEIV/FcD4Q99eH1dP3crXPASbfLWqz45/uZzbH8mVHsvjEo
         aRcgWKjno2fp9jA9rK8CuSbXrUFn/PZJ1ylND6U5dwvYZt2GnCLS6soiBYoT2qJduP+O
         Evdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635268; x=1759240068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itAvX3hB1qz6eonkBcKywNsEaMgbTwm8NpUY2huFizg=;
        b=RuZZpO4gxLqo5zCZgEF2cIYMvkTOTtiA63m73hfpbglc7LBeAE8GBD1dyvduz+e64v
         23KAXAXS+OlP/SI3UIeAOYAVGX1knCKhiMRgShC5W2rvR6uU452VwS9kS7zkps0UTCAB
         OfhLnbjvEaW7MDYwjbSZelxlsbRnppJdEjjkqtT3hjhhG0m4jdhiWsHPSBmKL1FnyFA5
         P9x/jMnkS16+8T0vaUtAOFH9nNILbKHQTj3rjHiY+wyAxy+OGdGzo+64zWrUGRQ52aUM
         NIOfe+xA9A+jKFGQ9HMAsgK9HR69bvtQFPkPL/mXHX46v7/wW0VurSZPhB2ugTDRCeBN
         oJIA==
X-Gm-Message-State: AOJu0Yw8A8F0CCOduvm8mauobanNA2YJGaDTMOmhP3r9GQU80x63qg76
	XvJp7vbzzZkC9/mz1X6XKfz+00yo+k3bEASitJRSVhGobMqQtgaelBrU
X-Gm-Gg: ASbGnctqjLGejiJ7+rsFzq0VL1QvmnfL+NUt14x+FqAeLgZN4PGouWNW+RQkufYmncG
	IpZ3MsdYMudux3D2HTLv9FZb8vcGHnCxaihjO2IARpxirSFW4EswWGUDJKGOsNyiNDZXgDcw+Pb
	Tc2g9vNpsjnDEe7tuX8cD7j7mVxUU4z4UCLIrL0JNZxZ5T+VWexd3RCAJd6pdpar4hef86JDVJq
	wetHQNO0zhPQBs9RgmHTUbyfi04MBVrRYn4NnhNLP90yuTUGoiA7TsjxUjSGHLolpdMB3yWIUvM
	Y/9wlg5D9Im72ty39P0AYeVDCx2dFZZ7S20/H20heIc84qnnZHB0ivPuJDkXyeyjH1oRGt+uRr/
	VgJyW5I5s0oyY0pHhNjCMC+RsrQOV1OBbRWmAyU4NxUcp8tj+8u4oeNyw0RNl1exnFrB81g==
X-Google-Smtp-Source: AGHT+IEimTbmh2pVu/1GM6Z8VgmXbiguDb2u+F6fwoOfs4R1bTaemrY+/MBS/sh9BbionrWlaYEKEA==
X-Received: by 2002:a05:6000:400c:b0:405:8ef9:ee71 with SMTP id ffacd0b85a97d-405c5cccf56mr2301445f8f.24.1758635267746;
        Tue, 23 Sep 2025 06:47:47 -0700 (PDT)
Received: from localhost (tor.caspervk.net. [31.133.0.235])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46d1f3e1b03sm91298025e9.23.2025.09.23.06.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:47:47 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	tcpdump-workers@lists.tcpdump.org,
	Guy Harris <gharris@sonic.net>,
	Michael Richardson <mcr@sandelman.ca>,
	Denis Ovsienko <denis@ovsienko.info>,
	Xin Long <lucien.xin@gmail.com>,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH net-next 00/17] BIG TCP for UDP tunnels
Date: Tue, 23 Sep 2025 16:47:25 +0300
Message-ID: <20250923134742.1399800-1-maxtram95@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

This series consists adds support for BIG TCP IPv4/IPv6 workloads for vxlan
and geneve. It consists of two parts:

01-11: Remove hop-by-hop header for BIG TCP IPv6 to align with BIG TCP IPv4
12-17: Fix up things that prevent BIG TCP from working with tunnels.

There are a few places that make assumptions about skb->len being
smaller than 64k and/or that store it in 16-bit fields, trimming the
length. The first step to enable BIG TCP with VXLAN and GENEVE tunnels
is to patch those places to handle bigger lengths properly (patches
12-17). This is enough to make IPv4 in IPv4 work with BIG TCP, but when
either the outer or the inner protocol is IPv6, the current BIG TCP code
inserts a hop-by-hop extension header that stores the actual 32-bit
length of the packet. This additional hop-by-hop header turns out to be
problematic for encapsulated cases, because:

1. The drivers don't strip it, and they'd all need to know the structure
of each tunnel protocol in order to strip it correctly.

2. Even if (1) is implemented, it would be an additional performance
penalty per aggregated packet.

3. The skb_gso_validate_network_len check is skipped in
ip6_finish_output_gso when IP6SKB_FAKEJUMBO is set, but it seems that it
would make sense to do the actual validation, just taking into account
the length of the HBH header. When the support for tunnels is added, it
becomes trickier, because there may be one or two HBH headers, depending
on whether it's IPv6 in IPv6 or not.

At the same time, having an HBH header to store the 32-bit length is not
strictly necessary, as BIG TCP IPv4 doesn't do anything like this and
just restores the length from skb->len. The same thing can be done for
BIG TCP IPv6 (patches 01-11). Removing HBH from BIG TCP would allow to
simplify the implementation significantly, and align it with BIG TCP IPv4.

A trivial tcpdump PR for IPv6 is pending here [0]. While the tcpdump
commiters seem actively contributing code to the repository, it
appears community PRs are stuck for a long time (?). We checked
with Xin Long with regards to BIG TCP IPv4, and it turned out only
GUESS_TSO was added to the Fedora distro spec file CFLAGS definition
back then. In any case we have Cc'ed Guy Harris et al (tcpdump maintainer/
committer) here just in case to see if he could help out with unblocking [0].

Thanks all!

[0] https://github.com/the-tcpdump-group/tcpdump/pull/1329

Daniel Borkmann (1):
  geneve: Enable BIG TCP packets

Maxim Mikityanskiy (16):
  net/ipv6: Introduce payload_len helpers
  net/ipv6: Drop HBH for BIG TCP on TX side
  net/ipv6: Drop HBH for BIG TCP on RX side
  net/ipv6: Remove jumbo_remove step from TX path
  net/mlx5e: Remove jumbo_remove step from TX path
  net/mlx4: Remove jumbo_remove step from TX path
  ice: Remove jumbo_remove step from TX path
  bnxt_en: Remove jumbo_remove step from TX path
  gve: Remove jumbo_remove step from TX path
  net: mana: Remove jumbo_remove step from TX path
  net/ipv6: Remove HBH helpers
  net: Enable BIG TCP with partial GSO
  udp: Support gro_ipv4_max_size > 65536
  udp: Validate UDP length in udp_gro_receive
  udp: Set length in UDP header to 0 for big GSO packets
  vxlan: Enable BIG TCP packets

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 21 -----
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  |  3 -
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  3 -
 drivers/net/ethernet/mellanox/mlx4/en_tx.c    | 42 ++--------
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   | 75 +++---------------
 drivers/net/ethernet/microsoft/mana/mana_en.c |  3 -
 drivers/net/geneve.c                          |  2 +
 drivers/net/vxlan/vxlan_core.c                |  2 +
 include/linux/ipv6.h                          | 21 ++++-
 include/net/ipv6.h                            | 79 -------------------
 include/net/netfilter/nf_tables_ipv6.h        |  4 +-
 net/bridge/br_netfilter_ipv6.c                |  2 +-
 net/bridge/netfilter/nf_conntrack_bridge.c    |  4 +-
 net/core/dev.c                                |  6 +-
 net/core/gro.c                                |  2 -
 net/core/skbuff.c                             | 10 +--
 net/ipv4/udp.c                                |  5 +-
 net/ipv4/udp_offload.c                        | 12 ++-
 net/ipv4/udp_tunnel_core.c                    |  2 +-
 net/ipv6/ip6_input.c                          |  2 +-
 net/ipv6/ip6_offload.c                        | 36 +--------
 net/ipv6/ip6_output.c                         | 20 +----
 net/ipv6/ip6_udp_tunnel.c                     |  2 +-
 net/ipv6/output_core.c                        |  7 +-
 net/netfilter/ipvs/ip_vs_xmit.c               |  2 +-
 net/netfilter/nf_conntrack_ovs.c              |  2 +-
 net/netfilter/nf_log_syslog.c                 |  2 +-
 net/sched/sch_cake.c                          |  2 +-
 28 files changed, 84 insertions(+), 289 deletions(-)

-- 
2.50.1


