Return-Path: <netdev+bounces-196567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B32AD557E
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 14:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1306A3A2A98
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 12:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBFF27FD48;
	Wed, 11 Jun 2025 12:26:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9D327E1CA
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 12:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644800; cv=none; b=eUK7M1N6ZM9n5JiCvnXJtYn4AGQpOfVALG0tlEQIzvsZFSqomxSagxHpARtHx4fphgi7mFm9sqzxSzhZAab6F21u7xoPbt5cSSD4c96m2CJ3DZA2NRNzUHqMyYaM03MsHOdw3JbDFEP2zTZPudSw+/tw5FNWFBmxvMAOm/IvrQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644800; c=relaxed/simple;
	bh=LnUumeNEdEHZqFIrLiHzMV5L1txyW+F+LXghYm2oaCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=In97yFxePbPFo8+s7BRQ0PwcIq9pjPr2X4hmCcjGB50Vziz2P1KBDGVzcaBsXbBqLE0IfsX9VQKY92T6ElpAgJqXjSUGRWIiuKATaN2HuFRunIJ+o9NxkdsJy3ucjQ8Uxt9ztEIsg0lhX5d+DpPiBpaJPd/V3DGfFda5qi7QChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uPKXM-0000zY-3u; Wed, 11 Jun 2025 14:26:36 +0200
Message-ID: <73539d7f-75a9-4f52-a95c-b2b1a608fe6d@pengutronix.de>
Date: Wed, 11 Jun 2025 14:26:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bridge: dump mcast querier state per vlan
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com,
 bridge@lists.linux-foundation.org, entwicklung@pengutronix.de,
 razor@blackwall.org
References: <20250611121151.1660231-1-f.pfitzner@pengutronix.de>
 <aEl0eD0qm5xYgvE7@shredder>
Content-Language: en-US, de-DE
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
In-Reply-To: <aEl0eD0qm5xYgvE7@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: f.pfitzner@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On 6/11/25 14:20, Ido Schimmel wrote:
> On Wed, Jun 11, 2025 at 02:11:52PM +0200, Fabian Pfitzner wrote:
>> Dump the multicast querier state per vlan.
>> This commit is almost identical to [1].
>>
>> The querier state can be seen with:
>>
>> bridge -d vlan global
>>
>> The options for vlan filtering and vlan mcast snooping have to be enabled
>> in order to see the output:
>>
>> ip link set [dev] type bridge mcast_vlan_snooping 1 vlan_filtering 1
>>
>> The querier state shows the following information for IPv4 and IPv6
>> respectively:
>>
>> 1) The ip address of the current querier in the network. This could be
>>     ourselves or an external querier.
>> 2) The port on which the querier was seen
>> 3) Querier timeout in seconds
>>
>> [1] https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=16aa4494d7fc6543e5e92beb2ce01648b79f8fa2
>>
>> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
>> ---
>>
>> v1->v2
>> 	- refactor code
>> 	- link to v1: https://lore.kernel.org/netdev/20250604105322.1185872-1-f.pfitzner@pengutronix.de/
> Regarding your note on v1, there is a patch under review to add a bridge
> lib file:
>
> https://lore.kernel.org/netdev/8a4999a27c11934f75086354314269f295ee998a.1749567243.git.petrm@nvidia.com/
>
> Maybe wait until it's accepted and then submit v3 with a shared helper
> function?
Sounds good to me. I'll submit a v3 then.
>
-- 
Pengutronix e.K.                           | Fabian Pfitzner             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |


