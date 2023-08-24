Return-Path: <netdev+bounces-30174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC8778647A
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 03:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334C12813DB
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 01:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4BC15C1;
	Thu, 24 Aug 2023 01:10:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1957F
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 01:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B590C433C7;
	Thu, 24 Aug 2023 01:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692839414;
	bh=ezjID3PxHGUATbcnhrCju3Zulnrv6a9vUszI0YdyQuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pLbShbiAkSkOfESCpTZgmK5Mx1+fsem5sr6qt2cDT3RC+CO64Ib4Pn1JDd2vivEWo
	 WTRm2/H1B/EYz9faHgdgRixoGQVtg5LJ7Dw7Sv7VA/vujv1dRND1fT0fwUNC8rcyio
	 TdAB5/KvA9B78u28gy0bquEBI385CxD9enBCm4D/GURLmJ38ZN37V3vejgYX68pbYI
	 8zvIQp++fPxZAaQ7TADUx1oJxUj4tfvargtQHA43GXqxiONwFcCCrmrcZB+bkGjSqx
	 BSIm9LXf8UoFZTt5mlQsegsmjDP7sBT2Bu1Ari5mDJYjxNueyfIvavdTqfZNup6WbK
	 p/cz/GxwlTwAA==
Date: Wed, 23 Aug 2023 18:10:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc: "vkoul@kernel.org" <vkoul@kernel.org>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
 <krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH net-next v5 10/10] net: axienet: Introduce dmaengine
 support
Message-ID: <20230823181012.0a46d96a@kernel.org>
In-Reply-To: <MN0PR12MB5953AC3094F6BC7190266104B71CA@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
	<1691387509-2113129-11-git-send-email-radhey.shyam.pandey@amd.com>
	<20230808154853.0fafa7fc@kernel.org>
	<MN0PR12MB5953A9FEC556D07494DB8E37B711A@MN0PR12MB5953.namprd12.prod.outlook.com>
	<20230814082953.747791ff@kernel.org>
	<MN0PR12MB5953AC3094F6BC7190266104B71CA@MN0PR12MB5953.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Aug 2023 17:38:58 +0000 Pandey, Radhey Shyam wrote:
> > The kmemcache is not the worst possible option but note that the
> > objects you're allocating (with zeroing) are 512+ bytes. That's
> > pretty large, when most packets will not have full 16 fragments.
> > Ring buffer would allow to better match the allocation size to
> > the packets. Not to mention that it can be done fully locklessly.  
> 
> I modified the implementation to use a circular ring buffer for TX
> and RX. It seems to be working in initial testing and now running 
> perf tests.
> 
> Just had one question on when to submit v6 ? Wait till dmaengine
> patches([01/10-[07/10] is part of net-next? Or can I send it now also.

Assuming Linus cuts final this Sunday - after Sept 10th.

