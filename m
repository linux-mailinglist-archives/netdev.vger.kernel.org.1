Return-Path: <netdev+bounces-243678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADADCA5BA7
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 01:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 334703009804
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 00:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFF74A02;
	Fri,  5 Dec 2025 00:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8v1jVPs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4840A2581
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 00:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764893323; cv=none; b=gNInDwjb8OO82NPCffbyJcrFGt4z64hzYhW+/OxXWrbIlC0GYBH+BSLXxnIdb5N89OWETiYjhzmsHHBQbWIFh0kC21zUJe+pVYEPQBfSqzjE4YMMSTxwMGHE661F77yR4cIoFnjEgvZsz518HAwQXxMv6rWGepXhWOaPiffp+do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764893323; c=relaxed/simple;
	bh=BpSgXE4GSXZoVEoigCnteIlf6z3FI2L/RreVBAnNgws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZHy57/Ofh0D6eqXZjELwHtbg23LcHAGFNCWgKOgJAnFpizZpWMqpTyRrRfI8bVf+Y89WTbbuydzZFPNgNP2pDlOpSB8zhta1ME1UVe1oYXIrirgOysKOxGl+d6Q5us7HoPoqEAH2TsMVBgrDLtH40+mKakKMW2IZxo65rYpfPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8v1jVPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EA9C4CEFB;
	Fri,  5 Dec 2025 00:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764893322;
	bh=BpSgXE4GSXZoVEoigCnteIlf6z3FI2L/RreVBAnNgws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B8v1jVPsjEgKCHs8g+Wbv0mKkVERgN1yF1SUIbp/5I+mZl8CHDX8NHnoElD0HUtex
	 LqQvIJKjymmgnckycfBlxJZ2l+4JKRD8aLF3uWUKUVx9M62eIpd1LUpgoyOpIjb789
	 SZNSag30PYtQ6ZtCRciAuCcq2IU2Y6c360rQjf3XJvc1rXPTGYKoBmAOvXjVQziiGL
	 UXIdz7S2GEG18vTO1LihEpgE5qjip8fiTsMr00GlpGxQFsQEjqzlq/hPvKIuywo5Rl
	 S8cphtQC8GfnGZ/cnaEMuowBp4veq/rEn8BEwN8asvcwnuCyZlnYv79t4KOjlXtIQK
	 FaP0FrCJeQJ0g==
Date: Thu, 4 Dec 2025 16:08:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tom Herbert <tom@herbertland.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] ipv6: Disable IPv6 Destination Options RX
 processing by default
Message-ID: <20251204160841.70fafdba@kernel.org>
In-Reply-To: <20251201185817.1003392-1-tom@herbertland.com>
References: <20251201185817.1003392-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Dec 2025 10:55:29 -0800 Tom Herbert wrote:
> Tom Herbert (5):
>   ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
>   ipv6: Disable IPv6 Destination Options RX processing by default
>   ipv6: Set Hop-by-Hop options limit to 1
>   ipv6: Document default of zero for max_dst_opts_number
>   ipv6: Document default of one for max_hbh_opts_number

Hi Tom, the patches got marked as Changes Requested by someone,
not sure who. FWIW they are all missing our S-o-B.
net-next is now technically closed but I suppose you may want 
to argue these are okay for net (if at all).

