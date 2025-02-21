Return-Path: <netdev+bounces-168363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F537A3EA84
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 03:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A3019C36D7
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 02:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5F5149C4D;
	Fri, 21 Feb 2025 02:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhwDSDXD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233CD2AD0F;
	Fri, 21 Feb 2025 02:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740103433; cv=none; b=nWWQzYYyB0WZtmOfw3PewJa5ywY+PdAD45Pq71is+dggiWKhIaHyAAwfpm4EtH+UJbELLZcBaMDfQ2GCVF1ULzQxkqfZxCkZycIrxJsVahj2wR+rDTeAG3jlj7NI+37B3V9kmCH0zSt+mbeiTubzCNcjxOrzE3w/GtJoDOu7K8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740103433; c=relaxed/simple;
	bh=rht45uoBqeDV8bCsVQoc0fVIMDOzQd/AYaIBdWP/qDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aD9RtC1x23XVGbFSXf7aIdXm3S/ltFQijlfe2S6eAIoK9KrjP9/2hW8Aka5H5x4vcdH4kIiZzJs7zYrNZlVxPQ8SKlZ8adZIrHhfPhJJwCdEB7bMSU4fCWTGylDOWiTtY2UOJZswMjCRdVH8oKy9SDFKAdBhD0t+P4phi31ZRT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhwDSDXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE916C4CED1;
	Fri, 21 Feb 2025 02:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740103432;
	bh=rht45uoBqeDV8bCsVQoc0fVIMDOzQd/AYaIBdWP/qDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RhwDSDXDH7bO9y3PQei3q2cm1swTeixfKi/1SV+76IKchkQa53ZxrGk0JtUJ2pgJO
	 aFGfVps3lmMu3AcSOXJdu7sv6Z5j5H4kZTpijDEIQ4Sl9/GTkkwOpmlnGFvbjvLSp3
	 5oSvVAXbt7xOpZnYFzUg79t728aqVKf0LKSgwK3MozT66HrWZmCe1FozPWRgp7NK9t
	 aHll+VYZM3cTyWW20yqa9lvOAdIa6PRxoNEQf7S8Net1DpWVxpv3JIWeKlMR3u1bgR
	 lM8U74ag4mVb5vcedvBUg2emQLdB+BT+bSBeBbeTLcu3wzI4W+BkW428S8lYT+KP6v
	 uFWdEd9+0WuAg==
Date: Thu, 20 Feb 2025 18:03:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Nimrod Oren
 <noren@nvidia.com>
Subject: Re: [PATCH net-next v4 5/5] selftests: drv-net-hw: Add a test for
 symmetric RSS hash
Message-ID: <20250220180351.7e278ec9@kernel.org>
In-Reply-To: <20250220113435.417487-6-gal@nvidia.com>
References: <20250220113435.417487-1-gal@nvidia.com>
	<20250220113435.417487-6-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 13:34:35 +0200 Gal Pressman wrote:
> +def _get_rand_port(remote):
> +    for _ in range(1000):
> +        port = rand_port()
> +        try:
> +            check_port_available_remote(port, remote)
> +            return port
> +        except:
> +            continue
> +
> +    raise Exception("Can't find any free unprivileged port")

TCP and UDP port spaces are separate, I think your checking if the
ports are available on TCP here, and then use them for UDP below.

We don't really care about the 100% success, I don't think we should 
be checking the ports. Pick two ports, send a A<>B packet, send a B<>A
packet, if either fails to connect or doesn't arrive just ignore.
As long as we can get ~10? successful pairs in 100? ties it's good.

> +def traffic(cfg, local_port, remote_port, ipver):
> +    af_inet = socket.AF_INET if ipver == "4" else socket.AF_INET6
> +    sock = socket.socket(af_inet, socket.SOCK_DGRAM)
> +    sock.bind(('', local_port))
> +    sock.connect((cfg.remote_addr_v[ipver], remote_port))
> +    tgt = f"{ipver}:[{cfg.addr_v[ipver]}]:{local_port},sourceport={remote_port}"
> +    cmd("echo a | socat - UDP" + tgt, host=cfg.remote)
> +    sock.recvmsg(100)

Could you use fd_read_timeout():
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/tools/testing/selftests/net/lib/py/utils.py#n20

In case the packet got lost?

> +    return sock.getsockopt(socket.SOL_SOCKET, socket.SO_INCOMING_CPU)
> +
> +
> +def test_rss_input_xfrm(cfg, ipver):
> +    """
> +    Test symmetric input_xfrm.
> +    If symmetric RSS hash is configured, send traffic twice, swapping the
> +    src/dst UDP ports, and verify that the same queue is receiving the traffic
> +    in both cases (IPs are constant).
> +    """
> +
> +    input_xfrm = cfg.ethnl.rss_get(
> +        {'header': {'dev-name': cfg.ifname}}).get('input_xfrm')
> +
> +    # Check for symmetric xor/or-xor
> +    if input_xfrm and (input_xfrm == 1 or input_xfrm == 2):
> +        cpus = set()
> +        for _ in range(8):
> +            port1 = _get_rand_port(cfg.remote)
> +            port2 = _get_rand_port(cfg.remote)
> +            cpu1 = traffic(cfg, port1, port2, ipver)
> +            cpu2 = traffic(cfg, port2, port1, ipver)
> +            cpus.update([cpu1, cpu2])
> +
> +            ksft_eq(
> +                cpu1, cpu2, comment=f"Received traffic on different cpus ({cpu1} != {cpu2}) with ports ({port1 = }, {port2 = }) while symmetric hash is configured")

the cpu1 cpu2 values will already be printed by the helper, no need 
to format them in

> +
> +        ksft_ge(len(cpus), 2, comment=f"Received traffic on less than two cpus")
> +    else:
> +        raise KsftSkipEx("Symmetric RSS hash not requested")

Flip the condition, raise the exception right after the if, then the
rest of the code doesn't have to be indented?

I'd also add a:

	if len(cpus) == 1:
		raise KsftSkipEx(f"Only one CPU seen traffic: {cpus}")
-- 
pw-bot: cr

