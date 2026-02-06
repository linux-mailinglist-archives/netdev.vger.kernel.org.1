Return-Path: <netdev+bounces-257649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFdGJk03hmmHLAQAu9opvQ
	(envelope-from <netdev+bounces-257649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 19:47:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 105E510239D
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 19:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23EFA30143DF
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 18:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207F4423A94;
	Fri,  6 Feb 2026 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxwwPbUZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01EC304972
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 18:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770403514; cv=none; b=BVb6Srw0ikcQYrMxRezNDgdAXFeiP7vOMGSVph+5TvQLSPktMcaXbBhNRNVKvst6gN273ltKMy317nC76elPV3gpK4tud0uaDTZgvg3CzRZsT6pF6cf25MN6Mpa7mWE9qLo2X9bQXY3+adgZdW+HESfrT30+RQkxOMXwGx8c4YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770403514; c=relaxed/simple;
	bh=xYAr1VD0m5Cm0i/hSi3pqzo/xeelnf4R5TTCEpYeUo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMVaWx5e28t8lhWoVa81/OabPqDe2cI5GSmm8BONsmsIu4075h5OpbdWalS6zWIQ9Uky95rT0+B8KRsR5QXFcSC/ldHbHE1zhoJVSAt3SnojRZa1iG0trozSWBmyCyavq+3eJYvTa2wPWYi8sRA4hi7gWq9FZz46M3PrU7ji3v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxwwPbUZ; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-649e456e8a2so2513247d50.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 10:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770403513; x=1771008313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XfLvf4bDBja7Ue7KPMMjqL8WIjMGp/jmDLDyA8iJldM=;
        b=BxwwPbUZ6QJdaIwduypqQVk8Evz+KP0dEb/I814+YlLZu7eoqsz/ygluxcUY1s5ZJl
         LcUbMHR+/r7GgjovfdH8f2+xa5DpBmcrMRU89AC/M52+vQy/N//wRXi+5AtSU44UYR8+
         tiXmZapb5Qpuc6moPskDL74aBzKFCndgiBe30Zvw8/1XrWrkwJ/X6thLm6N5U+vHOnHm
         gtEN3Kx1cCNzUYBEQtpfbV3SM1EpYJ70RSI0rCZMO86wB9sxTgW1oIskcuozkmlGV4zS
         +3oeYofNya5feIz4IAQbNIblRk9MPtNGRSnObEpwelNxZfPNID3RnUBt6ZQezdj3rQkn
         BAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770403513; x=1771008313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfLvf4bDBja7Ue7KPMMjqL8WIjMGp/jmDLDyA8iJldM=;
        b=XWpwhSn+REog2ZJNykkTvc84qXiq1HlgQPJsbnu4yKu4Gg1Wt5aGBdCiDe6dMqLCgR
         afpNBjCPhjdr1GynQEqkCf5HxcHHIEZUeG6fFeD7zFM1Jg3sQPZa2NsOKDBGIqasFX8i
         6FsHBLYsL4V/nsV82UgrhKfEowty1U2DMOnO2E4qQXV+IN/aSVF7HlN/Mpd6ikI38JbN
         iLJpzjsHoA+yIM4eD9PfFO5OepaQazIDlcINb/KqDDk1pplq0Ld0GoZIBLbc+zpVn0q9
         wZxOs8ySBp0kRexi6T0JPFGlrbkRwhLf6ZxM4bGTGiBIkKtn1AmCAkiWh2oDhsuvo94M
         mUVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL5/gvgrqav/h9Kr+qrkNmmlKMdjY0iofo934zuNSX4SfJzdqSeeLL9l9bHRn12uak+QU9Zr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB0Dcnepiq72iBtExetLdQC83Nh0KwaTz2wZGnzn6RvuxEgzcX
	o+lk0uDrL42w8mPx3Wjj6gYM9keciJIzacdg4+ibeVBGlZDdCMEylzpO
X-Gm-Gg: AZuq6aISfpI3fblfNmojinGIH4MiiloL6iq3M1K8RmBLECvwHUMn/sMSU5+YaeOVo/e
	1aUVTW8EoXIG3jfar/0MsGXU3cGJjkCt3CKW6xk2qc+2TS3VHyEFImj6KW2pCfgo58om6ubUUMR
	dqBawwVFTqTMoaXGBM3p2PYdN18AAiK4oVbZV0FCsEhf74pN4AyJS83z+H9JV73+nqqxtIDJMdo
	V4ZlyxU5eniz5D62ga1r0pszitXo3iPL6phYzoz+5BsRO+rW04AHSs8CzNzOKv7vxoECAAdvLmz
	4RkZAjNFKfabmOpW2J37U1D3mKrwXyHPFxIyi8SbySjdpGtE6Q4XE/oDBlGYLtqwGWcExTkXFkn
	tBEbd/vjhZeiP7t5XVGuf6dNIobYK9qNkjd7xFLY4ZuD8bzoMHW36PuocWLqZ9a9YxEIFlUT7c/
	MnjwVnCz4ytpZU+1z0+L85hLkOpsbDtFzA5eo=
X-Received: by 2002:a05:690c:6f03:b0:78e:1aa5:e98a with SMTP id 00721157ae682-7952ab2517bmr74469677b3.37.1770403512631;
        Fri, 06 Feb 2026 10:45:12 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:51::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a013704sm28536797b3.11.2026.02.06.10.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 10:45:12 -0800 (PST)
Date: Fri, 6 Feb 2026 10:45:05 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net v2 4/4] selftests: drv-net: rss_ctx: test RSS
 contexts persist after ifdown/up
