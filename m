Return-Path: <netdev+bounces-58379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0071181619F
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 19:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240A81C21143
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 18:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F56F44C76;
	Sun, 17 Dec 2023 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqUTKNXs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DF52B9B1
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 18:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DBCC433C7;
	Sun, 17 Dec 2023 18:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702838553;
	bh=TJWZy87Yj5BFxYJVosvoT9VQgxlUIjvIwWM0dHN5wi4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EqUTKNXs0rdP06BOSrpPdQl85gXBZL8P7Y08pmSk6g2djO5644aqz+eqRtvir0LG1
	 GRMZiNXwEt5SyAfenvWiNLnMCG6fL31rtibmp8sm3M5I07RJyCnFxpuUP5NrSN9Lfm
	 10DdAKupJpwxb/B2hLiPd+7aJ51acPPUf2kuu3ylEehct1AddQodywbkN6IceHF+Qu
	 tqOIorl2frGglYolz0A3ovWNo31H6Ueo/S/aQlBZS58rnkplcZnWFivvNvsgQEf7z3
	 h3MJVrW0Zfcx/N82+6BMYv3xcrPIsfR+nlYomZGp7oapgz68KKW4BRwA7R8taHj+9f
	 IepbJcw6uayrw==
Message-ID: <b3014260-8a57-40ed-a2b1-301503e392e3@kernel.org>
Date: Sun, 17 Dec 2023 11:42:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net: ipconfig: dev_set_mtu call is incompatible with a number of
 Ethernet drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: Graeme Smecher <gsmecher@threespeedlogic.com>, davem@davemloft.net,
 netdev@vger.kernel.org, claudiu.beznea@tuxon.dev,
 nicolas.ferre@microchip.com, mdf@kernel.org
References: <f532722f-d1ea-d8fb-cf56-da55f3d2eb59@threespeedlogic.com>
 <58519bfa-260c-4745-a145-fdca89b4e9d1@kernel.org>
 <43538a80-2b46-4fe2-9bb7-97d1e0f0c4c7@lunn.ch>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <43538a80-2b46-4fe2-9bb7-97d1e0f0c4c7@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/23 11:22 AM, Andrew Lunn wrote:
> On Fri, Dec 15, 2023 at 09:49:45AM -0800, David Ahern wrote:
>> On 12/14/23 12:07 PM, Graeme Smecher wrote:
>>> Hi all,
>>>
>>> In a number of ethernet drivers, the MTU can't be changed on a running
>>> device. Here's one example (from drivers/net/ethernet/cadence/macb_main.c):
>>>
>>
>> ...
>>
>>>
>>> So - what to do? I can see three defensible arguments:
>>>
>>> - The network drivers should allow MTU changes on-the-fly (many do), or
>>> - The ipconfig code could bring the adapter down and up again, or
>>
>> looking at the ordering, bringing down the selected device to change the
>> MTU seems the more reasonable solution.
> 
> But you need to review all the drivers and make sure there are none
> which require the interface to be up in order to change the MTU.

Is there really such a driver / H/W? Seems like a bug to me that the
device has to be brought up to configure it. Very counter-intuitive.

> 
> So you might actually want to do is first try to change the MTU with
> the interface up. If that fails, try it with it down. That should not
> cause any regressions.
> 

yea, that would be the least invasive.


