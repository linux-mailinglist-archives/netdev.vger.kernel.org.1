Return-Path: <netdev+bounces-189300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033E7AB181F
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6E41788BC
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9DF23535A;
	Fri,  9 May 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/+LFOLQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E660A23504F;
	Fri,  9 May 2025 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803415; cv=none; b=VvUt54RzHkj202UjlCgCSOeTTCMOqFJbfGvuKekgAQiRT/YBjaSwnt8mS+zbzZIyINqoqA5iUnZnEIazuTKxFYPEV2N/Try+2k2PKdocfF+K3j/DTFhImscRftTGG665MTTLJFrVQNDCBZ4yagPGapg0u6lCzhFwEgYVYpH/YFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803415; c=relaxed/simple;
	bh=qkjHOlLmyt6yQtAnTPCkxud4dJDEGgNNDold91+8/NE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/Ov6GYuf1zS8JaRkMGRhybeYxjpun36qW1q9n/UkvHYB1z0O520BCwyiqiH8BXEyJgt9K/vniEcnNoL1RBPEtJwAip8uIyABIYnBlmyQxTnyq1kDD3Zyo9A3YyWwajDmbuM4Em63M3ns6r/dzp5FjO57L1k0/Z+As96Y/7sm68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/+LFOLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DF5C4CEE4;
	Fri,  9 May 2025 15:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746803414;
	bh=qkjHOlLmyt6yQtAnTPCkxud4dJDEGgNNDold91+8/NE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s/+LFOLQYyMMzpL8QB4L4Z1c4DdIEh5iNYcdwCFnGNkumZFKyISrIU5j0ib+FzaSc
	 1ve1P1m8M2YRTlKE3MCCH+3aua+jtixqXcx9gf0j6CY5PUKN42ZEqyrzvxbtGWa1If
	 UW3gnDQel3KRfiUPPnPOKUv2VGbbxu2Ge7ekBJ18Qup/iu8ld0anXlDaj3p65bRJBG
	 raSZlxi5C5+M/NUqCVlz6wT67cPoR6asVXy1wwcAHRNPvTVge6PpYYujB/2NAoABTH
	 Hz+XSGOA+Ac09PwGyC0amGYzOHSHohGj8se+7m87efpLW5OoVYQNKUQNpX9ZvigvUJ
	 bUWhV1n7amE6A==
Date: Fri, 9 May 2025 08:10:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller"	
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni	
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula	
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Kuniyuki Iwashima	
 <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, Nathan Chancellor	
 <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v8 10/10] ref_tracker: eliminate the ref_tracker_dir
 name field
Message-ID: <20250509081012.31e55987@kernel.org>
In-Reply-To: <950c901d046b5fc806ba61cd96f2d774de3f9c7f.camel@kernel.org>
References: <20250507-reftrack-dbgfs-v8-0-607717d3bb98@kernel.org>
	<20250507-reftrack-dbgfs-v8-10-607717d3bb98@kernel.org>
	<20250507200129.677dc67a@kernel.org>
	<950c901d046b5fc806ba61cd96f2d774de3f9c7f.camel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 09 May 2025 09:36:57 -0400 Jeff Layton wrote:
> On Wed, 2025-05-07 at 20:01 -0700, Jakub Kicinski wrote:
> > On Wed, 07 May 2025 09:06:35 -0400 Jeff Layton wrote:  
> > > + * @quarantime_count: max number of entries to be tracked  
> > 
> > quarantime
> >         ^
> > :(  
> 
> Sorry, I thought I had fixed that. Do you need me to resend? The pile
> with that fixed is also in my "reftrack-dbgfs" branch:
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/

If you don't mind, a resend would be good.
Our CI stops if it sees a build warning, so it didn't get
to the selftest stage with this patchset.

