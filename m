Return-Path: <netdev+bounces-199942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F950AE2773
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 07:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20143B4826
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 05:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE8F15CD74;
	Sat, 21 Jun 2025 05:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="puKdiV82"
X-Original-To: netdev@vger.kernel.org
Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A142F2E
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 05:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750482284; cv=none; b=J9WIuMzWIF6Vo49Is6KoWnsUtbJF2VgPLlAxMvIz5jDNd6oB2zdk96QYVvR+Y3cfm4ryaigBjH3K93G/C6LKLxbEQ7r3rzIQEs99LPXLRPA8L8S9YCU2p24H0G1ndQB5KqhAja+0hRgMWyYo9pFMBcEUnuCfErA9CyD4oz1aLgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750482284; c=relaxed/simple;
	bh=UrjX0VaVWt68TxIeXRCRPEowTFOZU/MOUb1551OjlOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DwwAnpNZD7UVhYO+Rp/7keaaiG4IcvkFMwGHtA3+czrNRI2SOzdm8G2/os6Gf/EVCrak7SqJtyXZr10xe4/CN5keTdwFuNvOVA6ES8rHaK7Lc/Lp7ZmH1oRjx7a6jEXjvIw4qQAEb4GAQKFTF1nqZApM1V8BXW/Rk1pLOUPAj/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=puKdiV82 reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Received: from [192.168.201.189] (210-129-16-52.radian.jp-east.compute.idcfcloud.net [210.129.16.52])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 55L54cpp089288
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 21 Jun 2025 14:04:39 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=LZdezGJr6XkvkE2YOsN+SrADt9LqOAUKitDf9jiHCdo=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=Message-ID:Date:Subject:To:From;
        s=rs20250326; t=1750482280; v=1;
        b=puKdiV82z9Cb5mXUNaOXjD0cXRv6XKeBU6+CSzC4rXSsxyQ1Y9Wu3TpQGMtdWy3e
         O+Fa1PyqIVWWWBWXvLQhARWrtGanCPLQTNbp1gsKXNzcyf/1IoCIZtKd18LrE19U
         2DFx6LBRhjHVwEwRmMJr7Kgw5sb25W4Ptr6xMy5PL3fE2nQdXxRpENTaBQAHAI4w
         VuJnXh/IF9qZWYEuFF586Z6vzvGqYjuPTVD4ABc00JzKw4UliVmnTWYXzmEq9itq
         c7C/TfqvMUulXjIadClb5AHrT0DuEJuU/DHQTM/QJgg5eAqVEVPH02kK40ce0HA/
         gzYC3D8wd61su/eNNEXe2Q==
Message-ID: <c513ea1d-cdbb-424c-a204-bc0123ce7e8d@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 21 Jun 2025 14:04:32 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 7/8] tun: enable gso over UDP tunnel support.
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Yuri Benditovich <yuri.benditovich@daynix.com>
References: <cover.1750176076.git.pabeni@redhat.com>
 <1c6ffd4bd0480ecc4c8442cef7c689fbfb5e0e56.1750176076.git.pabeni@redhat.com>
 <add3a48e-f16a-4e32-91d4-fc34b1ff3ce6@daynix.com>
 <0aa1055e-3e52-4275-a074-e6f27115a748@redhat.com>
 <f5bb7b71-bae6-49c6-970d-869a59f11a1f@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <f5bb7b71-bae6-49c6-970d-869a59f11a1f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/06/20 5:30, Paolo Abeni wrote:
> On 6/19/25 7:41 PM, Paolo Abeni wrote:
>> On 6/19/25 6:02 PM, Akihiko Odaki wrote:
>>> On 2025/06/18 1:12, Paolo Abeni wrote:
>>>> @@ -2426,7 +2453,17 @@ static int tun_xdp_one(struct tun_struct *tun,
>>>>    	if (metasize > 0)
>>>>    		skb_metadata_set(skb, metasize);
>>>>    
>>>> -	if (tun_vnet_hdr_to_skb(tun->flags, skb, gso)) {
>>>> +	/*
>>>> +	 * Assume tunnel offloads are enabled if the received hdr is large
>>>> +	 * enough.
>>>> +	 */
>>>> +	if (READ_ONCE(tun->vnet_hdr_sz) >= TUN_VNET_TNL_SIZE &&
>>>> +	    xdp->data - xdp->data_hard_start >= TUN_VNET_TNL_SIZE)
>>>> +		features = NETIF_F_GSO_UDP_TUNNEL |
>>>> +			   NETIF_F_GSO_UDP_TUNNEL_CSUM;
>>>
>>> xdp->data - xdp->data_hard_start may not represent the header size.
>>>
>>> struct tun_xdp_hdr is filled in vhost_net_build_xdp() in
>>> drivers/vhost/net.c. This function sets the two fields with
>>> xdp_prepare_buff(), but the arguments passed to xdp_prepare_buff() does
>>> not seem to represent the exact size of the header.
>>
>> Indeed the xdp->data - xdp->data_hard_start range additionally contains
>> some padding and eventually the xdp specific headroom. The problem is
>> that both info are vhost_net specific and tun can't (or at least shoul)
>> not be aware of them.
>>
>> The only IMHO feasible refinement could be using xdp->data_meta instead
>> of xdp->data when available. Alternatively I could drop entirely the test.

struct tun_xdp_hdr can be extended to contain struct 
virtio_net_hdr_v1_hash_tunnel.

> 
> As the vhost_net padding is considerably larger than the largest
> possible vnet_hdr_sz, I'll drop entirely the xdp check - so that I can
> use the newly introduced tun_vnet_hdr_guest_features() helper here, too.

I think dropping the XDP check is the best option (and leaving struct 
tun_xdp_hdr as is) until vhost_net_build_xdp() gains the UDP tunnel support.

Regards,
Akihiko Odaki

