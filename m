Return-Path: <netdev+bounces-141207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7979BA0A4
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 14:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508BE1F21882
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 13:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEFC18B477;
	Sat,  2 Nov 2024 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8Z4jNIw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242C415884A
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730555929; cv=none; b=gCfUPoJ0UlD09gxsKy+m7mdI1NQYgUCOU0pqUK99I+Vg45MwQkZOtfbxE92xtmA7tnET1yJqfRTMOkYejmTcrWr3hOHLk2Xu9Zj3eUeZgFt9IKL2Rm8ZyJIYwKxZ7Yt1qe9EAdbOsc7xybffocqN6z57Fn1JkH9XgSKfhquQdus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730555929; c=relaxed/simple;
	bh=mg7JT0oGc946bHqSmO3ptSbSTk074KDaebAPyi46XKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJ3lUW9ezI7H5vPl+3P4o7tgBNGvGVPAfVdbrV+LSWxSgAyLvjLa7M2wH6m4GZEMA/bFixmotmJ/1Tt1P6EV+mVOfr0RTZh+lbiMtviKx6Q1ZPID5zpdYqweTJjiS3UL7YvkjEBn3RvBkJ1+F9Hd7zSrjnFnOI8ktvmV24Q4ydw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8Z4jNIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78103C4CEC3;
	Sat,  2 Nov 2024 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730555928;
	bh=mg7JT0oGc946bHqSmO3ptSbSTk074KDaebAPyi46XKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E8Z4jNIwkbgX6Ax0fv02uFRiCTCA+IVlJ13rLHHHV2D4MgKDiXxUkD/Ppb2w1WxYF
	 7UYAdcCTAq2199pDH03fL1ulA1ZH2bMTD3n9tFHSXA5t7wUaMbi6ZdwBKPToPbE50o
	 206vhChowtlZrbiwz787hodgn2WskzVkjqkwK1sLPtOx76r5JiyBlgDLxXny2C+vFB
	 np+PxWdVsCJq0EdISpG5Hrhi8w9EBuA0uOkrxmo9MrEk6zye+qhmgJYPlgfzJVryjO
	 unop8LOSOYzxogRJJHfK7RG3cw1XdpQqWbx6Jx9zzLkepU3eG+NKFoa94fRKpK+BYb
	 nmDuChfxvg7uQ==
Date: Sat, 2 Nov 2024 13:58:43 +0000
From: Simon Horman <horms@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: ncsi: check for netlink-driven responses
 before requiring a handler
Message-ID: <20241102135843.GL1838431@kernel.org>
References: <20241028-ncsi-arb-opcode-v1-1-9d65080908b9@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028-ncsi-arb-opcode-v1-1-9d65080908b9@codeconstruct.com.au>

On Mon, Oct 28, 2024 at 03:08:34PM +0800, Jeremy Kerr wrote:
> Currently, the NCSI response path will look up an opcode-specific
> handler for all incoming response messages. However, we may be receiving
> a response from a netlink-generated request, which may not have a
> corresponding in-kernel handler for that request opcode. In that case,
> we'll drop the response because we didn't find a opcode-specific
> handler.
> 
> Perform the lookup for the pending request (and hence for
> NETLINK_DRIVEN) before requiring an in-kernel handler, and defer the
> requirement for a corresponding kernel request until we know it's a
> kernel-driven command.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Hi Jeremy,

Not strictly related to this patch, but I do wonder if the log messages
should be rate limited, which doesn't seem to be the case at this time.

Regardless, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

