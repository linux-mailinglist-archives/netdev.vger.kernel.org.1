Return-Path: <netdev+bounces-187819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A3EAA9C0D
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 20:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD16917D37A
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCAF26F45F;
	Mon,  5 May 2025 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbelu7s7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA026F453
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471412; cv=none; b=Po5s/c5NF2bNqet+QmC2stPdPPNKRN+uGk3nX9SsQ0b944dD833rAhv7RIym3aA1hNZczEE6asqvSx2FSnIs+l1OFvzUitHNFUV/i7vGKLp9L9tFNiDDgYRTjqnX3N2zgX5pyyr/RZE4HGkRyTKXdef1djLsZ/RVWnp6KJw/hZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471412; c=relaxed/simple;
	bh=CdjfHlYHRFSCunXCx79NBqlRvedR7t5yxArgE9saR3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyqN9Hknk9CfZ1hZSkyfA5wVDXVrZCyYJqfiRW7RoDdoJyeq9MfqTvPuHuTKoi4fbvV4+JXGfI8LSEVT2+/tv0iyA4iRCvJ3cze2uXn8isfZI2g/dSMWCjuw6BexAdjS3UcRIuy8pLPGkYTwYP4MYoMFTLR6TFV8IFaHtkazr5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbelu7s7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E72EC4CEE4;
	Mon,  5 May 2025 18:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746471411;
	bh=CdjfHlYHRFSCunXCx79NBqlRvedR7t5yxArgE9saR3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cbelu7s7ol+4bWTJ/8gBaq5l3NbSN7A4R5eUatkEOCR/DRHEpW0CZNiamx9+OyAsH
	 VuGFu2Rk+kGl+n60bHoMTm/TBGpKBtHajtaZKA+PkyhQZphawIeCrmDwttw8EOFhzi
	 UO+PyKyMqagDLVXAg4ji0BEubwc/HmmNiH6nYNZ6oPmUvhB2vB3lZId6xeTulmMLei
	 2tlwBD0jrJn3IZ0EcaeqPGDRHAp0/XtwECPZ1WApNn+cnCca9CY0Ed8q0QOYob5HMF
	 db0Bi2bzlXA46UUacbJrwv2fXE3B42eXFAPLiO8LuHEEZBSNKA/6IDRysQLVPUdvQr
	 YI8He7PO2A/DA==
Date: Mon, 5 May 2025 11:56:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Samiullah Khawaja
 <skhawaja@google.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
Message-ID: <20250505115650.300a3422@kernel.org>
In-Reply-To: <aBWHv6TAwLnbPhMd@LQ3V64L9R2>
References: <20250423201413.1564527-1-skhawaja@google.com>
	<20250425174251.59d7a45d@kernel.org>
	<aAxFmKo2cmLUmqAJ@LQ3V64L9R2>
	<680cf086aec78_193a062946c@willemb.c.googlers.com.notmuch>
	<aA_FErzTzz9BfDTc@LQ3V64L9R2>
	<20250428113845.543ca2b8@kernel.org>
	<aA_zH52V-5qYku3M@LQ3V64L9R2>
	<20250428153207.03c01f64@kernel.org>
	<aBFrwyxWzLle6B03@LQ3V64L9R2>
	<20250502191011.68ccfdfe@kernel.org>
	<aBWHv6TAwLnbPhMd@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 May 2025 20:04:31 -0700 Joe Damato wrote:
> > The thing I did add (in the rx-buf-len series) was a hook to the queue
> > count changing code which wipes the configuration for queues which are
> > explicitly disabled.
> > So if you do some random reconfig (eg attach XDP) and driver recreates
> > all NAPIs - the config should stay around. Same if you do ifdown ifup.
> > But if you set NAPI count from 8 to 4 - the NAPIs 4..7 should get wiped.  
> 
> Yea I see. I will go back and re-read that series because I think
> missed that part.
> 
> IIRC, if you:
>   1. set defer-hard-irqs on NAPIs 2 and 3
>   2. resize down to 2 queues
>   3. resize then back up to 4, the setting for NAPIs 2 and 3 should
>      be restored.
> 
> I now wonder if I should change that to be more like what you
> describe for rx-buf-len so we converge?

IMHO yes, but others may disagree.

