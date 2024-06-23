Return-Path: <netdev+bounces-105914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E456F9138E0
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 10:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B861C20A14
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 08:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1ED4CDEC;
	Sun, 23 Jun 2024 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWeYa9wy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6423017C77
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719129834; cv=none; b=VUq/JYNX8eZEXhfljt57FEy2AwAX907ziGdeKXqQgzIWRISYzZKpYWBnnbJzMJltX4i8tfY4QH6Hgp8pweIA2d64XZNP3/VhhV3j5f6GCD+Xtnd7RJZcsS/D4li/cYKRMvrKy24Ova+JYjgRZ59WlJEwFltZl0/JsD8Kpv7zI+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719129834; c=relaxed/simple;
	bh=CaT4YJ1lY1mw2PzcLBFJeQb6yzuBx7sgKLXi6g3ZS0M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=L1W/3eZUm+R73uk77D7VTqdHMFzlo3NU+NlwDGMGu/cjTRo26lQSRNe5/iw5FNY+jjsQbP9tpTRhd8lM0Ow3mwJVeMGqqE4PfpY3FxSio7YglsYRb0OuE/U3vDsOE/fJFA3spqWXf2nirYc2yVGoybhAsPxGwUm7l89sCDJTwkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWeYa9wy; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b4fec3a1a7so14572706d6.2
        for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 01:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719129831; x=1719734631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPoarJkVXbGPNLUACTx9hKbC8zKVwnxzRJlTBlve7qA=;
        b=GWeYa9wydATRvzGC34Nk2XhVn1vaZLvD3AyZjXELNwgu9uhGHZR6dTuUrsFXEqD6pL
         E9KByRNLnJgVKQJkh6RVkrllxyDQkOPqSlnra/mLMtGSeQNSsFzjw+ix2TpRnyIsSsY1
         w9S1+7i0ydH1uGihULzxL7AOC1pjIZWJnDH8nqCaCk+mApoHLv+d02YyxAdQLyezS02i
         sp/ZgZELF2/MqAUDNfn7YN2mlN7D2l+A5ssgCWVJ++d1rYlqxHx4VarpXai2HgQBBkn1
         PIeLqPMeQqm/fK8Sj/xdwtNyJcR3le15PiyLZjQPLd0yyxG9o8LNOlchRzTAFI2FuuIK
         ERjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719129831; x=1719734631;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CPoarJkVXbGPNLUACTx9hKbC8zKVwnxzRJlTBlve7qA=;
        b=wSbDsqZ4gX867oizQXZhOSrMjD87sZuGpxsRZMr8eyly1fetFaZFenDq8cmpmlqaeY
         wPeB/JSHt/pIDn/OWOGfUSkvNrra47clQrvxVakNWsBJmt4JJvYY9q02OcHjuMDZQibl
         2nDj887LAwO+8fZOeFx+86KBwzrQvDmry84UGvvJhfTg8IsuYDXlZHLw5j5Fx64AHKPg
         DXl+A+YiDaGEbIdKcTFH/+0v4qre4+HmEZFAkt5sagOKqjkc8U66pxImN4E5DxyM19vV
         exwWNZ4I9HRRIYjCwiX6p2bX9NCl+yK+TnTzI5qOsVRJHpneSP9DyqsMSk5kuAaNvqaE
         SwHQ==
X-Gm-Message-State: AOJu0Yyr/xc9Pq6JOF3uLav0Rzj8wUTv/U0De/6amHfAS2qxAwvyb6h+
	2LYG0r1YtSixs6T4PkHrEJb2hzuIQy3m+YMGcgi53X1qTAIqovWJ
X-Google-Smtp-Source: AGHT+IEi+HvSz3rgKgCByTfWCNGcPuLuqNu0dy9vVQd3+/2+cP/RJutxx6XXFanpgtv43lP2yNprkg==
X-Received: by 2002:a0c:f745:0:b0:6b2:e107:af03 with SMTP id 6a1803df08f44-6b53bbb8240mr20205036d6.31.1719129830977;
        Sun, 23 Jun 2024 01:03:50 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ecfe883sm23812026d6.2.2024.06.23.01.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 01:03:50 -0700 (PDT)
Date: Sun, 23 Jun 2024 04:03:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 ecree.xilinx@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <6677d6e5e646e_33363c2944d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240620232902.1343834-5-kuba@kernel.org>
References: <20240620232902.1343834-1-kuba@kernel.org>
 <20240620232902.1343834-5-kuba@kernel.org>
