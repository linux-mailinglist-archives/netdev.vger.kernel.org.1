Return-Path: <netdev+bounces-85771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45C989C1E0
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2BADB283C4
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B020080058;
	Mon,  8 Apr 2024 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVKtwK3w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC0A80045
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582023; cv=none; b=nwrwj2BAdhd1art/J16pz2955TSnO1ku2lh5+REaev1HZITsC6j5Rkc+V1v6FMe0gdtyl/J933GvblG6cs0mDaryTthvFgdPoBMuIqo1HqZPvSPP3KSmPKXzoKzwePpuBATeBCg3UE+4isMeHqZvuszgx6w6F1MdZyLWwxa2b8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582023; c=relaxed/simple;
	bh=w7mbhzgIDEsUoaLxTQI0tTenLivVC167JlArscZ8FWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1flB+oho/eLmh/q3NjBbeH61XhIA+XWrWTAt/32DU8qbbxRbttvKVvdh04/kV801QAuwxiyhdY8K1VloTWID89q8NjWnWOuB5ELnmp6t+HFO7TL0KaOOo+Q5kohlRwezyRyhfC3xbGPe1aiTNW328IUg3/paD/OJa4rB2r1AxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVKtwK3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D1FC433F1;
	Mon,  8 Apr 2024 13:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712582023;
	bh=w7mbhzgIDEsUoaLxTQI0tTenLivVC167JlArscZ8FWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aVKtwK3w5uZC3vz0JnOCO7Ue8vrgaRiSqqQcgs2yFYL+T+w8WCsMul84T3N3LgniX
	 gFN/E6Pkj/M7arwOUuvSC/ah021w1jwpzZvONA55ASAFQtcq3TwYLuJs6lGy7HfRuO
	 AP0/TWjVfyGJi64ZVg5f8t1OZ0fEHS4SnJh7RfjwDf/ZYTTXpcfv41+jmjSr6bHocZ
	 +VI+1M6qrjEgmjv192pRjVGz14m8mnmIO8ztRjJwDShu8xJF7lGuBtlwN1HAt8XGJK
	 znMc0lefGxrXsBqflQppG32InWerR4Mw3h4pO/HW1LVabdwGAlPJjKQdwaF8JOezR5
	 EJPmAvy8B6+6Q==
Date: Mon, 8 Apr 2024 14:13:38 +0100
From: Simon Horman <horms@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Fei Qin <fei.qin@corigine.com>, netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: Re: [PATCH net-next v4 4/4] nfp: use new dim profiles for better
 latency
Message-ID: <20240408131338.GE26556@kernel.org>
References: <20240405081547.20676-1-louis.peens@corigine.com>
 <20240405081547.20676-5-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405081547.20676-5-louis.peens@corigine.com>

On Fri, Apr 05, 2024 at 10:15:47AM +0200, Louis Peens wrote:
> From: Fei Qin <fei.qin@corigine.com>
> 
> Latency comparison between EQE profiles and SPECIFIC_0 profiles
> for 5 different runs:
> 
>                                      Latency (us)
> EQE profiles 	    |	132.85  136.32  131.31  131.37  133.51
> SPECIFIC_0 profiles |	92.09   92.16   95.58   98.26   89.79

Nice improvement :)

> Signed-off-by: Fei Qin <fei.qin@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

