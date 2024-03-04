Return-Path: <netdev+bounces-77214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A36870B2F
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E136287CAB
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 20:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EC57AE5F;
	Mon,  4 Mar 2024 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps+mCZyc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C9C7995F;
	Mon,  4 Mar 2024 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709582869; cv=none; b=ftGs/nZ0gJ5CYhmkn0Nl8YaU4WSJYOcjjl/D6IhL7HngZMacAPWgEGNvfe2sMzrF+YEIO649a2sqt8z9z/gHhAH1SNAUOvI3o3qHTy8oTr1fVJ2EFQy2eCCBPKcJgo727NdwAdN76JOd9axUDiO3djvE1wdjt3+du3gBPW8Fd3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709582869; c=relaxed/simple;
	bh=IxhkFb0JGseP/F6oidrp0nqH9NvZIV1ZHiC2lHFKZU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+ifn3li2VYRO6Lqdbq4ikE8/WHQMk4a+tR+LeS3UMxCtTXJ56wH5AoVagJvrMApxRmGWW+TYyCLCUvQuhx2p6T1fb/j6HLykdx7e3xgAT/26mNbH8dAsy0Lds6znhcBo52hFLGKGFsObJxL0OoV5dQW0q9KwU/kgTzEPPIgh/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps+mCZyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC3CC433F1;
	Mon,  4 Mar 2024 20:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709582869;
	bh=IxhkFb0JGseP/F6oidrp0nqH9NvZIV1ZHiC2lHFKZU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ps+mCZycuYOmCI3C6RRj9rCLV/7gBs3eR1cRDiQA1BJj7gX2RCz13LiFhEuqsqj03
	 Dw9op7fWLqMiK0YurvCC24nldP2xDYGoWeoaoqJO9KUDyrNKdc8eH2CnNvDAONdkak
	 AHIHRd9fMuE+apQJbzG2HG6FQ5/9anpKReXNhUsgHHqcqnoyO604oKLbtg6OClMck5
	 HcDY2rDrJkc6rmX8TSIgZ/ZliId4nC7qXBAA5k0kult4VzJuPbSIqDzMLmPU9dCI12
	 nE6W0TlyLR3W4M+02cpgaOrKKQ9IEbjbk1WzwycTEhV4cix9wrrB4J9/jKWmTbncjl
	 Om5vHv+2kCSow==
Date: Mon, 4 Mar 2024 12:07:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tom Herbert <tom@sipanda.io>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, John Fastabend
 <john.fastabend@gmail.com>, "Singhai, Anjali" <anjali.singhai@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Linux Kernel Network Developers
 <netdev@vger.kernel.org>, "Chatterjee, Deb" <deb.chatterjee@intel.com>,
 "Limaye, Namrata" <namrata.limaye@intel.com>, mleitner@redhat.com,
 Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, "Osinski, Tomasz"
 <tomasz.osinski@intel.com>, Jiri Pirko <jiri@resnulli.us>, Cong Wang
 <xiyou.wangcong@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 edumazet@google.com, Vlad Buslov <vladbu@nvidia.com>, horms@kernel.org,
 khalidm@nvidia.com, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, Victor Nogueira
 <victor@mojatatu.com>, "Tammela, Pedro" <pctammela@mojatatu.com>, "Daly,
 Dan" <dan.daly@intel.com>, andy.fingerhut@gmail.com, "Sommers, Chris"
 <chris.sommers@keysight.com>, mattyk@nvidia.com, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v12 00/15] Introducing P4TC (series 1)
Message-ID: <20240304120747.6f34ab6e@kernel.org>
In-Reply-To: <CAOuuhY_senZbdC2cVU9kfDww_bT+a_VkNaDJYRk4_fMbJW17sQ@mail.gmail.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
	<b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
	<CO1PR11MB49931E501B20F32681F917CD935F2@CO1PR11MB4993.namprd11.prod.outlook.com>
	<65e106305ad8b_43ad820892@john.notmuch>
	<CAM0EoM=r1UDnkp-csPdrz6nBt7o3fHUncXKnO7tB_rcZAcbrDg@mail.gmail.com>
	<CAOuuhY8qbsYCjdUYUZv8J3jz8HGXmtxLmTDP6LKgN5uRVZwMnQ@mail.gmail.com>
	<20240301090020.7c9ebc1d@kernel.org>
	<CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
	<20240301173214.3d95e22b@kernel.org>
	<CAOuuhY8fnpEEBb8z-1mQmvHtfZQwgQnXk3=op-Xk108Pts8ohA@mail.gmail.com>
	<20240302191530.22353670@kernel.org>
	<CAOuuhY_senZbdC2cVU9kfDww_bT+a_VkNaDJYRk4_fMbJW17sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 Mar 2024 08:31:11 -0800 Tom Herbert wrote:
> Even before considering hardware offload, I think this approach
> addresses a more fundamental problem to make the kernel programmable.

I like some aspects of what you're describing, but my understanding
is that it'd be a noticeable shift in direction.
I'm not sure if merging P4TC is the most effective way of taking
a first step in that direction. (I mean that in the literal sense
of lack of confidence, not polite way to indicate holding a conviction
to the contrary.)

