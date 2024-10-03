Return-Path: <netdev+bounces-131566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0530998EE00
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A070C1F21290
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 11:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C0014F9F7;
	Thu,  3 Oct 2024 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klxZzYfv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902DE13D25E
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727954601; cv=none; b=lHOtJknXjNCk3sRsR+tCTgKkpANYmGOEzBNlYApeeCCdZx6miIs2DbVrjn3vkGthOhVxapSXF4NG0kzYooPu9CpiWShh4CJumEgtudpzNHBMp/akB9RdgS8+AqjTDZM7G2OE6U33VLj2DWBvUKVBenoo8yWY74I1yHjFC71mtJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727954601; c=relaxed/simple;
	bh=ttmtZo6Oq+diwOx9Z0oyWSeXjDie0XmOM+P7Xe8hM3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYE+/rlx/4OUCY9mZRHbiRu9H7H6601Rz2gQZKSNZO4IvaPV+wc6RFTNY1U92hauCX2JzukObq3BQEu+ax4D7bymw41h1p5wCsDkNQf9pWRWwd/RmvL/19WS2ebaPy/7BSA0DmCHng9aQNQYKiFV29w/325fMpyn4jy/CUfA7lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klxZzYfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6531C4CEC5;
	Thu,  3 Oct 2024 11:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727954601;
	bh=ttmtZo6Oq+diwOx9Z0oyWSeXjDie0XmOM+P7Xe8hM3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=klxZzYfvN8K9BOKaXKAoJJp0aUe3Fw0EPcYUffCA6CKivyoTa0L5qJfa6GGJT3aCk
	 61LYRCsfaT/g+mGLXR/+taFev6BdxdY2IKRsXpDM2PMAqTbMRorVgxGUYsAkyxnrhZ
	 FWXRQFECGSByYQLdC/t/A7CI/REq47G+U0PSaerSeCQOOjVD5e6JZKp8SVEm1NWpZX
	 rRUUikwHUqyirEmijjissBsz8WEk4cbmtNZURL9kKgwEDCwTTN6Mbdi5uZ1pHrVFmn
	 zu6ig7f3XL5kx53Astw7XMWyEN96ut8UWtipsEY/ZtGd2/zxNkiU8wZ1FHLUln7yK3
	 iWEQysFvVb/Ow==
Date: Thu, 3 Oct 2024 12:23:17 +0100
From: Simon Horman <horms@kernel.org>
To: Gilad Naaman <gnaaman@drivenets.com>
Cc: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/2] Convert neighbour-table to use hlist
Message-ID: <20241003112317.GK1310185@kernel.org>
References: <20241001050959.1799151-1-gnaaman@drivenets.com>
 <20241001050959.1799151-2-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001050959.1799151-2-gnaaman@drivenets.com>

On Tue, Oct 01, 2024 at 05:09:56AM +0000, Gilad Naaman wrote:
> Use doubly-linked instead of singly-linked list when linking neighbours,
> so that it is possible to remove neighbours without traversing the
> entire table.
> 
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>

Hi Gilad,

This is not a full review, but rather some feedback to take into account
once a proper review arrives.

> ---
>  include/net/neighbour.h |   8 +--
>  net/core/neighbour.c    | 123 ++++++++++++++--------------------------
>  2 files changed, 45 insertions(+), 86 deletions(-)
> 
> diff --git a/include/net/neighbour.h b/include/net/neighbour.h
> index a44f262a7384..77a4aa53aecb 100644
> --- a/include/net/neighbour.h
> +++ b/include/net/neighbour.h
> @@ -135,7 +135,7 @@ struct neigh_statistics {
>  #define NEIGH_CACHE_STAT_INC(tbl, field) this_cpu_inc((tbl)->stats->field)
>  
>  struct neighbour {
> -	struct neighbour __rcu	*next;
> +	struct hlist_node __rcu list;
>  	struct neigh_table	*tbl;
>  	struct neigh_parms	*parms;
>  	unsigned long		confirmed;

Sparse is having a bit of a cow with rcu changes introduced by this patch.
Please take a look at that.

...

