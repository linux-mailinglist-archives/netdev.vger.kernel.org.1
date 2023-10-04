Return-Path: <netdev+bounces-37941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7527B7EF6
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 14:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 383F228154B
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 12:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7192C13AE1;
	Wed,  4 Oct 2023 12:23:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6362512B99
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 12:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3C3C433C7;
	Wed,  4 Oct 2023 12:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696422200;
	bh=26CWUnkqAitYPT5MZJ2aTuKF8TOeq7L12kkfwxhNJ+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SVUpMa8hYvkoF608scqq88M2VdbQ9IuG5wooAoVKxs18xxaUKe/ajD/X0tAe4LyZU
	 riasiuxWIBMGSniuK/S1S0/CR08o/NAVxhhpGngJqgb7ql2M3bp67H4j13pgfEO5Jj
	 Hat3k0xez1e9LFTV+K5ozioTdggcUB2U8v0CQMvmDqWEaa1Owt62grssVFlEbE7iYN
	 fiu/LaKvugVZg7tTNooGQ3PA0zGQiGF47ORPlrsXJCD42AfoIXljtbnZ/LUrLsluF6
	 aMVluO7/SdPTRgvPTvk4oialwD9pxACuff+zsFecmHISDE2RO1akWM7ubeM+GvgzFC
	 PobwhgL9qCorg==
Date: Wed, 4 Oct 2023 14:23:16 +0200
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 0/5] mlxsw: Control the order of blocks in ACL
 region
Message-ID: <ZR1ZNPgcbRBa8uer@kernel.org>
References: <cover.1696330098.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696330098.git.petrm@nvidia.com>

On Tue, Oct 03, 2023 at 01:25:25PM +0200, Petr Machata wrote:
> Amit Cohen writes:
> 
> For 12 key blocks in the A-TCAM, rules are split into two records, which
> constitute two lookups. The two records are linked using a
> "large entry key ID".
> 
> Due to a Spectrum-4 hardware issue, KVD entries that correspond to key
> blocks 0 to 5 of 12 key blocks will be placed in the same KVD pipe if they
> only differ in their "large entry key ID", as it is ignored. This results
> in a reduced scale, we can insert less than 20k filters and get an error:
> 
>     $ tc -b flower.batch
>     RTNETLINK answers: Input/output error
>     We have an error talking to the kernel
> 
> To reduce the probability of this issue, we can place key blocks with
> high entropy in blocks 0 to 5. The idea is to place blocks that are often
> changed in blocks 0 to 5, for example, key blocks that match on IPv4
> addresses or the LSBs of IPv6 addresses. Such placement will reduce the
> probability of these blocks to be same.
> 
> Mark several blocks with 'high_entropy' flag and place them in blocks 0
> to 5. Note that the list of the blocks is just a suggestion, I will verify
> it with architects.
> 
> Currently, there is a one loop that chooses which blocks should be used
> for a given list of elements and fills the blocks - when a block is
> chosen, it fills it in the region. To be able to control the order of
> the blocks, separate between searching blocks and filling them. Several
> pre-changes are required.
> 
> Patch set overview:
> Patch #1 marks several blocks with 'high_entropy' flag.
> Patches #2-#4 prepare the code for filling blocks at the end of the search.
> Patch #5 changes the loop to just choose the blocks and fill the blocks at
> the end.
> 
> Amit Cohen (5):
>   mlxsw: Mark high entropy key blocks
>   mlxsw: core_acl_flex_keys: Add a bitmap to save which blocks are
>     chosen
>   mlxsw: core_acl_flex_keys: Save chosen elements per block
>   mlxsw: core_acl_flex_keys: Save chosen elements in all blocks per
>     search
>   mlxsw: core_acl_flex_keys: Fill blocks with high entropy first
> 
>  .../mellanox/mlxsw/core_acl_flex_keys.c       | 64 +++++++++++++++++--
>  .../mellanox/mlxsw/core_acl_flex_keys.h       |  9 +++
>  .../mellanox/mlxsw/spectrum_acl_flex_keys.c   | 12 ++--
>  3 files changed, 72 insertions(+), 13 deletions(-)

For series,

Reviewed-by: Simon Horman <horms@kernel.org>


