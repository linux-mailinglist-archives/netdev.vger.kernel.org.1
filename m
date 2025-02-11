Return-Path: <netdev+bounces-165252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC1AA3145D
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12874161B22
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58728253B43;
	Tue, 11 Feb 2025 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyCz/i1Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391D1E47A8
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739299803; cv=none; b=kNJ85sR7+2gDRhSYhNOfNFlXZq2r54+imIbyhyhxzxM1rLE/k9Eo1Cgo7lNukk40rwayYruLSxvNa8syvWzhmCuOQH93P+YuFwHagqDVL6J7rsRQqyTOAXzKsUvf2TcnCHEbGRVLsMR06koiZJ0/VfNdH16xTQlFBBIMZeA7d3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739299803; c=relaxed/simple;
	bh=V1or1My7No6aRJku3pIf+1as11Stw3Sq6wgX8WAdDro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E70qmJNLuidZ8k2unv8498nOZIb+LGG7tsyURcxR7wxFD3mMlG2RBKCiLFNVBjca3ZuBYR1eF0ybaB0M0Cji2fKKxdjBAqELL1aUAtemP6UEOIn/x0aW8OKwytVf1U1ePmjOKqdtqHmo1JnWGIUN57wvNwBEoMYlQoeOkxLWeHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyCz/i1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F28C4CEDD;
	Tue, 11 Feb 2025 18:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739299802;
	bh=V1or1My7No6aRJku3pIf+1as11Stw3Sq6wgX8WAdDro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hyCz/i1QRpyeYkwMDNvN7Hy2h7wOe1kVQVc8eCdxIHvrObJA0ym5cqkALjLe++AgO
	 EPn2OPf0hWuK29IjBx85IlUHohg+yIlmc1YZEEiSHT/Rsyk+Yl1u6bvipqcRFpAF/4
	 6Mw6TE3H9kwPh0KKiVuoj6S7CnJYg9e5Oux/HaH1j4+YS6/4hlNf8obOOVU0biwHaG
	 MPyIObO4MIC8DWYlr9UhWfCSjlQBSV7pPOdFL0veXw2Cyi6Ltdq9JERa7cHOi0wq5l
	 57KXWCMQ9cdeDYjRrUq0uVpwEYYFbJZGkF1ojoZztASiVTSxnKb085lwAeSSXYuLKk
	 FnXOrjF66w9qg==
Date: Tue, 11 Feb 2025 10:50:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 tariqt@nvidia.com, hawk@kernel.org
Subject: Re: [PATCH net-next 0/4] eth: mlx4: use the page pool for Rx
 buffers
Message-ID: <20250211105001.73b220fb@kernel.org>
In-Reply-To: <1c187a13-977d-4dae-a9eb-18ef602f5682@gmail.com>
References: <20250205031213.358973-1-kuba@kernel.org>
	<c130df76-9b18-40a9-9b0c-7ad21fd6625b@gmail.com>
	<20250206075846.1b87b347@kernel.org>
	<1c187a13-977d-4dae-a9eb-18ef602f5682@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 20:05:01 +0200 Tariq Toukan wrote:
> On 06/02/2025 17:58, Jakub Kicinski wrote:
> > On Thu, 6 Feb 2025 14:57:59 +0200 Tariq Toukan wrote:  
> >> Thanks for your patches.
> >>
> >> As this series touches critical data-path area, and you had no real
> >> option of testing it, we are taking it through a regression cycle, in
> >> parallel to the code review.
> >>
> >> We should have results early next week. We'll update.  
> > 
> > Sounds good, could you repost once ready?
> > I'll mark it as awaiting upstream in patchwork for now.
> > And feel free to drop the line pointed out by Ido, no real
> > preference either way there.  
> 
> Hi,
> 
> Patches passed functional tests.
> 
> Overall, the patches look good.

Thanks!

> Only a few comments:
> 1. Nit by Ido.
> 2. pool size.
> 3. xdp xmit support description.
> 
> How do you want to proceed?
> Do you want to fix and re-spin?

Sure thing, will do.

