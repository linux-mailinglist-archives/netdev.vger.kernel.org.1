Return-Path: <netdev+bounces-219280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED1BB40E02
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A6748715D
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 19:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A581E286D69;
	Tue,  2 Sep 2025 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOkMYNze"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEEC198A11
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756842067; cv=none; b=dEjgjTwRADQrTs0Mgg5K6yVbRl5XOl+BV8RJ24Mb21bqqwTuQhpNO7h9tgIyGpY2v2fl78yPwsLbyDicVQ9l6EJ8gPSGnJcuKCeq9mf5UJFUg2MwiqWdyygpJLn52w++bDiiQYf9Ri08tLbNJ9jZ82E32TUIaN7EAOCFtCUAbcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756842067; c=relaxed/simple;
	bh=aZTn45iZgNyWp6Dz8hyPEXXqCeu+iaj8YasSZ0fP+Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkS5n9zhsi8ScE19w1p9G7FtQ79s3K9z7QojdhdefDyg0xfr42NY4/5801NS3igS7sIMF8gHk6dpsXS5oLHPnaamrwcXK6EWioPWVGEN1Y0tTOi/TQxIAXBg4R4Q8vXoAGVbcgacJFTvC+XcNtRtuzK+iyn4nu7kJTkA50w0Zq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOkMYNze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06FDC4CEED;
	Tue,  2 Sep 2025 19:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756842067;
	bh=aZTn45iZgNyWp6Dz8hyPEXXqCeu+iaj8YasSZ0fP+Ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOkMYNzezWvDkYtfjOMZ6v5fvomipi4wJdMIWrdc9Ek+8gYckNaNp7NR9Mj5gBmhK
	 esUSynXKBSOHPi04kyDhA7uhdpUfZ/Xcy850fukBb0PDK2p/xxA6R/WeaJhdidtqjP
	 KlvKX73sW2kanyYQMpAeYevvaLK00fblzXq/g0oyQm1aLlNtxNQT+3ZZeIbl1OGb+F
	 lut7xcAqpD56HCNVyIai/TvAJkrrppCGW5aS48jVEbuOhM3JdIS6vmdnqG9yj6Hsy8
	 m1NSsNuSnnexskWtjxlRxDask1BZQf3SzzhAxogPkIfz0RFi9CGOf8PBa0qSJBvcv1
	 lNqTC6H0Du9/Q==
Date: Tue, 2 Sep 2025 12:41:05 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kiran Kella <kiran.kella@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v10 00/19] add basic PSP encryption for TCP
 connections
Message-ID: <aLdIUZbwF83DbUiv@x130>
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250828162953.2707727-1-daniel.zahka@gmail.com>

On 28 Aug 09:29, Daniel Zahka wrote:
>This is v10 of the PSP RFC [1] posted by Jakub Kicinski one year
>ago. General developments since v1 include a fork of packetdrill [2]
>with support for PSP added, as well as some test cases, and an
>implementation of PSP key exchange and connection upgrade [3]
>integrated into the fbthrift RPC library. Both [2] and [3] have been
>tested on server platforms with PSP-capable CX7 NICs. Below is the
>cover letter from the original RFC:
>
>Add support for PSP encryption of TCP connections.
>

[...]

>Raed Salem (9):
>  net/mlx5e: Support PSP offload functionality
>  net/mlx5e: Implement PSP operations .assoc_add and .assoc_del
>  psp: provide encapsulation helper for drivers
>  net/mlx5e: Implement PSP Tx data path
>  net/mlx5e: Add PSP steering in local NIC RX
>  net/mlx5e: Configure PSP Rx flow steering rules
>  psp: provide decapsulation and receive helper for drivers
>  net/mlx5e: Add Rx data path offload
>  net/mlx5e: Implement PSP key_rotate operation
>

[...]

> .../mellanox/mlx5/core/en_accel/psp.c         | 195 +++++
> .../mellanox/mlx5/core/en_accel/psp.h         |  49 ++
> .../mellanox/mlx5/core/en_accel/psp_fs.c      | 736 ++++++++++++++++++
> .../mellanox/mlx5/core/en_accel/psp_fs.h      |  30 +
> .../mellanox/mlx5/core/en_accel/psp_offload.c |  44 ++

A bit too much control path files, psp_offload.c holds only two level
functions for key management and rotation, while psp_fs is.c implementing the 
flow steering part and psp.c is the netdev API facing implementation,
do we really need three files ? You can sparate the logic inside one file
by bottom up design rather than 3 split files.
psp is a well defined protocol, I don't expect it to scale larger than a
1-2k lines of code in mlx5, so let's keep it simple, just consolidate all
files into one en_accel/psp.{c,h} and leave rxtx.c data path separate.

Also As Jakub pointed out on V7, mlx5_ifc changes need to be separated into
own patch, "net/mlx5e: Support PSP offload functionality" need to split at
the point where we cache ps caps on driver load, so main.c and mlx5_if.c in
that patch have to go into own patch and then pulled into mlx5-next branch
to avoid any conflict. Let me know if you need any assistance.


> .../mellanox/mlx5/core/en_accel/psp_rxtx.c    | 200 +++++
> .../mellanox/mlx5/core/en_accel/psp_rxtx.h    | 121 +++
> .../net/ethernet/mellanox/mlx5/core/en_main.c |   9 +
> .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  49 +-
> .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  10 +-
> drivers/net/ethernet/mellanox/mlx5/core/fw.c  |   6 +
> .../ethernet/mellanox/mlx5/core/lib/crypto.h  |   1 +
> .../net/ethernet/mellanox/mlx5/core/main.c    |   1 +
> .../mellanox/mlx5/core/steering/hws/definer.c |   2 +-


