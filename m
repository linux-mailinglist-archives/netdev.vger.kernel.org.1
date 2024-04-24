Return-Path: <netdev+bounces-90977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EB68B0D21
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0764EB243AE
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 14:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23FA15EFC2;
	Wed, 24 Apr 2024 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyUGxXZa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1BF15EFC0
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970161; cv=none; b=i3/Y+cn320ImSPFpk9onTmCsS87Z5xoagEOPuvOsyl1mSxc6XdQXTKv6LZVoKM3DDZp/0GUuGHtEt8yxe52nL8PswumTdYLxlBzvDbFzrkb+jSG1451EjEtKGKPjAkS+wK6NwQtsAYMxAEeiZ/tQJGUYmN9lu/rLDKYTz7AxV3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970161; c=relaxed/simple;
	bh=0D14/Pj7CtsSFMadS1XQTZuQ0QmkieiUQtRMM+6USyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrdXy2aQl8pDWShNA7zCujt+cbAc0jcLRSR1eKa9huE3oSNUQmObPt5Zz6WgVTvt3JuzWdXluAKVo8GdivKsUAMlJBFoRrUT3uweA9d8Q5m6Z8/wSUQd/sdjgPCKK3/gGDjaWcXnQuiobrpz57/NviseSGNHhRuF7YWKCx0HutE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyUGxXZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34078C113CD;
	Wed, 24 Apr 2024 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713970161;
	bh=0D14/Pj7CtsSFMadS1XQTZuQ0QmkieiUQtRMM+6USyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lyUGxXZa+oqbjS/542jxN+qdlmrD4MSRfFQWQzCT1rA1NjLG6rVEzBOaXf5f+VjRT
	 gS4JvrzS3yTZ6k1BcRM8nEobcb5MQal6zzpFoKIegfj1ceqrmVCOt+WlUt476YnXbW
	 MrEedg1bKZX3dAJUFYMX44pROgv0NaAucBBcdsFLIDXjg3kT2Gu6H6FrNACK3VBIUn
	 xTxgHyP9ZIPN5huhi6PkoIXZzX9LzDHNNUIRL3hFpYw1AikwdRm8V/ogQuOmZQ1RP4
	 o5kP/yBjL5OCs0YHKxXiP+v+EncpUmEPqD/JyWMNh4arQlxCxySJK3/MonaRj1QxKt
	 QQA51TzyVT6mQ==
Date: Wed, 24 Apr 2024 15:49:16 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>, Alexander Zubkov <green@qrator.net>,
	mlxsw@nvidia.com
Subject: Re: [PATCH net 3/9] mlxsw: spectrum_acl_tcam: Fix possible
 use-after-free during activity update
Message-ID: <20240424144916.GE42092@kernel.org>
References: <cover.1713797103.git.petrm@nvidia.com>
 <1fcce0a60b231ebeb2515d91022284ba7b4ffe7a.1713797103.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fcce0a60b231ebeb2515d91022284ba7b4ffe7a.1713797103.git.petrm@nvidia.com>

On Mon, Apr 22, 2024 at 05:25:56PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The rule activity update delayed work periodically traverses the list of
> configured rules and queries their activity from the device.
> 
> As part of this task it accesses the entry pointed by 'ventry->entry',
> but this entry can be changed concurrently by the rehash delayed work,
> leading to a use-after-free [1].
> 
> Fix by closing the race and perform the activity query under the
> 'vregion->lock' mutex.
> 
> [1]
> BUG: KASAN: slab-use-after-free in mlxsw_sp_acl_tcam_flower_rule_activity_get+0x121/0x140

...

> Fixes: 2bffc5322fd8 ("mlxsw: spectrum_acl: Don't take mutex in mlxsw_sp_acl_tcam_vregion_rehash_work()")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Tested-by: Alexander Zubkov <green@qrator.net>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...


