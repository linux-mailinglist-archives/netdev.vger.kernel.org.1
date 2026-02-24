Return-Path: <netdev+bounces-260626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id q8vwJVXrnWngSgQAu9opvQ
	(envelope-from <netdev+bounces-260626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 19:17:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADE518B2ED
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 19:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC0BA310CF28
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79B02C1585;
	Tue, 24 Feb 2026 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvSqG5X/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241772BD012
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771956636; cv=none; b=eoH1plhw5fD2+d3UPtQly78o3McX5gWLVwXTAP/NJ3neM7kiB+ks7ICtZhQSl/DE1o3QQk6kzb81SN+C3vnXJe7EoBP9rPuj7tUg8taWNfuzv9ylYMMiPfbHBE5tp8H93Byke6w/pjA0R/COhpxt8agyZX5ltFW/jJv+vAefcjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771956636; c=relaxed/simple;
	bh=rGFIzZzH3dmbkld5GRkauQMh/HRTh9712CmQjHFkRjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lq7D0Kif+PTx5s+83ON7FWRDSRo1uPhBz0XReLeR7ITRna1HvrC165E+CRFAb/YISPTtE6Uq1r8ue2dm1yAAZejhOO6OBWOVtkxCo2Q8e3ET79SsqfQqjqaD27Z/v8KWYWkwb1HCtMfLA7gtXscM/oBADVpdPV8Gp4G+o8BcdCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvSqG5X/; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64ca423ad53so557273d50.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 10:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771956634; x=1772561434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhDtZovMyV1w4JDAIshQ8A/sqBQSikZh0fB1QgWojsU=;
        b=LvSqG5X/KDY5LjH7HXrvkPyupTtOdUriSBHZ055I8X2STVjxMQ1SeOS8v6Mipjmvqk
         W1I9CXNUzB5EekD4vlX1VMTVlEcmWZjWf/V1dTh8GkAydOLboEBHWANYsXZl1cRCZnmn
         svwBXt9Hf2UTSzqEK9erWTk2xiuepPs7yJ2tc/7CIczQRRg51EOQR1utvLX6NbOI8K7c
         HrqPFrU4ZcY0i80Al37h90JisVXUDCSz9WJ4FChYpdTxU0PZj/iLaL9cawhMVwxta7J9
         Klw5lWby5m2H1tWPGkhiNQh37hMt6csqGxKl+qMcaTCANNWZ/01JsEYRPmAZkXipzHSN
         RShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771956634; x=1772561434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhDtZovMyV1w4JDAIshQ8A/sqBQSikZh0fB1QgWojsU=;
        b=g7T0snBO7h9DdI6rnyWUF6TRQMgKXA7mBkOEo1kP1VPKyyjRJAGLcUGh5FoyIjeSvn
         SzqMYgOJeXY96Dr6FL2UknXxUIGusdv6c/GdL4UEP8L4y1bPgSmffdsUvybsO4gipdIh
         2zotPDJ74tDtuieT4o/TjUVCgyMXr9QjhOT657l1/qjdAJQHwZkvVTSXZDfK11Qcsw6j
         JoZ5jmiOwHp8Sn2RXz6X7IOWnaj7oWpVFpcTySTNj55YNB9+L9Tx0SHOqZM3eqgpmKp+
         ZVfQOq02H3+yMttc4MyGhDj5N2nhfTtx8ghhf+e7earuq2TKfZDBEkOnhHBxDXfuWALV
         OGpQ==
X-Gm-Message-State: AOJu0YyiW02lK1MPJ8BhyxyiGf3gDd97+toReCZTL8FsiL8uxtw2C/tA
	odkpdSmAl9afrRlZSQrv+YjW02e86ORuZtwO9b/lQ0bdKkERLtDLDFHe
X-Gm-Gg: ATEYQzyYo6jeXvgxL9Jp1R5wuJkII9NdpZQXwD5N/sNES/WC/kuKKV0QGV9EPlmlzLU
	UwdHX9sVfmbxmfhC/Cg7Ib7NIdlF6gTAzE7GJot26iBk8D9cQos1NV3r0vubAwgnD6RYQqOdy0a
	b0r8APkZ3xwJNcrbtyBSd7UDYdvBcttFCta+yvH5/XrF+Yzp49GiATrelkIIkzYTLx3Ss8XP2H1
	0UkZysggHtGPvV0ndt3hRGLPk8dZAL0JAYcOUYxj+tUan1LY9TJ1Wz6qV/ohxe5NiesMMCKWRT1
	7Ghq6gOSqKXivpc2Q0dd2VbwOX1TKCdqftNC7ed/JCv+XTIWtTSPhSPYcj4dNxyoS7Rq3gJzo35
	1IZodNDRWopFXDITy5rgXVoBVSsILTOyCetsCiwWwTmbfb1M0Lmwpp66U8sZCX2QTsCGp/iYlSR
	4zajoq99gKIYB0Xd5Xz8ORbg9tXrz1EBZMfW+G5mbZb3LdPrW2+OienjRH
X-Received: by 2002:a05:690e:2496:b0:63f:afdb:b936 with SMTP id 956f58d0204a3-64c787d70e3mr7901569d50.8.1771956634081;
        Tue, 24 Feb 2026 10:10:34 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c7a35b43csm4526601d50.11.2026.02.24.10.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:10:33 -0800 (PST)
Date: Tue, 24 Feb 2026 10:10:31 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Wei Wang <weibunny@fb.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net-next 3/9] selftests/net: Add env for container based
 tests
