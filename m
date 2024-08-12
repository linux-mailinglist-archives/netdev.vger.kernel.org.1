Return-Path: <netdev+bounces-117844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006BA94F894
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 22:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342E21C209A7
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 20:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507401922DA;
	Mon, 12 Aug 2024 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU2Pjtir"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA0E152199
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495873; cv=none; b=Tg53C0WBbSDG0wcmeCYfha5CI+B4KbKXI3bbXZFTAkVRcEN1YgNsd3wIDBhmKWrOeBpvBaUhsiJqGIEoeJosK7D8s3y26vHHoyGP8dleYqjcMDYv5iwRjl/mfLe+CohTMRcnjBZgCtgCaDLWlPQwR1fZdyIc96rm/2fVww1w91Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495873; c=relaxed/simple;
	bh=Z/55FYUJ2h3gDBewOKEgb8waAudLus7qV6NITdJ1Tws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BqVwXghveOYBc6yKO+FysCxHb91sgtR3x6146sAyJtKPKYRHydC2umSRviqgy7dtARpy1w3aWdvMs7a1dkvroCkzDj0P2f3n0EZvYkra+LNx89BE4pJxk39GzzdrHKW/bXiWziJ5bm7d4MTHi83ZqW1A9Vv9vyXgWzPgmNiShBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU2Pjtir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6795DC32782;
	Mon, 12 Aug 2024 20:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723495872;
	bh=Z/55FYUJ2h3gDBewOKEgb8waAudLus7qV6NITdJ1Tws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aU2PjtirSgKamgW5C9X/ggYF6ze6YaMd9aCPMnn9kjX7lRlZrVhFufQ3xW67LOA+E
	 ew2GaC3FXoohErOa2c+wt9c+6bUMJnOuU7ipzW8hzU7upfLgsbSAybxJ4K8XsrvvcM
	 h9PTu9qG+RJsG/JiymNDYe0Se4Yp3yCSh9i2/cbhLGr0tZIyb+WCHsdTEua86R88uA
	 EsG+EM5kUz14P1S73tXVhYQut6dDZOS8Vf9XvQ/VNM39YuGnkKTrESKtiGAzopMCyk
	 2R1L49EO6bcyg/9wrKlmpGAh9BctyiOomj0sowHAycFNdNwuMgk1hDqIK5F6b+YCYN
	 afT7xuGxhZyCw==
Date: Mon, 12 Aug 2024 13:51:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ziwei Xiao <ziweixiao@google.com>
Cc: Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 willemb@google.com, jeroendb@google.com, shailend@google.com,
 hramamurthy@google.com, jfraker@google.com
Subject: Re: [PATCH net-next v2 0/2] gve: Add RSS config support
Message-ID: <20240812135111.378be14b@kernel.org>
In-Reply-To: <CAG-FcCMT+bdJg+R7rY309GbwhLTXefd3EMh07TH9yp1mz-Kt+g@mail.gmail.com>
References: <20240808205530.726871-1-pkaligineedi@google.com>
	<20240809222226.42673806@kernel.org>
	<CAG-FcCMT+bdJg+R7rY309GbwhLTXefd3EMh07TH9yp1mz-Kt+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 09:40:13 -0700 Ziwei Xiao wrote:
> > Code looks good, thanks!
> >
> > Unfortunately the series didn't get into patchwork.
> > Could you repost?  
> Should we add any changes to resend the patches such as changing the
> version number or add a RESEND tag in the subject line, or if it's
> okay to just send the original patch series? Thank you!

v3 is best, add something like this to the cover letter:

v3:
 - no changes, pure repost to get the patches into patchwork
v2: https://lore.kernel.org/20240808205530.726871-1-pkaligineedi@google.com

