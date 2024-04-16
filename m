Return-Path: <netdev+bounces-88369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCF68A6E65
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 16:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5D81F21D41
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB5512FF9E;
	Tue, 16 Apr 2024 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOz/tEw4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9B12C522
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278023; cv=none; b=caaMHYGYNFajqUjZjzDdtblCt49lF7wk9gMtQLFUZMNv+63V7Ky09o5TZOCog0FLA8JlJLjFwjk7ph6eONg9Nz5hNYroHSnVfXxDtzgzFiJDwXjX498eI+eM1YV8bTNRWeeIwNNz5EAd74Jq3sulp35BYZM7xC9DWGMJjP8Ijg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278023; c=relaxed/simple;
	bh=PC/PeNcwDucm77SdPXJdsD0FsQrNRW/b6ReGzvrUnrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a89kMcWU/pQhKG0zvBiwTjwv6qvo4fRWhrcbYssA9KhIyDSwKDAGt1KIVn4vM4OIkZjOgnr01NyZUHb9PrkVjdOScOUVAS2Sr5QsK2e+9BvewgurCTvjBRb8bPXyG6VTN4N35pLzoDbL9NNerz7K1tcpylXLZ3NXkn8ZJWt7CW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOz/tEw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13357C4AF07;
	Tue, 16 Apr 2024 14:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713278023;
	bh=PC/PeNcwDucm77SdPXJdsD0FsQrNRW/b6ReGzvrUnrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IOz/tEw4zO4uIJv0sb4Ah18/0gyNRKyl7ANKJNrWC2QlWJrzhxWYMVmvvrnoNyWwq
	 MmPK2pDmB3JOx+bSqKdBpuAmzieKbml9RVYntV6lwa+QuFRaid2QhCUYz+g4DczdjH
	 MSc1+xSJVZEAp1l00PuhUy3I9QudtsPNFwQ0dCd2oYLf7TM3dEgsThCQZM5UG6TLaM
	 RwhzdgsH9260wuliZOEdG9Pn01dHFzxm5nVmDS/A7cWGVsS7c+M0XBt1ZrsKOhDOE6
	 TC59H/sp4DUhejsymxMc4J+3pI4GvgVSGmkG/QxzkaqdaH9u2PM7VUUy1uQrbiPzaF
	 3rvMKFAIZ4hOw==
Date: Tue, 16 Apr 2024 15:33:38 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	mlxsw@nvidia.com, Jiri Pirko <jiri@resnulli.us>,
	Amit Cohen <amcohen@nvidia.com>
Subject: Re: [PATCH net 1/3] mlxsw: core: Unregister EMAD trap using FORWARD
 action
Message-ID: <20240416143338.GQ2320920@kernel.org>
References: <cover.1713262810.git.petrm@nvidia.com>
 <bb8f06c1644f0d3dfb3a488f625f27476d9b8a01.1713262810.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb8f06c1644f0d3dfb3a488f625f27476d9b8a01.1713262810.git.petrm@nvidia.com>

On Tue, Apr 16, 2024 at 12:24:14PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The device's manual (PRM - Programmer's Reference Manual) classifies the
> trap that is used to deliver EMAD responses as an "event trap". Among
> other things, it means that the only actions that can be associated with
> the trap are TRAP and FORWARD (NOP).
> 
> Currently, during driver de-initialization the driver unregisters the
> trap by setting its action to DISCARD, which violates the above
> guideline. Future firmware versions will prevent such misuses by
> returning an error. This does not prevent the driver from working, but
> an error will be printed to the kernel log during module removal /
> devlink reload:
> 
> mlxsw_spectrum 0000:03:00.0: Reg cmd access status failed (status=7(bad parameter))
> mlxsw_spectrum 0000:03:00.0: Reg cmd access failed (reg_id=7003(hpkt),type=write)
> 
> Suppress the error message by aligning the driver to the manual and use
> a FORWARD (NOP) action when unregistering the trap.
> 
> Fixes: 4ec14b7634b2 ("mlxsw: Add interface to access registers and process events")
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: Amit Cohen <amcohen@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


