Return-Path: <netdev+bounces-100269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCF88D85A1
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB662280A0E
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CA312FF71;
	Mon,  3 Jun 2024 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7fRvYdo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD9712FB0B
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426783; cv=none; b=DmoVnudfqAtNWl11wPvY41dGZf/X/4G1ElD6pZ3YJ4tmXlqwgELeI2oC109hdGOnTFDbZpffLwLCPbztytVQAYCNwad6/G4X6q6Ydmq/jKYrFA2rdXsTV9AKMzDq3U4oX0wTgHTyi0wj9DgTlO9WiGotP4u9la4H7w95DUgnKzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426783; c=relaxed/simple;
	bh=Z1rEm25VKP1lqpvgdHrxX+m+i6SYlukeBsgBNgBx/hA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iS79NOMJyKdRk4wKySaGhPEOidLFyFjvbmdqSqOHfWT8QO21GPsYWk05nKTgfUrFcIvsaNYHLLn1jcOxAjLKnUVrBUsF+gOtz4g8gpnnckhzQ0j7MUdoGx2zXZz8YV8FpTkbXpTR8N5zehrYb43YwY897Ek3anH9P/kW105zYDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7fRvYdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73DFC4AF0A;
	Mon,  3 Jun 2024 14:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717426783;
	bh=Z1rEm25VKP1lqpvgdHrxX+m+i6SYlukeBsgBNgBx/hA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c7fRvYdoy8YnmDs1md1N6FHgNJH/zifJPAPQdnVN1asH+5q0xvvXu1tl1oOuYz3rz
	 6SQQXx1a3yugqrKRnr+xr052dU00rMidirSLgU1Uf5SBqeFbcw9a99KwJcrk9iMb/i
	 el/Onl7U1B8Zex9CWLtBzdWykKGBXz8JLH3at3N0bgv9WNGeuMD5IIPUzn7jNmfqlf
	 lmZAqcgc4n16j77pJtGr9E9E+RwJApTROT/VsA28usQWB3lXyUD5eMdv1FBphC0dxf
	 em6TL5OZZpNEi8WzB9yBvR4rFUkUbUu/fpKGR3JyiCuPqZqO/aDjZh6GicFcP0M4Sl
	 5nEdnAfx18i9A==
Date: Mon, 3 Jun 2024 07:59:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, Stephen Hemminger
 <stephen@networkplumber.org>, davem@davemloft.net, netdev@vger.kernel.org,
 pabeni@redhat.com, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() in
 inet_dump_ifaddr()
Message-ID: <20240603075941.297d1e56@kernel.org>
In-Reply-To: <CANn89iKF3z_c7_2bqAVcqKZfrsFaTtdQcUNvMQo4mZCFk0Nx8g@mail.gmail.com>
References: <20240601212517.644844-1-kuba@kernel.org>
	<20240601161013.10d5e52c@hermes.local>
	<20240601164814.3c34c807@kernel.org>
	<ad393197-fd1a-4cd8-a371-f6529419193b@kernel.org>
	<CANn89i+i-CooK7GHKr=UYDw4Nf7EYQ5GFGB3PFZiaB7a_j3_xA@mail.gmail.com>
	<20240602152102.1a50feed@kernel.org>
	<20240603065425.6b74c2dd@kernel.org>
	<CANn89iKF3z_c7_2bqAVcqKZfrsFaTtdQcUNvMQo4mZCFk0Nx8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 16:22:19 +0200 Eric Dumazet wrote:
> > Hi Eric, how do you feel about this approach? It would also let us
> > extract the "RTNL unlocked dump" handling from af_netlink.c, which
> > would be nice.  
> 
> Sure, I have not thought of af_netlink
> 
> > BTW it will probably need to be paired with fixing the
> > for_each_netdev_dump() foot gun, maybe (untested):
> 
> I confess I am a bit lost : this part relates to your original submission,
> when you set "ctx->ifindex = ULONG_MAX;"  in inet_dump_ifaddr() ?

Yes, xa_for_each_start() leaves ifindex at the last valid entry, so
without this snippet it's not safe to call dump again after we reached
the end.

