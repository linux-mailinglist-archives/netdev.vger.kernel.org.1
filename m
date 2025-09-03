Return-Path: <netdev+bounces-219724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC976B42CC3
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AAF31C21B6B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9C32EC0A5;
	Wed,  3 Sep 2025 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeragVM2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D962E9ED8
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756938363; cv=none; b=ZvUifHclDV+06ntnZtikLlTC3SuPUOXJaNvASnVGQjvLzIqaYQt0JopWYCpa6RDZ1uCOqiu1SS41T/Uvk6TglD/N6wh15/yv0tlsyBeB6ZL/8lrvRxShv7CiE5To4ZqzkJMM/p3tvmTU7QcqZCOX53bKFVpgDvrXxxoU1rT17Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756938363; c=relaxed/simple;
	bh=HcZrsas8AaFUjKIPof1m6udsVFep6G1qTnwZpdloA78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zy5ATCsmIRLhUKzobqeB6d4WaEEdzVEXoPQZX0O5qahNZpUz1AxbgSMKDOBpNsfk4pgxiv14gNDQMNERCCiOCQG5cLvn+I4D7qfnHSvTG2M9IANTQ/NeIdR8qCYDO32HbYZGQ5eTUn6HF7UWtOfodPo6bdTJPexE7w3nyUEn+iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeragVM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A5AC4CEE7;
	Wed,  3 Sep 2025 22:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756938362;
	bh=HcZrsas8AaFUjKIPof1m6udsVFep6G1qTnwZpdloA78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BeragVM2h16ZI97KVDjAyy2X0msul9g8ZUK2WOzbNvGi+S7eWYbuM5vhDibDGn6R1
	 uPuJyCCW98vJN2xeILt7T2jdHpVpvT+4IzhE5bo/h2yXWmTguSPeR1ClMdFeLTcNdx
	 tmC8RV0k689XhQks6nWjhhZc5S22HY86PnPW4RiYH23kXmMFvK/WzzpwOK+12cJhoU
	 3ScWVuMvTEovhCAOC4zLw0N1nT/GxtdjFnvxmuv99HXXKF18WQDN2EqVrArXHe6mWX
	 We9Cu0472ddF9+/cYP70Tv8Nxoq6f6RN/PTElEDBBFkTSY8NockMhyPEtvXVKoFCzh
	 Nm703P3Bvccgg==
Date: Wed, 3 Sep 2025 15:26:01 -0700
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
Message-ID: <aLjAefFr3VqEWDJ1@x130>
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
 <aLdIUZbwF83DbUiv@x130>
 <13540207-c99e-408b-a116-2a34825f7e10@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13540207-c99e-408b-a116-2a34825f7e10@gmail.com>

On 03 Sep 11:51, Daniel Zahka wrote:
>
>
>On 9/2/25 3:41 PM, Saeed Mahameed wrote:
>>On 28 Aug 09:29, Daniel Zahka wrote:
>>>.../mellanox/mlx5/core/en_accel/psp.c | 195 +++++
>>>.../mellanox/mlx5/core/en_accel/psp.h         |  49 ++
>>>.../mellanox/mlx5/core/en_accel/psp_fs.c      | 736 ++++++++++++++++++
>>>.../mellanox/mlx5/core/en_accel/psp_fs.h      |  30 +
>>>.../mellanox/mlx5/core/en_accel/psp_offload.c |  44 ++
>>
>>A bit too much control path files, psp_offload.c holds only two level
>>functions for key management and rotation, while psp_fs is.c 
>>implementing the flow steering part and psp.c is the netdev API 
>>facing implementation,
>>do we really need three files ? You can sparate the logic inside one file
>>by bottom up design rather than 3 split files.
>>psp is a well defined protocol, I don't expect it to scale larger than a
>>1-2k lines of code in mlx5, so let's keep it simple, just consolidate all
>>files into one en_accel/psp.{c,h} and leave rxtx.c data path separate.
>>
>>Also As Jakub pointed out on V7, mlx5_ifc changes need to be 
>>separated into
>>own patch, "net/mlx5e: Support PSP offload functionality" need to 
>>split at
>>the point where we cache ps caps on driver load, so main.c and 
>>mlx5_if.c in
>>that patch have to go into own patch and then pulled into mlx5-next 
>>branch
>>to avoid any conflict. Let me know if you need any assistance.
>>
>>
>>>.../mellanox/mlx5/core/en_accel/psp_rxtx.c | 200 +++++
>>>.../mellanox/mlx5/core/en_accel/psp_rxtx.h    | 121 +++
>>>.../net/ethernet/mellanox/mlx5/core/en_main.c |   9 +
>>>.../net/ethernet/mellanox/mlx5/core/en_rx.c   |  49 +-
>>>.../net/ethernet/mellanox/mlx5/core/en_tx.c   |  10 +-
>>>drivers/net/ethernet/mellanox/mlx5/core/fw.c  |   6 +
>>>.../ethernet/mellanox/mlx5/core/lib/crypto.h  |   1 +
>>>.../net/ethernet/mellanox/mlx5/core/main.c    |   1 +
>>>.../mellanox/mlx5/core/steering/hws/definer.c |   2 +-
>>
>
>Hello Saeed,
>I want confirm that I understand the ask here. So, I will consolidate 
>all of:
>
>.../mellanox/mlx5/core/en_accel/psp.c | 195 +++++
>.../mellanox/mlx5/core/en_accel/psp.h |  49 ++
>.../mellanox/mlx5/core/en_accel/psp_fs.c | 736 ++++++++++++++++++
>.../mellanox/mlx5/core/en_accel/psp_fs.h |  30 +
>.../mellanox/mlx5/core/en_accel/psp_offload.c |  44 ++
>
>into en_accel/psp.[ch]. And then for the ifc changes, I will rebase 
>after your PR is merged. And then no action is needed beyond that on 
>the other files. Is that right?
>

Yes, The PR was just pulled into net-next.