Subject: Re: [PATCH net-next 4/4] selftests: drv-net: rss_ctx: add tests for
 RSS configuration and contexts
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
> Add tests focusing on indirection table configuration and
> creating extra RSS contexts in drivers which support it.
> 
>   $ ./drivers/net/hw/rss_ctx.py
>   KTAP version 1
>   1..6
>   ok 1 rss_ctx.test_rss_key_indir
>   ok 2 rss_ctx.test_rss_context
>   ok 3 rss_ctx.test_rss_context4
>   # Increasing queue count 44 -> 66
>   # Failed to create context 32, trying to test what we got
>   ok 4 rss_ctx.test_rss_context32 # SKIP Tested only 31 contexts, wanted 32
>   ok 5 rss_ctx.test_rss_context_overlap
>   ok 6 rss_ctx.test_rss_context_overlap2
>   # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |   1 +
>  .../selftests/drivers/net/hw/rss_ctx.py       | 243 ++++++++++++++++++
>  .../selftests/drivers/net/lib/py/load.py      |   7 +-
>  tools/testing/selftests/net/lib/py/ksft.py    |   5 +
>  tools/testing/selftests/net/lib/py/utils.py   |   8 +-
>  5 files changed, 259 insertions(+), 5 deletions(-)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/rss_ctx.py
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 4933d045ab66..c9f2f48fc30f 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -11,6 +11,7 @@ TEST_PROGS = \
>  	hw_stats_l3_gre.sh \
>  	loopback.sh \
>  	pp_alloc_fail.py \
> +	rss_ctx.py \
>  	#
>  
>  TEST_FILES := \
> diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> new file mode 100755
> index 000000000000..74d2ca62083f
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> @@ -0,0 +1,243 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import datetime
> +import random
> +from lib.py import ksft_run, ksft_pr, ksft_exit, ksft_eq, ksft_ge, ksft_lt
> +from lib.py import NetDrvEpEnv
> +from lib.py import NetdevFamily
> +from lib.py import KsftSkipEx
> +from lib.py import rand_port
> +from lib.py import ethtool, ip, GenerateTraffic, CmdExitFailure
> +
> +
> +def _rss_key_str(key):
> +    return ":".join(["{:02x}".format(x) for x in key])
> +
> +
> +def _rss_key_rand(length):
> +    return [random.randint(0, 255) for _ in range(length)]
> +
> +
> +def get_rss(cfg):
> +    return ethtool(f"-x {cfg.ifname}", json=True)[0]
> +
> +
> +def ethtool_create(cfg, act, opts):
> +    output = ethtool(f"{act} {cfg.ifname} {opts}").stdout
> +    # Output will be something like: "New RSS context is 1" or
> +    # "Added rule with ID 7", we want the integer from the end
> +    return int(output.split()[-1])
> +
> +
> +# Get Rx packet counts for all queues, as a simple list of integers
> +# if @prev is specified the prev counts will be subtracted
> +def _get_rx_cnts(cfg, prev=None):
> +    cfg.wait_hw_stats_settle()
> +    data = cfg.netdevnl.qstats_get({"ifindex": cfg.ifindex, "scope": ["queue"]}, dump=True)
> +    data = [x for x in data if x['queue-type'] == "rx"]
> +    max_q = max([x["queue-id"] for x in data])
> +    queue_stats = [0] * (max_q + 1)
> +    for q in data:
> +        queue_stats[q["queue-id"]] = q["rx-packets"]
> +        if prev and q["queue-id"] < len(prev):
> +            queue_stats[q["queue-id"]] -= prev[q["queue-id"]]
> +    return queue_stats
> +
> +
> +def test_rss_key_indir(cfg):
> +    """
> +    Test basics like updating the main RSS key and indirection table.
> +    """
> +    data = get_rss(cfg)
> +    want_keys = ['rss-hash-key', 'rss-hash-function', 'rss-indirection-table']
> +    for k in want_keys:
> +        if k not in data:
> +            raise KsftFailEx("ethtool results missing key: " + k)
> +        if not data[k]:
> +            raise KsftFailEx(f"ethtool results empty for '{k}': {data[k]}")

No point in printing data[k]?

> +
> +    key_len = len(data['rss-hash-key'])
> +
> +    # Set the key
> +    key = _rss_key_rand(key_len)
> +    ethtool(f"-X {cfg.ifname} hkey " + _rss_key_str(key))

Probably too paranoid, but in case failure is only for some randomized
input, is the key logged on error?

