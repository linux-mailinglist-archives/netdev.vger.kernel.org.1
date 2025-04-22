Return-Path: <netdev+bounces-184795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A68CA97353
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 19:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C4A3A8728
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CE0293B55;
	Tue, 22 Apr 2025 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMp2CpEF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C56A13C3F6
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745341612; cv=none; b=FTbF0z3ocxHhgXx9xMyfwThBL4mvxHBLiaPM08lz0y9/oZTzrvSczjNeN3hb7Lv8/lNHr1F+NMg3Dku62zNf7QfVACzQ36Cssh3iadHiDa7oKEoQBfnRoGn4h2IAxl2kykYTSS/k/74tHkeEt6n1bkKrjPxc6zz1RT5uyqbyOSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745341612; c=relaxed/simple;
	bh=KAox7O8ghMX45K8i9/7C9UokeJFyg3C/oMBsFgCPP+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zg+7aQsyPD+XTJpo+F/63nMLt43QR/nnE5wqHuz8bbkdE8X87vyIExabL9vWwKK4j+U2nE42RmO3uo8dpaTyAGnEy8jGPlzsL7w32VpxbNk9pDWpYXUjkB6dc2sBjZ0DCHEbFYwqZwyGmrEGtxJvR9GukIA11oQWu+8Fb8BTUDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMp2CpEF; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b03bc416962so3939591a12.0
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 10:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745341610; x=1745946410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LXKNwAqPyrfePqTdq+hrBNPAEy/X4TKI6ueHlNWt4gI=;
        b=WMp2CpEFdzWeU/Hdbw1mPWhlOAe5CI8pdzJ0q4OWQqsooIFisqEB9E7PLbKpBShvZY
         6H8nBw3OFWKcAd7gNlyvnv+CGvEldSkdgnQ4y3EVfDllgjOovU9Tx/Y6j/DKtgWuLz0i
         K9aK72vtdXB+vSH6np4sBum7T7lTZGXgPS77usCbla/oUMWeVYUr0/sQe0ghHoEFHCmz
         C7ZQ8uDjqsCQx88V/kprNpCeY+OxcdqbClhDoEj/Dhrn8I1z2DmKhvEwx8eh3w27qh2D
         q1JZe8YA2bjxxRtgLuy+6OU8czdezuNLN5LlmIxTIv8oov/gTX8bI1PKqrNCgDVodfiS
         blvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745341610; x=1745946410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXKNwAqPyrfePqTdq+hrBNPAEy/X4TKI6ueHlNWt4gI=;
        b=abg9KW/nRwcAR777t4hitw7NwrcOItUbvdoSgdsZETIGsjksUCXdItop8lZh41oGkC
         w2lzDfn33f9ux7aSFz2IKW9P1ieKNJq9K+bET15LF+dYNSh6SIJFxvNPfL8IQjFUzkQi
         N8YHp+6mz/1FksA7eAgjSvMCqFwauN0NlbplRUcK6pKGxv0mI5LL282Cuz3U2uKhlT0H
         BBB0HDaWGJXIXcb5xXBT+tydsp+XqEWhK4PY7DqasWxjpRQB76jRggMSdHrGOCjylRg4
         N/ZVJ/aXufga/mORdofc4P630JolNTGpfWGHdCe4hr5jkKe6wz9KKdpnMCfhxUDeupdE
         EJJg==
X-Forwarded-Encrypted: i=1; AJvYcCXAh7BB1Cv3BSNFqbljo/HTwjttXxG9CX0PfhshU4Iz6qheuEJqrTid/4JN5HghS9EGHT9hFPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd16wqGDKBfKJj3aNhPJfycxR+5froUOlfHTygvvGOHhBINvpE
	9vPRZWuubtAafYLZOhjxDY7SypubRM4SMviCscyo0Of2QBgpCUg=
