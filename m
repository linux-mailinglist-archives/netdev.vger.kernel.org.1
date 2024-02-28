Return-Path: <netdev+bounces-75637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D046486ABF2
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 11:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7225A1F29E63
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 10:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E9B3838F;
	Wed, 28 Feb 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n96fHgZo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A426A38390
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115142; cv=none; b=Ch31Flntv8muvfkH2fzMueppbggDCOm8ECGcLQXQWVj9OYInvjJySUxOgOyQcyDnVn3U0rzv2/VmIzGabe9H2xegIU7Zy6uWf08VAl1ilqh3Hd+kwL0w1M73+BBesvy5Yj+OG7KLGq8BlJyvMFS9ZmXj9onu/SKfg4Cc1fEI1fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115142; c=relaxed/simple;
	bh=QFYQUoP97qt1SySTRyNAKrKSlup8Ut/g9RM8S9am1mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9p/rBP1ywHmHFj4JoMLWC6Vg4S1/etFVbXjbYfzMiivNtCLoljMHwRKNEiZracasklnkxpu5tsSyQRJDOiP3GAqp4y25GPNmkwty5vbIAoIlSfU7v5g62qxk1eUqLhCbyRZ64NzBtap9dzj0dx/c08GoVJ3IetzDZi0EMS+vGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n96fHgZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A43C43394;
	Wed, 28 Feb 2024 10:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709115142;
	bh=QFYQUoP97qt1SySTRyNAKrKSlup8Ut/g9RM8S9am1mM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n96fHgZoOdwmwYupMkJDHIcXKFSXtzfuPciA6Q42WzIjAQyyy5pHqrp4mmDiktMvD
	 XmBa/boDMeU+a2wslPm1yJwkAavc1N3w7ZIxdZg4gKwzBJVQJbovMVGpcGxmSgCp/3
	 pyzEoAr8fum7GOtxgFr/sWyqJG/z49bfpW0rkKsqWv9apEaND2hzEjpQOt4zuEodZM
	 MpGNikI0U3z4djHIey7UyYG/LGLBdJSKJPRDfyUAhwGnlQq0pGrxqvSLT/ghrmrUbH
	 frHRNk9eoVqaCj7WPme6IOFcYS/699pd7GMHJyuHoEo9ylWRavq+/gaib+VQ3BeQyo
	 N8O+BlpjtjD1g==
Date: Wed, 28 Feb 2024 10:12:18 +0000
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, lukasz.czapnik@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Nebojsa Stevanovic <nebojsa.stevanovic@gcore.com>,
	Christian Rohmann <christian.rohmann@inovex.de>
Subject: Re: [PATCH iwl-net] ice: fix stats being updated by way too large
 values
Message-ID: <20240228101218.GB292522@kernel.org>
References: <20240227143124.21015-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227143124.21015-1-przemyslaw.kitszel@intel.com>

On Tue, Feb 27, 2024 at 03:31:06PM +0100, Przemek Kitszel wrote:
> Simplify stats accumulation logic to fix the case where we don't take
> previous stat value into account, we should always respect it.
> 
> Main netdev stats of our PF (Tx/Rx packets/bytes) were reported orders of
> magnitude too big during OpenStack reconfiguration events, possibly other
> reconfiguration cases too.
> 
> The regression was reported to be between 6.1 and 6.2, so I was almost
> certain that on of the two "preserve stats over reset" commits were the
> culprit. While reading the code, it was found that in some cases we will
> increase the stats by arbitrarily large number (thanks to ignoring "-prev"
> part of condition, after zeroing it).
> 
> Note that this fixes also the case where we were around limits of u64, but
> that was not the regression reported.
> 
> Full disclosure: I remember suggesting this particular piece of code to
> Ben a few years ago, so blame on me.
> 
> Fixes: 2fd5e433cd26 ("ice: Accumulate HW and Netdev statistics over reset")
> Reported-by: Nebojsa Stevanovic <nebojsa.stevanovic@gcore.com>
> Link: https://lore.kernel.org/intel-wired-lan/VI1PR02MB439744DEDAA7B59B9A2833FE912EA@VI1PR02MB4397.eurprd02.prod.outlook.com
> Reported-by: Christian Rohmann <christian.rohmann@inovex.de>
> Link: https://lore.kernel.org/intel-wired-lan/f38a6ca4-af05-48b1-a3e6-17ef2054e525@inovex.de
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