> +
> +    data = get_rss(cfg)
> +    ksft_eq(key, data['rss-hash-key'])
> +
> +    # Set the indirection table
> +    ethtool(f"-X {cfg.ifname} equal 2")
> +    data = get_rss(cfg)
> +    ksft_eq(0, min(data['rss-indirection-table']))
> +    ksft_eq(1, max(data['rss-indirection-table']))
> +
> +    # Check we only get traffic on the first 2 queues
> +    cnts = _get_rx_cnts(cfg)
> +    GenerateTraffic(cfg).wait_pkts_and_stop(20000)
> +    cnts = _get_rx_cnts(cfg, prev=cnts)
> +    # 2 queues, 20k packets, must be at least 5k per queue
> +    ksft_ge(cnts[0], 5000, "traffic on main context (1/2): " + str(cnts))
> +    ksft_ge(cnts[1], 5000, "traffic on main context (2/2): " + str(cnts))
> +    # The other queues should be unused
> +    ksft_eq(sum(cnts[2:]), 0, "traffic on unused queues: " + str(cnts))
> +
> +    # Restore, and check traffic gets spread again
> +    ethtool(f"-X {cfg.ifname} default")

Consider save and restore state at the start of the test, in case
default is overridden at boot.

Not important, but this also repeats some of toeplitz.sh. That has not
been integrated into net-drv, and the .c and .sh code is more verbose
than this python code. Perhaps can be replaced entirely eventually.

> +
> +    cnts = _get_rx_cnts(cfg)
> +    GenerateTraffic(cfg).wait_pkts_and_stop(20000)
> +    cnts = _get_rx_cnts(cfg, prev=cnts)
> +    # First two queues get less traffic than all the rest
> +    ksft_ge(sum(cnts[2:]), sum(cnts[:2]), "traffic distributed: " + str(cnts))
> +
> +
> +def test_rss_context(cfg, ctx_cnt=1):
> +    """
> +    Test separating traffic into RSS contexts.
> +    The queues will be allocated 2 for each context:
> +     ctx0  ctx1  ctx2  ctx3
> +    [0 1] [2 3] [4 5] [6 7] ...
> +    """
> +
> +    requested_ctx_cnt = ctx_cnt
> +
> +    # Try to allocate more queues when necessary
> +    qcnt = len(_get_rx_cnts(cfg))
> +    if qcnt >= 2 + 2 * ctx_cnt:
> +        qcnt = None
> +    else:
> +        try:
> +            ksft_pr(f"Increasing queue count {qcnt} -> {2 + 2 * ctx_cnt}")
> +            ethtool(f"-L {cfg.ifname} combined {2 + 2 * ctx_cnt}")
> +        except:
> +            raise KsftSkipEx("Not enough queues for the test")
> +
> +    ntuple = []
> +    ctx_id = []
> +    ports = []
> +    try:
> +        # Use queues 0 and 1 for normal traffic
> +        ethtool(f"-X {cfg.ifname} equal 2")
> +
> +        for i in range(ctx_cnt):
> +            try:
> +                ctx_id.append(ethtool_create(cfg, "-X", "context new"))
> +            except CmdExitFailure:
> +                # try to carry on and skip at the end
> +                if i == 0:
> +                    raise
> +                ksft_pr(f"Failed to create context {i + 1}, trying to test what we got")
> +                ctx_cnt = i
> +                break
> +
> +            ethtool(f"-X {cfg.ifname} context {ctx_id[i]} start {2 + i * 2} equal 2")
> +
> +            ports.append(rand_port())
> +            flow = f"flow-type tcp{cfg.addr_ipver} dst-port {ports[i]} context {ctx_id[i]}"
> +            ntuple.append(ethtool_create(cfg, "-N", flow))

Need to test feature ('-k') ntuple and skip test otherwise or set?