X-Gm-Gg: ASbGncuT+rWiKmTXecEoJRbEQRb+5EqCwpPEVo3q2fTZpvpCBg84nNxUE32Wg4lfOll
	r/rGXSUuJmNDB5vJgAoQBpHjtXQcnWPapPZbo7QlE5n3ROn8rhVg5brF2xi0Uih0oruTxouuSCH
	q9DVJNGepf9Lg2yJtL8AG/rALxl3ff922+Aht03p8Vn8nLkO9jSTNBihQhHH6dRGMh3/5JMRqx4
	MyBQIOtUxjXWlYn9FIT2DtBpkYAKW/nmpDKEB+GxkoVaRXjyeaMsc8Ao2k4yLciE6OnnMv2RX2A
	6D8sn+NLsfJabLkx+34lRQ1NFF+N9RpljHz0Uc5P
X-Google-Smtp-Source: AGHT+IGe2VeTaYYWiD3MCh5jDOKx/152+g9E/E6Ybm1lucxVA9ZDKsYQDiHCjV0NtQEzsKzsiIlIAQ==
X-Received: by 2002:a17:90b:254d:b0:2ff:7331:18bc with SMTP id 98e67ed59e1d1-3087bbc22dbmr19362800a91.26.1745341610124;
        Tue, 22 Apr 2025 10:06:50 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3087df0c143sm8877810a91.16.2025.04.22.10.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 10:06:49 -0700 (PDT)
Date: Tue, 22 Apr 2025 10:06:48 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
	dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
	jdamato@fastly.com, dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 22/22] selftests: drv-net: add test for rx-buf-len
Message-ID: <aAfMqE_m6QFTph_k@mini-arch>
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-23-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250421222827.283737-23-kuba@kernel.org>

On 04/21, Jakub Kicinski wrote:
> Add a test for rx-buf-len. Check both nic-wide and per-queue settings.
> 
>   # ./drivers/net/hw/rx_buf_len.py
>   TAP version 13
>   1..6
>   ok 1 rx_buf_len.nic_wide
>   ok 2 rx_buf_len.nic_wide_check_packets
>   ok 3 rx_buf_len.per_queue
>   ok 4 rx_buf_len.per_queue_check_packets
>   ok 5 rx_buf_len.queue_check_ring_count
>   ok 6 rx_buf_len.queue_check_ring_count_check_packets
>   # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |   1 +
>  .../selftests/drivers/net/hw/rx_buf_len.py    | 299 ++++++++++++++++++
>  2 files changed, 300 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/rx_buf_len.py
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 07cddb19ba35..88625c0e86c8 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -20,6 +20,7 @@ TEST_PROGS = \
>  	pp_alloc_fail.py \
>  	rss_ctx.py \
>  	rss_input_xfrm.py \
> +	rx_buf_len.py \
>  	tso.py \
>  	#
>  
> diff --git a/tools/testing/selftests/drivers/net/hw/rx_buf_len.py b/tools/testing/selftests/drivers/net/hw/rx_buf_len.py
> new file mode 100755
> index 000000000000..d8a6d07fac5e
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/rx_buf_len.py
> @@ -0,0 +1,299 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import errno, time
> +from typing import Tuple
> +from lib.py import ksft_run, ksft_exit, KsftSkipEx, KsftFailEx
> +from lib.py import ksft_eq, ksft_ge, ksft_in, ksft_not_in
> +from lib.py import EthtoolFamily, NetdevFamily, NlError
> +from lib.py import NetDrvEpEnv, GenerateTraffic
> +from lib.py import cmd, defer, bpftrace, ethtool, rand_port
> +
> +
> +def _do_bpftrace(cfg, mul, base_size, tgt_queue=None):
> +    queue_filter = ''
> +    if tgt_queue is not None:
> +        queue_filter = 'if ($skb->queue_mapping != %d) {return;}' % (tgt_queue + 1, )

if tgt_queue: should work as well?

> +
> +    t = ('tracepoint:net:netif_receive_skb { ' +
> +         '$skb = (struct sk_buff *)args->skbaddr; '+
> +         '$sh = (struct skb_shared_info *)($skb->head + $skb->end); ' +
> +         'if ($skb->dev->ifindex != ' + str(cfg.ifindex) + ') {return;} ' +
> +         queue_filter +
> +         '@[$skb->len - $skb->data_len] = count(); ' +
> +         '@h[$skb->len - $skb->data_len] = count(); ' +
> +         'if ($sh->nr_frags > 0) { @[$sh->frags[0].len] = count(); @d[$sh->frags[0].len] = count();} }'
> +        )

