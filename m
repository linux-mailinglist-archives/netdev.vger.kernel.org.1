Return-Path: <netdev+bounces-151688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AC59F0995
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24693160648
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06701B6D18;
	Fri, 13 Dec 2024 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr7Q4klB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB71E1B21AB
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086102; cv=none; b=n3/kNjHFlvcA42mByZQAFDPAR3YsXNdImo0FUsOIPnZH5kzJRzhL+UYED4R2xopdHEbg/BvWkdPhw5BuRg7A4f/tzdTZhVZV2BkFw3eIflkOr9r9TF4b1L+0WkKp2SE8XUgp9DLRjNjY6xKuxo+stpnSYErUm8itmNemMiuStyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086102; c=relaxed/simple;
	bh=GOyt87T6w3/aSeB+EYCX/He2ptMenbnh66Yigq8U/uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5mzPFqc0p7Pe4OWdHAHgULEPCIK7NRCP3XpbwnDerxryCZNFS8YpgbyYAo1yQv1srw69dMwCLzSRUIzIdNp3mDBe8LsnXfgT/bG7eRpSPVvU+ffFoIY7Wf7bPFMXz33ZJKUHgkHReU3oGZ6MKJMXL4/ju6X3WrbvWAzRz3NlPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dr7Q4klB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4963C4CED0;
	Fri, 13 Dec 2024 10:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734086102;
	bh=GOyt87T6w3/aSeB+EYCX/He2ptMenbnh66Yigq8U/uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dr7Q4klB+ehwaEiRJ6i1iM+Wqzd6EcPk1swdaFcL7F60RgiNTZJySKDl0nC9M8AoB
	 MYM4r6w3qBd+FIbSRrJ5whZ8VmWnShnxOhI7ylBCZCCqR8rg8EvUkDLajXpPGxCZ1F
	 ahiWq7YIC9Lj5rjefLnzVc8o1qPHg8ooC80AEAmqgpSNOqt1DSbqAr5iptuKpqEYPi
	 5iw8/gXJSlYMvwQj3ZZcEzH6XiC4snwyXCgPV1jKaabOpLCyzgNB0erm/bhCKZ0UvB
	 WS3tsxUw4HSKQB3KyKyP3ZBnvMSRv1jK7+CjZrDkn7CBKMKPOlieoORs2UtHwNjbBg
	 gLdZ7XXR8VeYg==
Date: Fri, 13 Dec 2024 10:34:58 +0000
From: Simon Horman <horms@kernel.org>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] netconsole: allow selection of egress interface via MAC
 address
Message-ID: <20241213103458.GK2110@kernel.org>
References: <20241211021851.1442842-1-ushankar@purestorage.com>
 <20241212101156.GF2806@kernel.org>
 <Z1tkWqxwF+3JpGcv@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1tkWqxwF+3JpGcv@dev-ushankar.dev.purestorage.com>

On Thu, Dec 12, 2024 at 03:31:54PM -0700, Uday Shankar wrote:
> On Thu, Dec 12, 2024 at 10:11:56AM +0000, Simon Horman wrote:
> > Also, as this is a new feature, I wonder if a selftest should be added.
> > Perhaps some variant of netcons_basic.sh as has been done here:
> > 
> > * [PATCH net-next 0/4] netconsole: selftest for userdata overflow
> >   https://lore.kernel.org/netdev/20241204-netcons_overflow_test-v1-0-a85a8d0ace21@debian.org/
> 
> Sure, I can add a test. That patchset does some refactoring that I'd
> like to use though. Can it be merged? It looks like it's ready.

It is in the queue for the maintainers to decide on.
We will see :)

In any case I agree that it makes sense to base your test
on the refactoring in that series, unless that series gets
derailed for some reason.

