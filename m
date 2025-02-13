Return-Path: <netdev+bounces-166113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A7AA348DF
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5D5167C82
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A26B155326;
	Thu, 13 Feb 2025 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXIozDDu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB12185E4A
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462577; cv=none; b=lorNXuc/Gw0cH/z9dC+5Q/VLXxc4MhkF5p7XaWUcSxipdkKknbgKYoUDIvH/20i7Zvb3iQS8lBPW79FgqbYSSTeGbdTzwz9YFU+LhyEu9i5u3MqYZCbh0DV5s4v1edfxeKOfqOUCFAGaqavml16yQ2Li+fAO8kxdiCM7q1vQTuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462577; c=relaxed/simple;
	bh=z+c5wx1HGA0X8EMHqANLAy4C9vpA62QggA968LKXS8s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nAIqR3icNrSi0JsGHI1viZ50XuHZTa4ugh0I0z9lO+/RuWN5GLzdZ9VCRYOwEDr+6gE2qGvctp2VLoBypkduTdk4WNMd6wAuVYT9yHwm2ATHrucflad7fz8Z3+WajB7SdkfnskAtDlsgnbuN8ieP05vNpbLnhbuel3pNH8+wVBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXIozDDu; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46c8474d8f6so8628981cf.3
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 08:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739462574; x=1740067374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfFs5rwaBMMKYNeyC2uP2J/AU5nD+CW3R0r3l+ThPQI=;
        b=VXIozDDub4/o5WuJ3GD2e404/sBvZpssDyZg3NL05oxHNdSzIV1C4vthKqlK/CJ7+z
         f1OpuI4Nh0Gzq+1jO4/Q6DbIuWulbO7UiOCaD1iueCLOeJ+CClQFY9bUfTnAB+YBhGjv
         zyiKYUccNNJj7jbfdbma7wCZNaAWMqUa28HQJpbGwY8XKMW0H/AmO1LPLAxsjablepsS
         5tD2Iin6LFd3RWxUwXVZPK4kADp/DWbA/u6lMhvGu5tDOD77gkfL3JKoDNZESaBqi21i
         T2RS41xgYwyz1ZeJIE1HP0vLTM1wedy/iLAylRIek2+cBz5x05F2rOG7/bYyM1vk58lN
         y5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739462574; x=1740067374;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jfFs5rwaBMMKYNeyC2uP2J/AU5nD+CW3R0r3l+ThPQI=;
        b=nlxniggQ09QP433GMsLRdUPrVzQXxaP/6C0ytNEgodaa00hO65VjBnNbSrTd1bLLHD
         dGXSI2FAXtkjVfrJ3qyW6oOa9SGJ/wdm+J8KIDhS/urBl8k+AiO5GgGK6sdd/MDd3B5B
         6ID/t535+NQDXfj+K1Rid0lZvWadnVT8eZydMCaN6MGwedOyLDd60CD8/i+7G6WRrBww
         IoKJDflEJw/yJObRYoUGXY3wuduRDmJgWi6NpenMyysdLR1DzZy/BLfNeAx057fauu7z
         f/xMpXU7XN4I/n8+LrHXFfHWXkan8PjsG6Cof+mOjhnvmK/nt1+0vAGBdV0OzVfuM5pU
         ldXw==
X-Forwarded-Encrypted: i=1; AJvYcCWmEs+7Y5gKv0brI/f9EitINiNBBYM1MDWchSn4XlC96oK+rA6eRIdp+gouJ9uh1fLdrFdrs+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx30ynOeiAWaZrkiu/w+LsVmgazbkROD3EbzbeRsykwuJXAwI8m
	SSi0iI2i94U54P8u75zBWU25DdxLKvbZ4a5bwBgtLrw30uWUn6bX
X-Gm-Gg: ASbGncvpUljO4gi81LxLBZKEnEohpFKyMlwBcsvYVMew8y3mdPWv0hNJC1GKRtqFTHS
	8HEuE1JCpXd59VYsftACw2jGEA7bFaT1jCcIPHxpL5jlA5mj5dtFGYDChEmth1o7js2DlXbZwfm
	F3scUHUdO6YIs3La7/IM0B0Qe/TieHD9f7i1oWY5uIuxjjg01oEWcs+GxGmcBkHMAninhi9JLv4
	8C2XLM8B/yMgo5cjkeJl6MHC6p9vcu0WiJ3M+ac11I/MnkKhwipfnCDBQifYLLzGO/bkdtjVH9U
	mvgSSmW4m2hraWC5x7NdrRG2EfF3Yfs24b5fr9jdMQNgktI2KNe70lNiUZE0D/Y=
