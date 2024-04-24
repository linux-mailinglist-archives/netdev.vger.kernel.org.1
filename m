Return-Path: <netdev+bounces-90978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2AF8B0D26
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F3B1F26BC0
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 14:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3D215D5C7;
	Wed, 24 Apr 2024 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjHfEtyk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5891DFEB
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970207; cv=none; b=C0XYizyFbRo7VMdVwQzpV5qaibzZ3VC5mwaSVZ6kPwX6dzwZx+hKx6TSGLL3hFB7pEzhylJnrX0D5mBuvpCj2+ERf09Nk7b3VdhtL5gFlcpjA4c6BPyZAdYxqOF4KWHzIU+r9Gn+SuXLZsG1y/OCZXC4qn+4fLfoEk2EiOzrKQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970207; c=relaxed/simple;
	bh=UeW7Ol3gwl61w41U8ceb3+hLYlYY8lsdpxqv0gXVnXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWddiAJq2dNxLBA3SpdCdc4SspajUwXI6ELRBeP+XJIoND5wAgMsUXmOZGzDVz3b0esQXcdAsyqpVxOs5J9ebyo9vfzFlg7bA+YUeLUykHgxffNurp307OSn3CMAdbuGJaCshZQqWl+qrD2hHcdZ1h4OrX7yHvzpMhrHC6g63OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjHfEtyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01887C113CD;
	Wed, 24 Apr 2024 14:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713970207;
	bh=UeW7Ol3gwl61w41U8ceb3+hLYlYY8lsdpxqv0gXVnXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SjHfEtyksaPeZt/uJ8XwsRfrLsjR0MykV/Qx1o8CLu0I8dI6LO6XqDK5AnjbTrk1A
	 mqntu5ApBC7NY33yFPzDq5LPgNw7aa1xp9DblidpUX1Tp2bEVYzkS4MO1djtO4afVR
	 9tkxEa/PUm3mqNt7GzGiyPUXp4pGwKGMd7u0M4/I/gG+QgelDHV7Kphglqp57dJvR9
	 Lk9qBJbLOAd3b9PstZNwSHZH1YVeES3DG2YNXWekfUP3DP+VMdHqwx3Aur/OFfjvZS
	 DjwEyQROX550Za21m8r8/lFvKHqepfErzBk9/mucsESuECpD7VrfJY3o9JUn+VwWFO
	 X1NjLS9vQQHiw==
Date: Wed, 24 Apr 2024 15:50:02 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>, Alexander Zubkov <green@qrator.net>,
	mlxsw@nvidia.com
Subject: Re: [PATCH net 4/9] mlxsw: spectrum_acl_tcam: Fix possible
 use-after-free during rehash
Message-ID: <20240424145002.GF42092@kernel.org>
References: <cover.1713797103.git.petrm@nvidia.com>
 <3e412b5659ec2310c5c615760dfe5eac18dd7ebd.1713797103.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e412b5659ec2310c5c615760dfe5eac18dd7ebd.1713797103.git.petrm@nvidia.com>

On Mon, Apr 22, 2024 at 05:25:57PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The rehash delayed work migrates filters from one region to another
> according to the number of available credits.
> 
> The migrated from region is destroyed at the end of the work if the
> number of credits is non-negative as the assumption is that this is
> indicative of migration being complete. This assumption is incorrect as
> a non-negative number of credits can also be the result of a failed
> migration.
> 
> The destruction of a region that still has filters referencing it can
> result in a use-after-free [1].
> 
> Fix by not destroying the region if migration failed.
> 
> [1]
> BUG: KASAN: slab-use-after-free in mlxsw_sp_acl_ctcam_region_entry_remove+0x21d/0x230

...

> Fixes: c9c9af91f1d9 ("mlxsw: spectrum_acl: Allow to interrupt/continue rehash work")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Tested-by: Alexander Zubkov <green@qrator.net>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

