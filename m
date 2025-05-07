Return-Path: <netdev+bounces-188779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341E9AAEC97
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 22:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316753B9CC9
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 20:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3373B72639;
	Wed,  7 May 2025 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMKTO2AG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B49B2F43;
	Wed,  7 May 2025 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746648077; cv=none; b=Zk4274K4GXgO11mMBcYiOOXnlEXF6ypBNo4e9MgIpEBadQOfhHtWVsYfRFoyUoaBTwssWfPw1fduW9wb6bQgR3oqL5dOTyktsmqMKDjlc/nyuB/zEdiXf/5xgD2LAywy9VKwqNKvy3ZCL7N3oH6uJaJfEJ7F0uXDqf5PCMkCCR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746648077; c=relaxed/simple;
	bh=DfHI/ZnSSfwOEFBgC0Q2ORu/XpEumIZs17KMnZ4wfYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5DMcJmv6sSp1PBnr4aCh83S4mXBFzbUTpPmF7mT2jyGoAX63Ddj+S/L7jtXVaOiKfU0q3QlmuCxKj/FBAMgUtFEuD4ssdgSUe0Crn1FOiEJU++rkHUbrZttBJ6yc+u6bqcg1cknvdphLtnDqX8zRjlz9l0x7WByK1kcF4Ecm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMKTO2AG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFC8C4CEE2;
	Wed,  7 May 2025 20:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746648076;
	bh=DfHI/ZnSSfwOEFBgC0Q2ORu/XpEumIZs17KMnZ4wfYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eMKTO2AGZHIyVpqOm/b+ii7bIuDASYiYkxOS307zgNov5/r2xLovO1FEYUaOdEULq
	 LrfTOaysbGvZDXhslwCRv4KJS/62We3F+1HQezK4Fn3pOjzyXIRyA/sESaJPpQlOiS
	 b1fXrPFxcohJlDFcbs+3eSMttn4Ed0ZHW/FoS2F/Zh4azbusPeOhoVoG7xkNRHseUI
	 5CUbKIuZaUBRBCJ+IPYwOr7iupzW0DYHoRjJpaMfbedAA/raMHF67pqrQq7SR2p1DO
	 huwAUMu8e0784osyr+74CFpFKrk1Y9zQ67+tH/noKnbUiWjj283YsccSSRbhVne5/c
	 ZcddghvRy5wxg==
Date: Wed, 7 May 2025 21:01:12 +0100
From: Simon Horman <horms@kernel.org>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
	richardcochran@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v1] ptp: ocp: Limit SMA/signal/freq counts in show/store
 functions
Message-ID: <20250507200112.GL3339421@horms.kernel.org>
References: <20250506080647.116702-1-maimon.sagi@gmail.com>
 <20250507194630.GJ3339421@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507194630.GJ3339421@horms.kernel.org>

On Wed, May 07, 2025 at 08:46:30PM +0100, Simon Horman wrote:
> On Tue, May 06, 2025 at 11:06:47AM +0300, Sagi Maimon wrote:
> > The sysfs show/store operations could access uninitialized elements in
> > the freq_in[], signal_out[], and sma[] arrays, leading to NULL pointer
> > dereferences. This patch introduces u8 fields (nr_freq_in, nr_signal_out,
> > nr_sma) to track the actual number of initialized elements, capping the
> > maximum at 4 for each array. The affected show/store functions are updated to
> > respect these limits, preventing out-of-bounds access and ensuring safe
> > array handling.
> > 
> > Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> 
> Hi Sagi,
> 
> With this patch applied GCC 14.2.0 reports:

Sorry, I forgot to mention that this is an allmodconfig W=1 build
on x86_64.

...

