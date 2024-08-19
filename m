Return-Path: <netdev+bounces-119774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B00956EB5
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 17:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0200F280F1F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4FF3BBF2;
	Mon, 19 Aug 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ql3peRzY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824C31BC59;
	Mon, 19 Aug 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081269; cv=none; b=C/mzBkWC3DWKsQbLBteFjjxjrpBhI3sDMBGdFisHlD+Sttl0HzoLlCFXeTaBkF9PCCegXSmwmfjuiPXVr22QnsHjhwPA5t56S8d/Y0LSA1d118roaWdnZtG19XKgmFAJt8MO9cv1mOS/aSmGjFLVSIveiq5KDEnhSJleIwgtxOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081269; c=relaxed/simple;
	bh=qeQgtKomB5cd6jQ08sQEldXRUMgKAV4Meg42eZK5Yqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFt4TukjpUirI54Pix3GmYuAQhwB4WCAJcXhjve2VxQcqlttBn4nTBpfurEA4lCapUNXZs64WTcthzzljPy3qIbbFdigX0JceC2HOnrw5x6AYnHrAfXnF92IdOZcy7GWScZ5R5UEgiEFdhwgKWBIaGqFakbPCIdx28rvN6BvPHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ql3peRzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D81C32782;
	Mon, 19 Aug 2024 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724081269;
	bh=qeQgtKomB5cd6jQ08sQEldXRUMgKAV4Meg42eZK5Yqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ql3peRzYCiZzWaW5HHgk69sLXnu0TLikVLegHU83NRAojUt/h8OxLaBZ6GXtBYi+9
	 clJAHYTC5a0kbph+aYFm5uMn8L9L7uVksW21taoM1gFYvuaEQoPC6QzrGB2xoma8X6
	 tS4IdKThz4xWxMH/gna8U2fvUwfcOVPNBF6WQjg0+LVYnQflvQ8RDE+SNS1brrZHFP
	 hsJLcQ3HYuhvz0bOU+CrEmTHWUctCeFjQUtDx45O4PVYjDefhszwtLX9B0lpGvfbH3
	 VEvimfjMvaPYOJBQQ0/UhR38Z5rAcndQzOsAhxxX0bwv9FL9ihkGd3j7SAMko0vIfT
	 a49ZIdDy+h+xA==
Date: Mon, 19 Aug 2024 16:27:44 +0100
From: Simon Horman <horms@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jerinj@marvell.com,
	lcherian@marvell.com, ndabilpuram@marvell.com
Subject: Re: [net PATCH v2] octeontx2-af: Fix CPT AF register offset
 calculation
Message-ID: <20240819152744.GA543198@kernel.org>
References: <20240819123237.490603-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819123237.490603-1-bbhushan2@marvell.com>

On Mon, Aug 19, 2024 at 06:02:37PM +0530, Bharat Bhushan wrote:
> Some CPT AF registers are per LF and others are global.
> Translation of PF/VF local LF slot number to actual LF slot
> number is required only for accessing perf LF registers.
> CPT AF global registers access do not require any LF
> slot number.
> 
> Also there is no reason CPT PF/VF to know actual lf's register
> offset.
> 
> Fixes: bc35e28af789 ("octeontx2-af: replace cpt slot with lf id on reg write")
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---

Hi Bharat,

It would be very nice to have links (to lore) to earlier version and
descriptions of what has changed between versions here.

Using b4 to manage patch submissions will help with this.

