Return-Path: <netdev+bounces-183891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4990EA92BB3
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7341B6651E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627391FFC4F;
	Thu, 17 Apr 2025 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eERAyV8S"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03131FF60E;
	Thu, 17 Apr 2025 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744918008; cv=none; b=cNwOtiqV0Gd+DtAffqRKNIMRdeQ8F/TL1n4SBcjYPDvnJL60O/pheJAr1Zse6aepzNsOk+DeLt9063IFssEo1DqbDDzgGU9V2pvWqAIKnaywedMApoiK3nlryeehus6ZAAQzWXU9tNLRQo/ebRDu06rjoOdhnvr+GD0MooM2hvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744918008; c=relaxed/simple;
	bh=IHPtnIfi6f8KDLDgve2g6vvQovf4Noy158Iwjuwgbyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAy4WWdeTpbIsuyLj5zJyEuRtwcCdwb+MWrgAx4CBEw5fmbTCzOm3cOvqi8K4AqV8rFIbvKQldMosEWlh+Tf3SaCkkD1GenmyQbjNdu9InzkQqcYXOE1moDl62BRSX4pq2uuveK9WUPXx9hLsFZvrqUeNh4GbKh084uo6AFcyuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eERAyV8S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=H0l0O/+vPdquCSr+CZ01ghKfCZRXnYFO1/2RNrcPM6E=; b=eERAyV8SVTEuCyPmUKFRYdUaqi
	CxJb5Jk2qD0DJ0Mi6813LvSIVr7NQzIkMd1Tob/74fNY86xHTQ23DOrSYXKj3I32QsCD7NUK1tGz3
	i4YEPddc7RmKioRMPLjH26PWhUVLsQfmarrXgSDhAnsUAAk4YppsbjTyPqBSCOcrhpwI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5Usd-009p7F-Ry; Thu, 17 Apr 2025 21:26:35 +0200
Date: Thu, 17 Apr 2025 21:26:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Qasim Ijaz <qasdev00@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 3/8] ref_tracker: have callers pass output function to
 pr_ostream()
Message-ID: <63f4d126-1ee1-47dd-9d72-aa2b13e124d4@lunn.ch>
References: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
 <20250417-reftrack-dbgfs-v3-3-c3159428c8fb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417-reftrack-dbgfs-v3-3-c3159428c8fb@kernel.org>

On Thu, Apr 17, 2025 at 09:11:06AM -0400, Jeff Layton wrote:
> In a later patch, we'll be adding a 3rd mechanism for outputting
> ref_tracker info via seq_file. Instead of a conditional, have the caller
> set a pointer to an output function in struct ostream. As part of this,
> the log prefix must be explicitly passed in, as it's too late for the
> pr_fmt macro.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

