Return-Path: <netdev+bounces-70472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC74B84F243
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF9F1C21A41
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF36066B59;
	Fri,  9 Feb 2024 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nh+oQQGe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B79A664B1
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470732; cv=none; b=sUIczBYxVtWfnjOi3C4JrLx7FISwoDFJgF/nsBP67iI6cAtzD99K9E0P7umtnu7kBac6qNiXE6njw+zxHHWy+UJUcifm8ZCdXkiGflKZdf0CVubtnH5Ry5RaqA+SpzsjHWO4lTwhH3HfEusnzDviTWuYKXB4kmRj4VNm+nmY2MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470732; c=relaxed/simple;
	bh=ijlXZZpstuOR/7zgVyuoyGVvBGbY+/KYQaUCy078DuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuRR6Q9mid8Yadrja3rOIUFWwhqN2TgSHhB/JH/G434KcRaHKgIfSm1ORjpjzqxyxFNvAS5VWMi2Zt/i8erEgQARTa62QAyUe/ALhc1Pxn5fYRXaPek4Vv7sr0Yh7eCpFiUSPq4bh4ELU1kOhljlmtiZladkFshbNoT1+DJraRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nh+oQQGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B091C433C7;
	Fri,  9 Feb 2024 09:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707470732;
	bh=ijlXZZpstuOR/7zgVyuoyGVvBGbY+/KYQaUCy078DuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nh+oQQGeJfKRJcXd9Ron/FmSRdieRxlb+ljHGKgYi6Ix+GX1MT4a/1tjt35ZzTXSt
	 lPdAUpxFDrqOHRUkuQg+lm6TJl+WD4Z5RnnT1keXZqVBpsHnk/NVk8r47u/7PnZX6d
	 pKIQ/7rGul6jm3z8qnzP5obzOVwoU9IsT/JUhKO5+KI8FScnH4fEs/1JoOHzrt26g5
	 31vBUnOjIuZf1vaCM8hbYwdtjq7sC757Bih2SguB/TBjCqiVAO6yi8f9SzIAmdHe4p
	 xZJFIEpVJ1ccX6GGUbKFHNH9WMJtOyP7hJj1l2akTLTUNsmyt6qF5QLoz7QFdeKArB
	 bG0O0rA7PSvVg==
Date: Fri, 9 Feb 2024 09:25:28 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, sd@queasysnail.net, vadim.fedorenko@linux.dev,
	borisp@nvidia.com, john.fastabend@gmail.com
Subject: Re: [PATCH net 5/7] net: tls: fix use-after-free with partial reads
 and async decrypt
Message-ID: <20240209092528.GR1435458@kernel.org>
References: <20240207011824.2609030-1-kuba@kernel.org>
 <20240207011824.2609030-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207011824.2609030-6-kuba@kernel.org>

On Tue, Feb 06, 2024 at 05:18:22PM -0800, Jakub Kicinski wrote:
> From: Sabrina Dubroca <sd@queasysnail.net>
> 
> tls_decrypt_sg doesn't take a reference on the pages from clear_skb,
> so the put_page() in tls_decrypt_done releases them, and we trigger
> a use-after-free in process_rx_list when we try to read from the
> partially-read skb.
> 
> Fixes: fd31f3996af2 ("tls: rx: decrypt into a fresh skb")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> This is pretty much Sabrina's patch just addressing my own
> feedback, so I'm keeping her as the author.

Reviewed-by: Simon Horman <horms@kernel.org>


