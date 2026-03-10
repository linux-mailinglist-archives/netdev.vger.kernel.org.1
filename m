Return-Path: <netdev+bounces-266285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMPwHWxesGloigIAu9opvQ
	(envelope-from <netdev+bounces-266285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:09:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D21562562E9
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5954B313B91D
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1863D47AE;
	Tue, 10 Mar 2026 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZaLXMgLb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C953C9434
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166119; cv=none; b=X/jO2khJPYw8Lnp5TcSGaGUtjW+gUC73OuadZjyoKlZzpQ9Zu8sPggVOBf6bPyH7N/X+SyhXGiTOAaO8KOX91qKLHaUvVgzxw5wKJEqeX9TEiJtBJQXG+R3NV65j6cOnxNI3yFk435NQquEhjHtq3EV6Ul/yYC+gUNhAPuSDVqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166119; c=relaxed/simple;
	bh=bit/ic6HN5WNdhAWxtNn4HhVc6Jh/lKIurv4+Mh1ZiU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=gDcRMGcIrHbmETmUrCnj6k5TRe1qaP3Xkfe5OX25sb9kRVYcR9EUdAmXTgTF2ODNwqupyHGJHLqoMOmdHO6uvq/LxGInJeu7NDmDqZE1PVARtI9OPXvM8ExC1dcsFLQQrX/lFBZwkYg0EePgnuQD1Op8fG63BUWf8gG2j+hem3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZaLXMgLb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so37849545e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 11:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773166116; x=1773770916; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03GQ7mrH28/JbpPiAKnbywEuim+LKwXQ0RbcMJr59SQ=;
        b=ZaLXMgLbBSg8KLtkplvsmKp9NlJh2N/XDZ2gB4MXRgS07TqFNoiuo70+k3QqDdP6DL
         jsclKK0E0PZDEFPKZ5b8lMyLEQb3eQAic5o6YfezB6Isg4vuSALF5FZoUxZW03L+fPyr
         4w03/chh74H1lkVV9wI2VJgZxwdspXW4dIiw0xXJ7kVRXFWLzZ/tsC0RPAo6BBJ0BMBD
         wAKzEAwL5US9YJVFAla9a+L8bpdlWm9gTPfy7fbHim5qgaSWs5fgu1+z7ov9UKGx5Uqw
         J4jnrjOQoLR5OokIaTLSsJ3Gm2i8kh58DiB+tCmAmV7AoNT8Ym2MBz4oRLIsq55howgd
         NvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773166116; x=1773770916;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=03GQ7mrH28/JbpPiAKnbywEuim+LKwXQ0RbcMJr59SQ=;
        b=MRqA0lkP27G6PFzoTmDCEb2TDDs/PbhBCKqE+Jyk7VXieoF8IO8++fPYB5r5rRwPn5
         zeCJM5WY2eyZngnwR1di6X6cKr6ZDThZsCCXwvKO4iTHPUilhbjXvZuXE8gpXWU1eDWy
         Qe0I6zRr4Rxx2IpyVIGCKULBr3KUoLzwGpzvJcXFLoAplKm+Et2iOcfN80P4+NpakNC+
         hOzPK8KaAvn0MjD7x+vMKazCLTPP126Q9BNpaS4M0I2sTPmLRY44FbikeAf0hz0UThpL
         nCwSk+g0hiJ37vWe59c3gT4kW2eEXBu3qQklMXQkFLmHx49T4L5X8FlEgcGO1N8bqqVu
         dcXg==
X-Forwarded-Encrypted: i=1; AJvYcCVfxKjdma1VzOgqBIoKvOKLJb2o9RidMsMzaCvGTZdaSeE9kIUXJobCs1z7dWpKaqL/Wfm/plE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxopRPGglCyoZtFMGN7K9e3g1RUInVmrt/genrKitjCtLi6Ywci
	WxwF7vFSRDG1ev0uQnSiPZwY47FhADC6IM7COe3l/K1Gam86fUU506k5X10FLApAPmM=
X-Gm-Gg: ATEYQzwOy1LMFZxQ17mQDL/GuTaHJ3n3WAJNV6tQnemnbs3/XOtdTYLWF69uBcCRHDW
	Ls3nzmnFVpN4DOHQERWLktLvMzCd7vBFGBMeZI6ZXTpgOU1WnvUm6avIo+P/5QMgiPhqNR60H9Q
	0OobrXpue0Na8+q7I9N2wX+jdzhavTlDA17c4C59JTDKJnKX7WLT3sC6U0cxVOusk3ZZJpnq1QG
	0ZEJ7jMyv/d1qbtc9Ct8/IqQTeOP0zOFjWQhPBSbpEGF2wHNc8GoLTCUndKGcNQ33obcyodPEtU
	WBir+6BeE5BZ7Csg6q1LNQKAPDw7xcsjOh0Aoj/ABUCCP0PKctTklzx5gBdlrDNOf4gne38fkMM
	ZpbUIMc5Xne3g4gn2voxxQ3h4Ree3qO1PBl2NABAdgJI4z9O9FOiXotT2PhMdlFDlr8Dg3mdca/
	yAQNuOQkWBtF9ENtQPvoAs
X-Received: by 2002:a05:600c:3b83:b0:485:35d3:ce57 with SMTP id 5b1f17b1804b1-48535d3cf0cmr194530295e9.34.1773166115704;
        Tue, 10 Mar 2026 11:08:35 -0700 (PDT)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f8481c1sm15462214eec.15.2026.03.10.11.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Mar 2026 15:08:32 -0300
Message-Id: <DGZAXEK6CSAH.2AJXYLOUG3LL8@suse.com>
Subject: Re: [PATCH 00/10 net-next v2] Convert CONFIG_IPV6 to built-in and
 remove stubs
Cc: <rbm@suse.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <dsahern@kernel.org>, <linux-kernel@vger.kernel.org>
To: "Fernando Fernandez Mancera" <fmancera@suse.de>,
 <netdev@vger.kernel.org>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
X-Mailer: aerc 0.21.0-120-g22b95d38161f
References: <20260310153506.5181-1-fmancera@suse.de>
In-Reply-To: <20260310153506.5181-1-fmancera@suse.de>
X-Rspamd-Queue-Id: D21562562E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266285-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbm@suse.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue Mar 10, 2026 at 12:34 PM -03, Fernando Fernandez Mancera wrote:
> Historically, the Linux kernel has supported compiling the IPv6 stack as
> a loadable module. While this made sense in the early days of IPv6
> adoption, modern deployments and distributions overwhelmingly either
> build IPv6 directly into the kernel (CONFIG_IPV6=3Dy) or disable it
> entirely (CONFIG_IPV6=3Dn). The modular IPv6 use-case offers image size
> and memory savings for specific setups, this benefit is outweighed by
> the architectural burden it imposes on the subsystems on implementation
> and maintenance.
>
> To allow core networking, BPF, Netfilter, and various device drivers to
> safely interact with a potentially unloaded IPv6 module, the kernel
> relies on indirect call structures like ipv6_stub, ipv6_bpf_stub, and
> nf_ipv6_ops, along with dynamic RCU registrations for things like ICMPv6
> senders.
>
> This patch series addresses this by changing CONFIG_IPV6 from a tristate
> to a boolean, enforcing that IPv6 is either built-in or disabled. This
> allows us to completely rip out the stub infrastructures and safely
> replace them with direct function calls.
>
> The bloat-o-meter report the following results for m68k, arm64, x86_64
> defconfig.
>
> m68k (keep on mind that CONFIG_IPV6 is disabled now):
> add/remove: 65/938 grow/shrink: 36/254 up/down: 3022/-49692 (-46670)
>
> arm64:
> add/remove: 1251/265 grow/shrink: 81/46 up/down: 448740/-71519 (377221)
>
> x86_64:
> add/remove: 62/98 grow/shrink: 10/39 up/down: 2497/-4357 (-1860)
>
> All the patches has been independently build tested. With allmodconfig
> and allmodconfig + CONFIG_IPV6=3Dn. In addition, net selftest has been ru=
n
> against them on virtme-ng.
>
> The series applied as a whole as been tested with allyesconfig and also
> allyesconfig + CONFIG_IPV6=3Dn but not all patches has been independently
> tested this way.
>
> This will like need to wait for [1] and [2] to be applied to avoid
> conflicts from net tree and rebased in top of them.
>
> [1] https://lore.kernel.org/netdev/20260307-net-nd_tbl_fixes-v4-0-e2677e8=
5628c@suse.com/
>
> [2] https://lore.kernel.org/netdev/20260308032304.1841198-1-kuniyu@google=
.com/
>
> Fernando Fernandez Mancera (10):
>   ipv6: convert CONFIG_IPV6 to built-in only and clean up Kconfigs
>   ipv6: replace IS_BUILTIN(CONFIG_IPV6) with IS_ENABLED(CONFIG_IPV6)
>   ipv6: remove dynamic ICMPv6 sender registration infrastructure
>   ipv6: prepare headers for ipv6_stub removal
>   drivers: net: drop ipv6_stub usage and use direct function calls
>   ipv4: drop ipv6_stub usage and use direct function calls
>   net: convert remaining ipv6_stub users to direct function calls
>   bpf: remove ipv6_bpf_stub completely and use direct function calls
>   ipv6: remove ipv6_stub infrastructure completely
>   netfilter: remove nf_ipv6_ops and use direct function calls

Using defconfig + tools/testing/selftests/net/config:

- All commits build with both IPV6=3Dy and IPV6=3Dn with no problems.
- All net selftests report OK on tip commit.

Tested-by: Ricardo B. Marli=C3=A8re <rbm@suse.com>

>
>  arch/arm64/configs/defconfig                  |   2 +-
>  arch/m68k/configs/amiga_defconfig             |  45 +-------
>  arch/m68k/configs/apollo_defconfig            |  46 +-------
>  arch/m68k/configs/atari_defconfig             |  45 +-------
>  arch/m68k/configs/bvme6000_defconfig          |  45 +-------
>  arch/m68k/configs/hp300_defconfig             |  47 +-------
>  arch/m68k/configs/mac_defconfig               |  45 +-------
>  arch/m68k/configs/multi_defconfig             |  45 +-------
>  arch/m68k/configs/mvme147_defconfig           |  45 +-------
>  arch/m68k/configs/mvme16x_defconfig           |  45 +-------
>  arch/m68k/configs/q40_defconfig               |  45 +-------
>  arch/m68k/configs/sun3_defconfig              |  45 +-------
>  arch/m68k/configs/sun3x_defconfig             |  45 +-------
>  drivers/infiniband/Kconfig                    |   1 -
>  drivers/infiniband/core/addr.c                |   3 +-
>  drivers/infiniband/hw/ocrdma/Kconfig          |   2 +-
>  drivers/infiniband/sw/rxe/rxe_net.c           |   6 +-
>  drivers/infiniband/ulp/ipoib/Kconfig          |   2 +-
>  drivers/net/Kconfig                           |   9 --
>  drivers/net/ethernet/broadcom/Kconfig         |   2 +-
>  drivers/net/ethernet/chelsio/Kconfig          |   2 +-
>  .../mellanox/mlx5/core/en/rep/neigh.c         |  12 ++-
>  .../ethernet/mellanox/mlx5/core/en/tc_tun.c   |   3 +-
>  .../mellanox/mlx5/core/en/tc_tun_encap.c      |   2 +-
>  .../mellanox/mlx5/core/en_accel/ipsec.c       |   1 -
>  .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   1 -
>  .../net/ethernet/mellanox/mlx5/core/en_tc.c   |   1 -
>  drivers/net/ethernet/mellanox/mlxsw/Kconfig   |   1 -
>  .../ethernet/mellanox/mlxsw/spectrum_router.c |   9 +-
>  .../ethernet/mellanox/mlxsw/spectrum_span.c   |   3 +-
>  drivers/net/ethernet/netronome/Kconfig        |   1 -
>  .../ethernet/netronome/nfp/flower/action.c    |   2 +-
>  .../netronome/nfp/flower/tunnel_conf.c        |   9 +-
>  drivers/net/ethernet/sfc/tc_counters.c        |   2 +-
>  drivers/net/ethernet/sfc/tc_encap_actions.c   |   5 +-
>  drivers/net/geneve.c                          |   1 -
>  drivers/net/gtp.c                             |   2 +-
>  drivers/net/ovpn/peer.c                       |   3 +-
>  drivers/net/ovpn/udp.c                        |   3 +-
>  drivers/net/usb/cdc_mbim.c                    |  17 +--
>  drivers/net/vrf.c                             |   3 +-
>  drivers/net/vxlan/vxlan_core.c                |  11 +-
>  drivers/net/vxlan/vxlan_multicast.c           |   6 +-
>  drivers/net/wireguard/socket.c                |   3 +-
>  drivers/net/wireless/intel/ipw2x00/ipw2100.c  |   2 +-
>  drivers/scsi/bnx2fc/Kconfig                   |   1 -
>  drivers/scsi/bnx2i/Kconfig                    |   1 -
>  drivers/scsi/cxgbi/cxgb3i/Kconfig             |   2 +-
>  drivers/scsi/cxgbi/cxgb4i/Kconfig             |   2 +-
>  fs/dlm/Kconfig                                |   2 +-
>  fs/gfs2/Kconfig                               |   2 +-
>  include/linux/icmpv6.h                        |  26 +----
>  include/linux/indirect_call_wrapper.h         |   2 +-
>  include/linux/netfilter_ipv6.h                | 102 ++----------------
>  include/net/ip.h                              |   5 -
>  include/net/ip6_fib.h                         |  34 +++++-
>  include/net/ip6_route.h                       |  26 +++++
>  include/net/ipv6.h                            |  12 +++
>  include/net/ipv6_stubs.h                      | 102 ------------------
>  include/net/ndisc.h                           |  38 +++----
>  include/net/udp_tunnel.h                      |   3 +-
>  net/bridge/Kconfig                            |   1 -
>  net/bridge/br_arp_nd_proxy.c                  |   3 +-
>  net/bridge/br_netfilter_hooks.c               |  12 +--
>  net/bridge/br_netfilter_ipv6.c                |   7 +-
>  net/core/filter.c                             |  70 ++++++------
>  net/core/lwt_bpf.c                            |  10 +-
>  net/ieee802154/6lowpan/tx.c                   |   2 +-
>  net/ipv4/Kconfig                              |   9 +-
>  net/ipv4/fib_semantics.c                      |  11 +-
>  net/ipv4/icmp.c                               |   2 +-
>  net/ipv4/nexthop.c                            |  21 ++--
>  net/ipv4/route.c                              |   2 +-
>  net/ipv4/udp.c                                |   7 +-
>  net/ipv6/Kconfig                              |   6 +-
>  net/ipv6/addrconf.c                           |  10 +-
>  net/ipv6/addrconf_core.c                      |  91 ----------------
>  net/ipv6/af_inet6.c                           |  69 ++----------
>  net/ipv6/icmp.c                               |   6 --
>  net/ipv6/ip6_fib.c                            |  10 +-
>  net/ipv6/ip6_icmp.c                           |  46 +-------
>  net/ipv6/ip6_offload.c                        |   4 +-
>  net/ipv6/ip6_output.c                         |   5 +-
>  net/ipv6/ip6_udp_tunnel.c                     |   3 +-
>  net/ipv6/ndisc.c                              |  35 +++---
>  net/ipv6/netfilter.c                          |  48 ---------
>  net/ipv6/route.c                              |  13 +--
>  net/l2tp/Kconfig                              |   1 -
>  net/mpls/af_mpls.c                            |   3 +-
>  net/netfilter/Kconfig                         |   8 --
>  net/netfilter/core.c                          |   3 -
>  net/netfilter/nf_nat_masquerade.c             |  21 +---
>  net/netfilter/nfnetlink_queue.c               |  22 +++-
>  net/netfilter/utils.c                         |   1 -
>  net/openvswitch/actions.c                     |   3 +-
>  net/rxrpc/Kconfig                             |   2 +-
>  net/sched/sch_frag.c                          |   4 +-
>  net/sctp/Kconfig                              |   1 -
>  net/tipc/Kconfig                              |   1 -
>  net/tipc/udp_media.c                          |   9 +-
>  net/xfrm/espintcp.c                           |   5 +-
>  net/xfrm/xfrm_nat_keepalive.c                 |   4 +-
>  net/xfrm/xfrm_output.c                        |   3 +-
>  103 files changed, 328 insertions(+), 1301 deletions(-)
>  delete mode 100644 include/net/ipv6_stubs.h


