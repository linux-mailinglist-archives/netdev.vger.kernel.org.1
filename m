Return-Path: <netdev+bounces-58071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1AC814F38
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 18:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F42EB2242F
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 17:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6179A82EE3;
	Fri, 15 Dec 2023 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7ij1vE/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4788F4184E
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 17:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB1FC433C7;
	Fri, 15 Dec 2023 17:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702662586;
	bh=d6HjQ90ZtNX1IkZrZUhDnF2CqbAfowKH+HF2mcG8qLc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a7ij1vE/5+BQ0iN2l9sJBQprmghqCzk3Wm42Psu+H/Ewtwji6pGnt5rcg/bmj18Lh
	 3PLh9aIICal1FGN/tAb4ezqhjuQCYuaaDpF/XLcKyzgm7XSbgnddkbQk0M9mm69p4g
	 ENgFgHhwNnfoyo3c3VRZG2VxQ4zd5X7VzpE3CuWWBq7J9gEqfhZfOogjY3SA8nf7J2
	 QoFoLNbrc/XCa5RGCEo6c2sMkmC4mTG7E0PNHq0exK19Ayd/nbfQ6svtP8ANMoxB76
	 6fQ55yPU4inql6GrC3/ue7txV872pRKguBUvBFwg1RQZaqe2dsd9JORMz17VrNFCKA
	 Y/+cO5+5doMHQ==
Message-ID: <58519bfa-260c-4745-a145-fdca89b4e9d1@kernel.org>
Date: Fri, 15 Dec 2023 09:49:45 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net: ipconfig: dev_set_mtu call is incompatible with a number of
 Ethernet drivers
Content-Language: en-US
To: Graeme Smecher <gsmecher@threespeedlogic.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, claudiu.beznea@tuxon.dev,
 nicolas.ferre@microchip.com, mdf@kernel.org
References: <f532722f-d1ea-d8fb-cf56-da55f3d2eb59@threespeedlogic.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <f532722f-d1ea-d8fb-cf56-da55f3d2eb59@threespeedlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/14/23 12:07 PM, Graeme Smecher wrote:
> Hi all,
> 
> In a number of ethernet drivers, the MTU can't be changed on a running
> device. Here's one example (from drivers/net/ethernet/cadence/macb_main.c):
> 

...

> 
> So - what to do? I can see three defensible arguments:
> 
> - The network drivers should allow MTU changes on-the-fly (many do), or
> - The ipconfig code could bring the adapter down and up again, or

looking at the ordering, bringing down the selected device to change the
MTU seems the more reasonable solution.

> - This is out-of-scope, and I should be reconfiguring the interface in
> userspace anyways.
> 


