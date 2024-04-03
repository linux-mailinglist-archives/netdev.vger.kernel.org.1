Return-Path: <netdev+bounces-84264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597D88962C0
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 05:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8572C28762F
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 03:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E391BDD5;
	Wed,  3 Apr 2024 03:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="dVSIJEl9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644EB1BC44
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712113599; cv=none; b=Xim+CnZviU+DPSprAFmP2ds0e073fPF8BPcZ+5lCTAp99dVHG4CajJgmxHbc9tz4CEeOjPRdUHZydvx6/gvWMyDJqzz8ZQXvCv4x4LtxIIhtBmKd3Do6+H/iC8PBqNcnI5lSWi95xCw/Xvu+o54esmQ2XSQ/UdjBzEQRjVgfLKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712113599; c=relaxed/simple;
	bh=gfRBx+4Y9iM1sMe+Ux972EkdKEGN5qo3qtP6v7LkPqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+tMmUtW2ez95maDpJ9/S1EX1NTMs/ylbE7GqkvN0pIVkGE56jkdQXM1Mpw7ze8q7Xljk82a2Un2aGfj7I0dBD0wGbGyDHdOkTCX5rtmS53A1QCe7Fj0WN/nvfQySipAKzNlWCsmAp1wsFB+Y6wNYpUi9NBwzQsWiK4FfgBdIGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=dVSIJEl9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6b6f86975so3922335b3a.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 20:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1712113595; x=1712718395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nyLbNqsjlfVWogT37V/VMxi7jOiuzGi7H5ixOhAI8Og=;
        b=dVSIJEl9auDM3f0Cl1Z2PybMT7kASu5BfrzCygXL4DSGzs5wIsVmKPgJHqFQMoU3Ti
         /ODIdWy8vPHPWQAXQH10tfpZ697g+J2F1zLYbpEzbKR2sPuLpXEvhUqn6RBMibdsrktF
         kXtw6Ph/KFy0WlzeJSYwtapwhFnRFGtLviYPEzNR33CmtXSYs/qk6QxNxZ+UR5zkfDTY
         1Cs2EljpgzpaVtsoilxZcfHFR1U/JEChGlR/c/pbfguoB7mdGVuBqWJOYMN+fHet+rMR
         c5B8U7WtBNTTRSeP5tmn2QhGVBmuT8OCe7rkIuzFTwMzKqe/CvTCxKEZ3CzpFIvPegp4
         pljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712113595; x=1712718395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nyLbNqsjlfVWogT37V/VMxi7jOiuzGi7H5ixOhAI8Og=;
        b=G7y0zruEUwHbYQ+Wqr+6rDENUmmWK45Xi11ezAiSA4yc314zEd8R6evsk0rflJyP0G
         Y6+euc48mR8yASRK15RBUIrzY+jzWd7OIJJvWX/R34haA7RjbIeG7j3A06d/GjpVzgXU
         uz6edLqz0P84HLjSHdYKeF+IU96vWKKGZ9o287BnpvNh4KCNttVd+BiuVfbKcYf4w1HR
         C+aSjFBDBGJ1KxikePta0/VNumYviWfBKwLG+U8U0G3jin7cAOfbBSP3mOBXUZ3R6jiL
         Gs3KVR5W6Q9A7RSwYgkx7oDCc5BR/vt0Ey+5l8o0oWbi9yv9rvrhRaMVzGJd6epYEKp1
         SHxw==
X-Gm-Message-State: AOJu0Yy6bn5YJDWSiHjmoGj7zMa0k5EqvkhBaGLDjf1HzeIZ4nPs853E
	R7CDfllks7wV5R9SlLjB5LTJSK5Ah0x4ewonaBBKTkiKcwrk+CTpZNuN2DswV+k=
X-Google-Smtp-Source: AGHT+IEw9B57KJAiOx1SXzebZJ0dc/cCWqqLsrVE1ofZ6/aUx5wrJKSi79X+hdpFZ/W3MMZP9MHEUQ==
X-Received: by 2002:a05:6a00:180f:b0:6eb:3c2a:90ab with SMTP id y15-20020a056a00180f00b006eb3c2a90abmr1948515pfa.30.1712113595548;
        Tue, 02 Apr 2024 20:06:35 -0700 (PDT)
Received: from [192.168.1.26] (71-212-18-124.tukw.qwest.net. [71.212.18.124])
        by smtp.gmail.com with ESMTPSA id k8-20020aa78208000000b006eaad01817esm10660094pfi.105.2024.04.02.20.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 20:06:35 -0700 (PDT)
Message-ID: <b39992a9-ebb5-40e1-a00a-ea6019346115@davidwei.uk>
Date: Tue, 2 Apr 2024 20:06:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/7] selftests: drivers: add scaffolding for
 Netlink tests in Python
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, sdf@google.com, donald.hunter@gmail.com,
 linux-kselftest@vger.kernel.org, petrm@nvidia.com
References: <20240402010520.1209517-1-kuba@kernel.org>
 <20240402010520.1209517-7-kuba@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240402010520.1209517-7-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-01 18:05, Jakub Kicinski wrote:
