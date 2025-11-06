Return-Path: <netdev+bounces-236479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAF4C3CD6B
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 18:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB0062381C
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 17:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D192A34F265;
	Thu,  6 Nov 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hy85GsKu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7C6246327
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449794; cv=none; b=JI+XEIubi/OMCMDxbYnayEV7ZBwilEjO4Yo9qslPkbwzSq9m1hsEsil6q2rIeb5mkx6CMw3cokcvxEVEvfib3KGrrokgg5QYlWIR5OgEIjR/hh00JYVwb8mmQ1PzqokFYMfAKKI2HE2qDMJyDp7+t/QlfqUM52nFNKg2LsAOegw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449794; c=relaxed/simple;
	bh=RpA4CYjdxqrS8CyxWrH8ayWrFSEs59iSDbxr7qWQJl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsVF7oVbqRWRhKBXFKjlbJy+YNTBULWzhrCYJI/t35XQ+ZTyXryGlZXw1y7aBKNQUsAEhLSp0qb5yjR/c+P/Jr+HjiGdBZ7tsWE8KefXwm6kvOAkeEZGKrSD8M/E7Ba4cRui/kmt1PhU/YTnH3kWovqTuo2jVw6yCZc1B0MgImY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hy85GsKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F8AC4CEF7;
	Thu,  6 Nov 2025 17:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762449793;
	bh=RpA4CYjdxqrS8CyxWrH8ayWrFSEs59iSDbxr7qWQJl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hy85GsKuC/xxzL3BgesxJos6PjSC9nhY9Ubsi/mrCurst2igc6+yxKMSMpW8ZrlIR
	 jjI4xwmLxoisV4zNukOJLtZrXwGjx7IVAqeYih03iQk4wLWeNceYgVTWT2tHEj9m8X
	 Zpf4iusQSjLfSlhjQF2aMg2YZ+kepYAjYe/G6CZXPHaouE3fIy7OkYa5e7s00gtqA1
	 N4O83w+u2+HHJGrhr51CuchOPIDHzG4mAq1Y8VVNdBDFA/j/iW4vO6yUkxyJ9tIpTH
	 QXrSQSRwb4afJilKqGUQ8kDFv9wJMO4/eYaQLaYA9DyS7Mpv/R9PgeeJdWGIYx8g9k
	 KD2LQO9hI321g==
Date: Thu, 6 Nov 2025 17:23:09 +0000
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 2/9] ice: use cacheline groups for
 ice_rx_ring structure
Message-ID: <aQzZfXz9qBjr5vtB@horms.kernel.org>
References: <20251105-jk-refactor-queue-stats-v2-0-8652557f9572@intel.com>
 <20251105-jk-refactor-queue-stats-v2-2-8652557f9572@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-jk-refactor-queue-stats-v2-2-8652557f9572@intel.com>