Message-ID: <aZ3pl177Q6+uJCCN@devvm11784.nha0.facebook.com>
References: <20260224002410.1553838-1-weibunny@fb.com>
 <20260224002410.1553838-4-weibunny@fb.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224002410.1553838-4-weibunny@fb.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,iogearbox.net];
	TAGGED_FROM(0.00)[bounces-260626-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lib.py:url,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Queue-Id: 3ADE518B2ED
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 04:24:03PM -0800, Wei Wang wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add an env NetDrvContEnv for container based selftests. This automates
> the setup of a netns, netkit pair with one inside the netns, and a BPF
> program that forwards skbs from the NETIF host inside the container.
> 
> Currently only netkit is used, but other virtual netdevs e.g. veth can
> be used too.
> 
> Expect netkit container datapath selftests to have a publicly routable
> IP prefix to assign to netkit in a container, such that packets will
> land on eth0. The BPF skb forward program will then forward such packets
> from the host netns to the container netns.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  .../testing/selftests/drivers/net/README.rst  |  19 ++
>  .../drivers/net/hw/lib/py/__init__.py         |   7 +-
>  .../selftests/drivers/net/lib/py/__init__.py  |   7 +-
>  .../selftests/drivers/net/lib/py/env.py       | 163 ++++++++++++++++++
>  4 files changed, 190 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
> index eb838ae94844..39370a83f238 100644
> --- a/tools/testing/selftests/drivers/net/README.rst
> +++ b/tools/testing/selftests/drivers/net/README.rst
> @@ -62,6 +62,25 @@ LOCAL_V4, LOCAL_V6, REMOTE_V4, REMOTE_V6
>  
>  Local and remote endpoint IP addresses.
>  
> +LOCAL_PREFIX_V4, LOCAL_PREFIX_V6
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Still not sure we want LOCAL_PREFIX_V4 here, since it is not supported?

> +
> +Local IP prefix/subnet which can be used to allocate extra IP addresses (for
> +network name spaces behind macvlan, veth, netkit devices). DUT must be
> +reachable using these addresses from the endpoint.
> +
> +  +-------------+        +----------------------------+
> +  | INIT NS     |        | TEST NS                    |
> +  | +---------+ |        | +------------------------+ |
> +  | | NETIF   | |  bpf   | | Netkit                 | |
> +  | |         |-|--------|>| nk_guest               | |
> +  | +---------+ |        | | {LOCAL_PREFIX_V6}::2:2 | |
> +  | +---------+ |        | +------------------------+ |
> +  | | Netkit  | |        +----------------------------+
> +  | | nk_host | |
> +  | +---------+ |
> +  +-------------+
> +

One thing I noticed when I tested this was the flow broke down when
NETIF's address happened to match LOCAL_PREFIX_V6. I didn't fully reason
through why this was the case, but maybe it's worth mentioning in the
docs here?

>  REMOTE_TYPE
>  ~~~~~~~~~~~
>  
> diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
> index d5d247eca6b7..022008249313 100644
> --- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
> +++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
> @@ -3,6 +3,7 @@
>  """
>  Driver test environment (hardware-only tests).
>  NetDrvEnv and NetDrvEpEnv are the main environment classes.
> +NetDrvContEnv extends NetDrvEpEnv with netkit container support.
>  Former is for local host only tests, latter creates / connects
>  to a remote endpoint. See NIPA wiki for more information about
>  running and writing driver tests.
> @@ -29,7 +30,7 @@ try:
>      from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
>          ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
>      from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner
> -    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv
> +    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
>  
>      __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev",
>                 "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
> @@ -44,8 +45,8 @@ try:
>                 "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
>                 "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
>                 "ksft_not_none", "ksft_not_none",
> -               "NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote",
> -               "Iperf3Runner"]
> +               "NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic",
> +               "Remote", "Iperf3Runner"]
>  except ModuleNotFoundError as e:
>      print("Failed importing `net` library from kernel sources")
>      print(str(e))
> diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
> index a18e21069f7a..6b55068d5370 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
> @@ -3,6 +3,7 @@
>  """
>  Driver test environment.
>  NetDrvEnv and NetDrvEpEnv are the main environment classes.
> +NetDrvContEnv extends NetDrvEpEnv with netkit container support.
>  Former is for local host only tests, latter creates / connects
>  to a remote endpoint. See NIPA wiki for more information about
>  running and writing driver tests.
> @@ -43,12 +44,12 @@ try:
>                 "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
>                 "ksft_not_none", "ksft_not_none"]
>  
> -    from .env import NetDrvEnv, NetDrvEpEnv
> +    from .env import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
>      from .load import GenerateTraffic, Iperf3Runner
>      from .remote import Remote
>  
> -    __all__ += ["NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote",
> -                "Iperf3Runner"]
> +    __all__ += ["NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic",
> +                "Remote", "Iperf3Runner"]
>  except ModuleNotFoundError as e:
>      print("Failed importing `net` library from kernel sources")
>      print(str(e))
> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
> index 41cc248ac848..857ae0f37516 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -1,13 +1,16 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> +import ipaddress
>  import os
>  import time
> +import json
>  from pathlib import Path
>  from lib.py import KsftSkipEx, KsftXfailEx
>  from lib.py import ksft_setup, wait_file
>  from lib.py import cmd, ethtool, ip, CmdExitFailure
>  from lib.py import NetNS, NetdevSimDev
>  from .remote import Remote
> +from . import bpftool, RtnlFamily, Netlink
>  
>  
>  class NetDrvEnvBase:
> @@ -289,3 +292,163 @@ class NetDrvEpEnv(NetDrvEnvBase):
>                  data.get('stats-block-usecs', 0) / 1000 / 1000
>  
>          time.sleep(self._stats_settle_time)
> +
> +
> +class NetDrvContEnv(NetDrvEpEnv):
> +    """
> +    Class for an environment with a netkit pair setup for forwarding traffic
> +    between the physical interface and a network namespace.
> +    +-------------+        +----------------------------+
> +    | INIT NS     |        | TEST NS                    |
> +    | +---------+ |        | +------------------------+ |
> +    | | NETIF   | |  bpf   | | Netkit                 | |
> +    | |         |-|--------|>| nk_guest               | |
> +    | +---------+ |        | | {LOCAL_PREFIX_V6}::2:2 | |
> +    | +---------+ |        | +------------------------+ |
> +    | | Netkit  | |        +----------------------------+
> +    | | nk_host | |
> +    | +---------+ |
> +    +-------------+
> +    """
> +
> +    def __init__(self, src_path, rxqueues=1, **kwargs):
> +        super().__init__(src_path, **kwargs)
> +
> +        self.netns = None
> +        self._nk_host_ifname = None
> +        self._nk_guest_ifname = None
> +        self._tc_clsact_added = False
> +        self._tc_attached = False
> +        self._bpf_prog_pref = None
> +        self._bpf_prog_id = None
> +        self._init_ns_attached = False