Message-ID: <aYY2sak4adKOGRSv@devvm11784.nha0.facebook.com>
References: <20260206052930.1882740-1-michael.chan@broadcom.com>
 <20260206052930.1882740-5-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206052930.1882740-5-michael.chan@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257649-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,utils.py:url]
X-Rspamd-Queue-Id: 105E510239D
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 09:29:30PM -0800, Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> Add a test to verify that RSS contexts persist across interface
> down/up along with their associated Ntuple fitlers. Another test
> that creates contexts/rules keeping interface down and test their
> persistence is also added.
> 
> Tested on bnxt_en:
> 
>  TAP version 13
>  1..1
>  # timeout set to 0
>  # selftests: drivers/net/hw: rss_ctx.py
>  # TAP version 13
>  # 1..2
>  # ok 1 rss_ctx.test_rss_context_persist_create_and_ifdown
>  # ok 2 rss_ctx.test_rss_context_persist_ifdown_and_create # SKIP Create context not supported with interface down
>  # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
> v2: Many improvements suggested by Jakub:
> 1. simplified the tests to have only 2 contexts, use one of the contexts
> to test ntuple filters' persistence also 
> 2. used @ksft_disruptive for the test
> 3. used netlink API to get rss contexts
> 
> v1: https://lore.kernel.org/netdev/20260129061646.1417185-5-michael.chan@broadcom.com/
> ---
>  .../selftests/drivers/net/hw/rss_ctx.py       | 102 +++++++++++++++++-
>  1 file changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> index ed7e405682f0..f72162ee9dc3 100755
> --- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> +++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> @@ -4,11 +4,13 @@
>  import datetime
>  import random
>  import re
> +import time
>  from lib.py import ksft_run, ksft_pr, ksft_exit
>  from lib.py import ksft_eq, ksft_ne, ksft_ge, ksft_in, ksft_lt, ksft_true, ksft_raises
>  from lib.py import NetDrvEpEnv
>  from lib.py import EthtoolFamily, NetdevFamily
>  from lib.py import KsftSkipEx, KsftFailEx
> +from lib.py import ksft_disruptive
>  from lib.py import rand_port
>  from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
>  
> @@ -809,6 +811,102 @@ def test_rss_default_context_rule(cfg):
>                            'noise' : (0, 1) })
>  
>  
> +@ksft_disruptive
> +def test_rss_context_persist_ifupdown(cfg, pre_down=False):
> +    """
> +    Test that RSS contexts and their associated ntuple filters persist across
> +    an interface down/up cycle.
> +
> +    """
> +
> +    require_ntuple(cfg)
> +
> +    qcnt = len(_get_rx_cnts(cfg))
> +    if qcnt < 6:
> +        try:
> +            ethtool(f"-L {cfg.ifname} combined 6")
> +            defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
> +        except:
> +            raise KsftSkipEx("Not enough queues for the test")
> +
> +    ethtool(f"-X {cfg.ifname} equal 2")
> +    defer(ethtool, f"-X {cfg.ifname} default")
> +
> +    if pre_down:
> +        ip(f"link set dev {cfg.ifname} down")
> +
> +    try:
> +        ctx1_id = ethtool_create(cfg, "-X", "context new start 2 equal 2")
> +        defer(ethtool, f"-X {cfg.ifname} context {ctx1_id} delete")
> +    except CmdExitFailure:
> +        if pre_down:
> +            ip(f"link set dev {cfg.ifname} up")
> +            raise KsftSkipEx("Create context not supported with interface down")
> +        raise
> +
> +    ctx2_id = ethtool_create(cfg, "-X", "context new start 4 equal 2")
> +    defer(ethtool, f"-X {cfg.ifname} context {ctx2_id} delete")
> +
> +    port_ctx2 = rand_port()
> +    flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port_ctx2} context {ctx2_id}"
> +    ntuple_id = ethtool_create(cfg, "-N", flow)
> +    defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}")
> +
> +    if not pre_down:
> +        ip(f"link set dev {cfg.ifname} down")
> +
> +    ip(f"link set dev {cfg.ifname} up")
> +
> +    import subprocess
> +    max_wait = 10
> +    ping_success = False
> +    remote_addr = cfg.remote_addr_v[cfg.addr_ipver]
> +    for attempt in range(max_wait):
> +        try:
> +            result = subprocess.run(['ping', '-c', '1', '-W', '1', remote_addr],
> +                                  capture_output=True, timeout=2)
> +            if result.returncode == 0:
> +                ping_success = True
> +                break

