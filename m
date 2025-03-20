Return-Path: <netdev+bounces-176569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06682A6AD2F
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 19:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD193B866C
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 18:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319BE226CF6;
	Thu, 20 Mar 2025 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Chz2tfsS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3331C69D
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742495943; cv=none; b=YIoKL3LfeaspDRK35oITsNbeKIgCoMyi8INH0mFjv6pg12clQsndWzyHHwlp5xQZ2Z6/gk/nPuZy+ucgDxO4tntRBkB1APoPqbPBtyLW+bvS3to+fZm2QtTXM4/pidQ4d//8kE/T1rAzqbHr+txb9wkpUMX+JqziGVw+Zuc/dCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742495943; c=relaxed/simple;
	bh=1GQKQJ6HaXh6ZFNkDc6sDEMSJe/2AW2XG3mN4M0bVtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f63adUSgxNFI5+oAHsRbi7kp3v+fb7ayPVVhU7BTgjH5y7YdJjFw7EdTojk/1pr/ly7izlw/rwRJ32thY4acjvgIri6vf/nMg0Yw+OCfS+FrUBDBbRwQUAIB2uBLE25vYUHuwXMLrpteIXPE2dzEfpNKrfpkJZ4ASuRN7m61Odg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Chz2tfsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E0DC4CEDD;
	Thu, 20 Mar 2025 18:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742495942;
	bh=1GQKQJ6HaXh6ZFNkDc6sDEMSJe/2AW2XG3mN4M0bVtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Chz2tfsS+G1OymuVwMApo6Oq6Pl4Z1MEM1H0Ch6PLYBTmdi44bhY/gcfxn18VMm1m
	 fdf9IbyZMiMAvxJBvF/UGEhvT71f0xpTwRyEK7scGX3Spy2eMhgWw2dBHeHLA9Ym/C
	 j1wo3+duqdWfdojJfuEuUNA87qs17LbGLSURwwuxAJzj3DJCB1YT79Jz7Pqmkmmn8Y
	 rrniXX9visEGt39/RV/aKxisI0FRNyjxXKbRVnrPWOESoFAZrsXzZAKBCoUZT1PWGh
	 J/eBFT9sm33loJivXfm5uAjn9AoNG2J0fw9oiY4ZBJn/VWZ7/+z6bSJTfIbCOe5C/p
	 1bLeg1i5wkIdA==
Date: Thu, 20 Mar 2025 18:38:58 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 2/2] tcp/dccp: remove icsk->icsk_ack.timeout
Message-ID: <20250320183858.GJ892515@horms.kernel.org>
References: <20250318154359.778438-1-edumazet@google.com>
 <20250318154359.778438-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318154359.778438-3-edumazet@google.com>

On Tue, Mar 18, 2025 at 03:43:59PM +0000, Eric Dumazet wrote:
> icsk->icsk_ack.timeout can be replaced by icsk->csk_delack_timer.expires
> 
> This saves 8 bytes in TCP/DCCP sockets and helps for better cache locality.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> v2: rebase after "tcp: cache RTAX_QUICKACK metric in a hot cache line"

Hi Eric,

I hate to be a bore, but patch 2/2 does seem to apply to net-next.

