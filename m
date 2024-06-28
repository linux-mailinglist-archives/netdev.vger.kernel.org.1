Return-Path: <netdev+bounces-107789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B40391C59D
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 20:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E121F22910
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 18:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3D91CCCBA;
	Fri, 28 Jun 2024 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFICYDrQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A7CDDC0
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719599112; cv=none; b=YsXjLn2wbsKTOY1a6lLpeQIIgEEE8hGnyjiHvNucTDZLxG5JmY+4TYrneQ4S3GLGQwYj6oHpcCMhYPwDN8XPeUKSRybVboMI/5Dpv7rG0dOSqfnQJAhZvdr84dk4PThfkMErzZVOvWPQEJL8RqhvbY7fpemM27bg56Rve7YdP8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719599112; c=relaxed/simple;
	bh=84F1j1O/PzUWmQC1iWnQz2NAnHWgc1MJHpiaRY3OPKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcJQ+F/EZ+5tNHoiMp953U0owAA3uJeCT7dXu4cxF2zfL92507CJlD5arBnfW7bfpfN1EsCvrv5NgV/vCEOGrmk2rcZGpKQ7YOk1lZp8wAcL3OkmpKTgHeNY2LZqqPp8k/fUD6ddA/Of1lgz4y4B17DckeHSuPOsvrb4g8EaIfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFICYDrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22705C116B1;
	Fri, 28 Jun 2024 18:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719599112;
	bh=84F1j1O/PzUWmQC1iWnQz2NAnHWgc1MJHpiaRY3OPKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lFICYDrQKIx7BTHu9tHllcKsW6lt0bEPpxzNSReN7qcjSJ0Hq5ZuaszVTw1W1LX/V
	 2JrfwU2qVaou2JMtZvK3nfKzm1zoVqdSiMpl6dpaagE/RS7WqCwu7d4olslG4x3Zm8
	 6i4Rr8agx62uQPR7d5fKqMksGIblmhSmmJkmxbi/MMLKGl8eU+wSz5h0TiS50d/p3l
	 ZLHRaiVK15MT2PyD+Cafp+ehL4pqTIXTWLinI9e+XiBjP7OomYDowyJZOSD6n3eKmg
	 v6KdM+1HwTgi8TSeYA4fs+W6ePH0lK5CCVUiMTmX1VwWWaQLFVNyYVP9/BT0UN7lZc
	 j7M4Y19SBybuw==
Date: Fri, 28 Jun 2024 19:25:09 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com
Subject: Re: [PATCH iwl-next 5/6] ice: Optimize switch recipe creation
Message-ID: <20240628182509.GF837606@kernel.org>
References: <20240618141157.1881093-1-marcin.szycik@linux.intel.com>
 <20240618141157.1881093-6-marcin.szycik@linux.intel.com>
 <20240628124409.GD783093@kernel.org>
 <5328363b-1ff0-439e-94f7-c6d3ca6039cd@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5328363b-1ff0-439e-94f7-c6d3ca6039cd@intel.com>

On Fri, Jun 28, 2024 at 03:56:55PM +0200, Przemek Kitszel wrote:
> On 6/28/24 14:44, Simon Horman wrote:
> > On Tue, Jun 18, 2024 at 04:11:56PM +0200, Marcin Szycik wrote:

...

> > I appreciate the detailed description above, it is very helpful.
> > After a number of readings of this patch - it is complex -
> > I was unable to find anything wrong. And I do like both the simplification
> > and better hw utilisation that this patch (set) brings.
> > 
> > So from that perspective:
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > I would say, however, that it might have been easier to review
> > if somehow this patch was broken up into smaller pieces.
> > I appreciate that, in a sense, that is what the other patches
> > of this series do. But nonetheless... it is complex.
> > 
> > ...
> 
> all of the "bugs" that I have internally found for this patch were
> addressed by commit msg or comment changes ;)
> what about you reviewing also patch 7 from v3 of this series?

Right, sorry about accidently reviewing an old version of the patchset.
I will look at 7 from v3.

