Return-Path: <netdev+bounces-161657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F82A23111
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 16:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5991672EE
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 15:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7572E1E98F3;
	Thu, 30 Jan 2025 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJ2iK+Vs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA9D158545
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738251359; cv=none; b=NDQ6kaZ/Cj2mkjfTKneU4kIbRWsZZP2P1PRUjNzn5vkCtE7BFVQ59tyYsjG822CwunK39Cs6NsLUz4cEk+mggSQ5psA4PyGt0A3SqzADvNtT598aD/gCsC8BZkKwBDrcsOEqUcHb4dy24R6TrKx4Y0Z442l0BjNt9BIDgHywgK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738251359; c=relaxed/simple;
	bh=dly84mGzthqPBdRl0Trz2TPRBIoo8+nAOhYTKpvuRsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U92R+N8QqF/gJL2afB/aRoG+46IUim56gqidJBcnCtNN7T74NmCQ9BOgoIWfAEVo5S/SSe98lKcfUM+qIZ2zAovd8QWTDaKCnF0AouAC5EpKfYW2NBMgZmDwPRkAnr8ZQdDMFQFHoIu1Q/wz7CcuZnZR6Nnh6tLGJ8IzV2AMj8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJ2iK+Vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DD4C4CEE2;
	Thu, 30 Jan 2025 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738251358;
	bh=dly84mGzthqPBdRl0Trz2TPRBIoo8+nAOhYTKpvuRsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TJ2iK+VsZiAHBTlveHKb4KJnuODLXkeFgtdtsxRD8f7gAj3B3PEZVQdwmXpwoTsCV
	 k3xCd0ZvuQ1KDC+z1ukNaxSVDqbZ0doHm9Cg/s6RWc0UFG1+qKdY9yzwFLgnGtRkMe
	 3ahf0zQLzDI9VaVtw8WOW/4tX+J2IrYXil80tIdBtsBgv3coisEDr2UAAq/Pr8KsP2
	 03L56KopY7OocI8GTTYgVAXz19kbuuLRL9ZfGjmKMyj4wi8xiTjiOU+ID5UxyScA4L
	 7b8+4MFz18XR72zbIKZL0TCd1qsoFxqZDt1YCNAbJGS34wX3lKQ0OHK75WPT18QhV9
	 pZCCweF1kn9Lg==
Date: Thu, 30 Jan 2025 15:35:55 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Justin Iurman <justin.iurman@uliege.be>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, dsahern@kernel.org
Subject: Re: [PATCH net v2 2/2] net: ipv6: fix dst ref loops in rpl, seg6 and
 ioam6 lwtunnels
Message-ID: <20250130153555.GA13457@kernel.org>
References: <20250130031519.2716843-1-kuba@kernel.org>
 <20250130031519.2716843-2-kuba@kernel.org>
 <20250130102813.GD113107@kernel.org>
 <91681490-63fa-405f-84cc-7ec0236eba8a@uliege.be>
 <20250130065610.1f5aa007@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130065610.1f5aa007@kernel.org>

On Thu, Jan 30, 2025 at 06:56:10AM -0800, Jakub Kicinski wrote:
> On Thu, 30 Jan 2025 14:41:56 +0100 Justin Iurman wrote:
> > This was my thought as well. While Fixes tags are correct for #1, what 
> > #2 is trying to fix was already there before 985ec6f5e623, 40475b63761a 
> > and dce525185bc9 respectively. I think it should be:
> > 
> > Fixes: 8cb3bf8bff3c ("ipv6: ioam: Add support for the ip6ip6 encapsulation")
> > Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and 
> > injection with lwtunnels")
> > Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
> 
> I'll swap the tags when applying, if there are no other comments.

Thanks, SGTM.

Reviewed-by: Simon Horman <horms@kernel.org>


