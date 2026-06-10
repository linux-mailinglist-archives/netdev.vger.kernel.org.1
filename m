Return-Path: <netdev+bounces-297858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eJ8IIi7zKWoPgAMAu9opvQ
	(envelope-from <netdev+bounces-297858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:28:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF46D66D604
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:28:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cysusgAb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297858-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297858-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5594830B2296
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 23:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBEE374A06;
	Wed, 10 Jun 2026 23:28:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD3F299A82
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 23:28:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781134123; cv=none; b=i84AEbhgAdiRZNluH74CVp5BECDHjqGGV+k+7KFvzhQkjPfMU2vxy5XksvEvJY84vhy/uDaIN4f/qxizGo1WFLJ9n+5xAw5tcpYktTZTXrMnVokOJGbc7Xpp2x1UpjCzAR4xzKVf/fZCvZngIRDAUJsd8zYtpn4MJmquIlqq56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781134123; c=relaxed/simple;
	bh=2MCx7xXUuR2MZ+dBUkkAXLqm6iPrh+NkujPunW9Vi1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oa0yy7FHeFwGUygJRrVdMY65uuVyy7JMyqfFIDuS5ch3zKrlpX7Iq+GKbO2jj4L7IVKzUy999T+iRWP88gT6DS9EfUvhP7m5Esuh1ntpeu7AVPq5/Ah0NErIFDCt6kiu+Ju67YCPjOO+7sC8wbpn5ERYQ/q7O0z/j0i7g3GSkm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cysusgAb; arc=none smtp.client-ip=209.85.215.181
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c8573e75425so2890772a12.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781134122; x=1781738922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bApNCJj+6mfr9htyuIkxWvuo7x/w+UoH39HdrUr7PRM=;
        b=cysusgAbhafXHMTnXne4hewJQg7BUY+AmfbT9iF0uLZc5nVHrbhzJopnGiqDtl6Xcw
         8ibW1TqqHNYMiwSNEV/yn/KjLU0bgG2kn/QpyfY2raL3upiCBk4/O/JwuYmZdMTKmbFf
         ykscNrsPYJYFZWIoywA5bU6eUsee1CTMwDDnAg3taJy4FfY2XwgcjG3VJprjzQ3EOKct
         WsOdEpWYPahBwf27KDxlcj3C1+eOmUas17kwTIuNhIghgmB/OrqM4zvHuYbVM0LliasI
         XOstL+RUBdn4+ACfzL0Zsx6unhrxns4xwrLojTYq4nYzmP408SW+ppO2Vz/pA6LJco+O
         ifkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781134122; x=1781738922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bApNCJj+6mfr9htyuIkxWvuo7x/w+UoH39HdrUr7PRM=;
        b=n+8COBgzy1wBeCPNXQI6e5rpoTgWcy0VZnJNjn07+g1h/LYUzUH0RwyhEOz35pI4mu
         e/g12rtAKQjE41XC3mc7ybyadDOivProvtsfz694uMDx9wfFUc6PX9uc72ORGoqFPJDv
         7kdU8jPNRJ8+XPgamc/k0Z1Xro/cwL4xCc+odxJbt+rwnbSxFZLw2XIBxTT/VhvjQohS
         ROVq0GTPCjHCuuJX9NUDBKN1FHIhhUFbSo11cRYvPhEK8zQZhYOJ6azxNis4+9UV8y95
         p0n2qqAUPWGWxiZdsuVkeN61kqqriP5kaUVQFSSyP93Q77rVO5U913hNV5eS7ulWHk2P
         2ipQ==
X-Forwarded-Encrypted: i=1; AFNElJ+DcgJA5E4ryKCCtTMMyUnsxr1cE9T45DSRRF8wWJRhLv5FrbPW4+QUuSIW6Flac1Jur2XYEfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfSOui0gdoVAqvyX6l5xoq09y8ZEihoezt5KsQKCfEj1KHamvF
	x2qvCMT1zEnUrfDBSD3tusm6gdsMaLMwGDuQ/Kz3bXPx4TkvH3JYmTVO
X-Gm-Gg: Acq92OEeI/2GUBlZ0hrVhU26sYH/u5d4nQSjSVJwuWQWXEo4jzSyT7SKUGp07FY37LD
	Kn4aQYgG8I95dcBdLc67tA2Ll1eRi4FxaOiQSEbVv+AdxxyDm+OngJpuQE0tB3T9d05XCWga0xQ
	01Ra/XpgXhOvhCaepgAq8NJEAucZAANcAWq6rz/JwrbN1w4+7pkWNV6jD2BLxS4EjixAn9Gyz7x
	k003wNBD+P1eHUKJYbKNrcelq4pO+O6GVgLxiL9IiPuNTx+va7bVz4TRikgPXrIb3JFnognu6Gp
	pCzeBlJ3FJRGU6Q62MRwdjVRBQlwGhoKMAmQSizqVEf5sQ9beklXS/CNvV1pUDzr+4kJd0bzQAp
	NvKKUl7raXI1Hxu3paog9JzLgOFrFFW2O7/9tLASRvOQh87lxFEtNbtUpfO9hhmVcOPYY7PoZ03
	OO7qlDNJ3wQwLBAaQdjfDDaEQUUFYLfvyXNmcC/IeecrU5yYQeQGEMRqg=
X-Received: by 2002:a05:6a00:4f86:b0:841:edb9:4ea2 with SMTP id d2e1a72fcca58-84336be426emr22920b3a.32.1781134121619;
        Wed, 10 Jun 2026 16:28:41 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282916b10sm25914222b3a.58.2026.06.10.16.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:28:41 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:28:39 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, razor@blackwall.org, bobbyeshleman@meta.com,
	dw@davidwei.uk, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] selftests/net: Add netkit io_uring ZC test
 for large rx_buf_len
