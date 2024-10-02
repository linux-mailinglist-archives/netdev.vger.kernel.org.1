Return-Path: <netdev+bounces-131222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B3698D609
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723A2281CC6
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C9D1D0487;
	Wed,  2 Oct 2024 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5f3gMzT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E058E1D0426;
	Wed,  2 Oct 2024 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876149; cv=none; b=GX5RD6nS8t/PzKYGpCsJwTTkgyUT60H+wTLoDOn04QGOanY8451Q5CuqbtA4U/9erT2mdZbrpGfO1+Pnx/XzH5DctCPL0aMQl7HutVLOVAZOeBLo8OGKO/+Mp+j7BqMrEAzGqTsdFwcJdipQqDkBITAkqFWu2lvEbySzW0fjfQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876149; c=relaxed/simple;
	bh=3qG/9YOqZH45qgm8Ugp2vUhwx3nsBP3Gfv9WA6Js/Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5MxVjCG7jstjSX+uLTCXkQZ0cHDAWIu5IHkZZWZSzF5uW3oWTAWghHG38P4qXsSjytKHu+L7QFv/Y8Pac+m1QMmtm0svpTASUGcqM12XpzCd0lVM/XUJvbupoLiwZCs7oQblTo75IZgspm91rAYQuqmJVuzwFbMLdvldDyPEAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5f3gMzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807DBC4CECF;
	Wed,  2 Oct 2024 13:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727876148;
	bh=3qG/9YOqZH45qgm8Ugp2vUhwx3nsBP3Gfv9WA6Js/Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5f3gMzTpNBlN0srsMIORRzU9gM2Gaea1sy2AXJyYzDEnz+jm6z+4knaIZ2ppp/VT
	 Y6vQHzSBbjTlHSBPOzlAI2unCE6kK1r32atYrrEUHrFnTEYuYMH4LYBca+tkv633FN
	 akwJM3OQ5KSOb7dsIUgG2uHvt//aRkgSkYBf7q76Fv0xJJZFELgPndcWa3YodWklWy
	 Kdcy2vOmxmjkOxmt/tuRqRw55D5OuAis9+8X0qUPkExsPpDYtXgynXzZI7BDD76BbU
	 Evhv+o0RSvMezMen+6jWSBDwwxF0MjhcwXq4L44UkxT95N6rPy/h6vG4p5sUJ7CFK1
	 t83TvKaabl/sQ==
Date: Wed, 2 Oct 2024 14:35:43 +0100
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 06/12] net: vxlan: make vxlan_snoop() return
 drop reasons
Message-ID: <20241002133543.GW1310185@kernel.org>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
 <20241001073225.807419-7-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001073225.807419-7-dongml2@chinatelecom.cn>

On Tue, Oct 01, 2024 at 03:32:19PM +0800, Menglong Dong wrote:
> Change the return type of vxlan_snoop() from bool to enum
> skb_drop_reason. In this commit, two drop reasons are introduced:
> 
>   SKB_DROP_REASON_VXLAN_INVALID_SMAC
>   SKB_DROP_REASON_VXLAN_ENTRY_EXISTS
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v4:
> - rename SKB_DROP_REASON_VXLAN_INVALID_SMAC to
>   SKB_DROP_REASON_MAC_INVALID_SOURCE

super-nit: SKB_DROP_REASON_VXLAN_INVALID_SMAC was renamed in the code below
           but not the patch description above

In any case, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

