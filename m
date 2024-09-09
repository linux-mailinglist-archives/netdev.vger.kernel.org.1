Return-Path: <netdev+bounces-126606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A3B971FFE
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21801C233A0
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E9B17332B;
	Mon,  9 Sep 2024 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JhKlOU9D"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7FB172BAE
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901621; cv=none; b=kxRKRFaAUb4UmePT+grlpq4GeRc4kmMHq4Es6ZnPmnkaLECJeUW8+8sWQYzpbtT/RcRDqZ4VJCy3QcTHLsJelX1oF68ZqTushrwGlDb5at5xAt9cWrsHfPLIhyaPzEpeF9LQP3K3DAyGZkp3Qf3+v+UxKek+t3ZIflzU3+aeWB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901621; c=relaxed/simple;
	bh=YvuTEo3gCuN+ih3Ot/4XzfbfkK6jZG1cQi1TwckdPJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vga+U9JWk5X2Mpsafh8pU2CCXbaM8cR4RTJBsR9vqA6sz/O/upOE0oPJRpN+QIGqYWsJxJSwjImI8XW0bjt3n363nGuUdN0y6vv4q2kVZ1Lfh65yvi8w5/GGOqltVQ7bft2hyUddkH6jz+wdd61uYbRPu/vSJGZPzNpBGdMQrBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JhKlOU9D; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c17ef59b-330f-404d-ab03-0c45447305b0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725901616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQw1oeHSCvpcH8bA67v30RdZskBj7xtZCGm6aq02Fgc=;
	b=JhKlOU9DZD19VPD/qu8EGPv2Ho3jMI+5pmfMVbkSPwSOBChpu/1XXURKcNUIeCRLxiKRpN
	QYxdfllaQ5Adr3+5GQAL3WOJYECof8CrbHSXuF4T7T2CirOhelz5n5jvUPS7FE4iWnJ0rE
	oB6MR0PzzcFvL4+Z7bFHcY9DWnND1/8=
Date: Mon, 9 Sep 2024 13:06:52 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: dpaa: Pad packets to ETH_ZLEN
To: Eric Dumazet <edumazet@google.com>
Cc: Madalin Bucur <madalin.bucur@nxp.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
References: <20240909160604.1148178-1-sean.anderson@linux.dev>
 <CANn89i+UHJgx5cp6M=6PidC0rdPdr4hnsDaQ=7srijR3ArM1jw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <CANn89i+UHJgx5cp6M=6PidC0rdPdr4hnsDaQ=7srijR3ArM1jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/9/24 12:46, Eric Dumazet wrote:
> On Mon, Sep 9, 2024 at 6:06 PM Sean Anderson <sean.anderson@linux.dev> wrote:
>>
>> When sending packets under 60 bytes, up to three bytes of the buffer following
>> the data may be leaked. Avoid this by extending all packets to ETH_ZLEN,
>> ensuring nothing is leaked in the padding. This bug can be reproduced by
>> running
>>
>>         $ ping -s 11 destination
>>
>> Fixes: 9ad1a3749333 ("dpaa_eth: add support for DPAA Ethernet")
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>>
>>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
>> index cfe6b57b1da0..e4e8ee8b7356 100644
>> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
>> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
>> @@ -2322,6 +2322,12 @@ dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
>>         }
>>  #endif
>>
>> +       /* Packet data is always read as 32-bit words, so zero out any part of
>> +        * the skb which might be sent if we have to pad the packet
>> +        */
>> +       if (__skb_put_padto(skb, ETH_ZLEN, false))
>> +               goto enomem;
>> +
> 
> This call might linearize the packet.
> 
> @nonlinear variable might be wrong after this point.
> 
>>         if (nonlinear) {
>>                 /* Just create a S/G fd based on the skb */
>>                 err = skb_to_sg_fd(priv, skb, &fd);
>> --
>> 2.35.1.1320.gc452695387.dirty
>>
> 
> Perhaps this instead ?
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> index cfe6b57b1da0e45613ac1bbf32ddd6ace329f4fd..5763d2f1bf8dd31b80fda0681361514dad1dc307
> 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> @@ -2272,12 +2272,12 @@ static netdev_tx_t
>  dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
>  {
>         const int queue_mapping = skb_get_queue_mapping(skb);
> -       bool nonlinear = skb_is_nonlinear(skb);
>         struct rtnl_link_stats64 *percpu_stats;
>         struct dpaa_percpu_priv *percpu_priv;
>         struct netdev_queue *txq;
>         struct dpaa_priv *priv;
>         struct qm_fd fd;
> +       bool nonlinear;
>         int offset = 0;
>         int err = 0;
> 
> @@ -2287,6 +2287,10 @@ dpaa_start_xmit(struct sk_buff *skb, struct
> net_device *net_dev)
> 
>         qm_fd_clear_fd(&fd);
> 
> +       if (__skb_put_padto(skb, ETH_ZLEN, false))
> +               goto enomem;
> +
> +       nonlinear = skb_is_nonlinear(skb);
>         if (!nonlinear) {
>                 /* We're going to store the skb backpointer at the beginning
>                  * of the data buffer, so we need a privately owned skb

Thanks for the suggestion; I was having a hard time figuring out where
to call this.

Do you have any hints for how to test this for correctness? I'm not sure
how to generate a non-linear packet under 60 bytes.

--Sean

