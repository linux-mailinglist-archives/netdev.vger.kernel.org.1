Return-Path: <netdev+bounces-120629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F53695A0CD
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D252C1C22AD4
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBB7433B3;
	Wed, 21 Aug 2024 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMf+M4EB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454552AD31;
	Wed, 21 Aug 2024 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252455; cv=none; b=HQKdOwIl0sgqPNnpzVf0uFGv6dD3fp1452lYAmCqFE8gzD/rmD+K4j1GRp6f2PNYaa8nh5H20Dr+ApTyAXa/JxWGSRDHF2DJEkUz1+Nir1hEk27or0sSLOPTqd4k1dZ/PeDpeb9HXWZJZ46U6z37Iji2icrwZuCk0Bg2jEqo3zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252455; c=relaxed/simple;
	bh=eJNiBqrJbjjZJgFXhFE46zU9f0kJIUwxiIhksD62wnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsOOSMor7cr3BBfPyY6GwiiJLYLw/EcrlNNtwPimg+J0UfuIT18O3UupKYBa9bkiHuSv8iU/X+xZsXALv8O9mhKY66sz3lowEdlBSUGeAdzFpbZZv/aFCmT59bSGzaZMlc4GGouYCwva+sIosBFxvnehJLIw4Ovuzdxv96KSzlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMf+M4EB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C74C32781;
	Wed, 21 Aug 2024 15:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724252454;
	bh=eJNiBqrJbjjZJgFXhFE46zU9f0kJIUwxiIhksD62wnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IMf+M4EBimBtQgxD0kg7bQ3MRyhHg2VFlNAtZ6Va2m5fWYrmFbmUC8lKtOFUtruAl
	 rlfXiUVEx4mrU1DjldLk7L2O/PBbR8V+nUU+pXn+hXZZKTFoUbqfGXxW5tTn1eVUIJ
	 nNbgGLoMRDtuRV1hpAEGQ3YF3QoSBEk/r6EZQ85+yFZXfgDXoZaYybYnVldExKzJWF
	 DVY/lOQp1cQrBjyJzPNEKqax6F3lrleOjds+T9266Q5LRud2Kcbhyui7OqaH8/xxP3
	 An3CH9Qrj8NdQmhRT2y2rG1pj02kySOKaVQlVfXOsxeES/sHnCpVnd/B6/W213Q2Hg
	 4clUQGHDBLY5A==
Date: Wed, 21 Aug 2024 16:00:50 +0100
From: Simon Horman <horms@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jerinj@marvell.com,
	lcherian@marvell.com, ndabilpuram@marvell.com
Subject: Re: [net PATCH v3] octeontx2-af: Fix CPT AF register offset
 calculation
Message-ID: <20240821150050.GB2164@kernel.org>
References: <20240821070558.1020101-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821070558.1020101-1-bbhushan2@marvell.com>

On Wed, Aug 21, 2024 at 12:35:58PM +0530, Bharat Bhushan wrote:
> Some CPT AF registers are per LF and others are global. Translation
> of PF/VF local LF slot number to actual LF slot number is required
> only for accessing perf LF registers. CPT AF global registers access
> do not require any LF slot number. Also, there is no reason CPT
> PF/VF to know actual lf's register offset.
> 
> Without this fix microcode loading will fail, VFs cannot be created
> and hardware is not usable.
> 
> Fixes: bc35e28af789 ("octeontx2-af: replace cpt slot with lf id on reg write")
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v3:
>   - Updated patch description about what's broken without this fix
>   - Added patch history
> 
> v2: https://lore.kernel.org/netdev/20240819152744.GA543198@kernel.org/T/
>   - Spelling fixes in patch description
> 
> v1: https://lore.kernel.org/lkml/CAAeCc_nJtR2ryzoaXop8-bbw_0RGciZsniiUqS+NVMg7dHahiQ@mail.gmail.com/T/
>   - Added "net" in patch subject prefix, missed in previous patch:
>     https://lore.kernel.org/lkml/20240806070239.1541623-1-bbhushan2@marvell.com/
> 

Thanks for the updates, and the information below the scissors ('---').

Reviewed-by: Simon Horman <horms@kernel.org>


