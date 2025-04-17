Return-Path: <netdev+bounces-183551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D09D2A91004
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 02:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1DC189474F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964104A1D;
	Thu, 17 Apr 2025 00:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXEavcoD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CD9BA34
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 00:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744848793; cv=none; b=lwYlTYm/1172pFXaQdfRgpMx4HoQCFdTvTbHKGQKsDM7mVGBJrpJ/gQEs/dvCGdUMogaW2SWjMRZ6msfVclMw80MCNNOaKPFMF3OMDPXFD0EeziOZmD/KcmKCQRLFTYMkVUANuspPscCRTIUvLV+zO0gAv80Lj6eUi0XYNpnOWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744848793; c=relaxed/simple;
	bh=6SjWXyZeZ7k56pWGMKnGwNYjc5GwbN6XrG18Hplr6Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nD9h0drwCn9vMxrOUCO0q9seaSrraKb7ByNohNKq6Ll2lqzfv/W4eMw8ndzju+SbCW4EyiSbnwI3OUxXkfcTkWjT6qPAwEVI8dQvjkWbXQfMyvUiHlNMME167Mgv/QGawbKy6DV69VW2qstpCgKco4yJ8kVMSJV9cdf0ltZP9+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXEavcoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD50C4CEE2;
	Thu, 17 Apr 2025 00:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744848792;
	bh=6SjWXyZeZ7k56pWGMKnGwNYjc5GwbN6XrG18Hplr6Bs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QXEavcoDyiRCE8Oe3BYIEQEl1xn2S9aSNUoBbbG8U05ZfAClSvQL6VG4onUpafULf
	 haqlEocegnyxKjIBG8UPoeoj5uA7sh0zC59OVou3dtKInnna1YIElRgANpJkhGoG3k
	 1aTG6v5lCaRRb8uQHppNys0+/NE7YTfUckmOJe3+Y8LQgiZIYEcan1W0od3/3xJQrB
	 3k6NAEQE1HhWhh00zFU+5DKAp/tUWf722blWRQVamKooWOgXpRyWf/TNQ3rqTNvl1d
	 sqTZNdN0E4gA2Yu/yyhFUBA02zunWTlr7RTP2bSdARNaEzjN9q2BpGpYR+1qwunn63
	 sPm2FM38NMN1A==
Date: Wed, 16 Apr 2025 17:13:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "Damato, Joe"
 <jdamato@fastly.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 Igor Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>,
 Zdenek Pesek <zdenek.pesek@gooddata.com>, "Dumazet, Eric"
 <edumazet@google.com>, Martin Karsten <mkarsten@uwaterloo.ca>, "Zaki,
 Ahmed" <ahmed.zaki@intel.com>, "Czapnik, Lukasz"
 <lukasz.czapnik@intel.com>, "Michal Swiatkowski"
 <michal.swiatkowski@linux.intel.com>
Subject: Re: [Intel-wired-lan] Increased memory usage on NUMA nodes with ICE
 driver after upgrade to 6.13.y (regression in commit 492a044508ad)
Message-ID: <20250416171311.30b76ec1@kernel.org>
In-Reply-To: <CO1PR11MB5089365F31BCD97E59CCFA83D6BD2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com>
	<4a061a51-8a6c-42b8-9957-66073b4bc65f@intel.com>
	<20250415175359.3c6117c9@kernel.org>
	<CAK8fFZ6ML1v8VCjN3F-r+SFT8oF0xNpi3hjA77aRNwr=HcWqNA@mail.gmail.com>
	<20250416064852.39fd4b8f@kernel.org>
	<CAK8fFZ4bKHa8L6iF7dZNBRxujdmsoFN05p73Ab6mkPf6FGhmMQ@mail.gmail.com>
	<CO1PR11MB5089365F31BCD97E59CCFA83D6BD2@CO1PR11MB5089.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 22:57:10 +0000 Keller, Jacob E wrote:
> > > And you're reverting just and exactly 492a044508ad13 ?
> > > The memory for persistent config is allocated in alloc_netdev_mqs()
> > > unconditionally. I'm lost as to how this commit could make any
> > > difference :(  
> > 
> > Yes, reverted the 492a044508ad13.  
> 
> Struct napi_config *is* 1056 bytes

You're probably looking at 6.15-rcX kernels. Yes, the affinity mask
can be large depending on the kernel config. But report is for 6.13,
AFAIU. In 6.13 and 6.14 napi_config was tiny.

