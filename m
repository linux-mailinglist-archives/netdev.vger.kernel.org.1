Return-Path: <netdev+bounces-27604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B494277C841
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9884281337
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 07:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0861D8830;
	Tue, 15 Aug 2023 07:02:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4947185D
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CD8C433C7;
	Tue, 15 Aug 2023 07:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692082940;
	bh=lYUSEbf0TujFGL+bzvO4yZmXFfvLFVwmpTGEDK8DuJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UtBqJbwvyJakfkU7f+ho0WMCcATFvXqXyHssSeCG1x9CwEkGcil6pj1IB7ia3AQE4
	 sMJaAWuknNKeKmR8CTZ8t1JO3yJa0jcdN377GV9nLqSn1a+5hWBvBLnJwMmymlS1p4
	 4DXljJWiC5cVhh62hcGNd22Js7wl/beSCT/T0f4IR/YFvO5jN6XMLmZKRWh44Y3k7x
	 uRTeurkc0BB/8sJJSdfoS8s/OIpgGAFmFmnw0+xqh1/+O+XcEDTHMoiqaS5tBX+c3u
	 9Siz/YesGcqJ3AKjI3DulIw5S/YWFrDlk4ksPvzNtOJPu1G3LgUnL3re8jMf993Hno
	 cCak3voP+x4pA==
Date: Tue, 15 Aug 2023 10:02:16 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 1/3] net: warn about attempts to register
 negative ifindex
Message-ID: <20230815070216.GG22185@unreal>
References: <20230814205627.2914583-1-kuba@kernel.org>
 <20230814205627.2914583-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814205627.2914583-2-kuba@kernel.org>

On Mon, Aug 14, 2023 at 01:56:25PM -0700, Jakub Kicinski wrote:
> Since the xarray changes we mix returning valid ifindex and negative
> errno in a single int returned from dev_index_reserve(). This depends
> on the fact that ifindexes can't be negative. Otherwise we may insert
> into the xarray and return a very large negative value. This in turn
> may break ERR_PTR().
> 
> OvS is susceptible to this problem and lacking validation (fix posted
> separately for net).
> 
> Reject negative ifindex explicitly. Add a warning because the input
> validation is better handled by the caller.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Turns out concerns from reviewers that callers may not check bounds on
> ifindex were legit...
> ---
>  net/core/dev.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

