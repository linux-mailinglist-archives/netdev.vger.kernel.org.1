Return-Path: <netdev+bounces-32538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2BE798364
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 09:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CDC2818C8
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 07:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CE8187D;
	Fri,  8 Sep 2023 07:46:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A74186B
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 07:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BE2C433C8;
	Fri,  8 Sep 2023 07:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694159201;
	bh=bBPq4b4Cu5rzDJOGSM5/1ZHCNPwheICHYAzPV5foX68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TG3L/N7eHIgD0XUMgJw/KEvT8gtlQqtwUPfgV6lWgX7TVhfpGTIZJwF/SNC4Dx/J1
	 CC1Xj6G+vWmG4JKhgYfh/E76oofd8wndsCaUv0sgdPjFJnq96QbLCON7qiVz0A/V1R
	 Sv3JfKvK9W+eCJdXZyb8QQte9gRyGzhRGNY9ua74pgN55pVRuaUyG2nbE0vTrFtgTt
	 7al9z/xFtJksqGgKJJIcfbREuzaluCmtU50uW0j6UMwl+ytQiu+kSOY2HKYvXAR7Vr
	 cd5NPE4IFgxz0cTzo0o017bysu6tyz3Q3oK+WzElaROevbbVpafyfGJGyROvXdUgP5
	 4ap836OxebXdQ==
Message-ID: <12c11462-5449-b100-5f92-f66c775237fa@kernel.org>
Date: Fri, 8 Sep 2023 10:46:35 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH net-next 3/4] net: ti: icssg-prueth: Add support for
 ICSSG switch firmware on AM654 PG2.0 EVM
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Richard Cochran <richardcochran@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com,
 Pekka Varis <p-varis@ti.com>
References: <20230830110847.1219515-1-danishanwar@ti.com>
 <20230830110847.1219515-4-danishanwar@ti.com>
 <1fb683f4-d762-427b-98b7-8567ca1f797c@lunn.ch>
 <0d70cebf-8fd0-cf04-ccc2-6f240b27ecca@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <0d70cebf-8fd0-cf04-ccc2-6f240b27ecca@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/09/2023 11:43, MD Danish Anwar wrote:
> On 04/09/23 19:38, Andrew Lunn wrote:
>>> Switch mode requires loading of new firmware into ICSSG cores. This
>>> means interfaces have to taken down and then reconfigured to switch mode
>>> using devlink.
>>
>> Can you always run it in switch mode, just not have the ports in a
>> bridge?
>>
>> 	Andrew
> 
> No, we can't always run it in switch mode. Switch mode requires loading
> of different firmware. The switch firmware only supports switch
> operations. If the ports are not in a bridge in switch mode, the normal
> functionalities will not work. We will not be able to send / receive /
> forward packets in switch mode without bridge.
> 
> When device is booted up, the dual EMAC firmware is loaded and ICSSG
> works in dual EMAC mode with both ports doing independent TX / RX.
> 
> When switch mode is enabled, dual EMAC firmware is unloaded and switch
> firmware is loaded. The ports become part of the bridge and the two port
> together acts as a switch.
> 

Since we are loading the switch firmware and the switch logic is in firmware,
it means we don't really need Linux help to do basic switching on the external
ports.

I suppose Andrews question was, can it work as a switch after switching
from dual-emac to switch mode and not setting up the Linux bridge.

e.g. Looking at your command list

> Switch to ICSSG Switch mode:
>  ip link set dev eth1 down
>  ip link set dev eth2 down
>  devlink dev param set platform/icssg2-eth name \
>  switch_mode value 1 cmode runtime

At this point, can it work as a switch. If not, why?

>  ip link add name br0 type bridge
>  ip link set dev eth1 master br0
>  ip link set dev eth2 master br0
>  ip link set dev br0 up
>  ip link set dev eth1 up
>  ip link set dev eth2 up
>  bridge vlan add dev br0 vid 1 pvid untagged self

-- 
cheers,
-roger

