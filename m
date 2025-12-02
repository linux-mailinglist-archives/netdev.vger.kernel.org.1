Return-Path: <netdev+bounces-243185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C418C9B078
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 11:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEF9A4E27C7
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 10:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6BE2F619A;
	Tue,  2 Dec 2025 10:08:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDDD1FD4;
	Tue,  2 Dec 2025 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764670131; cv=none; b=e76qfKOvi5+lJAj6InrrLMFIhKfq/3hFZMPE0gFl1YPswAAxzEi3JB+vUV1PlCidLZgl0dfuHuIcSHBxXDtt9a4UTJPubdOCkkQH+tZvw0zvsDM0U0qWPzD0kOAZiBZBZjUknSTtAKkcnmgodDIdf+CSfjhKe97zdM+rCNhDOq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764670131; c=relaxed/simple;
	bh=cV2z5rwX55Jr18N7BUJSn1oaDI24IULbODEt1jfCpX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VgmVo3E7X86jEBv7WBzNdeH8choIH1F1eD7gd5/Nxy+oEOegLXUqIs8pgh5or1yFErWYKNV4TGQcBPgs85yNeoNGB/bb7z13DNetdXoyzoY7JRjAmARJCA3PxkxW17twhk9R6d/P493oTFP8ERzgnh9CnGV25wukAX0WWTDXhjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dLGfq2Qb2zHnH81;
	Tue,  2 Dec 2025 18:07:47 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 7330740565;
	Tue,  2 Dec 2025 18:08:45 +0800 (CST)
Received: from [10.123.122.223] (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Dec 2025 13:08:44 +0300
Message-ID: <41b025b6-1675-4318-b98c-4d5435a771a7@huawei.com>
Date: Tue, 2 Dec 2025 13:08:44 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/12] ipvlan: Ignore PACKET_LOOPBACK in
 handle_mode_l2()
To: Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Eric Dumazet
	<edumazet@google.com>, Julian Vetter <julian@outer-limits.org>, Guillaume
 Nault <gnault@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
References: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
 <20251120174949.3827500-12-skorodumov.dmitry@huawei.com>
 <ea2db7e6-bc4b-4717-a188-faab3c13ef5c@redhat.com>
Content-Language: en-US
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
In-Reply-To: <ea2db7e6-bc4b-4717-a188-faab3c13ef5c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500004.china.huawei.com (7.188.26.250)


On 25.11.2025 17:30, Paolo Abeni wrote:
> On 11/20/25 6:49 PM, Dmitry Skorodumov wrote:
>> Packets with pkt_type == PACKET_LOOPBACK are captured by
>> handle_frame() function, but they don't have L2 header.
>> We should not process them in handle_mode_l2().
>>
>> This doesn't affect old L2 functionality, since handling
>> was anyway incorrect.
>>
>> Handle them the same way as in br_handle_frame():
>> just pass the skb.
>>
>> To observe invalid behaviour, just start "ping -b" on bcast address
>> of port-interface.
>>
>> Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
> Again, this looks like a fix suitable for 'net'.
>
> Also the condition described above looks easily reproducible, you should
> add a specific self-test.

Hm... I'm not sure how to invent a self-test for this (and tests for ipvlan appears only after this series). It is just an SKB without ETH-header and it just flows through functions in the module - where each of the functions treats data of IP-header as ETH

The issue seems quite obvious - i hope it's ok if I send this patch separately - but without tests so far

Dmitry