X-Google-Smtp-Source: AGHT+IEgZPfvDutxb0Z1f0jXQLhpUUmU8CDPyxh1YuDy0XWjjaCoExUId7uO6O7S+jo5du1liqyycA==
X-Received: by 2002:a05:622a:181a:b0:470:1fc6:f821 with SMTP id d75a77b69052e-471b06edc47mr109695511cf.35.1739462573733;
        Thu, 13 Feb 2025 08:02:53 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2a11e77sm9249821cf.29.2025.02.13.08.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:02:53 -0800 (PST)
Date: Thu, 13 Feb 2025 11:02:51 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemb@google.com, 
 shuah@kernel.org, 
 petrm@nvidia.com
Message-ID: <67ae17abc8d98_24be452942f@willemb.c.googlers.com.notmuch>
In-Reply-To: <Z61dwqIp7PD_-m0B@mini-arch>
References: <20250213003454.1333711-1-kuba@kernel.org>
 <20250213003454.1333711-4-kuba@kernel.org>
 <Z61dwqIp7PD_-m0B@mini-arch>
Subject: Re: [PATCH net-next 3/3] selftests: drv-net: add a simple TSO test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stanislav Fomichev wrote:
> On 02/12, Jakub Kicinski wrote:
> > Add a simple test for TSO. Send a few MB of data and check device
> > stats to verify that the device was performing segmentation.
> > Do the same thing over a few tunnel types.
> > 
> > Injecting GSO packets directly would give us more ability to test
> > corner cases, but perhaps starting simple is good enough?
> > 
> >   # ./ksft-net-drv/drivers/net/hw/tso.py
> >   # Detected qstat for LSO wire-packets
> >   KTAP version 1
> >   1..14
> >   ok 1 tso.ipv4 # SKIP Test requires IPv4 connectivity
> >   ok 2 tso.vxlan4_ipv4 # SKIP Test requires IPv4 connectivity
> >   ok 3 tso.vxlan6_ipv4 # SKIP Test requires IPv4 connectivity
> >   ok 4 tso.vxlan_csum4_ipv4 # SKIP Test requires IPv4 connectivity
> >   ok 5 tso.vxlan_csum6_ipv4 # SKIP Test requires IPv4 connectivity
> >   ok 6 tso.gre4_ipv4 # SKIP Test requires IPv4 connectivity
> >   ok 7 tso.gre6_ipv4 # SKIP Test requires IPv4 connectivity
> >   ok 8 tso.ipv6
> >   ok 9 tso.vxlan4_ipv6
> >   ok 10 tso.vxlan6_ipv6
> >   ok 11 tso.vxlan_csum4_ipv6
> >   ok 12 tso.vxlan_csum6_ipv6
> >   ok 13 tso.gre4_ipv6
> >   ok 14 tso.gre6_ipv6
> >   # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:7 error:0
> > 
> > Note that the test currently depends on the driver reporting
> > the LSO count via qstat, which appears to be relatively rare
> > (virtio, cisco/enic, sfc/efc; but virtio needs host support).
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> >  .../testing/selftests/drivers/net/hw/Makefile |   1 +
> >  tools/testing/selftests/drivers/net/hw/tso.py | 226 ++++++++++++++++++
> >  2 files changed, 227 insertions(+)
> >  create mode 100755 tools/testing/selftests/drivers/net/hw/tso.py
> > 
> > diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> > index 21ba64ce1e34..ae783e18be83 100644
> > --- a/tools/testing/selftests/drivers/net/hw/Makefile
> > +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> > @@ -15,6 +15,7 @@ TEST_PROGS = \
> >  	nic_performance.py \
> >  	pp_alloc_fail.py \
> >  	rss_ctx.py \
> > +	tso.py \
> >  	#
> >  
> >  TEST_FILES := \
> > diff --git a/tools/testing/selftests/drivers/net/hw/tso.py b/tools/testing/selftests/drivers/net/hw/tso.py
> > new file mode 100755
> > index 000000000000..ee3e207d85b3
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/hw/tso.py
> > @@ -0,0 +1,226 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +"""Run the tools/testing/selftests/net/csum testsuite."""
> > +
> > +import fcntl
> > +import socket
> > +import struct
> > +import termios
> > +import time
> > +
> > +from lib.py import ksft_pr, ksft_run, ksft_exit, KsftSkipEx, KsftXfailEx
> > +from lib.py import ksft_eq, ksft_ge, ksft_lt
> > +from lib.py import EthtoolFamily, NetdevFamily, NetDrvEpEnv
> > +from lib.py import bkg, cmd, defer, ethtool, ip, rand_port, wait_port_listen
> > +
> > +
> > +def sock_wait_drain(sock, max_wait=1000):
> > +    """Wait for all pending write data on the socket to get ACKed."""
> > +    for _ in range(max_wait):
> > +        one = b'\0' * 4
> > +        outq = fcntl.ioctl(sock.fileno(), termios.TIOCOUTQ, one)
> > +        outq = struct.unpack("I", outq)[0]
> > +        if outq == 0:
> > +            break
> > +        time.sleep(0.01)
> > +    ksft_eq(outq, 0)
> > +
> > +
> > +def tcp_sock_get_retrans(sock):
> > +    """Get the number of retransmissions for the TCP socket."""
> > +    info = sock.getsockopt(socket.SOL_TCP, socket.TCP_INFO, 512)
> > +    return struct.unpack("I", info[100:104])[0]
> > +
> > +
> > +def run_one_stream(cfg, ipv4, remote_v4, remote_v6, should_lso):
> > +    cfg.require_cmd("socat", remote=True)
> > +
> > +    port = rand_port()
> > +    listen_cmd = f"socat -{cfg.addr_ipver} -t 2 -u TCP-LISTEN:{port},reuseport /dev/null,ignoreeof"
> > +
> > +    with bkg(listen_cmd, host=cfg.remote) as nc:
> > +        wait_port_listen(port, host=cfg.remote)
> > +
> > +        if ipv4:
> > +            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
> > +            sock.connect((remote_v4, port))
> > +        else:
> > +            sock = socket.socket(socket.AF_INET6, socket.SOCK_STREAM)
> > +            sock.connect((remote_v6, port))
> > +
> > +        # Small send to make sure the connection is working.
> > +        sock.send("ping".encode())
> > +        sock_wait_drain(sock)
> > +
> > +        # Send 4MB of data, record the LSO packet count.
> > +        qstat_old = cfg.netnl.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
> > +        buf = b"0" * 1024 * 1024 * 4
> > +        sock.send(buf)
> > +        sock_wait_drain(sock)
> > +        qstat_new = cfg.netnl.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
> > +
> > +        # No math behind the 10 here, but try to catch cases where
> > +        # TCP falls back to non-LSO.
> > +        ksft_lt(tcp_sock_get_retrans(sock), 10)
> > +        sock.close()
> > +
> > +        # Check that at least 90% of the data was sent as LSO packets.
> > +        # System noise may cause false negatives, it is what it is.
> > +        total_lso_wire  = len(buf) * 0.90 // cfg.dev["mtu"]
> > +        total_lso_super = len(buf) * 0.90 // cfg.dev["tso_max_size"]

Besides noise this also includes the payload to wire length with headers
fudge factor, right?

> > +        if should_lso:
> > +            if cfg.have_stat_super_count:
> > +                ksft_ge(qstat_new['tx-hw-gso-packets'] -
> > +                        qstat_old['tx-hw-gso-packets'],
> > +                        total_lso_super,
> > +                        comment="Number of LSO super-packets with LSO enabled")
> > +            if cfg.have_stat_wire_count:
> > +                ksft_ge(qstat_new['tx-hw-gso-wire-packets'] -
> > +                        qstat_old['tx-hw-gso-wire-packets'],
> > +                        total_lso_wire,
> > +                        comment="Number of LSO wire-packets with LSO enabled")
> > +        else:

