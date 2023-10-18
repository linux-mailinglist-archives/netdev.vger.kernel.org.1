Return-Path: <netdev+bounces-42448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C4A7CEC4D
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D1F1C20E21
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 23:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A4F450ED;
	Wed, 18 Oct 2023 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDyquIIA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C394B4292F;
	Wed, 18 Oct 2023 23:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2588C433C9;
	Wed, 18 Oct 2023 23:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697673022;
	bh=xzyBRSLNILhZ9XPTGbRgeQaBpcpvp+VTRtwqd65Y2ps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jDyquIIAfzo1AcouG0XZnhFod8njD5NjytVJbZ17RUkxx9ihOmWpBENhLa05hU+wq
	 or4nP6z09vCfgxp3rOamqbcitzreRbIsj6u1wt8KGE6yHS4RxP4XA3HmPQkdsSFjL7
	 UCRQB32WmkOAxT9x6tFn7bZhxAexFDg+/CWMIf71JQrhlshzye5VJqqJNIxiYjXNHX
	 Ytc/B+BrzZ6zzFFRPVTXtYRuZJdnoCEPilQ1oxsNtPWAnn1STqTK+9bQPzFyO58hk0
	 sLOVU4PxJ258vj7dG6kHIz3twBBC7Y9zvpPsw/JzsWG3GxnwwLf9risIW2XpTvkm+T
	 /ThvaixH7OLmA==
Date: Wed, 18 Oct 2023 16:50:20 -0700
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
Message-ID: <20231018165020.55cc4a79@kernel.org>
In-Reply-To: <CAKgT0Udz+YdkmtO2Gbhr7CccHtBbTpKich4er3qQXY-b2inUoA@mail.gmail.com>
References: <20231016154937.41224-1-ahmed.zaki@intel.com>
	<20231016154937.41224-2-ahmed.zaki@intel.com>
	<8d1b1494cfd733530be887806385cde70e077ed1.camel@gmail.com>
	<26812a57-bdd8-4a39-8dd2-b0ebcfd1073e@intel.com>
	<CAKgT0Ud7JjUiE32jJbMbBGVexrndSCepG54PcGYWHJ+OC9pOtQ@mail.gmail.com>
	<14feb89d-7b4a-40c5-8983-5ef331953224@intel.com>
	<CAKgT0UfcT5cEDRBzCxU9UrQzbBEgFt89vJZjz8Tow=yAfEYERw@mail.gmail.com>
	<20231016163059.23799429@kernel.org>
	<CAKgT0Udyvmxap_F+yFJZiY44sKi+_zOjUjbVYO=TqeW4p0hxrA@mail.gmail.com>
	<20231017131727.78e96449@kernel.org>
	<CAKgT0Ud4PX1Y6GO9rW+Nvr_y862Cbv3Fpn+YX4wFHEos9rugJA@mail.gmail.com>
	<20231017173448.3f1c35aa@kernel.org>
	<CAKgT0Udz+YdkmtO2Gbhr7CccHtBbTpKich4er3qQXY-b2inUoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 11:12:13 -0700 Alexander Duyck wrote:
> > > Based on earlier comments it doesn't change the inputs, it just
> > > changes how I have to handle the data and the key. It starts reducing
> > > things down to something like the Intel implementation of Flow
> > > Director in terms of how the key gets generated and hashed.  
> >
> > About Flow Director I know only that it is bad :)  
> 
> Yeah, and that is my concern w/ the symmetric XOR is that it isn't
> good. It opens up the toeplitz hash to exploitation. You can target
> the same bucket by just making sure that source IP and port XOR with
> destination IP and port to the same value. That can be done by adding
> the same amount to each side. So there are 2^144 easily predictable
> possible combinations that will end up in the same hash bucket. Seems
> like it might be something that could be exploitable. That is why I
> want it marked out as a separate algo since it is essentially
> destroying entropy before we even get to the Toeplitz portion of the
> hash. As such it isn't a hash I would want to use for anything that is
> meant to spread workload since it is so easily exploitable.

I see your point.

Which is not to say that I know what to do about it. crc or any
future secure algo will get destroyed all the same. It's the input
entropy that gets destroyed, independently of the algo.

We already support xor, and it doesn't come with a warning saying
it's insecure so we kind of assume user knows what they are doing.

I think the API we pick for configuring sym-xor should be the same as
sym-sort. And the "makes algo insecure" argument won't apply to sort.

IMO fat warning in the documentation and ethtool man saying that this
makes the algo (any / all) vulnerable to attack would be enough.
Willem?

