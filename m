Return-Path: <netdev+bounces-298166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pf8OFtHLKmqHxAMAu9opvQ
	(envelope-from <netdev+bounces-298166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:53:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F51672D9B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:53:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EOqITxrQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298166-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298166-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77E0A3084438
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1983388E5B;
	Thu, 11 Jun 2026 14:53:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F488FC0A
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 14:53:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189582; cv=none; b=AXJL8pE957uLmSOWkuegAysF6QUh0cXoauwrkQhbfmrc6Hw2p50vPE+QfjuRSV2dKfbA0DwROiwkAXCSodRC2JX/40cPTM2PUY9TMlei8x6rSRTPCDNtGvN4650nVKLY3gjzLfkqRiyxK4tfZbIHo/5fEbcxBD/EWZg6Is7tu20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189582; c=relaxed/simple;
	bh=9UskbZJ/G7EaPv3isuQ0X+3eqMOVJOo5I4HimWSTnLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0Jq4kHfeGhA59g47lkn8repcTXMAfJN7+uyoDtRcjPVQWn3MpMeahoRc4QIotOR7dse50BbZ8b3LA7FLnr8LC8gJcZ0Ya7WI4WfqsGU8gOEk4d4ZFIMY0GHVjwMH+5XM7k0pBtTvPruyc0eRfQZP1c36swsLf7jaPbmajtiOM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOqITxrQ; arc=none smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8423f869421so6037468b3a.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 07:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781189580; x=1781794380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x6oRtyUHZtz2EkgHvit/MB+Qj4WxWb8BIkMgxeX1Q1c=;
        b=EOqITxrQDWv9dOtaX7OOa+EDpFfgY7yOH47qdHM5ShDEZgEj6yjoY696r0BEqjCuE/
         NSl09qciii0rhr7qBcOOfZaW+znwTe+lbl8K2f2qTQohdAlL5biMto5fo/P/HvLz9V89
         W9Fge88EttTH3Ld36A+KLnQQU0ThJVImnskSbfSTrUhA5gKfCXyqupl5MU5ehGRKacg0
         WZrfYH8zDPxJnmzxHwiDVAerrzDXn4M4uSHfDeHXewqwQl9MccLmhtLqhAHfAPMxsbVq
         GVZpeV+IGh0LItKSaXcDflKCxuVQi67lrcLTuK7snvy+2BEz2B/Kii72qkAU1qUZf0nC
         60zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781189580; x=1781794380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6oRtyUHZtz2EkgHvit/MB+Qj4WxWb8BIkMgxeX1Q1c=;
        b=AKyscdw2m11yfiz9ckTVUiI9FVXJk3NyUcc8lBvIDfWlmpRykmzgL6Epmfa55bZGfM
         Z0/ny55H6ZXESaSmghmy7aOZGBDbizNcFsADf5VSYw6rhPYdnvXa+b9jmMB16npokCNT
         0jtjjQux35OygitGwO0tiz7bdkav2KaYFKACcrGMeiEGmeVoQQDrr45O53CPPy5P2LTl
         7kNUrAnhZnkWwHqkKPqeghlRpWyp6TEtYv7d5JmYJXLprf0Cf7DVlf08RQX8EJcb1SDw
         KF0FXdSiqnpYGw5dpRnNnbPhQMh5o6zqc7VT8/mt9A09Mda98VbOIdiNimPnCqe6AngD
         zksQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xDg2mQfzGIjEXLAdfXgBSBqxEeU7gie6PM3RiNPgLzlVPPmKvtP1rDSc3cDdug/quwbJHcZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmKcNK84sXRReLfqobRU7X+9LM5lZjudCp6uS1BhOPkfGm2632
	U4Yffmym2Fb0gCM5F6E1CBYSbcCQ7qof9pPp2TwuAv50vBIrhl06ZsH/
X-Gm-Gg: Acq92OG/Fk8qLAEYCw0wnQd6vm0WxjaS7Mq+2wZaAPuHGc6G/rg1bHGtuZxn30dUhTc
	fltlP/dWEGY9ltn4OcxphRFILvf3ZdPHSUJScGF7VafT0fYOpC1wHqL60duTsa9LZwHs3w1ymOT
	POnXSPTviMaEpiNjN6k8cIvEJRYD2Rf3dERGrYqr6++Fk5YDMjnvrlkJq3ml3MpKaD7y4H0r5hF
	Wrr+/fYboKDMBZUq55KZ2G2tIXnkhyLgqhA9/FNj3rEkcws8yrCAMYwZh1pvgpZe16jK3qadYJO
	hZ8zOulDBj7Dc7nwa0p7/2w9muAVaIKZTH7vmULchxJOywN9p1TEJtlOsJVm79r/WFMMALcC3F6
	ygALhuJiw9CXbhkuHFF0uKLaU9/NmPagTw/d/6HacwnR1YPR99n9jGwFlLmFDUpsJ9Rcq8YvIHQ
	xJlQlTFKk+UaZVXnevaS5VN4tfG8NNFrXPnMURk1b/DxiDqQgA6zbDLA==
X-Received: by 2002:a05:6a00:3ccc:b0:842:614e:cc8a with SMTP id d2e1a72fcca58-84336a8cf84mr3436613b3a.28.1781189580471;
        Thu, 11 Jun 2026 07:53:00 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8433831920dsm2370761b3a.53.2026.06.11.07.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 07:53:00 -0700 (PDT)
Date: Thu, 11 Jun 2026 07:52:58 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, razor@blackwall.org, bobbyeshleman@meta.com,
	dw@davidwei.uk, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] selftests/net: Add netkit io_uring ZC
 test for large rx_buf_len
