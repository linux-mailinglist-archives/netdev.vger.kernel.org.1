Return-Path: <netdev+bounces-147726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1869DB743
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 13:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B00280DCB
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 12:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6F319ADBF;
	Thu, 28 Nov 2024 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9P83NGP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A4D194A54;
	Thu, 28 Nov 2024 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796065; cv=none; b=rAZdOJAjqPXFhou1wVtu4VazwMqriZiikQMQsXPjEOgYQ/lJ1Ris5QoMQ9ilUU5YPN+T6c5cln/gmTC2H+F/sihGqoiSklzrPqQIefIs8ph/4/zrd2NaylXbfTJcKCqZrxaNdsXljJa/gWNWmM3wltapfwPX2hCC3e6ZcP1JS7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796065; c=relaxed/simple;
	bh=aYTGiaF1Ncd++rnEqg+GshvLAZsQSC2EVUStlVHU8rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dky47tSfunT2GuKkXR17zb4mmz+uck6Ott43jvFaHu3fjKjgNYP8A1ULypQTbnI9uaAQJJbyj00Vdg53s6BZ/7cnxzlQ6MZCBumC6n77691mnyApBELvv6SwEty7S6L0ryijrNn8NE4WojIpVpvkt2uOiyUC1NyBpZYT2yEEhdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9P83NGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83824C4CECE;
	Thu, 28 Nov 2024 12:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732796065;
	bh=aYTGiaF1Ncd++rnEqg+GshvLAZsQSC2EVUStlVHU8rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e9P83NGPrYizfRoGhBgR+QXaDCSdD1olz7/pSxWD6uHDsSwALUaY5KaDLdO+354MB
	 tIaHzEPNtDZoSP+NQyQ+P6YxIehu42F+3zedYo64e4yaNfdF3JNFjGMtR6Iahl1GmH
	 bCVRPlM8YQtgtIJ0l3IwAHvH+Eb/5/q7qZ31D9cP9d/6zU8s563s+sMYDAKy9t4nPW
	 +oPrY9nxUQo5TZHgw2hjIHA5hR7QrSAkpoHp3Z0xdfkjrahfhYbtkvUEyBxZEndMEx
	 4l69LoG97vPU4Fut6fEnKPJ84JZg6rAJKwX1sYFH31ZEZiHaaf7mygFYygpILZOgcs
	 yLbMj4+HNcayg==
Date: Thu, 28 Nov 2024 14:14:20 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, herbert@gondor.apana.org.au,
	David Miller <davem@davemloft.net>, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfrm: Add pre-encap fragmentation for packet offload
Message-ID: <20241128121420.GH1245331@unreal>
References: <20241124093531.3783434-1-ilia.lin@kernel.org>
 <20241124120424.GE160612@unreal>
 <CA+5LGR2n-jCyGbLy9X5wQoUT5OXPkAc3nOr9bURO6=9ObEZVnA@mail.gmail.com>
 <20241125194340.GI160612@unreal>
 <CA+5LGR0e677wm5zEx9yYZDtsCUL6etMoRB2yF9o5msqdVOWU8w@mail.gmail.com>
 <20241126083513.GL160612@unreal>
 <Z0XGMxSou3AZrB2f@gauss3.secunet.de>
 <20241126132145.GA1245331@unreal>
 <Z0g3A87ArEdrOCgj@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0g3A87ArEdrOCgj@gauss3.secunet.de>

On Thu, Nov 28, 2024 at 10:25:23AM +0100, Steffen Klassert wrote:
> On Tue, Nov 26, 2024 at 03:21:45PM +0200, Leon Romanovsky wrote:
> > On Tue, Nov 26, 2024 at 01:59:31PM +0100, Steffen Klassert wrote:
> > > On Tue, Nov 26, 2024 at 10:35:13AM +0200, Leon Romanovsky wrote:
> > > > 
> > > > Steffen, do we need special case for packet offload here? My preference is
> > > > to make sure that we will have as less possible special cases for packet
> > > > offload.
> > > 
> > > Looks like the problem on packet offload is that packets
> > > bigger than MTU size are dropped before the PMTU signaling
> > > is handled.
> > 
> > But PMTU should be less or equal to MTU, even before first packet was
> > sent. Otherwise already first packet will be fragmented.
> 
> Atually I ment PMTU. On packet offload, we just drop packets bigger
> than PMTU. We need to make sure that xfrm{4,6}_tunnel_check_size
> is called. This will either fragment or do PMTU signaling.

Right, I'll check it next week (change is clear, need some time to set
testing setup).

Thanks

