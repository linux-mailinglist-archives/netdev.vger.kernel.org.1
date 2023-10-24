Return-Path: <netdev+bounces-43978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E497D5B5F
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 21:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255D01C20B03
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 19:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A15F3CD02;
	Tue, 24 Oct 2023 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgoyoUPE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2108208AB
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 19:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAE6C433C7;
	Tue, 24 Oct 2023 19:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698175176;
	bh=2WsBoJTSg/WDud1IvCege7SjdpuuE00s7XiYRZqSqZw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LgoyoUPEAxUKaw0r/ruSGFkhNw6om2fdfMbOSucq9Hb2mxOyPvFGqDc6ksrADEDmc
	 7bOB007hnVHIq5HB6EdCATE/e/DrNHyZ0S3V0MJxf61oKrJSjUY9BTnneIpP6IZS8f
	 20KZ+7RATNo2IfF5xbcPaf+EqLpA3NIRVpR1pVgQoNZlbi3lXCiFPPRG8wGsvLObcA
	 nI8WXv5gWTRz1v9mlbsaQSFFoVstFGfXIF1GAaUqIidFhsOwEYaRkElu7odU05MpUV
	 74gqvVOuGeuxEgX4BvE6fD8P2mv0+yFy1tzsDs3rnLhP/I5lvQIH0GHc+6Mxh38pX0
	 DdRXf1vvGwj1Q==
Message-ID: <dcfbecd9-5539-495f-a046-2d89a34252ca@kernel.org>
Date: Tue, 24 Oct 2023 13:19:35 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/15] net: page_pool: record pools per netdev
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org
References: <20231024160220.3973311-1-kuba@kernel.org>
 <20231024160220.3973311-6-kuba@kernel.org>
 <cb0d160b-42bf-40c9-ac36-246010d04975@kernel.org>
 <20231024104910.71ced925@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231024104910.71ced925@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/23 11:49 AM, Jakub Kicinski wrote:
> On Tue, 24 Oct 2023 11:31:46 -0600 David Ahern wrote:
>> On 10/24/23 10:02 AM, Jakub Kicinski wrote:
>>> Link the page pools with netdevs. This needs to be netns compatible
>>> so we have two options. Either we record the pools per netns and
>>> have to worry about moving them as the netdev gets moved.
>>> Or we record them directly on the netdev so they move with the netdev
>>> without any extra work.
>>>
>>> Implement the latter option. Since pools may outlast netdev we need
>>> a place to store orphans. In time honored tradition use loopback
>>> for this purpose.
>>
>> blackhole_netdev might be a better choice than loopback
> 
> With loopback we still keep it per netns, and still accessible 
> via netlink.

and if the namespace and loopback device get deleted?