> Add drivers/net as a target for mixed-use tests.
> The setup is expected to work similarly to the forwarding tests.
> Since we only need one interface (unlike forwarding tests)
> read the target device name from NETIF. If not present we'll
> try to run the test against netdevsim.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/Makefile              |   3 +-
>  tools/testing/selftests/drivers/net/Makefile  |   7 ++
>  .../testing/selftests/drivers/net/README.rst  |  30 +++++
>  .../selftests/drivers/net/lib/py/__init__.py  |  17 +++
>  .../selftests/drivers/net/lib/py/env.py       |  41 ++++++
>  .../testing/selftests/net/lib/py/__init__.py  |   1 +
>  tools/testing/selftests/net/lib/py/nsim.py    | 118 ++++++++++++++++++
>  7 files changed, 216 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/drivers/net/Makefile
>  create mode 100644 tools/testing/selftests/drivers/net/README.rst
>  create mode 100644 tools/testing/selftests/drivers/net/lib/py/__init__.py
>  create mode 100644 tools/testing/selftests/drivers/net/lib/py/env.py
>  create mode 100644 tools/testing/selftests/net/lib/py/nsim.py
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 0cffdfb4b116..d015ec14a85e 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -17,6 +17,7 @@ TARGETS += devices
>  TARGETS += dmabuf-heaps
>  TARGETS += drivers/dma-buf
>  TARGETS += drivers/s390x/uvdevice
> +TARGETS += drivers/net
>  TARGETS += drivers/net/bonding
>  TARGETS += drivers/net/team
>  TARGETS += dt
> @@ -117,7 +118,7 @@ TARGETS_HOTPLUG = cpu-hotplug
>  TARGETS_HOTPLUG += memory-hotplug
>  
>  # Networking tests want the net/lib target, include it automatically
> -ifneq ($(filter net ,$(TARGETS)),)
> +ifneq ($(filter net drivers/net,$(TARGETS)),)
>  ifeq ($(filter net/lib,$(TARGETS)),)
>  	override TARGETS := $(TARGETS) net/lib
>  endif
> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> new file mode 100644
> index 000000000000..379cdb1960a7
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TEST_INCLUDES := $(wildcard lib/py/*.py)
> +
> +TEST_PROGS := stats.py
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
> new file mode 100644
> index 000000000000..5ef7c417d431
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/README.rst
> @@ -0,0 +1,30 @@
> +Running tests
> +=============
> +
> +Tests are executed within kselftest framework like any other tests.
> +By default tests execute against software drivers such as netdevsim.
> +All tests must support running against a real device (SW-only tests
> +should instead be placed in net/ or drivers/net/netdevsim, HW-only
> +tests in drivers/net/hw).
> +
> +Set appropriate variables to point the tests at a real device.
> +
> +Variables
> +=========
> +
> +Variables can be set in the environment or by creating a net.config
> +file in the same directory as this README file. Example::
> +
> +  $ NETIF=eth0 ./some_test.sh
> +
> +or::
> +
> +  $ cat tools/testing/selftests/drivers/net/net.config
> +  # Variable set in a file
> +  NETIF=eth0
> +
> +NETIF
> +~~~~~
> +
> +Name of the netdevice against which the test should be executed.
> +When empty or not set software devices will be used.
> diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
> new file mode 100644
> index 000000000000..4653dffcd962
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import sys
> +from pathlib import Path
> +
> +KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
> +
> +try:
> +    sys.path.append(KSFT_DIR.as_posix())
> +    from net.lib.py import *
> +except ModuleNotFoundError as e:
> +    ksft_pr("Failed importing `net` library from kernel sources")
> +    ksft_pr(str(e))
> +    ktap_result(True, comment="SKIP")
> +    sys.exit(4)
> +
> +from .env import *
> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
> new file mode 100644
> index 000000000000..ee4a44555d83
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import os
> +import shlex
> +from pathlib import Path
> +from lib.py import ip
> +from lib.py import NetdevSimDev

nit: these could be on the same line.

> +
> +class NetDrvEnv:
> +    def __init__(self, src_path):
> +        self.env = os.environ.copy()
> +        self._load_env_file(src_path)
> +
> +        if 'NETIF' in self.env:
> +            self._ns = None

My brain interprets 'ns' as 'namespace'. How about something like
nsimdev/nsdev/nsim?

> +            self.dev = ip("link show dev " + self.env['NETIF'], json=True)[0]
> +        else:
> +            self._ns = NetdevSimDev()
> +            self.dev = self._ns.nsims[0].dev
> +        self.ifindex = self.dev['ifindex']
> +
> +    def __del__(self):
> +        if self._ns:
> +            self._ns.remove()
> +
> +    def _load_env_file(self, src_path):
> +        src_dir = Path(src_path).parent.resolve()
> +        if not (src_dir / "net.config").exists():
> +            return
> +
> +        lexer = shlex.shlex(open((src_dir / "net.config").as_posix(), 'r').read())
> +        k = None
> +        for token in lexer:
> +            if k is None:
> +                k = token
> +                self.env[k] = ""
> +            elif token == "=":
> +                pass
> +            else:
> +                self.env[k] = token
> +                k = None
> diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
> index 81a8d14b68f0..99cfc8dc4dca 100644
> --- a/tools/testing/selftests/net/lib/py/__init__.py
> +++ b/tools/testing/selftests/net/lib/py/__init__.py
> @@ -3,4 +3,5 @@
>  from .ksft import *
>  from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily
>  from .consts import KSRC
> +from .nsim import *
>  from .utils import *
> diff --git a/tools/testing/selftests/net/lib/py/nsim.py b/tools/testing/selftests/net/lib/py/nsim.py
> new file mode 100644
> index 000000000000..13eb42c82829
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/py/nsim.py
> @@ -0,0 +1,118 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import json
> +import os
> +import random
> +import re
> +import time
> +from .utils import cmd, ip
> +
> +
> +class NetdevSim:
> +    """
> +    Class for netdevsim netdevice and its attributes.
> +    """
> +
> +    def __init__(self, nsimdev, port_index, ifname, ns=None):
> +        # In case udev renamed the netdev to according to new schema,
> +        # check if the name matches the port_index.
> +        nsimnamere = re.compile("eni\d+np(\d+)")
> +        match = nsimnamere.match(ifname)
> +        if match and int(match.groups()[0]) != port_index + 1:
> +            raise Exception("netdevice name mismatches the expected one")
> +
> +        self.ifname = ifname
> +        self.nsimdev = nsimdev
> +        self.port_index = port_index
> +        self.ns = ns
> +        self.dfs_dir = "%s/ports/%u/" % (nsimdev.dfs_dir, port_index)
> +        ret = ip("-j link show dev %s" % ifname, ns=ns)
> +        self.dev = json.loads(ret.stdout)[0]
> +
> +    def dfs_write(self, path, val):
> +        self.nsimdev.dfs_write(f'ports/{self.port_index}/' + path, val)
> +
> +
> +class NetdevSimDev:
> +    """
> +    Class for netdevsim bus device and its attributes.
> +    """
> +    @staticmethod
> +    def ctrl_write(path, val):
> +        fullpath = os.path.join("/sys/bus/netdevsim/", path)
> +        with open(fullpath, "w") as f:
> +            f.write(val)
> +
> +    def dfs_write(self, path, val):
> +        fullpath = os.path.join(f"/sys/kernel/debug/netdevsim/netdevsim{self.addr}/", path)
> +        with open(fullpath, "w") as f:
> +            f.write(val)
> +
> +    def __init__(self, port_count=1, ns=None):
> +        # nsim will spawn in init_net, we'll set to actual ns once we switch it the.sre
> +        self.ns = None
> +
> +        if not os.path.exists("/sys/bus/netdevsim"):
> +            cmd("modprobe netdevsim")
> +
> +        addr = random.randrange(1 << 15)
> +        while True:
> +            try:
> +                self.ctrl_write("new_device", "%u %u" % (addr, port_count))
> +            except OSError as e:
> +                if e.errno == errno.ENOSPC:
> +                    addr = random.randrange(1 << 15)
> +                    continue
> +                raise e
> +            break
> +        self.addr = addr
> +
> +        # As probe of netdevsim device might happen from a workqueue,
> +        # so wait here until all netdevs appear.
> +        self.wait_for_netdevs(port_count)
> +
> +        if ns:
> +            cmd(f"devlink dev reload netdevsim/netdevsim{addr} netns {ns.name}")
> +            self.ns = ns
> +
> +        cmd("udevadm settle", ns=self.ns)
> +        ifnames = self.get_ifnames()
> +
> +        self.dfs_dir = "/sys/kernel/debug/netdevsim/netdevsim%u/" % addr
> +
> +        self.nsims = []
> +        for port_index in range(port_count):
> +            self.nsims.append(NetdevSim(self, port_index, ifnames[port_index],
> +                                        ns=ns))
> +
> +    def get_ifnames(self):
> +        ifnames = []
> +        listdir = cmd(f"ls /sys/bus/netdevsim/devices/netdevsim{self.addr}/net/",
> +                      ns=self.ns).stdout.split()
> +        for ifname in listdir:
> +            ifnames.append(ifname)
> +        ifnames.sort()
> +        return ifnames
> +
> +    def wait_for_netdevs(self, port_count):
> +        timeout = 5
> +        timeout_start = time.time()
> +
> +        while True:
> +            try:
> +                ifnames = self.get_ifnames()
> +            except FileNotFoundError as e:
> +                ifnames = []
> +            if len(ifnames) == port_count:
> +                break
> +            if time.time() < timeout_start + timeout:
> +                continue
> +            raise Exception("netdevices did not appear within timeout")
> +
> +    def remove(self):
> +        self.ctrl_write("del_device", "%u" % (self.addr, ))

I really want this to be in the dtor, but couldn't get it to work
because Python doesn't let you open files in __del__(). :(

> +
> +    def remove_nsim(self, nsim):
> +        self.nsims.remove(nsim)
> +        self.ctrl_write("devices/netdevsim%u/del_port" % (self.addr, ),
> +                        "%u" % (nsim.port_index, ))

