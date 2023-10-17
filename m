Return-Path: <netdev+bounces-42050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 922C47CCDBB
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 22:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE78281966
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 20:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17E343105;
	Tue, 17 Oct 2023 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCK4e2ir"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC12430EC;
	Tue, 17 Oct 2023 20:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9D5C433C7;
	Tue, 17 Oct 2023 20:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697573849;
	bh=ZD4QymKAn9GvDpcL1wt4gWYiyp7jJSQIpyOTNO6Ptg4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qCK4e2iroZsLp6ifWINmBnK7M1QTQoXL4y/dppV1GD9iPvhCcSwnLc2RH+T1MeJGN
	 WWkaLvlV/j6dRouTcRtLc2j4n7HtoW++PEtLJq6VYhS1iO5IFMYjr6zQAUNEYhTss/
	 9l/OIeqOnLJmWh59wqGcg47sqBbY3LPVSRzBRhLFcvNMniQ3Lc0yLROEFTOP7HPreJ
	 /peYoR8VxOmXDgS07sj8uwxpKfuRa8LqYx7a7xn2MhRL1XVGRc0hL4tXiNEjb/hfqo
	 k6H1aM6SqXbXxay+3I3AqYeFz08H9o3MWrdTPcOAFxJetiPFknVxQHHk1cf2nx+Ajb
	 2Bu3j6XKwaOXA==
Date: Tue, 17 Oct 2023 13:17:27 -0700
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
Message-ID: <20231017131727.78e96449@kernel.org>
In-Reply-To: <CAKgT0Udyvmxap_F+yFJZiY44sKi+_zOjUjbVYO=TqeW4p0hxrA@mail.gmail.com>
References: <20231016154937.41224-1-ahmed.zaki@intel.com>
	<20231016154937.41224-2-ahmed.zaki@intel.com>
	<8d1b1494cfd733530be887806385cde70e077ed1.camel@gmail.com>
	<26812a57-bdd8-4a39-8dd2-b0ebcfd1073e@intel.com>
	<CAKgT0Ud7JjUiE32jJbMbBGVexrndSCepG54PcGYWHJ+OC9pOtQ@mail.gmail.com>
	<14feb89d-7b4a-40c5-8983-5ef331953224@intel.com>
	<CAKgT0UfcT5cEDRBzCxU9UrQzbBEgFt89vJZjz8Tow=yAfEYERw@mail.gmail.com>
	<20231016163059.23799429@kernel.org>
	<CAKgT0Udyvmxap_F+yFJZiY44sKi+_zOjUjbVYO=TqeW4p0hxrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 11:37:52 -0700 Alexander Duyck wrote:
> > Algo is also a bit confusing, it's more like key pre-processing?
> > There's nothing toeplitz about xoring input fields. Works as well
> > for CRC32.. or XOR.  
> 
> I agree that the change to the algorithm doesn't necessarily have
> anything to do with toeplitz, however it is still a change to the
> algorithm by performing the extra XOR on the inputs prior to
> processing. That is why I figured it might make sense to just add a
> new hfunc value that would mean toeplitz w/ symmetric XOR.

XOR is just one form of achieving symmetric hashing, sorting is another.

> > We can use one of the reserved fields of struct ethtool_rxfh to carry
> > this extension. I think I asked for this at some point, but there's
> > only so much repeated feedback one can send in a day :(  
> 
> Why add an extra reserved field when this is just a variant on a hash
> function? I view it as not being dissimilar to how we handle TSO or
> tx-checksumming. It would make sense to me to just set something like
> toeplitz-symmetric-xor to on in order to turn this on.

It's entirely orthogonal. {sym-XOR, sym-sort} x {toep, crc, xor} -
all combinations can work.

Forget the "is it algo or not algo" question, just purely from data
normalization perspective, in terms of the API, if combinations make
sense they should be controllable independently.

https://en.wikipedia.org/wiki/First_normal_form

