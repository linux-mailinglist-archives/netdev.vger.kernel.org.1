Return-Path: <netdev+bounces-165779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2E5A3359C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 03:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7593A6D3C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78FA84D29;
	Thu, 13 Feb 2025 02:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0Fv6Wex"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B24023BE
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 02:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739414982; cv=none; b=T8KJBozJxG/pf5F+Jk0agmPDvUe5ETCu65ivQQx0VIWUNVnP9Sij9NMDLAd8BP7t989nDnBwHKx6I76mX4T/pGAA6o2JqXHz8nIqY8h3jGyH8eooLHeK7llVx48UiaGbMDQIALTZk57wah/umKk2kBrr5sjYIR6YCiP+FCvlfUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739414982; c=relaxed/simple;
	bh=nQnPifyQxuZlzS5WKXvSp79KAX5UYBwkT96N7fLn6Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/+P1PHXqA+bxfYnmHyE7+3ySuNQtHMd6SF+Dl9DLeOODT1cJTsU1Sb5x6w9vkYNzBGoYoGoeoF70o8bCwx9r6MqD1XNj2KG9T56Dc8844DA7Djgxz4XGgFnQKzT6M/xc0tv7BJ2EEukUYbeWu10q5JN3ZLCZdr+m3uG7V9cMFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0Fv6Wex; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f818a980cso4667235ad.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 18:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739414980; x=1740019780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BHkj5LuZJbHVf+wpbuA8W2CHAUmle19CuHcBP9FGNEU=;
        b=Q0Fv6Wexu2dEqnheXRXK0yTevB2KUTJ2Wl0sIxpH5Ds/2lORu+Jm+T1SbpnXf1AZRz
         ks0G+SWdPrqWLISAxDpdr/LzZSie2vPb0CLf4e/0nP+LfzHhYFEkVmEsfZTbGgo5Kjfk
         u6M5BJPFIF3xtHOjCZY3hB81GMWEHe/BzOqq0D5Sm5dqNU5HBJ2Y3tZGWTo86z32jJL0
         ARNoXdVZbfw9VhruJwl/Tss75Q1rojwItWJLH4Pib+Y1Z9qCwQ8UPKvl6VsIeNTWDVgD
         W+Z+RnnS/p+Ai8NRNNBnBCVG/riFi4R/7UPEGyXE1JDoH+1FRchkAf1+rqkgraM7K++m
         IP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739414980; x=1740019780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHkj5LuZJbHVf+wpbuA8W2CHAUmle19CuHcBP9FGNEU=;
        b=Rn/GtfyNxENLyMJGEVQ/mC9RWZCv7dBSCHiG8gqIgqdaXv8nrOKbbYowbUegSz4gtK
         zynUxFNIze645MpnSqFfwHnvoGQ5ZgmLJ5iYaukH783a/pqdVIwfVT+xC/PwqmaPavpE
         cmHzVeQ5EXJ+UFMXHZ4KFc/wda7VeLxfiT/tvN1lR63b59zP3qR2T0bLuq24aAcVjibU
         A/3AzeNOGVS7Z27JNXynEp7kBElIcgwvHPdUT0MQGQGvhDburpKC5z9MzTkNN9gm88Q4
         zseUGpYodj5hgyvcqpk3WCKT+EZsQuteqDxVcouVRc/OwaJFRsm8hfpmaJQZunP7bvT7
         Il6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbOVimZtZLhHsMAX7hwP4m9OBQCZyQCiDbwrVwmPKRf7PI6IZEWfjwdaP19hK0INSYrQKz9fU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5G9WlGX1f5ZtMqe9rfKNWsgVDY6POEhv7bEQoy9gk1SL64sW8
	/UMbOpPTNSAVfgOgWUOT5jYBh7g2nXX/qEImJoTBMBiS2yTCVSU=
X-Gm-Gg: ASbGnculR+MEQUbS/nCiuyONRftLxwawhN5ONGgMCKRbQJFwXk1tPiLQTGkPl8pU+8e
	5YOppP6N7WubtzBgznmUy9gtZiUSNovHjSCf/xZSsZ4deTQXlojqp48utbIVtxkMKa3D6r4Pk7f
	Eq7OBVUkMiifTEj/fNPhOnN2pYP8bhx4SB9BFXB4wKauZay3N9vi3XBMUMRb+n/z4Z7PO1gc5uY
	Vc2ucpfIkM+F31C3dioXj+SVher+y6h9PG6NaOs+yy/2i4t3rp3hAiIM5YPhrNnbA01YOg+gCFG
	j/ApL5PVD3htuCI=
X-Google-Smtp-Source: AGHT+IHe81wuCBjltBhJrrghuEs9AnQRy31VYro069ReJgK8obWamF5pmsT6IE7LH9cHKvEzdld31Q==
X-Received: by 2002:a05:6a21:618f:b0:1e1:afd3:bbfc with SMTP id adf61e73a8af0-1ee5c7339d2mr10379397637.3.1739414980111;
        Wed, 12 Feb 2025 18:49:40 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73242761676sm169917b3a.142.2025.02.12.18.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 18:49:39 -0800 (PST)
Date: Wed, 12 Feb 2025 18:49:38 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	willemb@google.com, shuah@kernel.org, petrm@nvidia.com
Subject: Re: [PATCH net-next 3/3] selftests: drv-net: add a simple TSO test
Message-ID: <Z61dwqIp7PD_-m0B@mini-arch>
References: <20250213003454.1333711-1-kuba@kernel.org>
 <20250213003454.1333711-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213003454.1333711-4-kuba@kernel.org>

On 02/12, Jakub Kicinski wrote:
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
>  .../testing/selftests/drivers/net/hw/Makefile |   1 +
>  tools/testing/selftests/drivers/net/hw/tso.py | 226 ++++++++++++++++++
>  2 files changed, 227 insertions(+)
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
> index 000000000000..ee3e207d85b3
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/tso.py
> @@ -0,0 +1,226 @@
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
> +        # System noise may cause false negatives, it is what it is.
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

[..]

> +            if cfg.have_stat_super_count:
> +                ksft_lt(qstat_new['tx-hw-gso-packets'] -
> +                        qstat_old['tx-hw-gso-packets'],
> +                        100, comment="Number of LSO super-packets with LSO disabled")
> +            if cfg.have_stat_wire_count:
> +                ksft_lt(qstat_new['tx-hw-gso-wire-packets'] -
> +                        qstat_old['tx-hw-gso-wire-packets'],
> +                        1000, comment="Number of LSO wire-packets with LSO disabled")

Why do you expect there to be some noise (100/1000) with the feature
disabled?

