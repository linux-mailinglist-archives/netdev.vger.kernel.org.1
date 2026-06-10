Return-Path: <netdev+bounces-297864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u85TMEP4KWpWgQMAu9opvQ
	(envelope-from <netdev+bounces-297864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:50:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A3D66D6F5
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:50:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=T0T5L81F;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297864-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297864-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19B38301724E
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 23:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F9A37BE95;
	Wed, 10 Jun 2026 23:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEBE2E62B7
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 23:50:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781135424; cv=none; b=B20K58wqNOsA53rPdgWDWKTH6wkRYfD8lMZ8nvFyI/d/lI97rMJNtt3TpDaqNd+7nwPs01SxXx2HnCROznw5FpFeQBTunkhA0vW4xVEk6E5GffCSHqiXkOqM44/sXPvYUEjVc+qxN//KlSoj04Vh05DbVcWS5xuuPBph+kDwG6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781135424; c=relaxed/simple;
	bh=Jfq0XmS9yNn6kphlezBFZ3/UU5AaocF07pK3/s/+rQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BookcnnO6mlFtfOJ7vB1Zx5wsZvXR0SCPUmc2gP2RL1K+e3NQMN9d2ZhhyX2AcwCs143b6yuoP+OL/r0EI8cz2nlWKgyYoHnSoEP0jTTvyy3hZVTAl5J8xQe+0qZ/Zlh01AjNDZ1hY2bQuPH/bRbStc/Ue03lJf64LrV93M7Xds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0T5L81F; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0c2c7d45eso66250945ad.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781135422; x=1781740222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a8inCSQ5MsU/go4x5mVraE8DEnfTIi+whQe5odAyqyg=;
        b=T0T5L81F+Dam3DrY/tojOe097uU/TG8Ed6ZCfFcoqhqYyTCTCT+WPuG6VF+KErSI0e
         82a+pSnkueGinKOQxY4o3Ly7OtfTHierwxeHH177RdLpu9HLo6qcRTrZb9XWTI3FlokK
         B4vJhxKFMAYlv+sk4ArbQJNx6LZ9yaEX9Z8j8xeRb35ilNR2jrazIgcV21A0F3zPVNKz
         KAUUcfEmYLfd3nAUrz4/8WiWJvyVDyNIW1zIlRxqx1YWiIR20N51PNj9Qx59uDMlFW5v
         8l2OCvIHVT9752q1SNFLd20PzCgtNfvYn49/AD4FvRg1Ovk8GF0/cLd+M9l6Lm3UyuZt
         iJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781135422; x=1781740222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8inCSQ5MsU/go4x5mVraE8DEnfTIi+whQe5odAyqyg=;
        b=coLvCCik36YTp2JiZdCtkSZLlTazyZAcm/WaXt+nzctt0QMPHHsXu7OMPpPsQvW029
         7o9majeBvuEgtKZDn02fJUJBsTPD9X0Q6zg+XGLec3UgGKKmGgJT4hOHw4RCVVPcxA0T
         kLJBicLPLmX4spVM4in3Hgv7SkETnSWnxqqT6v46zb1DTqf4Lvu6wJocmb3Rdq6+aWE4
         k4gxD8z8QSQ+6NZYKVaJS6hebQJDQJOAdADnqS4tkdDLuoIVudpfngPZqve1U6moowtm
         ASFs00tMHa/jm3wHirZwXyGaB7wvQKKojRHTPc8eeFXMZ9WHg88EljKOzTaWUlASujwa
         Du6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+7uUFdLz65q6FLNlt+xDueiDKsq6gMUkObx+xJM7H3d+1cysV+wbvtLiEvPd6F9LMqRJ8aav0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNapTl2u8Uqo3x+vpGBz8v4lpaq8JymWshriiFa7x4gZXPpvQY
	ypZ+VruSrySttK9ayEDiPYdekDbtshPEfBHFV1or2PTiYxqGyzq7sash
X-Gm-Gg: Acq92OF/0deOvOx9osiN/+IABHlwaE1q9Qh+y0KX0A/t6InGlb/J/3m2HmAkAuGqDsz
	WMMA11FB1BVUxWuLJxXhxigNQ6pKw52GWplu+q9xX0y1OHT8/gycmRwDpucNB4AJ8zvG4BHqHz8
	spx7sF6LM3JJb/rMBWGJbJpe07cJwZtj1DKeQwcS9ymr+QOLSSH1rJnudEUHKsQqw7F3nlFPSkJ
	W4ktcSc5p91ufWQiPUASExTM9pyHc+nmBE1sPaIrB4m+jraHLfWdiMafnrVVEdY+PQslosHviy1
	MTSLnGwXynuJVL+O6gmC5I1037o4sz8uZxXBIcE7R7TeBe/7IqPCGhV3hP8EIqq10gqNYu5gnp6
	deCmHsbUoy4HX9yU02ZlL3ZmVRFtnWuljoWpzgTASMTsqodlUjpExorjNiSCnQ/XE4GWBZZUe2m
	wJGhG+7EJelPngrkYCgbJDZx0nJPAXUq4wJR37HU0Zrkq/r2Z3TpihtkA=
X-Received: by 2002:a17:903:13c7:b0:2c2:245a:3368 with SMTP id d9443c01a7336-2c2f0930222mr2338885ad.14.1781135421817;
        Wed, 10 Jun 2026 16:50:21 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649ab01sm248150685ad.71.2026.06.10.16.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:50:21 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:50:19 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, razor@blackwall.org, bobbyeshleman@meta.com,
	dw@davidwei.uk, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] selftests/net: Move netkit lease hw setup
 into per-test fixtures
