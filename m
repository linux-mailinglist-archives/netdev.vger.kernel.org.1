Return-Path: <netdev+bounces-55867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5BE80C92C
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4FDC1F216E5
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 12:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356D039862;
	Mon, 11 Dec 2023 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVED9p66"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D5F1F612
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 12:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05243C433C7;
	Mon, 11 Dec 2023 12:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702296858;
	bh=uV0+ph2kWvrsjdsxLRZm7vmxpk47FipXRAv2sxnGka8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NVED9p66ydbmRK9iz6Q7WCigJpP6ShQfBE2O6mcAwXMDH5k1Wd/6EhLFs/1WmnQaK
	 meG43MrZ4hRIGkv+m56HyzG4wPMvjA/o4aZAVxuNU6kozh7iXqGeXvXWRyxGizXgwl
	 dIo8SFj2ODA4P47N9KlbuBSafMneE9Rwczlhnsk55kztYwVm4Oit7fFsENIWXbOQba
	 Q8eLqpBK4P6tFStn4nRUeZIRaa+0iTzwpXd2IY+vMSYH2FuRgvs3txAqy0gr9L4R+/
	 13qiZDQmPBDjPoY9DFgZiLoDOhP8ICnmA7e5EVlSBF3ew/l2bBx8RLMChnnyVHNBv3
	 v7W91W5n3oMNQ==
Message-ID: <4a162951-7f62-499e-98b4-cb0410cd9b1e@kernel.org>
Date: Mon, 11 Dec 2023 14:14:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 6/8] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
 vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
 netdev@vger.kernel.org
References: <20231201135802.28139-1-rogerq@kernel.org>
 <20231201135802.28139-7-rogerq@kernel.org>
 <20231204123531.tpjbt7byzdnrhs7f@skbuf>
 <8caf8252-4068-4d17-b919-12adfef074e5@kernel.org>
 <7d8fb848-a491-414b-adb8-d26a16a499a4@kernel.org>
 <c6ca2492-20a9-47b9-a6ea-3feb6f3cb2d8@kernel.org>
 <20231211121240.ooufyapz6rswyrbn@skbuf>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231211121240.ooufyapz6rswyrbn@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/12/2023 14:12, Vladimir Oltean wrote:
> On Fri, Dec 08, 2023 at 02:33:00PM +0200, Roger Quadros wrote:
>> But,
>>
>> bool __ethtool_dev_mm_supported(struct net_device *dev)
>> {
>> 	const struct ethtool_ops *ops = dev->ethtool_ops;
>> 	struct ethtool_mm_state state = {};
>> 	int ret = -EOPNOTSUPP;
>>
>> 	if (ops && ops->get_mm)
>> 		ret = ops->get_mm(dev, &state);
>>
>> 	return !ret;
>> }
>>
>> So looks like it is better to not define get_mm/set_mm if CONFIG_TI_AM65_CPSW_TAS is disabled.
> 
> Why not? __ethtool_dev_mm_supported() returns true if os->get_mm() is
> implemented and returns 0. You return -EOPNOTSUPP, and that's different
> from 0.

Yes, I realized it eventually. Better to define it and return -EOPNOTSUPP if
CONFIG_TI_AM65_CPSW_TAS is not enabled.

-- 
cheers,
-roger

