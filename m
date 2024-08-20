Return-Path: <netdev+bounces-120231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC9D958A01
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7812887C8
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035DB192B66;
	Tue, 20 Aug 2024 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d8/wpa3K"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D0F1922EA
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165006; cv=none; b=CvUBpoabaOPSW6pH9lVITM42stqDrmT099WJLZ/mTj9D9U1naMqKclAvnOE9HW9PDoh3td5Kd38COzBJRKjJcxO09FLtUqQ1oG5MqysYZ6ox1VwHTeYOUh4Cr7g58+phcqbMl9y0em9VyjFRYNDOp7IC9VKgFiJI5vdRJYovKuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165006; c=relaxed/simple;
	bh=gEchAEsDX2Bq++JcIAfskBwNw3myWe0jqkwea0NF+aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QEe9Yto3itVek6Xm1rlhEhlerQ8KvEzZZO8OqEMfHWK90S9ZHiZOn/P3M61gZQBtfUCg7EBGeFskCyb6+8SjzyfSqZMTK9roCwbEMHqq8YCbgYjgI2yJQZdGzh76zj8xDn6Su8E/BD4bWMEue3yJ3dsTEZ6wCloKcNgO8B4jxkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d8/wpa3K; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6342f461-1b9b-4740-b261-384be1843f5a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724164999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6jwRObCNPR0+g8uFj57IS8iZXnm2htkGxsa+HSGdNt8=;
	b=d8/wpa3K2lHgNbAsWUaBeT8Iau2NvKKV/WObRES9unfA/tCEyzHQE1gRNDxkP128sL5NGZ
	pyBZ5r/1EEMs+Xpro2gVsU5Pr636KIlHCFcZlf2pMYo3l6NaCb59FLsf//6q63p2PflZBS
	9DLqv01IyOQaeXMuIbw0Qplf0RBxXTU=
Date: Tue, 20 Aug 2024 10:43:10 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/5] net: xilinx: axienet: Fix dangling
 multicast addresses
To: Jakub Kicinski <kuba@kernel.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <michal.simek@amd.com>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
References: <20240815193614.4120810-1-sean.anderson@linux.dev>
 <20240815193614.4120810-3-sean.anderson@linux.dev>
 <20240819183302.26b7a352@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240819183302.26b7a352@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/19/24 21:33, Jakub Kicinski wrote:
> On Thu, 15 Aug 2024 15:36:11 -0400 Sean Anderson wrote:
>> If a multicast address is removed but there are still some multicast
>> addresses, that address would remain programmed into the frame filter.
>> Fix this by explicitly setting the enable bit for each filter.
>> 
>> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Again, I'd go for net.
> 
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> index 0d5b300107e0..03fef656478e 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> @@ -170,6 +170,7 @@
>>  #define XAE_UAW0_OFFSET		0x00000700 /* Unicast address word 0 */
>>  #define XAE_UAW1_OFFSET		0x00000704 /* Unicast address word 1 */
>>  #define XAE_FMI_OFFSET		0x00000708 /* Filter Mask Index */
>> +#define XAE_FFE_OFFSET		0x0000070C /* Frame Filter Enable */
>>  #define XAE_AF0_OFFSET		0x00000710 /* Address Filter 0 */
>>  #define XAE_AF1_OFFSET		0x00000714 /* Address Filter 1 */
> 
> There is a conflict with current net / net-next here, because of
> 9ff2f816e2aa65ca9, you'll need to rebase / repost (which is why 
> I'm allowing myself the nit picks ;))
> 
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> index e664611c29cf..1bcabb016ca9 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> @@ -433,7 +433,7 @@ static int netdev_set_mac_address(struct net_device *ndev, void *p)
>>   */
>>  static void axienet_set_multicast_list(struct net_device *ndev)
>>  {
>> -	int i;
>> +	int i = 0;
> 
> Consider renaming i to addr_cnt ? or addr_num ?

Well, this doesn't really have anything to do with addresses. It selects
the "Filter Index" (as named by the datasheet) so I'd rename it `filter`
if anything.

This hardware is actually really unusual since the CAM acts on the
entire first 64 bytes of the packet. So you could theoretically filter
for the source address too, but I don't know why you'd want to since all
you can do is drop the packet. Seems like a big waste of resources to
me.

--Sean

