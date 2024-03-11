Return-Path: <netdev+bounces-79238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA158785F8
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 18:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 160B3B21718
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 17:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D563C46B;
	Mon, 11 Mar 2024 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lwi0CgB4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CABF4D9E4
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176712; cv=none; b=mpcSIkjOzQzFm3EJPnbFAw5JzZqORKrlFcC434BAabMA5iF1Zc5mhDfprK9om7SOhVwn3z7M2r8G7Jkm6r6Is/Ig6X68HxrNIdDFdjbxPzQFTZZDOV3Fiz80IUDnDsi1fnKw2rL6l2J0EOiohFpy6b8nX48EbfNCEIfdHrRVNro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176712; c=relaxed/simple;
	bh=tiqsUKZdBPC3+B4cRKS8C5vjTM9xswrPWQVlMQQtTNM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGOGsBQd9G4DEYuAUSPsp3MSBfHk9m572acG+1P7AEuUxdFu0M4k7befxbuKmcThGAXKXfpuFy7xC+T8pZJ94nbqIjNs5ABL9rcidVH5WKXdf+m1MMUijviEXng9cqzvsySLg4zYbprSYkbImWGDJK+l1nAs+0m3mk1kCAqn4o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lwi0CgB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452AAC433C7;
	Mon, 11 Mar 2024 17:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710176711;
	bh=tiqsUKZdBPC3+B4cRKS8C5vjTM9xswrPWQVlMQQtTNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lwi0CgB4VIW+4TcyZWyaUv53qFnK6qYgB8Q2+Ls9ueBZXEaa63wP229/+8rir6Szj
	 OI0iLkhNVSq5nulJBdr7gMrtBJOLtUyn4950bSakRiC95hTNjWt20CQhlDClvtaUbE
	 ZaI4fYAaNzv3T6mls16FtEKF0eE+gPENe1FOuHp8T9DVO2iR+VfBS804Vk6k66kU+p
	 oMrnwefOILJUxcfYrgTMsg7xMrEps/EukpkCl7G/nDxWZ3ecp/Fx7HiWLLFXtr7p+8
	 RH48xBFVUMASsNPB8MBjFEgp5vWf2Hzs1AKRAwLv5FXUiEsTVuXN67NTZD/SUpRSSt
	 vQR33OuPmblpA==
Date: Mon, 11 Mar 2024 10:05:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, Steffen Klassert
 <steffen.klassert@secunet.com>
Cc: David Miller  <davem@davemloft.net>, Herbert Xu
 <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/5] xfrm: Pass UDP encapsulation in TX packet offload
Message-ID: <20240311100510.03126bb9@kernel.org>
In-Reply-To: <a650221ae500f0c7cf496c61c96c1b103dcb6f67.camel@redhat.com>
References: <20240306100438.3953516-1-steffen.klassert@secunet.com>
	<20240306100438.3953516-3-steffen.klassert@secunet.com>
	<a650221ae500f0c7cf496c61c96c1b103dcb6f67.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 17:25:03 +0100 Paolo Abeni wrote:
> Hi,
> 
> On Wed, 2024-03-06 at 11:04 +0100, Steffen Klassert wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > In addition to citied commit in Fixes line, allow UDP encapsulation in
> > TX path too.
> > 
> > Fixes: 89edf40220be ("xfrm: Support UDP encapsulation in packet offload mode")
> > CC: Steffen Klassert <steffen.klassert@secunet.com>
> > Reported-by: Mike Yu <yumike@google.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>  
> 
> This is causing self-test failures:
> 
> https://netdev.bots.linux.dev/flakes.html?tn-needle=pmtu-sh
> 
> reverting this change locally resolves the issue.
> 
> @Leon, @Steffen: could you please have a look?

The failure in rtnetlink.sh seems to also be xfrm related:

# FAIL: ipsec_offload can't create SA

https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/502821/10-rtnetlink-sh/stdout

