Return-Path: <netdev+bounces-120968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0CF95B4E1
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCA1287C72
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7488517E00F;
	Thu, 22 Aug 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrYz7ko5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4482116A940;
	Thu, 22 Aug 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724329230; cv=none; b=QkUc+3ro7MePwZalvznWP9l0xNHkZtw71DDp46pZI1Bj/Cksv3VddEM4rvNVa5mqlBUE41oB4lOqH6dldYo2BO+ysfHkYdYvWqOiepQIqLf7aDaR/zKmr6knIVf5Wb4hsMwMa1Yv1dYWXxfNDc9C/dcyAwwtVldBwayvYEl2fqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724329230; c=relaxed/simple;
	bh=stMLxFv66OkFuObD6fVYFuyIPTsazrqfFXFvEAHOF3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3lnihXCZfeT7XfqTu/FZ6kuoMO2fZLwrwdcCfCrHFYlbPX4lFJ0poSsDlak4oWMovLYnDLIbXdQkfBdYfZghYqNZLYkvfrpRlIZJMm+qscs52KozlcY7qvJkyQE48guCisnfEcU7p6R2Cqt+ZEnH/J64qRBj2pQhuuUHmpvs2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrYz7ko5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D811C32782;
	Thu, 22 Aug 2024 12:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724329230;
	bh=stMLxFv66OkFuObD6fVYFuyIPTsazrqfFXFvEAHOF3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OrYz7ko56CTvUx56VYqHQecOjKEIpjE9/UFtZHt9JuWSTEiKLEAdVTcePGmwT3rQ/
	 eQm3/XQLWiccxxmk7mBJqQfIX1Q/CQL/gjIkf2sWWjd3D78m00m2JnYLYFMlxcHnJv
	 pkNGZMkIU71FGjiCnOAoGKHapbMEJ2k715dk8kDSoEyeiQeOJmzBiRXnceg4tTwus1
	 YE+92S8LrOQZi65J0AHVi/B+SlQEt7vWhSAPvQJnPWj8uAazWqnxneo8TYlh7Z1Eh7
	 D5Lyt0SwEVLJyp6IWxDVbW81eXsUF65GtpAkHjTpuVewgAltDHu9l1EwEC9GhcYd/3
	 jGek+Yd0G/8xg==
Date: Thu, 22 Aug 2024 13:20:26 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: netlink: Remove the dump_cb_mutex field
 from struct netlink_sock
Message-ID: <20240822122026.GO2164@kernel.org>
References: <c15ce0846e0aed6f342d85f36092c386c6148d00.1724309198.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c15ce0846e0aed6f342d85f36092c386c6148d00.1724309198.git.christophe.jaillet@wanadoo.fr>

On Thu, Aug 22, 2024 at 09:03:20AM +0200, Christophe JAILLET wrote:
> Commit 5fbf57a937f4 ("net: netlink: remove the cb_mutex "injection" from
> netlink core") has removed the usage of the 'dump_cb_mutex' field from the
> struct netlink_sock.
> 
> Remove the field itself now. It saves a few bytes in the structure.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only

Reviewed-by: Simon Horman <horms@kernel.org>


