Return-Path: <netdev+bounces-104904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F14490F14E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD411C2437D
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3F81EEFC;
	Wed, 19 Jun 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEgPTwi+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98C51D545
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808665; cv=none; b=Zoois7XlEwLvjxHklqXMF1+z4RWs0npAiC8bXqcP0xrhIvqvfcx0a7dF8YNV4ENYF2UYq5yvAktR63VogpyhE0SvIcpcEyu6eQNSiJwv4oRYWo/bi0S5AKLmMIlRnuStJ6u83aIMpJ2y6gL/1PBYjMS8qaXmsd1e43D/m2N+s0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808665; c=relaxed/simple;
	bh=VKf6L13I7DomE2QDfI8uOtwauSiOSDNSIDkz7wtYYXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4MgcvP1J29KZoK+64GztrHe6AlM23SDJWiutCjacCO4dTiCRDRSHwK46aEwYk2/b9bfpWHemJOCivz9gsmyWEKKlOcYrDk31AN/nsV8wPgHz9EUweS3LG9J8H9zw2fbnUkJlsnGOuivZsJP9t0PAaHGx9s2e43rCuonmjcfZPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEgPTwi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833C5C2BBFC;
	Wed, 19 Jun 2024 14:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718808665;
	bh=VKf6L13I7DomE2QDfI8uOtwauSiOSDNSIDkz7wtYYXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEgPTwi+3NDL6/ekMiWK0c+SYapeMxzJ9+ExkT81Bi7U+byTZLOX1MQcUBthtFlOf
	 GYybqqS0vK5LY8czeFMcXYxc+IWHyYHAOI/v6YDpgCkRWGaAUjU/HQ6XWFWtCHjffE
	 z61wLnljqRISs7e9qm1CihGEp0rEJX1LcneeFLvE0wjP/X2xpW8b2k/6pmyEKrdiUy
	 c1NYMPmo9eF6psU2AhBJbRSQUQr9Lih5L0dCA3OlZIooQXgo209zk28d0ln52QQcRG
	 PM3O8EcuopakeDkSXAyF2dOxH+7ZMpijTx76Bg1ntqRS6YLxSpKDnvGmhP1xmgTixv
	 2ABBNfVcZb84A==
Date: Wed, 19 Jun 2024 15:51:01 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	mlxsw@nvidia.com, Amit Cohen <amcohen@nvidia.com>
Subject: Re: [PATCH net 3/3] mlxsw: spectrum_buffers: Fix memory corruptions
 on Spectrum-4 systems
Message-ID: <20240619145101.GI690967@kernel.org>
References: <cover.1718641468.git.petrm@nvidia.com>
 <fefa63964bccd39495490d6974df1cc25e68ce21.1718641468.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fefa63964bccd39495490d6974df1cc25e68ce21.1718641468.git.petrm@nvidia.com>

On Mon, Jun 17, 2024 at 06:56:02PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The following two shared buffer operations make use of the Shared Buffer
> Status Register (SBSR):
> 
>  # devlink sb occupancy snapshot pci/0000:01:00.0
>  # devlink sb occupancy clearmax pci/0000:01:00.0
> 
> The register has two masks of 256 bits to denote on which ingress /
> egress ports the register should operate on. Spectrum-4 has more than
> 256 ports, so the register was extended by cited commit with a new
> 'port_page' field.
> 
> However, when filling the register's payload, the driver specifies the
> ports as absolute numbers and not relative to the first port of the port
> page, resulting in memory corruptions [1].
> 
> Fix by specifying the ports relative to the first port of the port page.
> 
> [1]
> BUG: KASAN: slab-use-after-free in mlxsw_sp_sb_occ_snapshot+0xb6d/0xbc0
> Read of size 1 at addr ffff8881068cb00f by task devlink/1566
> [...]
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xc6/0x120
>  print_report+0xce/0x670
>  kasan_report+0xd7/0x110
>  mlxsw_sp_sb_occ_snapshot+0xb6d/0xbc0
>  mlxsw_devlink_sb_occ_snapshot+0x75/0xb0
>  devlink_nl_sb_occ_snapshot_doit+0x1f9/0x2a0
>  genl_family_rcv_msg_doit+0x20c/0x300
>  genl_rcv_msg+0x567/0x800
>  netlink_rcv_skb+0x170/0x450
>  genl_rcv+0x2d/0x40
>  netlink_unicast+0x547/0x830
>  netlink_sendmsg+0x8d4/0xdb0
>  __sys_sendto+0x49b/0x510
>  __x64_sys_sendto+0xe5/0x1c0
>  do_syscall_64+0xc1/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [...]
> Allocated by task 1:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  __kasan_kmalloc+0x8f/0xa0
>  copy_verifier_state+0xbc2/0xfb0
>  do_check_common+0x2c51/0xc7e0
>  bpf_check+0x5107/0x9960
>  bpf_prog_load+0xf0e/0x2690
>  __sys_bpf+0x1a61/0x49d0
>  __x64_sys_bpf+0x7d/0xc0
>  do_syscall_64+0xc1/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 1:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  kasan_save_free_info+0x3b/0x60
>  poison_slab_object+0x109/0x170
>  __kasan_slab_free+0x14/0x30
>  kfree+0xca/0x2b0
>  free_verifier_state+0xce/0x270
>  do_check_common+0x4828/0xc7e0
>  bpf_check+0x5107/0x9960
>  bpf_prog_load+0xf0e/0x2690
>  __sys_bpf+0x1a61/0x49d0
>  __x64_sys_bpf+0x7d/0xc0
>  do_syscall_64+0xc1/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: f8538aec88b4 ("mlxsw: Add support for more than 256 ports in SBSR register")
> Cc: Amit Cohen <amcohen@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


