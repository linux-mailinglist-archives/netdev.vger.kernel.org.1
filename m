Return-Path: <netdev+bounces-181345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F143FA84948
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C9A17B4D7
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A821E9B14;
	Thu, 10 Apr 2025 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VA3UiaXc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74A189F5C
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744301284; cv=none; b=cgMAqFBgW3duUO0HGtmh48LDtI4nThqBjNt5atYOSdU7IPg0MCkXyUktt4rgk6KIh4AylD82e1q4/BQ/WOmikM0K4wolSHNxJ4j3h2JIPAwS4QV2bx1emjUZnGTz72BTaKyyw2XibmxLyGsT08c3TAmwkHVi6pETP/wIo3B34Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744301284; c=relaxed/simple;
	bh=HlsR8ChgYqXHIorcQJbZzGnvN03OnYCjS8E0mGPeGXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Opm6OKG7caEiNRAAZp5TQzVm8HM8LtraSvjNoZGxBIE5S6Ko7CSbIDV0xI8hjBza7vR9RY2S+xHELLabo4p/xRsKSKXl7D6ZgqxnOYyx4KS3oHmG+2LpR6R73mejBHik79a77FZCnucRgBmxxH1OlHdF/VLwWpo+NbjbHQ8AJSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VA3UiaXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEEDC4CEDD;
	Thu, 10 Apr 2025 16:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744301283;
	bh=HlsR8ChgYqXHIorcQJbZzGnvN03OnYCjS8E0mGPeGXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VA3UiaXc4eFkd0OHtZqQXc/yJqa8ZPf6RSbGWI3dvOKCBl81A6x35kagCpLsy8UY6
	 jbGn7JCl8yB0n1vphMTHUAwvcVsZo86eo8tfqR0EnfS2a56EwjkQ/97DYgQEcruywC
	 XX2fHxcKO/RDaNCgOlLpe/f+X2LKpB8vqS6dJBGKnvUuGA6M4upfhdke9gSKgr9eCN
	 wLYs4uhx+G/2C8dSEEQeUibtFj65+o5nPilDAVyOpPHnaf0tDNI8mahxvILFzI5NQv
	 X7Lm2tYkuInF1rZiAkNe8+afkWYgHRXzMWmcr69mSinWrtzIFcUO2LqliS45wSVUuR
	 mHXwSgt+aYFLw==
Date: Thu, 10 Apr 2025 09:08:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <sdf@fomichev.me>, <hramamurthy@google.com>, <kuniyu@amazon.com>,
 <jdamato@fastly.com>
Subject: Re: [PATCH net-next v2 7/8] docs: netdev: break down the instance
 locking info per ops struct
Message-ID: <20250410090802.37207b61@kernel.org>
In-Reply-To: <119bf05d-17c6-4327-a79b-31e3e2838abe@intel.com>
References: <20250408195956.412733-1-kuba@kernel.org>
	<20250408195956.412733-8-kuba@kernel.org>
	<119bf05d-17c6-4327-a79b-31e3e2838abe@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Apr 2025 23:01:18 -0700 Jacob Keller wrote:
> > +All queue management callbacks are invoked while holding the netdev instance
> > +lock. ``rtnl_lock`` may or may not be held.
> > +
> > +Note that supporting struct netdev_queue_mgmt_ops automatically enables
> > +"ops locking".
> > +  
> 
> Does this mean we don't allow drivers which support
> netdev_queue_mgmt_ops but don't set request_ops_lock? Or does it mean
> that supporting netdev_queue_mgmt_ops and/or netdev shapers
> automatically implies request_ops_lock? Or is there some other
> behavioral difference?
> 
> From the wording this sounds like its enforced via code, and it seems
> reasonable to me that we wouldn't allow these without setting
> request_ops_lock to true...

"request" is for drivers to optionally request.
If the driver supports queue or shaper APIs it doesn't have a say.

