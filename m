Return-Path: <netdev+bounces-77626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7D787268B
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 19:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455FE1F281E9
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 18:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E216418AED;
	Tue,  5 Mar 2024 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VzY/HMe3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6A217C6E
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663363; cv=none; b=evMD+BNqZam1WHrrExSiWmocC8iKfidlMctJR+0ny2xvmMsH18/f4uqycs+iRd4UFj0L5yU+9zl4AwFvs/XqMCQoUhCfAcxClAzzzhx0fnYqMXxkb1YcbgxSG//ARs3wjS6Qnca/Bm29erSo9qK+aqbSZ6DxSaM6LSmoP/IcpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663363; c=relaxed/simple;
	bh=d4SDYPcK3ui/iasvcVQRHJS5HLEZg5XlZdzq8LAryhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrnffYtrjcHQlB3LUVx9dT1NL/wARROvqwTmJjaX8lIoe75faGYXHAD7P7bUFGLrQOo5Ml8Su55IeGjr4lgfAxvS+o3l2lVTsAt+VBNSqXs3gJKtjP7s5VW4WDN7y45GxM+nat9MwCSkvqe+giJAQzjDqg2bDWL8gtsK5laW7kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VzY/HMe3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412f18cd094so5155e9.1
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 10:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709663360; x=1710268160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oo5Kn86/Rxexd7CHhraCAyyooug8JvfZgqGxxt5ExJY=;
        b=VzY/HMe3Et5r4HTnqOdd/z1iVkuxDPUi6KMCItB+PEbOeMG5i+WpgPTdd8i+8oHwXM
         x3oG8u3J1VVOPeEOSozr1W5O8AXJpnlFvjovQWs6ujevZSpS0o338wJiDSPiHyOREDpI
         usb0MhxDI+XhaDP+0y7br21sGVXDx7e7rLI1/7YkZsbGZPy8Aut1kmXSkPwY+P5ZtWWv
         W5AfCNAkaTM2Fn3CE75HXMhvoyHXzQNaW8XgUnFcILv0Cnh+o0nmZOCPTTYeUjc3+RM9
         gTHOrZmT1qW/0JGlmac589VnbHJulLNX7AHL7Py1/JZzul5h1YxrTmQT2+fgGCOIk78D
         lCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709663360; x=1710268160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oo5Kn86/Rxexd7CHhraCAyyooug8JvfZgqGxxt5ExJY=;
        b=KG45OI9B2GHLsu7Ur20azHO5/DfcczUype4Enc2pg1j/ZkroRYWJ1sCYEWvF8OGHE/
         qYQ9KY4x4aYY7Kr6ISvnVxeORC82RvTeG4naTkP0b93CSwqSwZopbl18gpgNs2ihwRzw
         RUjF0mRsFtD44N3llALizUx1Ax+8LwrKIKQcDPyFzpsy7tihxYu1bIRVBpkGC1AKNZzz
         uQpQsqU36HU3J3p3l7+S9BBJKH1hRMmn0BJaQjkQKOeO0WvuvY6MwuQE5PDP7V6GwQrq
         AjLbUGd4DSszM50vmvi5UkGlnJX0gEGQrZZ5buqxCRFOWjrehXZKE5ADQsABZQ4W4wFB
         th5w==
X-Forwarded-Encrypted: i=1; AJvYcCVk+wPklJ3CuGfceZOtxbP0iOO2CpFB1nqILsZVi28c2Xxl/vW5RYQfaMUGWEpSeJyXEO3JDE8WR7pYAREf32FNZXXndc0w
X-Gm-Message-State: AOJu0YwLlT4LcrAjsLI+QtKyuQIPws5ku2/OhSlGIUl0oWcH5P47JvpC
	v/H42N4ewqznZGA4qUKVQ9FRpssTLGD8POv1umGMrF3ztUoQ9u6c13RsnuFa1oUW4ZCLCUZVXM8
	0r0w2UlZEySYMxhs7uh2Diq2z0aMk5GqVd3xS
X-Google-Smtp-Source: AGHT+IHAjs/ChCm0ueFV5Lz1VJ16EqR9k+nrijv3Tycdalr/eFS+XEmf3XjkzaNlTZxL5hE+JyE5ZOfDhIYJzMLRzGY=
X-Received: by 2002:a05:600c:5106:b0:412:c3d0:593d with SMTP id
 o6-20020a05600c510600b00412c3d0593dmr170650wms.5.1709663360128; Tue, 05 Mar
 2024 10:29:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305160413.2231423-1-edumazet@google.com>