Message-ID: <ain4OzpmFM17XWqD@devvm29614.prn0.facebook.com>
References: <20260610080344.701380-1-daniel@iogearbox.net>
 <20260610080344.701380-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610080344.701380-2-daniel@iogearbox.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297864-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:kuba@kernel.org,m:razor@blackwall.org,m:bobbyeshleman@meta.com,m:dw@davidwei.uk,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29A3D66D6F5

On Wed, Jun 10, 2026 at 10:03:41AM +0200, Daniel Borkmann wrote:
> The HW counterpart of nk_qlease.py was carrying its lease setup in main()
> and stashing src_queue / nk_queue / nk_*_ifname on cfg, which had drawbacks
> called out during the review at [0].
> 
> This is the deferred half of the cleanup that landed in commit e254ffb9502c
> ("selftests/net: Split netdevsim tests from HW tests in nk_qlease") which
> was the SW counterpart of nk_qlease.py.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://lore.kernel.org/netdev/20260408162238.16709090@kernel.org/ [0]
> ---
>  .../selftests/drivers/net/hw/nk_qlease.py     | 192 +++++++++++++-----
>  1 file changed, 146 insertions(+), 46 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/nk_qlease.py b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
> index 139a91ebd229..81125856727f 100755
> --- a/tools/testing/selftests/drivers/net/hw/nk_qlease.py
> +++ b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
> @@ -18,8 +18,10 @@ from lib.py import (
>      NetNSEnter,
>      EthtoolFamily,
>      NetdevFamily,
> +    RtnlFamily,
>  )
>  from lib.py import (
> +    Netlink,
>      bkg,
>      cmd,
>      defer,
> @@ -31,9 +33,117 @@ from lib.py import (
>  from lib.py import KsftSkipEx, CmdExitFailure
>  
>  
> -def set_flow_rule(cfg):
> +def _create_netkit_pair(cfg, rxqueues=2):
> +    if cfg._nk_host_ifname:
> +        cmd(f"ip link del dev {cfg._nk_host_ifname}", fail=False)
> +        cfg._nk_host_ifname = None
> +        cfg.nk_guest_ifname = None
> +    if getattr(cfg, "_tc_attached", False):
> +        cmd(
> +            f"tc filter del dev {cfg.ifname} ingress pref {cfg._bpf_prog_pref}",
> +            fail=False,
> +        )
> +        cfg._tc_attached = False
> +
> +    all_links = ip("-d link show", json=True)
> +    old_idxs = {
> +        link["ifindex"]
> +        for link in all_links
> +        if link.get("linkinfo", {}).get("info_kind") == "netkit"
> +    }
> +
> +    rtnl = RtnlFamily()
> +    rtnl.newlink(
> +        {
> +            "linkinfo": {
> +                "kind": "netkit",
> +                "data": {
> +                    "mode": "l2",
> +                    "policy": "forward",
> +                    "peer-policy": "forward",
> +                },
> +            },
> +            "num-rx-queues": rxqueues,
> +        },
> +        flags=[Netlink.NLM_F_CREATE, Netlink.NLM_F_EXCL],
> +    )
> +
> +    all_links = ip("-d link show", json=True)
> +    nk_links = [
> +        link
> +        for link in all_links
> +        if link.get("linkinfo", {}).get("info_kind") == "netkit"
> +        and link["ifindex"] not in old_idxs
> +    ]
> +    if len(nk_links) != 2:
> +        raise KsftSkipEx("Failed to create netkit pair")
> +
> +    nk_links.sort(key=lambda x: x["ifindex"])
> +    cfg._nk_host_ifname = nk_links[1]["ifname"]
> +    cfg.nk_guest_ifname = nk_links[0]["ifname"]
> +    cfg.nk_host_ifindex = nk_links[1]["ifindex"]
> +    cfg.nk_guest_ifindex = nk_links[0]["ifindex"]
> +
> +    ip(f"link set dev {cfg.nk_guest_ifname} netns {cfg.netns.name}")
> +    ip(f"link set dev {cfg._nk_host_ifname} up")
> +    ip(f"-6 addr add fe80::1/64 dev {cfg._nk_host_ifname} nodad")
> +    ip(
> +        f"-6 route add {cfg.nk_guest_ipv6}/128 via fe80::2 "
> +        f"dev {cfg._nk_host_ifname}"
> +    )
> +    ip(f"link set dev {cfg.nk_guest_ifname} up", ns=cfg.netns)
> +    ip(f"-6 addr add fe80::2/64 dev {cfg.nk_guest_ifname}", ns=cfg.netns)
> +    ip(
> +        f"-6 addr add {cfg.nk_guest_ipv6}/64 dev {cfg.nk_guest_ifname} nodad",
> +        ns=cfg.netns,
> +    )
> +    ip(
> +        f"-6 route add default via fe80::1 dev {cfg.nk_guest_ifname}",
> +        ns=cfg.netns,
> +    )
> +
> +    cfg._attach_bpf()
> +
> +
> +def _setup_lease(cfg, rxqueues=2):
> +    _create_netkit_pair(cfg, rxqueues=rxqueues)
> +
> +    ethnl = EthtoolFamily()
> +    channels = ethnl.channels_get({"header": {"dev-index": cfg.ifindex}})[
> +        "combined-count"
> +    ]
> +    if channels < 2:
> +        raise KsftSkipEx(
> +            "Test requires NETIF with at least 2 combined channels"
> +        )
> +    src_queue = channels - 1
> +
> +    with NetNSEnter(str(cfg.netns)):
> +        netdevnl = NetdevFamily()
> +        bind_result = netdevnl.queue_create(
> +            {
> +                "ifindex": cfg.nk_guest_ifindex,
> +                "type": "rx",
> +                "lease": {
> +                    "ifindex": cfg.ifindex,
> +                    "queue": {"id": src_queue, "type": "rx"},
> +                    "netns-id": 0,
> +                },
> +            }
> +        )
> +    return src_queue, bind_result["id"]
> +
> +
> +def _teardown_netkit(cfg):
> +    if cfg._nk_host_ifname:
> +        cmd(f"ip link del dev {cfg._nk_host_ifname}", fail=False)
> +        cfg._nk_host_ifname = None
> +        cfg.nk_guest_ifname = None
> +
> +
> +def set_flow_rule(cfg, src_queue):
>      output = ethtool(
> -        f"-N {cfg.ifname} flow-type tcp6 dst-port {cfg.port} action {cfg.src_queue}"
> +        f"-N {cfg.ifname} flow-type tcp6 dst-port {cfg.port} action {src_queue}"
>      ).stdout
>      values = re.search(r"ID (\d+)", output).group(1)
>      return int(values)
> @@ -41,6 +151,8 @@ def set_flow_rule(cfg):
>  
>  def test_iou_zcrx(cfg) -> None:
>      cfg.require_ipver("6")
> +    src_queue, nk_queue = _setup_lease(cfg)
> +    defer(_teardown_netkit, cfg)
>      ethnl = EthtoolFamily()
>  
>      rings = ethnl.rings_get({"header": {"dev-index": cfg.ifindex}})
> @@ -65,13 +177,16 @@ def test_iou_zcrx(cfg) -> None:
>          },
>      )
>  
> -    ethtool(f"-X {cfg.ifname} equal {cfg.src_queue}")
> +    ethtool(f"-X {cfg.ifname} equal {src_queue}")
>      defer(ethtool, f"-X {cfg.ifname} default")
>  
> -    flow_rule_id = set_flow_rule(cfg)
> +    flow_rule_id = set_flow_rule(cfg, src_queue)
>      defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
>  
> -    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg.nk_guest_ifname} -q {cfg.nk_queue}"
> +    rx_cmd = (
> +        f"ip netns exec {cfg.netns.name} {cfg.bin_local} "
> +        f"-s -p {cfg.port} -i {cfg.nk_guest_ifname} -q {nk_queue}"
> +    )
>      tx_cmd = f"{cfg.bin_remote} -c -h {cfg.nk_guest_ipv6} -p {cfg.port} -l 12840"
>      with bkg(rx_cmd, exit_wait=True):
>          wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
> @@ -80,25 +195,29 @@ def test_iou_zcrx(cfg) -> None:
>  
>  def test_attrs(cfg) -> None:
>      cfg.require_ipver("6")
> +    src_queue, nk_queue = _setup_lease(cfg)
> +    defer(_teardown_netkit, cfg)
>      netdevnl = NetdevFamily()
>      queue_info = netdevnl.queue_get(
> -        {"ifindex": cfg.ifindex, "id": cfg.src_queue, "type": "rx"}
> +        {"ifindex": cfg.ifindex, "id": src_queue, "type": "rx"}
>      )
>  
> -    ksft_eq(queue_info["id"], cfg.src_queue)
> +    ksft_eq(queue_info["id"], src_queue)
>      ksft_eq(queue_info["type"], "rx")
>      ksft_eq(queue_info["ifindex"], cfg.ifindex)
>  
>      ksft_in("lease", queue_info)
>      lease = queue_info["lease"]
>      ksft_eq(lease["ifindex"], cfg.nk_guest_ifindex)
> -    ksft_eq(lease["queue"]["id"], cfg.nk_queue)
> +    ksft_eq(lease["queue"]["id"], nk_queue)
>      ksft_eq(lease["queue"]["type"], "rx")
>      ksft_in("netns-id", lease)
>  
>  
>  def test_attach_xdp_with_mp(cfg) -> None:
>      cfg.require_ipver("6")
> +    src_queue, nk_queue = _setup_lease(cfg)
> +    defer(_teardown_netkit, cfg)
>      ethnl = EthtoolFamily()
>  
>      rings = ethnl.rings_get({"header": {"dev-index": cfg.ifindex}})
> @@ -123,18 +242,21 @@ def test_attach_xdp_with_mp(cfg) -> None:
>          },
>      )
>  
> -    ethtool(f"-X {cfg.ifname} equal {cfg.src_queue}")
> +    ethtool(f"-X {cfg.ifname} equal {src_queue}")
>      defer(ethtool, f"-X {cfg.ifname} default")
>  
>      netdevnl = NetdevFamily()
>  
> -    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg.nk_guest_ifname} -q {cfg.nk_queue}"
> +    rx_cmd = (
> +        f"ip netns exec {cfg.netns.name} {cfg.bin_local} "
> +        f"-s -p {cfg.port} -i {cfg.nk_guest_ifname} -q {nk_queue}"
> +    )
>      with bkg(rx_cmd):
>          wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
>  
>          time.sleep(0.1)
>          queue_info = netdevnl.queue_get(
> -            {"ifindex": cfg.ifindex, "id": cfg.src_queue, "type": "rx"}
> +            {"ifindex": cfg.ifindex, "id": src_queue, "type": "rx"}
>          )
>          ksft_in("io-uring", queue_info)
>  
> @@ -144,13 +266,15 @@ def test_attach_xdp_with_mp(cfg) -> None:
>  
>      time.sleep(0.1)
>      queue_info = netdevnl.queue_get(
> -        {"ifindex": cfg.ifindex, "id": cfg.src_queue, "type": "rx"}
> +        {"ifindex": cfg.ifindex, "id": src_queue, "type": "rx"}
>      )
>      ksft_not_in("io-uring", queue_info)
>  
>  
>  def test_destroy(cfg) -> None:
>      cfg.require_ipver("6")
> +    src_queue, nk_queue = _setup_lease(cfg)
> +    defer(_teardown_netkit, cfg)
>      ethnl = EthtoolFamily()
>  
>      rings = ethnl.rings_get({"header": {"dev-index": cfg.ifindex}})
> @@ -175,16 +299,19 @@ def test_destroy(cfg) -> None:
>          },
>      )
>  
> -    ethtool(f"-X {cfg.ifname} equal {cfg.src_queue}")
> +    ethtool(f"-X {cfg.ifname} equal {src_queue}")
>      defer(ethtool, f"-X {cfg.ifname} default")
>  
> -    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg.nk_guest_ifname} -q {cfg.nk_queue}"
> +    rx_cmd = (
> +        f"ip netns exec {cfg.netns.name} {cfg.bin_local} "
> +        f"-s -p {cfg.port} -i {cfg.nk_guest_ifname} -q {nk_queue}"
> +    )
>      rx_proc = cmd(rx_cmd, background=True)
>      wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
>  
>      netdevnl = NetdevFamily()
>      queue_info = netdevnl.queue_get(
> -        {"ifindex": cfg.ifindex, "id": cfg.src_queue, "type": "rx"}
> +        {"ifindex": cfg.ifindex, "id": src_queue, "type": "rx"}
>      )
>      ksft_in("io-uring", queue_info)
>  
> @@ -199,17 +326,14 @@ def test_destroy(cfg) -> None:
>      cfg.nk_guest_ifname = None
>  
>      queue_info = netdevnl.queue_get(
> -        {"ifindex": cfg.ifindex, "id": cfg.src_queue, "type": "rx"}
> +        {"ifindex": cfg.ifindex, "id": src_queue, "type": "rx"}
>      )
>      ksft_not_in("io-uring", queue_info)
>  
> -    cmd(f"tc filter del dev {cfg.ifname} ingress pref {cfg._bpf_prog_pref}")
> -    cfg._tc_attached = False
> -
> -    flow_rule_id = set_flow_rule(cfg)
> +    flow_rule_id = set_flow_rule(cfg, src_queue)
>      defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
>  
> -    rx_cmd = f"{cfg.bin_local} -s -p {cfg.port} -i {cfg.ifname} -q {cfg.src_queue}"
> +    rx_cmd = f"{cfg.bin_local} -s -p {cfg.port} -i {cfg.ifname} -q {src_queue}"
>      tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {cfg.port} -l 12840"
>      with bkg(rx_cmd, exit_wait=True):
>          wait_port_listen(cfg.port, proto="tcp")
> @@ -217,7 +341,7 @@ def test_destroy(cfg) -> None:
>      # Short delay since iou cleanup is async and takes a bit of time.
>      time.sleep(0.1)
>      queue_info = netdevnl.queue_get(
> -        {"ifindex": cfg.ifindex, "id": cfg.src_queue, "type": "rx"}
> +        {"ifindex": cfg.ifindex, "id": src_queue, "type": "rx"}
>      )
>      ksft_not_in("io-uring", queue_info)
>  
> @@ -230,30 +354,6 @@ def main() -> None:
>          cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
>          cfg.port = rand_port()
>  
> -        ethnl = EthtoolFamily()
> -        channels = ethnl.channels_get({"header": {"dev-index": cfg.ifindex}})
> -        channels = channels["combined-count"]
> -        if channels < 2:
> -            raise KsftSkipEx("Test requires NETIF with at least 2 combined channels")
> -
> -        cfg.src_queue = channels - 1
> -
> -        with NetNSEnter(str(cfg.netns)):
> -            netdevnl = NetdevFamily()
> -            bind_result = netdevnl.queue_create(
> -                {
> -                    "ifindex": cfg.nk_guest_ifindex,
> -                    "type": "rx",
> -                    "lease": {
> -                        "ifindex": cfg.ifindex,
> -                        "queue": {"id": cfg.src_queue, "type": "rx"},
> -                        "netns-id": 0,
> -                    },
> -                }
> -            )
> -            cfg.nk_queue = bind_result["id"]
> -
> -        # test_destroy must be last because it destroys the netkit devices
>          ksft_run(
>              [test_iou_zcrx, test_attrs, test_attach_xdp_with_mp, test_destroy],
>              args=(cfg,),
> -- 
> 2.43.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