Message-ID: <airLyuaNdUAn3JZ1@devvm29614.prn0.facebook.com>
References: <20260611082527.741674-1-daniel@iogearbox.net>
 <20260611082527.741674-4-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611082527.741674-4-daniel@iogearbox.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298166-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:kuba@kernel.org,m:razor@blackwall.org,m:bobbyeshleman@meta.com,m:dw@davidwei.uk,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lib.py:url,iogearbox.net:email,devvm29614.prn0.facebook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71F51672D9B

On Thu, Jun 11, 2026 at 10:25:26AM +0200, Daniel Borkmann wrote:
> Add test_iou_zcrx_large_buf, which runs iou-zcrx with rx_buf_len >
> page size (-x 2) through a netkit-leased RX queue. The netkit ifindex
> is opaque to io_uring, but rx_page_size is honoured by the leased
> physical qops via netif_mp_open_rxq()'s lease redirect.
> 
> Originally, I also added a BIG TCP variant on top, but dropped it
> here as fbnic (and the QEMU fbnic model) has no BIG TCP support
> to exercise it as this point.
> 
> Tested against the QEMU fbnic emulation. The new test exercises
> the > page rx_buf_len path only when the leased NIC advertises
> QCFG_RX_PAGE_SIZE; otherwise it skips.
> 
> For fbnic, I used Bjorn's patches locally [0]:
> 
>   # ./nk_qlease.py
>   TAP version 13
>   1..5
>   ok 1 nk_qlease.test_iou_zcrx
>   ok 2 nk_qlease.test_iou_zcrx_large_buf
>   ok 3 nk_qlease.test_attrs
>   ok 4 nk_qlease.test_attach_xdp_with_mp
>   ok 5 nk_qlease.test_destroy
>   # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Without those patches (aka not advertising QCFG_RX_PAGE_SIZE):
> 
>   # ./nk_qlease.py
>   TAP version 13
>   1..5
>   ok 1 nk_qlease.test_iou_zcrx
>   ok 2 nk_qlease.test_iou_zcrx_large_buf # SKIP Large chunks are not supported -95
>   ok 3 nk_qlease.test_attrs
>   ok 4 nk_qlease.test_attach_xdp_with_mp
>   ok 5 nk_qlease.test_destroy
>   # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://lore.kernel.org/netdev/20260522113225.241337-1-bjorn@kernel.org/ [0]
> ---
>  .../selftests/drivers/net/hw/nk_qlease.py     | 107 +++++++++++++++++-
>  1 file changed, 106 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/nk_qlease.py b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
> index b97663820ccf..4f53034c9a50 100755
> --- a/tools/testing/selftests/drivers/net/hw/nk_qlease.py
> +++ b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
> @@ -32,6 +32,31 @@ from lib.py import (
>  )
>  from lib.py import KsftSkipEx, CmdExitFailure
>  
> +# iou-zcrx exits with 42 from setup_zcrx() when the NIC does not advertise
> +# QCFG_RX_PAGE_SIZE (or otherwise rejects the requested rx_buf_len).
> +SKIP_CODE = 42
> +
> +
> +def _restore_hugepages(count):
> +    with open("/proc/sys/vm/nr_hugepages", "w", encoding="utf-8") as f:
> +        f.write(str(count))
> +
> +
> +def _mp_clear_wait(cfg, src_queue):
> +    """Wait for the io_uring memory provider to clear from the leased
> +    physical queue; io_uring tears it down asynchronously after the
> +    process holding the ifq exits."""
> +    netdevnl = NetdevFamily()
> +    deadline = time.time() + 5
> +    while time.time() < deadline:
> +        queue_info = netdevnl.queue_get(
> +            {"ifindex": cfg.ifindex, "id": src_queue, "type": "rx"}
> +        )
> +        if "io-uring" not in queue_info:
> +            return
> +        time.sleep(0.1)
> +    raise TimeoutError("Timed out waiting for memory provider to clear")
> +
>  
>  def _create_netkit_pair(cfg, rxqueues=2):
>      if cfg.nk_host_ifname:
> @@ -188,6 +213,80 @@ def test_iou_zcrx(cfg) -> None:
>          cmd(tx_cmd, host=cfg.remote)
>  
>  
> +def test_iou_zcrx_large_buf(cfg) -> None:
> +    """iou-zcrx with rx_buf_len > page size, going through a netkit-leased
> +    queue. Exercises the queue rx-buf-len path via netif_mp_open_rxq()'s
> +    lease redirect: the netkit ifindex is opaque to io_uring, but
> +    rx_page_size is honoured by the *physical* qops because the lease
> +    pointer rewrites the request from netkit onto the leased physical
> +    rxq before supported_params/validate_qcfg are consulted.
> +    """
> +    cfg.require_ipver("6")
> +    src_queue, nk_queue = _setup_lease(cfg)
> +    defer(_teardown_netkit, cfg)
> +    ethnl = EthtoolFamily()
> +
> +    with open("/proc/sys/vm/nr_hugepages", "r+", encoding="utf-8") as f:
> +        nr_hugepages = int(f.read().strip())
> +        if nr_hugepages < 64:
> +            f.seek(0)
> +            f.write("64")
> +            defer(_restore_hugepages, nr_hugepages)
> +
> +    rings = ethnl.rings_get({"header": {"dev-index": cfg.ifindex}})
> +    rx_rings = rings["rx"]
> +    hds_thresh = rings.get("hds-thresh", 0)
> +
> +    ethnl.rings_set(
> +        {
> +            "header": {"dev-index": cfg.ifindex},
> +            "tcp-data-split": "enabled",
> +            "hds-thresh": 0,
> +            "rx": 64,
> +        }
> +    )
> +    defer(
> +        ethnl.rings_set,
> +        {
> +            "header": {"dev-index": cfg.ifindex},
> +            "tcp-data-split": "unknown",
> +            "hds-thresh": hds_thresh,
> +            "rx": rx_rings,
> +        },
> +    )
> +
> +    ethtool(f"-X {cfg.ifname} equal {src_queue}")
> +    defer(ethtool, f"-X {cfg.ifname} default")
> +
> +    flow_rule_id = set_flow_rule(cfg, src_queue)
> +    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
> +
> +    # -x 2 asks iou-zcrx for rx_buf_len = 2 * page_size (8 KiB on x86_64),
> +    # backed by a 2 MiB hugepage area so the chunks are physically
> +    # contiguous, which is what zcrx requires for non-default rx_buf_len.
> +    rx_cmd = (
> +        f"{cfg.bin_local} -s -p {cfg.port} "
> +        f"-i {cfg.nk_guest_ifname} -q {nk_queue} -x 2"
> +    )
> +    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.nk_guest_ipv6} -p {cfg.port} -l 12840"
> +
> +    # Probe via -d (dry run): exits with SKIP_CODE if the leased physical
> +    # qops doesn't advertise QCFG_RX_PAGE_SIZE (e.g. older bnxt FW/HW).
> +    probe = cmd(rx_cmd + " -d", fail=False, ns=cfg.netns)
> +    if probe.ret == SKIP_CODE:
> +        msg = probe.stdout.strip() or "rx_buf_len not supported by leased NIC"
> +        raise KsftSkipEx(msg)
> +
> +    # A successful dry run still registered the zcrx ifq on the leased
> +    # physical queue; wait for its async teardown before the real server
> +    # binds the same queue.
> +    _mp_clear_wait(cfg, src_queue)
> +
> +    with bkg(rx_cmd, exit_wait=True, ns=cfg.netns):
> +        wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
> +        cmd(tx_cmd, host=cfg.remote)
> +
> +
>  def test_attrs(cfg) -> None:
>      cfg.require_ipver("6")
>      src_queue, nk_queue = _setup_lease(cfg)
> @@ -350,7 +449,13 @@ def main() -> None:
>          cfg.port = rand_port()
>  
>          ksft_run(
> -            [test_iou_zcrx, test_attrs, test_attach_xdp_with_mp, test_destroy],
> +            [
> +                test_iou_zcrx,
> +                test_iou_zcrx_large_buf,
> +                test_attrs,
> +                test_attach_xdp_with_mp,
> +                test_destroy,
> +            ],
>              args=(cfg,),
>          )
>      ksft_exit()
> -- 
> 2.43.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