One problem with these attrs is that if super().__init__() fails
(NetDrvEpEnv.__init__()) then these will raise attribute errors in
__del__().

This can happen if NetDrvEpEnv.remote_remote_ifc() (for example) throws
an exception because it couldn't find the address the user configured.

One alternative to getattr() is moving these assignments before
super().__init__()?

Best,
Bobby

> +
> +        self.require_ipver("6")
> +        local_prefix = self.env.get("LOCAL_PREFIX_V6")
> +        if not local_prefix:
> +            raise KsftSkipEx("LOCAL_PREFIX_V6 required")
> +
> +        local_prefix = local_prefix.rstrip("/64").rstrip("::").rstrip(":")
> +        self.ipv6_prefix = f"{local_prefix}::"
> +        self.nk_host_ipv6 = f"{local_prefix}::2:1"
> +        self.nk_guest_ipv6 = f"{local_prefix}::2:2"
> +
> +        rtnl = RtnlFamily()
> +        rtnl.newlink(
> +            {
> +                "linkinfo": {
> +                    "kind": "netkit",
> +                    "data": {
> +                        "mode": "l2",
> +                        "policy": "forward",
> +                        "peer-policy": "forward",
> +                    },
> +                },
> +                "num-rx-queues": rxqueues,
> +            },
> +            flags=[Netlink.NLM_F_CREATE, Netlink.NLM_F_EXCL],
> +        )
> +
> +        all_links = ip("-d link show", json=True)
> +        netkit_links = [link for link in all_links
> +                        if link.get('linkinfo', {}).get('info_kind') == 'netkit'
> +                        and 'UP' not in link.get('flags', [])]
> +
> +        if len(netkit_links) != 2:
> +            raise KsftSkipEx("Failed to create netkit pair")
> +
> +        netkit_links.sort(key=lambda x: x['ifindex'])
> +        self._nk_host_ifname = netkit_links[1]['ifname']
> +        self._nk_guest_ifname = netkit_links[0]['ifname']
> +        self.nk_host_ifindex = netkit_links[1]['ifindex']
> +        self.nk_guest_ifindex = netkit_links[0]['ifindex']
> +
> +        self._setup_ns()
> +        self._attach_bpf()
> +
> +    def __del__(self):
> +        if self._tc_attached:
> +            cmd(f"tc filter del dev {self.ifname} ingress pref {self._bpf_prog_pref}")
> +            self._tc_attached = False
> +
> +        if self._tc_clsact_added:
> +            cmd(f"tc qdisc del dev {self.ifname} clsact")
> +            self._tc_clsact_added = False
> +
> +        if self._nk_host_ifname:
> +            cmd(f"ip link del dev {self._nk_host_ifname}")
> +            self._nk_host_ifname = None
> +            self._nk_guest_ifname = None
> +
> +        if self._init_ns_attached:
> +            cmd("ip netns del init", fail=False)
> +            self._init_ns_attached = False
> +
> +        if self.netns:
> +            del self.netns
> +            self.netns = None
> +
> +        super().__del__()
> +
> +    def _setup_ns(self):
> +        self.netns = NetNS()
> +        cmd("ip netns attach init 1")
> +        self._init_ns_attached = True
> +        ip("netns set init 0", ns=self.netns)
> +        ip(f"link set dev {self._nk_guest_ifname} netns {self.netns.name}")
> +        ip(f"link set dev {self._nk_host_ifname} up")
> +        ip(f"-6 addr add fe80::1/64 dev {self._nk_host_ifname} nodad")
> +        ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self._nk_host_ifname}")
> +
> +        ip("link set lo up", ns=self.netns)
> +        ip(f"link set dev {self._nk_guest_ifname} up", ns=self.netns)
> +        ip(f"-6 addr add fe80::2/64 dev {self._nk_guest_ifname}", ns=self.netns)
> +        ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self._nk_guest_ifname} nodad", ns=self.netns)
> +        ip(f"-6 route add default via fe80::1 dev {self._nk_guest_ifname}", ns=self.netns)
> +
> +    def _tc_ensure_clsact(self):
> +        qdisc = json.loads(cmd(f"tc -j qdisc show dev {self.ifname}").stdout)
> +        for q in qdisc:
> +            if q['kind'] == 'clsact':
> +                return
> +        cmd(f"tc qdisc add dev {self.ifname} clsact")
> +        self._tc_clsact_added = True
> +
> +    def _get_bpf_prog_ids(self):
> +        filter = json.loads(cmd(f"tc -j filter show dev {self.ifname} ingress").stdout)
> +        for bpf in filter:
> +            if 'options' not in bpf:
> +                continue
> +            if bpf['options']['bpf_name'].startswith('nk_forward.bpf'):
> +                return (bpf['pref'], bpf['options']['prog']['id'])
> +        if self._bpf_prog_pref is None:
> +            raise Exception("Failed to get BPF prog ID")
> +
> +    def _attach_bpf(self):
> +        bpf_obj = self.test_dir / "nk_forward.bpf.o"
> +        if not bpf_obj.exists():
> +            raise KsftSkipEx("BPF prog not found")
> +
> +        self._tc_ensure_clsact()
> +        cmd(f"tc filter add dev {self.ifname} ingress bpf obj {bpf_obj} sec tc/ingress direct-action")
> +        self._tc_attached = True
> +
> +        (self._bpf_prog_pref, self._bpf_prog_id) = self._get_bpf_prog_ids()
> +        prog_info = bpftool(f"prog show id {self._bpf_prog_id}", json=True)
> +        map_ids = prog_info.get("map_ids", [])
> +
> +        bss_map_id = None
> +        for map_id in map_ids:
> +            map_info = bpftool(f"map show id {map_id}", json=True)
> +            if map_info.get("name").endswith("bss"):
> +                bss_map_id = map_id
> +
> +        if bss_map_id is None:
> +            raise Exception("Failed to find .bss map")
> +
> +        ipv6_addr = ipaddress.IPv6Address(self.ipv6_prefix)
> +        ipv6_bytes = ipv6_addr.packed
> +        ifindex_bytes = self.nk_host_ifindex.to_bytes(4, byteorder='little')
> +        value = ipv6_bytes + ifindex_bytes
> +        value_hex = ' '.join(f'{b:02x}' for b in value)
> +        bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value hex {value_hex}")
> -- 
> 2.47.3
> 

