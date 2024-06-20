Return-Path: <netdev+bounces-105473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5161911580
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 00:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2069B20F1A
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 22:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D987E799;
	Thu, 20 Jun 2024 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dkTMPl2Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6300455880
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921952; cv=none; b=n1IfFib6n5Sqo2eAYZJASC3e1OcZ4SBD2CEFwOIg/PRjhhDk50BBqALZHXkkYWlgZFJr2FBh/NYod9XksYQLO/TWmBlEZkDU6/Et17GB8i/YeSlQpYxW34Bt6Nn0AadF9vDrkys/+tKrMcB2VucWquT+vJbuu9n2r+OhoQL4Vlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921952; c=relaxed/simple;
	bh=EgLIeqznyOPTSJ5z6m8OsrbxN79BJFzPw3f2c5ZHDRc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nmlm36KP9rzY3YYboUJG8Se8ldga8XHyLsyLcfMftZsO2ftyJ06bk5e6UIIpbLylwwN7TOL7OIH1cgB0k7XIiK1S41a90wISUZfGoZfS0GW9WkY4pNG0QgMJ4rb27wZTzT4hE2er5+9nHQCICFRgQrRZcTh1H1y5FmiIozw+OXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dkTMPl2Z; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5bae81effd1so730141eaf.2
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 15:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718921950; x=1719526750; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8CXkaBTtnkZYe8FKNmQUlJrq+bqc8/5T0kpTwXzA8v4=;
        b=dkTMPl2Z/CHsXCT1RFEvERm/SacDhS9UhhfyPiA+SX8bjFfZUqd8VubfZTNDMioK6/
         t+5Ud3iY/Hsbf66HuOsxKyKK3GEnHIdOQerWDjRFwxzH74lTfBCMUZHJYT9aYHkTTc7d
         VJLIdTBUwiXyraea4QQskcRv+l56VRq6rZOKQAOY7enPcBwHZWly4BF3Naqc1tvB3e69
         pVuY9Ze/0Fc+RN4BWjml+sJsSPC0q3clnkekV8YW9BWfTarhEcmFT0YeFcn6+2ExhvX+
         OxtSXWCjOnRHyqcQbmwaRadmo8ISoNveiuH4ZKEQuEbvWW4jiCCS1s4/dkkq1gXZKKfR
         ScwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718921950; x=1719526750;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CXkaBTtnkZYe8FKNmQUlJrq+bqc8/5T0kpTwXzA8v4=;
        b=qmKZ/aKKtetgjeM6E20WcD1u7ZyKDO5FEZ+ZVACZSPLwj0OqbtUqib34FUr+DcAUdv
         lu1BQNCT5Mtmm4CY3Y82JemJVO0EeGtRWwMKL9ScqWuprwqKm+IdoeB3vziqteHZ+AjP
         1UqhEGVPGKcY+J6Tv1YndKShstJmZVRurhAczzKAELB9fdaUHzpe8eJ5o2mcSxtx84HM
         sr7One8kgOkhHw3MeFW7lg/3mZ/c7F2nXw1jOUX8/u6aLMzoLL5aOakyiosJ2hSh2D0k
         ++qMC1GIGEEMKmD5QQ/ly6BQdrB7U0XJ5dduCca9hr8OMogmAoneIbA4loIS7vHig8jS
         h9hQ==
X-Gm-Message-State: AOJu0YwPeUy0M4OO5Co0Qnct6TJP+CpZYw725n9ZWe7Ja8kPE272Hi/9
	Y01MnRjRG0VM5t7e4SYnLMjJSLY4pDBplUwKlzfbNbDsxW/s0gV6gQFymncTGQoVhZWIL3LlEb+
	+
X-Google-Smtp-Source: AGHT+IEn/e1JCoI6n9QjJCApJJIiV/04yUlZRh2THSU//mSCMbMWyTjDtNzzp65OpwjNG+jObfWH4Q==
X-Received: by 2002:a05:6358:5e08:b0:19f:3a23:880 with SMTP id e5c5f4694b2df-1a1fd5259e3mr837090755d.23.1718921949881;
        Thu, 20 Jun 2024 15:19:09 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:19cd::292:40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce8b1297sm17704285a.43.2024.06.20.15.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:19:09 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:19:07 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org, yan@cloudflare.com
Subject: [RFC net-next 0/9] xdp: allow disable GRO per packet by XDP
Message-ID: <cover.1718919473.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Software GRO is currently controlled by a single switch, i.e.

  ethtool -K dev gro on|off

However, this is not always desired. When GRO is enabled, even if the
kernel cannot GRO certain traffic, it has to run through the GRO receive
handlers with no benefit.

There are also scenarios that turning off GRO is a requirement. For
example, our production environment has a scenario that a TC egress hook
may add multiple encapsulation headers to forwarded skbs for load
balancing and isolation purpose. The encapsulation is implemented via
BPF. But the problem arises then: there is no way to properly offload a
double-encapsulated packet, since skb only has network_header and
inner_network_header to track one layer of encapsulation, but not two.
On the other hand, not all the traffic through this device needs double
encapsulation. But we have to turn off GRO completely for any ingress
device as a result.

A natural approach to make this more flexible is to use XDP to control
GRO behavior. But current semantic gap between XDP buffer/frame and socket
buffer requires some new primitives.

This change set proposes a control bit gro_disabled on skbs to determine
if GRO should work on an skb or not. To manipulate this bit, we
introduce a new XDP kfunc bpf_xdp_disable_gro as well as generic helpers
xdp_frame/buff_fixup_skb_offloading.

The expected working flow is that:
* XDP program examines packets and can call bpf_xdp_disable_gro to
  disable GRO on a packet
* Device drivers need to call xdp_buff_fixup_skb_offloading (or
  equivalent version for xdp_frame), to check if skb->gro_disabled
  needs to be set.
* The kernel will elide GRO later if this bit is used.

Initially we only modified a few drivers for demonstration purpose. The
driver side changes is optional and also incremental depending on
vendors' agenda. Any suggestions are welcome!

Jesper Dangaard Brouer (1):
  mlx5: move xdp_buff scope one level up

Yan Zhai (8):
  skb: introduce gro_disabled bit
  xdp: add XDP_FLAGS_GRO_DISABLED flag
  xdp: implement bpf_xdp_disable_gro kfunc
  bnxt: apply XDP offloading fixup when building skb
  ice: apply XDP offloading fixup when building skb
  veth: apply XDP offloading fixup when building skb
  mlx5: apply XDP offloading fixup when building skb
  bpf: selftests: test disabling GRO by XDP

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   4 +
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   6 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/rx.c   |  10 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/rx.h   |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 117 ++++++++++-------
 drivers/net/veth.c                            |   4 +
 include/linux/netdevice.h                     |   9 +-
 include/linux/skbuff.h                        |  10 ++
 include/net/xdp.h                             |  38 +++++-
 include/net/xdp_sock_drv.h                    |   2 +-
 net/Kconfig                                   |  10 ++
 net/core/gro.c                                |   2 +-
 net/core/gro_cells.c                          |   2 +-
 net/core/skbuff.c                             |   4 +
 net/core/xdp.c                                |  27 +++-
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/xdp_offloading.c | 122 ++++++++++++++++++
 .../selftests/bpf/progs/xdp_offloading.c      |  50 +++++++
 20 files changed, 369 insertions(+), 63 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_offloading.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_offloading.c

-- 
2.30.2



