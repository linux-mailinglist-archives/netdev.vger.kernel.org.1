Return-Path: <netdev+bounces-167126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B113A38FE0
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143DE1888C5F
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 00:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1948E4A35;
	Tue, 18 Feb 2025 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ey9hpuXj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15874A07;
	Tue, 18 Feb 2025 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739837997; cv=none; b=Ktu8363TYSClLwv7EznhlfFNG9cAUT4WhFf//InA1Yb5kfVbgjeHKhtKuuKXU7oPi/b3KirHJtUuVE+Z3QZafE9GpCA2ASkA3sILRd2K1TDmOJ6F0DVtorrGN70EGBcAsAVXoiX4qDPgEXI8KAgFGHQeDBnk8iuL5bzGckFGMXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739837997; c=relaxed/simple;
	bh=Ymnq93z6WFJ6BRThQv4kCuwLR3K+xrELo2Jr0tkpPsI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwrdCJS7aHiGZdaDvNjnLH4zQDpnNuR19/xZ0ZHNMR/VJ8emytgJvVGVp3jHNkRjkxY0goyjLeBAgRR6csznErWBhuXg41b+GdzFlRyMfdD9FkosTPZ5JTfzsYcDDYbV3CrWWiQm0IRLxlL6f+RU9r0LxwzTqGbjTzUQa/F+Fik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ey9hpuXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51A3C4CED1;
	Tue, 18 Feb 2025 00:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739837996;
	bh=Ymnq93z6WFJ6BRThQv4kCuwLR3K+xrELo2Jr0tkpPsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ey9hpuXjWUy/V5uxdQ/fYHDNf82JcViWzyEiVOhkuIo1U3xEpzqV2me+DUdRdp/us
	 bvk3JzQ9lqlB4oVy4NjGjgsrBpfFrRykkPpHr2VZ7zf+yAg8riFCOI6h/uC5sYGF+i
	 bw4whhBD4SJ/Rrh275sAFcPZRRJTCeuK2bcj2ieI7c4Cdj7KJYLiNc2JgpLBI6jTRh
	 w2bC6fhvrkhQdTeRawdHp3NMSDHhKn4GN+sGDb3XGHG3ZPiJkoY1ALNaXNR91sl8ug
	 jDogUHpvpLYXx5HMD/44LKMoH9TWwOjMIWFYp7nmJuo0REL/rvr6zJ0XGx0ZpoH01i
	 R8ipranr/ULhQ==
Date: Mon, 17 Feb 2025 16:19:54 -0800
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
Subject: Re: [PATCH net-next v3 5/5] selftests: drv-net-hw: Add a test for
 symmetric RSS hash
Message-ID: <20250217161954.57fd1457@kernel.org>
In-Reply-To: <20250216182453.226325-6-gal@nvidia.com>
References: <20250216182453.226325-1-gal@nvidia.com>
	<20250216182453.226325-6-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Feb 2025 20:24:53 +0200 Gal Pressman wrote:
> +    # Check for symmetric xor/or-xor
> +    if input_xfrm and (input_xfrm == 1 or input_xfrm == 2):
> +        port1 = _get_rand_port(cfg.remote)
> +        port2 = _get_rand_port(cfg.remote)
> +        ksft_pr(f'Running traffic on ports: {port1 = }, {port2 = }')
> +
> +        cnts = _get_rx_cnts(cfg)
> +        GenerateTraffic(cfg, port=port1, parallel=1,
> +                        cport=port2).wait_pkts_and_stop(20000)
> +        cnts = _get_rx_cnts(cfg, prev=cnts)
> +        rxq1 = _get_active_rx_queue(cnts)
> +        ksft_pr(f'Received traffic on {rxq1 = }')
> +
> +        cnts = _get_rx_cnts(cfg)
> +        GenerateTraffic(cfg, port=port2, parallel=1,
> +                        cport=port1).wait_pkts_and_stop(20000)
> +        cnts = _get_rx_cnts(cfg, prev=cnts)
> +        rxq2 = _get_active_rx_queue(cnts)
> +        ksft_pr(f'Received traffic on {rxq2 = }')
> +
> +        ksft_eq(
> +            rxq1, rxq2, comment=f"Received traffic on different queues ({rxq1} != {rxq2}) while symmetric hash is configured")

Wouldn't it be both faster and less error prone to test this with UDP
sockets?

	sock = socket.socket(socket.AF_INET6, socket.SOCK_DGRAM)
	sock.connect(cfg.remove_addr_v[ipver], remote_port)
	sock.recvmsg(100)

	tgt = f"{ipver}:{cfg.addr_v[ipver]}:{local_port},sourceport={remote_port}"
	cmd("echo a | socat - UDP" + tgt, host=cfg.remote)

	cpu = sock.getsockopt(socket.SOL_SOCKET, socket.SO_INCOMING_CPU)

Run this for 10 pairs for ports, make sure we hit at least 2 CPUs,
and that the CPUs match for each pair.

Would be good to test both IPv4 and IPv6. I'm going to merge:
  https://lore.kernel.org/all/20250217194200.3011136-4-kuba@kernel.org/
it should make writing the v4 + v6 test combos easier.
-- 
pw-bot: cr