In-Reply-To: <20240305160413.2231423-1-edumazet@google.com>
From: Soheil Hassas Yeganeh <soheil@google.com>
Date: Tue, 5 Mar 2024 13:28:42 -0500
Message-ID: <CACSApvZcw+A_gRwFi3vErYp5WkY=v9sC7aTxFzKvY5GdtOQB+w@mail.gmail.com>
Subject: Re: [PATCH net-next 00/18] net: group together hot data
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 11:04=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> While our recent structure reorganizations were focused
> on increasing max throughput, there is still an
> area where improvements are much needed.
>
> In many cases, a cpu handles one packet at a time,
> instead of a nice batch.
>
> Hardware interrupt.
>  -> Software interrupt.
>    -> Network/Protocol stacks.
>
> If the cpu was idle or busy in other layers,
> it has to pull many cache lines.
>
> This series adds a new net_hotdata structure, where
> some critical (and read-mostly) data used in
> rx and tx path is packed in a small number of cache lines.
>
> Synthetic benchmarks will not see much difference,
> but latency of single packet should improve.
>
> net_hodata current size on 64bit is 416 bytes,
> but might grow in the future.
>
> Also move RPS definitions to a new include file.

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>

Nice series!

> Eric Dumazet (18):
>   net: introduce struct net_hotdata
>   net: move netdev_budget and netdev_budget to net_hotdata
>   net: move netdev_tstamp_prequeue into net_hotdata
>   net: move ptype_all into net_hotdata
>   net: move netdev_max_backlog to net_hotdata
>   net: move ip_packet_offload and ipv6_packet_offload to net_hotdata
>   net: move tcpv4_offload and tcpv6_offload to net_hotdata
>   net: move dev_tx_weight to net_hotdata
>   net: move dev_rx_weight to net_hotdata
>   net: move skbuff_cache(s) to net_hotdata
>   udp: move udpv4_offload and udpv6_offload to net_hotdata
>   ipv6: move tcpv6_protocol and udpv6_protocol to net_hotdata
>   inet: move tcp_protocol and udp_protocol to net_hotdata
>   inet: move inet_ehash_secret and udp_ehash_secret into net_hotdata
>   ipv6: move inet6_ehash_secret and udp6_ehash_secret into net_hotdata
>   ipv6: move tcp_ipv6_hash_secret and udp_ipv6_hash_secret to
>     net_hotdata
>   net: introduce include/net/rps.h
>   net: move rps_sock_flow_table to net_hotdata
>
>  drivers/net/ethernet/intel/ice/ice_arfs.c     |   1 +
>  .../net/ethernet/mellanox/mlx4/en_netdev.c    |   1 +
>  .../net/ethernet/mellanox/mlx5/core/en_arfs.c |   1 +
>  drivers/net/ethernet/sfc/rx_common.c          |   1 +
>  drivers/net/ethernet/sfc/siena/rx_common.c    |   1 +
>  drivers/net/tun.c                             |   1 +
>  include/linux/netdevice.h                     |  88 ------------
>  include/linux/skbuff.h                        |   1 -
>  include/net/gro.h                             |   5 +-
>  include/net/hotdata.h                         |  52 ++++++++
>  include/net/protocol.h                        |   3 +
>  include/net/rps.h                             | 125 ++++++++++++++++++
>  include/net/sock.h                            |  35 -----
>  kernel/bpf/cpumap.c                           |   4 +-
>  net/bpf/test_run.c                            |   4 +-
>  net/core/Makefile                             |   1 +
>  net/core/dev.c                                |  58 +++-----
>  net/core/dev.h                                |   3 -
>  net/core/gro.c                                |  15 +--
>  net/core/gro_cells.c                          |   3 +-
>  net/core/gso.c                                |   4 +-
>  net/core/hotdata.c                            |  22 +++
>  net/core/net-procfs.c                         |   7 +-
>  net/core/net-sysfs.c                          |   1 +
>  net/core/skbuff.c                             |  44 +++---
>  net/core/sysctl_net_core.c                    |  25 ++--
>  net/core/xdp.c                                |   5 +-
>  net/ipv4/af_inet.c                            |  49 +++----
>  net/ipv4/inet_hashtables.c                    |   3 +-
>  net/ipv4/tcp.c                                |   1 +
>  net/ipv4/tcp_offload.c                        |  17 ++-
>  net/ipv4/udp.c                                |   2 -
>  net/ipv4/udp_offload.c                        |  17 ++-
>  net/ipv6/af_inet6.c                           |   1 +
>  net/ipv6/inet6_hashtables.c                   |   8 +-
>  net/ipv6/ip6_offload.c                        |  18 +--
>  net/ipv6/tcp_ipv6.c                           |  17 +--
>  net/ipv6/tcpv6_offload.c                      |  16 +--
>  net/ipv6/udp.c                                |  19 ++-
>  net/ipv6/udp_offload.c                        |  21 ++-
>  net/sched/sch_generic.c                       |   3 +-
>  net/sctp/socket.c                             |   1 +
>  net/xfrm/espintcp.c                           |   4 +-
>  net/xfrm/xfrm_input.c                         |   3 +-
>  44 files changed, 391 insertions(+), 320 deletions(-)
>  create mode 100644 include/net/hotdata.h
>  create mode 100644 include/net/rps.h
>  create mode 100644 net/core/hotdata.c
>
> --
> 2.44.0.278.ge034bb2e1d-goog
>

