Return-Path: <netdev+bounces-166673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF4BA36EE3
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 15:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0889216D3C6
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 14:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC771A5B92;
	Sat, 15 Feb 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyEXBCEX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A168A4400
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739630971; cv=none; b=cq/SeOLlpuYPkaHMFzgg/uHLj02UTWzarkvELQ00GAowMUBcduBrFNIc5i/r7J7h2sJQD8mnjhxFz+00frPoZjQhNYIs/TSsGAR9ycOnESUI5uuH2fFZJ5qWyApEPMqMRQ1hHXgAAd2kwPmTcVr/3xQbyfMCibOtbchND11KHDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739630971; c=relaxed/simple;
	bh=+vAwt+wh88vvPX6xR7qUaqvexFXjNmWp5z9pQPrP56c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Tt1BBZ2T4S5Y5tOLV/o/0iZ5+fCstvsrjfv8/jV4rbkVI2rksCnHZvl3B+YThRCSMSFuWuTu+/VSGf4T4acU+yr6n5vLPYVJ4r8NdNi+ETGRGQJkIPi0602XkgffXmDZQgRaOtmQJDQu2nNlOIh3Duc1LQlDTjhGf2RN68t1t6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyEXBCEX; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c07b65efeeso235713085a.2
        for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 06:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739630968; x=1740235768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/Oe+vStV0Rrs+qVaGNe1olWj3rdZtt3hHlahzYjF0s=;
        b=lyEXBCEXIuetVyi637VTR0CsYmtK9pHB1SlKSjLH4aNQTEfs8FaUM0v28kE0CZfVDx
         BPItR+xHDlVX3KY243C6C47oXRJG54+YZSzXu6iLK94UZ+TFuxWvPtzrN2IoZYhb6JaV
         xK+RMTPF4uySDIRk37dt2GEDVlI6e/8aLp8fwvNzO4tl0qufzjdPMVxJDIEMwJi4gszq
         f9NqAHK6GbygJfHJsxo6j58jq9XsfIo1tza2lNRaoa8y9ucErXUQTK34BFTxm3pX8EQ3
         UZd7MUpnwcczh/9C6Kkp7Zv5PcOmWPovdb7P4lcPWK3/5pusXq7/rKw/srJ8fE79veeb
         O2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739630968; x=1740235768;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X/Oe+vStV0Rrs+qVaGNe1olWj3rdZtt3hHlahzYjF0s=;
        b=keNs9luWkpcrWd86OOA7PR3uiEPtgiVJd5ggX9A/m3EtV12BCWAPmiHDqQi0KFOho+
         bKk9YbJ3vNVxR0SAsH24pTCxVofUp4898NqCEr79aXIEAK0uHIoY2FaWzk+xkv9wejAi
         iMAF9U/OUinGAWZ5Kl5WR6vr35zTGJe7+q4J+N4cheDP1zbtxnr+uEJzi8KgHA4esXiF
         YRlgl2iOQGa1E9yYc+4DXjkz+m5oCRiGh8A5RAwqn7AlLjQFiYaybTo9aZcUOVQjmZZC
         TXFvi5x4cPg8xhe8vj1ejI90jIuDkdd1V1RHDfvpwbrW6CujZIIFnuvQpJ5sLPX8+bMA
         fnSA==
X-Gm-Message-State: AOJu0YxZQV/G0Mzd1mzEgnPePi+nhBY+dlF3gNP9LKfquqqfHNnQN6nr
	zIzUvmLVA4hzs1aUsLhrI/mXIZQQSEfIAfIc5EcgHe7DerYLf2sD
X-Gm-Gg: ASbGncsp9xa4q7YHPk9SqPt1tgHkzojHPcNhxgm47yO9YssVGRHxtA5Fk6+AIDrNzHX
	rfShuVQL300rcjUfw5b3cI+MWMvv/Wx8mnIuszv/TwSEE5s9Nr4nVgbiMP+Tn0gVxgLfjFdX1/E
	zxgsEqJtb9RiR56BQoICfHdnHg0d/T6bT9fTXzcPD7f06DuTo+n7ueXJMGAGNqNusg4VQhJBMEW
	YqqgkHwQGnVrBDI7WcW+S6MHBjlVTejy0A3nOx/7BWH6Iv3jDhDPv1M8B8iyr/Ts15aGTSeBpFp
	4zFrPoKeOG3Lt0H+sxacNbDM63tWnyQCpYq2rE7NmKd9HnD7H68tsaGFVYFq1i4=
