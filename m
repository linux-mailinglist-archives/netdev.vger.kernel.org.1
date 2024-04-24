Return-Path: <netdev+bounces-90984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA538B0D47
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E2F1F27014
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 14:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BFB15ECDB;
	Wed, 24 Apr 2024 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y80/b+nU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40F615ECD4
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970398; cv=none; b=ZBbO6s/+d41hiF2M4reK0L3jpc9jKyrutT/pBt7zBELla2J6I6c+yUh0UMwvZ3ekmnJmMSS2eHZHcDosTucGxKgWO2k5NCuzAr2MmOkocSdvCdiFcv9yil+PTAv5J02y8Upws7LH9U0N4yYXCxHsfVIRhWiL4m50P4vtX4pH0AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970398; c=relaxed/simple;
	bh=5UVGcvrRFlNYhSJVVYydNcAOvJaNtiYsR3R/m9d2dsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mR48FnaytDcoYfHAJDZ5Osy1k4FAhMCaB8Yw1J0NHgmnz2qTITshzUyowGNWwFll37iTfMv4zsBfOYzmH0uShwGCFqCZJTnxh1vM0TbdsTc4JgZze3EJSyknRyy/3ZQP2Ol7q8ra0yNl5F0lmVJm4cv5iJL1O8QteWYerx1Yn/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y80/b+nU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500ABC2BBFC;
	Wed, 24 Apr 2024 14:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713970398;
	bh=5UVGcvrRFlNYhSJVVYydNcAOvJaNtiYsR3R/m9d2dsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y80/b+nUTOrG72C5MGNxQVzQoKjlmpPSD9k7NEK4X61uxIKTFV3ycIUZwblAJz9mH
	 QdFliBEHEIaHtGYCoea+7hUFEPtjvR6eRTXCYA+YTs1hEkyHb1V2RKk9izY328EHEl
	 hzeFnsYm59V+pFZGQvfqZ2hdqBTdrvuAXep4bKr+XH076gEto1p+fN8QUbLSx40q5x
	 br+PWuplMDdGhL0vZU4ufvWLhvg+4SpKA9xn2Dj/2uPiffG8kDZGa96R/BzvW2hKYs
	 ZomHu8rKQ7A7rc/a7XSz/v3GWN41mTBU3CWEbrjNIg9aC3xRGkYCoaBGDB6m0RfcGX
	 IelT0VvaIbH9Q==
Date: Wed, 24 Apr 2024 15:53:14 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>, Alexander Zubkov <green@qrator.net>,
	mlxsw@nvidia.com
Subject: Re: [PATCH net 8/9] mlxsw: spectrum_acl_tcam: Fix incorrect list API
 usage
Message-ID: <20240424145314.GJ42092@kernel.org>
References: <cover.1713797103.git.petrm@nvidia.com>
 <4628e9a22d1d84818e28310abbbc498e7bc31bc9.1713797103.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4628e9a22d1d84818e28310abbbc498e7bc31bc9.1713797103.git.petrm@nvidia.com>

On Mon, Apr 22, 2024 at 05:26:01PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Both the function that migrates all the chunks within a region and the
> function that migrates all the entries within a chunk call
> list_first_entry() on the respective lists without checking that the
> lists are not empty. This is incorrect usage of the API, which leads to
> the following warning [1].
> 
> Fix by returning if the lists are empty as there is nothing to migrate
> in this case.
> 
> [1]
> WARNING: CPU: 0 PID: 6437 at drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c:1266 mlxsw_sp_acl_tcam_vchunk_migrate_all+0x1f1/0>
> Modules linked in:
> CPU: 0 PID: 6437 Comm: kworker/0:37 Not tainted 6.9.0-rc3-custom-00883-g94a65f079ef6 #39
> Hardware name: Mellanox Technologies Ltd. MSN3700/VMOD0005, BIOS 5.11 01/06/2019
> Workqueue: mlxsw_core mlxsw_sp_acl_tcam_vregion_rehash_work
> RIP: 0010:mlxsw_sp_acl_tcam_vchunk_migrate_all+0x1f1/0x2c0
> [...]
> Call Trace:
>  <TASK>
>  mlxsw_sp_acl_tcam_vregion_rehash_work+0x6c/0x4a0
>  process_one_work+0x151/0x370
>  worker_thread+0x2cb/0x3e0
>  kthread+0xd0/0x100
>  ret_from_fork+0x34/0x50
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> Fixes: 6f9579d4e302 ("mlxsw: spectrum_acl: Remember where to continue rehash migration")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Tested-by: Alexander Zubkov <green@qrator.net>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