> +
> +        for i in range(ctx_cnt):
> +            cnts = _get_rx_cnts(cfg)
> +            GenerateTraffic(cfg, port=ports[i]).wait_pkts_and_stop(20000)
> +            cnts = _get_rx_cnts(cfg, prev=cnts)
> +
> +            ksft_lt(sum(cnts[ :2]), 10000, "traffic on main context:" + str(cnts))
> +            ksft_ge(sum(cnts[2+i*2:4+i*2]), 20000, f"traffic on context {i}: " + str(cnts))
> +            ksft_eq(sum(cnts[2:2+i*2] + cnts[4+i*2:]), 0, "traffic on other contexts: " + str(cnts))
> +    finally:
> +        for nid in ntuple:
> +            ethtool(f"-N {cfg.ifname} delete {nid}")
> +        for cid in ctx_id:
> +            ethtool(f"-X {cfg.ifname} context {cid} delete")
> +        ethtool(f"-X {cfg.ifname} default")
> +        if qcnt:
> +            ethtool(f"-L {cfg.ifname} combined {qcnt}")
> +
> +    if requested_ctx_cnt != ctx_cnt:
> +        raise KsftSkipEx(f"Tested only {ctx_cnt} contexts, wanted {requested_ctx_cnt}")
> +
> +
> +def test_rss_context4(cfg):
> +    test_rss_context(cfg, 4)
> +
> +
> +def test_rss_context32(cfg):
> +    test_rss_context(cfg, 32)
> +
> +
> +def test_rss_context_overlap(cfg, other_ctx=0):
> +    """
> +    Test contexts overlapping with each other.
> +    Use 4 queues for the main context, but only queues 2 and 3 for context 1.
> +    """
> +    ctx_id = None
> +    ntuple = None
> +    if other_ctx == 0:
> +        ethtool(f"-X {cfg.ifname} equal 4")
> +    else:
> +        other_ctx = ethtool_create(cfg, "-X", "context new")
> +        ethtool(f"-X {cfg.ifname} context {other_ctx} equal 4")
> +
> +    try:
> +        ctx_id = ethtool_create(cfg, "-X", "context new")
> +        ethtool(f"-X {cfg.ifname} context {ctx_id} start 2 equal 2")
> +
> +        port = rand_port()
> +        if other_ctx:
> +            flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {other_ctx}"
> +            ntuple = ethtool_create(cfg, "-N", flow)
> +
> +        # Test the main context
> +        cnts = _get_rx_cnts(cfg)
> +        GenerateTraffic(cfg, port=port).wait_pkts_and_stop(20000)
> +        cnts = _get_rx_cnts(cfg, prev=cnts)
> +
> +        ksft_ge(sum(cnts[ :4]), 20000, "traffic on main context: " + str(cnts))
> +        ksft_ge(sum(cnts[ :2]),  7000, "traffic on main context (1/2): " + str(cnts))
> +        ksft_ge(sum(cnts[2:4]),  7000, "traffic on main context (2/2): " + str(cnts))
> +        if other_ctx == 0:
> +            ksft_eq(sum(cnts[4: ]),     0, "traffic on other queues: " + str(cnts))
> +
> +        # Now create a rule for context 1 and make sure traffic goes to a subset
> +        if other_ctx:
> +            ethtool(f"-N {cfg.ifname} delete {ntuple}")
> +        flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {ctx_id}"
> +        ntuple = ethtool_create(cfg, "-N", flow)
> +
> +        cnts = _get_rx_cnts(cfg)
> +        GenerateTraffic(cfg, port=port).wait_pkts_and_stop(20000)
> +        cnts = _get_rx_cnts(cfg, prev=cnts)
> +
> +        ksft_lt(sum(cnts[ :2]),  7000, "traffic on main context: " + str(cnts))
> +        ksft_ge(sum(cnts[2:4]), 20000, "traffic on extra context: " + str(cnts))
> +        if other_ctx == 0:
> +            ksft_eq(sum(cnts[4: ]),     0, "traffic on other queues: " + str(cnts))
> +    finally:
> +        if ntuple:
> +            ethtool(f"-N {cfg.ifname} delete {ntuple}")
> +        if ctx_id:
> +            ethtool(f"-X {cfg.ifname} context {ctx_id} delete")
> +        if other_ctx == 0:
> +            ethtool(f"-X {cfg.ifname} default")
> +        else:
> +            ethtool(f"-X {cfg.ifname} context {other_ctx} delete")
> +
> +
> +def test_rss_context_overlap2(cfg):
> +    test_rss_context_overlap(cfg, True)
> +
> +
> +def main() -> None:
> +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
> +        cfg.netdevnl = NetdevFamily()
> +
> +        ksft_run([test_rss_key_indir, test_rss_context, test_rss_context4,
> +                  test_rss_context32, test_rss_context_overlap,
> +                  test_rss_context_overlap2],
> +                 args=(cfg, ))
> +    ksft_exit()
> +
> +
> +if __name__ == "__main__":
> +    main()
> diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
> index ae60c438f6c2..1de62977433b 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/load.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/load.py
> @@ -5,13 +5,14 @@ import time
>  from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
>  

