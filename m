Return-Path: <netdev+bounces-107381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6851291ABA7
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992971C20956
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99EA1990C8;
	Thu, 27 Jun 2024 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjQYVKPd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61C8152DE3
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502884; cv=none; b=bQtFv28KWy+cQxo41UMarA91TMD2OEyT+Z10UR27e6cBc7ULjqJkYtRD7w1f4mZuTn5cGMcmgvAHb7rQVRP0IsfrUNuJfjObdsHjpnpBM86E5O53ZSm4gwlLrKYRArbsKMnQo3ugsB4ZQUjpki88d2T0fg5hZTBGqDMT+O4EvBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502884; c=relaxed/simple;
	bh=fR9DprWEeLbmIbYdRgAygRqGpS/P9y4mEDPFBkNRRgw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEn5x5+qON6mlJmCxhgrvQnke5yUGAKo7Lt/TkUPsNpZr/ztiIZ4UywDPlQt96lXKp5YZERYzMLqW+hjuUGlQG7vVTYDu23/nbxqP/T4C9bjmlxPEQEkmwSOOJ1X4CN+jvCCnW9nXZ1vxVKjUTiy12+zOSyh/HY/FM0Onbsbdr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjQYVKPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6911C2BBFC;
	Thu, 27 Jun 2024 15:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719502884;
	bh=fR9DprWEeLbmIbYdRgAygRqGpS/P9y4mEDPFBkNRRgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kjQYVKPd5WSrxyhb4sOTVR6ClXJg2nV2d9H2OGNjNlCBeetBkD9bfvr0pCT35gAQA
	 Yg27QdGI9tckzfGTcPAWI8Y3F6F1KJ8puKNPe7T8m3voZx9R9KnXYnyPh9egQQ7JrN
	 6VOfU3KNA/EWdipE0JVc8RbTAwjiJGNdNxO+aLUT5LgZQ56IyiQ+zRZCsNyMN/ujxF
	 4YeKjomrAoOcgq9n5QTqqhJaa391lSXYfdAcV4/XLr/NE5gzhYduJmTf/8hquptvNL
	 3Ln81w9ruRDt5iklR3NUkl0kKyCzMqOVEkOx8x83jE9tqu9mh28fKiBvCXCuzbDJaa
	 O87pzxJhv1SxA==
Date: Thu, 27 Jun 2024 08:41:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <willemdebruijn.kernel@gmail.com>,
 <przemyslaw.kitszel@intel.com>, <leitao@debian.org>
Subject: Re: [RFC net-next 1/2] selftests: drv-net: add ability to schedule
 cleanup with defer()
Message-ID: <20240627084122.125e9122@kernel.org>
In-Reply-To: <874j9eaj6m.fsf@nvidia.com>
References: <20240626013611.2330979-1-kuba@kernel.org>
	<20240626013611.2330979-2-kuba@kernel.org>
	<878qys9cqt.fsf@nvidia.com>
	<20240626090920.64b0a5c0@kernel.org>
	<874j9eaj6m.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 09:37:50 +0200 Petr Machata wrote:
> > I was wondering if we're better off throwing the exception from
> > remove() or silently ignoring (what is probably an error in the 
> > test code). I went with the former intentionally, but happy to
> > change.  
> 
> Hmm, right, it would throw. Therefore second exec() would as well. Good.
> But that means that exec() should first cancel, then exec, otherwise
> second exec invocation would actually exec the cleanup a second time
> before bailing out.

Good point, that sounds safer.

> >> This shouldn't exec if self.executed.
> >> 
> >> But I actually wonder if we need two flags at all. Whether the defer
> >> entry is resolved through exec(), cancel() or __exit__(), it's "done".
> >> It could be left in the queue, in which case the "done" flag is going to
> >> disable future exec requests. Or it can just be dropped from the queue
> >> when done, in which case we don't even need the "done" flag as such.  
> >
> > If you recall there's a rss_ctx test case which removes contexts out of
> > order. The flags are basically for that test. We run the .exec() to
> > remove a context, and then we can check 
> >
> > 	if thing.queued:
> > 		.. code for context that's alive ..
> > 	else:
> > 		.. code for dead context ..  
> 
> That test already has its own flags to track which was removed, can't it
> use those? My preference is always to keep an API as minimal as possible
> and the flags, if any, would ideally be private. I don't think defer
> objects should keep track of whether the user has already invoked them
> or not, that's their user's business to know.

Ack, will delete it then.

