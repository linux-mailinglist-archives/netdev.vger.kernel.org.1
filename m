Return-Path: <netdev+bounces-210575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C544EB13F5D
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B48A47A2B2B
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CA41B4223;
	Mon, 28 Jul 2025 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOX1p73v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504FF8479
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718517; cv=none; b=UI1hYoy7b5l136sUfhmKfg9+ojq9YmNA/sH8npPfrNjPhjTM8Y2k2KCl1jqXD4RzxrELiU6t3K83NRp/32wPHWVm9ar59s+mxFtkyY4yyP6w5lrN1J3BWzHri2TwHsZ5JI5N7IM+XgJ3B1SjcMiQwHMorI1HmFeYCvCNFe/bZOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718517; c=relaxed/simple;
	bh=u/Ou9o5/xihhmZ9YU6hDdCMplh926VAAAaYqkZYD9RE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ds35WUVFjEiMILQ/wtVceCDETbDMw1rszzH1YkGQED9qwmE8aZBVwpZnF8tPm/QUrgN615RyPXaF7KvLWL1ePudc8gE8sG7dpma7lXAwKQvFFjB6kfQceI9YKs+GZ/WUy+2ikug/fiXlEkd07wh6/ih6C6I2+53dOUln/iZRU0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOX1p73v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C84FC4CEE7;
	Mon, 28 Jul 2025 16:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753718516;
	bh=u/Ou9o5/xihhmZ9YU6hDdCMplh926VAAAaYqkZYD9RE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MOX1p73vIrKPUzVU4QJS6RD3aUuhriCLyBfVTTi9yBhcyTijCycsV8bRJg7x9ClDQ
	 yZ8nMbZmHKjzIYTLR/jJo7qAxogBJIEzCuM5cNCdJzozxm9Pvt69ot5sYvwSm+sFgl
	 iQxFkzWC373Qof2abKSXdEK0hULmARexXV1Ds1ecf9SOFLripxyJ4VLg7eEjhuRNNs
	 8q4eUEwx3z0TGKk2vW7ugbtmczCgs1wyqc8IzSSKe1bLRp4SmTZjlUk1ryLpp/V5zH
	 88u0Q/O0iAA//awtEMW1m8Up/FpkSB2SA0Opjmi916pT+ZB6wrnW1TExSl6hSiUZo5
	 B/R7PXQ3xcaEA==
Date: Mon, 28 Jul 2025 09:01:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krishna Kumar <krikku@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 tom@herbertland.com, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 kuniyu@google.com, ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 atenart@kernel.org, krishna.ku@flipkart.com
Subject: Re: [PATCH v6 net-next 1/2] net: Prevent RPS table overwrite for
 active flows
Message-ID: <20250728090155.384b2b14@kernel.org>
In-Reply-To: <CACLgkEY4cRWsRQW=-PSxnE=V6AvRuKuvYzXSuofmB8NMJ=9ZqQ@mail.gmail.com>
References: <20250723061604.526972-1-krikku@gmail.com>
	<20250723061604.526972-2-krikku@gmail.com>
	<20250725154515.0bff0c4d@kernel.org>
	<CACLgkEY4cRWsRQW=-PSxnE=V6AvRuKuvYzXSuofmB8NMJ=9ZqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 07:43:25 +0530 Krishna Kumar wrote:
> > > +                             if (hash != READ_ONCE(tmp_rflow->hash) ||
> > > +                                 next_cpu == tmp_cpu) {
> > > +                                     /*
> > > +                                      * Don't unnecessarily reprogram if:
> > > +                                      * 1. This slot has an active different
> > > +                                      *    flow.
> > > +                                      * 2. This slot has the same flow (very
> > > +                                      *    likely but not guaranteed) and
> > > +                                      *    the rx-queue# did not change.
> > > +                                      */  
> 
> I took some time to figure out the different paths here as it was a
> new area for me, hence I put this comment. Shall I keep it as the
> condition is not very intuitive?

To me it just restates the condition, so not worth keeping the comment.
You could add the explanation of the logic with more justifications to
the commit message if you'd like? (perhaps you have it there already..)

