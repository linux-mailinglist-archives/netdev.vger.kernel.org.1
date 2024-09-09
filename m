Return-Path: <netdev+bounces-126624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6752972180
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595081F2336B
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55A917B515;
	Mon,  9 Sep 2024 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xaSxC3dl"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8D3224F6
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725904967; cv=none; b=snPe0TCx9snw3XmUpSnnhTzNeAIDiWaBnwBl9GEbdb8maGY8ofAddrUqVvbr5WHx92aC0OZ+yVNG2ENT3uEZRAG/nVkVdbfB26BSLwtxhVMP6ZJtU6aHC8zBYRGPyYUCH0DWrwc29IWE2Z2lDF/ByxRvXUlpT1X1b0V+sgM9kW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725904967; c=relaxed/simple;
	bh=1k8tFhRQPpn1Fk12JXIXWqlkalGBGe2FZcpDGf/yyhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQdYvn3vq2pSZDvubLGdf1O2ir9Dy4KCABoS6Jwjf3prEGqpwWTAUwLBiu6ovIS5CMph7xpZ71wFch5ub1N/Hx+tbRrc9tqtC0a1r+XSuc7/40WV8FJeMDTIbO0tXeaEHZ7rhjwmIMewJXbWUFDH/Txcm3RZHSfJFKX47sKaIYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xaSxC3dl; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a4c02c5b-af54-456b-b36a-42653991ea34@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725904963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EYbueR0PDXZpaF3ZZ/nt7eKjsvBmORIBNkb8Dq6k9X4=;
	b=xaSxC3dlxLazqcXhE316s390pQ924aUIwwX/bMqoxrsLOk0xSSMNXYs4ck3hLaWwedOjjA
	T9aaqt/n2ZPMcHw+WRtk4L1p6W4XS/vc82FTo46stRx79/pGS9v7AfCjvPbbdSJ02BS7pA
	xQ1FhUN9zbFvCw1ED119okb0c5K0JMk=
Date: Mon, 9 Sep 2024 14:02:37 -0400
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
 <c17ef59b-330f-404d-ab03-0c45447305b0@linux.dev>
 <CANn89iJp6exvUkDSS6yG7_gLGknYGCyOE5vdkL-q5ZpPktWzqA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <CANn89iJp6exvUkDSS6yG7_gLGknYGCyOE5vdkL-q5ZpPktWzqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/9/24 13:14, Eric Dumazet wrote:
> On Mon, Sep 9, 2024 at 7:07 PM Sean Anderson <sean.anderson@linux.dev> wrote:
>>
>> On 9/9/24 12:46, Eric Dumazet wrote:
>> > On Mon, Sep 9, 2024 at 6:06 PM Sean Anderson <sean.anderson@linux.dev> wrote:
>> >>
>> >> When sending packets under 60 bytes, up to three bytes of the buffer following
>> >> the data may be leaked. Avoid this by extending all packets to ETH_ZLEN,
>> >> ensuring nothing is leaked in the padding. This bug can be reproduced by
>> >> running
>> >>
>> >>         $ ping -s 11 destination
>> >>
>> >> Fixes: 9ad1a3749333 ("dpaa_eth: add support for DPAA Ethernet")
>> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> >> ---
>> >>
>> >>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 6 ++++++
>> >>  1 file changed, 6 insertions(+)
>> >>
>> >> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
>> >> index cfe6b57b1da0..e4e8ee8b7356 100644
>> >> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
>> >> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
>> >> @@ -2322,6 +2322,12 @@ dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
>> >>         }
>> >>  #endif
>> >>
>> >> +       /* Packet data is always read as 32-bit words, so zero out any part of
>> >> +        * the skb which might be sent if we have to pad the packet
>> >> +        */
>> >> +       if (__skb_put_padto(skb, ETH_ZLEN, false))
>> >> +               goto enomem;
>> >> +
>> >
>> > This call might linearize the packet.
>> >
>> > @nonlinear variable might be wrong after this point.
>> >
>> >>         if (nonlinear) {
>> >>                 /* Just create a S/G fd based on the skb */
>> >>                 err = skb_to_sg_fd(priv, skb, &fd);
>> >> --
>> >> 2.35.1.1320.gc452695387.dirty
>> >>
>> >
>> > Perhaps this instead ?
>> >
>> > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
>> > b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
>> > index cfe6b57b1da0e45613ac1bbf32ddd6ace329f4fd..5763d2f1bf8dd31b80fda0681361514dad1dc307
>> > 100644
>> > --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
>> > +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
>> > @@ -2272,12 +2272,12 @@ static netdev_tx_t
>> >  dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
>> >  {
>> >         const int queue_mapping = skb_get_queue_mapping(skb);
>> > -       bool nonlinear = skb_is_nonlinear(skb);
>> >         struct rtnl_link_stats64 *percpu_stats;
>> >         struct dpaa_percpu_priv *percpu_priv;
>> >         struct netdev_queue *txq;
>> >         struct dpaa_priv *priv;
>> >         struct qm_fd fd;
>> > +       bool nonlinear;
>> >         int offset = 0;
>> >         int err = 0;
>> >
>> > @@ -2287,6 +2287,10 @@ dpaa_start_xmit(struct sk_buff *skb, struct
>> > net_device *net_dev)
>> >
>> >         qm_fd_clear_fd(&fd);
>> >
>> > +       if (__skb_put_padto(skb, ETH_ZLEN, false))
>> > +               goto enomem;
>> > +
>> > +       nonlinear = skb_is_nonlinear(skb);
>> >         if (!nonlinear) {
>> >                 /* We're going to store the skb backpointer at the beginning
>> >                  * of the data buffer, so we need a privately owned skb
>>
>> Thanks for the suggestion; I was having a hard time figuring out where
>> to call this.
>>
>> Do you have any hints for how to test this for correctness? I'm not sure
>> how to generate a non-linear packet under 60 bytes.
> 
> I think pktgen can do this, with its frags parameter.

OK, I tested both and was able to use

./pktgen/pktgen_sample01_simple.sh -i net5 -m 7e:de:97:38:53:b9 -d 10.0.0.2 -n 3 -s 59

with a call to `pg_set $DEV "frags 2"` added manually.

This results in the following result

OK: 109(c13+d95) usec, 1 (59byte,0frags)

The original patch causes the nonlinear path to be taken (see with the
"tx S/G [TOTAL]" statistic) while your suggestion uses the linear path.
Both work, since there's no problem using the nonlinear path with a
linear skb.

--Sen

