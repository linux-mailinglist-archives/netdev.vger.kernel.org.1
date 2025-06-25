Return-Path: <netdev+bounces-201045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1424CAE7E8F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E594E16F84C
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B3C29DB96;
	Wed, 25 Jun 2025 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBxJT3OU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBA9285C80;
	Wed, 25 Jun 2025 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846017; cv=none; b=CIEYbuNocF/QucKn1QiF72igMe6CXnKeOtPkIJ0oDDSeF+EnERwbayqJZqKimtw7SR/9hq4AzHI7KX7DFfR3dRGCsK1sEfvohIbFAJNZ5GVmzl13f92wbKOwS0ApGFSd6IayPJa00d+C55QhEW64WKRq/gLElSxtJgikB6SuhLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846017; c=relaxed/simple;
	bh=lkwFVRLEO4WEAf2vPeYKWFdLiVu7GkN0FIiFJ22pK9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbu5aPO/NCS5ekltUGGmGIAl4tIXUzE8FXPIso9ppAGkZaNbz2+hwx6nZyQa9Gef4wEiPUurME5nhUiEh+KnRgX6JULaTwEyZOom0nI4u8DgsAE1w6DoziqYTZwo48IL5WXLhqJTasGnr8S/vvoUb6oZdipsXQ6r5GcX5nPqfjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBxJT3OU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424FDC4CEEA;
	Wed, 25 Jun 2025 10:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750846016;
	bh=lkwFVRLEO4WEAf2vPeYKWFdLiVu7GkN0FIiFJ22pK9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uBxJT3OUU2fFGeHgrHXXuwFo9x+onaJYUVDklBxclGjjz9N3KdFYtcg/8MwjdHlvT
	 zDUZop/kEt3hNwVfKaaasOqQRHzNf7KlnUXKnD/dZW20B+tbdXxhIWE523cO4mDVLM
	 86w4cAqm5FEoRFx6oVY6c/s5oq7ZSBYMVOhUCqQK5l3PfML1XdXijO1L+MNQExJ7/P
	 jPoXasBvynEiBu5Pk6BQisbOKiNEUdp9VmkAx6StvkyXLfMQCcTM+a2nIvGyoOURpM
	 CNNKSS0dMdF2Y1p1sXAbXvBr9qU5BmQOdy9ka9WAOwvUGT/OiczlDS1TaFLueMdwBH
	 7Y3u7q6fx0nOw==
Date: Wed, 25 Jun 2025 11:06:52 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/7] af_unix: Drop
 unix_stream_read_state::splice_flags
Message-ID: <20250625100652.GR1562@horms.kernel.org>
References: <20250624-splice-drop-unused-v1-0-cf641a676d04@rbox.co>
 <20250624-splice-drop-unused-v1-4-cf641a676d04@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-splice-drop-unused-v1-4-cf641a676d04@rbox.co>

On Tue, Jun 24, 2025 at 11:53:51AM +0200, Michal Luczaj wrote:
> Since skb_splice_bits() does not accept the @flags argument anymore,
> struct's field became unused. Remove it.
> 
> No functional change indented.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Simon Horman <horms@kernel.org>


