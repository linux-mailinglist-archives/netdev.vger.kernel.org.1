Return-Path: <netdev+bounces-66863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035AF8413CF
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 20:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85581F23ACB
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 19:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBCF7605F;
	Mon, 29 Jan 2024 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ud2BOR1R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587CC76049
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558033; cv=none; b=hv3W7mIp5ycxF+V3BfIpnvE8WYR15vXgx4HD7bkxgPbsUHTQpzzMvEWWNz52yzAdVZsMLSUmHONmmtfvDKTQaw/ODJSz3esGdHKss39vEqQx35DKFZnwoeHyZ8LDrJ0ShSGXuMAcAV35xDGjbyVXwDh+pevB33xJJAR67sbgM1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558033; c=relaxed/simple;
	bh=1nw/UGHeoOJ7qQly1dls4qSgnpDCqRIxfQpKfgFjhF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtFk6SpckYVaNLdtZnErDfV3MhdWWJmKzNgmld/KCj3v/dxRF2rWnap/pS+XFxUQNheJyVP3C9nXty6dKu/UAEwNUYtOKzOsfur4rzm/sua2wuKXEz2K+rfQp/s1v4sIjEP41rU+dVCDpyrymL4SPu+LpdtRpybUR9yoiJFviCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ud2BOR1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AAAC43394;
	Mon, 29 Jan 2024 19:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706558032;
	bh=1nw/UGHeoOJ7qQly1dls4qSgnpDCqRIxfQpKfgFjhF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ud2BOR1RvbLempzlD4ocEh0GRp67BUgQ6rZ0CgUteot6zL5d4MHzI3mMGKyQIej3a
	 xIAaYBmgRfkf8UrR6dMZ7zNrmxH9O/aQjWYCNxOIRKX0SpdjAa2/tz84XaFIRbzbdY
	 RsQTpopWaeiEg9/ozEyQjmz98/8cEX2dg64YFgHa0OzoLsKXBPc141fCVOdYtZTeIp
	 etvW5CjlDAtnlH8hy21mPsk1Jl/JmVPly5ONKyqGf897/Ilo8nbyGqWhh0i0PNE3H4
	 cgc8X2imvZ356JiFtYcQXYCAqKekVjLdHTk3D5ammndK/R6adfhzUXAbQR+3T8hKA1
	 0MVAPyI0yRBag==
Date: Mon, 29 Jan 2024 19:53:48 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 5/6] mlxsw: spectrum: Refactor LAG create and
 destroy code
Message-ID: <20240129195348.GP401354@kernel.org>
References: <cover.1706293430.git.petrm@nvidia.com>
 <30eb498438bf114bfcd8c02bc6117007aa0e9600.1706293430.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30eb498438bf114bfcd8c02bc6117007aa0e9600.1706293430.git.petrm@nvidia.com>

On Fri, Jan 26, 2024 at 07:58:30PM +0100, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> mlxsw_sp stores an array of LAGs. When a port joins a LAG, in case that
> this LAG is already in use, we only have to increase the reference counter.
> Otherwise, we have to search for an unused LAG ID and configure it in
> hardware. When a port leaves a LAG, we have to destroy it only for the last
> user. This code can be simplified, for such requirements we usually add
> get() and put() functions which create and destroy the object.
> 
> Add mlxsw_sp_lag_{get,put}() and use them. These functions take care of
> the reference counter and hardware configuration if needed. Change the
> reference counter to refcount_t type which catches overflow and underflow
> issues.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


