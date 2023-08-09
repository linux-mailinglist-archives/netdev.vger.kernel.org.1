Return-Path: <netdev+bounces-26022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 807EF77676F
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8311C2139C
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 18:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A9124505;
	Wed,  9 Aug 2023 18:37:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E0924503
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 18:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191A5C433C7;
	Wed,  9 Aug 2023 18:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691606254;
	bh=1MHKH+VT4pP3zt6uWdZ73JYnRTASX2BWF0tTKLUP1nQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tNtv4qri17Ilzavg6eK79JpHSCs4yVQaN0POB4npvphxrfHheCZxNaUVAZcx982u8
	 aBTguFR50/2cMS4Hin9uWhHg0LK6poWe+uDpSCHhwdk2/3hbuQ7ZS/9sI22a4zH58s
	 2XVYQjXiZm0GTlwnRPnkke0Tx4pbHKBGkwOiF7SWJitLeZH/ti8bYGzJzA8o35zIFC
	 w1RIxtRA2yp7S+dddvVJk81/2pnt5a29A09jIlb2Q4PRRu6GFoENQbCPcN5LV0+hwZ
	 25DAnNpq9CfGSY8OaMw5X/qPk2WutiikDVNnPWGjp2EdBebJilmViNhU/UqTzeRG5S
	 N5/pu5GRnf+Kw==
Date: Wed, 9 Aug 2023 11:37:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hayes Wang <hayeswang@realtek.com>
Cc: "Limonciello, Mario" <mario.limonciello@amd.com>, "edumazet@google.com"
 <edumazet@google.com>, LKML <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
 <davem@davemloft.net>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Paul
 Menzel" <pmenzel@molgen.mpg.de>
Subject: Re: Error 'netif_napi_add_weight() called with weight 256'
Message-ID: <20230809113732.5806b550@kernel.org>
In-Reply-To: <ba9b777754f7493ba14faa2dab7d8d59@realtek.com>
References: <0bfd445a-81f7-f702-08b0-bd5a72095e49@amd.com>
	<20230731111330.5211e637@kernel.org>
	<673bc252-2b34-6ef9-1765-9c7cac1e8658@amd.com>
	<8fcbab1aa2e14262bea79222bf7a4976@realtek.com>
	<20230807093727.5249f517@kernel.org>
	<ba9b777754f7493ba14faa2dab7d8d59@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Aug 2023 13:11:57 +0000 Hayes Wang wrote:
> I think it depends on the platform.
> Most of the platforms don't have the same situation.
> Besides, I think the platform with 100Gbps device may
> have faster CPU than that one which I test.
> 
> What would happen, if I set the weight to 256 on the platform
> which runs well for the weight of 64?
> Doesn't it only influence the slow platform?

High weight will cause higher latency for other softirq and RT
processing, it's not a good idea. Even with weight/budget of 64
if there's no higher prio work to do the driver will be polled
again immediately if it consumed the budget and has more packets.

Do you have some actual data on how the device performs with budget 
of 64 and 256? And maybe perf traces to show where the difference goes?