X-Google-Smtp-Source: AGHT+IH8LqclAX4pm5y/TF65XUMJou+vFLKTtpfoRcKApjUHiDe5/ugvIW0I6bNTcdRuXd0IKR/9Bg==
X-Received: by 2002:a05:620a:2b48:b0:7bd:bafc:32a0 with SMTP id af79cd13be357-7c08a9a616bmr504931585a.23.1739630967877;
        Sat, 15 Feb 2025 06:49:27 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c86ffe3sm322389785a.104.2025.02.15.06.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 06:49:27 -0800 (PST)
Date: Sat, 15 Feb 2025 09:49:26 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 petrm@nvidia.com, 
 stfomichev@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <67b0a976ba5fd_36e344294b1@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250214234631.2308900-4-kuba@kernel.org>
References: <20250214234631.2308900-1-kuba@kernel.org>
 <20250214234631.2308900-4-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 3/3] selftests: drv-net: add a simple TSO test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Add a simple test for TSO. Send a few MB of data and check device
> stats to verify that the device was performing segmentation.
> Do the same thing over a few tunnel types.
> 
> Injecting GSO packets directly would give us more ability to test
> corner cases, but perhaps starting simple is good enough?
> 
>   # ./ksft-net-drv/drivers/net/hw/tso.py
>   # Detected qstat for LSO wire-packets
>   KTAP version 1
>   1..14
>   ok 1 tso.ipv4 # SKIP Test requires IPv4 connectivity
>   ok 2 tso.vxlan4_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 3 tso.vxlan6_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 4 tso.vxlan_csum4_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 5 tso.vxlan_csum6_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 6 tso.gre4_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 7 tso.gre6_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 8 tso.ipv6
>   ok 9 tso.vxlan4_ipv6
>   ok 10 tso.vxlan6_ipv6
>   ok 11 tso.vxlan_csum4_ipv6
>   ok 12 tso.vxlan_csum6_ipv6
>   ok 13 tso.gre4_ipv6
>   ok 14 tso.gre6_ipv6
>   # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:7 error:0
> 
> Note that the test currently depends on the driver reporting
> the LSO count via qstat, which appears to be relatively rare
> (virtio, cisco/enic, sfc/efc; but virtio needs host support).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - lower max noise
>  - mention header overhead in the comment
>  - fix the basic v4 TSO feature name
>  - also run a stream with just GSO partial for tunnels
> v1: https://lore.kernel.org/20250213003454.1333711-4-kuba@kernel.org
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |   1 +
>  tools/testing/selftests/drivers/net/hw/tso.py | 234 ++++++++++++++++++
>  2 files changed, 235 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/tso.py
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 21ba64ce1e34..ae783e18be83 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -15,6 +15,7 @@ TEST_PROGS = \
>  	nic_performance.py \
>  	pp_alloc_fail.py \
>  	rss_ctx.py \
> +	tso.py \
>  	#
>  
>  TEST_FILES := \
> diff --git a/tools/testing/selftests/drivers/net/hw/tso.py b/tools/testing/selftests/drivers/net/hw/tso.py
> new file mode 100755
> index 000000000000..346b257f7160
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/tso.py
> @@ -0,0 +1,234 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +"""Run the tools/testing/selftests/net/csum testsuite."""
> +
> +import fcntl
> +import socket
> +import struct
> +import termios
> +import time
> +
> +from lib.py import ksft_pr, ksft_run, ksft_exit, KsftSkipEx, KsftXfailEx
> +from lib.py import ksft_eq, ksft_ge, ksft_lt
> +from lib.py import EthtoolFamily, NetdevFamily, NetDrvEpEnv
> +from lib.py import bkg, cmd, defer, ethtool, ip, rand_port, wait_port_listen
> +
> +
> +def sock_wait_drain(sock, max_wait=1000):
> +    """Wait for all pending write data on the socket to get ACKed."""
> +    for _ in range(max_wait):
> +        one = b'\0' * 4
> +        outq = fcntl.ioctl(sock.fileno(), termios.TIOCOUTQ, one)
> +        outq = struct.unpack("I", outq)[0]
> +        if outq == 0:
> +            break
> +        time.sleep(0.01)
> +    ksft_eq(outq, 0)
> +
> +
> +def tcp_sock_get_retrans(sock):
> +    """Get the number of retransmissions for the TCP socket."""
> +    info = sock.getsockopt(socket.SOL_TCP, socket.TCP_INFO, 512)
> +    return struct.unpack("I", info[100:104])[0]
> +
> +
> +def run_one_stream(cfg, ipv4, remote_v4, remote_v6, should_lso):
> +    cfg.require_cmd("socat", remote=True)
> +
> +    port = rand_port()
> +    listen_cmd = f"socat -{cfg.addr_ipver} -t 2 -u TCP-LISTEN:{port},reuseport /dev/null,ignoreeof"
> +
> +    with bkg(listen_cmd, host=cfg.remote) as nc:
> +        wait_port_listen(port, host=cfg.remote)
> +
> +        if ipv4:
> +            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
> +            sock.connect((remote_v4, port))
> +        else:
> +            sock = socket.socket(socket.AF_INET6, socket.SOCK_STREAM)
> +            sock.connect((remote_v6, port))
> +
> +        # Small send to make sure the connection is working.
> +        sock.send("ping".encode())
> +        sock_wait_drain(sock)
> +
> +        # Send 4MB of data, record the LSO packet count.
> +        qstat_old = cfg.netnl.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
> +        buf = b"0" * 1024 * 1024 * 4
> +        sock.send(buf)
> +        sock_wait_drain(sock)
> +        qstat_new = cfg.netnl.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
> +
> +        # No math behind the 10 here, but try to catch cases where
> +        # TCP falls back to non-LSO.
> +        ksft_lt(tcp_sock_get_retrans(sock), 10)
> +        sock.close()
> +
> +        # Check that at least 90% of the data was sent as LSO packets.
> +        # System noise may cause false negatives. Also header overheads
> +        # will add up to 5% of extra packes... The check is best effort.
> +        total_lso_wire  = len(buf) * 0.90 // cfg.dev["mtu"]
> +        total_lso_super = len(buf) * 0.90 // cfg.dev["tso_max_size"]
> +        if should_lso:
> +            if cfg.have_stat_super_count:
> +                ksft_ge(qstat_new['tx-hw-gso-packets'] -
> +                        qstat_old['tx-hw-gso-packets'],
> +                        total_lso_super,
> +                        comment="Number of LSO super-packets with LSO enabled")
> +            if cfg.have_stat_wire_count:
> +                ksft_ge(qstat_new['tx-hw-gso-wire-packets'] -
> +                        qstat_old['tx-hw-gso-wire-packets'],
> +                        total_lso_wire,
> +                        comment="Number of LSO wire-packets with LSO enabled")
> +        else:
> +            if cfg.have_stat_super_count:
> +                ksft_lt(qstat_new['tx-hw-gso-packets'] -
> +                        qstat_old['tx-hw-gso-packets'],
> +                        15, comment="Number of LSO super-packets with LSO disabled")
> +            if cfg.have_stat_wire_count:
> +                ksft_lt(qstat_new['tx-hw-gso-wire-packets'] -
> +                        qstat_old['tx-hw-gso-wire-packets'],
> +                        500, comment="Number of LSO wire-packets with LSO disabled")
> +
> +
> +def build_tunnel(cfg, outer_ipv4, tun_info):
> +    local_v4  = NetDrvEpEnv.nsim_v4_pfx + "1"
> +    local_v6  = NetDrvEpEnv.nsim_v6_pfx + "1"
> +    remote_v4 = NetDrvEpEnv.nsim_v4_pfx + "2"
> +    remote_v6 = NetDrvEpEnv.nsim_v6_pfx + "2"
> +
> +    if outer_ipv4:
> +        local_addr  = cfg.v4
> +        remote_addr = cfg.remote_v4
> +    else:
> +        local_addr  = cfg.v6
> +        remote_addr = cfg.remote_v6
> +
> +    tun_type = tun_info[0]
> +    tun_arg  = tun_info[2]
> +    ip(f"link add {tun_type}-ksft type {tun_type} {tun_arg} local {local_addr} remote {remote_addr} dev {cfg.ifname}")
> +    defer(ip, f"link del {tun_type}-ksft")
> +    ip(f"link set dev {tun_type}-ksft up")
> +    ip(f"addr add {local_v4}/24 dev {tun_type}-ksft")
> +    ip(f"addr add {local_v6}/64 dev {tun_type}-ksft")
> +
> +    ip(f"link add {tun_type}-ksft type {tun_type} {tun_arg} local {remote_addr} remote {local_addr} dev {cfg.remote_ifname}",
> +        host=cfg.remote)
> +    defer(ip, f"link del {tun_type}-ksft", host=cfg.remote)
> +    ip(f"link set dev {tun_type}-ksft up", host=cfg.remote)
> +    ip(f"addr add {remote_v4}/24 dev {tun_type}-ksft", host=cfg.remote)
> +    ip(f"addr add {remote_v6}/64 dev {tun_type}-ksft", host=cfg.remote)
> +
> +    return remote_v4, remote_v6
> +
> +
> +def test_builder(name, cfg, ipv4, feature, tun=None, inner_ipv4=None):
> +    """Construct specific tests from the common template."""
> +    def f(cfg):
> +        if ipv4:
> +            cfg.require_v4()
> +        else:
> +            cfg.require_v6()
> +
> +        if not cfg.have_stat_super_count and \
> +           not cfg.have_stat_wire_count:
> +            raise KsftSkipEx(f"Device does not support LSO queue stats")
> +
> +        if tun:
> +            remote_v4, remote_v6 = build_tunnel(cfg, ipv4, tun)
> +        else:
> +            remote_v4 = cfg.remote_v4
> +            remote_v6 = cfg.remote_v6
> +
> +        tun_partial = tun and tun[1]
> +        has_gso_partial = tun and 'tx-gso-partial' in cfg.features
> +
> +        # First test without the feature enabled.
> +        ethtool(f"-K {cfg.ifname} {feature} off")
> +        if has_gso_partial:
> +            ethtool(f"-K {cfg.ifname} tx-gso-partial off")
> +        run_one_stream(cfg, ipv4, remote_v4, remote_v6, should_lso=False)
> +
> +        # Now test with the feature enabled.
> +        # For compatible tunnels only - just GSO partial, not specific feature.
> +        if has_gso_partial:
> +            ethtool(f"-K {cfg.ifname} tx-gso-partial on")
> +            run_one_stream(cfg, ipv4, remote_v4, remote_v6,
> +                           should_lso=tun_partial)
> +
> +        # Full feature enabled.
> +        if feature in cfg.features:
> +            ethtool(f"-K {cfg.ifname} {feature} on")
> +            run_one_stream(cfg, ipv4, remote_v4, remote_v6, should_lso=True)
> +        else:
> +            raise KsftXfailEx(f"Device does not support {feature}")
> +
> +    if tun:
> +        name += ("4" if inner_ipv4 else "6") + "_"
> +    if ipv4:
> +        f.__name__ = name + "ipv4"
> +    else:
> +        f.__name__ = name + "ipv6"
> +    return f
> +
> +
> +def query_nic_features(cfg) -> None:
> +    """Query and cache the NIC features."""
> +    cfg.features = set()
> +
> +    cfg.have_stat_super_count = False
> +    cfg.have_stat_wire_count = False
> +
> +    features = cfg.ethnl.features_get({"header": {"dev-index": cfg.ifindex}})
> +    for f in features["active"]["bits"]["bit"]:
> +        cfg.features.add(f["name"])
> +    for f in features["hw"]["bits"]["bit"]:
> +        cfg.features.add(f["name"])
> +
> +    stats = cfg.netnl.qstats_get({"ifindex": cfg.ifindex}, dump=True)
> +    if stats:
> +        if 'tx-hw-gso-packets' in stats[0]:
> +            ksft_pr("Detected qstat for LSO super-packets")
> +            cfg.have_stat_super_count = True
> +        if 'tx-hw-gso-wire-packets' in stats[0]:
> +            ksft_pr("Detected qstat for LSO wire-packets")
> +            cfg.have_stat_wire_count = True
> +
> +
> +def main() -> None:
> +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
> +        cfg.ethnl = EthtoolFamily()
> +        cfg.netnl = NetdevFamily()
> +
> +        query_nic_features(cfg)
> +
> +        test_info = (
> +            # name,    skip v4/v6  ethtool_feature              tun:(type,    partial, args)
> +            ("",            False, "tx-tcp-segmentation",           None),
> +            ("",            True,  "tx-tcp6-segmentation",          None),
> +            ("vxlan",       None,  "tx-udp_tnl-segmentation",       ("vxlan",  True,  "id 100 dstport 4789 noudpcsum")),
> +            ("vxlan_csum",  None,  "tx-udp_tnl-csum-segmentation",  ("vxlan",  False, "id 100 dstport 4789 udpcsum")),
> +            ("gre",         False, "tx-gre-segmentation",           ("ipgre",  False,  "")),
> +            ("gre",         True,  "tx-gre-segmentation",           ("ip6gre", False,  "")),
> +        )
> +
> +        cases = []
> +        for outer_ipv4 in [True, False]:
> +            for info in test_info:
> +                # Skip if test which only works for a specific IP version
> +                if outer_ipv4 == info[1]:

Only if need to respin:

using ternary True, False, None for skip_ipv6, skip_ipv4, skip_neither
is a bit non-obvious. Use strings?

