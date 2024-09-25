Return-Path: <netdev+bounces-129669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A44E398555A
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 10:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E21D1F21D0F
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 08:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A057157472;
	Wed, 25 Sep 2024 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiVLF7Cr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560501547F5
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 08:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727252372; cv=none; b=lVrMl1Cdq/nU6aGts0eCEC6a8bA/lP5a8S1YeufdVrKtI32S0z/Vona/NwRSE43NDYBhrcMkBg1an/LNqXskO1rBNxeav6gLknXR1KCizX2CpKu2Z6f9ctwKjMsDFNd1gMK2NAsEqIx8DBW7ve0W+VzKSjKEMpFd4CE5VHcmQnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727252372; c=relaxed/simple;
	bh=NKtpXnORoWIqSsbon3c4R1RhQX2f/fYpW7Kuu7E/HU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/lqlGANJNo/1mk5BJOgwQJmSDe8bcSKgT0RZKah6Xth4oMZw0K9pjDxBy0CW0iQq39QiyeIynwXcBWGrfvp4futXNX5Rm2+vH2dayEhTvXyqvNRfdxvgLAvTKiRI0+rt5BdAJwhlolrfHLnlnUnai34MQ0Tmi7bvdEQs7phjgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiVLF7Cr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DA3C4CEC3;
	Wed, 25 Sep 2024 08:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727252370;
	bh=NKtpXnORoWIqSsbon3c4R1RhQX2f/fYpW7Kuu7E/HU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GiVLF7CrzzOeWI2Z682LDPW6Q6AqtKOKNgL1lnWG8rTb29CEuHphZNlc4Mcg+eDnL
	 EliCkVwM7mz0XvEDIP5eSX9QSQOfdVaq7+zH/AGS9PADRXp920emimMM9y5DU6pl2b
	 J9FZM7Q3v8qUSYpqBxBtRPlxn3sKwTiwU7BCmwj2OtEh4rbtK/+Q31wL2qcfr/0OM3
	 JhO6UnbOqB1Hh1Rapzq1d/4pVzNJp0P2kUKSdH6iTVDLGWIgBTlMocfRb7YJPLUsl7
	 h6Xh2sFIAHL+a51asLEc1hQxJIy8/dc9JGygW+79DI4n1PxOYVds+MLrPOWyh8X8H9
	 et7+p6en5A5kg==
Date: Wed, 25 Sep 2024 11:19:24 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Feng Wang <wangfe@google.com>, netdev@vger.kernel.org,
	antony.antony@secunet.com
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <20240925081924.GB967758@unreal>
References: <20240822200252.472298-1-wangfe@google.com>
 <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240831173934.GC4000@unreal>
 <ZtVs2KwxY8VkvoEr@gauss3.secunet.de>
 <20240902094452.GE4026@unreal>
 <Zt67MfyiRQrYTLHC@gauss3.secunet.de>
 <20240911104040.GG4026@unreal>
 <ZvKVuBTkh2dts8Qy@gauss3.secunet.de>
 <CADsK2K9aHkouKK4btdEMmPGkwOEZTNmd7OPHvYQErd+3NViDnQ@mail.gmail.com>
 <ZvMAof2+5JET6JRA@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvMAof2+5JET6JRA@gauss3.secunet.de>

On Tue, Sep 24, 2024 at 08:10:41PM +0200, Steffen Klassert wrote:
> Please don't top post!
> 
> On Tue, Sep 24, 2024 at 10:57:12AM -0700, Feng Wang wrote:
> > Hi Steffen,
> > 
> > The easiest thing would be to upstream your driver, that is the
> > prefered way and would just end this discussion.
> > 
> > I will try to upstream the xfrm interface id handling code to
> > netdevsim, thus it will have an in-driver implementation.
> 
> Netdevsim is just the second best option and still might
> lead to discussion.

netdevsim should come with relevant selftests, otherwise this
new feature won't be tested properly. We can't rely on someone
out-of-tree to test it.

> 
> Upstream the google driver that actually uses it, this _is_
> the prefered way.

+1

> 

