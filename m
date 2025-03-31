Return-Path: <netdev+bounces-178388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 473AFA76CFC
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 829F77A373D
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72493213E8E;
	Mon, 31 Mar 2025 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFRN7QPU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7E31BD9E3
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743446164; cv=none; b=Td0bcjPyecNgG6oS1VsZYuon3BOWkqjBbbeCGG0BZNOm7TNrS1dUeQ2FnFNJTqbv8UkMimLVab+NRh7qrNMtd202u0mSTZYGI1k2YatQK6rQz/ncdw7Tau+p9MDyLJAopGQ6uGVNOJWBGEE4zoyBKaVNSQTS2z/Ajmsy4vH8o9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743446164; c=relaxed/simple;
	bh=7Tn+A3lMqNbZML1Tlv2br4N1DZoYmmbLez1xdkROqDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PvKKUol0T9Ndoe2ocNPem5yp3IQGnES81GL5m+CPUr+0IAJOVebZjFwoK7oVLRv281ebQ7UqF0DuSdWmxEv5mCyXJQwC4k35XPbdCi1lyF4t5KLElajcl9jbKizpAaxvbRBp2S0yN3bdJbxf0T+JEUAMvjMKJqRCi1mYvxRDIss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFRN7QPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9868C4CEE3;
	Mon, 31 Mar 2025 18:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743446164;
	bh=7Tn+A3lMqNbZML1Tlv2br4N1DZoYmmbLez1xdkROqDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YFRN7QPU9OvQzMV+RaVj7ARALnNK9n7EvxOgCO1665ppskLi5SdCGDbkTfrY75csf
	 kjvKi75pqqEJDEiVVrI8rtJqghJK1RSsaL3diSd6TAJ1I3Etj7MnyyYoj4mrIO8EeS
	 6B9QXabS+7Rnxwfj4kCbBLZ0dBcZssDGc9tXFHywr5cTF0/RYDGT+C76XEI2o+Lkfc
	 sPjJJVMpyimr/UdTYkU4fYDBRHH7h0n0+7rfEzgapLb0T7TiMjSo3SdA0hR5oZQwmy
	 D/Jek4plePDmxE4cFK4sy1BSOUYpoYc5zpMglnhmmwwerml0Pe3/Bj9f9Mvgoblojr
	 X30ra+s3yvoAQ==
Date: Mon, 31 Mar 2025 11:36:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
 <horms@kernel.org>, <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>, <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v4 net 0/3] udp: Fix two integer overflows when
 sk->sk_rcvbuf is close to INT_MAX.
Message-ID: <20250331113603.6b15bb9a@kernel.org>
In-Reply-To: <20250331182142.1108-1-kuniyu@amazon.com>
References: <20250331065109.45dddd0d@kernel.org>
	<20250331182142.1108-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 11:21:34 -0700 Kuniyuki Iwashima wrote:
> > Plus we also see failures in udpgso.sh  
> 
> I forgot to update `size` when skb_condense() is called.
> 
> Without the change I saw the new test stuck at 1 page after
> udpgso.sh, but with the change both passed.
> 
> Will post v5.

Please do test locally if you can.