This might be wanting to use utils.py's cmd()?

> +        except Exception:
> +            pass

> +        time.sleep(1)
> +
> +    if not ping_success:
> +        raise KsftSkipEx("Cannot reach remote host after interface up")
> +
> +    ctxs = cfg.ethnl.rss_get({'header': {'dev-name': cfg.ifname}}, dump=True)
> +
> +    data1 = [c for c in ctxs if c.get('context') == ctx1_id]
> +    ksft_eq(len(data1), 1, f"Context {ctx1_id} should persist after ifup")
> +
> +    data2 = [c for c in ctxs if c.get('context') == ctx2_id]
> +    ksft_eq(len(data2), 1, f"Context {ctx2_id} should persist after ifup")
> +
> +    _ntuple_rule_check(cfg, ntuple_id, ctx2_id)
> +
> +    cnts = _get_rx_cnts(cfg)
> +    GenerateTraffic(cfg).wait_pkts_and_stop(20000)
> +    cnts = _get_rx_cnts(cfg, prev=cnts)
> +
> +    main_traffic = sum(cnts[0:2])
> +    ksft_ge(main_traffic, 18000, f"Main context traffic distribution: {cnts}")
> +    ksft_lt(sum(cnts[2:6]), 500, f"Other context queues should be mostly empty: {cnts}")
> +
> +    _send_traffic_check(cfg, port_ctx2, f"context {ctx2_id}",
> +                        {'target': (4, 5),
> +                         'noise': (0, 1),
> +                         'empty': (2, 3)})
> +
> +
> +def test_rss_context_persist_create_and_ifdown(cfg):
> +    test_rss_context_persist_ifupdown(cfg, pre_down=False)
> +
> +
> +def test_rss_context_persist_ifdown_and_create(cfg):
> +    test_rss_context_persist_ifupdown(cfg, pre_down=True)
> +
> +
>  def main() -> None:
>      with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
>          cfg.context_cnt = None
> @@ -823,7 +921,9 @@ def main() -> None:
>                    test_rss_context_out_of_order, test_rss_context4_create_with_cfg,
>                    test_flow_add_context_missing,
>                    test_delete_rss_context_busy, test_rss_ntuple_addition,
> -                  test_rss_default_context_rule],
> +                  test_rss_default_context_rule,
> +                  test_rss_context_persist_create_and_ifdown,
> +                  test_rss_context_persist_ifdown_and_create],
>                   args=(cfg, ))
>      ksft_exit()
>  
> -- 
> 2.51.0
> 

