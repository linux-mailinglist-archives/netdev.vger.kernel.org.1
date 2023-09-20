Return-Path: <netdev+bounces-35141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6535D7A73D9
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 09:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215BD281A48
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 07:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95DE8484;
	Wed, 20 Sep 2023 07:20:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9329747B
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 07:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8814C433C8;
	Wed, 20 Sep 2023 07:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695194435;
	bh=H9wVKjvGVPXXyFE5kDB/IAFjYiewUvn32o8qyJzBTF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fcvEFv9seiEaFxmdc9Dzr6HbMB0HFveSkjQztghfL8LG56IX4FfV7nIutdTAjFjpD
	 Sy2TPMuvHBZf1hcqgndCq2RbRolD+tlnnFyPG/LWe2fPd5rV/6INK794pM6O7pjJG5
	 RegCcH9Ytk7MHCoy0dPamWTmbfOvJOQshQkBMeSqSD1uMXSdvLnxf32E/0ZADpewD5
	 /nepXRsalCOinA0DuJxO6mRK7wkqoFFENfyDxScmLfRFhr6Gs/u945MasSyNmz4fvV
	 HsgPwjdUBZ/+Sp7N+tZHFuOzNjbWXfgCeldyxiRXPy2+yVZ4EsnHi9d4TqTrnotQBX
	 fh5C1Qr16a38Q==
Message-ID: <5a4eb30b-6842-0512-56d5-23cb52c1f4ee@kernel.org>
Date: Wed, 20 Sep 2023 10:20:30 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption
 MAC Merge support
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, vladimir.oltean@nxp.com
Cc: horms@kernel.org, s-vadapalli@ti.com, srk@ti.com, vigneshr@ti.com,
 p-varis@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230918095346.91592-1-rogerq@kernel.org>
 <ad0a961c523aa50f25380b339e1cb6f50109a5fe.camel@redhat.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <ad0a961c523aa50f25380b339e1cb6f50109a5fe.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 19/09/2023 16:13, Paolo Abeni wrote:
> On Mon, 2023-09-18 at 12:53 +0300, Roger Quadros wrote:
>> Add driver support for viewing / changing the MAC Merge sublayer
>> parameters and seeing the verification state machine's current state
>> via ethtool.
>>
>> As hardware does not support interrupt notification for verification
>> events we resort to polling on link up. On link up we try a couple of
>> times for verification success and if unsuccessful then give up.
>>
>> The Frame Preemption feature is described in the Technical Reference
>> Manual [1] in section:
>> 	12.3.1.4.6.7 Intersperced Express Traffic (IET – P802.3br/D2.0)
>>
>> Due to Silicon Errata i2208 [2] we set limit min IET fragment size to 124.
>>
>> [1] AM62x TRM - https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
>> [2] AM62x Silicon Errata - https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 150 ++++++++++++
>>  drivers/net/ethernet/ti/am65-cpsw-nuss.c    |   2 +
>>  drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   5 +
>>  drivers/net/ethernet/ti/am65-cpsw-qos.c     | 240 ++++++++++++++++----
>>  drivers/net/ethernet/ti/am65-cpsw-qos.h     | 104 +++++++++
>>  5 files changed, 454 insertions(+), 47 deletions(-)
>>
>> Changelog:
>>
>> v3:
>> - Rebase on top of v6.6-rc1 and mqprio support [1]
> 
> I'm unsure if this will require a rebase for the next revision of the
> mqprio support. Anyhow the two patches are related, it's probably
> better bundle them in a series so that the dep is straight-forward.

Good idea.

> 
> When reposting, please insert the target tree in the subject profix
> (net-next in this case).

My bad. I will add. Thanks.

-- 
cheers,
-roger