Why do we have @h and @d? We seem to check only the 'sizes'/@?

> +    maps = bpftrace(t, json=True, timeout=2)
> +    # We expect one-dim array with something like:
> +    # {"type": "map", "data": {"@": {"1500": 1, "719": 1,
> +    sizes = maps["@"]
> +    h = maps["@h"]
> +    d = maps["@d"]
> +    good = 0
> +    bad = 0

[..]

> +    for k, v in sizes.items():
> +        k = int(k)
> +        if mul == 1 and k > base_size:
> +            bad += v
> +        elif mul > 1 and k > base_size:
> +            good += v
> +        elif mul < 1 and k >= base_size:
> +            bad += v

I haven't fully processed what's going on here, but will it be
easier if we go from mul*base_size to old_size and new_size? Or maybe
the comments can help?

if old_size == new_size and frag > old_size:
  # unchanged buf len, unexpected large frag
elif new_size < old_size and frag >= old_size:
  # shrank buf len, but got old (big) frag
elif new_size > old_size and frag > old_size:
  # good

> +    ksft_eq(bad, 0, "buffer was decreased but large buffers seen")
> +    if mul > 1:
> +        ksft_ge(good, 100, "buffer was increased but no large buffers seen")

> +
> +
> +def _ethtool_create(cfg, act, opts):
> +    output = ethtool(f"{act} {cfg.ifname} {opts}").stdout
> +    # Output will be something like: "New RSS context is 1" or
> +    # "Added rule with ID 7", we want the integer from the end
> +    return int(output.split()[-1])
> +
> +
> +def nic_wide(cfg, check_geometry=False) -> None:
> +    """
> +    Apply NIC wide rx-buf-len change. Run some traffic to make sure there
> +    are no crashes. Test that setting 0 restores driver default.
> +    Assume we start with the default.
> +    """
> +    try:
> +        rings = cfg.ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
> +    except NlError as e:
> +        rings = {}
> +    if "rx-buf-len" not in rings:
> +        raise KsftSkipEx('rx-buf-len configuration not supported by device')
> +
> +    if rings['rx-buf-len'] * 2 <= rings['rx-buf-len-max']:
> +        mul = 2
> +    else:
> +        mul = 1/2

And similarly here? (and elsewhere)

def pick_buf_size(rings):
	""" pick new rx-buf-len depending on current and max settings """
	buf_len = rings['rx-buf-len']
	if buf_len * 2 <= <= rings['rx-buf-len-max']:
 	  # if can grow, try to grow
	  return buf_len, buf_len * 2
	else:
	  # otherwise shrink
	  return buf_len, buf_len / 2

old_buf_len, new_buf_len = pick_buf_size(ring)
...

(or maybe its just me, idk, easier to think in old>new comparisons vs
doing mul*base_size math)

