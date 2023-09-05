Return-Path: <netdev+bounces-32110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F97792C42
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 19:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E27280ECE
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 17:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ED6DDAA;
	Tue,  5 Sep 2023 17:15:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84719CA7D
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 17:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2717C433C8;
	Tue,  5 Sep 2023 17:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693934106;
	bh=HvPi9f0SGmumRIHi9LjYtklnVb/H8KTRBiVZ93B0BFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ciOsKoTfkApH8xK7KIOVqyRfXMpq35WChQ57fb9Up4fhMsU3COBjtg9rBPkIgwC5T
	 UHyZp69StEB0aJ7hg8PH4t4BXNl9YJSAI8W/UdKCUcsmeCSCK4ukwUNrohV4SR1vax
	 HeQr4Dom+gobh+glL1TGZwHw4bs7PyZrxuqpxwkgcbp0ppCe5PX+vdBKGk5URVZJcx
	 uJdquvxDf99fuU+me2Arjo9MTOTNX+EbDUU+UoR4ht0lWpcCDQt0BXP3i9YilaGivz
	 WT7ZOGWs6Zf2VAz5Y+ALnjaT6/I3TX92WloptEVfF21PhLoKwPF2cDrack1WzbQ7OJ
	 dVu1fmANy29tQ==
Date: Tue, 5 Sep 2023 10:15:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Neftin, Sasha" <sasha.neftin@intel.com>,
 "horms@kernel.org" <horms@kernel.org>, "bcreeley@amd.com"
 <bcreeley@amd.com>, Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net v3 2/2] igc: Modify the tx-usecs coalesce setting
Message-ID: <20230905101504.4a9da6b8@kernel.org>
In-Reply-To: <SJ1PR11MB6180F2DBE9F6296E35451B3CB8E9A@SJ1PR11MB6180.namprd11.prod.outlook.com>
References: <20230822221620.2988753-1-anthony.l.nguyen@intel.com>
	<20230822221620.2988753-3-anthony.l.nguyen@intel.com>
	<20230823191928.1a32aed7@kernel.org>
	<SJ1PR11MB6180CA2B18577F8D10E8490DB81DA@SJ1PR11MB6180.namprd11.prod.outlook.com>
	<20230824170022.5a055c55@kernel.org>
	<SJ1PR11MB6180835AA3B1C2CC9611B44AB8E3A@SJ1PR11MB6180.namprd11.prod.outlook.com>
	<20230825173429.2a2d0d9f@kernel.org>
	<SJ1PR11MB6180F2DBE9F6296E35451B3CB8E9A@SJ1PR11MB6180.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Sep 2023 00:59:40 +0000 Zulkifli, Muhammad Husaini wrote:
> However, if the user enters the same value for the tx-usecs and a
> different value for the rx-usecs, the command will succeed. . 
> Are you ok with it?

It's unfortunate, but strictly better than the alternative, AFACT.
In the ioctl uAPI we can't differentiate between params which were
echoed back to us vs those user set via CLI to what they already were.

Maybe we should extend the uAPI and add a "queue pair" IRQ moderation?

