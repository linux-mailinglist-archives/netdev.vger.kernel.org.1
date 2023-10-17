Return-Path: <netdev+bounces-42051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEBF7CCDCA
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 22:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC6D2814F3
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 20:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0343B4310B;
	Tue, 17 Oct 2023 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe3Xj8mm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2528430F9;
	Tue, 17 Oct 2023 20:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FD5C433C7;
	Tue, 17 Oct 2023 20:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697573998;
	bh=7f38VTgPNThxtQB+t4iwNPxsBALtJlMLE4P2e5Y2R1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oe3Xj8mmHHNFmpW9r54h/3Fb4nnfs44+0xDXiU2NXqOQlHtUsNYs3Jtib4hTZjjbR
	 ZjTZIzILkVVv51abb85tPu8BkjNufiTZplpmiXPufrOr2XQbGNOy7hXYfRzRE1a9UE
	 Vse6T4yl601SRxPx5o+eRHgsNsJIUT2PfXqB5ITw1hzof9I/OSTjytUViKNecONtLJ
	 QnSu1H83/gLaQBVOESqhfOsKemzAyTifyB/BnugITnq7NlFtcsXvs26XTbQ/DI/ZLx
	 DZrjcMnKwpmWPWaJ+C5Rutbdy5MRB8TGIvMHv8a+JwIAKJKAGA4YWQId9/NUkaUZKM
	 z12ZrZ6cU/RXw==
Date: Tue, 17 Oct 2023 13:19:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, corbet@lwn.net,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vladimir.oltean@nxp.com, andrew@lunn.ch, horms@kernel.org,
 mkubecek@suse.cz, willemdebruijn.kernel@gmail.com,
 linux-doc@vger.kernel.org, Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH net-next v4 1/6] net: ethtool: allow symmetric-xor RSS
 hash for any flow type
Message-ID: <20231017131957.200bbb7e@kernel.org>
In-Reply-To: <CAKgT0UepNjfPp=TzXyY9Z7rYSGPZyUY64yjB2pqgWTP56=hCcA@mail.gmail.com>
References: <20231016154937.41224-1-ahmed.zaki@intel.com>
	<20231016154937.41224-2-ahmed.zaki@intel.com>
	<8d1b1494cfd733530be887806385cde70e077ed1.camel@gmail.com>
	<26812a57-bdd8-4a39-8dd2-b0ebcfd1073e@intel.com>
	<CAKgT0Ud7JjUiE32jJbMbBGVexrndSCepG54PcGYWHJ+OC9pOtQ@mail.gmail.com>
	<14feb89d-7b4a-40c5-8983-5ef331953224@intel.com>
	<CAKgT0UfcT5cEDRBzCxU9UrQzbBEgFt89vJZjz8Tow=yAfEYERw@mail.gmail.com>
	<20231016163059.23799429@kernel.org>
	<afb4a06f-cfba-47ba-adb3-09bea7cb5f00@intel.com>
	<CAKgT0UdPe_Lb=E+P+zuwyyWVfqBQWLaomwGLwkqnsr0mf40E+g@mail.gmail.com>
	<31cde50b-2603-443c-8f55-a0809ecdd987@intel.com>
	<CAKgT0UepNjfPp=TzXyY9Z7rYSGPZyUY64yjB2pqgWTP56=hCcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 13:03:39 -0700 Alexander Duyck wrote:
> > > My thought would be to possibly just look at reducing your messaging
> > > to a warning from the driver if the inputs are not symmetric, but you
> > > have your symmetric xor hash function enabled.  
> >
> > With the restrictions (to be moved into ice_ethtool), the user is unable
> > to use non-symmetric inputs.  
> 
> I think a warning would make more sense than an outright restriction.
> You could warn on both the enabling if the mask is already unbalanced,
> or you could warn if the mask is set to be unbalanced after enabling
> your hashing.

Either it's a valid configuration or we should error out in the core.
Keep in mind that we can always _loosen_ the restriction, like you
asked for VLAN ID, but we can never _tighten_ it without breaking uAPI.
So error.

