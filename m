Return-Path: <netdev+bounces-105497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7B3911834
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 03:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DDD01F22994
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 01:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266B9824AD;
	Fri, 21 Jun 2024 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="oXmPmzRr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB2C3EA6C
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718934747; cv=none; b=p5l36vNbkD/oV/sgruZxNOQ2gMSZ36cSQSKb+f/DwEyzoBfGLHQoIHpHB1Xuo33KhODUgAgwUYspWuwHjlNM/j8xG8y3OdBx8C3wBX9c2U5BeauuN5Ug5JnOlzv8t6hWM0XOsLEtqyXF68XHR8FED7IzZqHI+yYpXs19LnZi/Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718934747; c=relaxed/simple;
	bh=EjozglWzX4+K9TpOH9bbbRCYHatnE7/iF3B9guckVy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzoDrTNLPZwfbiTkzV+A8O37r6EnlMKbPoulnK11FrDC4mKOz52F1KrjGAdKTBcVudH2+lqS2+tRK0AbDojT4CPezEatCoxql+kdjaa3R/Ph48BPgG74LIdFxINt8YTeIemdk4aOO77IrWOHj6RL4ZndZQSsBeOwLAsQpSLV5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=oXmPmzRr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f9bf484d9fso12397065ad.1
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 18:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718934743; x=1719539543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tCGsCjyKR1iuGeMxlJvZ7gnmSsnFk3J5pn6v37rROxc=;
        b=oXmPmzRrC3ZVu+vnTIG7/3kDcr7Kwyo1W6b2cbplv6yr6uw6iv1+DbBgE+d5eNkEIZ
         P7tzNS11JjE4bnWcGinda3+nXp98aUa45PfQUYiVS9llXx/3cja5NZert5Kje+OJ3wYX
         7GgMBlOOR/y/tC9Z8Yu0EaoaX0aaY9gUW3RtPDurplOvfvPCGgq0gqBQm8NekQd66qhO
         K0Cr28rZl/gSSLp9F6NEdbPRj6jgTBsBd+fuh+FepApcxHWK2xmwP851cQyB/rPwpqaQ
         DsGAbDfYbdOuGnIz6j2X2JmLH4gYJ44HTff4+4K6Ge2DzrTgQnQuaFt3fPUuuHJanN4i
         Kjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718934743; x=1719539543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tCGsCjyKR1iuGeMxlJvZ7gnmSsnFk3J5pn6v37rROxc=;
        b=H4nDt3ErzHsWPGYAOo+KstpPO9/tF1rIc07wvaTH8lHmJW2+mqOtNyb+fR1Q0ydMBq
         Xo6FpzRIGTsqJHTyZdz1P17tjIj7LLbYDBfwgNT9jblFVLUwN/6PevhZUEC+Gbh89SN8
         y6OWkyglTBQf3br456Qy+ZBe3OR5Ez/3Jn8p1mdvYwo2GVm6cJP2YIUvuvFZfC3iLjJ0
         +yf1jrVVISJK65PlNNbyG2EVjE9BvP15lzwYAxG7jCkZi6XYLMlQPWSwjpGU6sACSiH2
         6rONEA8zM7adBc5yL91McOTcnGkkH1E2maSVpDFnno4oWGMS+CVrB+B81V1emA4CwgKr
         AfzQ==
X-Gm-Message-State: AOJu0YzO/tkb6V0snvFIjDALdGSkgkTT9cqOYu2IvwrgQIZ1ROMktCKr
	eVHKPCQcLdOMoVo+gzW8CtLV11Cd1svcW/UYzD9Q4lzc1hlQzdY0nMrZdwGNN50=
X-Google-Smtp-Source: AGHT+IGGI+Qc4kVY4NkcHEuvo0fD4ayb5InEzdSrSJM/nuj01luj47OW2A8VHFHI/kCqA4srwJuy9Q==
X-Received: by 2002:a17:90a:a515:b0:2c2:ee8e:ceff with SMTP id 98e67ed59e1d1-2c6cb1b1c31mr12220958a91.24.1718934743370;
        Thu, 20 Jun 2024 18:52:23 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cbd:da2b:a9f2:881? ([2620:10d:c090:500::6:b127])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e55db313sm2393500a91.25.2024.06.20.18.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 18:52:23 -0700 (PDT)
