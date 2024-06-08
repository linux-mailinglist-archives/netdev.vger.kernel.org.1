Return-Path: <netdev+bounces-101998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC2D9010C8
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 11:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA941C20AE8
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 09:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC9A17B4F8;
	Sat,  8 Jun 2024 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xv9ZND2z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC26717B4F5
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837299; cv=none; b=fdpPOCFD9qtiX4xUzrkHUUbwiaZ9kqodi41ghilwXCoa4vqK+UJiP+uSfmak6VsVQvmoxAmzQYJA/msQ5qksfLyjOYBBoIrFJL6M9K4OsL50WjDvpmvNWIfFmfXaJC4zDFNGLKbGzun+c7rPkM3DmDb6nQ8UKWG5bZ89e4a63zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837299; c=relaxed/simple;
	bh=zwu2YthqHwFQmHsPWcNBr7Ceb7PF8h/unGt0rig609A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+Rk8H4k8PBe8pyMIzkpcLZcLKsA9oOOcKoPsURsBpx2Maht+wbuA2S2KfoIdotpipvQ5He/I7PzQZImzVaD67ot6/WmHAJwUhjd+XtNcTB8HXJALEHH+hnSAKQSHdcOftQN9Q+1qMP9dTWhPP7btiuE2W6aGg3pOAN47FEgLao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xv9ZND2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273D8C2BD11;
	Sat,  8 Jun 2024 09:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837299;
	bh=zwu2YthqHwFQmHsPWcNBr7Ceb7PF8h/unGt0rig609A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xv9ZND2z+VDoWf/BLBhd7CGltozw3vwiIwEvT/XH2xRS35PvpkJ5a4LcRT9j7rZVH
	 c4uYp7MAgOYMDvI+Cb6Ez2Rrj1KD4WgxxiBF4XkQJ7nhzkQbHMU3/lnVuPfpaj8qSN
	 tvRMlTsQG0olU36WsqOjZXxMh8Nsgxl3dAVwIcfaMjNNirGJRQFPX8r7btdnaHQzFR
	 nHO12GiyhSV0Zn34ncZNVPfHVgC3HfDKdHK9OmzuRJOHyHNRmSMmfn6Sj+SP+gOLGA
	 sHHI/Z6Xqxg04sL6DeUweMYtGDxIuPNcl9QuI6u50kYAF7UPcgZToxG/Bzblxa0xSS
	 HmkkHeI3v5Y6Q==
Date: Sat, 8 Jun 2024 10:01:35 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Amit Cohen <amcohen@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	Alexander Zubkov <green@qrator.net>, mlxsw@nvidia.com
Subject: Re: [PATCH net 4/6] lib: objagg: Fix general protection fault
Message-ID: <20240608090135.GQ27689@kernel.org>
References: <cover.1717684365.git.petrm@nvidia.com>
 <3de2a4e3a61b58f948b3fd3b0f0763fabcd9a819.1717684365.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3de2a4e3a61b58f948b3fd3b0f0763fabcd9a819.1717684365.git.petrm@nvidia.com>

On Thu, Jun 06, 2024 at 04:49:41PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The library supports aggregation of objects into other objects only if
> the parent object does not have a parent itself. That is, nesting is not
> supported.
> 
> Aggregation happens in two cases: Without and with hints, where hints
> are a pre-computed recommendation on how to aggregate the provided
> objects.
> 
> Nesting is not possible in the first case due to a check that prevents
> it, but in the second case there is no check because the assumption is
> that nesting cannot happen when creating objects based on hints. The
> violation of this assumption leads to various warnings and eventually to
> a general protection fault [1].
> 
> Before fixing the root cause, error out when nesting happens and warn.
> 
> [1]
> general protection fault, probably for non-canonical address 0xdead000000000d90: 0000 [#1] PREEMPT SMP PTI
> CPU: 1 PID: 1083 Comm: kworker/1:9 Tainted: G        W          6.9.0-rc6-custom-gd9b4f1cca7fb #7
> Hardware name: Mellanox Technologies Ltd. MSN3700/VMOD0005, BIOS 5.11 01/06/2019
> Workqueue: mlxsw_core mlxsw_sp_acl_tcam_vregion_rehash_work
> RIP: 0010:mlxsw_sp_acl_erp_bf_insert+0x25/0x80
> [...]
> Call Trace:
>  <TASK>
>  mlxsw_sp_acl_atcam_entry_add+0x256/0x3c0
>  mlxsw_sp_acl_tcam_entry_create+0x5e/0xa0
>  mlxsw_sp_acl_tcam_vchunk_migrate_one+0x16b/0x270
>  mlxsw_sp_acl_tcam_vregion_rehash_work+0xbe/0x510
>  process_one_work+0x151/0x370
>  worker_thread+0x2cb/0x3e0
>  kthread+0xd0/0x100
>  ret_from_fork+0x34/0x50
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> Fixes: 9069a3817d82 ("lib: objagg: implement optimization hints assembly and use hints for object creation")
> Reported-by: Alexander Zubkov <green@qrator.net>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Amit Cohen <amcohen@nvidia.com>
> Tested-by: Alexander Zubkov <green@qrator.net>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