On Wed, Nov 05, 2025 at 01:06:34PM -0800, Jacob Keller wrote:
> The ice ring structure was reorganized back by commit 65124bbf980c ("ice:
> Reorganize tx_buf and ring structs"), and later split into a separate
> ice_rx_ring structure by commit e72bba21355d ("ice: split ice_ring onto
> Tx/Rx separate structs")
> 
> The ice_rx_ring structure has comments left over from this prior
> reorganization indicating which fields belong to which cachelines.
> Unfortunately, these comments are not all accurate. The intended layout is
> for x86_64 systems with a 64-byte cache.
> 
>  * Cacheline 1 spans from the start of the struct to the end of the rx_fqes
>    and xdp_buf union. The comments correctly match this.
> 
>  * Cacheline 2 spans from hdr_fqes to the end of hdr_truesize, but the
>    comment indicates it should end xdp and xsk union.
> 
>  * Cacheline 3 spans from the truesize field to the xsk_pool, but the
>    comment wants this to be from the pkt_ctx down to the rcu head field.
> 
>  * Cacheline 4 spans from the rx_hdr_len down to the flags field, but the
>    comment indicates that it starts back at the ice_channel structure
>    pointer.
> 
>  * Cacheline 5 is indicated to cover the xdp_rxq. Because this field is
>    aligned to 64 bytes, this is actually true. However, there is a large 45
>    byte gap at the end of cacheline 4.
> 
> The use of comments to indicate cachelines is poor design. In practice,
> comments like this quickly become outdated as developers add or remove
> fields, or as other sub-structures change layout and size unexpectedly.
> 
> The ice_rx_ring structure *is* 5 cachelines (320 bytes), but ends up having
> quite a lot of empty space at the end just before xdp_rxq.
> 
> Replace the comments with __cacheline_group_(begin|end)_aligned()
> annotations. These macros enforce alignment to the start of cachelines, and
> enforce padding between groups, thus guaranteeing that a following group
> cannot be part of the same cacheline.
> 
> Doing this changes the layout by effectively spreading the padding at the
> tail of cacheline 4 between groups to ensure that the relevant fields are
> kept as separate cachelines on x86_64 systems. For systems with the
> expected cache line size of 64 bytes, the structure size does not change.
> For systems with a larger SMB_CACHE_BYTES size, the structure *will*
> increase in size a fair bit, however we'll now guarantee that each group is
> in a separate cacheline. This has an advantage that updates to fields in
> one group won't trigger cacheline eviction of the other groups. This comes
> at the expense of extra memory footprint for the rings.
> 
> If fields get re-arranged, added, or removed, the alignment and padding
> ensure the relevant fields are kept on separate cache lines. This could
> result in unexpected changes in the structure size due to padding to keep
> cachelines separate.
> 
> To catch such changes during early development, add build time compiler
> assertions that check the size of each group to ensure it doesn't exceed 64
> bytes, the expected cache line size. The assertion checks that the size of
> the group excluding any padding at the end is less than the provided size
> of 64 bytes. This type of check will behave the same even on architectures
> with larger cache sizes. The primary aim is to produce a warning if
> developers add fields into a cacheline group which exceeds the size of the
> expected 64 byte groupings.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.h | 26 +++++++++++++++++++++-----
>  drivers/net/ethernet/intel/ice/ice_main.c |  2 ++
>  2 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h

...

> @@ -298,10 +302,22 @@ struct ice_rx_ring {
>  #define ICE_RX_FLAGS_MULTIDEV		BIT(3)
>  #define ICE_RX_FLAGS_RING_GCS		BIT(4)
>  	u8 flags;
> -	/* CL5 - 5th cacheline starts here */
> +	__cacheline_group_end_aligned(cl4);
> +
> +	__cacheline_group_begin_aligned(cl5);
>  	struct xdp_rxq_info xdp_rxq;
> +	__cacheline_group_end_aligned(cl5);
>  } ____cacheline_internodealigned_in_smp;
>  
> +static inline void ice_rx_ring_struct_check(void)
> +{
> +	CACHELINE_ASSERT_GROUP_SIZE(struct ice_rx_ring, cl1, 64);
> +	CACHELINE_ASSERT_GROUP_SIZE(struct ice_rx_ring, cl2, 64);
> +	CACHELINE_ASSERT_GROUP_SIZE(struct ice_rx_ring, cl3, 64);
> +	CACHELINE_ASSERT_GROUP_SIZE(struct ice_rx_ring, cl4, 64);
> +	CACHELINE_ASSERT_GROUP_SIZE(struct ice_rx_ring, cl5, 64);

Hi Jacob,

Unfortunately the last line results in a build failure on ARM (32-bit)
with allmodconfig. It seems that in that case the size of the group is
128 bytes.

> +}
> +
>  struct ice_tx_ring {
>  	/* CL1 - 1st cacheline starts here */
>  	struct ice_tx_ring *next;	/* pointer to next ring in q_vector */

...

