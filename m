Return-Path: <netdev+bounces-137197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E74329A4C0C
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 10:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869F11F222C7
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 08:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD431DC07B;
	Sat, 19 Oct 2024 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZCbiD/C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9643012B17C
	for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729326907; cv=none; b=iRO9jcgdRr7vmhZTSuTd3Xmj663egagEMWlUVpO8wi/J86+nRMI1OVQIIVxWVmmSxtjewIRzoMf87YCViSEiDBRVSmWw9RLeTmbtdFZIdaCJOL+f095Qt6t0QmP81KSarjyFOBnR46qT6O5db4HOlWLGHVgq+O3cWQLrO03Svlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729326907; c=relaxed/simple;
	bh=3ZIoAZEktoA7w0nBDMntwdncGqIx5+VOLWZqNtfh+lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBJ3kqQMP1FUmsN/V3Go9irFlJrlGUDOnCosdXeZoMzv9WWWhgHmkQqf4ppJRKPGgGYdE/RKO56u4ri17KTOUafAgn9/HwGFRtXwdt4rC3sF3YDv29f/6ohYcCr5P4LO++c14cqjoyyGjlbqChOdQLzKccdmxn+X07efZZG1OEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZCbiD/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E96C4CEC5;
	Sat, 19 Oct 2024 08:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729326907;
	bh=3ZIoAZEktoA7w0nBDMntwdncGqIx5+VOLWZqNtfh+lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZCbiD/CWrjaFh3A+6YiAVdUcIgIO1qUqpzP3gxIrTBkkDgzuDMTL6X0ZI3Go4Zf6
	 snrGRWIklycw7eCZprlBwQpsITgSOhrOl0rFepM03ZUacXgDPxdiJvArXCLmL4lrS6
	 ddTPXcs1omo4PfF3/d33EHRx8qN74w0aYUSz+aX7rl74jydjhlriwPEkKYMnszl/uY
	 58iSJZTHVuMnmpWwrL9e3LhsoMwgx7m3mQvsftz+lCOhipLIlUajAXu/JIRt3P6dOW
	 XbA2Mv/eYak3Tr6P5BEzOYq6wZLrJCbd8NCSj5AaHpYmaYffPKE17XOYTy9fRk/l3T
	 jz9lDBTNha7Ng==
Date: Sat, 19 Oct 2024 09:35:02 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Dan Nowlin <dan.nowlin@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH iwl-next v3 1/2] ice: refactor "last" segment of DDP pkg
Message-ID: <20241019083502.GJ1697@kernel.org>
References: <20241018141823.178918-4-przemyslaw.kitszel@intel.com>
 <20241018141823.178918-5-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018141823.178918-5-przemyslaw.kitszel@intel.com>

On Fri, Oct 18, 2024 at 04:17:36PM +0200, Przemek Kitszel wrote:
> Add ice_ddp_send_hunk() that buffers "sent FW hunk" calls to AQ in order
> to mark the "last" one in more elegant way. Next commit will add even
> more complicated "sent FW" flow, so it's better to untangle a bit before.
> 
> Note that metadata buffers were not skipped for NOT-@indicate_last
> segments, this is fixed now.
> 
> Minor:
>  + use ice_is_buffer_metadata() instead of open coding it in
>    ice_dwnld_cfg_bufs();
>  + ice_dwnld_cfg_bufs_no_lock() + dependencies were moved up a bit to have
>    better git-diff, as this function was rewritten (in terms of git-blame)
> 
> CC: Paul Greenwalt <paul.greenwalt@intel.com>
> CC: Dan Nowlin <dan.nowlin@intel.com>
> CC: Ahmed Zaki <ahmed.zaki@intel.com>
> CC: Simon Horman <horms@kernel.org>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> git: --inter-hunk-context=6
> 
> v3: added ice_ddp_send_ctx_set_err() to avoid "user" code setting
>     the ctx->err directly, fix kdoc warnings, removed redundant
>     assignement, typo fix, all thanks to Simon
> v2: fixed one kdoc warning

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>


