Return-Path: <netdev+bounces-49746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7787F3558
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 18:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796AE1C208D2
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 17:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD68720DDF;
	Tue, 21 Nov 2023 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DERQnK0m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03573D8C
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 17:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A92C433C7;
	Tue, 21 Nov 2023 17:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700589314;
	bh=n1Zn5nlS5xH9kFxuUwCKmtIQwpyHIwddlCzscTmphY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DERQnK0myt9snuJFTi4uDQHTQukDTVxBRmmXLVLdDMH1v0BHUGxOqHJ7snfYouGdU
	 pTvuMgvprTBvFdPROi0EfyEDsAXPrEAx83YxQfQ5uU21Tnp+IJzZPvljHvWmQOD1a9
	 0xCLSmxOe5PUmJs+dU5xWOHUZwRVkJ+4WrKY9wbik9/r7FRgUfdWf/yMn1bv5aYj5N
	 UnN3YeLqwRt2yDvXyWYsbSaWkMeTCTBxrcxWcPBFE4EhXg749b5WVrnFofTAWFmP8y
	 neWLVCLsY02yxJtzAPY4apK3nldBqorGsyW4pvWoWX+o6PUIDvNjlDysSiax2d/PiM
	 GmpBaIITSZI1w==
Date: Tue, 21 Nov 2023 09:55:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
 johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
 amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v3 5/9] genetlink: implement release callback
 and free sk_user_data there
Message-ID: <20231121095512.089139f9@kernel.org>
In-Reply-To: <ZVys11ToRj+oo75s@nanopsycho>
References: <20231120084657.458076-1-jiri@resnulli.us>
	<20231120084657.458076-6-jiri@resnulli.us>
	<20231120185022.78f10188@kernel.org>
	<ZVys11ToRj+oo75s@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 14:12:55 +0100 Jiri Pirko wrote:
> >How is this supposed to work?
> >
> >genetlink sockets are not bound to a family. User can use a single
> >socket to subscribe to notifications from all families and presumably
> >each one of the would interpret sk->sk_user_data as their own state?
> >
> >You need to store the state locally in the family, keyed
> >on pid, and free it using the NETLINK_URELEASE notifier...  
> 
> Well, pin can have 2 sockets of different config. I think that sk/family
> tuple is needed. I'm exploring a possibility to have genetlink
> sk->sk_user_data used to store the hashlist keyed by the sk/family tuple.

If you're doing it centrally, please put the state as a new field in
the netlink socket. sk_user_data is for the user.

Also let's start with a list, practically speaking using one socket 
in many families should be very rare.