> +    cfg.ethnl.rings_set({'header': {'dev-index': cfg.ifindex},
> +                         'rx-buf-len': rings['rx-buf-len'] * mul})
> +
> +    # Use zero to restore default, per uAPI, we assume we started with default
> +    reset = defer(cfg.ethnl.rings_set, {'header': {'dev-index': cfg.ifindex},
> +                                       'rx-buf-len': 0})
> +
> +    new = cfg.ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
> +    ksft_eq(new['rx-buf-len'], rings['rx-buf-len'] * mul, "config after change")
> +
> +    # Runs some traffic thru them buffers, to make things implode if they do
> +    traf = GenerateTraffic(cfg)
> +    try:
> +        if check_geometry:
> +            _do_bpftrace(cfg, mul, rings['rx-buf-len'])
> +    finally:
> +        traf.wait_pkts_and_stop(20000)
> +
> +    reset.exec()
> +    new = cfg.ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
> +    ksft_eq(new['rx-buf-len'], rings['rx-buf-len'], "config reset to default")
> +
> +
> +def nic_wide_check_packets(cfg) -> None:
> +    nic_wide(cfg, check_geometry=True)
> +
> +
> +def _check_queues_with_config(cfg, buf_len, qset):
> +    cnt = 0
> +    queues = cfg.netnl.queue_get({'ifindex': cfg.ifindex}, dump=True)
> +    for q in queues:
> +        if 'rx-buf-len' in q:
> +            cnt += 1
> +            ksft_eq(q['type'], "rx")
> +            ksft_in(q['id'], qset)
> +            ksft_eq(q['rx-buf-len'], buf_len, "buf size")
> +    if cnt != len(qset):
> +        raise KsftFailEx('queue rx-buf-len config invalid')
> +
> +
> +def _per_queue_configure(cfg) -> Tuple[dict, int, defer]:
> +    """
> +    Prep for per queue test. Set the config on one queue and return
> +    the original ring settings, the multiplier and reset defer.
> +    """
> +    # Validate / get initial settings
> +    try:
> +        rings = cfg.ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
> +    except NlError as e:
> +        rings = {}
> +    if "rx-buf-len" not in rings:
> +        raise KsftSkipEx('rx-buf-len configuration not supported by device')
> +
> +    try:
> +        queues = cfg.netnl.queue_get({'ifindex': cfg.ifindex}, dump=True)
> +    except NlError as e:
> +        raise KsftSkipEx('queue configuration not supported by device')
> +
> +    if len(queues) < 2:
> +        raise KsftSkipEx('not enough queues: ' + str(len(queues)))
> +    for q in queues:
> +        if 'rx-buf-len' in q:
> +            raise KsftFailEx('queue rx-buf-len already configured')
> +
> +    # Apply a change, we'll target queue 1
> +    if rings['rx-buf-len'] * 2 <= rings['rx-buf-len-max']:
> +        mul = 2
> +    else:
> +        mul = 1/2
> +    try:
> +        cfg.netnl.queue_set({'ifindex': cfg.ifindex, "type": "rx", "id": 1,
> +                             'rx-buf-len': rings['rx-buf-len'] * mul })
> +    except NlError as e:
> +        if e.error == errno.EOPNOTSUPP:
> +            raise KsftSkipEx('per-queue rx-buf-len configuration not supported')
> +        raise
> +
> +    reset = defer(cfg.netnl.queue_set, {'ifindex': cfg.ifindex,
> +                                        "type": "rx", "id": 1,
> +                                        'rx-buf-len': 0})
> +    # Make sure config stuck
> +    _check_queues_with_config(cfg, rings['rx-buf-len'] * mul, {1})
> +
> +    return rings, mul, reset
> +
> +
> +def per_queue(cfg, check_geometry=False) -> None:
> +    """
> +    Similar test to nic_wide, but done a single queue (queue 1).
> +    Flow filter is used to direct traffic to that queue.
> +    """
> +
> +    rings, mul, reset = _per_queue_configure(cfg)
> +    _check_queues_with_config(cfg, rings['rx-buf-len'] * mul, {1})
> +
> +    # Check with traffic, we need to direct the traffic to the expected queue
> +    port = rand_port()
> +    flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port} action 1"
> +    nid = _ethtool_create(cfg, "-N", flow)
> +    ntuple = defer(ethtool, f"-N {cfg.ifname} delete {nid}")
> +
> +    traf = GenerateTraffic(cfg, port=port)
> +    try:
> +        if check_geometry:
> +            _do_bpftrace(cfg, mul, rings['rx-buf-len'], tgt_queue=1)
> +    finally:
> +        traf.wait_pkts_and_stop(20000)
> +    ntuple.exec()
> +
> +    # And now direct to another queue
> +    flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port} action 0"
> +    nid = _ethtool_create(cfg, "-N", flow)
> +    ntuple = defer(ethtool, f"-N {cfg.ifname} delete {nid}")
> +
> +    traf = GenerateTraffic(cfg, port=port)
> +    try:
> +        if check_geometry:
> +            _do_bpftrace(cfg, 1, rings['rx-buf-len'], tgt_queue=0)
> +    finally:
> +        traf.wait_pkts_and_stop(20000)
> +
> +    # Back to default
> +    reset.exec()
> +    queues = cfg.netnl.queue_get({'ifindex': cfg.ifindex}, dump=True)
> +    for q in queues:
> +        ksft_not_in('rx-buf-len', q)
> +
> +
> +def per_queue_check_packets(cfg) -> None:
> +    per_queue(cfg, check_geometry=True)
> +
> +
> +def queue_check_ring_count(cfg, check_geometry=False) -> None:
> +    """
> +    Make sure the change of ring count is handled correctly.
> +    """
> +    rings, mul, reset = _per_queue_configure(cfg)
> +
> +    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
> +    if channels.get('combined-count', 0) < 4:
> +        raise KsftSkipEx('need at least 4 rings, have',
> +                         channels.get('combined-count'))
> +
> +    # Move the channel count up and down, should make no difference
> +    moves = [1, 0]
> +    if channels['combined-count'] == channels['combined-max']:
> +        moves = [-1, 0]
> +    for move in moves:
> +        target = channels['combined-count'] + move
> +        cfg.ethnl.channels_set({'header': {'dev-index': cfg.ifindex},
> +                                'combined-count': target})
> +
> +    _check_queues_with_config(cfg, rings['rx-buf-len'] * mul, {1})
> +
> +    # Check with traffic, we need to direct the traffic to the expected queue
> +    port1 = rand_port()
> +    flow1 = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port1} action 1"
> +    nid = _ethtool_create(cfg, "-N", flow1)
> +    ntuple = defer(ethtool, f"-N {cfg.ifname} delete {nid}")
> +
> +    traf = GenerateTraffic(cfg, port=port1)
> +    try:
> +        if check_geometry:
> +            _do_bpftrace(cfg, mul, rings['rx-buf-len'], tgt_queue=1)
> +    finally:
> +        traf.wait_pkts_and_stop(20000)
> +
> +    # And now direct to another queue
> +    port0 = rand_port()
> +    flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port0} action 0"
> +    nid = _ethtool_create(cfg, "-N", flow)
> +    defer(ethtool, f"-N {cfg.ifname} delete {nid}")
> +
> +    traf = GenerateTraffic(cfg, port=port0)
> +    try:
> +        if check_geometry:
> +            _do_bpftrace(cfg, 1, rings['rx-buf-len'], tgt_queue=0)
> +    finally:
> +        traf.wait_pkts_and_stop(20000)
> +
> +    # Go to a single queue, should reset
> +    ntuple.exec()
> +    cfg.ethnl.channels_set({'header': {'dev-index': cfg.ifindex},
> +                            'combined-count': 1})
> +    cfg.ethnl.channels_set({'header': {'dev-index': cfg.ifindex},
> +                            'combined-count': channels['combined-count']})
> +
> +    nid = _ethtool_create(cfg, "-N", flow1)
> +    defer(ethtool, f"-N {cfg.ifname} delete {nid}")
> +
> +    queues = cfg.netnl.queue_get({'ifindex': cfg.ifindex}, dump=True)
> +    for q in queues:
> +        ksft_not_in('rx-buf-len', q)
> +
> +    # Check with traffic that queue is now getting normal buffers
> +    traf = GenerateTraffic(cfg, port=port1)
> +    try:
> +        if check_geometry:
> +            _do_bpftrace(cfg, 1, rings['rx-buf-len'], tgt_queue=1)
> +    finally:
> +        traf.wait_pkts_and_stop(20000)
> +
> +
> +def queue_check_ring_count_check_packets(cfg):
> +    queue_check_ring_count(cfg, True)
> +
> +
> +def main() -> None:
> +    with NetDrvEpEnv(__file__) as cfg:
> +        cfg.netnl = NetdevFamily()
> +        cfg.ethnl = EthtoolFamily()
> +
> +        o = [nic_wide,
> +             per_queue,
> +             nic_wide_check_packets]

o?