Message-ID: <ainzJx27MlX3WhLV@devvm29614.prn0.facebook.com>
References: <20260610080344.701380-1-daniel@iogearbox.net>
 <20260610080344.701380-4-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610080344.701380-4-daniel@iogearbox.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297858-lists,netdev=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[netns.name:server fail,vger.kernel.org:server fail,lib.py:server fail,iogearbox.net:server fail,devvm29614.prn0.facebook.com:server fail,sea.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:kuba@kernel.org,m:razor@blackwall.org,m:bobbyeshleman@meta.com,m:dw@davidwei.uk,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF46D66D604

On Wed, Jun 10, 2026 at 10:03:43AM +0200, Daniel Borkmann wrote:
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
>  .../selftests/drivers/net/hw/nk_qlease.py     | 86 ++++++++++++++++++-
>  1 file changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/nk_qlease.py b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
> index fee114676fd8..90d688453ddf 100755
> --- a/tools/testing/selftests/drivers/net/hw/nk_qlease.py
> +++ b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
> @@ -32,6 +32,15 @@ from lib.py import (
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
>  
>  def _create_netkit_pair(cfg, rxqueues=2):
>      if cfg.nk_host_ifname:
> @@ -188,6 +197,75 @@ def test_iou_zcrx(cfg) -> None:
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
> +        f"ip netns exec {cfg.netns.name} {cfg.bin_local} "
> +        f"-s -p {cfg.port} -i {cfg.nk_guest_ifname} -q {nk_queue} -x 2"
> +    )

Could cmd(..., ns=cfg.netns) be used instead of ip netns exec?

> +    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.nk_guest_ipv6} -p {cfg.port} -l 12840"
> +
> +    # Probe via -d (dry run): exits with SKIP_CODE if the leased physical
> +    # qops doesn't advertise QCFG_RX_PAGE_SIZE (e.g. older bnxt FW/HW).
> +    probe = cmd(rx_cmd + " -d", fail=False)
> +    if probe.ret == SKIP_CODE:
> +        msg = probe.stdout.strip() or "rx_buf_len not supported by leased NIC"
> +        raise KsftSkipEx(msg)

Since -d can still install an mp, does this also need mp_clear_wait()?

The rest below looks good to me!

Best,
Bobby

> +
> +    with bkg(rx_cmd, exit_wait=True):
> +        wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
> +        cmd(tx_cmd, host=cfg.remote)
> +
> +
>  def test_attrs(cfg) -> None:
>      cfg.require_ipver("6")
>      src_queue, nk_queue = _setup_lease(cfg)
> @@ -350,7 +428,13 @@ def main() -> None:
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