Message-ID: <fc0b5d42-0ab6-4ce1-b0ee-2345b4ae9b2f@davidwei.uk>
Date: Thu, 20 Jun 2024 18:52:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] selftests: drv-net: rss_ctx: add tests for
 RSS configuration and contexts
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, ecree.xilinx@gmail.com
References: <20240620232902.1343834-1-kuba@kernel.org>
 <20240620232902.1343834-5-kuba@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240620232902.1343834-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-20 16:29, Jakub Kicinski wrote:
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

At this point I think json=True can be the default.

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
> +
> +    key_len = len(data['rss-hash-key'])
> +
> +    # Set the key
> +    key = _rss_key_rand(key_len)
> +    ethtool(f"-X {cfg.ifname} hkey " + _rss_key_str(key))
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
> +
> +    cnts = _get_rx_cnts(cfg)
> +    GenerateTraffic(cfg).wait_pkts_and_stop(20000)
> +    cnts = _get_rx_cnts(cfg, prev=cnts)
> +    # First two queues get less traffic than all the rest
> +    ksft_ge(sum(cnts[2:]), sum(cnts[:2]), "traffic distributed: " + str(cnts))

Do you need to check the number of queues? If it's 3 then would this
check potentially fail?

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
> +
> +        for i in range(ctx_cnt):
> +            cnts = _get_rx_cnts(cfg)
> +            GenerateTraffic(cfg, port=ports[i]).wait_pkts_and_stop(20000)
> +            cnts = _get_rx_cnts(cfg, prev=cnts)
> +
> +            ksft_lt(sum(cnts[ :2]), 10000, "traffic on main context:" + str(cnts))

What if the host is getting significant traffic during the test?

> +            ksft_ge(sum(cnts[2+i*2:4+i*2]), 20000, f"traffic on context {i}: " + str(cnts))

Is this exactly 20000?

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

What if the queue count < 4?

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

Add a test case for other_ctx=0?

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
>  class GenerateTraffic:
> -    def __init__(self, env):
> +    def __init__(self, env, port=None):
>          env.require_cmd("iperf3", remote=True)
>  
>          self.env = env
>  
> -        port = rand_port()
> -        self._iperf_server = cmd(f"iperf3 -s -p {port}", background=True)
> +        if port is None:
> +            port = rand_port()
> +        self._iperf_server = cmd(f"iperf3 -s -1 -p {port}", background=True)
>          wait_port_listen(port)
>          time.sleep(0.1)
>          self._iperf_client = cmd(f"iperf3 -c {env.addr} -P 16 -p {port} -t 86400",
> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> index 4769b4eb1ea1..91648c5baf40 100644
> --- a/tools/testing/selftests/net/lib/py/ksft.py
> +++ b/tools/testing/selftests/net/lib/py/ksft.py
> @@ -57,6 +57,11 @@ KSFT_RESULT_ALL = True
>          _fail("Check failed", a, "<", b, comment)
>  
>  
> +def ksft_lt(a, b, comment=""):
> +    if a > b:
> +        _fail("Check failed", a, ">", b, comment)
> +
> +
>  class ksft_raises:
>      def __init__(self, expected_type):
>          self.exception = None
> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index bf8b5e4d9bac..b3ee57a650ae 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -8,6 +8,10 @@ import subprocess
>  import time
>  
>  
> +class CmdExitFailure(Exception):
> +    pass
> +
> +
>  class cmd:
>      def __init__(self, comm, shell=True, fail=True, ns=None, background=False, host=None, timeout=5):
>          if ns:
> @@ -42,8 +46,8 @@ import time
>          if self.proc.returncode != 0 and fail:
>              if len(stderr) > 0 and stderr[-1] == "\n":
>                  stderr = stderr[:-1]
> -            raise Exception("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
> -                            (self.proc.args, stdout, stderr))
> +            raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
> +                                 (self.proc.args, stdout, stderr))
>  
>  
>  class bkg(cmd):

