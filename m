Return-Path: <netdev+bounces-176732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6404BA6BB3D
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 13:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C375119C35DB
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0F5227EBD;
	Fri, 21 Mar 2025 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SWEnqRYe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BEC225387;
	Fri, 21 Mar 2025 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742561544; cv=none; b=MA0goZYBY17/a08BemP/fuIVP8evD7KIz0ExLx7hvMWiA4MTOa9JswODQfyAtmho4bQ0I4+j5jLtSti8xIhbqzufRcdvlQKBS15chPyj7GxarK7kC3q4lVN61Zkam3zY1z+pm0if8nuLKbgqxNj80a6UwZ0PZDTaIe0YESUJZg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742561544; c=relaxed/simple;
	bh=SUKhHUcxhL0l5xhcTWSK8TZ43wGOHoBGsqPnsArUmlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNZYxFOfmBFiC+uWFnjWPXeFFkNh97/wxCC1c/sDCaNBC0zdN1Icr0jazRpP5hLv1mkxfiQ/++S/SXmjDju7YrOGAEKaJFLv4X3Xp3O6FHAihrxJbh5yK9ieQ9GGE0Ay1t3M3DYONQnFpIBbaFtG57+aBD1Xg7ak9/2Hrti53Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=SWEnqRYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E8DC4CEE3;
	Fri, 21 Mar 2025 12:52:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SWEnqRYe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1742561541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iBEsa6g1RBoSR0J0Kh1JDeWbWAeUk9HC8KUOCLyfPJc=;
	b=SWEnqRYezPlf1E+iZomGlmtJq8Gz+rfAumlre6h7c18OJEcuJ4KtkGml//SFMb2XME2nNm
	HSXdKIdcS9scfPpO1trtdon3a+KYMkSIlGNj04dk46QWfMuxFyMAfKQJTfmoLjvl4vEAjU
	DRtuBxODEY438a851a6a+dzfHYMp1cI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 991796b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Mar 2025 12:52:21 +0000 (UTC)
Date: Fri, 21 Mar 2025 13:52:19 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	Markus Theil <theil.markus@gmail.com>, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, netdev@vger.kernel.org,
	tytso@mit.edu
Subject: Re: [PATCH v2 1/3] drm/i915/selftests: use prandom in selftest
Message-ID: <Z91hA0q-uC04asw2@zx2c4.com>
References: <CAHmME9oqvWp_Nd1Gwgyw52qy8wxztMyCpNsjByH=VnRaXqczww@mail.gmail.com>
 <20250211063332.16542-1-theil.markus@gmail.com>
 <20250211063332.16542-2-theil.markus@gmail.com>
 <Z64pkN7eU6yHPifn@ashyti-mobl2.lan>
 <Z9r7ORwztMxsNyF4@zx2c4.com>
 <874izmd0g4.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874izmd0g4.fsf@intel.com>

On Fri, Mar 21, 2025 at 02:37:15PM +0200, Jani Nikula wrote:
> On Wed, 19 Mar 2025, "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> > Hi Andi,
> >
> > On Thu, Feb 13, 2025 at 06:19:12PM +0100, Andi Shyti wrote:
> >> Hi Markus,
> >> 
> >> On Tue, Feb 11, 2025 at 07:33:30AM +0100, Markus Theil wrote:
> >> > This is part of a prandom cleanup, which removes
> >> > next_pseudo_random32 and replaces it with the standard PRNG.
> >> > 
> >> > Signed-off-by: Markus Theil <theil.markus@gmail.com>
> >> 
> >> I merged just this patch in drm-intel-gt-next.
> >
> > This is minorly annoying for me... What am I supposed to do with patches
> > 2 and 3? Take them through my tree for 6.16 in like half a year? Can I
> > just take the v1 into my tree and we can get this done with straight
> > forwardly? Or do you have a different suggestion for me?
> 
> Feel free to apply it to your tree too. It's not ideal to have two
> commits for the same thing, but oh well.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>

Oh that's a good idea. Thanks!

Jason

