Return-Path: <netdev+bounces-14886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 245B6744547
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 01:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A6C1C20B5A
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 23:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0A0AD45;
	Fri, 30 Jun 2023 23:38:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA7AD21
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 23:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23459C433C8;
	Fri, 30 Jun 2023 23:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688168286;
	bh=aDoGh6BHxlBh8t8fWNrlX4oW9QEZMOk3iSMADxRRBXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gjxEOHFtQDjhnWQdK9QdGAprDJKS6adNgQsHCKsmOTrUk0tHMJ0hkwvzDLfzNtYp8
	 icQEI1wly+b79kcGi5TeSAte360WuGtIWKvvG1p8K8UFr6elCYdKgiAttgVntvJGmw
	 I/mf+Ob2ls5a1zagzuBdqNtx3rGOoiyX2vu7bpawkLhJ2rFDhLfBEsH/ex4SBSRy6x
	 waEhg1HGyj/3ZRdvfVQgU54X19N7XHmK/IXWc4Lg3gF/LyRJnSqk92av9VeAZ7GrsG
	 SWosTlvCtf3qucEgi0NbdTaMuke2O3MRoCLbt2dZBc5+dAxd2aess/d8te8pvKpjx+
	 ioP351LYUGItA==
Date: Fri, 30 Jun 2023 16:38:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Paolo Abeni <pabeni@redhat.com>,
 "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Ajay Sharma
 <sharmaajay@microsoft.com>, Dexuan Cui <decui@microsoft.com>, KY Srinivasan
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Message-ID: <20230630163805.79c0bdf5@kernel.org>
In-Reply-To: <PH7PR21MB3263330E6A32D81D52B955FBCE2AA@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
	<36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
	<PH7PR21MB3263B266E381BA15DCE45820CE25A@PH7PR21MB3263.namprd21.prod.outlook.com>
	<e5c3e5e5033290c2228bbad0307334a964eb065e.camel@redhat.com>
	<PH7PR21MB326330931CFDDA96E287E470CE2AA@PH7PR21MB3263.namprd21.prod.outlook.com>
	<2023063001-agenda-spent-83c6@gregkh>
	<PH7PR21MB3263330E6A32D81D52B955FBCE2AA@PH7PR21MB3263.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jun 2023 20:42:28 +0000 Long Li wrote:
> > > 5.15 and kernel 6.1. (those kernels are longterm) They need this fix to achieve
> > > the performance target.
> > 
> > Why can't they be upgraded to get that performance target, and all the other
> > goodness that those kernels have?  We don't normally backport new features,
> > right?  
> 
> I think this should be considered as a fix, not a new feature.
> 
> MANA is designed to be 200GB full duplex at the start.  Due to lack of
> hardware testing capability at early stage of the project, we could only test 100GB
> for the Linux driver. When hardware is fully capable of reaching designed spec,
> this bug in the Linux driver shows up.

That part we understand.

If I were you I'd try to convince Greg and Paolo that the change is
small and significant for user experience. And answer Greg's question
why upgrading the kernel past 6.1 is a challenge in your environment.

